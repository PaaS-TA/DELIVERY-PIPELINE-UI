package paasta.delivery.pipeline.ui.qualityIssues;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;

/**
 * Created by kim on 2017-08-10.
 */
@Service
public class QualityIssuesService {

    private static final String REQ_URL_Inspection = "/qualityIssues";

    private static final String REQ_URL_Common = "/qualityIssues";

    private final RestTemplateService restTemplateService;

    @Autowired
    public QualityIssuesService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }


    /**
     *  QualityIssues 리스트
     *
     * @param
     * @return QualityIssues
     */
    public QualityIssues qualityIssuesList(QualityIssues qualityIssues){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityIssuesList", HttpMethod.POST, qualityIssues, QualityIssues.class);
    }

    /**
     *  QualityIssues 조건리스트
     *
     * @param
     * @return QualityIssues
     */
    public List<QualityIssues> getIssuesConditionList(QualityIssues qualityIssues){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/issuesConditionList", HttpMethod.POST, qualityIssues, List.class);
    }

    /**
     *  QualityIssues 상세
     *
     * @param
     * @return QualityIssues
     */
    public List getQualityIssuesDetail(QualityIssues qualityIssues){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityIssuesDetail?fileKey="+qualityIssues.getFileKey()+"&fileUuid="+qualityIssues.getFileUuid(), HttpMethod.GET, null, List.class);
    }


    /**
     *  QualityIssues 이슈 설정
     *
     * @param qualityIssues
     * @return QualityIssues
     */
    public Object setSeverity(QualityIssues qualityIssues){
      return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/setSeverity", HttpMethod.POST, qualityIssues, Object.class);
    }

    /**
     *  QualityIssues 이슈 활성 설정
     *
     * @param qualityIssues
     * @return QualityIssues
     */
    public QualityIssues setTransition(QualityIssues qualityIssues){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/setTransition", HttpMethod.POST, qualityIssues, QualityIssues.class);
    }

}
