<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 6/12/2017
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- 타이틀 :s -->
        <h3 class="sub_title">Configuration details</h3>
        <!--//타이틀 :e -->
        <!-- sub content :s -->
        <div class="sub_content">
            <form action="#" method="post">
                <!-- form (contBox) -->
                <div class="contBox">
                    <!-- 내작업 -->
                    <div class="form_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">My work</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <input type="text" class="input-medium" id="deployJobName" name="deployJobName" title="" value="Deployment job" maxlength="25" placeholder="작업명">
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                    <!--//내작업 -->
                    <!-- 작업 유형 (Job) -->
                    <div class="form_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">Job type (Job)</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <select class="input-medium jobType" title="" id="deployJobType">
                                    <option value="">Select a job</option>
                                    <c:forEach items="${jobTypeList}" var="item" varStatus="status">
                                        <option value="${item.typeName}">${item.typeValue}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--2뎁스 영역(유형 (type)) -->
                            <p class="sub_title">Type (type)</p>
                            <div class="formBox">
                                <select class="input-medium" title="" id="deployType">
                                    <option value="">Select a type</option>
                                    <c:forEach items="${deployTypeList}" var="item" varStatus="status">
                                        <option value="${item.typeName}">${item.typeValue}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--//2뎁스 영역(유형 (type)) -->
                            <!--2뎁스 영역(Cloud Foundry 정보) -->
                            <p class="sub_title">About Cloud Foundry</p>
                            <div class="formBox">
                                <select class="input-medium" title="" id="cfInfoId">
                                    <option value="">Select Cloud Foundry information</option>
                                    <c:forEach items="${cfInfoList}" var="item" varStatus="status">
                                        <option value="${item.id}">${item.cfName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--//2뎁스 영역(Cloud Foundry 정보) -->
                            <!--2뎁스 영역(조직/공간) -->
                            <p class="sub_title">Organization/Space</p>
                            <div id="cfInfoWelcomeArea">
                                <div class="formBox">
                                    <p class="txt_normal" style="color: #ff4500">If you select About Cloud Foundry, it will be activated.</p>
                                </div>
                            </div>
                            <div id="cfInfoResultArea" style="display: none;">
                                <div class="formBox">
                                    <p class="txt_normal">Organization name: <span id="deployTargetOrgView"></span></p>
                                </div>
                                <div class="formBox">
                                    <select class="input-medium" title="" id="deployTargetSpace">
                                    </select>
                                </div>
                                <div class="formBox">
                                    <input type="text" class="input-medium" id="appName" name="appName" title="" value="" maxlength="25" placeholder="Application name">
                                </div>
                            </div>
                            <!--//2뎁스 영역(조직/공간) -->
                            <!--2뎁스 영역(MANIFEST 사용 여부) -->
                            <p class="sub_title">Whether to use MANIFEST</p>
                            <div class="formBox">
                                <select class="input-medium" title="" id="manifestUseYn">
                                    <option title="" value="<%= Constants.CHECK_YN_Y %>"><%= Constants.CHECK_YN_Y %></option>
                                    <option title="" value="<%= Constants.CHECK_YN_N %>" selected><%= Constants.CHECK_YN_N %></option>
                                </select>
                            </div>
                            <!--//2뎁스 영역(MANIFEST 사용 여부) -->
                            <!--2뎁스 영역(MANIFEST YML) -->
                            <p class="sub_title">MANIFEST.YML</p>
                            <div class="formBox">
                                <textarea class="input-medium" name="manifestScript" id="manifestScript" cols="30" rows="6" title="">---
applications:
- name: %APP_NAME%
  memory: 512M
  buildpack: java_buildpack_offline</textarea>
                            </div>
                            <!--//2뎁스 영역(MANIFEST YML) -->
                        </div>
                        <!--//form 영역-->
                    </div>
                    <!--//작업 유형 (Job) -->
                    <!-- 공통영역(입력 유형) -->
                    <div class="commonArea">
                        <div class="form_info">
                            <!--타이틀 영역-->
                            <div class="form_left">
                                <p class="title">Input type</p>
                            </div>
                            <!--//타이틀 영역-->
                            <!--form 영역-->
                            <div class="form_right">
                                <div class="formBox">
                                    <select class="input-medium" title="" id="buildJobIdForDeployJob">
                                        <option value="">Staging selection</option>
                                        <option value="">NOT READY</option>
                                    </select>
                                </div>
                            </div>
                            <!--//form 영역-->
                        </div>
                    </div>
                    <!--//공통영역(입력 유형) -->
                    <!-- 작업 트리거 (Job Trigger) -->
                    <div class="form_info">
                        <div class="form_right">
                            <!--2뎁스 영역-->
                            <p class="sub_title">Job trigger (Job Trigger)</p>
                            <div class="formBox">
                                <ul>
                                    <c:forEach items="${deployJobTriggerTypeList}" var="item" varStatus="status">
                                        <c:choose>
                                            <c:when test="${0 == status.index}">
                                                <li><input type="radio" name="deployJobTrigger" value="${item.typeName}" checked title="">${item.typeValue}</li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><input type="radio" name="deployJobTrigger" value="${item.typeName}" title="">${item.typeValue}</li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </ul>
                            </div>
                            <!--//2뎁스 영역-->
                        </div>
                    </div>
                    <!--//작업 트리거 (Job Trigger) -->
                    <!-- 버튼 영역 -->
                    <div class="btn_Area plr20">
                        <div class="fr">
                            <button type="button" class="button btn_default btnCreate <%= Constants.JOB_TYPE_DEPLOY %>" title="Save">Save</button>
                            <button type="button" class="button btn_default btnCancel" title="Cancel">Cancel</button>
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
