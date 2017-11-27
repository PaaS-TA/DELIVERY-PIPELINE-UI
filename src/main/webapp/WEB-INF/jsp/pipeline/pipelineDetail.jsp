<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-05-18
  Time: 오후 5:33
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
            <li><span id="pipelineName"></span></li>
        </ul>
        <div class="fr">
            <button type="button" class="button btn_default" title="정보보기/수정" id="btnUpdatePipeline">정보보기/수정</button>
            <button type="button" class="button btn_default" title="신규생성" id="btnCreatePipeline">신규생성</button>
        </div>
    </div>
</div>
<!--//이동경로 :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- sub_tab :s -->
        <div class="sub_tab">
            <ul>
                <li class="fst active"><a href="javascript:void(0);" onClick="procMovePipelineDetailTabPage('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_DETAIL %>');"><span class="file_on"></span>파이프라인 <span class="pl10" id="jobCount"></span></a></li><!--아이콘 on 파일네임 파일명_on 붙이면 됨-->
                <li class=""><a href="javascript:void(0);" onClick="procMovePipelineDetailTabPage('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_CONTRIBUTOR %>');"><span class="contributor"></span>참여자(Contributor) <span class="pl10" id="contributorCount"></span></a></li>
            </ul>
        </div>
        <!--//sub_tab :e -->
        <!-- sub탭 콘텐츠01 :s -->
        <div class="sub_tab_cont00">
            <div class="tab_content">
                <!-- 리스트 :s -->
                <div class="row" id="jobListWrap" style="display: none;">
                    <div class="processtype01 column5 section" id="jobListArea">
                    </div>
                </div>
                <!--//리스트 :e -->
                <!-- new job :s -->
                <div class="classification" id="classification1">
                    <div class="thumbnail" id="createJobButtonWrap" style="display: none;">
                        <div class="caption">
                            <h3>이곳을 클릭하여 새 작업 추가</h3>
                            <div class="toggler tooltips" data-container="body" data-placement="left" data-html="true" data-original-title="Click to open advance theme customizer panel" id="btnCreateJob" onclick="procMoveCreateJobPage();">
                                <i class="glyphicon glyphicon-plus"></i>
                            </div>
                        </div>
                    </div>
                    <!--//new job :e -->
                    <!-- 버튼 :s -->
                    <div class="fl">
                        <button type="button" class="button btn_default contributor-permission" title="새 작업 그룹 추가" id="btnAddNewGroup">새 작업 그룹 추가</button>
                    </div>
                    <!--//버튼 :e -->
                </div>

                <%--<div class="classification" id="classification2" style="display: none;">
                    <div style="width:292px;margin-bottom:25px;padding: 5px;border-radius: 3px;-webkit-transition: border .2s ease-in-out;-o-transition: border .2s ease-in-out;transition: border .2s ease-in-out;text-align:center;">
                        <div style="height:242px;max-height:242px;padding: 9px;margin:0 auto;font-size: 25px;font-weight: 300;text-align: center;display:table-cell;vertical-align:middle;">
                            현재 작업이 없습니다.
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
        <!--//sub탭 콘텐츠01 :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->


<input type="hidden" id="pipelineIdControlAuthority" name="pipelineIdControlAuthority" value="<c:out value='${pipelineId}' default='' />" />


<script type="text/javascript">

    var gCheckInit = 0;
    var gDelayTime = 5000;
    var gLastGroupOrder = 0;
    var gJobStatusTimerList = {};
    var gJobTitleList = [];


    // GET
    var getPipeline = function() {
        procCallAjax('/pipeline/pipelineDetail.do', {id : "<c:out value='${pipelineId}' default='' />"}, callbackGetPipeline);
    };


    // CALLBACK
    var callbackGetPipeline = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        $('#pipelineName').html(data.name);
    };


    // GET JOB LIST FROM DB
    var getJobListFromDb = function() {
        procCallAjax(JOB_PIPELINE_URL + '/list.do', null, callbackGetJobListFromDb);
    };


    // CALLBACK GET LIST FROM DB
    var callbackGetJobListFromDb = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var jobListArea = $('#jobListArea'),
            listLength = data.length,
            htmlString = [],
            groupWrapperStartCss = '',
            groupWrapperEndCss = '',
            objJobCount = $('#jobCount');

        jobListArea.html('');
        objJobCount.html(listLength);

        for (var i = 0; i < listLength; i++) {
            var groupOrder = data[i].groupOrder,
                jobOrder = data[i].jobOrder,
                jobId = data[i].id,
                lastJobStatus = data[i].lastJobStatus,
                previousJobStatus = '<%= Constants.RESULT_STATUS_SUCCESS %>',
                nextJobId = 0,
                backgroundString = '',
                nextGroupOrder;

            // SET LAST GROUP ORDER
            gLastGroupOrder = groupOrder;

            // CHECK LAST GROUP ORDER
            if (i < listLength - 1) {
                nextGroupOrder = data[i + 1].groupOrder;
                gLastGroupOrder = (gLastGroupOrder < nextGroupOrder) ? nextGroupOrder : gLastGroupOrder;
            }

            if (jobOrder === 1) {
                groupWrapperStartCss = '<ol>';
            }

            if ((groupOrder !== gLastGroupOrder) || (i === listLength - 1)) {
                groupWrapperEndCss = '</ol>';
                backgroundString = ' style="background: none;"';
            }

            // CHECK PREVIOUS JOB STATUS
            if (i > 0) {
                previousJobStatus = (jobOrder === 1) ? '<%= Constants.RESULT_STATUS_SUCCESS %>' : data[i - 1].lastJobStatus;
            }

            // SET NEXT JOB NUMBER
            if (i < listLength - 1) {
                nextJobId = data[i + 1].id;
            }

            htmlString.push(groupWrapperStartCss);
            htmlString.push('<li id="jobWrap_' + jobId + '"' + backgroundString + '>');
            htmlString.push(setJobDetailHtmlString(data[i]));
            htmlString.push('</li>');
            htmlString.push('<input type="hidden" id="jobIsBuilding_' + jobId + '" value="" />');
            htmlString.push('<input type="hidden" id="previousJobStatus_' + jobId + '" value="' + previousJobStatus + '" />');
            htmlString.push('<input type="hidden" id="nextJobId_' + jobId + '" value="' + nextJobId + '" />');
            htmlString.push(groupWrapperEndCss);

            groupWrapperStartCss = '';
            groupWrapperEndCss = '';

            startGetJobStatusTimer(jobId, data[i].lastSuccessJobNumber);

            if ('<%= Constants.RESULT_STATUS_JOB_WORKING %>' === lastJobStatus
                || '<%= Constants.RESULT_STATUS_BUILT_FILE_UPLOADING %>' === lastJobStatus) {
                $('#jobIsBuilding_' + jobId).val('<%= Constants.CHECK_YN_Y %>');
                procSetFadeInOutJobTitle(jobId, 'ADD');
            }
        }

        jobListArea.append(htmlString.join(''));

        if (listLength < 1) {
            $('#createJobButtonWrap').show();
        } else {
            $('#jobListWrap').show();
            //$('#classification2').hide();
        }

        if (0 === gCheckInit) {
            procCallSpinner(SPINNER_STOP);
            gCheckInit++;
        }

        var testPermissionContributor = 'permission_contributor';
        jobContributorGrantedAuthorities(grAry,  document.getElementById('pipelineIdControlAuthority').value, testPermissionContributor);
    };


    // SET JOB DETAIL HTML STRING
    var setJobDetailHtmlString = function (data) {
        var htmlString = [],
            jobType = data.jobType,
            jobId = data.id,
            jobGuid = data.jobGuid,
            groupOrder = data.groupOrder,
            jobOrder = data.jobOrder,
            lastJobOrder = data.lastJobOrder,
            jobName = data.jobName,
            jobNamePostfix = '',
            repositoryUrl = data.repositoryUrl,
            repositoryCommitRevision = data.repositoryCommitRevision,
            repositoryCommitRevisionPostfix = '',
            lastModifiedString = data.lastModifiedString,
            lastJobStatus = data.lastJobStatus,
            lastJobModified = data.lastJobModified,
            initJobStatusText = '실행 전',
            lastJobStatusText = initJobStatusText,
            lastJobModifiedText = initJobStatusText,
            portletBoxCss = ' wait',
            jobWrapTriggerStyle = '',
            jobWrapStopStyle = 'style="display: none;"',
            confirmMessage = '';

        if (null !== lastJobStatus && 'null' !== lastJobStatus) {
            if (lastJobStatus.indexOf('<%= Constants.RESULT_STATUS_SUCCESS %>') > -1) {
                lastJobStatusText = '실행완료';
                lastJobModifiedText = lastJobModified;
                portletBoxCss = ' success';
            }

            if ('<%= Constants.RESULT_STATUS_FAILURE %>' === lastJobStatus) {
                lastJobStatusText = '실패';
                lastJobModifiedText = lastJobModified;
                portletBoxCss = ' fail';
            }

            if ('<%= Constants.RESULT_STATUS_CANCELLED %>' === lastJobStatus) {
                lastJobStatusText = '취소';
                lastJobModifiedText = lastJobModified;
                portletBoxCss = ' retract';
            }

            if ('<%= Constants.RESULT_STATUS_ABORTED %>' === lastJobStatus) {
                lastJobStatusText = '중지';
                lastJobModifiedText = lastJobModified;
                portletBoxCss = ' retract';
            }

            if ('<%= Constants.RESULT_STATUS_JOB_WORKING %>' === lastJobStatus
                || '<%= Constants.RESULT_STATUS_BUILT_FILE_UPLOADING %>' === lastJobStatus) {
                lastJobStatusText = '실행 중';
                lastJobModifiedText = ' - ';
                portletBoxCss = ' custom-progress';
                jobWrapTriggerStyle = 'style="display: none;"';
                jobWrapStopStyle = '';
            }
        }

        var jobOrderListString = '';
        var arrangeJobNumber = 0;

        if (lastJobOrder > 1) {
            for (var i = 0; i < lastJobOrder; i++) {
                arrangeJobNumber = i + 1;

                if (arrangeJobNumber !== jobOrder) {
                    jobOrderListString += '<li><a href="javascript:void(0);" onclick="rearrangeJobOrder(\'' + jobId + '\', \'' + arrangeJobNumber + '\');">' + arrangeJobNumber + '</a></li>';
                }
            }

        } else {
            jobOrderListString = '<li><a href="javascript:void(0);"> - </a></li>';
        }


        if (jobName.length > 14) {
            jobNamePostfix = '...';
        }

        // BUILD JOB
        if ("<%= Constants.JOB_TYPE_BUILD %>" === jobType) {
            confirmMessage = '빌드 JOB';

            if (repositoryCommitRevision.length > 18) {
                repositoryCommitRevisionPostfix = '...';
            }

            htmlString.push('<div class="portlet box' + portletBoxCss + '" id="jobPortlet_' + jobId + '">');
            htmlString.push('<div class="portlet-title">');
            htmlString.push('<div class="caption" id="jobPortletTitle_' + jobId + '" title="' + jobName + '"> ');
            htmlString.push(jobOrder +  '. ' + jobName.substring(0, 12) + jobNamePostfix + '</div>');
            htmlString.push('<ul class="panel-tools">');
            htmlString.push('<li id="jobWrap_' + jobId + '_trigger" ' + jobWrapTriggerStyle + '>');
            htmlString.push('<a class="icon permission_contributor permission_contributorExecute" href="javascript:void(0);" title="실행" ');
            htmlString.push('onclick="triggerJob(\'' + jobId +  '\', \'' + confirmMessage + '\');">');
            htmlString.push('<i class="tool_ico_play" id="jobIcon_' + jobId + '"></i></a>');
            htmlString.push('</li>');
            htmlString.push('<li id="jobWrap_' + jobId + '_stop" ' + jobWrapStopStyle + '>');
            htmlString.push('<a class="icon permission_contributor permission_contributorExecute" href="javascript:void(0);" title="정지" ');
            htmlString.push('onclick="stopJob(\'' + jobId + '\', \'' + jobGuid +  '\', \'' + data.lastSuccessJobNumber + '\');">');
            htmlString.push('<i class="tool_ico_stop" id="jobIcon_' + jobId + '"></i></a>');
            htmlString.push('</li>');
            htmlString.push('<li><a class="icon closed-tool" href="javascript:void(0);" title="구성" ');
            htmlString.push('onclick="movePage(\'<%= Constants.REQUEST_TYPE_SET %>\', \'' + jobType.toLowerCase() +  '\', \'' + jobId +  '\');">');
            htmlString.push('<i class="tool_ico_setting"></i></a></li>');
            htmlString.push('<li><a class="icon closed-tool" href="javascript:void(0);" title="로그/히스토리" ');
            htmlString.push('onclick="movePage(\'<%= Constants.REQUEST_TYPE_LOG %>\', \'' + jobType.toLowerCase() +  '\', \'' + jobId +  '\');">');
            htmlString.push('<i class="tool_ico_log"></i></a></li>');
            htmlString.push('<li role="presentation" class="dropdown"><a class="dropdown-toggle icon closed-tool permission_contributor"  ');
            htmlString.push('title="작업 정렬" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> ');
            htmlString.push('<i class="tool-ico-rearrange"></i></a>');
            htmlString.push('<div class="dropdown-menu" id="custom-rearrange-job-order-menu-div-wrapper">');
            htmlString.push('<ul id="custom-rearrange-job-order-menu-wrapper" style="">');
            htmlString.push(jobOrderListString);
            htmlString.push('</ul>');
            htmlString.push('</div>');
            htmlString.push('</li>');
            htmlString.push('</ul></div>');
            htmlString.push('<div class="portlet-body"><div class="jobbox_contents">');
            htmlString.push('<dl class="plan_area">');
            htmlString.push('<dt>마지막 커밋(Recent Commit)</dt>');
            htmlString.push('<dd><a href="' + repositoryUrl + '" target="_blank" title="' + repositoryUrl + '">' + repositoryUrl + '</a></dd>');
            htmlString.push('<dd><span title="' + repositoryCommitRevision + '">' + (repositoryCommitRevision.substring(0, 20) + repositoryCommitRevisionPostfix) + '</span>');
            htmlString.push('<span class="data">' + lastModifiedString + '</span></dd>');
            htmlString.push('</dl>');
            htmlString.push('<dl class="plan_area02">');
            htmlString.push('<dt>작업(Job)</dt>');
            htmlString.push('<dd><i class="job_ico_wait"></i>');
            htmlString.push('<span class="font-wait">Build (<span id="lastJobStatusText_' + jobId + '">' + lastJobStatusText + '</span>)</span>');
            htmlString.push('<span class="data" id="lastJobModifiedText_' + jobId + '">' + lastJobModifiedText +  '</span>');
            htmlString.push('</dd>');
            htmlString.push('</dl>');
            htmlString.push('</div>');
            htmlString.push('<div class="panel-tools_btn">');
            htmlString.push('<ul><li><a class="permission_contributor" href="javascript:void(0);" onclick="addJob(\'' + groupOrder +  '\', \'' + jobOrder +  '\');">');
            htmlString.push('<span class="panel_ico_add">추가</span></a></li>');
            htmlString.push('<li><a class="permission_contributor" href="javascript:void(0);" onclick="replicateJob(\'' + jobId +  '\');">');
            htmlString.push('<span class="panel_ico_copy">복제</span></a></li>');
            htmlString.push('<li><a class="permission_contributor" href="javascript:void(0);" onclick="deleteJob(\'' + jobId +  '\');">');
            htmlString.push('<span class="panel_ico_del">삭제</span></a></li>');
            htmlString.push('</ul></div></div></div>');
        }


        // TEST JOB
        if ("<%= Constants.JOB_TYPE_TEST %>" === jobType) {
            confirmMessage = '테스트 JOB';

            if (repositoryCommitRevision.length > 18) {
                repositoryCommitRevisionPostfix = '...';
            }

            htmlString.push('<div class="portlet box' + portletBoxCss + '" id="jobPortlet_' + jobId + '">');
            htmlString.push('<div class="portlet-title">');
            htmlString.push('<div class="caption" id="jobPortletTitle_' + jobId + '" title="' + jobName + '"> ');
            htmlString.push(jobOrder +  '. ' + jobName.substring(0, 12) + jobNamePostfix + '</div>');
            htmlString.push('<ul class="panel-tools">');
            htmlString.push('<li id="jobWrap_' + jobId + '_trigger" ' + jobWrapTriggerStyle + '>');
            htmlString.push('<a class="icon permission_contributor permission_contributorExecute" href="javascript:void(0);" title="실행" ');
            htmlString.push('onclick="triggerJob(\'' + jobId +  '\', \'' + confirmMessage + '\');">');
            htmlString.push('<i class="tool_ico_play" id="jobIcon_' + jobId + '"></i></a>');
            htmlString.push('</li>');
            htmlString.push('<li id="jobWrap_' + jobId + '_stop" ' + jobWrapStopStyle + '>');
            htmlString.push('<a class="icon permission_contributor permission_contributorExecute" href="javascript:void(0);" title="정지" ');
            htmlString.push('onclick="stopJob(\'' + jobId + '\', \'' + jobGuid +  '\', \'' + data.lastSuccessJobNumber + '\');">');
            htmlString.push('<i class="tool_ico_stop" id="jobIcon_' + jobId + '"></i></a>');
            htmlString.push('</li>');
            htmlString.push('<li><a class="icon closed-tool" href="javascript:void(0);" title="구성" ');
            htmlString.push('onclick="movePage(\'<%= Constants.REQUEST_TYPE_SET %>\', \'' + jobType.toLowerCase() +  '\', \'' + jobId +  '\');">');
            htmlString.push('<i class="tool_ico_setting"></i></a></li>');
            htmlString.push('<li><a class="icon closed-tool" href="javascript:void(0);" title="로그/히스토리" ');
            htmlString.push('onclick="movePage(\'<%= Constants.REQUEST_TYPE_LOG %>\', \'' + jobType.toLowerCase() +  '\', \'' + jobId +  '\');">');
            htmlString.push('<i class="tool_ico_log"></i></a></li>');
            htmlString.push('<li role="presentation" class="dropdown"><a class="dropdown-toggle icon closed-tool permission_contributor"  ');
            htmlString.push('title="작업 정렬" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> ');
            htmlString.push('<i class="tool-ico-rearrange"></i></a>');
            htmlString.push('<div class="dropdown-menu" id="custom-rearrange-job-order-menu-div-wrapper">');
            htmlString.push('<ul id="custom-rearrange-job-order-menu-wrapper" style="">');
            htmlString.push(jobOrderListString);
            htmlString.push('</ul>');
            htmlString.push('</div>');
            htmlString.push('</li>');
            htmlString.push('</ul></div>');
            htmlString.push('<div class="portlet-body"><div class="jobbox_contents">');
            htmlString.push('<dl class="plan_area">');
            htmlString.push('<dt>마지막 커밋(Recent Commit)</dt>');
            htmlString.push('<dd><a href="' + repositoryUrl + '" target="_blank" title="' + repositoryUrl + '">' + repositoryUrl + '</a></dd>');
            htmlString.push('<dd><span title="' + repositoryCommitRevision + '">' + (repositoryCommitRevision.substring(0, 20) + repositoryCommitRevisionPostfix) + '</span>');
            htmlString.push('<span class="data">' + lastModifiedString + '</span></dd>');
            htmlString.push('</dl>');
            htmlString.push('<dl class="plan_area02">');
            htmlString.push('<dt>작업(Job)</dt>');
            htmlString.push('<dd><i class="job_ico_wait"></i>');
            htmlString.push('<span class="font-wait">Test (<span id="lastJobStatusText_' + jobId + '">' + lastJobStatusText + '</span>)</span>');
            htmlString.push('<span class="data" id="lastJobModifiedText_' + jobId + '">' + lastJobModifiedText +  '</span>');
            htmlString.push('</dd>');
            htmlString.push('</dl>');
            htmlString.push('</div>');
            htmlString.push('<div class="panel-tools_btn">');
            htmlString.push('<ul><li><a class="permission_contributor" href="javascript:void(0);" onclick="addJob(\'' + groupOrder +  '\', \'' + jobOrder +  '\');">');
            htmlString.push('<span class="panel_ico_add">추가</span></a></li>');
            htmlString.push('<li><a class="permission_contributor" href="javascript:void(0);" onclick="replicateJob(\'' + jobId +  '\');">');
            htmlString.push('<span class="panel_ico_copy">복제</span></a></li>');
            htmlString.push('<li><a class="permission_contributor" href="javascript:void(0);" onclick="deleteJob(\'' + jobId +  '\');">');
            htmlString.push('<span class="panel_ico_del">삭제</span></a></li>');
            htmlString.push('</ul></div></div></div>');
        }


        // DEPLOY JOB
        if ("<%= Constants.JOB_TYPE_DEPLOY %>" === jobType) {
            var deployType = data.deployType,
                blueGreenDeployStatus = data.blueGreenDeployStatus,
                blueDeployedCount = data.blueDeployedCount,
                deployTypeOriginalString = 'Deploy',
                deployTypeString = 'Deploy',
                tempAppUrlArray,
                appUrl = data.appUrl,
                hiddenAppUrl,
                displayAppUrl,
                appName = data.appName,
                blueGreenPostfix = '',
                isBlueDeployed = false,
                revertGreenDeployJobWrapStyle = 'style="display: none;"',
                revertGreenDeployConfirmMessage = '운영 GREEN 배포 JOB 되돌리기';

            confirmMessage = '개발 배포 JOB';
            hiddenAppUrl = appUrl;
            tempAppUrlArray = appUrl.split(appName);

            if ("<%=Constants.DeployType.PRD %>" === deployType) {
                deployTypeOriginalString = 'Green Deploy';
                deployTypeString = 'Green Deploy';
                blueGreenPostfix = '-GREEN';
                confirmMessage = '운영 GREEN 배포 JOB';
                hiddenAppUrl = tempAppUrlArray[0] + appName + blueGreenPostfix + tempAppUrlArray[1];

                if (lastJobModifiedText !== initJobStatusText) {
                    if (lastJobStatus.indexOf('<%= Constants.RESULT_STATUS_SUCCESS %>') > -1) {
                        if ("<%= Constants.BlueGreenDeployStatus.GREEN_DEPLOY %>" === blueGreenDeployStatus) {
                            deployTypeString = 'Blue Deploy';
                            blueGreenPostfix = '';
                        }

                        if ("<%= Constants.BlueGreenDeployStatus.BLUE_DEPLOY %>" === blueGreenDeployStatus) {
                            confirmMessage = '운영 BLUE 배포 JOB';
                            deployTypeOriginalString = 'Blue Deploy 3';
                            hiddenAppUrl = tempAppUrlArray[0] + appName + tempAppUrlArray[1];

                            // SHOW BUTTON FOR REVERTING GREEN DEPLOY
                            revertGreenDeployJobWrapStyle = '';
                        }

                        if ("<%= Constants.BlueGreenDeployStatus.REVERT_GREEN_DEPLOY %>" === blueGreenDeployStatus) {
                            deployTypeString = 'Green Deploy';
                            lastJobStatusText = '실행 전';

                            if ('0' === blueDeployedCount) {
                                isBlueDeployed = true;
                            } else {
                                deployTypeString = 'Blue Deploy';
                                lastJobStatusText = '실행완료';
                                blueGreenPostfix = '';
                            }
                        }
                    } else {
                        if ("<%= Constants.BlueGreenDeployStatus.BLUE_DEPLOY %>" === blueGreenDeployStatus) {
                            deployTypeString = 'Blue Deploy';
                            confirmMessage = '운영 BLUE 배포 JOB';
                            blueGreenPostfix = '';
                        }

                        if ("<%= Constants.BlueGreenDeployStatus.REVERT_GREEN_DEPLOY %>" === blueGreenDeployStatus) {
                            deployTypeString = 'Reverting Green Deploy';
                        }
                    }
                }
            }

            displayAppUrl = tempAppUrlArray[0] + appName + blueGreenPostfix + tempAppUrlArray[1];


            // INIT
            if (isBlueDeployed ||
                null === lastJobStatus
                || 'null' === lastJobStatus
                || ('' !== revertGreenDeployJobWrapStyle && '0' === blueDeployedCount && 'true' === $('#jobIsBuilding_' + jobId).val())) {
                deployTypeOriginalString = 'Green Deploy';
                deployTypeString = 'Green Deploy';
                displayAppUrl = 'Green Deploy is not triggered.';
                lastJobStatusText = '실행 전';

            }

            // TRIGGERING REVERT GREEN DEPLOY
            if ('실행 중' === lastJobStatusText && "<%= Constants.BlueGreenDeployStatus.REVERT_GREEN_DEPLOY %>" === blueGreenDeployStatus) {
                deployTypeOriginalString = 'Reverting Green Deploy';
                deployTypeString = 'Reverting Green Deploy';
                displayAppUrl = 'Reverting Green Deploy';
                hiddenAppUrl = 'Reverting Green Deploy';
            }


            htmlString.push('<div class="portlet box' + portletBoxCss + '" id="jobPortlet_' + jobId + '">');
            htmlString.push('<div class="portlet-title">');
            htmlString.push('<div class="caption" id="jobPortletTitle_' + jobId + '" title="' + jobName + '"> ');
            htmlString.push(jobOrder +  '. ' + jobName.substring(0, 12) + jobNamePostfix + '</div>');
            htmlString.push('<ul class="panel-tools">');
            htmlString.push('<li id="jobWrap_' + jobId + '_trigger" ' + jobWrapTriggerStyle + '>');
            htmlString.push('<a class="icon permission_contributor permission_contributorExecute" href="javascript:void(0);" title="실행" ');
            htmlString.push('onclick="triggerJob(\'' + jobId +  '\', \'' + confirmMessage + '\');">');
            htmlString.push('<i class="tool_ico_play" id="jobIcon_' + jobId + '"></i></a>');
            htmlString.push('</li>');
            htmlString.push('<li id="jobWrap_' + jobId + '_stop" ' + jobWrapStopStyle + '>');
            htmlString.push('<a class="icon permission_contributor permission_contributorExecute" href="javascript:void(0);" title="정지" ');
            htmlString.push('onclick="stopJob(\'' + jobId + '\', \'' + jobGuid +  '\', \'' + data.lastSuccessJobNumber + '\');">');
            htmlString.push('<i class="tool_ico_stop" id="jobIcon_' + jobId + '"></i></a>');
            htmlString.push('</li>');
            htmlString.push('<li><a class="icon closed-tool" href="javascript:void(0);" title="구성" ');
            htmlString.push('onclick="movePage(\'<%= Constants.REQUEST_TYPE_SET %>\', \'' + jobType.toLowerCase() +  '\', \'' + jobId +  '\');">');
            htmlString.push('<i class="tool_ico_setting"></i></a></li>');
            htmlString.push('<li><a class="icon closed-tool" href="javascript:void(0);" title="로그/히스토리" ');
            htmlString.push('onclick="movePage(\'<%= Constants.REQUEST_TYPE_LOG %>\', \'' + jobType.toLowerCase() +  '\', \'' + jobId +  '\');">');
            htmlString.push('<i class="tool_ico_log"></i></a></li>');
            htmlString.push('<li id="jobWrap_' + jobId + '_revertGreenDeployJobTrigger" ' + revertGreenDeployJobWrapStyle + '>');
            htmlString.push('<a class="icon permission_contributor permission_contributorExecute" href="javascript:void(0);" title="운영 GREEN 배포 JOB 되돌리기" ');
            htmlString.push('onclick="triggerRevertGreenDeployJob(\'' + jobId +  '\', \'' + revertGreenDeployConfirmMessage + '\');">');
            htmlString.push('<i class="tool-ico-revert" id="jobIcon_' + jobId + '"></i></a>');
            htmlString.push('</li>');
            htmlString.push('<li role="presentation" class="dropdown"><a class="dropdown-toggle icon closed-tool permission_contributor"  ');
            htmlString.push('title="작업 정렬" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false"> ');
            htmlString.push('<i class="tool-ico-rearrange"></i></a>');
            htmlString.push('<div class="dropdown-menu" id="custom-rearrange-job-order-menu-div-wrapper">');
            htmlString.push('<ul id="custom-rearrange-job-order-menu-wrapper" style="">');
            htmlString.push(jobOrderListString);
            htmlString.push('</ul>');
            htmlString.push('</div>');
            htmlString.push('</li>');
            htmlString.push('</ul></div>');
            htmlString.push('<div class="portlet-body"><div class="jobbox_contents">');
            htmlString.push('<dl class="plan_area">');
            htmlString.push('<dt>마지막 배포(Recent Deploy)</dt>');
            htmlString.push('<dd><a href="' + hiddenAppUrl + '" target="_blank" title="' + hiddenAppUrl + '" id="appUrlOriginalText_' + jobId + '" style="display: none;">' + hiddenAppUrl + '</a>');
            htmlString.push('<a href="' + displayAppUrl + '" target="_blank" title="' + displayAppUrl + '" id="appUrlDisplayText_' + jobId + '">' + displayAppUrl + '</a></dd>');
            htmlString.push('<dd>' + data.buildJobName + '<span class="data">' + lastModifiedString + '</span></dd>');
            htmlString.push('</dl>');
            htmlString.push('<dl class="plan_area02">');
            htmlString.push('<dt>작업(Job)</dt>');
            htmlString.push('<dd><i class="job_ico_wait"></i>');
            htmlString.push('<span class="font-wait"><span id="lastJobOriginalText_' + jobId + '" style="display: none;">' + deployTypeOriginalString + '</span>');
            htmlString.push('<span id="lastJobDisplayText_' + jobId + '">' + deployTypeString + '</span> ');
            htmlString.push('(<span id="lastJobStatusText_' + jobId + '">' + lastJobStatusText + '</span>)</span>');
            htmlString.push('<span class="data" id="lastJobModifiedText_' + jobId + '">' + lastJobModifiedText +  '</span>');
            htmlString.push('</dd>');
            htmlString.push('</dl>');
            htmlString.push('</div>');
            htmlString.push('<div class="panel-tools_btn">');
            htmlString.push('<ul><li><a class="permission_contributor" href="javascript:void(0);" onclick="addJob(\'' + groupOrder +  '\', \'' + jobOrder +  '\');">');
            htmlString.push('<span class="panel_ico_add">추가</span></a></li>');
            htmlString.push('<li><a class="permission_contributor" href="javascript:void(0);" onclick="replicateJob(\'' + jobId +  '\');">');
            htmlString.push('<span class="panel_ico_copy">복제</span></a></li>');
            htmlString.push('<li><a class="permission_contributor" href="javascript:void(0);" onclick="deleteJob(\'' + jobId +  '\');">');
            htmlString.push('<span class="panel_ico_del">삭제</span></a></li>');
            htmlString.push('</ul></div></div></div>');
        }

        return htmlString.join('');
    };


    // START TIMER
    var startGetJobStatusTimer = function (reqJobId, reqJobNumber) {
        gJobStatusTimerList["jobStatusTimer_" + reqJobId] = setInterval(function () {
            setTimeout(function () {
                getJobStatusById(reqJobId, reqJobNumber);
                }, 10);
            }, gDelayTime);
    };


    // GET JOB STATUS
    var getJobStatusById = function (reqJobId, reqJobNumber) {
        var param = {
            id: reqJobId,
            jobNumber : parseInt(reqJobNumber, 10) + 1
        };

        procCallAjax(JOB_PIPELINE_URL + '/status.do', param, callbackGetJobStatusById);
    };


    // CALLBACK GET JOB STATUS
    var callbackGetJobStatusById = function(data, reqParam) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var reqJobId = reqParam.id;
        var isBuilding = data.isBuilding;
        var lastJobStatus = data.lastJobStatus;
        var objJobIsBuilding = $('#jobIsBuilding_' + reqJobId);
        var jobIsBuilding = objJobIsBuilding.val();
        var checkY = '<%= Constants.CHECK_YN_Y %>';
        var checkN = '<%= Constants.CHECK_YN_N %>';
        var statusJobWorking = '<%= Constants.RESULT_STATUS_JOB_WORKING %>';
        var statusBuiltFileUploading = '<%= Constants.RESULT_STATUS_BUILT_FILE_UPLOADING %>';

        // SET PREVIOUS JOB STATUS
        $('#previousJobStatus_' + $('#nextJobId_' + reqParam.id).val()).val(lastJobStatus);

        if ('' === jobIsBuilding) {
            objJobIsBuilding.val(checkN);
        }

        if ('true' === isBuilding || statusJobWorking === lastJobStatus || statusBuiltFileUploading === lastJobStatus || checkY === jobIsBuilding) {
            if (checkY !== jobIsBuilding) {
                objJobIsBuilding.val(checkY);
                procSetFadeInOutJobTitle(reqJobId, 'ADD');
                changeTriggerJobHtml(reqJobId);
            }
        }

        if ('false' === isBuilding && checkY === jobIsBuilding && !(statusJobWorking === lastJobStatus || statusBuiltFileUploading === lastJobStatus)) {
            objJobIsBuilding.val(checkN);
            setUpdateJobDetailDiv(reqJobId);
            procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");
        }
    };


    // START JOB TITLE TIMER
    var startJobTitleTimer = function () {
        setInterval(function () {procSetFadeInOutJobTitle('INIT', 'INIT');}, 1000);
    };


    // SET FADE IN OUT JOB TITLE
    var procSetFadeInOutJobTitle = function (reqJobId, reqProcessType) {
        var jobTitleList = gJobTitleList,
            listLength = jobTitleList.length,
            checkDuplicatedJobId = false,
            jobId;

        reqJobId = String(reqJobId);

        // CHECK ADD OR REMOVE
        // CHECK DUPLICATED JOB ID
        for (var i = 0; i < listLength; i++) {
            jobId = jobTitleList[i];

            if ((jobId === reqJobId) && ('ADD' === reqProcessType)) {
                checkDuplicatedJobId = true;
            }

            if ((jobId === reqJobId) && ('REMOVE' === reqProcessType)) {
                jobTitleList.splice(i, 1);
            }

        }

        if (('ADD' === reqProcessType) && !checkDuplicatedJobId) {
            jobTitleList.push(reqJobId);
        }

        gJobTitleList = jobTitleList;

        for (var k = 0; k < listLength; k++) {
            jobId = jobTitleList[k];
            $('#jobPortletTitle_' + jobId).fadeOut(500).fadeIn(500);
        }
    };


    // CHANGE TRIGGER JOB HTML
    var changeTriggerJobHtml = function (reqJobId) {
        var jobPortlet = $('#jobPortlet_' + reqJobId);
        var jobWrapString = '#jobWrap_' + reqJobId;
        var progressCss = 'custom-progress';

        jobPortlet.removeClass('wait').addClass(progressCss);
        jobPortlet.removeClass('success').addClass(progressCss);
        jobPortlet.removeClass('fail').addClass(progressCss);
        jobPortlet.removeClass('retract').addClass(progressCss);

        $(jobWrapString + '_trigger').hide();
        $(jobWrapString + '_stop').show();

        // FOR DEPLOY JOB :: BEGIN
        $('#appUrlOriginalText_' + reqJobId).show();
        $('#appUrlDisplayText_' + reqJobId).hide();
        $('#lastJobOriginalText_' + reqJobId).show();
        $('#lastJobDisplayText_' + reqJobId).hide();
        // FOR DEPLOY JOB :: END

        $('#lastJobStatusText_' + reqJobId).html('실행 중');
        $('#lastJobModifiedText_' + reqJobId).html(' - ');
    };


    // SET UPDATE JOB DETAIL DIV
    var setUpdateJobDetailDiv = function (reqJobId) {
        var reqUrl = JOB_PIPELINE_URL + '/get.do?id=' + reqJobId;
        procCallAjax(reqUrl, null, callbackSetUpdateJobDetailDiv);
    };


    // CALLBACK
    var callbackSetUpdateJobDetailDiv = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var jobId = data.id;
        var objJobWrapString = $('#jobWrap_' + jobId);

        procSetFadeInOutJobTitle(jobId, 'REMOVE');
        objJobWrapString.html(setJobDetailHtmlString(data));
    };


    // TRIGGER JOB
    var triggerJob = function (reqJobId, reqConfirmMessage) {
        var previousJobStatus = $('#previousJobStatus_' + reqJobId).val();

        if ('<%= Constants.RESULT_STATUS_SUCCESS %>' !== previousJobStatus) {
            reqConfirmMessage = '<p>이전 단계의 JOB이 성공하지 못했습니다.</p>' + reqConfirmMessage;
        }

        procPopupConfirm('작업 실행', reqConfirmMessage + '을 실행 하시겠습니까?', 'procTriggerJob(\'' + reqJobId + '\', \'<%= Constants.CHECK_YN_N %>\');', '실행');
    };


    // TRIGGER REVERT GREEN DEPLOY JOB
    var triggerRevertGreenDeployJob = function (reqJobId, reqConfirmMessage) {
        procPopupConfirm('운영 GREEN 배포 JOB 되돌리기', reqConfirmMessage + '를 실행 하시겠습니까?', 'procTriggerJob(\'' + reqJobId + '\', \'<%= Constants.CHECK_YN_Y %>\');', '실행');
    };


    // TRIGGER JOB
    var procTriggerJob = function (reqJobId, reqRevertGreenDeploy) {
        procClosePopup();

        var param = {
            id : reqJobId
        };

        // CHECK REVERT GREEN DEPLOY
        if ('<%= Constants.CHECK_YN_Y %>' === reqRevertGreenDeploy) {
            var greenDeployRevertParam = {
                blueGreenDeployStatus : '<%= Constants.BlueGreenDeployStatus.REVERT_GREEN_DEPLOY %>'
            };

            $.extend(param, greenDeployRevertParam);

            $('#appUrlOriginalText_' + reqJobId).html('Reverting Green Deploy');
            $('#appUrlDisplayText_' + reqJobId).html('Reverting Green Deploy');
            $('#lastJobOriginalText_' + reqJobId).html('Reverting Green Deploy');
        }

        $('#jobIsBuilding_' + reqJobId).val('<%= Constants.CHECK_YN_Y %>');
        procSetFadeInOutJobTitle(reqJobId, 'ADD');
        changeTriggerJobHtml(reqJobId);

        procCallAjax(JOB_PIPELINE_URL + '/trigger.do', param, callbackTriggerJob);
    };


    // CALLBACK TRIGGER JOB
    var callbackTriggerJob = function(data, reqParam) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
    };


    // STOP JOB
    var stopJob = function (reqJobId, reqJobGuid, reqJobNumber) {
        procPopupConfirm('작업 정지', '작업을 정지 하시겠습니까?', 'procStopJob(\'' + reqJobId + '\', \'' + reqJobGuid + '\',  \'' + reqJobNumber + '\');', '정지');
    };


    // STOP JOB
    var procStopJob = function (reqJobId, reqJobGuid, reqJobNumber) {
        procClosePopup();

        var param = {
            serviceInstancesId: '<c:out value='${suid}' default='' />',
            jobGuid : reqJobGuid,
            jobNumber : parseInt(reqJobNumber, 10) + 1,
            reqJobId: reqJobId
        };

        $('#lastJobStatusText_' + reqJobId).html('정지 중');
        $('#lastJobModifiedText_' + reqJobId).html(' - ');

        procCallAjax(JOB_PIPELINE_URL + '/stop.do', param, callbackStopJob);
    };


    // CALLBACK STOP JOB
    var callbackStopJob = function(data, reqParam) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var reqJobId = reqParam.reqJobId;

        $('#lastJobStatusText_' + reqJobId).html('실행완료');
        $('#lastJobModifiedText_' + reqJobId).html(' - ');

        setUpdateJobDetailDiv(reqJobId);
    };


    // REARRANGE JOB ORDER
    var rearrangeJobOrder = function(reqJobId, reqJobOrder) {
        procPopupConfirm('작업 재정렬', '작업 재정렬을 실행 하시겠습니까?', 'procRearrangeJobOrder(\'' + reqJobId + '\', \'' + reqJobOrder + '\');', '실행');
    };


    // REARRANGE JOB ORDER
    var procRearrangeJobOrder = function(reqJobId, reqJobOrder) {
        var param = {
            id: reqJobId,
            jobOrder: reqJobOrder
        };

        procCallSpinner(SPINNER_START);
        procCallAjax(JOB_PIPELINE_URL + '/rearrangeJobOrder.do', param, callbackRearrangeJobOrder);
    };


    // CALLBACK REARRANGE JOB ORDER
    var callbackRearrangeJobOrder = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        procPopupAlert('작업 재정렬이 완료 되었습니다.', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // ADD JOB
    var addJob = function(groupOrder, jobOrder) {
        var reqUrl = JOB_PIPELINE_URL + '/create?groupOrder=' + groupOrder + '&jobOrder=' + jobOrder;
        procMovePage(reqUrl);
    };


    // REPLICATE JOB
    var replicateJob = function(reqJobId) {
        procPopupConfirm('작업 복제', '작업을 복제 하시겠습니까?', 'procReplicateJob(\'' + reqJobId + '\');', '복제');
    };


    // REPLICATE JOB
    var procReplicateJob = function(reqJobId) {
        procCallSpinner(SPINNER_START);

        resetAllTimer();
        procCallAjax(JOB_PIPELINE_URL + '/replicate.do', { id : reqJobId }, callbackReplicateJob);
    };


    // CALLBACK REPLICATE JOB
    var callbackReplicateJob = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        procPopupAlert('복제 되었습니다.', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // RESET ALL TIMER
    var resetAllTimer = function() {
        for (var i in gJobStatusTimerList) {
            clearInterval(gJobStatusTimerList[i]);
            clearTimeout(gJobStatusTimerList[i]);
        }

        gJobStatusTimerList = {};
    };


    // DELETE JOB
    var deleteJob = function(reqJobId) {
        procPopupConfirm('작업 삭제', '작업을 삭제 하시겠습니까?', 'procDeleteJob(\'' + reqJobId + '\');', '삭제');
    };


    // DELETE JOB
    var procDeleteJob = function(reqJobId) {
        procCallSpinner(SPINNER_START);

        resetAllTimer();
        procCallAjax(JOB_PIPELINE_URL + '/delete.do', { id : reqJobId }, callbackDeleteJob);
    };


    // CALLBACK DELETE JOB
    var callbackDeleteJob = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        procPopupAlert('삭제 되었습니다.', 'procMovePage("/pipeline/<c:out value='${pipelineId}' default='' />/detail");');
    };


    // MOVE PAGE
    var movePage = function(reqType, jobType, id) {
        var reqUrl = JOB_PIPELINE_URL + '/' + id + '/' + jobType;

        if ('<%= Constants.REQUEST_TYPE_SET %>' === reqType) {
            reqUrl += '/update';
        }

        procMovePage(reqUrl);
    };


    // MOVE PAGE
    var procMoveCreateJobPage = function() {
        procMovePage(JOB_PIPELINE_URL + "/create");
    };


    // MOVE PAGE
    var procMovePipelineDetailTabPage = function(reqPage) {
        var reqUrl = '/pipeline/<c:out value='${pipelineId}' default='' />/';
        reqUrl += ('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_DETAIL %>' === reqPage)? 'detail' : 'contributor';

        procMovePage(reqUrl);
    };


    // BIND
    $("button[id^='btn']").on("click", function() {
        switch(this.id) {
            case 'btnCreatePipeline' :
                procMovePage('/pipeline/create');
                break;

            case 'btnUpdatePipeline' :
                procMovePage('/pipeline/update/<c:out value='${pipelineId}' default='' />');
                break;

            case 'btnAddNewGroup' :
                procMovePage(JOB_PIPELINE_URL + '/create?groupOrder=' + (gLastGroupOrder + 1) + '&jobOrder=0');
                break;
        }
    });

    var getContributorList = function(){
        var reqUrl;
        reqUrl = '/pipeline/<c:out value='${pipelineId}' default='' />/contributorList.do?size=' + 10000;

        procCallAjax(reqUrl, null, callbackGetContributorList);
    };

    var callbackGetContributorList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        document.getElementById('contributorCount').innerHTML = data.instanceUses.length;
    };


    var permissionContributor = function(reqClassName){
        $('.' + reqClassName).attr('onclick', 'procPopupAlert("권한이 없습니다.");');
    };


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        startJobTitleTimer();
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, 'pipeline', null);
        getPipeline();
        getJobListFromDb();
        getContributorList();
    });

</script>
