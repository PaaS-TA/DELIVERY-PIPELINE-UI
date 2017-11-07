package paasta.delivery.pipeline.ui.cf.url;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cf.url
 *
 * @author REX
 * @version 1.0
 * @since 11 /06/2017
 */
@Service
public class CfUrlService {

    private static final String REQ_URL = "/cf-urls";
    private final RestTemplateService restTemplateService;


    /**
     * Instantiates a new Cf url service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public CfUrlService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets cf url list.
     *
     * @param serviceInstancesId the service instances id
     * @return the cf url list
     */
    List getCfUrlList(String serviceInstancesId) {
        String reqUrl = "/serviceInstances/" + serviceInstancesId + REQ_URL;
        return restTemplateService.send(Constants.TARGET_COMMON_API, reqUrl, HttpMethod.GET, null, List.class);
    }


    /**
     * Gets cf url.
     *
     * @param cfUrl the cf url
     * @return the cf url
     */
    CfUrl getCfUrl(CfUrl cfUrl) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + cfUrl.getId(), HttpMethod.GET, null, CfUrl.class);
    }


    /**
     * Sets create cf url.
     *
     * @param cfUrl the cf url
     * @return the create cf url
     */
    CfUrl setCreateCfUrl(CfUrl cfUrl) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.POST, cfUrl, CfUrl.class);
    }


    /**
     * Sets update cf url.
     *
     * @param cfUrl the cf url
     * @return the update cf url
     */
    CfUrl setUpdateCfUrl(CfUrl cfUrl) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.PUT, cfUrl, CfUrl.class);
    }


    /**
     * Sets delete cf url.
     *
     * @param cfUrl the cf url
     * @return the delete cf url
     */
    CfUrl setDeleteCfUrl(CfUrl cfUrl) {
        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + cfUrl.getId(), HttpMethod.DELETE, null, String.class);
        cfUrl.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return cfUrl;
    }

}
