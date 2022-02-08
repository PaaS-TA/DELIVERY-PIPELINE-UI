package paasta.delivery.pipeline.ui.common;

/**
 * paastaDeliveryPipelineApi
 * paasta.delivery.pipeline.ui.common
 *
 * @author REX
 * @version 1.0
 * @since 5 /10/2017
 */
public class Constants {

    /**
     * The constant RESULT_STATUS_SUCCESS.
     */
    public static final String RESULT_STATUS_SUCCESS = "SUCCESS";
    /**
     * The constant RESULT_STATUS_FAIL.
     */
    public static final String RESULT_STATUS_FAIL = "FAIL";
    /**
     * The constant RESULT_STATUS_FAILURE.
     */
    public static final String RESULT_STATUS_FAILURE = "FAILURE";
    /**
     * The constant RESULT_STATUS_ABORTED.
     */
    public static final String RESULT_STATUS_ABORTED = "ABORTED";
    /**
     * The constant RESULT_STATUS_CANCELLED.
     */
    public static final String RESULT_STATUS_CANCELLED = "CANCELLED";
    /**
     * The constant RESULT_STATUS_JOB_WORKING.
     */
    public static final String RESULT_STATUS_JOB_WORKING = "JOB_WORKING";
    /**
     * The constant RESULT_STATUS_BUILT_FILE_UPLOADING.
     */
    public static final String RESULT_STATUS_BUILT_FILE_UPLOADING = "BUILT_FILE_UPLOADING";

    /**
     * The constant TARGET_COMMON_API.
     */
    public static final String TARGET_COMMON_API = "commonApi";
    /**
     * The constant TARGET_DELIVERY_PIPELINE_API.
     */
    public static final String TARGET_DELIVERY_PIPELINE_API = "deliveryPipelineApi";
    /**
     * The constant TARGET_INSPECTION_API.
     */
    public static final String TARGET_INSPECTION_API = "inspectionApi";
    /**
     * The constant TARGET_BINARY_STORAGE_API.
     */
    public static final String TARGET_BINARY_STORAGE_API = "binaryStorageApi";

    /**
     * The constant REPOSITORY_TYPE_SCM.
     */
    public static final String REPOSITORY_TYPE_SCM = "SCM";
    /**
     * The constant REPOSITORY_TYPE_SCM_GIT.
     */
    public static final String REPOSITORY_TYPE_SCM_GIT = "SCM_GIT";
    /**
     * The constant REPOSITORY_TYPE_SCM_SVN.
     */
    public static final String REPOSITORY_TYPE_SCM_SVN = "SCM_SVN";
    /**
     * The constant REPOSITORY_TYPE_GIT_HUB.
     */
    public static final String REPOSITORY_TYPE_GIT_HUB = "GIT_HUB";

    /**
     * The constant JOB_TYPE_BUILD.
     */
    public static final String JOB_TYPE_BUILD = "BUILD";
    /**
     * The constant JOB_TYPE_TEST.
     */
    public static final String JOB_TYPE_TEST = "TEST";
    /**
     * The constant JOB_TYPE_DEPLOY.
     */
    public static final String JOB_TYPE_DEPLOY = "DEPLOY";

    /**
     * The constant TYPE_JOB.
     */
    public static final String TYPE_JOB = "JOB";
    /**
     * The constant TYPE_REPOSITORY.
     */
    public static final String TYPE_REPOSITORY = "REPOSITORY";
    /**
     * The constant TYPE_BUILDER.
     */
    public static final String TYPE_LANGUAGE = "LANGUAGE";
    /**
     * The constant TYPE_BUILDER_VERSION.
     */
    public static final String TYPE_LANGUAGE_VERSION = "LANGUAGE_VERSION";
    /**
     * The constant TYPE_BUILDER.
     */
    public static final String TYPE_BUILDER = "BUILDER";
    /**
     * The constant TYPE_BUILDER_VERSION.
     */
    public static final String TYPE_BUILDER_VERSION = "BUILDER_VERSION";
    /**
     * The constant TYPE_DEPLOY.
     */
    public static final String TYPE_DEPLOY = "DEPLOY";
    /**
     * The constant BUILD_JOB_TRIGGER_TYPE.
     */
    public static final String BUILD_JOB_TRIGGER_TYPE = "BUILD_JOB_TRIGGER_TYPE";
    /**
     * The constant TEST_JOB_TRIGGER_TYPE.
     */
    public static final String TEST_JOB_TRIGGER_TYPE = "TEST_JOB_TRIGGER_TYPE";
    /**
     * The constant DEPLOY_JOB_TRIGGER_TYPE.
     */
    public static final String DEPLOY_JOB_TRIGGER_TYPE = "DEPLOY_JOB_TRIGGER_TYPE";

    /**
     * The constant EMPTY_VALUE.
     */
    public static final String EMPTY_VALUE = "EMPTY_VALUE";

    /**
     * The constant CHECK_YN_Y.
     */
    public static final String CHECK_YN_Y = "Y";
    /**
     * The constant CHECK_YN_N.
     */
    public static final String CHECK_YN_N = "N";

    /**
     * The constant REQUEST_TYPE_SET.
     */
    public static final String REQUEST_TYPE_SET = "SET";
    /**
     * The constant REQUEST_TYPE_LOG.
     */
    public static final String REQUEST_TYPE_LOG = "LOG";

    /**
     * The constant JOB_TRIGGER_NEW_WORK_GROUP.
     */
    public static final String JOB_TRIGGER_NEW_WORK_GROUP = "ETC";
    /**
     * The constant JOB_TRIGGER_NEW_WORK_GROUP_STRING.
     */
    public static final String JOB_TRIGGER_NEW_WORK_GROUP_STRING = "이 작업(Job)을 새 작업 그룹으로 구성";
    /**
     * The constant JOB_TRIGGER_PREVIOUS_JOB_SUCCESS.
     */
    public static final String JOB_TRIGGER_PREVIOUS_JOB_SUCCESS = "PREVIOUS_JOB_SUCCESS";
    /**
     * The constant JOB_TRIGGER_MODIFIED_PUSH.
     */
    public static final String JOB_TRIGGER_MODIFIED_PUSH = "MODIFIED_PUSH";
    /**
     * The constant JOB_TRIGGER_MANUAL_TRIGGER.
     */
    public static final String JOB_TRIGGER_MANUAL_TRIGGER = "MANUAL_TRIGGER";
    /**
     * The constant JOB_TRIGGER_ROLLBACK.
     */
    public static final String JOB_TRIGGER_ROLLBACK = "ROLLBACK";

    /**
     * The constant JOB_TRIGGER_PREVIOUS_JOB_SUCCESS_STRING.
     */
    public static final String JOB_TRIGGER_PREVIOUS_JOB_SUCCESS_STRING = "이전 작업 성공";
    /**
     * The constant JOB_TRIGGER_MODIFIED_PUSH_STRING.
     */
    public static final String JOB_TRIGGER_MODIFIED_PUSH_STRING = "변경사항 푸시";
    /**
     * The constant JOB_TRIGGER_MANUAL_TRIGGER_STRING.
     */
    public static final String JOB_TRIGGER_MANUAL_TRIGGER_STRING = "사용자 실행";
    /**
     * The constant JOB_TRIGGER_ROLLBACK_STRING.
     */
    public static final String JOB_TRIGGER_ROLLBACK_STRING = "롤백";

    /**
     * The constant PIPELINE_DETAIL_TAB_TYPE_DETAIL.
     */
    public static final String PIPELINE_DETAIL_TAB_TYPE_DETAIL = "DETAIL";
    /**
     * The constant PIPELINE_DETAIL_TAB_TYPE_CONTRIBUTOR.
     */
    public static final String PIPELINE_DETAIL_TAB_TYPE_CONTRIBUTOR = "CONTRIBUTOR";


    /**
     * Instantiates a new Constants.
     */
    Constants() {}


    /**
     * The enum Deploy type.
     */
    public enum DeployType {
        /**
         * Dev deploy type.
         */
        DEV,
        /**
         * Prd deploy type.
         */
        PRD;
    }


    /**
     * The enum Blue green deploy status.
     */
    public enum BlueGreenDeployStatus {
        /**
         * Blue deploy blue green deploy status.
         */
        BLUE_DEPLOY,
        /**
         * Green deploy blue green deploy status.
         */
        GREEN_DEPLOY,
        /**
         * Green deploy revert blue green deploy status.
         */
        REVERT_GREEN_DEPLOY;
    }


    /**
     * The enum Pipeline contributor authority type.
     */
    public enum PipelineContributorAuthorityType {
        /**
         * Write pipeline contributor authority type.
         */
        WRITE,
        /**
         * Read pipeline contributor authority type.
         */
        READ,
        /**
         * Execute pipeline contributor authority type.
         */
        EXECUTE;
    }

}
