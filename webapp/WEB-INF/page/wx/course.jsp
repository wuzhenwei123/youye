<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>课程</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
	<style type="text/css">
	.l_box img {
		width:100.19px !important;
	}
	</style>
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
<!-- 							        	<p>最新上架：</p> -->
<!-- 							        	<p class="t_p">${banner.theme_name} / ${banner.module_name} /</p> -->
<!-- 							        	<P class="t_p1">${banner.name}</P> -->
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
			<div class="weui-tabbar cur_list_lis">
				<c:forEach items="${listTheme}" var="theme" varStatus="status">
					<c:set var="index" value="${status.index+1}"></c:set>
					<a href="${ctx}/weixin/toCourse?theme_id=${theme.id}" class="weui-tabbar__item <c:if test="${theme_id==theme.id}">li_on${index}</c:if>">
						<i class="<c:if test="${theme.id!=theme_id}">lis_icon${index}</c:if><c:if test="${theme.id==theme_id}">lis_icon${index}_on</c:if>"></i>
						<p class="li_p">${theme.name }</p>
					</a>
						
					
				</c:forEach>
<!-- 				<a href="${ctx}/weixin/toCourse?theme_id=3" class="weui-tabbar__item <c:if test="${theme_id==3}">li_on1</c:if>"> -->
<!-- 					<i class="<c:if test="${theme_id!=3}">lis_icon1</c:if><c:if test="${theme_id==3}">lis_icon1_on</c:if>"></i> -->
<!-- 					<p class="li_p">通用</p> -->
<!-- 				</a> -->
<!-- 				<a href="${ctx}/weixin/toCourse?theme_id=4" class="weui-tabbar__item <c:if test="${theme_id==4}">li_on2</c:if>"> -->
<!-- 					<i class="<c:if test="${theme_id!=4}">lis_icon2</c:if><c:if test="${theme_id==4}">lis_icon2_on</c:if>"></i> -->
<!-- 					<p>领导力</p> -->
<!-- 				</a> -->
<!-- 				<a href="${ctx}/weixin/toCourse?theme_id=8" class="weui-tabbar__item <c:if test="${theme_id==8}">li_on3</c:if>"> -->
<!-- 					<i class="<c:if test="${theme_id!=8}">lis_icon3</c:if><c:if test="${theme_id==8}">lis_icon3_on</c:if>"></i> -->
<!-- 					<p>运营</p> -->
<!-- 				</a> -->
<!-- 				<a href="${ctx}/weixin/toCourse?theme_id=6" class="weui-tabbar__item <c:if test="${theme_id==6}">li_on4</c:if>"> -->
<!-- 					<i class="<c:if test="${theme_id!=6}">lis_icon4</c:if><c:if test="${theme_id==6}">lis_icon4_on</c:if>"></i> -->
<!-- 					<p>人力资源</p> -->
<!-- 				</a> -->
<!-- 				<a href="${ctx}/weixin/toCourse?theme_id=7" class="weui-tabbar__item <c:if test="${theme_id==7}">li_on5</c:if>"> -->
<!-- 					<i class="<c:if test="${theme_id!=7}">lis_icon5</c:if><c:if test="${theme_id==7}">lis_icon5_on</c:if>"></i> -->
<!-- 					<p>财务</p> -->
<!-- 				</a> -->
<!-- 				<a href="${ctx}/weixin/toCourse?theme_id=5" class="weui-tabbar__item <c:if test="${theme_id==5}">li_on6</c:if>"> -->
<!-- 					<i class="<c:if test="${theme_id!=5}">lis_icon6</c:if><c:if test="${theme_id==5}">lis_icon6_on</c:if>"></i> -->
<!-- 					<p>精益</p> -->
<!-- 				</a> -->
			</div>
			<div class="cur_main">
				<div class="cur_showBox">
					<c:forEach items="${listSub1}" var="cc">
						<div class="cur_mains">
							<h3>${cc.name}</h3>
							<div class="cur_mains_l">
								<div class="swiper-container swiper-container2">
							        <div class="swiper-wrapper">
							        	<c:forEach items="${cc.listSub}" var="ccSub">
							        		<div class="swiper-slide" onclick="toCourse(${ccSub.id})">
								            	<div class="l_box">
								            		<img src="${pic}${ccSub.img_url}" width="100.19px" height="70px" onerror="javascript:this.src='${ctx}/images/wx/ty_pic.png'"/>	
								            	</div>
								            	<p class="l_text">${ccSub.name}</p>
								            </div>
							        		
							        	</c:forEach>
							            
							        </div>
							    </div>
							</div>
						</div>
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

       // //tab切换
       // $(".cur_list_lis li").click(function(){
       //      $(this).addClass("li_on").siblings().removeClass("li_on");
       //      var index = $(this).index();
       //      $(".cur_main").find(".cur_showBox").eq(index).show().siblings().hide();
       //       event.stopPropagation();
       //  })

        
    });
    function toCourse(pointId){
		window.location.href = "${ctx}/weixin/toLessonDetail?lessonId="+pointId;
	}
</script>
</body>
</html>