package paasta.delivery.pipeline.ui.qualityGate;

import java.util.List;

/**
 * Created by hrjin on 2017-06-29.
 */
public class QualityGate {

    private Long id;
    private String uuid;
    private String name;
    private String orgName;
    private String orgGuid;
    private String userName;
    private String userGuid;
    private List<Long> projectIdList;
    private String created;
    private String lastModified;
    private String createdString;
    private String lastModifiedString;
    private String resultStatus;
    private String resultMessage;

    //////////////////////////////////////
    private String serviceInstancesId;

    //게이트 조건 목록
    private List conditions;

    //게이트 조건 저장 목록
    private String gateId;
    private String metric;
    private String error;
    private String warning;
    private String op;

    //게이트 조건 콤보박스 목록
    private  List metrics;

    //프로젝트 연결상태
    private Boolean linked;

    //게이트 리스트
    private List qualitygates;
    //삭제 예정
    private String defaultKey;

    private String defaultYn;
    private List domains;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public List<Long> getProjectIdList() {
        return projectIdList;
    }

    public void setProjectIdList(List<Long> projectIdList) {
        this.projectIdList = projectIdList;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getLastModified() {
        return lastModified;
    }

    public void setLastModified(String lastModified) {
        this.lastModified = lastModified;
    }

    public String getCreatedString() {
        return createdString;
    }

    public void setCreatedString(String createdString) {
        this.createdString = createdString;
    }

    public String getLastModifiedString() {
        return lastModifiedString;
    }

    public void setLastModifiedString(String lastModifiedString) {
        this.lastModifiedString = lastModifiedString;
    }

    public String getResultStatus() {
        return resultStatus;
    }

    public void setResultStatus(String resultStatus) {
        this.resultStatus = resultStatus;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    public List getConditions() {
        return conditions;
    }

    public void setConditions(List conditions) {
        this.conditions = conditions;
    }

    public String getGateId() {
        return gateId;
    }

    public void setGateId(String gateId) {
        this.gateId = gateId;
    }

    public String getMetric() {
        return metric;
    }

    public void setMetric(String metric) {
        this.metric = metric;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getWarning() {
        return warning;
    }

    public void setWarning(String warning) {
        this.warning = warning;
    }

    public String getOp() {
        return op;
    }

    public void setOp(String op) {
        this.op = op;
    }

    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
    }

    public Boolean getLinked() {
        return linked;
    }

    public void setLinked(Boolean linked) {
        this.linked = linked;
    }

    public List getMetrics() {
        return metrics;
    }

    public void setMetrics(List metrics) {
        this.metrics = metrics;
    }

    public List getQualitygates() {
        return qualitygates;
    }

    public void setQualitygates(List qualitygates) {
        this.qualitygates = qualitygates;
    }

    public String getDefaultKey() {
        return defaultKey;
    }

    public void setDefaultKey(String defaultKey) {
        this.defaultKey = defaultKey;
    }

    public List getDomains() {
        return domains;
    }

    public void setDomains(List domains) {
        this.domains = domains;
    }

    public String getDefaultYn() {
        return defaultYn;
    }

    public void setDefaultYn(String defaultYn) {
        this.defaultYn = defaultYn;
    }

    @Override
    public String toString() {
        return "QualityGate{" +
                "id=" + id +
                ", uuid='" + uuid + '\'' +
                ", name='" + name + '\'' +
                ", orgName='" + orgName + '\'' +
                ", orgGuid='" + orgGuid + '\'' +
                ", userName='" + userName + '\'' +
                ", userGuid='" + userGuid + '\'' +
                ", projectIdList=" + projectIdList +
                ", created='" + created + '\'' +
                ", lastModified='" + lastModified + '\'' +
                ", createdString='" + createdString + '\'' +
                ", lastModifiedString='" + lastModifiedString + '\'' +
                ", resultStatus='" + resultStatus + '\'' +
                ", resultMessage='" + resultMessage + '\'' +
                ", serviceInstancesId='" + serviceInstancesId + '\'' +
                ", conditions=" + conditions +
                ", gateId='" + gateId + '\'' +
                ", metric='" + metric + '\'' +
                ", error='" + error + '\'' +
                ", warning='" + warning + '\'' +
                ", op='" + op + '\'' +
                ", metrics=" + metrics +
                ", linked=" + linked +
                ", qualitygates=" + qualitygates +
                ", defaultKey='" + defaultKey + '\'' +
                ", defaultYn='" + defaultYn + '\'' +
                ", domains=" + domains +
                '}';
    }
}
