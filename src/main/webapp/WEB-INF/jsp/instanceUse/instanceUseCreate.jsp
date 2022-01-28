<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-08
  Time: 오후 5:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
Instance Instance & Use 등록 페이지 :: INSTANCE USE CREATE PAGE Use registration page :: INSTANCE USE CREATE PAGE
<br>
<ul>
    <li>Service Instance ID ::
        <select id="suid" title="">
            <option selected="selected" value="">Select</option>
            <c:forEach items="${serviceInstanceInfo}" var="item">
                <option value="${item.id}">${item.id}</option>
            </c:forEach>
        </select>
    </li>
    <li>User ID ::
        <select id="uuid" title="">
            <option selected="selected" value="">Select</option>
            <c:forEach items="${userInfo}" var="item2">
                <option value="${item2.id}">${item2.id}</option>
            </c:forEach>
        </select>
    </li>
</ul>
<br>
<button type="button" id="btnCreate"> [ Register ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>

<script type="text/javascript">


    // CALLBACK
    var callbackCreateInstanceUse = function(data) {

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        $('#resultArea').html("Registration complete <br><br>SERVICE INSTANCE ID :: " + data.id);
    };

    // CREATE USER
    var createInstanceUse = function() {
        var serviceInstanceId = $('#suid').val();
        var userId = $('#uuid').val();

        var param = {
            serviceInstancesId : serviceInstanceId,
            userId : userId
        };

        procCallAjax("/instanceUse/instanceUseCreate.do", param, callbackCreateInstanceUse);
    };




    // ON LOAD
    $(document.body).ready(function () {
        // BIND
        $("#btnCreate").on("click", function() {
            createInstanceUse();
        });
    });

</script>


