package paasta.delivery.pipeline.ui.security;

import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.web.client.RestTemplate;
import paasta.delivery.pipeline.ui.auth.Authority;
import paasta.delivery.pipeline.ui.auth.GrantedAuthority;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Extension of {@link OAuth2AuthenticationDetails} providing extra details about the current
 * user and his grant to manage the current service instance.
 *
 * @author Sebastien Gerard
 */
@SuppressWarnings("serial")
public class DashboardAuthenticationDetails extends OAuth2AuthenticationDetails {

    private String managingServiceInstance;
    private String instanceId;
    private final boolean managingService;
    private final String id;
    private final String userid;
    private final String userFullName;
    private String role;
    private String roleId;
    private String roleDisplayName;
    private List<GrantedAuthority> grantedAuthorities;
    private final RestTemplate restTemplate;
    private OAuth2AccessToken accessToken;


    /**
     * Records the access token value and remote address and will also set the session Id if a session already exists
     * (it won't create one).
     * @param request that the authentication request was received from
     * @param managingService
     * @param id
     * @param userFullName the full user name (first name + last name)
     * @param restTemplate 사용자의 권한이 포함되어 있는 RestTemplate
     */
    public DashboardAuthenticationDetails(HttpServletRequest request, boolean managingService, String id, String user_id,String userFullName, RestTemplate restTemplate) {
        super(request);
        this.managingService = managingService;
        this.id = id;
        this.userid = user_id;
        this.userFullName = userFullName;
        this.restTemplate = restTemplate;
    }

    /**
     * Returns the current full user name (first name + last name).
     */
    public String getUserFullName() {
        return userFullName;
    }

    /**
     * 관리 권한이 있는 serviceInstanceId를 입력한다.
     * @param serviceInstanceId
     */
    public void setManagingServiceInstance(String serviceInstanceId) {
        this.managingServiceInstance = serviceInstanceId;
    }
    public String getManagingServiceInstance() {
        return managingServiceInstance;
    }


    /**
     * Returns the flag indicating whether the current user is allowed to manage
     * the current service instance.
     */
    public boolean isManagingService() {
        return managingService;
    }

    /**
     * 입력 받은 Service Instance Id가 일치하는지 여부를 체크한다.
     * @param serviceInstanceId
     * @return
     */
    public boolean isManagedServiceInstance(String serviceInstanceId) {
        return serviceInstanceId.equals(this.managingServiceInstance);
    }

    public String getId() {
        return id;
    }

    public String getUserid() {
        return userid;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRoleDisplayName() {
        return roleDisplayName;
    }

    public void setRoleDisplayName(String roleDisplayName) {
        this.roleDisplayName = roleDisplayName;
    }

    public List<GrantedAuthority> getGrantedAuthorities() {
        return grantedAuthorities;
    }

    public void setGrantedAuthorities(List<GrantedAuthority> grantedAuthorities) {
        this.grantedAuthorities = grantedAuthorities;
    }

    public RestTemplate getRestTemplate() {
        return restTemplate;
    }

    public OAuth2AccessToken getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(OAuth2AccessToken accessToken) {
        this.accessToken = accessToken;
    }
}
