<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 5/15/2017
  Time: 11:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- 이동경로 :s -->
    <div class="location">
        <div class="location_inner">
            <ul>
                <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
                <li><a href="javascript:void(0);" onclick="procMovePage('/user/dashboard');" class="userList">사용자 목록</a></li>
            </ul>
            <%--<div class="fr">
                <button type="button" class="button btn_default" title="사용자 추가" id="btnCreate">사용자 추가</button>
            </div>--%>
        </div>
    </div>
    <!--//이동경로 :e -->

    <!-- container :s -->
    <div id="container">
        <!-- content :s -->
        <div class="contents">
            <!-- 셀렉트(검색, 권한 선택, 사용여부 선택) :s -->
            <div class="rSearch_group">
                <div class="sel_group fr">
                        <div class="keyword_search">
                            <input id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;" placeholder="아이디 검색" autocomplete="on" onkeypress="if(event.keyCode==13) {gCheckMore = false; search(''); }" value="${listRequest.name}" />
                            <a class="btn_search" href="javascript:void(0);" title="검색" id="btnSearch"></a>
                        </div>
                        <div class="selectbox select1 ml5" style="width:95px;">
                            <div>
                                <strong>전체</strong><span class="bul"></span>
                            </div>
                            <ul class="select-list">
                                <li class="authName">전체</li>
                                    <c:forEach items="${authList}" var="auth">
                                        <c:if test="${auth.authType eq 'dashboard'}">
                                            <li value="${auth.id}" class="authName">${auth.displayName}</li>
                                        </c:if>
                                    </c:forEach>
                            </ul>
                        </div>
                </div>
            </div>
            <!--//셀렉트(검색, 권한 선택, 사용여부 선택) :e -->
            <!-- 사용자 목록(이미지없는) :s -->
            <ul class="product_list2" id="listArea">
            </ul>
            <!--//사용자 목록(이미지없는) :e -->
        </div>
        <!-- 더보기 버튼 :s -->
        <div class="table_more" id="moreListButtonArea" style="display: none;">
            <div class="btn_more" id="btnMore" style="cursor: pointer;">more</div>
        </div>
        <div></div>
        <!--//더보기 버튼 :e -->
        <!--//content :e -->
    </div>
    <!--//container :e -->
<input type="hidden" id="serviceInstancesId" name="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />"/>
<input type="hidden" id="requestSearchKeyword" name="requestSearchKeyword" value="<c:out value='${id}' default='' />" />
<input type="hidden" id="requestSort" name="requestSort" value="<c:out value='${sort}' default='' />" />
<input type="hidden" id="requestPage" name="requestPage" value="<c:out value='${page}' default='0' />" />
<input type="hidden" id="requestSize" name="requestSize" value="<c:out value='${size}' default='0' />" />
<input type="hidden" id="authName" name="authName" value="<c:out value='${authName}' default='' />" />
<script type="text/javascript">

    var gPage = 0;
    var gCheckMore = false;

    // GET LIST
    var getUserList = function() {
        var requestSearchKeyword = $("#requestSearchKeyword").val();
        var searchKeywordObject = $("#search_keyword");
        var searchKeyword = searchKeywordObject.val();
        var requestPageObject = $("#requestPage");
        var requestPage = requestPageObject.val();
        var requestSize = $("#requestSize").val();
        var reqUrl;
        var authName = $("#authName").val();


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

        reqUrl = "/user/list.do?id=" + searchKeywordObject.val() + "&authName="+ authName + "&page=" + gPage + "&sort=" + $("#requestSort").val();
        reqUrl += ('0' !== requestSize)? "&size=" + requestSize : '';

        procCallAjax(reqUrl, null, callbackGetUserList);
    };


    // CALLBACK
    var callbackGetUserList = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.instanceUses.length;
        var isLast = data.last;
        var htmlString = [];


        if(0 === listLength){
            htmlString = "<li><dl><dt>조회 된 데이터가 없습니다.</dt><dd></li>";
        } else {
            for (var i = 0; i < listLength; i++) {
                var html = "<li><dl><dt>"
                        + "<a href='javascript:void(0);' onclick='moveDetailPage(\"" + data.instanceUses[i].user.id +  "\");'>"+ data.instanceUses[i].user.name;

                for(var j = 0; j < data.instanceUses[i].grantedAuthorities.length; j++){
                    if(data.instanceUses[i].grantedAuthorities[j].authority.authType == 'dashboard'){
                        html += " (" + data.instanceUses[i].grantedAuthorities[j].authority.displayName + ")";
                    }
                }

                html += " </a></dt><dd><ul><li class='stateArea'>"
                        + "<i class='ico_update'></i>마지막 업데이트 : " + data.instanceUses[i].user.lastModifiedString
                        + "<span class='pr15'></span> <i class='ico_app'></i>생성일 : " + data.instanceUses[i].user.createdString
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
    };


    // MOVE DETAIL PAGE
    var moveDetailPage = function(id) {
        procMovePage("/user/detail/" + id);
    };

    // BIND
    $(".authName").on("click", function(){
        var authName = $(this).attr('value');
        $("#authName").val($(this).attr('value'));

        gCheckMore = false;
        gPage = 0;
        getUserList();
    });

    // BIND
    $("#btnSearch").on("click", function() {
        gCheckMore = false;
        search();
    });

    // SEARCH
    var search = function(){
        var requestSearchKeyword = $("#search_keyword").val();
        var reqUrl = "/user/dashboard";

        if ("" !== requestSearchKeyword) {
            reqUrl += "?id=" + requestSearchKeyword;
        }
        procMovePage(reqUrl);
    };

    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });

    // BIND
    $("#btnMore").on("click", function(){
        gCheckMore = true;
        gPage++;
        getUserList();
    });

    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        getUserList();
        $('#search_keyword').putCursorAtEnd();
    });

</script>
