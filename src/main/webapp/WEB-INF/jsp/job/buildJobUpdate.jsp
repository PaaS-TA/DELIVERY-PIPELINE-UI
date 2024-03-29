<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 5/18/2017
  Time: 9:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                            <input type="text" class="input-medium" id="buildJobType" name="buildJobType" title="" value="빌드 (Build)" disabled>
                        </div>

                        <!--2뎁스 영역-->
                        <p class="sub_title">언어유형 (type)</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="codeList" style="display:none">
                                <c:forEach items="${codeList}" var="item" varStatus="status">
                                    <option value="${item.codeValue}" data-type="${item.codeType}" data-group="${item.codeGroup}">${item.codeName}</option>
                                </c:forEach>
                            </select>
                            <select class="input-medium" title="" id="languageType">
                                <option value="" data-type="" data-group="">언어 유형 선택</option>
                                <c:forEach items="${codeList}" var="item" varStatus="status">
                                    <c:if test="${item.codeType eq 'language_type'}">
                                        <option value="${item.codeValue}" data-type="${item.codeType}" data-group="${item.codeGroup}">${item.codeName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                            <select class="input-medium" title="" id="languageTypeVersion">
                                <option value="" data-type="" data-group="">언어 버전 선택</option>
                            </select>
                        </div>
                        <!--//2뎁스 영역-->
                        <!--2뎁스 영역-->
                        <p class="sub_title">빌더유형 (type)</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="builderType">
                                <option value="" data-type="" data-group="">빌더 유형 선택</option>
                            </select>
                            <select class="input-medium" title="" id="builderTypeVersion">
                                <option value="" data-type="" data-group="">빌더 버전 선택</option>
                            </select>
                            <p class="txt_help"><input type="checkbox" id="buildJobPostActionYn" value="" title=""> 이 작업에 실패하는 경우 연결 작업 실행 중단</p>
                        </div>
                        <!--//2뎁스 영역-->
                        <!--2뎁스 영역(COMMAND) -->
                        <div id="commandScriptWrapper" style="display:none">
                            <p class="sub_title">COMMAND</p>
                            <div class="formBox">
                                <textarea class="input-medium" name="commandScript" id="commandScript" cols="30" rows="6" title="">#PHP - COMPOSER 예제
cd $WORKSPACE

files=$(ls 'composer.json' 2> /dev/null | wc -l)
if [ "$files" != "0" ]
then
    rm -rf vendor/*
    composer install
else
    echo "composer.json Not found."
    exit 1
fi
                                </textarea>
                            </div>
                        </div>
                        <!--2뎁스 영역(COMMAND) -->

                    </div>
                    <!--//form 영역-->
                </div>
                <!--//작업 유형 (Job) -->
                <!-- 공통영역(입력유형) -->
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
                                <select class="input-medium" title="" id="repositoryType">
                                    <option value="">입력유형 선택</option>
                                    <c:forEach items="${repositoryTypeList}" var="item" varStatus="status">
                                        <option value="${item.typeName}">${item.typeValue}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--2뎁스 영역-->
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryAccountId" name="repositoryAccountId" title="" value="" maxlength="25" placeholder="아이디 입력">
                            </div>
                            <div class="formBox">
                                <input type="password" class="input-medium" id="repositoryAccountPassword" name="repositoryAccountPassword" title="" value="" maxlength="150" placeholder="비밀번호 ( Github의 경우 token 입력)">&emsp;
                                <label id="githubTokenGuide" style="display: none;"><a href="https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token" target="_blank" title="Creating a personal access token">※ Github Access Token 생성 가이드</a></label>
                            </div>
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryUrl" name="repositoryUrl" title="" value="" maxlength="200" placeholder="레파지토리 경로 입력">
                            </div>
                            <!--//2뎁스 영역-->
                            <!--버튼 영역-->
                            <div class="btn_Area plr20" id="btnGetBranchListWrapper">
                                <div class="fr">
                                    <button type="button" class="button btn_regist" title="조회" id="btnGetBranchList">조회</button>
                                </div>
                            </div>
                            <!--//버튼 영역-->
                            <!-- 브랜치 (Branch) -->
                            <div id="repositoryBranchWrapper" style="display: none;">
                                <p class="sub_title">브랜치 (Branch)</p>
                                <div class="formBox">
                                    <select class="input-medium" title="" id="repositoryBranch">
                                        <option value="">브랜치 목록</option>
                                    </select>
                                </div>
                            </div>
                            <!--//브랜치 (Branch) -->
                        </div>
                        <!--//form 영역-->
                    </div>
                </div>
                <!--//공통영역(입력유형) -->
                <!-- 작업 트리거 (Job Trigger) -->
                <div class="form_info">
                    <div class="form_right">
                        <!--2뎁스 영역-->
                        <p class="sub_title">작업 트리거 (Job Trigger)</p>
                        <div class="formBox">
                            <ul>
                                <c:forEach items="${buildJobTriggerTypeList}" var="item" varStatus="status">
                                    <c:choose>
                                        <c:when test="${0 == status.index}">
                                            <li><input type="radio" name="buildJobTrigger" value="${item.typeName}" checked title="">${item.typeValue}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><input type="radio" name="buildJobTrigger" value="${item.typeName}" title="">${item.typeValue}</li>
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
<input type="hidden" id="created" name="created" value="" />
<input type="hidden" id="originalRepositoryId" name="originalRepositoryId" value="" />
<input type="hidden" id="originalRepositoryBranch" name="originalRepositoryBranch" value="" />


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
            repositoryType = data.repositoryType;

        doc.getElementById('jobId').value = data.id;
        doc.getElementById('serviceInstancesId').value = data.serviceInstancesId;
        doc.getElementById('pipelineIdControlAuthority').value = data.pipelineId;
        doc.getElementById('jobGuid').value = data.jobGuid;
        doc.getElementById('jobName').value = data.jobName;
        doc.getElementById('jobType').value = data.jobType;
        doc.getElementById('groupOrder').value = data.groupOrder;
        doc.getElementById('jobOrder').value = data.jobOrder;
        doc.getElementById('repositoryType').value = repositoryType;
        doc.getElementById('repositoryUrl').value = data.repositoryUrl;
        doc.getElementById('repositoryAccountId').value = data.repositoryAccountId;
        doc.getElementById('repositoryAccountPassword').value = data.repositoryAccountPassword;
        doc.getElementById('repositoryBranch').value = data.repositoryBranch;
        doc.getElementById('originalRepositoryId').value = data.repositoryId;
        doc.getElementById('originalRepositoryBranch').value = data.repositoryBranch;

        doc.getElementById('languageType').value = data.languageType;
        $("#languageType").val(data.languageType).trigger('change');
        doc.getElementById('languageTypeVersion').value = data.languageTypeVersion;
        doc.getElementById('builderType').value = data.builderType;
        $("#builderType").val(data.builderType).trigger('change');
        doc.getElementById('builderTypeVersion').value = data.builderTypeVersion;
        doc.getElementById('created').value = data.created;
        doc.getElementById('commandScript').value = data.manifestScript;


        if ("<%= Constants.CHECK_YN_Y %>" === data.postActionYn) {
            $('#buildJobPostActionYn').prop('checked', true);
        }

        $("input:radio[name='buildJobTrigger']:radio[value='" + data.jobTrigger + "']").attr("checked", true);
        setViewGetBranchListButton(repositoryType);

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
            procPopupAlert("입력 유형을 선택하십시오.");
            return false;
        }

        // EXCEPT SVN
        if ("<%= Constants.REPOSITORY_TYPE_SCM_SVN %>" === repositoryType) {
            // TODO
            // HIDE BRANCH SEARCH BUTTON
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
        var resultTagList = data.repositoryTagList;

        if (resultList !== null) {
            var brancheListCount = resultList.length,
                tempListItem = '',
                selectedCss = '',
                htmlString = [];

            for (var i = 0; i < brancheListCount; i++) {
                tempListItem = resultList[i];
                selectedCss = (tempListItem === "master")? ' selected' : '';
                htmlString.push('<option value="' + tempListItem + '"' + selectedCss + '>[Branches] ' + tempListItem + '</option>');
            }

            if(resultTagList !== null) {
                for (var i = 0; i < resultTagList.length; i++) {
                    tempListItem = resultTagList[i];
                    htmlString.push('<option value="refs/tags/' + tempListItem + '">[Tags] ' + tempListItem + '</option>');
                }
            }

            $('#repositoryId').val(data.repositoryId);
            $('#repositoryBranch').html(htmlString);
            $('#repositoryBranchWrapper').show();

            $('#repositoryBranch').val($('#originalRepositoryBranch').val());

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

        $('#originalRepositoryId').val(data.repositoryId);
        updateJob();
    };


    // UPDATE JOB
    var updateJob = function() {
        var doc = document,
            postActionYn = "<%= Constants.CHECK_YN_N %>",
            jobName = $('#jobName').val(),
            languageType = $('#languageType').val(),
            languageTypeVersion = $('#languageTypeVersion').val(),
            builderType = $('#builderType').val(),
            builderTypeVersion = $('#builderTypeVersion').val(),
            repositoryType = $('#repositoryType').val(),
            repositoryBranch = doc.getElementById('repositoryBranch').value;

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("작업명을 입력하십시오.", "$('#jobName').focus();");
            return false;
        }

        // CHECK BUILDER TYPE
        if (procIsNullString(languageType)) {
            procPopupAlert("언어 유형을 입력하십시오.", "$('#languageType').focus();");
            return false;
        }

        // CHECK BUILDER TYPE VERSION
        if (procIsNullString(languageTypeVersion)  && !$('#languageTypeVersion').is(":disabled")) {
            procPopupAlert("언어 버전을 입력하십시오.", "$('#languageTypeVersion').focus();");
            return false;
        }

        // CHECK BUILDER TYPE
        if (procIsNullString(builderType)  && !$('#builderType').is(":disabled")) {
            procPopupAlert("빌더 유형을 입력하십시오.", "$('#builderType').focus();");
            return false;
        }

        // CHECK BUILDER TYPE VERSION
        if (procIsNullString(builderTypeVersion)  && !$('#builderTypeVersion').is(":disabled")) {
            procPopupAlert("빌더 버전을 입력하십시오.", "$('#builderTypeVersion').focus();");
            return false;
        }

        // CHECK REPOSITORY TYPE
        if (procIsNullString(repositoryType)) {
            procPopupAlert("입력 유형을 입력하십시오.", "$('#repositoryType').focus();");
            return false;
        }

        // CHECK UPDATED REPOSITORY BRANCH
        if (repositoryBranch === "") {
            repositoryBranch = doc.getElementById('originalRepositoryBranch').value
        }

        // GET POST ACTION
        if ($("#buildJobPostActionYn").is(":checked")) {
            postActionYn = "<%= Constants.CHECK_YN_Y %>";
        }

        // COMMAND
        var commandScript = (languageType != "JAVA") ? $("#commandScript").val() : "";

        var reqParam = {
            id: doc.getElementById('jobId').value,
            serviceInstancesId: doc.getElementById('serviceInstancesId').value,
            pipelineId: doc.getElementById('pipelineIdControlAuthority').value,
            jobGuid: doc.getElementById('jobGuid').value,
            jobName: doc.getElementById('jobName').value,
            jobType: doc.getElementById('jobType').value,
            postActionYn: postActionYn,
            jobTrigger: $(':input:radio[name=buildJobTrigger]:checked').val(),
            groupOrder: doc.getElementById('groupOrder').value,
            jobOrder: doc.getElementById('jobOrder').value,
            repositoryType: repositoryType,
            repositoryUrl: doc.getElementById('repositoryUrl').value,
            repositoryAccountId: doc.getElementById('repositoryAccountId').value,
            repositoryAccountPassword: doc.getElementById('repositoryAccountPassword').value,
            repositoryBranch: repositoryBranch,
            repositoryId: doc.getElementById('originalRepositoryId').value,
            languageType: doc.getElementById('languageType').value,
            languageTypeVersion: doc.getElementById('languageTypeVersion').value,
            builderType: doc.getElementById('builderType').value,
            builderTypeVersion: doc.getElementById('builderTypeVersion').value,
            manifestScript: commandScript,
            created: doc.getElementById('created').value
        };

        procCallSpinner(SPINNER_START);
        procCallAjax(JOB_PIPELINE_URL + "/build/update.do", reqParam, callbackUpdateJob);
    };


    // CALLBACK UPDATE JOB
    var callbackUpdateJob = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        procCallSpinner(SPINNER_STOP);
        procPopupAlert('수정 되었습니다.', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // BIND
    $("#repositoryType").on("change", function() {
        setViewGetBranchListButton($(this).val());
    });


    // BIND
    $("#btnGetBranchList").on("click", function() {
        getBranchList();
    });


    // BIND
    $("#btnUpdate").on("click", function() {
        var doc = document;

        // CHECK REPOSITORY URL
        if (doc.getElementById('repositoryUrl').value.indexOf(" ") > -1) {
            procPopupAlert("레파지토리 경로를 확인하십시오.", "$('#repositoryUrl').focus();");
            return false;
        }

        if ("<%= Constants.REPOSITORY_TYPE_SCM_SVN %>" === doc.getElementById('repositoryType').value) {
            getScmSvnInfo();
        } else {
            getGrantedAuthorities(doc.getElementById('pipelineIdControlAuthority').value, "job", "update");
            /*for(var i = 0; i < grAry.length; i++){
                if(grAry[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                    if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                        procPopupAlert("권한이 없습니다.");
                    }else{
                        updateJob();
                    }
                }
            }*/
        }
    });


    // BIND
    $("#btnCancel").on("click", function() {
        procMovePage(-1);
    });

    var getCamelCase = function(str){
        return str.toLowerCase().replace(/[^a-zA-Z0-9]+(.)/g, (m, chr) => chr.toUpperCase());
    }

    var setSelectDisabled = function(){
        if($("#languageType").val() != "JAVA"){
            $("#languageTypeVersion").attr("disabled",true);
            $("#builderType").attr("disabled",true);
            $("#builderTypeVersion").attr("disabled",true);
            $("#commandScriptWrapper").show();
        }else{
            $("#languageTypeVersion").attr("disabled",false);
            $("#builderType").attr("disabled",false);
            $("#builderTypeVersion").attr("disabled",false);
            $("#commandScriptWrapper").hide();
        }
    };

    var codeListOption = $("#codeList").find("option");
    $("#languageType, #builderType").on("change", function() {
        var codeValue = $(this).val();

        setSelectDisabled();

        if($(this).attr("id") == "languageType"){
            $("#"+$(this).attr("id")+"Version").children("option:not(:first)").remove();
            $("#builderType").children("option:not(:first)").remove();
            $("#builderTypeVersion").children("option:not(:first)").remove();
        }else{
            $("#"+$(this).attr("id")+"Version").children("option:not(:first)").remove();
        }

        $(codeListOption).each(function(){
            if($(this).attr("data-group") == codeValue && $(this).attr("data-type") != "language_type"){
                $(this).prop("selected",false);
                $("#"+getCamelCase($(this).attr("data-type"))).append(this);
            }
        });
    });

    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        getPipeline();
        $('#jobName').putCursorAtEnd();
    });

</script>
