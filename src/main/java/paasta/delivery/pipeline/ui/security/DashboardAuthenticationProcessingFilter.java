package paasta.delivery.pipeline.ui.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.filter.OAuth2ClientAuthenticationProcessingFilter;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import paasta.delivery.pipeline.ui.common.CommonService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Extension of {@link OAuth2ClientAuthenticationProcessingFilter} that uses the
 * {@link org.springframework.security.authentication.AuthenticationManager}.
 * This implementation also starts authentication if there is no authentication and
 * if the current request requires authentication.
 *
 * @author Sebastien Gerard
 */
public class DashboardAuthenticationProcessingFilter extends OAuth2ClientAuthenticationProcessingFilter {

    private static final Logger LOGGER = LoggerFactory.getLogger(DashboardAuthenticationProcessingFilter.class);

    private AuthenticationDetailsSource<HttpServletRequest, ?> detailsSource;

    private CommonService commonService;

    public DashboardAuthenticationProcessingFilter() {
        super("/");
    }

    @Override
    protected boolean requiresAuthentication(HttpServletRequest request, HttpServletResponse response) {
        logger.info("###### requiresAuthentication");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return ((authentication == null) || !(((DashboardAuthenticationDetails) authentication.getDetails()).isManagedServiceInstance(request.getServletPath().split("/")[2])))
                && super.requiresAuthentication(request, response);
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException, IOException, ServletException {
        logger.info("###### requiresAuthentication");
        final Authentication authentication = super.attemptAuthentication(request, response);

        if (detailsSource != null) {
            request.getSession().invalidate();
            ((OAuth2Authentication) authentication).setDetails(detailsSource.buildDetails(request));
        }

        return getAuthenticationManager().authenticate(authentication);
    }

    /**
     * Sets the optional source providing {@link Authentication#getDetails() authentication details}.
     */
    public void setDetailsSource(AuthenticationDetailsSource<HttpServletRequest, ?> detailsSource) {
        this.detailsSource = detailsSource;
    }

    public void setCommonService(CommonService commonService) {
        this.commonService = commonService;
    }
}
