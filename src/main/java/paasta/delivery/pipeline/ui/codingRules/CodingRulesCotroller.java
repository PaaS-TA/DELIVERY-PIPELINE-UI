package paasta.delivery.pipeline.ui.codingRules;

import org.omg.Messaging.SYNC_WITH_TRANSPORT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfile;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfileService;


import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value="/dashboard/{serviceInstancesId}")
public class CodingRulesCotroller {
    private static final String BASE_URL = "/codingRules";
    private final CommonService commonService;
    private final CodingRulesService codingRulesService;
    private final QualityProfileService qualityProfileService;

    @Autowired
    public CodingRulesCotroller(CommonService commonService, CodingRulesService codingRulesService, QualityProfileService qualityProfileService){
        this.commonService = commonService;
        this.codingRulesService = codingRulesService;
        this.qualityProfileService = qualityProfileService;
    }


    /**
     *  CodingRules 리스트 페이지
     *
     * @param
     * @return List
     */
    @RequestMapping(value = BASE_URL+"/dashboard", method = RequestMethod.GET)
    public ModelAndView getCodingRulesListPage(HttpServletRequest httpServletRequest, @ModelAttribute CodingRules codingRules){
        ModelAndView mv = new ModelAndView();
        mv.addObject("codingRules", codingRules);
        //공통 serviceInstancesId 셋팅하기
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/codingRulesList", mv);
    }

    /**
     *  CodingRules detail 페이지
     *
     * @param
     * @return List
     */
    @RequestMapping(value = BASE_URL+"/codingRulesDetail", method = RequestMethod.GET)
    public ModelAndView getCodingRulesDetaliPage(HttpServletRequest httpServletRequest,@ModelAttribute CodingRules codingRules){
        ModelAndView mv = new ModelAndView();
        mv.addObject("codingRules", codingRules);
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/codingRulesDetail", mv);

    }




    /**
     *  CodingRules 리스트
     *
     * @param
     * @return Map
     */
    @RequestMapping(value = {BASE_URL+"/codingRulesList.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CodingRules getCodingRulesList(@RequestBody CodingRules codingRules) {
        return codingRulesService.getCodingRulesList(codingRules);
    }

    /**
     *  CodingRules 검색 조건
     *
     * @param
     * @return List
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
     *  CodingRules 상세 페이지
     *
     * @param
     * @return List
     */
    @RequestMapping(value = {BASE_URL+"/codingRulesDeteil.do"}, method = RequestMethod.GET)
    @ResponseBody
    public Map getCodingRulesDeteil(@ModelAttribute CodingRules codingRues){
       
        Map<String,Object> list = codingRulesService.getCodingRulesDeteil(codingRues);
        return list;
    }

    /**
     *  CodingRules 프로파일 추가
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/codingRulesProfileAdd.do", method = RequestMethod.POST)
    @ResponseBody
    public CodingRules createCodingRulesProfile(@RequestBody CodingRules codingRules){
        return codingRulesService.createCodingRulesProfile(codingRules);
    }


    /**
     *  CodingRules 프로파일 제거
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/codingRulesProfileDelete.do", method = RequestMethod.POST)
    @ResponseBody
    public CodingRules deleteCodingRulesProfile(@RequestBody CodingRules codingRules){
        return codingRulesService.deleteCodingRulesProfile(codingRules);
    }


    /**
     *  CodingRules 프로파일 변경
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/codingRulesProfileUpdate.do" ,method = RequestMethod.POST)
    @ResponseBody
    public CodingRules updateCodingRulesProfile(@RequestBody CodingRules codingRules){
        return codingRulesService.updateCodingRulesProfile(codingRules);
    }


}
