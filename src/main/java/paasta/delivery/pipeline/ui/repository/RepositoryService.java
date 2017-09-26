package paasta.delivery.pipeline.ui.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.job.Job;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.repository
 *
 * @author REX
 * @version 1.0
 * @since 5 /29/2017
 */
@Service
public class RepositoryService {

    private static final String SCM_API_URL = "/api/rest/repositories";
    private static final String GIT_HUB_API_URL = "https://api.github.com/repos";
    private static final String SEARCH_SCM_GIT_STRING = "/git/";
    private static final String SEARCH_SCM_SVN_STRING = "/svn/";
    private static final String SEARCH_GIT_HUB_STRING = "https://github.com";
    private static final String SEARCH_BRANCHES_STRING = "/branches";

    private final RestTemplateService restTemplateService;


    /**
     * Instantiates a new Repository service.
     *
     * @param restTemplateService the rest template service
     */
    @Autowired
    public RepositoryService(RestTemplateService restTemplateService) {this.restTemplateService = restTemplateService;}


    /**
     * Gets repository branch list.
     *
     * @param job the custom job
     * @return the repository branch list
     */
    Job getRepositoryInfo(Job job) {
        Job resultModel = new Job();
        resultModel.setResultStatus(Constants.RESULT_STATUS_FAIL);

        String repositoryType = job.getRepositoryType();

        // CHECK REPOSITORY TYPE
        if (String.valueOf(RepositoryType.GIT_HUB).equals(repositoryType)) {
            resultModel = procGetGitHubRepositoryInfo(job);
        } else {
            resultModel = procGetScmRepositoryInfo(job);
        }

        resultModel.setRepositoryType(repositoryType);
        resultModel.setRepositoryUrl(job.getRepositoryUrl());
        resultModel.setRepositoryAccountId(job.getRepositoryAccountId());

        return resultModel;
    }


    private Job procGetGitHubRepositoryInfo(Job job) {
        Job resultModel = new Job();
        String reqRepositoryUrl = job.getRepositoryUrl();

        String repositoryUrl;
        String reqRepositoryBranchListUrl;
        List<String> resultList = new ArrayList<>();

        if (reqRepositoryUrl.contains(SEARCH_GIT_HUB_STRING)) {
            repositoryUrl = reqRepositoryUrl.substring(SEARCH_GIT_HUB_STRING.length(), reqRepositoryUrl.length() - 4);
            reqRepositoryBranchListUrl = GIT_HUB_API_URL + repositoryUrl + SEARCH_BRANCHES_STRING;

            // CUSTOM REST SEND :: GET BRANCH LIST
            for (Object aRepositoryList : procGetGitHubRepositoryBranchList(job, reqRepositoryBranchListUrl)) {
                Map tempMap = (Map) aRepositoryList;
                resultList.add(tempMap.get("name").toString());
            }

            resultModel.setRepositoryId(repositoryUrl);
            resultModel.setRepositoryBranchList(resultList);
            resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);
        }

        return resultModel;
    }


    private List procGetGitHubRepositoryBranchList(Job job, String reqRepositoryBranchListUrl) {
        // CUSTOM REST SEND :: GET BRANCH LIST
        return restTemplateService.customSend(reqRepositoryBranchListUrl, HttpMethod.GET, null, List.class, job);
    }


    private Job procGetScmRepositoryInfo(Job job) {
        Job resultModel = new Job();
        String reqRepositoryUrl = job.getRepositoryUrl();
        String repositoryType = job.getRepositoryType();

        // SEARCH :: GIT
        if (String.valueOf(RepositoryType.SCM_GIT).equals(repositoryType) && reqRepositoryUrl.contains(SEARCH_SCM_GIT_STRING)) {
            resultModel = procGetScmGitRepositoryInfo(job);
        }

        // SEARCH :: SVN
        if (String.valueOf(RepositoryType.SCM_SVN).equals(repositoryType) && reqRepositoryUrl.contains(SEARCH_SCM_SVN_STRING)) {
            resultModel = procGetScmSvnRepositoryInfo(job);
        }

        return resultModel;
    }


    private Job procGetScmGitRepositoryInfo(Job job) {
        Job resultModel = new Job();
        List<String> resultList = new ArrayList<>();
        String repositoryId;

        // CUSTOM REST SEND :: GET ID
        repositoryId = procGetScmRepositoryId(job);
        job.setRepositoryId(repositoryId);

        // CUSTOM REST SEND :: GET BRANCH LIST
        for (LinkedHashMap aRepositoryBranchList : procGetScmGitRepositoryBranchList(job, procGetScmRepositoryUrl(job, UrlType.GET_BRANCH_LIST))) {
            resultList.add(String.valueOf(aRepositoryBranchList.get("name")));
        }

        resultModel.setRepositoryId(repositoryId);
        resultModel.setRepositoryBranchList(resultList);
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);

        return resultModel;
    }


    private String procGetScmRepositoryId(Job job) {
        String resultString;
        LinkedHashMap repositoryDetailMap;

        // CUSTOM REST SEND :: GET ID
        repositoryDetailMap = restTemplateService.customSend(procGetScmRepositoryUrl(job, UrlType.GET_DETAIL), HttpMethod.GET, null, LinkedHashMap.class, job);
        resultString = repositoryDetailMap.get("id").toString();

        return resultString;
    }


    private String procGetScmRepositoryUrl(Job job, Enum reqUrlType) {
        String resultString = null;
        String reqRepositoryUrl = job.getRepositoryUrl();
        String searchString = SEARCH_SCM_GIT_STRING;
        String repositoryId = job.getRepositoryId();
        String repositoryName;

        if (String.valueOf(RepositoryType.SCM_SVN).equals(job.getRepositoryType())) {
            searchString = SEARCH_SCM_SVN_STRING;
        }

        // SEARCH
        int searchResult = reqRepositoryUrl.indexOf(searchString);
        String repositoryUrl = reqRepositoryUrl.substring(0, searchResult);

        // FOR GETTING ID
        if (UrlType.GET_DETAIL.equals(reqUrlType)) {
            repositoryName = reqRepositoryUrl.substring(searchResult + searchString.length());
            resultString = repositoryUrl + SCM_API_URL + searchString + repositoryName;
        }

        // FOR GETTING BRANCH LIST
        if (UrlType.GET_BRANCH_LIST.equals(reqUrlType)) {
            resultString = repositoryUrl + SCM_API_URL + "/" + repositoryId + SEARCH_BRANCHES_STRING;
        }

        return resultString;
    }


    private List<LinkedHashMap> procGetScmGitRepositoryBranchList(Job job, String reqRepositoryBranchListUrl) {
        List<LinkedHashMap> resultList;

        // CUSTOM REST SEND :: GET BRANCH LIST
        LinkedHashMap tempResultMap = restTemplateService.customSend(reqRepositoryBranchListUrl, HttpMethod.GET, null, LinkedHashMap.class, job);
        resultList = (List<LinkedHashMap>) tempResultMap.get("branch");

        return resultList;
    }


    private Job procGetScmSvnRepositoryInfo(Job job) {
        Job resultModel = new Job();

        // CUSTOM REST SEND :: GET ID
        resultModel.setRepositoryId(procGetScmRepositoryId(job));
        resultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);

        return resultModel;
    }


    /**
     * The enum Repository Type.
     */
    enum RepositoryType {
        /**
         * Scm git repository type.
         */
        SCM_GIT,
        /**
         * Scm svn repository type.
         */
        SCM_SVN,
        /**
         * Git hub repository type.
         */
        GIT_HUB;
    }

    /**
     * The enum Url type.
     */
    enum UrlType {
        /**
         * Get detail url type.
         */
        GET_DETAIL,
        /**
         * Get branch list url type.
         */
        GET_BRANCH_LIST;
    }

}
