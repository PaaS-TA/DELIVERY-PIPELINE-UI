<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-30
  Time: 오전 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
QualityGate 상세 페이지 :: QUALITY GATE DETAIL PAGE
<br>
<ul>
    <li>ID :: <span id="qualityGateId"></span></li>
    <li>NAME :: <span id="name"></span></li>
    <li>ORG NAME :: <span id="orgName"></span></li>
    <li>ORG ID :: <span id="orgGuid"></span></li>
    <li>USER NAME :: <span id="userName"></span></li>
    <li>USER ID :: <span id="userGuid"></span></li>
    <li>RELATED ProjectId List :: <span id="projectIdList"></span></li>

</ul>
<br>
<button type="button" id="btnUpdate"> [ 수정 ] </button>
<button type="button" id="btnDelete"> [ 삭제 ] </button>
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
        doc.getElementById('qualityGateId').innerHTML= data.id;
        doc.getElementById('name').innerHTML = data.name;
        doc.getElementById('orgName').innerHTML = data.orgName;
        doc.getElementById('orgGuid').innerHTML = data.orgGuid;
        doc.getElementById('userName').innerHTML = data.userName;
        doc.getElementById('userGuid').innerHTML = data.userGuid;
        doc.getElementById('projectIdList').innerHTML = data.projectIdList;
    };


    // DELETE
    var deleteQualityGate = function() {
        procCallAjax("/qualityGate/qualityGateDelete.do", {id : document.getElementById('id').value}, callbackDeleteQualityGate);
    };


    // CALLBACK
    var callbackDeleteQualityGate = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        alert("삭제 되었습니다.");
        procMovePage('<c:url value="/qualityGate/dashboard"/>');
    };


    // BIND
    $("#btnDelete").on("click", function() {
        if(confirm("삭제 하시겠습니까?")) deleteQualityGate();
    });


    //BIND
    $("#btnUpdate").on("click", function(){
        procMovePage('<c:url value="/qualityGate/update/"/>' + document.getElementById('qualityGateId').innerHTML);
    });

    // ON LOAD
    $(document.body).ready(function () {
        getQualityGate();
    });

</script>
