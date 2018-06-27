<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>团队管理-课程管理</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
</head>
<body style="background:#fff;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper">
	<div class="cur_box_all team_box_all">
		<div class="per_header">
			<div class="per_header_main">
				<div class="per_pic">
					<span class="per_pics">
						<img alt="" src="${admin_user.head_img}" width="63px;" height="63px;" style="border-radius: 50%;">
					</span>
				</div>
				<p class="per_name">${admin_user.name}</p>
				<P>${admin_user.company_name}</P>
			</div>
<!-- 			<a href="" class="message"><img src="images/message_icon.png"/></a> -->
		</div>
		<div class="cur_list">
			<div class="learn_lis clearfix">
				<li style="list-style:none"><a href="${ctx}/weixin/toTeamAnalytics">数据统计</a></li>
				<li style="list-style:none" class="l_on"><a href="${ctx}/weixin/toTeamLessonList">课程管理</a></li>
			</div>		
		</div>
	    <div class="personal_rank team_main" style="background:#fff;">
	    	<div class="learn_com_box">
	    		<c:forEach items="${listC}" var="uc">
<!-- 	    			<a href="${ctx}/weixin/toLearnTask?userCourseId=${uc.id}&over_time=<fmt:formatDate value="${uc.over_time}" pattern="yyyy-MM-dd HH:mm"/>"> -->
	    			<a href="${ctx}/weixin/toLessonDetail?lessonId=${uc.course_classify_id}"/>">
						<div class="learn_com_main" >
							<div class="learn_com_mains learn_com_mains_on clearfix">
								<div class="mains_l">
									<p class="learn_p1"><img src="${ctx}/images/wx/learn_icon1.png"/></p>	
								</div>
								<div class="mains_r">
									<div class="mains_rt clearfix">
										<span class="mains_rt_t"><b class="t_b">${uc.moduleName}</b> / ${uc.lessonName}</span>
										<span class="mains_rt_t1">
										<c:if test="${uc.over_time!=null}"><fmt:formatDate value="${uc.over_time}" pattern="yyyy-MM-dd"/></c:if>
										  剩余${uc.overDays}天</span>
									</div>
									<div class="team_rb">
										<div class="team_names">
											<c:forEach items="${uc.listUC}" var="user">
												<span>${user.user_name}</span>
											</c:forEach>
										</div>
										<b class="more_text">...${uc.count}+</b>
									</div>
								</div>
							</div>
						</div>
					</a>
	    		</c:forEach>
			</div>
	    </div>
	</div>
<!-- 	<div class="addBtn"> -->
<!-- 		<a href=""><img src="${ctx}/images/wx/add_icon1.png"/></a> -->
<!-- 	</div> -->
</div>
</body>
</html>