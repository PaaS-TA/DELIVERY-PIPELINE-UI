<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-29
  Time: 오후 5:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
    .sub_tab_cont00 {
        height: 200px;
    }
    .sub_tab_cont01 {
        height: 200px;
    }
    .sub_tab_cont02 {
        height: 200px;
    }
    .right {
        position: absolute;
        right: 10px;
    }
    .button.tbl_in_btn_lg_red, .btnTag.tbl_in_btn_lg_red {font-weight:normal!important;color:#fff;background: #f84822;border:1px solid #f84c14;height:32px;line-height:12px;padding:2px 12px 2px 12px;}/*tbl 기본버튼 */
    .button.tbl_in_btn_lg_red:hover, .btnTag.tbl_in_btn_lg_red:hover {color:#fff;background:#373c45;border:1px solid #373c45;}
</style>

<div class="location">
    <div class="location_inner">
        <ul>
            <li><a href="javascript:void(0);" onclick="procMovePage('/');" class="home">Home</a></li>
            <li>Quality gate</li>
        </ul>
        <div>
            <ul class="right">
                <button type="button" class="button btn_default" id="craetePopBtn">Create</button>
            </ul>
        </div>
    </div>

</div>


<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="">
        <!-- full_sub_content :s -->
        <div class="">
            <!-- left :s -->
            <div class="lnbWrap">
                <div class="lnb">
                    <ul class="mt11" style="bottom: 1px;">
                        <h4>List of quality gates </h4>
                    </ul>
                    <ul id="qualityGateName">

                    </ul>
                </div>
            </div>
            <!--//left :e -->
            <div class="contentWrap" id="contentGateExp" style="display: block;">
                <div style="padding: 20px; line-height: 2.2em;">
                    <p> A quality gate is a collection of simple Boolean thresholds set in a project measure. </p>
                    <p> The project must pass each threshold to pass the quality gate as a whole. </p>
                    <p> You can set a default quality gate that applies to all projects that are not explicitly assigned to another gate. </p>
                </div>
            </div>
            <!-- contentWrap :s -->
            <div class="contentWrap" id="contentGate" style="display:none;">
                <div class="content_in">
                    <!-- sub 타이틀 영역 :s -->
                    <div class="col-md-7 fl">
                        <h3 class="proj_tit" id="gateName"></h3>
                    </div>
                    <div class="fr mb10">
                        <%--<button type="button" class="button btn_default" id="defaultSetting">기본으로 설정</button>--%>
                        <button type="button" class="button btn_default" id="copyPopBtn">Duplicate</button>

                        <button type="button" id="updatePopBtn" class="button btn_default">Change</button>

                        <button type="button" class="button btn_default" id="deleteGateBtn">Delete</button>
                    </div>
                    <!--//sub 타이틀 영역 :e -->
                    <!-- 조건 영역 :s -->
                    <h3 class="sub_title">Condition</h3>

                    <div id="addSelect">
                        <select class="selectbox select1" onchange="addCondition()" id="addCondition">
                            <option value="add">Add condition</option>
                        </select>
                    </div>
                    <!-- 리스트 테이블 :s -->
                    <table summary="This is a table of condition lists such as condition, warning level, error level, and saving/modifying criteria." class="BasicTable">
                        <caption>
                            Condition list table
                        </caption>
                        <colgroup>
                            <col style="width: 40%"/>
                            <col style="width: 15%"/>
                            <col style="width: 15%"/>
                            <col style="width: 15%"/>
                            <col style="width: 15%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">Condition</th>
                            <th scope="col">Warning level</th>
                            <th scope="col">Error level</th>
                            <th scope="col">Criteris</th>
                            <th scope="col">Save/Edit</th>
                        </tr>
                        </thead>
                        <tbody id="gateCondition">

                        </tbody>
                    </table>
                    <!--//리스트 테이블 :e -->
                    <!--//조건 영역 :e -->

                    <!-- 연결된 프로젝트 :s -->
                    <h3 class="sub_title">linked project</h3>
                    <!-- sub_tab :s -->
                    <div class="sub_tab">
                        <ul>
                            <li class="fst active"><a href="#;" onClick="sub_tab(0);">Connected <span class="pl10"></span></a>
                            </li>
                            <li class=""><a href="#;" onClick="sub_tab(1);">Unconnected <span class="pl10"></span></a></li>
                            <li class=""><a href="#;" onClick="sub_tab(2);">All <span class="pl10"></span></a></li>
                        </ul>
                    </div>
                    <!--//sub_tab :e -->
                    <!-- sub탭 콘텐츠01 :s -->
                    <div class="sub_tab_cont00 mts">
                        <div class="tab_content tbl_scroll">
                            <!-- 리스트 테이블 -->
                            <table summary="Linked projects list table." class="BasicTable">
                                <caption>Linked projects list</caption>
                                <colgroup>
                                    <col style="width:3%">
                                    <col style="width: *"/>
                                </colgroup>
                                <thead>
                                </thead>
                                <tbody id="projectLinked">

                                </tbody>
                            </table>
                            <!--//리스트 테이블-->
                        </div>
                    </div>
                    <!--//sub탭 콘텐츠01 :e -->
                    <!-- sub탭 콘텐츠02 :s -->
                    <div class="sub_tab_cont01 mTs" style="display:none;">
                        <div class="tab_content tbl_scroll">
                            <!-- 리스트 테이블 -->
                            <table summary="This is the unconnected projects list table." class="BasicTable">
                                <caption>Unconnected projects list</caption>
                                <colgroup>
                                    <col style="width:3%">
                                    <col style="width: 97%"/>
                                </colgroup>
                                <thead>
                                </thead>
                                <tbody id="projectFailure">
                                <%--                          <tr>
                                                              <td><input type="checkbox" id="Checkbox1" value="option1"></td>
                                                              <td class="alignL">This is where the project name is revealed. 1</td>
                                                          </tr>
                                                          <tr>
                                                              <td><input type="checkbox" id="Checkbox1" value="option1"></td>
                                                              <td class="alignL">This is where the project name is revealed. 3</td>
                                                          </tr>
                                                          <tr>
                                                              <td><input type="checkbox" id="Checkbox1" value="option1"></td>
                                                              <td class="alignL">This is where the project name is revealed. 5</td>
                                                          </tr>--%>
                                </tbody>
                            </table>
                            <!--//리스트 테이블-->
                        </div>
                    </div>
                    <!--//sub탭 콘텐츠02 :e -->
                    <!-- sub탭 콘텐츠03 :s -->
                    <div class="sub_tab_cont02 mTs" style="display:none;">
                        <div class="tab_content tbl_scroll">
                            <!-- 리스트 테이블 -->
                            <table summary="This is the full project list table." class="BasicTable">
                                <caption>Full project list</caption>
                                <colgroup>
                                    <col style="width:3%">
                                    <col style="width: 97%"/>
                                </colgroup>
                                <thead>
                                </thead>
                                <tbody id="allProject">
                                <%--                                <tr>
                                                                    <td><input type="checkbox" id="Checkbox1" value="option1"></td>
                                                                    <td class="alignL">This is where the project name is revealed. 1</td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="checkbox" id="Checkbox1" value="option1"></td>
                                                                    <td class="alignL">This is where the project name is revealed. 2</td>
                                                                </tr>
                                                                <tr>
                                                                    <td><input type="checkbox" id="Checkbox1" value="option1"></td>
                                                                    <td class="alignL">This is where the project name is revealed. 3</td>
                                                                </tr>--%>
                                </tbody>
                            </table>
                            <!--//리스트 테이블-->
                        </div>
                    </div>
                    <!--//sub탭 콘텐츠03 :e -->
                    <!--//연결된 프로젝트 :e -->
                </div>
            </div>
            <!--//contentWrap :e -->
        </div>
        <!--//full_sub_content :e -->
    </div>
    <!--//content :e -->
</div>


<!-- //복제 팝업창 -->

<div class="modal fade" id="modalGate" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width: 600px;">
        <!-- 콘텐츠 -->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close copyGateClose" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <span class="modal-title">Quality gate clone</span>
            </div>
            <div class="modal-body">
                <!-- form -->
                <div class="modal_contBox">
                    <!-- 기본 영역(품질 프로파일) -->
                    <div class="modalform_info">
                        <!--타이틀 영역-->
                        <div class="form_left">
                            <p class="title">Quality gate</p>
                        </div>
                        <div class="form_right">
                            <div class="formBox">
                                <input id="copyGateText" name="copyGateText" maxlength="50" type="text"
                                       placeholder="Enter the name of the quality gate (required)">
                            </div>
                        </div>
                    </div>
                </div>
                <!--//form -->
            </div>
            <div class="modal-footer">

                <div class="fr" id="frCopyBtn">
                    <button type="button" class="button btn_pop" id="copyGateBtn">Duplicate</button>
                    <button type="button" class="button btn_pop copyGateClose" data-dismiss="modal">Cancel</button>
                </div>

                <div class="fr" id="frCreateBtn">
                    <button type="button" class="button btn_pop" id="createGateBtn">Create</button>
                    <button type="button" class="button btn_pop copyGateClose" data-dismiss="modal">Cancel</button>
                </div>

                <div class="fr" id="frUdtBtn">
                    <button type="button" class="button btn_pop" id="updateGateBtn">Change</button>
                    <button type="button" class="button btn_pop copyGateClose" data-dismiss="modal">Cancel</button>
                </div>

            </div>
        </div>
        <!--//콘텐츠 :e -->
    </div>
</div>

<!--//생성 팝업창-->


<!-- 선택된 퀄리티게이트 key값 -->
<input type="hidden" name="gateId" id="gateId">
<input type="hidden" name="serviceInstancesId" id="serviceInstancesId"
       value="<c:out value='${serviceInstancesId}' default='' />">
<input type="hidden" id="defaultYn">

<script type="text/javascript">
    var doubleSubmitFlag = false;

    //더블클릭 방지
    function doubleSubmitCheck() {

        if (doubleSubmitFlag) {
            return doubleSubmitFlag;
        } else {
            doubleSubmitFlag = true;
            return false;
        }
    }


    //button 이벤트
    $(function () {
        //팝업 닫기 버튼
        $(".copyGateClose").on("click", function () {
//            $('div.modal').modal('hide');
            procClosePopup();
            $("#copyGateText").val("");
        });

        //복제 팝업 활성화 버튼
        $("#copyPopBtn").on("click", function () {
            buttonControll('Duplicate');
        });

        //게이트 복제 버튼
        $("#copyGateBtn").on("click", function () {
            $('#modalGate').modal('hide');
            if ($("#copyGateText").val().trim() == "") {
                procPopupAlert("Enter the name of the quality gate.", "$('#modalGate').modal('show');", "<%= Constants.CHECK_YN_Y %>");
            } else {
                procPopupConfirm('Quality gate duplication', 'Do you want to duplicate?', 'saveCopyGate();');
            }

        });

        //게이트 생성 팝업 활성화
        $("#craetePopBtn").on("click", function () {
            buttonControll('Create');
        });

        //게이트 생성 버튼
        $("#createGateBtn").on("click", function () {
            $('#modalGate').modal('hide');
            if ($("#copyGateText").val().trim() == "") {
                procPopupAlert("Enter the name of the quality gate.", "$('#modalGate').modal('show');", "<%= Constants.CHECK_YN_Y %>");

            } else {
                procPopupConfirm('Create quality gate', 'Do you want to create?', 'createGate()', '', '');
            }


        });

        //게이트 수정 팝업 활성화
        $("#updatePopBtn").on("click", function () {
            buttonControll('Change');
        });

        //게이트 수정 버튼
        $("#updateGateBtn").on("click", function () {
            $('#modalGate').modal('hide');
            if ($("#copyGateText").val().trim() == "") {
                procPopupAlert("Enter the name of the quality gate.", "$('#modalGate').modal('show');", "<%= Constants.CHECK_YN_Y %>");
            } else {
                procPopupConfirm('Edit quality gate', 'Do you want to edit it?', 'updateGate();');
            }


        });
        //게이트 삭제 버튼
        $("#deleteGateBtn").on("click", function () {
            procPopupConfirm('Delete quality gate', 'Are you sure you want to delete?', 'deleteGate();');
        });

        /*
                $("#defaultSetting").click(function(){
                    procPopupConfirm('Quality gate default setting', 'Do you want to set ' + $("#gateName").text()+' as Default?', 'defaultSetting();', 'Setting');
                });
        */

    });


    var defaultSetting = function () {
        var param = {
            id: $("#gateId").val(),
            serviceInstancesId: $("#serviceInstancesId").val()

        }
        procCallAjax("/qualityGate/qualityGateDefaultSetting.do", param, callbackGateDefaultSetting);
    }

    var callbackGateDefaultSetting = function (data) {
        procPopupAlert($("#gateName").text() + 'is set as the default.');
        getList();
        gateActive($("#gateName").text(), $("#gateId").val(), $("#defaultYn").val());
    }


    //팝업 버튼 컨트롤
    var buttonControll = function (name) {
        if (name == "Duplicate") {
            $("#frCopyBtn").show();
            $("#frCreateBtn").hide();
            $("#frUdtBtn").hide();
            $("#copyGateText").val('');
            $(".modal-title").text("Quality gate clone");
        } else if (name == "Create") {
            $("#frCopyBtn").hide();
            $("#frCreateBtn").show();
            $("#frUdtBtn").hide();
            $("#copyGateText").val('');
            $(".modal-title").text("Create quality gates");
        } else if (name == "Change") {
            $("#frCopyBtn").hide();
            $("#frCreateBtn").hide();
            $("#frUdtBtn").show();
            $("#copyGateText").val($("#gateName").text());
            $(".modal-title").text("Edit quality gate");
        }

        $("#modalGate").modal('show');
    }

    //게이트 복제하기
    function saveCopyGate() {
        //연속 클릭 방지
        if (doubleSubmitCheck()) return;

        var param = {
            qualityGateId: $("#gateId").val(),
            qualityGateName: $("#copyGateText").val(),
            serviceInstancesId: $("#serviceInstancesId").val(),
            gateDefaultYn: "N"
        };

        procCallAjax("/qualityGate/qualityGateCopy.do", param, callbackGateCopy);

    }

    //복제 콜백
    var callbackGateCopy = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        $("#copyGateText").val("");
        getList();
        gateActive(data.qualityGateName, data.qualityGateId, data.defaultYn);
        procPopupAlert('The quality gate has been duplicated');
    }


    //게이트 삭제
    function deleteGate() {
        //연속 클릭 방지
        if (doubleSubmitCheck()) return;

        var param = {
            qualityGateId: $("#gateId").val(),
            serviceInstancesId: $("#serviceInstancesId").val()
        };

        procCallAjax("/qualityGate/qualityGateDelete.do", param, callbackGetGateDelete);
    }

    var callbackGetGateDelete = function (data) {

        $("#copyGateText").val("");
        getList();
        $("#contentGateExp").css("display", "block");
        $("#contentGate").css("display", "none");
        procPopupAlert('The quality gate has been removed');
    }


    //게이트 수정
    function updateGate() {
        //연속 클릭 방지
        if (doubleSubmitCheck()) return;
        var param = {
            qualityGateId: $("#gateId").val(),
            qualityGateName: $("#copyGateText").val(),
            serviceInstancesId: $("#serviceInstancesId").val(),
            gateDefaultYn: "N"
        };

        procCallAjax("/qualityGate/qualityGateUpdate.do", param, callbackGetGateUpdate);
    }

    var callbackGetGateUpdate = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        $("#copyGateText").val("");
        getList();
        gateActive(data.qualityGateName, data.qualityGateId, data.defaultYn);
        procPopupAlert('The quality profile has been modified.');
    }


    //새로운 게이트 생성
    function createGate() {
        //연속클릭방지
        if (doubleSubmitCheck()) return;
        var param = {
            qualityGateName: $("#copyGateText").val(),
            serviceInstancesId: $("#serviceInstancesId").val(),
            gateDefaultYn: "N"
        };
        procCallAjax("/qualityGate/qualityGateCreate.do", param, callbackGetGateCreate);
    }

    var callbackGetGateCreate = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        $("#copyGateText").val("");
        getList();
        $("#gateId").val(data.id);
        gateActive(data.qualityGateName, data.qualityGateId, data.defaultYn);
        procPopupAlert('You have created a quality gate.');

    }


    //quality Gate 클릭시 조건 및 프로젝트 리스트 노출
    function gateActive(gatename, gateid, defaultYn) {
        $("#gateName").text(gatename);

        btnActiveYn(gateid, defaultYn);

        procCallSpinner(SPINNER_START);
        //프로젝트리스트
        getProjectList();

        //조건 리스트
        getGateCondition(gateid);
        //도메인 조건 리스트
        getMetricsList();

        //탭 처음으로 이동
        sub_tab(0);
        $("#contentGate").css("display", "block");
        procCallSpinner(SPINNER_STOP);
    }

    function btnActiveYn(gateid, defaultYn) {
        if (defaultYn == "Y") {
            $("#updatePopBtn").hide();
            $("#deleteGateBtn").hide();
        } else {
            $("#updatePopBtn").show();
            $("#deleteGateBtn").show();
        }
        procClosePopup();

        $("#contentGateExp").css("display", "none");
        $("#defaultYn").val(defaultYn);
        $("#gateId").val(gateid);
        doubleSubmitFlag = false;

    }


    function getGateCondition(id) {
        procCallAjax("/qualityGate/qualityGateCondition.do?id=" + id, null, callbackGetGateCondition);
    }


    var callbackGetGateCondition = function (data) {
        $("#gateCondition").html("");

        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        //게이트명
        $("#gateName").text(data.name);

        if (data.conditions != null) {
            //품질 게이트 명

            for (var i = 0; i < data.conditions.length; i++) {
                var list = "";
                var id = data.conditions[i].id;
                var metric = data.conditions[i].metric;
                var name = data.conditions[i].name;
                var warning = data.conditions[i].warning;
                var error = data.conditions[i].error;
                var op = data.conditions[i].op;

                if (undefined == id || null == id || 'null' == id || '' == id)
                    id = "";
                if (undefined == metric || null == metric || 'null' == metric || '' == metric)
                    metric = "";
                if (undefined == name || null == name || 'null' == name || '' == name)
                    name = "";
                if (undefined == warning || null == warning || 'null' == warning || '' == warning)
                    warning = "0";
                if (undefined == error || null == error || 'null' == error || '' == error)
                    error = "0";
                if (undefined == op || null == op || 'null' == op || '' == op)
                    op = "";

                list += "<tr>";
                list += "<td class='alignL' id='conditionsKey_" + (i + 1) + "'>" + name + "</td>";
                list += "<input type='hidden' id='metricsKey_" + (i + 1) + "' value='" + metric + "'>";
                list += "<td>";
                list += "<i class='ico_warn'></i>";
                list += "<input type='text' id='warn_" + (i + 1) + "' name='warn' onkeydown='onlyNumber(this)' onkeyup='textChange(" + (i + 1) + ")' title='' value='" + warning + "' style='width:70%;' placeholder='' maxlength='15'>";
                list += "</td>";
                list += "<td><i class='ico_error'></i> ";
                list += "<input type='text' id='error_" + (i + 1) + "' name='error' onkeydown='onlyNumber(this)' onkeyup='textChange(" + (i + 1) + ")' title='' value='" + error + "' style='width:70%;' placeholder='' maxlength='15'>";
                list += "</td>";
                list += "<td>";
                list += "<select class='input-medium'  onchange='textChange(" + (i + 1) + ")' name='conditionSelect' id='conditionSelect_" + (i + 1) + "'>";
                if (op == "GT") {
                    list += "<option value='GT' selected='selected'>More than</option>";
                } else {
                    list += "<option value='GT'>More than</option>";
                }

                if (op == "LT") {
                    list += "<option value='LT' selected='selected'>Below</option>";
                } else {
                    list += "<option value='LT'>Below</option>";
                }

                if (op == "EQ") {
                    list += "<option value='EQ' selected='selected'>Equal</option>";
                } else {
                    list += "<option value='EQ'>Equal</option>";
                }

                if (op == "NE") {
                    list += "<option value='NE' selected='selected'>Not Equal</option>";
                } else {
                    list += "<option value='NE'>Not Equal</option>";
                }
                list += "</select>";
                list += "</td>";
                list += "<td><button type='button' class='button tbl_in_btn_lg' disabled='disabled' name='saveBtn' id='saveBtn_" + (i + 1) + "' onclick='saveCondition(" + (i + 1) + ")' title='저장'>수정</button> <button type='button' class='button tbl_in_btn_lg_red' name='deleteBtn' id='deleteBtn_" + (i + 1) + "' onclick='deleteCondition(" + (i + 1) + ")' value= '" + id + "' title='Delete' >삭제</button></td>";
                list += "<input type='hidden' id='conditions_" + (i + 1) + "' value='" + id + "' >";
                list += "</tr>";

                $("#gateCondition").append(list);

                if ($("#defaultYn").val() == "Y" && $("#defaultYn").val() != "") {
                    $("#deleteBtn_" + (i + 1)).hide();
                    $("#saveBtn_" + (i + 1)).hide();
                    $("#warn_" + (i + 1)).attr('disabled', 'disabled');
                    $("#error_" + (i + 1)).attr('disabled', 'disabled');
                    $("#conditionSelect_" + (i + 1)).attr('disabled', 'disabled');
                }

            }


        }
    }

    //조건 name 셋팅
    var callbackNameChang = function (data) {
        var trLength = $("#gateCondition tr").length;

        for (var i = 1; i <= trLength; i++) {
            for (var j = 0; j < data[0].metrics.length; j++) {
                if ($("#metricsKey_" + i).val() == data[0].metrics[j].key) {
                    $("#conditionsKey_" + i).text(data[0].metrics[j].name);
                }
            }
        }

    }

    //저장 버튼 활성화
    function textChange(index) {
        $("#saveBtn_" + index).attr("disabled", false);

    }

    // GET LIST
    var getList = function () {
        var serviceInstancesId = $("#serviceInstancesId").val();
        procCallAjax("/qualityGate/qualityGateList.do?serviceInstancesId=" + serviceInstancesId, null, callbackGetList);
    };

    // CALLBACK
    var callbackGetList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        var list = "";
        //리스트 마지막에 defaultKey를 넣어 놨음
        if (data.length != 0) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].gateDefaultYn == "Y") {
                    list += "<li class='pt10'><a href=\"javascript:gateActive(\'" + data[i].name + "','" + data[i].id + "','" + data[i].gateDefaultYn + "')\"><span class='block ico_bul gateStrong'>" + data[i].name + "</span> <span class='issue_num'><span class='word_sort'>Basic</span></span></a></li>";

                } else {
                    list += "<li><a href=\"javascript:gateActive(\'" + data[i].name + "','" + data[i].id + "','" + data[i].gateDefaultYn + "')\"><span class='block ico_bul gateStrong'>" + data[i].name + "</span> </a></li>";
                }
            }
        }

        $("#qualityGateName").html(list);

    }

    var getProjectList = function () {
        var param = {
            serviceInstancesId: $("#serviceInstancesId").val()
        }

        procCallAjax("/qualityGate/projectsList.do", param, callbackGetProjectList);
    }


    var callbackGetProjectList = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;

        //전체 프로첵트 리스트
        var projectList = "";

        //연결된 프로젝트 리스트
        var projectLinkedList = "";

        //미연결된 프로젝트리스트
        var projectFailureList = "";


        var gateId = $("#gateId").val();
        if (data.length != 0) {
            if ($("#defaultYn").val() != "Y") {
                for (var i = 0; i < data.length; i++) {
                    projectList += "<tr>";
                    if (data[i].qualityGateId != gateId) {
                        projectList += "<td><input type='checkbox' name='projectConnection" + data[i].id + "' onclick='projectConnection(" + data[i].id + ",this)' value='" + data[i].projectId + "' ></td>";
                    } else if (data[i].qualityGateId == gateId) {
                        projectList += "<td><input type='checkbox' name='projectConnection" + data[i].id + "' onclick='projectConnection(" + data[i].id + ",this)' value='" + data[i].projectId + "' checked ></td>";
                    }
                    projectList += "<input type='hidden' id='projectKey_" + data[i].id + "'  value='" + data[i].projectKey + "' >";
                    projectList += "<td class='alignL'>" + data[i].projectViewName + "</td>";
                    projectList += "</tr>";

                    ///////////////////


                    if (data[i].qualityGateId == gateId) {
                        projectLinkedList += "<tr>";
                        projectLinkedList += "<td><input type='checkbox' name='projectConnection" + data[i].id + "' onclick='projectConnection(" + data[i].id + ",this)' value='" + data[i].projectId + "' checked ></td>";
                        projectLinkedList += "<td class='alignL'>" + data[i].projectViewName + "</td>";
                        projectLinkedList += "</tr>";
                    }


                    //////////////////////////////////////


                    if (data[i].qualityGateId != gateId) {
                        projectFailureList += "<tr>";
                        projectFailureList += "<td><input type='checkbox' name='projectConnection" + data[i].id + "' onclick='projectConnection(" + data[i].id + ",this)' value='" + data[i].projectId + "' ></td>";
                        projectFailureList += "<td class='alignL' >" + data[i].projectViewName + "</td>";
                        projectFailureList += "</tr>";
                    }

                }

            } else {
                projectList += "<tr><td colspan='2'>It is not possible to select a specific project for the default quality gate.</td></tr>";
                projectLinkedList += "<tr><td  colspan='2'>It is not possible to select a specific project for the default quality gate.</td></tr>";
                projectFailureList += "<tr><td  colspan='2'>It is not possible to select a specific project for the default quality gate.</td></tr>";
            }
        }

        $("#allProject").html(projectList);
        $("#projectLinked").html(projectLinkedList);
        $("#projectFailure").html(projectFailureList);


    }


    //프로젝트 전체에서 체크박스 선택
    function projectConnection(id, chk) {
        var param = {};
        if (chk.checked == true) {
            param = {
                id: id,
                projectId: $("input[name=projectConnection" + id + "]").val(),
                projectKey: $("#projectKey_" + id).val(),
                qualityGateId: $("#gateId").val(),
                linked: "true"
            };
        } else if (chk.checked == false) {
            param = {
                id: id,
                projectId: $("input[name=projectConnection" + id + "]").val(),
                projectKey: $("#projectKey_" + id).val(),
                qualityGateId: $("#gateId").val(),
                linked: "false"
            };
        }
        procCallAjax("/qualityGate/qualityGateProjectLiked.do", param, callbackGetqualityGateProjectLiked);

    }


    var callbackGetqualityGateProjectLiked = function (data) {
        //탭 처음으로 이동
//        sub_tab(0);
        getProjectList();
    }


    //조건 추가하기
    function addCondition() {
        if ($("#defaultYn").val() == "Y") {

            procPopupAlert("The default quality gate cannot add conditions.");
            return false;
        }

        var list = "";

        var name = $("#addCondition option:selected").text();
        var keyValue = $("#addCondition").val();
        var trIndex = $("#gateCondition tr").length;
        if (name != "add") {
            list += "<tr>";
            list += "<td class='alignL'>" + name.trim() + "</td><input type='hidden' id='metricsKey_" + (trIndex + 1) + "' value='" + keyValue + "'>";
            list += "<td><i class='ico_warn'></i> <input type='text'  name='warn' title='' onkeydown='onlyNumber(this)'  value='' style='width:70%;' placeholder=''></td>";
            list += "<td><i class='ico_error'></i> <input type='text'  name='error' title='' onkeydown='onlyNumber(this)'  value='' style='width:70%;' placeholder=''></td>";
            list += "<td>";
            list += "<select class='input-medium' name='conditionSelect'id='conditionSelect_" + (trIndex + 1) + "'>";
            list += "<option value='GT' selected='selected'>More than</option>";
            list += "<option value='LT'>Below</option>";
            list += "<option value='EQ'>Equal</option>";
            list += "<option value='NE'>Not Equal</option>";
            list += "</select>";
            list += "<input type='hidden' id='conditions_" + (trIndex + 1) + "' value='' >";
            list += "</td>";
            list += "<td><button type='button' class='button tbl_in_btn_lg'  name='saveBtn' id='saveBtn_" + (trIndex + 1) + "' onclick='saveCondition(" + (trIndex + 1) + ")' title='저장'>저장</button> <button type='button' class='button tbl_in_btn_lg_red' name='deleteBtn' id='deleteBtn_" + (trIndex + 1) + "' onclick='deleteCondition(" + (trIndex + 1) + ")' title='Delete'>삭제</button></td>";
            list += "</tr>";
        }

        $("#gateCondition").append(list);
        //추가후 다시 조건추가 옵션으로 이동
        $("#addCondition").val("add").attr("selected", "selected");
    }

    //text 숫자만 입력(공통으로 뺐음)
    function onlyNumber(obj) {
        $(obj).keyup(function () {
            $(this).val($(this).val().replace(/[^0-9]/g, ""));
        });
    }


    //조건 저장
    function saveCondition(index) {
        //조건 id
        var condId = $("#conditions_" + index).val();
        var param = {};
        var validation = saveConditionValidation($("#metricsKey_" + index).val());

        if (!validation) {
            return false;
        }

        if (condId != "") {
            param = {
                id: $("#conditions_" + index).val(),
                gateId: $("#gateId").val(),
                metric: $("#metricsKey_" + index).val(),
                error: $("#gateCondition tr").eq(index - 1).find("input[name=error]").val(),
                warning: $("#gateCondition tr").eq(index - 1).find("input[name=warn]").val(),
                op: $("#conditionSelect_" + index).val()
            }
            procCallAjax("/qualityGate/qualityGateCondUpdate.do", param, callbackSetCondId);

        } else if (condId == "") {
            param = {
                index: index,
                gateId: $("#gateId").val(),
                metric: $("#metricsKey_" + index).val(),
                error: $("#gateCondition tr").eq(index - 1).find("input[name=error]").val(),
                warning: $("#gateCondition tr").eq(index - 1).find("input[name=warn]").val(),
                op: $("#conditionSelect_" + index).val()
            }
            procCallAjax("/qualityGate/qualityGateCondSave.do", param, callbackSetCondId);
        }

        $("#saveBtn_" + index).attr("disabled","disabled");
    }

    function saveConditionValidation(metric) {
        var cnt = 0;
        for (var index = 0; index < 100000; index++) {
            if ($("#metricsKey_" + index).val() == metric) {
                cnt++;
            }
        }
        //새로생성된아이도 이값을 가지기 때문에 1개 이상일경우 중복임
        if (cnt > 1) {
            procPopupAlert('There are duplicate conditions.');
            return false;
        }

        return true;
    }

    var callbackSetCondId = function (data) {

        if (RESULT_STATUS_FAIL == data.resultStatus) {return false;}
        $("#conditions_" + data.index).val(data.id);
        $("#saveBtn_" + index).text("Change");
    }

    //삭제, 취소 버튼 이벤트
    function deleteCondition(index) {
        var btn = $("#deleteBtn_" + index).attr("title");
        var indexRemove = index - 1;
        var condId = $("#conditions_" + index).val();
        if (undefined == condId || null == condId || 'null' == condId || '' == condId) {
            $("#gateCondition tr").eq(indexRemove).remove();
        } else if (btn == "Delete") {
            procPopupConfirm('Delete quality gate condition', 'Are you sure you want to delete?', 'delectConditionPop(\'' + index + '\');');
        }


    }

    //조건 삭제
    var delectConditionPop = function (index) {

        var param = {
            serviceInstancesId: $("#serviceInstancesId").val(),
            id: $("#conditions_" + index).val(),
            qualityGateId: $("#gateId").val(),
            qualityGateName: $("#gateName").text()
        };
        procCallAjax("/qualityGate/qualityGateCondDelete.do", param, callbackGetCondDelete);
    }

    var callbackGetCondDelete = function (data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) return false;
        procClosePopup();
        gateActive(data.qualityGateName, data.qualityGateId, $("#defaultYn").val());
    }

    //조건 이름리스트
    //

    var getMetricsList = function () {
        procCallAjax("/qualityGate/metricsList.do", null, callbackMetricsList);
    }

    var callbackMetricsList = function (data) {

        var list = "";
        list += "<option value='add'>Add condition</option>";

        if (data[0].metrics.length != 0) {
            for (var j = 0; j < data[1].domains.length; j++) {
                list += "<option disabled='disabled'>" + data[1].domains[j] + "</option>";
                for (var i = 0; i < data[0].metrics.length; i++) {
                    if (data[0].metrics[i].hidden == false && data[0].metrics[i].direction != 0) {
                        if (data[1].domains[j] == data[0].metrics[i].domain) {
                            if (data[0].metrics[i].hidden == false && (data[0].metrics[i].type == "INT" ||  data[0].metrics[i].type == "FLOAT" ||  data[0].metrics[i].type == "PERCENT")) {
                                list += "<option value='" + data[0].metrics[i].key + "'>&nbsp&nbsp&nbsp" + data[0].metrics[i].name + "</option>";
                            }
                        }
                    }
                }
            }
        }

        $("#addCondition").html(list);
    }

    // ON LOAD
    $(document.body).ready(function () {
        getList();
    });

</script>
