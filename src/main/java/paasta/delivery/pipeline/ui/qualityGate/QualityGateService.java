package paasta.delivery.pipeline.ui.qualityGate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import paasta.delivery.pipeline.ui.common.Constants;
import paasta.delivery.pipeline.ui.common.RestTemplateService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hrjin on 2017-06-29.
 */
@Service
public class QualityGateService {

    private static final String REQ_URL_Common = "/qualityGate";
    private static final String REQ_URL_Inspection = "/qualitygates";
    private final RestTemplateService restTemplateService;

    @Autowired
    public QualityGateService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }



    public QualityGate getQualityGate(Long id) {
        return restTemplateService.send(Constants.TARGET_COMMON_API, REQ_URL_Common + "/" + id, HttpMethod.GET, null, QualityGate.class);
    }



    ///////////////////////////////////////////////////////////////


    /**
     *  QualityGate 목록 조회
     *
     * @return
     */
    public  List getQualityGateList(String serviceInstancesId) {

        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityGateList?serviceInstancesId="+serviceInstancesId, HttpMethod.GET, null, List.class);
    }

    /**
     *  QualityGate 조건 옵션조회
     *
     * @param
     * @return QualityGate
     */
    public List getMetricsList(){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/metricsList", HttpMethod.GET, null, List.class);
    }


    /**
     *  QualityGate 조건 목록
     *
     * @param id
     * @return
     */
    public QualityGate getQualityGateCondition(Long id){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/condition?id="+id, HttpMethod.GET, null, QualityGate.class);
    }

    /**
     *  QualityGate condition 저장
     *
     * @param
     * @return
     */
    public QualityGate createQualityGateCond(QualityGate qualityGate){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityGateCondSave", HttpMethod.POST, qualityGate, QualityGate.class);
    }

    /**
     *  QualityGate condition 수정
     *
     * @param
     * @return
     */
    public QualityGate updateQualityGateCond(QualityGate qualityGate){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityGateCondUpdate", HttpMethod.POST, qualityGate, QualityGate.class);
    }

    /**
     *  QualityGate condition 삭제
     *
     * @param
     * @return
     */
    public QualityGate deleteQualityGateCond(String id){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityGateCondDelete", HttpMethod.POST, id, QualityGate.class);
    }

    /**
     *  QualityGate 복제
     *
     * @param
     * @return
     */
    public QualityGate copyQualityGate(QualityGate qualityGate){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityGateCopy",HttpMethod.POST, qualityGate, QualityGate.class);
    }

    /**
     *  QualityGate 생성 execute
     *
     * @param qualityGate
     * @return
     */
    public QualityGate createQualityGate(QualityGate qualityGate) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityGateCreate", HttpMethod.POST, qualityGate, QualityGate.class);
    }

    /**
     *  QualityGate 수정 execute
     *
     * @param qualityGate
     * @return
     */
    public QualityGate updateQualityGate(QualityGate qualityGate) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection + "/qualityGateUpdate", HttpMethod.POST, qualityGate, QualityGate.class);
    }


    /**
     *  QualityGate 삭제 execute
     *
     * @param qualityGate
     * @return
     */
    public QualityGate deleteQualityGate(QualityGate qualityGate) {
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection + "/qualityGateDelete", HttpMethod.POST, qualityGate, QualityGate.class);

    }

    /**
     *  QualityGate default setting
     *
     * @param
     * @return
     */
    public QualityGate qualityGateDefaultSetting(QualityGate qualityGate){
        return restTemplateService.send(Constants.TARGET_INSPECTION_API, REQ_URL_Inspection+"/qualityGateDefaultSetting", HttpMethod.POST, qualityGate, QualityGate.class);
    }

}
