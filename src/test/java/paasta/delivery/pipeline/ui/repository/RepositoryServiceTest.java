package paasta.delivery.pipeline.ui.repository;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpMethod;
import org.springframework.test.context.junit4.SpringRunner;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.job.Job;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.repository
 *
 * @author REX
 * @version 1.0
 * @since 5 /30/2017
 */
@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class RepositoryServiceTest {

    private static final String SCM_API_URL = "/api/rest/repositories";
    private static final String GIT_HUB_API_URL = "https://api.github.com/repos";
    private static final String SEARCH_SCM_GIT_STRING = "/git/";
    //    private static final String SEARCH_SCM_SVN_STRING = "/svn/";
    private static final String SEARCH_GIT_HUB_STRING = "https://github.com";
    private static final String SEARCH_BRANCHES_STRING = "/branches";
    private static final String SEARCH_COMMIT_REVISION_STRING = "/changesets?limit=1&branch=";


    @Mock
    private RestTemplateService restTemplateService;

    @InjectMocks
    private RepositoryService repositoryService;


    /**
     * Sets up.
     *
     * @throws Exception the exception
     */
    @Before
    public void setUp() throws Exception {
    }


    /**
     * Tear down.
     *
     * @throws Exception the exception
     */
    @After
    public void tearDown() throws Exception {
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////// MethodName_StateUnderTest_ExpectedBehavior
    ////////////////////////////////////////////////////////////////////////////////////////////////////


    /**
     * Gets repository branch list valid model return model.
     *
     * @throws Exception the exception
     */
    @Test
    public void getRepositoryBranchList_ValidModel_ReturnModel() throws Exception {
        String testRepositoryUrl = "http://123.123.123.123:8080/scm/git/test-repository";
        String testRepositoryAccountId = "test-id";
        String testRepositoryAccountPassword = "test-password";
        String testRepositoryBranchName = "test-branch-name";

        Job testModel = new Job();
        testModel.setRepositoryType(String.valueOf(RepositoryType.SCM_GIT));
        testModel.setRepositoryUrl(testRepositoryUrl);
        testModel.setRepositoryAccountId(testRepositoryAccountId);
        testModel.setRepositoryAccountPassword(testRepositoryAccountPassword);

        String reqRepositoryUrl = testModel.getRepositoryUrl();
        int searchResult = reqRepositoryUrl.indexOf(SEARCH_SCM_GIT_STRING);
        String repositoryUrl = reqRepositoryUrl.substring(0, searchResult);
        String repositoryName = reqRepositoryUrl.substring(searchResult + SEARCH_SCM_GIT_STRING.length());
        String reqRepositoryDetailUrl = repositoryUrl + SCM_API_URL + SEARCH_SCM_GIT_STRING + repositoryName;

        Job testResultModel = new Job();
        testResultModel.setRepositoryType(testModel.getRepositoryType());
        testResultModel.setRepositoryUrl(testModel.getRepositoryUrl());
        testResultModel.setRepositoryAccountId(testModel.getRepositoryAccountId());
        testResultModel.setResultStatus(Constants.RESULT_STATUS_SUCCESS);

        LinkedHashMap repositoryDetailMap = new LinkedHashMap();
        repositoryDetailMap.put("id", "test-repository-id");

        when(restTemplateService.customSend(reqRepositoryDetailUrl, HttpMethod.GET, null, LinkedHashMap.class, testModel)).thenReturn(repositoryDetailMap);

        String repositoryId = repositoryDetailMap.get("id").toString();
        String reqRepositoryBranchListUrl = repositoryUrl + SCM_API_URL + "/" + repositoryId + SEARCH_BRANCHES_STRING;

        LinkedHashMap resultMap = new LinkedHashMap();
        List testList = new ArrayList();
        LinkedHashMap tempResultMap = new LinkedHashMap();
        tempResultMap.put("name", testRepositoryBranchName);
        testList.add(tempResultMap);
        resultMap.put("branch", testList);

        when(restTemplateService.customSend(reqRepositoryBranchListUrl, HttpMethod.GET, null, LinkedHashMap.class, testModel)).thenReturn(resultMap);

        LinkedHashMap resultCommitRevisionMap = new LinkedHashMap();
        ArrayList<LinkedHashMap> tempCommitRevisionList = new ArrayList<>();
        LinkedHashMap tempCommitRevisionMap = new LinkedHashMap();
        tempCommitRevisionMap.put("id", "test-commit-revision-id");
        tempCommitRevisionList.add(tempCommitRevisionMap);
        resultCommitRevisionMap.put("changesets", tempCommitRevisionList);

        String reqRepositoryCommitRevisionUrl = repositoryUrl + SCM_API_URL + "/" + repositoryId + SEARCH_COMMIT_REVISION_STRING;
        when(restTemplateService.customSend(reqRepositoryCommitRevisionUrl, HttpMethod.GET, null, LinkedHashMap.class, testModel)).thenReturn(resultCommitRevisionMap);


        // TEST
        Job resultModel = repositoryService.getRepositoryInfo(testModel);

        assertThat(resultModel).isNotNull();
        assertEquals(String.valueOf(RepositoryType.SCM_GIT), resultModel.getRepositoryType());
        assertEquals(testRepositoryUrl, resultModel.getRepositoryUrl());
        assertEquals(testRepositoryAccountId, resultModel.getRepositoryAccountId());
        assertThat(resultModel.getRepositoryBranchList()).isNotNull();
        assertEquals(testRepositoryBranchName, resultModel.getRepositoryBranchList().get(0));
        assertEquals(Constants.RESULT_STATUS_SUCCESS, resultModel.getResultStatus());
    }


    /**
     * Gets git hub repository branch list valid model return model.
     *
     * @throws Exception the exception
     */
    @Test
    public void getGitHubRepositoryBranchList_ValidModel_ReturnModel() throws Exception {
        // TODO :: FIX
        String testRepositoryUrl = "https://github.com/test/test.git";
        String testRepositoryAccountId = "test-id";
        String testRepositoryAccountPassword = "test-password";
        String testRepositoryBranchName = "test-branch-name";

        Job testModel = new Job();
        testModel.setRepositoryType(String.valueOf(RepositoryType.GIT_HUB));
        testModel.setRepositoryUrl(testRepositoryUrl);
        testModel.setRepositoryAccountId(testRepositoryAccountId);
        testModel.setRepositoryAccountPassword(testRepositoryAccountPassword);

        String reqRepositoryUrl = testModel.getRepositoryUrl();
        String repositoryUrl;
        String reqUrl;

        repositoryUrl = reqRepositoryUrl.substring(SEARCH_GIT_HUB_STRING.length(), reqRepositoryUrl.length() - 4);
        reqUrl = GIT_HUB_API_URL + repositoryUrl + SEARCH_BRANCHES_STRING;

        List resultList = new ArrayList();
        LinkedHashMap tempResultMap = new LinkedHashMap();
        tempResultMap.put("name", testRepositoryBranchName);
        resultList.add(tempResultMap);

        when(restTemplateService.customSend(reqUrl, HttpMethod.GET, null, List.class, testModel)).thenReturn(resultList);

        Job resultModel = repositoryService.getRepositoryInfo(testModel);

        assertThat(resultModel).isNotNull();
        assertEquals(String.valueOf(RepositoryType.GIT_HUB), resultModel.getRepositoryType());
        assertEquals(testRepositoryUrl, resultModel.getRepositoryUrl());
        assertEquals(testRepositoryAccountId, resultModel.getRepositoryAccountId());
        assertThat(resultModel.getRepositoryBranchList()).isNotNull();
        assertEquals(testRepositoryBranchName, resultModel.getRepositoryBranchList().get(0));
        assertEquals(Constants.RESULT_STATUS_SUCCESS, resultModel.getResultStatus());
    }


    /**
     * The enum Repository type.
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

}
