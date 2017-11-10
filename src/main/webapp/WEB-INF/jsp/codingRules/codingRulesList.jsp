<%--
  Created by IntelliJ IDEA.
  User: kim
  Date: 2017-07-28
  Time: 오전 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li>코딩 규칙</li>
        </ul>
    </div>
</div>


<div id="container">
            <!-- left :s -->
            <div class="lnbWrap">
                <div class="lnb">
                    <!-- 검색 :s -->
                    <div class="pl12 mt10">
                        <form id="" method="post" action="">
                            <div class="lnb_search">
                                <input id="search_keyword" id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;"  placeholder="규칙명 검색" autocomplete="on" onkeypress="if(event.keyCode==13) {gCheckMore = false; searchList(''); }"/>
                                <%--<input id="search_keyword" id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;"  placeholder="규칙명 검색" autocomplete="on" />--%>

                                <a class="btn_search" href="javascript:searchList();" title="검색"></a>
                            </div>
                        </form>
                    </div>
                    <!--//검색 :e -->
                    <ul class="mt10">
                        <h4>개발언어 (Language)</h4>
                        <div id="searchLang">

                        </div>
                        <h4>이슈 수준 (Severity)</h4>
                        <div id="searchIssue">
                            <li><a href="javascript:chkOn(0,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="BLOCKER"> <span class="block"><i class="ico_blocker"></i>심각 (Blocker)</span> <span class="issue_num"></span></a></li>
                            <li><a href="javascript:chkOn(1,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="CRITICAL"> <span class="block"><i class="ico_critical"></i>높음 (Critical)</span> <span class="issue_num"></span></a></li>
                            <li><a href="javascript:chkOn(2,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="MAJOR"> <span class="block"><i class="ico_major"></i>보통 (Major)</span> <span class="issue_num"></span></a></li>
                            <li><a href="javascript:chkOn(3,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="MINOR"> <span class="block"><i class="ico_minor"></i>낮음 (Minor)</span> <span class="issue_num"></span></a></li>
                            <li class="last"><a href="javascript:chkOn(4,'issue');" ><input type="checkbox" name="issue" onclick="searchList()" value="INFO"> <span class="block"><i class="ico_info"></i>정보 (Info)</span> <span class="issue_num"></span></a></li>
                        </div>
                        <h4>품질 프로파일 (Quality Profile)</h4>
                        <div id="searchProfile">

                        </div>
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
                            <tbody id="tbodyData">
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
<!--//container :e -->


<div class="modal fade" id="modalCodingRules" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width: 600px;">
        <!-- 콘텐츠 -->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" id="popCloseBtn"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <span class="modal-title">선택 항목 품질 프로파일에 추가</span>
            </div>
            <div class="modal-body">
                <!-- form -->
                <div class="modal_contBox">
                    <!-- 기본 영역(품질 프로파일) -->
                    <div class="modalform_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">품질 프로파일</p><input type="hidden" id="qprofileUpdateKey" name="">
                        </div>
                        <!--//타이틀 영역-->
                        <!-- form 영역-->
                        <div class="form_right" id="qprofileCreate">
                            <div class="formBox">
                                <p><select class="input-large" id="qprofileSelect">
                                </select></p>
                            </div>
                        </div>

                        <!--//form 영역-->
                    </div>
                    <!--//기본 영역(품질 프로파일) -->
                    <!-- 기본 영역(이슈 수준 변경) -->
                    <div class="modalform_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">이슈 수준 변경</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!-- form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <p><select class="input-medium" id="issuesSelect">
                                    <option value="BLOCKER"><i class="ico_blocker"></i>심각</option>
                                    <option value="CRITICAL"><i class="ico_critical"></i>높음</option>
                                    <option value="MAJOR"><i class="ico_major"></i>보통</option>
                                    <option value="MINOR"><i class="ico_minor"></i>낮음</option>
                                    <option value="INFO"><i class="ico_info"></i>정보</option>
                                </select></p>
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                    <!--//기본 영역(이슈 수준 변경) -->
                </div>
                <!--//form -->
            </div>
            <div class="modal-footer">
                <!--추가-->
                <div class="fr" style="display: block" id="footerAddBtn">
                    <button type="button" class="button btn_pop" id="qprofilePopAdd">추가</button>
                    <button type="button" class="button btn_pop popClose">취소</button>
                </div>
            </div>
        </div>
        <!--//콘텐츠 :e -->
    </div>
</div>
<!--//Modal popup :e -->

<input type="hidden" id="serviceInstancesId" name="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />">
<!-- 페이징 할 갯수-->
<input type="hidden" id="crPaging" name="crPaging" value="50"/>
<!-- 페이징 토탈-->
<input type="hidden" id="totalPage" name="totalPage"/>
<!-- 코딩룰 sort -->
<input type="hidden" name="s" id="codingRuleSort" value="name"/>
<input type="hidden" name="codingRulesKey" id="codingRulesKey">

<form name="codingForm" id="codingForm" method="post">
    <input type="hidden" id="key" value="<c:out value='${codingRules.key}' default='' />">
    <input type="hidden" id="languages" value="<c:out value='${codingRules.languages}' default='' />">
    <input type="hidden" id="issues" value="<c:out value='${codingRules.issues}' default='' />">
    <input type="hidden" id="qprofile" value="<c:out value='${codingRules.qprofile}' default='' />">
    <input type="hidden" id="keyword" value="<c:out value='${codingRules.keyword}' default='' />">
</form>
    <input type="hidden" id="profileKey" value="<c:out value='${profileKey}' default='' />">

<script type="text/javascript">
    //loding bar
    $(window).scroll(function(){
        if($("#crDetail").css("display") == "none"){
            if($(window).scrollTop() >= $(document).height() - $(window).height()){
                var pageSize = $("#crPaging").val();
                var pageTotal = $("#totalPage").val();
                if(pageSize < pageTotal ) {
                    var loadingImg = "<tr id='lodingTable' ><td colspan='3' class='alignC'><img src = '/resources/images/img_loading.gif'></td></tr>";
                    $("#tbodyData > :last").html(loadingImg);


                    if (pageSize != "") {
                        pageSize = parseInt(pageSize) + 50;
                        $("#crPaging").val(pageSize);
                    } else {
                        pageSize = 0;
                        pageSize = parseInt(pageSize) + 50;
                        $("#crPaging").val(pageSize);
                    }
                    searchList();
                }else{
                    $("#lodingTable").hide();
                }
            }
        }
    });

/*    $(window).bind("popstate", function(event) {

        var data = event.originalEvent.state;


        if (data) {

            var splitter = $("#layout-vertical").data("kendoSplitter");

            splitter.ajaxRequest("#article-pane", data);

        }

        else {

            // 히스토리에 정보가 없을경우 메인화면으로 보내준다.

            var url = "/메인화면";

            $(location).attr('href', url);

        }

    })*/






    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        var gPage = 0;
        var gCheckMore = false;


        //언어 조회
        getLanguage();

        //프로파일 조회
        getQualityProfile();

        //리스트 조회
        searchList();
        var issues = $("#issues").val()
        $("#searchIssue").find("input[name=issue]").each(function(i){
            if(issues != "" && issues == $(this).val() ) {
                $(this).attr("checked","checked");
            }
        });
    });

    $(function(){
        //팝업 닫기 버튼
        $("#popCloseBtn , .popClose").click(function(){
            procClosePopup();
        });

        $("#qprofilePopAdd").click(function(){
            procPopupConfirm('프로파일에 추가', '추가 하시겠습니까?', 'qprofileAdd();');
        });
    });



    //이슈, 개발언어 a 태그 체크박스 활성화
    function chkOn(chkNum, chkName) {


        if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == false) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', true);

        } else if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == true) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', false);
        }


        searchList();
    }




    //프로파일 하나만 체크박스 하나만 선택하게 함수
    function qpCheck(name,chk){


        if(name == 'aTag'){
            if ($("input[name=profile]").eq(chk).is(":checked") == false) {

                $("#searchProfile").find("input[name=profile]").each(function (i) {

                    $(this).prop('checked', false);
                })

                $("input[name=profile]").eq(chk).prop('checked', true);
            } else {

                $("#searchProfile").find("input[name=profile]").each(function (i) {

                    $(this).prop('checked', false);
                })
            }
        } else {

            if ($("input[name=profile]").eq(chk).is(":checked") == true) {

                $("#searchProfile").find("input[name=profile]").each(function (i) {

                    $(this).prop('checked', false);
                })

                $("input[name=profile]").eq(chk).prop('checked', true);
            } else {

                $("#searchProfile").find("input[name=profile]").each(function (i) {

                    $(this).prop('checked', false);
                })
            }
        }


        searchList();

    }


//////////////////////////////////////////////////////////////////////////////////
    //엔터 검색
/*
    function CheckEnter(){
        var keycode = event.keyCode;
        if(keycode == 13){
            searchList();
        }else{
            return false;
        }
    }

    $("#search_keyword").keydown(function(){
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
            searchList();
        }
    });
*/

    /////////////////////////////////////////////////////////////

    //sonar 언어 목록 체크박스 조회
    function getLanguage(){
        procCallAjax("/codingRules/codingRulesCondition.do", null, callbackCodingRulesCondition);
    }

    //comm 프로파일 체크박스 조회
    function getQualityProfile(){
//        procCallAjax("/codingRules/qualityProfileList.do?serviceInstancesId="+$("#serviceInstancesId").val(),null,callbackCodingRulesProfile);

        procCallAjax("/codingRules/qualityProfileList.do",null,callbackCodingRulesProfile);
    }


    //코딩룰 리스트
    function searchList(){
        $("#ruleList").css("display","block");
        $("#crDetail").css("display","none");
        $("#crDetail").children().remove();


        //룰 검색 키워드
        var ruleKeyword = $("#search_keyword").val();

        //이슈 value
        var searchIssue = "";

        //언어 value
        var searchLanguage = "";

        //프로파일 value
        var searchProfile = "";

        //프로파일 체크박스 온 체크(프로파일 파라메터 값이 2개여야만 활성화)
        var profileOn = null;

        var listUrl = "/codingRules/codingRulesList.do";

        //이슈 체크박스 클릭시 param 셋팅
        $("#searchIssue").find("input[name=issue]").each(function(i){
            if($(this).is(":checked") == true){
                searchIssue += $(this).val()+",";
            }
        })

        //개발언어 체크박스 클릭시 param 셋팅
        $("#searchLang").find("input[name=langName]").each(function(i){
            if($(this).is(":checked") == true){
                searchLanguage += $(this).val()+",";
            }
        })

        //품질 프로파일(true)
        //품질프로파일 체크박스 클릭시 param 셋팅
        $("#searchProfile").find("input[name=profile]").each(function(i){

            if($(this).is(":checked") == true) {
                searchProfile = $(this).val();
                profileOn = "true";
            }

        })


        var issueData = searchIssue.slice(0,-1);
        var languageData = searchLanguage.slice(0,-1);


        //post data 셋팅
        var param = {
            ps: $("#crPaging").val(),
            q: ruleKeyword,
            severities: issueData,
            languages: languageData,
            serviceInstancesId : $("#serviceInstancesId").val(),
            qprofile : searchProfile,
            activation : profileOn,
            s:$("#codingRuleSort").val()
        };



        procCallAjax(listUrl,param,callbackCodingRulesList);

    }


    //rules deteil
    function crDetail(key){

        var searchLanguage = "";

        //이슈 value
        var searchIssue = "";

        //프로파일 value
        var searchProfile = "";

        $("#searchLang").find("input[name=langName]").each(function(i){
            if($(this).is(":checked") == true){
                searchLanguage += $(this).val()+",";
            }
        })

        //이슈 체크박스 클릭시 param 셋팅
        $("#searchIssue").find("input[name=issue]").each(function(i){
            if($(this).is(":checked") == true){
                searchIssue += $(this).val()+",";
            }
        })

        $("#searchProfile").find("input[name=profile]").each(function(i){

            if($(this).is(":checked") == true) {
                searchProfile = $(this).val();
            }

        })

        var issueData = searchIssue.slice(0,-1);
        var languageData = searchLanguage.slice(0,-1);



        var param= key+"&keyword"+$("#search_keyword").val() +"&languages=" +languageData+"&issues="+issueData+"&qprofile="+searchProfile

/*        $("#key").val(key);
        $("#langage").val(languageData);
        $("#keyword").val($("#search_keyword").val());
        $("#issues").val(issueData);
        $("#qprofile").val(searchProfile);

        var currentUrl = location.pathname;
        var splitString = "/";
        var splits = currentUrl.split(splitString);

        $("#codingForm").attr("action", splitString + splits[1] + splitString + splits[2]+"/codingRules/codingRulesDetail");
        $("#codingForm").submit();*/




        procMovePage("/codingRules/codingRulesDetail?key="+param);



    }



    /* callback list 목록 */

    //sonar 언어리스트 callBack
    var callbackCodingRulesCondition = function(data) {

        var list = "";

        if (RESULT_STATUS_FAIL === data.RESULT) {
            return false;
        }

        var listName = data.languages;
        var languageCheck = $("#languages").val()
        var checkNum = "";
        if (listName.length != 0) {
            for (var i = 0; i < listName.length; i++) {
                if(languageCheck ==   listName[i].key){
                    list += "<li><a href=\"javascript:chkOn("+ i +",'langName');\"><input type=\"checkbox\" name=\"langName\" value=\"" + listName[i].key + "\" onclick=\"searchList()\" checked> <span class=\"block\">" + listName[i].name + "</span> <span class=\"issue_num\"></span></a></li>";
                    checkNum = i;
                }else{
                    list += "<li><a href=\"javascript:chkOn("+ i +",'langName');\"><input type=\"checkbox\" name=\"langName\" value=\"" + listName[i].key + "\" onclick=\"searchList()\"> <span class=\"block\">" + listName[i].name + "</span> <span class=\"issue_num\"></span></a></li>";
                }

            }
        }

        $("#searchLang").html(list);
        if(languageCheck != ""){
            chkOn(checkNum , 'langName');
        }
    }


    //프로파일 리스트 callBack
    var callbackCodingRulesProfile = function (data) {
        procCallSpinner(SPINNER_STOP);

        if (RESULT_STATUS_FAIL === data.RESULT) { return false;}
        var list = "";

        var listName = data;
        var profileCheck = $("#profileKey").val();

        if(listName.length != 0){
            for(var i=0;i<listName.length;i++){
                if(listName[i].profileDefaultYn == "Y") {
                    if (profileCheck != "" && listName[i].key == profileCheck) {
                        list += "<li><a href=\"javascript:qpCheck('aTag'," + i + ");\"><input type=\"checkbox\" name=\"profile\" value=\"" + listName[i].key + "\" onclick=\"qpCheck('chkBox'," + i + ")\" checked> <span class=\"block\">" + listName[i].name + "</span> <span class=\"issue_num\"><span class='word_sort'>기본</span></span></a></li>";
                    } else {
                        list += "<li><a href=\"javascript:qpCheck('aTag'," + i + ");\"><input type=\"checkbox\" name=\"profile\" value=\"" + listName[i].key + "\" onclick=\"qpCheck('chkBox'," + i + ")\"> <span class=\"block\">" + listName[i].name + "</span><span class=\"issue_num\"><span class='word_sort'>기본</span></span></a></li>";
                    }
                }else{
                    if (profileCheck != "" && listName[i].key == profileCheck) {
                        list += "<li><a href=\"javascript:qpCheck('aTag'," + i + ");\"><input type=\"checkbox\" name=\"profile\" value=\"" + listName[i].key + "\" onclick=\"qpCheck('chkBox'," + i + ")\" checked> <span class=\"block\">" + listName[i].name + "</span> <span class=\"issue_num\"></span></a></li>";
                    } else {
                        list += "<li><a href=\"javascript:qpCheck('aTag'," + i + ");\"><input type=\"checkbox\" name=\"profile\" value=\"" + listName[i].key + "\" onclick=\"qpCheck('chkBox'," + i + ")\"> <span class=\"block\">" + listName[i].name + "</span> <span class=\"issue_num\"></span></a></li>";
                    }
                }
            }

        }


        $("#searchProfile").html(list);


    }





    //코딩룰 리스트 callBack
    var callbackCodingRulesList = function(data){
        var list = "";

        if (RESULT_STATUS_FAIL === data.RESULT) {
            list += "<tr>";
            list += "<td colspan='3' class='alignC'> 검색한 내용이 없습니다. </td>";
            list += "</tr>";
            return false;
        }

        var profilechecked = "";
        $("#searchProfile").find("input[name=profile]").each(function(i){
            if($(this).is(":checked") == true) {
                profilechecked += $(this).val();
            }
        })

        var listName = data.rules;



        if(listName.length != 0){
            $("#crPagin").val(data.ps);
            $("#totalPage").val(data.total);

            for(var i =0;i<listName.length;i++){
                list += "<tr>";
                list += "<td class='rule_tit'><a onclick='crDetail(\""+listName[i].key+"\");' href='javascript:void(0);' >"+ listName[i].name+ "</a></td>";

                if(listName[i].severity == "BLOCKER"){
                    list += "<td class='alignC'><i class='ico_blocker'></i></td>";
                } else if(listName[i].severity == "CRITICAL"){
                    list += "<td class='alignC'><i class='ico_critical'></i></td>";
                } else if(listName[i].severity == "MAJOR"){
                    list += "<td class='alignC'><i class='ico_major'></i></td>";
                } else if(listName[i].severity == "MINOR"){
                    list += "<td class='alignC'><i class='ico_minor'></i></td>";
                } else if(listName[i].severity == "INFO"){
                    list += "<td class='alignC'><i class='ico_info'></i></td>";
                }


                list += "<td class='alignC'>"+listName[i].langName+"</td>";

                //나중에 수정해야함
                if(profilechecked != "java-egov-qualityprofile-79840"){
                    if(profilechecked != "") {
                        list += "<td class='alignC'><button type='button' class='button quality_btn profileDelete' name ='profileDelete' onclick='qprofileDelete(\""+listName[i].key+"\")'>프로파일에서 제거</button></td>";
                    }else {
                        list += "<td class='alignC'><button type='button' class='button quality_btn profileAdd' name ='profileAdd'  onclick='addProfileBtn(\""+listName[i].key+"\")'>프로파일에 추가</button></td>";
                    }
                }else{
                    list += "<td class='alignC'><button type='button' class='button quality_btn profileDelete' name ='profileDelete' disabled onclick='qprofileDelete(\""+listName[i].key+"\")'>프로파일에서 제거</button></td>";
                }



                list += "</tr>";


            }

        }else{
            list += "<tr>";
            list += "<td colspan='3' class='alignC'> 검색한 내용이 없습니다. </td>";
            list += "</tr>";
        }

        $("#lodingTable").hide();
        $("#tbodyData").html(list);

    }


    var callbackCodingRulesDetail = function(data){
        var list = data.rule;
        $("#ruleList").css("display","none");
        $("#crDetail").css("display","block");
        $("#crDetail").append("<div class='fr mb10'><button type='button' class='button btn_default' onclick='searchList()' >목록</button></div>");
        $("#crDetail").append( '<table summary="품질이슈 리스트 테이블입니다." class="quality_list">'
               +' <caption>품질이슈 리스트</caption><colgroup> <col style="width: *" /> <col style="width:12%"> </colgroup> <tbody>'
               + '<tr> <td>'
               +'<div class="rule_tit">'+ list.name +'</div>'
               +'<ul class="sel_menu">'
               +'<li>'+ list.langName +'</li>'
                +'</ul>'
                +'</td>'
                +' <td></td>'
                +'</tr>'
                +'<tr class="codeArea">'
                +'<td colspan="2">'
                +list.htmlDesc+
                +'</td>'
                +'</tr>'
                + '</tbody>'
                + '</table>');

               if( list.severity == 'BLOCKER'){
                   $(".sel_menu").append( '<li><span class="ico_blocker"></span></li>');
               }else if(list.severity == 'CRITICAL'){
                   $(".sel_menu").append( '<li><span class="ico_critical"></span></li>');
               }else if(list.severity == 'MAJOR'){
                   $(".sel_menu").append( '<li><span class="ico_major"></span></li>')
               }else if(list.severity == 'MINOR'){
                   $(".sel_menu").append('<li><span class="ico_minor"></span></li>');
               }else if(list.severity == 'INFO'){
                   $(".sel_menu").append('<li><span class="ico_info"></span></li>');
               }


//        var renewURL = location.pathname;;
//
//        renewURL = renewURL.replace("/codingRules/dashboard","");
//
//        renewURL += '/codingRules/codingRulesDetail';
//        history.pushState(null, null, renewURL);


    }



//나중에 상세 추가

    //프로파일 팝업 셀렉트박스 리스트
    function addProfileBtn(key){
        procCallAjax("/codingRules/qualityProfileList.do",null,callbackCodingRulesProfilePopup);
        $("#modalCodingRules").modal('toggle');
        $("#codingRulesKey").val(key);
    }

    var callbackCodingRulesProfilePopup = function(data){

//        var profileHidden =$(".profile_name").length;
//        var profileArray = new Array();
        var list = "";
//        profileHidden - 1
//        for(var i=0;i<profileHidden;i++){
//            profileArray[i] = $("#qprofileId"+i).val();
//        }

        for(var j=0;j<data.length;j++){
//            if(data[j].key != profileArray[j]){
                list += "<option value='"+data[j].key+"'>"+data[j].name+"</option>";
//            }
        }

        $("#qprofileSelect").html(list);
    }


    //프로파일 추가
    function qprofileAdd(){
        //reset 추가해야함
        if( $("#qprofileSelect").val() != "java-egov-qualityprofile-79840"){

            var param = {
                rule_key : $("#codingRulesKey").val(),
                profile_key : $("#qprofileSelect").val(),
                severity : $("#issuesSelect").val(),
                reset: "true"
            };

            //api/qualityprofiles/activate_rule
            procCallAjax("/codingRules/codingRulesProfileAdd.do", param, callbackcodingRulesProfileAdd);
        }else{
            procPopupAlert('기본 품질 프로파일은 추가, 수정할 수 없습니다.', 'searchList();');
        }


    }

    var callbackcodingRulesProfileAdd = function(data){
        $("#laypop").hide();
        //리스트 재 조회
        procPopupAlert('추가 되었습니다.', 'searchList();');

        $("#codingRulesKey").val("");
    };


    //프로파일 제거
    function qprofileDelete(key){
        procPopupConfirm('프로파일 삭제', '삭제 하시겠습니까?', 'qprofileDel(\'' + key + '\');');
    }

    var qprofileDel = function(key){
        var searchProfile = "";
        $("#searchProfile").find("input[name=profile]").each(function(i){

            if($(this).is(":checked") == true) {
                searchProfile = $(this).val();
            }

        });

        var param = {
            rule_key : key,
            profile_key : searchProfile
        };

        procCallAjax("/codingRules/codingRulesProfileDelete.do", param, callbackcodingRulesProfileDelete);
    }

    var callbackcodingRulesProfileDelete = function(data){
        procPopupAlert('삭제 되었습니다.', 'searchList();');
    }

</script>