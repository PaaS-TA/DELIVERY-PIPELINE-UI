package paasta.delivery.pipeline.ui.pipeline;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.auth.Authority;
import paasta.delivery.pipeline.ui.auth.AuthorityService;
import paasta.delivery.pipeline.ui.auth.GrantedAuthority;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.job.Job;
import paasta.delivery.pipeline.ui.job.JobService;
import paasta.delivery.pipeline.ui.serviceInstance.InstanceUse;

import java.util.Map;

/**
 * Created by hrjin on 2017-05-18.
 */
@Service
public class PipelineService {

    private static final String REQ_URL = "/pipeline";
    private final RestTemplateService restTemplateService;
    private final CommonService commonService;
    private final AuthorityService authorityService;
    private final JobService jobService;

    @Autowired
    public PipelineService(RestTemplateService restTemplateService, CommonService commonService, AuthorityService authorityService, JobService jobService) {
        this.restTemplateService = restTemplateService;
        this.commonService = commonService;
        this.authorityService = authorityService;
        this.jobService = jobService;
    }

    public PipelineList getPipelineList(String suid, String queryString) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + suid + "/list" + queryString, HttpMethod.GET, null, PipelineList.class);
    }

    public Pipeline getPipeline(Long pipelineId) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + pipelineId, HttpMethod.GET, null, Pipeline.class);
    }

    public Pipeline setCreatePipeline(Pipeline pipeline) {
        Pipeline newPipeline = null;
        // 1. 파이프라인이 생성됨과 동시에 생성한 사람은 write 권한을 가지게 되는 로직.
        if(pipeline.getServiceInstancesId() != null){
            newPipeline = restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + pipeline.getServiceInstancesId(), HttpMethod.POST, pipeline, Pipeline.class);

            // 2. user_id 와 service_instance_id 를 가지고 instance_use_id 조회.
            String userId = commonService.getUserInfo().getId();
            InstanceUse instanceUse = restTemplateService.send(Constants.TARGET_COMMON_API, "/serviceInstance/" + pipeline.getServiceInstancesId() + "/user/" + userId, HttpMethod.GET, null, InstanceUse.class);

            // 3. 생성 권한 authority_id를 가져옴.
            String code = "write";
            Authority authority = authorityService.getCode(code);

            // 4. 앞에서 가져온 authority_id와 instance_use_id를 가지고 GrantedAuthority 를 실행 - > write 권한 부여.
            GrantedAuthority grantedAuthority = new GrantedAuthority();
            grantedAuthority.setAuthorityId(authority.getId());
            grantedAuthority.setInstanceUseId(instanceUse.getId());

            grantedAuthority.setAuthCode(newPipeline.getId());

            GrantedAuthority newGrantedAuthority = restTemplateService.send(Constants.TARGET_COMMON_API, "/authorize", HttpMethod.POST, grantedAuthority, GrantedAuthority.class);
        }

        return newPipeline;
    }

    public Pipeline setUpdatePipeline(Long pipelineId, Pipeline pipeline) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + pipelineId, HttpMethod.PUT, pipeline, Pipeline.class);
    }

    public Pipeline setDeletePipeline(long pipelineId) {
        restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + pipelineId, HttpMethod.DELETE, null, String.class);

        // GET JOB LIST BY PIPELINE ID
        Job job = new Job();
        job.setPipelineId(pipelineId);

        // DELETE JOB INCLUDE JOB HISTORY
        for (Object aJobList : jobService.getDbJobList(job)) {
            Map<String, Object> map = (Map<String, Object>) aJobList;
            int jobId = (int) map.get("id");
            Job reqJob = new Job();
            reqJob.setId((long) jobId);

            jobService.setDeleteJob(reqJob);
        }

        Pipeline resultModel = new Pipeline();
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return resultModel;
    }
}
