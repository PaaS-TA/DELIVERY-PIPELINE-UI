<%--
  Created by IntelliJ IDEA.
  User: REX
  Date: 9/27/2017
  Time: 10:15 AM
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

    <link rel="shortcut icon" type="image/x-icon" href="/resources/images/favicon.ico">
    <title>PaaS-TA deployment pipeline</title>
    <style>
        .layer {position:absolute;display:table;top:0;left:0;width:100%;height:100%}
        .layer .layer_inner{display:table-cell;text-align:center;vertical-align:middle}
        .layer .content{display:inline-block;background:#fff;width: 28%; margin-top: -100px;}
        .panel {
            border: solid 1px #bbb;
        }
        .panel-heading {
            background-color: #343942; padding: 20px;
        }

        .panel-image {
            vertical-align: middle; margin-left: -20px;
        }
        .header-title {
            font-size: 16px;
            font-weight: 600;
            color: #dfe3e8;
            vertical-align:middle;
            margin-left: 6px;
        }
        .panel-body {
            padding: 40px;
        }
        .panel-body span {
            color: #343942;
        }
        hr {
            margin-top: 20px;
            margin-bottom: 20px;
            border: 0;
            border-top: 1px solid #ccc;
        }
    </style>

</head>

<body>
<!-- wrap :s -->
<div id="wrap">

    <%--CONTENTS AREA :: BEGIN--%>
    <main id="sitemesh-page-wrapper">
        <div class="sitemesh-container-fluid">
            <sitemesh:write property="body" />
        </div>
    </main>
    <%--CONTENTS AREA :: END--%>

</div>
<!--//wrap :e -->
</body>
</html>
