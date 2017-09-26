package paasta.delivery.pipeline.ui.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import paasta.delivery.pipeline.ui.job.Job;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.repository
 *
 * @author REX
 * @version 1.0
 * @since 5 /29/2017
 */
@Controller
@RequestMapping(value = "/dashboard/{suid}")
public class RepositoryController {

    private final RepositoryService repositoryService;


    /**
     * Instantiates a new Repository controller.
     *
     * @param repositoryService the repository service
     */
    @Autowired
    public RepositoryController(RepositoryService repositoryService) {this.repositoryService = repositoryService;}


    /**
     * Gets repository branch list.
     *
     * @param job the custom job
     * @return the repository branch list
     */
    @RequestMapping(value = {"/repository/branch/list.do"}, method = RequestMethod.POST)
    @ResponseBody
    public Job getRepositoryBranchList(@RequestBody Job job) {
        return repositoryService.getRepositoryInfo(job);
    }

}
