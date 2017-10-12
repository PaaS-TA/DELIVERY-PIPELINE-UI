package paasta.delivery.pipeline.ui.job;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * deliveryPipelineApi
 * paasta.delivery.pipeline.ui.job
 *
 * @author REX
 * @version 1.0
 * @since 10 /11/2017
 */
@Controller
@RequestMapping(value = "/dashboard/{serviceInstancesId}/pipelines/{pipelineId}/inspections")
public class JobInspectionController {

    private final JobInspectionService jobInspectionService;


    /**
     * Instantiates a new Job inspection controller.
     *
     * @param jobInspectionService the job inspection service
     */
    @Autowired
    public JobInspectionController(JobInspectionService jobInspectionService) {this.jobInspectionService = jobInspectionService;}


    /**
     * Gets quality profile list.
     *
     * @param serviceInstancesId the service instances id
     * @return the quality profile list
     */
    @GetMapping(value = {"/getQualityProfileList.do"})
    @ResponseBody
    public List getQualityProfileList(@PathVariable("serviceInstancesId") String serviceInstancesId) {
        return jobInspectionService.getQualityProfileList(serviceInstancesId);
    }


    /**
     * Gets quality gate list.
     *
     * @param serviceInstancesId the service instances id
     * @return the quality gate list
     */
    @GetMapping(value = {"/getQualityGateList.do"})
    @ResponseBody
    public List getQualityGateList(@PathVariable("serviceInstancesId") String serviceInstancesId) {
        return jobInspectionService.getQualityGateList(serviceInstancesId);
    }

}
