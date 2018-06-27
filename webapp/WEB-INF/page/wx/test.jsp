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
<input type="button" value="拍照上传" onclick="pai()">
<input type="text" id="v">

<img alt="" src="" id="imgs">
<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/plus/layer/layer.js"></script>
<script type="text/javascript">


   function pai(){
		wx.chooseImage({
			count : 1, // 默认9
			sizeType : [ 'original' ], // 可以指定是原图还是压缩图，默认二者都有
			sourceType : [ 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
			success : function(res) {
				var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
				uploadP(localIds[0]);
			}
		});
		
	}
   
   function uploadP(localIds){
	   wx.uploadImage({
			localId : localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
			isShowProgressTips : 1, // 默认为1，显示进度提示
			success : function(res) {
				var serverId = res.serverId; // 返回图片的服务器端ID
				$("#v").val(serverId);
				//下载到本地
				$.get("${ctx}/weixin/saveImageToDisk?mediaId="+serverId,function(data){
					var json = eval("("+data+")");
					if(json.c=="0"){
						$("#imgs").attr("src","${pic}"+json.d);
					}else{
						layer.msg(json.m);
					}
				});
				
			}
		});
   }
</script>
</body>
</html>