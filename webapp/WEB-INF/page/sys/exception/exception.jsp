<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title }</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/css/style.css" />
	<%@ include file="/WEB-INF/page/common/js.jsp" %>	
	<script src="${ctx}/js/common.js"></script> 
</head>

<body style="background:#fff;">
	<div id="content1">
	  <div id="content-header">
	      <h1>系统异常</h1>
	  </div>
		<div class="container-fluid">
		  <div class="row-fluid">
		    <div class="span12">
		    	<div class="widget-box">
		          <div class="widget-title"> <span class="icon"> <i class="icon-exclamation-sign"></i> </span>
		            <h5>以下是系统异常信息 ，请把以下信息发给管理员</h5>
		          </div>
		          <div class="widget-content">
				  	${errorTips}
				  </div>
		        </div>
		    </div>
		  </div>
		</div>
	</div>
</body>
</html>
 