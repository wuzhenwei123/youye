<%@page import="com.base.utils.ConfigConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!doctype html>
<html lang="zh-CN">
<head>
	<meta charset="utf-8"> 
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<meta name="format-detection" content="telephone=no" />
	<title>设置</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/common.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/style.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/weui.css">
	<link rel="stylesheet" type="text/css" href="${ctx}/css/wx/new/swiper.min.css">
</head>
<body style="background:#fff;">
<%@ include file="/WEB-INF/page/common/share1.jsp" %>
<div class="wrapper">
	<div class="se_box">
		<div class="se_box_a clearfix">
			<div class="se_box_al">
				<span class="pic_text">头像：<b>点击更换</b></span>
			</div>
			<div class="se_box_ar" onclick="uploadImg()">
				<img src="${admin_user.head_img}" id="pic" onerror="javascript:this.src='${ctx}/images/wx/photo1.jpg'"/>
			</div>
		</div>
		<form action="#" method="post" id="add-form" enctype="multipart/form-data">
			<div style="display: none;">
				<input id="upload" name="file" type="file" accept="image/jpg,image/jpeg,image/png,image/gif" />
			</div>
		</form>
<!-- 		<div class="se_box_a clearfix" style="padding:15px 20px;line-height: 30px;"> -->
<!-- 			<div class="se_box_als"> -->
<!-- 				<span class="pic_text">仅在Wi—Fi下观看视频</span> -->
<!-- 			</div> -->
<!-- 			<div class="se_box_ar"> -->
<!-- 				<div class="weui-cell__ft"> -->
<!-- 	                <label for="switchCP" class="weui-switch-cp"> -->
<!-- 	                    <input id="switchCP" class="weui-switch-cp__input" type="checkbox" checked="checked"> -->
<!-- 	                    <div class="weui-switch-cp__box"></div> -->
<!-- 	                </label> -->
<!-- 	            </div> -->
<!--             </div> -->
<!-- 		</div> -->
	</div>
	<div class="weui-dialog__btn weui-dialog__btn_primary receive_btn_wechat">
        <a href="javascript:unBind()">解除绑定</a>
    </div>
</div>
<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/js/wx/iscroll.js"></script>
<script src="${ctx}/js/weui.min.js"></script>
<script type="text/javascript">
function uploadImg(){
	$("#upload").click();
}
$("#upload").on("change",function(){
	var objUrl = getObjectURL(this.files[0]) ; //获取图片的路径，该路径不是图片在本地的路径
	if (objUrl) {
		ajaxFileUpload(objUrl);
// 		$("#pic").attr("src", objUrl) ; //将图片路径存入src中，显示出图片
	}
});

function ajaxFileUpload(objUrl) {
	var loading = weui.loading('上传中', {
	    className: 'custom-classname'
	});
	var server_path = '<%=ConfigConstants.URL_PATH%>';
	var formData = new FormData($( "#add-form" )[0]); 
	$.ajax({  
		url : "${ctx}/upload/exec?proVal=web_pic",  
		type : 'POST',  
		data : formData,  
		processData : false,  
		contentType : false,  
		dataType : 'json',  
		success : function(data) { 
	    	var result = data;
	        if (result.code == '1') {
	        	var item = result.list[0];
	        	$.post("<c:url value='/weixin/updateAvatar'/>",
                	{
	        		avatarUrl : server_path + "/pic" + item.filePath,
         			 _t:Math.random()},
         	       	function(data){
         				$("#pic").attr("src", objUrl)
         				loading.hide();
                });
	         } else {
	        	 tipError('上传失败');
	         }
		}
	});
}

//建立一個可存取到該file的url
function getObjectURL(file) {
	var url = null ;
	if (window.createObjectURL!=undefined) { // basic
		url = window.createObjectURL(file) ;
	} else if (window.URL!=undefined) { // mozilla(firefox)
		url = window.URL.createObjectURL(file) ;
	} else if (window.webkitURL!=undefined) { // webkit or chrome
		url = window.webkitURL.createObjectURL(file) ;
	}
	return url ;
}

function unBind(){
	weui.dialog({
	    title: '提示',
	    content: '确定要解除绑定？',
	    className: 'custom-classname',
	    buttons: [{
	        label: '取消',
	        type: 'default',
	        onClick: function () {}
	    }, {
	        label: '确定',
	        type: 'primary',
	        onClick: function () {
	        	$.post("${ctx}/weixin/unBind",
                	{
         			 _t:Math.random()},
         	       	function(data){
         	        	var result = eval('('+data+')'); 
         	            if (result.c == '0') {
         	            	weui.alert("解除成功!");
         	            	setTimeout(goLogin(),2000);
         	             } else {
         	            	 weui.alert("解除失败!");
         	             }
                });
	        }
	    }]
	});
}

function goLogin(){
	window.location.href = "${ctx}/weixin/toLogin?openId=${admin_user.openId}";
}
</script>
</body>
</html>