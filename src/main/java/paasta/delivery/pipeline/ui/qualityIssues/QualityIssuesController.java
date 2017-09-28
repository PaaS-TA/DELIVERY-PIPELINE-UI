package paasta.delivery.pipeline.ui.qualityIssues;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.codingRules.CodingRulesService;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.project.Project;
import paasta.delivery.pipeline.ui.project.ProjectService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by kim on 2017-08-10.
 */
@RestController
@RequestMapping(value = "/dashboard/{serviceInstancesId}")
public class QualityIssuesController {

    private static final String BASE_URL = "/qualityIssues";
    private final QualityIssuesService qualityIssuesService;
    private final CommonService commonService;
    private final ProjectService projectService;
    private final CodingRulesService codingRulesService;

    @Autowired
    public QualityIssuesController(QualityIssuesService qualityIssuesService, CommonService commonService
            ,ProjectService projectService,CodingRulesService codingRulesService){
        this.qualityIssuesService = qualityIssuesService;
        this.commonService = commonService;
        this.projectService = projectService;
        this.codingRulesService = codingRulesService;
    }


    /**
     *  qualityIssues 페이지 이동
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL + "/dashboard", method = RequestMethod.GET)
    public ModelAndView qualityIssuesPage(HttpServletRequest httpServletRequest ){
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/qualityIssuesList", new ModelAndView());
    }


    /**
     *  qualityIssues 리스트
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL + "/qualityIssuesList.do", method = RequestMethod.POST)
    public QualityIssues qualityIssuesList(@RequestBody QualityIssues qualityIssues){
        return qualityIssuesService.qualityIssuesList(qualityIssues);
    }

    /**
     *  qualityIssues project 리스트
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL + "/issuesConditionList.do", method = RequestMethod.POST)
    public List<QualityIssues> getIssuesConditionList(@RequestBody QualityIssues qualityIssues ){
        return qualityIssuesService.getIssuesConditionList(qualityIssues);
    }

    /**
     *  qualityIssues project 리스트
     *
     * @param project
     * @return List
     */
    @RequestMapping(value = BASE_URL+"/projectList.do", method = RequestMethod.POST)
    public List getProjectList(@RequestBody Project project){
        return projectService.getProjectList(project);
    }



    /**
     *  qualityIssues language 리스트
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL +"/getLanguageList.do", method = RequestMethod.GET)
    public Map getLangguageList(){
        return codingRulesService.getCodingRulesCondition();
    }

    /**
     *  qualityIssues language 리스트
     *
     * @param
     * @return
     */
    @RequestMapping(value = BASE_URL+"/qualityIssuesDetail.do", method = RequestMethod.GET)
    public List getQualityIssuesDetail(QualityIssues qualityIssues){
        return qualityIssuesService.getQualityIssuesDetail(qualityIssues);
    }


}
