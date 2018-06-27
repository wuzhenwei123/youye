<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title }</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- CSS -->
    <link rel="stylesheet" href="${ctx }/matrix/login/css/reset.css">
    <link rel="stylesheet" href="${ctx }/matrix/login/css/supersized.css">
    <link rel="stylesheet" href="${ctx }/plus/layer/skin/layer.css" />
    <link rel="stylesheet" href="${ctx }/matrix/login/css/style.css">
    <!-- Javascript -->
    <script src="${ctx }/matrix/login/js/jquery-1.8.2.min.js"></script>
    <script src="${ctx }/matrix/login/js/supersized.3.2.7.min.js"></script>
    <script src="${ctx }/plus/layer/layer.js"></script>
    <script src="${ctx }/matrix/login/js/scripts.js"></script>
    <script src="${ctx }/js/login.js"></script>
</head>

<body>
	<input type="hidden" id="ctx" value="${ctx }" />
	<div id="page-container">
		<div class="page-container">
			<form name="form1" method="post">
			      <dl>
				   <dd>
				   		<h2 style="color:#000000;font-size:28px;font-weight:bolder;width: 315px;">优也树后台管理系统</h2>
				   </dd>
				   <dd><input type="text" name="username" id="username" placeholder="请输入用户名"/></dd>
				   <dd><input type="password" class="alltxt" name="password" placeholder="请输入密码"/></dd>
				   <dd>
				   		<input id="vdcode" type="text" name="verfycode" style="text-transform:uppercase;width: 177px;" placeholder="请输入验证码"/>
				   		<img id="vdimgck" onClick="this.src=this.src+'?'" style="cursor: pointer;position: relative;top: 15px;height: 40px;border-radius:6px;box-shadow: 0 2px 3px 0 rgba(0, 0, 0, 0.1) inset;top: 13px\0;" title="看不清？点击更换" src="${ctx }/manageAdminUser/pcrimg"/>
			       </dd>
					<dt>&nbsp;</dt>
					<dd><button type="button" name="sm1" class="login-btn" onclick="checkLogin()">登录 & LOGIN</button></dd>
					<dd>
						<h5 style="font-size:14px;margin-top: 20px;margin-bottom: 20px;">©2017 xxx.com All rights reserved 京ICP备14027297号-1</h5>
					</dd>
				 </dl>
			</form>
		</div>
	</div>  
	<script>
		$(document).ready(function() {
			$("#username").focus();
		});
	</script>
</body>
</html>