<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/5/2017
  Time: 4:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- footer :s -->
<div id="footer">
    <div class="footerIn">
        <div class="copy">
            Copyright © 2017 PaaS-TA. All rights reserved.
        </div>
    </div>
</div>
<!--//footer :e -->
<%--<!-- Top 가기 :s -->--%>
<div class="follow" title="Scroll Back to Top">
    <a href="#" title="top"><img src="<c:url value='/resources/images/a_top.png'/>"></a>
</div>
<!--//Top 가기 :e -->


<%--POPUP CONFIRM :: BEGIN--%>
<div class="modal fade" id="modalConfirm" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &times; </span></button>
                <h1 id="commonPopupConfirmTitle" class="modal-title"> 알림 </h1>
            </div>
            <div class="modal-body">
                <p id="commonPopupConfirmMessage"> MESSAGE </p>
            </div>
            <div class="modal-footer">
                <div class="fr">
                    <button type="button" class="button btn_pop" id="commonPopupConfirmButtonText"> 저장 </button>
                    <button type="button" class="button btn_pop" data-dismiss="modal"> 취소
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--POPUP CONFIRM :: END--%>


<%--POPUP ALERT :: BEGIN--%>
<div class="modal fade" id="modalAlert" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &times; </span></button>
                <h1 class="modal-title"> 알림 </h1>
            </div>
            <div class="modal-body">
                <p id="commonPopupAlertMessage"> MESSAGE </p>
            </div>
            <div class="modal-footer">
                <div class="fr">
                    <button type="button" class="button btn_pop fr" data-dismiss="modal"> 확인 </button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--POPUP ALERT :: END--%>


<%--SPINNER :: BEGIN--%>
<div class="modal fade" id="modalSpinner" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
    <div class="container">
        <div class="row" style="">
            <div class="loader"></div>
        </div>
    </div>
</div>
<%--SPINNER :: END--%>


<!--select 스크립트-->
<script>
    $.fn.selectDesign = function() {
        var t = $(this);
        var div = t.children("div");
        var strong = div.children("strong");
        var ul = t.children("ul");
        var li = ul.children("li");
        var door = false;

        div.click(function() {
            if(door) {
                ul.hide();
            }else{
                ul.show();
            }
            door = !door;
        });

        li.click(function() {
            var txt = $(this).text();
            strong.html(txt);
            div.click();
        });
    };

    $(".select1").selectDesign();
    $(".select2").selectDesign();
    $(".select3").selectDesign();

</script>
<!--//select 스크립트-->