package paasta.delivery.pipeline.ui.projectRelation;

/**
 * Created by hrjin on 2017-06-29.
 */
public class ProjectRelation {

    private Long id; // projectId 와 동일.
    private Long qualityProfileId;
    private Long qualityGateId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getQualityProfileId() {
        return qualityProfileId;
    }

    public void setQualityProfileId(Long qualityProfileId) {
        this.qualityProfileId = qualityProfileId;
    }

    public Long getQualityGateId() {
        return qualityGateId;
    }

    public void setQualityGateId(Long qualityGateId) {
        this.qualityGateId = qualityGateId;
    }

    @Override
    public String toString() {
        return "ProjectRelation{" +
                "id=" + id +
                ", qualityProfileId=" + qualityProfileId +
                ", qualityGateId=" + qualityGateId +
                '}';
    }
}
