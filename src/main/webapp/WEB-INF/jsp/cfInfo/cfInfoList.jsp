<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/25/2017
  Time: 1:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이동경로 :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">Home</a></li>
            <li>Cloud Foundry Information management</li>
        </ul>
        <div class="fr">
            <button type="button" class="button btn_default" title="Cloud Foundry Account registration" id="btnCreate">Cloud Foundry Account</button>
        </div>
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
                <div class="keyword_search">
                    <input id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;" placeholder="Account Name Search" autocomplete="on" onkeypress="if(event.keyCode==13) {gCheckMore = false; search(''); }" value="<c:out value='${cfName}' default='' />"/>
                    <a class="btn_search" href="javascript:void(0);" title="Search" id="btnSearch"></a>
                </div>
            </div>
        </div>
        <!--//검색, 정렬기준 선택 :e -->
        <!-- 사용자 목록(이미지없는) :s -->
        <ul class="product_list2" id="listArea">
        </ul>
        <!--//사용자 목록(이미지없는) :e -->
        <!-- 더보기 버튼 :s -->
        <div class="table_more" id="moreListButtonArea" style="display: none;">
            <div class="btn_more" id="btnMore" style="cursor: pointer;"> More </div>
        </div>
        <!--//더보기 버튼 :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->


<input type="hidden" id="requestSearchKeyword" name="requestSearchKeyword" value="<c:out value='${cfId}' default='' />" />
<input type="hidden" id="requestPage" name="requestPage" value="<c:out value='${page}' default='0' />" />
<input type="hidden" id="requestSize" name="requestSize" value="<c:out value='${size}' default='0' />" />
<input type="hidden" id="requestSort" name="requestSort" value="<c:out value='${sort}' default='' />" />


<script type="text/javascript">

    var gPage = 0;
    var gCheckMore = false;


    // GET
    var getListFromDb = function() {
        var requestSearchKeyword = $("#requestSearchKeyword").val(),
            searchKeywordObject = $("#search_keyword"),
            searchKeyword = searchKeywordObject.val(),
            requestPageObject = $("#requestPage"),
            requestPage = requestPageObject.val(),
            requestSize = $("#requestSize").val(),
            reqUrl;

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

        reqUrl = "/cf-info/list.do?cfName=" + searchKeywordObject.val() + "&page=" + gPage + "&sort=" + $("#requestSort").val();
        reqUrl += ('0' !== requestSize)? "&size=" + requestSize : '';

        procCallAjax(reqUrl, null, callbackGetListFromDb);
    };


    // CALLBACK
    var callbackGetListFromDb = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        var isLast = data.last,
            cfInfoList = data.cfInfos,
            listLength = cfInfoList.length,
            moreListButtonArea = $('#moreListButtonArea'),
            listArea = $('#listArea'),
            htmlString = [];

        if (0 === listLength) {
            htmlString = "<li><dl><dt>No data was retrieved.</dt><dd></li>";
        } else {
            for (var i = 0; i < listLength; i++) {
                htmlString.push('<li><dl><dt>' +
                    '<a href="javascript:void(0);" onclick="moveDetailPage(\'' + cfInfoList[i].id + '\');">' + cfInfoList[i].cfName +
                    ' (' + cfInfoList[i].cfApiUrl + ')' +
                    '</a>' +
                    '</dt><dd><ul><li class="stateArea"><i class="ico_app"></i>Date of addition : ' + cfInfoList[i].createdString +
                    '<span class="pr15"></span><i class="ico_modify"></i>Date of modification : ' + cfInfoList[i].lastModifiedString +
                    '</li></ul></dd></dl></li>');
            }
        }

        // CHECK LAST OF LIST
        if (isLast) {
            moreListButtonArea.hide();
        } else {
            moreListButtonArea.show();
        }

        // CHECK LIST MORE
        if (gCheckMore) {
            listArea.append(htmlString);
        } else {
            listArea.html(htmlString);
        }

        procCallSpinner(SPINNER_STOP);
    };


    // MOVE DETAIL PAGE
    var moveDetailPage = function(id) {
        procMovePage("/cf-info/" + id);
    };


    // SEARCH
    var search = function(){
        var requestSearchKeyword = $("#search_keyword").val(),
            reqUrl = "/cf-info";

        if ("" !== requestSearchKeyword) {
            reqUrl += "?cfName=" + requestSearchKeyword
        }

        procMovePage(reqUrl);
    };


    // BIND
    $("#btnSearch").on("click", function() {
        gCheckMore = false;
        search();
    });


    // BIND
    $("#btnCreate").on("click", function(){
        procMovePage("/cf-info/create");
    });


    // BIND
    $("#btnMore").on("click", function(){
        gCheckMore = true;
        gPage++;
        getListFromDb();
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);

        getListFromDb();
        $("#search_keyword").putCursorAtEnd();
    });

</script>
