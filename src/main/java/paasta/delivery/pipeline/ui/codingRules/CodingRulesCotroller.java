package paasta.delivery.pipeline.ui.codingRules;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfile;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfileService;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * The type Coding rules cotroller.
 */
@RestController
@RequestMapping(value="/dashboard/{serviceInstanceId}")
public class CodingRulesCotroller {

    private static final Logger LOGGER = LoggerFactory.getLogger(CodingRulesCotroller.class);

    private static final String BASE_URL = "/codingRules";

    @Autowired
    private CodingRulesService codingRulesService;
    @Autowired
    private CommonService commonService;
    @Autowired
    private QualityProfileService qualityProfileService;

    /**
     * Get coding rules list page model and view.
     *
     * @param httpServletRequest the http servlet request
     * @param serviceInstanceId  the service instance id
     * @return the model and view
     */
    @GetMapping(value = BASE_URL + "/dashboard")
    public ModelAndView getCodingRulesListPage(HttpServletRequest httpServletRequest, @PathVariable String serviceInstanceId){
        ModelAndView mv = new ModelAndView();

        // ------- Coding Rules Default Search condition
        CodingRules codingRules = new CodingRules();
        // 1-based page number
        codingRules.setP(1);
        // Page size. Must be greater than 0 and less than 500
        codingRules.setPs(15);
        // Comma-separated list of the facets to be computed. No facet is computed by default.
        codingRules.setFacets("languages,severities");
        // Comma-separated list of the fields to be returned in response.
        codingRules.setF("name,lang,langName,sysTags,tags,status,severity");
        // Sort field : name, updatedAt, createdAt, key
        codingRules.setS("name");
        // Ascending sort : true(default), false, yes, no
        codingRules.setAsc("true");
        // Comma-separated list of languages :: 현재 java 만 지원하므로 java 설정
        codingRules.setLanguages("java");

        CodingRules data = codingRulesService.getCodingRules(codingRules);

        ((List)data.getFacets()).forEach(e -> {
            if ("languages".equals((String)((Map)e).get("property"))) {
                // 개발 언어 목록 + Count
                mv.addObject("languages", ((Map)e).get("values"));
            }
            if ("severities".equals((String)((Map)e).get("property"))) {
                // 이슈 수준 + Count
                mv.addObject("severities", ((List)((Map)e).get("values")).stream()
                        .collect(Collectors.toMap(s -> (((Map)s).get("val")), s -> ((Map)s).get("count"))));
            }
        });
        data.setCondition(codingRules);
        // 전체 Coding Rules
        mv.addObject("rules", data.getRules());
        mv.addObject("codingRules", data);

        // 품질 프로파일 목록
        QualityProfile param = new QualityProfile();
        param.setServiceInstanceId(serviceInstanceId);
        // 현재 java 만 지원
        param.setLanguage("java");

        mv.addObject("qualityProfiles", qualityProfileService.getQualityProfileList(param));

        //공통 serviceInstanceId 셋팅하기
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/codingRulesList", mv);
    }


    /**
     * Gets coding rules.
     *
     * @param codingRules the coding rules
     * @return the coding rules
     */
    @GetMapping(value=BASE_URL + "/codingRules.do")
    @ResponseBody
    public Map getCodingRules(@ModelAttribute CodingRules codingRules) {

        // 기본 parameter 설정
        codingRules.setF("name,lang,langName,severity,severity");
        codingRules.setFacets("languages,severities");

        Map result = new HashMap();

        CodingRules data = codingRulesService.getCodingRules(codingRules);

        ((List)data.getFacets()).forEach(e -> {
            if ("languages".equals((String)((Map)e).get("property"))) {
                // 개발 언어 목록 + Count
                result.put("languages", ((Map)e).get("values"));
            }
            if ("severities".equals((String)((Map)e).get("property"))) {
                // 이슈 수준 + Count
                result.put("severities", ((List)((Map)e).get("values")).stream()
                        .collect(Collectors.toMap(s -> (((Map)s).get("val")), s -> ((Map)s).get("count"))));
            }
        });

        data.setCondition(codingRules);
        // 전체 Coding Rules
        result.put("rules", data.getRules());
        result.put("codingRules", data);

        // 품질 프로파일 목록
        return result;

    }

    /**
     * Activate rule quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    @PostMapping(value=BASE_URL + "/activateRule.do")
    @ResponseBody
    public QualityProfile activateRule (@RequestBody QualityProfile qualityProfile) {

        return qualityProfileService.activateRule(qualityProfile);

    }

    /**
     * Deactivate rule quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    @PostMapping(value=BASE_URL + "/deactivateRule.do")
    @ResponseBody
    public QualityProfile deactivateRule (@RequestBody QualityProfile qualityProfile) {

        return qualityProfileService.deactivateRule(qualityProfile);

    }

    /**
     * Get quality profile list list.
     *
     * @param serviceInstanceId the service instance id
     * @return the list
     */
    @GetMapping(value = BASE_URL + "/qualityProfileList.do")
    @ResponseBody
    public List getQualityProfileList(@PathVariable String serviceInstanceId){

        // 프로파일 조회
        QualityProfile param = new QualityProfile();
        param.setServiceInstanceId(serviceInstanceId);
        // 현재 java 만 지원
        param.setLanguage("java");

        List result = qualityProfileService.getQualityProfileList(param);

        return result;

    }


        //TODO -------------------------------------------



    /**
     * CodingRules detail 페이지
     *
     * @param httpServletRequest the http servlet request
     * @param codingRules        the coding rules
     * @return List model and view
     */
    @RequestMapping(value = BASE_URL+"/codingRulesDetail", method = RequestMethod.GET)
    public ModelAndView getCodingRulesDetaliPage(HttpServletRequest httpServletRequest,@ModelAttribute CodingRules codingRules){
        ModelAndView mv = new ModelAndView();
        mv.addObject("codingRules", codingRules);
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/codingRulesDetail", mv);

    }


    /**
     * CodingRules 상세 페이지
     *
     * @param codingRues the coding rues
     * @return List map
     */
    @RequestMapping(value = {BASE_URL+"/codingRulesDeteil.do"}, method = RequestMethod.GET)
    @ResponseBody
    public Map getCodingRulesDeteil(@ModelAttribute CodingRules codingRues){
       
        Map<String,Object> list = codingRulesService.getCodingRulesDeteil(codingRues);
        return list;
    }


}
