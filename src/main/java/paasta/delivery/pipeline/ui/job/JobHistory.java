package paasta.delivery.pipeline.ui.job;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.job
 *
 * @author REX
 * @version 1.0
 * @since 5/22/2017
 */
public class JobHistory {

    // DATABASE COLUMNS
    private long id;
    private long jobId;
    private int previousJobNumber;
    private int jobNumber;
    private long duration;
    private String status;
    private long fileId;
    private String triggerType;
    private String userId;
    private String created;
    private String lastModified;

    // UI
    private String createdString;
    private String lastModifiedString;
    private String previousJobName;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getJobId() {
        return jobId;
    }

    public void setJobId(long jobId) {
        this.jobId = jobId;
    }

    public int getPreviousJobNumber() {
        return previousJobNumber;
    }

    public void setPreviousJobNumber(int previousJobNumber) {
        this.previousJobNumber = previousJobNumber;
    }

    public int getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(int jobNumber) {
        this.jobNumber = jobNumber;
    }

    public long getDuration() {
        return duration;
    }

    public void setDuration(long duration) {
        this.duration = duration;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public long getFileId() {
        return fileId;
    }

    public void setFileId(long fileId) {
        this.fileId = fileId;
    }

    public String getTriggerType() {
        return triggerType;
    }

    public void setTriggerType(String triggerType) {
        this.triggerType = triggerType;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    public String getPreviousJobName() {
        return previousJobName;
    }

    public void setPreviousJobName(String previousJobName) {
        this.previousJobName = previousJobName;
    }

    @Override
    public String toString() {
        return "JobHistory{" +
                "id=" + id +
                ", jobId=" + jobId +
                ", previousJobNumber=" + previousJobNumber +
                ", jobNumber=" + jobNumber +
                ", duration=" + duration +
                ", status='" + status + '\'' +
                ", fileId=" + fileId +
                ", triggerType='" + triggerType + '\'' +
                ", userId='" + userId + '\'' +
                ", created='" + created + '\'' +
                ", lastModified='" + lastModified + '\'' +
                ", createdString='" + createdString + '\'' +
                ", lastModifiedString='" + lastModifiedString + '\'' +
                ", previousJobName='" + previousJobName + '\'' +
                '}';
    }

}
