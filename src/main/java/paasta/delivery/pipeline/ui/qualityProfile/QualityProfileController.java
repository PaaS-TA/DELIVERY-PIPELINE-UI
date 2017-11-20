package paasta.delivery.pipeline.ui.qualityProfile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.common.CommonService;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * The type Quality profile controller.
 */
@RestController
@RequestMapping(value = "/dashboard/{serviceInstancesId}")
public class QualityProfileController {

    private static final Logger LOGGER = LoggerFactory.getLogger(QualityProfileController.class);

    private static final String BASE_URL = "/qualityProfile";

    @Autowired
    private QualityProfileService  qualityProfileService;

    @Autowired
    private CommonService commonService;

    /**
     * Get quality profile list page model and view.
     *
     * @param httpServletRequest the http servlet request
     * @return the model and view
     */
    @GetMapping(value = BASE_URL +"/dashboard")
    public ModelAndView getQualityProfileListPage(HttpServletRequest httpServletRequest){

        ModelAndView mv = new ModelAndView();
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/qualityProfileList", mv);
    }

    /**
     * QualityProfile 리스트
     *
     * @param serviceInstancesId the service instances id
     * @return map
     */
    @GetMapping(value = BASE_URL + "/qualityProfileList.do")
    @ResponseBody
    public Map getQualityProfileList(@PathVariable String serviceInstancesId){

        Map result = new HashMap<>();

        // 개발 언어 조회
        List languages = qualityProfileService.getQualityProfileLanguages();
        // 프로파일 조회
        List profiles = qualityProfileService.getQualityProfileList(serviceInstancesId);

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
    public QualityProfile qualityProfileCreate(@RequestBody QualityProfile qualityProfile){

        QualityProfile result = qualityProfileService.qualityProfileCreate(qualityProfile);

        LOGGER.info("===[UI - INSPECTION :: qualityProfileCreate]=== result : {}", result.toString());

        return result;

    }

    //TODO---------------------------------------
//    //시연후 수정
//    @RequestMapping(value= BASE_URL + "/projectsList.do" , method = RequestMethod.POST)
//    @ResponseBody
//    public List<Project> getProjectList(@RequestBody Project project){
//        return projectService.getProjectList(project);
//    }
//
//    /**
//     *  QualityProfile 프로젝트 연결
//     *
//     * @return
//     */
//    @RequestMapping(value = BASE_URL + "/qualityProfileProjectLinked.do" , method = RequestMethod.POST)
//    public Project qualityProfileProjectLiked(@RequestBody Project project){
//        return projectService.qualityProfileProjectLinked(project);
//    }
//
//
//    /**
//     *  QualityProfile 복제
//     *
//     * @param
//     * @return
//     */
//    @RequestMapping(value = BASE_URL+"/qualityProfileCopy.do", method = RequestMethod.POST)
//    @ResponseBody
//    public QualityProfile qualityProfileCopy(@RequestBody QualityProfile qualityProfile){
//        return qualityProfileService.qualityProfileCopy(qualityProfile);
//    }
//
//    /**
//     *  QualityProfile 삭제
//     *
//     * @param
//     * @return
//     */
//    @RequestMapping(value = BASE_URL+"/qualityProfileDelete.do", method = RequestMethod.POST)
//    @ResponseBody
//    public QualityProfile deleteQualityProfile(@RequestBody QualityProfile qualityProfile){
//        return qualityProfileService.deleteQualityProfile(qualityProfile);
//    }
//
//    /**
//     *  QualityProfile 수정
//     *
//     * @param
//     * @return
//     */
//    @RequestMapping(value = BASE_URL+"/qualityProfileUpdate.do", method = RequestMethod.POST)
//    @ResponseBody
//    public QualityProfile updateQualityProfile(@RequestBody QualityProfile qualityProfile){
//        return qualityProfileService.updateQualityProfile(qualityProfile);
//    }
//
//    /**
//     *  QualityProfile default setting
//     *
//     * @param
//     * @return
//     */
//    @RequestMapping(value = BASE_URL+"/qualityProfileDefaultSetting.do", method = RequestMethod.POST)
//    public QualityProfile defaultQualityProfile(@RequestBody QualityProfile qualityProfile){
//        return qualityProfileService.defaultQualityProfile(qualityProfile);
//    }


}
