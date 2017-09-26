package paasta.delivery.pipeline.ui.job;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;
import java.util.Map;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.job
 *
 * @author REX
 * @version 1.0
 * @since 5 /10/2017
 */
@Service
public class JobService {

    private static final String REQ_URL = "/jobs";
    private static final String REQ_CONFIG_TYPE_URL = "/job-configs/";
    private final RestTemplateService restTemplateService;


    /**
     * Instantiates a new Job service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public JobService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets api job list.
     *
     * @return the api job list
     */
    Map getApiJobList() {
        // TODO :: MAY NOT BE USE
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL, HttpMethod.GET, null, Map.class);
    }


    /**
     * Gets db job list.
     *
     * @param job the job
     * @return the db job list
     */
    public List getDbJobList(Job job) {
        Long pipelineId = job.getPipelineId();
        String jobType = job.getJobType();
        String reqUrl = "";

        if (null != pipelineId && pipelineId != 0) {
            reqUrl += "/pipelines/" + pipelineId + "/jobs";

            if (null != jobType && !"".equals(jobType)) {
                reqUrl += "/job-types/" + jobType;
            }
        }

        return restTemplateService.send(Constants.TARGET_COMMON_API, reqUrl, HttpMethod.GET, null, List.class);
    }


    /**
     * Gets api job.
     *
     * @param jobGuid the job guid
     * @return the api job
     */
    Map getApiJob(String jobGuid) {
        // TODO :: MAY NOT BE USE
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL + "/" + jobGuid, HttpMethod.GET, null, Map.class);
    }


    /**
     * Gets db job.
     *
     * @param id the id
     * @return the db job
     */
    Job getDbJob(Long id) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + id, HttpMethod.GET, null, Job.class);
    }


    /**
     * Sets create build job.
     *
     * @param job the custom job
     * @return the create build job
     */
    Job setCreateJob(Job job) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL, HttpMethod.POST, job, Job.class);
    }


    /**
     * Sets update build job.
     *
     * @param job the custom job
     * @return the update build job
     */
    Job setUpdateJob(Job job) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL, HttpMethod.PUT, job, Job.class);
    }


    /**
     * Sets delete job.
     *
     * @param job the custom job
     * @return the delete job
     */
    public Job setDeleteJob(Job job) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL + "/" + job.getId(), HttpMethod.DELETE, null, Job.class);
    }


    /**
     * Sets trigger job.
     *
     * @param job the custom job
     * @return the trigger job
     */
    Job setTriggerJob(Job job) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL + "/trigger", HttpMethod.POST, job, Job.class);
    }


    /**
     * Sets stop job.
     *
     * @param job the custom job
     * @return the stop job
     */
    Job setStopJob(Job job) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL + "/stop", HttpMethod.POST, job, Job.class);
    }


    /**
     * Gets db job history list.
     *
     * @param jobHistory the custom job history
     * @return the db job history list
     */
    List getDbJobHistoryList(JobHistory jobHistory) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL + "/" + jobHistory.getJobId() + "/histories", HttpMethod.GET, null, List.class);
    }


    /**
     * Gets job config type list.
     *
     * @param configType the config type
     * @return the job config type list
     */
    List getJobConfigTypeList(String configType) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_CONFIG_TYPE_URL + configType, HttpMethod.GET, null, List.class);
    }


    /**
     * Gets job log.
     *
     * @param id        the id
     * @param jobNumber the job number
     * @return the job log
     */
    Job getJobLog(int id, int jobNumber) {
        String reqUrl = REQ_URL + "/" + id + "/log/" + jobNumber;
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, reqUrl, HttpMethod.GET, null, Job.class);
    }


    /**
     * Gets job status.
     *
     * @param job the custom job
     * @return the job status
     */
    Job getJobStatus(Job job) {
        String reqUrl = REQ_URL + "/" + job.getId() + "/status/" + job.getJobNumber();
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, reqUrl, HttpMethod.GET, job, Job.class);
    }


    /**
     * Sets replicate job.
     *
     * @param job the job
     * @return the replicate job
     */
    Job setReplicateJob(Job job) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL + "/replicate", HttpMethod.POST, job, Job.class);
    }


    /**
     * Sets rearrange job order.
     *
     * @param job the job
     * @return the rearrange job order
     */
    Job rearrangeJobOrder(Job job) {
        return restTemplateService.send(Constants.TARGET_DELIVERY_PIPELINE_API, REQ_URL + "/rearrange-job-order", HttpMethod.POST, job, Job.class);
    }

}
