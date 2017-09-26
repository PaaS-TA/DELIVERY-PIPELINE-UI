// GET DASHBOARD URL
var procGetDashboardUrl = function () {
    var currentUrl = location.pathname;
    var splitString = "/";
    var splits = currentUrl.split(splitString);

    return splitString + splits[1] + splitString + splits[2];
};

// FILE FORM DATA
var getFileFormData = function() {
    var reqFileObject = REQUEST_FILE;
    if (null == reqFileObject || undefined === reqFileObject) return false;

    var formData = new FormData();
    formData.append("file", reqFileObject[0]);
    return formData;
};


// UPLOAD FILE
var procUploadFile = function(formData, reqUploadUrl, reqProcFunction) {
    console.log("procUploadFile ####");
    reqUploadUrl = procGetDashboardUrl() + reqUploadUrl;
    $.ajax({
        url : reqUploadUrl
        , method : "POST"
        , processData : false
        , contentType : false
        , data : formData
        , dataType : "json",
        beforeSend : function(xhr){
            xhr.setRequestHeader(_csrf_header, _csrf_token);
        }
        , success : function(data){
            if (data) {
                reqProcFunction(data);
            } else {
                var resData = {RESULT : RESULT_STATUS_SUCCESS,
                                RESULT_MESSAGE : "<spring:message code='common.info.result.success' />"};

                reqProcFunction(resData);
            }
        },
        error: function(xhr, status, error) {
            // procCallSpinner(SPINNER_SPIN_STOP);

            var resData = {RESULT : RESULT_STATUS_FAIL,
                            RESULT_MESSAGE : JSON.parse(xhr.responseText).customMessage};

            reqProcFunction(resData);
            console.log("FILE UPLOAD ERROR :: error :: ", error);
        },
        complete : function(data) {
            console.log("FILE UPLOAD COMPLETE :: data :: ", data);
        }
    });
};

