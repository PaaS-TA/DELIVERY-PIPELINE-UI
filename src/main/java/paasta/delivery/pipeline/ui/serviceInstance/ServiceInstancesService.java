package paasta.delivery.pipeline.ui.serviceInstance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;

/**
 * Created by hrjin on 2017-06-02.
 */
@Service
public class ServiceInstancesService {

    private static final String REQ_URL = "/serviceInstance";
    private final RestTemplateService restTemplateService;

    @Autowired
    public ServiceInstancesService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    public List<ServiceInstances> getServiceInstancesList() {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.GET, null, List.class);
    }

    public ServiceInstances setCreateServiceInstances(ServiceInstances serviceInstances) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL, HttpMethod.POST, serviceInstances, ServiceInstances.class);
    }


    public ServiceInstances getServiceInstances(String id) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + id, HttpMethod.GET, null, ServiceInstances.class);
    }

    public ServiceInstances setDeleteServiceInstance(String id) {
        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + id, HttpMethod.DELETE, null, String.class);
        ServiceInstances resultModel = new ServiceInstances();
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return resultModel;
    }
}
