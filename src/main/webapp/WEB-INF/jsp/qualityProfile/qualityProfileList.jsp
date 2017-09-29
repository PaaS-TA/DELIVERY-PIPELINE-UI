<%--
  Created by IntelliJ IDEA.
  User: kim
  Date: 2017-08-10
  Time: 오후 2:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li>품질 프로파일</li>
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
                    <ul id="profileList">

                    </ul>
                </div>
            </div>
            <!--//left :e -->
            <div clss="contentWrap" id="contentProfileExp"style="display: block">
                <h5 class="sub_title">&nbsp;품질 프로파일은 분석하는 동안 적용 할 규칙 모음입니다. <br>&nbsp;각 언어별로 기본 프로파일이 있습니다. 다른 프로파일에 명시적으로 할당되지 않은 모든 프로젝트는 기본값으로 분석됩니다.</h5>
            </div>
            <!-- contentWrap :s -->
            <div class="contentWrap" id="contentProfile" style="display: none">
                <div class="content_in">
                    <!-- sub 타이틀 영역 :s -->
                    <div class="col-md-7 fl">
                        <h3 class="proj_tit" id="profileName"><span class="program">Java</span></h3>
                    </div>
                    <div class="fr mb10">
                       <button type="button" class="button btn_default" id="profileCopy">복제</button>
                        <button type="button" class="button btn_default" id="profileCreate">생성</button>
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
                    <!--내용없을 시<p class="ml18">기본 품질 프로파일에는 특정 프로젝트가 연결되지 않습니다.</p>-->
                    <!-- sub_tab :s -->
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
            <!--//contentWrap :e -->
        </div>
        <!--//full_sub_content :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->


<%----%>
<div class="modal fade" id="modalProfile" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width: 600px;">
        <!-- 콘텐츠 -->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close profileClose" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <span class="modal-title">품질 프로파일 복제</span>
            </div>
            <div class="modal-body">
                <!-- form -->
                <div class="modal_contBox">
                    <!-- 기본 영역(품질 프로파일) -->
                    <div class="modalform_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">품질 프로파일</p>
                        </div>
                        <div class="form_right">
                            <div class="formBox">
                                <input id="copyProfileText" name="copyProfileText" type="text" placeholder="품질 프로파일명을 입력하세요(필수)">
                            </div>
                        </div>
                    </div>
                    <div class="modalform_info">
                        <div class="form_left">
                            <p class="title">개발언어</p>
                        </div>
                        <div class="form_right" id="langText">
                            <div class="formBox">
                                <span id="profileLang"></span>
                            </div>
                        </div>
                        <div class="form_right">
                            <div class="formBox" id="langSelect">
                                <p><select class="input-medium" id="langSelectList">

                                </select></p>
                            </div>
                        </div>

                    </div>
                </div>
                <!--//form -->
            </div>
            <div class="modal-footer">

                <div class="fr" id="frCopyBtn">
                    <button type="button" class="button btn_pop" id="copyProfileBtn">복제</button> <button type="button" class="button btn_pop profileClose">취소</button>
                </div>

                <div class="fr" id="frCreateBtn">
                    <button type="button" class="button btn_pop" id="createProfileBtn">생성</button> <button type="button" class="button btn_pop profileClose">취소</button>
                </div>

                <div class="fr" id="frUdtBtn">
                    <button type="button" class="button btn_pop" id="updateProfileeBtn">수정</button> <button type="button" class="button btn_pop profileClose">취소</button>
                </div>

            </div>
        </div>
    </div>
    <!--//콘텐츠 :e -->
</div>





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


    $(document.body).ready(function () {
        getList();
    });






    $(function(){
        $("#profileCopy").click(function(){
            btnChang("copy");

        });

        $(".profileClose").click(function(){
            procClosePopup();

        });

        $("#copyProfileBtn").click(function(){
            procPopupConfirm('품질프로파일 복제', '복제 하시겠습니까?', 'saveCopyProfile();');
        });

        $("#profileUpdate").click(function(){
            btnChang("update");
        });

        $("#deleteProfileBtn").click(function(){
            procPopupConfirm('품질프로파일 삭제', '삭제 하시겠습니까?', 'deleteProfile();');

        });

        $("#updateProfileeBtn").click(function(){
            if($("#defaultVn").val() == "Y"){
                procPopupAlert("기본으로 제공되는 품질 프로파일은 삭제, 수정 할 수 없습니다.");
                return false;
            } else if($("#copyProfileText").val() == ""){
                procPopupAlert("품질 프로파일 명을 입력하세요.");
                $("#copyProfileText").val("");
            }else{
                procPopupConfirm('품질프로파일 수정', '수정 하시겠습니까?', 'updateProfile();');
            }
        });

        $("#profileCreate").click(function(){
            btnChang("create");
            languageList();

        });

        $("#createProfileBtn").click(function(){
            if($("#copyProfileText").val() == ""){
                procPopupAlert("품질 프로파일 명을 입력하세요.");
                $("#copyProfileText").val("");
            }else{
                procPopupConfirm('품질프로파일 생성', '생성 하시겠습니까?', 'createProfile();');
            }

        })

        $("#profileDefault").click(function(){
            procPopupConfirm('품질프로파일 기본설정', $("#profileName").text()+'을 기본으로 설정 하시겠습니까?', 'defaultProfile();','설정');
        })



    })

    var defaultProfile = function(){
        var param = {
            id:$("#profileId").val(),
            profileKey: $("#profileKey").val(),
            serviceInstancesId:$("#serviceInstancesId").val()
        };
        procCallAjax("/qualityProfile/qualityProfileDefaultSetting.do", param, qualityProfileDefaultSetting);
    }

    var qualityProfileDefaultSetting = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

//        procPopupAlert(  $("#profileName").text()+'를 기본으로 설정 하였습니다.');
        getList();
        profileActive($("#profileKey").val() ,$("#profileName").text(), $("#profileId").val(),$("#langName").val(),$("#language").val(),$("#defaultYn").val() );



    }



    function createProfile(){


        var param = {
            language:$("#langSelectList").val(),
            name : $("#copyProfileText").val(),
            serviceInstancesId:$("#serviceInstancesId").val(),
            defaultYn:"N"

        };

        procCallAjax("/qualityProfile/qualityProfileCreate.do", param, qualityProfileCreate);

    }

    var qualityProfileCreate = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        getList();
        getCodingRules(data.language, data.name);
        profileActive(data.key, data.name,data.id ,data.languageName ,data.language, data.defaultYn);
        getProjectList();
        $("#copyProfileText").val("");
        procPopupAlert('생성 되었습니다.');
    }


    function languageList(){
        procCallAjax("/qualityProfile/qualityProfileLangList.do", null, qualityProfileLangList);
    }

    var qualityProfileLangList = function(data){

        var list = "";
        if(data.languages.length != 0){
            for(var i=0;i<data.languages.length;i++){
                list += "<option value='"+data.languages[i].key+"'>"+ data.languages[i].name +"</option>";
            }

        }

        $("#langSelectList").html(list);

    }

    function deleteProfile(){
        if($("#defaultVn").val() == "Y"){
            procPopupAlert('기본으로 제공하는 품질 프로파일은 삭제,수정 할 수 없습니다.');
            return false;
        }

        var param = {
            id:$("#profileId").val(),
            profileKey:$("#profileKey").val(),
            serviceInstancesId:$("#serviceInstancesId").val(),
            defaultYn:"N"

        }
        procCallAjax("/qualityProfile/qualityProfileDelete.do", param, callbackGetQualityProfileDelete);
    }

    var callbackGetQualityProfileDelete = function(data){

        $("#contentProfileExp").css("display", "block");
        $("#contentProfile").css("display", "none");
        procPopupAlert('품질프로파일을 삭제 하였습니다.');
        $("#copyProfileText").val("");
        getList();


    }




    function updateProfile(){
        var param = {
            id:$("#profileId").val(),
            name:$("#copyProfileText").val(),
            key:$("#profileKey").val(),
            defaultYn:"N"

        };
        procCallAjax("/qualityProfile/qualityProfileUpdate.do", param, callbackGetQualityProfileUpdate);
    }

    var callbackGetQualityProfileUpdate = function(data){

        getList();
        profileActive(data.key, data.name,data.id , data.languageName ,data.language, data.defaultYn);
        getProjectList();
        $("#copyProfileText").val("");
//        procClosePopup();
        procPopupAlert('수정 되었습니다.');

    }


    function btnChang(name){
        if(name == "copy"){
            $("#frCopyBtn").css("display", "block");
            $("#frCreateBtn").css("display", "none");
            $("#frUdtBtn").css("display", "none");
            $("#langText").css("display", "block");
            $("#langSelect").css("display", "none");
            $("#profileLang").text($("#langName").val());
            $(".modal-title").text("품질 프로파일 복제");
        }else if(name == "update"){
            $("#frCopyBtn").css("display", "none");
            $("#frCreateBtn").css("display", "none");
            $("#frUdtBtn").css("display", "block");
            $("#profileLang").text($("#langName").val());
            $("#copyProfileText").val($("#profileName").text());
            $("#langText").css("display", "block");
            $("#langSelect").css("display", "none");
            $(".modal-title").text("품질 프로파일 수정");
        }else if(name == "create"){
            $("#frCopyBtn").css("display", "none");
            $("#frCreateBtn").css("display", "block");
            $("#frUdtBtn").css("display", "none");
            $("#langText").css("display", "none");
            $("#langSelect").css("display", "block");
            $(".modal-title").text("품질 프로파일 생성");
            $("#copyProfileText").val("");
        }

        $("#modalProfile").modal('toggle');
    }


    function saveCopyProfile(){
        if(doubleSubmitCheck()) return;
        var param = {
            fromKey: $("#profileKey").val(),
            toName:  $("#copyProfileText").val(),
            languageName: $("#langName").val(),
            language:$("#language").val(),
            serviceInstancesId:$("#serviceInstancesId").val(),
            defaultYn:"N"

        };
        procCallAjax("/qualityProfile/qualityProfileCopy.do", param, callbackGetQualityProfileCopy);

    }

    var callbackGetQualityProfileCopy = function(data){


        getList();
        profileActive(data.key, data.name, data.id, data.languageName ,data.language,data.defaultYn);
        getProjectList();
        $("#copyProfileText").val("");
        procPopupAlert('복제 되었습니다.');

    }


    // GET LIST
    var getList = function() {
        procCallAjax("/qualityProfile/qualityProfileList.do", null, callbackGetList);
    };

    var callbackGetList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;



        var list = "";
        var langName = new Array();
        var langResult = [];


        for(var i=0 ; i< data.length; i++){
            langName.push(data[i].languageName);
        }

        $.each(langName , function(index, element){
            if($.inArray(element, langResult) == -1){
                langResult.push(element);
                list += "<h4>"+element+"</h4>";
                for(var i=0 ; i< data.length; i++){
                    if(element == data[i].languageName){
                        if(data[i].defaultYn == "Y" ){
                            list += "<li><a href=\"javascript:profileActive(\'"+data[i].key+"', '"+data[i].name+"','"+data[i].id+"','"+data[i].languageName+"','"+data[i].language+"','"+data[i].defaultYn+"')\"><span class='block ico_bul'>"+data[i].name+"</span> <span class='issue_num'><span class='word_sort'>기본</span></span></a></li>";
                        } else if(data[i].defaultYn == "N"){
                            list += "<li><a href=\"javascript:profileActive(\'"+data[i].key+"', '"+data[i].name+"','"+data[i].id+"','"+data[i].languageName+"','"+data[i].language+"','"+data[i].defaultYn+"')\"><span class='block ico_bul'>"+data[i].name+"</span><span class='issue_num'></span></a></li>";
                        }

                    }

                }
            }
        })

        $("#profileList").html(list);


    }


    function profileActive(key , name, id, langName, language, defaultYn){
//        history.pushState(location.pathname);
        procCallSpinner(SPINNER_START);
        if(defaultYn == "Y") {
            $("#deleteProfileBtn").hide();
            $("#profileUpdate").hide();
        }else{
            $("#deleteProfileBtn").show();
            $("#profileUpdate").show();
        }

        $("#contentProfileExp").css("display","none");
        $("#contentProfile").css("display","block");
        $("#profileName").text(name);
        $("#langName").val(langName);
        $("#profileId").val(id);
        $("#profileKey").val(key);
        $("#language").val(language);
        $("#defaultYn").val(defaultYn);
        doubleSubmitFlag = false;
        //프로젝트 리스트
        getProjectList();

        //코딩 규칙 리스트
        getCodingRules(language, name);

        procCallSpinner(SPINNER_STOP);
    }

    function getCodingRules(language, name){
        var param =  {
            name:name,
            language:language

        };

        procCallAjax("/qualityProfile/codingRulesList.do", param, callbackGetQualityProfileList);
    }


    var callbackGetQualityProfileList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var list = data[0].rules;

        var blocker = 0;
        var critical = 0;
        var major = 0;
        var minor = 0;
        var info = 0;
        var total = 0;

        if(list != null ){
            for(var i=0;i<list.length;i++){

                if(list[i].severity == "BLOCKER" ){
                    blocker += 1;
                }else if(list[i].severity == "CRITICAL"){
                    critical += 1;
                }else if(list[i].severity == "MAJOR"){
                    major += 1;
                }else if(list[i].severity == "MINOR"){
                    minor += 1;
                }else if(list[i].severity == "INFO"){
                    info += 1;
                }

            }

        }
        total = blocker + critical + major+minor + info;
        $("#crTotal").text(total);
        $("#blockerNum").text(blocker);
        $("#criticalNum").text(critical);
        $("#majorNum").text(major);
        $("#minorNum").text(minor);
        $("#infoNum").text(info);
    }

    function getProjectList(){
        var param = {
            serviceInstancesId:$("#serviceInstancesId").val()
        }
        procCallAjax("/qualityProfile/projectsList.do", param, callbackGetProjectList);
    }

    var callbackGetProjectList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        //전체 프로첵트 리스트
        var projectList = "";

        //연결된 프로젝트 리스트
        var projectLinkedList = "";

        //미연결된 프로젝트리스트
        var projectFailureList = "";

        var profileId = $("#profileId").val();

        if(data.length != 0){
            for(var i=0; i<data.length; i++){

                if($("#defaultYn").val() != "Y"){
                    projectList += "<tr>";
                    if(data[i].qualityProfileId == profileId){
                        projectList += "<td><input type='checkbox' name='projectConnection"+data[i].id+"' onclick=\"projectConnection(\'"+data[i].id+"','"+data[i].sonarKey+"',this)\" value='"+ data[i].id + "' checked ></td>";
                    }else{

                        projectList += "<td><input type='checkbox' name='projectConnection"+data[i].id+"' onclick=\"projectConnection(\'"+data[i].id+"','"+data[i].sonarKey+"',this)\" value='"+ data[i].id + "' ></td>";
                    }

                    projectList += "<td class='alignL'>"+ data[i].name +"</td>";
                    projectList += "</tr>";

                    ///////////////////


                    if(data[i].qualityProfileId == profileId) {
                        projectLinkedList += "<tr>";
                        projectLinkedList += "<td><input type='checkbox' name='projectConnection"+data[i].id+"' onclick=\"projectConnection(\'"+data[i].id+"','"+data[i].sonarKey+"',this)\" value='" + data[i].id + "' checked > </td>";
                        projectLinkedList += "<td class='alignL'>"+ data[i].name +"</td>";
                        projectLinkedList += "</tr>";
                    }


                    //////////////////////////////////////


                    if(data[i].qualityProfileId != profileId){
                        projectFailureList += "<tr>";
                        projectFailureList += "<td><input type='checkbox' name='projectConnection"+data[i].id+"' onclick=\"projectConnection(\'"+data[i].id+"','"+data[i].sonarKey+"',this)\" value='" + data[i].id + "' > </td>";
                        projectFailureList += "<td class='alignL' >"+ data[i].name +"</td>";
                        projectFailureList += "</tr>";
                    }
                }else{
                    projectList = "<tr><td colspan='2'>기본 품질 프로파일에 대해 특정 프로젝트를 선택할 수 없습니다.</td></tr>";
                    projectLinkedList = "<tr><td  colspan='2'>기본 품질 프로파일에 대해 특정 프로젝트를 선택할 수 없습니다.</td></tr>";
                    projectFailureList = "<tr><td  colspan='2'>기본 품질 프로파일에 대해 특정 프로젝트를 선택할 수 없습니다.</td></tr>";
                }





            }


        }


        $("#allProject").html(projectList);
        $("#projectLinked").html(projectLinkedList);
        $("#projectFailure").html(projectFailureList);

    }

    //프로젝트 연결
    function projectConnection(id, key,chk){
        var profileId = $("#profileId").val();
        var profileKey = $("#profileKey").val();
        var projectKey = key;
        var projectId = id;

        var param = {};

        if(chk.checked == true){
            param = {
                qualityProfileId: profileId,
                profileKey:profileKey,
                projectKey:key,
                sonarKey: key,
                id: id,
                linked: "true"
            };
        }if(chk.checked == false){
            param = {
                qualityProfileId: profileId,
                profileKey:profileKey,
                projectKey:key,
                sonarKey: key,
                id: id,
                linked: "false"
            };
        }

        procCallAjax("/qualityProfile/qualityProfileProjectLinked.do", param, callbackQualityProfileProjectLinked);
    }


    var callbackQualityProfileProjectLinked = function(data){
        profileActive($("#profileKey").val() ,$("#profileName").text(), $("#profileId").val(),$("#langName").val(),$("#language").val(),$("#defaultYn").val() );
    }



    //rules page 이동
    var rulesPageMove = function(){
        //profile_key
        var profileKey = $("#profileKey").val()
//
//        procMovePage("/codingRules/"+profileKey+"/dashboard");
    }


</script>