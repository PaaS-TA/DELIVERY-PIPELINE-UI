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
                            <input type="text" class="input-medium" id="buildJobType" name="buildJobType" title="" value="Build (Build)" disabled>
                        </div>
                        <!--2뎁스 영역-->
                        <p class="sub_title">Builder type (type)</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="builderType">
                                <option value="">Select a builder</option>
                                <c:forEach items="${builderTypeList}" var="item" varStatus="status">
                                    <option value="${item.typeName}">${item.typeValue}</option>
                                </c:forEach>
                            </select>
                            <p class="txt_help"><input type="checkbox" id="buildJobPostActionYn" value="" title=""> Abort the execution of the connected task if this task fails</p>
                        </div>
                        <!--//2뎁스 영역-->

                    </div>
                    <!--//form 영역-->
                </div>
                <!--//작업 유형 (Job) -->
                <!-- 공통영역(입력유형) -->
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
                                <select class="input-medium" title="" id="repositoryType">
                                    <option value="">Select input type</option>
                                    <c:forEach items="${repositoryTypeList}" var="item" varStatus="status">
                                        <option value="${item.typeName}">${item.typeValue}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--2뎁스 영역-->
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryAccountId" name="repositoryAccountId" title="" value="" maxlength="25" placeholder="Enter ID">
                            </div>
                            <div class="formBox">
                                <input type="password" class="input-medium" id="repositoryAccountPassword" name="repositoryAccountPassword" title="" value="" maxlength="150" placeholder="Password (In case of Github, enter token)">&emsp;
                                <label id="githubTokenGuide" style="display: none;"><a href="https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token" target="_blank" title="Creating a personal access token">※ Github Access Token Creation Guide</a></label>
                            </div>
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryUrl" name="repositoryUrl" title="" value="" maxlength="200" placeholder="Enter the repository path">
                            </div>
                            <!--//2뎁스 영역-->
                            <!--버튼 영역-->
                            <div class="btn_Area plr20" id="btnGetBranchListWrapper">
                                <div class="fr">
                                    <button type="button" class="button btn_regist" title="Lookup" id="btnGetBranchList">Search</button>
                                </div>
                            </div>
                            <!--//버튼 영역-->
                            <!-- 브랜치 (Branch) -->
                            <div id="repositoryBranchWrapper" style="display: none;">
                                <p class="sub_title">Branch (Branch)</p>
                                <div class="formBox">
                                    <select class="input-medium" title="" id="repositoryBranch">
                                        <option value="">Branches</option>
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
                        <p class="sub_title">Job trigger (Job Trigger)</p>
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
        doc.getElementById('builderType').value = data.builderType;
        doc.getElementById('created').value = data.created;

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
            procPopupAlert("Select an input type.");
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
    var callbackGetBranchList = function(data) {
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

            $('#originalRepositoryId').val(data.repositoryId);
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

        $('#originalRepositoryId').val(data.repositoryId);
        updateJob();
    };


    // UPDATE JOB
    var updateJob = function() {
        var doc = document,
            postActionYn = "<%= Constants.CHECK_YN_N %>",
            jobName = $('#jobName').val(),
            builderType = $('#builderType').val(),
            repositoryType = $('#repositoryType').val(),
            repositoryBranch = doc.getElementById('repositoryBranch').value;

        // CHECK JOB NAME
        if (procIsNullString(jobName)) {
            procPopupAlert("Enter a job name.", "$('#jobName').focus();");
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

        // CHECK UPDATED REPOSITORY BRANCH
        if (repositoryBranch === "") {
            repositoryBranch = doc.getElementById('originalRepositoryBranch').value
        }

        // GET POST ACTION
        if ($("#buildJobPostActionYn").is(":checked")) {
            postActionYn = "<%= Constants.CHECK_YN_Y %>";
        }

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
            builderType: doc.getElementById('builderType').value,
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
        procPopupAlert('Changed', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
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
            procPopupAlert("Check the repository path.", "$('#repositoryUrl').focus();");
            return false;
        }

        if ("<%= Constants.REPOSITORY_TYPE_SCM_SVN %>" === doc.getElementById('repositoryType').value) {
            getScmSvnInfo();
        } else {
            getGrantedAuthorities(doc.getElementById('pipelineIdControlAuthority').value, "job", "update");
            /*for(var i = 0; i < grAry.length; i++){
                if(grAry[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                    if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                        procPopupAlert("You do not have permission.");
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


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        getPipeline();
        $('#jobName').putCursorAtEnd();
    });

</script>
