<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="format-detection" content="telephone=no" />
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/weui.css">
	<style type="text/css">
	img {
	    -webkit-transform: scale(1) rotate(0) translate3d(0,0,0);
	    transform: scale(1) rotate(0) translate3d(0,0,0);
	}
	</style>
</head>
<body style="background:#fff;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper">
    <div class="content_order">
        <div class="login_box">
            <img src="${ctx}/images/wx/login_icon.png?t=<%=Math.random()%>" style="width: 118px;height: 32px;"/>
        </div> 
        <div class="content_order_list clearfix">
            <span class="sp_l" id="numberPicker" style="position:relative;">
                <lable>+86</lable>
                <b class="triangle-down"></b>
            </span>
            <div class="sp_r sp_r1">
                <input type="text" class="order_input1" placeholder="请输入手机号" id="mobile"/>
            </div>
        </div>            
        <div class="content_order_list clearfix">
            <span class="sp_l">
                <lable>验证码</lable>
            </span>
            <div class="sp_r sp_r1" style="width:33%;">
                <input type="text" class="order_input1" placeholder="请输入验证码" id="code"/>
            </div>
            <div class="bind_btn_box">
                <input type="button" class="bind_btn" value="获取短信验证码" onclick="getCode()" id="codeBtn"/>
            </div>
        </div>   
    </div>
    <div class="weui-dialog__btn weui-dialog__btn_primary receive_btn_phone">
        <a href="javascript:save();">登录</a>
    </div>
<!--     <div class="weui-dialog__btn weui-dialog__btn_primary receive_btn_wechat"> -->
<!--         <a href="">微信登录</a> -->
<!--     </div> -->
</div>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/weui.min.js"></script>
<script type="text/javascript" class="picker js_show">
 $(document).ready(function(){
	
	    
 });
 var flagSubmit = true;
 function save(){
 	var mobile = $("#mobile").val();
 	if(mobile==""){
 		weui.alert("请输入手机号");
 		$("#mobile").focus();
 	  	return false;
 	}else{
 		if(!validatemobile(mobile)){
 			weui.alert("请输入正确的手机号");
 			$("#mobile").focus();
 			return false;
 		}
 	}
 	var code = $("#code").val();
 	if(code==""){
 		weui.alert("请输入验证码");
 	  	return false;
 	}
 	if(flagSubmit){
 		flagSubmit = false;
 		var loading = weui.loading('数据处理中', {
 		    className: 'custom-classname'
 		});
 		$.post("<c:url value='/weixin/login'/>",
        	{
 	   		openId : '${openId}',
 	   		mobile : mobile,
 	   		code : code,
 			 _t:Math.random()},
 	       	function(data){
 				loading.hide();
 				flagSubmit = true;
 	        	var result = eval('('+data+')'); 
 	            if (result.c == '0') {
 	            	weui.alert("登录成功!");
 	            	window.location.href = "${ctx}/weixin/toLearn?openId=${openId}";
 	             } else {
 	            	 weui.alert(result.m);
 	             }
        });
 	}
 }
 var dxflag = true;
 function getCode(){
 	var phone = $.trim($("#mobile").val());
 	if(phone == ''){
 		weui.alert("请输入手机号");
 		$("#phone").focus();
 		return false;
 	}else{
 		if(!validatemobile(phone)){
 			weui.alert("请输入正确的手机号");
 			$("#phone").focus();
 			return false;
 		}
 	}
 	if(dxflag){
 		dxflag = false;
 		$.get("<c:url value='/api/user/sendsms'/>",
 	   	{
 			mobile : phone,
 			_t:Math.random()},
 	    	function(data){
 			dxflag = true;
 	     	var result = eval('('+data+')'); 
 	         if (result.c == '0') {
 	        	$("#code").val(result.d);
 	         	btnNum();
 	         	weui.alert("发送成功，请注意查收验证码");
 	          } else {
 	        	 countdown = 0;
 	         	 weui.alert(result.m);
 	          }
 	   });
 	}
 }
 function btnNum(){
 	var num = 59;
//  	$("#codeBtn").attr('disabled',true);
 	$("#codeBtn").removeAttr('onclick');
 	$("#codeBtn").val('还剩'+num-- +'秒');
 	var intervalID = setInterval(function(){
 		if(num>0){
//  			$("#codeBtn").attr('disabled',true);
//  			$("#codeBtn").attr('onclick','');
 			$("#codeBtn").val('还剩'+num+'秒');
//  			$("#codeBtn").css('background','#b6b6b6');
 			num--;
 		}else{
 			$("#codeBtn").val('获取验证码');
//  			$("#codeBtn").attr('disabled',false);
 			$("#codeBtn").attr('onclick','getCode()');
//  			$("#codeBtn").css('color','#31b962');
 			clearInterval(intervalID)
 		}
 	}, 1000);
 }
 function validatemobile(mobile){ 
 	if (mobile.length == 0) {
 		return false;
 	}
 	if (mobile.length != 11) {
 		return false;
 	}
 	var myreg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[0-9]|18[0-9]|14[57])[0-9]{8}$/;
 	if (!myreg.test(mobile)) {
 		return false;
 	}
 	return true;
 }
 
 function golearn(){
	 window.location.href = "${ctx}/weixin/toLearn?openId=${openId}";
 }
</script>
</body>
</html>