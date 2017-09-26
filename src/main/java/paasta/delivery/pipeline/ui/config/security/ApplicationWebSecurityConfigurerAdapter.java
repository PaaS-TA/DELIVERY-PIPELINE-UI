package paasta.delivery.pipeline.ui.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
//import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.preauth.AbstractPreAuthenticatedProcessingFilter;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.web.context.request.RequestContextListener;

import static paasta.delivery.pipeline.ui.config.security.DashboardSecurityConfiguration.isManagingApp;


/**
 * {@link WebSecurityConfigurerAdapter} securing the web application.
 *
 * @author Sebastien Gerard
 */
@Configuration
@Order(1)
//@EnableWebMvcSecurity
@EnableWebSecurity
public class ApplicationWebSecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {

    /**
     * Role that users accessing the dashboard endpoint must have.
     */
    public static final String ROLE_DASHBOARD = "DASHBOARD";

    /**
     * Role that users accessing a web-service endpoint must have.
     */
//    public static final String ROLE_WEB_SERVICE = "WEB_SERVICE";

    @Autowired
    @Bean(name = "authenticationManager")
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManager();
    }

    @Bean
    @ConditionalOnMissingBean(RequestContextListener.class)
    public RequestContextListener requestContextListener() {
        return new RequestContextListener();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
                .antMatcher("/webjars/**")
                .antMatcher("/css/**")
                .antMatcher("/js/**")
                .antMatcher("/common/error/**")
                .authorizeRequests()
                .anyRequest()
                .permitAll()
                .and().csrf().disable();

    }


    /**
     * {@link WebSecurityConfigurerAdapter} securing the dashboard.
     */
    @Configuration
    @Order(2)
    public static class DashboardWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
        @Autowired
        @Qualifier("dashboardEntryPointMatcher")
        private RequestMatcher dashboardEntryPointMatcher;

        @Autowired
        @Qualifier("dashboardClientContextFilter")
        private FilterWrapper dashboardClientContextFilter;

        @Autowired
        @Qualifier("dashboardSocialClientFilter")
        private FilterWrapper dashboardSocialClientFilter;

        @Autowired
        @Qualifier("dashboardLogoutSuccessHandler")
        private LogoutSuccessHandler dashboardLogoutSuccessHandler;

        @Autowired
        @Qualifier("dashboardLogoutUrlMatcher")
        private RequestMatcher dashboardLogoutUrlMatcher;

        @Autowired
        @Qualifier("dashboardAuthenticationProvider")
        private AuthenticationProvider dashboardAuthenticationProvider;

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http
                    .requestMatcher(dashboardEntryPointMatcher)
                    .authorizeRequests()
                    .anyRequest().access(isManagingApp())
                    .and()
                    .addFilterBefore(dashboardClientContextFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)
                    .addFilterBefore(dashboardSocialClientFilter.unwrap(), AbstractPreAuthenticatedProcessingFilter.class)

                    .logout()
                        .logoutSuccessHandler(dashboardLogoutSuccessHandler)
                        .logoutRequestMatcher(dashboardLogoutUrlMatcher)
                    .and()
                    .exceptionHandling().accessDeniedPage("/common/error/forbidden");

        }


        @Override
        protected void configure(AuthenticationManagerBuilder auth) throws Exception {
            auth.authenticationProvider(dashboardAuthenticationProvider);
        }

    }


}
