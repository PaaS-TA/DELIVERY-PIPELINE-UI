package paasta.delivery.pipeline.ui.qualityProfile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;


/**
 * The type Quality profile service.
 */
@Service
public class QualityProfileService {

    private static final Logger LOGGER = LoggerFactory.getLogger(QualityProfileService.class);
    private static final String REQ_URL_Inspection = "/qualityProfile";

    @Autowired
    private RestTemplateService restTemplateService;

    /**
     * QualityPrifile 리스트
     *
     * @param serviceInstanceId the service instance id
     * @return List list
     */
    public List getQualityProfileList(String serviceInstanceId){

        // 프로파일 목록 조회
        String reqUrl = REQ_URL_Inspection + "/qualityProfileList?serviceInstanceId="+serviceInstanceId;
        LOGGER.info("===[UI :: QUALITYPROFILE :: getQualityProfileList - profile]=== reqUrl : {}", reqUrl);
        List profiles = restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.GET, null, List.class);

        return profiles;
    }

    /**
     * Get quality profile languages list.
     *
     * @return the list
     */
    public List getQualityProfileLanguages(){

        // 개발 언어 조회
        String reqUrl = REQ_URL_Inspection + "/qualityProfileLanguages";

        LOGGER.info("===[UI :: QUALITYPROFILE :: getQualityProfileLanguages]=== reqUrl : {}", reqUrl);
        List languages = restTemplateService.send(Constants.TARGET_INSPECTION_API,reqUrl, HttpMethod.GET, null, List.class);

        //result.put("languages",languages.stream().filter(e -> ((String)((Map)e).get("key")).toUpperCase().equals("JAVA")).collect(toList()) );

        return languages;

    }


    /**
     * Quality profile create quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    public QualityProfile createQualityProfile(QualityProfile qualityProfile) {

        // 품질 프로파일 생성
        String reqUrl = REQ_URL_Inspection + "/qualityProfileCreate";
        LOGGER.info("===[UI :: QUALITYPROFILE :: qualityProfileCreate]=== reqUrl : {}", reqUrl);
        QualityProfile result = restTemplateService.send(Constants.TARGET_INSPECTION_API,reqUrl, HttpMethod.POST, qualityProfile, QualityProfile.class);
        result.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return result;

    }

    /**
     * Gets projects.
     *
     * @param key      the key
     * @param selected the selected
     * @return the projects
     */
    public QualityProfile getProjects(String key, String selected) {

        String reqUrl = REQ_URL_Inspection + "/projects?key="+key + "&selected="+selected;
        QualityProfile result = restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.GET, null, QualityProfile.class);
        result.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return result;
    }

    /**
     * Copy quality profile quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    public QualityProfile copyQualityProfile(QualityProfile qualityProfile) {
        // 품질 프로파일 복제
        String reqUrl = REQ_URL_Inspection + "/qualityProfileCopy";
        LOGGER.info("===[UI :: QUALITYPROFILE :: qualityProfileCopy]=== reqUrl : {}", reqUrl);
        QualityProfile result = restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.POST, qualityProfile, QualityProfile.class);
        result.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        return result;
    }

    /**
     * Update quality profile quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    public QualityProfile updateQualityProfile(QualityProfile qualityProfile) {

        // 품질 프로파일 수정
        String reqUrl = REQ_URL_Inspection + "/qualityProfileUpdate";
        LOGGER.info("===[UI :: QUALITYPROFILE :: updateQualityProfile]=== reqUrl : {}", reqUrl);
        QualityProfile result = restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.POST, qualityProfile, QualityProfile.class);

        return result;
    }

    /**
     * Delete quality profile quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    public QualityProfile deleteQualityProfile(QualityProfile qualityProfile) {
        // 품질 프로파일 삭제
        String reqUrl = REQ_URL_Inspection + "/qualityProfileDelete";
        LOGGER.info("===[UI :: QUALITYPROFILE :: deleteQualityProfile]=== reqUrl : {}", reqUrl);
        QualityProfile result = restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.POST, qualityProfile, QualityProfile.class);

        //TODO :: 프로젝트 정보 (DB)에서 삭제 처리
        return result;
    }

    //TODO ---------------------------


//    /**
//     * QualityPrifile 복제
//     *
//     * @param qualityProfile the quality profile
//     * @return List quality profile
//     */
//    public QualityProfile qualityProfileCopy(QualityProfile qualityProfile){
//        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileCopy", HttpMethod.POST, qualityProfile, QualityProfile.class);
//    }
//
//    /**
//     * QualityPrifile 삭제
//     *
//     * @param qualityProfile the quality profile
//     * @return quality profile
//     */
//    public QualityProfile deleteQualityProfile(QualityProfile qualityProfile){
//        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileDelete", HttpMethod.POST, qualityProfile, QualityProfile.class);
//    }
//
//    /**
//     * QualityPrifile 수정
//     *
//     * @param qualityProfile the quality profile
//     * @return List quality profile
//     */
//    public QualityProfile updateQualityProfile(QualityProfile qualityProfile){
//        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection +"/qualityProfileUpdae", HttpMethod.POST, qualityProfile, QualityProfile.class);
//    }
//



}
