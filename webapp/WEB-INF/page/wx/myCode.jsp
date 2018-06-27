<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="format-detection" content="telephone=no" />
    <title>我的二维码</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/weui.css">
</head>
<body style="background:#fff;">
<div class="wrapper">
    <div class="content_order">
        <div class="login_box">
            <img src="${pic}${imgUrl}"/>
        </div> 
    </div>
</div>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/weui.min.js"></script>
</body>
</html>