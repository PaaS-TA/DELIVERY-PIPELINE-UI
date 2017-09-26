<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 5/17/2017
  Time: 11:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <div class="location">
        <div class="location_inner">
            <ul>
                <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
                <li><a href="javascript:void(0);" onclick="procMovePage('/user/dashboard');" class="userList">사용자 목록</a></li>
                <li><b>사용자 상세/수정</b></li>
            </ul>
        </div>
    </div>
    <!--//이동경로 :e -->

    <!-- container :s -->
    <div id="container">
        <!-- content :s -->
        <div class="contents">
            <!-- 타이틀 :s -->
            <h3 class="sub_title">사용자 상세/수정</h3>
            <!--//타이틀 :e -->
            <!-- sub content :s -->
            <div class="sub_content">
                <%--<form action="#" method="post">--%>
                    <!-- form (contBox) -->
                    <div class="contBox">
                        <!-- 기본 영역 -->
                        <div class="form_info">
                            <!--타이틀 영역-->
                            <div class="form_left">
                                <p class="title">사용자 정보</p>
                            </div>
                            <!--//타이틀 영역-->
                            <!--form 영역-->
                            <div class="form_right">
                                <div class="controlbox mt-5">
                                    <dl class="none">아이디 : <span id="userName"></span></dl>
                                </div>
                            </div>
                            <!--//form 영역-->
                        </div>
                        <!--//기본 영역 -->
                        <!-- 공통 영역 -->
                        <div class="commonArea">
                            <div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">사용여부 </p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox" id="authType">
                                        <c:forEach items="${authList}" var="auth">
                                            <c:if test="${auth.authType eq 'dashboard'}">
                                                <label><input type="radio" name="radio" value="${auth.id}" id="radio">${auth.displayName}</label>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>
                            <div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">설명 (선택)</p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox">
                                        <textarea type="text" style="width:96%;" colos="20" rows="5" onfocus="resize(this)" placeholder="아이디는 수정이 불가능합니다." id="description"></textarea>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>
                        </div>
                        <!--//공통 영역 -->
                        <!-- 버튼 영역 -->
                        <div class="btn_Area plr20">
                            <div class="fr">
                                <button type="button" class="button btn_default" title="수정" id="btnUpdate">수정</button>
                                <button type="button" class="button btn_default" title="취소" id="btnCancel">취소</button>
                            </div>
                        </div>
                        <!--//버튼 영역-->
                    </div>
                    <!--//form (contBox) -->
                <%--</form>--%>
            </div>
            <!--//sub content :e -->
        </div>
        <!--//content :e -->
    </div>
    <!--//container :e -->

    <!-- footer :s -->
    <div class="footerIn" id="moreListButtonArea" style="display: none;">
        <div class="copy">
        </div>
    </div>
    <!--//footer :e -->

    <input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />" />
    <input type="hidden" id="serviceInstancesId" name="serviceInstancesId" value="<c:out value='${serviceInstancesId}' default='' />"/>
    <script type="text/javascript">

        // GET
        var getUser = function() {
            procCallAjax("/user/get.do", {id : document.getElementById('id').value}, callbackGetUser);
        };


        // CALLBACK
        var callbackGetUser = function(data) {
            procCallSpinner(SPINNER_STOP);
            var doc = document;


            doc.getElementById('userName').innerHTML = data.user.name;

            var desc = data.user.description;
            if (undefined == desc || null == desc || 'null' == desc || '' == desc)
                desc = '';

            doc.getElementById('description').innerHTML = desc;

            var grantedauthorities = data.grantedAuthorities;
            for(var i = 0; i < grantedauthorities.length; i++) {
                var authority = grantedauthorities[i].authority;
                $('input:radio[name=radio]:input[value=' + authority.id + ']').attr("checked", true);
            }

        };


        // BIND
        $("#btnUpdate").on("click", function() {
            procPopupConfirm('사용자 정보 수정', '수정 하시겠습니까?', 'updateUser();');

        });

        var updateUser = function () {
            procCallSpinner(SPINNER_START);
            var auth = $('input:radio[name="radio"]:checked').val();
            var reqParam = {
                serviceInstancesId : document.getElementById('serviceInstancesId').value,
                userId : document.getElementById('id').value,
                authListStr : auth,
                userDescription : document.getElementById('description').value
            };

            procCallAjax("/user/update.do", reqParam, callbackUpdateUser);
        };


        //CALLBACK
        var callbackUpdateUser = function(data){
            procCallSpinner(SPINNER_STOP);
            if (RESULT_STATUS_FAIL === data.resultStatus) return false;
            procPopupAlert('수정 되었습니다.', 'procMovePage("/user/dashboard");');

        };

        // BIND
        $("#btnCancel").on("click", function() {
            procPopupConfirm('사용자 정보 수정 취소','취소 하시겠습니까?', 'procMovePage(-1);', '확인');
        });


        // ON LOAD
        $(document.body).ready(function () {
            procCallSpinner(SPINNER_START);
            getUser();
        });

    </script>
