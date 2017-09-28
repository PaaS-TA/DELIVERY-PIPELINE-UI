package paasta.delivery.pipeline.ui.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.oauth2.client.DefaultOAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2ClientContext;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.filter.OAuth2ClientContextFilter;
import org.springframework.security.oauth2.client.token.AccessTokenRequest;
import org.springframework.security.oauth2.client.token.DefaultAccessTokenRequest;
import org.springframework.security.oauth2.client.token.grant.code.AuthorizationCodeResourceDetails;
import org.springframework.security.oauth2.provider.token.*;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.context.WebApplicationContext;
import paasta.delivery.pipeline.ui.auth.AuthorityService;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.security.*;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUseService;
import paasta.delivery.pipeline.ui.serviceInstance.ServiceInstancesService;
import paasta.delivery.pipeline.ui.user.UserService;

import javax.servlet.http.HttpServletRequest;

import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import static java.util.Arrays.asList;
import static paasta.delivery.pipeline.ui.config.security.FilterWrapper.wrap;

/**
 * {@link Configuration} related to the dashboard security.
 *
 * @author Sebastien Gerard
 */
@Configuration
public class DashboardSecurityConfiguration {

    /**
     * Returns the SPeL expression checking that the current user is authorized
     * to manage this service.
     */
    public static String isManagingApp() {
        return "(authentication.details != null) " +
                "and (authentication.details instanceof T(" + DashboardAuthenticationDetails.class.getName() + ")) "
                + "and authentication.details.managingService ";
    }

    @Value("${cf.uaa.oauth.client.id}")
    private String clientId;

    @Value("${cf.uaa.oauth.client.secret}")
    private String clientSecret;

    @Value("${cf.uaa.oauth.info.uri}")
    private String oauthInfoUrl;

    @Value("${cf.api.url}")
    private String apiUrl;

    @Value("${cf.uaa.oauth.token.check.uri}")
    private String checkTokenUri;

    @Value("${cf.uaa.oauth.authorization.uri}")
    private String authorizationUri;

    @Value("${cf.uaa.oauth.token.access.uri}")
    private String accessUri;

    @Value("${cf.uaa.oauth.logout.url}")
    private String logoutUrl;

    @Autowired
    @Qualifier("authenticationManager")
    private AuthenticationManager authenticationManager;

    @Autowired
    private HttpServletRequest httpServletRequest;

    @Bean(name = "dashboardEntryPointMatcher")
    public RequestMatcher dashboardEntryPointMatcher() {
        return new AntPathRequestMatcher("/dashboard/**/**/**");
    }

    @Bean(name = "dashboardClientContextFilter")
    public FilterWrapper dashboardClientContextFilter() {
        // If it was a Filter bean it would be automatically added out of the Spring security filter chain.
        return wrap(new OAuth2ClientContextFilter());
    }

    @Bean(name = "dashboardSocialClientFilter")
    @Autowired
    public FilterWrapper dashboardSocialClientFilter(CommonService commonService) {
        // If it was a Filter bean it would be automatically added out of the Spring security filter chain.
        final DashboardAuthenticationProcessingFilter filter
              = new DashboardAuthenticationProcessingFilter();

        filter.setRestTemplate(dashboardRestOperations());
        filter.setTokenServices(dashboardResourceServerTokenServices());
        filter.setAuthenticationManager(authenticationManager);
        filter.setRequiresAuthenticationRequestMatcher(dashboardEntryPointMatcher());
        filter.setDetailsSource(dashboardAuthenticationDetailsSource());
        filter.setAuthenticationSuccessHandler(new DashboardAuthenticationSuccessHandler());
        filter.setCommonService(commonService);

        return wrap(filter);
    }

    @Bean(name = "dashboardProtectedResourceDetails")
    @Scope(value = WebApplicationContext.SCOPE_SESSION)
    @Autowired
    public AuthorizationCodeResourceDetails dashboardProtectedResourceDetails() {
        final AuthorizationCodeResourceDetails resourceDetails = new AuthorizationCodeResourceDetails() {
            @Override
            public boolean isClientOnly() {
                return true;
            }
        };

        resourceDetails.setClientId(clientId);
        resourceDetails.setClientSecret(clientSecret);
        resourceDetails.setUserAuthorizationUri(authorizationUri);
        resourceDetails.setAccessTokenUri(accessUri);
        resourceDetails.setUseCurrentUri(true);
        resourceDetails.setScope(asList("openid", "cloud_controller_service_permissions.read"));

        return resourceDetails;
    }

    @Bean(name = "dashboardClientContext")
    @Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public OAuth2ClientContext dashboardClientContext() {
        return new DefaultOAuth2ClientContext(dashboardAccessTokenRequest());
    }

    @Bean(name = "dashboardAccessTokenRequest")
    @Scope(value = WebApplicationContext.SCOPE_REQUEST, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public AccessTokenRequest dashboardAccessTokenRequest() {
        final DefaultAccessTokenRequest request = new DefaultAccessTokenRequest(httpServletRequest.getParameterMap());

        final Object currentUri = httpServletRequest.getAttribute(OAuth2ClientContextFilter.CURRENT_URI);
        if (currentUri != null) {
            request.setCurrentUri(currentUri.toString());
        }

        return request;
    }

    @Bean(name = "dashboardRestOperations")
    @Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public OAuth2RestTemplate dashboardRestOperations() {

        try {
            SSLUtils.turnOffSslChecking();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }


        return new OAuth2RestTemplate(dashboardProtectedResourceDetails(), dashboardClientContext());
    }

    @Bean(name = "dashboardAccessTokenConverter")
    public AccessTokenConverter dashboardAccessTokenConverter() {
        final DefaultAccessTokenConverter defaultAccessTokenConverter = new DefaultAccessTokenConverter();
        final DefaultUserAuthenticationConverter userTokenConverter = new DefaultUserAuthenticationConverter();

        userTokenConverter.setDefaultAuthorities(new String[]{"ROLE_" + ApplicationWebSecurityConfigurerAdapter.ROLE_DASHBOARD});
        defaultAccessTokenConverter.setUserTokenConverter(userTokenConverter);

        return defaultAccessTokenConverter;
    }

    @Bean(name = "dashboardResourceServerTokenServices")
    @Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
    @Autowired
    public ResourceServerTokenServices dashboardResourceServerTokenServices() {
        final RemoteTokenServices remoteTokenServices = new RemoteTokenServices();

        remoteTokenServices.setClientId(clientId);
        remoteTokenServices.setClientSecret(clientSecret);
        remoteTokenServices.setCheckTokenEndpointUrl(checkTokenUri);
        remoteTokenServices.setAccessTokenConverter(dashboardAccessTokenConverter());

        return remoteTokenServices;
    }

    @Bean(name = "dashboardAuthenticationDetailsSource")
    @Autowired
    public org.springframework.security.authentication.AuthenticationDetailsSource dashboardAuthenticationDetailsSource() {
        return new DashboardAuthenticationDetailsSource(dashboardRestOperations(), oauthInfoUrl, apiUrl);
    }

    @Bean(name = "dashboardAuthenticationProvider")
    @Autowired
    public DashboardAuthenticationProvider dashboardAuthenticationProvider(UserService userService, InstanceUseService instanceUseService
            , ServiceInstancesService servceInstancesService, AuthorityService authorityService, RestTemplateService restTemplateService, CommonService commonService) {
        return new DashboardAuthenticationProvider(userService, instanceUseService , servceInstancesService, authorityService,restTemplateService,commonService);
    }

    @Bean(name = "dashboardLogoutSuccessHandler")
    public LogoutSuccessHandler dashboardLogoutSuccessHandler() {
        final SimpleUrlLogoutSuccessHandler logoutSuccessHandler = new SimpleUrlLogoutSuccessHandler();

        logoutSuccessHandler.setRedirectStrategy(new DashboardLogoutRedirectStrategy(logoutUrl));

        return logoutSuccessHandler;
    }

    @Bean(name = "dashboardLogoutUrlMatcher")
    public RequestMatcher dashboardLogoutUrlMatcher() {
        return new AntPathRequestMatcher("/dashboard/logout");
    }
}
