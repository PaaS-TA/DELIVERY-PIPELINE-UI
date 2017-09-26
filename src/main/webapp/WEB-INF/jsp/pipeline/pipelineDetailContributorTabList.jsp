<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/10/2017
  Time: 5:54 PM
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
        <div class="sub_tab_cont01 mTs">
            <div class="tab_content">
                <!-- 검색, 버튼(참여자 추가) :s -->
                <div class="rSearch_group">
                    <div class="sel_group">
                            <div class="keyword_search">
                                <input id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;" placeholder="참여자 아이디 검색" autocomplete="on" onkeypress="if(event.keyCode==13) {gCheckMore = false; search(); }" value="${listRequest.name}" />
                                <a class="btn_search" href="javascript:void(0);" title="참여자 아이디 또는 이름 검색" id="btnSearch"></a>
                            </div>
                            <div class="fr">
                                <button type="button" class="button btn_default ml5" title="참여자 추가" id="btnCreateContributor">참여자 추가</button>
                            </div>
                    </div>
                </div>
                <!--//검색, 버튼(참여자 추가) :e -->
                <!-- 레파지토리 목록(이미지없는) :s -->
                <ul class="product_list2" id="listArea">
                    <%--<li>
                        <dl>
                            <dt><a href="#">아이디</a></dt>
                            <dd>
                                <ul>
                                    <li class="sbj_txt"><a href="#">홍길동</a></li>
                                    <li class="stateArea"><i class="ico_create"></i>생성일 : <a href="#">2017-06-09 14:22:45</a><span class="pr10"></span> <i class="ico_modify"></i>수정일 : <a href="#">2017-06-09 14:22:45</a></li>
                                </ul>
                            </dd>
                            <dd class="icon_wrap">
                                <ul class="ico_lst">
                                    <li class="ico_area">
                                        <a href="#"><img src="<c:out value='/resources/images/process_ico_run.png' />" alt="실행권한 이미지" border="0">
                                            <p class="tit">실행권한</p></a>
                                    </li>
                                </ul>
                            </dd>
                        </dl>
                    </li>
                    <li>
                        <dl>
                            <dt><a href="#">아이디</a></dt>
                            <dd>
                                <ul>
                                    <li class="sbj_txt"></li>
                                    <li class="stateArea"><i class="ico_create"></i>생성일 : <a href="#">2017-06-09 14:22:45</a><span class="pr10"></span> <i class="ico_modify"></i>수정일 : <a href="#">2017-06-09 14:22:45</a></li>
                                </ul>
                            </dd>
                            <dd class="icon_wrap">
                                <ul class="ico_lst">
                                    <li class="ico_area">
                                        <a href="#"><img src="<c:out value='/resources/images/process_ico_contribute.png' />" alt="보기권한 이미지" border="0">
                                            <p class="tit">보기권한</p></a>
                                    </li>
                                </ul>
                            </dd>
                        </dl>
                    </li>
                    <li>
                        <dl>
                            <dt><a href="#">아이디</a></dt>
                            <dd>
                                <ul>
                                    <li class="sbj_txt"><a href="#">홍길동</a></li>
                                    <li class="stateArea"><i class="ico_create"></i>생성일 : <a href="#">2017-06-09 14:22:45</a><span class="pr10"></span> <i class="ico_modify"></i>수정일 : <a href="#">2017-06-09 14:22:45</a></li>
                                </ul>
                            </dd>
                            <dd class="icon_wrap">
                                <ul class="ico_lst">
                                    <li class="ico_area">
                                        <a href="#"><img src="<c:out value='/resources/images/process_ico_admin.png' />" alt="생성권한 이미지" border="0">
                                            <p class="tit">생성권한</p></a>
                                    </li>
                                </ul>
                            </dd>
                        </dl>
                    </li>--%>
                </ul>
                <!--//레파지토리 목록(이미지없는) :e -->
            </div>
        </div>
    <!--//sub탭 콘텐츠02 :e -->
    </div>
<!--//content :e -->
</div>

<input type="hidden" id="suid" name="suid" value="<c:out value='${suid}' default='' />"/>
<input type="hidden" id="pipelineIdControlAuthority" name="pipelineIdControlAuthority" value="<c:out value='${pipelineId}' default='' />"/>
<input type="hidden" id="requestSearchKeyword" name="requestSearchKeyword" value="<c:out value='${id}' default='' />" />
<input type="hidden" id="requestPage" name="requestPage" value="<c:out value='${page}' default='0' />" />
<input type="hidden" id="requestSize" name="requestSize" value="<c:out value='${size}' default='0' />" />
<input type="hidden" id="requestSort" name="requestSort" value="<c:out value='${sort}' default='' />" />


<script type="text/javascript">

    var gPage = 0;
    var gCheckMore = false;

    var getContributorList = function(){
        var requestSearchKeyword = $("#requestSearchKeyword").val();
        var searchKeywordObject = $("#search_keyword");
        var searchKeyword = searchKeywordObject.val();
        var requestPageObject = $("#requestPage");
        var requestPage = requestPageObject.val();
        var requestSize = $("#requestSize").val();
        var reqUrl;

        if ("" !== requestSearchKeyword && "" === searchKeyword) {
            searchKeywordObject.val(requestSearchKeyword);
        }

        if (!gCheckMore) {
            gPage = 0;
        }

        if ('0' !== requestPage) {
            gPage = requestPage;
            requestPageObject.val("0");
        }

        reqUrl = "/pipeline/<c:out value='${pipelineId}' default='' />/contributorList.do?id=" + searchKeywordObject.val() + "&page=" + gPage + "&sort=" + $("#requestSort").val() + "&size=" + 10000;

        procCallAjax(reqUrl, null, callbackGetContributorList);
    };

    var callbackGetContributorList = function(data){
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        procCallSpinner(SPINNER_STOP);
        var listLength = data.instanceUses.length;

        var contributorCount = listLength;
        document.getElementById('contributorCount').innerHTML = contributorCount;

        //var isLast = data.last;
        var htmlString = [];
        var pipelineId = $("#pipelineIdControlAuthority").val();

        if(0 === listLength){
            htmlString = "<li><dl><dt>조회 된 데이터가 없습니다.</dt><dd></li>";
        } else {
                for (var i = 0; i < listLength; i++) {
                    var instanceUses = data.instanceUses[i];
                    var displayName = '';
                    var authorityId = '';
                    var userId = instanceUses.user.id;
                    var grantedauthorities = instanceUses.grantedAuthorities;
                    for(var j = 0; j < grantedauthorities.length; j++) {
                        var authority = grantedauthorities[j].authority;
                        if(grantedauthorities[j].authCode != null && grantedauthorities[j].authCode == pipelineId){
                            displayName = authority.displayName;
                            authorityId = authority.id;
                        }
                    }

                    var html = "<li><dl><dt>"
                            + "<a href='javascript:void(0);' onclick='moveDetailPage(\""+userId+"\",\""+authorityId+"\",\""+pipelineId+"\");'>"
                            + instanceUses.user.name + " </a></dt><dd><ul>"
                            +"<li class='sbj_txt'>"+"<a href='javascript:void(0);' onclick='moveDetailPage(\""+userId+"\",\""+authorityId+"\",\""+pipelineId+"\");'>" + "</a></li>"
                            +"<li class='stateArea'>"
                            + "<i class='ico_create'></i>생성일 : " + instanceUses.user.createdString
                            + "<span class='pr10'></span> <i class='ico_modify'></i>수정일 : " + instanceUses.user.lastModifiedString
                            + "</li></ul></dd>"
                            + "<dd class='icon_wrap'><ul class='ico_lst'>" + "<li class='ico_area'>";

                    if(displayName == '생성권한'){
                        html += "<img src='/resources/images/process_ico_admin.png' alt='생성권한 이미지' border='0'>"
                    }

                    if(displayName == '보기권한'){
                        html += "<img src='/resources/images/process_ico_contribute.png' alt='보기권한 이미지' border='0'>"
                    }

                    if(displayName == '실행권한'){
                        html += "<img src='/resources/images/process_ico_run.png' alt='실행권한 이미지' border='0'>"
                    }

                    html += "<p class='tit'>"+displayName+"</p></li></dl></li>";

                    htmlString.push(html);
                }

        }

        var listArea = $('#listArea');

        if (gCheckMore) {
            listArea.append(htmlString);
        } else {
            listArea.html(htmlString);
        }
    };

    // BIND
    $("#btnSearch").on("click", function() {
        gCheckMore = false;
        search();
    });

    // SEARCH
    var search = function(){
        var requestSearchKeyword = $("#search_keyword").val();
        var reqUrl = "/pipeline/<c:out value='${pipelineId}' default='' />/contributor";

        if ("" !== requestSearchKeyword) {
            reqUrl += "?id=" + requestSearchKeyword;
        }
        procMovePage(reqUrl);
    };

    $('#btnCreateContributor').on("click", function(){
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "contributor", "create");
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('id').value){
                if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                    procPopupAlert("권한이 없습니다.");
                }else{
                    procMovePage("/pipeline/"+ document.getElementById('id').value + "/contributor/create");
                }
            }
        }*/

    });


    // MOVE PAGE
    var procMovePipelineDetailTabPage = function(reqPage) {
        var reqUrl = "/pipeline/<c:out value='${pipelineId}' default='' />/";
        reqUrl += ('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_DETAIL %>' === reqPage)? "detail" : "contributor";

        procMovePage(reqUrl);
    };

    // MOVE DETAIL PAGE
    var moveDetailPage = function(id , authorityId , pipelineId) {
        procMovePage("/pipeline/"+ pipelineId +"/contributor/update/"+id);
    };

    // GET
    var getPipeline = function() {
        procCallAjax("/pipeline/pipelineDetail.do", {id : "<c:out value='${pipelineId}' default='' />"}, callbackGetPipeline);
    };


    // CALLBACK
    var callbackGetPipeline = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        $('#pipelineName').html(data.name);
    };


    // BIND
    $('#btnUpdatePipeline').on("click", function () {
        procMovePage("/pipeline/update/<c:out value='${pipelineId}' default='' />");
    });

    //BIND
    $('#btnCreatePipeline').on("click", function(){
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "pipeline", "create");
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('id').value){
                if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                    procPopupAlert("권한이 없습니다.");
                }else{
                    procMovePage("/pipeline/create");
                }
            }
        }*/
    });


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


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        //getGrantedAuthorities();
        getContributorList();
        getPipeline();
        getJobListFromDb();
        $('#search_keyword').putCursorAtEnd();
    });


</script>