package paasta.delivery.pipeline.ui.cf.info;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cfInfo
 *
 * @author REX
 * @version 1.0
 * @since 7/25/2017
 */
public class CfInfo {

    private long id;
    private String serviceInstancesId;
    private String cfName;
    private String cfId;
    private String cfPassword;
    private String cfApiUrl;
    private String description;
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

    public String getCfName() {
        return cfName;
    }

    public void setCfName(String cfName) {
        this.cfName = cfName;
    }

    public String getCfId() {
        return cfId;
    }

    public void setCfId(String cfId) {
        this.cfId = cfId;
    }

    public String getCfPassword() {
        return cfPassword;
    }

    public void setCfPassword(String cfPassword) {
        this.cfPassword = cfPassword;
    }

    public String getCfApiUrl() {
        return cfApiUrl;
    }

    public void setCfApiUrl(String cfApiUrl) {
        this.cfApiUrl = cfApiUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
        return "CfInfo{" +
                "id=" + id +
                ", serviceInstancesId='" + serviceInstancesId + '\'' +
                ", cfName='" + cfName + '\'' +
                ", cfId='" + cfId + '\'' +
                ", cfApiUrl='" + cfApiUrl + '\'' +
                ", description='" + description + '\'' +
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
