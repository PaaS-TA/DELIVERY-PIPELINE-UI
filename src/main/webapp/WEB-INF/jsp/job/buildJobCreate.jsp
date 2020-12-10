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
        <h3 class="sub_title">구성상세</h3>
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
                        <p class="title">내 작업</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="buildJobName" name="buildJobName" title="" value="빌드 job" maxlength="25" placeholder="작업명">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//내작업 -->
                <!-- 작업 유형 (Job) -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">작업 유형 (Job)</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <select class="input-medium jobType" title="" id="buildJobType">
                                <option value="">작업 선택</option>
                                <c:forEach items="${jobTypeList}" var="item" varStatus="status">
                                    <option value="${item.typeName}">${item.typeValue}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <!--2뎁스 영역-->
                        <p class="sub_title">빌더유형 (type)</p>
                        <div class="formBox">
                            <select class="input-medium" title="" id="builderType">
                                <option value="">빌더 선택</option>
                                <c:forEach items="${builderTypeList}" var="item" varStatus="status">
                                    <option value="${item.typeName}">${item.typeValue}</option>
                                </c:forEach>
                            </select>
                            <p class="txt_help"><input type="checkbox" id="buildJobPostActionYn" value="" title=""> 이 작업에 실패하는 경우 연결 작업 실행 중단</p>
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
                            <p class="title">입력 유형</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <select class="input-medium" title="" id="repositoryType">
                                    <option value="">입력유형 선택</option>
                                    <c:forEach items="${repositoryTypeList}" var="item" varStatus="status">
                                        <option value="${item.typeName}">${item.typeValue}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!--2뎁스 영역-->
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryAccountId" name="repositoryAccountId" title="" value="" maxlength="25" placeholder="아이디 입력">
                            </div>
                            <div class="formBox">
                                <input type="password" class="input-medium" id="repositoryAccountPassword" name="repositoryAccountPassword" title="" value="" maxlength="150" placeholder="비밀번호 ( Github의 경우 token 입력)">&emsp;
                                <label id="githubTokenGuide" style="display: none;"><a href="https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token" target="_blank" title="Creating a personal access token">※ Github Access Token 생성 가이드</a></label>
                            </div>
                            <div class="formBox">
                                <input type="text" class="input-medium" id="repositoryUrl" name="repositoryUrl" title="" value="" maxlength="200" placeholder="레파지토리 경로 입력">
                            </div>
                            <!--//2뎁스 영역-->
                            <!--버튼 영역-->
                            <div class="btn_Area plr20" id="btnGetBranchListWrapper">
                                <div class="fr">
                                    <button type="button" class="button btn_regist" title="조회" id="btnGetBranchList">조회</button>
                                </div>
                            </div>
                            <!--//버튼 영역-->
                            <!-- 브랜치 (Branch) -->
                            <div id="repositoryBranchWrapper" style="display: none;">
                                <p class="sub_title">브랜치 (Branch)</p>
                                <div class="formBox">
                                    <select class="input-medium" title="" id="repositoryBranch">
                                        <option value="">브랜치 목록</option>
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
                        <p class="sub_title">작업 트리거 (Job Trigger)</p>
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
                        <button type="button" class="button btn_default btnCreate <%= Constants.JOB_TYPE_BUILD %>" title="저장">저장</button>
                        <button type="button" class="button btn_default btnCancel" title="취소">취소</button>
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
