<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2017-06-02
  Time: 오후 3:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
Service Instance registration page :: SERVICE INSTANCE CREATE PAGE
<br>
<ul>
    <li>아이디 :: <input type="text" id="id" title="" value="Service instance ID"></li>
</ul>
<br>
<button type="button" id="btnCreate"> [ Register ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>

<script type="text/javascript">


    // CALLBACK
    var callbackCreateServiceInstance = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        $('#resultArea').html("Registration complete <br><br>SERVICE INSTANCE ID :: " + data.id);
    };

    // CREATE USER
    var createServiceInstance = function() {
        var reqParam = {
            id: document.getElementById('id').value
        };
        procCallAjax("/serviceInstance/serviceInstanceCreate.do", reqParam, callbackCreateServiceInstance);
    };




    // ON LOAD
    $(document.body).ready(function () {
        // BIND
        $("#btnCreate").on("click", function() {
            createServiceInstance();
        });
    });

</script>

