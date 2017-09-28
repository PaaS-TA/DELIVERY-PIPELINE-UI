<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/5/2017
  Time: 4:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="details.role" var="role"/>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
    <script>
        location.href='/common/error/unauthorized';
    </script>
</sec:authorize>

<!-- header :s -->
<div id="header">
    <div class="head_inner">
        <h1><a title="PaaS-TA 배포파이프라인" href="javascript:void(0);" onclick="procMovePage('/');"><img
                alt="PaaS-TA 배포파이프라인" src="<c:url value='/resources/images/logo.png'/>"><span>배포파이프라인</span></a></h1>
        <ul class="RP_title">
            <li><a href="#"><span class="RP_num" id="topMenuPipelineListCount">0</span></a></li>
            <li role="presentation" class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <span class="RP_name"> 파이프라인 목록 </span>
                </a>
                <ul class="dropdown-menu togglemenu" style="width:320px;left:-60px;">
                    <c:if test="${role == 'ROLE_ADMIN'}">
                        <li>
                            <h3><i class="glyphicon glyphicon-plus"></i>신규 생성 (New Pipeline)</h3>
                            <input id="topMenuPipelineName" name="topMenuPipelineName" type="text"
                                   placeholder="파이프라인 명(필수)"
                                   onkeypress="if(event.keyCode==13) {createTopMenuPipeline(); }">
                        </li>

                        <li class="alignC">
                            <button type="button" class="button btn_regist" id="btnTopMenuPipelineCreate">등록</button>
                            <button type="button" class="button btn_regist" id="btnTopMenuPipelineCancel">취소</button>
                        </li>
                    </c:if>

                    <li class="toggl_message" id="topMenuPipelineCreateResultArea" style="display: none;"><span
                            class="point01 bold" id="topMenuPipelineCreateResultPipelineName">‘파이프라인 명’</span> 파이프라인을
                        생성했습니다.
                    </li>
                    <li>
                        <h3><i class="glyphicon glyphicon-list"></i>
                            <a href="javascript:void(0);" onclick="procMovePage('/');" style="display: inline;">나의 파이프라인 (My Pipelines)</a>
                        </h3>
                        <ul class="h6_ul" id="topMenuPipelineList">
                        </ul>
                    </li>
                </ul>
            </li>
            <c:if test="${role == 'ROLE_ADMIN'}">
                <li role="presentation" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                       aria-expanded="false">
                        파이프라인 관리
                    </a>
                    <ul class="dropdown-menu togglemenu" style="width:200px;left:-50px;padding-top:4px;">
                        <li><a href="javascript:void(0);" onclick="procMovePage('/cf-info');"> Cloud Foundry 정보관리 </a>
                        </li>
                    </ul>
                </li>
                <li role="presentation" class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true"
                       aria-expanded="false">
                        품질 관리
                    </a>
                    <ul class="dropdown-menu togglemenu" style="width:100px;left:-50px;padding-top:4px;">
                        <li><a href="javascript:void(0);" onclick="procMovePage('/qualityIssues/dashboard');">품질 이슈</a>
                        </li>
                        <li><a href="javascript:void(0);" onclick="procMovePage('/codingRules/dashboard');">코딩 규칙</a>
                        </li>
                        <li><a href="javascript:void(0);" onclick="procMovePage('/qualityProfile/dashboard');"> 품질
                            프로파일</a>
                        </li>
                        <li><a href="javascript:void(0);" onclick="procMovePage('/qualityGate/dashboard');">품질 게이트</a>
                        </li>
                    </ul>
                </li>
            </c:if>
        </ul>
        <ul class="nav_ibtn">
            <li class="mr20"><span style="color: #efefef; vertical-align: bottom;">
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication property="details.userid"/>
                    </sec:authorize>
                </span>
            </li>
            <c:if test="${role == 'ROLE_ADMIN'}">
                <li><a href="javascript:void(0);" onclick="procMovePage('/user/dashboard');" style="background: none;">사용자
                    관리</a>
                </li>
            </c:if>
        </ul>
    </div>
</div>
<!--//header :e -->
<input type="hidden" id="role" name="role" value="<c:out value='${role}' />"/>

<script type="text/javascript">

    // GET LIST
    var getTopMenuPipelineList = function () {
        procCallAjax("/pipeline/pipelineList.do?size=10000&sort=created,DESC", null, callbackTopMenuPipelineList);
    };


    // CALLBACK
    var callbackTopMenuPipelineList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.pipelines.length;
        var htmlString = [];

        if (0 === listLength) {
            htmlString = "<li><dl><dt>조회 된 데이터가 없습니다.</dt><dd></li>";
        } else {
            for (var i = 0; i < listLength; i++) {
                var html = "<li>";
                if (document.getElementById('role').value != "ROLE_ADMIN") {
                    var count = 0;
                    for (var j = 0; j < grAry.length; j++) {
                        if (grAry[j].authCode != null && data.pipelines[i].id == grAry[j].authCode) {
                            count++;
                        }
                    }
                    if (count > 0) {
                        html += "<a href='javascript:void(0);' onclick='moveTopMenuPipelineDetailPage(\"" + data.pipelines[i].id + "\");'> " + data.pipelines[i].name + " </a></li>";
                    } else {
                        html += data.pipelines[i].name;
                    }
                } else {
                    html += "<a href='javascript:void(0);' onclick='moveTopMenuPipelineDetailPage(\"" + data.pipelines[i].id + "\");'>" + data.pipelines[i].name + "</a></li>";
                }
                htmlString.push(html);
            }
        }

        $('#topMenuPipelineListCount').html(data.totalElements);
        $('#topMenuPipelineList').html(htmlString);
    };


    // MOVE DETAIL PAGE
    var moveTopMenuPipelineDetailPage = function (id) {
        procMovePage("/pipeline/" + id + "/detail");
    };


    // CREATE PIPELINE
    var createTopMenuPipeline = function () {
        var serviceInstancesId = (procIsNullString(G_SUID)) ? G_SERVICE_INSTANCE_ID : G_SUID;
        var pipelineName = $('#topMenuPipelineName').val();

        if (procIsNullString(pipelineName)) {
            procPopupAlert("파이프라인 명을 입력하십시오.", "$('#topMenuPipelineName').focus();");
            return false;
        }

        var reqParam = {
            name: pipelineName,
            serviceInstancesId: serviceInstancesId
        };

        procCallAjax("/pipeline/pipelineCreate.do", reqParam, callbackCreateTopMenuPipeline);
    };

    // CALLBACK
    var callbackCreateTopMenuPipeline = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        $('#topMenuPipelineName').val('');
        $('#topMenuPipelineCreateResultPipelineName').html(document.getElementById('topMenuPipelineName').value);

        procPopupAlert('파이프라인을 생성했습니다.', 'procMovePage("/");');
    };


    // BIND
    $("#btnTopMenuPipelineCreate").on("click", function () {
        createTopMenuPipeline();
    });


    // BIND
    $("#btnTopMenuPipelineCancel").on("click", function () {
        $('#topMenuPipelineName').val('');
        $('#topMenuPipelineCreateResultArea').hide();
        $('.togglemenu').hide();
    });


    // BIND
    $('.dropdown').on('show.bs.dropdown', function (e) {
        $(this).find('.dropdown-menu').first().stop(true, true).slideDown();
    }).on('hide.bs.dropdown', function (e) {
        $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
    });


    // ON LOAD
    $(document.body).ready(function () {
        getTopMenuPipelineList();
    });

</script>