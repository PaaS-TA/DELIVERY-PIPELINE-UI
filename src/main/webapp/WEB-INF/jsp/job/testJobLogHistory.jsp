<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 8/22/2017
  Time: 3:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이동경로 :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
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
                            <li>실행 : <span class="data_txt_box font-wait" id="jobStatusText"></span></li>
                            <li>시작 : <span class="data_txt" id="jobCreatedString"></span></li>
                            <li>종료 : <span class="data_txt" id="jobLastModifiedString"></span></li>
                            <li>이전 작업명 : <span class="data_txt" id="previousJobNameString"></span></li>
                            <li>이전 작업 번호 : <span class="data_txt" id="previousJobNumberString"></span></li>
                            <li>트리거 : <span class="data_txt" id="jobTriggerType"></span></li>
                        </ul>
                    </div>
                    <div class="btn_wrap">
                        <button type="button" class="button btn_default" title="실행" id="btnTrigger">실행</button>
                        <button type="button" class="button btn_default" title="취소" id="btnStop" style="display: none;">취소</button>
                        <button type="button" class="button btn_default" title="구성" id="btnUpdate">구성</button>
                        <button type="button" class="button btn_default" title="목록" id="btnList">목록</button>
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
                        <div style="float: left;"><h3>로그</h3></div>
                        <div style="float: right;">
                            <button type="button" class="button btn_default" title="품질 이슈 결과" id="btnMoveInspectionResultPage" disabled>품질 이슈 결과</button>
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


<input type="hidden" id="serviceInstancesId" name="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />">
<input type="hidden" id="pipelineIdControlAuthority" name="pipelineIdControlAuthority" value="<c:out value='${pipelineId}' default='' />" />
<input type="hidden" id="jobId" name="jobId" value="<c:out value='${id}' default='' />" />
<input type="hidden" id="jobGuid" name="jobGuid" value="" />
<input type="hidden" id="jobNumber" name="jobNumber" value="" />
<input type="hidden" id="jobIsTriggering" name="jobIsTriggering" value="<%= Constants.CHECK_YN_N %>" />
<input type="hidden" id="jobIsStopping" name="jobIsStopping" value="<%= Constants.CHECK_YN_N %>" />
<input type="hidden" id="jobIsBuilding" name="jobIsBuilding" value="<%= Constants.CHECK_YN_N %>" />
<input type="hidden" id="inspectionProjectId" name="inspectionProjectId" value="" />


<script type="text/javascript">

    var gJobHistoryList,
        gJobLogTimer,
        gJobStatusTimer,
        gBuildingCount = 0;

    // check languageType
    var languageType = "";

    // GET JOB
    var getJob = function() {
        var reqUrl = JOB_PIPELINE_URL + "/get.do?id=<c:out value='${id}' default='' />";
        procCallAjax(reqUrl, null, callbackGetJob);
    };


    // CALLBACK GET JOB
    var callbackGetJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var doc = document;

        doc.getElementById('pipelineName').innerHTML= data.pipelineName;
        doc.getElementById('jobName').innerHTML= data.jobName;
        doc.getElementById('jobGuid').value = data.jobGuid;
        doc.getElementById('inspectionProjectId').value = data.inspectionProjectId;
        languageType = data.languageType;

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
            objBtnMoveInspectionResultPage = $('#btnMoveInspectionResultPage'),
            noDataString = " - ",
            progressString = "진행중";

        if (listLength < 1) {
            htmlString.push("이력이 없습니다.");
            lastJobNumber = 0;

            objJobStatusText.html(noDataString);
            $('#jobCreatedString').html(noDataString);
            $('#jobLastModifiedString').html(noDataString);
            objBtnMoveInspectionResultPage.attr('disabled', true);

        } else {
            for (var i = 0; i < listLength; i++) {
                tempJobNumber = parseInt(data[i].jobNumber, 10);

                if (tempJobNumber > 0) {
                    jobNumber = tempJobNumber;
                }

                jobStatus = data[i].status;
                listNumberString = listLength - i;
                createdString = data[i].createdString;

                objJobStatusText.removeClass().addClass("data_txt_box");

                // STATUS :: SUCCESS
                if ("<%= Constants.RESULT_STATUS_SUCCESS %>" === jobStatus) {
                    jobStatusCss = "success";
                    jobStatusText = "성공";
                    objJobStatusText.addClass("font-success");
                }

                // STATUS :: FAIL
                if ("<%= Constants.RESULT_STATUS_FAILURE %>" === jobStatus) {
                    jobStatusCss = "failure";
                    jobStatusText = "실패";
                    objJobStatusText.addClass("font-fail");
                }

                // STATUS :: ABORTED
                if ("<%= Constants.RESULT_STATUS_ABORTED %>" === jobStatus) {
                    jobStatusCss = "cancel";
                    jobStatusText = "중단";
                    objJobStatusText.addClass("font-retract");
                }

                // STATUS :: CANCELED
                if ("<%= Constants.RESULT_STATUS_CANCELLED %>" === jobStatus) {
                    jobStatusCss = "cancel";
                    jobStatusText = "취소";
                    objJobStatusText.addClass("font-retract");
                }

                // STATUS :: JOB WORKING
                if ("<%= Constants.RESULT_STATUS_JOB_WORKING %>" === jobStatus
                    || "<%= Constants.RESULT_STATUS_BUILT_FILE_UPLOADING %>" === jobStatus) {
                    jobStatusCss = "action";
                    jobStatusText = progressString;
                    objJobStatusText.addClass("font-progress");

                    listNumberString = progressString;
                    createdString = noDataString;

                    objJobIsBuilding.val("<%= Constants.CHECK_YN_Y %>");

                    $('#jobLogHistoryConsoleLogArea').html("진행 중입니다.");
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
            if(languageType == "JAVA"){
                objBtnMoveInspectionResultPage.attr('disabled', false);
            }else{
                objBtnMoveInspectionResultPage.hide();
            }
        }

        $('#jobLogHistoryArea').html(htmlString.join(''));
        $('#jobNumber').val(lastJobNumber);

        var lastJobNumberForJobStatus = parseInt(getLastJobNumber(), 10) + 1;
        startGetJobStatusTimer(lastJobNumberForJobStatus);

        if ("<%= Constants.CHECK_YN_N %>" === objJobIsBuilding.val()) {
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
            $('#jobLogHistoryConsoleLogArea').html("상세 이력이 없습니다.");
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
            $('#jobLogHistoryConsoleLogArea').html("<pre>" + consoleOutputHtml + "</pre>");
        }
    };


    // SET JOB HISTORY INFO
    var setJobHistoryInfo = function (reqDataIndex) {
        var objJobStatusText = $('#jobStatusText'),
            jobHistoryList = gJobHistoryList[reqDataIndex],
            lastJobStatus = jobHistoryList.status,
            jobCreatedString = jobHistoryList.createdString,
            jobLastModifiedString = jobHistoryList.lastModifiedString,
            previousJobNameString = jobHistoryList.previousJobName,
            previousJobNumberString = jobHistoryList.previousJobNumber,
            jobStatusText = " - ",
            noDataString = " - ",
            triggerType = jobHistoryList.triggerType,
            triggerTypeString = "<%= Constants.JOB_TRIGGER_MANUAL_TRIGGER_STRING %>";

        if ("<%= Constants.JOB_TRIGGER_ROLLBACK %>" === triggerType) {
            triggerTypeString = "<%= Constants.JOB_TRIGGER_ROLLBACK_STRING %>";
        }

        if ("<%= Constants.JOB_TRIGGER_PREVIOUS_JOB_SUCCESS %>" === triggerType) {
            triggerTypeString = "<%= Constants.JOB_TRIGGER_PREVIOUS_JOB_SUCCESS_STRING %>";
        }

        if ("<%= Constants.JOB_TRIGGER_MODIFIED_PUSH %>" === triggerType) {
            triggerTypeString = "<%= Constants.JOB_TRIGGER_MODIFIED_PUSH_STRING %>";
        }

        objJobStatusText.removeClass().addClass("data_txt_box");

        // STATUS :: SUCCESS
        if ("<%= Constants.RESULT_STATUS_SUCCESS %>" === lastJobStatus) {
            jobStatusText = "성공";
            objJobStatusText.addClass("font-success");
        }

        // STATUS :: FAIL
        if ("<%= Constants.RESULT_STATUS_FAILURE %>" === lastJobStatus) {
            jobStatusText = "실패";
            objJobStatusText.addClass("font-fail");
        }

        // STATUS :: ABORTED
        if ("<%= Constants.RESULT_STATUS_ABORTED %>" === lastJobStatus) {
            jobStatusText = "중단";
            objJobStatusText.addClass("font-retract");
        }

        // STATUS :: CANCELED
        if ("<%= Constants.RESULT_STATUS_CANCELLED %>" === lastJobStatus) {
            jobStatusText = "취소";
            objJobStatusText.addClass("font-retract");
        }

        // STATUS :: JOB WORKING
        if ("<%= Constants.RESULT_STATUS_JOB_WORKING %>" === lastJobStatus
            || "<%= Constants.RESULT_STATUS_BUILT_FILE_UPLOADING %>" === lastJobStatus) {
            jobStatusText = "진행중";
            jobCreatedString = noDataString;
            jobLastModifiedString = noDataString;
            previousJobNameString = noDataString;
            previousJobNumberString = noDataString;
            triggerTypeString = noDataString;
            objJobStatusText.addClass("font-progress");
        }

        // CHECK PREVIOUS JOB NUMBER
        if (previousJobNumberString === 0) {
            previousJobNameString = noDataString;
            previousJobNumberString = noDataString;
        }

        objJobStatusText.html(jobStatusText);
        $('#jobFileId').val(jobHistoryList.fileId);
        $('#jobCreatedString').html(jobCreatedString);
        $('#jobLastModifiedString').html(jobLastModifiedString);
        $('#previousJobNameString').html(previousJobNameString);
        $('#previousJobNumberString').html(previousJobNumberString);
        $('#jobTriggerType').html(triggerTypeString);

        var spinnerDiv = '<div id="spinner"><img src="<c:url value='/resources/spinner.gif' />" alt=""></div>';
        $('#jobLogHistoryConsoleLogArea').html(spinnerDiv);
    };


    // TRIGGER JOB
    var triggerJob = function () {
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
            jobType : "<%= Constants.JOB_TYPE_TEST %>"
        };

        $('#jobIsTriggering').val("<%= Constants.CHECK_YN_Y %>");

        procCallAjax(JOB_PIPELINE_URL + "/trigger.do", param, callbackTriggerJob);
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

        if ("<%= Constants.CHECK_YN_N %>" === objJobIsStopping.val()) {
            procPopupAlert('실행이 완료 되었습니다.');
        }

        objJobIsStopping.val("<%= Constants.CHECK_YN_N %>");
        $('#jobIsTriggering').val("<%= Constants.CHECK_YN_N %>");

        getJobHistoryList();
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
            jobNumber = 0,
            listLength = data.length;

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
        var htmlString = '<li><span class="action"></span><span class="action_txt" style="width: 38px;">진행중</span></li>',
            objJobLogHistoryArea = $('#jobLogHistoryArea'),
            objJobStatusText = $('#jobStatusText'),
            noDataString = " - ";

        objJobStatusText.removeClass().addClass("data_txt_box").addClass("font-progress");
        objJobStatusText.html("진행중");

        $('#jobCreatedString').html(noDataString);
        $('#jobLastModifiedString').html(noDataString);
        $('#jobTriggerType').html(noDataString);

        if (gJobHistoryList.length < 1) {
            objJobLogHistoryArea.html("");
        }

        objJobLogHistoryArea.prepend(htmlString);
        $('#jobLogHistoryConsoleLogArea').html("");
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
        var reqUrl = JOB_PIPELINE_URL + "/<c:out value='${id}' default='' />/log.do/" + reqJobNumber;
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
            $('#jobLogHistoryConsoleLogArea').html("<pre>" + consoleOutputHtml + "</pre>" + spinnerDiv);
        }
    };


    // STOP JOB
    var stopJob = function () {
        var doc = document,
            jobNumber = parseInt(doc.getElementById('jobNumber').value, 10);

        if ("<%= Constants.CHECK_YN_Y %>" === $('#jobIsTriggering').val()) {
            jobNumber++;
        }

        var param = {
            serviceInstancesId: "<c:out value='${serviceInstancesId}' default='' />",
            jobGuid : doc.getElementById('jobGuid').value,
            jobNumber : jobNumber
        };

        $('#jobIsStopping').val("<%= Constants.CHECK_YN_Y %>");
        procCallAjax(JOB_PIPELINE_URL + "/stop.do", param, callbackStopJob);
    };


    // CALLBACK STOP JOB
    var callbackStopJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        $('#btnTrigger').show();
        $('#btnStop').hide();

        procPopupAlert('정지 되었습니다.');
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
            id : "<c:out value='${id}' default='' />",
            jobNumber : reqJobNumber
        };

        procCallAjax(JOB_PIPELINE_URL + "/status.do", param, callbackGetJobStatus);
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
            checkY = "<%= Constants.CHECK_YN_Y %>",
            checkN = "<%= Constants.CHECK_YN_N %>",
            statusJobWorking = "<%= Constants.RESULT_STATUS_JOB_WORKING %>",
            statusBuiltFileUploading = "<%= Constants.RESULT_STATUS_BUILT_FILE_UPLOADING %>";

        if ("true" === isBuilding
            || statusJobWorking === lastJobStatus
            || statusBuiltFileUploading === lastJobStatus
            || checkY === jobIsBuilding) {
            if (statusJobWorking === lastJobStatus || statusBuiltFileUploading === lastJobStatus) {
                objJobIsBuilding.val(checkY);
            }

            if (gBuildingCount === 1 && checkY === jobIsBuilding && checkN === jobIsTriggering) {
                getJobHistoryList();
                startJobLogTimer(reqParam.jobNumber);
            }
            gBuildingCount++;
        }

        if ("false" === isBuilding
            && (checkY === jobIsBuilding || checkY === jobIsTriggering)
            && !(statusJobWorking === lastJobStatus || statusBuiltFileUploading === lastJobStatus)) {
            objJobIsBuilding.val(checkN);
            objJobIsTriggering.val(checkN);
            gBuildingCount = 0;
            getJobHistoryList();
        }
    };


    // BIND
    $("#btnTrigger").on("click", function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "job", "testTrigger");
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                if(grAry[i].authority.code == "read"){
                    procPopupAlert("권한이 없습니다.");
                }else{
                    procPopupConfirm('JOB 실행', '실행 하시겠습니까?', 'triggerJob();');
                }
            }
        }*/

    });


    // BIND
    $("#btnStop").on("click", function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "job", "testStop");
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                if(grAry[i].authority.code == "read"){
                    procPopupAlert("권한이 없습니다.");
                }else{
                    procPopupConfirm('JOB 정지', '정지 하시겠습니까?', 'stopJob();');
                }
            }
        }*/
    });


    // BIND
    $("#btnUpdate").on("click", function() {
        var reqUrl = JOB_PIPELINE_URL + "/<c:out value='${id}' default='' />/test/update";
        procMovePage(reqUrl);
    });


    // BIND
    $("#btnMoveInspectionResultPage").on("click", function() {
        procMovePage('/projects/' + $('#inspectionProjectId').val() + '/dashboard');
    });


    // BIND
    $("#btnList").on("click", function() {
        procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);

        //getGrantedAuthorities();
        getJob();
    });

</script>
