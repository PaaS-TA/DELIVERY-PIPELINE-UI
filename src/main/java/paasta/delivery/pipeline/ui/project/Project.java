package paasta.delivery.pipeline.ui.project;

import java.util.List;

/**
 * Created by hrjin on 2017-06-29.
 */
public class Project {
    private Long id;

    private String name;

    private String key;

    private String sonarKey; // sonarqube의 key 값

    private String sonar_name;

    private String qualifier;

    private String orgName;

    private String orgGuid;

    private String userName;

    private String userGuid;

    private String qualityProfileId;

    private String qualityGateId;

    private String serviceInstancesId;

    private int pipelineId;

    private long jobId;

    //testJob
    private String jobName;
    private String branch;

    //프로젝트 연결상태
    private Boolean linked;

    //프로파일 프로젝트 연결
    private String profileKey;
    private String projectKey;

    //품질관리 대시보드
    private Object measures;
    private String uuid;
    private String projectName;

    //품질관리 커버리지
    private String resource;
    private List msr;
    private String metrics;

    //tests소스
    private Object baseComponent;
    private String baseComponentKey;
    private List components;
    private List sources;
    private List issues;
    private List scm;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSonarKey() {
        return sonarKey;
    }

    public void setSonarKey(String sonarKey) {
        this.sonarKey = sonarKey;
    }

    public String getSonar_name() {
        return sonar_name;
    }

    public void setSonar_name(String sonar_name) {
        this.sonar_name = sonar_name;
    }

    public String getQualifier() {
        return qualifier;
    }

    public void setQualifier(String qualifier) {
        this.qualifier = qualifier;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getOrgGuid() {
        return orgGuid;
    }

    public void setOrgGuid(String orgGuid) {
        this.orgGuid = orgGuid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserGuid() {
        return userGuid;
    }

    public void setUserGuid(String userGuid) {
        this.userGuid = userGuid;
    }

    public String getQualityProfileId() {
        return qualityProfileId;
    }

    public void setQualityProfileId(String qualityProfileId) {
        this.qualityProfileId = qualityProfileId;
    }

    public String getQualityGateId() {
        return qualityGateId;
    }

    public void setQualityGateId(String qualityGateId) {
        this.qualityGateId = qualityGateId;
    }

    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
    }
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public Boolean getLinked() {
        return linked;
    }

    public void setLinked(Boolean linked) {
        this.linked = linked;
    }

    public String getProjectKey() {
        return projectKey;
    }

    public void setProjectKey(String projectKey) {
        this.projectKey = projectKey;
    }

    public Object getMeasures() {
        return measures;
    }

    public void setMeasures(Object measures) {
        this.measures = measures;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public List getMsr() {
        return msr;
    }

    public void setMsr(List msr) {
        this.msr = msr;
    }

    public String getMetrics() {
        return metrics;
    }

    public void setMetrics(String metrics) {
        this.metrics = metrics;
    }

    public Object getBaseComponent() {
        return baseComponent;
    }

    public void setBaseComponent(Object baseComponent) {
        this.baseComponent = baseComponent;
    }

    public String getBaseComponentKey() {
        return baseComponentKey;
    }

    public void setBaseComponentKey(String baseComponentKey) {
        this.baseComponentKey = baseComponentKey;
    }

    public List getComponents() {
        return components;
    }

    public void setComponents(List components) {
        this.components = components;
    }

    public List getSources() {
        return sources;
    }

    public void setSources(List sources) {
        this.sources = sources;
    }

    public List getIssues() {
        return issues;
    }

    public void setIssues(List issues) {
        this.issues = issues;
    }

    public List getScm() {
        return scm;
    }

    public void setScm(List scm) {
        this.scm = scm;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getProfileKey() {
        return profileKey;
    }

    public void setProfileKey(String profileKey) {
        this.profileKey = profileKey;
    }

    public int getPipelineId() {
        return pipelineId;
    }

    public void setPipelineId(int pipelineId) {
        this.pipelineId = pipelineId;
    }

    public long getJobId() {
        return jobId;
    }

    public void setJobId(long jobId) {
        this.jobId = jobId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Project{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", key='" + key + '\'' +
                ", sonarKey='" + sonarKey + '\'' +
                ", sonar_name='" + sonar_name + '\'' +
                ", qualifier='" + qualifier + '\'' +
                ", orgName='" + orgName + '\'' +
                ", orgGuid='" + orgGuid + '\'' +
                ", userName='" + userName + '\'' +
                ", userGuid='" + userGuid + '\'' +
                ", qualityProfileId='" + qualityProfileId + '\'' +
                ", qualityGateId='" + qualityGateId + '\'' +
                ", serviceInstancesId='" + serviceInstancesId + '\'' +
                ", pipelineId=" + pipelineId +
                ", jobId=" + jobId +
                ", jobName='" + jobName + '\'' +
                ", branch='" + branch + '\'' +
                ", linked=" + linked +
                ", profileKey='" + profileKey + '\'' +
                ", projectKey='" + projectKey + '\'' +
                ", measures=" + measures +
                ", uuid='" + uuid + '\'' +
                ", projectName='" + projectName + '\'' +
                ", resource='" + resource + '\'' +
                ", msr=" + msr +
                ", metrics='" + metrics + '\'' +
                ", baseComponent=" + baseComponent +
                ", baseComponentKey='" + baseComponentKey + '\'' +
                ", components=" + components +
                ", sources=" + sources +
                ", issues=" + issues +
                ", scm=" + scm +
                '}';
    }
}
