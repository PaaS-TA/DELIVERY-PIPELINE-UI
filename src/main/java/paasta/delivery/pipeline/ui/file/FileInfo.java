package paasta.delivery.pipeline.ui.file;

/**
 * Created by hrjin on 2017-06-13.
 */
public class FileInfo {
    private Long id;
    private String originalFileName;
    private String storedFileName;
    private String fileUrl;
    private String resultStatus;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

    public String getStoredFileName() {
        return storedFileName;
    }

    public void setStoredFileName(String storedFileName) {
        this.storedFileName = storedFileName;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getResultStatus() {
        return resultStatus;
    }

    public void setResultStatus(String resultStatus) {
        this.resultStatus = resultStatus;
    }

    @Override
    public String toString() {
        return "FileInfo{" +
                "id=" + id +
                ", originalFileName='" + originalFileName + '\'' +
                ", storedFileName='" + storedFileName + '\'' +
                ", fileUrl='" + fileUrl + '\'' +
                ", resultStatus='" + resultStatus + '\'' +
                '}';
    }
}
