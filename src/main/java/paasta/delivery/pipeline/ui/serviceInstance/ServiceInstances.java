package paasta.delivery.pipeline.ui.serviceInstance;

/**
 * Created by hrjin on 2017-05-29.
 */
public class ServiceInstances {
    private String id;
    private String resultStatus;
    private String resultMessage;
    private String serviceInstancesId;
    private String owner;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    @Override
    public String toString() {
        return "ServiceInstances{" +
                "id='" + id + '\'' +
                ", resultStatus='" + resultStatus + '\'' +
                ", resultMessage='" + resultMessage + '\'' +
                ", serviceInstancesId='" + serviceInstancesId + '\'' +
                ", owner='" + owner + '\'' +
                '}';
    }
}
