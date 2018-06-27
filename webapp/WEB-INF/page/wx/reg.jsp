<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="format-detection" content="telephone=no" />
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/weui.css">
</head>
<body style="background:#fff;">
<%-- <%@ include file="/WEB-INF/page/common/share1.jsp" %> --%>
<div class="wrapper">
    <div class="content_order" style="padding-bottom:70px">
        <div class="content_order_list clearfix" style="border-bottom:0;">
            <span class="sp_l" style="10%">
                <lable>公司</lable>
            </span>
            <div class="sp_r">
                <span class="sp_r_p">
                    <lable>${yyCompany.name}</lable>
                </span>
            </div>
        </div>
        <div class="content_order_list clearfix" style="border-bottom:0;">
            <span class="sp_l">
                <lable>直属上级</lable>
            </span>
            <div class="sp_r sp_r1">
                <span class="">
                    <lable>${yyUser.name}</lable>
                </span>
            </div>
        </div>    
        <div class="content_order_list clearfix">
            <span class="sp_l">
                <lable>姓名</lable>
            </span>
            <div class="sp_r sp_r1">
                <input type="text" class="order_input1" placeholder="请填写真实姓名" id="name"/>
            </div>
        </div>
        <div class="content_order_list clearfix">
            <span class="sp_l">
                <lable>部门</lable>
            </span>
            <div class="sp_r sp_r1">
                <input type="text" class="order_input1" placeholder="请填写部门名称" id="department"/>
            </div>
        </div>
        <div class="content_order_list_all">
        	<div class="content_order_list clearfix" id="content_order_list">
	            <span class="sp_l" style="position:relative;">
	                <lable>职能</lable>
	            </span>
	            <div class="sp_r sp_r1">
	                <input type="text" readonly="readonly" class="order_input1" id="cascadePickerBtn" placeholder="请选择职能"/>
	            </div>
            </div>
            <a href="javascript:void(0);" class="tk_add"><img src="${ctx}/images/wx/add_icon1.png"/></a>
        </div>
        <div class="content_order_list clearfix">
            <span class="sp_l" id="numberPicker" style="position:relative;">
                <lable>+86</lable>
                <b class="triangle-down"></b>
            </span>
            <div class="sp_r sp_r1">
                <input type="text" class="order_input1" placeholder="请输入手机号" id="phone"/>
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
    <div class="weui-dialog__btn weui-dialog__btn_primary receive_btn_tj">
        <a href="javascript:save();">确认提交</a>
    </div>
</div>
<input type="hidden" id="fp">
<input type="hidden" id="fc">
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/weui.min.js"></script>
<script type="text/javascript" class="picker js_show">
if (typeof WeixinJSBridge == "undefined"){
   if( document.addEventListener ){
       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
   }else if (document.attachEvent){
       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
   }
}else{
	   onBridgeReady();
}

function closeWin(){
	WeixinJSBridge.call('closeWindow');
}
function onBridgeReady(){
}
$(document).ready(function(){
// 	var arrayAll = '${arrayAll}';
// 	var location_p = eval("("+arrayAll+")");
    // 地区
	document.querySelector('#cascadePickerBtn').addEventListener('click', function () {
	    weui.picker(${arrayAll}, {
	        depth: 2,
	        onChange: function onChange(result) {
// 	            console.log(result);
	        },
	        onConfirm: function onConfirm(result) {
	        	var fp = result[0];
	        	$("#fp").val(fp);
	        	var fc = result[1];
	        	$("#fc").val(fc);
	        	var html = "";
	        	var location_p1 = JSON.stringify(${arrayAll});
	        	var location_p = JSON.parse(location_p1);
	        	for(var i =0;i<location_p.length;i++){
	        		if(location_p[i].value==fp){
	        			html = location_p[i].label;
	        			var children_c = location_p[i].children;
	        			for(var j =0;j<children_c.length;j++){
	        				if(children_c[j].value==fc){
	        					html = html + " · " + children_c[j].label;
	        				}
	        			}
	        		}
	        	}
	        	$("#cascadePickerBtn").val(html);
	        },
	    });
	});
 });
 
var flagSubmit = true;
function save(){
	var name = $("#name").val();
	if(name==""){
		weui.alert("请填写姓名");
	  	return false;
	}
	var department = $("#department").val();
	if(department==""){
		weui.alert("请填写部门名称");
	  	return false;
	}
	
  	var fp = $("#fp").val();
	if(fp==""){
		weui.alert("请选择职能");
	  	return false;
	}
	var phone = $("#phone").val();
	if(phone==""){
		weui.alert("请输入手机号");
	  	return false;
	}
	var code = $("#code").val();
	if(code==""){
		weui.alert("请输入验证码");
	  	return false;
	}
	var fc = "";
	$("input:hidden").each(function(){
		if(fc==""){
			fc = $(this).val();
		}else{
			fc = fc + "," + $(this).val();
		}
	})
	if(flagSubmit){
		flagSubmit = false;
		var loading = weui.loading('数据处理中', {
		    className: 'custom-classname'
		});
		$.post("<c:url value='/yyUser/reg'/>",
       	{
	   		name : name,
	   		fp : fp,
	   		fc : fc,
	   		openId : '${openId}',
	   		company_id : '${company_id}',
	   		parent_id : '${parent_id}',
	   		phone : phone,
	   		company_name : '${yyCompany.name}',
	   		parent_name : '${yyUser.name}',
	   		code : code,
	   		department : department,
			 _t:Math.random()},
	       	function(data){
				loading.hide();
				flagSubmit = true;
	        	var result = eval('('+data+')'); 
	            if (result.code == '0') {
	            	weui.alert("提交成功!");
	            	setTimeout(closeWin(),3000);
	             } else {
	            	 weui.alert(result.message);
	             }
       });
	}
}
var dxflag = true;
function getCode(){
	var phone = $.trim($("#phone").val());
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
		$.get("<c:url value='/weixin/sendsms'/>",
	   	{
			mobile : phone,
			_t:Math.random()},
	    	function(data){
			dxflag = true;
	     	var result = eval('('+data+')'); 
	         if (result.c == '0') {
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
	var num = 179;
// 	$("#codeBtn").attr('disabled',true);
	$("#codeBtn").removeAttr('onclick');
	$("#codeBtn").val('还剩'+num-- +'秒');
	var intervalID = setInterval(function(){
		if(num>0){
// 			$("#codeBtn").attr('disabled',true);
// 			$("#codeBtn").attr('onclick','');
			$("#codeBtn").val('还剩'+num+'秒');
// 			$("#codeBtn").css('background','#b6b6b6');
			num--;
		}else{
			$("#codeBtn").val('获取验证码');
// 			$("#codeBtn").attr('disabled',false);
			$("#codeBtn").attr('onclick','getCode()');
// 			$("#codeBtn").css('color','#31b962');
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
var i = 0;
$(".tk_add").click(function(){
	i = i + 1;
    $(".content_order_list_all").append($("#content_order_list").first().clone());
    $(".content_order_list_all").find(".content_order_list").each(function(index){
    	if(index==i){
    		$(this).find(".order_input1").attr("id","cascadePickerBtn"+index);
    		$("#cascadePickerBtn"+index).val('');
    		document.querySelector('#cascadePickerBtn'+i).addEventListener('click', function () {
    		    weui.picker(${arrayAll}, {
    		        depth: 2,
    		        onChange: function onChange(result) {
//    	 	            console.log(result);
    		        },
    		        onConfirm: function onConfirm(result) {
    		        	var fp = result[0];
    		        	$("#content_order_list").append("<input type='hidden' id='fp"+index+"' value='"+fp+"'>");
    		        	var fc = result[1];
    		        	$("#content_order_list").append("<input type='hidden' id='fc"+index+"' value='"+fc+"'>");
    		        	var html = "";
    		        	var location_p1 = JSON.stringify(${arrayAll});
    		        	var location_p = JSON.parse(location_p1);
    		        	for(var i =0;i<location_p.length;i++){
    		        		if(location_p[i].value==fp){
    		        			html = location_p[i].label;
    		        			var children_c = location_p[i].children;
    		        			for(var j =0;j<children_c.length;j++){
    		        				if(children_c[j].value==fc){
    		        					html = html + " · " + children_c[j].label;
    		        				}
    		        			}
    		        		}
    		        	}
    		        	$("#cascadePickerBtn"+index).val(html);
    		        },
    		    });
    		});
    	}
    })
   
});
</script>
</body>
</html>