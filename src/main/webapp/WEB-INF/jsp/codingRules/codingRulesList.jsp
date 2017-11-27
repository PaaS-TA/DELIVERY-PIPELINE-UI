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
                            <a id="qualityProfile_all" data-profileKey="" data-isdefault="false" href="#none">
                                <%--<input type="checkbox" data-profileKey="all" name="qualityProfile_all" id="qualityProfile_all" value="${qualityProfile.name}">--%>
                                <%--<label for="chk_profile_${qualityProfile.key}" style="cursor:pointer"><span class="block" style="width:220px;">${qualityProfile.name}</span></label>--%>
                                <span class="block" style="width:220px;">전체 보기</span>
                            </a>
                        </li>
                        <c:forEach items="${qualityProfiles}" var="qualityProfile" varStatus="status">
                            <li id="listProfileCondition_${qualityProfile.key}">
                                <a id="qualityProfile_${qualityProfile.key}" data-profileKey="${qualityProfile.key}" data-isdefault="${qualityProfile.isDefault}" href="#none">
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
                                <td class="rule_tit" data-key="${rule.key}">${rule.name}</td>
                                <td class="alignC"></td>
                                <td class="alignC">${rule.langName}</td>
                                <c:if test="${role == 'ROLE_ADMIN'}">
                                <td class="alignC"><button type="button" data-ruleKey="${rule.key}" id="btn_activate_${rule.key}" class="button quality_btn">프로파일에 추가</button></td>
                                </c:if>
                            </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <!--//리스트 테이블-->
                        <!-- 더보기 버튼 :s -->
                        <div class="table_more" id="moreListButtonArea" <c:if test="${codingRules.total <= codingRules.condition.ps}">style="display: none;"</c:if> >
                            <div class="btn_more" id="btnMore" style="cursor: pointer;"> 더보기 </div>
                        </div>
                        <!--//더보기 버튼 :e -->
                    </div>

                    <!--//상세 테이블 -->
                    <div id="crDetail" style="display:none;">
                        <table summary="품질이슈 리스트 테이블입니다." class="quality_list">
                            <caption>품질이슈 리스트</caption>
                            <colgroup>
                                <col style="width: *" />
                                <col style="width:12%">
                            </colgroup>
                            <tbody>
                            <tr>
                                <td colspan="2">
                                    <div id="rule_desc_tit" class="rule_tit"></div>
                                    <ul class="sel_menu">
                                        <li>
                                            <span id="rule_severity_BLOCKER" style="display:none;"><i class="ico_blocker"></i>심각 (Blocker)</span>
                                            <span id="rule_severity_CRITICAL" style="display:none;"><i class="ico_critical"></i>높음 (Critical)</span>
                                            <span id="rule_severity_MAJOR" style="display:none;"><i class="ico_major"></i>보통 (Major)</span>
                                            <span id="rule_severity_MINOR" style="display:none;"><i class="ico_minor"></i>낮음 (Minor)</span>
                                            <span id="rule_severity_INFO" style="display:none;"><i class="ico_info"></i>정보 (Info)</span>
                                        </li>
                                        <li id="rule_desc_language"></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr class="codeArea">
                                <td id="rule_desc" colspan="2"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <h3>연결된 품질 프로파일
                                        <c:if test="${role == 'ROLE_ADMIN'}">
                                        <button type="button" data-type="Add" class="button tbl_in_btn_sm">추가</button>
                                        </c:if>
                                    </h3>
                                    <div class="rule_tit"></div>
                                    <ul id="profile_list" class="profile_list"></ul>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <!--//리스트 테이블 -->

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
<input type="hidden" name="countPerPageDefault" id="countPerPageDefault" value="11">
<%--Sort 항목--%>
<input type="hidden" name="sortKey" id="sortKey" value="${codingRules.condition.s}">
<%--Sort 타입--%>
<input type="hidden" name="sortAsc" id="sortAsc" value="${codingRules.condition.asc}">
<%--Sort 타입--%>

<input type="hidden" name="conditionKeyWord" id="conditionKeyWord">
<input type="hidden" name="conditionLanguages" id="conditionLanguages" value="${codingRules.condition.languages}">
<input type="hidden" name="conditionSeverrity" id="conditionSeverrity">
<input type="hidden" name="conditionProfileKey" id="conditionProfileKey">
<input type="hidden" name="conditionProfileIsDefault" id="conditionProfileIsDefault">
<input type="hidden" name="conditionPageType" id="conditionPageType">
<input type="hidden" name="selectedRuleKey" id="selectedRuleKey">

<script type="text/javascript">
    // Popup Types
    var gPopupTypeAdd = "Add";
    var gPopupTypeUpdate = "Update";
    var gPopupTypeDelete = "Delete";
    var gPageTypeList = "List";
    var gPageTypeDetail = "Detail";
    var gSeverityArr = [
        {"key":"BLOCKER", "value": "심각 (Blocker)"},
        {"key":"CRITICAL", "value": "높음 (Critical)"},
        {"key":"MAJOR", "value": "보통 (Major)"},
        {"key":"MINOR", "value": "낮음 (Minor)"},
        {"key":"INFO", "value": "정보 (Info)"}
    ];

    $(document.body).ready(function () {

    });


    // 품질 프로파일 선택
    $("a[id^='qualityProfile_']").on("click", function () {

        var profileKey = $(this).data().profilekey;
        var isDefault = $(this).data().isdefault;

        $("#conditionProfileKey").val(profileKey);
        $("#conditionProfileIsDefault").val(isDefault);

        // remove class
        $("ul.mt10").find("li").removeClass("custom-profile-selected");
        // 선택 프로파일 add class
        $("#listProfileCondition_"+profileKey).addClass("custom-profile-selected");
        $("#countPerPage").val($("#countPerPageDefault").val());
        getCodingRules();

    });
    // 이슈 수준 선택
    $("input[id^='chk_severity_']").on("click", function () {
        var chk_select = $(this).val();
        // console.log(" ::: checkbox select ::: "+ chk_select);
        $("#countPerPage").val($("#countPerPageDefault").val());
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

    // 연결된 품질 프로파일 수정 POPUP :: 수정 선택
    $("#btnRuleUpdate").on("click", function () {

        // select box 선택이므로 유효성 체크 Pass
        $('#modalCodingRules').modal('hide');

        // 확인 POPUP
        var reqTitle = "이슈 수준 조정";
        var reqMessage = $('#btnRuleUpdate').text() + " 하시겠습니까?";
        var procFunction = "UpdateProfileRule();";
        var reqButtonText = $('#btnRuleUpdate').text();

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

    // 검색어 Enter 제어
    $("#search_keyword").keydown(function(evt) {
        if (evt.keyCode == 13) {
            $("#countPerPage").val($("#countPerPageDefault").val());
            getCodingRules();
            return false;
        }

    });

    // 검색 버튼 제어
    $(".btn_search").on("click", function () {
        $("#countPerPage").val($("#countPerPageDefault").val());
        getCodingRules();

    });

    // 더보기 버튼 제어
    $("#btnMore").on("click", function () {

        $("#countPerPage").val($("#totalCount").val());
        getCodingRules();

    });

    // Rule 상세 페이지
    $(document).on("click", ".rule_tit" , function() {

        //console.log("Detail ::: " + $(this).data().key);
        getCodingRuleDetail($(this).data().key);
    });

    // Rule 상세 페이지 :: 연결된 품질 프로파일 추가 / 변경 / 삭제
    $(document).on("click", ".tbl_in_btn_sm" , function() {

        var btn_type = $(this).data().type;
        var qprofile = $(this).data().profile;
        var qprofilenm = $(this).data().name;
        $('#conditionProfileKey').val(qprofile);

        //console.log("Detail btn Type::: " + btn_type);
        //console.log("Detail btn Type::: " + qprofile);
        //console.log("Detail btn Type::: " + qprofilenm);

        if (gPopupTypeDelete == btn_type) {

            var btnText = "제거";
            var reqTitle = $(this).text();
            var reqMessage = btnText + " 하시겠습니까?";
            var procFunction = "DeleteProfileRule();";
            var reqButtonText = btnText;

            procPopupConfirm(reqTitle, reqMessage, procFunction, reqButtonText, null);

        } else if (gPopupTypeAdd == btn_type) {

            var objModalList = $('#modalCodingRules');
            // 품질 프로파일 목록 조회
            getQualityProfileList();

            // Popup 설정
            procSetPopupArea(gPopupTypeAdd);

            objModalList.modal('toggle');

        }
        if (gPopupTypeUpdate == btn_type) {
            //console.log("Detail btn Update ::: " + btn_type);

            var objModalList = $('#modalCodingRules');

            // Popup 설정
            procSetPopupArea(gPopupTypeUpdate);
            $('#popupProfileUpdate').text(qprofilenm);
            $('#popupProfileUpdate').data("key",qprofile);

            objModalList.modal('toggle');
        }

    });


    //////////////////////////////////////////////////////////////////////
    // Coding Rules 조회
    var getCodingRules = function () {

        procCallSpinner(SPINNER_START);
        $("#ruleList").css("display","block");
        $("#crDetail").css("display","none");
        $("#moreListButtonArea").css("display","none");
        $("#conditionPageType").val(gPageTypeList);

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
            procCallSpinner(SPINNER_STOP);
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
        $("#countPerPage").val(data.codingRules.condition.ps);
        $("#sortKey").val(data.codingRules.condition.s);
        $("#sortAsc").val(data.codingRules.condition.asc);
        $("#conditionKeyWord").val(data.codingRules.condition.q);
        $("#conditionLanguages").val(data.codingRules.condition.languages);
        $("#conditionProfileKey").val(data.codingRules.condition.qprofile);
        $("#selectedRuleKey").val("");

        var isDefaultProfile = $("#conditionProfileIsDefault").val();
        console.log(">>>> result ::::: "+ isDefaultProfile);

        // 권한제어
        var role = '${role}';
        //console.log("ROLE :::: "+ role);

        // Coding Rules list
        var codingRulesData = "";
        if (data.codingRules.total > data.codingRules.condition.ps) {
            $("#moreListButtonArea").css("display","block");
        }

        if (data.rules.length > 0) {

            $.each(data.rules, function (index, rule) {
                codingRulesData += "<tr>";
                codingRulesData += "<td class='rule_tit' data-key='"+rule.key+"'>"+rule.name+"</td>";
                codingRulesData += "<td class='alignC'></td>";
                codingRulesData += "<td class='alignC'>"+rule.langName+"</td>";

                if (role == "ROLE_ADMIN" && isDefaultProfile == "false") {
                    codingRulesData += "<td class='alignC'><button type='button' data-ruleKey='"+rule.key+"'";
                    if ($("#conditionProfileKey").val() != "") {
                        codingRulesData += " id='btn_deactivate_"+rule.key+"' class='button quality_btn'>프로파일에 제거";
                    } else {
                        codingRulesData += " id='btn_activate_"+rule.key+"' class='button quality_btn'>프로파일에 추가";
                    }
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

            if (!profile.isDefault) {
                profileName = profile.name.toString().indexOf("^") > 0 ? profile.name.toString().split("^")[1] : profile.name;

                selectProfile += "<option value='" + profile.key + "'>";
                selectProfile += profileName + "</option>";
            }

        });
        $("#popupProfileAdd").html(selectProfile);

    };

    // RULE 프로파일에 추가
    var AddProfileRule = function () {
        var popupProfileKey = $('#popupProfileAdd').val();
        var popupSeverity = $('#popupSeverityAdd').val();
        var ruleKey = $("#selectedRuleKey").val();
        var pageType = $("#conditionPageType").val();

        // console.log("=== Activate_rule :: profile_key :: "+ popupProfileKey);
        // console.log("=== Activate_rule :: rule_key :: "+ ruleKey);
        // console.log("=== Activate_rule :: severity :: "+ popupSeverity);

        var reqParam = {
            serviceInstanceId : $("#serviceInstanceId").val(),
            rule_key : ruleKey,
            profile_key : popupProfileKey,
            severity : popupSeverity
        };

        if (pageType == gPageTypeDetail) {
            procCallAjax("/codingRules/activateRule.do", reqParam, callbackAddProfileRuleDetail);

        } else {
            procCallAjax("/codingRules/activateRule.do", reqParam, callbackAddProfileRule);
        }

    };

    // [Collback] RULE 프로파일에 추가
    var callbackAddProfileRule = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }
        $('#modalCodingRules').modal('hide');
        procPopupAlert('추가 되었습니다.');
    };

    // [Collback] RULE 프로파일에 추가 :: Detail
    var callbackAddProfileRuleDetail = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }
        $('#modalCodingRules').modal('hide');
        procPopupAlert('추가 되었습니다.');
        var ruleKey = $("#selectedRuleKey").val();
        // 상세페이지
        getCodingRuleDetail(ruleKey);

    };

    // RULE - 이슈수준 조정 (수정)
    var UpdateProfileRule = function () {
        var popupProfileKey = $('#popupProfileUpdate').data().key;
        var popupSeverity = $('#popupSeverityUpdate').val();
        var ruleKey = $("#selectedRuleKey").val();
        var pageType = $("#conditionPageType").val();

        console.log("=== Activate_rule :: profile_key :: "+ popupProfileKey);
        console.log("=== Activate_rule :: rule_key :: "+ ruleKey);
        console.log("=== Activate_rule :: severity :: "+ popupSeverity);

        var reqParam = {
            serviceInstanceId : $("#serviceInstanceId").val(),
            rule_key : ruleKey,
            profile_key : popupProfileKey,
            severity : popupSeverity
        };

        procCallAjax("/codingRules/activateRule.do", reqParam, callbackUpdateProfileRule);


    };

    // [Collback] RULE 프로파일에 추가
    var callbackUpdateProfileRule = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }
        $('#modalCodingRules').modal('hide');
        procPopupAlert('수정 되었습니다.');
        var ruleKey = $("#selectedRuleKey").val();
        console.log("###### :: "+ ruleKey);
        // 상세페이지
        getCodingRuleDetail(ruleKey);

    };
    // RULE 프로파일에 제거
    var DeleteProfileRule = function () {
        var profileKey = $('#conditionProfileKey').val();
        var ruleKey = $("#selectedRuleKey").val();
        var pageType = $("#conditionPageType").val();

        //console.log(">>>>>> : "+ profileKey);
        //console.log(">>>>>> : "+ ruleKey);
        //console.log(">>>>>> : "+ pageType);

        var reqParam = {
            serviceInstanceId : $("#serviceInstanceId").val(),
            rule_key : ruleKey,
            profile_key : profileKey
        };

        if (pageType == gPageTypeDetail) {
            procCallAjax("/codingRules/deactivateRule.do", reqParam, callbackDeleteProfileRuleDetail);

        } else {
            procCallAjax("/codingRules/deactivateRule.do", reqParam, callbackDeleteProfileRule);
        }

    };

    // [Collback] RULE 프로파일에 제거
    var callbackDeleteProfileRule = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        // 해당 프로파일 Rule 페이지 리로딩
        procPopupAlert('제거 되었습니다.');
        $("#countPerPage").val($("#countPerPageDefault").val());
        getCodingRules();

    };

    // [Collback] RULE 프로파일에 제거 :: Detail
    var callbackDeleteProfileRuleDetail = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        // 해당 프로파일 Rule 페이지 리로딩
        procPopupAlert('제거 되었습니다.');
        var ruleKey = $("#selectedRuleKey").val();
        //console.log("###### :: "+ ruleKey);
        // 상세페이지
        getCodingRuleDetail(ruleKey);

    };

    // Coding Rules 상세 조회
    var getCodingRuleDetail = function (ruleKey) {

        procCallSpinner(SPINNER_START);

        $("#ruleList").css("display","none");
        $("#crDetail").css("display","block");
        $("#moreListButtonArea").css("display","none");
        $("#selectedRuleKey").val(ruleKey);
        $("#conditionPageType").val(gPageTypeDetail);

        var reqUrl = "/codingRules/codingRuleDetail.do?key="+ruleKey+"&actives=true";

        procCallAjax(reqUrl, null, callbackGetCodingRuleDetail);

    };
    // [Collback] Coding Rules 상세
    var callbackGetCodingRuleDetail = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var rule = data.rule;
        var profiles = data.activatedQProfiles;

        // 권한제어
        var role = '${role}';

        // Coding Rule 타이틀
        $("#rule_desc_tit").html(rule.name);
        // Coding Rule 이슈수준
        $("ul.sel_menu > li").find("span").css("display","none");
        $("#rule_severity_"+rule.severity).css("display","block");
        // Coding Rule 개발 언어
        $("#rule_desc_language").text(rule.langName);
        // Coding Rule 상세
        $("#rule_desc").html("<pre class='rule_desc'>"+rule.htmlDesc+"</pre>");

        // 연결된 품질 프로파일
        var profilesHtml = "<p class='examp'>연결된 품질 프로파일이 없습니다.</p>";

        if (profiles.length > 0) {
            //console.log("size ::: "+ profiles.length);
            profilesHtml = "";

            $.each(profiles, function (index, profile) {
                //console.log("index ::: "+ index);
                profileName = profile.qPrdofileName.toString().indexOf("^") > 0 ? profile.qPrdofileName.toString().split("^")[1] : profile.qPrdofileName;

                profilesHtml += "<li>";
                profilesHtml += "<span class='profile_name'>"+ profileName +"</span>";
                profilesHtml += "<span class='r_box'>";
                profilesHtml += "<span class='ico_issue'><i class='ico_"+profile.severity.toString().toLowerCase()+"'></i>";

                $.map(gSeverityArr, function (severity, index) {
                    if (severity.key == profile.severity) {
                        profilesHtml += severity.value;
                    }
                });
                profilesHtml += "</span>";
                if (role == "ROLE_ADMIN" && profile.isDefault === false) {
                    profilesHtml += "<button type='button' data-type='Update' data-profile='"+profile.qProfile+"' data-name='"+profileName+"' class='button tbl_in_btn_sm'>변경</button>";
                    profilesHtml += "<button type='button' data-type='Delete' data-profile='"+profile.qProfile+"' data-name='"+profileName+"' class='button tbl_in_btn_sm'>제거</button>";
                }
                profilesHtml += "</span>";
                profilesHtml += "</li>";

            });
        }
        $("#profile_list").html(profilesHtml);

        procCallSpinner(SPINNER_STOP);

    };

</script>