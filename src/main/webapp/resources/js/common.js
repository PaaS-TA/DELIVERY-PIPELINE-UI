// POPUP CONFIRM
var procPopupConfirm = function (reqTitle, reqMessage, procFunction, reqButtonText, procCancelFunction) {
    if (null === reqTitle || reqTitle.length < 1) return false;
    if (null === reqMessage || reqMessage.length < 1) return false;
    if (null === procFunction) return false;

    var objButtonText = $('#commonPopupConfirmButtonText');
    var objCancelButton = $('.commonPopupConfirmCancelButton');
    var buttonText = (null === reqButtonText || '' === reqButtonText || undefined === reqButtonText) ? reqMessage.split(' ')[0] : reqButtonText;

    $('#commonPopupConfirmTitle').html(reqTitle);
    $('#commonPopupConfirmMessage').html(reqMessage);

    objButtonText.html(buttonText);
    objButtonText.attr('onclick', procFunction);

    if (null === procCancelFunction || '' === procCancelFunction || undefined === procCancelFunction) {
        objCancelButton.attr("data-dismiss", "modal");
    } else {
        objCancelButton.attr("data-dismiss", "");
        objCancelButton.attr('onclick', procCancelFunction);
    }

    $('#modalConfirm').modal('toggle');
};


// CLOSE POPUP
var procClosePopup = function () {
    $('div.modal').modal('hide');
};


// POPUP ALERT
var procPopupAlert = function (reqMessage, procFunction, reqClosePopup) {
    if (null === reqClosePopup || undefined === reqClosePopup) {
        procClosePopup();
    }

    if (reqMessage === null || reqMessage.length < 1) return false;

    $('#commonPopupAlertMessage').html(reqMessage);

    var objModalAlert = $('#modalAlert');

    objModalAlert.modal('show');
    objModalAlert.on('hidden.bs.modal', function () {
        if (null !== procFunction && undefined !== procFunction && reqMessage.length > 0) {
            setTimeout(function () {
                eval(procFunction);
            }, 3);
        }
    })
};


// CALL SPINNER
var procCallSpinner = function (reqStatus) {
    var objModalSpinner = $('#modalSpinner');

    if ('' === reqStatus || undefined === reqStatus || SPINNER_START === reqStatus) {
        procClosePopup();
        window.scrollTo(0, 0);
        objModalSpinner.modal('toggle');
    }

    if ('' !== reqStatus && SPINNER_STOP === reqStatus) {
        objModalSpinner.modal('hide');
        window.scrollTo(0, 0);
    }
};


// CHECK IS NULL STRING
var procIsNullString = function (reqString) {
    return (reqString === null) || (reqString === "undefined") || (reqString === "null") || (reqString + ''.replace(/ /gi, "") === "");
};

// GET DASHBOARD URL
var procGetDashboardUrl = function () {
    var currentUrl = location.pathname;
    var splitString = "/";
    var splits = currentUrl.split(splitString);

    return splitString + splits[1] + splitString + splits[2];
};


// CALL AJAX
var getProcCallAjax = function (reqUrl, callback) {
    console.log("GET REQUEST");
    $.ajax({
        url: reqUrl,
        method: "GET",
        dataType: 'json',
        contentType: "application/json",
        success: function (data) {
            if (data) {
                callback(data);
            } else {
                var resData = {
                    resultStatus: RESULT_STATUS_SUCCESS
                    // RESULT: RESULT_STATUS_FAIL,
                    // RESULT_MESSAGE: JSON.parse(xhr.responseText).message
                };

                callback(resData);
                // var resData = {
                //     RESULT: RESULT_STATUS_SUCCESS,
                //     RESULT_MESSAGE: RESULT_STATUS_SUCCESS_MESSAGE
                // };
                //
                // callback(resData, param);
            }
        },
        error: function (xhr, status, error) {
            console.log("ERROR :: xhr :: ", xhr);
            console.log("ERROR :: status :: ", status);
            console.log("ERROR :: error :: ", error);

            var responseString = '시스템 장애가 발생했습니다.';
            var objModalAlert = $('#modalAlert');
            var responseText = xhr.responseText;
            var tempResultMessage = (null === responseText || 'null' === responseText || '' === responseText) ? responseString : JSON.parse(responseText).message;
            var responseResultMessage = (null === tempResultMessage || 'null' === tempResultMessage || '' === tempResultMessage) ? responseString : tempResultMessage;

            var resData = {
                resultStatus: RESULT_STATUS_FAIL,
                resultMessage: responseResultMessage
            };

            $('#commonPopupAlertMessage').html(responseResultMessage);
            objModalAlert.modal('show');

            callback(resData);
        },
        complete: function (data) {
            console.log("COMPLETE :: data :: ", data);
        }
    });
};


var postProcCallAjax = function (reqUrl, param, callback) {
    console.log("POST REQUEST");

    var reqData = {};

    if (param !== null) {
        reqData = JSON.stringify(param);
    }

    $.ajax({
        url: reqUrl,
        method: "POST",
        data: reqData,
        dataType: 'json',
        contentType: "application/json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(_csrf_header, _csrf_token);
        },
        success: function (data) {
            if (data) {
                callback(data, param);
            } else {
                var resData = {
                    resultStatus: RESULT_STATUS_SUCCESS
                    // RESULT: RESULT_STATUS_SUCCESS,
                    // RESULT_MESSAGE: RESULT_STATUS_SUCCESS_MESSAGE
                };

                callback(resData, param);
            }
        },
        error: function (xhr, status, error) {
            console.log("ERROR :: xhr :: ", xhr);
            console.log("ERROR :: status :: ", status);
            console.log("ERROR :: error :: ", error);

            var responseString = '시스템 장애가 발생했습니다.';
            var objModalAlert = $('#modalAlert');
            var responseText = xhr.responseText;
            var tempResultMessage = (null === responseText || 'null' === responseText || '' === responseText) ? responseString : JSON.parse(responseText).message;
            var responseResultMessage = (null === tempResultMessage || 'null' === tempResultMessage || '' === tempResultMessage) ? responseString : tempResultMessage;

            var resData = {
                resultStatus: RESULT_STATUS_FAIL,
                resultMessage: responseResultMessage
            };

            // PASS :: JOB STATUS EXCEPTION
            if ('JOB_STATUS_EXCEPTION' !== responseResultMessage) {
                $('#commonPopupAlertMessage').html(responseResultMessage);
                objModalAlert.modal('show');
            }

            callback(resData, param);
        },
        complete: function (data) {
            console.log("COMPLETE :: data :: ", data);
        }
    });
};

var getProcCallAjaxData = function (reqUrl, param, callback) {
    console.log("POST REQUEST");

    var reqData = {};

    if (param !== null) {
        reqData = JSON.stringify(param);
    }

    $.ajax({
        url: reqUrl,
        method: "GET",
        data: reqData,
        dataType: 'json',
        contentType: "application/json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(_csrf_header, _csrf_token);
        },
        success: function (data) {
            if (data) {
                callback(data, param);
            } else {
                var resData = {
                    resultStatus: RESULT_STATUS_SUCCESS
                    // RESULT: RESULT_STATUS_SUCCESS,
                    // RESULT_MESSAGE: RESULT_STATUS_SUCCESS_MESSAGE
                };

                callback(resData, param);
            }
        },
        error: function (xhr, status, error) {
            console.log("ERROR :: xhr :: ", xhr);
            console.log("ERROR :: status :: ", status);
            console.log("ERROR :: error :: ", error);

            var responseString = '시스템 장애가 발생했습니다.';
            var objModalAlert = $('#modalAlert');
            var responseText = xhr.responseText;
            var tempResultMessage = (null === responseText || 'null' === responseText || '' === responseText) ? responseString : JSON.parse(responseText).message;
            var responseResultMessage = (null === tempResultMessage || 'null' === tempResultMessage || '' === tempResultMessage) ? responseString : tempResultMessage;

            var resData = {
                resultStatus: RESULT_STATUS_FAIL,
                resultMessage: responseResultMessage
            };

            // PASS :: JOB STATUS EXCEPTION
            if ('JOB_STATUS_EXCEPTION' !== responseResultMessage) {
                $('#commonPopupAlertMessage').html(responseResultMessage);
                objModalAlert.modal('show');
            }

            callback(resData, param);
        },
        complete: function (data) {
            console.log("COMPLETE :: data :: ", data);
        }
    });
};


var procCallAjax = function (reqUrl, param, callback) {
    reqUrl = procGetDashboardUrl() + reqUrl;
    if (param === null) {
        getProcCallAjax(reqUrl, callback);
    } else {
        postProcCallAjax(reqUrl, param, callback);
    }
};


var procCallAjaxGet = function (reqUrl, param, callback) {
    reqUrl = procGetDashboardUrl() + reqUrl;
    getProcCallAjaxData(reqUrl, param, callback);

};


// MOVE PAGE
var procMovePage = function (pageUrl) {
    if (pageUrl === null || pageUrl.length < 1) {
        return false;
    }

    if ((!!pageUrl && typeof pageUrl === 'number') && -1 === pageUrl) {
        history.back();
    } else {
        pageUrl = ("/" === pageUrl) ? "" : pageUrl;
        location.href = procGetDashboardUrl() + pageUrl;
    }

};


// DOWNLOAD
var procDownload = function (fileId) {
    procMovePage(DOWNLOAD_API_URL + fileId);
};


// MOVE CURSOR TO END OF TEXTAREA OR INPUT
jQuery.fn.putCursorAtEnd = function () {

    return this.each(function () {
        var $el = $(this), el = this;
        if (!$el.is(":focus")) {
            $el.focus();
        }

        if (el.setSelectionRange) {
            var len = $el.val().length * 2;
            setTimeout(function () {
                el.setSelectionRange(len, len);
            }, 1);

        } else {
            $el.val($el.val());
        }

        this.scrollTop = 999999;
    });
};


// VALIDATE URL
var procValidateUrl = function (reqUrl) {
    var regex = /^(((http(s?))\:\/\/)?)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?/;
    return regex.test(reqUrl);
};
