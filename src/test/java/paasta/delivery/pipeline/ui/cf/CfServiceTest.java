package paasta.delivery.pipeline.ui.cf;

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
import paasta.delivery.pipeline.ui.cfInfo.CfInfo;
import paasta.delivery.pipeline.ui.cfInfo.CfInfoService;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cf
 *
 * @author REX
 * @version 1.0
 * @since 8 /21/2017
 */
@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class CfServiceTest {

    // TODO :: FIX :: CF_TARGET_API
    private static final String CF_TARGET_API = "https://test.123.456.789";
    private static final String CF_SERVICE_INSTANCES_LIST_API = "/v2/service_instances";
    private static final String CF_SPACE_LIST_API = "/v2/spaces";
    private static final String CF_ORG_LIST_API = "/v2/organizations";
    private static final String MAP_KEY_RESOURCE = "resources";
    private static final String MAP_KEY_METADATA = "metadata";
    private static final String MAP_KEY_GUID = "guid";
    private static final String MAP_KEY_ENTITY = "entity";
    private static final String MAP_KEY_NAME = "name";


    @Mock
    private CommonService commonService;

    @Mock
    private RestTemplateService restTemplateService;

    @Mock
    private CfInfoService cfInfoService;

    @InjectMocks
    private CfService cfService;


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
     * Gets cf org name and space list valid string return model.
     *
     * @throws Exception the exception
     */
    @Test
    public void getCfOrgNameAndSpaceList_ValidString_ReturnModel() throws Exception {
        String token = "test-token";
        String serviceInstancesId = "test-service-instances-id";
        long cfId = 1L;
        String spaceGuid = "test-space-guid";
        String orgGuid = "test-org-guid";
        String orgName = "test-org-name";

        CfInfo cfInfo = new CfInfo();
        cfInfo.setServiceInstancesId(serviceInstancesId);
        cfInfo.setId(cfId);

        CfInfo tempResultCfInfo = new CfInfo();
        tempResultCfInfo.setCfApiUrl(CF_TARGET_API);


        // GET SERVICE INSTANCES LIST
        Map serviceInstancesResourcesEntityMap = new HashMap();
        serviceInstancesResourcesEntityMap.put("space_guid", spaceGuid);

        Map serviceInstancesResourcesMetaDataSubMap = new HashMap();
        serviceInstancesResourcesMetaDataSubMap.put(MAP_KEY_GUID, serviceInstancesId);

        Map serviceInstancesResourcesMetaDataMap = new HashMap();
        serviceInstancesResourcesMetaDataMap.put(MAP_KEY_ENTITY, serviceInstancesResourcesEntityMap);
        serviceInstancesResourcesMetaDataMap.put(MAP_KEY_METADATA, serviceInstancesResourcesMetaDataSubMap);

        List serviceInstancesResourcesList = new ArrayList();
        serviceInstancesResourcesList.add(serviceInstancesResourcesMetaDataMap);

        Map serviceInstancesListMap = new HashMap();
        serviceInstancesListMap.put(MAP_KEY_RESOURCE, serviceInstancesResourcesList);


        // GET SPACES LIST
        Map spaceResourcesEntityMap = new HashMap();
        spaceResourcesEntityMap.put("organization_guid", orgGuid);

        Map spaceResourcesMetaDataSubMap = new HashMap();
        spaceResourcesMetaDataSubMap.put(MAP_KEY_GUID, spaceGuid);

        Map spaceResourcesMetaDataMap = new HashMap();
        spaceResourcesMetaDataMap.put(MAP_KEY_ENTITY, spaceResourcesEntityMap);
        spaceResourcesMetaDataMap.put(MAP_KEY_METADATA, spaceResourcesMetaDataSubMap);

        List spaceResourcesList = new ArrayList();
        spaceResourcesList.add(spaceResourcesMetaDataMap);

        Map spaceListMap = new HashMap();
        spaceListMap.put(MAP_KEY_RESOURCE, spaceResourcesList);


        // GET ORGANIZATIONS LIST
        Map orgResourcesEntityMap = new HashMap();
        orgResourcesEntityMap.put(MAP_KEY_NAME, orgName);

        Map orgResourcesMetaDataSubMap = new HashMap();
        orgResourcesMetaDataSubMap.put(MAP_KEY_GUID, orgGuid);

        Map orgResourcesMetaDataMap = new HashMap();
        orgResourcesMetaDataMap.put(MAP_KEY_ENTITY, orgResourcesEntityMap);
        orgResourcesMetaDataMap.put(MAP_KEY_METADATA, orgResourcesMetaDataSubMap);

        List orgResourcesList = new ArrayList();
        orgResourcesList.add(orgResourcesMetaDataMap);

        Map orgListMap = new HashMap();
        orgListMap.put(MAP_KEY_RESOURCE, orgResourcesList);


        // GET CF INFO DETAIL FROM DATABASE
        when(cfInfoService.getCfInfo(cfInfo)).thenReturn(tempResultCfInfo);
        // GET TOKEN
        when(commonService.getToken()).thenReturn(token);
        // GET SERVICE INSTANCES LIST
        when(restTemplateService.cfSend(commonService.getToken(), CF_TARGET_API + CF_SERVICE_INSTANCES_LIST_API, HttpMethod.GET, null, Map.class)).thenReturn(serviceInstancesListMap);
        // GET SPACES LIST
        when(restTemplateService.cfSend(commonService.getToken(), CF_TARGET_API + CF_SPACE_LIST_API, HttpMethod.GET, null, Map.class)).thenReturn(spaceListMap);
        // GET ORGANIZATIONS LIST
        when(restTemplateService.cfSend(commonService.getToken(), CF_TARGET_API + CF_ORG_LIST_API, HttpMethod.GET, null, Map.class)).thenReturn(orgListMap);


        // TEST
        Cf resultModel = cfService.getCfOrgNameAndSpaceList(cfInfo);

        assertThat(resultModel).isNotNull();
        assertEquals(orgName, resultModel.getOrgName());
        assertEquals(1, resultModel.getSpaceList().size());
    }

}