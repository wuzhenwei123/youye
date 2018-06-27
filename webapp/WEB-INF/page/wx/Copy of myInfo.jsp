<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>个人中心</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
</head>
<body style="background:#f9f9f9;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
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
<!-- 			<a href="" class="message"><img src="${admin_user.head_img}"/></a> -->
		</div>	
		<div class="personal_nav">
	        <div class="nav_t clearfix">
	        	<span class="nav_t_l">学习记录</span>
<!-- 	        	<span class="nav_t_r"> -->
<!-- 	        		<img src="${ctx}/images/wx/waterdrop_icon.png"> -->
<!-- 	        		<b>32</b>能量泉 -->
<!-- 	        	</span> -->
	        </div>
	        <ul class="clearfix">
	            <li>
	                <span><b>${studyTimeCount}</b>分</span>
	                <em>学习总时长</em>
	            </li>
	            <li>
	                <span><b>${lessonCount}</b>个</span>
	                <em>完成课程</em>
	            </li>
	            <li>
	                <span><b>0</b>次</span>
	                <em>提交改善</em>
	            </li>
	        </ul>
	    </div>
<!-- 	    <div class="personal_rank"> -->
<!-- 	    	<h2>本周学习排行</h2> -->
<!-- 	    	<table border="0" cellspacing="0" cellpadding="0" class="tab1"> -->
<!-- 	    		 <tbody> -->
<!-- 		    		<tr class="tab1_tr"> -->
<!-- 		    			<td class="tab1_td_f"></td> -->
<!-- 		    			<td>成员</td> -->
<!-- 		    			<td>学习时间</td> -->
<!-- 		    			<td>完成课程</td> -->
<!-- 		    			<td>提交改善</td> -->
<!-- 		    		</tr> -->
<!-- 		    		<tr> -->
<!-- 		    			<td class="tab1_td_f"> -->
<!-- 		    				<div class="medel_icon"> -->
<!-- 		    					<img src="${ctx}/images/wx/medal_icon.png"/> -->
<!-- 		    				</div> -->
<!-- 		    			</td> -->
<!-- 		    			<td>小张</td> -->
<!-- 		    			<td>3.5</td> -->
<!-- 		    			<td>2</td> -->
<!-- 		    			<td>8</td> -->
<!-- 		    		</tr> -->
<!-- 		    		<tr> -->
<!-- 		    			<td class="tab1_td_f"> -->
<!-- 		    				<div class="medel_icon"> -->
<!-- 		    					<img src="${ctx}/images/wx/medal_icon1.png"/> -->
<!-- 		    				</div> -->
<!-- 		    			</td> -->
<!-- 		    			<td>小张</td> -->
<!-- 		    			<td>3.5</td> -->
<!-- 		    			<td>2</td> -->
<!-- 		    			<td>8</td> -->
<!-- 		    		</tr> -->
<!-- 		    		<tr> -->
<!-- 		    			<td class="tab1_td_f"> -->
<!-- 		    				<div class="medel_icon"> -->
<!-- 		    					<img src="${ctx}/images/wx/medal_icon2.png"/> -->
<!-- 		    				</div> -->
<!-- 		    			</td> -->
<!-- 		    			<td>小张</td> -->
<!-- 		    			<td>3.5</td> -->
<!-- 		    			<td>2</td> -->
<!-- 		    			<td>8</td> -->
<!-- 		    		</tr> -->
<!-- 					<tr> -->
<!-- 						<td><div style="padding:10px 0;"></div></td> -->
<!-- 					</tr> -->
<!-- 		    		<tr class="tab1_tr_my"> -->
<!-- 		    			<td class="tab1_td_f"> -->
<!-- 		    				15 -->
<!-- 		    			</td> -->
<!-- 		    			<td>我</td> -->
<!-- 		    			<td>3.5</td> -->
<!-- 		    			<td>2</td> -->
<!-- 		    			<td>8</td> -->
<!-- 		    		</tr> -->
<!-- 	    		</tbody> -->
<!-- 	    	</table> -->
<!-- 	    </div> -->
	    <div class="personal_list_box">
	        <div class="personal_list clearfix" onclick="toTeam()">
	            <a href="javascript:;" style="display:block;">
	                <div class="personal_left"><i><img src="${ctx}/images/wx/team_icon.png"/></i>团队管理</div>
	                <div class="personal_right"><span><img src="${ctx}/images/wx/jt_icon.png"></span></div>
	            </a>
	        </div>
<!-- 	        <div class="personal_list clearfix"> -->
<!-- 	            <a href="" style="display:block;"> -->
<!-- 	                <div class="personal_left"><i><img src="${ctx}/images/wx/waterdrop_icon_a.png"/></i>我的能量</div> -->
<!-- 	                <div class="personal_right"><span><img src="${ctx}/images/wx/jt_icon.png"></span></div> -->
<!-- 	            </a> -->
<!-- 	        </div> -->
	        <div class="personal_list clearfix" onclick="toStudyRecord()">
	            <a href="javascript:;" style="display:block;">
	                <div class="personal_left"><i><img src="${ctx}/images/wx/history_icon.png"/></i>学习记录</div>
	                <div class="personal_right"><span><img src="${ctx}/images/wx/jt_icon.png"></span></div>
	            </a>
	        </div>
	        <div class="personal_list clearfix" onclick="toSetting()">
	            <a href="javascript:;" style="display:block;">
	                <div class="personal_left"><i><img src="${ctx}/images/wx/setting_icon.png"/></i>个人设置</div>
	                <div class="personal_right"><span><img src="${ctx}/images/wx/jt_icon.png"></span></div>
	            </a>
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

       //tab切换
       $(".cur_list_lis li").click(function(){
            $(this).addClass("li_on").siblings().removeClass("li_on");
            var index = $(this).index();
            $(".cur_main").find(".cur_showBox").eq(index).show().siblings().hide();
             event.stopPropagation();
        })

        
    });

    function toStudyRecord(){
    	window.location.href = '${ctx}/weixin/toStudyRecord';
    }
    function toSetting(){
    	window.location.href = '${ctx}/weixin/toSetting';
    }
    function toTeam(){
    	window.location.href = '${ctx}/weixin/toTeamAnalytics';
    }
</script>
</body>
</html>