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
            <li>Cloud Foundry 정보관리</li>
        </ul>
    </div>
</div>
<!--//이동경로 :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- 타이틀 :s -->
        <h3 class="sub_title">계정 상세</h3>
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
                    <div class="fl">
                        <button type="button" class="button btn_default" title="삭제" id="btnDelete">삭제</button>
                    </div>
                    <div class="fr">
                        <button type="button" class="button btn_default" title="수정" id="btnUpdate">수정</button>
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


<input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />">
<input type="hidden" id="originalCfName" name="originalCfName" value="<c:out value='${id}' default='' />">
<input type="hidden" id="created" name="created" value="" />


<script type="text/javascript">


    // GET
    var getCfInfo = function() {
        procCallAjax("/cf-info/get.do?id=" + document.getElementById('id').value, null, callbackGetCfInfo);
    };


    // CALLBACK
    var callbackGetCfInfo = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        $('#cfName').val(data.cfName);
        $('#cfId').val(data.cfId);
        $('#cfPassword').val(data.cfPassword);
        $('#cfApiUrl').val(data.cfApiUrl);
        $('#description').val(data.description);
        $('#created').val(data.created);

        $('#originalCfName').val(data.cfName);

        procCallSpinner(SPINNER_STOP);
    };


    // DELETE
    var deleteCfInfo = function() {
        procCallAjax("/cf-info/delete.do", {id : document.getElementById('id').value}, callbackDeleteCfInfo);
    };


    // CALLBACK
    var callbackDeleteCfInfo = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        procPopupAlert('삭제 되었습니다.', 'procMovePage("/cf-info");');
    };


    // CREATE
    var checkCfName = function() {
        var cfName = $('#cfName').val();

        // CHECK CF NAME
        if (procIsNullString(cfName)) {
            procPopupAlert("계정명을 입력하십시오.", "$('#cfName').focus();");
            return false;
        }

        // CHECK ORIGINAL CF NAME
        if ($('#originalCfName').val() === cfName) {
            updateCfInfo();
        } else {
            procCallAjax("/cf-info/get.do?serviceInstancesId=<c:out value='${serviceInstancesId}' default='' />&cfName=" + cfName, null, callbackCheckCfName);
        }
    };


    // CALLBACK
    var callbackCheckCfName = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procPopupAlert("이미 등록 된 계정명입니다.", "$('#cfName').putCursorAtEnd();");
            return false;
        }

        updateCfInfo();
    };


    // UPDATE
    var updateCfInfo = function() {
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
            id: doc.getElementById('id').value,
            serviceInstancesId: "<c:out value='${serviceInstancesId}' default='' />",
            cfName: doc.getElementById('cfName').value,
            cfId: cfId,
            cfPassword: cfPassword,
            cfApiUrl: cfApiUrl,
            description: doc.getElementById('description').value
        };

        procCallAjax("/cf-info/update.do", reqParam, callbackCreateCfInfo);
    };


    // CALLBACK
    var callbackCreateCfInfo = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        procPopupAlert('저장 되었습니다.', 'procMovePage("/cf-info");');
    };


    // BIND
    $("#btnDelete").on("click", function() {
        procPopupConfirm('Cloud Foundry 정보 삭제', '삭제 하시겠습니까?', 'deleteCfInfo();');
    });


    // BIND
    $("#btnUpdate").on("click", function() {
        procPopupConfirm('Cloud Foundry 정보 수정', '수정 하시겠습니까?', 'checkCfName();');
    });


    // BIND
    $("#btnCancel").on("click", function() {
        procMovePage(-1);
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);

        getCfInfo();
        $('#cfName').putCursorAtEnd();
    });

</script>
