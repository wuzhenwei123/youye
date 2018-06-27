<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>学习</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
</head>
<body style="background:#fff;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper">
	<div class="cur_box_all">
		<div class="cur_box">
			<div class="com_box">
		        <div class="swiper-container" id="swiper-container1">
		            <div class="swiper-wrapper">
		                <c:forEach var="banner" items="${listBanner }">
		                	<div class="swiper-slide">
			                	<a href="${ctx}/weixin/toLessonDetail?lessonId=${banner.id}">
			                		<img src="${pic}${banner.img_url}" width="100%" height="160px" onerror="javascript:this.src='${ctx}/images/wx/banner.jpg'"/>
			                		<div class="cur_box_text">
							        	<p>最新上架：</p>
							        	<p class="t_p">${banner.theme_name} / ${banner.module_name} /</p>
							        	<P class="t_p1">${banner.name}</P>
							        </div>
							    </a>
							</div>
		                </c:forEach>
		            </div>
		            <!-- Add Pagination -->
		            <div class="swiper-pagination"></div>
		        </div>
		    </div>
		</div>
		<div class="cur_list">
			<div class="learn_lis clearfix">
				<li class="l_on" style="list-style:none">我的必修课</li>
				<li style="list-style:none">我的选修课</li>
			</div>	
			<div class="learn_com">
				<div class="learn_com_box">
					<c:forEach items="${listB}" var="bx">
						<a href="${ctx}/weixin/toLessonDetail?lessonId=${bx.course_classify_id}">
							<div class="learn_com_main">
								<div class="learn_com_mains learn_com_mains_on clearfix">
									<div class="mains_l">
										<p class="learn_p"><img width="36px;" height="36px;" src="${pic}${bx.img_url}" onerror="javascript:this.src='${ctx}/images/wx/learn_icon.png'"/></p>	
									</div>
									<div class="mains_r">
										<div class="mains_rt clearfix">
											<span class="mains_rt_t"><b class="t_b">${bx.moduleName}</b> / ${bx.lessonName}</span>
											<span class="mains_rt_t1">完成${bx.studyProgress}/${bx.studyCount}  剩余${bx.overDays}天</span>
										</div>
										<div class="mains_rb">
											<div class="weui-progress">
									            <div class="weui-progress__bar">
									                <div class="weui-progress__inner-bar js_progress" style="width: <fmt:formatNumber value='${(bx.studyProgress/bx.studyCount)*100}' pattern='#'/>%;"></div>
									            </div>
									        </div>
										</div>
									</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
				<div class="learn_com_box dn">
					<c:forEach items="${listX}" var="bx">
						<a href="${ctx}/weixin/toLessonDetail?lessonId=${bx.course_classify_id}">
							<div class="learn_com_main">
								<div class="learn_com_mains learn_com_mains_on clearfix">
									<div class="mains_l">
										<p class="learn_p"><img width="36px;" height="36px;" src="${pic}${bx.img_url}"  onerror="javascript:this.src='${ctx}/images/wx/learn_icon.png'"/></p>	
									</div>
									<div class="mains_r">
										<div class="mains_rt clearfix">
											<span class="mains_rt_t"><b class="t_b">${bx.moduleName}</b> / ${bx.lessonName}</span>
											<span class="mains_rt_t1">完成${bx.studyProgress}/${bx.studyCount}</span>
										</div>
										<div class="mains_rb">
											<div class="weui-progress">
									            <div class="weui-progress__bar">
									                <div class="weui-progress__inner-bar weui-progress__inner-bar1 js_progress" style="width: <fmt:formatNumber value='${(bx.studyProgress/bx.studyCount)*100}' pattern='#'/>%;"></div>
									            </div>
									        </div>
										</div>
									</div>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</div>		
		</div>
	</div>
	<!-- 底部菜单 -->
    <%@ include file="/WEB-INF/page/common/wx_footer.jsp" %>
</div>
<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
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

    });

</script>
</body>
</html>