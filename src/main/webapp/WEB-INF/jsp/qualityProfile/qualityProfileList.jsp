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
                    <h3 class="sub_title">코딩규칙 <a href="javascript:void(0);" onclick="rulesPageMove()"><span id="crTotal"></span></a></h3>
                    <table summary="코딩규칙 테이블입니다." class="quality_list">
                        <caption>코딩규칙</caption>
                        <colgroup>
                            <col style="width: 100%" />
                        </colgroup>
                        <tbody>
                        <tr>
                            <td>
                                <ul class="rule_list">
                                    <li><span class="issue_name"><i class="ico_blocker"></i>심각 (Blocker)</span> <a href="javascript:void(0);" onclick="rulesPageMove()"><span class="code_rulenumber" id="blockerNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_critical"></i>높음 (Critical)</span> <a href="javascript:void(0);" onclick="rulesPageMove()"><span class="code_rulenumber" id="criticalNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_major"></i>보통 (Major)</span> <a href="javascript:void(0);" onclick="rulesPageMove()"><span class="code_rulenumber" id="majorNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_minor"></i>낮음 (Minor)</span> <a href="javascript:void(0);" onclick="rulesPageMove()"><span class="code_rulenumber" id="minorNum"></span></a></li>
                                    <li><span class="issue_name"><i class="ico_info"></i>정보 (Info)</span> <a href="javascript:void(0);" onclick="rulesPageMove()"><span class="code_rulenumber" id="infoNum"></span></a></li>
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

<script type="text/javascript">

    var doubleSubmitFlag = false;
    //더블클릭 방지
    function doubleSubmitCheck(){

        if(doubleSubmitFlag){
            return doubleSubmitFlag;
        }else{
            doubleSubmitFlag = true;
            return false;
        }
    }

    // Popup Types
    var gPopupTypeCreate = "Create";
    var gPopupTypeUpdate = "Update";
    var gPopupTypeCopy = "Copy";

    $(document.body).ready(function () {
        // Left :: 개발 언어별 품질 프로파일 List 조회
        getQualityProfileList();
    });


    // Set PopUp Area
    var procSetPopupArea = function (type) {

        var procTypeArray = [gPopupTypeCreate, gPopupTypeUpdate, gPopupTypeCopy];

        $.each(procTypeArray, function (index, procType) {

            $('#popupProfileName'+type).val("");

            if (procType == type) {
                $('#popup' + procType + 'Area').fadeIn("slow");
                $('#popup' + procType + 'ButtonArea').fadeIn("slow");

                if (procType != gPopupTypeCreate) {
                    $('#popupProfileLanguage'+type).text($('#h_language').val());
                }
            } else {
                $('#popup' + procType + 'Area').hide();
                $('#popup' + procType + 'ButtonArea').hide();
            }

        });
    };

    // 품질 프로파일 생성 Popup
    $("#btnPopupProfileCreate").on("click", function () {

        var objModalList = $('#modalQualityProfileList');

        // 개발언어 리스트 조회
        getQualityProfileLanguages();

        // Popup 설정
        procSetPopupArea(gPopupTypeCreate);

        objModalList.modal('toggle');
    });

    // 품질 프로파일 생성
    $("#btnProfileCreate").on("click", function () {

        // 입력값  유효성 체크
        procValidatePopup(gPopupTypeCreate);

    });

    // validate popup
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

    // SET POPUP FOCUS
    var procSetPopupFocus = function(type, reqObject) {
        var objModalList = $('#modalQualityProfileList');

        procSetPopupArea(type);
        objModalList.modal('show');

        objModalList.on('shown.bs.modal', function () {

            $('#' + reqObject).focus();
        });
    };

    // 품질 프로파일 복제
    $("#btnPopupProfileCopy").on("click", function () {

        var objModalList = $('#modalQualityProfileList');

        // Popup 설정
        procSetPopupArea(gPopupTypeCopy);

        objModalList.modal('toggle');
    });


    // 품질 프로파일 복제
    $("#btnProfileCopy").on("click", function () {

        // 입력값  유효성 체크
        procValidatePopup(gPopupTypeCopy);

    });

    // 품질 프로파일 수정
    $("#btnPopupProfileUpdate").on("click", function () {

        var objModalList = $('#modalQualityProfileList');

        // Popup 설정
        procSetPopupArea(gPopupTypeUpdate);

        objModalList.modal('toggle');
    });

    // 품질 프로파일 수정
    $("#btnProfileUpdate").on("click", function () {

        // 입력값  유효성 체크
        procValidatePopup(gPopupTypeUpdate);

    });

    // 품질 프로파일 삭제
    $("#btnPopupProfileDelete").on("click", function () {

        var btnText = $("#btnPopupProfileDelete").text();

        var reqTitle = $('popupQualityProfileConfirmTitle').text() +" "+btnText;
        var reqMessage = btnText + " 하시겠습니까?";
        var procFunction = "DeleteQualityProfile();";
        var reqButtonText = btnText;

        procPopupConfirm(reqTitle, reqMessage, procFunction, reqButtonText, null);

    });
    // ------ function
    // Left :: 개발 언어별 품질 프로파일 List 조회 ::::: s
    var getQualityProfileList = function () {
        var reqUrl = "/qualityProfile/qualityProfileList.do";

        procCallAjax(reqUrl, null, callbackGetQualityProfileList);

    };
    // [Collback] Left :: 개발 언어별 품질 프로파일 List 조회
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
    // Left :: 개발 언어별 품질 프로파일 List 조회 ::::: e

    // 품질 프로파일 생성 > 개발 언어 조회 ::::: s
    var getQualityProfileLanguages = function () {

        procCallAjax("/qualityProfile/qualityProfileLanguageList.do", null, callbackGetQualityProfileLanguages);
    };

    // [Collback] 품질 프로파일 생성 > 개발 언어 조회
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
    // 품질 프로파일 생성 > 개발 언어 조회 ::::: e

    // 품질 프로파일 생성 ::::: S
    var CreateQualityProfile = function () {
        var newProfileName = $("#h_serviceInstanceId").val() + "^" + $('#popupProfileName'+ gPopupTypeCreate).val();

        var reqParam = {
            serviceInstanceId: $("#h_serviceInstanceId").val(),
            name: newProfileName,
            language: $('#popupProfileLanguage' + gPopupTypeCreate).val()
        };

        procCallAjax("/qualityProfile/qualityProfileCreate.do", reqParam, callbackCreateQualityProfile);
    };

    // [Collback] 품질 프로파일 생성
    var callbackCreateQualityProfile = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        getQualityProfileList();
        $('#modalQualityProfileList').modal('hide');
        procPopupAlert('생성 되었습니다.');


    };
    // 품질 프로파일 생성 ::::: e

    // 품질 프로파일 상세 ::::: s

    var profileDetail = function (profileKey, profileDefault, profileName, profileLanguage) {
//        procCallSpinner(SPINNER_START);

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

        doubleSubmitFlag = false;

        //console.log("GET getCodingRules ::::: s");
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

            sub_tab(0);
            getReleatedProjects(profileKey);
        }

//        procCallSpinner(SPINNER_STOP);

    };

    function getCodingRules(profileKey, language){

        var url = "/qualityProfile/codingRules.do?qprofile="+profileKey+"&languages="+language;

        procCallAjax(url, null, callbackGetCodingRules);
    }

    // [Collback] 코딩 규칙
    var callbackGetCodingRules = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        $("#crTotal").text(data.total);

        var facets = data.facets;
        var values;
        $.each(facets, function (index, facet) {
            if ("active_severities" == facet.property) {
                values = facet.values;
            }
        });

        $.each(values, function (index, value) {

            if (value.val == "MAJOR") {
                $("#majorNum").text(value.count);
            }

            if (value.val == "MINOR") {
                $("#minorNum").text(value.count);
            }

            if (value.val == "CRITICAL") {
                $("#criticalNum").text(value.count);
            }

            if (value.val == "INFO") {
                $("#infoNum").text(value.count);
            }

            if (value.val == "BLOCKER") {
                $("#blockerNum").text(value.count);
            }

        });


    };

    function getReleatedProjects(profileKey) {

        procCallAjax("/qualityProfile/projects.do?key="+profileKey+"&selected=all", null, callbackGetProjects);

    }
    // [Collback] 연결된 프로젝트
    var callbackGetProjects = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var results = data.results;
        var releatedProjects;
        var unReleatedProjects;
        var allProjects;

        $.each(results, function (index, result) {

            if(result.selected) {
                releatedProjects += "<tr>";
                releatedProjects += "<td><input type='checkbox' id='CheckboxSelected_"+result.uuid+"' value='"+result.uuid+"' checked></td>";
                releatedProjects += "<td class='alignL'>"+result.name+"</td>";
                releatedProjects += "</tr>";
            }

            if(!result.selected) {
                unReleatedProjects += "<tr>";
                unReleatedProjects += "<td><input type='checkbox' id='CheckboxUnSelected_"+result.uuid+"' value='"+result.uuid+"'></td>";
                unReleatedProjects += "<td class='alignL'>"+result.name+"</td>";
                unReleatedProjects += "</tr>";
            }

            allProjects += "<tr>";
            allProjects += "<td><input type='checkbox' id='Checkbox_"+result.uuid+"' value='"+result.uuid+"' ";
            if(result.selected) {
                allProjects += "checked"
            }
            allProjects += "></td>";
            allProjects += "<td class='alignL'>"+result.name+"</td>";
            allProjects += "</tr>";
        });

        $("#allProject").html(allProjects);
        $("#projectLinked").html(releatedProjects);
        $("#projectUnLinked").html(unReleatedProjects);

    };
    // 품질 프로파일 상세 ::::: e

    // 품질 프로파일 복제 ::::: s

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

    // [Collback] 품질 프로파일 복제
    var callbackCopyQualityProfile = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
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

    // 품질 프로파일 수정 ::::: s
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

    // [Collback] 품질 프로파일 수정
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

    // 품질 프로파일 삭제 ::::: s
    var DeleteQualityProfile = function () {

        var reqParam = {
            profileKey: $("#h_profileKey").val()
        };

        procCallAjax("/qualityProfile/qualityProfileDelete.do", reqParam, callbackDeleteQualityProfile);
    };

    // [Collback] 품질 프로파일 삭제
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

</script>