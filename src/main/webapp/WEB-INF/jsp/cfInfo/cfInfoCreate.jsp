<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/25/2017
  Time: 1:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이동경로 :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li><a href="javascript:void(0);" onclick="procMovePage('/cf-info');">Cloud Foundry 정보관리</a></li>
            <li>계정 등록</li>
        </ul>
    </div>
</div>
<!--//이동경로 :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- 타이틀 :s -->
        <h3 class="sub_title">계정 등록</h3>
        <!--//타이틀 :e -->
        <!-- sub content :s -->
        <div class="sub_content">
            <!-- form (contBox) -->
            <div class="contBox">
                <!-- Cloud foundry 계정명 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">계정명</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="cfName" name="cfName" title="" value="" maxlength="255" placeholder="계정명 입력">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//Cloud foundry 계정명 -->
                <!-- Cloud foundry 아이디 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">아이디</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="cfId" name="cfId" title="" value="" maxlength="25" placeholder="아이디 입력">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//Cloud foundry 아이디 -->
                <!-- Cloud foundry 비밀번호 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">비밀번호</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="password" class="input-medium" id="cfPassword" name="cfPassword" title="" value="" maxlength="25" placeholder="비밀번호 입력">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//Cloud foundry 비밀번호 -->
                <!-- Cloud foundry API URL -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">URL</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <select class="input-medium" title="" id="cfApiUrl">
                                <option value="">URL 선택</option>
                                <option value="https://api.115.68.46.186.xip.io">https://api.115.68.46.186.xip.io</option>
                            </select>
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//Cloud foundry API URL -->
                <!-- 설명 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">설명 <span class="bold500">(선택)</span></p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <textarea type="text" id="description" name="description" style="width:96%;" cols="20" rows="5" title=""></textarea>
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//설명 -->
                <!-- 버튼 영역 -->
                <div class="btn_Area plr20">
                    <div class="fr">
                        <button type="button" class="button btn_default" title="추가" id="btnCreate">등록</button>
                        <button type="button" class="button btn_default" title="취소" id="btnCancel">취소</button>
                    </div>
                </div>
                <!--//버튼 영역-->
            </div>
            <!--//form (contBox) -->
        </div>
        <!--//sub content :e -->
    </div>
    <!--//content :e -->
</div>
<!--//container :e -->


<script type="text/javascript">

    // CREATE
    var checkCfName = function() {
        var cfName = $('#cfName').val();

        // CHECK CF NAME
        if (procIsNullString(cfName)) {
            procPopupAlert("계정명을 입력하십시오.", "$('#cfName').focus();");
            return false;
        }

        procCallAjax("/cf-info/get.do?serviceInstancesId=<c:out value='${serviceInstancesId}' default='' />&cfName=" + cfName, null, callbackCheckCfName);
    };


    // CALLBACK
    var callbackCheckCfName = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procPopupAlert("이미 등록 된 계정명입니다.", "$('#cfName').putCursorAtEnd();");
            return false;
        }
        procPopupConfirm('계정 등록', '등록 하시겠습니까?', 'createCfInfo();');
    };


    // CREATE
    var createCfInfo = function() {
        procCallSpinner(SPINNER_START);
        var doc = document,
            cfId = $('#cfId').val(),
            cfPassword = $('#cfPassword').val(),
            cfApiUrl = $('#cfApiUrl').val();

        // CHECK CF ID
        if (procIsNullString(cfId)) {
            procPopupAlert("아이디를 입력하십시오.", "$('#cfId').focus();");
            return false;
        }

        // CHECK CF PASSWORD
        if (procIsNullString(cfPassword)) {
            procPopupAlert("비밀번호를 입력하십시오.", "$('#cfPassword').focus();");
            return false;
        }

        // CHECK CF API URL
        if (procIsNullString(cfApiUrl)) {
            procPopupAlert("URL을 입력하십시오.", "$('#cfApiUrl').focus();");
            return false;
        }

        var reqParam = {
            serviceInstancesId: "<c:out value='${serviceInstancesId}' default='' />",
            cfName: doc.getElementById('cfName').value,
            cfId: cfId,
            cfPassword: cfPassword,
            cfApiUrl: cfApiUrl,
            description: doc.getElementById('description').value
        };

        procCallAjax("/cf-info/create.do", reqParam, callbackCreateCfInfo);
    };


    // CALLBACK
    var callbackCreateCfInfo = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        procCallSpinner(SPINNER_STOP);
        procPopupAlert('등록 되었습니다.', 'procMovePage("/cf-info");');
    };


    // BIND
    $("#btnCreate").on("click", function() {
        checkCfName();
    });


    // BIND
    $("#btnCancel").on("click", function() {
        procMovePage(-1);
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        procCallSpinner(SPINNER_STOP);

        $('#cfName').putCursorAtEnd();
    });

</script>
