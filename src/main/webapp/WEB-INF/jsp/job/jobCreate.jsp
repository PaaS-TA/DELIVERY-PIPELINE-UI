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

    var gLastAppName;
    var gBuildToolTypeGradle = "gradle";
    var gBuildToolTypeMaven = "maven";
    var gJacocoPluginScriptGradle = "jacocoPluginScriptGradle";
    var gJacocoPluginScriptMaven = "jacocoPluginScriptMaven";


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

        getQualityProfileList();
    };


    // GET QUALITY PROFILE LIST
    var getQualityProfileList = function() {
        var reqUrl = INSPECTION_PIPELINE_URL + '/getQualityProfileList.do';
        procCallAjax(reqUrl, null, callbackGetQualityProfileList);
    };


    // CALLBACK GET QUALITY PROFILE LIST
    var callbackGetQualityProfileList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var listLength = data.length,
            selectedCss = '',
            profileName = '',
            listNumber = 0,
            htmlString = [];

        htmlString.push('<option value="">Select a quality profile</option>');

        for (var i = 0; i < listLength; i++) {
            selectedCss = (listNumber === 0)? ' selected' : '';
            listNumber++;

            profileName = data[i].name;
            profileName = profileName.toString().indexOf("^") > 0 ? profileName.toString().split("^")[1] : profileName;

            htmlString.push('<option value="' + data[i].key + '"' + selectedCss + '>' + listNumber + '. ' + profileName + '</option>');
        }

        $('#inspectionProfileKey').html(htmlString);

        getQualityGateList();
    };


    // GET QUALITY GATE LIST
    var getQualityGateList = function() {
        var reqUrl = INSPECTION_PIPELINE_URL + '/getQualityGateList.do?pipelineId=<c:out value='${pipelineId}' default='' />';
        procCallAjax(reqUrl, null, callbackGetQualityGateList);
    };


    // CALLBACK GET QUALITY GATE LIST
    var callbackGetQualityGateList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var listLength = data.length,
            selectedCss = '',
            listNumber = 0,
            htmlString = [];

        htmlString.push('<option value="">Quality gate selection</option>');

        for (var i = 0; i < listLength; i++) {
            selectedCss = (listNumber === 0)? ' selected' : '';
            listNumber++;
            htmlString.push('<option value="' + data[i].id + '"' + selectedCss + '>' + listNumber + '. ' + data[i].name + '</option>');
        }

        $('#inspectionGateId').html(htmlString);

        getBuildJobList();
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

        htmlString.push('<option value="">Staging selection</option>');

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


    // SET VIEW GET BRANCH LIST BUTTON
    var setViewGetBranchListButton = function(reqRepositoryType) {
        var objBtnGetBranchListWrapper = $('#btnGetBranchListWrapper');
        var objGithubTokenGuide = $('#githubTokenGuide');

        if ("<%= Constants.REPOSITORY_TYPE_SCM_SVN %>" === reqRepositoryType) {
            objBtnGetBranchListWrapper.hide();
            objGithubTokenGuide.hide();
        } else if ("<%= Constants.REPOSITORY_TYPE_GIT_HUB %>" === reqRepositoryType){
            objBtnGetBranchListWrapper.show();
            objGithubTokenGuide.show();
        } else {
            objBtnGetBranchListWrapper.show();
            objGithubTokenGuide.hide();
        }
    };


    // GET BRANCH LIST
    var getBranchList = function() {
        var doc = document,
            repositoryType = doc.getElementById('repositoryType').value;

        if (procIsNullString(repositoryType)) {
            procPopupAlert("Select an input type.");
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
            procPopupAlert('Branch list lookup failed.', null, "<%= Constants.CHECK_YN_Y %>");
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
            procPopupAlert('Branch list lookup failed.');
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
            procPopupAlert('Failed to retrieve SVN information.');
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
            procPopupAlert("Enter a job name.", "$('#buildJobName').focus();");
            return false;
        }

        // CHECK JOB TYPE
        if (procIsNullString(jobType)) {
            procPopupAlert("Enter the job type.", "$('#buildJobType').focus();");
            return false;
        }

        // CHECK BUILDER TYPE
        if (procIsNullString(builderType)) {
            procPopupAlert("Enter the builder type.", "$('#builderType').focus();");
            return false;
        }

        // CHECK REPOSITORY TYPE
        if (procIsNullString(repositoryType)) {
            procPopupAlert("Enter the input type.", "$('#repositoryType').focus();");
            return false;
        }

        // GET POST ACTION
        if ($("#buildJobPostActionYn").is(":checked")) {
            postActionYn = "<%= Constants.CHECK_YN_Y %>";
        }

        // CHECK REPOSITORY BRANCH
        if ("<%= Constants.REPOSITORY_TYPE_SCM_GIT %>" === repositoryType ||  "<%= Constants.REPOSITORY_TYPE_GIT_HUB %>" === repositoryType) {
            if (procIsNullString(repositoryBranch)) {
                procPopupAlert("After querying the branch, select the branch.", "$('#repositoryBranch').focus();");
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
        procPopupAlert('Saved.', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // CREATE TEST JOB
    var createTestJob = function() {
        var doc = document,
            jobName = $('#testJobName').val(),
            jobType = $('#testJobType').val(),
            postActionYn = "<%= Constants.CHECK_YN_N %>",
            inspectionProfileKey = $('#inspectionProfileKey').val(),
            inspectionGateId = $('#inspectionGateId').val(),
            buildJobId = $('#buildJobIdForTestJob').val();

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("Enter a job name.", "$('#testJobName').focus();");
            return false;
        }

        // CHECK JOB TYPE
        if (procIsNullString(jobType)) {
            procPopupAlert("Enter the job type.", "$('#testJobType').focus();");
            return false;
        }

        // GET POST ACTION
        if ($("#testJobPostActionYn").is(":checked")) {
            postActionYn = "<%= Constants.CHECK_YN_Y %>";
        }

        // CHECK INSPECTION PROFILE KEY
        if (procIsNullString(inspectionProfileKey)) {
            procPopupAlert("Select the quality profile item.", "$('#inspectionProfileKey').focus();");
            return false;
        }

        // CHECK INSPECTION GATE ID
        if (procIsNullString(inspectionGateId)) {
            procPopupAlert("Select the quality gate item.", "$('#inspectionGateId').focus();");
            return false;
        }

        // CHECK BUILD JOB ID
        if (procIsNullString(buildJobId)) {
            procPopupAlert("Select a staging item.", "$('#buildJobIdForTestJob').focus();");
            return false;
        }

        var reqParam = {
            serviceInstancesId: doc.getElementById('serviceInstancesId').value,
            pipelineId: doc.getElementById('pipelineId').value,
            groupOrder: doc.getElementById('groupOrder').value,
            jobOrder: parseInt(doc.getElementById('jobOrder').value, 10) + 1,
            pipelineName: $('#pipelineName').html(),
            jobName: jobName,
            jobType: jobType,
            postActionYn: postActionYn,
            inspectionProfileKey: inspectionProfileKey,
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
            procPopupAlert("Enter a job name.", "$('#deployJobName').focus();");
            return false;
        }

        // CHECK JOB TYPE
        if (procIsNullString(jobType)) {
            procPopupAlert("Enter the job type.", "$('#deployJobType').focus();");
            return false;
        }

        // CHECK DEPLOY TYPE
        if (procIsNullString(deployType)) {
            procPopupAlert("Enter the deployment type.", "$('#deployType').focus();");
            return false;
        }

        // CHECK DEPLOY TYPE :: PRD
        if ("<%= Constants.DeployType.PRD %>" === deployType) {
            blueGreenDeployStatus = "<%= Constants.BlueGreenDeployStatus.GREEN_DEPLOY %>";

            // CHECK JOB TRIGGER
            if ("<%= Constants.JOB_TRIGGER_PREVIOUS_JOB_SUCCESS %>" === deployJobTrigger) {
                procPopupAlert("When deploying operations, only manual task execution is possible.");
                return false;
            }
        }

        // CHECK CF INFO
        if (procIsNullString(cfInfoId)) {
            procPopupAlert("Select About Cloud Foundry.", "$('#cfInfoId').focus();");
            return false;
        }

        // CHECK DEPLOY TARGET SPACE
        if (procIsNullString(deployTargetSpace)) {
            procPopupAlert("Select a space.", "$('#deployTargetSpace').focus();");
            return false;
        }

        // CHECK APP NAME
        if (procIsNullString(appName)) {
            procPopupAlert("Enter the application name.", "$('#appName').focus();");
            return false;
        }

        // CHECK BUILD JOB ID
        if (procIsNullString(buildJobId)) {
            procPopupAlert("Select a staging item.", "$('#buildJobIdForDeployJob').focus();");
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

        htmlString.push('<option value="">Select a space</option>');

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


    // SET MANIFEST SCRIPT FORM
    var setManifestScriptForm = function(reqManifestUseYn) {
        var objManifestScript = $('#manifestScript'),
            appName = $('#appName').val(),
            booleanDisabled = false;

        if ('<%= Constants.CHECK_YN_N %>' === reqManifestUseYn) {
            booleanDisabled = true;
        }

        objManifestScript.attr('disabled' , booleanDisabled);
        setAppNameToManifestScriptForm(appName);
    };


    // SET APP NAME TO MANIFEST SCRIPT FORM
    var setAppNameToManifestScriptForm = function(reqAppName) {
        var appNameInitString = '%APP_NAME%',
            objManifestScript = $('#manifestScript');

        if (procIsNullString(reqAppName)) {
            objManifestScript.val(objManifestScript.val().replace(gLastAppName, appNameInitString));
        } else {
            gLastAppName = reqAppName;

            if ("<%= Constants.CHECK_YN_Y %>" === $("#manifestUseYn").val()) {
                objManifestScript.val(objManifestScript.val().replace(appNameInitString, reqAppName));
            } else {
                objManifestScript.val(objManifestScript.val().replace(reqAppName, appNameInitString));
            }
        }
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
    $("#btnGetBranchList").on("click", function() {
        getBranchList();
    });


    // BIND
    $("#cfInfoId").on("change", function() {
        getCfOrgNameAndSpaceList($(this).val());
    });


    // BIND
    $("#appName").on("blur", function() {
        setAppNameToManifestScriptForm($(this).val());
    });


    // BIND
    $("#manifestUseYn").on("change", function() {
        setManifestScriptForm($(this).val());
    });


    // BIND
    $(".btnCreate").on("click", function() {
        var doc = document,
            classArray = $(this).attr('class').split(" "),
            reqJobType = classArray[classArray.length - 1];

        if ("<%= Constants.JOB_TYPE_BUILD %>" === reqJobType) {
            // CHECK REPOSITORY URL
            if (doc.getElementById('repositoryUrl').value.indexOf(" ") > -1) {
                procPopupAlert("Check the repository path.", "$('#repositoryUrl').focus();");
                return false;
            }

            if ("<%= Constants.REPOSITORY_TYPE_SCM_SVN %>" === doc.getElementById('repositoryType').value) {
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


    // BIND
    $(".jacocoPluginScript").on("click", function() {
        var viewOnString = "view-on",
            viewOffString = "view-off",
            jacocoPluginScriptObject = null,
            buildToolType = $(this).attr("class").split(" ")[1];

        if (gBuildToolTypeGradle === buildToolType) {
            jacocoPluginScriptObject = $('#' + gJacocoPluginScriptGradle);
        }

        if (gBuildToolTypeMaven === buildToolType) {
            jacocoPluginScriptObject = $('#' + gJacocoPluginScriptMaven);
        }

        if (jacocoPluginScriptObject.hasClass(viewOffString)) {
            jacocoPluginScriptObject.removeClass(viewOffString).addClass(viewOnString);
            jacocoPluginScriptObject.fadeIn("slow");
        } else {
            jacocoPluginScriptObject.removeClass(viewOnString).addClass(viewOffString);
            jacocoPluginScriptObject.fadeOut("fast");
        }
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);

        getPipeline();
        setManifestScriptForm("<%= Constants.CHECK_YN_N %>");

        $('#buildJobType').val("<%= Constants.JOB_TYPE_BUILD %>");
        $('#buildJobName').putCursorAtEnd();
    });

</script>
