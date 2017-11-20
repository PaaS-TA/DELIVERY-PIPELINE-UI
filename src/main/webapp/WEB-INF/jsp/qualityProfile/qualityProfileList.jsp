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
            <div clss="contentWrap" id="contentProfileExp"style="display: block">
                <h5 style="line-height:2.3em;">&nbsp;&nbsp;품질 프로파일은 분석하는 동안 적용 할 규칙 모음입니다. <br>&nbsp;&nbsp;각 언어별로 기본 프로파일이 있습니다. 다른 프로파일에 명시적으로 할당되지 않은 모든 프로젝트는 기본값으로 분석됩니다.</h5>
            </div>
            <div class="contentWrap" id="contentProfile" style="display: none">
                <div class="content_in">
                    <!-- sub 타이틀 영역 :s -->
                    <div class="col-md-7 fl">
                        <h3 class="proj_tit" id="profileName"><span class="program">Java</span></h3>
                    </div>
                    <div class="fr mb10">
                        <button type="button" class="button btn_default" id="profileCopy">복제</button>
                        <button type="button" class="button btn_default" id="profileUpdate">수정</button>
                        <button type="button" class="button btn_default" id="deleteProfileBtn">삭제</button>
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
                                    <tbody id="projectFailure">

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


<%--POPUP CF URL :: BEGIN--%>
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
                </div>
            </div>
            <div class="modal-footer">
                <div id="popupCreateButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnProfileCreate"> 생성</button>
                        <button type="button" class="button btn_pop" data-dismiss="modal"> 취소</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--POPUP CF URL :: END--%>


<input type="hidden" name="profileKey" id="profileKey"/>
<input type="hidden" name="profileId" id="profileId"/>
<input type="hidden" name="langName" id="langName">
<input type="hidden" name="language" id="language">
<input type="hidden" id="serviceInstancesId" name="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />">
<input type="hidden" id="defaultYn">

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
        console.log("::::: start :::::");
        getQualityProfileList();
        console.log("::::: end :::::");
    });


    // Set PopUp Area
    var procSetPopupArea = function (type) {

        var procTypeArray = [gPopupTypeCreate, gPopupTypeUpdate, gPopupTypeCopy];

        $.each(procTypeArray, function (index, procType) {

            if (procType == type) {
                $('#popup' + procType + 'Area').fadeIn("slow");
                $('#popup' + procType + 'ButtonArea').fadeIn("slow");
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

//        console.log("popupProfileName:::" + popupProfileName);
//        console.log("popupProfileLanguage:::" + popupProfileLanguage);

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

        var newProfileName = G_SERVICE_INSTANCE_ID + "^" + popupProfileName;
        var inputLength = 100 - G_SERVICE_INSTANCE_ID.length -1;
        console.log ("new profileName :::: "+ newProfileName);

        if (procValidateQualityKeyNameLength(newProfileName)) {
            procPopupAlert("품질 프로파일 명은 최대 " + inputLength+ "자까지 입력 가능합니다.", "procSetPopupFocus('" + type + "', '" + 'popupProfileNme'+type + "');", "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        // 개발언어 유효성 체크
        if (popupProfileLanguage.toUpperCase() != "JAVA") {
            procPopupAlert("개발 언어는 현재 JAVA만 지원되고 있습니다.", "procSetPopupFocus('" + type + "', '" + 'popupProfileLanguage'+type + "');", "<%= Constants.CHECK_YN_Y %>");
            $('#popupProfileLanguage' + type).val("java");
            return false;
        }

        var reqTitle = $('popupQualityProfileConfirmTitle').text() +" "+ $('#btnProfile'+type).text();
        var reqMessage = $('#btnProfile'+type).text() + " 하시겠습니까?";
        var procFunction = type + "QualityProfile();";
        var reqButtonText = $('#btnProfile'+type).text();

//        console.log("reqTitle ::: "+ reqTitle);
//        console.log("reqMessage ::: "+ reqMessage);
//        console.log("procFunction ::: "+ procFunction);
//        console.log("reqButtonText ::: "+ reqButtonText);

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



//    $("li[id^=profile_]").on("click", function () {
//    $("#profile_java_1").on("click", function () {
//        console.log("success");
//        console.log("profile-list-item");
//        console.log("profile-list-item :: key ::: "+$(this).data().key);
//        console.log("profile-list-item :: language :: "+$(this).data().language);
//
//    });



    // ------ function
    // Left :: 개발 언어별 품질 프로파일 List 조회 ::::: s
    var getQualityProfileList = function () {
        var reqUrl = "/qualityProfile/qualityProfileList.do";

        procCallAjax(reqUrl, null, callbackGetQualityProfileList);

    }
    // [Collback] Left :: 개발 언어별 품질 프로파일 List 조회
    var callbackGetQualityProfileList = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var dataLanguages = data.languages;
        var dataProfiles = data.profiles;

        var htmlstr = "";
        var profileName;

        $.each(dataLanguages, function (index, language) {
//            console.log("KEY:::" + language.key);
//            console.log("VALUE:::" + language.name);

            if (language.key.toUpperCase() == "JAVA") {
                htmlstr += "<h4>" + language.name + "</h4>";

                $.each(dataProfiles, function (index, profile) {

//                    console.log("PROFILE :: LANGUAGE :: " + profile.language);

                    if (language.key == profile.language) {

//                        console.log("before :: profile.name :: " + profile.name);
                        //TODO replace
//
//                        console.log(newstr);  // Twas the night before Christmas...

//                        console.log("PROFILE :: LANGUAGE :: " + profile.language);
                        htmlstr += "<li><a id='profileItem_"+profile.key
                            +"' data-default='"+profile.isDefault
                            +"' data-name='"+profile.name
                            +"' data-language='"+profile.language
                            +"' href=\"javascript:profileDetail('"+profile.key+"')\">";
//                        htmlstr += "<a href=\"javascript:profileDetail()\">";

                        //TODO
                        // data-key , data-language
//                    <a href=\"javascript:profileActive(\'"+data[i].key+"', '"+data[i].name+"','"+data[i].id+"','"+data[i].languageName+"','"+data[i].language+"','"+data[i].profileDefaultYn+"')\"><span class='block ico_bul'>"+data[i].name+"</span> <span class='issue_num'><span class='word_sort'>기본</span></span></a></li>";
                        htmlstr += "<span class='block ico_bul'>" + profile.name + "</span>";
                        htmlstr += "<span class='issue_num'>";
                        if (profile.projectCount != null) {
                            htmlstr += profile.projectCount;
                        }
                        if (profile.isDefault) {
                            htmlstr += "<span class='word_sort'>기본</span>";
                        }
                        htmlstr += "</span></a></li>";
                    }
                });
            }
        });

        $("#qualityProfileList").html(htmlstr);
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
        $("#popupProfileNameCreate").html("");


    };
    // 품질 프로파일 생성 > 개발 언어 조회 ::::: e

    // 품질 프로파일 생성 ::::: S
    var CreateQualityProfile = function () {
        var newProfileName = G_SERVICE_INSTANCE_ID + "^" + $('#popupProfileName'+ gPopupTypeCreate).val();

        console.log("=== CreateQualityProfile :: name :: "+ newProfileName);
        var reqParam = {
            serviceInstanceId: G_SERVICE_INSTANCE_ID,
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

    var profileDetail = function (profileKey) {

        // profile Info
        var isDefault = $('#profileItem_'+profileKey).data().default;
        var name = $('#profileItem_'+profileKey).data().name;
        var language = $('#profileItem_'+profileKey).data().language;

//        procCallSpinner(SPINNER_START);

        $("#contentProfileExp").css("display","none");
        $("#contentProfile").css("display","block");
        $("#profileName").text(name);
        $("#profileName").append("<span class='program'>"+language+"</span>");
//        $("#langName").val(langName);
//        $("#profileId").val(id);
//        $("#profileKey").val(key);
//        $("#language").val(language);
//        $("#defaultYn").val(defaultYn);
        doubleSubmitFlag = false;

        console.log("GET getCodingRules ::::: s");
        // 코딩 규칙 정보 취득
        getCodingRules(profileKey, language);

        if (isDefault) {
            $("#relatedProjectArea").css("display","none");
            $("#relatedProjectAreaDefault").css("display","block");
        } else {
            // 프로젝트 정보 취득
            $("#relatedProjectArea").css("display","block");
            $("#relatedProjectAreaDefault").css("display","none");
            $("#allProject").html("");
            $("#projectLinked").html("");
            $("#projectFailure").html("");
            sub_tab(0);
            getReleatedProjects(profileKey);
        }

//        procCallSpinner(SPINNER_STOP);

    };

    function getCodingRules(profileKey, language){

        var url = "/codingRules/codingRules.do?qprofile="+profileKey+"&languages="+language+"&facets=active_severities";

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
        console.log("results >>::: "+results);
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
        $("#projectFailure").html(unReleatedProjects);






    };
    // 품질 프로파일 상세 ::::: e


</script>