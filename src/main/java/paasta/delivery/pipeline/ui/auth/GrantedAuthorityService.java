package paasta.delivery.pipeline.ui.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

/**
 * Created by hrjin on 2017-08-14.
 */
@Service
public class GrantedAuthorityService {
    private static final String REQ_URL = "/authorize";
    private final RestTemplateService restTemplateService;

    @Autowired
    public GrantedAuthorityService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    public GrantedAuthority contributorGrantedAuthority(GrantedAuthority newGrantedAuthority) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.POST, newGrantedAuthority, GrantedAuthority.class);
    }

    public String deleteContributor(String id) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + id, HttpMethod.DELETE, null, String.class);
    }
}
