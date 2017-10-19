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
                            <li><a href="javascript:resolutionChecked(0);"><input type="checkbox" name="resolutionCheck" value="UNRESOLVED" onclick="resolutionChecked('0')"> <span class="block">미해결 (Unresolved)</span> <span class="issue_num" id="unresolved">0</span></a></li>
                            <li><a href="javascript:resolutionChecked(1);"><input type="checkbox" name="resolutionCheck" value="FIXED" onclick="resolutionChecked('1')"> <span class="block">수정됨 (fixed)</span> <span class="issue_num" id="fixed">0</span></a></li>
                            <li><a href="javascript:resolutionChecked(2);"><input type="checkbox" name="resolutionCheck" value="FALSE-POSITIVE" onclick="resolutionChecked('2')"> <span class="block">보류 (False positive)</span> <span class="issue_num" id="false_positive">0</span></a></li>
                            <li><a href="javascript:resolutionChecked(3);"><input type="checkbox" name="resolutionCheck" value="WONTFIX" onclick="resolutionChecked('3')"> <span class="block">무시 (Won’t fix)</span> <span class="issue_num" id="wontfix">0</span></a></li>
                            <li class="last"><a href="javascript:resolutionChecked(4);"><input type="checkbox" name="resolutionCheck" value="REMOVED" onclick="resolutionChecked('4')"> <span class="block">제거됨 (Removed)</span> <span class="issue_num" id="removed">0</span></a></li>
                        </div>
                        <h4>이슈 수준 (Severity)</h4>
                        <div id="issueSeverity">
                            <li><a href="javascript:chkOn(0,'severityCheck');"><input type="checkbox" name="severityCheck" value="BLOCKER" onclick="getList()"> <span class="block"><i class="ico_blocker"></i>심각 (Blocker)</span> <span class="issue_num" id="blocker">0</span></a></li>
                            <li><a href="javascript:chkOn(1,'severityCheck');"><input type="checkbox" name="severityCheck" value="CRITICAL" onclick="getList()"> <span class="block"><i class="ico_critical"></i>높음 (Critical)</span> <span class="issue_num" id="critical">0</span></a></li>
                            <li><a href="javascript:chkOn(2,'severityCheck');"><input type="checkbox" name="severityCheck" value="MAJOR" onclick="getList()"> <span class="block"><i class="ico_major"></i>보통 (Major)</span> <span class="issue_num" id="major">0</span></a></li>
                            <li><a href="javascript:chkOn(3,'severityCheck');"><input type="checkbox" name="severityCheck" value="MINOR" onclick="getList()"> <span class="block"><i class="ico_minor"></i>낮음 (Minor)</span> <span class="issue_num" id="minor">0</span></a></li>
                            <li class="last"><a href="javascript:chkOn(4,'severityCheck');"><input type="checkbox" name="severityCheck" value="INFO" onclick="getList()"> <span class="block"><i class="ico_info"></i>정보 (Info)</span> <span class="issue_num" id="info">0</span></a></li>
                        </div>
                        <h4>상태 (Status)</h4>
                        <div id="issueStatus">
                            <li><a href="javascript:chkOn(0,'statusCheck');"><input type="checkbox"  name="statusCheck" value="OPEN" onclick="getList()"> <span class="block">활성 (Open)</span> <span class="issue_num" id="open">0</span></a></li>
                            <li><a href="javascript:chkOn(1,'statusCheck');"><input type="checkbox"  name="statusCheck" value="RESOLVED" onclick="getList()"> <span class="block">해결됨 (Resolved)</span> <span class="issue_num" id="resolved">0</span></a></li>
                            <li><a href="javascript:chkOn(2,'statusCheck');"><input type="checkbox"  name="statusCheck" value="REOPENED" onclick="getList()"> <span class="block">재활성 (Reopened)</span> <span class="issue_num" id="reopened">0</span></a></li>
                            <li><a href="javascript:chkOn(3,'statusCheck');"><input type="checkbox"  name="statusCheck" value="CLOSED" onclick="getList()"> <span class="block">비활성 (Closed)</span> <span class="issue_num" id="closed">0</span></a></li>
                            <li class="last"><a href="javascript:chkOn(4,'statusCheck');"><input type="checkbox" name="statusCheck" value="CONFIRMED" onclick="getList()"> <span class="block">확인됨 (Confirmed)</span> <span class="issue_num" id="confirmed">0</span></a></li>

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
                        <div class="tit" id="fileName">BD-Service-Java-Broker-MySQL</div>
                        <p id="filePath">rc/main/java/org/openpaas/servicebroker/mysql/config/Application.java</p>
                        <div class="btn_wrap">
                            <ul class="issue_data">
                                <li><span><em id="fileLineNum">12345</em><br>라인</span></li>
                                <li><span><em id="fileIssueNum">1234</em><br>이슈</span></li>
                                <li><span><em id="fileCoverageNum">100%</em><br>커버리지</span></li>
                            </ul>
                        </div>
                    </div>
                    <div class="sourcebox">
                        <div class="source_num">

                        </div>
                        <div class="source_code">
                            <!-- 리스트 테이블 1단 -->
                            <%--                              <table summary="품질이슈 리스트 테이블입니다." class="quality_list">
                                                           <caption>품질이슈 리스트</caption>
                                                           <colgroup>
                                                               <col style="width: *" />
                                                               <col style="width:10%">
                                                           </colgroup>
                                                           <tbody id="tbodyDetail">
                                                        <tr class="bgArea">
                                                               <td>
                                                                   <div class="rule_tit">규칙 명이 들어갑니다. 길 경우 두 줄까지 허용합니다.<br />규칙 명이 들어갑니다. 길 경우 두 줄까지 허용합니다.</div>
                                                                   <ul class="sel_menu">
                                                                       <li>
                                                                           <div class="selectbox select1" style="width:95px;">
                                                                               <div>
                                                                                   <strong><img src="/resources/images/ico_blocker.png"> 심각</strong><span class="bul"></span>
                                                                               </div>
                                                                               <ul class="select-list">
                                                                                   <li><span class="ico_blocker"></span>심각</li>
                                                                                   <li><span class="ico_critical"></span>높음</li>
                                                                                   <li><span class="ico_major"></span>보통</li>
                                                                                   <li><span class="ico_minor"></span>낮음</li>
                                                                                   <li><span class="ico_info"></span>정보</li>
                                                                               </ul>
                                                                           </div>
                                                                       </li>
                                                                       <li>
                                                                           <div class="selectbox select2" style="width:90px;">
                                                                               <div>
                                                                                   <strong>활성</strong><span class="bul"></span>
                                                                               </div>
                                                                               <ul class="select-list">
                                                                                   <li>활성</li>
                                                                                   <li>확인됨</li>
                                                                                   <li>수정됨</li>
                                                                                   <li>보류</li>
                                                                                   <li>무시</li>
                                                                                   <li>재활성</li>
                                                                               </ul>
                                                                           </div>
                                                                       </li>
                                                                       <li class="loca_txt">위치 : 12345라인</li>
                                                                   </ul>
                                                               </td>
                                                               <td><button type="submit" class="button quality_btn">규칙상세</button></td>
                                                           </tr>
                                                           <tr class="codeArea">
                                                               <td colspan="2">
                                                                   <p>내용내용 들어갈곳입니다.<br>내용내용 들어갈곳입니다.<br>내용내용 들어갈곳입니다.</p>
                                                               </td>
                                                           </tr>
                                                           </tbody>
                                                       </table>--%>
                        </div>
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
<input type="hidden" name="serviceInstancesId" id="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />">



<script type="text/javascript">
    $(window).scroll(function(){
     if($(window).scrollTop() >= $(document).height() - $(window).height()){

         var pageSize = $("#issuesPs").val();
         var pageTotal = $("#issuesTotal").val();
         if(parseInt(pageSize) < parseInt(pageTotal) ) {
             var loadingImg = " <tr><td class='alignC'><img src = '/resources/images/img_loading.gif'></td></tr>";
            $(".tbodyDatas  > :last").append(loadingImg);

            if (pageSize != "") {
                if($("#issuesTable").css("display") == "block") {
                    pageSize = parseInt(pageSize) + 50;
                    $("#issuesPs").val(pageSize);
                    getList();
                }
             } else {
                 pageSize = 0;
                 pageSize = parseInt(pageSize) + 50;
                 $("#issuesPs").val(pageSize);
             }
  /*           if($("#issuesTable").css("display") == "block") {
              if (pageSize != "" && pageSize <= pageTotal) {
              pageSize = parseInt(pageSize) + 50;
              $("#issuesPs").val(pageSize);
              getList();
              } else if (pageSize > pageTotal) {
              return false;
              }
              }*/

         }




        }
     })

    $(function(){

        $("#issuesListReturn").click(function(){
            $("#issuesTable").css("display", "block");
            $("#issuesDetail").css("display", "none");
        })



    });





    function getList(){

        $("#issuesTable").css("display", "block");
        $("#issuesDetail").css("display", "none");
        var ps = $("#issuesPs").val();
        var resolutions = "";
        var severities = "";
        var statuses = "";
        var componentKeys = "";
        //미해결은 검색조건이 다름
        var resolved = "";


        $("#issueResolution").find("input[name=resolutionCheck]").each(function(i){
            if($(this).is(":checked") == true){

                resolutions += $(this).val()+",";
            }
        });

        $("#issueSeverity").find("input[name=severityCheck]").each(function(i){
            if($(this).is(":checked") == true){
                severities += $(this).val()+",";
            }
        });

        $("#issueStatus").find("input[name=statusCheck]").each(function(i){
            if($(this).is(":checked") == true){
                statuses += $(this).val()+",";
            }
        });

        $("#issueProject").find("input[name=projectCheck]").each(function(i){

            if($(this).is(":checked") == true){
                componentKeys += $(this).val()+",";
            }
        });



        resolutions = resolutions.slice(0,-1);
        severities = severities.slice(0,-1);
        statuses = statuses.slice(0,-1);
        componentKeys = componentKeys.slice(0,-1);



        var param = {
            ps : ps,
            resolutions: resolutions,
            severities: severities,
            statuses: statuses,
            componentKeys: componentKeys,
            resolved: resolved,
            serviceInstancesId:$("#serviceInstancesId").val()

        }

        procCallAjax("/qualityIssues/qualityIssuesList.do", param, callbackGetList);
//        procCallAjax("/qualityIssues/issuesConditionList.do", param ,callbackGetIssuesCondition);


/*        if(componentKeys != ""){

            var param = {
                serviceInstancesId:$("#serviceInstancesId").val(),
                componentKeys:componentKeys
            }
            procCallAjax("/qualityIssues/issuesConditionList.do", param ,callbackGetIssuesCondition);
        }*/

        var param = {
            serviceInstancesId:$("#serviceInstancesId").val(),
            componentKeys:componentKeys
        }
        procCallAjax("/qualityIssues/issuesConditionList.do", param ,callbackGetIssuesCondition);

    }



    var callbackGetList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        procCallSpinner(SPINNER_START);
        var list = "";
        var listHead = "";
        var listFile = "";
        if(data.length != 0) {
            console.log(data);
            //data 정렬
            data.components.sort(function(a,b){
                return a.name < b.name ? -1 : a.name > b.name ? 1:0;
            });


            $("#issuesTotal").val(data.total);
            if(data.components != null && data.components.length >0) {
                for (var j = 0; j < data.components.length; j++) {


                    if (data.components[j].qualifier == "FIL") {

                        listHead += " <table summary='품질이슈 리스트 테이블입니다.' class='quality_list'>";
                        listHead += "<caption>품질이슈 리스트</caption>";
                        listHead += "<colgroup> <col style='width: *' /> <col style='width:10%'> </colgroup>";
                        listHead += "<thead><tr><th colspan='2' scope='col'>";
                        listHead += "<div class='tit' id='file_header_" + j + "'>";
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
            }else{
                listHead += " <table summary='품질이슈 리스트 테이블입니다.' class='quality_list'>";
                listHead += "<caption>품질이슈 리스트</caption>";
                listHead += "<colgroup> <col style='width: *' /> <col style='width:10%'> </colgroup>";


                listHead +=  "<tbody  class='tbodyDatas'>";
                listHead += "<tr><td class='alignC'>검색한 데이터가 없습니다.</td></tr>";
                listHead += "</tbody>";
                listHead += "</table>";

            }


            $("#issuesTable").html(listHead);

            if(data.components != null && data.components.length >0) {
                for (var j = 0; j < data.components.length; j++) {
                    if (data.components[j].qualifier == "TRK") {
                        $(".filePath_" + data.components[j].id).before(data.components[j].name);
                    }
                }


                for (var i = 0; i < data.issues.length; i++) {
                    list += "<tr>";
                    list += "<td>";
                    list += "<div class='rule_tit'>" + data.issues[i].message + "</div>";
                    list += "<ul class='sel_menu'>";
                    list += "<li>";
                    /*                list += "<div class='selectbox' style='width:95px;'>";
                 list += "<div>";
                     list += "<strong><img src='/resources/images/ico_blocker.png'> 심각</strong><span class='bul'></span>";
                     } else if (data.issues[i].severity == "CRITICAL") {
                     list += "<strong><img src='/resources/images/ico_critical.png'> 높음</strong><span class='bul'></span>";
                     } else if (data.issues[i].severity == "MAJOR") {
                     list += "<strong><img src='/resources/images/ico_major.png'> 보통</strong><span class='bul'></span>";
                     } else if (data.issues[i].severity == "MINOR") {
                     list += "<strong><img src='/resources/images/ico_minor.png'> 낮음</strong><span class='bul'></span>";
                     } else if (data.issues[i].severity == "INFO") {
                     list += "<strong><img src='/resources/images/ico_info.png'> 정보</strong><span class='bul'></span>";
                     }
                     if (data.issues[i].severity == "BLOCKER") {

                 list += "</div>";
                 list += "<ul class='select-list'>";
                 list += "<li><span class='ico_blocker'></span>심각</li>";
                 list += "<li><span class='ico_critical'></span>높음</li>";
                 list += "<li><span class='ico_major'></span>보통</li>";
                 list += "<li><span class='ico_minor'></span>낮음</li>";
                 list += "<li><span class='ico_info'></span>정보</li>";
                 list += "</ul>";
                 list += "</div>";*/
                 list += "<input type='hidden' id='issueKey_"+i+"' value='"+data.issues[i].key+"'>";
                 list += "<select id='issueSelect_"+i+"' class ='makeMeFancy' onchange='setSeverity("+i+")' style='width:95px;'>";

                if(data.issues[i].severity == "BLOCKER"){
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='심각' value='BLOCKER' selected>심각</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='높음' value='CRITICAL' >높음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='보통' value='MAJOR' >보통</option>";
                    list += "<option data-icon='/resources/images/ico_minor.png' data-html-text='낮음' value='MINOR' >낮음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='정보' value='INFO'>정보</option>";
                } else if (data.issues[i].severity == "CRITICAL") {

                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='심각' value='BLOCKER'>심각</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='높음' value='CRITICAL' selected>높음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='보통' value='MAJOR' >보통</option>";
                    list += "<option data-icon='/resources/images/ico_minor.png' data-html-text='낮음' value='MINOR' >낮음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='정보' value='INFO'>정보</option>";
                } else if (data.issues[i].severity == "MAJOR") {

                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='심각' value='BLOCKER'>심각</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='높음' value='CRITICAL'>높음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='보통' value='MAJOR' selected>보통</option>";
                    list += "<option data-icon='/resources/images/ico_minor.png' data-html-text='낮음' value='MINOR' >낮음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='정보' value='INFO'>정보</option>";
                } else if (data.issues[i].severity == "MINOR") {

                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='심각' value='BLOCKER'>심각</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='높음' value='CRITICAL'>높음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='보통' value='MAJOR'>보통</option>";
                    list += "<option data-icon='/resources/images/ico_minor.png' data-html-text='낮음' value='MINOR' selected>낮음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='정보' value='INFO'>정보</option>";
                } else if (data.issues[i].severity == "INFO") {

                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='심각' value='BLOCKER'>심각</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='높음' value='CRITICAL'>높음</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='보통' value='MAJOR'>보통</option>";
                    list += "<option data-icon='/resources/images/ico_blocker.png' data-html-text='낮음' value='MINOR'>낮음</option>";
                    list += "<option data-icon='/resources/images/ico_info.png' data-html-text='정보' value='INFO'selected>정보</option>";

                }

                list += " </select>";
                list += "</li>";

                list += "<li>";
                list += "<select style='width:95px;'>";
                if(data.issues[i].resolution == "OPEN"){
                    list += "<option value='' selected>활성</option>";
                    list += "<option>확인됨</option>";
                    list += "<option>수정됨</option>";
                    list += "<option>보류</option>";
                    list += "<option>무시</option>";
                    list += "<option>재활성</option>";
                } else if(data.issues[i].resolution =="CONFIRMED"){
                    list += "<option value=''>활성</option>";
                    list += "<option value='' selected>확인됨</option>";
                    list += "<option>수정됨</option>";
                    list += "<option>보류</option>";
                    list += "<option>무시</option>";
                    list += "<option>재활성</option>";
                } else if(data.issues[i].resolution =="FIXED"){
                    list += "<option value=''>활성</option>";
                    list += "<option value=''>확인됨</option>";
                    list += "<option selected>수정됨</option>";
                    list += "<option>보류</option>";
                    list += "<option>무시</option>";
                    list += "<option>재활성</option>";
                } else if(data.issues[i].resolution =="FALSE-POSITIVE"){
                    list += "<option value=''>활성</option>";
                    list += "<option value=''>확인됨</option>";
                    list += "<option>수정됨</option>";
                    list += "<option selected>보류</option>";
                    list += "<option>무시</option>";
                    list += "<option>재활성</option>";
                } else if(data.issues[i].resolution =="WONTFIX"){
                    list += "<option value='' >활성</option>";
                    list += "<option value='' >확인됨</option>";
                    list += "<option>수정됨</option>";
                    list += "<option>보류</option>";
                    list += "<option selected>무시</option>";
                    list += "<option>재활성</option>";
                } else if(data.issues[i].resolution =="REOPENED"){
                    list += "<option value='' >활성</option>";
                    list += "<option value='' >확인됨</option>";
                    list += "<option>수정됨</option>";
                    list += "<option>보류</option>";
                    list += "<option>무시</option>";
                    list += "<option selected>재활성</option>";
                }


                list += "</select>";
                list += "</li>";

                if (data.issues[i].textRange == "" || data.issues[i].textRange == "undefined" || data.issues[i].textRange == null) {
                    list += "<li class='loca_txt'></li>";
                } else {
                    list += "<li class='loca_txt'>위치 : " + data.issues[i].textRange.startLine + " 라인</li>";
                }
                list += " </ul>";
                list += "</td>";
                list += "<td><button type='button' class='button quality_btn issuesBtn' onclick=\"issuesDetail(\'" + data.issues[i].component + "','" + data.issues[i].key + "')\">규칙상세</button></td>";
                list += "</tr>";


                $("#tbodyData_" + data.issues[i].componentId).append(list);
                list = "";
            }
         }
        }

        procCallSpinner(SPINNER_STOP);

    }

/*    var test = function(){
        $('select.makeMeFancy').tzSelect({
            render : function(option){
                alert(+option.data);
                return $('<li>',{
                    html:	'<img src="'+option.data('icon')+'" /><span>'+
                    option.data('html-text')+'</span>'
                });
            },
            className : 'hasDetails'
        });
    }*/


    var getProjectList = function(){
        var param = {
            serviceInstancesId:$("#serviceInstancesId").val()
        };
        procCallAjax("/qualityIssues/projectList.do",param,callbackGetProjectList);
    }

    var callbackGetProjectList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var list = "";
        if(data.length > 0){

            for(var i=0 ; i<data.length; i++) {
                list += "<li><a href=\"javascript:chkOn(\'" +i+ "','projectCheck');\"><input type='checkbox' name='projectCheck' onclick='getList()' value='" + data[i].sonarKey + "'> <span class='block' title='"+data[i].name+"'>" + data[i].projectName + "</span> <span class='issue_num'></span></a></li>";
            }
        }

        $("#issueProject").html(list);

    }


    var getIssuesCondition = function(){
        var param = {
            serviceInstancesId:$("#serviceInstancesId").val()
        }
        procCallAjax("/qualityIssues/issuesConditionList.do", param ,callbackGetIssuesCondition);
    }

    var callbackGetIssuesCondition = function(data){

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        //값 초기화
        conditionSetting();


        var projectKey = new Array();
        var severity = new Array();
        var status = new Array();
        var resolution = new Array();

//        var projectList = "";
        var count = 0 ;
        if(data.length != 0) {
            for(var i=0;i<data.length;i++){
                count +=i;
                for (var j = 0; j < data[i].issues.length; j++) {
                    projectKey[count] = data[i].issues[j].project;
                    severity[count] = data[i].issues[j].severity;
                    status[count] = data[i].issues[j].status;
                    resolution[count] = data[i].issues[j].resolution;
                    count++;
                }

            }


            var projectResults = new Array();
            var severityResults = new Array();
            var statusResults = new Array();
            var resolutionResults = new Array();

            for (var k = 0; k < projectKey.length; k++) {
                var key = projectKey[k];
                var severityKey = severity[k];
                var statusKey = status[k];
                var resolutionKey = resolution[k];

                if (!projectResults[key]) {
                    projectResults[key] = 1
                } else {
                    projectResults[key] = projectResults[key] + 1;
                }

                if (!severityResults[severityKey]) {
                    severityResults[severityKey] = 1
                } else {
                    severityResults[severityKey] = severityResults[severityKey] + 1;
                }

                if (!statusResults[statusKey]) {
                    statusResults[statusKey] = 1
                } else {
                    statusResults[statusKey] = statusResults[statusKey] + 1;
                }

                if (!resolutionResults[resolutionKey]) {
                    resolutionResults[resolutionKey] = 1
                } else {
                    resolutionResults[resolutionKey] = resolutionResults[resolutionKey] + 1;
                }



            }


            //////////////////////////////////////////////////////////
            var projectCount = 0;

            for (var projectName in projectResults) {
                for(var i=0;i<data.length;i++) {
                    for (var j = 0; j < data[i].components.length; j++) {
                        if (data[i].components[j].qualifier == "TRK" && projectName == data[i].components[j].key) {
                            $("#issueProject").find("li").each(function(k){
                                if($(this).find(".block").text() ==data[i].components[j].name){
                                    $(this).find(".issue_num").text(projectResults[projectName]);
                                }
                            });
//                            projectList += "<li><a href=\"javascript:chkOn(\'"+(count)+"','projectCheck');\"><input type='checkbox' name='projectCheck' onclick='getList()' value='" + data[i].components[j].key + "'> <span class='block'>" + data[i].components[j].name + "</span> <span class='issue_num'>" +projectResults[projectName] + "</span></a></li>";
                            projectCount++;
                        }
                    }
                }

            }



//            $("#issueProject").html(projectList);


            for (var resolutionNum in resolutionResults) {


                if(resolutionNum == "FALSE-POSITIVE") {
                    $("#false_positive").text(resolutionResults[resolutionNum]);
                }else if(resolutionNum == "WONTFIX") {
                    $("#wontfix").text(resolutionResults[resolutionNum]);
                }else if(resolutionNum == "FIXED") {
                    $("#fixed").text(resolutionResults[resolutionNum]);
                }else if(resolutionNum == "REMOVED") {
                    $("#removed").text(resolutionResults[resolutionNum]);
                }else{
                    $("#unresolved").text(resolutionResults[resolutionNum]);
                }
            }


            for (var severityNum in severityResults) {
                if(severityNum == "BLOCKER"){
                    $("#blocker").text(severityResults[severityNum]);
                }else if(severityNum == "CRITICAL") {
                    $("#critical").text(severityResults[severityNum]);
                }else if(severityNum == "MAJOR") {
                    $("#major").text(severityResults[severityNum]);
                }else if(severityNum == "MINOR") {
                    $("#minor").text(severityResults[severityNum]);
                }else if(severityNum == "INFO") {
                    $("#info").text(severityResults[severityNum]);
                }
            }

            for (var statusNum in statusResults) {
                if(statusNum == "OPEN"){
                    $("#open").text(statusResults[statusNum]);
                }else if(statusNum == "RESOLVED") {
                    $("#resolved").text(statusResults[statusNum]);
                }else if(statusNum == "REOPENED") {
                    $("#reopened").text(statusResults[statusNum]);
                }else if(statusNum == "CLOSED") {
                    $("#closed").text(statusResults[statusNum]);
                }else if(statusNum == "CONFIRMED") {
                    $("#confirmed").text(statusResults[statusNum]);
                }
            }



        }



    }

    var getLanguage = function(){
        procCallAjax("/qualityIssues/getLanguageList.do",null,callbackGetIssueLanguageList);
    }

    var callbackGetIssueLanguageList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var list = "";
        if(data.languages.length > 0){
            for(var i=0;i<data.languages.length;i++){
                list += " <li><a href='#'><input type='checkbox' id='' value='"+data.languages[i].key+"'> <span class='block'>"+data.languages[i].name+"</span> <span class='issue_num'></span></a></li>";
            }

        }
        $("#issueLanguage").html(list);
    }





    function issuesDetail(key,uuid){

        $("#issuesTable").css("display", "none");
        $("#issuesDetail").css("display", "block");


        procCallAjax("/qualityIssues/qualityIssuesDetail.do?fileKey="+key+"&fileUuid="+uuid ,null,callbackGetIssuesDetail);

    }

    var callbackGetIssuesDetail = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        procCallSpinner(SPINNER_START);

        //소스
        var list = "";
        var source_num = "";
        //커버리지
        var lines = ""
            ,coverage = ""
            ,issue = ""
            ,lineData = "";
        var msrArray = new Array();
        var coverageArray = new Array();

        //파일
        var fileName = ""
            ,filePath = "";


        if(data.length > 0){
            for(var j=0;j<data.length;j++){
                //소스 영역
                if(data[j].sources != null){
                    for(var i=0; i<data[j].sources.length;i++){
                        source_num += "<p id='lineNum_"+data[j].sources[i][0]+"'>"+data[j].sources[i][0]+"</p>";
                        if(data[j].sources[i][1] ==""){
                            list += "<p><br></p>";
                        }else{
                            list += "<p>"+data[j].sources[i][1]+"</p>";
                        }

                    }

                }

                //파일이름 영역
                if(data[j].components != null){
                    for(var h=0;h<data[j].components.length;h++){
                        if(data[j].components[h].qualifier == "TRK"){
                            fileName = data[j].components[h].name;
                        }else if(data[j].components[h].qualifier == "FIL"){
                            filePath = data[j].components[h].path;
                        }
                    }

                }

                //커버리지 영역
                if(data[j].msr != null){
                    for(var k=0;k<data[j].msr.length;k++){
                        if(data[j].msr[k].key == "lines"){
                            lines = data[j].msr[k].frmt_val;
                        }else if(data[j].msr[k].key == "coverage"){
                            coverage = data[j].msr[k].frmt_val;
                        }else if(data[j].msr[k].key == "violations"){
                            issue = data[j].msr[k].frmt_val;
                        }else if(data[j].msr[k].key == "coverage_line_hits_data"){
                            lineData = data[j].msr[k].data;
                        }


                    }

                }

            }

            $("#filePath").text(filePath);
            $("#fileName").text(fileName);
            $("#fileLineNum").text(lines);
            $("#fileIssueNum").text(issue);
            $("#fileCoverageNum").text(coverage);
            $(".source_code").html(list);
            $(".source_num").html(source_num);



            if(lineData != ""){
                if(lineData.indexOf(";") != -1) {
                    msrArray = lineData.split(";");
                    for(var i=0;i<msrArray.length;i++){
                        coverageArray = msrArray[i].split("=");
                        if(coverageArray[1] == "1"){
                            $("#lineNum_"+coverageArray[0]).attr("class","line_bar_green");
                        }else if(coverageArray[1] == "0"){
                            $("#lineNum_"+coverageArray[0]).attr("class","line_bar_red");
                        }

                    }
                }else{
                    coverageArray = lineData.split("=");
                    if(coverageArray[1] == "1"){
                        $("#lineNum_"+coverageArray[0]).attr("class","line_bar_green");
                    }else if(coverageArray[1] == "0"){
                        $("#lineNum_"+coverageArray[0]).attr("class","line_bar_red");
                    }
                }
            }

        }
        procCallSpinner(SPINNER_STOP);
    }




    //button 이벤트
    $(function(){
        //상세 버튼
        $(".issuesBtn").click(function(){
            $("#issuesTable").css("display", "none");
            $("#issuesDetail").css("display", "block");

        })
    })

    var resolutionChecked = function(chk){
        if(chk == "0"){
            for(var i=1;i<=4;i++){
                $("input[name=resolutionCheck]").eq(i).prop("checked",false);
            }

        }else{
            $("input[name=resolutionCheck]").eq(0).prop("checked",false);
        }
        getList();
    }

    var chkOn = function(chkNum, chkName){
        if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == false) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', true);

        } else if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == true) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', false);
        }
        getList();
    }


    //검색조건 갯수 초기화
    var conditionSetting = function(){

        $("#issueResolution").find(".issue_num").each(function(i){
            $(this).text("0");
        })

        $("#issueSeverity").find(".issue_num").each(function(i){
            $(this).text("0");
        })

        $("#issueStatus").find(".issue_num").each(function(i){
            $(this).text("0");
        })

    }


    var setSeverity = function(num){
       var issue = $("#issueKey_"+num).val();
       var severity = $("#issueSelect_"+num).val();


        var param ={
            issue:issue,
            severity:severity
        };
        procCallAjax("/qualityIssues/setSeverity.do",param,callbackGetServerity);
    }

    var callbackGetServerity = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        getProjectList();
        getIssuesCondition();
        getLanguage();
        getList();
    }

    $(document.body).ready(function () {
        getProjectList();
        getIssuesCondition();
        getLanguage();
        getList();

    });

</script>