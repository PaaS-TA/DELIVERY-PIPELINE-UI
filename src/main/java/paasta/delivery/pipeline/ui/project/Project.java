package paasta.delivery.pipeline.ui.project;

import java.util.List;

/**
 * Created by hrjin on 2017-06-29.
 */
public class Project {

    // DATABASE COLUMNS :: BEGIN
    private long id; // pid
    private String serviceInstancesId;
    private long pipelineId;
    private long jobId;
    private long projectId; // id -> projectId
    private String projectName;
    private String projectKey;  //자동생성 uuid
    private String qualityProfileKey;
    private long qualityGateId;
    private String created;
    private String lastModified;
    private String createdString;
    private String lastModifiedString;
    private String projectViewName;
    // DATABASE COLUMNS :: END

    private String qualifier;
    private String resultStatus;
    private String resultMessage;
    private String branch;

    //프로젝트와 게이트, 프로파일 연결 상태
    private boolean linked;

    //sona에서 사용하는 id(gate)
    private String gateId;

    //sonar에서 사용하는 id(profile)
    private String profileKey;

    //품질관리 대시보드
    private Object measures;
    private String uuid;

    //품질관리 커버리지
    private String resource;
    private List msr;
    private String metrics;

    //tests소스
    private Object baseComponent;
    private String baseComponentKey;
    private List components;
    private List sources;
    private List scm;
    private List issues;

    //프로젝트 추가, 수정시 게이트와 프로파일 default 상태
    private String gateDefaultYn;
    private String profileDefaultYn;

    // Project Link 해제 시, Default Profile Key
    private String defaultQualityProfileKey;

    /**
     * Gets id.
     *
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * Sets id.
     *
     * @param id the id
     */
    public void setId(long id) {
        this.id = id;
    }

    /**
     * Gets service instances id.
     *
     * @return the service instances id
     */
    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    /**
     * Sets service instances id.
     *
     * @param serviceInstancesId the service instances id
     */
    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
    }

    /**
     * Gets pipeline id.
     *
     * @return the pipeline id
     */
    public long getPipelineId() {
        return pipelineId;
    }

    /**
     * Sets pipeline id.
     *
     * @param pipelineId the pipeline id
     */
    public void setPipelineId(long pipelineId) {
        this.pipelineId = pipelineId;
    }

    /**
     * Gets job id.
     *
     * @return the job id
     */
    public long getJobId() {
        return jobId;
    }

    /**
     * Sets job id.
     *
     * @param jobId the job id
     */
    public void setJobId(long jobId) {
        this.jobId = jobId;
    }

    /**
     * Gets project id.
     *
     * @return the project id
     */
    public long getProjectId() {
        return projectId;
    }

    /**
     * Sets project id.
     *
     * @param projectId the project id
     */
    public void setProjectId(long projectId) {
        this.projectId = projectId;
    }

    /**
     * Gets project name.
     *
     * @return the project name
     */
    public String getProjectName() {
        return projectName;
    }

    /**
     * Sets project name.
     *
     * @param projectName the project name
     */
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    /**
     * Gets project key.
     *
     * @return the project key
     */
    public String getProjectKey() {
        return projectKey;
    }

    /**
     * Sets project key.
     *
     * @param projectKey the project key
     */
    public void setProjectKey(String projectKey) {
        this.projectKey = projectKey;
    }

    /**
     * Gets quality profile key.
     *
     * @return the quality profile key
     */
    public String getQualityProfileKey() {
        return qualityProfileKey;
    }

    /**
     * Sets quality profile key.
     *
     * @param qualityProfileKey the quality profile key
     */
    public void setQualityProfileKey(String qualityProfileKey) {
        this.qualityProfileKey = qualityProfileKey;
    }

    /**
     * Gets quality gate id.
     *
     * @return the quality gate id
     */
    public long getQualityGateId() {
        return qualityGateId;
    }

    /**
     * Sets quality gate id.
     *
     * @param qualityGateId the quality gate id
     */
    public void setQualityGateId(long qualityGateId) {
        this.qualityGateId = qualityGateId;
    }

    /**
     * Gets created.
     *
     * @return the created
     */
    public String getCreated() {
        return created;
    }

    /**
     * Sets created.
     *
     * @param created the created
     */
    public void setCreated(String created) {
        this.created = created;
    }

    /**
     * Gets last modified.
     *
     * @return the last modified
     */
    public String getLastModified() {
        return lastModified;
    }

    /**
     * Sets last modified.
     *
     * @param lastModified the last modified
     */
    public void setLastModified(String lastModified) {
        this.lastModified = lastModified;
    }

    /**
     * Gets created string.
     *
     * @return the created string
     */
    public String getCreatedString() {
        return createdString;
    }

    /**
     * Sets created string.
     *
     * @param createdString the created string
     */
    public void setCreatedString(String createdString) {
        this.createdString = createdString;
    }

    /**
     * Gets last modified string.
     *
     * @return the last modified string
     */
    public String getLastModifiedString() {
        return lastModifiedString;
    }

    /**
     * Sets last modified string.
     *
     * @param lastModifiedString the last modified string
     */
    public void setLastModifiedString(String lastModifiedString) {
        this.lastModifiedString = lastModifiedString;
    }

    /**
     * Gets project view name.
     *
     * @return the project view name
     */
    public String getProjectViewName() {
        return projectViewName;
    }

    /**
     * Sets project view name.
     *
     * @param projectViewName the project view name
     */
    public void setProjectViewName(String projectViewName) {
        this.projectViewName = projectViewName;
    }

    /**
     * Gets qualifier.
     *
     * @return the qualifier
     */
    public String getQualifier() {
        return qualifier;
    }

    /**
     * Sets qualifier.
     *
     * @param qualifier the qualifier
     */
    public void setQualifier(String qualifier) {
        this.qualifier = qualifier;
    }

    /**
     * Gets result status.
     *
     * @return the result status
     */
    public String getResultStatus() {
        return resultStatus;
    }

    /**
     * Sets result status.
     *
     * @param resultStatus the result status
     */
    public void setResultStatus(String resultStatus) {
        this.resultStatus = resultStatus;
    }

    /**
     * Gets result message.
     *
     * @return the result message
     */
    public String getResultMessage() {
        return resultMessage;
    }

    /**
     * Sets result message.
     *
     * @param resultMessage the result message
     */
    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    /**
     * Gets branch.
     *
     * @return the branch
     */
    public String getBranch() {
        return branch;
    }

    /**
     * Sets branch.
     *
     * @param branch the branch
     */
    public void setBranch(String branch) {
        this.branch = branch;
    }

    /**
     * Is linked boolean.
     *
     * @return the boolean
     */
    public boolean isLinked() {
        return linked;
    }

    /**
     * Sets linked.
     *
     * @param linked the linked
     */
    public void setLinked(boolean linked) {
        this.linked = linked;
    }

    /**
     * Gets gate id.
     *
     * @return the gate id
     */
    public String getGateId() {
        return gateId;
    }

    /**
     * Sets gate id.
     *
     * @param gateId the gate id
     */
    public void setGateId(String gateId) {
        this.gateId = gateId;
    }

    /**
     * Gets profile key.
     *
     * @return the profile key
     */
    public String getProfileKey() {
        return profileKey;
    }

    /**
     * Sets profile key.
     *
     * @param profileKey the profile key
     */
    public void setProfileKey(String profileKey) {
        this.profileKey = profileKey;
    }

    /**
     * Gets measures.
     *
     * @return the measures
     */
    public Object getMeasures() {
        return measures;
    }

    /**
     * Sets measures.
     *
     * @param measures the measures
     */
    public void setMeasures(Object measures) {
        this.measures = measures;
    }

    /**
     * Gets uuid.
     *
     * @return the uuid
     */
    public String getUuid() {
        return uuid;
    }

    /**
     * Sets uuid.
     *
     * @param uuid the uuid
     */
    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    /**
     * Gets resource.
     *
     * @return the resource
     */
    public String getResource() {
        return resource;
    }

    /**
     * Sets resource.
     *
     * @param resource the resource
     */
    public void setResource(String resource) {
        this.resource = resource;
    }

    /**
     * Gets msr.
     *
     * @return the msr
     */
    public List getMsr() {
        return msr;
    }

    /**
     * Sets msr.
     *
     * @param msr the msr
     */
    public void setMsr(List msr) {
        this.msr = msr;
    }

    /**
     * Gets metrics.
     *
     * @return the metrics
     */
    public String getMetrics() {
        return metrics;
    }

    /**
     * Sets metrics.
     *
     * @param metrics the metrics
     */
    public void setMetrics(String metrics) {
        this.metrics = metrics;
    }

    /**
     * Gets base component.
     *
     * @return the base component
     */
    public Object getBaseComponent() {
        return baseComponent;
    }

    /**
     * Sets base component.
     *
     * @param baseComponent the base component
     */
    public void setBaseComponent(Object baseComponent) {
        this.baseComponent = baseComponent;
    }

    /**
     * Gets base component key.
     *
     * @return the base component key
     */
    public String getBaseComponentKey() {
        return baseComponentKey;
    }

    /**
     * Sets base component key.
     *
     * @param baseComponentKey the base component key
     */
    public void setBaseComponentKey(String baseComponentKey) {
        this.baseComponentKey = baseComponentKey;
    }

    /**
     * Gets components.
     *
     * @return the components
     */
    public List getComponents() {
        return components;
    }

    /**
     * Sets components.
     *
     * @param components the components
     */
    public void setComponents(List components) {
        this.components = components;
    }

    /**
     * Gets sources.
     *
     * @return the sources
     */
    public List getSources() {
        return sources;
    }

    /**
     * Sets sources.
     *
     * @param sources the sources
     */
    public void setSources(List sources) {
        this.sources = sources;
    }

    /**
     * Gets scm.
     *
     * @return the scm
     */
    public List getScm() {
        return scm;
    }

    /**
     * Sets scm.
     *
     * @param scm the scm
     */
    public void setScm(List scm) {
        this.scm = scm;
    }

    /**
     * Gets issues.
     *
     * @return the issues
     */
    public List getIssues() {
        return issues;
    }

    /**
     * Sets issues.
     *
     * @param issues the issues
     */
    public void setIssues(List issues) {
        this.issues = issues;
    }

    /**
     * Gets gate default yn.
     *
     * @return the gate default yn
     */
    public String getGateDefaultYn() {
        return gateDefaultYn;
    }

    /**
     * Sets gate default yn.
     *
     * @param gateDefaultYn the gate default yn
     */
    public void setGateDefaultYn(String gateDefaultYn) {
        this.gateDefaultYn = gateDefaultYn;
    }

    /**
     * Gets profile default yn.
     *
     * @return the profile default yn
     */
    public String getProfileDefaultYn() {
        return profileDefaultYn;
    }

    /**
     * Sets profile default yn.
     *
     * @param profileDefaultYn the profile default yn
     */
    public void setProfileDefaultYn(String profileDefaultYn) {
        this.profileDefaultYn = profileDefaultYn;
    }

    /**
     * Gets default quality profile key.
     *
     * @return the default quality profile key
     */
    public String getDefaultQualityProfileKey() {
        return defaultQualityProfileKey;
    }

    /**
     * Sets default quality profile key.
     *
     * @param defaultQualityProfileKey the default quality profile key
     */
    public void setDefaultQualityProfileKey(String defaultQualityProfileKey) {
        this.defaultQualityProfileKey = defaultQualityProfileKey;
    }

}
