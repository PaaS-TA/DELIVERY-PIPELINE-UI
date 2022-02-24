<%--
  Created by IntelliJ IDEA.
  User: lena
  Date: 2017-11-16
  Time: 오후 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="details.role" var="role"/>
    <sec:authentication property="details.userid" var="userid"/>
</sec:authorize>
<!-- location :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li>품질 프로파일</li>
        </ul>

        <c:if test="${role == 'ROLE_ADMIN'}">
            <div class="fr">
                <button type="button" class="button btn_default" title="생성" id="btnPopupProfileCreate">생성</button>
            </div>
        </c:if>
    </div>
</div>
<!-- location :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="">
        <!-- full_sub_content :s -->
        <div class="">
            <!-- left :s -->
            <div class="lnbWrap">
                <div class="lnb">
                    <ul id="qualityProfileList"></ul>
                </div>
            </div>
            <!--//left :e -->
            <!-- contentWrap :s -->
            <div class="contentWrap" id="contentProfileExp" style="display: block">
                <div style="padding: 20px; line-height: 2.2em;">
                    <p> 품질 프로파일은 분석하는 동안 적용할 규칙 모음입니다. </p>
                    <p> 언어별로 기본 프로파일이 있습니다. </p>
                    <p> 다른 프로파일에 명시적으로 할당되지 않은 모든 프로젝트는 기본값으로 분석됩니다. </p>
                </div>
            </div>
            <div class="contentWrap" id="contentProfile" style="display: none">
                <div class="content_in">
                    <!-- sub 타이틀 영역 :s -->
                    <div class="col-md-7 fl">
                        <h3 class="proj_tit" id="profileName"><span class="program">Java</span></h3>
                    </div>
                    <div class="fr mb10">
                        <c:if test="${role == 'ROLE_ADMIN'}">
                        <button type="button" class="button btn_default" id="btnPopupProfileCopy">복제</button>
                        <button type="button" class="button btn_default" id="btnPopupProfileUpdate">수정</button>
                        <button type="button" class="button btn_default" id="btnPopupProfileDelete">삭제</button>
                        </c:if>
                    </div>

                    <!--//sub 타이틀 영역 :e -->
                    <!-- 코딩규칙 :s -->
                    <h3 class="sub_title">코딩규칙 <a href="#none"><span class="code_rulenumber" id="crTotal"></span></a></h3>
                    <table summary="코딩규칙 테이블입니다." class="quality_list">
                        <caption>코딩규칙</caption>
                        <colgroup>
                            <col style="width: 100%" />
                        </colgroup>
                        <tbody>
                        <tr>
                            <td>
                                <ul class="rule_list">
                                    <li><span class="issue_name"><i class="ico_blocker"></i>심각 (Blocker)</span> <a href="#none"><span class="code_rulenumber" id="blockerNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_critical"></i>높음 (Critical)</span> <a href="#none"><span class="code_rulenumber" id="criticalNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_major"></i>보통 (Major)</span> <a href="#none"><span class="code_rulenumber" id="majorNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_minor"></i>낮음 (Minor)</span> <a href="#none"><span class="code_rulenumber" id="minorNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_info"></i>정보 (Info)</span> <a href="#none"><span class="code_rulenumber" id="infoNum"></span></a></li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <!--//코딩규칙 :e -->
                    <!-- 연결된 프로젝트 :s -->
                    <h3 class="sub_title">연결된 프로젝트</h3>
                    <div id="relatedProjectAreaDefault" style="display: none;">
                        <p class="ml18">기본 품질 프로파일에는 특정 프로젝트가 연결되지 않습니다.</p>
                    </div>
                    <!-- sub_tab :s -->
                    <div id="relatedProjectArea" style="display: block;">
                        <div class="sub_tab">
                            <ul>
                                <li class="fst active"><a href="#;" onClick="sub_tab(0);">연결됨 <span class="pl10"></span></a></li>
                                <li class=""><a href="#;" onClick="sub_tab(1);">미연결 <span class="pl10"></span></a></li>
                                <li class=""><a href="#;" onClick="sub_tab(2);">전체 <span class="pl10"></span></a></li>
                            </ul>
                        </div>
                        <!--//sub_tab :e -->
                        <!-- sub탭 콘텐츠01 :s -->
                        <div class="sub_tab_cont00">
                            <div class="tab_content tbl_scroll" style="height:310px;">
                                <!-- 리스트 테이블 -->
                                <table summary="연결된 프로젝트 리스트 테이블입니다." class="BasicTable">
                                    <caption>연결된 프로젝트 리스트</caption>
                                    <colgroup>
                                        <col style="width:3%">
                                        <col style="width: *" />
                                    </colgroup>
                                    <thead>
                                    </thead>
                                    <tbody id="projectLinked">

                                    </tbody>
                                </table>
                                <!--//리스트 테이블-->
                            </div>
                        </div>
                        <!--//sub탭 콘텐츠01 :e -->
                        <!-- sub탭 콘텐츠02 :s -->
                        <div class="sub_tab_cont01 mTs" style="display:none;">
                            <div class="tab_content tbl_scroll" style="height:310px;">
                                <!-- 리스트 테이블 -->
                                <table summary="미연결 프로젝트 리스트 테이블입니다." class="BasicTable">
                                    <caption>미연결 프로젝트 리스트</caption>
                                    <colgroup>
                                        <col style="width:3%">
                                        <col style="width: *" />
                                    </colgroup>
                                    <thead>
                                    </thead>
                                    <tbody id="projectUnLinked">

                                    </tbody>
                                </table>
                                <!--//리스트 테이블-->
                            </div>
                        </div>
                        <!--//sub탭 콘텐츠02 :e -->
                        <!-- sub탭 콘텐츠03 :s -->
                        <div class="sub_tab_cont02 mTs" style="display:none;">
                            <div class="tab_content tbl_scroll" style="height:310px;">
                                <!-- 리스트 테이블 -->
                                <table summary="전체 프로젝트 리스트 테이블입니다." class="BasicTable">
                                    <caption>전체 프로젝트 리스트</caption>
                                    <colgroup>
                                        <col style="width:3%">
                                        <col style="width: *" />
                                    </colgroup>
                                    <thead>
                                    </thead>
                                    <tbody id="allProject">

                                    </tbody>
                                </table>
                                <!--//리스트 테이블-->
                            </div>
                        </div>
                        <!--//sub탭 콘텐츠03 :e -->
                        <!--//연결된 프로젝트 :e -->
                    </div>
                </div>
            </div>
            <!--//contentWrap :e -->
        </div>
        <!--//full_sub_content :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->

<%--POPUP QUALITYPROFILE :: BEGIN--%>
<div class="modal fade" id="modalQualityProfileList" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &times; </span>
                </button>
                <h1 id="popupQualityProfileConfirmTitle" class="modal-title"> 품질 프로파일 </h1>
            </div>
            <div class="modal-body">
                <div class="modal_contBox">
                    <%--CREATE :: BEGIN--%>
                    <div id="popupCreateArea" style="display: none;">
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">품질 프로파일</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <input type="text" class="input-large" id="popupProfileNameCreate" name="popupProfileName"
                                           title="popupProfileName" value="" maxlength="100"
                                           placeholder="품질 프로파일명을 입력하세요(필수)">
                                </div>
                            </div>
                        </div>
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">개발언어</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <p>
                                        <select class="input-large" id="popupProfileLanguageCreate"></select>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--CREATE :: END--%>
                    <%--COPY   :: BEGIN--%>
                    <div id="popupCopyArea" style="display: none;">
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">품질 프로파일</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <input type="text" class="input-large" id="popupProfileNameCopy" name="popupProfileName"
                                           title="popupProfileName" value="" maxlength="100"
                                           placeholder="품질 프로파일명을 입력하세요(필수)">
                                </div>
                            </div>
                        </div>
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">개발언어</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <p id="popupProfileLanguageCopy"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--COPY   :: END--%>
                    <%--UPDATE :: BEGIN--%>
                    <div id="popupUpdateArea" style="display: none;">
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">품질 프로파일</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <input type="text" class="input-large" id="popupProfileNameUpdate" name="popupProfileName"
                                           title="popupProfileName" value="" maxlength="100"
                                           placeholder="품질 프로파일명을 입력하세요(필수)">
                                </div>
                            </div>
                        </div>
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">개발언어</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <p id="popupProfileLanguageUpdate"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--UPDATE :: END--%>
                </div>
            </div>
            <div class="modal-footer">
                <div id="popupCreateButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnProfileCreate"> 생성</button>
                        <button type="button" class="button btn_pop" data-dismiss="modal"> 취소</button>
                    </div>
                </div>
                <div id="popupCopyButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnProfileCopy"> 복제</button>
                        <button type="button" class="button btn_pop" data-dismiss="modal"> 취소</button>
                    </div>
                </div>
                <div id="popupUpdateButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnProfileUpdate"> 수정</button>
                        <button type="button" class="button btn_pop" data-dismiss="modal"> 취소</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--POPUP QUALITYPROFILE :: END--%>

<%-- Hidden Value :: BEGIN --%>
<input type="hidden" name="h_defaultProfileKey" id="h_defaultProfileKey"/>
<input type="hidden" name="h_profileKey" id="h_profileKey"/>
<input type="hidden" name="h_profileName" id="h_profileName"/>
<input type="hidden" name="h_language" id="h_language">
<input type="hidden" id="h_serviceInstanceId" name="h_serviceInstanceId" value="<c:out value='${serviceInstanceId}' default='' />">
<input type="hidden" name="h_isDefault" id="h_isDefault"/>
<%-- Hidden Value :: END --%>

<%-- Form Value :: BEGIN --%>
<form id="frm" name="frm" action="" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
    <input type="hidden" id="qprofile" name="qprofile" value=""/>
    <input type="hidden" id="severities" name="severities" value=""/>
</form>
<%-- Form Value :: END --%>

<script type="text/javascript">

    // ::::: Popup Types
    var gPopupTypeCreate = "Create";
    var gPopupTypeUpdate = "Update";
    var gPopupTypeCopy = "Copy";

    $(document.body).ready(function () {
        // --- 개발 언어별 품질 프로파일 List 조회
        getQualityProfileList();
    });

    // ::::: 개발 언어별 품질 프로파일 List 조회 : BEGIN
    var getQualityProfileList = function () {
        var reqUrl = "/qualityProfile/qualityProfileList.do";

        procCallAjax(reqUrl, null, callbackGetQualityProfileList);

    };
    //// [COLLBACK] 개발 언어별 품질 프로파일 List 조회
    var callbackGetQualityProfileList = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var dataLanguages = data.languages;
        var dataProfiles = data.profiles;

        var profileHtml = "";
        var htmlDefault = "";
        var htmlstr = "";

        var profileName = "";

        $.each(dataLanguages, function (index, language) {


            if (language.key.toUpperCase() == "JAVA") {
                profileHtml += "<h4>" + language.name + "</h4>";


                $.each(dataProfiles, function (index, profile) {

                    profileName = profile.name.toString().indexOf("^") > 0 ? profile.name.toString().split("^")[1] : profile.name;

                    if (language.key == profile.language) {
                        if (profile.isDefault) {

                            htmlDefault += "<li><a id='profileItem_"+profile.key
                                +"' data-isdefault='"+profile.isDefault
                                +"' data-name='"+profile.name
                                +"' data-language='"+profile.language
                                +"' href=\"javascript:profileDetail('"+profile.key+"')\">";

                            //htmlstr += "<span class='block ico_bul'>" + procSplitStringBySeparator(profile.name, "^") + "</span>";

                            htmlDefault += "<span class='block ico_bul'>" + profileName + "</span>";
                            htmlDefault += "<span class='issue_num'>";
                            if (profile.projectCount != null) {
                                htmlDefault += profile.projectCount;
                            }
                            htmlDefault += "<span class='word_sort'>기본</span>";
                            $("#h_defaultProfileKey").val(profile.key);
                            htmlDefault += "</span></a></li>";
                        } else {

                            htmlstr += "<li><a id='profileItem_"+profile.key
                                +"' data-isdefault='"+profile.isDefault
                                +"' data-name='"+profile.name
                                +"' data-language='"+profile.language
                                +"' href=\"javascript:profileDetail('"+profile.key+"')\">";

                            //htmlstr += "<span class='block ico_bul'>" + procSplitStringBySeparator(profile.name, "^") + "</span>";
                            htmlstr += "<span class='block ico_bul'>" + profileName + "</span>";
                            htmlstr += "<span class='issue_num'>";
                            if (profile.projectCount != null) {
                                htmlstr += profile.projectCount;
                            }
                            if (profile.isDefault) {
                                htmlstr += "<span class='word_sort'>기본</span>";

                                $("#h_defaultProfileKey").val(profile.key);
                            }
                            htmlstr += "</span></a></li>";
                        }

                    }
                });
            }
        });
        profileHtml += htmlDefault + htmlstr;
        $("#qualityProfileList").html(profileHtml);

    }
    // ::::: 개발 언어별 품질 프로파일 List 조회 : END

    // ::::: 품질 프로파일 상세 : BEGIN
    var profileDetail = function (profileKey, profileDefault, profileName, profileLanguage) {

        // profile Info
        var isDefault = profileDefault == null ? $('#profileItem_'+profileKey).data().isdefault : profileDefault;
        var namedata = profileName == null ? $('#profileItem_'+profileKey).data().name : profileName;
        var language = profileLanguage == null ? $('#profileItem_'+profileKey).data().language : profileLanguage;

        //console.log("=== profileDetail :: key :: "+ profileKey + " ::: profileDefault ::: "+ isDefault + " ::: language ::: "+ language);
        var name = namedata.toString().indexOf("^") > 0 ? namedata.toString().split("^")[1] : namedata;

        $("#contentProfileExp").css("display","none");
        $("#contentProfile").css("display","block");
        $("#profileName").text(name);
        $("#profileName").append("<span class='program'>"+language+"</span>");
        $("#h_profileName").val(name);
        $("#h_isDefault").val(isDefault);
        $("#h_language").val(language);
        $("#h_profileKey").val(profileKey);

        // console.log("GET getCodingRules ::::: s");
        // 코딩 규칙 정보 취득
        getCodingRules(profileKey, language);

        if (isDefault.toString() == "true") {
            $("#relatedProjectArea").css("display","none");
            $("#relatedProjectAreaDefault").css("display","block");
            $("#btnPopupProfileDelete").hide();

        } else {
            // 프로젝트 정보 취득
            $("#relatedProjectArea").css("display","block");
            $("#relatedProjectAreaDefault").css("display","none");
            $("#btnPopupProfileDelete").show();
            $("#allProject").html("");
            $("#projectLinked").html("");
            $("#projectUnLinked").html("");

            getProjects();
        }

    };
    //// 코딩 규칙 정보
    function getCodingRules(profileKey, language){

        var url = "/qualityProfile/codingRules.do?qprofile="+profileKey+"&languages="+language;
        procCallAjax(url, null, callbackGetCodingRules);
    }
    //// [COLLBACK] 코딩 규칙 정보
    var callbackGetCodingRules = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var qprofile = $("#h_profileKey").val();

        $("#crTotal").text(data.total);
        $("#crTotal").data("severity", "");

        var facets = data.facets;
        var values;
        $.each(facets, function (index, facet) {
            if ("severities" == facet.property) {
                values = facet.values;
            }
        });

        $.each(values, function (index, value) {

            if (value.val == "MAJOR") {
                $("#majorNum").text(value.count);
                $("#majorNum").data("severity", "MAJOR");
            }

            if (value.val == "MINOR") {
                $("#minorNum").text(value.count);
                $("#minorNum").data("severity", "MINOR");
            }

            if (value.val == "CRITICAL") {
                $("#criticalNum").text(value.count);
                $("#criticalNum").data("severity", "CRITICAL");
            }

            if (value.val == "INFO") {
                $("#infoNum").text(value.count);
                $("#infoNum").data("severity", "INFO");
                // .log($("#infoNum").data());
            }

            if (value.val == "BLOCKER") {
                $("#blockerNum").text(value.count);
                $("#blockerNum").data("severity", "BLOCKER");
            }

        });
    };
    //// 연결된 프로젝트 정보
    function getProjects() {
        procCallAjax("/qualityProfile/projects.do", null, callbackGetProjects);
    }
    //// [COLLBACK] 연결된 프로젝트 정보
    var callbackGetProjects = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        sub_tab(0);

        $("#allProject").html("");
        $("#projectLinked").html("");
        $("#projectUnLinked").html("");

        var profileKey = $("#h_profileKey").val();
        var linkedProjects;
        var unLinkedProjects;
        var allProjects;

        $.each(data, function (index, project) {

            if (project.qualityProfileKey == profileKey) {
                linkedProjects += "<tr>";
                linkedProjects += "<td><input type='checkbox' name='linkProject' data-id='"+project.id+"' id='chk_projectLinked_"+project.id+"' value='"+project.projectKey+"' checked></td>";
                linkedProjects += "<td class='alignL'>"+project.projectViewName+"</td>";
                linkedProjects += "</tr>";
            } else {
                unLinkedProjects += "<tr>";
                unLinkedProjects += "<td><input type='checkbox' name='linkProject' data-id='"+project.id+"' id='chk_projectUnLinked_"+project.id+"' value='"+project.projectKey+"'></td>";
                unLinkedProjects += "<td class='alignL'>"+project.projectViewName+"</td>";
                unLinkedProjects += "</tr>";
            }

            allProjects += "<tr>";
            allProjects += "<td><input type='checkbox' name='linkProject' data-id='"+project.id+"' id='chk_projectLinkAll_"+project.id+"' value='"+project.projectKey+"' ";
            if(project.qualityProfileKey == profileKey) {
                allProjects += "checked"
            }
            allProjects += "></td>";
            allProjects += "<td class='alignL'>"+project.projectViewName+"</td>";
            allProjects += "</tr>";
        });

        $("#allProject").html(allProjects);
        $("#projectLinked").html(linkedProjects);
        $("#projectUnLinked").html(unLinkedProjects);

    };
    // ::::: 품질 프로파일 상세 : END

    // ::::: 프로젝트 연결 / 해제 : BEGIN
    //// Page :: 프로젝트 연결 / 해제
    $(document).on("click", '[name="linkProject"]' , function() {

        var defaultProfileKey = $("#h_defaultProfileKey").val();
        var profileKey = $("#h_profileKey").val();

        var projectId = $(this).data().id;
        var projectKey = $(this).attr("value");
        var isCheck = $(this).is(":checked");

        var params = {
            id : projectId,
            projectId : projectId,
            projectKey : projectKey,
            qualityProfileKey : profileKey,
            linked : isCheck,
            defaultQualityProfileKey : defaultProfileKey
        };

        var reqUrl = "/qualityProfile/linkedProject.do";

        // console.log("Link Profile ::: defaultProfileKey ::: " + defaultProfileKey);
        // console.log("Link Profile ::: ProfileKey ::: " + profileKey);
        // console.log("Link Profile ::: Project ID ::: " + projectId);
        // console.log("Link Profile ::: Project Key ::: " + projectKey);
        // console.log("Link Profile ::: is Link ::: " + isCheck);

        procCallAjax(reqUrl, params, callbackLinkedProject);

    });
    //// [CALLBACK] 프로젝트 연결 / 해제
    var callbackLinkedProject = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        // 연결된 프로젝트 정보
        getProjects();
        // 품질 프로파일 정보
        getQualityProfileList();

    };
    // ::::: 프로젝트 연결 / 해제 : END

    // ::::: 코딩규칙 건수 클릭 -> 코딩 규칙 페이지 이동 : BEGIN
    $(".code_rulenumber").on("click", function () {

        // 프로파일 키
        var qprofile = $("#h_profileKey").val();
        var severity = $(this).data().severity;

        // console.log("qprofile ::: "+ qprofile);
        // console.log("severity ::: "+ severity);

        $("#frm").attr("action", procGetDashboardUrl()+"/codingRules/dashboard");
        $("#qprofile").val(qprofile);
        $("#severities").val(severity);
        $("#frm").submit();

    });
    // ::::: 코딩규칙 건수 클릭 -> 코딩 규칙 페이지 이동 : END

    // ::::: 품질 프로파일 생성 : BEGIN
    //// Page :: 품질 프로파일 생성
    $("#btnPopupProfileCreate").on("click", function () {

        var objModalList = $('#modalQualityProfileList');

        // 개발언어 리스트 조회
        getQualityProfileLanguages();

        // Popup 설정
        procSetPopupArea(gPopupTypeCreate);

        objModalList.modal('toggle');
    });
    //// Popup :: 품질 프로파일 생성
    $("#btnProfileCreate").on("click", function () {

        // Popup :: 입력값  유효성 체크
        procValidatePopup(gPopupTypeCreate);

    });

    //// 품질 프로파일 생성
    var CreateQualityProfile = function () {
        var newProfileName = $("#h_serviceInstanceId").val() + "^" + $('#popupProfileName'+ gPopupTypeCreate).val();

        var reqParam = {
            serviceInstanceId: $("#h_serviceInstanceId").val(),
            name: newProfileName,
            language: $('#popupProfileLanguage' + gPopupTypeCreate).val()
        };

        procCallAjax("/qualityProfile/qualityProfileCreate.do", reqParam, callbackCreateQualityProfile);
    };
    //// [COLLBACK] 품질 프로파일 생성
    var callbackCreateQualityProfile = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        getQualityProfileList();
        $('#modalQualityProfileList').modal('hide');
        procPopupAlert('생성 되었습니다.');
    };
    // ::::: 품질 프로파일 생성 : END

    // ::::: 품질 프로파일 복제 : BEGIN
    //// Page :: 품질 프로파일 복제
    $("#btnPopupProfileCopy").on("click", function () {

        var objModalList = $('#modalQualityProfileList');
        // Popup 설정
        procSetPopupArea(gPopupTypeCopy);

        objModalList.modal('toggle');
    });
    //// Popup :: 품질 프로파일 복제
    $("#btnProfileCopy").on("click", function () {

        // Popup :: 입력값  유효성 체크
        procValidatePopup(gPopupTypeCopy);

    });
    //// 품질 프로파일 복제
    var CopyQualityProfile = function () {
        var newProfileName = $("#h_serviceInstanceId").val() + "^" + $('#popupProfileName'+ gPopupTypeCopy).val();

        var reqParam = {
            serviceInstanceId: $("#h_serviceInstanceId").val(),
            toName: newProfileName,
            fromKey: $("#h_profileKey").val(),
            language: $('#h_language').val()
        };
        procCallSpinner(SPINNER_START);

        procCallAjax("/qualityProfile/qualityProfileCopy.do", reqParam, callbackCopyQualityProfile);

    };
    //// [COLLBACK] 품질 프로파일 복제
    var callbackCopyQualityProfile = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var profileKey = data.key;

        $("#h_profileKey").val(profileKey);

        // 프로파일 목록 조회
        getQualityProfileList();
        $('#modalQualityProfileList').modal('hide');
        procPopupAlert('복제 되었습니다.');
        profileDetail(profileKey, data.isDefault, data.name, data.language);

        procCallSpinner(SPINNER_STOP);

    };
    // ::::: 품질 프로파일 복제 : END

    // ::::: 품질 프로파일 수정 : BEGIN
    //// Page :: 품질 프로파일 수정
    $("#btnPopupProfileUpdate").on("click", function () {

        var objModalList = $('#modalQualityProfileList');

        // Popup 설정
        procSetPopupArea(gPopupTypeUpdate);

        objModalList.modal('toggle');
    });
    //// Popup :: 품질 프로파일 수정
    $("#btnProfileUpdate").on("click", function () {

        // 입력값  유효성 체크
        procValidatePopup(gPopupTypeUpdate);

    });
    //// 품질 프로파일 수정
    var UpdateQualityProfile = function () {
        var newProfileName = $("#h_serviceInstanceId").val() + "^" + $('#popupProfileName'+ gPopupTypeUpdate).val();

        var reqParam = {
            serviceInstanceId: $("#h_serviceInstanceId").val(),
            key: $("#h_profileKey").val(),
            name: newProfileName,
            language : $("#h_language").val(),
            isDefault : $("#h_isDefault").val()
        };

        procCallAjax("/qualityProfile/qualityProfileUpdate.do", reqParam, callbackUpdateQualityProfile);
    };
    //// [COLLBACK] 품질 프로파일 수정
    var callbackUpdateQualityProfile = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var profileKey = data.key;

        // 프로파일 목록 조회
        getQualityProfileList();
        profileDetail(profileKey,data.isDefault, data.name, data.language);
        $('#modalQualityProfileList').modal('hide');
        procPopupAlert('수정 되었습니다.');
    };
    // ::::: 품질 프로파일 수정 : END

    // ::::: 품질 프로파일 삭제 : BEGIN
    //// Page :: 품질 프로파일 삭제
    $("#btnPopupProfileDelete").on("click", function () {

        var btnText = $("#btnPopupProfileDelete").text();

        var reqTitle = $('popupQualityProfileConfirmTitle').text() +" "+btnText;
        var reqMessage = btnText + " 하시겠습니까?";
        var procFunction = "DeleteQualityProfile();";
        var reqButtonText = btnText;

        procPopupConfirm(reqTitle, reqMessage, procFunction, reqButtonText, null);

    });
    //// 품질 프로파일 삭제
    var DeleteQualityProfile = function () {

        var linkedProjects = new Array();
        var profileKey = $("#h_profileKey").val();
        var defaultProfileKey = $("#h_defaultProfileKey").val();

        $("input[id^='chk_projectLinked_']:checked").each(function() {
            //linkedProjects.push($(this).val());
            var project = new Object();
            project.id = $(this).data().id;
            project.projectId = $(this).data().id;
            project.projectKey = $(this).val();
            project.qualityProfileKey = profileKey;
            project.linked = false;
            project.defaultQualityProfileKey = defaultProfileKey;

            linkedProjects.push(project);
        });

        //console.log(">>linkedProjects.length>> "+ linkedProjects.length);
        //console.log(">>linkedProjects.toString>> "+ linkedProjects.toString());

        var reqParam = {
            profileKey: $("#h_profileKey").val(),
            linkedProjects : linkedProjects
        };
        procCallAjax("/qualityProfile/qualityProfileDelete.do", reqParam, callbackDeleteQualityProfile);
    };
    //// [COLLBACK] 품질 프로파일 삭제
    var callbackDeleteQualityProfile = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        // 프로파일 목록 조회
        getQualityProfileList();
        procPopupAlert('삭제 되었습니다.');
        $("#contentProfileExp").css("display","block");
        $("#contentProfile").css("display","none");

    };
    // ::::: 품질 프로파일 삭제 : END

    // ::::: [ POPUP ] : BEGIN

    //// Popup : 개발 언어 리스트 조회 : BEGIN
    var getQualityProfileLanguages = function () {

        procCallAjax("/qualityProfile/qualityProfileLanguageList.do", null, callbackGetQualityProfileLanguages);
    };
    //// [COLLBACK] Popup : 개발 언어 리스트 조회
    var callbackGetQualityProfileLanguages = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var selectList;

        $.each(data, function (index, language) {
            selectList += "<option value='" + language.key + "'";

            if (language.key.toUpperCase() == "JAVA") {
                selectList += " selected";
            }
            selectList += ">";
            selectList += language.name + "</option>";
        });

        $("#popupProfileLanguageCreate").html(selectList);


    };
    //// Popup : 개발 언어 리스트 조회 : END

    //// Popup : Set PopUp Area : BEGIN
    var procSetPopupArea = function (type) {

        var procTypeArray = [gPopupTypeCreate, gPopupTypeUpdate, gPopupTypeCopy];

        $.each(procTypeArray, function (index, procType) {
            $('#popup' + procType + 'Area').hide();
            $('#popup' + procType + 'ButtonArea').hide();
            $('#popupProfileName'+type).val("");

            if (procType == type) {
                $('#popup' + procType + 'Area').fadeIn("slow");
                $('#popup' + procType + 'ButtonArea').fadeIn("slow");

                if (procType != gPopupTypeCreate) {
                    $('#popupProfileLanguage'+type).text($('#h_language').val());
                }
            }

        });
    };
    //// Popup : Set PopUp Area : END

    //// Popup : 입력값  유효성 체크 : BEGIN
    var procValidatePopup = function(type) {

        var popupProfileName = $('#popupProfileName'+ type).val();
        var popupProfileLanguage = $('#popupProfileLanguage' + type).val();

        $('#modalQualityProfileList').modal('hide');

        // 품질 프로파일 명 유효성 체크
        if (procIsNullString(popupProfileName)) {
            procPopupAlert("품질 프로파일 명을 입력하십시오.", "procSetPopupFocus('" + type + "', '" + 'popupProfileNme'+type + "');", "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        if (!procValidateQualityKeyName(popupProfileName)) {
            procPopupAlert("품질 프로파일 명을 확인하십시오.[영문, 숫자, '-' ,'_' 사용가능]", "procSetPopupFocus('" + type + "', '" + 'popupProfileNme'+type + "');", "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        var newProfileName = $("#h_serviceInstanceId").val() + "^" + popupProfileName;
        var inputLength = 100 - $("#h_serviceInstanceId").val().length -1;

        if (procValidateQualityKeyNameLength(newProfileName)) {
            procPopupAlert("품질 프로파일 명은 최대 " + inputLength+ "자까지 입력 가능합니다.", "procSetPopupFocus('" + type + "', '" + 'popupProfileNme'+type + "');", "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        if (type == gPopupTypeCreate ) {
            // 개발언어 유효성 체크
            if (popupProfileLanguage.toUpperCase() != "JAVA") {
                procPopupAlert("개발 언어는 현재 JAVA만 지원되고 있습니다.", "procSetPopupFocus('" + type + "', '" + 'popupProfileLanguage'+type + "');", "<%= Constants.CHECK_YN_Y %>");
                $('#popupProfileLanguage' + type).val("java");
                return false;
            }
        }

        var reqTitle = $('popupQualityProfileConfirmTitle').text() +" "+ $('#btnProfile'+type).text();
        var reqMessage = $('#btnProfile'+type).text() + " 하시겠습니까?";
        var procFunction = type + "QualityProfile();";
        var reqButtonText = $('#btnProfile'+type).text();

        procPopupConfirm(reqTitle, reqMessage, procFunction, reqButtonText, null);

    };
    //// Popup : 입력값  유효성 체크 : END

    //// Popup : SET POPUP FOCUS : BEGIN
    var procSetPopupFocus = function(type, reqObject) {
        var objModalList = $('#modalQualityProfileList');

        procSetPopupArea(type);
        objModalList.modal('show');

        objModalList.on('shown.bs.modal', function () {

            $('#' + reqObject).focus();
        });
    };
    //// Popup : SET POPUP FOCUS : END

    // ::::: [ POPUP ] : END
</script>