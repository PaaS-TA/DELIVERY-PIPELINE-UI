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
                <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
                <li><a href="javascript:void(0);" onclick="procMovePage('/user/dashboard');" class="userList">사용자 목록</a></li>
                <li><b>사용자 초대</b></li>
            </ul>
        </div>
    </div>
    <!--//이동경로 :e -->

    <!-- container :s -->
    <div id="container">
        <!-- content :s -->
        <div class="contents">
            <!-- 타이틀 :s -->
            <h3 class="sub_title">사용자 초대</h3>
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
                                <p class="title">사용자 초대</p>
                            </div>
                            <!--//타이틀 영역-->
                            <!--form 영역-->
                            <div class="form_right">
                                <div class="formBox">
                                    <input class="input-medium" id="memberSearch" name="memberSearch" type="text" placeholder="포털 사용자 아이디 검색">
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
                                    <p class="title">권한</p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox">
                                        <label><input type="radio" name="radio1" id="radio1" value="option1" checked="checked">사용자</label>
                                        <label><input type="radio" name="radio1" id="radio1" value="option2">관리자</label>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>
                            <div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">설명 <span class="bold500">(선택)</span></p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox">
                                        <textarea type="text" style="width:96%;" colos="20" rows="5" onfocus="resize(this)">사용자 설명이 입력된 곳</textarea>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>
                        </div>
                        <!--//공통영역(권한) -->
                        <!-- 버튼 영역 -->
                        <div class="btn_Area plr20">
                            <div class="fr">
                                <button type="button" class="button btn_default" title="추가">추가</button>
                                <button type="button" class="button btn_default" title="취소">취소</button>
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
사용자 등록 페이지 :: USER CREATE PAGE
<br>
<ul>
    <li>ID :: <input type="text" id="userId" title="" value="test-id"></li>
    <li>이름 :: <input type="text" id="name" title="" value="테스트 이름"></li>
    <li>전화번호 :: <input type="text" id="tellPhone" title="" value="02-1234-5678"></li>
    <li>휴대폰번호 :: <input type="text" id="cellPhone" title="" value="010-4561-7894"></li>
    <li>이메일 :: <input type="text" id="email" title="" value="test@test.io"></li>
    <li>회사 :: <input type="text" id="company" title="" value="비디"></li>
    </li>
</ul>
<br>
    <button type="button" id="btnCreate"> [ 등록 ] </button>
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
        $('#resultArea').html("등록 되었습니다. <br><br>USER ID :: " + data.id);
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
