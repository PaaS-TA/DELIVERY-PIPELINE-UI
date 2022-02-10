<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 7/4/2017
  Time: 3:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko" style="visibility: visible;">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

    <link rel="shortcut icon" type="image/x-icon" href="<c:url value='/resources/images/favicon.ico'/>">
    <title>PaaS-TA Pipeline</title>

    <%--COMMON LIBRARY :: BEGIN--%>
    <%@include file="../common/commonLibs.jsp" %>
    <%--COMMON LIBRARY :: END--%>
</head>

<body>
    <!-- wrap :s -->
    <div id="wrap">

        <%--HEADER AREA :: BEGIN--%>
        <%@include file="../common/header.jsp" %>
        <%--HEADER AREA :: END--%>

        <%--CONTENTS AREA :: BEGIN--%>
        <main id="sitemesh-page-wrapper">
            <div class="sitemesh-container-fluid">
                <sitemesh:write property="body" />
            </div>
        </main>
        <%--CONTENTS AREA :: END--%>

        <%--FOOTER AREA :: BEGIN--%>
        <%@include file="../common/footer.jsp" %>
        <%--FOOTER AREA :: END--%>

    </div>
    <!--//wrap :e -->
</body>
</html>
