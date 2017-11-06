package paasta.delivery.pipeline.ui.cf.url;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;

@Service
public class CfUrlService {

    private static final String REQ_URL = "/cf-urls";
    private final RestTemplateService restTemplateService;


    @Autowired
    public CfUrlService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    List getCfUrlList(String serviceInstancesId) {
        String reqUrl = REQ_URL + "/" + serviceInstancesId;
        return restTemplateService.send(Constants.TARGET_COMMON_API, reqUrl, HttpMethod.GET, null, List.class);
    }


    CfUrl getCfUrl(CfUrl cfUrl) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + cfUrl.getId(), HttpMethod.GET, null, CfUrl.class);
    }


    CfUrl setCreateCfUrl(CfUrl cfUrl) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.POST, cfUrl, CfUrl.class);
    }


    CfUrl setUpdateCfUrl(CfUrl cfUrl) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.PUT, cfUrl, CfUrl.class);
    }


    CfUrl setDeleteCfUrl(CfUrl cfUrl) {
        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + cfUrl.getId(), HttpMethod.DELETE, null, String.class);
        cfUrl.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return cfUrl;
    }

}
