<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/24/2017
  Time: 3:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이동경로 :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">Home</a></li>
            <li>
                <a href="javascript:void(0);" onclick="procMovePage('/pipeline/<c:out value='${pipelineId}' default='' />/detail');">
                    <span id="pipelineName"></span>
                </a>
            </li>
        </ul>
    </div>
</div>
<!--//이동경로 :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- sub content :s -->
        <div class="full_sub_content">
            <!-- 로그히스토리 :s -->
            <div class="log_histioy">
                <!--타이틀 :s -->
                <div class="header">
                    <div class="tit"><span id="jobName"></span></div>
                    <div class="databox">
                        <ul>
                            <li>Execute : <span class="data_txt_box font-success" id="jobStatusText"></span></li>
                            <li>Start : <span class="data_txt" id="jobCreatedString"></span></li>
                            <li>Finish : <span class="data_txt" id="jobLastModifiedString"></span></li>
                            <li>Previous job name : <span class="data_txt" id="previousJobNameString"></span></li>
                            <li>Previous job number : <span class="data_txt" id="previousJobNumberString"></span></li>
                            <li>Trigger : <span class="data_txt" id="jobTriggerType"></span></li>
                        </ul>
                    </div>
                    <div class="btn_wrap">
                        <button type="button" class="button btn_default" title="Execute" id="btnTrigger">실행</button>
                        <button type="button" class="button btn_default" title="Cancel" id="btnStop" style="display: none;">취소</button>
                        <button type="button" class="button btn_default" title="Composition" id="btnUpdate">구성</button>
                        <button type="button" class="button btn_default" title="List" id="btnList">목록</button>
                    </div>
                </div>
                <!--//타이틀 :e -->
                <!-- 본문영역 :s -->
                <div class="log_body">
                    <!-- Left :s -->
                    <div class="leftArea" style="border: none;">
                        <div class="log_value">
                            <ul id="jobLogHistoryArea">
                            </ul>
                        </div>
                    </div>
                    <!-- Left :s -->
                    <!-- Content :s -->
                    <div class="contentArea" style="position: inherit; float: none; clear: none;">
                        <div style="float: left;"><h3>Log</h3></div>
                        <div style="float: right;">
                            <button type="button" class="button btn_default" title="Rollback" id="btnRevertGreenDeploy" style="display: none;">Operation GREEN distribution revert</button>
                            <button type="button" class="button btn_default" title="Rollback" id="btnPopupRollBack" disabled>rollback to current job</button>
                        </div>
                        <!-- 내용 들어갈곳-->
                        <div class="log_body2" id="jobLogHistoryConsoleLogArea">
                        </div>
                        <!--//내용 들어갈곳-->
                    </div>
                    <!--//Content :e -->
                </div>
                <!--//본문영역 :e -->
            </div>
            <!--//로그히스토리 :e -->
        </div>
        <!--//sub content :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->


<%--POPUP ROLLBACK :: BEGIN--%>
<div class="modal fade" id="modalRollbackJob" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &times; </span></button>
                <h1 id="popupConfirmTitle" class="modal-title"> Rollback to current job </h1>
            </div>
            <div class="modal-body">
                <!-- form -->
                <div class="modal_contBox">
                    <!-- 기본 영역(Cloud Foundry 정보) -->
                    <div class="modalform_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">About Cloud Foundry</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!-- form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <p>
                                    <select class="input-large" title="" id="cfInfoId">
                                        <option value="">Select Cloud Foundry information</option>
                                        <c:forEach items="${cfInfoList}" var="item" varStatus="status">
                                            <option value="${item.id}">${item.cfName}</option>
                                        </c:forEach>
                                    </select>
                                </p>
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                    <!--//기본 영역(Cloud Foundry 정보) -->
                    <!-- 기본 영역(조직/공간) -->
                    <div class="modalform_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">Organization/Space</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!-- form 영역-->
                        <div class="form_right">
                            <div id="cfInfoWelcomeArea">
                                <div class="formBox">
                                    <p class="txt_normal" style="color: #ff4500">If you select About Cloud Foundry, it will be activated.</p>
                                </div>
                            </div>
                            <div id="cfInfoResultArea">
                                <div class="formBox">
                                    <p class="txt_normal">Organization name: <span id="deployTargetOrgView"></span></p>
                                </div>
                                <!-- 2뎁스 영역(유형 (type)) -->
                                <div class="formBox">
                                    <p>
                                        <select class="input-large" title="" id="deployTargetSpace">
                                        </select>
                                    </p>
                                    <p><input type="text" class="input-large" id="popupAppName" name="popupAppName" title="" value="" maxlength="25" placeholder="Application name"></p>
                                </div>
                            </div>
                            <!--//2뎁스 영역(유형 (type)) -->
                        </div>
                        <!--//form 영역-->
                    </div>
                    <!--//기본 영역(조직/공간) -->
                </div>
                <!--//form -->
            </div>
            <div class="modal-footer">
                <div class="fr">
                    <button type="button" class="button btn_pop" id="btnRollBack">Rollback</button>
                    <button type="button" class="button btn_pop" data-dismiss="modal"> Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--POPUP ROLLBACK :: END--%>


<input type="hidden" id="serviceInstancesId" name="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />">
<input type="hidden" id="pipelineIdControlAuthority" name="pipelineIdControlAuthority" value="<c:out value='${pipelineId}' default='' />" />
<input type="hidden" id="jobId" name="jobId" value="<c:out value='${id}' default='' />" />
<input type="hidden" id="jobGuid" name="jobGuid" value="" />
<input type="hidden" id="jobNumber" name="jobNumber" value="" />
<input type="hidden" id="buildJobId" name="buildJobId" value="" />
<input type="hidden" id="jobHistoryId" name="jobHistoryId" value="" />
<input type="hidden" id="jobIsTriggering" name="jobIsTriggering" value="<%= Constants.CHECK_YN_N %>" />
<input type="hidden" id="jobIsStopping" name="jobIsStopping" value="<%= Constants.CHECK_YN_N %>" />
<input type="hidden" id="jobIsBuilding" name="jobIsBuilding" value="<%= Constants.CHECK_YN_N %>" />
<input type="hidden" id="deployTargetOrg" name="deployTargetOrg" value="" />
<input type="hidden" id="originalDeployTargetSpace" name="originalDeployTargetSpace" value="" />
<input type="hidden" id="deployType" name="deployType" value="<%= Constants.DeployType.DEV %>" />
<input type="hidden" id="revertGreenDeployStatus" name="revertGreenDeployStatus" value="<%= Constants.CHECK_YN_N %>" />


<script type="text/javascript">

    var gJobHistoryList,
        gJobLogTimer,
        gJobStatusTimer,
        gBuildingCount = 0,
        gCheckInit = 0,
        gDeployTypePRD = '<%= Constants.DeployType.PRD %>';
        gResultStatusSuccess = '<%= Constants.RESULT_STATUS_SUCCESS %>';


    // GET JOB
    var getJob = function() {
        var reqUrl = JOB_PIPELINE_URL + '/get.do?id=<c:out value='${id}' default='' />';
        procCallAjax(reqUrl, null, callbackGetJob);
    };


    // CALLBACK GET JOB
    var callbackGetJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var doc = document,
            cfInfoId = data.cfInfoId;

        // SET REVERT GREEN DEPLOY STATUS
        if (gDeployTypePRD === data.deployType) {
            doc.getElementById('deployType').value = gDeployTypePRD;

            if ('<%= Constants.BlueGreenDeployStatus.BLUE_DEPLOY %>' === data.blueGreenDeployStatus) {
                doc.getElementById('revertGreenDeployStatus').value = '<%= Constants.CHECK_YN_Y %>';
            }
        }

        doc.getElementById('pipelineName').innerHTML= data.pipelineName;
        doc.getElementById('jobName').innerHTML= data.jobName;
        doc.getElementById('jobGuid').value = data.jobGuid;
        doc.getElementById('buildJobId').value = data.buildJobId;
        doc.getElementById('deployTargetOrg').value = data.deployTargetOrg;
        doc.getElementById('popupAppName').value = data.appName;
        doc.getElementById('cfInfoId').value = cfInfoId;

        doc.getElementById('originalDeployTargetSpace').value = data.deployTargetSpace;

        getCfOrgNameAndSpaceList(cfInfoId);

        procCallSpinner(SPINNER_STOP);
        getJobHistoryList();
    };


    // GET JOB HISTORY LIST
    var getJobHistoryList = function() {
        resetAllTimer();

        $('#btnTrigger').show();
        $('#btnStop').hide();

        var reqUrl = JOB_PIPELINE_URL + "/db/history/list.do?jobId=<c:out value='${id}' default='' />";
        procCallAjax(reqUrl, null, callbackGetJobHistoryList);
    };


    // CALLBACK GET JOB HISTORY LIST
    var callbackGetJobHistoryList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        gJobHistoryList = data;

        var listLength = data.length,
            htmlString = [],
            tempJobNumber,
            jobNumber = 0,
            jobStatus,
            jobStatusCss,
            jobStatusText,
            lastJobNumber,
            listNumberString,
            createdString,
            objJobStatusText = $('#jobStatusText'),
            objJobIsBuilding = $('#jobIsBuilding'),
            noDataString = ' - ',
            progressString = 'In progress';

        if (listLength < 1) {
            htmlString.push('There is no history.');
            lastJobNumber = 0;

            objJobStatusText.html(noDataString);
            $('#jobCreatedString').html(noDataString);
            $('#jobLastModifiedString').html(noDataString);
            $('#btnPopupRollBack').attr('disabled', true);

        } else {
            for (var i = 0; i < listLength; i++) {
                tempJobNumber = parseInt(data[i].jobNumber, 10);

                if (tempJobNumber > 0) {
                    jobNumber = tempJobNumber;
                }

                jobStatus = data[i].status;
                listNumberString = listLength - i;
                createdString = data[i].createdString;

                objJobStatusText.removeClass().addClass('data_txt_box');

                // STATUS :: SUCCESS
                if (jobStatus.indexOf(gResultStatusSuccess) > -1) {
                    jobStatusCss = 'success';
                    jobStatusText = 'Success';
                    objJobStatusText.addClass('font-success');

                    if ('<%= Constants.BlueGreenDeployStatus.GREEN_DEPLOY %>' + '_' + gResultStatusSuccess === jobStatus && i === 0) {
                        $('#btnRevertGreenDeploy').show();
                    }
                }

                // STATUS :: FAIL
                if ('<%= Constants.RESULT_STATUS_FAILURE %>' === jobStatus) {
                    jobStatusCss = 'failure';
                    jobStatusText = 'Fail';
                    objJobStatusText.addClass('font-fail');
                }

                // STATUS :: ABORTED
                if ('<%= Constants.RESULT_STATUS_ABORTED %>' === jobStatus) {
                    jobStatusCss = 'cancel';
                    jobStatusText = 'Stop';
                    objJobStatusText.addClass('font-retract');
                }

                // STATUS :: CANCELED
                if ('<%= Constants.RESULT_STATUS_CANCELLED %>' === jobStatus) {
                    jobStatusCss = 'cancel';
                    jobStatusText = 'Cancel';
                    objJobStatusText.addClass('font-retract');
                }

                // STATUS :: JOB WORKING
                if ('<%= Constants.RESULT_STATUS_JOB_WORKING %>' === jobStatus) {
                    jobStatusCss = 'action';
                    jobStatusText = progressString;
                    objJobStatusText.addClass('font-progress');

                    listNumberString = progressString;
                    createdString = noDataString;

                    objJobIsBuilding.val('<%= Constants.CHECK_YN_Y %>');

                    $('#jobLogHistoryConsoleLogArea').html('It is in progress.');
                    $('#btnTrigger').hide();
                    $('#btnStop').show();
                }

                htmlString.push('<li onclick="getJobHistoryConsoleLog(' + tempJobNumber + ', ' + i + ');" style="cursor: pointer;">');
                htmlString.push('<span class="' + jobStatusCss + '"></span>');
                htmlString.push('<span class="' + jobStatusCss + '_txt" style="width: 38px;">' + listNumberString + '</span>');
                htmlString.push('<span class="data">' + createdString + '</span>');
                htmlString.push('</li>');
            }

            lastJobNumber = data[0].jobNumber;
        }

        $('#jobLogHistoryArea').html(htmlString.join(''));
        $('#jobNumber').val(lastJobNumber);

        var lastJobNumberForJobStatus = parseInt(getLastJobNumber(), 10) + 1;
        startGetJobStatusTimer(lastJobNumberForJobStatus);

        if ('<%= Constants.CHECK_YN_N %>' === objJobIsBuilding.val()) {
            getJobHistoryConsoleLog(lastJobNumber, 0);
        } else {
            if (listLength > 0) {
                setJobHistoryInfo(0);
            }
        }
    };


    // GET JOB HISTORY
    var getJobHistoryConsoleLog = function (reqJobNumber, reqDataIndex) {
        if (gJobHistoryList.length > 0) {
            setJobHistoryInfo(reqDataIndex);
        }

        if (parseInt(reqJobNumber, 10) < 1) {
            $('#jobLogHistoryConsoleLogArea').html('There is no detailed history.');
            return false;
        }

        var reqUrl = JOB_PIPELINE_URL + "/<c:out value='${id}' default='' />/log.do/" + reqJobNumber;
        procCallAjax(reqUrl, null, callbackGetJobHistoryConsoleLog);
    };


    // CALLBACK GET JOB HISTORY
    var callbackGetJobHistoryConsoleLog = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var consoleOutputHtml = data.consoleOutputHtml;
        if (consoleOutputHtml !== null) {
            $('#jobLogHistoryConsoleLogArea').html('<pre>' + consoleOutputHtml + '</pre>');
        }
    };


    // SET JOB HISTORY INFO
    var setJobHistoryInfo = function (reqDataIndex) {
        var objJobStatusText = $('#jobStatusText'),
            btnRevertGreenDeploy = $('#btnRevertGreenDeploy'),
            jobHistoryList = gJobHistoryList[reqDataIndex],
            jobStatus = jobHistoryList.status,
            jobCreatedString = jobHistoryList.createdString,
            jobLastModifiedString = jobHistoryList.lastModifiedString,
            previousJobNameString = jobHistoryList.previousJobName,
            previousJobNumberString = jobHistoryList.previousJobNumber,
            jobStatusText = ' - ',
            noDataString = ' - ',
            rollBackYn = true,
            triggerType = jobHistoryList.triggerType,
            triggerTypeString = '<%= Constants.JOB_TRIGGER_MANUAL_TRIGGER_STRING %>',
            connString = '_';

        btnRevertGreenDeploy.hide();

        if ('<%= Constants.JOB_TRIGGER_ROLLBACK %>' === triggerType) {
            triggerTypeString = '<%= Constants.JOB_TRIGGER_ROLLBACK_STRING %>';
        }

        if ('<%= Constants.JOB_TRIGGER_PREVIOUS_JOB_SUCCESS %>' === triggerType) {
            triggerTypeString = '<%= Constants.JOB_TRIGGER_PREVIOUS_JOB_SUCCESS_STRING %>';
        }

        if ('<%= Constants.JOB_TRIGGER_MODIFIED_PUSH %>' === triggerType) {
            triggerTypeString = '<%= Constants.JOB_TRIGGER_MODIFIED_PUSH_STRING %>';
        }

        objJobStatusText.removeClass().addClass('data_txt_box');

        // CHECK PRD
        if (gDeployTypePRD === $('#deployType').val()) {
            // STATUS :: PRD :: BLUE DEPLOY :: SUCCESS
            if (('<%= Constants.BlueGreenDeployStatus.BLUE_DEPLOY %>' + connString + gResultStatusSuccess) === jobStatus) {
                jobStatusText = 'Success';
                objJobStatusText.addClass('font-success');
                rollBackYn = false;
            }

            // STATUS :: PRD :: GREEN DEPLOY :: SUCCESS
            if (('<%= Constants.BlueGreenDeployStatus.GREEN_DEPLOY %>' + connString + gResultStatusSuccess) === jobStatus) {
                jobStatusText = 'Success';
                objJobStatusText.addClass('font-success');

                if ('<%= Constants.CHECK_YN_Y %>' === $('#revertGreenDeployStatus').val() && reqDataIndex === 0) {
                    btnRevertGreenDeploy.show();
                }
            }

            // STATUS :: PRD :: REVERT GREEN DEPLOY :: SUCCESS
            if (('<%= Constants.BlueGreenDeployStatus.REVERT_GREEN_DEPLOY %>' + connString + gResultStatusSuccess) === jobStatus) {
                jobStatusText = 'Success';
                objJobStatusText.addClass('font-success');
            }
        } else {
            // STATUS :: DEV :: SUCCESS
            if (gResultStatusSuccess === jobStatus) {
                jobStatusText = 'Success';
                objJobStatusText.addClass('font-success');
                rollBackYn = false;
            }
        }

        // STATUS :: FAIL
        if ('<%= Constants.RESULT_STATUS_FAILURE %>' === jobStatus) {
            jobStatusText = 'Fail';
            objJobStatusText.addClass('font-fail');
        }

        // STATUS :: ABORTED
        if ('<%= Constants.RESULT_STATUS_ABORTED %>' === jobStatus) {
            jobStatusText = 'Stop';
            objJobStatusText.addClass('font-retract');
        }

        // STATUS :: CANCELED
        if ('<%= Constants.RESULT_STATUS_CANCELLED %>' === jobStatus) {
            jobStatusText = 'Cancel';
            objJobStatusText.addClass('font-retract');
        }

        // STATUS :: JOB WORKING
        if ('<%= Constants.RESULT_STATUS_JOB_WORKING %>' === jobStatus) {
            jobStatusText = 'In progress';
            jobCreatedString = noDataString;
            jobLastModifiedString = noDataString;
            previousJobNameString = noDataString;
            previousJobNumberString = noDataString;
            triggerTypeString = noDataString;
            objJobStatusText.addClass('font-progress');
        }

        // CHECK PREVIOUS JOB NUMBER
        if (previousJobNumberString === 0) {
            previousJobNameString = noDataString;
            previousJobNumberString = noDataString;
        }

        objJobStatusText.html(jobStatusText);
        $('#jobCreatedString').html(jobCreatedString);
        $('#jobLastModifiedString').html(jobLastModifiedString);
        $('#previousJobNameString').html(previousJobNameString);
        $('#previousJobNumberString').html(previousJobNumberString);
        $('#jobTriggerType').html(triggerTypeString);
        $('#jobHistoryId').val(jobHistoryList.id);
        $('#btnPopupRollBack').attr('disabled', rollBackYn);

        var spinnerDiv = '<div id="spinner"><img src="<c:url value='/resources/spinner.gif' />" alt=""></div>';
        $('#jobLogHistoryConsoleLogArea').html(spinnerDiv);
    };


    // TRIGGER JOB
    var triggerJob = function (reqRollBack, reqRevertGreenDeploy) {
        procClosePopup();

        $('#btnTrigger').hide();
        $('#btnStop').show();

        var doc = document,
            jobNumber = 0,
            lastJobNumber = parseInt(doc.getElementById('jobNumber').value, 10);

        if (lastJobNumber < 1) {
            jobNumber = getLastJobNumber();
        } else {
            jobNumber = lastJobNumber;
        }

        jobNumber++;

        var param = {
            id : doc.getElementById('jobId').value,
            jobGuid : doc.getElementById('jobGuid').value,
            jobNumber : jobNumber,
            jobType : '<%= Constants.JOB_TYPE_DEPLOY %>',
            buildJobId : doc.getElementById('buildJobId').value
        };

        // CHECK REVERT GREEN DEPLOY
        if ('<%= Constants.CHECK_YN_Y %>' === reqRevertGreenDeploy) {
            var greenDeployRevertParam = {
                blueGreenDeployStatus : '<%= Constants.BlueGreenDeployStatus.REVERT_GREEN_DEPLOY %>'
            };

            $.extend(param, greenDeployRevertParam);
        }

        // CHECK ROLL BACK
        if (reqRollBack) {
            var rollBackParam = {
                jobHistoryId : doc.getElementById('jobHistoryId').value,
                deployTargetOrg : doc.getElementById('deployTargetOrg').value,
                deployTargetSpace : doc.getElementById('deployTargetSpace').value,
                appName : doc.getElementById('popupAppName').value,
                cfInfoId: doc.getElementById('cfInfoId').value
            };

            $.extend(param, rollBackParam);
        }

        $('#btnRevertGreenDeploy').hide();

        $('#jobIsTriggering').val('<%= Constants.CHECK_YN_Y %>');
        procCallAjax(JOB_PIPELINE_URL + '/trigger.do', param, callbackTriggerJob);
        setInitTriggerJobLogHistory();
        startJobLogTimer(jobNumber);
    };


    // CALLBACK TRIGGER JOB
    var callbackTriggerJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var objJobIsStopping = $('#jobIsStopping');

        $('#btnTrigger').show();
        $('#btnStop').hide();

        if ('<%= Constants.CHECK_YN_N %>' === objJobIsStopping.val()) {
            procPopupAlert('Execution is complete.');
        }

        objJobIsStopping.val('<%= Constants.CHECK_YN_N %>');
        $('#jobIsTriggering').val('<%= Constants.CHECK_YN_N %>');

        getJob();
    };


    // RESET ALL TIMER
    var resetAllTimer = function() {
        clearTimeout(gJobStatusTimer);
        clearTimeout(gJobLogTimer);

        clearInterval(gJobStatusTimer);
        clearInterval(gJobLogTimer);

        gJobStatusTimer = [];
        gJobLogTimer = [];

    };


    // GET LAST JOB NUMBER
    var getLastJobNumber = function () {
        var data = gJobHistoryList,
            listLength = data.length,
            jobNumber = 0;

        for (var i = 0; i < listLength; i++) {
            jobNumber = parseInt(data[i].jobNumber, 10);

            if (jobNumber > 0) {
                break;
            }
        }

        return jobNumber;
    };


    // SET INIT TRIGGER JOB LOG HISTORY
    var setInitTriggerJobLogHistory = function () {
        var htmlString = '<li><span class="action"></span><span class="action_txt" style="width: 38px;">In progress</span></li>',
            objJobLogHistoryArea = $('#jobLogHistoryArea'),
            objJobStatusText = $('#jobStatusText'),
            noDataString = ' - ';

        objJobStatusText.removeClass().addClass('data_txt_box').addClass('font-progress');
        objJobStatusText.html('In progress');

        $('#jobCreatedString').html(noDataString);
        $('#jobLastModifiedString').html(noDataString);
        $('#jobTriggerType').html(noDataString);

        if (gJobHistoryList.length < 1) {
            objJobLogHistoryArea.html('');
        }

        objJobLogHistoryArea.prepend(htmlString);
        $('#jobLogHistoryConsoleLogArea').html('');
    };


    // START JOB LOG TIMER
    var startJobLogTimer = function (reqJobNumber) {
        var spinnerDiv = '<div id="spinner"><img src="<c:url value='/resources/spinner.gif' />" alt=""></div>';
        $('#jobLogHistoryConsoleLogArea').html(spinnerDiv);

        gJobLogTimer = setInterval(function () {
            getJobLog(reqJobNumber);
        }, 5000);
    };


    // GET JOB LOG
    var getJobLog = function (reqJobNumber) {
        var reqUrl = JOB_PIPELINE_URL + '/<c:out value='${id}' default='' />/log.do/' + reqJobNumber;
        procCallAjax(reqUrl, null, callbackGetJobLog);
    };


    // CALLBACK GET JOB LOG
    var callbackGetJobLog = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var spinnerDiv = '<div id="spinner"><img src="<c:url value='/resources/spinner.gif' />" alt=""></div>',
            consoleOutputHtml = data.consoleOutputHtml;

        if (consoleOutputHtml !== null) {
            $('#jobLogHistoryConsoleLogArea').html('<pre>' + consoleOutputHtml + '</pre>' + spinnerDiv);
        }
    };


    // STOP JOB
    var stopJob = function () {
        var doc = document,
            jobNumber = parseInt(doc.getElementById('jobNumber').value, 10);

        if ('<%= Constants.CHECK_YN_Y %>' === $('#jobIsTriggering').val()) {
            jobNumber++;
        }

        var param = {
            serviceInstancesId: '<c:out value='${serviceInstancesId}' default='' />',
            jobGuid : doc.getElementById('jobGuid').value,
            jobNumber : jobNumber
        };

        $('#jobIsStopping').val('<%= Constants.CHECK_YN_Y %>');
        procCallAjax(JOB_PIPELINE_URL + '/stop.do', param, callbackStopJob);
    };


    // CALLBACK STOP JOB
    var callbackStopJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        $('#btnTrigger').show();
        $('#btnStop').hide();

        procPopupAlert('Stopped.');
        getJobHistoryList();
    };


    // START TIMER
    var startGetJobStatusTimer = function (reqJobNumber) {
        gJobStatusTimer = setInterval(function () {
            getJobStatus(reqJobNumber);
        }, 3000);
    };


    // GET JOB STATUS
    var getJobStatus = function (reqJobNumber) {
        if (reqJobNumber < 1) {
            return false;
        }

        var param = {
            id : '<c:out value='${id}' default='' />',
            jobNumber : reqJobNumber
        };

        procCallAjax(JOB_PIPELINE_URL + '/status.do', param, callbackGetJobStatus);
    };


    // CALLBACK GET JOB STATUS
    var callbackGetJobStatus = function(data, reqParam) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var isBuilding = data.isBuilding,
            lastJobStatus = data.lastJobStatus,
            objJobIsBuilding = $('#jobIsBuilding'),
            objJobIsTriggering = $('#jobIsTriggering'),
            jobIsBuilding = objJobIsBuilding.val(),
            jobIsTriggering = objJobIsTriggering.val(),
            checkY = '<%= Constants.CHECK_YN_Y %>',
            checkN = '<%= Constants.CHECK_YN_N %>',
            statusJobWorking = '<%= Constants.RESULT_STATUS_JOB_WORKING %>';

        if ('true' === isBuilding
            || statusJobWorking === lastJobStatus
            || checkY === jobIsBuilding) {
            if (statusJobWorking === lastJobStatus) {
                objJobIsBuilding.val(checkY);
            }

            if (gBuildingCount === 1 && checkY === jobIsBuilding && checkN === jobIsTriggering) {
                getJobHistoryList();
                startJobLogTimer(reqParam.jobNumber);
            }
            gBuildingCount++;
        }

        if ('false' === isBuilding
            && (checkY === jobIsBuilding || checkY === jobIsTriggering)
            && !(statusJobWorking === lastJobStatus)) {
            objJobIsBuilding.val(checkN);
            objJobIsTriggering.val(checkN);
            gBuildingCount = 0;
            getJobHistoryList();
        }
    };


    // GET CF ORG NAME AND SPACE LIST
    var getCfOrgNameAndSpaceList = function(reqCfInfoId) {
        if (procIsNullString(reqCfInfoId)) {
            $('#cfInfoResultArea').hide();
            $('#cfInfoWelcomeArea').show();

            return false;
        }

        procCallAjax('/cf/get.do/' + reqCfInfoId, null, callbackGetCfOrgNameAndSpaceList);
    };


    // CALLBACK GET CF ORG NAME AND SPACE LIST
    var callbackGetCfOrgNameAndSpaceList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var objDeployTargetSpace = $('#deployTargetSpace'),
            orgName = data.orgName,
            spaceList = data.spaceList,
            listLength = spaceList.length,
            selectedCss = '',
            htmlString = [];

        htmlString.push('<option value="">Select a space</option>');

        for (var i = 0; i < listLength; i++) {
            selectedCss = (i === 0)? ' selected' : '';
            htmlString.push('<option value="' + spaceList[i] + '"' + selectedCss + '>' + spaceList[i] + '</option>');
        }

        $('#deployTargetOrg').val(orgName);
        $('#deployTargetOrgView').html(orgName);
        objDeployTargetSpace.html(htmlString);

        if (0 === gCheckInit) {
            objDeployTargetSpace.val(document.getElementById('originalDeployTargetSpace').value);
        }

        $('#cfInfoWelcomeArea').hide();
        $('#cfInfoResultArea').show();
    };


    // BIND
    $('#btnTrigger').on('click', function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, 'job', 'deployTrigger');
    });


    // BIND
    $('#btnStop').on('click', function() {
        procPopupConfirm('Stop JOB', 'Do you want to stop?', 'stopJob();');
    });


    // BIND
    $('#btnUpdate').on('click', function() {
        var reqUrl = JOB_PIPELINE_URL + '/<c:out value='${id}' default='' />/deploy/update';
        procMovePage(reqUrl);
    });


    // BIND
    $('#btnPopupRollBack').on('click', function() {
        $('#modalRollbackJob').modal('toggle');
    });


    // BIND
    $('#btnRevertGreenDeploy').on('click', function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, 'job', 'deployTriggerRevertGreenDeploy');
    });


    // BIND
    $('#btnRollBack').on('click', function() {
        procClosePopup();
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, 'job', 'deployTriggerRollBack');
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                if(grAry[i].authority.code == "read"){
                    procPopupAlert("You do not have permission.");
                }else{
                    procPopupConfirm('Rollback JOB', 'Do you want to roll back?', 'triggerJob(true);');
                }
            }
        }*/
    });


    // BIND
    $('#btnList').on('click', function() {
        procMovePage('/pipeline/<c:out value='${pipelineId}' default='' />/detail');
    });


    // BIND
    $('#cfInfoId').on('change', function(){
        getCfOrgNameAndSpaceList($(this).val());
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);

        //getGrantedAuthorities();
        getJob();
    });

</script>
