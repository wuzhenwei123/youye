<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>编辑任务</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
	<link rel="stylesheet" href="${ctx}/css/mobiscroll_date.css" />
</head>
<body style="background:#fff;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper">
	<header class="s_head bg_fff">
		<img src="${ctx}/images/wx/s_img6.png" alt="" onclick="goMain()">
		<span>编辑学习任务</span>
		<i class="s_bc" onclick="save()">保存</i>
	</header>
	<div class="s_box">
		<ul class="s_kclist bg_fff s_bdrb">
			<li class="s_pdtb30 clearfix">
				<p class="ss_icon"><img onerror="javascript:this.src='${ctx}/images/wx/list_icon3_on.png'" src="${pic}${yyUserCourse.img_url}" alt=""></p>
				<p class="ss_txt"><span class="cl_4A4A4A">战略导向</span></p>
			</li>
		</ul>
		<p class="s_timeul bg_fff s_bdrb">
			<span class="s_timico"><img src="${ctx}/images/wx/data_icon.png" alt=""></span>
<!-- 			<input id="over_time" class="ft_14px cl_4A4A4A" value="${over_time}" readonly="readonly"> -->
			<span class="ft_14px cl_4A4A4A"><input type="text" readonly="readonly" id="over_time" value="${over_time}"></span>
		</p>
		<div class="s_timeul bg_f9f9f9 s_bdrb clearfix">
			<span class="s_timico s_fl"><img src="${ctx}/images/wx/per_icon.png" alt=""></span>
			<div class="s_mianbao2">
				<c:forEach items="${listU}" var="user">
					<span>${user.user_name}</span>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="s_del" onclick="del()">
		<p>删除学习任务</p>
	</div>
</div>

<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/wx/iscroll.js"></script>
<script src="${ctx}/js/weui.min.js"></script>
<script src="${ctx}/js/mobiscroll_date.js"></script>
<script src="${ctx}/js/mobiscroll.js"></script>
<script type="text/javascript">
$(function(){
	var currYear = (new Date()).getFullYear();
    var opt = {};
    opt.date = {
        preset: 'date'
    };
    opt.datetime = {
        preset: 'datetime'
    };
    opt.time = {
        preset: 'time'
    };
    opt.default = {
        theme: 'android-ics light', //皮肤样式
        dateFormat: 'yy-mm-dd',
        showNow: true,
        nowText: "今天",
        setText: '确定', //确认按钮名称
        cancelText: '取消',//取消按钮名籍我
        dateOrder: 'yymmdd', //面板中日期排列格式
        timeFormat: 'HH:ii',  
        timeWheels: 'HHii',  
        stepMinute:	10,//分间隔
        hourText: '时', minuteText: '分', dayText: '日', monthText: '月', yearText: '年', //面板中年月日文字
        startYear: currYear, //开始年份
        endYear: currYear //结束年份
    };
    
    $("#over_time").mobiscroll($.extend(opt['datetime'], opt['default']));
})
function del(){
	weui.dialog({
	    title: '提示',
	    content: '确定要删除学习任务吗？',
	    className: 'custom-classname',
	    buttons: [{
	        label: '取消',
	        type: 'default',
	        onClick: function () {}
	    }, {
	        label: '确定',
	        type: 'primary',
	        onClick: function () {
	        	$.post("${ctx}/weixin/delLearnTask",
                	{
	        		userCourseId : '${userCourseId}',
         			 _t:Math.random()},
         	       	function(data){
         	        	var result = eval('('+data+')'); 
         	            if (result.c == '0') {
         	            	weui.alert("删除成功!");
         	            	setTimeout(goMain(),2000);
         	             } else {
         	            	 weui.alert("删除失败!");
         	             }
                });
	        }
	    }]
	});
}
function goMain(){
	window.location.href = "${ctx}/weixin/toTeamLessonList";
}

function save(){
	var over_time = $("#over_time").val();
	var old_over_time = '${over_time}';
	if(over_time!=old_over_time){
		$.post("${ctx}/weixin/updateLearnTask",
	        	{
	    		userCourseId : '${userCourseId}',
	    		over_time : over_time,
	 			 _t:Math.random()},
	 	       	function(data){
	 	        	var result = eval('('+data+')'); 
	 	            if (result.c == '0') {
	 	            	weui.alert("修改成功!");
	 	            	setTimeout(goMain(),2000);
	 	             } else {
	 	            	 weui.alert("修改失败!");
	 	             }
	        });
	}else{
		weui.alert("修改成功!");
	}
	
}
</script>
</body>
</html>