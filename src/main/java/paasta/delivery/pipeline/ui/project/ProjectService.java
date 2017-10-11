package paasta.delivery.pipeline.ui.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.List;
import java.util.Map;

/**
 * Created by kim on 2017-08-01.
 */
@Service
public class ProjectService {

    private static final String REQ_URL_Inspection = "/projects";
    private static final String REQ_URL_Common = "/project";

    private final RestTemplateService restTemplateService;

    @Autowired
    public ProjectService(RestTemplateService restTemplateService){
        this.restTemplateService = restTemplateService;
    }


    /**
     * project 리스트
     *
     * @param
     * @return Project
     */
    public List getProjectList(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/projectList", HttpMethod.POST, project, List.class);
    }

    /**
     * pipelineId에 속한 project
     *
     * @param
     * @return Project
     */
    public List getProject(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/getProject", HttpMethod.POST, project, List.class);
    }



    /**
     * project create
     *
     * @param project
     * @return Project
     */
    public Project createProjects(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/projectsCreate", HttpMethod.POST, project, Project.class);
    }

    /**
     * project delete
     *
     * @param project
     * @return Project
     */
    public Project deleteProjects(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/projectsDelete", HttpMethod.POST, project, Project.class);
    }

    /**
     *  project update
     *
     * @param  project
     * @return project
     */
    public Project updateProjects(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/projectsUpdate", HttpMethod.POST, project, Project.class);
    }



    /**
     *  qualityGate Linked
     *
     * @param  project
     * @return project
     */
    public Project qualityGateProjectLiked(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/qualityGateProjectLiked", HttpMethod.POST, project, Project.class );
    }

    /**
     *  qualityProfile Linked
     *
     * @param  project
     * @return project
     */
    public Project qualityProfileProjectLinked(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/qualityProfileProjectLinked", HttpMethod.POST, project, Project.class );
    }

    ///////////////////////////////////

    /**
     *  getProject sonarKey(uuid)
     *
     * @param
     * @return List
     */
    public List getProjectSonarKey(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/getProjectSonarKey?projectKey="+project.getProjectKey(), HttpMethod.GET, null, List.class );
    }

    /**
     *  quality Management
     *
     * @param  project
     * @return project
     */
    public Project qualityManagementList(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/qualityManagementList?uuid="+project.getUuid(), HttpMethod.GET, null, Project.class );
    }

    /**
     *  quality coverage
     *
     * @param  project
     * @return project
     */
    public List<Project> qualityCoverageList(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/qualityCoverageList?resource="+project.getResource(), HttpMethod.GET, null, List.class );
    }

    /**
     *  tests source
     *
     * @param  project
     * @return List
     */
    public List testsSourceList(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/testsSource?projectKey="+project.getProjectKey()+"&metrics="+project.getMetrics(), HttpMethod.GET, null, List.class );
    }

    /**
     *  tests source
     *
     * @param  project
     * @return Project
     */
    public Project testsSourceShow(Project project){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API,REQ_URL_Inspection+"/testsSourceShow?key="+project.getKey()+"&uuid="+project.getUuid(), HttpMethod.GET, null, Project.class );
    }

}
