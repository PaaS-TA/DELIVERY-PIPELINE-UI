package paasta.delivery.pipeline.ui.qualityProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;
import java.util.Map;

/**
 * Created by kim on 2017-07-31.
 */
@Service
public class QualityProfileService {
    private static final String REQ_URL_Inspection = "/qualityProfile";

    private static final String REQ_URL_Common = "/qualityProfile";

    private final RestTemplateService restTemplateService;

    @Autowired
    public QualityProfileService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }


    /**
     *  QualityPrifile 리스트
     *
     * @param
     * @return List
     */
    public List getQualityProfileList(){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileList", HttpMethod.GET, null, List.class);
    }

    /**
     *  QualityPrifile 복제
     *
     * @param
     * @return List
     */
    public QualityProfile qualityProfileCopy(QualityProfile qualityProfile){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileCopy", HttpMethod.POST, qualityProfile, QualityProfile.class);
    }

    /**
     *  QualityPrifile 삭제
     *
     * @param
     * @return
     */
    public QualityProfile deleteQualityProfile(QualityProfile qualityProfile){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileDelete", HttpMethod.POST, qualityProfile, QualityProfile.class);
    }

    /**
     *  QualityPrifile 수정
     *
     * @param
     * @return List
     */
    public QualityProfile updateQualityProfile(QualityProfile qualityProfile){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileUpdae", HttpMethod.POST, qualityProfile, QualityProfile.class);
    }

    /**
     *  QualityPrifile 언어 리스트
     *
     * @param
     * @return List
     */
    public QualityProfile qualityProfileLangList(){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileLangList", HttpMethod.GET, null, QualityProfile.class);
    }

    /**
     *  QualityPrifile 생성
     *
     * @param
     * @return List
     */
    public QualityProfile qualityProfileCreate(QualityProfile qualityProfile){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileCreate", HttpMethod.POST, qualityProfile, QualityProfile.class);
    }

    /**
     *  QualityProfile default setting
     *
     * @param
     * @return
     */
    public QualityProfile defaultQualityProfile(QualityProfile qualityProfile){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/qualityProfileDefault", HttpMethod.POST,qualityProfile,QualityProfile.class);
    }


    /**
     *  QualityProfile codingRules
     *
     * @param qualityProfile
     * @return list
     */
    public List getCodingRulesList(QualityProfile qualityProfile){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/codingRulesList",HttpMethod.POST,qualityProfile,List.class);
    }

}
