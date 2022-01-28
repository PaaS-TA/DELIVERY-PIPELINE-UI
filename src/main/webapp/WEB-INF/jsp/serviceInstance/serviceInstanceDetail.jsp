<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-07
  Time: 오전 9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
Service Instance detail page :: SERVICE INSTANCE DETAIL PAGE
<br>
<ul>
    <li>ID :: <span id="serviceInstanceId"></span></li>
</ul>
<br>
<button type="button" id="btnDelete"> [ Delete ] </button>
<button type="button" id="btnCreate"> [ Create a pipeline ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>
<input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />" />

<script type="text/javascript">

    // GET
    var getServiceInstance = function() {
        procCallAjax("/serviceInstance/serviceInstanceDetail.do", {id : document.getElementById('id').value}, callbackGetServiceInstance);
    };


    // CALLBACK
    var callbackGetServiceInstance = function(data) {
        var doc = document;

        doc.getElementById('serviceInstanceId').innerHTML= data.id;
    };


    // DELETE
    var deleteServiceInstance = function() {
        procCallAjax("/serviceInstance/serviceInstanceDelete.do", {id : document.getElementById('id').value}, callbackDeleteServiceInstance);
    };


    // CALLBACK
    var callbackDeleteServiceInstance = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        alert("Deleted.");
        procMovePage('<c:url value="/serviceInstance/dashboard"/>');
    };


    // BIND
    $("#btnDelete").on("click", function() {
        if(confirm("Are you sure you want to delete?")) deleteServiceInstance();
    });


    //BIND
    $("#btnCreate").on("click", function(){
       procMovePage('/pipeline/create');
    });

    // ON LOAD
    $(document.body).ready(function () {
        getServiceInstance();
    });

</script>
