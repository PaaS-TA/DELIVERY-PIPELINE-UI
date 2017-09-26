package paasta.delivery.pipeline.ui.user;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.auth.Authority;
import paasta.delivery.pipeline.ui.auth.AuthorityService;
import paasta.delivery.pipeline.ui.auth.GrantedAuthority;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.ListRequest;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUse;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUseList;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUseService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.user
 *
 * @author REX
 * @version 1.0
 * @since 5/17/2017
 */
@Controller
@RequestMapping(value = "/dashboard/{serviceInstancesId}")
public class UserController {

    private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

    private static final String BASE_URL = "/user";
    private final UserService userService;
    private final CommonService commonService;
    private final InstanceUseService instanceUseService;
    private final AuthorityService authorityService;

    @Autowired
    public UserController(UserService userService, CommonService commonService, InstanceUseService instanceUseService, AuthorityService authorityService) {
        this.userService = userService;
        this.commonService = commonService;
        this.instanceUseService = instanceUseService;
        this.authorityService = authorityService;
    }


    /**
     * User 목록 검색 및 페이징 조회 ::: move
     *
     * @param httpServletRequest
     * @param name
     * @return
     */
    @RequestMapping(value = {BASE_URL + "/dashboard"}, method = RequestMethod.GET)
    public ModelAndView getUserListPage(HttpServletRequest httpServletRequest,
                                        @RequestParam(value = "id", required = false) String name,
                                        @RequestParam(value = "authName", required = false) String authName) {

        ListRequest listRequest = new ListRequest();
        listRequest.setName(name);
        listRequest.setAuthName(authName);

        ModelAndView mv = new ModelAndView();
        mv.addObject("authList", authorityService.getAuthorityList());

        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/userList", mv);
    }

    /**
     * User 생성 ::: move
     *
     * @return
     */
    @RequestMapping(value = {BASE_URL + "/create"}, method = RequestMethod.POST)
    public ModelAndView getUserCreatePage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/userCreate", new ModelAndView());
    }


    /**
     * User 상세 조회 ::: move
     *
     * @param
     * @return
     */
    @RequestMapping(value = {BASE_URL + "/detail/{id}"}, method = RequestMethod.GET)
    public ModelAndView getUserDetailPage(@PathVariable String serviceInstancesId, @PathVariable String id) {

        ModelAndView mv = new ModelAndView();
        mv.addObject("list", instanceUseService.getInstanceUse(serviceInstancesId, id));
        mv.addObject("authList", authorityService.getAuthorityList());
        mv.setViewName(BASE_URL + "/userDetail");
        return mv;
    }



    /*
    * User 목록 검색 및 페이징 조회 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/list.do"}, method = RequestMethod.GET)
    @ResponseBody
    public InstanceUseList getUserList(HttpServletRequest httpServletRequest,
                                       @PathVariable String serviceInstancesId) {

        InstanceUseList list = instanceUseService.getInstanceUseList(serviceInstancesId, commonService.setParameters(httpServletRequest));
        return list;
    }

    /*
    * User 목록만 조회 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/userList.do"}, method = RequestMethod.GET)
    @ResponseBody
    public UserList getOnlyUserList(HttpServletRequest httpServletRequest, @RequestParam("id") String name) {

        ListRequest listRequest = new ListRequest();
        listRequest.setName(name);

        UserList list = userService.getUserList(commonService.setParameters(httpServletRequest));
        return list;
    }


    /*
    *  User 상세 조회 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/get.do"}, method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse getUser(@RequestBody User user, @PathVariable String serviceInstancesId) {
        InstanceUse instanceUse = instanceUseService.getInstanceUse(serviceInstancesId, user.getId());
        List<GrantedAuthority> grantedAuthorityList = instanceUse.getGrantedAuthorities();
        if (grantedAuthorityList == null) {
            GrantedAuthority grantedAuthority = new GrantedAuthority();
            grantedAuthority.setAuthorityId(commonService.getUserInfo().getRoleId());
            grantedAuthorityList.add(grantedAuthority);
            instanceUse.setGrantedAuthorities(grantedAuthorityList);
        } else {
            String adminRoleId = "";
            String userRoleId = "";
            List<Map> pipeauthorities = authorityService.getAuthorityListMap();
            for (int i = 0; i < pipeauthorities.size(); i++) {
                if (pipeauthorities.get(i).get("code") != null) {
                    String code = pipeauthorities.get(i).get("code").toString();
                    if (code.equalsIgnoreCase("dashboard.manager")) {
                        adminRoleId = pipeauthorities.get(i).get("id").toString();

                    } else if (code.equalsIgnoreCase("dashboard.user")) {
                        userRoleId = pipeauthorities.get(i).get("id").toString();
                    }
                }
            }
            int cnt = 0;
            for (GrantedAuthority grantedAuthority : grantedAuthorityList) {
                if (grantedAuthority.getAuthority().getId() != null) {
                    if (grantedAuthority.getAuthority().getId().equalsIgnoreCase(adminRoleId) || grantedAuthority.getAuthority().getId().equalsIgnoreCase(userRoleId)) {
                        cnt++;
                    }
                }
            }
            if (cnt == 0) {
                GrantedAuthority grantedAuthority = new GrantedAuthority();
                Authority authority = new Authority();
                authority.setId(commonService.getUserInfo().getRoleId());
                grantedAuthority.setAuthority(authority);
                grantedAuthorityList.add(grantedAuthority);
                instanceUse.setGrantedAuthorities(grantedAuthorityList);
            }
        }
        return instanceUse;
    }


    /*
    *  User 생성 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/create.do"}, method = RequestMethod.POST)
    @ResponseBody
    public User setCreateUser(@RequestBody User user) {
        return userService.setCreateUser(user);
    }


    /*
    * User 삭제 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/delete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public User setDeleteUser(@RequestBody User user) {
        return userService.setDeleteUser(user.getId());
    }


    /*
    *  User 수정 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/update.do"}, method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse setUpdateUser(@PathVariable String serviceInstancesId, @RequestBody InstanceUse instanceUse) {
        InstanceUse updateInstanceUse = instanceUseService.setUpdateInstanceUse2(serviceInstancesId, instanceUse.getUserId(), instanceUse);
        return updateInstanceUse;
    }
}
