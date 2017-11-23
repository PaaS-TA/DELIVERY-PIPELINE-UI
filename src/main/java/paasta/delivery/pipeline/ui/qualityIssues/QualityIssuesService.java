package paasta.delivery.pipeline.ui.qualityIssues;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfileService;

import java.util.List;

/**
 * Created by kim on 2017-08-10.
 */
@Service
public class QualityIssuesService {

    private static final String REQ_URL_Inspection = "/qualityIssues";

    private static final String REQ_URL_Common = "/qualityIssues";

    private final RestTemplateService restTemplateService;

    private final QualityProfileService qualityProfileService;

    @Autowired
    public QualityIssuesService(RestTemplateService restTemplateService,QualityProfileService qualityProfileService) {
        this.restTemplateService = restTemplateService;
        this.qualityProfileService = qualityProfileService;
    }


    /**
     * QualityIssues 리스트
     *
     * @param
     * @return QualityIssues
     */
    public QualityIssues qualityIssuesList(QualityIssues qualityIssues) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection + "/qualityIssuesList", HttpMethod.POST, qualityIssues, QualityIssues.class);
    }

    /**
     * QualityIssues 조건리스트
     *
     * @param
     * @return QualityIssues
     */
    public List<QualityIssues> getIssuesConditionList(QualityIssues qualityIssues) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection + "/issuesConditionList", HttpMethod.POST, qualityIssues, List.class);
    }

    /**
     * QualityIssues 상세
     *
     * @param
     * @return QualityIssues
     */
    public List getQualityIssuesDetail(QualityIssues qualityIssues) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection + "/qualityIssuesDetail?fileKey=" + qualityIssues.getFileKey() + "&fileUuid=" + qualityIssues.getFileUuid() + "&serviceInstancesId=" + qualityIssues.getServiceInstancesId(), HttpMethod.GET, null, List.class);
    }


    /**
     * QualityIssues 이슈 설정
     *
     * @param qualityIssues
     * @return QualityIssues
     */
    public Object setSeverity(QualityIssues qualityIssues) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection + "/setSeverity", HttpMethod.POST, qualityIssues, Object.class);
    }

    /**
     * QualityIssues 이슈 활성 설정
     *
     * @param qualityIssues
     * @return QualityIssues
     */
    public QualityIssues setTransition(QualityIssues qualityIssues) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection + "/setTransition", HttpMethod.POST, qualityIssues, QualityIssues.class);
    }



    /**
     * QualityIssues 검색조건 언어설정
     *
     * @param
     * @return QualityIssues
     */
    public List getLanguge() {
        return qualityProfileService.getQualityProfileLanguages();
    }
}
