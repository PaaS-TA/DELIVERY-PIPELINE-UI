<%--
  Created by IntelliJ IDEA.
  User: lena
  Date: 2017-11-21
  Time: 오후 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- location :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li>코딩 규칙</li>
        </ul>
    </div>
</div>
<!-- location :e -->

<div id="container">
    <!-- content :s -->
    <div class="">
        <!-- full_sub_content :s -->
        <div class="">
            <!-- left :s -->
            <div class="lnbWrap">
                <div class="lnb">
                    <!-- 검색 :s -->
                    <div class="pl12 mt10">
                        <form id="" method="post" action="">
                            <div class="lnb_search">
                                <input id="search_keyword" id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;"  placeholder="규칙명 검색" autocomplete="on" />
                                <%--<input id="search_keyword" id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;"  placeholder="규칙명 검색" autocomplete="on" />--%>
                                <a class="btn_search" href="#none" title="검색"></a>
                            </div>
                        </form>
                    </div>
                    <!--//검색 :e -->
                    <ul class="mt10">
                        <h4>개발언어 (Language)</h4>
                        <c:forEach items="${languages}" var="language" varStatus="status">
                            <c:if test="${fn:containsIgnoreCase(language.val, 'JAVA')}">
                            <li <c:if test="${status.last}">class="last"</c:if>>
                                    <%--<input type="checkbox" name="${language.val}" id="chk_languages_${language.val}" value="${language.val}">--%>
                                <span class="block" style="padding-left:20px;">${fn:substring(language.val, 0, 1).toUpperCase()}${fn:substring(language.val, 1, fn:length(language.val))}</span>
                                <span class="issue_num" id="language_${language.val}_num" style="padding-left:220px;">${language.count}</span>
                            </li>
                            </c:if>
                        </c:forEach>
                        <%--<div id="searchLang"></div>--%>
                        <h4>이슈 수준 (Severity)</h4>
                        <div id="searchIssue">
                            <li>
                                <a href="#none">
                                    <input type="checkbox" id="chk_severity_blocker" name="issue" value="BLOCKER">
                                    <label for="chk_severity_blocker"> <span class="block"><i class="ico_blocker"></i>심각 (Blocker)</span> <span id="severityBlockerNum" class="issue_num">${severities.BLOCKER}</span></label>
                                </a>
                            </li>
                            <li>
                                <a href="#none">
                                    <input type="checkbox" id="chk_severity_critical" name="issue" value="CRITICAL">
                                    <label for="chk_severity_critical"> <span class="block"><i class="ico_critical"></i>높음 (Critical)</span> <span id="severityCriticalNum" class="issue_num">${severities.CRITICAL}</span></label>
                                </a>
                            </li>
                            <li>
                                <a href="#none">
                                    <input type="checkbox" id="chk_severity_major" name="issue" value="MAJOR">
                                    <label for="chk_severity_major"><span class="block"><i class="ico_major"></i>보통 (Major)</span> <span id="severityMajorNum" class="issue_num">${severities.MAJOR}</span></label>
                                </a>
                            </li>
                            <li>
                                <a href="#none">
                                    <input type="checkbox" id="chk_severity_minor" name="issue" value="MINOR">
                                    <label for="chk_severity_minor"> <span class="block"><i class="ico_minor"></i>낮음 (Minor)</span> <span id="severityMinorNum" class="issue_num">${severities.MINOR}</span></label>
                                </a>
                            </li>
                            <li class="last">
                                <a href="#none">
                                    <input type="checkbox" id="chk_severity_info" name="issue" value="INFO">
                                    <label for="chk_severity_info"><span class="block"><i class="ico_info"></i>정보 (Info)</span> <span id="severityInfoNum" class="issue_num">${severities.INFO}</span></label>
                                </a>
                            </li>
                        </div>
                        <h4>품질 프로파일 (Quality Profile)</h4>
                        <li id="listProfileCondition_">
                            <a id="qualityProfile_all" data-profileKey="" href="#none">
                                <%--<input type="checkbox" data-profileKey="all" name="qualityProfile_all" id="qualityProfile_all" value="${qualityProfile.name}">--%>
                                <%--<label for="chk_profile_${qualityProfile.key}" style="cursor:pointer"><span class="block" style="width:220px;">${qualityProfile.name}</span></label>--%>
                                <span class="block" style="width:220px;">전체 보기</span>
                            </a>
                        </li>
                        <c:forEach items="${qualityProfiles}" var="qualityProfile" varStatus="status">
                            <li id="listProfileCondition_${qualityProfile.key}">
                                <a id="qualityProfile_${qualityProfile.key}" data-profileKey=${qualityProfile.key} href="#none">
                                    <%--<input type="checkbox" data-profileKey=${qualityProfile.key} name="${qualityProfile.key}" id="chk_profile_${qualityProfile.key}" value="${qualityProfile.name}">--%>
                                    <%--<label for="chk_profile_${qualityProfile.key}" style="cursor:pointer">--%>
                                        <span class="block" style="width:220px;">
                                            ${fn:indexOf(qualityProfile.name, "^") > 0 ? fn:split(qualityProfile.name,"^")[1] : qualityProfile.name}
                                        </span>
                                    <%--</label>--%>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <!--//left :e -->
            <!-- contentWrap :s -->
            <div class="contentWrap" >
                <div class="content_in">
                    <div id="ruleList" style="display:block;">
                        <!-- 리스트 테이블 -->
                        <table summary="코딩규칙 리스트 테이블입니다." class="quality_list">
                            <caption>코딩규칙 리스트</caption>
                            <colgroup>
                                <col style="width: *" />
                                <col style="width:5%">
                                <col style="width:8%">
                                <col style="width:11%">
                            </colgroup>
                            <thead></thead>
                            <tbody id="codingRulesData">
                            <c:forEach items="${rules}" var="rule" varStatus="status">
                            <tr>
                                <td class="rule_tit">${rule.name}</td>
                                <td class="alignC"><i class="ico_${fn:toLowerCase(rule.severity)}"></i></td>
                                <td class="alignC">${rule.langName}</td>
                                <td class="alignC"><button type="button" data-ruleKey="${rule.key}" id="btn_activate_${rule.key}" class="button quality_btn">프로파일에 추가</button></td>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <!--//리스트 테이블-->
                    </div>

                    <!--//상세 테이블 -->
                    <div id="crDetail" style="display:none;">

                    </div>
                </div>
            </div>
            <!--//contentWrap :e -->
        </div>
        <!-- full_sub_content :e -->
    </div>
    <!-- full_sub_content :s -->
</div>
<!--//container :e -->

<%--POPUP CODINGRULES :: BEGIN--%>
<div class="modal fade" id="modalCodingRules" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width: 600px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &times; </span>
                </button>
                <h1 id="popupCodingRulesConfirmTitle" class="modal-title"> 프로파일에 추가 </h1>
            </div>
            <div class="modal-body">
                <div class="modal_contBox">
                    <%--RULE ADD :: BEGIN--%>
                    <div id="popupAddArea" style="display: none;">
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">품질 프로파일</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <p>
                                        <select class="input-large" id="popupProfileAdd"></select>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">이슈 수준</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <p>
                                        <select class="input-large" id="popupSeverityAdd">
                                            <option value="BLOCKER"><i class="ico_blocker"></i>심각</option>
                                            <option value="CRITICAL"><i class="ico_critical"></i>높음</option>
                                            <option value="MAJOR"><i class="ico_major"></i>보통</option>
                                            <option value="MINOR"><i class="ico_minor"></i>낮음</option>
                                            <option value="INFO"><i class="ico_info"></i>정보</option>
                                        </select>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--RULE ADD :: END--%>
                    <%--RULE UPDATE :: BEGIN--%>
                    <div id="popupUpdateArea" style="display: none;">
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">품질 프로파일</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <p id="popupProfileUpdate"></p>
                                </div>
                            </div>
                        </div>
                        <div class="modalform_info">
                            <div class="form_left">
                                <p class="title">이슈 수준</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <p>
                                        <select class="input-large" id="popupSeverityUpdate">
                                            <option value="BLOCKER"><i class="ico_blocker"></i>심각</option>
                                            <option value="CRITICAL"><i class="ico_critical"></i>높음</option>
                                            <option value="MAJOR"><i class="ico_major"></i>보통</option>
                                            <option value="MINOR"><i class="ico_minor"></i>낮음</option>
                                            <option value="INFO"><i class="ico_info"></i>정보</option>
                                        </select>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--RULE ADD :: END--%>
                </div>
            </div>
            <div class="modal-footer">
                <div id="popupAddButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnRuleAdd"> 추가</button>
                        <button type="button" class="button btn_pop" data-dismiss="modal"> 취소</button>
                    </div>
                </div>
                <div id="popupUpdateButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnRuleUpdate"> 수정</button>
                        <button type="button" class="button btn_pop" data-dismiss="modal"> 취소</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--POPUP CODINGRULES :: END--%>

<input type="hidden" id="serviceInstanceId" name="serviceInstanceId" value="<c:out value='${serviceInstanceId}' default='' />">

<%--CodingRule Total Count--%>
<input type="hidden" name="totalCount" id="totalCount" value="${codingRules.total}">
<%--페이지 No--%>
<input type="hidden" name="pageNo" id="pageNo" value="${codingRules.condition.p}">
<%--페이지당 표시할 CodingRule Count--%>
<input type="hidden" name="countPerPage" id="countPerPage" value="${codingRules.condition.ps}">
<%--Sort 항목--%>
<input type="hidden" name="sortKey" id="sortKey" value="${codingRules.condition.s}">
<%--Sort 타입--%>
<input type="hidden" name="sortAsc" id="sortAsc" value="${codingRules.condition.asc}">
<%--Sort 타입--%>

<input type="hidden" name="conditionKeyWord" id="conditionKeyWord">
<input type="hidden" name="conditionLanguages" id="conditionLanguages" value="${codingRules.condition.languages}">
<input type="hidden" name="conditionSeverrity" id="conditionSeverrity">
<input type="hidden" name="conditionProfileKey" id="conditionProfileKey">
<input type="hidden" name="selectedRuleKey" id="selectedRuleKey">

<script type="text/javascript">
    // Popup Types
    var gPopupTypeAdd = "Add";
    var gPopupTypeUpdate = "Update";

    $(document.body).ready(function () {
        // Left :: 개발언어, 이슈수준 목록 조회
        //getCodingRulesCondition();
        // Left :: 품질 프로파일 목록 조회
        //getQualityProfileList();
        // Right :: Coding Rules 조회
        //getCodingRules();
    });


    // 품질 프로파일 선택
    $("a[id^='qualityProfile_']").on("click", function () {

        var profileKey = $(this).data().profilekey;
        $("#conditionProfileKey").val(profileKey);

        // remove class
        $("ul.mt10").find("li").removeClass("custom-profile-selected");
        // 선택 프로파일 add class
        $("#listProfileCondition_"+profileKey).addClass("custom-profile-selected");
        getCodingRules();


    });
    // 이슈 수준 선택
    $("input[id^='chk_severity_']").on("click", function () {
        var chk_select = $(this).val();
        // console.log(" ::: checkbox select ::: "+ chk_select);
        getCodingRules();
    });

    // 프로파일에 추가 선택
    $(document).on("click", ".quality_btn" , function() {

        var id = $(this).attr("id");
        var activateRule = $(this).data().rulekey;

        $("#selectedRuleKey").val(activateRule);

        // console.log(" ::: activate rule ::: " + activateRule + ">>>"+ id + ":::"+ $(this).text());

        if (id.toString().match("btn_deactivate_")) {
            // console.log(" ::: btn_deactive rule ::: " + activateRule + ">>>"+ id.toString());

            var btnText = "제거";
            var reqTitle = $(this).text();
            var reqMessage = btnText + " 하시겠습니까?";
            var procFunction = "DeleteProfileRule();";
            var reqButtonText = btnText;

            procPopupConfirm(reqTitle, reqMessage, procFunction, reqButtonText, null);

        } else {
            var objModalList = $('#modalCodingRules');
            // 품질 프로파일 목록 조회
            getQualityProfileList();

            // Popup 설정
            procSetPopupArea(gPopupTypeAdd);

            objModalList.modal('toggle');
        }

    });

    // 프로파일에 추가 POPUP :: 추가 선택
    $("#btnRuleAdd").on("click", function () {


        // select box 선택이므로 유효성 체크 Pass
        $('#modalCodingRules').modal('hide');

        // 확인 POPUP
        var reqTitle = $('#popupCodingRulesConfirmTitle').text();
        var reqMessage = $('#btnRuleAdd').text() + " 하시겠습니까?";
        var procFunction = "AddProfileRule();";
        var reqButtonText = $('#btnRuleAdd').text();

        procPopupConfirm(reqTitle, reqMessage, procFunction, reqButtonText, null);

    });

    // Set PopUp Area
    var procSetPopupArea = function (type) {

        var procTypeArray = [gPopupTypeAdd, gPopupTypeUpdate];

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

    // 검색
    $("#search_keyword").keydown(function(evt) {
        if (evt.keyCode == 13) {
            getCodingRules();
            return false;
        }


    });
    $(".btn_search").on("click", function () {
        getCodingRules();

    });
    //////////////////////////////////////////////////////////////////////
    // Coding Rules 조회
    var getCodingRules = function () {

        procCallSpinner(SPINNER_START);
        $("#ruleList").css("display","block");
        $("#crDetail").css("display","none");
        //$("#crDetail").children().remove();

        // 검색 키워드
        var keyWord = $("#search_keyword").val();
        $("#conditionKeyWord").val(keyWord);

        // 이슈 수준 체크 박스 리스트
        var chkSeverities = "";
        $(":checkbox[name='issue']:checked").each(function(i,e){
            if(chkSeverities == ""){
                chkSeverities = e.value;
            }else{
                chkSeverities += ","+e.value;
            }
        });
        // console.log("condition ::: chkSeverities ::: "+chkSeverities);
        // 품질 프로파일
        // console.log("condition ::: profile ::: "+$("#conditionProfileKey").val());


        // 페이지 번호
        var params = {
            q : $("#conditionKeyWord").val(),
            p : $("#pageNo").val(),
            ps : $("#countPerPage").val(),
            s : $("#sortKey").val(),
            asc : $("#sortAsc").val(),
            qprofile : $("#conditionProfileKey").val(),
            languages : $("#conditionLanguages").val(),
            severities : chkSeverities
        }

        var paramstr = $.param(params);
        if ($("#conditionProfileKey").val()!= "") {
            paramstr += "&activation=true";
        }

        // console.log("condition ::: paramstr ::: "+paramstr);

        var reqUrl = "/codingRules/codingRules.do?";

        procCallAjax(reqUrl + paramstr, null, callbackGetCodingRules);

    };
    // [Collback] Coding Rules 조회
    var callbackGetCodingRules = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        // console.log("SUCCESS");

        var languages = data.languages;

        $.each(languages, function (index, language) {
            $("#language_"+language.val+"_num").text(language.count);
        });

        $("#severityMajorNum").text(data.severities.MAJOR);
        $("#severityMinorNum").text(data.severities.MINOR);
        $("#severityCriticalNum").text(data.severities.CRITICAL);
        $("#severityInfoNum").text(data.severities.INFO);
        $("#severityBlockerNum").text(data.severities.BLOCKER);

        // 기본 값 설정
        $("#totalCount").val(data.codingRules.total);
        $("#pageNo").val(data.codingRules.p);
        $("#countPerPage").val(data.codingRules.ps);
        $("#sortKey").val(data.codingRules.condition.s);
        $("#sortAsc").val(data.codingRules.condition.asc);
        $("#conditionKeyWord").val(data.codingRules.condition.q);
        $("#conditionLanguages").val(data.codingRules.condition.languages);
        $("#conditionProfileKey").val(data.codingRules.condition.qprofile);
        $("#selectedRuleKey").val("");

        // 이슈수준, 프로파일 키 설정

        // Coding Rules list
        var codingRulesData = "";

        if (data.rules.length > 0) {

            $.each(data.rules, function (index, rule) {
                codingRulesData += "<tr>";
                codingRulesData += "<td class='rule_tit'>"+rule.name+"</td>";
                codingRulesData += "<td class='alignC'><i class='ico_"+rule.severity.toString().toLowerCase()+"'></i></td>";
                codingRulesData += "<td class='alignC'>"+rule.langName+"</td>";
                codingRulesData += "<td class='alignC'><button type='button' data-ruleKey='"+rule.key+"'";
                if ($("#conditionProfileKey").val() != "") {
                    codingRulesData += " id='btn_deactivate_"+rule.key+"' class='button quality_btn'>프로파일에 제거";
                } else {
                    codingRulesData += " id='btn_activate_"+rule.key+"' class='button quality_btn'>프로파일에 추가";
                }
                codingRulesData += "</td>";
                codingRulesData += "</tr>";
            });

        } else {
            codingRulesData += "<tr><td class='rule_tit'> 프로파일에 속한 코딩 규칙이 없습니다.</td></tr>";
        }
        $("#codingRulesData").html("");
        $("#codingRulesData").html(codingRulesData);
        procCallSpinner(SPINNER_STOP);

    };

    // 프로파일에 추가 POPUP :: 품질 프로파일 목록 조회
    var getQualityProfileList = function () {
        var reqUrl = "/codingRules/qualityProfileList.do";

        procCallAjax(reqUrl, null, callbackGetQualityProfileList);
    };

    // [Collback] Left :: 품질 프로파일 목록 조회
    var callbackGetQualityProfileList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }
        var selectProfile = "";
        var profileName;

        $.each(data, function (index, profile) {
            profileName = profile.name.toString().indexOf("^") > 0 ? profile.name.toString().split("^")[1] : profile.name

            selectProfile += "<option value='" + profile.key + "'>";
            selectProfile += profileName + "</option>";

        });
        $("#popupProfileAdd").html(selectProfile);

    };

    // RULE 프로파일에 추가
    var AddProfileRule = function () {
        var popupProfileKey = $('#popupProfileAdd').val();
        var popupSeverity = $('#popupSeverityAdd').val();
        var ruleKey = $("#selectedRuleKey").val();

        // console.log("=== Activate_rule :: profile_key :: "+ popupProfileKey);
        // console.log("=== Activate_rule :: rule_key :: "+ ruleKey);
        // console.log("=== Activate_rule :: severity :: "+ popupSeverity);

        var reqParam = {
            serviceInstanceId : $("#serviceInstanceId").val(),
            rule_key : ruleKey,
            profile_key : popupProfileKey,
            severity : popupSeverity
        };

        procCallAjax("/codingRules/activateRule.do", reqParam, callbackAddProfileRule);
    };

    // [Collback] RULE 프로파일에 추가
    var callbackAddProfileRule = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }
        $('#modalCodingRules').modal('hide');
        procPopupAlert('추가 되었습니다.');
    };


    // RULE 프로파일에 제거
    var DeleteProfileRule = function () {
        var profileKey = $('#conditionProfileKey').val();
        var ruleKey = $("#selectedRuleKey").val();

        // console.log("=== Activate_rule :: profile_key :: "+ profileKey);
        // console.log("=== Activate_rule :: rule_key :: "+ ruleKey);

        var reqParam = {
            serviceInstanceId : $("#serviceInstanceId").val(),
            rule_key : ruleKey,
            profile_key : profileKey
        };

        procCallAjax("/codingRules/deactivateRule.do", reqParam, callbackDeleteProfileRule);
    };

    // [Collback] RULE 프로파일에 제거
    var callbackDeleteProfileRule = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        // 해당 프로파일 Rule 페이지 리로딩
        procPopupAlert('제거 되었습니다.');
        getCodingRules();

    };

</script>