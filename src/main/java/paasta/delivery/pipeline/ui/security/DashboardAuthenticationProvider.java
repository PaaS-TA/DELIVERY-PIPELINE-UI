package paasta.delivery.pipeline.ui.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import paasta.delivery.pipeline.ui.auth.AuthorityService;
import paasta.delivery.pipeline.ui.auth.GrantedAuthority;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUse;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUseService;
import paasta.delivery.pipeline.ui.serviceInstance.ServiceInstances;
import paasta.delivery.pipeline.ui.serviceInstance.ServiceInstancesService;
import paasta.delivery.pipeline.ui.user.User;
import paasta.delivery.pipeline.ui.user.UserService;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * {@link org.springframework.security.authentication.AuthenticationProvider} used to make the link between an OAuth user
 * and an internal User.
 *
 * @author Sebastien Gerard
 */
public class DashboardAuthenticationProvider implements AuthenticationProvider {


    private static final Logger LOGGER = LoggerFactory.getLogger(DashboardAuthenticationProvider.class);

    private final UserService userService;
    private final InstanceUseService instanceUseService;
    private final AuthorityService authorityService;
    private final ServiceInstancesService serviceInstancesService;
    private final RestTemplateService restTemplateService;
    private final CommonService commonService;

    private static final String REQ_URL = "/pipeline";

    public DashboardAuthenticationProvider(UserService userService, InstanceUseService instanceUseService, ServiceInstancesService serviceInstancesService, AuthorityService authorityService, RestTemplateService restTemplateService, CommonService commonService) {
        this.userService = userService;
        this.instanceUseService = instanceUseService;
        this.serviceInstancesService = serviceInstancesService;
        this.authorityService = authorityService;
        this.restTemplateService = restTemplateService;
        this.commonService = commonService;
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        final String name = authentication.getName();
        final Object details = authentication.getDetails();


        if (!(details instanceof DashboardAuthenticationDetails)) {
            throw new InternalAuthenticationServiceException("The authentication details [" + details
                    + "] are not an instance of " + DashboardAuthenticationDetails.class.getSimpleName());
        }

        DashboardAuthenticationDetails dashboardAuthenticationDetails = (DashboardAuthenticationDetails) details;


        LOGGER.info("###############################################################");
        LOGGER.info("SESSION INFOMATION SETTING [" + name + "]" + " [" + ((DashboardAuthenticationDetails) details).getUserid() + "]" + " [" + authentication.getPrincipal() + "] ");
        LOGGER.info("###############################################################");

        try {

            //권한들에 대한 정보 추출
            List<Map> pipeauthorities = authorityService.getAuthorityListMap();

            String adminRoleId = "";
            String adminRoleDisplayName = "";
            String userRoleId = "";
            String userRoleDisplayName = "";


            for (int i = 0; i < pipeauthorities.size(); i++) {
                if (pipeauthorities.get(i).get("code") != null) {
                    String code = pipeauthorities.get(i).get("code").toString();
                    if (code.equalsIgnoreCase("dashboard.manager")) {
                        adminRoleId = pipeauthorities.get(i).get("id").toString();
                        adminRoleDisplayName = pipeauthorities.get(i).get("displayName").toString();
                    } else if (code.equalsIgnoreCase("dashboard.user")) {
                        userRoleId = pipeauthorities.get(i).get("id").toString();
                        userRoleDisplayName = pipeauthorities.get(i).get("displayName").toString();
                    }
                }
            }


            ServiceInstances serviceInstances = serviceInstancesService.getServiceInstances(dashboardAuthenticationDetails.getManagingServiceInstance());
            List<GrantedAuthority> role = new ArrayList();
            List authorities = new ArrayList();

            // TODO 외부 인증으로 로그인한 사용자에 대한 정보가 내부에 있는지 확인하고 없으면 사용자 정보를 추가한다.
            final User userInfo = userService.getUser(dashboardAuthenticationDetails.getId());
            if (userInfo == null) {
                // TODO 사용자 정보가 없으면 기본적인 정보를 입력한다.
                final User newUser = new User();
                newUser.setId(dashboardAuthenticationDetails.getId());
                newUser.setName(authentication.getName());
                newUser.setEmail("");
                newUser.setCompany("");
                userService.setCreateUser(newUser);

            }

            String roleId = "";
            String roleDisplayName = "";
            String roleString = "";
            //인스턴스 주인장이지 확인한다.
            if (serviceInstances.getOwner().equalsIgnoreCase(dashboardAuthenticationDetails.getUserid())) {
                roleId = adminRoleId;
                roleDisplayName = adminRoleDisplayName;
                roleString = "ROLE_ADMIN";
            } else {
                roleId = userRoleId;
                roleDisplayName = userRoleDisplayName;
                roleString = "ROLE_USER";
            }


            InstanceUse instanceUse = instanceUseService.getInstanceUse(dashboardAuthenticationDetails.getManagingServiceInstance(), dashboardAuthenticationDetails.getId());
            if (instanceUse == null && dashboardAuthenticationDetails.isManagingService()) {
                LOGGER.debug("인스터스 생성 및 롤 권한 설정");
                InstanceUse newInstanceUse = new InstanceUse();
                newInstanceUse.setServiceInstancesId(dashboardAuthenticationDetails.getManagingServiceInstance());
                newInstanceUse.setUserId(dashboardAuthenticationDetails.getId());
                //인스턴스를 생성하면서
                instanceUse = instanceUseService.createInstanceUse(newInstanceUse);
                //권한을 부여한다.
                List<GrantedAuthority> userAuthorities = createGrantedAuthority(roleId, roleDisplayName, instanceUse.getId());

                authorities.add(new SimpleGrantedAuthority(roleString));
                dashboardAuthenticationDetails = commonService.setDetails(dashboardAuthenticationDetails, roleString, roleId, roleDisplayName);
                dashboardAuthenticationDetails.setGrantedAuthorities(userAuthorities);
            } else {
                if (instanceUse != null) {
                    if (instanceUse.getGrantedAuthorities() != null) {
                        for (GrantedAuthority grantedAuthority : instanceUse.getGrantedAuthorities()) {
                            role.add(grantedAuthority);
                        }
                    }
                }

                //권한이 있으면...ID값으로 권한을 검색해서...사용자?? 관리자?? 권한 부여...
                if (role.size() > 0) {
                    dashboardAuthenticationDetails.setGrantedAuthorities(role);
                    for (int i = 0; i < role.size(); i++) {
                        if (role.get(i).getAuthority().getId() != null) {
                            if (role.get(i).getAuthority().getId().equalsIgnoreCase(adminRoleId)) {
                                dashboardAuthenticationDetails = commonService.setDetails(dashboardAuthenticationDetails, "ROLE_ADMIN", adminRoleId, adminRoleDisplayName);
                            } else if (role.get(i).getAuthority().getId().equalsIgnoreCase(userRoleId)) {
                                dashboardAuthenticationDetails = commonService.setDetails(dashboardAuthenticationDetails, "ROLE_USER", userRoleId, userRoleDisplayName);
                            }
                        }
                    }
                } else {
                    //인스턴스는 있는데 권한이 없으면, 권한을 생성하고, 디테일을 생성한다.
                    List<GrantedAuthority> grantedAuthorities = createGrantedAuthority(roleId, roleDisplayName, instanceUse.getId());
                    dashboardAuthenticationDetails = commonService.setDetails(dashboardAuthenticationDetails, roleString, roleId, roleDisplayName);
                    dashboardAuthenticationDetails.setGrantedAuthorities(grantedAuthorities);

                }
            }



            //이렇게 까지 했는데...없으면...에러 출력
            if (dashboardAuthenticationDetails.getRoleId() == null) {
                throw new AccessDeniedException("Permission Error on [" + name + "]");
            }

            if(!dashboardAuthenticationDetails.isManagingService()){
                SecurityContextHolder.clearContext();
                throw new AccessDeniedException("Permission Error on [" + name + "]");
            }

            //이상없으면 세션에 저장
            authentication = new OAuth2Authentication(((OAuth2Authentication) authentication).getOAuth2Request(), new UsernamePasswordAuthenticationToken(authentication.getPrincipal(), "N/A", authorities));
            ((OAuth2Authentication) authentication).setDetails(dashboardAuthenticationDetails);

        } catch (Exception e) {
            e.printStackTrace();
            // 세션 초기화
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpServletRequest request = attributes.getRequest();
            request.getSession().invalidate();
            SecurityContextHolder.clearContext();

            throw new InternalAuthenticationServiceException("Permission Error on [" + name + "]", e);
        }

        return authentication;
    }


    @Override
    public boolean supports(Class<?> authentication) {
        return OAuth2Authentication.class.isAssignableFrom(authentication);
    }


    private List<GrantedAuthority> createGrantedAuthority(String roleId, String displayName, long instanceUseId) {
        GrantedAuthority grantedAuthority = new GrantedAuthority();
        grantedAuthority.setAuthorityId(roleId);
        grantedAuthority.setInstanceUseId(instanceUseId);
        grantedAuthority.setAuthCode(null);
        restTemplateService.send(Constants.TARGET_COMMON_API, "/authorize", HttpMethod.POST, grantedAuthority, GrantedAuthority.class);
        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        grantedAuthorities.add(grantedAuthority);
        return grantedAuthorities;

    }
}

