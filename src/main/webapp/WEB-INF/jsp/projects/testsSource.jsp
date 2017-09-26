<%--
  Created by IntelliJ IDEA.
  User: kim
  Date: 2017-08-31
  Time: 오후 7:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                        <table summary="프로젝트 리스트 테이블입니다." class="tbl_noline" >
                            <caption>
                                프로젝트 리스트
                            </caption>
                            <colgroup>
                                <col style="width: *" />
                                <col style="width: 20%" />
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
                        <table summary="프로젝트 리스트 테이블입니다." class="tbl_noline" >
                            <caption>
                                프로젝트 리스트
                            </caption>
                            <colgroup>
                                <col style="width: *" />
                                <col style="width: 20%" />
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


<input type="hidden" id="projectKey" value="<c:out value='${projectKey}' default='' />">
<input type="hidden" id="sourceCode" value="<c:out value='${sourceCode}' default='' />">
<input type="hidden" id="fileShow">
<script type="text/javascript">

    $(function(){
        $("#coverageBtn").click(function(){
            var projectKey =  $("#projectKey").val();
            procMovePage("/projects/"+projectKey+"/dashboard");
        })
    })



    var getList = function(){

        var metrics = "";
        if($("#sourceCode").val() == "unitCode"){
            metrics = "tests";
            $("#title").text("Unit tests");
        }else if($("#sourceCode").val() == "lineCode"){
            metrics = "ncloc";
            $("#title").text("Line of code");

        }else if($("#sourceCode").val() == "coverage"){
            metrics = "uncovered_lines";
            $("#title").text("Coverage");
        }else if($("#sourceCode").val() =="lineCoverage"){
            metrics = "uncovered_lines";
            $("#title").text("Line Coverage");
        }else if($("#sourceCode").val() =="uncoveredLines"){
            metrics = "uncovered_lines";
            $("#title").text("Uncovered lines");
        }else if($("#sourceCode").val() =="linesToCover"){
            metrics = "lines_to_cover";
            $("#title").text("Lines To Cover");
        }else if($("#sourceCode").val() =="branchCoverage"){
            metrics = "branch_coverage";
            $("#title").text("Condition coverage");
        }else if($("#sourceCode").val() =="uncoveredConditions"){
            metrics = "uncovered_conditions";
            $("#title").text("Uncovered conditions");
        }else if($("#sourceCode").val() =="conditionsToCover"){
            metrics = "conditions_to_cover";
            $("#title").text("Conditions to cover");
        }else if($("#sourceCode").val() =="newLineCoverage"){
            metrics = "new_coverage";
            $("#title").text("Coverage on new code");
        }else if($("#sourceCode").val() == "testExecutionTime"){
            metrics = "test_execution_time";
            $("#title").text("Unit tests duration");
        }else if($("#sourceCode").val()=="testErrors"){
            metrics = "test_errors";
            $("#title").text("Unit tests errors");
        }else if($("#sourceCode").val() == "testFailures"){
            metrics = "test_failures";
            $("#title").text("Unit tests failures");
        }else if($("#sourceCode").val()=="skippedTests"){
            metrics = "skipped_tests";
            $("#title").text("Skipped unit tests");
        }else if($("#sourceCode").val()=="testSuccessDensity"){
            metrics ="test_success_density";
            $("#title").text("Unit tests success");
        }else if($("#sourceCode").val() == "coverageList"){
            metrics ="coverage";
            $("#title").text("Coverage");
        }

        procCallAjax("/projects/testsSource.do?projectKey="+$("#projectKey").val()+"&metrics="+metrics,  null , callbacktestsSource);
    }


    var callbacktestsSource = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

/*        $(".code_coverage").text(data.baseComponent.measures[0].value);
        var list = "";
        var list2 = "";
        if(data.components.length > 0){
            for(var i=0;i<data.components.length;i++){

                list += "<tr>";
                list += "<td>"+data.components[i].path+"</td>";
                list += "<td class='td_number'>"+data.components[i].measures[0].value+"</td>";
                list += "</tr>";

                list2 += "<tr>";
                list2 += "<td>"+data.components[i].name+"</td>";
                list2 += "<td class='td_number'>"+data.components[i].measures[0].value+"</td>";
                list2 += "</tr>";
            }

        }*/


        var list = "";
        var list2 = "";
        var code_num = "";

        if(data.length > 0){
            for(var i=0;i<data.length;i++){
                if(data[i].msr[0] != null) {
                    if (data[i].qualifier == "TRK") {
                        code_num = data[i].msr[0].frmt_val;
                    } else if (data[i].qualifier == "DIR" && data[i].msr[0].frmt_val != 0) {

                        list += "<tr>";
                        list += "<td><a href='javascript:void(0);' onclick=\"getFiles(\'" + data[i].key + "','" + data[i].uuid + "')\">" + data[i].lname + "</a></td>";
                        list += "<td class='td_number'>" + data[i].msr[0].frmt_val + "</td>";
                        list += "</tr>";

                    } else if (data[i].qualifier == "FIL" && data[i].msr[0].frmt_val != 0) {
                        list2 += "<tr id='file_" + data[i].uuid + "' style='display: block;'>";
                        list2 += "<td><a href='javascript:void(0);' onclick=\"getSource(\'" + data[i].key + "','" + data[i].uuid + "')\">" + data[i].name + "</a></td>";
                        list2 += "<td class='td_number'>" + data[i].msr[0].frmt_val + "</td>";
                        list2 += "</tr>";
                    }
                }else{
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
        }else{
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

  var getSource = function (key , uuid){
        procCallAjax("/projects/testsSourceShow.do?key="+key+"&uuid="+uuid,  null , callbacktestsSourceShow);
    }

    var callbacktestsSourceShow = function(data){

        var source_num = "";
        var source_code = "";
        var list = "";

        var author = "";
        var severity = "";

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
//        procCallSpinner(SPINNER_START);
        procCallSpinner(SPINNER_START);
        if(data.sources.length > 0){
            for(var i = 0;i<data.sources.length;i++){
                source_num += "<p id='lineNum_"+(i+1)+"'>"+data.sources[i][0]+"</p>";

                if(data.sources[i][1] == ""){
                    source_code += "<p><br></p>";
                }else{
                    source_code += "<p>"+data.sources[i][1]+"</p>";
                }


            }

        }
        $(".source_num").html(source_num);
        $(".source_code").html(source_code);
//        $("#sourceBox").css("display","block");
        $("#sourceBox").show();
        //사용자명 가져오기
        if(data.scm.length > 0 ){
            getAuthor(data.scm);
        }

        if(data.msr.length > 0){
            getMsr(data.msr);
        }
//        procCallSpinner(SPINNER_STOP);

        procCallSpinner(SPINNER_STOP);
  }

  var getAuthor = function(data){
        var author = "";
        for(var j=0;j<data.length;j++){
            $(".source_num").children("p").each(function(i){
                if(data[j][0] == $(this).text()){
                    if(data[j][1].length >= 10){
                        $(this).text($(this).text()+"  "+data[j][1].substr(0,10)+"...");
                        $(this).attr("data-toggle","tooltip");
                        $(this).attr("data-original-title","Default tooltip");
                        $(this).attr("title",data[j][1] + data[j][2]);
                    }else {
                        $(this).text($(this).text() + "  " + data[j][1]);
                    }


                }
            });
        }
  }

   //커버리지 표시
  var getMsr = function(data){
      var coverage = "";
      var msrArray = new Array();
      var coverageArray = new Array();

      var msrArray_2 = new Array();
      var coverageArray_2 = new Array();


      if(data[0].msr[0].data.indexOf(";") != -1){

          msrArray = data[0].msr[0].data.split(";");
          for(var i=0;i<msrArray.length;i++){
              coverageArray = msrArray[i].split("=");
              if(coverageArray[1] == "1"){
                  $("#lineNum_"+coverageArray[0]).attr("class","line_bar_green");
                  $("#lineNum_"+coverageArray[0]).attr("title","테스트 완료");
              }else if(coverageArray[1] == "0"){
                  $("#lineNum_"+coverageArray[0]).attr("class","line_bar_red");
                  $("#lineNum_"+coverageArray[0]).attr("title","테스트 미수행");
              }
          }
      }else{
          coverageArray = data[0].msr[0].data.split("=");;
          if(coverageArray[1] == "1"){
              $("#lineNum_"+coverageArray[0]).attr("class","line_bar_green");
              $("#lineNum_"+coverageArray[0]).attr("title","테스트 완료");
          }else if(coverageArray[1] == "0"){
              $("#lineNum_"+coverageArray[0]).attr("class","line_bar_red");
              $("#lineNum_"+coverageArray[0]).attr("title","테스트 미수행");
          }
      }


      if(data[0].msr[1] != null){
          if(data[0].msr[1].data.indexOf(";") != -1) {
              msrArray_2 = data[0].msr[1].data.split(";");

              for (var i = 0; i < msrArray_2.length; i++) {
                  coverageArray_2 = msrArray_2[i].split("=");
                  $("#lineNum_" + coverageArray_2[0]).attr("class", "line_bar_blue");
              }
          }else{
              coverageArray_2 = data[0].msr[1].data.split("=");
              $("#lineNum_" + coverageArray_2[0]).attr("class", "line_bar_blue");
          }
      }



  }




    //파일 감추기
    var getFiles = function(key,uuid){

        $("#sourceBox").css("display","none");
        var metrics = "";
        if($("#sourceCode").val() == "unitCode"){
            metrics = "tests";
            $("#title").text("Unit tests");
        }else if($("#sourceCode").val() == "lineCode"){
            metrics = "ncloc";
            $("#title").text("Line of code");
        }else if($("#sourceCode").val() == "coverage"){
            metrics = "uncovered_lines";
            $("#title").text("Coverage");
        }else if($("#sourceCode").val() =="lineCoverage"){
            metrics = "uncovered_lines";
            $("#title").text("Line Coverage");
        }else if($("#sourceCode").val() =="uncoveredLines"){
            metrics = "uncovered_lines";
            $("#title").text("Uncovered lines");
        }else if($("#sourceCode").val() =="linesToCover"){
            metrics = "lines_to_cover";
            $("#title").text("Lines To Cover ");
        }else if($("#sourceCode").val() =="branchCoverage"){
            metrics = "branch_coverage";
            $("#title").text("Condition coverage");
        }else if($("#sourceCode").val() =="uncoveredConditions"){
            metrics = "uncovered_conditions";
            $("#title").text("Uncovered conditions");
        }else if($("#sourceCode").val() =="conditionsToCover"){
            metrics = "conditions_to_cover";
            $("#title").text("Conditions to cover");
        }else if($("#sourceCode").val() =="newLineCoverage"){
            metrics = "new_coverage";
            $("#title").text("Coverage on new code");
        }else if($("#sourceCode").val()=="testErrors"){
            metrics = "test_errors";
            $("#title").text("Unit tests errors");
        }else if($("#sourceCode").val() == "testFailures"){
            metrics = "test_failures";
            $("#title").text("Unit tests failures");
        }else if($("#sourceCode").val()=="skippedTests"){
            metrics = "skipped_tests";
            $("#title").text("Skipped unit tests");
        }else if($("#sourceCode").val()=="testSuccessDensity"){
            metrics ="test_success_density";
            $("#title").text("Unit tests success");
        }else if($("#sourceCode").val() == "coverageList"){
            metrics ="coverage";
            $("#title").text("Coverage");
        }

        if($("#fileShow").val() == "" || $("#fileShow").val() != uuid){

            procCallAjax("/projects/testsSource.do?projectKey="+key+"&metrics="+metrics,  null , callbackFileList);
            $("#fileShow").val(uuid);

        }else{
            procCallAjax("/projects/testsSource.do?projectKey="+$("#projectKey").val()+"&metrics="+metrics,  null , callbacktestsSource);
            $("#fileShow").val("");
        }


    }

    var callbackFileList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var list = "";
        if(data.length > 0){
            for(var i=0;i<data.length;i++){
                if(data[i].qualifier == "FIL") {
                    if(data[i].msr[0].frmt_val != 0){
                        list += "<tr id='file_" + data[i].uuid + "' style='display: block;'>";
                        list += "<td><a href='javascript:void(0);' onclick=\"getSource(\'" + data[i].key + "','" + data[i].uuid + "')\">" + data[i].name + "</a></td>";
                        list += "<td class='td_number'>" + data[i].msr[0].frmt_val + "</td>";
                        list += "</tr>";
                    }

                }
            }
        }else{
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
        $("[data-toggle='tooltip']").tooltip();

    })





</script>



