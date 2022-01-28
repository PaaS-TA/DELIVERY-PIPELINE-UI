<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2017-06-16
  Time: 오후 1:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
FILE INFO details page
<br>
<ul>
    <li>ID :: <span id="fileId"></span></li>
    <li>origin name :: <span id="originName"></span></li>
    <li>stored name :: <span id="storedName"></span></li>
    <li>file URL :: <span id="url"></span></li>
</ul>
<br>
<button type="button" id="btnDelete"> [ Delete ] </button>

<input type="hidden" id="id" name="id" value="<c:out value='${id}' default='' />" />

<script type="text/javascript">

    var getFile = function(){
      procCallAjax("/file/getFileInfo.do", {id :  document.getElementById('id').value}, callbackGetFileDetailInfo);
    };


    var deleteFile = function(){
       procCallAjax("/file/fileDelete.do", {id : document.getElementById('id').value}, callbackDeleteFile);
    };

    var callbackGetFileDetailInfo = function(data){
        var doc = document;
        doc.getElementById('fileId').innerHTML = data.id;
        doc.getElementById('originName').innerHTML = data.originalFileName;
        doc.getElementById('storedName').innerHTML = data.storedFileName;
        doc.getElementById('url').innerHTML = data.fileUrl;
    };


    var callbackDeleteFile = function(data){
        if (RESULT_STATUS_FAIL == data.resultStatus) return false;

        alert("Deleted.");
        procMovePage('<c:url value="/file/info"/>');
    };
    /*var downloadUploadedFile = function(id){
        procCallAjax("/file/download.do", id, postProcCallAjax());
    };*/

    $('#btnDelete').on("click", function(){
        if(confirm("Are you sure you want to delete?")) deleteFile();
    });

    $(document.body).ready(function(){
       getFile();
    });
</script>

