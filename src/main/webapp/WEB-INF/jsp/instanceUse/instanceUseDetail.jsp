<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-08
  Time: 오전 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
Instance Instance & Use 상세 페이지 :: INSTANCE USE DETAIL PAGE Use detail page :: INSTANCE USE DETAIL PAGE
<br>
<ul>
    <li>ID :: ${id}</li>
    <li>SERVICE INSTANCE ID :: ${serviceInstanceId}</li>
    <li>USER ID :: ${userId}</li>
</ul>
<br>
<button type="button" id="btnDelete"> [ Delete ] </button>

<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>
<input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />" />
<input type="hidden" id="serviceInstanceId" name="serviceInstanceId" value="<c:out value='${serviceInstanceId}' default='' />" />
<input type="hidden" id="userId" name="userId" value="<c:out value='${userId}' default='' />" />

<script type="text/javascript">



    // GET
    var getInstanceUse = function() {
        var reqId = {
            id: document.getElementById('id').value,
            serviceInstancesId : document.getElementById('serviceInstanceId').value,
            userId : document.getElementById('userId').value
        };

        procCallAjax("/instanceUse/instanceUseDetail.do", reqId, callbackGetInstanceUse);
    };


    // CALLBACK
    var callbackGetInstanceUse = function(data) {

    };


    // DELETE
    var deleteInstanceUse = function() {
        var reqId = {
            serviceInstancesId : document.getElementById('serviceInstanceId').value,
            userId : document.getElementById('userId').value
        };

        procCallAjax("/instanceUse/instanceUseDelete.do", reqId, callbackDeleteInstanceUse);
    };


    // CALLBACK
    var callbackDeleteInstanceUse = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        alert("Deleted.");
        procMovePage('<c:url value="/instanceUse/dashboard"/>');
    };


    // BIND
    $("#btnDelete").on("click", function() {
        if(confirm("Are you sure you want to delete?")) deleteInstanceUse();
    });


    // ON LOAD
    $(document.body).ready(function () {
        getInstanceUse();
    });

</script>
