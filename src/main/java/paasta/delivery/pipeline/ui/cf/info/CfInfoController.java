package paasta.delivery.pipeline.ui.cf.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.common.CommonService;

import javax.servlet.http.HttpServletRequest;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cfInfo
 *
 * @author REX
 * @version 1.0
 * @since 7 /25/2017
 */
@Controller
@RequestMapping(value = "/dashboard/{serviceInstancesId}/cf-info")
public class CfInfoController {

    private static final String VIEW_BASE_URL = "/cfInfo";
    private final CommonService commonService;
    private final CfInfoService cfInfoService;


    /**
     * Instantiates a new Cf info controller.
     *
     * @param commonService the common service
     * @param cfInfoService the cf info service
     */
    @Autowired
    public CfInfoController(CommonService commonService, CfInfoService cfInfoService) {
        this.commonService = commonService;
        this.cfInfoService = cfInfoService;
    }


    /**
     * Gets cf info list page.
     *
     * @param httpServletRequest the http servlet request
     * @return the cf info list page
     */
    @GetMapping
    public ModelAndView getCfInfoListPage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/cfInfoList", new ModelAndView());
    }


    /**
     * Gets cf info create page.
     *
     * @param httpServletRequest the http servlet request
     * @return the cf info create page
     */
    @GetMapping(value = {"/create"})
    public ModelAndView getCfInfoCreatePage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/cfInfoCreate", new ModelAndView());
    }


    /**
     * Gets cf info update page.
     *
     * @param httpServletRequest the http servlet request
     * @return the cf info update page
     */
    @GetMapping(value = {"/{id:.+}"})
    public ModelAndView getCfInfoUpdatePage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/cfInfoUpdate", new ModelAndView());
    }


    /**
     * Gets cf info list.
     *
     * @param serviceInstancesId the service instances id
     * @param httpServletRequest the http servlet request
     * @return the cf info list
     */
    @RequestMapping(value = {"/list.do"}, method = RequestMethod.GET)
    @ResponseBody
    public CfInfoList getCfInfoList(@PathVariable(value = "serviceInstancesId", required = false) String serviceInstancesId,
                                    HttpServletRequest httpServletRequest) {
        return cfInfoService.getCfInfoList(serviceInstancesId, commonService.setParameters(httpServletRequest));
    }


    /**
     * Gets cf info.
     *
     * @param cfInfo the cf info
     * @return the cf info
     */
    @RequestMapping(value = {"/get.do"}, method = RequestMethod.GET)
    @ResponseBody
    public CfInfo getCfInfo(CfInfo cfInfo) {
        return cfInfoService.getCfInfo(cfInfo);
    }


    /**
     * Sets create cf info.
     *
     * @param cfInfo the cf info
     * @return the create cf info
     */
    @RequestMapping(value = {"/create.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfInfo setCreateCfInfo(@RequestBody CfInfo cfInfo) {
        return cfInfoService.setCreateCfInfo(cfInfo);
    }


    /**
     * Sets update cf info.
     *
     * @param cfInfo the cf info
     * @return the update cf info
     */
    @RequestMapping(value = {"/update.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfInfo setUpdateCfInfo(@RequestBody CfInfo cfInfo) {
        return cfInfoService.setUpdateCfInfo(cfInfo);
    }


    /**
     * Sets delete cf info.
     *
     * @param cfInfo the cf info
     * @return the delete cf info
     */
    @RequestMapping(value = {"/delete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfInfo setDeleteCfInfo(@RequestBody CfInfo cfInfo) {
        return cfInfoService.setDeleteCfInfo(cfInfo);
    }

}
