package paasta.delivery.pipeline.ui.cf.url;

public class CfUrl {

    private long id;
    private String serviceInstancesId;
    private String cfApiName;
    private String cfApiUrl;
    private String userId;
    private String resultStatus;
    private String resultMessage;
    private String created;
    private String lastModified;
    private String createdString;
    private String lastModifiedString;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
    }

    public String getCfApiName() {
        return cfApiName;
    }

    public void setCfApiName(String cfApiName) {
        this.cfApiName = cfApiName;
    }

    public String getCfApiUrl() {
        return cfApiUrl;
    }

    public void setCfApiUrl(String cfApiUrl) {
        this.cfApiUrl = cfApiUrl;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    @Override
    public String toString() {
        return "CfApi{" +
                "id=" + id +
                ", serviceInstancesId='" + serviceInstancesId + '\'' +
                ", cfApiName='" + cfApiName + '\'' +
                ", cfApiUrl='" + cfApiUrl + '\'' +
                ", userId='" + userId + '\'' +
                ", resultStatus='" + resultStatus + '\'' +
                ", resultMessage='" + resultMessage + '\'' +
                ", created='" + created + '\'' +
                ", lastModified='" + lastModified + '\'' +
                ", createdString='" + createdString + '\'' +
                ", lastModifiedString='" + lastModifiedString + '\'' +
                '}';
    }

}
