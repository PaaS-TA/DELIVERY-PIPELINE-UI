package paasta.delivery.pipeline.ui.job;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;

/**
 * deliveryPipelineApi
 * paasta.delivery.pipeline.ui.job
 *
 * @author REX
 * @version 1.0
 * @since 10 /11/2017
 */
@Service
public class JobInspectionService {

    private static final String REQ_URL = "";
    private final RestTemplateService restTemplateService;


    /**
     * Instantiates a new Job inspection service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public JobInspectionService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets quality profile list.
     *
     * @param serviceInstancesId the service instances id
     * @return the quality profile list
     */
    List getQualityProfileList(String serviceInstancesId) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL + "/qualityProfile/qualityProfileList?serviceInstancesId=" + serviceInstancesId + "&language=java", HttpMethod.GET, null, List.class);
    }


    /**
     * Gets quality gate list.
     *
     * @param serviceInstancesId the service instances id
     * @return the quality gate list
     */
    List getQualityGateList(String serviceInstancesId) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL + "/qualitygates/qualityGateList?serviceInstancesId=" + serviceInstancesId, HttpMethod.GET, null, List.class);
    }

}
