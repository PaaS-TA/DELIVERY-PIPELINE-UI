<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-13
  Time: 오후 2:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
파일 업로드 페이지 :: FILE UPLOAD CREATE PAGE
<br>
<div class="row">
    <div id="reqFileArea" class="custom-container fl" role="main">
        <div id="dndBox" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #ff8c00 4px; display: none;">
            <div class="">
                <div id="reqFileLabel"><strong> Choose a file </strong><span class="custom-box-dragndrop"> or drag it here. </span></div>
            </div>
        </div>
    </div>
    <br>
    <div class="fl">
        <label for="reqFile" class="sr-only"> FILE </label>
        <input type="file" name="files[]" id="reqFile" class="req_file_object">
        <button type="button" id="sendFile"> [ 보내기 ] </button>
    </div>

    <%-- 파일이 존재할 때 / 파일 업로드가 2개 이상 될 때 뜨는 부분--%>
    <c:if test="">
    <div class="col-sm-12 fl pd0" >
        <div class="panel panel-default" hidden>
            <div class="panel-body pd10">
                <div class="fl">
                    <span id="reqFileName" class="modify_panel_title"> 파일 첨부는 1개 파일만 가능합니다. </span>
                </div>
                <div id="fileDeleteButtonArea" class="ml10 fl">
                    <button type="button" id="btnDeleteFile" class="btn btn-save btn-sm"> 첨부파일 삭제 </button>
                </div>
            </div>
        </div>
    </div>
    </c:if>
    <br>
    <br>

    <div id="resultArea" style="width: 90%; height: auto; min-height: 100px; padding: 10px; border: dotted #1EA0E6 4px;">
    </div>
</div>

<script type="text/javascript" src="<c:url value='/resources/js/fileUpload.js' />"></script>
<script>

    REQUEST_FILE_OBJECT = $('#reqFile');
    REQUEST_FILE_OBJECT.on("change", function () {
        REQUEST_FILE = ($(this)[0].files);
    });

    $("#sendFile").on("click", function(){
        var formData = getFileFormData();
        procUploadFile(formData, "/file/uploadFile.do", procInsert);
    });


    // INSERT
    var procInsert = function (data) {
        $('#resultArea').html("# fileURL ::: " + data.fileUrl);
    };

    $(document).ready(function () {

    });

</script>
