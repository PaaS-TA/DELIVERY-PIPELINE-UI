<%--
  Created by IntelliJ IDEA.
  User: kim
  Date: 2017-08-10
  Time: 오후 4:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li>품질 이슈</li>
        </ul>
    </div>
</div>

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="">
        <!-- full_sub_content :s -->
        <div class="">
            <!-- left :s -->
            <div class="lnbWrap">
                <div class="lnb">
                    <ul>
                        <h4>해결여부 (Resolution)</h4>
                        <div id="issueResolution">
                            <li><a href="javascript:resolutionChecked(0);">
                                <input type="checkbox" name="resolutionCheck" value="UNRESOLVED">
                                <span class="block">미해결 (Unresolved)</span> <span class="issue_num"
                                                                                  id="unresolved">0</span></a></li>
                            <li><a href="javascript:resolutionChecked(1);">
                                <input type="checkbox" name="resolutionCheck" value="FIXED" >
                                <span class="block">수정됨 (fixed)</span> <span class="issue_num" id="fixed">0</span></a>
                            </li>
                            <li><a href="javascript:resolutionChecked(2);">
                                <input type="checkbox" name="resolutionCheck" value="FALSE-POSITIVE">
                                <span class="block">보류 (False positive)</span> <span class="issue_num"
                                                                                     id="false_positive">0</span></a>
                            </li>
                            <li><a href="javascript:resolutionChecked(3);">
                                <input type="checkbox" name="resolutionCheck" value="WONTFIX">
                                <span class="block">무시 (Won’t fix)</span> <span class="issue_num" id="wontfix">0</span></a>
                            </li>
                            <li class="last"><a href="javascript:resolutionChecked(4);">
                                <input type="checkbox" name="resolutionCheck" value="REMOVED">
                                <span class="block">제거됨 (Removed)</span> <span class="issue_num"
                                                                               id="removed">0</span></a></li>
                        </div>
                        <h4>이슈 수준 (Severity)</h4>
                        <div id="issueSeverity">
                            <li><a href="javascript:chkOn(0,'severityCheck');"><input type="checkbox"
                                                                                      name="severityCheck"
                                                                                      value="BLOCKER"
                                                                                      onclick="getList('refresh')"> <span
                                    class="block"><i class="ico_blocker"></i>심각 (Blocker)</span> <span class="issue_num"
                                                                                                       id="blocker">0</span></a>
                            </li>
                            <li><a href="javascript:chkOn(1,'severityCheck');"><input type="checkbox"
                                                                                      name="severityCheck"
                                                                                      value="CRITICAL"
                                                                                      onclick="getList('refresh')"> <span
                                    class="block"><i class="ico_critical"></i>높음 (Critical)</span> <span
                                    class="issue_num" id="critical">0</span></a></li>
                            <li><a href="javascript:chkOn(2,'severityCheck');"><input type="checkbox"
                                                                                      name="severityCheck" value="MAJOR"
                                                                                      onclick="getList('refresh')"> <span
                                    class="block"><i class="ico_major"></i>보통 (Major)</span> <span class="issue_num"
                                                                                                   id="major">0</span></a>
                            </li>
                            <li><a href="javascript:chkOn(3,'severityCheck');"><input type="checkbox"
                                                                                      name="severityCheck" value="MINOR"
                                                                                      onclick="getList('refresh')"> <span
                                    class="block"><i class="ico_minor"></i>낮음 (Minor)</span> <span class="issue_num"
                                                                                                   id="minor">0</span></a>
                            </li>
                            <li class="last"><a href="javascript:chkOn(4,'severityCheck');"><input type="checkbox"
                                                                                                   name="severityCheck"
                                                                                                   value="INFO"
                                                                                                   onclick="getList('refresh')">
                                <span class="block"><i class="ico_info"></i>정보 (Info)</span> <span class="issue_num"
                                                                                                   id="info">0</span></a>
                            </li>
                        </div>
                        <h4>상태 (Status)</h4>
                        <div id="issueStatus">
                            <li><a href="javascript:chkOn(0,'statusCheck');"><input type="checkbox" name="statusCheck"
                                                                                    value="OPEN" onclick="getList('refresh')">
                                <span class="block">활성 (Open)</span> <span class="issue_num" id="open">0</span></a></li>
                            <li><a href="javascript:chkOn(1,'statusCheck');"><input type="checkbox" name="statusCheck"
                                                                                    value="RESOLVED"
                                                                                    onclick="getList('refresh')"> <span
                                    class="block">해결됨 (Resolved)</span> <span class="issue_num"
                                                                              id="resolved">0</span></a></li>
                            <li><a href="javascript:chkOn(2,'statusCheck');"><input type="checkbox" name="statusCheck"
                                                                                    value="REOPENED"
                                                                                    onclick="getList('refresh')"> <span
                                    class="block">재활성 (Reopened)</span> <span class="issue_num"
                                                                              id="reopened">0</span></a></li>
                            <li><a href="javascript:chkOn(3,'statusCheck');"><input type="checkbox" name="statusCheck"
                                                                                    value="CLOSED" onclick="getList('refresh')">
                                <span class="block">비활성 (Closed)</span> <span class="issue_num" id="closed">0</span></a>
                            </li>
                            <li class="last"><a href="javascript:chkOn(4,'statusCheck');"><input type="checkbox"
                                                                                                 name="statusCheck"
                                                                                                 value="CONFIRMED"
                                                                                                 onclick="getList('refresh')">
                                <span class="block">확인됨 (Confirmed)</span> <span class="issue_num"
                                                                                 id="confirmed">0</span></a></li>

                        </div>
                        <h4>개발언어 (Language)</h4>
                        <div id="issueLanguage">

                        </div>
                        <h4>프로젝트 (Project)</h4>
                        <div id="issueProject">

                        </div>
                    </ul>
                </div>
            </div>
            <!--//left :e -->
            <!-- contentWrap :s -->
            <div class="contentWrap">
                <div class="content_in" id="issuesTable" style="display: block">

                </div>

                <div class="content_in" id="issuesDetail" style="display:none;">
                    <div class="fr mb10">
                        <button type="button" class="button btn_default" id="issuesListReturn" onclick="">목록</button>
                    </div>
                    <div class="sub_titlebox">
                        <div class="tit" id="fileName">BD</div>
                        <p id="filePath">src/main/java/org/openpaas/servicebroker/mysql/config/Application.java</p>
                        <div class="btn_wrap">
                            <ul class="issue_data">
                                <li><span><em id="fileLineNum">12345</em><br>라인</span></li>
                                <li><span><em id="fileIssueNum">1234</em><br>이슈</span></li>
                                <li><span><em id="fileCoverageNum">100%</em><br>커버리지</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="sourcebox">
                        <div class="source_num" id="source_num"></div>
                        <div class="source_code" id="source_code"></div>
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


<input type="hidden" name="issuesTotal" id="issuesTotal"/>
<input type="hidden" name="issuesPs" id="issuesPs" value="50"/>
<input type="hidden" name="serviceInstancesId" id="serviceInstancesId"
       value="<c:out value='${serviceInstancesId}' default='' />">


<script type="text/javascript">
    $(window).scroll(function () {
        if ($(window).scrollTop() >= $(document).height() - $(window).height()) {

            var pageSize = $("#issuesPs").val();
            var pageTotal = $("#issuesTotal").val();
            if (parseInt(pageSize) < parseInt(pageTotal)) {
                var loadingImg = " <tr><td class='alignC'><img src = '/resources/images/img_loading.gif'></td></tr>";
                $(".tbodyDatas  > :last").append(loadingImg);

                if (pageSize != "") {
                    if ($("#issuesTable").css("display") == "block") {
                        pageSize = parseInt(pageSize) + 50;
                        $("#issuesPs").val(pageSize);
                        getList('refresh');
                    }
                } else {
                    pageSize = 0;
                    pageSize = parseInt(pageSize) + 50;
                    $("#issuesPs").val(pageSize);
                }
            }
        }
    })

    $(function () {
        $("#issuesListReturn").click(function () {
            $("#issuesTable").css("display", "block");
            $("#issuesDetail").css("display", "none");
        });
    });


    function getList(status) {

        $("#issuesTable").css("display", "block");
        $("#issuesDetail").css("display", "none");
        var ps = $("#issuesPs").val();
        var resolutions = "";
        var severities = "";
        var statuses = "";
        var componentKeys = "";
        var resolved = "";


        $("#issueResolution").find("input[name=resolutionCheck]").each(function (i) {
            if ($(this).is(":checked") == true) {

                resolutions += $(this).val() + ",";
            }
        });

        $("#issueSeverity").find("input[name=severityCheck]").each(function (i) {
            if ($(this).is(":checked") == true) {
                severities += $(this).val() + ",";
            }
        });

        $("#issueStatus").find("input[name=statusCheck]").each(function (i) {
            if ($(this).is(":checked") == true) {
                statuses += $(this).val() + ",";
            }
        });

        $("#issueProject").find("input[name=projectCheck]").each(function (i) {

            if ($(this).is(":checked") == true) {
                componentKeys += $(this).val() + ",";
            }
        });


        resolutions = resolutions.slice(0, -1);
        severities = severities.slice(0, -1);
        statuses = statuses.slice(0, -1);
        componentKeys = componentKeys.slice(0, -1);


        var param = {
            ps: ps,
            resolutions: resolutions,
            severities: severities,
            statuses: statuses,
            componentKeys: componentKeys,
            resolved: resolved,
            serviceInstancesId: $("#serviceInstancesId").val()

        }

        if(status == 'init'){
            procCallAjax("/qualityIssues/qualityIssuesList.do", param, callbackGetListInit);
        }else{
            procCallAjax("/qualityIssues/qualityIssuesList.do", param, callbackGetList);
        }
    }


    var callbackGetList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        //procCallSpinner(SPINNER_START);
        var list = "";
        var listHead = "";

        if (data != undefined && data.length != 0) {

            $("#issuesTotal").val(data.total);
            if (data.components != null && data.components.length > 0) {
                //data 정렬
                data.components.sort(function (a, b) {
                    return a.name < b.name ? -1 : a.name > b.name ? 1 : 0;
                });

                for (var j = 0; j < data.components.length; j++) {
                    if (data.components[j].qualifier == "FIL") {
                        listHead += " <table summary='품질이슈 리스트 테이블입니다.' class='quality_list'>";
                        listHead += "<caption>품질이슈 리스트</caption>";
                        listHead += "<colgroup> <col style='width: *' /> <col style='width:10%'> </colgroup>";
                        listHead += "<thead><tr><th colspan='2' scope='col'>";
                        listHead += "<div class='tit' id='file_header_" + j + "'>"+data.components[j].projectViewName;
                        listHead += "<span class='filePath_" + data.components[j].projectId + "'>" + data.components[j].path + "</span>";
                        listHead += "</div>";
                        listHead += "</th>";
                        listHead += "</tr>";
                        listHead += "</thead>";
                        listHead += "<tbody id='tbodyData_" + data.components[j].id + "' class='tbodyDatas'>";
                        listHead += "</tbody>";
                        listHead += "</table>";
                    }
                }
            } else {
                listHead += " <table summary='품질이슈 리스트 테이블입니다.' class='quality_list'>";
                listHead += "<caption>품질이슈 리스트</caption>";
                listHead += "<colgroup> <col style='width: *' /> <col style='width:10%'> </colgroup>";


                listHead += "<tbody  class='tbodyDatas'>";
                listHead += "<tr><td class='alignC'>검색된 데이터가 없습니다.</td></tr>";
                listHead += "</tbody>";
                listHead += "</table>";

            }


            $("#issuesTable").html(listHead);

            if (data.components != null && data.components.length > 0) {

                for (var i = 0; i < data.issues.length; i++) {
                    list += "<tr>";
                    list += "<td>";
                    list += "<div class='rule_tit'>" + data.issues[i].message + "<button type='button' class='btn btn-secondary btn-sm' style='margin: 0 0 0 10px;' onclick=\"setViewCodingRuleDetail(\'" + i + "','" + data.issues[i].rule + "')\">코딩 규칙</button></div>";
                    list += "<div class='rule_tit view-off' id='ruleMessageArea_" + i + "' style='padding: 0 20px; color: #999999; display: none;'></div>";
                    list += "<ul class='sel_menu'>";
                    list += "<li>";
                    list += "<input type='hidden' id='issueKey_" + i + "' value='" + data.issues[i].key + "'>";
                    list += "<select id='issueSelect_" + i + "' class ='makeMeFancy' onchange='setSeverity(" + i + ")' style='width:95px;'>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='심각' value='BLOCKER' >심각</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='높음' value='CRITICAL' >높음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='보통' value='MAJOR' >보통</option>";
                    list += "<option data-icon='/resources/images/ico_minor.png' data-html-text='낮음' value='MINOR' >낮음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='정보' value='INFO'>정보</option>";
                    list += " </select>";
                    list += "</li>";
                    list += "<li>";
                    list += "<select id='transitionSelect_" + i + "' style='width:95px;' onchange=\"setTransition(\'" + data.issues[i].key + "')\">";
                    list += "<option value='OPEN'>활성</option>";
                    list += "<option value='CONFIRMED'>확인됨</option>";
                    list += "<option value='FIXED'>수정됨</option>";
                    list += "<option value='POSITIVE'>보류</option>";
                    list += "<option value='WONTFIX'>무시</option>";
                    list += "<option value='REOPENED'>재활성</option>";
                    list += "</select>";
                    list += "</li>";

                    if (data.issues[i].textRange == "" || data.issues[i].textRange == "undefined" || data.issues[i].textRange == null) {
                        list += "<li class='loca_txt'></li>";
                    } else {
                        list += "<li class='loca_txt'>위치 : " + data.issues[i].textRange.startLine + " 라인</li>";
                    }
                    list += " </ul>";
                    list += "</td>";
                    list += "<td><button type='button' class='button quality_btn issuesBtn' onclick=\"issuesDetail(\'" + data.issues[i].component + "','" + data.issues[i].key + "')\">상세</button></td>";
                    list += "</tr>";


                    $("#tbodyData_" + data.issues[i].componentId).append(list);
                    list = "";
                }
            }
        }
        procCallSpinner(SPINNER_STOP);

    }


    // FOR SET CODING RULE NAME
    gCodingRuleAreaIndex = 0;


    // SET VIEW CODING RULE DETAIL
    var setViewCodingRuleDetail = function (reqIndex, reqCodingRuleKey) {
        console.log("## 1 :: " + $(this));
        console.log("## 2 :: " + $(this).blur());
        var ruleMessageArea = $('#ruleMessageArea_' + reqIndex),
            viewOnString = "view-on",
            viewOffString = "view-off";

        gCodingRuleAreaIndex = reqIndex;

        if (ruleMessageArea.hasClass(viewOffString)) {
            ruleMessageArea.removeClass(viewOffString).addClass(viewOnString);
            gCodingRuleAreaIndex = reqIndex;
            getCodingRuleDetail(reqCodingRuleKey);
        } else {
            gCodingRuleAreaIndex = 0;
            ruleMessageArea.removeClass(viewOnString).addClass(viewOffString);
            ruleMessageArea.fadeOut("slow");
        }
    };


    // GET CODING RULE DETAIL
    var getCodingRuleDetail = function (reqCodingRuleKey) {
        if ("" === reqCodingRuleKey || undefined === reqCodingRuleKey) return false;

        procCallSpinner(SPINNER_START);
        var reqUrl = "/codingRules/codingRuleDetail.do?key=" + reqCodingRuleKey + "&actives=true";
        procCallAjax(reqUrl, null, callbackGetCodingRuleDetail);
    };


    // CALLBACK GET CODING RULE DETAIL
    var callbackGetCodingRuleDetail = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        if (0 === gCodingRuleAreaIndex) return false;

        var ruleMessageArea = $('#ruleMessageArea_' + gCodingRuleAreaIndex);

        ruleMessageArea.html(data.rule.name);
        ruleMessageArea.fadeIn("slow");

        procCallSpinner(SPINNER_STOP);
    };


    var callbackGetListInit = function (data) {

        var opencount = 0;
        var resolvedcount =0;
        var reopenedcount = 0;
        var closedcount = 0;
        var confirmedcount = 0;
        var blokercount = 0;
        var criticalcount =0;
        var majorcount = 0;
        var minorcount = 0;
        var infocount = 0;
        var unresolvedcount = 0;
        var fixedcount = 0;
        var falsepositivecount = 0;
        var wontfixcount = 0;
        var removecount = 0;

        if (data != undefined && data.length != 0) {

           if (data.components != null && data.components.length > 0) {

                for (var i = 0; i < data.issues.length; i++) {

                    if (data.issues[i].status == "OPEN") {
                        opencount++;
                    } else if (data.issues[i].status == "RESOLVED") {
                        resolvedcount++;
                    } else if (data.issues[i].status == "REOPENED") {
                        reopenedcount++;
                    } else if (data.issues[i].status == "CLOSED") {
                        closedcount++;
                    } else if (data.issues[i].status == "CONFIRMED") {
                        confirmedcount++;
                    }


                    if (data.issues[i].severity == "BLOCKER") {
                        blokercount++;
                    } else if (data.issues[i].severity == "CRITICAL") {
                        criticalcount++;
                    } else if (data.issues[i].severity == "MAJOR") {
                        majorcount++;
                    } else if (data.issues[i].severity == "MINOR") {
                        minorcount++;
                    } else if (data.issues[i].severity == "INFO") {
                        infocount++;
                    }


                    if (data.issues[i].resolution == "UNRESOLVED") {
                        unresolvedcount;
                    } else if (data.issues[i].resolution == "FIXED") {
                        fixedcount++;
                    } else if (data.issues[i].resolution == "FALSE-POSITIVE") {
                        falsepositivecount++;
                    } else if (data.issues[i].resolution == "WONTFIX") {
                        wontfixcount++;
                    } else if (data.issues[i].resolution == "REMOVED") {
                        removecount++;
                    } else {
                        unresolvedcount++;
                    }

                }
            }
        }


        //상태 카운트 세팅
        $("#open").text(opencount);
        $("#resolved").text(resolvedcount);
        $("#reopened").text(reopenedcount);
        $("#closed").text(closedcount);
        $("#confirmed").text(confirmedcount);


        //이슈 수준 카운트 세팅
        $("#blocker").text(blokercount);
        $("#critical").text(criticalcount);
        $("#major").text(majorcount);
        $("#minor").text(minorcount);
        $("#info").text(infocount);

        //해결여부 카운트 세팅
        $("#unresolved").text(unresolvedcount);
        $("#false_positive").text(resolvedcount);
        $("#wontfix").text(wontfixcount);
        $("#fixed").text(fixedcount);
        $("#removed").text(removecount);
        //처음에 한번반 호출해서 카운트 세팅하고, 그이후로는 데이터만 초기화함
        callbackGetList(data);
    }




    var getProjectList = function () {
        var param = {
            serviceInstancesId: $("#serviceInstancesId").val()
        };
        procCallAjax("/projects/projectsList.do", param, callbackGetProjectList);
    }

    var callbackGetProjectList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var list = "";
        if (data.length > 0) {

            for (var i = 0; i < data.length; i++) {
                list += "<li><a href=\"javascript:chkOn(\'" + i + "','projectCheck');\"><input type='checkbox' name='projectCheck' onclick='getList(refresh)' value='" + data[i].projectKey + "'> <span class='block' title='" + data[i].name + "'>" + data[i].projectViewName + "</span> <span class='issue_num'></span></a></li>";
            }
        }

        $("#issueProject").html(list);

    }

    var getLanguage = function () {
        procCallAjax("/qualityIssues/getLanguageList.do", null, callbackGetIssueLanguageList);
    }

    var callbackGetIssueLanguageList = function (data) {        ;
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var list = "";
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {

                //언어 추가시 a태그에 이벤트 추가하여 선택되도록 변경해야함
                if(data[i].name == "Java"){
                    list += "<li><a href=\"javascript:chkOn('\" + i + \"');\"><input type='checkbox' id='' name='chklanguage' value='" + data[i].key + "' disabled='disabled' checked='checked'> <span class='block'>" + data[i].name + "</span> <span class='issue_num'></span></a></li>";
                }else{
                    list += "<li><a href=\"javascript:chkOn('\" + i + \"');\><input type='checkbox' id='' name='' value='" + data[i].key + "' disabled='disabled'> <span class='block'>" + data[i].name + "(추후지원)</span> <span class='issue_num'></span></a></li>";
                }
            }
        }
        $("#issueLanguage").html(list);
    }

    function checkLanguage(index) {


//        if ($("input[name=chklanguage]").eq(index).is(":checked") == false) {
//
//            $("input[name=chklanguage]").eq(index).prop('checked', true);
//
//        } else if ($("input[name=chklanguage]").eq(index).is(":checked") == true) {
//
//            $("input[name=chklanguage]").eq(index).prop('checked', false);
//        }
//        getList("refresh");
    }


    function issuesDetail(key, uuid) {

        $("#issuesTable").css("display", "none");
        $("#issuesDetail").css("display", "block");
        procCallAjax("/qualityIssues/qualityIssuesDetail.do?fileKey=" + key + "&fileUuid=" + uuid+"&serviceInstancesId="+$("#serviceInstancesId").val(), null, callbackGetIssuesDetail);

    }

    var callbackGetIssuesDetail = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        procCallSpinner(SPINNER_START);
        //소스
        var list = "";
        var source_num = "";
        //커버리지
        var lines = ""
            , coverage = ""
            , issue = ""
            , lineData = "";
        var msrArray = new Array();
        var coverageArray = new Array();

        //파일
        var fileName = ""
            , filePath = "";
        //이슈 표시
        var issues = "";
        var allIssues = "";
        var issuesArray = new Array();
        var severityArray = new Array();
        var list = "";

        if (data.length > 0) {
            for (var j = 0; j < data.length; j++) {



                //소스 영역
                if (data[j].sources != null) {
                    for (var i = 0; i < data[j].sources.length; i++) {
                        source_num += "<p id='lineNum_" + data[j].sources[i][0] + "'>" + data[j].sources[i][0] + "</p>";
                        var source = data[j].sources[i][1].replace(/\t/gi,"&emsp;&emsp;");
                        if (data[j].sources[i][1] == "") {
                            list += "<p id='sourceView_" + (i + 1) + "'><br></p>";
                        } else {
                            list += "<p id='sourceView_" + (i + 1) + "'>" + source + "</p>";
                        }

                    }

                }

                //파일이름 영역
                if (data[j].components != null) {
                    for (var h = 0; h < data[j].components.length; h++) {
                       if (data[j].components[h].qualifier == "FIL") {
                            fileName = data[j].components[h].projectViewName;
                            filePath = data[j].components[h].path;
                        }
                    }

                }

                //커버리지 영역
                if (data[j].msr != null) {
                    for (var k = 0; k < data[j].msr.length; k++) {
                        if (data[j].msr[k].key == "lines") {
                            lines = data[j].msr[k].frmt_val;
                        } else if (data[j].msr[k].key == "coverage") {
                            coverage = data[j].msr[k].frmt_val;
                        } else if (data[j].msr[k].key == "violations") {
                            issue = data[j].msr[k].frmt_val;
                        } else if (data[j].msr[k].key == "coverage_line_hits_data") {
                            lineData = data[j].msr[k].data;
                        }


                    }

                }
                var message = "";
                //이슈 영역
                if (data[j].issues != null) {
                    for (var s = 0; s < data[j].issues.length; s++) {
                        if (data[j].issues[s].textRange != null && data[j].issues[s].severity != null) {
                            issues += data[j].issues[s].textRange.startLine + "=" + data[j].issues[s].severity + ","
                            message += data[j].issues[s].message;
                        } else if (data[j].issues[s].textRange == null && data[j].issues[s].severity != null) {
                            allIssues += data[j].issues[s].severity;
                            message += data[j].issues[s].message;
                        }

                    }
                }


            }
            if (undefined == fileLineNum || null == fileLineNum || 'null' == fileLineNum || '' == fileLineNum)
                fileLineNum = "0"
            if (undefined == filePath || null == filePath || 'null' == filePath || '' == filePath)
                filePath = "";
            if (undefined == lines || null == lines || 'null' == lines || '' == lines)
                lines = "0";
            if (undefined == issue || null == issue || 'null' == issue || '' == issue)
                issue = "0";
            if (undefined == coverage || null == coverage || 'null' == coverage || '' == coverage)
                coverage = "0";



            $("#filePath").text(filePath);
            $("#fileName").text(fileName);
            $("#fileLineNum").text(lines);
            $("#fileIssueNum").text(issue);
            $("#fileCoverageNum").text(coverage);
            $("#source_code").html(list);
            $("#source_num").html(source_num);


            if (lineData != "") {
                if (lineData.indexOf(";") != -1) {
                    msrArray = lineData.split(";");
                    for (var i = 0; i < msrArray.length; i++) {
                        coverageArray = msrArray[i].split("=");
                        if (coverageArray[1] == "1") {
                            $("#lineNum_" + coverageArray[0]).attr("class", "line_bar_green");
                            $("#lineNum_" + coverageArray[0]).attr("title", "단위 테스트에 포함됨");
                        } else if (coverageArray[1] == "0") {
                            $("#lineNum_" + coverageArray[0]).attr("class", "line_bar_red");
                            $("#lineNum_" + coverageArray[0]).attr("title", "단위 테스트에 포함되지 않음");
                        }

                    }
                } else {
                    coverageArray = lineData.split("=");
                    if (coverageArray[1] == "1") {
                        $("#lineNum_" + coverageArray[0]).attr("class", "line_bar_green");
                        $("#lineNum_" + coverageArray[0]).attr("title", "단위 테스트에 포함됨");
                    } else if (coverageArray[1] == "0") {
                        $("#lineNum_" + coverageArray[0]).attr("class", "line_bar_red");
                        $("#lineNum_" + coverageArray[0]).attr("title", "단위 테스트에 포함되지 않음");
                    }
                }
            }

            //라인 소스 이슈
            if (issues != "") {
                issues = issues.slice(0, -1);
                if (issues.indexOf(",") != -1) {
                    issuesArray = issues.split(",");
                    for (var i = 0; i < issuesArray.length; i++) {
                        severityArray = issuesArray[i].split("=");
                        if (severityArray[1] == "BLOCKER") {
                            $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_blocker.png'>");
                        } else if (severityArray[1] == "CRITICAL") {
                            $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_critical.png'>");
                        } else if (severityArray[1] == "MAJOR") {
                            $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_major.png'>");
                        } else if (severityArray[1] == "MINOR") {
                            $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_minor.png'>");
                        } else if (severityArray[1] == "INFO") {
                            $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_info.png'>");
                        }

                    }
                } else {

                    severityArray = issues.split("=");
                    if (severityArray[1] == "BLOCKER") {
                        $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_blocker.png'>");
                    } else if (severityArray[1] == "CRITICAL") {
                        $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_critical.png'>");
                    } else if (severityArray[1] == "MAJOR") {
                        $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_major.png'>");
                    } else if (severityArray[1] == "MINOR") {
                        $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_minor.png'>");
                    } else if (severityArray[1] == "INFO") {
                        $("#lineNum_" + severityArray[0]).append("&nbsp;<img src='/resources/images/ico_info.png'>");
                    }
                }
            }


            //소스 전체 이슈
            if (allIssues != "") {
                if (allIssues == "BLOCKER") {
                    $("#lineNum_1").before("&nbsp;<img src='/resources/images/ico_blocker.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "CRITICAL") {
                    $("#lineNum_1").before("&nbsp;<img src='/resources/images/ico_critical.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "MAJOR") {
                    $("#lineNum_1").before("&nbsp;<img src='/resources/images/ico_major.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "MINOR") {
                    $("#lineNum_1").before("&nbsp;<img src='/resources/images/ico_minor.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "INFO") {
                    $("#lineNum_1").before("&nbsp;<img src='/resources/images/ico_info.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                }
            }


        }
        procCallSpinner(SPINNER_STOP);
    }


    //button 이벤트
    $(function () {
        //상세 버튼
        $(".issuesBtn").click(function () {
            $("#issuesTable").css("display", "none");
            $("#issuesDetail").css("display", "block");

        })
    })

    var resolutionChecked = function (chk) {
        if (chk == "0") {
            //unresolve일  경우 나머지는 모두 해제 unreslove만 선택되게 해야함
            for (var i = 0; i <= 4; i++) {
                $("input[name=resolutionCheck]").eq(i).prop('checked', false);
            }
            $("input[name=resolutionCheck]").eq(0).prop('checked', true);
        } else {
            //unresolve일  제외한 나머지가 선택될경우 unrelove는 해제됨
            $("input[name=resolutionCheck]").eq(0).prop('checked', false);
            if ( $("input[name=resolutionCheck]").eq(chk).is(":checked") == false) {

                $("input[name=resolutionCheck]").eq(chk).prop('checked', true);

            } else if ($("input[name=resolutionCheck]").eq(chk).is(":checked") == true) {

                $("input[name=resolutionCheck]").eq(chk).prop('checked', false);
            }
        }
        getList("refresh");
    }

    var chkOn = function (chkNum, chkName) {
        if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == false) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', true);

        } else if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == true) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', false);
        }
        getList("refresh");
    }


    //검색조건 갯수 초기화
    var conditionSetting = function () {

        $("#issueResolution").find(".issue_num").each(function (i) {
            $(this).text("0");
        })

        $("#issueSeverity").find(".issue_num").each(function (i) {
            $(this).text("0");
        })

        $("#issueStatus").find(".issue_num").each(function (i) {
            $(this).text("0");
        })

    }


    var setSeverity = function (num) {
        var issue = $("#issueKey_" + num).val();
        var severity = $("#issueSelect_" + num).val();


        var param = {
            issue: issue,
            severity: severity
        };
        procCallAjax("/qualityIssues/setSeverity.do", param, callbackGetServerity);
    }

    var callbackGetServerity = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        getProjectList();
        getLanguage();
        getList("refrash");
    }


    $(document.body).ready(function () {
        getProjectList();
        getLanguage();
        getList("init");
    });



</script>