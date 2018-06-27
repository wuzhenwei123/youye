<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>学习记录</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
</head>
<body style="background:#f9f9f9;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper">
	<header class="s_head bg_fff">
		<img src="${ctx}/images/wx/s_img1.png" alt="">
		<span>学习记录</span>
	</header>
	<div class="s_box">
		<p class="s_p1">已学过课程</p>
		<c:forEach items="${list}" var="study">
			<div class="s_demo1 bg_fff">
				<div class="clearfix" onclick="toPoint(${study.lesson_id})">
					<div class="s_left bg_832676"><img width="128px" height="72px;" src="${pic}${study.img_url}" alt="" onerror="javascript:this.src='${ctx}/images/wx/ty_pic.png'"></div>
					<div class="s_right s_right1">
						<p><span class="cl_2C7EC2">${study.module_name}<b class="cl_4A4A4A">/${study.lesson_name}</b></span><span class="s_time"><c:if test="${study.lastStudyTime!=null}">${study.lastStudyTime}天前</c:if><c:if test="${study.lastStudyTime==null}">今天</c:if></span></p>
						<ul>
							<c:forEach items="${study.listCourse}" var="course">
								<li style="text-overflow:ellipsis;width: 135px;white-space: nowrap;overflow:hidden;"><i></i>${course.name}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<ul class="s_list" style="margin-top: 5px;">
					<c:forEach items="${study.listAppendix}" var="appendix">
						<li style="list-style:none" onclick="showTip()"><span style="text-overflow:ellipsis;white-space: nowrap;overflow:hidden;width: 135px;">${appendix.name}</span><span class="s_xiazai"></span></li>
					</c:forEach>
				</ul>
<!-- 				<div class="s_btn">展开全部</div> -->
			</div>
			<div class="s_ht8"></div>
		</c:forEach>
		
	</div>
</div>

<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/wx/iscroll.js"></script>
<script src="${ctx}/plus/layer/layer.js"></script>
<script type="text/javascript">
function toPoint(id){
	window.location.href = '${ctx}/weixin/toLessonDetail?lessonId='+id;
}
function showTip(){
	layer.msg("请登录APP或者登陆网页版下载");
}
</script>
</body>
</html>