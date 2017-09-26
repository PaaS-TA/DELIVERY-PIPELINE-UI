package paasta.delivery.pipeline.ui.serviceInstance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;

/**
 * Created by hrjin on 2017-06-07.
 */
@Service
public class InstanceUseService {

    private static final String REQ_URL = "/serviceInstance";
    private final RestTemplateService restTemplateService;

    @Autowired
    public InstanceUseService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    public List<InstanceUse> getInstanceUseList() {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/detail", HttpMethod.GET, null, List.class);
    }

    public InstanceUseList getInstanceUseList(String serviceInstancesId, String queryString) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + serviceInstancesId + "/detail" + queryString, HttpMethod.GET, null, InstanceUseList.class);
    }

    public InstanceUse getInstanceUse(String serviceInstancesId, String userId) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + serviceInstancesId + "/user/" + userId, HttpMethod.GET, null, InstanceUse.class);
    }

    public InstanceUse setDeleteInstanceUse(String serviceInstancesId, String userId) {
        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + serviceInstancesId + "/user/" + userId, HttpMethod.DELETE, null, String.class);
        InstanceUse resultModel = new InstanceUse();
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return resultModel;
    }

    public InstanceUse createInstanceUse(InstanceUse instanceUse) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + instanceUse.getServiceInstancesId() + "/user/" + instanceUse.getUserId(), HttpMethod.POST, instanceUse, InstanceUse.class);
    }

    public InstanceUse setUpdateInstanceUse(String serviceInstancesId, InstanceUse instanceUse) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + serviceInstancesId + "/user/" + instanceUse.getUser().getId(), HttpMethod.PUT, instanceUse, InstanceUse.class);
    }


    public InstanceUseList getInstanceUseListByPipelineContributor(String suid, Long pipelineId, String queryString) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + suid + "/pipeline/" + pipelineId + queryString, HttpMethod.GET, null, InstanceUseList.class);
    }

    /*public InstanceUse setUpdateContributor(Long pipelineId, InstanceUse instanceUse) {
        /{serviceInstanceId}/user/{userId}
    }*/


    public InstanceUse setUpdateInstanceUse2(String serviceInstancesId,String userUid ,InstanceUse instanceUse) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + serviceInstancesId + "/user/" + userUid , HttpMethod.PUT, instanceUse, InstanceUse.class);
    }
}
