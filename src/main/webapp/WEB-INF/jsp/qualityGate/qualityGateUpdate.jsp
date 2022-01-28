<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2017-06-30
  Time: 오전 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<br>
QUALITY GATE UPDATE PAGE :: QUALITY GATE UPDATE PAGE
<br>
<ul>
    <li>ID :: <span id="qualityGateId">${id}</span></li>
    <li>NAME :: <input type="text" id="name" title="" value=""></li>
    <li>ORG NAME :: <span id="orgName">${list.orgName}</span></li>
    <li>ORG ID :: <span id="orgGuid">${list.orgGuid}</span></li>
    <li>USER NAME :: <span id="userName">${list.userName}</span></li>
    <li>USER ID :: <span id="userGuid">${list.userGuid}</span></li>
</ul>
<br>
<button type="button" id="btnUpdate"> [ Change ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>
<input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />" />

<script type="text/javascript">

    // GET
    var getQualityGate = function() {
        procCallAjax("/qualityGate/qualityGateDetail.do", {id : document.getElementById('id').value}, callbackGetQualityGate);
    };


    // CALLBACK
    var callbackGetQualityGate = function(data) {
        var doc = document;
        doc.getElementById('name').value = data.name;
    };


    // UPDATE
    var updateQualityGate = function() {
        var reqParam = {
            id: document.getElementById('qualityGateId').innerHTML,
            name: document.getElementById('name').value,
            orgName: document.getElementById('orgName').innerHTML,
            orgGuid: document.getElementById('orgGuid').innerHTML,
            userName: document.getElementById('userName').innerHTML,
            userGuid: document.getElementById('userGuid').innerHTML
        };

        procCallAjax("/qualityGate/qualityGateUpdate.do", reqParam, callbackUpdateQualityGate);
    };


    // CALLBACK
    var callbackUpdateQualityGate = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        $('#resultArea').html("Changed");
    };


    // BIND
    $("#btnUpdate").on("click", function() {
        updateQualityGate();
    });


    // ON LOAD
    $(document.body).ready(function () {
        getQualityGate();
    });

</script>
