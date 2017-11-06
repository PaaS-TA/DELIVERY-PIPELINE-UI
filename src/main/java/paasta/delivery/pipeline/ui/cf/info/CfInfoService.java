package paasta.delivery.pipeline.ui.cf.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cfInfo
 *
 * @author REX
 * @version 1.0
 * @since 7 /25/2017
 */
@Service
public class CfInfoService {

    private static final String REQ_URL = "/cf-info";
    private final RestTemplateService restTemplateService;


    /**
     * Instantiates a new Cf info service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public CfInfoService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets cf info list.
     *
     * @param serviceInstancesId the service instances id
     * @param queryString        the query string
     * @return the cf info list
     */
    public CfInfoList getCfInfoList(String serviceInstancesId, String queryString) {
        String reqUrl = "/serviceInstances/" + serviceInstancesId + REQ_URL + queryString;
        return restTemplateService.send(Constants.TARGET_COMMON_API, reqUrl, HttpMethod.GET, null, CfInfoList.class);
    }


    /**
     * Gets cf info.
     *
     * @param cfInfo the cf info
     * @return the cf info
     */
    public CfInfo getCfInfo(CfInfo cfInfo) {
        CfInfo resultModel = new CfInfo();
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);

        Long reqId = cfInfo.getId();
        String reqCfName = cfInfo.getCfName();

        // GET DETAIL
        if (0 < reqId) {
            resultModel = restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + reqId, HttpMethod.GET, null, CfInfo.class);
        }

        // GET COUNT BY CF NAME
        if (null != reqCfName && !"".equals(reqCfName)
                && 0 < restTemplateService.send(Constants.TARGET_COMMON_API, "/serviceInstances/" + cfInfo.getServiceInstancesId() + REQ_URL + "/cf-name/" + reqCfName, HttpMethod.GET, null, Integer.class)) {
            resultModel.setResultStatus(Constants.RESULT_STATUS_FAIL);
        }

        return resultModel;
    }


    /**
     * Sets create cf info.
     *
     * @param cfInfo the cf info
     * @return the create cf info
     */
    CfInfo setCreateCfInfo(CfInfo cfInfo) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.POST, cfInfo, CfInfo.class);
    }


    /**
     * Sets update cf info.
     *
     * @param cfInfo the cf info
     * @return the update cf info
     */
    CfInfo setUpdateCfInfo(CfInfo cfInfo) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.PUT, cfInfo, CfInfo.class);
    }


    /**
     * Sets delete cf info.
     *
     * @param cfInfo the cf info
     * @return the delete cf info
     */
    CfInfo setDeleteCfInfo(CfInfo cfInfo) {
        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + cfInfo.getId(), HttpMethod.DELETE, null, String.class);
        cfInfo.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return cfInfo;
    }

}
