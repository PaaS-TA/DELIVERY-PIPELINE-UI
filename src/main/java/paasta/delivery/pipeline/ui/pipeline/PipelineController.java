package paasta.delivery.pipeline.ui.pipeline;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.auth.AuthorityService;
import paasta.delivery.pipeline.ui.auth.GrantedAuthority;
import paasta.delivery.pipeline.ui.auth.GrantedAuthorityService;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.ListRequest;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUse;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUseList;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUseService;
import paasta.delivery.pipeline.ui.user.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by hrjin on 2017-05-18.
 */
@Controller
@RequestMapping(value = "/dashboard/{suid}")
public class PipelineController {

    private static final Logger LOGGER = LoggerFactory.getLogger(PipelineController.class);

    private static final String BASE_URL = "/pipeline";
    private final CommonService commonService;
    private final PipelineService pipelineService;
    private final InstanceUseService instanceUseService;
    private final AuthorityService authorityService;
    private final GrantedAuthorityService grantedAuthorityService;

    @Autowired
    public PipelineController(CommonService commonService, PipelineService pipelineService, InstanceUseService instanceUseService, AuthorityService authorityService, GrantedAuthorityService grantedAuthorityService) {
        this.commonService = commonService;
        this.pipelineService = pipelineService;
        this.instanceUseService = instanceUseService;
        this.authorityService = authorityService;
        this.grantedAuthorityService = grantedAuthorityService;
    }


    /**
     * Redirect pipeline dashboard model and view.
     *
     * @param serviceInstancesId the service instances id
     * @return the model and view
     */
    @GetMapping
    public ModelAndView redirectlogin(@PathVariable("suid") String serviceInstancesId, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
        commonService.updateSession();
        return new ModelAndView("redirect:/dashboard/" + serviceInstancesId + "/pipeline/dashboard");

    }


    /**
     * Gets pipeline list page
     *
     * @param httpServletRequest the http servlet request
     * @param name               search by pipelineName
     * @return the pipeline list page
     */
    @RequestMapping(value = {BASE_URL + "/dashboard"}, method = RequestMethod.GET)
    public ModelAndView getPipelineListPage(HttpServletRequest httpServletRequest, @RequestParam(value = "name", required = false) String name) {
        ListRequest listRequest = new ListRequest();
        listRequest.setName(name);
        ModelAndView mv = new ModelAndView();
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/pipelineList", mv);
    }


    /**
     * Gets pipeline detail page
     *
     * @param httpServletRequest the http servlet request
     * @return the pipeline detail page
     */
    @RequestMapping(value = {BASE_URL + "/{pipelineId}/detail"}, method = RequestMethod.GET)
    public ModelAndView getPipelineDetailPage(HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("authorityList", commonService.getUserInfo().getGrantedAuthorities());
        mv.setViewName(BASE_URL + "/pipelineDetail");

        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/pipelineDetail", mv);
    }


    /**
     * Gets pipeline detail_contributor list page
     *
     * @param httpServletRequest the http servlet request
     * @param name               search by userName
     * @return the contributor list page
     */
    @RequestMapping(value = {BASE_URL + "/{pipelineId}/contributor"}, method = RequestMethod.GET)
    public ModelAndView getPipelineDetailContributorPage(HttpServletRequest httpServletRequest, @RequestParam(value = "id", required = false) String name) {
        ListRequest listRequest = new ListRequest();
        listRequest.setName(name);

        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/pipelineDetailContributorTabList", new ModelAndView());
    }


    /**
     * Gets pipeline detail_contributor create page
     *
     * @param httpServletRequest the http servlet request
     * @return the contributor create page
     */
    @RequestMapping(value = {BASE_URL + "/{pipelineId}/contributor/create"}, method = RequestMethod.GET)
    public ModelAndView getPipelineDetailContributorCreatePage(HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("authList", authorityService.getAuthorityList());
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/pipelineDetailContributorTabCreate", mv);
    }


    /**
     * Gets pipeline detail_contributor update page
     *
     * @param httpServletRequest the http servlet request
     * @param suid               the service instances id
     * @param pipelineId         the pipeline id
     * @param id                 the user id
     * @return the detail_contributor update page
     */
    @RequestMapping(value = {BASE_URL + "/{pipelineId}/contributor/update/{id}"}, method = RequestMethod.GET)
    public ModelAndView getPipelineDetailContributorUpdatePage(HttpServletRequest httpServletRequest, @PathVariable String suid, @PathVariable String pipelineId, @PathVariable String id) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("authList", authorityService.getAuthorityList());
        mv.addObject("pipelineId", pipelineId);
        mv.setViewName(BASE_URL + "/userDetail");
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/pipelineDetailContributorTabUpdate", mv);
    }


    /**
     * Gets pipeline create page
     *
     * @param httpServletRequest the http servlet request
     * @return the pipeline create page
     */
    @RequestMapping(value = {BASE_URL + "/create"}, method = RequestMethod.GET)
    public ModelAndView getPipelineCreatePage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/pipelineCreate", new ModelAndView());
    }


    /**
     * Gets pipeline update page
     *
     * @param httpServletRequest the http servlet request
     * @return the pipeline update page
     */
    @RequestMapping(value = {BASE_URL + "/update/{id}"}, method = RequestMethod.GET)
    public ModelAndView getPipelineUpdatePage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/pipelineUpdate", new ModelAndView());
    }


    /**
     * Gets pipeline list
     *
     * @param httpServletRequest the http servlet request
     * @param suid               the service instances id
     * @return the pipeline list
     */
    @RequestMapping(value = {BASE_URL + "/pipelineList.do"}, method = RequestMethod.GET)
    @ResponseBody
    public PipelineList getPipelineList(HttpServletRequest httpServletRequest, @PathVariable String suid) {
        return pipelineService.getPipelineList(suid, commonService.setParameters(httpServletRequest));
    }


    /**
     * Sets pipeline detail
     *
     * @param pipeline the pipeline
     * @return the pipeline
     */
    @RequestMapping(value = {BASE_URL + "/pipelineDetail.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Pipeline getPipeline(@RequestBody Pipeline pipeline) {
        return pipelineService.getPipeline(pipeline.getId());
    }


    /**
     * Sets create pipeline
     *
     * @param pipeline the pipeline
     * @return the create pipeline
     */
    @RequestMapping(value = {BASE_URL + "/pipelineCreate.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Pipeline setCreatePipeline(@RequestBody Pipeline pipeline) {
        return pipelineService.setCreatePipeline(pipeline);
    }


    /**
     * Sets update pipeline
     *
     * @param pipeline the pipeline
     * @return the update pipeline
     */
    @RequestMapping(value = {BASE_URL + "/pipelineUpdate.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Pipeline setUpdatePipeline(@RequestBody Pipeline pipeline) {
        return pipelineService.setUpdatePipeline(pipeline.getId(), pipeline);
    }


    /**
     * Sets delete pipeline
     *
     * @param pipeline the pipeline
     * @return the delete pipeline
     */
    @RequestMapping(value = {BASE_URL + "/pipelineDelete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Pipeline setDeletePipeline(@RequestBody Pipeline pipeline) {
        return pipelineService.setDeletePipeline(pipeline.getId());
    }


    /**
     * Gets contributor list
     *
     * @param httpServletRequest the http servlet request
     * @param suid               the service instances id
     * @param pipelineId         the pipeline id
     * @return the contributor list
     */
    @RequestMapping(value = {BASE_URL + "/{pipelineId}/contributorList.do"}, method = RequestMethod.GET)
    @ResponseBody
    public InstanceUseList getContributorList(HttpServletRequest httpServletRequest, @PathVariable String suid, @PathVariable Long pipelineId) {
        InstanceUseList list = instanceUseService.getInstanceUseListByPipelineContributor(suid, pipelineId, commonService.setParameters(httpServletRequest));
        return list;
    }


    /**
     * Sets contributor detail
     *
     * @param user the user
     * @param suid the service instances id
     * @return the contributor detail
     */
    @RequestMapping(value = {BASE_URL + "/contributorDetail.do"}, method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse getContributorDetail(@RequestBody User user, @PathVariable String suid) {
        InstanceUse instanceUse = instanceUseService.getInstanceUse(suid, user.getId());
        return instanceUse;
    }


    /**
     * Sets create contributor's authority
     *
     * @param reqGrantedAuthority the grantedAuthority
     * @param suid                the service instances id
     * @return the create contributor's authority
     */
    @RequestMapping(value = {BASE_URL + "/contributorGrantedAuthority.do"}, method = RequestMethod.POST)
    @ResponseBody
    public GrantedAuthority createContributorGrantedAuthority(@RequestBody GrantedAuthority reqGrantedAuthority, @PathVariable String suid) {
        GrantedAuthority newGrantedAuthority = new GrantedAuthority();
        newGrantedAuthority.setInstanceUseId(reqGrantedAuthority.getInstanceUseId());
        newGrantedAuthority.setAuthorityId(reqGrantedAuthority.getAuthorityId());
        newGrantedAuthority.setAuthCode(reqGrantedAuthority.getPipelineId());

        if (reqGrantedAuthority.getDescription() != null) {
            InstanceUse instanceUse = instanceUseService.getInstanceUse(suid, reqGrantedAuthority.getUserId());
            instanceUse.getUser().setDescription(reqGrantedAuthority.getDescription());

            instanceUseService.setUpdateInstanceUse2(suid, reqGrantedAuthority.getUserId(), instanceUse);
        }
        return grantedAuthorityService.contributorGrantedAuthority(newGrantedAuthority);
    }


    /**
     * Sets update contributor's authority
     *
     * @param reqGrantedAuthority the grantedAuthority
     * @param suid                the service instances id
     * @return the update contributor's authority
     */
    @RequestMapping(value = {BASE_URL + "/contributorGrantedAuthorityUpdate.do"}, method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse setContributorUpdate(@RequestBody GrantedAuthority reqGrantedAuthority, @PathVariable String suid) {
        InstanceUse instanceUse = instanceUseService.getInstanceUse(suid, reqGrantedAuthority.getUserId());
        instanceUse.setPipelineId(reqGrantedAuthority.getPipelineId());
        instanceUse.setAuthListStr(reqGrantedAuthority.getAuthorityId());

        InstanceUse updateInstanceUse = instanceUseService.setUpdateInstanceUse2(suid, reqGrantedAuthority.getUserId(), instanceUse);

        return updateInstanceUse;
    }


    /**
     * Sets delete contributor's authority
     *
     * @param reqGrantedAuthority the grantedAuthority
     * @param suid                the service instances id
     * @return the delete contributor's authority
     */
    @RequestMapping(value = {BASE_URL + "/contributorGrantedAuthorityDelete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse deleteContributor(@RequestBody GrantedAuthority reqGrantedAuthority, @PathVariable String suid) {
        // 1. instanceUse -> 53 번(hrjin) user 에 해당하는 값들이 나옴.
        InstanceUse instanceUse = instanceUseService.getInstanceUse(suid, reqGrantedAuthority.getUserId());

        // 2. instanceUse 의 grantedAuthority 중에 authCode 가 넘어온 pipelineId 값이랑 같을 경우 해당 grantedAuthorities 의 행을 지운다.
        for (int i = 0; i < instanceUse.getGrantedAuthorities().size(); i++) {
            if (instanceUse.getGrantedAuthorities().get(i).getAuthCode() != null && instanceUse.getGrantedAuthorities().get(i).getAuthCode().intValue() == reqGrantedAuthority.getPipelineId().intValue()) {
                String resultMessage = grantedAuthorityService.deleteContributor(instanceUse.getGrantedAuthorities().get(i).getId());
                LOGGER.info(resultMessage);
            }
        }
        return instanceUseService.getInstanceUse(suid, reqGrantedAuthority.getUserId());
    }


    /**
     * Gets authority
     *
     * @return the authority
     */
    @RequestMapping(value = "/grantedAuthorities", method = RequestMethod.GET)
    @ResponseBody
    public List<GrantedAuthority> getGrantedAuthorities() {
        List<GrantedAuthority> grantedAuthorities = commonService.getUserInfo().getGrantedAuthorities();
        return grantedAuthorities;
    }
}
