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
        <!-- 타이틀 :s -->
        <h3 class="sub_title">구성상세</h3>
        <!--//타이틀 :e -->
        <!-- sub content :s -->
        <div class="sub_content">
            <!-- form (contBox) -->
            <div class="contBox">
                <!-- 내작업 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">내 작업</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="jobName" name="jobName" title="" value="" maxlength="25" placeholder="작업명">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//내작업 -->
                <!-- 작업 유형 (Job) -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">작업 유형 (Job)</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="testJobType" name="testJobType" title="" value="테스트 (Test)" disabled>
                            <ul>
                                <li><input type="checkbox" id="testJobPostActionYn" value="" title=""> 이 작업에 실패하는 경우 연결 작업 실행 중단</li>
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
                            <p class="title">입력 유형</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <select class="input-medium" title="" id="inspectionProfileId">
                                    <option value="">품질 프로파일 선택</option>
                                </select>
                            </div>
                            <div class="formBox">
                                <select class="input-medium" title="" id="inspectionGateId">
                                    <option value="">품질 게이트 선택</option>
                                </select>
                            </div>
                            <div class="formBox">
                                <select class="input-medium" title="" id="buildJobId">
                                    <option value="">스테이징 선택</option>
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
                        <p class="sub_title">작업 트리거 (Job Trigger)</p>
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
                        <button type="button" class="button btn_default" title="저장" id="btnUpdate">저장</button>
                        <button type="button" class="button btn_default" title="취소" id="btnCancel">취소</button>
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


<script type="text/javascript">

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

        var doc = document;

        doc.getElementById('jobId').value = data.id;
        doc.getElementById('buildJobId').value  = data.buildJobId;
        doc.getElementById('serviceInstancesId').value = data.serviceInstancesId;
        doc.getElementById('pipelineIdControlAuthority').value = data.pipelineId;
        doc.getElementById('jobGuid').value = data.jobGuid;
        doc.getElementById('jobName').value = data.jobName;
        doc.getElementById('jobType').value = data.jobType;
        doc.getElementById('groupOrder').value = data.groupOrder;
        doc.getElementById('jobOrder').value = data.jobOrder;
        doc.getElementById('inspectionProjectId').value = data.inspectionProjectId;
        doc.getElementById('inspectionProfileId').value = data.inspectionProfileId;
        doc.getElementById('inspectionGateId').value = data.inspectionGateId;
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

        if ("<%= Constants.CHECK_YN_Y %>" === data.postActionYn) {
            $('#testJobPostActionYn').prop('checked', true);
        }

        $("input:radio[name='testJobTrigger']:radio[value='" + data.jobTrigger + "']").attr("checked", true);

        getBuildJobList();
    };


    // GET QUALITY PROFILE LIST
    var getQualityProfileList = function() {
        var reqUrl = INSPECTION_PIPELINE_URL + '/getQualityProfileList.do?pipelineId=<c:out value='${pipelineId}' default='' />';
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
            listNumber = 0,
            htmlString = [];

        htmlString.push('<option value="">품질 프로파일 선택</option>');

        for (var i = 0; i < listLength; i++) {
            selectedCss = (listNumber === 0)? ' selected' : '';
            listNumber++;
            htmlString.push('<option value="' + data[i].id + '"' + selectedCss + '>' + listNumber + '. ' + data[i].name + '</option>');
        }

        $('#inspectionProfileId').html(htmlString);

        procCallSpinner(SPINNER_STOP);
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

        htmlString.push('<option value="">품질 게이트 선택</option>');

        for (var i = 0; i < listLength; i++) {
            selectedCss = (listNumber === 0)? ' selected' : '';
            listNumber++;
            htmlString.push('<option value="' + data[i].id + '"' + selectedCss + '>' + listNumber + '. ' + data[i].name + '</option>');
        }

        $('#inspectionGateId').html(htmlString);

        procCallSpinner(SPINNER_STOP);
    };


    // GET BUILD JOB LIST
    var getBuildJobList = function() {
        var reqUrl = JOB_PIPELINE_URL + "/list.do?pipelineId=<c:out value='${pipelineId}' default='' />&jobType=<%= Constants.JOB_TYPE_BUILD %>";
        procCallAjax(reqUrl, null, callbackGetBuildJobList);
    };


    // CALLBACK GET BUILD JOB LIST
    var callbackGetBuildJobList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.length,
            selectedCss = '',
            listNumber = 0,
            htmlString = [];

        for (var i = 0; i < listLength; i++) {
            if (data[i].groupOrder === parseInt(document.getElementById('groupOrder').value, 10)) {
                selectedCss = (listNumber === 0)? ' selected' : '';
                listNumber++;
                htmlString.push('<option value="' + data[i].id + '"' + selectedCss + '>' + listNumber + '. ' + data[i].jobName + '</option>');
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
            inspectionProfileId = $('#inspectionProfileId').val(),
            inspectionGateId = $('#inspectionGateId').val(),
            buildJobId = $('#buildJobId').val();

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("작업명을 입력하십시오.", "$('#jobName').focus();");
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
            procPopupAlert("스테이징 항목을 선택하십시오.", "$('#buildJobId').focus();");
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
            inspectionProfileId: inspectionProfileId,
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

        procPopupAlert('수정 되었습니다.', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // BIND
    $("#btnUpdate").on("click", function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "job", "testUpdate");
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                    procPopupAlert("권한이 없습니다.");
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
        getJob();
        getQualityProfileList();
        getQualityGateList();
        $('#jobName').putCursorAtEnd();
    });

</script>
