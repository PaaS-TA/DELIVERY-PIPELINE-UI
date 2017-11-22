package paasta.delivery.pipeline.ui.qualityProfile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.codingRules.CodingRules;
import paasta.delivery.pipeline.ui.codingRules.CodingRulesService;
import paasta.delivery.pipeline.ui.common.CommonService;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * The type Quality profile controller.
 */
@RestController
@RequestMapping(value = "/dashboard/{serviceInstanceId}")
public class QualityProfileController {

    private static final Logger LOGGER = LoggerFactory.getLogger(QualityProfileController.class);

    private static final String BASE_URL = "/qualityProfile";

    @Autowired
    private QualityProfileService  qualityProfileService;

    @Autowired
    private CodingRulesService codingRulesService;

    @Autowired
    private CommonService commonService;

    /**
     * Get quality profile list page model and view.
     *
     * @param httpServletRequest the http servlet request
     * @param serviceInstanceId  the service instance id
     * @return the model and view
     */
    @GetMapping(value = BASE_URL +"/dashboard")
    public ModelAndView getQualityProfileListPage(HttpServletRequest httpServletRequest, @PathVariable String serviceInstanceId){

        ModelAndView mv = new ModelAndView();
        mv.addObject("serviceInstanceId", serviceInstanceId);
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/qualityProfileList", mv);
    }

    /**
     * QualityProfile 리스트
     *
     * @param serviceInstanceId the service instances id
     * @return map map
     */
    @GetMapping(value = BASE_URL + "/qualityProfileList.do")
    @ResponseBody
    public Map getQualityProfileList(@PathVariable String serviceInstanceId){

        Map result = new HashMap<>();
        QualityProfile param = new QualityProfile();

        // 개발 언어 조회
        List languages = qualityProfileService.getQualityProfileLanguages();
        // 프로파일 조회
        param.setServiceInstanceId(serviceInstanceId);
        List profiles = qualityProfileService.getQualityProfileList(param);

        result.put("languages", languages);
        result.put("profiles", profiles);

        LOGGER.info("===[UI - INSPECTION :: getQualityProfileList]=== result : {}", result.toString());

        return result;

    }

    /**
     * Get quality profile language list list.
     *
     * @return the list
     */
    @GetMapping(value = BASE_URL + "/qualityProfileLanguageList.do")
    @ResponseBody
    public List getQualityProfileLanguageList(){

        List languages = qualityProfileService.getQualityProfileLanguages();

        LOGGER.info("===[UI - INSPECTION :: getQualityProfileLanguageList]=== result : {}", languages.toString());

        return languages;

    }

    /**
     * Get coding rules coding rules.
     *
     * @param codingRules the coding rules
     * @return the coding rules
     */
    @GetMapping(value = BASE_URL + "/codingRules.do")
    @ResponseBody
    public CodingRules getCodingRules(@ModelAttribute CodingRules codingRules){

        // 기본 설정 값
        codingRules.setFacets("active_severities");
        codingRules.setActivation("true");

        CodingRules result = codingRulesService.getCodingRules(codingRules);

        return result;

    }

    /**
     * Gets projects.
     *
     * @param key      the key
     * @param selected the selected
     * @return the projects
     */
    @GetMapping(value = BASE_URL + "/projects.do")
    @ResponseBody
    public QualityProfile getProjects(@RequestParam(value = "key", required = true) String key,
                                      @RequestParam(value = "selected", required = false) String selected){

        LOGGER.info("===[UI - INSPECTION :: getProjects]=== key : {}, selected {}", key, selected);

        return qualityProfileService.getProjects(key, selected);


    }

    /**
     * Quality profile create quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    @PostMapping(value = BASE_URL + "/qualityProfileCreate.do")
    @ResponseBody
    public QualityProfile createQualityProfile(@RequestBody QualityProfile qualityProfile){

        QualityProfile result = qualityProfileService.createQualityProfile(qualityProfile);

        LOGGER.info("===[UI - INSPECTION :: qualityProfileCreate]=== result : {}", result.toString());

        return result;

    }

    /**
     * Copy quality profile quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    @PostMapping(value = BASE_URL + "/qualityProfileCopy.do")
    @ResponseBody
    public QualityProfile copyQualityProfile(@RequestBody QualityProfile qualityProfile){

        QualityProfile result = qualityProfileService.copyQualityProfile(qualityProfile);

        LOGGER.info("===[UI - INSPECTION :: qualityProfileCopy]=== result : {}", result.toString());

        return result;

    }

    /**
     * Update quality profile quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    @PostMapping(value = BASE_URL + "/qualityProfileUpdate.do")
    @ResponseBody
    public QualityProfile updateQualityProfile(@RequestBody QualityProfile qualityProfile){

        QualityProfile result = qualityProfileService.updateQualityProfile(qualityProfile);

        LOGGER.info("===[UI - INSPECTION :: updateQualityProfile]=== result : {}", result.toString());

        return result;

    }

    /**
     * Delete quality profile quality profile.
     *
     * @param qualityProfile the quality profile
     * @return the quality profile
     */
    @PostMapping(value = BASE_URL + "/qualityProfileDelete.do")
    @ResponseBody
    public QualityProfile deleteQualityProfile(@RequestBody QualityProfile qualityProfile){

        QualityProfile result = qualityProfileService.deleteQualityProfile(qualityProfile);

        return result;

    }




    //TODO---------------------------------------
    // 프로젝트 연결 / 해제
    // API :: paasta.delivery.pipeline.inspection.api.project
    //## REQUEST PARAMETERS
    //- (Required) id
    //- (Required or Null) qualityProfileKey
    //- (Required or Null) qualityGateId
    //- (Required) linkOperationType
    //- (Optional, for UNLINK) defaultQualityProfileKey
    //- (Optional, for UNLINK) defaultQualityGateId
    //## RETURN OBJECT
    //- Project Model

}
