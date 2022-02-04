<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/12/2017
  Time: 10:26 AM
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
                            <input type="text" class="input-medium" id="testJobName" name="testJobName" title="" value="Test job" maxlength="25" placeholder="작업명">
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
                            <select class="input-medium jobType" title="" id="testJobType">
                                <option value="">Select a job</option>
                                <c:forEach items="${jobTypeList}" var="item" varStatus="status">
                                    <option value="${item.typeName}">${item.typeValue}</option>
                                </c:forEach>
                            </select>
                            <ul>
                                <li><input type="checkbox" id="testJobPostActionYn" value="" title=""> Abort the execution of the connected task if this task fails</li>
                            </ul>
                        </div>
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
                                <select class="input-medium" title="" id="inspectionProfileKey">
                                    <option value="">Select a quality profile</option>
                                </select>
                            </div>
                            <div class="formBox">
                                <select class="input-medium" title="" id="inspectionGateId">
                                    <option value="">Quality gate selection</option>
                                </select>
                            </div>
                            <div class="formBox">
                                <select class="input-medium" title="" id="buildJobIdForTestJob">
                                    <option value="">Staging selection</option>
                                </select>
                            </div>
                        </div>
                        <!--//form 영역-->
                    </div>
                    <div class="form_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">JACOCO plugin script</p>
                        </div>
                        <!--//타이틀 영역-->
                        <!--form 영역-->
                        <div class="form_right">
                            <div class="formBox">
                                <p class="jacocoPluginScript gradle" style="margin: 10px 0;" title="JACOCO PLUGIN SCRIPT FOR GRADLE">GRADLE</p>
                                <textarea id="jacocoPluginScriptGradle" class="input-medium view-off" cols="30" rows="12" title="JACOCO PLUGIN SCRIPT FOR GRADLE" style="display: none;"># Add the following script to your build.gradle file.
apply plugin: 'jacoco'

jacoco {
    toolVersion = "0.7.9+"
}

test {
    jacoco {
        destinationFile = file("$buildDir/jacoco/jacoco-overall.exec")
    }
}</textarea>
                            </div>
                            <div class="formBox">
                                <p class="jacocoPluginScript maven" style="margin: 10px 0;" title="JACOCO PLUGIN SCRIPT FOR MAVEN">MAVEN</p>
                                <textarea id="jacocoPluginScriptMaven" class="input-medium view-off" cols="30" rows="18" title="JACOCO PLUGIN SCRIPT FOR MAVEN" style="display: none;"># Add the following script to your pom.xml file.
<build>
    <plugins>
        <plugin>
            <groupId>org.jacoco</groupId>
            <artifactId>jacoco-maven-plugin</artifactId>
            <version>0.7.9</version>
            <executions>
                <execution>
                    <id>default-prepare-agent</id>
                    <goals>
                        <goal>prepare-agent</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build></textarea>
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
                                <c:forEach items="${testJobTriggerTypeList}" var="item" varStatus="status">
                                    <c:choose>
                                        <c:when test="${0 == status.index}">
                                            <li><input type="radio" name="testJobTrigger" value="${item.typeName}" checked title="">${item.typeValue}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><input type="radio" name="testJobTrigger" value="${item.typeName}" title="">${item.typeValue}</li>
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
                        <button type="button" class="button btn_default btnCreate <%= Constants.JOB_TYPE_TEST %>" title="Save">Save</button>
                        <button type="button" class="button btn_default btnCancel" title="Cancel">Cancel</button>
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
