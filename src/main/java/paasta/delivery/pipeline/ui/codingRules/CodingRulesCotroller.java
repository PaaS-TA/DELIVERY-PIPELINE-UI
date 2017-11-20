package paasta.delivery.pipeline.ui.codingRules;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfileService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * The type Coding rules cotroller.
 */
@RestController
@RequestMapping(value="/dashboard/{serviceInstancesId}")
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
     * Gets coding rules list.
     *
     * @param qprofile  the qprofile
     * @param languages the languages
     * @param facets    the facets
     * @return the coding rules list
     */
    @GetMapping(value = {BASE_URL+"/codingRules.do"})
    @ResponseBody
    public CodingRules getCodingRulesList(@RequestParam(value = "qprofile", required = true) String qprofile,
                                          @RequestParam(value = "languages", required = false) String languages,
                                          @RequestParam(value = "facets", required = true) String facets) {
        return codingRulesService.getCodingRuleList(qprofile, languages, facets);
    }


    //TODO -------------------------------------------

    /**
     * CodingRules 리스트 페이지
     *
     * @param httpServletRequest the http servlet request
     * @param codingRules        the coding rules
     * @return List model and view
     */
    @RequestMapping(value = BASE_URL+"/dashboard", method = RequestMethod.GET)
    public ModelAndView getCodingRulesListPage(HttpServletRequest httpServletRequest, @ModelAttribute CodingRules codingRules){
        ModelAndView mv = new ModelAndView();
        mv.addObject("codingRules", codingRules);
        //공통 serviceInstancesId 셋팅하기
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/codingRulesList", mv);
    }

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
     * CodingRules 검색 조건
     *
     * @param
     * @return List map
     */
    @RequestMapping(value={BASE_URL+"/codingRulesCondition.do"}, method = RequestMethod.GET)
        public  Map getCodingRulesCondition(){
        return codingRulesService.getCodingRulesCondition();
    }


    /**
     *  CodingRules 프로파일명 검색
     *
     * @param
     * @return Map
     */
    @RequestMapping(value = BASE_URL+"/qualityProfileList.do", method = RequestMethod.GET)
    @ResponseBody
    public List getQualityProfileList(@PathVariable String serviceInstancesId){
        return qualityProfileService.getQualityProfileList(serviceInstancesId);
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

    /**
     * CodingRules 프로파일 추가
     *
     * @param codingRules the coding rules
     * @return coding rules
     */
    @RequestMapping(value = BASE_URL+"/codingRulesProfileAdd.do", method = RequestMethod.POST)
    @ResponseBody
    public CodingRules createCodingRulesProfile(@RequestBody CodingRules codingRules){
        return codingRulesService.createCodingRulesProfile(codingRules);
    }


    /**
     * CodingRules 프로파일 제거
     *
     * @param codingRules the coding rules
     * @return coding rules
     */
    @RequestMapping(value = BASE_URL+"/codingRulesProfileDelete.do", method = RequestMethod.POST)
    @ResponseBody
    public CodingRules deleteCodingRulesProfile(@RequestBody CodingRules codingRules){
        return codingRulesService.deleteCodingRulesProfile(codingRules);
    }


    /**
     * CodingRules 프로파일 변경
     *
     * @param codingRules the coding rules
     * @return coding rules
     */
    @RequestMapping(value = BASE_URL+"/codingRulesProfileUpdate.do" ,method = RequestMethod.POST)
    @ResponseBody
    public CodingRules updateCodingRulesProfile(@RequestBody CodingRules codingRules){
        return codingRulesService.updateCodingRulesProfile(codingRules);
    }


}
