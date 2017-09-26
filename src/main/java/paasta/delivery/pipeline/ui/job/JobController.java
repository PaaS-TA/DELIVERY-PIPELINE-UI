package paasta.delivery.pipeline.ui.job;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.cfInfo.CfInfoService;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.Constants;

import javax.servlet.http.HttpServletRequest;
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
@Controller
@RequestMapping(value = "/dashboard/{serviceInstancesId}/pipelines/{pipelineId:.+}/jobs")
public class JobController {

    private static final String VIEW_BASE_URL = "/job";
    private static final String REQ_CONFIG_TYPE_URL = "/job-configs";
    private static final String CF_INFO_LIST_ATTR_NAME = "cfInfoList";
    private static final String CF_INFO_LIST_QUERY_STRING = "?size=10000";

    private final CommonService commonService;
    private final JobService jobService;
    private final CfInfoService cfInfoService;

    /**
     * Instantiates a new Job controller.
     *
     * @param commonService the common service
     * @param jobService    the job service
     * @param cfInfoService the cf info service
     */
    @Autowired
    public JobController(CommonService commonService, JobService jobService, CfInfoService cfInfoService) {
        this.commonService = commonService;
        this.jobService = jobService;
        this.cfInfoService = cfInfoService;
    }


    /**
     * Gets job list page.
     *
     * @param httpServletRequest the http servlet request
     * @return the job list page
     */
    @RequestMapping(value = {"/dashboard"}, method = RequestMethod.GET)
    public ModelAndView getJobListPage(HttpServletRequest httpServletRequest) {
        // TODO :: MAY NOT BE USE
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/jobList", new ModelAndView());
    }


    /**
     * Gets job create page.
     *
     * @param serviceInstancesId the service instances id
     * @param httpServletRequest the http servlet request
     * @return the job create page
     */
    @RequestMapping(value = {"/create"}, method = RequestMethod.GET)
    public ModelAndView getJobCreatePage(@PathVariable(value = "serviceInstancesId", required = false) String serviceInstancesId,
                                         HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();

        mv.addObject("jobTypeList", jobService.getJobConfigTypeList(Constants.TYPE_JOB));
        mv.addObject("builderTypeList", jobService.getJobConfigTypeList(Constants.TYPE_BUILDER));
        mv.addObject("repositoryTypeList", jobService.getJobConfigTypeList(Constants.TYPE_REPOSITORY));
        mv.addObject("deployTypeList", jobService.getJobConfigTypeList(Constants.TYPE_DEPLOY));
        mv.addObject(CF_INFO_LIST_ATTR_NAME, cfInfoService.getCfInfoList(serviceInstancesId, CF_INFO_LIST_QUERY_STRING).getCfInfos());
        mv.addObject("buildJobTriggerTypeList", jobService.getJobConfigTypeList(Constants.BUILD_JOB_TRIGGER_TYPE));
        mv.addObject("testJobTriggerTypeList", jobService.getJobConfigTypeList(Constants.TEST_JOB_TRIGGER_TYPE));
        mv.addObject("deployJobTriggerTypeList", jobService.getJobConfigTypeList(Constants.DEPLOY_JOB_TRIGGER_TYPE));

        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/jobCreate", mv);
    }


    /**
     * Gets build job detail page.
     *
     * @param httpServletRequest the http servlet request
     * @return the build job detail page
     */
    @RequestMapping(value = {"/{id:.+}/build"}, method = RequestMethod.GET)
    public ModelAndView getBuildJobDetailPage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/buildJobLogHistory", new ModelAndView());
    }


    /**
     * Gets build job update page.
     *
     * @param httpServletRequest the http servlet request
     * @return the build job update page
     */
    @RequestMapping(value = {"/{id:.+}/build/update"}, method = RequestMethod.GET)
    public ModelAndView getBuildJobUpdatePage(HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();

        mv.addObject("builderTypeList", jobService.getJobConfigTypeList(Constants.TYPE_BUILDER));
        mv.addObject("repositoryTypeList", jobService.getJobConfigTypeList(Constants.TYPE_REPOSITORY));
        mv.addObject("buildJobTriggerTypeList", jobService.getJobConfigTypeList(Constants.BUILD_JOB_TRIGGER_TYPE));

        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/buildJobUpdate", mv);
    }


    /**
     * Gets test job detail page.
     *
     * @param httpServletRequest the http servlet request
     * @return the test job detail page
     */
    @RequestMapping(value = {"/{id:.+}/test"}, method = RequestMethod.GET)
    public ModelAndView getTestJobDetailPage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/testJobLogHistory", new ModelAndView());
    }


    /**
     * Gets test job update page.
     *
     * @param httpServletRequest the http servlet request
     * @return the test job update page
     */
    @RequestMapping(value = {"/{id:.+}/test/update"}, method = RequestMethod.GET)
    public ModelAndView getTestJobUpdatePage(HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();

        mv.addObject("testJobTriggerTypeList", jobService.getJobConfigTypeList(Constants.TEST_JOB_TRIGGER_TYPE));

        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/testJobUpdate", mv);
    }


    /**
     * Gets deploy job detail page.
     *
     * @param serviceInstancesId the service instances id
     * @param httpServletRequest the http servlet request
     * @return the deploy job detail page
     */
    @RequestMapping(value = {"/{id:.+}/deploy"}, method = RequestMethod.GET)
    public ModelAndView getDeployJobDetailPage(@PathVariable(value = "serviceInstancesId", required = false) String serviceInstancesId,
                                               HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();

        mv.addObject(CF_INFO_LIST_ATTR_NAME, cfInfoService.getCfInfoList(serviceInstancesId, CF_INFO_LIST_QUERY_STRING).getCfInfos());

        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/deployJobLogHistory", mv);
    }


    /**
     * Gets deploy job update page.
     *
     * @param serviceInstancesId the service instances id
     * @param httpServletRequest the http servlet request
     * @return the deploy job update page
     */
    @RequestMapping(value = {"/{id:.+}/deploy/update"}, method = RequestMethod.GET)
    public ModelAndView getDeployJobUpdatePage(@PathVariable(value = "serviceInstancesId", required = false) String serviceInstancesId,
                                               HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();

        mv.addObject("deployTypeList", jobService.getJobConfigTypeList(Constants.TYPE_DEPLOY));
        mv.addObject(CF_INFO_LIST_ATTR_NAME, cfInfoService.getCfInfoList(serviceInstancesId, CF_INFO_LIST_QUERY_STRING).getCfInfos());
        mv.addObject("deployJobTriggerTypeList", jobService.getJobConfigTypeList(Constants.DEPLOY_JOB_TRIGGER_TYPE));

        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/deployJobUpdate", mv);
    }


    /**
     * Gets deploy job update page.
     *
     * @param httpServletRequest the http servlet request
     * @return the deploy job update page
     */
    @RequestMapping(value = {"/{id:.+}/deploy/{jobHistoryId:.+}/roll-back"}, method = RequestMethod.GET)
    public ModelAndView getDeployJobRollBackPage(HttpServletRequest httpServletRequest) {
        return commonService.setPathVariables(httpServletRequest, VIEW_BASE_URL + "/deployJobRollBack", new ModelAndView());
    }


    /**
     * Gets api job list.
     *
     * @return the api job list
     */
    @RequestMapping(value = {"/api/list.do"}, method = RequestMethod.GET)
    @ResponseBody
    public Map getApiJobList() {
        // TODO :: MAY NOT BE USE
        return jobService.getApiJobList();
    }


    /**
     * Gets db job list.
     *
     * @param job the job
     * @return the db job list
     */
    @RequestMapping(value = {"/list.do"}, method = RequestMethod.GET)
    @ResponseBody
    public List getDbJobList(Job job) {
        return jobService.getDbJobList(job);
    }


    /**
     * Gets api job.
     *
     * @param job the custom job
     * @return the api job
     */
    @RequestMapping(value = {"/api/get.do"}, method = RequestMethod.GET)
    @ResponseBody
    public Map getApiJob(Job job) {
        // TODO :: MAY NOT BE USE
        return jobService.getApiJob(job.getJobGuid());
    }


    /**
     * Gets db job.
     *
     * @param job the custom job
     * @return the db job
     */
    @RequestMapping(value = {"/get.do"}, method = RequestMethod.GET)
    @ResponseBody
    public Job getDbJob(Job job) {
        return jobService.getDbJob(job.getId());
    }


    /**
     * Sets create build job.
     *
     * @param job the custom job
     * @return the create build job
     */
    @RequestMapping(value = {"/build/create.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setCreateBuildJob(@RequestBody Job job) {
        return jobService.setCreateJob(job);
    }


    /**
     * Sets update build job.
     *
     * @param job the custom job
     * @return the update build job
     */
    @RequestMapping(value = {"/build/update.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setUpdateBuildJob(@RequestBody Job job) {
        return jobService.setUpdateJob(job);
    }


    /**
     * Sets create test job.
     *
     * @param job the job
     * @return the create test job
     */
    @RequestMapping(value = {"/test/create.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setCreateTestJob(@RequestBody Job job) {
        return jobService.setCreateJob(job);
    }


    /**
     * Sets update test job.
     *
     * @param job the job
     * @return the update test job
     */
    @RequestMapping(value = {"/test/update.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setUpdateTestJob(@RequestBody Job job) {
        return jobService.setUpdateJob(job);
    }


    /**
     * Sets create deploy job.
     *
     * @param job the job
     * @return the create deploy job
     */
    @RequestMapping(value = {"/deploy/create.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setCreateDeployJob(@RequestBody Job job) {
        return jobService.setCreateJob(job);
    }


    /**
     * Sets update deploy job.
     *
     * @param job the job
     * @return the update deploy job
     */
    @RequestMapping(value = {"/deploy/update.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setUpdateDeployJob(@RequestBody Job job) {
        return jobService.setUpdateJob(job);
    }


    /**
     * Sets delete job.
     *
     * @param job the custom job
     * @return the delete job
     */
    @RequestMapping(value = {"/delete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setDeleteJob(@RequestBody Job job) {
        return jobService.setDeleteJob(job);
    }


    /**
     * Sets trigger job.
     *
     * @param job the custom job
     * @return the trigger job
     */
    @RequestMapping(value = {"/trigger.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setTriggerJob(@RequestBody Job job) {
        return jobService.setTriggerJob(job);
    }


    /**
     * Sets stop job.
     *
     * @param job the custom job
     * @return the stop job
     */
    @RequestMapping(value = {"/stop.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setStopJob(@RequestBody Job job) {
        return jobService.setStopJob(job);
    }


    /**
     * Gets db job history list.
     *
     * @param jobHistory the custom job history
     * @return the db job history list
     */
    @RequestMapping(value = {"/db/history/list.do"}, method = RequestMethod.GET)
    @ResponseBody
    public List getDbJobHistoryList(JobHistory jobHistory) {
        return jobService.getDbJobHistoryList(jobHistory);
    }


    /**
     * Gets job config type list.
     *
     * @param configType the config type
     * @return the job config type list
     */
    @RequestMapping(value = {REQ_CONFIG_TYPE_URL + "/list.do/{configType:.+}"}, method = RequestMethod.POST)
    @ResponseBody
    public List getJobConfigTypeList(@PathVariable("configType") String configType) {
        return jobService.getJobConfigTypeList(configType);
    }


    /**
     * Gets job log.
     *
     * @param id        the id
     * @param jobNumber the job number
     * @return the job log
     */
    @RequestMapping(value = "/{id:.+}/log.do/{jobNumber:.+}", method = RequestMethod.GET)
    @ResponseBody
    public Job getJobLog(@PathVariable("id") int id, @PathVariable("jobNumber") int jobNumber) {
        return jobService.getJobLog(id, jobNumber);
    }


    /**
     * Gets job status.
     *
     * @param job the custom job
     * @return the job status
     */
    @RequestMapping(value = {"/status.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job getJobStatus(@RequestBody Job job) {
        return jobService.getJobStatus(job);
    }


    /**
     * Sets replicate job.
     *
     * @param job the job
     * @return the replicate job
     */
    @RequestMapping(value = {"/replicate.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job setReplicateJob(@RequestBody Job job) {
        return jobService.setReplicateJob(job);
    }


    /**
     * Rearrange job order.
     *
     * @param job the job
     * @return the rearrange job order
     */
    @RequestMapping(value = {"/rearrangeJobOrder.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job rearrangeJobOrder(@RequestBody Job job) {
        return jobService.rearrangeJobOrder(job);
    }

}
