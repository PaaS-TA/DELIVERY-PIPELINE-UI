<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/7/2017
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="paasta.delivery.pipeline.ui.common.Constants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/bootstrap/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/bootstrap/css/bootstrap-theme.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/custom.css'/>">

<script type="text/javascript" src="<c:url value='/resources/js/lib/jquery-3.2.1.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/bootstrap/js/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/lib/jquery.svgDoughnutChart.js' />"></script>
<script type="text/javascript" src="<c:url value='/resources/js/main.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/cont_tab.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common.js' />"></script>



<script type="text/javascript">

    var RESULT_STATUS_SUCCESS = "<%= Constants.RESULT_STATUS_SUCCESS %>";
    var RESULT_STATUS_FAIL = "<%= Constants.RESULT_STATUS_FAIL %>";
    var DOWNLOAD_API_URL = "<c:url value='/file/download/'/>";
    var JOB_PIPELINE_URL = "/pipelines/<c:out value='${pipelineId}' default='' />/jobs";
    var INSPECTION_PIPELINE_URL = "/pipelines/<c:out value='${pipelineId}' default='' />/inspections";
    var G_SUID = "<c:out value='${suid}' default='' />";
    var G_SERVICE_INSTANCE_ID = "<c:out value='${serviceInstancesId}' default='' />";
    var G_PIPELINE_ID = "<c:out value='${pipelineId}' default='' />";

    var REQUEST_FILE;
    var REQUEST_FILE_OBJECT;
    var SPINNER_START = 'START';
    var SPINNER_STOP = 'STOP';

    var _csrf_token = document.getElementsByName("_csrf")[0].getAttribute("content");
    var _csrf_header = document.getElementsByName("_csrf_header")[0].getAttribute("content");

</script>
