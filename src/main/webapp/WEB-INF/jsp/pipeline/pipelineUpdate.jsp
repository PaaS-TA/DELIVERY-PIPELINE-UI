<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-05-22
  Time: 오후 1:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이동경로 :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">Home</a></li>
            <li>View/edit pipeline information</li>
        </ul>
    </div>
</div>
<!--//이동경로 :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- 타이틀 :s -->
        <h3 class="sub_title">View/edit pipeline information</h3>
        <!--//타이틀 :e -->
        <!-- sub content :s -->
        <div class="sub_content">
                <!-- form (contBox) -->
                <div class="contBox">
                    <!-- 기본 영역 -->
                    <div class="form_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">Pipeline name (<span class="essential">*Required</span>)</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <input class="input-large97" id="pipelineName" name="pipelineName" type="text" placeholder="Pipeline name" />
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                    <!--//기본 영역 -->
                    <!-- 기본 영역 -->
                    <div class="form_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">Pipeline description <span class="bold500">(Optional)</span></p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <textarea type="text" style="width:96%;" colos="20" rows="10" onfocus="resize(this)" placeholder="Reveal the pipeline description entered" id="description"></textarea>
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                    <!--//기본 영역 -->
                    <!-- 버튼 영역 -->
                    <div class="btn_Area plr20">
                        <div class="fl">
                            <button type="button" class="button btn_default" title="Delete pipeline" id="btnDeletePipeline">파이프라인 삭제</button>
                        </div>
                        <div class="fr">
                            <button type="button" class="button btn_default" title="Save" id="btnUpdatePipeline">Edit</button>
                            <button type="button" class="button btn_default" title="Cancel" id="btnCancelPipeline">Cancel</button>
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

<input type="hidden" id="pipelineIdControlAuthority" name="pipelineIdControlAuthority" value="<c:out value='${id}' default='' />" />

<script type="text/javascript">

    // GET
    var getPipeline = function() {
        procCallAjax("/pipeline/pipelineDetail.do", {id : document.getElementById('pipelineIdControlAuthority').value}, callbackGetPipeline);
    };


    // CALLBACK
    var callbackGetPipeline = function(data) {
        procCallSpinner(SPINNER_STOP);
        var doc = document;
        doc.getElementById('pipelineIdControlAuthority').value= data.id;
        doc.getElementById('pipelineName').value = data.name;
        doc.getElementById('description').value = data.description;
    };


    // UPDATE
    var updatePipeline = function() {
        procCallSpinner(SPINNER_START);
        var reqParam = {
            id : document.getElementById('pipelineIdControlAuthority').value,
            name: document.getElementById('pipelineName').value,
            description : document.getElementById('description').value
        };

        procCallAjax("/pipeline/pipelineUpdate.do", reqParam, callbackUpdatePipeline);
    };


    // CALLBACK
    var callbackUpdatePipeline = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        procPopupAlert('Changed', 'procMovePage(-1);');
    };


    // DELETE
    var deletePipeline = function() {
        procCallSpinner(SPINNER_START);
        procCallAjax("/pipeline/pipelineDelete.do", {id : document.getElementById('pipelineIdControlAuthority').value}, callbackDeleteUser);
    };


    // CALLBACK
    var callbackDeleteUser = function(data) {
        procCallSpinner(SPINNER_STOP);
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        procPopupAlert('Deleted.', 'procMovePage("/pipeline/dashboard");');

    };


    // BIND
    $("#btnDeletePipeline").on("click", function() {
        //pipelineGrantedAuthorities(grAry, document.getElementById('id').value, "delete");
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "pipeline", "delete");
        /*for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('id').value){
                if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                    procPopupAlert("권한이 없습니다.");
                }else{
                    procPopupConfirm('파이프라인 삭제', '삭제 하시겠습니까?', 'deletePipeline();');
                }
            }
        }*/

    });


    // BIND
    $("#btnUpdatePipeline").on("click", function() {
        getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "pipeline", "update");
        /*alert("짜라자라잔~~~" + JSON.stringify(grAry));
        for(var i = 0; i < grAry.length; i++){
            if(grAry[i].authCode == document.getElementById('id').value){
                if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                    procPopupAlert("권한이 없습니다.");
                }else{
                    procPopupConfirm('파이프라인 수정', '수정 하시겠습니까?', 'updatePipeline();');
                }
            }
        }*/

    });


    // BIND
    $("#btnCancelPipeline").on("click", function() {
        procMovePage(-1);
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        //getGrantedAuthorities(document.getElementById('id').value);
        getPipeline();
    });

</script>
