<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>团队管理-数据统计</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
</head>
<body style="background:#f9f9f9;">
<%-- <%@ include file="/WEB-INF/page/common/share1.jsp" %> --%>
<div class="wrapper">
	<div class="cur_box_all">
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
				<li class="l_on" style="list-style:none"><a href="${ctx}/weixin/toTeamAnalytics">数据统计</a></li>
				<li style="list-style:none"><a href="${ctx}/weixin/toTeamLessonList">课程管理</a></li>
			</div>	
			<div class="team_com">
				<h2>团队统计</h2>
				<div class="count_main" id="main" style="width: 98%;height: 220px;"></div>
			</div>		
		</div>
	    <div class="personal_rank">
	    	<h2>团队详情</h2>
	    	<table border="0" cellspacing="0" cellpadding="0" class="tab1">
	    		 <tbody>
		    		<tr class="tab1_tr">
		    			<td>成员</td>
		    			<td>学习时间</td>
		    			<td>完成课程</td>
		    			<td>提交改善</td>
		    		</tr>
		    		<c:forEach items="${listChild}" var="child">
		    			<tr>
			    			<td>${child.name}</td>
			    			<td>${child.study_time}</td>
			    			<td>${child.studied_count}</td>
			    			<td>0</td>
			    		</tr>
		    		</c:forEach>
	    		</tbody>
	    	</table>
	    </div>
	</div>
</div>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/echarts.common.min.js"></script>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('main'));
var option = "{color: ['#feb830','#1eb4ec'],";
option = option + "tooltip : {trigger: 'axis'},legend: {data:['学习时长（分钟）','课程数量']},";
option = option + "grid: {left: '3%',right: '4%',bottom: '3%',containLabel: true},";
option = option + "xAxis : [{type : 'category',boundaryGap : false,data : [${user_names}]}],";
option = option + "yAxis : [{type : 'value'}],";
option = option + "series : [{name:'学习时长（分钟）',type:'line',label: {normal: {show: true,position: 'top'}},";
option = option + "data:[${study_times}]},{name:'课程数量',type:'line',label: {normal: {show: true,position: 'top'}},";
option = option + "data:[${course_counts}]}]}";
myChart.setOption(eval("("+option+")"));
</script>
</body>
</html>