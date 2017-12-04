<%--
  Created by IntelliJ IDEA.
  User: kim
  Date: 2017-08-31
  Time: 오후 7:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .contentWrap {
        margin-left: 0px;
    }
</style>

<div id="container" class="mt25">
    <!-- content :s -->
    <div class="contents">
        <!-- sub 타이틀 영역 :s -->
        <div class="sub_titlebox">
            <div class="tit" id="title">Unit tests</div>
            <p>
                <span class="code_coverage"></span>
            </p>
            <div class="btn_wrap">
                <button type="button" class="button btn_default" title="목록" id="coverageBtn">목록</button>
            </div>
        </div>
        <!--//sub 타이틀 영역 :e -->
        <!-- full_sub_content :s -->
        <div class="">
            <!-- col-wrapper(2단 테이블) :s -->
            <div class="col-wrapper">
                <!-- 좌 테이블 :s -->
                <div class="col_2_l">
                    <div class="table_scroll"><!--스크롤영역-->
                        <table summary="프로젝트 리스트 테이블입니다." class="tbl_noline">
                            <caption>
                                프로젝트 리스트
                            </caption>
                            <colgroup>
                                <col style="width: *"/>
                                <col style="width: 20%"/>
                            </colgroup>
                            <tbody id="sourceFilePathTbody">

                            </tbody>
                        </table>
                    </div>
                </div>
                <!--//좌 테이블 :e -->
                <!-- 우 테이블 :s -->
                <div class="col_2_r">
                    <div class="table_scroll"><!--스크롤영역-->
                        <table summary="프로젝트 리스트 테이블입니다." class="tbl_noline">
                            <caption>
                                프로젝트 리스트
                            </caption>
                            <colgroup>
                                <col style="width: *"/>
                                <col style="width: 20%"/>
                            </colgroup>
                            <tbody id="sourceFileNameTbody">

                            </tbody>
                        </table>
                    </div>
                </div>
                <!--//우 테이블 :e -->
            </div>
            <!--//page-wrapper(2단 테이블) :e -->
            <!-- 소스영역 :s -->
            <div class="sourcebox" id="sourceBox">
                <div class="source_num">
                </div>
                <div class="source_code">

                </div>
            </div>
            <!--//소스영역 :e -->
        </div>
        <!--//full_sub_content :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->

<div class="contentWrap">
    <div class="content_in" id="issuesTable" style="display: block">

    </div>

    <div class="content_in" id="issuesDetail" style="display:none;">

        <div class="sub_titlebox">
            <div class="tit" id="fileName">BD</div>
            <p id="filePath">src/main/java/org/openpaas/servicebroker/mysql/config/Application.java</p>
            <div class="btn_wrap">
                <ul class="issue_data">
                    <li class="issue"><span><em id="fileLineNum">0</em><br>라인</span></li>
                    <li class="issue"><span><em id="fileIssueNum">0</em><br>이슈</span></li>
                    <li class="issue"><span><em id="fileCoverageNum">0%</em><br>커버리지</span></li>
                    <li class="test"><span><em id="testNum">0%</em><br>단위테스트</span></li>
                </ul>


            </div>
        </div>
        <div class="sourcebox">
            <div class="source_num" id="source_num"></div>
            <div class="source_code" id="source_code"></div>
        </div>
    </div>


</div>

<input type="hidden" id="package">
<input type="hidden" id="sourcefile">
<input type="hidden" id="projectName">
<input type="hidden" id="projectKey" value="<c:out value='${projectKey}' default='' />">
<input type="hidden" id="sourceCode" value="<c:out value='${sourceCode}' default='' />">
<input type="hidden" id="fileShow">
<script type="text/javascript">

    $(function () {
        $("#coverageBtn").click(function () {
            var projectKey = $("#projectKey").val();
            procMovePage("/projects/" + projectKey + "/dashboard");
        })
    })


    var getList = function () {

        var metrics = "";
        if ($("#sourceCode").val() == "unitCode") {
            metrics = "tests";
            $("#title").text("Unit tests");
        } else if ($("#sourceCode").val() == "lineCode") {
            metrics = "ncloc";
            $("#title").text("Line of code");
        } else if ($("#sourceCode").val() == "coverage") {
            metrics = "uncovered_lines";
            $("#title").text("Coverage");
        } else if ($("#sourceCode").val() == "lineCoverage") {
            metrics = "uncovered_lines";
            $("#title").text("Line Coverage");
        } else if ($("#sourceCode").val() == "uncoveredLines") {
            metrics = "uncovered_lines";
            $("#title").text("Uncovered lines");
        } else if ($("#sourceCode").val() == "linesToCover") {
            metrics = "lines_to_cover";
            $("#title").text("Lines To Cover");
        } else if ($("#sourceCode").val() == "branchCoverage") {
            metrics = "branch_coverage";
            $("#title").text("Condition coverage");
        } else if ($("#sourceCode").val() == "uncoveredConditions") {
            metrics = "uncovered_conditions";
            $("#title").text("Uncovered conditions");
        } else if ($("#sourceCode").val() == "conditionsToCover") {
            metrics = "conditions_to_cover";
            $("#title").text("Conditions to cover");
        } else if ($("#sourceCode").val() == "newLineCoverage") {
            metrics = "new_coverage";
            $("#title").text("Coverage on new code");
        } else if ($("#sourceCode").val() == "testExecutionTime") {
            metrics = "test_execution_time";
            $("#title").text("Unit tests duration");
        } else if ($("#sourceCode").val() == "testErrors") {
            metrics = "test_errors";
            $("#title").text("Unit tests errors");
        } else if ($("#sourceCode").val() == "testFailures") {
            metrics = "test_failures";
            $("#title").text("Unit tests failures");
        } else if ($("#sourceCode").val() == "skippedTests") {
            metrics = "skipped_tests";
            $("#title").text("Skipped unit tests");
        } else if ($("#sourceCode").val() == "testSuccessDensity") {
            metrics = "test_success_density";
            $("#title").text("Unit tests success");
        } else if ($("#sourceCode").val() == "coverageList") {
            metrics = "coverage";
            $("#title").text("Coverage");
        }


        procCallAjax("/projects/testsSource.do?projectKey=" + $("#projectKey").val() + "&metrics=" + metrics, null, callbacktestsSource);
    }


    var callbacktestsSource = function (data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;


        var list = "";
        var list2 = "";
        var code_num = "";

        if (data.length > 0) {
            list += "<tr>";
            list += "<td><a href='javascript:void(0);' onclick=\"getFiles(\'','')\">전체</a></td>";
            list += "<td class='td_number'></td>";
            list += "</tr>";


            for (var i = 0; i < data.length; i++) {
                if (data[i].msr[0] != null) {
                    if (data[i].qualifier == "TRK") {
                        code_num = data[i].msr[0].frmt_val;
                    } else if (data[i].qualifier == "DIR" && data[i].msr[0].frmt_val != 0) {

                        list += "<tr>";
                        list += "<td><a href='javascript:void(0);' onclick=\"getFiles(\'" + data[i].key + "','" + data[i].uuid + "','" + data[i].lname + "')\">" + data[i].lname + "</a></td>";
                        list += "<td class='td_number'>" + data[i].msr[0].frmt_val + "</td>";
                        list += "</tr>";

                    }
                } else {
                    list += "<tr>";
                    list += "<td>검색한 데이터가 없습니다.</td>";
                    list += "<td class='td_number'></td>";
                    list += "</tr>";

                    list2 += "<tr>";
                    list2 += "<td>검색한 데이터가 없습니다.</td>";
                    list2 += "<td class='td_number'></td>";
                    list2 += "</tr>";
                    break;
                }
            }
        } else {
            list += "<tr>";
            list += "<td>검색한 데이터가 없습니다.</td>";
            list += "<td class='td_number'></td>";
            list += "</tr>";

            list2 += "<tr>";
            list2 += "<td>검색한 데이터가 없습니다.</td>";
            list2 += "<td class='td_number'></td>";
            list2 += "</tr>";

        }


        $(".code_coverage").text(code_num);
        $("#sourceFilePathTbody").html(list);
        $("#sourceFileNameTbody").html(list2)


    }
    var testUnit = 0;
    var getSource = function (key, uuid, data) {
        testUnit = data;

        var src = key.split(":");
        $("#fileName").text($("#projectName").val());
        $("#filePath").text("/" + src[1]);
        $("#issuesTable").css("display", "none");
        $("#issuesDetail").css("display", "block");
        procCallAjax("/qualityIssues/qualityIssuesDetail.do?fileKey=" + key + "&fileUuid=" + uuid, null, callbackGetIssuesDetail);
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


        //이슈 표시
        var issues = "";
        var allIssues = "";
        var issuesArray = new Array();
        var severityArray = new Array();
        var list = "";

        if (data.length > 0) {

            console.log(data);
            for (var j = 0; j < data.length; j++) {



                //소스 영역
                if (data[j].sources != null) {
                    for (var i = 0; i < data[j].sources.length; i++) {
                        source_num += "<p id='lineNum_" + data[j].sources[i][0] + "'>" + data[j].sources[i][0] + "</p>";
                        var source = data[j].sources[i][1].replace(/\t/gi, "&emsp;&emsp;");
                        if (data[j].sources[i][1] == "") {
                            list += "<p id='sourceView_" + (i + 1) + "'><br></p>";
                        } else {
                            list += "<p id='sourceView_" + (i + 1) + "'>" + source + "</p>";
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


            if (undefined == lines || null == lines || 'null' == lines || '' == lines)
                lines = "0";
            if (undefined == issue || null == issue || 'null' == issue || '' == issue)
                issue = "0";
            if (undefined == coverage || null == coverage || 'null' == coverage || '' == coverage)
                coverage = "0";


            $("#fileLineNum").text(lines);
            $("#fileIssueNum").text(issue);
            $("#fileCoverageNum").text(coverage);
            $("#source_code").html(list);
            $("#source_num").html(source_num);

            if ($("#sourceCode").val() == "unitCode") {
                $("#testNum").text(testUnit);
                $(".issue").hide();
                $(".test").show();
            } else {
                $(".issue").show();
                $(".test").hide();
            }


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
                            $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_blocker.png'>");
                        } else if (severityArray[1] == "CRITICAL") {
                            $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_critical.png'>");
                        } else if (severityArray[1] == "MAJOR") {
                            $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_major.png'>");
                        } else if (severityArray[1] == "MINOR") {
                            $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_minor.png'>");
                        } else if (severityArray[1] == "INFO") {
                            $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_info.png'>");
                        }

                    }
                } else {
                    severityArray = issues.split("=");
                    if (severityArray[1] == "BLOCKER") {
                        $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_blocker.png'>");
                    } else if (severityArray[1] == "CRITICAL") {
                        $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_critical.png'>");
                    } else if (severityArray[1] == "MAJOR") {
                        $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_major.png'>");
                    } else if (severityArray[1] == "MINOR") {
                        $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_minor.png'>");
                    } else if (severityArray[1] == "INFO") {
                        $("#lineNum_" + severityArray[0]).append("<img src='/resources/images/ico_info.png'>");
                    }

                }
            }


            //소스 전체 이슈
            if (allIssues != "") {
                if (allIssues == "BLOCKER") {
                    $("#lineNum_1").before("<img src='/resources/images/ico_blocker.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "CRITICAL") {
                    $("#lineNum_1").before("<img src='/resources/images/ico_critical.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "MAJOR") {
                    $("#lineNum_1").before("<img src='/resources/images/ico_major.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "MINOR") {
                    $("#lineNum_1").before("<img src='/resources/images/ico_minor.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                } else if (allIssues == "INFO") {
                    $("#lineNum_1").before("<img src='/resources/images/ico_info.png'>");
                    $("#sourceView_1").before("<p><br></p>");
                }
            }


        }
        procCallSpinner(SPINNER_STOP);
    }
    //파일 감추기
    var getFiles = function (key, uuid, packageName) {

        $("#package").val(packageName);
        $("#issuesTable").css("display", "block");
        $("#issuesDetail").css("display", "none");

        $("#sourceBox").css("display", "none");
        var metrics = "";
        if ($("#sourceCode").val() == "unitCode") {
            metrics = "tests";
            $("#title").text("Unit tests");
        } else if ($("#sourceCode").val() == "lineCode") {
            metrics = "ncloc";
            $("#title").text("Line of code");
        } else if ($("#sourceCode").val() == "coverage") {
            metrics = "uncovered_lines";
            $("#title").text("Coverage");
        } else if ($("#sourceCode").val() == "lineCoverage") {
            metrics = "uncovered_lines";
            $("#title").text("Line Coverage");
        } else if ($("#sourceCode").val() == "uncoveredLines") {
            metrics = "uncovered_lines";
            $("#title").text("Uncovered lines");
        } else if ($("#sourceCode").val() == "linesToCover") {
            metrics = "lines_to_cover";
            $("#title").text("Lines To Cover ");
        } else if ($("#sourceCode").val() == "branchCoverage") {
            metrics = "branch_coverage";
            $("#title").text("Condition coverage");
        } else if ($("#sourceCode").val() == "uncoveredConditions") {
            metrics = "uncovered_conditions";
            $("#title").text("Uncovered conditions");
        } else if ($("#sourceCode").val() == "conditionsToCover") {
            metrics = "conditions_to_cover";
            $("#title").text("Conditions to cover");
        } else if ($("#sourceCode").val() == "newLineCoverage") {
            metrics = "new_coverage";
            $("#title").text("Coverage on new code");
        } else if ($("#sourceCode").val() == "testErrors") {
            metrics = "test_errors";
            $("#title").text("Unit tests errors");
        } else if ($("#sourceCode").val() == "testFailures") {
            metrics = "test_failures";
            $("#title").text("Unit tests failures");
        } else if ($("#sourceCode").val() == "skippedTests") {
            metrics = "skipped_tests";
            $("#title").text("Skipped unit tests");
        } else if ($("#sourceCode").val() == "testSuccessDensity") {
            metrics = "test_success_density";
            $("#title").text("Unit tests success");
        } else if ($("#sourceCode").val() == "coverageList") {
            metrics = "coverage";
            $("#title").text("Coverage");
        }

        if (uuid != "") {
            procCallAjax("/projects/testsSource.do?projectKey=" + key + "&metrics=" + metrics, null, callbackFileList);
        } else {
            procCallAjax("/projects/testsSource.do?projectKey=" + $("#projectKey").val() + "&metrics=" + metrics, null, callbackFileList);
        }


    }

    // GET DETAIL
    function getProjectDetail() {
        procCallAjax("/projects/getProjectDetail.do/<c:out value='${id}' default='' />", null, callbackGetProjectDetail);
    }


    // CALLBACK
    var callbackGetProjectDetail = function (data) {
        var doc = document;
        $('#projectName').val(data.projectViewName);
    };

    var callbackFileList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var list = "";
        if (data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].scope == "FIL") {
                    if (data[i].msr[0].frmt_val != 0) {
                        list += "<tr id='file_" + data[i].uuid + "' style='display: block;'>";
                        list += "<td><a href='javascript:void(0);' onclick=\"getSource(\'" + data[i].key + "','" + data[i].uuid + "','" + data[i].msr[0].frmt_val + "')\">" + data[i].name + "</a></td>";
                        list += "<td class='td_number'>" + data[i].msr[0].frmt_val + "</td>";
                        list += "</tr>";
                    }
                }

            }
        } else {
            list += "<tr>";
            list += "<td>검색한 데이터가 없습니다.</td>";
            list += "<td class='td_number'></td>";
            list += "</tr>";
        }
        $("#sourceFileNameTbody").html(list);

    }


    $(document.body).ready(function () {
        //sonarKey(소나 uuid 가져오기)
        $("#sourceBox").hide();
        getList();
        getProjectDetail();
        $("[data-toggle='tooltip']").tooltip();

    })


</script>



