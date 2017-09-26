<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 5/17/2017
  Time: 11:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
사용자 수정 페이지 :: USER UPDATE PAGE
<br>
<ul>
    <li>ID :: <input type="text" id="userId" title="" value=""></li>
    <li>이름 :: <input type="text" id="name" title="" value=""></li>
    <li>전화번호 :: <input type="text" id="tellPhone" title="" value=""></li>
    <li>휴대폰번호 :: <input type="text" id="cellPhone" title="" value=""></li>
    <li>이메일 :: <input type="text" id="email" title="" value=""></li>
    <li>회사 :: <input type="text" id="company" title="" value=""></li>
    </li>
</ul>
<br>
    <button type="button" id="btnUpdate"> [ 수정 ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>
<input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />" />

<script type="text/javascript">

    // GET
    var getUser = function() {
        procCallAjax("/user/get.do", {id : document.getElementById('id').value}, callbackGetUser);
    };


    // CALLBACK
    var callbackGetUser = function(data) {
        var doc = document;

        doc.getElementById('userId').value = data.id;
        doc.getElementById('name').value = data.name;
        doc.getElementById('tellPhone').value = data.tellPhone;
        doc.getElementById('cellPhone').value = data.cellPhone;
        doc.getElementById('email').value = data.email;
        doc.getElementById('company').value = data.company;
    };


    // UPDATE
    var updateUser = function() {
        var reqParam = {
            id: document.getElementById('id').value,
            name: document.getElementById('name').value,
            tellPhone: document.getElementById('tellPhone').value,
            cellPhone: document.getElementById('cellPhone').value,
            email: document.getElementById('email').value,
            company: document.getElementById('company').value
        };

        procCallAjax("/user/update.do", reqParam, callbackUpdateUser);
    };


    // CALLBACK
    var callbackUpdateUser = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        $('#resultArea').html("수정 되었습니다.");
    };


    // BIND
    $("#btnUpdate").on("click", function() {
        updateUser();
    });


    // ON LOAD
    $(document.body).ready(function () {
        getUser();
    });

</script>
