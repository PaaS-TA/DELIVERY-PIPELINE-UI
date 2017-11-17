package paasta.delivery.pipeline.ui.project;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.common.CommonService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * Created by kim on 2017-08-01.
 */
@RestController
@RequestMapping(value = "/dashboard/{serviceInstancesId}")
public class ProjectController {
    private final ProjectService projectService;
    private static final String BASE_URL = "/projects";
    private static final String COVERAGE_URL = "/coverage";
    private final CommonService commonService;
    private final Logger LOGGER = getLogger(getClass());

    @Autowired
    ProjectController(CommonService commonService, ProjectService projectService) {
        this.commonService = commonService;
        this.projectService = projectService;
    }

    @RequestMapping(value = BASE_URL + "/dashboard", method = RequestMethod.GET)
    public ModelAndView getProjectTest(HttpServletRequest httpServletRequest) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName(BASE_URL + "/testProject");
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/testProject", mv);
    }


    /**
     * quality management
     *
     * @param
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/{projectKey}/dashboard", method = RequestMethod.GET)
    public ModelAndView getProjectPage(HttpServletRequest httpServletRequest, @PathVariable String projectKey) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("projectKey", projectKey);
        mv.setViewName(BASE_URL + "/projectList");
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/projectList", mv);
    }


    /**
     * lineOfCode
     *
     * @param
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/{projectKey}/" + COVERAGE_URL + "/{sourceView}", method = RequestMethod.GET)
    public ModelAndView getLineOfCodePage(HttpServletRequest httpServletRequest, @PathVariable String projectKey, @PathVariable String sourceView) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("projectKey", projectKey);
        mv.addObject("sourceCode", sourceView);
        mv.setViewName(BASE_URL + COVERAGE_URL + "/testsSource");
        return commonService.setPathVariables(httpServletRequest, BASE_URL + "/testsSource", mv);
    }


    /**
     * project 리스트
     *
     * @param
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/projectsList.do", method = RequestMethod.POST)
    public List getProjectList(@RequestBody Project project) {
        return projectService.getProjectList(project);
    }

    /**
     * getProject
     * <p>
     * serviceInstancesId
     * pipelineId
     *
     * @param project
     * @return Project
     */
    @RequestMapping(value = {BASE_URL + "/getProject.do"}, method = RequestMethod.POST)
    public List getProject(@RequestBody Project project) {
        return projectService.getProject(project);
    }


    /**
     * project create
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/projectsCreate.do", method = RequestMethod.POST)
    @ResponseBody
    public Project createProjects(@RequestBody Project project) {
        return projectService.createProjects(project);
    }


    /**
     * project delete
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/projectsDelete.do", method = RequestMethod.POST)
    @ResponseBody
    public Project deleteProjects(@RequestBody Project project) {
        return projectService.deleteProjects(project);
    }

    /**
     * project update
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/projectsUpdate.do", method = RequestMethod.POST)
    @ResponseBody
    public Project updateProjects(@RequestBody Project project) {
        return projectService.updateProjects(project);
    }


    /**
     * getProjectKey
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/projectsKey.do", method = RequestMethod.POST)
    public Project getProjectKey(@RequestBody Project project) {
        return projectService.getProjectKey(project);
    }


    @RequestMapping(value = BASE_URL + "/getProjectSonarKey.do", method = RequestMethod.GET)
    public List getProjectSonarKey(Project project) {
        return projectService.getProjectSonarKey(project);
    }

    /**
     * quality Management
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/qualityManagementList.do", method = RequestMethod.GET)
    public Project qualityManagementList(Project project) {
        return projectService.qualityManagementList(project);
    }

    /**
     * quality Coverage
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/qualityCoverageList.do", method = RequestMethod.GET)
    public List<Project> qualityCoverageList(@ModelAttribute Project project) {
        return projectService.qualityCoverageList(project);
    }


    /**
     * tests source fileList
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/testsSource.do", method = RequestMethod.GET)
    public List testsSourceList(@ModelAttribute Project project) {
        return projectService.testsSourceList(project);
    }

    /**
     * tests source Detail
     *
     * @param project
     * @return project
     */
    @RequestMapping(value = BASE_URL + "/testsSourceShow.do", method = RequestMethod.GET)
    public Project testsSourceShow(@ModelAttribute Project project) {
        return projectService.testsSourceShow(project);
    }


}
