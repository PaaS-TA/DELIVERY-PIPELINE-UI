package paasta.delivery.pipeline.ui.codingRules;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfile;

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
     * Gets coding rules.
     *
     * @param codingRules the coding rules
     * @return the coding rules
     */
    public CodingRules getCodingRules(CodingRules codingRules) {

        String reqUrl = restTemplateService.makeQueryParam(REQ_URL_Inspection, codingRules);

        return restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.GET, null, CodingRules.class);
    }



    //TODO -------------------------------------------


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

    //TODO --- 문선임 쓰고 있음
    /**
     *  CodingRules 검색 조건
     *
     * @param
     * @return List
     */
    public Map getCodingRulesCondition(){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/condition", HttpMethod.GET, null, Map.class);
    }

}
