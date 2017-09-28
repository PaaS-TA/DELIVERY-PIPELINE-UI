package paasta.delivery.pipeline.ui.qualityProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.codingRules.CodingRules;
import paasta.delivery.pipeline.ui.codingRules.CodingRulesService;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.project.Project;
import paasta.delivery.pipeline.ui.project.ProjectService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by kim on 2017-07-31.
 */
@RestController
@RequestMapping(value = "/dashboard/{serviceInstancesId}")
public class QualityProfileController {

    private static final String BASE_URL = "/qualityProfile";

    private final QualityProfileService  qualityProfileService;

    private final CodingRulesService codingRulesService;

    private final ProjectService projectService;

    private final CommonService commonService;

    @Autowired
    public QualityProfileController(CommonService commonService, QualityProfileService qualityProfileService
            , CodingRulesService codingRulesService
            , ProjectService projectService){
        this.qualityProfileService = qualityProfileService;
        this.commonService = commonService;
        this.codingRulesService = codingRulesService;
        this.projectService = projectService;
    }

    /**
     *  QualityProfile 목록 페이지
     *
     * @return
     */
    @RequestMapping(value = BASE_URL +"/dashboard", method = RequestMethod.GET)
    public ModelAndView getQualityProfileListPage(HttpServletRequest httpServletRequest){
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/qualityProfileList", new ModelAndView());
    }

    /**
     *  QualityProfile 리스트
     *
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityProfileList.do", method = RequestMethod.GET)
    public List getQualityProfileList(@PathVariable String serviceInstancesId){
        return qualityProfileService.getQualityProfileList(serviceInstancesId);
    }

    /**
     *  QualityProfile 코딩룰 리스트
     *
     * @return
     */
    @RequestMapping(value = BASE_URL + "/codingRulesList.do" , method = RequestMethod.POST)
    public List getCodingRulesList(@RequestBody QualityProfile qualityProfile){
        return qualityProfileService.getCodingRulesList(qualityProfile);
    }


    //시연후 수정
    @RequestMapping(value= BASE_URL + "/projectsList.do" , method = RequestMethod.POST)
    @ResponseBody
    public List<Project> getProjectList(@RequestBody Project project){
        return projectService.getProjectList(project);
    }

    /**
     *  QualityProfile 프로젝트 연결
     *
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityProfileProjectLinked.do" , method = RequestMethod.POST)
    public Project qualityProfileProjectLiked(@RequestBody Project project){
        return projectService.qualityProfileProjectLinked(project);
    }


    /**
     *  QualityProfile 복제
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityProfileCopy.do", method = RequestMethod.POST)
    @ResponseBody
    public QualityProfile qualityProfileCopy(@RequestBody QualityProfile qualityProfile){
        return qualityProfileService.qualityProfileCopy(qualityProfile);
    }

    /**
     *  QualityProfile 삭제
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityProfileDelete.do", method = RequestMethod.POST)
    @ResponseBody
    public QualityProfile deleteQualityProfile(@RequestBody QualityProfile qualityProfile){
        return qualityProfileService.deleteQualityProfile(qualityProfile);
    }

    /**
     *  QualityProfile 수정
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityProfileUpdate.do", method = RequestMethod.POST)
    @ResponseBody
    public QualityProfile updateQualityProfile(@RequestBody QualityProfile qualityProfile){
        return qualityProfileService.updateQualityProfile(qualityProfile);
    }

    /**
     *  QualityProfile 언어List
     *
     * @param
     * @return
     */
    @RequestMapping(value=BASE_URL+"/qualityProfileLangList.do",method = RequestMethod.GET)
    @ResponseBody
    public QualityProfile qualityProfileLangList(){
        return qualityProfileService.qualityProfileLangList();
    }


    /**
     *  QualityProfile 생성
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityProfileCreate.do",method = RequestMethod.POST)
    @ResponseBody
    public QualityProfile createQualityProfile(@RequestBody QualityProfile qualityProfile){
        return qualityProfileService.qualityProfileCreate(qualityProfile);
    }

    /**
     *  QualityProfile default setting
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityProfileDefaultSetting.do", method = RequestMethod.POST)
    public QualityProfile defaultQualityProfile(@RequestBody QualityProfile qualityProfile){
        return qualityProfileService.defaultQualityProfile(qualityProfile);
    }


}
