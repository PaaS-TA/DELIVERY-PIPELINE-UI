package paasta.delivery.pipeline.ui.codingRules;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfile;
import paasta.delivery.pipeline.ui.qualityProfile.QualityProfileService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * The type Coding rules service.
 */
@Service
public class CodingRulesService {

    private static final Logger LOGGER = LoggerFactory.getLogger(CodingRulesService.class);

    private static final String REQ_URL_Inspection = "/codingrules";

    @Autowired
    private RestTemplateService restTemplateService;
    @Autowired
    private QualityProfileService qualityProfileService;


    /**
     * Gets coding rules.
     *
     * @param codingRules the coding rules
     * @return the coding rules
     */
    public CodingRules getCodingRules(CodingRules codingRules) {

        String reqUrl = restTemplateService.makeQueryParam(REQ_URL_Inspection, codingRules);

        return restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.GET, null, CodingRules.class);
    }

    /**
     * Gets coding rule detail.
     *
     * @param codingRules the coding rules
     * @return the coding rule detail
     */
    public CodingRules getCodingRuleDetail(CodingRules codingRules) {
        String reqUrl = restTemplateService.makeQueryParam(REQ_URL_Inspection + "/codingRuleDetail", codingRules);
        CodingRules data = restTemplateService.send(Constants.TARGET_INSPECTION_API, reqUrl, HttpMethod.GET, null, CodingRules.class);

        // 연결된 품질 프로파일 리스트 조회 : 해당 서비스 인스턴스 + 품질 프로파일명 조회
        QualityProfile param = new QualityProfile();
        param.setServiceInstanceId(codingRules.getServiceInstanceId());
        param.setLanguage((String) ((Map) data.getRule()).get("lang"));
        List allQualityProfles = qualityProfileService.getQualityProfileList(param);

        List actives = (List) data.getActives();
        List qualityProfiles = new ArrayList();
        if (actives != null && actives.size() > 0) {

            actives.forEach(e -> {
                String qprofileKey = (String) ((Map) e).get("qProfile");
                allQualityProfles.forEach(p -> {
                    if (qprofileKey.equals((String) ((Map) p).get("key"))) {
                        LOGGER.info("############### equal :::: [{}] === [{}]", qprofileKey, (String) ((Map) p).get("key"));
                        ((Map) e).put("qPrdofileName", ((Map) p).get("name"));
                        ((Map) e).put("isDefault", ((Map) p).get("isDefault"));
                        qualityProfiles.add(e);
                    }
                });
            });
        }

        data.setActivatedQProfiles(qualityProfiles);

        LOGGER.info("RESULT :::::::::::::::::::::::::::::::::::::::::::"+qualityProfiles.size());
        return data;
    }

}