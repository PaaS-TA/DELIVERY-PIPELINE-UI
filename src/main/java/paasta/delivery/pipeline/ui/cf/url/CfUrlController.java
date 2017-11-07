package paasta.delivery.pipeline.ui.cf.url;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cf.url
 *
 * @author REX
 * @version 1.0
 * @since 11 /06/2017
 */
@Controller
@RequestMapping(value = "/dashboard/{serviceInstancesId}/cf-urls")
public class CfUrlController {

    private final CfUrlService cfUrlService;


    /**
     * Instantiates a new Cf url controller.
     *
     * @param cfUrlService the cf url service
     */
    @Autowired
    public CfUrlController(CfUrlService cfUrlService) {this.cfUrlService = cfUrlService;}


    /**
     * Gets cf url list.
     *
     * @param serviceInstancesId the service instances id
     * @return the cf url list
     */
    @RequestMapping(value = {"/list.do"}, method = RequestMethod.GET)
    @ResponseBody
    public List getCfUrlList(@PathVariable(value = "serviceInstancesId") String serviceInstancesId) {
        return cfUrlService.getCfUrlList(serviceInstancesId);
    }


    /**
     * Gets cf url.
     *
     * @param cfUrl the cf url
     * @return the cf url
     */
    @RequestMapping(value = {"/get.do"}, method = RequestMethod.GET)
    @ResponseBody
    public CfUrl getCfUrl(CfUrl cfUrl) {
        return cfUrlService.getCfUrl(cfUrl);
    }


    /**
     * Sets create cf url.
     *
     * @param cfUrl the cf url
     * @return the create cf url
     */
    @RequestMapping(value = {"/create.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfUrl setCreateCfUrl(@RequestBody CfUrl cfUrl) {
        return cfUrlService.setCreateCfUrl(cfUrl);
    }


    /**
     * Sets update cf url.
     *
     * @param cfUrl the cf url
     * @return the update cf url
     */
    @RequestMapping(value = {"/update.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfUrl setUpdateCfUrl(@RequestBody CfUrl cfUrl) {
        return cfUrlService.setUpdateCfUrl(cfUrl);
    }


    /**
     * Sets delete cf url.
     *
     * @param cfUrl the cf url
     * @return the delete cf url
     */
    @RequestMapping(value = {"/delete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfUrl setDeleteCfUrl(@RequestBody CfUrl cfUrl) {
        return cfUrlService.setDeleteCfUrl(cfUrl);
    }

}
