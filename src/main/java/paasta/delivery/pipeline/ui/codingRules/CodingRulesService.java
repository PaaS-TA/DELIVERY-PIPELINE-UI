package paasta.delivery.pipeline.ui.codingRules;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Service
public class CodingRulesService {

    private static final String REQ_URL_Inspection = "/codingrules";
    private static final String REQ_URL_Common = "/qualityProfile";
    private final RestTemplateService restTemplateService;

    @Autowired
    public CodingRulesService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     *  CodingRules 리스트
     *
     * @param
     * @return List
     */
    public CodingRules getCodingRulesList(CodingRules codingRules) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection, HttpMethod.POST, codingRules, CodingRules.class);
//        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"?severities="+codingRules.getSeverities()+"&languages="+codingRules.getLanguages(), HttpMethod.GET, null, Map.class);
    }

    /**
     *  CodingRules 검색 조건
     *
     * @param
     * @return List
     */
    public Map getCodingRulesCondition(){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/condition", HttpMethod.GET, null, Map.class);
    }

    /**
     *  CodingRules 프로파일명 검색
     *
     * @param
     * @return List
     */
    public List<QualityProfile> getQualityProfileList(String serviceInstancesId){

        return restTemplateService.send(Constants.TARGET_COMMON_API,REQ_URL_Common+"?serviceInstancesId="+serviceInstancesId,HttpMethod.GET,null,List.class);
    }


    /**
     *  CodingRules 상세리스트
     *
     * @param codingRules
     * @return List
     */
    public Map getCodingRulesDeteil(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesDeteil?key="+codingRules.getKey()+"&actives="+codingRules.getActives(), HttpMethod.GET, codingRules, Map.class);
    }

    /**
     *  CodingRules 프로파일 추가
     *
     * @param codingRules
     * @return CodingRules
     */
    public CodingRules createCodingRulesProfile(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesProfileAdd", HttpMethod.POST, codingRules, CodingRules.class);
    }

    /**
     *  CodingRules 프로파일 추가
     *
     * @param codingRules
     * @return CodingRules
     */
    public CodingRules deleteCodingRulesProfile(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesProfileDelete", HttpMethod.POST, codingRules, CodingRules.class);
    }

    /**
     *  CodingRules 프로파일 변경
     *
     * @param codingRules
     * @return
     */
    public CodingRules updateCodingRulesProfile(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesProfileUpdate", HttpMethod.POST, codingRules, CodingRules.class);
    }
}
