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
                            <input type="text" class="input-medium" id="testJobType" name="testJobType" title="" value="Test (Test)" disabled>
                            <ul>
                                <li><input type="checkbox" id="testJobPostActionYn" value="" title=""> Abort the execution of the connected task if this task fails</li>
                            </ul>
                        </div>
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
                                <select class="input-medium" title="" id="inspectionProfileKey">
                                    <option value="">Select a quality profile</option>
                                </select>
                            </div>
                            <div class="formBox">
                                <select class="input-medium" title="" id="inspectionGateId">
                                    <option value="">Quality gate selection</option>
                                </select>
                            </div>
                            <div class="formBox">
                                <select class="input-medium" title="" id="buildJobId">
                                    <option value="">Staging selection</option>
                                </select>
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                    <div class="form_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">JACOCO plugin script</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <p class="jacocoPluginScript gradle" style="margin: 10px 0;" title="JACOCO PLUGIN SCRIPT FOR GRADLE">GRADLE</p>
                                <textarea id="jacocoPluginScriptGradle" class="input-medium view-off" cols="30" rows="12" title="JACOCO PLUGIN SCRIPT FOR GRADLE" style="display: none;"># Add the following script to your build.gradle file.
apply plugin: 'jacoco'

jacoco {
    toolVersion = "0.7.9+"
}

test {
    jacoco {
        destinationFile = file("$buildDir/jacoco/jacoco-overall.exec")
    }
}</textarea>
                            </div>
                            <div class="formBox">
                                <p class="jacocoPluginScript maven" style="margin: 10px 0;" title="JACOCO PLUGIN SCRIPT FOR MAVEN">MAVEN</p>
                                <textarea id="jacocoPluginScriptMaven" class="input-medium view-off" cols="30" rows="18" title="JACOCO PLUGIN SCRIPT FOR MAVEN" style="display: none;"># Add the following script to your pom.xml file.
<build>
    <plugins>
        <plugin>
            <groupId>org.jacoco</groupId>
            <artifactId>jacoco-maven-plugin</artifactId>
            <version>0.7.9</version>
            <executions>
                <execution>
                    <id>default-prepare-agent</id>
                    <goals>
                        <goal>prepare-agent</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build></textarea>
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
                                <c:forEach items="${testJobTriggerTypeList}" var="item" varStatus="status">
                                    <c:choose>
                                        <c:when test="${0 == status.index}">
                                            <li><input type="radio" name="testJobTrigger" value="${item.typeName}" checked title="">${item.typeValue}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><input type="radio" name="testJobTrigger" value="${item.typeName}" title="">${item.typeValue}</li>
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
                        <button type="button" class="button btn_default" title="Save" id="btnUpdate">저장</button>
                        <button type="button" class="button btn_default" title="Cancel" id="btnCancel">취소</button>
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
<input type="hidden" id="builderType" name="builderType" value="" />
<input type="hidden" id="created" name="created" value="" />

<input type="hidden" id="inspectionProjectId" name="inspectionProjectId" value="" />
<input type="hidden" id="repositoryType" name="repositoryType" value="" />
<input type="hidden" id="repositoryUrl" name="repositoryUrl" value="" />
<input type="hidden" id="repositoryAccountId" name="repositoryAccountId" value="" />
<input type="hidden" id="repositoryAccountPassword" name="repositoryAccountPassword" value="" />
<input type="hidden" id="repositoryId" name="repositoryId" value="" />
<input type="hidden" id="repositoryBranch" name="repositoryBranch" value="" />
<input type="hidden" id="repositoryCommitRevision" name="repositoryCommitRevision" value="" />
<input type="hidden" id="originalInspectionProfileKey" name="originalInspectionProfileKey" value="" />
<input type="hidden" id="originalInspectionGateId" name="originalInspectionGateId" value="" />
<input type="hidden" id="originalBuildJobId" name="originalBuildJobId" value="" />

<script type="text/javascript">

    var gBuildToolTypeGradle = "gradle";
    var gBuildToolTypeMaven = "maven";
    var gJacocoPluginScriptGradle = "jacocoPluginScriptGradle";
    var gJacocoPluginScriptMaven = "jacocoPluginScriptMaven";


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
            inspectionProfileKey = data.inspectionProfileKey,
            inspectionGateId = data.inspectionGateId,
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
        doc.getElementById('inspectionProjectId').value = data.inspectionProjectId;
        doc.getElementById('inspectionProfileKey').value = inspectionProfileKey;
        doc.getElementById('inspectionGateId').value = inspectionGateId;
        doc.getElementById('repositoryType').value = data.repositoryType;
        doc.getElementById('repositoryUrl').value = data.repositoryUrl;
        doc.getElementById('repositoryAccountId').value = data.repositoryAccountId;
        doc.getElementById('repositoryAccountPassword').value = data.repositoryAccountPassword;
        doc.getElementById('repositoryBranch').value = data.repositoryBranch;
        doc.getElementById('repositoryId').value = data.repositoryId;
        doc.getElementById('repositoryBranch').value = data.repositoryBranch;
        doc.getElementById('repositoryCommitRevision').value = data.repositoryCommitRevision;
        doc.getElementById('builderType').value = data.builderType;
        doc.getElementById('created').value = data.created;

        doc.getElementById('originalInspectionProfileKey').value = inspectionProfileKey;
        doc.getElementById('originalInspectionGateId').value = inspectionGateId;
        doc.getElementById('originalBuildJobId').value = buildJobId;

        if ("<%= Constants.CHECK_YN_Y %>" === data.postActionYn) {
            $('#testJobPostActionYn').prop('checked', true);
        }

        $("input:radio[name='testJobTrigger']:radio[value='" + data.jobTrigger + "']").attr("checked", true);

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
            originalInspectionProfileKey = $('#originalInspectionProfileKey').val(),
            inspectionProfileKey = '',
            selectedCss = '',
            profileName = '',
            listNumber = 0,
            htmlString = [];

        htmlString.push('<option value="">Select a quality profile</option>');

        for (var i = 0; i < listLength; i++) {
            inspectionProfileKey = data[i].key;
            selectedCss = (originalInspectionProfileKey === inspectionProfileKey)? ' selected' : '';
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
            originalInspectionGateId = parseInt($('#originalInspectionGateId').val(), 10),
            inspectionGateId = '',
            selectedCss = '',
            listNumber = 0,
            htmlString = [];

        htmlString.push('<option value="">Quality gate selection</option>');

        for (var i = 0; i < listLength; i++) {
            inspectionGateId = parseInt(data[i].id, 10);
            selectedCss = (originalInspectionGateId === inspectionGateId)? ' selected' : '';
            listNumber++;
            htmlString.push('<option value="' + inspectionGateId + '"' + selectedCss + '>' + listNumber + '. ' + data[i].name + '</option>');
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
            postActionYn = "<%= Constants.CHECK_YN_N %>",
            jobName = $('#jobName').val(),
            inspectionProfileKey = $('#inspectionProfileKey').val(),
            inspectionGateId = $('#inspectionGateId').val(),
            buildJobId = $('#buildJobId').val();

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("Enter a job name.", "$('#jobName').focus();");
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
            procPopupAlert("Select a staging item.", "$('#buildJobId').focus();");
            return false;
        }

        var reqParam = {
            id: doc.getElementById('jobId').value,
            serviceInstancesId: doc.getElementById('serviceInstancesId').value,
            pipelineId: doc.getElementById('pipelineIdControlAuthority').value,
            jobGuid: doc.getElementById('jobGuid').value,
            groupOrder: doc.getElementById('groupOrder').value,
            jobOrder: doc.getElementById('jobOrder').value,
            buildJobId: buildJobId,
            pipelineName: $('#pipelineName').html(),
            jobName: jobName,
            jobType: doc.getElementById('jobType').value,
            postActionYn: postActionYn,
            jobTrigger: $(':input:radio[name=testJobTrigger]:checked').val(),
            inspectionProfileKey: inspectionProfileKey,
            inspectionGateId: inspectionGateId,
            builderType: doc.getElementById('builderType').value,
            repositoryType: doc.getElementById('repositoryType').value,
            repositoryUrl: doc.getElementById('repositoryUrl').value,
            repositoryAccountId: doc.getElementById('repositoryAccountId').value,
            repositoryAccountPassword: doc.getElementById('repositoryAccountPassword').value,
            repositoryBranch: doc.getElementById('repositoryBranch').value,
            repositoryId: doc.getElementById('repositoryId').value,
            repositoryCommitRevision: doc.getElementById('repositoryCommitRevision').value,
            created: doc.getElementById('created').value
        };

        procCallSpinner(SPINNER_START);
        procCallAjax(JOB_PIPELINE_URL + "/test/update.do", reqParam, callbackUpdateJob);
    };


    // CALLBACK UPDATE JOB
    var callbackUpdateJob = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        procPopupAlert('Changed', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // BIND
    $("#btnUpdate").on("click", function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "job", "testUpdate");
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

        //getGrantedAuthorities();
        getPipeline();
        $('#jobName').putCursorAtEnd();
    });

</script>
