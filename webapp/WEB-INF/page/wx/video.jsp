<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>课程视频</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
	<style type="text/css">
		video::-internal-media-controls-download-button {
		    display:none;
		}
		video::-webkit-media-controls-enclosure {
		    overflow:hidden;
		}
		video::-webkit-media-controls-panel {
		    width: calc(100% + 30px); 
		}
	</style>
</head>
<body style="background:#fff;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper" style="padding-bottom:52px;">
	<div class="s_vedio">
		<img class="s_htui" src="${ctx}/images/wx/s_img1.png" alt="">
		<div class="s_qiehuan">
			<button class="s_active" style="margin-right: 15px;" onclick="playVideo(1)" id="videobutton">视频</button>
			<button onclick="playVideo(2)" id="audiobutton">音频</button>
		</div>
		<video class="news_video" src="${yyCourse.video_play}" width="100%" controls autobuffer id="media">
		</video>
	</div>
	<div class="s_box">
		<p class="s_h1">${themeName} / ${moduleName} / ${lessonName}</p>
		<p class="s_h2">${pointName}</p>
		<p class="s_h3">${pointDesc}</p>
		<ul class="s_kclist">
			<c:forEach items="${listAppendix}" var="appendix">
				<li class="clearfix s_bdr_btm" onclick="showTip()">
					<p class="ss_icon"><img src="${ctx}/images/wx/learn_icon3.png" alt=""></p>
					<p class="ss_txt2"><span class="cl_2C7EC2">${moduleName}</span><span class="cl_A4A4A4"> / ${lessonName}</span></p><br>
					<p class="s_yklist">${appendix.name}</p>
					<p></p>
<!-- 					<p class="s_xz"><img src="images/s_img4.png" alt=""></p> -->
				</li>
			</c:forEach>
		</ul>
		
		<c:forEach items="${listC}" var="course">
			<div class="s_demo2 s_bdno clearfix" style="position: relative;" onclick="toCourse(${course.id})">
				<div class="s_left video_box">
					<img src="${pic}${course.img_url}" width="100%" height="42.39px;">
					<div class="video_text">
						<i><img src="${ctx}/images/wx/video_icon.png"></i>
						<span>${course.when_long_str}</span>
					</div>
				</div>
				<div class="s_right2">
					<p class="ft_14px cl_4A4A4A">${course.name}</p>
					<p class="ft_12px cl_A4A4A4">${course.info}</p>
				</div>
			</div>
		</c:forEach>
		
	</div>
</div>
<!-- 底部菜单 -->
<%@ include file="/WEB-INF/page/common/wx_footer.jsp" %>

<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/wx/iscroll.js"></script>
<script src="${ctx}/js/weui.min.js"></script>
<script src="${ctx}/plus/layer/layer.js"></script>
<script type="text/javascript">
	var start_time;
	var end_time;
	var is_over=0;
	$.ajaxSetup({
		async: false
	});
    $(document).ready(function(){

        //底部导航
        $('.foot_nav a').each(function(index){
            $(this).on('click', function () {
                $(this).addClass('foot_nav_item_on').siblings().removeClass('foot_nav_item_on');
                if($('.foot_nav a:eq(0)').is('.foot_nav_item_on')){
                    $('.foot_nav a:eq(0) i').attr('class','weui-tabbar__icon study_icon_on');
                    $('.foot_nav a:eq(1) i').attr('class','weui-tabbar__icon cur_icon');
                    $('.foot_nav a:eq(2) i').attr('class','weui-tabbar__icon my_icon');
                };
                if($('.foot_nav a:eq(1)').is('.foot_nav_item_on')){
                    $('.foot_nav a:eq(0) i').attr('class','weui-tabbar__icon study_icon');
                    $('.foot_nav a:eq(1) i').attr('class','weui-tabbar__icon cur_icon_on');
                    $('.foot_nav a:eq(2) i').attr('class','weui-tabbar__icon my_icon');
                };
                if($('.foot_nav a:eq(2)').is('.foot_nav_item_on')){
                    $('.foot_nav a:eq(0) i').attr('class','weui-tabbar__icon study_icon');
                    $('.foot_nav a:eq(1) i').attr('class','weui-tabbar__icon cur_icon');
                    $('.foot_nav a:eq(2) i').attr('class','weui-tabbar__icon my_icon_on');
                };
            });

        })

        //轮播图
        var swiper = new Swiper('#swiper-container1', {
	        pagination: '.swiper-pagination',
	        paginationClickable: true,
	        spaceBetween: 0,
	        centeredSlides: true,
	        autoplay: 2500,
	        autoplayDisableOnInteraction: false,
	        loop: true
	    });  

        //tab切换
        $(".learn_lis li").click(function(){
            $(this).addClass("l_on").siblings().removeClass("l_on");
            var index = $(this).index();
            $(".learn_com").find(".learn_com_box").eq(index).show().siblings().hide();
        })
        
        
        /*视频播放状态*/
        $('.news_video').bind('play', function () {
            start_time = new Date().Format("yyyy-MM-dd HH:mm:ss"); 
        });

        /*视频结束或错误*/
        $('.news_video').bind('error ended', function(){
            is_over = 1;
            end_time = new Date().Format("yyyy-MM-dd HH:mm:ss");
            var d1 = new Date(start_time);
            var d2 = new Date(end_time);
            var long_time = parseInt(d2 - d1) / 1000;
            $.post("<c:url value='/weixin/studyRecord'/>",
            {
            	start_time : start_time,
            	end_time : end_time,
            	long_time : long_time,
            	is_over : is_over,
            	pointId : '${yyCourse.id}',
      			 _t:Math.random()},
      	       	function(data){});
        })

        /*视频暂停*/
        $('.news_video').bind('pause', function () {
            end_time = new Date().Format("yyyy-MM-dd HH:mm:ss");
            var d1 = new Date(start_time);
            var d2 = new Date(end_time);
            var long_time = parseInt(d2 - d1) / 1000;
            $.post("<c:url value='/weixin/studyRecord'/>",
            {
            	start_time : start_time,
            	end_time : end_time,
            	long_time : long_time,
            	is_over : is_over,
            	pointId : '${yyCourse.id}',
      			 _t:Math.random()},
      	       	function(data){
      				start_time = new Date().Format("yyyy-MM-dd HH:mm:ss"); 
      			 });
        });
    	
    	$(document).bind("keydown",function(e){ 
    		e=window.event||e; 
    		if(e.keyCode==116){ 
    			e.keyCode = 0; 
    			return false; 
    		} 
    	});

    });

    function toCourse(pointId){
		window.location.href = "${ctx}/weixin/toVideo?id="+pointId;
	}
    
    function playVideo(v){
    	var myVideo = document.getElementById("media");
    	var curTime=myVideo.currentTime;
    	//获取当前播放时间
    	if(v==1){
    		var src = '${yyCourse.video_play}';
    		$("#media").attr("src",src);
    		$("#videobutton").addClass("s_active");
    		$("#audiobutton").removeClass("s_active");
    	}else{
    		var src = '${yyCourse.audio_play}';
    		$("#media").attr("src",src);
    		$("#audiobutton").addClass("s_active");
    		$("#videobutton").removeClass("s_active");
    	}
    	var myVideo1 = document.getElementById("media");
    	myVideo1.currentTime=curTime;
    	myVideo1.play();
    }
    
    Date.prototype.Format = function (fmt) { //author: meizz   
        var o = {  
            "M+": this.getMonth() + 1, //月份   
            "d+": this.getDate(), //日   
            "H+": this.getHours(), //小时   
            "m+": this.getMinutes(), //分   
            "s+": this.getSeconds(), //秒   
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
            "S": this.getMilliseconds() //毫秒   
        };  
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
        for (var k in o)  
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
        return fmt;  
    }  
    function showTip(){
    	layer.msg("请登录APP或者登陆网页版下载");
    }
</script>
</body>
</html>