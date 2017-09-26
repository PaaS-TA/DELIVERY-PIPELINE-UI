<%--
  Created by IntelliJ IDEA.
  User: kim
  Date: 2017-08-18
  Time: 오후 2:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div id="container">
    <div class="lnbWrap">
        <div class="lnb">
            <!-- 검색 :s -->
            <div class="pl12 mt10">
                <form id="" method="" action="">
                    <div class="lnb_search">
                        <input id="search_keyword" id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;" value="" placeholder="규칙명 검색" autocomplete="on" onkeypress="if(event.keyCode==13) {gCheckMore = false; searchList(''); }"></input>
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

                    <li><a href="javascript:chkOn(0,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="BLOCKER" > <span class="block"><i class="ico_blocker"></i>심각 (Blocker)</span> <span class="issue_num"></span></a></li>
                    <li><a href="javascript:chkOn(1,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="CRITICAL"> <span class="block"><i class="ico_critical"></i>높음 (Critical)</span> <span class="issue_num"></span></a></li>
                    <li><a href="javascript:chkOn(2,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="MAJOR"> <span class="block"><i class="ico_major"></i>보통 (Major)</span> <span class="issue_num"></span></a></li>
                    <li><a href="javascript:chkOn(3,'issue');" ><input type="checkbox"  name="issue" onclick="searchList()" value="MINOR"> <span class="block"><i class="ico_minor"></i>낮음 (Minor)</span> <span class="issue_num"></span></a></li>
                    <li class="last"><a href="javascript:chkOn(4,'issue');" ><input type="checkbox" name="issue" onclick="searchList()" value="INFO"> <span class="block"><i class="ico_info"></i>정보 (Info)</span> <span class="issue_num"></span></a></li>

                </div>
                <h4>프로젝트 (Project)</h4>
                <div id="searchProfile">

                </div>
            </ul>

        </div>
    </div>
    <div class="contentWrap" >
        <div class="content_in">
            <!--//상세 테이블 -->
            <div class="fr mb10">
                <button type="button" class="button btn_default" id="codingRulesListReturn">목록</button>
            </div>
            <table summary="품질이슈 리스트 테이블입니다." class="quality_list">
                <caption>품질이슈 리스트</caption>
                <colgroup>
                    <col style="width: *" />
                    <col style="width:12%">
                </colgroup>
                <tbody id="detailData">



                </tbody>
            </table>

        </div>
    </div>






</div>



<!-- 팝업창-->
<div class="modal fade" id="modalCodingDetail" tabindex="-1" role="dialog">
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
                        <div class="form_right" style="display: block" id="qprofileCreate">
                            <div class="formBox">
                                <p><select class="input-large" id="qprofileSelect">
                                </select></p>
                            </div>
                        </div>

                        <div class="form_right" style="display: none" id="qprofileUpdate">
                            <p class="title">품질 프로파일</p>
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
                <!--수정 -->
                <div class="fr" style="display: none" id="footerUpdateBtn">
                    <button type="button" class="button btn_pop" id="qprofilePopUpdate">수정</button>
                    <button type="button" class="button btn_pop popClose">취소</button>
                </div>
            </div>
        </div>
        <!--//콘텐츠 :e -->
    </div>
</div>
<!--//Modal popup :e -->



<form id="codingDetailForm" method="post">
    <input type="hidden" id="key" value="<c:out value='${codingRules.key}' default='' />">
    <input type="hidden" id="languages" value="<c:out value='${codingRules.languages}' default='' />">
    <input type="hidden" id="issues" value="<c:out value='${codingRules.issues}' default='' />">
    <input type="hidden" id="qprofile" value="<c:out value='${codingRules.qprofile}' default='' />">
    <input type="hidden" id="keyword" value="<c:out value='${codingRules.keyword}' default='' />">
</form>






<%--<div id="detailHtml" style="display: block">
</div>--%>



<script type="text/javascript">
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        //언어 조회
        getLanguage();
        //프로파일 조회
        getQualityProfile();
        //로딩시 이슈체크박스 체크하기
        chkIssues();

        getList();

    });

    //button 이벤트
    $(function() {
/*        $("#qprofileAddBtn").click(function(){
            $("#laypop").show();
        });*/



        //팝업 닫기 버튼
        $("#popCloseBtn , .popClose").click(function(){
            procClosePopup();
        });

        //퀄리티 프로파일 추가
        $("#qprofilePopAdd").click(function(){
            procPopupConfirm('프로파일에 추가', '추가 하시겠습니까?', 'qprofileAdd();');
//            qprofileAdd();
        });

        //퀄리티 프로파일 변경
        $("#qprofilePopUpdate").click(function(){
            procPopupConfirm('프로파일 변경', '변경 하시겠습니까?', 'qprofileUpdate();');
//            qprofileUpdate();
        });

        //
        $("#codingRulesListReturn").click(function(){
//            history.go(-1);
//            location.href("")
            var param = $("#key").val()+"&keyword"+$("#search_keyword").val() +"&languages=" +$("#languages").val()+"&issues="+$("#issues").val()+"&qprofile="+$("#qprofile").val();
            procMovePage("/codingRules/dashboard?key="+param);
        })
    });











    //이슈 체크
    function chkIssues(){
        var issues = $("#issues").val();
        var issuesArr = new Array();
        if(issues.indexOf(',') != -1){
            var issueSp = issues.split(',');
            for(var i in issueSp){
                issuesArr[i] = issueSp[i];
            }
        }else{
            issuesArr[0]= issues;
        }

        $("#searchIssue").find("input[name=issue]").each(function(i){
            for(var j=0;j<issuesArr.length;j++){
                if(issuesArr[j] == $(this).val()) {
                    $(this).prop('checked', true);
                }
            }
        })
    }


    //sonar 언어 목록 체크박스 조회
    function getLanguage(){
        procCallAjax("/codingRules/codingRulesCondition.do", null, callbackCodingRulesCondition);
    }

    //sonar 언어리스트 callBack
    var callbackCodingRulesCondition = function(data) {

        var list = "";

        if (RESULT_STATUS_FAIL === data.RESULT) {
            return false;
        }

        var listName = data.languages;

        //리스트에서 받은 체크박스
        var lang = $("#languages").val();

        var langArray = new Array();
        if(lang.indexOf(',') != -1){
            langArray = lang.split(",");
        }



        if (listName.length != 0) {
            for (var i = 0; i < listName.length; i++) {

                list += "<li><a href=\"javascript:chkOn("+ i +",'langName');\"><input type=\"checkbox\" name=\"langName\" value=\"" + listName[i].key + "\" onclick=\"searchList()\"> <span class=\"block\">" + listName[i].name + "</span> <span class=\"issue_num\"></span></a></li>";
            }
        }

        $("#searchLang").html(list);
    }

    //comm 프로바일 체크박스 조회
    function getQualityProfile(){
//        procCallAjax("/codingRules/qualityProfileList.do?serviceInstancesId="+$("#serviceInstancesId").val(),null,callbackCodingRulesProfile);

        procCallAjax("/codingRules/qualityProfileList.do",null,callbackCodingRulesProfile);
    }

    //프로파일 리스트 callBack
    var callbackCodingRulesProfile = function (data) {
        procCallSpinner(SPINNER_STOP);
        var list = "";
        if (RESULT_STATUS_FAIL === data.RESULT) { return false;}

        var listName = data;
        var qprofile = $("#qprofile").val();


        if(listName.length != 0){
            for(var i=0;i<listName.length;i++){
                if(qprofile == listName[i].key ){
                    list += "<li><a href=\"javascript:qpCheck('aTag',"+i+");\"><input type=\"checkbox\" name=\"profile\" value=\"" + listName[i].key + "\" onclick=\"qpCheck('chkBox',"+i+")\" checked> <span class=\"block\">"+listName[i].name+"</span> <span class=\"issue_num\"></span></a></li>";
                }else{
                    list += "<li><a href=\"javascript:qpCheck('aTag',"+i+");\"><input type=\"checkbox\" name=\"profile\" value=\"" + listName[i].key + "\" onclick=\"qpCheck('chkBox',"+i+")\"> <span class=\"block\">"+listName[i].name+"</span> <span class=\"issue_num\"></span></a></li>";
                }

            }

        }


        $("#searchProfile").html(list);

    }

    //체크박스 하나만 클릭되게~
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

    }


    //이슈, 개발언어 a 태그 체크박스 활성화
    function chkOn(chkNum, chkName) {


        if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == false) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', true);

        } else if ($("input[name=" + chkName + "]").eq(chkNum).is(":checked") == true) {

            $("input[name=" + chkName + "]").eq(chkNum).prop('checked', false);
        }

    }


    function getList(){
        var key = $("#key").val();
        //품질 프로파일 연결 확인(권한에 따라 false , yes, no ) 바꿔야함
        var actives = "true";

        procCallAjax("/codingRules/codingRulesDeteil.do?key="+key+"&actives="+actives, null, callbackCodingRulesDetail);
    }

   var callbackCodingRulesDetail =  function(data){
       var list = data.rule;
       var html = data.rule.htmlDesc;
       var detailList = "";
       var qprofileList = "";

       detailList += '<tr>';
       detailList += '<td>';
       detailList += '<div class="rule_tit">'+ list.name +'</div>';
       detailList += '<ul class="sel_menu">';

       if( list.severity == 'BLOCKER'){
           detailList += '<li><span class="ico_blocker"></span></li>'
       }else if(list.severity == 'CRITICAL'){
           detailList += '<li><span class="ico_critical"></span></li>'
       }else if(list.severity == 'MAJOR'){
           detailList += '<li><span class="ico_major"></span></li>'
       }else if(list.severity == 'MINOR'){
           detailList += '<li><span class="ico_minor"></span></li>'
       }else if(list.severity == 'INFO'){
           detailList += '<li><span class="ico_info"></span></li>'
       }

       detailList += '<li>'+ list.langName +'</li>';
       detailList += '</ul>';
       detailList += '</td>';
       detailList += '<td></td>';
       detailList += '</tr>';
       detailList += '<tr class="codeArea" >';
       detailList += '<td colspan="2" id="testbody">';
       detailList += list.htmlDesc;
       detailList += '</td>';
       detailList += "</tr>";





               detailList += '<tr>';
               detailList += '<td colspan="2">';
               detailList += '<h3>연결된 품질 프로파일 <button type="button" class="button tbl_in_btn_sm" id="qprofileAddBtn" onclick="addProfileBtn()">추가</button></h3>';
               detailList +=  '<div class="rule_tit">Refactor this method to throw at most one checked exception instead of: java.net.MalformedURLException, java.net.URISyntaxExceptio</div>';

       if(data.actives.length != 0){
           for(var i=0 ; i<data.actives.length; i++){
               detailList += '<ul class="profile_list">';
               detailList += '<li>';
               detailList += '<span class="profile_name">'+data.actives[i].qProfile+'<input type="hidden" id="qprofileId'+i+'" value="'+data.actives[i].qProfile+'"></span>';
               detailList += '<span class="r_box">';
               if( data.actives[i].severity == 'BLOCKER'){
                   detailList += '<span class="ico_issue"><i class="ico_blocker"></i> 심각 (Blocker)</span>';
               }else if(data.actives[i].severity == 'CRITICAL'){
                   detailList += '<span class="ico_issue"><i class="ico_critical"></i> 높음 (Critical)</span>';
               }else if(data.actives[i].severity == 'MAJOR'){
                   detailList += '<span class="ico_issue"><i class="ico_major"></i> 보통 (Major)</span>';
               }else if(data.actives[i].severity == 'MINOR'){
                   detailList += '<span class="ico_issue"><i class="ico_minor"></i> 낮음 (Minor)</span>';
               }else if(data.actives[i].severity == 'INFO'){
                   detailList += '<span class="ico_issue"><i class="ico_info"></i> 정보 (Info)</span>';
               }


               detailList += "<button type='button' class='button tbl_in_btn_sm' onclick='qprofileUpdatePop(\""+data.actives[i].qProfile+"\")'>변경</button> <button type='button' onclick='qprofileDelete(\""+data.actives[i].qProfile+"\")' class='button tbl_in_btn_sm' >제거</button>";
               detailList += '</span>';
               detailList += '</li>';
               detailList += '</ul>';
           }

       }
       detailList += '</td>';
       detailList += '</tr>';
       $("#detailData").html(detailList);
   }





    //프로파일 팝업 셀렉트박스 리스트
    function addProfileBtn(i){

       procCallAjax("/codingRules/qualityProfileList.do",null,callbackCodingRulesProfilePopup);
       popSet('추가');
        $("#modalCodingDetail").modal('toggle');
    }

    var callbackCodingRulesProfilePopup = function(data){

        var profileHidden =$(".profile_name").length;
        var profileArray = new Array();
        var list = "";
        profileHidden - 1
        for(var i=0;i<profileHidden;i++){
            profileArray[i] = $("#qprofileId"+i).val();
        }

        for(var j=0;j<data.length;j++){
            if(data[j].key != profileArray[j]){
                list += "<option value='"+data[j].key+"'>"+data[j].name+"</option>";
            }
        }

        $("#qprofileSelect").html(list);
    }


    //프로파일 추가
    function qprofileAdd(){



        var param = {
            rule_key : $("#key").val(),
            profile_key : $("#qprofileSelect").val(),
            severity : $("#issuesSelect").val()
        };

        //api/qualityprofiles/activate_rule
        procCallAjax("/codingRules/codingRulesProfileAdd.do", param, callbackcodingRulesProfileAdd);
    }

    var callbackcodingRulesProfileAdd = function(data){
        procClosePopup();
        //리스트 재 조회
        getList();

    }

//    api/qualityprofiles/deactivate_rule

    //프로파일 제거
    function qprofileDelete(key){
        procPopupConfirm('프로파일 삭제', '삭제 하시겠습니까?', 'qprofileDel(\'' + key + '\');');
    }

    var qprofileDel = function(key){
        var param = {
            rule_key : $("#key").val(),
            profile_key : key
        };
        procCallAjax("/codingRules/codingRulesProfileDelete.do", param, callbackcodingRulesProfileDelete);
    }


    var callbackcodingRulesProfileDelete = function(data){
        procPopupAlert('삭제 되었습니다.', 'getList();');

    }




    //프로파일 이슈 변경 팝업창
    function qprofileUpdatePop(key){
        popSet("변경");
        $("#qprofileUpdate").find(".title").text(key);
        $("#qprofileUpdateKey").val(key);

        $("#modalCodingDetail").modal('toggle');
    }

    //프로파일 이슈변경
    function qprofileUpdate(){
        var param = {
            rule_key : $("#key").val(),
            profile_key : $("#qprofileUpdateKey").val(),
            reset: true,
            severity: $("#issuesSelect").val()
        };

            procCallAjax("/codingRules/codingRulesProfileUpdate.do", param, callbackcodingRulesProfileUpdate);

    }


    var callbackcodingRulesProfileUpdate = function(data){
        procPopupAlert('변경 되었습니다.');
//        procClosePopup();
        getList();
    }


    //팝업변경 셋팅
    function popSet(set){
        if(set == '추가'){
            $("#qprofileUpdate").css("display", "none");
            $("#qprofileCreate").css("display", "block");
            $("#footerUpdateBtn").css("display","none");
            $("#footerAddBtn").css("display","block");
        } else if(set == '변경'){
            $("#qprofileUpdate").css("display", "block");
            $("#qprofileCreate").css("display", "none");
            $("#footerUpdateBtn").css("display","block");
            $("#footerAddBtn").css("display","none")
        }
    }


</script>