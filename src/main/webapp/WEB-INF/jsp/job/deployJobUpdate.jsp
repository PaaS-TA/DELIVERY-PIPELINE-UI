<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 6/12/2017
  Time: 1:20 PM
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
        <!-- 타이틀 :s -->
        <h3 class="sub_title">Configuration details</h3>
        <!--//타이틀 :e -->
        <!-- sub content :s -->
        <div class="sub_content">
            <!-- form (contBox) -->
            <div class="contBox">
                <!-- 내작업 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">My work</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="jobName" name="jobName" title="" value="" maxlength="25" placeholder="Job name">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//내작업 -->
                <!-- 작업 유형 (Job) -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">Job type (Job)</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="deployJobType" name="deployJobType" title="" value="Deployment (Deploy)" disabled>
                        </div>
                        <!--2뎁스 영역(유형 (type)) -->
                        <p class="sub_title">Type (type)</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="deployType" disabled>
                                <option value="">Select a type</option>
                                <c:forEach items="${deployTypeList}" var="item" varStatus="status">
                                    <option value="${item.typeName}">${item.typeValue}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <!--//2뎁스 영역(유형 (type)) -->
                        <!--2뎁스 영역(Cloud Foundry 정보) -->
                        <p class="sub_title">About Cloud Foundry</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="cfInfoId">
                                <option value="">Select Cloud Foundry information</option>
                                <c:forEach items="${cfInfoList}" var="item" varStatus="status">
                                    <option value="${item.id}">${item.cfName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <!--//2뎁스 영역(Cloud Foundry 정보) -->
                        <!--2뎁스 영역(조직/공간) -->
                        <p class="sub_title">Organization/Space</p>
                        <div id="cfInfoWelcomeArea" style="display: none;">
                            <div class="formBox">
                                <p class="txt_normal" style="color: #ff4500">If you select About Cloud Foundry, it will be activated.</p>
                            </div>
                        </div>
                        <div id="cfInfoResultArea" style="display: none;">
                            <div class="formBox">
                                <p class="txt_normal">Organization name: <span id="deployTargetOrgView"></span></p>
                            </div>
                            <div class="formBox">
                                <select class="input-medium" title="" id="deployTargetSpace">
                                </select>
                            </div>
                            <div class="formBox">
                                <input type="text" class="input-medium" id="appName" name="appName" title="" value="" maxlength="25" placeholder="Application name">
                            </div>
                        </div>
                        <!--//2뎁스 영역(조직/공간) -->
                        <!--2뎁스 영역(MANIFEST 사용 여부) -->
                        <p class="sub_title">Whether to use MANIFEST</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="manifestUseYn">
                                <option title="" value="<%= Constants.CHECK_YN_Y %>"><%= Constants.CHECK_YN_Y %></option>
                                <option title="" value="<%= Constants.CHECK_YN_N %>" selected><%= Constants.CHECK_YN_N %></option>
                            </select>
                        </div>
                        <!--//2뎁스 영역(MANIFEST 사용 여부) -->
                        <!--2뎁스 영역(MANIFEST YML) -->
                        <p class="sub_title">MANIFEST.YML</p>
                        <div class="formBox">
                            <textarea class="input-medium" name="manifestScript" id="manifestScript" cols="30" rows="6" title=""></textarea>
                        </div>
                        <!--//2뎁스 영역(MANIFEST YML) -->
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//작업 유형 (Job) -->
                <!-- 공통영역(입력 유형) -->
                <div class="commonArea">
                    <div class="form_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">Input type</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <select class="input-medium" title="" id="buildJobId">
                                    <option value="">Staging selection</option>
                                </select>
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                </div>
                <!--//공통영역(입력 유형) -->
                <!-- 작업 트리거 (Job Trigger) -->
                <div class="form_info">
                    <div class="form_right">
                        <!--2뎁스 영역-->
                        <p class="sub_title">Job trigger (Job Trigger)</p>
                        <div class="formBox">
                            <ul>
                                <c:forEach items="${deployJobTriggerTypeList}" var="item" varStatus="status">
                                    <c:choose>
                                        <c:when test="${0 == status.index}">
                                            <li><input type="radio" name="deployJobTrigger" value="${item.typeName}" checked title="">${item.typeValue}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><input type="radio" name="deployJobTrigger" value="${item.typeName}" title="">${item.typeValue}</li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </ul>
                        </div>
                        <!--//2뎁스 영역-->
                    </div>
                </div>
                <!--//작업 트리거 (Job Trigger) -->
                <!-- 버튼 영역 -->
                <div class="btn_Area plr20">
                    <div class="fr">
                        <button type="button" class="button btn_default" title="Save" id="btnUpdate">Save</button>
                        <button type="button" class="button btn_default" title="Cancel" id="btnCancel">Cancel</button>
                    </div>
                </div>
                <!--//버튼 영역-->
            </div>
            <!--//form (contBox) -->
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
<input type="hidden" id="jobType" name="jobType" value="" />
<input type="hidden" id="groupOrder" name="groupOrder" value="" />
<input type="hidden" id="jobOrder" name="jobOrder" value="" />
<input type="hidden" id="created" name="created" value="" />
<input type="hidden" id="deployTargetOrg" name="deployTargetOrg" value="" />
<input type="hidden" id="originalDeployTargetSpace" name="originalDeployTargetSpace" value="" />
<input type="hidden" id="originalBuildJobId" name="originalBuildJobId" value="" />
<input type="hidden" id="blueGreenDeployStatus" name="blueGreenDeployStatus" value="" />


<script type="text/javascript">

    var gCheckInit = 0;


    // GET
    var getPipeline = function() {
        procCallAjax("/pipeline/pipelineDetail.do", {id : document.getElementById('pipelineIdControlAuthority').value}, callbackGetPipeline);
    };


    // CALLBACK
    var callbackGetPipeline = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        document.getElementById('pipelineName').innerHTML= data.name;
        getJob();
    };


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

        var doc = document,
            cfInfoId = data.cfInfoId,
            manifestUseYn = data.manifestUseYn,
            deployTargetSpace = data.deployTargetSpace,
            buildJobId = data.buildJobId;

        doc.getElementById('jobId').value = data.id;
        doc.getElementById('buildJobId').value  = buildJobId;
        doc.getElementById('serviceInstancesId').value = data.serviceInstancesId;
        doc.getElementById('pipelineIdControlAuthority').value = data.pipelineId;
        doc.getElementById('jobGuid').value = data.jobGuid;
        doc.getElementById('jobName').value = data.jobName;
        doc.getElementById('jobType').value = data.jobType;
        doc.getElementById('groupOrder').value = data.groupOrder;
        doc.getElementById('jobOrder').value = data.jobOrder;
        doc.getElementById('cfInfoId').value = cfInfoId;
        doc.getElementById('deployType').value = data.deployType;
        doc.getElementById('blueGreenDeployStatus').value = data.blueGreenDeployStatus;
        doc.getElementById('deployTargetOrg').value = data.deployTargetOrg;
        doc.getElementById('appName').value = data.appName;
        doc.getElementById('manifestUseYn').value = manifestUseYn;
        doc.getElementById('manifestScript').value = data.manifestScript;
        doc.getElementById('created').value = data.created;

        doc.getElementById('originalDeployTargetSpace').value = deployTargetSpace;
        doc.getElementById('originalBuildJobId').value = buildJobId;

        $("input:radio[name='deployJobTrigger']:radio[value='" + data.jobTrigger + "']").attr("checked", true);

        setManifestScriptForm(manifestUseYn);
        getCfOrgNameAndSpaceList(cfInfoId);
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

        var objDeployTargetSpace = $('#deployTargetSpace'),
            originalDeployTargetSpace = $('#originalDeployTargetSpace').val(),
            orgName = data.orgName,
            spaceList = data.spaceList,
            listLength = spaceList.length,
            deployTargetSpace = '',
            selectedCss = '',
            htmlString = [];

        htmlString.push('<option value="">Select a space</option>');

        for (var i = 0; i < listLength; i++) {
            deployTargetSpace = spaceList[i];
            selectedCss = (originalDeployTargetSpace === deployTargetSpace)? ' selected' : '';
            htmlString.push('<option value="' + deployTargetSpace + '"' + selectedCss + '>' + deployTargetSpace + '</option>');
        }

        $('#deployTargetOrg').val(orgName);
        $('#deployTargetOrgView').html(orgName);
        objDeployTargetSpace.html(htmlString);

        if (0 === gCheckInit) {
            objDeployTargetSpace.val(document.getElementById('originalDeployTargetSpace').value);
        }

        $('#cfInfoWelcomeArea').hide();
        $('#cfInfoResultArea').show();

        getBuildJobList();
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
            originalBuildJobId = parseInt($('#originalBuildJobId').val(), 10),
            buildJobId = '',
            selectedCss = '',
            listNumber = 0,
            htmlString = [];


        for (var i = 0; i < listLength; i++) {
            if (data[i].groupOrder === parseInt(document.getElementById('groupOrder').value, 10)) {
                buildJobId = parseInt(data[i].id, 10);
                selectedCss = (originalBuildJobId === buildJobId)? ' selected' : '';
                listNumber++;
                htmlString.push('<option value="' + buildJobId + '"' + selectedCss + '>' + listNumber + '. ' + data[i].jobName + '</option>');
            }
        }

        $('#buildJobId').append(htmlString);

        procCallSpinner(SPINNER_STOP);
    };


    // UPDATE JOB
    var updateJob = function() {
        var doc = document,
            jobName = $('#jobName').val(),
            deployTargetSpace = $('#deployTargetSpace').val(),
            appName = $('#appName').val(),
            cfInfoId = $('#cfInfoId').val(),
            buildJobId = $('#buildJobId').val(),
            deployType = $('#deployType').val(),
            blueGreenDeployStatus = $('#blueGreenDeployStatus').val();

        // CHECK DEPLOY TYPE AND BLUE GREEN DEPLOY STATUS
        if ("<%= Constants.DeployType.DEV %>" !== deployType && "<%= Constants.BlueGreenDeployStatus.BLUE_DEPLOY %>" === blueGreenDeployStatus) {
            procPopupAlert("Operational GREEN Deployment cannot be modified if in progress or when completed");
            return false;
        }

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("Enter a job name.", "$('#jobName').focus();");
            return false;
        }

        // CHECK CF INFO
        if (procIsNullString(cfInfoId)) {
            procPopupAlert("Enter your Cloud Foundry information.", "$('#cfInfoId').focus();");
            return false;
        }

        // CHECK DEPLOY TARGET SPACE
        if (procIsNullString(deployTargetSpace)) {
            procPopupAlert("Enter space.", "$('#deployTargetSpace').focus();");
            return false;
        }

        // CHECK APP NAME
        if (procIsNullString(appName)) {
            procPopupAlert("Enter the application name.", "$('#appName').focus();");
            return false;
        }

        // CHECK BUILD JOB ID
        if (procIsNullString(buildJobId)) {
            procPopupAlert("Select a staging item.", "$('#buildJobId').focus();");
            return false;
        }

        var reqParam = {
            id: doc.getElementById('jobId').value,
            serviceInstancesId: doc.getElementById('serviceInstancesId').value,
            pipelineId: doc.getElementById('pipelineIdControlAuthority').value,
            jobGuid: doc.getElementById('jobGuid').value,
            jobName: jobName,
            jobType: doc.getElementById('jobType').value,
            deployType: doc.getElementById('deployType').value,
            blueGreenDeployStatus: doc.getElementById('blueGreenDeployStatus').value,
            groupOrder: doc.getElementById('groupOrder').value,
            jobOrder: doc.getElementById('jobOrder').value,
            cfInfoId: doc.getElementById('cfInfoId').value,
            deployTargetOrg: doc.getElementById('deployTargetOrg').value,
            deployTargetSpace: doc.getElementById('deployTargetSpace').value,
            appName: doc.getElementById('appName').value,
            manifestUseYn: doc.getElementById('manifestUseYn').value,
            manifestScript: doc.getElementById('manifestScript').value,
            buildJobId: doc.getElementById('buildJobId').value,
            jobTrigger: $(':input:radio[name=deployJobTrigger]:checked').val(),
            postActionYn: "<%= Constants.CHECK_YN_N %>",
            newWorkGroupYn: "<%= Constants.CHECK_YN_N %>",
            created: doc.getElementById('created').value
        };

        procCallSpinner(SPINNER_START);
        procCallAjax(JOB_PIPELINE_URL + "/deploy/update.do", reqParam, callbackUpdateJob);
    };


    // CALLBACK UPDATE JOB
    var callbackUpdateJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        procCallSpinner(SPINNER_STOP);
        procPopupAlert('Changed', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // BIND
    $("#cfInfoId").on("change", function(){
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
    $("#btnUpdate").on("click", function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "job", "deployUpdate");
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                    procPopupAlert("You do not have permission.");
                }else{
                    updateJob();
                }
            }
        }*/
    });


    // BIND
    $("#btnCancel").on("click", function() {
        procMovePage(-1);
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        //getGrantedAuthorities();
        getPipeline();
        $('#jobName').putCursorAtEnd();
    });

</script>
