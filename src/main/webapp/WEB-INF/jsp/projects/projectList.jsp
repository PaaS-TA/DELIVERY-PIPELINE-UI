<%--
  Created by IntelliJ IDEA.
  User: kim
  Date: 2017-08-21
  Time: 오전 9:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">Home</a></li>
            <li>Quality Control Dashboard</li>
        </ul>
    </div>
</div>
<div id="container" class="mt25">
    <!-- content :s -->
    <div class="contents">

        <h2 class="title" style="margin: 0 15px; padding: 0 10px; " id="projectName"></h2>


        <h3 class="full_sub_title"  style="margin: 15px;padding: 10px;">Technical Debt</h3>
        <!--//타이틀 :e -->
        <!-- full_sub_content :s -->
        <%--<div class="full_sub_content">--%>
        <!-- list table :s -->
        <table summary="This is the project list table including project name, version, number of code lines, and final test" class="BasicTable" >
            <caption>
                Technical Debt
            </caption>
            <colgroup>
                <col style="width: 50%" />
                <col style="width: 50%" />
            </colgroup>
            <thead>
            </thead>
            <tbody id="technicalDebtBody">
            <tr>
                <td class="alignC" id="issueDay"></td>
                <td class="alignC" id="issuesNum"></td>
            </tr>
            </tbody>
        </table>
        <h3 class="full_sub_title"  style="margin: 15px;padding: 10px;">Coverage</h3>
        <table summary="COVERAGE" class="BasicTable" >
            <caption>

            </caption>
            <colgroup>
                <col style="width: 50%" />
                <col style="width: 50%" />
            </colgroup>
            <thead>
            </thead>
            <tbody id="coverTbody">
            <tr>
                <td class="alignC" id ="coverageNum"> </td>
                <td class="alignC" id="testsNum"></td>
            </tr>
            </tbody>
        </table>
        <h3 class="full_sub_title"  style="margin: 15px;padding: 10px;">Structure</h3>
        <table summary="COVERAGE" class="BasicTable" >
            <caption>

            </caption>
            <colgroup>
                <col style="width: 50%" />
                <col style="width: 50%" />
            </colgroup>
            <thead>
            </thead>
            <tbody id="structureBody">
            <tr>
                <td class="alignC"></td>
                <td class="alignC" id="codeLine"></td>
            </tr>
            </tbody>
        </table>

        <!-- full_sub_content :s -->

        <!-- col-wrapper(2단 테이블) :s -->
        <div class="col-wrapper">
            <!-- 좌 테이블 :s -->
            <div class="col_2_l">
                <h3 class="full_sub_title">Coverage(Coverage) </h3>  <%--<span>최종 테스트 : 2017-06-30</span>--%>
                <table summary="This is a table of coverage lists including items, numerical values, and variations" class="BasicTable" >
                    <caption>
                        Coverage list
                    </caption>
                    <colgroup>
                        <col style="width: *" />
                        <col style="width: 20%" />
                        <col style="width: 20%" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">Item</th>
                        <th scope="col">Numerical value</th>
                        <th scope="col">Variations</th>
                    </tr>
                    </thead>
                    <tbody id="coverageBody">
                    <tr class="total">
                        <td class="alignL">Coverage (%)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Code coverage (%)</td>
                        <td id=""></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Unexecuted code coverage (건)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Total code coverage (cases)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Conditional coverage (%)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Unexecuted conditional coverage (cases)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">All conditional coverage (cases)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr class="emph">
                        <td class="alignL">New code coverage (%)</td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--//좌 테이블 :e -->
            <!-- 우 테이블 :s -->
            <div class="col_2_r">
                <h3 class="full_sub_title" >Unit test (Unit test) </h3> <%--<span>최종 테스트 : 2017-06-30</span>--%>
                <table summary="This is a unit test list table including items, numerical values, and variations" class="BasicTable" >
                    <caption>
                        Unit test list
                    </caption>
                    <colgroup>
                        <col style="width: *" />
                        <col style="width: 20%" />
                        <col style="width: 20%" />
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">Item</th>
                        <th scope="col">Numerical value</th>
                        <th scope="col">Variations</th>
                    </tr>
                    </thead>
                    <tbody id="testsBody">
                    <tr>
                        <td class="alignL">Unit tests (cases)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Test run time (hours)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Error unit tests (건)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Failed unit tests (cases)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Skipped unit tests (cases)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    <tr>
                        <td class="alignL">Successful unit tests (%)</td>
                        <td></td>
                        <td class="increase"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!--//우 테이블 :e -->
        </div>
        <!--//page-wrapper(2단 테이블) :e -->
        <%--</div>--%>
        <!--//full_sub_content :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->

<input type="hidden" name="sonarKey" id="sonarKey"/>
<%--<input type="hidden" name="projectKey" id="projectKey" value="<c:out value='${projectKey}' default='' />">--%>
<input type="hidden" name="projectKey" id="projectKey" value="">


<script type="text/javascript">
    //AV2cYkiyooGwtceShh-F
    //AV30AhHeH-3Z4_C0kRaB
    var getSonarKey = function () {
        procCallAjax("/projects/getProjectSonarKey.do?projectKey=" + $("#projectKey").val(), null, callbackProjectSonarKey)
    }

    var callbackProjectSonarKey = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        if (data.length > 0) {
            $("#sonarKey").val(data[0].uuid);
            getList();
        }

    }

    var getList = function () {
        var sonarKey = $("#sonarKey").val();
        procCallAjax("/projects/qualityManagementList.do?uuid=" + sonarKey, null, callbackqualityManagementList);
    }

    var callbackqualityManagementList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var lines = "";
        var coverage = "";
        var issues = "";
        var tests = "";
        var debt = "";
        var key = "";
        var list = "";

        key = data.key;

        lines = "<a href='javascript:void(0)' onclick=\"movePage(\'lineCode')\"><h3 id='lineToCode'></h3><span style='text-decoration: underline;'>Line of Code</span></a>";


        if (data.measures.coverage != null || data.measures.coverage != undefined) {
            coverage = "<div style='display: inline;'><div id='coverageChat' style='display: inline-block;'></div><div style='display: inline-block;'><a href='javascript:void(0)' onclick=\"movePage(\'coverageList')\"><h3>" + data.measures.coverage + "</h3><span style='text-decoration: underline;'>Coverage</span></a></div></div>";
        } else {
            coverage = "<div style='display: inline;'><div id='coverageChat' style='display: inline-block;'></div><div style='display: inline-block;'><a href='javascript:void(0)' onclick=\"movePage(\'coverageList')\"><h3></h3></a></div></div>";
        }

        if (data.measures.issues != null || data.measures.issues != undefined) {
            issues = "<a  href='javascript:void(0)' onclick=\"movePage(\'issues')\"><h3>" + data.measures.issues + "</h3><span style='text-decoration: underline;'>Issues</span></a>";
        } else {
            issues = "<a  href='javascript:void(0)' onclick=\"movePage(\'issues')\"><h3></h3><span style='text-decoration: underline;'>Issues</span></a>";
        }
        tests = "<a href='javascript:void(0)'  onclick=\"movePage(\'unitCode')\"><h3>" + data.measures.tests + "</h3><span style='text-decoration: underline;'>Tests</span></a>";

        debt = "<a href='javascript:void(0)' onclick=\"movePage(\'debt')\"><h3>" + data.measures.debt + "</h3><span style='text-decoration: underline;'>Debt</span></a>";


        $("#issueDay").html(debt);
        $("#issuesNum").html(issues);
        $("#coverageNum").html(coverage);
        $("#testsNum").html(tests);
        $("#codeLine").html(lines);


        /*else{

            list += "<tr><td colspan='2'>No data was retrieved</td></tr>"
            $("#technicalDebtBody").html(list)
            $("#coverTbody").html(list);
            $("#structureBody").html(list);
        }
*/


        getCoverageList();
    }

    //커버리지 리스트
    var getCoverageList = function () {
        procCallAjax("/projects/qualityCoverageList.do?resource=" + $("#projectKey").val(), null, callbackqualityCoverageList);
    }

    var callbackqualityCoverageList = function (data) {

        var trLength = $("#coverageBody tr").length;
        var lineToCode = "";
        var coverage = "0.0%"
            , covarage_num = "0.0%"
            , line_coverage = "0.0%"
            , line_coverage_num = "0.0%"
            , uncovered_lines = "0"
            , uncovered_lines_num = "0"
            , lines_to_cover = "0"
            , lines_to_cover_num = "0"
            , branch_coverage = "0.0%"
            , branch_coverage_num = "0.0%"
            , uncovered_conditions = "0"
            , uncovered_conditions_num = "0"
            , conditions_to_cover = "0"
            , conditions_to_cover_num = "0"
            , new_line_coverage = "0.0%"
            , new_line_coverage_num = "0.0%"
            , datas = "";

        var tests
            , tests_num = "-"
            , test_execution_time
            , test_execution_time_num = "-"
            , test_errors
            , test_errors_num = "-"
            , test_failures
            , test_failures_num = "-"
            , skipped_tests
            , skipped_tests_num = "-"
            , test_success_density
            , test_success_density_num = "-";


        if (data.length > 0) {

            for (var i = 0; i < data[0].msr.length; i++) {
                datas = data[0].msr[i];
                if (datas.key == 'coverage' || datas.key == null) {
                    coverage = datas.frmt_val;
                    covarage_num = datas.fvar1;
                    $('#coverageChat').doughnutChart({
                        positiveColor: "#4FBAFF",
                        negativeColor: "#FF9CA5",
                        backgroundColor: "white",
                        percentage: datas.val,
                        size: 50,
                        doughnutSize: 0.35,
                    });

                } else if (datas.key == 'line_coverage' || datas.key == null) {
                    line_coverage = datas.frmt_val;
                    line_coverage_num = datas.fvar1;
                } else if (datas.key == 'uncovered_lines' || datas.key == null) {
                    uncovered_lines = datas.frmt_val;
                    uncovered_lines_num = datas.fvar1;
                } else if (datas.key == 'lines_to_cover' || datas.key == null) {
                    lines_to_cover = datas.frmt_val;
                    lines_to_cover_num = datas.fvar1;
                } else if (datas.key == 'branch_coverage' || datas.key == null) {
                    branch_coverage = datas.frmt_val;
                    branch_coverage_num = datas.fvar1;
                } else if (datas.key == 'uncovered_conditions' || datas.key == null) {
                    uncovered_conditions = datas.frmt_val;
                    uncovered_conditions_num = datas.fvar1;
                } else if (datas.key == 'conditions_to_cover' || datas.key == null) {
                    conditions_to_cover = datas.frmt_val;
                    conditions_to_cover_num = datas.fvar1;
                } else if (datas.key == 'new_coverage' || datas.key == null) {
                    new_line_coverage = datas.frmt_val;
                    new_line_coverage_num = datas.fvar1;


                } else if (datas.key == 'tests' || datas.key == null) {
                    tests = datas.frmt_val;
                    tests_num = datas.fvar1;
                } else if (datas.key == 'test_execution_time' || datas.key == null) {
                    test_execution_time = datas.frmt_val;
                    test_execution_time_num = datas.fvar1;
                } else if (datas.key == 'test_errors' || datas.key == null) {
                    test_errors = datas.frmt_val;
                    test_errors_num = datas.fvar1;
                } else if (datas.key == 'test_failures' || datas.key == null) {
                    test_failures = datas.frmt_val;
                    test_failures_num = datas.fvar1;
                } else if (datas.key == 'skipped_tests' || datas.key == null) {
                    skipped_tests = datas.frmt_val;
                    skipped_tests_num = datas.fvar1;
                } else if (datas.key == 'test_success_density' || datas.key == null) {
                    test_success_density = datas.frmt_val;
                    test_success_density_num = datas.fvar1;
                }

                if (datas.key == "ncloc" || datas.key == null) {
                    lineToCode = datas.frmt_val;
                }


            }


            $("#lineToCode").text(lineToCode);

            //커버리지 단위
            $("#coverageBody tr").eq(0).children().eq(1).html("<a href='javascript:void(0)' onclick=\"movePage(\'coverage')\">" + coverage + "</a>");
            $("#coverageBody tr").eq(1).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'lineCoverage')\">" + line_coverage + "</a>");
            $("#coverageBody tr").eq(2).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'uncoveredLines')\">" + uncovered_lines + "</a>");
            $("#coverageBody tr").eq(3).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'linesToCover')\">" + lines_to_cover + "</a>");
            $("#coverageBody tr").eq(4).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'branchCoverage')\">" + branch_coverage + "</a>");
            $("#coverageBody tr").eq(5).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'uncoveredConditions')\">" + uncovered_conditions + "</a>");
            $("#coverageBody tr").eq(6).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'conditionsToCover')\">" + conditions_to_cover + "</a>");
            $("#coverageBody tr").eq(7).children().eq(1).html();


            $("#coverageBody tr").eq(0).children().eq(2).text(covarage_num);
            $("#coverageBody tr").eq(1).children().eq(2).text(line_coverage_num);
            $("#coverageBody tr").eq(2).children().eq(2).text(uncovered_lines_num);
            $("#coverageBody tr").eq(3).children().eq(2).text(lines_to_cover_num);
            $("#coverageBody tr").eq(4).children().eq(2).text(branch_coverage_num);
            $("#coverageBody tr").eq(5).children().eq(2).text(uncovered_conditions_num);
            $("#coverageBody tr").eq(6).children().eq(2).text(conditions_to_cover_num);
            $("#coverageBody tr").eq(7).children().eq(2).html("<a href=javascript:void(0)' onclick=\"movePage(\'newLineCoverage')\">" + new_line_coverage_num + "</a>");


            $("#testsBody tr").eq(0).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'unitCode')\">" + tests + "</a>");
            $("#testsBody tr").eq(1).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'testExecutionTime')\">" + test_execution_time + "</a>");
            $("#testsBody tr").eq(2).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'testErrors')\">" + test_errors + "</a>");
            $("#testsBody tr").eq(3).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'testFailures')\">" + test_failures + "</a>");
            $("#testsBody tr").eq(4).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'skippedTests')\">" + skipped_tests + "</a>");
            $("#testsBody tr").eq(5).children().eq(1).html("<a href=javascript:void(0)' onclick=\"movePage(\'testSuccessDensity')\">" + test_success_density + "</a>");

            $("#testsBody tr").eq(0).children().eq(2).text(tests_num);
            $("#testsBody tr").eq(1).children().eq(2).text(test_execution_time_num);
            $("#testsBody tr").eq(2).children().eq(2).text(test_errors_num);
            $("#testsBody tr").eq(3).children().eq(2).text(test_failures_num);
            $("#testsBody tr").eq(4).children().eq(2).text(skipped_tests_num);
            $("#testsBody tr").eq(5).children().eq(2).text(test_success_density_num);


        }

    }

    var movePage = function (data) {
        var projectKey = $("#projectKey").val();
        var sourceView = data;
        if (sourceView == "issues" || sourceView == "debt") {
            procMovePage("/qualityIssues/dashboard");
        } else {
            procMovePage("/projects/" + projectKey + "/coverage/" + sourceView +"/<c:out value='${id}' default='' />");
        }
    }

    var getProjectName = function () {
        procCallAjax("/projects/getProjectName.do?projectKey=" + $("#projectKey").val(), null, callbackProjectName)
    }


    // GET DETAIL
    var getProjectDetail = function () {
        procCallAjax("/projects/getProjectDetail.do/<c:out value='${id}' default='' />", null, callbackGetProjectDetail)
//        procCallAjax("/projects/getProjectDetail.do/30", null, callbackGetProjectDetail)
    };


    // CALLBACK
    var callbackGetProjectDetail = function(data) {
        var doc = document;
        doc.getElementById('projectName').innerHTML = data.projectViewName;
        doc.getElementById('projectKey').value = data.projectKey;

        // TODO
        getSonarKey();
    };


    $(document.body).ready(function () {
        //sonarKey(소나 uuid 가져오기)
//        getSonarKey();
//        getProjectName();
        getProjectDetail();
    })


</script>
