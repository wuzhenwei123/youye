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
	<link rel="stylesheet" href="${ctx}/plus/layui/weui.min.css">
	<link rel="stylesheet" href="${ctx}/plus/layui/reg.css">
	<style type="text/css">
	.pubwarp {
		max-width: 640px;
		min-width: 320px;
		margin: 0 auto;
		overflow: hidden;
		padding-bottom: 5rem;
	}
	
	.layui-elem-field {
		margin-left: 5px;
		margin-right: 5px;
	}
	
	.preview {
		vertical-align: middle;
		text-align: center;
	}
	
	.maskbg {
		background: rgba(0, 0, 0, .7);
		display: none;
		height: 100%;
		left: 0;
		position: fixed;
		top: 0;
		width: 100%;
		z-index: 19999;
		overflow: auto;
	}
	</style>
</head>
<body>

	<%@ include file="/WEB-INF/page/common/share1.jsp" %>
	<div class="pubwarp" style="margin-bottom:30px;">
		<div class="zcheaderbox backffff">
			<div class="zcbgimg">
				<img src="${ctx}/plus/layui/demo/zcbg.png">
			</div>
			<section>
				<h1>聚划优营销工具</h1>
				<em>让生意做进7亿用户朋友圈</em>
			</section>
		</div>
		<form id="info_form" action="/Pc-data.html" method="post" enctype="multipart/form-data">
			
			
			
			<div class="weui_cells weui_cells_form" style="margin-top:0;">
				<div class="weui_cells" style="margin-top:0;">
					<div class="weui_cell weui_cell_select weui_select_before">
						<div class="weui_cell_hd">
							<select class="weui_select" name="select2">
								<option value="1">+86</option>
								<option value="2">+80</option>
								<option value="3">+84</option>
								<option value="4">+87</option>
							</select>
						</div>
						<div class="weui_cell_bd weui_cell_primary">
							<input class="weui_input" type="text" id="tel" name="tel" placeholder="请输入手机号码">
						</div>
					</div>
				</div>
				<fieldset class="layui-elem-field" style="margin-top: 10px;">
					<legend>身份证</legend>
						<nav class="weui_btn_area">
							<img alt="" src="" id="card_imgs" width="100%" height="120px;" onclick="showPic(this)">
						</nav>
						<nav class="weui_btn_area">
							<a class="weui_btn weui_btn_primary" href="javascript:pai(1);" id="showTooltips">拍照上传</a>
						</nav>
					<input type="hidden" id="card_url">
				</fieldset>
				<fieldset class="layui-elem-field" style="margin-top: 10px;">
					<legend>营业执照</legend>
						<nav class="weui_btn_area">
							<img alt="" src="" id="zz_imgs" width="100%" height="120px;" onclick="showPic(this)">
						</nav>
						<nav class="weui_btn_area">
							<a class="weui_btn weui_btn_primary" href="javascript:pai(2);" id="showTooltips">拍照上传</a>
						</nav>
						<input type="hidden" id="zz_url">
				</fieldset>
			</div>
			<nav class="weui_btn_area">
				<a class="weui_btn weui_btn_primary" href="javascript:submit();" id="showTooltips">开通注册</a>
			</nav>
		</form>
	</div>
	<div class="preview maskbg" data-p="" onclick="closePreview()">
		<img src="images/icon.jpg" />
	</div>
	<script src="${ctx}/js/wx/swiper.min.js"></script>
<script src="${ctx}/js/wx/jquery.min.js"></script>
<script src="${ctx}/plus/layer/layer.js"></script>
<script type="text/javascript">

function showPic(obj){
	//获取图片的宽和高
	var image = new Image();
    image.src = obj.src;
    var naturalWidth = image.width;
    var naturalHight = image.height;
	$(".preview").find("img").attr('src',obj.src);
	$(".preview").find("img").attr('width',naturalWidth);
	$(".preview").find("img").attr('height',naturalHight);
	$(".preview").show();
}

function closePreview(){
	$(".preview").hide();
}

   function pai(v){
		wx.chooseImage({
			count : 1, // 默认9
			sizeType : [ 'original' ], // 可以指定是原图还是压缩图，默认二者都有
			sourceType : [ 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
			success : function(res) {
				var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
				uploadP(localIds[0],v);
			}
		});
		
	}
   
   function uploadP(localIds,v){
	   wx.uploadImage({
			localId : localIds, // 需要上传的图片的本地ID，由chooseImage接口获得
			isShowProgressTips : 1, // 默认为1，显示进度提示
			success : function(res) {
				var serverId = res.serverId; // 返回图片的服务器端ID
				//下载到本地
				$.get("${ctx}/weixin/saveImageToDisk?mediaId="+serverId,function(data){
					var json = eval("("+data+")");
					if(json.c=="0"){
						if(v=="1"){
							$("#card_imgs").attr("src","${pic}"+json.d);
							$("#card_url").val(json.d);
						}else{
							$("#zz_imgs").attr("src","${pic}"+json.d);
							$("#zz_url").val(json.d);
						}
					}else{
						layer.msg(json.m);
					}
				});
				
			}
		});
   }
   
   var flag = true;
   function submit(){
	   var myreg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[0-9]|18[0-9]|14[57])[0-9]{8}$/;
	   var tel = $("#tel").val();
	   if(!myreg.test(tel)){
		   layer.msg("请输入正确的手机号");
		   return false;
	   }
	   var card_url = $("#card_url").val();
	   if(card_url==""){
		   layer.msg("请上传身份证照片");
		   return false;
	   }
	   
	   var zz_url = $("#zz_url").val();
	   if(zz_url==""){
		   layer.msg("请上传营业执照照片");
		   return false;
	   }
	   if(flag){
		   flag = false;
			var loading = weui.loading('数据处理中', {
			    className: 'custom-classname'
			});
			$.post("<c:url value='/yyUser/reg'/>",
	       	{
				phone : tel,
				zz_url : zz_url,
				card_url : card_url,
		   		openId : '${openId}',
				 _t:Math.random()},
		       	function(data){
					loading.hide();
					flag = true;
		        	var result = eval('('+data+')'); 
		            if (result.code == '0') {
		            	weui.alert("提交成功，等待审核!");
		            	setTimeout(closeWin(),3000);
		             } else {
		            	 weui.alert(result.message);
		             }
	       });
	   }
   }
   
   function closeWin(){
		WeixinJSBridge.call('closeWindow');
	}
</script>
</body>
</html>