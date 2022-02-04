<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/25/2017
  Time: 1:52 PM
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
            <li>Cloud Foundry Information management</li>
        </ul>
    </div>
</div>
<!--//이동경로 :e -->

<!-- container :s -->
<div id="container">
    <!-- content :s -->
    <div class="contents">
        <!-- 타이틀 :s -->
        <h3 class="sub_title">Account Details</h3>
        <!--//타이틀 :e -->
        <!-- sub content :s -->
        <div class="sub_content">
            <!-- form (contBox) -->
            <div class="contBox">
                <!-- Cloud foundry 계정명 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">Account name</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="cfName" name="cfName" title="" value="" maxlength="255" placeholder="Enter account name">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//Cloud foundry 계정명 -->
                <!-- Cloud foundry 아이디 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">ID</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="text" class="input-medium" id="cfId" name="cfId" title="" value="" maxlength="25" placeholder="Enter ID">
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//Cloud foundry 아이디 -->
                <!-- Cloud foundry 비밀번호 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">Password</p>
                    </div>
                    <!--//타이틀 영역-->
                    <!--form 영역-->
                    <div class="form_right">
                        <div class="formBox">
                            <input type="password" class="input-medium" id="cfPassword" name="cfPassword" title="" value="" maxlength="25" placeholder="Enter Password">
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
                            </select>
                            <button type="button" class="button btn_regist" title="URL management" id="btnPopupCfUrl">URL management</button>
                        </div>
                    </div>
                    <!--//form 영역-->
                </div>
                <!--//Cloud foundry API URL -->
                <!-- 설명 -->
                <div class="form_info">
                    <!--타이틀 영역-->
                    <div class="form_left">
                        <p class="title">Description <span class="bold500">(Optional)</span></p>
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
                        <button type="button" class="button btn_default" title="Delete" id="btnDelete">Delete</button>
                    </div>
                    <div class="fr">
                        <button type="button" class="button btn_default" title="Change" id="btnUpdate">Save</button>
                        <button type="button" class="button btn_default" title="Cancel" id="btnCancel">Cancel</button>
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


<%--POPUP CF URL :: BEGIN--%>
<div class="modal fade" id="modalCfUrlList" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width: 840px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"> &times; </span></button>
                <h1 id="popupCfUrlListConfirmTitle" class="modal-title"> URL management </h1>
            </div>
            <div class="modal-body">
                <div class="modal_contBox">
                    <%--LIST :: BEGIN--%>
                    <div id="popupCfUrlListAreaNoData" style="display: none;">
                        <div class="modalform_info" id="custom-cf-url-no-list">
                            <p>No data was retrieved.</p>
                        </div>
                    </div>
                    <div id="popupCfUrlListArea" style="display: none;">
                        <div class="modalform_info" id="custom-cf-url-list">
                            <div id="popupCfUrlListResultArea">
                            </div>
                        </div>
                    </div>
                    <%--LIST :: END--%>
                    <%--CREATE :: BEGIN--%>
                    <div id="popupCfUrlCreateArea" style="display: none;">
                        <div class="modalform_info" id="custom-cf-url-create">
                            <div class="form_left">
                                <p class="title">Cloud Foundry API name</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <input type="text" class="input-large" id="popupCfApiName" name="popupCfApiName" title="" value="" maxlength="100" placeholder="Cloud Foundry API name">
                                </div>
                            </div>
                            <div class="form_left">
                                <p class="title">Cloud Foundry API URL</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <input type="text" class="input-large" id="popupCfApiUrl" name="popupCfApiUrl" title="" value="" maxlength="100" placeholder="Yes) https://api.115.68.46.186.xip.io">
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--CREATE :: END--%>
                    <%--UPDATE :: BEGIN--%>
                    <div id="popupCfUrlUpdateArea" style="display: none;">
                        <div class="modalform_info" id="custom-cf-url-update">
                            <div class="form_left">
                                <p class="title">Cloud Foundry API name</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <input type="text" class="input-large" id="popupCfApiNameUpdate" name="popupCfApiNameUpdate" title="" value="" maxlength="100" placeholder="Cloud Foundry API name">
                                </div>
                            </div>
                            <div class="form_left">
                                <p class="title">Cloud Foundry API URL</p>
                            </div>
                            <div class="form_right">
                                <div class="formBox">
                                    <input type="text" class="input-large" id="popupCfApiUrlUpdate" name="popupCfApiUrlUpdate" title="" value="" maxlength="100" placeholder="Yes) https://api.115.68.46.186.xip.io">
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--UPDATE :: END--%>
                </div>
            </div>
            <div class="modal-footer">
                <div id="popupCfUrlListButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnPopupCfUrlCreate"> URL registration </button>
                        <button type="button" class="button btn_pop" data-dismiss="modal"> Confirm </button>
                    </div>
                </div>
                <div id="popupCfUrlCreateButtonArea" style="display: none;">
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnCfUrlCreate"> Save URL </button>
                        <button type="button" class="button btn_pop btnPopupCfUrlCreateCancel"> Cancel </button>
                    </div>
                </div>
                <div id="popupCfUrlUpdateButtonArea" style="display: none;">
                    <div class="fl">
                        <button type="button" class="button btn_pop" id="btnCfUrlDelete"> Delete URL </button>
                    </div>
                    <div class="fr">
                        <button type="button" class="button btn_pop" id="btnCfUrlUpdate"> Edit URL </button>
                        <button type="button" class="button btn_pop btnPopupCfUrlUpdateCancel"> Cancel </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--POPUP CF URL :: END--%>


<input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />">
<input type="hidden" id="originalCfName" name="originalCfName" value="<c:out value='${id}' default='' />">
<input type="hidden" id="created" name="created" value="" />
<input type="hidden" id="cfUrlDetailId" name="cfUrlDetailId" value="" />
<input type="hidden" id="cfUrlListCount" name="cfUrlListCount" value="0" />


<script type="text/javascript">

    var gRequestGetCfUrlListToPage = 'PAGE';
    var gPopupCfUrlStatusList = 'List';
    var gPopupCfUrlStatusCreate = 'Create';
    var gPopupCfUrlStatusUpdate = 'Update';


    // GET CF URL LIST
    var getCfUrlListFromDb = function(reqStatus) {
        // CHECK LIST RESULT AREA
        if (gRequestGetCfUrlListToPage === reqStatus) {
            // PAGE
            procCallAjax("/cf-urls/list.do", null, callbackGetCfUrlListFromDbToPage);
        } else {
            // POPUP
            procCallAjax("/cf-urls/list.do", null, callbackGetCfUrlListFromDbToPopup);
        }
    };


    // CALLBACK CF URL LIST TO PAGE
    var callbackGetCfUrlListFromDbToPage = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var resultList = data,
            listLength = resultList.length,
            listArea = $('#cfApiUrl'),
            htmlString = [];

        listArea.html('');
        $('#cfUrlListCount').val(listLength);

        if (0 === listLength) {
            htmlString.push('<option value=""> URL registration is required. </option>');
        } else {
            htmlString.push('<option value=""> Select the URL </option>');

            for (var i = 0; i < listLength; i++) {
                htmlString.push('<option value="' + resultList[i].cfApiUrl + '">' + resultList[i].cfApiUrl + '</option>');
            }
        }

        listArea.html(htmlString);
    };


    // CALLBACK CF URL LIST TO POPUP
    var callbackGetCfUrlListFromDbToPopup = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        var resultList = data,
            listLength = resultList.length,
            listArea = $('#popupCfUrlListResultArea'),
            htmlString = [];

        listArea.html('');
        $('#cfUrlListCount').val(listLength);

        if (0 === listLength) {
            $('#popupCfUrlListArea').hide();
            $('#popupCfUrlListAreaNoData').show();
        } else {
            for (var i = 0; i < listLength; i++) {
                htmlString.push('<div class="custom-cf-url-list-item">'
                    + '<div><a href="javascript:void(0);" onclick="getPopupCfUrlDetail(\'' + resultList[i].id + '\');">'
                    + resultList[i].cfApiName
                    + '</a></div>'
                    + '<div><a href="javascript:void(0);" onclick="getPopupCfUrlDetail(\'' + resultList[i].id + '\');">'
                    + resultList[i].cfApiUrl
                    + '</a></div></div>');
            }

            listArea.html(htmlString);

            $('#popupCfUrlListAreaNoData').hide();
            $('#popupCfUrlListArea').show();
        }
    };


    // VALIDATE POPUP CF URL
    var procValidatePopupCfUrl = function(reqStatus) {
        var cfApiNameString = 'popupCfApiName',
            cfApiUrlString = 'popupCfApiUrl',
            reqStatusString = 'Register',
            cfApiName,
            cfApiUrl;

        if (gPopupCfUrlStatusUpdate === reqStatus) {
            cfApiNameString += 'Update';
            cfApiUrlString += 'Update';
            reqStatusString = 'Change';
        }

        cfApiName = $('#' + cfApiNameString).val();
        cfApiUrl = $('#' + cfApiUrlString).val();

        $('#modalCfUrlList').modal('hide');

        // CHECK CF API NAME
        if (procIsNullString(cfApiName)) {
            procPopupAlert("Enter the API name.", "procSetPopupCfUrlFocus('" + reqStatus + "', '" + cfApiNameString + "');", "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        // CHECK CF API URL
        if (procIsNullString(cfApiUrl)) {
            procPopupAlert("Enter the API URL.", "procSetPopupCfUrlFocus('" + reqStatus + "', '" + cfApiUrlString + "');", "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        // VALIDATE CF API URL
        if (!procValidateUrl(cfApiUrl)) {
            procPopupAlert("Check the API URL.", "procSetPopupCfUrlFocus('" + reqStatus + "', '" + cfApiUrlString + "');", "<%= Constants.CHECK_YN_Y %>");
            return false;
        }

        procPopupConfirm('URL ' + reqStatusString, reqStatusString + ' Would you like to proceed? ', reqStatus.toLowerCase() + 'PopupCfUrl();', null, 'procClosePopup(); procSetPopupCfUrlArea("'+ reqStatus + '"); $("#modalCfUrlList").modal("show");');
    };


    // SET POPUP CF URL FOCUS
    var procSetPopupCfUrlFocus = function(reqStatus, reqObject) {
        var objModalCfUrlList = $('#modalCfUrlList');

        procSetPopupCfUrlArea(reqStatus);
        objModalCfUrlList.modal('show');

        objModalCfUrlList.on('shown.bs.modal', function () {
            $('#' + reqObject).focus();
        });
    };


    // SET POPUP CF URL AREA
    var procSetPopupCfUrlArea = function(reqStatus) {
        var objectArray = ['popupCfUrl', 'Area', 'ButtonArea'];
        var statusArray = [gPopupCfUrlStatusList, gPopupCfUrlStatusCreate, gPopupCfUrlStatusUpdate];
        var popupStatus;
        var popupCfUrlListAreaNoData = $('#popupCfUrlListAreaNoData');

        popupCfUrlListAreaNoData.hide();

        for (var i = 0; i < statusArray.length; i++) {
            popupStatus = statusArray[i];

            if (popupStatus === reqStatus) {
                $('#' + objectArray[0] + popupStatus + objectArray[1]).fadeIn("slow");
                $('#' + objectArray[0] + popupStatus + objectArray[2]).fadeIn("slow");
            } else {
                $('#' + objectArray[0] + popupStatus + objectArray[1]).hide();
                $('#' + objectArray[0] + popupStatus + objectArray[2]).hide();
            }
        }

        if (1 > $('#cfUrlListCount').val() && gPopupCfUrlStatusList === reqStatus) {
            popupCfUrlListAreaNoData.show();
        }
    };


    // CREATE POPUP CF URL
    var createPopupCfUrl = function() {
        var reqParam = {
            serviceInstancesId: "<c:out value='${serviceInstancesId}' default='' />",
            cfApiName: $('#popupCfApiName').val(),
            cfApiUrl: $('#popupCfApiUrl').val()
        };

        procCallAjax("/cf-urls/create.do", reqParam, callbackCreatePopupCfUrl);
    };


    // CALLBACK CREATE POPUP CF URL
    var callbackCreatePopupCfUrl = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        procSetPopupCfUrlResult('Register');
    };


    // SET POPUP CF URL RESULT
    var procSetPopupCfUrlResult = function(returnString) {
        getCfUrlListFromDb();

        $('#modalCfUrlList').modal('hide');
        procPopupAlert(returnString + ' Complete', 'procSetPopupCfUrlArea("' + gPopupCfUrlStatusList + '"); $("#modalCfUrlList").modal("show");');
    };


    // UPDATE POPUP CF URL
    var updatePopupCfUrl = function() {
        var reqParam = {
            id : $('#cfUrlDetailId').val(),
            serviceInstancesId: "<c:out value='${serviceInstancesId}' default='' />",
            cfApiName: $('#popupCfApiNameUpdate').val(),
            cfApiUrl: $('#popupCfApiUrlUpdate').val()
        };

        procCallAjax("/cf-urls/update.do", reqParam, callbackUpdatePopupCfUrl);
    };


    // CALLBACK UPDATE POPUP CF URL
    var callbackUpdatePopupCfUrl = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        procSetPopupCfUrlResult('Change');
    };


    // CONFIRM POPUP CF URL DELETE
    var procConfirmPopupCfUrlDelete = function() {
        $('#modalCfUrlList').modal('hide');
        procPopupConfirm('Delete URL', 'Are you sure you want to delete?', 'deletePopupCfUrl();', null, 'procClosePopup(); procSetPopupCfUrlArea("' + gPopupCfUrlStatusUpdate + '"); $("#modalCfUrlList").modal("show");');
    };


    // DELETE POPUP CF URL
    var deletePopupCfUrl = function() {
        procCallAjax("/cf-urls/delete.do", { id : $('#cfUrlDetailId').val() }, callbackDeletePopupCfUrl);
    };


    // CALLBACK DELETE POPUP CF URL
    var callbackDeletePopupCfUrl = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        procSetPopupCfUrlResult('Delete');
    };


    // GET POPUP CF URL DETAIL
    var getPopupCfUrlDetail = function(reqId) {
        procCallAjax("/cf-urls/get.do?id=" + reqId, null, callbackGetPopupCfUrlDetail);
    };


    // CALLBACK GET POPUP CF URL DETAIL
    var callbackGetPopupCfUrlDetail = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        $('#cfUrlDetailId').val(data.id);
        procSetPopupCfUrlDetail(data);
    };


    // SET POPUP CF URL DETAIL
    var procSetPopupCfUrlDetail = function(data) {
        var popupCfApiName = $('#popupCfApiNameUpdate');

        popupCfApiName.val(data.cfApiName);
        $('#popupCfApiUrlUpdate').val(data.cfApiUrl);

        procSetPopupCfUrlArea(gPopupCfUrlStatusUpdate);
        setTimeout(function() { popupCfApiName.putCursorAtEnd(); }, 100);
    };


    // GET CF INFO
    var getCfInfo = function() {
        procCallAjax("/cf-info/get.do?id=" + document.getElementById('id').value, null, callbackGetCfInfo);
    };


    // CALLBACK GET CF INFO
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


    // DELETE CF INFO
    var deleteCfInfo = function() {
        procCallAjax("/cf-info/delete.do", {id : document.getElementById('id').value}, callbackDeleteCfInfo);
    };


    // CALLBACK DELETE CF INFO
    var callbackDeleteCfInfo = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            return false;
        }

        procPopupAlert('Deleted.', 'procMovePage("/cf-info");');
    };


    // CHECK DUPLICATE CF NAME
    var checkDuplicateCfName = function() {
        var cfName = $('#cfName').val();

        // CHECK CF NAME
        if (procIsNullString(cfName)) {
            procPopupAlert("Please enter your account name.", "$('#cfName').focus();");
            return false;
        }

        // CHECK ORIGINAL CF NAME
        if ($('#originalCfName').val() === cfName) {
            updateCfInfo();
        } else {
            procCallAjax("/cf-info/get.do?serviceInstancesId=<c:out value='${serviceInstancesId}' default='' />&cfName=" + cfName, null, callbackCheckCfName);
        }
    };


    // CALLBACK CHECK DUPLICATE CF NAME
    var callbackCheckCfName = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procPopupAlert("This is an already registered account name.", "$('#cfName').putCursorAtEnd();");
            return false;
        }

        updateCfInfo();
    };


    // UPDATE CF INFO
    var updateCfInfo = function() {
        var doc = document,
            cfId = $('#cfId').val(),
            cfPassword = $('#cfPassword').val(),
            cfApiUrl = $('#cfApiUrl').val();

        // CHECK CF ID
        if (procIsNullString(cfId)) {
            procPopupAlert("Please enter your ID.", "$('#cfId').focus();");
            return false;
        }

        // CHECK CF PASSWORD
        if (procIsNullString(cfPassword)) {
            procPopupAlert("Please enter your password.", "$('#cfPassword').focus();");
            return false;
        }

        // CHECK CF API URL
        if (procIsNullString(cfApiUrl)) {
            procPopupAlert("Select the URL.", "$('#cfApiUrl').focus();");
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

        procCallSpinner(SPINNER_START);
        procCallAjax("/cf-info/update.do", reqParam, callbackUpdateCfInfo);
    };


    // CALLBACK UPDATE CF INFO
    var callbackUpdateCfInfo = function(data) {
        if (RESULT_STATUS_FAIL === data.resultStatus) {
            procCallSpinner(SPINNER_STOP);
            return false;
        }

        procPopupAlert('Saved.', 'procMovePage("/cf-info");');
    };


    // BIND
    $('#btnPopupCfUrl').on('click', function() {
        var objModalCfUrlList = $('#modalCfUrlList');

        getCfUrlListFromDb();
        procSetPopupCfUrlArea(gPopupCfUrlStatusList);

        objModalCfUrlList.modal('toggle');

        objModalCfUrlList.on('hidden.bs.modal', function () {
            getCfUrlListFromDb(gRequestGetCfUrlListToPage);
        })
    });


    // BIND
    $('#btnPopupCfUrlCreate').on('click', function() {
        var popupCfApiName = $('#popupCfApiName');
        popupCfApiName.val('');
        $('#popupCfApiUrl').val('');

        procSetPopupCfUrlArea(gPopupCfUrlStatusCreate);
        setTimeout(function() { popupCfApiName.focus(); }, 100);
    });


    // BIND
    $('.btnPopupCfUrlCreateCancel').on('click', function() {
        procSetPopupCfUrlArea(gPopupCfUrlStatusList);
    });


    // BIND
    $('.btnPopupCfUrlUpdateCancel').on('click', function() {
        procSetPopupCfUrlArea(gPopupCfUrlStatusList);
    });


    // BIND
    $("#btnCfUrlCreate").on("click", function() {
        procValidatePopupCfUrl(gPopupCfUrlStatusCreate);
    });


    // BIND
    $("#btnCfUrlUpdate").on("click", function() {
        procValidatePopupCfUrl(gPopupCfUrlStatusUpdate);
    });


    // BIND
    $("#btnCfUrlDelete").on("click", function() {
        procConfirmPopupCfUrlDelete();
    });


    // BIND
    $("#btnDelete").on("click", function() {
        procPopupConfirm('Delete Cloud Foundry information', 'Are you sure you want to delete?', 'deleteCfInfo();');
    });


    // BIND
    $("#btnUpdate").on("click", function() {
        procPopupConfirm('Edit Cloud Foundry Information', 'Do you want to edit it?', 'checkDuplicateCfName();');
    });


    // BIND
    $("#btnCancel").on("click", function() {
        procMovePage(-1);
    });


    // ON LOAD
    $(document.body).ready(function () {
        procCallSpinner(SPINNER_START);
        getCfUrlListFromDb(gRequestGetCfUrlListToPage);

        getCfInfo();
        $('#cfName').putCursorAtEnd();
    });

</script>
