<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-08
  Time: 오전 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
Instance & Use 대시보드 :: INSTANCE USE DASHBOARD
<br>
<button type="button" id="btnSearch"> [ 조회 ] </button>
<button type="button" id="btnReset"> [ 목록 초기화 ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>

<script type="text/javascript">

    // GET LIST
    var getList = function() {
        procCallAjax("/instanceUse/instanceUseList.do", null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.length;
        var htmlString = [];

        // STYLE 1
        for (var i = 0; i < listLength; i++) {
            htmlString.push("INSTANCE USE :: STYLE 1 :: " + data[i].id
                    + " || " + data[i].serviceInstances.id
                    + " || " + data[i].user.id
                    + " || " + "<a href='javascript:void(0);' onclick='moveDetailPage(\"" + data[i].id + "\",\"" + data[i].serviceInstances.id + "\",\"" + data[i].user.id + "\");'> DETAIL </a> "
                    + "<br><br>");
        }

        htmlString.push("<br><br>");

        $('#resultArea').html(htmlString);
    };


    // MOVE DETAIL PAGE
    var moveDetailPage = function(id1, id2, id3) {
        procMovePage("/instanceUse/detail/"+ id1 + "/" + id2 + "/" + id3);
    };


    // BIND
    $("#btnSearch").on("click", function() {
        getList();
    });


    // BIND
    $("#btnReset").on("click", function() {
        $('#resultArea').html("");
    });


    // ON LOAD
    $(document.body).ready(function () {
        //
    });

</script>
