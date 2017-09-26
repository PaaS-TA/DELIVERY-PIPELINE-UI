<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-08-01
  Time: 오후 4:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이동경로 :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li><span id="pipelineName"></span></li>
        </ul>
        <div class="fr">
            <button type="button" class="button btn_default" title="정보보기/수정" id="btnUpdatePipeline">정보보기/수정</button>
            <button type="button" class="button btn_default" title="신규생성" id="btnCreatePipeline">신규생성</button>
        </div>
    </div>
</div>
<!--//이동경로 :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- sub_tab :s -->
        <div class="sub_tab">
            <ul>
                <li class=""><a href="javascript:void(0);" onClick="procMovePipelineDetailTabPage('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_DETAIL %>');"><span class="file_on"></span>파이프라인 <span class="pl10" id="jobCount"></span></a></li><!--아이콘 on 파일네임 파일명_on 붙이면 됨-->
                <li class="fst active"><a href="javascript:void(0);" onClick="procMovePipelineDetailTabPage('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_CONTRIBUTOR %>');"><span class="contributor"></span>참여자(Contributor) <span class="pl10" id="contributorCount"></span></a></li>
            </ul>
        </div>
        <!--//sub_tab :e -->
        <!-- sub탭 콘텐츠02 :s -->
        <div class="sub_tab_cont01 mTs"<%-- style="display:none;"--%>>
            <div class="tab_content">
                    <!-- form (contBox) -->
                    <div class="contBox">
                        <!-- 공통 영역 -->
                        <div class="commonArea">
                            <div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">사용자 검색</p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="rSearch_group">
                                        <div class="sel_group">
                                                <div class="keyword_search">
                                                    <input id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;" placeholder="사용자 아이디 검색" autocomplete="on" onkeypress="if(event.keyCode==13) {search(); }" value="${listRequest.name}" />
                                                    <a class="btn_search" href="javascript:void(0);" title="사용자 아이디 검색" id="btnSearch"></a>
                                                </div>
                                        </div>
                                    </div>
                                    <!-- 검색시 추가 참여자 목록-->
                                    <div class="formBox mt-5">
                                        <ul id="listArea">
                                            <%--<li><span class="fl" style="width:525px;">test 1124</span> <a title="추가" href="#"></a></li>
                                            <li><span class="fl" style="width:525px;">kdhong12345</span> <a title="추가" href="#"></a></li>
                                            <li><span class="fl" style="width:525px;">test 1</span></li>
                                            <li><span class="fl" style="width:525px;">test 322</span> <a title="추가" href="#"></a></li>
                                            <li><span class="fl" style="width:525px;">test 1</span></li>
                                            <li><span class="fl" style="width:525px;">test 4</span></li>--%>
                                        </ul>
                                    </div>
                                    <!--//검색시 추가 참여자 목록-->
                                    <!-- 추가된 사용자 정보-->
                                    <div class="controlbox">
                                        <dl id="listArea2">
                                            <%--<dt>추가된 사용자 <span class="fr pr15"><a title="삭제" href="#">x</a></span></dt>
                                            <dd><span class="sm_tit">아이디 :</span> test</dd>
                                            <dd><span class="sm_tit">이메일 :</span> kdhong@naver.com</dd>--%>
                                        </dl>

                                    </div>
                                    <!--//추가된 사용자 정보-->
                                </div>
                                <!--//form 영역-->
                            </div>
                        </div>
                        <!--//공통영역 -->
                        <!-- 기본영역 -->
                        <div class="form_info">
                            <!--타이틀 영역-->
                            <div class="form_left">
                                <p class="title">권한</p>
                            </div>
                            <!--//타이틀 영역-->
                            <!--form 영역-->
                            <div class="form_right">
                                <div class="formBox">
                                    <c:forEach items="${authList}" var="auth">
                                        <c:if test="${auth.authType ne 'dashboard'}">
                                            <label><input type="radio" name="radio" value="${auth.id}" id="radio">${auth.displayName}</label>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <!--//form 영역-->
                        </div>
                        <!--//기본영역 -->
                        <!-- 기본영역 -->
                        <%--<div class="form_info">
                            <!--타이틀 영역-->
                            <div class="form_left">
                                <p class="title">설명 (선택)</p>
                            </div>
                            <!--//타이틀 영역-->
                            <!--form 영역-->
                            <div class="form_right">
                                <div class="formBox">
                                    <textarea type="text" colos="20" rows="5" onfocus="resize(this)" id="description"></textarea>
                                </div>
                            </div>
                            <!--//form 영역-->
                        </div>--%>
                        <!--//기본영역 -->
                        <!-- 버튼 영역 -->
                        <div class="btnboxArea">
                            <div class="fr">
                                <button type="button" class="button btn_default" title="추가" id="addContributor">추가</button>
                                <button type="button" class="button btn_default" title="취소" id="cancel">취소</button>
                            </div>
                        </div>
                        <!--//버튼 영역-->
                    </div>
                    <!--//form (contBox) -->
            </div>
        </div>
        <!--//sub탭 콘텐츠02 :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->
<input type="hidden" id="suid" name="suid" value="<c:out value='${suid}' default='' />"/>
<input type="hidden" id="id" name="id" value="<c:out value='${pipelineId}' default='' />"/>
<input type="hidden" id="requestSearchKeyword" name="requestSearchKeyword" value="<c:out value='${id}' default='' />" />
<input type="hidden" id="instanceUseId" name="instanceUseId" value="" />
<input type="hidden" id="user_id" name="user_id" value="" />
<script type="text/javascript">

    var count = 0;

    $("#btnSearch").on("click", function() {
        search();
    });

    var search = function(){
        var requestSearchKeyword = $("#requestSearchKeyword").val();
        var searchKeywordObject = $("#search_keyword");
        //var searchKeyword = searchKeywordObject.val();`

        var requestSearchKeyword = $("#search_keyword").val();
        var reqUrl;
        reqUrl = "/user/list.do?id=" + searchKeywordObject.val() + "&size=" + 10000;

        if(requestSearchKeyword != null && requestSearchKeyword != ''){
            procCallAjax(reqUrl, null, callbackGetUserList);
        }

        getContributorList();
    };


    var callbackGetUserList = function(data){
        var listLength = data.instanceUses.length;
        var htmlString = [];
        if(0 === listLength){
            htmlString = "<li><dl><dt>조회 된 데이터가 없습니다.</dt><dd></li>";
        } else {
            for (var i = 0; i < listLength; i++) {
                var count = 0;
                for(var j = 0; j < data.instanceUses[i].grantedAuthorities.length; j++){
                    if(data.instanceUses[i].grantedAuthorities[j].authCode != undefined && data.instanceUses[i].grantedAuthorities[j].authCode != null){
                        if(data.instanceUses[i].grantedAuthorities[j].authCode == $('#id').val()){
                            count++;
                        }
                    }
                }
                if(count == 0){
                    htmlString.push("<li>" + "<span class='fl' style='width:525px;'>" + "</span>"
                            + "<a title='추가' href='javascript:void(0);' onclick='moveDetailPage(\"" + data.instanceUses[i].user.id + "\");'>" + data.instanceUses[i].user.name + "</a></li>");
                }
            }
        }

        var listArea = $('#listArea');
        listArea.html(htmlString);

    };


    var moveDetailPage = function(id){
      var reqUrl = ("/user/get.do");
      var id = id;
      procCallAjax(reqUrl, {id : id }, callbackGetUser);
    };


    var callbackGetUser = function(data2){
        count++;

        var htmlString2 = [];

        htmlString2.push("<dt>추가할 사용자" + "<span class='fr pr15'><a title='삭제'>" + "</a></span></dt>"
                + "<dd><span class='sm_tit'>아이디 :" + "</span>"+ data2.user.name +"</dd>");


        var listArea2 = $('#listArea2');
        listArea2.html(htmlString2);

        var instanceUseId = data2.id;
        $('input[name=instanceUseId]').attr('value',instanceUseId);

        var user_id = data2.user.id;
        $('input[name=user_id]').attr('value',user_id);

        $('.controlbox').show();
    };

    $('.controlbox').hide();


    // BIND
    $('#cancel').on("click", function(){
       procMovePage(-1);
    });


    $('#addContributor').on("click", function(){
        var checkedValue = $("input[type=radio][name=radio]:checked").val();
        var userId = $('#user_id').val();
        if((userId =='' || checkedValue == undefined) || (userId =='' && checkedValue == undefined)){
            procPopupAlert('올바른 입력 값을 넣어주십시오.');
            return false;
        }else{
            procPopupConfirm('참여자 추가', '추가 하시겠습니까?', 'addContributor();');
        }



    });

    var addContributor = function(){
        procCallSpinner(SPINNER_START);
        var checkedValue = $("input[type=radio][name=radio]:checked").val();
        var instance_use_id = $("#instanceUseId").val();
        var userId = $('#user_id').val();
        var pipelineId = $('#id').val();
        //var description = $('#description').val();

        var reqParam = {
            instance_use_id : instance_use_id,
            authority_id : checkedValue,
            userId :userId,
            pipelineId : pipelineId
            //description : description
        };

        procCallAjax("/pipeline/contributorGrantedAuthority.do",reqParam, callbackGetContributor);
    };


    var callbackGetContributor = function(data){
        procCallSpinner(SPINNER_STOP);
        procPopupAlert('추가 되었습니다.', 'procMovePage(-1);');

    };

    // MOVE PAGE
    var procMovePipelineDetailTabPage = function(reqPage) {
        var reqUrl = "/pipeline/<c:out value='${pipelineId}' default='' />/";
        reqUrl += ('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_DETAIL %>' === reqPage)? "detail" : "contributor";

        procMovePage(reqUrl);
    };

    // GET
    var getPipeline = function() {
        procCallAjax("/pipeline/pipelineDetail.do", {id : "<c:out value='${pipelineId}' default='' />"}, callbackGetPipeline);
    };

    // BIND
    $('#btnUpdatePipeline').on("click", function () {
        procMovePage("/pipeline/update/<c:out value='${pipelineId}' default='' />");
    });

    //BIND
    $('#btnCreatePipeline').on("click", function(){
        procMovePage("/pipeline/create");
    });

    // CALLBACK
    var callbackGetPipeline = function(data) {
        $('#pipelineName').html(data.name);
    };

    // GET JOB LIST FROM DB
    var getJobListFromDb = function() {
        procCallAjax(JOB_PIPELINE_URL + "/list.do", null, callbackGetJobListFromDb);
    };

    // CALLBACK GET LIST FROM DB
    var callbackGetJobListFromDb = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.length,
                objJobCount = $('#jobCount');

        objJobCount.html(listLength);

    };

    var getContributorList = function(){
        var reqUrl;
        reqUrl = "/pipeline/<c:out value='${pipelineId}' default='' />/contributorList.do";

        procCallAjax(reqUrl, null, callbackGetContributorList);
    };

    var contributorList = [];

    var callbackGetContributorList = function(data){
        var listLength = data.instanceUses.length;
        contributorList = data.instanceUses;

        var contributorCount = listLength;
        document.getElementById('contributorCount').innerHTML = contributorCount;
    };

    $(document.body).ready(function(){
        procCallSpinner(SPINNER_START);
        getPipeline();
        getContributorList();
        getJobListFromDb();
        procCallSpinner(SPINNER_STOP);
        $('#search_keyword').putCursorAtEnd();
    });


</script>