<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>注册</title>
	<link rel="stylesheet" href="${ctx}/plus/layui/css/layui.css"  media="all">
	<link rel="stylesheet" href="${ctx}/plus/layui/global.css">
</head>
<body style="background:#fff;margin-top: 0px; ">

	<div class="layui-carousel" id="test10">
  		<div carousel-item="">
		    <div><img src="${ctx}/plus/layui/demo/1.png" width="100%" height="100%"></div>
		    <div><img src="${ctx}/plus/layui/demo/3.png" width="100%" height="100%"></div>
		    <div><img src="${ctx}/plus/layui/demo/5.png" width="100%" height="100%"></div>
  		</div>
	</div>
	
	<fieldset class="layui-elem-field" style="margin-top: 10px;">
		<legend>选择注册类型</legend>
		<div class="layui-field-box">
			<div class="fly-panel">
				<div class="fly-panel-main">
					<a href="http://layim.layui.com/?from=fly" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">批发商（每月99元）</a>
				</div>
			</div>
		</div>
		
		<div class="layui-field-box">
			<div class="fly-panel">
				<div class="fly-panel-main">
					<a href="http://layim.layui.com/?from=fly" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #205B95;">零售商（每月79元）</a>
				</div>
			</div>
		</div>
		
		<div class="layui-field-box">
			<div class="fly-panel">
				<div class="fly-panel-main">
					<a href="http://layim.layui.com/?from=fly" class="fly-zanzhu" time-limit="2017.09.25-2099.01.01" style="background-color: #FF7033;">电商代理（每月59元）</a>
				</div>
			</div>
		</div>
	</fieldset>



	<script src="${ctx}/js/wx/swiper.min.js"></script>
	<script src="${ctx}/js/wx/jquery.min.js"></script>
	<script src="${ctx}/plus/layui/layui.js"></script>
	<script>
	layui.use(['carousel', 'form'], function(){
	  var carousel = layui.carousel,form = layui.form;
	  //图片轮播
	  carousel.render({
	    elem: '#test10'
	    ,width: '100%'
	    ,height: '180px'
	    ,interval: 3000
	  });
	  
	});
	</script>
</body>
</html>