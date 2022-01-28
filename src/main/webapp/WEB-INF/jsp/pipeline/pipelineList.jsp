<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-05-18
  Time: 오후 2:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="details.role" var="role"/>
    <sec:authentication property="details.userid" var="userid"/>
</sec:authorize>
    <!-- 이동경로 :s -->
    <div class="location">
        <div class="location_inner">
            <ul>
                <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">Home</a></li>
                <li>All pipelines</li>
            </ul>
            <c:if test="${role == 'ROLE_ADMIN'}">
                <div class="fr">
                    <button type="button" class="button btn_default" title="Create new" id="btnCreate">신규생성</button>
                </div>
            </c:if>
        </div>
    </div>
    <!--//이동경로 :e -->

    <!-- container :s -->
    <div id="container">
        <!-- content :s -->
        <div class="contents">
            <!-- 검색, 정렬기준 선택 :s -->
            <div class="rSearch_group">
                <div class="sel_group fr">
                    <%--<form id="frm_search" method="post" action="">--%>
                        <div class="keyword_search">
                            <input id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;" placeholder="Pipeline name search" autocomplete="on" onkeypress="if(event.keyCode==13) {gCheckMore = false; search(''); }" value="${listRequest.name}" />
                            <a class="btn_search" href="javascript:void(0);" title="Search" id="btnSearch"></a>
                        </div>
                        <div class="selectbox select1 ml5" style="width:150px;">
                            <div>
                                <strong>Most recent creation date</strong><span class="bul"></span>
                            </div>
                            <ul class="select-list">
                                <li id="name_asc" class="selectSortType">Order by name (ascending)</li>
                                <li id="name_desc" class="selectSortType">Order by name (descending)</li>
                                <li id="lastModified_desc" class="selectSortType">Most recent update order</li>
                                <li id="lastModified_asc" class="selectSortType">Oldest update order</li>
                                <li id="created_desc" class="selectSortType">Most recent creation date</li>
                                <li id="created_asc" class="selectSortType">Oldest creation date</li>
                            </ul>
                        </div>
                    <%--</form>--%>
                </div>
            </div>
            <!--//검색, 정렬기준 선택 :e -->
            <!-- 사용자 목록(이미지없는) :s -->
            <ul class="product_list2" id="listArea">
                <%--<li>--%>
                    <%--<dl>--%>
                        <%--<dt><a href="#">파이프라인 명</a></dt>--%>
                        <%--<dd>--%>
                            <%--<ul>--%>
                                <%--<li class="stateArea"><i class="ico_update"></i>마지막 업데이트 : <a href="#">2017-06-09</a><span class="pr15"></span> <i class="ico_app"></i>생성일 : <a href="#">2017-06-09</a></li>--%>
                            <%--</ul>--%>
                        <%--</dd>--%>
                    <%--</dl>--%>
                <%--</li>--%>
            </ul>
            <!--//사용자 목록(이미지없는) :e -->
        </div>
        <!-- 더보기 버튼 :s -->
        <div class="table_more" id="moreListButtonArea" style="display: none;">
            <div class="btn_more" id="btnMore" style="cursor: pointer;"> More </div>
        </div>
        <!--//더보기 버튼 :e -->
        <!--//content :e -->
    </div>
    <!--//container :e -->

<input type="hidden" id="requestSearchKeyword" name="requestSearchKeyword" value="<c:out value='${name}' default='' />" />
<input type="hidden" id="requestPage" name="requestPage" value="<c:out value='${page}' default='0' />" />
<input type="hidden" id="requestSize" name="requestSize" value="<c:out value='${size}' default='0' />" />
<input type="hidden" id="requestSort" name="requestSort" value="<c:out value='${sort}' default='' />" />
<input type="hidden" id="role" name="role" value="<c:out value='${role}' />" />
<input type="hidden" id="userid" name="userid" value="<c:out value='${userid}' />" />
<input type="hidden" id="id" name="id" value="<c:out value='${id}' />" />

<script type="text/javascript">

    var gPage = 0;
    var gCheckMore = false;
    var grantedAuthorities = [];

    // GET LIST
    var getPipelineList = function() {
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

        reqUrl = "/pipeline/pipelineList.do?name=" + searchKeywordObject.val() + "&page=" + gPage + "&sort=" + $("#requestSort").val();
        reqUrl += ('0' !== requestSize)? "&size=" + requestSize : '';

        procCallAjax(reqUrl, null, callbackGetPipelineList);
    };


    // CALLBACK
    var callbackGetPipelineList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.pipelines.length;

        var isLast = data.last;

        var htmlString = [];

        if (0 === listLength) {
            htmlString = "<li><dl><dt>No data was retrieved.</dt><dd></li>";
        } else {
            for (var i = 0; i < listLength; i++) {
                var html = "<li><dl><dt>";
                if(document.getElementById('role').value != "ROLE_ADMIN"){
                    //html += data.pipelines[i].name;
                    var count = 0;
                    for(var j = 0; j < grantedAuthorities.length; j++){
                            if(grantedAuthorities[j].authCode != null && data.pipelines[i].id == grantedAuthorities[j].authCode) {
                                count++;
                            }
                        }
                        if(count > 0){
                            html += "<a href='javascript:void(0);' onclick='moveDetailPage(\"" + data.pipelines[i].id +  "\");'>" + data.pipelines[i].name + "</a>";
                        }else{
                            html += data.pipelines[i].name;
                        }
                    }else{
                        html += "<a href='javascript:void(0);' onclick='moveDetailPage(\"" + data.pipelines[i].id +  "\");'>" + data.pipelines[i].name + "</a>";
                    }

                html += "</dt><dd><ul><li class='stateArea'>"
                        + "<i class='ico_update'></i>Last update : " + data.pipelines[i].lastModifiedString
                        + "<span class='pr15'></span> <i class='ico_app'></i>Date of creation : " + data.pipelines[i].createdString
                        + "</li></ul></dd></dl></li>";
                htmlString.push(html);
            }
        }

        var moreListButtonArea = $('#moreListButtonArea');

        if (isLast) {
            moreListButtonArea.hide();
        } else {
            moreListButtonArea.show();
        }

        var listArea = $('#listArea');

        if (gCheckMore) {
            listArea.append(htmlString);
        } else {
            listArea.html(htmlString);
        }

//        window.scrollTo(0,document.body.scrollHeight);
    };


    // MOVE DETAIL PAGE
    var moveDetailPage = function(id) {
            procMovePage("/pipeline/" + id + "/detail");
    };


    // BIND
    $("#btnSearch").on("click", function() {
        gCheckMore = false;
        search();
    });


    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });


    // SEARCH
    var search = function(){
        var requestSearchKeyword = $("#search_keyword").val();
        var reqUrl = "/pipeline/dashboard";

        if ("" !== requestSearchKeyword) {
            reqUrl += "?name=" + requestSearchKeyword
        }

        procMovePage(reqUrl);
    };


    // BIND
    $(".selectSortType").on("click", function(){
        var requestSort = $(this).attr('id');
        $("#requestSort").val($(this).attr('id').replace("_", ","));

        gCheckMore = false;
        gPage = 0;
        getPipelineList();
    });


    // BIND
    $("#btnCreate").on("click", function(){
        procMovePage("/pipeline/create");
    });


    // BIND
    $("#btnMore").on("click", function(){
        gCheckMore = true;
        gPage++;
        getPipelineList();
    });


    // GET
    var getContributor = function() {
        procCallAjax("/pipeline/contributorDetail.do", {id : document.getElementById('id').value}, callbackGetContributor);
    };


    var callbackGetContributor = function(data){

        grantedAuthorities = data.grantedAuthorities;
        getPipelineList();
    };


    // GET LIST
    var getUserList = function() {

        var reqUrl;
        reqUrl = "/user/list.do";

        procCallAjax(reqUrl, null, callbackGetUserList);
    };


    // CALLBACK
    var callbackGetUserList = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var listLength = data.instanceUses.length;

        for(var i = 0; i< listLength; i++){
            if(data.instanceUses[i].user.name == document.getElementById('userid').value){
                $('input[name=id]').attr('value', data.instanceUses[i].user.id);
                getContributor();
            }
        }

    };



    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        getUserList();
        $('#search_keyword').putCursorAtEnd();
    });

</script>
