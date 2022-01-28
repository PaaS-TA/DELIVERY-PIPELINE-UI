<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-15
  Time: 오후 2:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
Uploaded file information
<br>
<button type="button" id="btnSearch"> [ Lookup ] </button>
<button type="button" id="btnReset"> [ List initialization ] </button>
<br>
<h1>RESULT</h1>
<br>
List of uploaded file lists
<br>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>

<script type="text/javascript">

    // GET LIST
    var getList = function() {
        procCallAjax("/file/getFileList.do", null, callbackGetList);
    };


    // CALLBACK
    var callbackGetList = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        var listLength = data.length;
        var htmlString = [];

        // STYLE 1
        for (var i = 0; i < listLength; i++) {
            htmlString.push("PIPELINE :: STYLE 1 :: " + data[i].id
                    + " || " + data[i].originalFileName
                    + " || " + data[i].storedFileName
                    + " || " + data[i].fileUrl
                    + " || " + "<a href='javascript:void(0);' onclick='moveDetailPage(\"" + data[i].id +  "\");'> DETAIL </a> "
                    + " || " + "<a href='javascript:void(0);' onclick='procDownload(\"" + data[i].id + "\");'> Download </a> "
                    + "<br><br>");
        }

        htmlString.push("<br>");
        $('#resultArea').html(htmlString);
    };


    // MOVE DETAIL PAGE
    var moveDetailPage = function(id) {
        procMovePage('<c:url value="/file/info/"/>' + id);
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