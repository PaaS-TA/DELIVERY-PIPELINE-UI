<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-30
  Time: 오전 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
QualityGate 등록 페이지 :: QUALITY GATE CREATE PAGE
<br>
<ul>
    <li>NAME :: <input type="text" id="name" title="" value="test"></li>
    <li>ORG NAME :: <input type="text" id="orgName" title="" value="BD"></li>
    <li>ORG ID :: <input type="text" id="orgGuid" title="" value="12456575"></li>
    <li>USER NAME :: <input type="text" id="userName" title="" value="사용자"></li>
    <li>USER ID :: <input type="text" id="userGuid" title="" value="001"></li>
</ul>
<br>
<button type="button" id="btnCreate"> [ 등록 ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>

<script type="text/javascript">

    // CREATE USER
    var createQualityGate = function() {
        var reqParam = {
            name: document.getElementById('name').value,
            orgName: document.getElementById('orgName').value,
            orgGuid: document.getElementById('orgGuid').value,
            userName: document.getElementById('userName').value,
            userGuid: document.getElementById('userGuid').value
        };

        procCallAjax("/qualityGate/qualityGateCreate.do", reqParam, callbackCreateQualityGate);
    };


    // CALLBACK
    var callbackCreateQualityGate = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        $('#resultArea').html("등록 되었습니다. <br><br>QUALITY GATE ID :: " + data.id);
    };


    // BIND
    $("#btnCreate").on("click", function() {
        createQualityGate();
    });


    // ON LOAD
    $(document.body).ready(function () {
        //
    });

</script>
