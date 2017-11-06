package paasta.delivery.pipeline.ui.cf;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.cf.info.CfInfo;
import paasta.delivery.pipeline.ui.cf.info.CfInfoService;
import paasta.delivery.pipeline.ui.common.CommonService;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.cf
 *
 * @author REX
 * @version 1.0
 * @since 8 /21/2017
 */
@Service
public class CfService {

    private static final String CF_SERVICE_INSTANCES_LIST_API = "/v2/service_instances";
    private static final String CF_SPACE_LIST_API = "/v2/spaces";
    private static final String CF_ORG_LIST_API = "/v2/organizations";
    private static final String MAP_KEY_RESOURCE = "resources";
    private static final String MAP_KEY_METADATA = "metadata";
    private static final String MAP_KEY_GUID = "guid";
    private static final String MAP_KEY_ENTITY = "entity";
    private static final String MAP_KEY_NAME = "name";

    private final CommonService commonService;
    private final CfInfoService cfInfoService;
    private final RestTemplateService restTemplateService;


    /**
     * Instantiates a new Cf service.
     *
     * @param commonService       the common service
     * @param cfInfoService       the cf info service
     * @param restTemplateService the rest template service
     */
    @Autowired
    public CfService(CommonService commonService, CfInfoService cfInfoService, RestTemplateService restTemplateService) {
        this.commonService = commonService;
        this.cfInfoService = cfInfoService;
        this.restTemplateService = restTemplateService;
    }


    /**
     * Gets cf org name and space list.
     *
     * @param cfInfo             the cf info
     * @return the cf org name and space list
     */
    Cf getCfOrgNameAndSpaceList(CfInfo cfInfo) {
        Cf resultModel = new Cf();
        String resultCfOrgName = "";
        String resultCfOrgGuid = "";
        List<String> resultCfSpaceList = new ArrayList<>();
        String resultSpaceGuid = "";
        String resultOrgGuid = "";
        String serviceInstancesId = cfInfo.getServiceInstancesId();

        // GET CF INFO DETAIL FROM DATABASE
        String cfApiUrl = cfInfoService.getCfInfo(cfInfo).getCfApiUrl();

        // GET SERVICE INSTANCES LIST
        Map serviceInstancesListMap = restTemplateService.cfSend(commonService.getToken(), cfApiUrl + CF_SERVICE_INSTANCES_LIST_API, HttpMethod.GET, null, Map.class);
        List serviceInstancesResourcesList = (List) serviceInstancesListMap.get(MAP_KEY_RESOURCE);

        for (Object aServiceInstancesResourcesList : serviceInstancesResourcesList) {
            Map serviceInstancesResourcesMetaDataMap = (Map) aServiceInstancesResourcesList;

            // CHECK SERVICE INSTANCE ID
            if (serviceInstancesId.equals(getGuid(serviceInstancesResourcesMetaDataMap))) {
                Map tempMap = (Map) serviceInstancesResourcesMetaDataMap.get(MAP_KEY_ENTITY);
                // GET SPACE GUID
                resultSpaceGuid = (String) tempMap.get("space_guid");
            }
        }


        // GET SPACES LIST
        Map spaceListMap = restTemplateService.cfSend(commonService.getToken(), cfApiUrl + CF_SPACE_LIST_API, HttpMethod.GET, null, Map.class);
        List spaceResourcesList = (List) spaceListMap.get(MAP_KEY_RESOURCE);

        for (Object aSpaceResourcesList : spaceResourcesList) {
            Map spaceResourcesMetaDataMap = (Map) aSpaceResourcesList;

            // CHECK SPACE GUID
            if (resultSpaceGuid.equals(getGuid(spaceResourcesMetaDataMap))) {
                Map tempMap = (Map) spaceResourcesMetaDataMap.get(MAP_KEY_ENTITY);
                // GET ORGANIZATIONS GUID
                resultOrgGuid = (String) tempMap.get("organization_guid");
            }
        }


        // GET ORGANIZATIONS LIST
        Map orgListMap = restTemplateService.cfSend(commonService.getToken(), cfApiUrl + CF_ORG_LIST_API, HttpMethod.GET, null, Map.class);
        List orgResourcesList = (List) orgListMap.get(MAP_KEY_RESOURCE);

        for (Object anOrgResourcesList : orgResourcesList) {
            Map orgResourcesMetaDataMap = (Map) anOrgResourcesList;
            String orgGuid = getGuid(orgResourcesMetaDataMap);

            // CHECK ORGANIZATIONS GUID
            if (resultOrgGuid.equals(orgGuid)) {
                Map tempMap = (Map) orgResourcesMetaDataMap.get(MAP_KEY_ENTITY);
                // GET ORGANIZATION NAME
                resultCfOrgName = (String) tempMap.get(MAP_KEY_NAME);
                resultCfOrgGuid = orgGuid;
            }
        }


        // SET SPACE LIST
        for (Object aSpaceResourcesList : spaceResourcesList) {
            Map spaceResourcesMetaDataMap = (Map) aSpaceResourcesList;

            // CHECK SPACE GUID
            Map spaceResourcesEntityMap = (Map) spaceResourcesMetaDataMap.get(MAP_KEY_ENTITY);
            String tempOrgGuid = (String) spaceResourcesEntityMap.get("organization_guid");

            if (resultCfOrgGuid.equals(tempOrgGuid)) {
                resultCfSpaceList.add((String) spaceResourcesEntityMap.get(MAP_KEY_NAME));
            }
        }

        resultModel.setOrgName(resultCfOrgName);
        resultModel.setSpaceList(resultCfSpaceList);

        return resultModel;
    }


    private String getGuid(Map reqMap) {
        Map metaDataSubMap = (Map) reqMap.get(MAP_KEY_METADATA);
        return (String) metaDataSubMap.get(MAP_KEY_GUID);
    }

}
