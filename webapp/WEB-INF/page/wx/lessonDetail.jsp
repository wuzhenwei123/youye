<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>课程详情</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
</head>
<body style="background:#f9f9f9;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper">
	<input type="hidden" id="lessonId" value="${lessonId}"/>
	<input type="hidden" id="" value="${themeName}"/>
	<input type="hidden" id="" value="${themeName}"/>
	<div class="cur_box_all">
		<div class="det_box_a">
			<div class="det_box_a_t"><img src="${ctx}/images/wx/det_pic.png"/></div>
			<div class="det_box_a_b clearfix">
				<div class="a_b_text">
					<p>${themeName} / ${moduleName}</p>
					<P class="text_p">${lessonName}</P>
				</div>
				<div class="a_b_btn">
					
					<c:if test="${joinStatus==0}">
						<a href="javascript:addCourse(this)">
							<i><img src="${ctx}/images/wx/add_icon.png"/></i>
							加入课程表
						</a>
					</c:if>
					<c:if test="${joinStatus==1}">
						<c:if test="${studyType!=null&&studyType==1}">
							<a href="javascript:removeCourse(this)">
								<i><img src="${ctx}/images/wx/quit_icon.png"/></i>
								移出课程表
							</a>
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		<div class="det_box_b">
			<h3>课程介绍：</h3>
			<div class="kc_text">
				<p class="hideCon">${lessonDesc}</p>
				<span class="down_icon"><img src="${ctx}/images/wx/down_icon.png"/></span>
			</div>
		</div>
		<div class="det_box_c">
			<c:forEach items="${listPoint}" var="point" varStatus="status">
				<div class="c_main clearfix" onclick="toCourse(${point.id})">
					<c:if test="${status.index==0}">
						<div class="c_main_l c_main_l_first <c:if test="${point.study_state==1}">c_main_l_f_color</c:if>"></div>
					</c:if>
					<c:if test="${status.index>0&&status.index<(fn:length(listPoint)-1)}">
						<div class="c_main_l c_main_l_center <c:if test="${point.study_state==1}">c_main_l_c_corlor</c:if>"></div>
					</c:if>
					<c:if test="${status.index>0&&status.index==(fn:length(listPoint)-1)}">
						<div class="c_main_l c_main_l_last <c:if test="${point.study_state==1}">c_main_l_c_corlor</c:if>"></div>
					</c:if>
					<div class="c_main_r clearfix">
						<div class="video_box">
							<img src="${pic}${point.img_url}" width="100%" height="56px;"/>
							<div class="video_text">
								<i><img src="${ctx}/images/wx/video_icon.png"/></i>
								<span>${point.when_long_str}</span>
							</div>
						</div>
						<div class="video_box_a">${point.name}</div>
					</div>
					<c:if test="${point.study_state==1}"><b class="yuan_icon_on"></b></c:if>
					<c:if test="${point.study_state!=1}"><b class="yuan_icon"></b></c:if>
					
				</div>
				
			</c:forEach>
		</div>
	</div>
	<!-- 底部菜单 -->
    <%@ include file="/WEB-INF/page/common/wx_footer.jsp" %>
</div>
<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/wx/iscroll.js"></script>
<script src="${ctx}/js/weui.min.js"></script>
<script type="text/javascript">

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
       window.onload=function(){
       	 var swiper = new Swiper('#swiper-container1', {
	        pagination: '.swiper-pagination',
	        paginationClickable: true,
	        spaceBetween: 0,
	        centeredSlides: true,
	        autoplay: 2500,
	        autoplayDisableOnInteraction: false,
	        loop: true
	    });  

        //手滑动
        var swiper = new Swiper('.swiper-container2', {
	        slidesPerView: 2.5,
	        paginationClickable: true,
	        spaceBetween: 10,
	        freeMode: true
	    });
       }

       //tab切换
       $(".cur_list_lis li").click(function(){
            $(this).addClass("li_on").siblings().removeClass("li_on");
            var index = $(this).index();
            $(".cur_main").find(".cur_showBox").eq(index).show().siblings().hide();
             event.stopPropagation();
        })
       $('.down_icon').on('click',function(){
       		$('.kc_text p').toggleClass('hideCon');
       		$(this).find("img").toggleClass('s_Img');
       })
		
        
    });

    function addCourse(obj){
 	   $.post("<c:url value='/weixin/operation'/>",
	        	{
 		   lessonId : '${lessonId}',
 		   type : 0,
	 			 _t:Math.random()},
	 	       	function(data){
	 	        	var result = eval('('+data+')'); 
	 	            if (result.c == '0') {
	 	            	weui.alert("添加成功!");
	 	            	window.location.href = "${ctx}/weixin/toCourse";
// 	 	            	$(obj).html("<i><img src='${ctx}/images/wx/quit_icon.png'/></i>移出课程表");
	 	             } else {
	 	            	 weui.alert(result.message);
	 	             }
	        });
    }
    
		function removeCourse(obj){
			weui.dialog({
			    title: '提示',
			    content: '确定要移除课程吗？',
			    className: 'custom-classname',
			    buttons: [{
			        label: '取消',
			        type: 'default',
			        onClick: function () { }
			    }, {
			        label: '确定',
			        type: 'primary',
			        onClick: function () { 
			        	$.post("<c:url value='/weixin/operation'/>",
				   	        	{
				    		   lessonId : '${lessonId}',
				    		   type : 1,
				   	 			 _t:Math.random()},
				   	 	       	function(data){
				   	 	        	var result = eval('('+data+')'); 
				   	 	            if (result.c == '0') {
				   	 	            	weui.alert("移除成功!");
				   	 	            	window.location.href = "${ctx}/weixin/toCourse";
// 				   	 	            	$(obj).html("<i><img src='${ctx}/images/wx/add_icon.png'/></i>加入课程表");
				   	 	             } else {
				   	 	            	 weui.alert(result.message);
				   	 	             }
				   	        });
			        	
			        }
			    }]
			});
    }
		
		function toCourse(pointId){
			window.location.href = "${ctx}/weixin/toVideo?id="+pointId;
		}
</script>
</body>
</html>