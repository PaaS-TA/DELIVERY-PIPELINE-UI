<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 5/15/2017
  Time: 11:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
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
            <%--<form action="#" method="post">--%>
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
                            <input type="text" class="input-medium" id="buildJobName" name="buildJobName" title="" value="Build job" maxlength="25" placeholder="작업명">
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
                            <select class="input-medium jobType" title="" id="buildJobType">
                                <option value="">Select a job</option>
                                <c:forEach items="${jobTypeList}" var="item" varStatus="status">
                                    <option value="${item.typeName}">${item.typeValue}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <!--2뎁스 영역-->
                        <p class="sub_title">Builder type (type)</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="builderType">
                                <option value="">Select a builder</option>
                                <c:forEach items="${builderTypeList}" var="item" varStatus="status">
                                    <option value="${item.typeName}">${item.typeValue}</option>
                                </c:forEach>
                            </select>
                            <p class="txt_help"><input type="checkbox" id="buildJobPostActionYn" value="" title=""> Abort the execution of the connected task if this task fails</p>
                        </div>
                        <!--//2뎁스 영역-->

                    </div>
                    <!--//form 영역-->
                </div>
                <!--//작업 유형 (Job) -->
                <!-- 공통영역(입력유형) -->
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
                                <select class="input-medium" title="" id="repositoryType">
                                    <option value="">Select input type</option>
                                    <c:forEach items="${repositoryTypeList}" var="item" varStatus="status">
                                        <option value="${item.typeName}">${item.typeValue}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--2뎁스 영역-->
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryAccountId" name="repositoryAccountId" title="" value="" maxlength="25" placeholder="Enter ID">
                            </div>
                            <div class="formBox">
                                <input type="password" class="input-medium" id="repositoryAccountPassword" name="repositoryAccountPassword" title="" value="" maxlength="150" placeholder="Password (In case of Github, enter token)">&emsp;
                                <label id="githubTokenGuide" style="display: none;"><a href="https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token" target="_blank" title="Creating a personal access token">※ Github Access Token Creation Guide</a></label>
                            </div>
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryUrl" name="repositoryUrl" title="" value="" maxlength="200" placeholder="Enter the repository path">
                            </div>
                            <!--//2뎁스 영역-->
                            <!--버튼 영역-->
                            <div class="btn_Area plr20" id="btnGetBranchListWrapper">
                                <div class="fr">
                                    <button type="button" class="button btn_regist" title="Lookup" id="btnGetBranchList">Search</button>
                                </div>
                            </div>
                            <!--//버튼 영역-->
                            <!-- 브랜치 (Branch) -->
                            <div id="repositoryBranchWrapper" style="display: none;">
                                <p class="sub_title">Branch (Branch)</p>
                                <div class="formBox">
                                    <select class="input-medium" title="" id="repositoryBranch">
                                        <option value="">Branches</option>
                                    </select>
                                </div>
                            </div>
                            <!--//브랜치 (Branch) -->
                        </div>
                        <!--//form 영역-->
                    </div>
                </div>
                <!--//공통영역(입력유형) -->
                <!-- 작업 트리거 (Job Trigger) -->
                <div class="form_info">
                    <div class="form_right">
                        <!--2뎁스 영역-->
                        <p class="sub_title">Job trigger (Job Trigger)</p>
                        <div class="formBox">
                            <ul>
                                <c:forEach items="${buildJobTriggerTypeList}" var="item" varStatus="status">
                                    <c:choose>
                                        <c:when test="${0 == status.index}">
                                            <li><input type="radio" name="buildJobTrigger" value="${item.typeName}" checked title="">${item.typeValue}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><input type="radio" name="buildJobTrigger" value="${item.typeName}" title="">${item.typeValue}</li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li><input type="checkbox" id="buildJobNewWorkGroup" value="" title=""><%= Constants.JOB_TRIGGER_NEW_WORK_GROUP_STRING %></li>
                            </ul>
                        </div>
                        <!--//2뎁스 영역-->
                    </div>
                </div>
                <!--//작업 트리거 (Job Trigger) -->
                <!-- 버튼 영역 -->
                <div class="btn_Area plr20">
                    <div class="fr">
                        <button type="button" class="button btn_default btnCreate <%= Constants.JOB_TYPE_BUILD %>" title="Save">Save</button>
                        <button type="button" class="button btn_default btnCancel" title="Cancel">Cancel</button>
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
