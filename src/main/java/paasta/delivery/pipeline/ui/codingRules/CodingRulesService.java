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

/**
 * The type Coding rules service.
 */
@Service
public class CodingRulesService {

    private static final String REQ_URL_Inspection = "/codingrules";
    private static final String REQ_URL_Common = "/qualityProfile";

    @Autowired
    private RestTemplateService restTemplateService;

    /**
     * Gets coding rule list.
     *
     * @param qprofile  the qprofile
     * @param languages the languages
     * @param facets    the facets
     * @return the coding rule list
     */
    public CodingRules getCodingRuleList(String qprofile, String languages, String facets) {
        String reqUrl = REQ_URL_Inspection + "?qprofile="+qprofile+"&languages="+languages+"&facets="+facets;
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.GET, null, CodingRules.class);
    }

    //TODO -------------------------------------------
    /**
     * CodingRules 검색 조건
     *
     * @param
     * @return List map
     */
    public Map getCodingRulesCondition(){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/condition", HttpMethod.GET, null, Map.class);
    }

    /**
     * CodingRules 프로파일명 검색
     *
     * @param serviceInstancesId the service instances id
     * @return List list
     */
    public List<QualityProfile> getQualityProfileList(String serviceInstancesId){

        return restTemplateService.send(Constants.TARGET_COMMON_API,REQ_URL_Common+"?serviceInstancesId="+serviceInstancesId,HttpMethod.GET,null,List.class);
    }


    /**
     * CodingRules 상세리스트
     *
     * @param codingRules the coding rules
     * @return List map
     */
    public Map getCodingRulesDeteil(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesDeteil?key="+codingRules.getKey()+"&actives="+codingRules.getActives(), HttpMethod.GET, codingRules, Map.class);
    }

    /**
     * CodingRules 프로파일 추가
     *
     * @param codingRules the coding rules
     * @return CodingRules coding rules
     */
    public CodingRules createCodingRulesProfile(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesProfileAdd", HttpMethod.POST, codingRules, CodingRules.class);
    }

    /**
     * CodingRules 프로파일 추가
     *
     * @param codingRules the coding rules
     * @return CodingRules coding rules
     */
    public CodingRules deleteCodingRulesProfile(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesProfileDelete", HttpMethod.POST, codingRules, CodingRules.class);
    }

    /**
     * CodingRules 프로파일 변경
     *
     * @param codingRules the coding rules
     * @return coding rules
     */
    public CodingRules updateCodingRulesProfile(CodingRules codingRules){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/codingRulesProfileUpdate", HttpMethod.POST, codingRules, CodingRules.class);
    }
}
