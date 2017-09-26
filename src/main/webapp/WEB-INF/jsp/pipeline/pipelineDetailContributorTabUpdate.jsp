<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-08-10
  Time: 오후 8:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 이동경로 :s -->
<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">홈으로</a></li>
            <li><span id="pipelineName"></span></li>
        </ul>
        <div class="fr">
            <button type="button" class="button btn_default" title="정보보기/수정" id="btnUpdatePipeline">정보보기/수정</button>
            <button type="button" class="button btn_default" title="신규생성" id="btnCreatePipeline">신규생성</button>
        </div>
    </div>
</div>
<!--//이동경로 :e -->

    <!-- container :s -->
    <div id="container">
        <!-- content :s -->
        <div class="contents">
            <!-- sub_tab :s -->
            <div class="sub_tab">
                <ul>
                    <li class=""><a href="javascript:void(0);" onClick="procMovePipelineDetailTabPage('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_DETAIL %>');"><span class="file_on"></span>파이프라인 <span class="pl10" id="jobCount"></span></a></li><!--아이콘 on 파일네임 파일명_on 붙이면 됨-->
                    <li class="fst active"><a href="javascript:void(0);" onClick="procMovePipelineDetailTabPage('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_CONTRIBUTOR %>');"><span class="contributor"></span>참여자(Contributor) <span class="pl10" id="contributorCount"></span></a></li>
                </ul>
            </div>
            <!--//sub_tab :e -->
            <!-- sub탭 콘텐츠02 :s -->
            <div class="sub_tab_cont01 mTs">
                <div class="tab_content">
                        <!-- form (contBox) -->
                        <div class="contBox">
                            <!-- 공통 영역 -->
                            <div class="commonArea">
                                <div class="form_info">
                                    <!--타이틀 영역-->
                                    <div class="form_left">
                                        <p class="title">참여자 정보</p>
                                    </div>
                                    <!--//타이틀 영역-->
                                    <!--form 영역-->
                                    <div class="form_right">
                                        <!-- 추가된 사용자 정보-->
                                        <div class="controlbox">
                                            <dl class="none">
                                                <dd>아이디 : <span id="userid"></span> </dd>
                                                <%--<dd>이메일 : <span id="email"></span> </dd>--%>
                                            </dl>
                                        </div>
                                        <!--//추가된 사용자 정보-->
                                    </div>
                                    <!--//form 영역-->
                                </div>
                            </div>
                            <!--//공통 영역 -->
                            <!-- 기본 영역 -->
                            <div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">권한</p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox">
                                        <c:forEach items="${authList}" var="auth">
                                            <c:if test="${auth.authType ne 'dashboard'}">
                                                <label><input type="radio" name="radio" value="${auth.id}" id="radio">${auth.displayName}</label>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>
                            <!--//기본 영역 -->
                            <!-- 기본 영역 -->
                            <%--<div class="form_info">
                                <!--타이틀 영역-->
                                <div class="form_left">
                                    <p class="title">설명 (선택)</p>
                                </div>
                                <!--//타이틀 영역-->
                                <!--form 영역-->
                                <div class="form_right">
                                    <div class="formBox">
                                        <textarea type="text" colos="20" rows="5" onfocus="resize(this)" id="description"></textarea>
                                    </div>
                                </div>
                                <!--//form 영역-->
                            </div>--%>
                            <!--//기본 영역 -->
                            <!-- 버튼 영역 -->
                            <div class="btn_Area">
                                <div class="fl">
                                    <button type="button" class="button btn_default" title="참여자 삭제" id="btnDeleteContributor">참여자 삭제</button>
                                </div>
                                <div class="fr">
                                    <button type="button" class="button btn_default" title="수정" id="btnUpdateContributor">수정</button>
                                    <button type="button" class="button btn_default" title="취소" id="cancel">취소</button>
                                </div>
                            </div>
                            <!--//버튼 영역-->
                        </div>
                        <!--//form (contBox) -->
                </div>
            </div>
            <!--//sub탭 콘텐츠02 :e -->
        </div>
        <!--//content :e -->
    </div>
    <!--//container :e -->
    <input type="hidden" id="suid" name="suid" value="<c:out value='${suid}' default='' />"/>
    <input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />"/>
    <input type="hidden" id="pipelineIdControlAuthority" name="pipelineIdControlAuthority" value="<c:out value='${pipelineId}' default='' />"/>

    <script type="text/javascript">

        // GET
        var getContributor = function() {
            procCallAjax("/pipeline/contributorDetail.do", {id : document.getElementById('id').value}, callbackGetContributor);
        };

        var callbackGetContributor = function(data){
            procCallSpinner(SPINNER_STOP);
            var doc = document;
            doc.getElementById('userid').innerHTML = data.user.name;
            //doc.getElementById('email').innerHTML = data.user.email;

            /*var desc = data.user.description
            if (undefined == desc || null == desc || 'null' == desc || '' == desc)
                desc = '';
            doc.getElementById('description').innerHTML = desc;*/

            var grantedAuthorities = data.grantedAuthorities;
            for(var i = 0; i < grantedAuthorities.length; i++) {
               var authority = grantedAuthorities[i].authority;
                if(grantedAuthorities[i].authCode == document.getElementById('pipelineIdControlAuthority').value){
                    $('input:radio[name=radio]:input[value=' + authority.id + ']').attr("checked", true);
                }
            }
        };

        $("#btnUpdateContributor").on("click", function(){
            getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "contributor", "update");
            /*for(var i = 0; i < grAry.length; i++){
                if(grAry[i].authCode == <c:out value='${pipelineId}' default='' />){
                    if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                        procPopupAlert("권한이 없습니다.");
                    }else{
                        procPopupConfirm('참여자 수정', '수정 하시겠습니까?', 'updateContributor();');
                    }
                }
            }*/
        });

        var updateContributor = function(){
            procCallSpinner(SPINNER_START);
            var checkedValue = $("input[type=radio][name=radio]:checked").val();

            var reqParam = {
                authority_id : checkedValue,
                userId : document.getElementById('id').value,
                pipelineId : document.getElementById('pipelineIdControlAuthority').value
            };

            procCallAjax("/pipeline/contributorGrantedAuthorityUpdate.do", reqParam, callbackUpdateContributor);
        };

        // CALLBACK :: UPDATE
        var callbackUpdateContributor = function(data){
            procCallSpinner(SPINNER_STOP);
            procPopupAlert('수정 되었습니다.', 'procMovePage(-1);');
        };

        //BIND
        $("#cancel").on("click", function(){
            procMovePage(-1);
        });

        // BIND
        $('#btnUpdatePipeline').on("click", function () {
            procMovePage("/pipeline/update/<c:out value='${pipelineId}' default='' />");
        });

        //BIND
        $('#btnCreatePipeline').on("click", function(){
            getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value, "pipeline", "create");
            /*for(var i = 0; i < grAry.length; i++){
                if(grAry[i].authCode == <c:out value='${pipelineId}' default='' />){
                    if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                        procPopupAlert("권한이 없습니다.");
                    }else{
                        procMovePage("/pipeline/create");
                    }
                }
            }*/
        });

        //BIND
        $("#btnDeleteContributor").on("click", function () {
            getGrantedAuthorities(document.getElementById('pipelineIdControlAuthority').value,"contributor", "delete");
            /*for(var i = 0; i < grAry.length; i++){
                if(grAry[i].authCode == <c:out value='${pipelineId}' default='' />){
                    if(grAry[i].authority.code == "read" || grAry[i].authority.code == "execute"){
                        procPopupAlert("권한이 없습니다.");
                    }else{
                        procPopupConfirm('참여자 삭제', '삭제 하시겠습니까?', 'deleteContributor();');
                    }
                }
            }*/

        });

        var deleteContributor = function(){
            procCallSpinner(SPINNER_START);
            var reqParam = {
                userId : document.getElementById('id').value,
                pipelineId : document.getElementById('pipelineIdControlAuthority').value
            };
            procCallAjax("/pipeline/contributorGrantedAuthorityDelete.do", reqParam, callbackDeleteContributor);
        };

        var callbackDeleteContributor = function(){
            procCallSpinner(SPINNER_STOP);
            procPopupAlert('삭제 되었습니다.', 'procMovePage(-1);');
        };

        // GET JOB LIST FROM DB
        var getJobListFromDb = function() {
            procCallAjax(JOB_PIPELINE_URL + "/list.do", null, callbackGetJobListFromDb);
        };

        // CALLBACK GET LIST FROM DB
        var callbackGetJobListFromDb = function(data) {
            if (RESULT_STATUS_FAIL === data.resultStatus) return false;

            var listLength = data.length,
                    objJobCount = $('#jobCount');

            objJobCount.html(listLength);

        };

        var getContributorList = function(){
            var reqUrl;
            reqUrl = "/pipeline/<c:out value='${pipelineId}' default='' />/contributorList.do";

            procCallAjax(reqUrl, null, callbackGetContributorList);
        };

        var callbackGetContributorList = function(data){
            var listLength = data.instanceUses.length;

            var contributorCount = listLength;
            document.getElementById('contributorCount').innerHTML = contributorCount;
        };

        // GET
        var getPipeline = function() {
            procCallAjax("/pipeline/pipelineDetail.do", {id : "<c:out value='${pipelineId}' default='' />"}, callbackGetPipeline);
        };

        // CALLBACK
        var callbackGetPipeline = function(data) {
            $('#pipelineName').html(data.name);
        };

        // MOVE PAGE
        var procMovePipelineDetailTabPage = function(reqPage) {
            var reqUrl = "/pipeline/<c:out value='${pipelineId}' default='' />/";
            reqUrl += ('<%= Constants.PIPELINE_DETAIL_TAB_TYPE_DETAIL %>' === reqPage)? "detail" : "contributor";

            procMovePage(reqUrl);
        };

        // ON LOAD
        $(document.body).ready(function () {
            procCallSpinner(SPINNER_START);
            //getGrantedAuthorities();
            getContributor();
            getJobListFromDb();
            getContributorList();
            getPipeline();
        });
    </script>