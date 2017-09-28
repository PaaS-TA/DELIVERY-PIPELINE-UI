package paasta.delivery.pipeline.ui.qualityProfile;

import java.util.List;

/**
 * Created by hrjin on 2017-06-29.
 */
public class QualityProfile {
    private Long id;
    private String name;
    private String language;
    private String languageName;
    private String sonarKey;
    private String key;
    private List<Long> projectIdList;
    private String defaultYn;

    private int activeRuleCount;

    private int activeDeprecatedRuleCount;

    private String serviceInstancesId;

    //코딩룰 리스트
    private String qprofile;
    private String activation;
    private String facets;

    //프로파일 복제
    private String fromKey;
    private String toName;

    //프로파일 삭제
    private String profileKey;
    private String qualityProfileId;

    //언어 리스트
    private List languages;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getLanguageName() {
        return languageName;
    }

    public void setLanguageName(String languageName) {
        this.languageName = languageName;
    }

    public List<Long> getProjectIdList() {
        return projectIdList;
    }

    public void setProjectIdList(List<Long> projectIdList) {
        this.projectIdList = projectIdList;
    }

    public int getActiveRuleCount() {
        return activeRuleCount;
    }

    public void setActiveRuleCount(int activeRuleCount) {
        this.activeRuleCount = activeRuleCount;
    }

    public int getActiveDeprecatedRuleCount() {
        return activeDeprecatedRuleCount;
    }

    public void setActiveDeprecatedRuleCount(int activeDeprecatedRuleCount) {
        this.activeDeprecatedRuleCount = activeDeprecatedRuleCount;
    }

    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
    }

    public String getSonarKey() {
        return sonarKey;
    }

    public void setSonarKey(String sonarKey) {
        this.sonarKey = sonarKey;
    }

    public String getFromKey() {
        return fromKey;
    }

    public void setFromKey(String fromKey) {
        this.fromKey = fromKey;
    }

    public String getToName() {
        return toName;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getProfileKey() {
        return profileKey;
    }

    public void setProfileKey(String profileKey) {
        this.profileKey = profileKey;
    }

    public List getLanguages() {
        return languages;
    }

    public void setLanguages(List languages) {
        this.languages = languages;
    }

    public String getQprofile() {
        return qprofile;
    }

    public void setQprofile(String qprofile) {
        this.qprofile = qprofile;
    }

    public String getActivation() {
        return activation;
    }

    public void setActivation(String activation) {
        this.activation = activation;
    }

    public String getFacets() {
        return facets;
    }

    public void setFacets(String facets) {
        this.facets = facets;
    }

    public String getQualityProfileId() {
        return qualityProfileId;
    }

    public void setQualityProfileId(String qualityProfileId) {
        this.qualityProfileId = qualityProfileId;
    }

    public String getDefaultYn() {
        return defaultYn;
    }

    public void setDefaultYn(String defaultYn) {
        this.defaultYn = defaultYn;
    }

    @Override
    public String toString() {
        return "QualityProfile{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", language='" + language + '\'' +
                ", languageName='" + languageName + '\'' +
                ", sonarKey='" + sonarKey + '\'' +
                ", key='" + key + '\'' +
                ", projectIdList=" + projectIdList +
                ", defaultYn='" + defaultYn + '\'' +
                ", activeRuleCount=" + activeRuleCount +
                ", activeDeprecatedRuleCount=" + activeDeprecatedRuleCount +
                ", serviceInstancesId='" + serviceInstancesId + '\'' +
                ", qprofile='" + qprofile + '\'' +
                ", activation='" + activation + '\'' +
                ", facets='" + facets + '\'' +
                ", fromKey='" + fromKey + '\'' +
                ", toName='" + toName + '\'' +
                ", profileKey='" + profileKey + '\'' +
                ", qualityProfileId='" + qualityProfileId + '\'' +
                ", languages=" + languages +
                '}';
    }
}
