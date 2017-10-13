package paasta.delivery.pipeline.ui.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationDetailsSource;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * {@link org.springframework.security.authentication.AuthenticationDetailsSource} providing extra details about the current
 * user and his grant to manage the current service instance.
 *
 * @author Sebastien Gerard
 */
public class DashboardAuthenticationDetailsSource
        implements AuthenticationDetailsSource<HttpServletRequest, OAuth2AuthenticationDetails> {

    /**
     * Token to use in {@link #getCheckUrl(String serviceInstanceId)} to specify the service instance id.
     */
    public static final String TOKEN_SUID = "[SUID]";

    /**
     * Key used in the JSON map returned by the call to {@link #getCheckUrl(String serviceInstanceId)} and associated
     * to the service instance id.
     */
    public static final String MANAGED_KEY = "manage";

    private static final Logger logger = LoggerFactory.getLogger(DashboardAuthenticationDetailsSource.class);

    private final RestTemplate restTemplate;
    private final String userInfoUrl;
    private final String apiUrl;

    /**
     * Returns the full name (first + last name) contains in the specified map.
     */
    protected static String getUserFullName(Map<String, String> map) {
        if (map.containsKey("name")) {
            return map.get("name");
        }
        if (map.containsKey("formattedName")) {
            return map.get("formattedName");
        }
        if (map.containsKey("fullName")) {
            return map.get("fullName");
        }
        String firstName = null;
        if (map.containsKey("firstName")) {
            firstName = map.get("firstName");
        }
        if (map.containsKey("givenName")) {
            firstName = map.get("givenName");
        }
        String lastName = null;
        if (map.containsKey("lastName")) {
            lastName = map.get("lastName");
        }
        if (map.containsKey("familyName")) {
            lastName = map.get("familyName");
        }
        if (firstName != null) {
            if (lastName != null) {
                return firstName + " " + lastName;
            }
        }
        return null;
    }

    /**
     * @param restTemplate the template to use to contact Cloud components
     * @param userInfoUrl the URL used to get the current OAuth user details
     * @param apiUrl the URL used to get the service instance permission
     */
    public DashboardAuthenticationDetailsSource(RestTemplate restTemplate,
                                                String userInfoUrl, String apiUrl) {
        logger.info("###### DashboardAuthenticationDetailsSource");
        this.restTemplate = restTemplate;
        this.userInfoUrl = userInfoUrl;
        this.apiUrl = apiUrl;
    }

    @Override
    public DashboardAuthenticationDetails buildDetails(HttpServletRequest request) {
        logger.info("###### buildDetails");
//        String serviceInstanceId = "";
        String serviceInstanceId = request.getServletPath().split("/")[2];

        Map<String, String> uaaUserInfo = null;
        try {
            uaaUserInfo = restTemplate.getForObject(userInfoUrl, Map.class);
        } catch (RestClientException e) {
            logger.error("Error while user full name from [" + userInfoUrl + "].", e);
        }

        String id = uaaUserInfo.get("user_id");
        String userid = uaaUserInfo.get("user_name");
        boolean managingService = isManagingApp(serviceInstanceId);
        DashboardAuthenticationDetails authenticationDetails = new DashboardAuthenticationDetails(request, managingService, id, userid, getUserFullName(uaaUserInfo), this.restTemplate);
        authenticationDetails.setManagingServiceInstance(serviceInstanceId);
        authenticationDetails.setAccessToken(((OAuth2RestTemplate) restTemplate).getAccessToken());

        return authenticationDetails;
    }

    /**
     * Checks whether the user is allowed to manage the current service instance.
     */
    private boolean isManagingApp(String serviceInstanceId) {
        logger.info("###### isManagingApp");
        final String url = getCheckUrl(serviceInstanceId);
        try {
            final Map<?, ?> result = restTemplate.getForObject(url, Map.class);

            return Boolean.TRUE.toString().equals(result.get(MANAGED_KEY).toString().toLowerCase());
        } catch (RestClientException e) {
            logger.error("Error while retrieving authorization from [" + url + "].", e);
            return false;
        }
    }

    /**
     * Returns the full name of the current user (first + last name).
     */
    @SuppressWarnings("unchecked")
//    private String getUserFullName() {
//        try {
//            return getUserFullName(restTemplate.getForObject(userInfoUrl, Map.class));
//        } catch (RestClientException e) {
//            logger.error("Error while user full name from [" + userInfoUrl + "].", e);
//            return "";
//        }
//    }

    /**
     * Returns the URL used to check whether the current user is allowed
     * to access the current service instance.
     */
    private String getCheckUrl(String serviceInstanceId) {
        return apiUrl.replace(TOKEN_SUID, serviceInstanceId);
    }

    private RestTemplate getRestTemplate() {
        return this.restTemplate;
    }
}
