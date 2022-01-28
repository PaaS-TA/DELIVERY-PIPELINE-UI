<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 5/16/2017
  Time: 11:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- 이동경로 :s -->
    <div class="location">
        <div class="location_inner">
            <ul>
                <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">Home</a></li>
                <li><a href="javascript:void(0);" onclick="procMovePage('/user/dashboard');" class="userList">Users</a></li>
                <li><b>User invitation</b></li>
            </ul>
        </div>
    </div>
    <!--//이동경로 :e -->

    <!-- container :s -->
    <div id="container">
        <!-- content :s -->
        <div class="contents">
            <!-- 타이틀 :s -->
            <h3 class="sub_title">User invitation</h3>
            <!--//타이틀 :e -->
            <!-- sub content :s -->
            <div class="sub_content">
                <form action="#" method="post">
                    <!-- form (contBox) -->
                    <div class="contBox">
                        <!-- 사용자 초대 -->
                        <div class="form_info">
                            <!--타이틀 영역-->
                            <div class="form_left">
                                <p class="title">User invitation</p>
                            </div>
                            <!--//타이틀 영역-->
                            <!--form 영역-->
                            <div class="form_right">
                                <div class="formBox">
                                    <input class="input-medium" id="memberSearch" name="memberSearch" type="text" placeholder="Search for Portal User ID">
                                </div>
                                <div class="formBox hidden"><!-- 검색 시 나타남-->
                                    <select class="input-medium">
                                        <option value="1">test</option>
                                        <option value="2">test123</option>
                                        <option value="3">hitest</option>
                                    </select>
                                </div>
                            </div>
                            <!--//form 영역-->
                        </div>
                        <!--//사용자 초대 -->
                        <!-- 공통영역(권한) -->
                        <div class="commonArea">
                            <div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">Authority</p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox">
                                        <label><input type="radio" name="radio1" id="radio1" value="option1" checked="checked">User</label>
                                        <label><input type="radio" name="radio1" id="radio1" value="option2">Administrator</label>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>
                            <div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">Description <span class="bold500">(Optional)</span></p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox">
                                        <textarea type="text" style="width:96%;" colos="20" rows="5" onfocus="resize(this)">Where user comments are entered</textarea>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>
                        </div>
                        <!--//공통영역(권한) -->
                        <!-- 버튼 영역 -->
                        <div class="btn_Area plr20">
                            <div class="fr">
                                <button type="button" class="button btn_default" title="Add">add</button>
                                <button type="button" class="button btn_default" title="Cancel">Cancel</button>
                            </div>
                        </div>
                        <!--//버튼 영역-->
                    </div>
                    <!--//form (contBox) -->
                </form>
            </div>
            <!--//sub content :e -->
        </div>
        <!--//content :e -->
    </div>
    <!--//container :e -->

    <!-- footer :s -->
    <div id="footer">
        <div class="footerIn">
            <div class="copy">
                Copyright © 2017 PaaS-TA. All rights reserved.
            </div>
        </div>
    </div>
    <!--//footer :e -->


<br>
User registration page :: USER CREATE PAGE
<br>
<ul>
    <li>ID :: <input type="text" id="userId" title="" value="test-id"></li>
    <li>이름 :: <input type="text" id="name" title="" value="Test name"></li>
    <li>Phone number :: <input type="text" id="tellPhone" title="" value="02-1234-5678"></li>
    <li>Mobile number :: <input type="text" id="cellPhone" title="" value="010-4561-7894"></li>
    <li>Email :: <input type="text" id="email" title="" value="test@test.io"></li>
    <li>Company :: <input type="text" id="company" title="" value="비디"></li>
    </li>
</ul>
<br>
    <button type="button" id="btnCreate"> [ Register ] </button>
<br>
<h1>RESULT</h1>
<div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px;">
</div>

<script type="text/javascript">

    // CREATE USER
    var createUser = function() {
        var reqParam = {
            id: document.getElementById('userId').value,
            name: document.getElementById('name').value,
            tellPhone: document.getElementById('tellPhone').value,
            cellPhone: document.getElementById('cellPhone').value,
            email: document.getElementById('email').value,
            company: document.getElementById('company').value
        };

        procCallAjax("/user/create.do", reqParam, callbackCreateUser);
    };


    // CALLBACK
    var callbackCreateUser = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        $('#resultArea').html("Registration complete <br><br>USER ID :: " + data.id);
    };


    // BIND
    $("#btnCreate").on("click", function() {
        createUser();
    });


    // ON LOAD
    $(document.body).ready(function () {
        //
    });

</script>
