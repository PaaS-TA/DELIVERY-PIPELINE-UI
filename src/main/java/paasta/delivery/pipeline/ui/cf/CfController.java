package paasta.delivery.pipeline.ui.cf;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import paasta.delivery.pipeline.ui.cfInfo.CfInfo;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cf
 *
 * @author REX
 * @version 1.0
 * @since 8 /24/2017
 */
@Controller
@RequestMapping(value = "/dashboard/{serviceInstancesId}/cf")
public class CfController {

    private final CfService cfService;


    /**
     * Instantiates a new Cf controller.
     *
     * @param cfService the cf service
     */
    @Autowired
    public CfController(CfService cfService) {this.cfService = cfService;}


    /**
     * Gets cf org name and space list.
     *
     * @param serviceInstancesId the service instances id
     * @param id                 the id
     * @return the cf org name and space list
     */
    @RequestMapping(value = {"/get.do/{id:.+}"}, method = RequestMethod.GET)
    @ResponseBody
    public Cf getCfOrgNameAndSpaceList(@PathVariable(value = "serviceInstancesId") String serviceInstancesId,
                                       @PathVariable(value = "id") int id) {
        CfInfo cfInfo = new CfInfo();
        cfInfo.setServiceInstancesId(serviceInstancesId);
        cfInfo.setId(id);
        return cfService.getCfOrgNameAndSpaceList(cfInfo);
    }

}
