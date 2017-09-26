package paasta.delivery.pipeline.ui.codingRules;

import java.util.List;

public class CodingRules {
    private Long id;
    private String key;
    private String severities;
    private String languages;
    private String ps;
    private String p;

    //룰 총 개수
    private String total;


    //프로파일 id
    private String qprofile;
    //프로파일 검색 상태(프로파일 true 여야만 룰 리스트 검색 가능)
    private String activation;

    private String serviceInstancesId;
    //룰 검색 키워드
    private String q;
    //룰 리스트 sort
    private String s;
    //룰 리스트
    private List rules;
    //이슈 체크리스트
    private String issues;
    //검색 키워드
    private String keyword;

    //룰 상세 프로파일 연결 확인
    private String actives;

    //룰과 프로파일 연결
    private String rule_key;
    private String profile_key;
    private String severity;

    //룰에대한 프로파일 이슈 변경
    private Boolean reset;
    //프로파일 이슈개수 목록
    private String facets;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getSeverities() {
        return severities;
    }

    public void setSeverities(String severities) {
        this.severities = severities;
    }

    public String getLanguages() {
        return languages;
    }

    public void setLanguages(String languages) {
        this.languages = languages;
    }

    public String getP() {
        return p;
    }

    public void setP(String p) {
        this.p = p;
    }

    public String getPs() {
        return ps;
    }

    public void setPs(String ps) {
        this.ps = ps;
    }

    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
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

    public String getQ() {
        return q;
    }

    public void setQ(String q) {
        this.q = q;
    }

    public String getS() {
        return s;
    }

    public void setS(String s) {
        this.s = s;
    }

    public List getRules() {
        return rules;
    }

    public void setRules(List rules) {
        this.rules = rules;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getIssues() {
        return issues;
    }

    public void setIssues(String issues) {
        this.issues = issues;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getRule_key() {
        return rule_key;
    }

    public void setRule_key(String rule_key) {
        this.rule_key = rule_key;
    }

    public String getProfile_key() {
        return profile_key;
    }

    public void setProfile_key(String profile_key) {
        this.profile_key = profile_key;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public String getActives() {
        return actives;
    }

    public void setActives(String actives) {
        this.actives = actives;
    }

    public String getFacets() {
        return facets;
    }

    public void setFacets(String facets) {
        this.facets = facets;
    }

    @Override
    public String toString() {
        return "CodingRules{" +
                "id=" + id +
                ", key='" + key + '\'' +
                ", severities='" + severities + '\'' +
                ", languages='" + languages + '\'' +
                ", ps='" + ps + '\'' +
                ", p='" + p + '\'' +
                ", total='" + total + '\'' +
                ", qprofile='" + qprofile + '\'' +
                ", activation='" + activation + '\'' +
                ", serviceInstancesId='" + serviceInstancesId + '\'' +
                ", q='" + q + '\'' +
                ", s='" + s + '\'' +
                ", rules=" + rules +
                ", issues='" + issues + '\'' +
                ", keyword='" + keyword + '\'' +
                ", actives='" + actives + '\'' +
                ", rule_key='" + rule_key + '\'' +
                ", profile_key='" + profile_key + '\'' +
                ", severity='" + severity + '\'' +
                ", reset=" + reset +
                ", facets='" + facets + '\'' +
                '}';
    }

    public Boolean getReset() {
        return reset;
    }

    public void setReset(Boolean reset) {
        this.reset = reset;
    }


}
