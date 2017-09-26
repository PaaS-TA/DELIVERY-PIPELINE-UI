package paasta.delivery.pipeline.ui.auth;

import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;
import java.util.Map;

/**
 * Created by hrjin on 2017-07-21.
 */
@Service
public class AuthorityService {

    private static final String REQ_URL = "/authorities";
    private final RestTemplateService restTemplateService;

    public AuthorityService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    public List<Authority> getAuthorityList() {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.GET, null, List.class);
    }

    public List<Map> getAuthorityListMap() {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.GET, null, List.class);
    }
    public Authority getCode(String code){
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/code/" + code, HttpMethod.GET, null, Authority.class);
    }

    /*public List<Authority> getAuthorityByAuthType(String authType) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/authType/" + authType, HttpMethod.GET, null, List.class);
    }*/
}
