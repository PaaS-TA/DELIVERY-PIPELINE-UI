<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 6/30/2017
  Time: 12:57 PM
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

<%--############################## BUILD JOB ##############################--%>
<div id="buildJobWrapper">
    <%@include file="buildJobCreate.jsp" %>
</div>

<%--############################## TEST JOB ##############################--%>
<div id="testJobWrapper" style="display:none;">
    <%@include file="testJobCreate.jsp" %>
</div>

<%--############################## DEPLOY JOB ##############################--%>
<div id="deployJobWrapper" style="display:none;">
    <%@include file="deployJobCreate.jsp" %>
</div>


<input type="hidden" id="serviceInstancesId" name="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />">
<input type="hidden" id="pipelineId" name="pipelineId" value="<c:out value='${pipelineId}' default='' />" />
<input type="hidden" id="id" name="id" value="<c:out value='${pipelineId}' default='' />" />
<input type="hidden" id="groupOrder" name="groupOrder" value="<c:out value='${groupOrder}' default='1' />" />
<input type="hidden" id="jobOrder" name="jobOrder" value="<c:out value='${jobOrder}' default='0' />" />
<input type="hidden" id="deployTargetOrg" name="deployTargetOrg" value="" />
<input type="hidden" id="repositoryId" name="repositoryId" value="" />


<script type="text/javascript">

    // GET
    var getPipeline = function() {
        procCallAjax("/pipeline/pipelineDetail.do", {id : document.getElementById('pipelineId').value}, callbackGetPipeline);
    };


    // CALLBACK
    var callbackGetPipeline = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        document.getElementById('pipelineName').innerHTML= data.name;
    };


    // SET VIEW GET BRANCH LIST BUTTON
    var setViewGetBranchListButton = function(reqRepositoryType) {
        var objBtnGetBranchListWrapper = $('#btnGetBranchListWrapper');

        if ("<%= Constants.REPOSITORY_TYPE_SCM_SVN %>" === reqRepositoryType) {
            objBtnGetBranchListWrapper.hide();
        } else {
            objBtnGetBranchListWrapper.show();
        }
    };


    // GET BRANCH LIST
    var getBranchList = function() {
        var doc = document,
            repositoryType = doc.getElementById('repositoryType').value;

        if (procIsNullString(repositoryType)) {
            procPopupAlert("입력 유형을 선택하십시오.");
            return false;
        }

        var param = {
            repositoryType : repositoryType,
            repositoryAccountId : doc.getElementById('repositoryAccountId').value,
            repositoryAccountPassword : doc.getElementById('repositoryAccountPassword').value,
            repositoryUrl : doc.getElementById('repositoryUrl').value
        };

        $('#repositoryBranchWrapper').hide();
        procCallAjax("/repository/branch/list.do", param, callbackGetBranchList);
    };


    // CALLBACK GET BRANCH LIST
    var callbackGetBranchList = function(data, reqParam) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procPopupAlert('브렌치 목록 조회에 실패했습니다.', null, "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        var resultList = data.repositoryBranchList;

        if (resultList !== null) {
            var listCount = resultList.length,
                tempListItem = '',
                selectedCss = '',
                htmlString = [];

            for (var i = 0; i < listCount; i++) {
                tempListItem = resultList[i];
                selectedCss = (tempListItem === "master")? ' selected' : '';
                htmlString.push('<option value="' + tempListItem + '"' + selectedCss + '>' + tempListItem + '</option>');
            }

            $('#repositoryId').val(data.repositoryId);
            $('#repositoryBranch').html(htmlString);
            $('#repositoryBranchWrapper').show();

        } else {
            procPopupAlert('브렌치 목록 조회에 실패했습니다.');
        }
    };


    // GET SCM SVN INFO
    var getScmSvnInfo = function() {
        var doc = document,
            param = {
            repositoryType : doc.getElementById('repositoryType').value,
            repositoryAccountId : doc.getElementById('repositoryAccountId').value,
            repositoryAccountPassword : doc.getElementById('repositoryAccountPassword').value,
            repositoryUrl : doc.getElementById('repositoryUrl').value
        };

        procCallAjax("/repository/branch/list.do", param, callbackGetScmSvnInfo);
    };


    // CALLBACK GET SCM SVN INFO
    var callbackGetScmSvnInfo = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procPopupAlert('SVN 정보 조회에 실패했습니다.');
            return false;
        }

        $('#repositoryId').val(data.repositoryId);
        createBuildJob();
    };


    // CREATE BUILD JOB
    var createBuildJob = function() {
        var doc = document,
            jobName = $('#buildJobName').val(),
            jobType = $('#buildJobType').val(),
            builderType = $('#builderType').val(),
            postActionYn = "<%= Constants.CHECK_YN_N %>",
            repositoryType = $('#repositoryType').val(),
            repositoryBranch = $('#repositoryBranch').val(),
            newWorkGroupYn = "<%= Constants.CHECK_YN_N %>";

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("작업명을 입력하십시오.", "$('#buildJobName').focus();");
            return false;
        }

        // CHECK JOB TYPE
        if (procIsNullString(jobType)) {
            procPopupAlert("작업 유형을 입력하십시오.", "$('#buildJobType').focus();");
            return false;
        }

        // CHECK BUILDER TYPE
        if (procIsNullString(builderType)) {
            procPopupAlert("빌더 유형을 입력하십시오.", "$('#builderType').focus();");
            return false;
        }

        // CHECK REPOSITORY TYPE
        if (procIsNullString(repositoryType)) {
            procPopupAlert("입력 유형을 입력하십시오.", "$('#repositoryType').focus();");
            return false;
        }

        // GET POST ACTION
        if ($("#buildJobPostActionYn").is(":checked")) {
            postActionYn = "<%= Constants.CHECK_YN_Y %>";
        }

        // CHECK REPOSITORY BRANCH
        if ("<%= Constants.REPOSITORY_TYPE_SCM_GIT %>" === repositoryType ||  "<%= Constants.REPOSITORY_TYPE_GIT_HUB %>" === repositoryType) {
            if (procIsNullString(repositoryBranch)) {
                procPopupAlert("브렌치 조회 후, 브렌치를 선택하십시오.", "$('#repositoryBranch').focus();");
                return false;
            }
        }

        // GET NEW WORK GROUP
        if ($("#buildJobNewWorkGroup").is(":checked")) {
            newWorkGroupYn = "<%= Constants.CHECK_YN_Y %>";
        }

        var reqParam = {
            serviceInstancesId: doc.getElementById('serviceInstancesId').value,
            pipelineId: doc.getElementById('pipelineId').value,
            groupOrder: doc.getElementById('groupOrder').value,
            jobOrder: parseInt(doc.getElementById('jobOrder').value, 10) + 1,
            jobName: jobName,
            jobType: jobType,
            postActionYn: postActionYn,
            builderType: builderType,
            jobTrigger: $(':input:radio[name=buildJobTrigger]:checked').val(),
            newWorkGroupYn: newWorkGroupYn,
            repositoryType: repositoryType,
            repositoryUrl: doc.getElementById('repositoryUrl').value,
            repositoryId: doc.getElementById('repositoryId').value,
            repositoryAccountId: doc.getElementById('repositoryAccountId').value,
            repositoryAccountPassword: doc.getElementById('repositoryAccountPassword').value,
            repositoryBranch: repositoryBranch
        };

        procCallSpinner(SPINNER_START);
        procCallAjax(JOB_PIPELINE_URL + "/build/create.do", reqParam, callbackCreateJob);
    };


    // CALLBACK CREATE BUILD JOB
    var callbackCreateJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        procCallSpinner(SPINNER_STOP);
        procPopupAlert('저장 되었습니다.', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // CREATE TEST JOB
    var createTestJob = function() {
        var doc = document,
            jobName = $('#testJobName').val(),
            jobType = $('#testJobType').val(),
            postActionYn = "<%= Constants.CHECK_YN_N %>",
            inspectionProfileId = $('#inspectionProfileId').val(),
            inspectionGateId = $('#inspectionGateId').val(),
            buildJobId = $('#buildJobIdForTestJob').val();

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("작업명을 입력하십시오.", "$('#testJobName').focus();");
            return false;
        }

        // CHECK JOB TYPE
        if (procIsNullString(jobType)) {
            procPopupAlert("작업 유형을 입력하십시오.", "$('#testJobType').focus();");
            return false;
        }

        // GET POST ACTION
        if ($("#testJobPostActionYn").is(":checked")) {
            postActionYn = "<%= Constants.CHECK_YN_Y %>";
        }

        // CHECK INSPECTION PROFILE ID
        if (procIsNullString(inspectionProfileId)) {
            procPopupAlert("품질 프로파일 항목을 선택하십시오.", "$('#inspectionProfileId').focus();");
            return false;
        }

        // CHECK INSPECTION GATE ID
        if (procIsNullString(inspectionGateId)) {
            procPopupAlert("품질 게이트 항목을 선택하십시오.", "$('#inspectionGateId').focus();");
            return false;
        }

        // CHECK BUILD JOB ID
        if (procIsNullString(buildJobId)) {
            procPopupAlert("스테이징 항목을 선택하십시오.", "$('#buildJobIdForTestJob').focus();");
            return false;
        }

        var reqParam = {
            serviceInstancesId: doc.getElementById('serviceInstancesId').value,
            pipelineId: doc.getElementById('pipelineId').value,
            groupOrder: doc.getElementById('groupOrder').value,
            jobOrder: parseInt(doc.getElementById('jobOrder').value, 10) + 1,
            jobName: jobName,
            jobType: jobType,
            postActionYn: postActionYn,
            inspectionProfileId: inspectionProfileId,
            inspectionGateId: inspectionGateId,
            buildJobId: buildJobId,
            jobTrigger: $(':input:radio[name=testJobTrigger]:checked').val(),
            newWorkGroupYn: "<%= Constants.CHECK_YN_N %>"
        };

        procCallSpinner(SPINNER_START);
        procCallAjax(JOB_PIPELINE_URL + "/test/create.do", reqParam, callbackCreateJob);
    };


    // CREATE DEPLOY JOB
    var createDeployJob = function() {
        var doc = document,
            jobName = $('#deployJobName').val(),
            jobType = $('#deployJobType').val(),
            deployType = $('#deployType').val(),
            blueGreenDeployStatus = '',
            cfInfoId = $('#cfInfoId').val(),
            deployTargetSpace = $('#deployTargetSpace').val(),
            appName = $('#appName').val(),
            buildJobId = $('#buildJobIdForDeployJob').val(),
            deployJobTrigger = $(':input:radio[name=deployJobTrigger]:checked').val();

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("작업명을 입력하십시오.", "$('#deployJobName').focus();");
            return false;
        }

        // CHECK JOB TYPE
        if (procIsNullString(jobType)) {
            procPopupAlert("작업 유형을 입력하십시오.", "$('#deployJobType').focus();");
            return false;
        }

        // CHECK DEPLOY TYPE
        if (procIsNullString(deployType)) {
            procPopupAlert("배포 유형을 입력하십시오.", "$('#deployType').focus();");
            return false;
        }

        // CHECK DEPLOY TYPE :: PRD
        if ("<%= Constants.DeployType.PRD %>" === deployType) {
            blueGreenDeployStatus = "<%= Constants.BlueGreenDeployStatus.GREEN_DEPLOY %>";

            // CHECK JOB TRIGGER
            if ("<%= Constants.JOB_TRIGGER_PREVIOUS_JOB_SUCCESS %>" === deployJobTrigger) {
                procPopupAlert("운영 배포 시, 수동 작업 실행만 가능합니다.");
                return false;
            }
        }

        // CHECK CF INFO
        if (procIsNullString(cfInfoId)) {
            procPopupAlert("Cloud Foundry 정보를 선택하십시오.", "$('#cfInfoId').focus();");
            return false;
        }

        // CHECK DEPLOY TARGET SPACE
        if (procIsNullString(deployTargetSpace)) {
            procPopupAlert("공간을 선택하십시오.", "$('#deployTargetSpace').focus();");
            return false;
        }

        // CHECK APP NAME
        if (procIsNullString(appName)) {
            procPopupAlert("애플리케이션명을 입력하십시오.", "$('#appName').focus();");
            return false;
        }

        // CHECK BUILD JOB ID
        if (procIsNullString(buildJobId)) {
            procPopupAlert("스테이징 항목을 선택하십시오.", "$('#buildJobIdForDeployJob').focus();");
            return false;
        }

        var reqParam = {
            serviceInstancesId: doc.getElementById('serviceInstancesId').value,
            pipelineId: doc.getElementById('pipelineId').value,
            groupOrder: doc.getElementById('groupOrder').value,
            jobOrder: parseInt(doc.getElementById('jobOrder').value, 10) + 1,
            jobName: jobName,
            jobType: jobType,
            deployType: deployType,
            blueGreenDeployStatus: blueGreenDeployStatus,
            cfInfoId: cfInfoId,
            deployTargetOrg: doc.getElementById('deployTargetOrg').value,
            deployTargetSpace: doc.getElementById('deployTargetSpace').value,
            appName: doc.getElementById('appName').value,
            manifestUseYn: doc.getElementById('manifestUseYn').value,
            manifestScript: doc.getElementById('manifestScript').value,
            buildJobId: buildJobId,
            jobTrigger: deployJobTrigger,
            postActionYn: "<%= Constants.CHECK_YN_N %>",
            newWorkGroupYn: "<%= Constants.CHECK_YN_N %>"
        };

        procCallSpinner(SPINNER_START);
        procCallAjax(JOB_PIPELINE_URL + "/deploy/create.do", reqParam, callbackCreateJob);
    };


    // GET BUILD JOB LIST
    var getBuildJobList = function() {
        var reqUrl = JOB_PIPELINE_URL + "/list.do?pipelineId=<c:out value='${pipelineId}' default='' />&jobType=<%= Constants.JOB_TYPE_BUILD %>";
        procCallAjax(reqUrl, null, callbackGetBuildJobList);
    };


    // CALLBACK GET BUILD JOB LIST
    var callbackGetBuildJobList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var listLength = data.length,
            selectedCss = '',
            listNumber = 0,
            htmlString = [];

        htmlString.push('<option value="">스테이징 선택</option>');

        for (var i = 0; i < listLength; i++) {
            if (data[i].groupOrder === parseInt("<c:out value='${groupOrder}' default='' />", 10)) {
                selectedCss = (listNumber === 0)? ' selected' : '';
                listNumber++;
                htmlString.push('<option value="' + data[i].id + '"' + selectedCss + '>' + listNumber + '. ' + data[i].jobName + '</option>');
            }
        }

        $('#buildJobIdForTestJob').html(htmlString);
        $('#buildJobIdForDeployJob').html(htmlString);

        procCallSpinner(SPINNER_STOP);
    };


    // GET CF ORG NAME AND SPACE LIST
    var getCfOrgNameAndSpaceList = function(reqCfInfoId) {
        if (procIsNullString(reqCfInfoId)) {
            $('#cfInfoResultArea').hide();
            $('#cfInfoWelcomeArea').show();

            return false;
        }

        procCallAjax("/cf/get.do/" + reqCfInfoId, null, callbackGetCfOrgNameAndSpaceList);
    };


    // CALLBACK GET CF ORG NAME AND SPACE LIST
    var callbackGetCfOrgNameAndSpaceList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var orgName = data.orgName,
            spaceList = data.spaceList,
            listLength = spaceList.length,
            selectedCss = '',
            htmlString = [];

        htmlString.push('<option value="">공간 선택</option>');

        for (var i = 0; i < listLength; i++) {
            selectedCss = (i === 0)? ' selected' : '';
            htmlString.push('<option value="' + spaceList[i] + '"' + selectedCss + '>' + spaceList[i] + '</option>');
        }

        $('#deployTargetOrg').val(orgName);
        $('#deployTargetOrgView').html(orgName);
        $('#deployTargetSpace').html(htmlString);

        $('#cfInfoWelcomeArea').hide();
        $('#cfInfoResultArea').show();
    };


    // BIND
    $(".jobType").on("change", function() {
        var reqJobType = $(this).val();

        if (procIsNullString(reqJobType)) {
            return false;
        }

        var objBuildJobWrapper = $('#buildJobWrapper'),
            objTestJobWrapper = $('#testJobWrapper'),
            objDeployJobWrapper = $('#deployJobWrapper');

        objBuildJobWrapper.hide();
        objTestJobWrapper.hide();
        objDeployJobWrapper.hide();

        if ("<%= Constants.JOB_TYPE_BUILD %>" === reqJobType) {
            $('#buildJobType').val(reqJobType);
            objBuildJobWrapper.show();
            $('#buildJobName').putCursorAtEnd();
        }

        if ("<%= Constants.JOB_TYPE_TEST %>" === reqJobType) {
            $('#testJobType').val(reqJobType);
            objTestJobWrapper.show();
            $('#testJobName').putCursorAtEnd();
        }

        if ("<%= Constants.JOB_TYPE_DEPLOY %>" === reqJobType) {
            $('#deployJobType').val(reqJobType);
            objDeployJobWrapper.show();
            $('#deployJobName').putCursorAtEnd();
        }
    });


    // BIND
    $("#repositoryType").on("change", function() {
        setViewGetBranchListButton($(this).val());
    });


    // BIND
    $("#deployType").on("change", function() {
        var deployType = this.value,
            objDeployJobTriggerPreviousJobSuccess = $("input:radio[name='deployJobTrigger']:radio[value='" + "<%= Constants.JOB_TRIGGER_PREVIOUS_JOB_SUCCESS %>" + "']"),
            objDeployJobTriggerManualTrigger = $("input:radio[name='deployJobTrigger']:radio[value='" + "<%= Constants.JOB_TRIGGER_MANUAL_TRIGGER %>" + "']");

        if ("<%=Constants.DeployType.PRD %>" === deployType) {
            objDeployJobTriggerPreviousJobSuccess.attr("checked", false);
            objDeployJobTriggerManualTrigger.attr("checked", true);
        } else {
            objDeployJobTriggerManualTrigger.attr("checked", false);
            objDeployJobTriggerPreviousJobSuccess.attr("checked", true);
        }
    });


    // BIND
    $("#cfInfoId").on("change", function() {
        getCfOrgNameAndSpaceList($(this).val());
    });


    // BIND
    $("#btnGetBranchList").on("click", function() {
        getBranchList();
    });


    // BIND
    $(".btnCreate").on("click", function() {
        var classArray = $(this).attr('class').split(" "),
            reqJobType = classArray[classArray.length - 1];

        if ("<%= Constants.JOB_TYPE_BUILD %>" === reqJobType) {
            if ("<%= Constants.REPOSITORY_TYPE_SCM_SVN %>" === document.getElementById('repositoryType').value) {
                getScmSvnInfo();
            } else {
                createBuildJob();
            }
        }

        if ("<%= Constants.JOB_TYPE_TEST %>" === reqJobType) {
            createTestJob();
        }

        if ("<%= Constants.JOB_TYPE_DEPLOY %>" === reqJobType) {
            createDeployJob();
        }
    });


    // BIND
    $(".btnCancel").on("click", function() {
        procMovePage(-1);
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);

        getPipeline();
        getBuildJobList();
        $('#buildJobType').val("<%= Constants.JOB_TYPE_BUILD %>");
        $('#buildJobName').putCursorAtEnd();
    });

</script>
