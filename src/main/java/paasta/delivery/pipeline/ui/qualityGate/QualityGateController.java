package paasta.delivery.pipeline.ui.qualityGate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.project.Project;
import paasta.delivery.pipeline.ui.project.ProjectService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by hrjin on 2017-06-29.
 */
@RestController
@RequestMapping(value = "/dashboard/{serviceInstancesId}")
public class QualityGateController {
    private static final String BASE_URL = "/qualityGate";
    private final QualityGateService qualityGateService;
    private final ProjectService projectService;
    private final CommonService commonService;

    @Autowired
    public QualityGateController(QualityGateService qualityGateService,  ProjectService projectService, CommonService commonService) {
        this.projectService = projectService;
        this.qualityGateService = qualityGateService;
        this.commonService = commonService;
    }

    /**
     *  QualityGate 목록 페이지
     *
     * @return
     */
    @RequestMapping(value = BASE_URL + "/dashboard", method = RequestMethod.GET)
    public ModelAndView QualityGateListPage(HttpServletRequest httpServletRequest){

        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/qualityGateList", new ModelAndView());
    }

    /**
     *  QualityGate 상세 페이지
     *
     * @param id
     * @return
     */
    @RequestMapping(value = BASE_URL + "/detail/{id}", method = RequestMethod.GET)
    public ModelAndView QualityGatePage(@PathVariable Long id){
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", id);
        mv.setViewName(BASE_URL + "/qualityGateDetail");
        return mv;
    }

    /**
     *  QualityGate 등록 페이지
     *
     * @return
     */
    @RequestMapping(value = BASE_URL + "/create", method = RequestMethod.GET)
    public ModelAndView CreateQualityGatePage(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName(BASE_URL + "/qualityGateCreate");
        return mv;
    }

    /**
     *  QualityGate 수정 페이지
     *
     * @param id
     * @return
     */
    @RequestMapping(value = BASE_URL + "/update/{id}", method = RequestMethod.GET)
    public ModelAndView updateQualityGatePage(@PathVariable Long id){
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", id);
        mv.addObject("list", qualityGateService.getQualityGate(id));
        mv.setViewName(BASE_URL + "/qualityGateUpdate");
        return mv;
    }


    /**
     *  QualityGate 상세 조회 execute
     *
     * @param qualityGate
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityGateDetail.do", method = RequestMethod.POST)
    public QualityGate getQualityGate(@RequestBody QualityGate qualityGate){
        return qualityGateService.getQualityGate(qualityGate.getId());
    }









    /////////////////////////////////////////////////////////////////


//    @RequestMapping(value = BASE_URL + "/qualityGateList.do", method = RequestMethod.GET)
//    public List<QualityGate> getQualityGateList(@PathVariable String serviceInstancesId){
//        return qualityGateService.getQualityGateList(serviceInstancesId);
//    }
    /**
     *  QualityGate 목록 조회
     *
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityGateList.do", method = RequestMethod.GET)
    public List getQualityGateList(@RequestParam String  serviceInstancesId){
        return qualityGateService.getQualityGateList(serviceInstancesId);
    }


    /**
     *  QualityGate 조건 옵션조회
     *
     * @param
     * @return QualityGate
     */
    @RequestMapping(value = BASE_URL+"/metricsList.do", method = RequestMethod.GET)
    public List getMetricsList(){
        return qualityGateService.getMetricsList();
    }


    /**
     *  QualityGate 조건 목록
     *
     * @param id
     * @return
     */
    @RequestMapping(value= BASE_URL + "/qualityGateCondition.do", method = RequestMethod.GET)
    public  QualityGate getQualityGateCondition(@RequestParam Long id){
        return qualityGateService.getQualityGateCondition(id);
    }


    /**
     *  project 목록 조회
     *
     * @param project
     * @return
     */
    @RequestMapping(value =  BASE_URL+"/projectsList", method = RequestMethod.POST)
    public List<Project> getGateProjectList(@RequestBody Project project){
        return projectService.getProjectList(project);
    }


    /**
     *  QualityGate condition 저장
     *
     * @param
     * @return
     */
    @RequestMapping(value= BASE_URL+"/qualityGateCondSave.do", method = RequestMethod.POST)
    public QualityGate createQualityGateCond(@RequestBody QualityGate qualityGate){
        return qualityGateService.createQualityGateCond(qualityGate);
    }

    /**
     *  QualityGate condition 수정
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityGateCondUpdate.do" , method = RequestMethod.POST)
    public QualityGate updateQualityGateCond(@RequestBody QualityGate qualityGate){
        return qualityGateService.updateQualityGateCond(qualityGate);
    }


    /**
     *  QualityGate condition 삭제
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityGateCondDelete.do",method = RequestMethod.POST)
    @ResponseBody
    public QualityGate deleteQualityGateCond(@RequestBody String id){
        return qualityGateService.deleteQualityGateCond(id);
    }


    /**
     *  QualityGate 복제
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityGateCopy.do",method = RequestMethod.POST)
    @ResponseBody
    public QualityGate copyQualityGate(@RequestBody QualityGate qualityGate){
        return qualityGateService.copyQualityGate(qualityGate);

    }

    /**
     *  QualityGate 생성 execute
     *
     * @param qualityGate
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityGateCreate.do", method = RequestMethod.POST)
    public QualityGate createQualityGate(@RequestBody QualityGate qualityGate){
        return qualityGateService.createQualityGate(qualityGate);
    }

    /**
     *  QualityGate 수정 execute
     *
     * @param qualityGate
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityGateUpdate.do", method = RequestMethod.POST)
    public QualityGate updateQualityGate(@RequestBody QualityGate qualityGate){
        return qualityGateService.updateQualityGate(qualityGate);
    }


    /**
     *  QualityGate 삭제 execute
     *
     * @param qualityGate
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityGateDelete.do", method = RequestMethod.POST)
    @ResponseBody
    public QualityGate deleteQualityGate(@RequestBody QualityGate qualityGate){
        return qualityGateService.deleteQualityGate(qualityGate);
    }



    /**
     *  QualityGate project 연결
     *
     * @param project
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityGateProjectLiked.do" , method = RequestMethod.POST)
    @ResponseBody
    public Project qualityGateProjectLiked(@RequestBody Project project){
        return projectService.qualityGateProjectLiked(project);
    }

    /**
     *  QualityGate default setting
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityGateDefaultSetting.do", method = RequestMethod.POST)
    public QualityGate qualityGateDefaultSetting(@RequestBody QualityGate qualityGate){
        return qualityGateService.qualityGateDefaultSetting(qualityGate);
    }
}
