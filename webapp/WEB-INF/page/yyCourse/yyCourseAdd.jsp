<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
<head>
	<title>新增yyCourse</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/select2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx}/plus/date/skin/WdatePicker.css">
	<link href="<c:url value='/plus/webuploader/webuploader.css'/>" rel="stylesheet">
	<link rel="stylesheet" href="${ctx}/css/style.css?_t=<%=Math.random() %>" />
	<link href="${ctx}/css/wx/weui.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		#content{
			margin-left:0px;
		}
		.webuploader-pick {
			padding: 0px 15px !important;
		}
		#filePicker {
		    line-height:-1px !important;
		}
		#filePicker1 {
		   padding: 0px 15px !important;
		}
		#filePicker2 {
		    padding: 0px 15px !important;
		}
		.weui_cell{
			padding: 0px 0px !important;
		}
	</style>
</head>
<body id="wrapper">
	<div id="content">
	  <div id="content-header">
	      <h1>添加知识点</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate" enctype="multipart/form-data">
	            	<div class="control-group">
		                <label class="control-label">知识点名称:</label>
		                <div class="controls">
		                  <input type="text" name="aName" id="aName"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">知识点编号:</label>
		                <div class="controls">
		                  <input type="text" name="aCode" id="aCode"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">知识点封面:</label>
		                <div class="controls">
		                  <table>
			                  <tbody>
			                    <tr>
			                      <td>
			                      	<img alt="" src="${ctx}/images/loading.gif" class="headimg" id="exe_img" style="display: none;width: 98px;height: 98px;">
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<div class="btn btn-inverse btn-mini" id="filePicker" style="padding: 0px 15px !important;"><i class="icon-upload-alt"></i> 浏览</div>
			                      </td>
			                    </tr>
			                    
			                  </tbody>
			                </table>
		                  <input type="hidden" name="aImg_url" id="aImg_url"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">上传视频:</label>
		                <div class="controls">
		                	<table>
			                  <tbody>
			                    <tr>
			                      <td>
			                      	<div class="layui-progress layui-progress-big" lay-filter="demo" lay-showPercent="true">
									  <div class="layui-progress-bar" lay-percent="0%"></div>
									</div>
<!-- 			                      	<img alt="" src="${ctx}/images/loading.gif" class="headimg" id="mp4_img" style="display: none;width: 80px;height: 80px;"> -->
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<div class="btn btn-inverse btn-mini" id="filePicker1" style="padding: 0px 15px !important;"><i class="icon-upload-alt"></i> 浏览</div>
			                      </td>
			                    </tr>
			                    
			                  </tbody>
			                </table>
		                  <input type="hidden" name="aVideo_url" id="aVideo_url"  value="" required/>
		                  <input type="hidden" name="video_fileId" id="video_fileId"  value=""/>
		                  <input type="hidden" name="videoFileName" id="videoFileName"  value=""/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">上传音频:</label>
		                <div class="controls">
		                	<table>
			                  <tbody>
			                    <tr>
			                      <td>	
			                      	<div class="layui-progress layui-progress-big" lay-filter="demo1" lay-showPercent="true">
									  <div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>
									</div>
<!-- 			                      	<img alt="" src="${ctx}/images/loading.gif" class="headimg" id="mp3_img" style="display: none;width: 80px;height: 80px;"> -->
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<div class="btn btn-inverse btn-mini" id="filePicker2" style="padding: 0px 15px !important;"><i class="icon-upload-alt"></i> 浏览</div>
			                      </td>
			                    </tr>
			                    
			                  </tbody>
			                </table>
		                  <input type="hidden" name="aMp3_url" id="aMp3_url"  value="" required/>
		                  <input type="hidden" name="audio_fileId" id="audio_fileId"  value="" />
		                  <input type="hidden" name="audioFileName" id="audioFileName"  value="" />
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">知识点简介:</label>
		                <div class="controls">
		                <textarea rows="4" cols="4" name="aInfo" id="aInfo" required></textarea>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">时长（秒）:</label>
		                <div class="controls">
		                  <input type="text" name="aWhen_long" id="aWhen_long"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">显示顺序:</label>
		                <div class="controls">
		                  <input type="text" name="aSort_id" id="aSort_id"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">工具:</label>
		                <div class="controls">
		                	<div class="weui_cells weui_cells_form">
						        <div class="weui_cell">
						            <div class="weui_cell_bd weui_cell_primary">
						                <div class="weui_uploader">
						                    <div class="weui_uploader_bd" style="height: 115px;">
						                        <ul class="weui_uploader_files" style="margin: 0 0 10px 0px;">
						                        </ul>
						                        <div class="weui_uploader_input_wrp">
						                            <input class="weui_uploader_input" name="file" type="file" style="width: 79px;height: 79px;"/>
						                        </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </div>
		            	</div>
		            </div>
	            </form>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

	<script src="${ctx}/matrix/js/jquery.min.js"></script> 
	<script src="${ctx}/matrix/js/jquery.ui.custom.js"></script> 
	<script src="${ctx}/matrix/js/bootstrap.min.js"></script> 
	<script src="${ctx}/matrix/js/jquery.uniform.js"></script> 
	<script src="${ctx}/matrix/js/select2.min.js"></script> 
    <script src="${ctx}/matrix/js/nicescroll/jquery.nicescroll.min.js"></script> 
	<script src="${ctx}/matrix/js/jquery.validate.js"></script> 
	<script src="${ctx}/matrix/js/matrix.js"></script> 
	<script src="${ctx}/plus/date/WdatePicker.js"></script>
	<script type="text/javascript" src="<c:url value='/plus/webuploader/webuploader.min.js'/>"></script>
	<script src="${ctx}/js/common.js"></script> 
	<script src="${ctx}/plus/layui/layui.js"></script> 
	
	
	<script type="text/javascript">
		var add_form;
		var r = 0;
		$(document).ready(function(){
			add_form = $("#add-form").validate({
				errorClass: "help-inline",
				errorElement: "span",
				submitHandler:function(form){
		        },
				highlight:function(element, errorClass, validClass) {
					$(element).parents('.control-group').addClass('error');
					$(element).parents('.control-group').removeClass('success');
				},
				unhighlight: function(element, errorClass, validClass) {
					$(element).parents('.control-group').removeClass('error');
					$(element).parents('.control-group').addClass('success');
				}
			});
			initScroll('wrapper');
			upload1('${ctx}','filePicker',uploadCallBack,'','web_pic','');
			upload1('${ctx}','filePicker1',uploadCallBack1,'video','web_pic','');
			upload1('${ctx}','filePicker2',uploadCallBack2,'audio','web_pic','');
			$("#filePicker").css("line-height","-1px");
			$(".weui_uploader_input").change(function() {
				files = $(this).prop('files');
				if (files.length > 0) {
		            file = files[0];
					r = r + 1;
					ajaxFileUpload();
				}
			})
		});
		function validate(){
			var flag = add_form.form();
			return flag;
		}
		function uploadCallBack(response){
			if(response.code == '1'){
				var fileList = response.list;
				if(fileList.length == 1){
					var filePath = fileList[0].filePath
					var fileId = fileList[0].fileId
					$("#exe_img").attr("src","${pic}"+filePath);
					$("#exe_img").show();
					$("#aImg_url").val(filePath);
				}
			}else{
				tipError("上传异常");
			}
		}
		function uploadCallBack1(response){
			if(response.code == '1'){
				var fileList = response.list;
				if(fileList.length == 1){
					var filePath = fileList[0].filePath;
					var fileId = fileList[0].fileId;
					var videoFileName = fileList[0].fileName;
					$("#mp4_img").attr("src","${ctx}/images/mp4.jpg");
					$("#mp4_img").show();
					$("#aVideo_url").val(filePath);
					$("#video_fileId").val(fileId);
					$("#videoFileName").val(videoFileName);
				}
			}else{
				tipError("上传异常");
			}
		}
		function uploadCallBack2(response){
			if(response.code == '1'){
				var fileList = response.list;
				if(fileList.length == 1){
					var filePath = fileList[0].filePath;
					var fileId = fileList[0].fileId;
					var audioFileName = fileList[0].fileName;
					$("#mp3_img").attr("src","${ctx}/images/mp3.png");
					$("#mp3_img").show();
					$("#aMp3_url").val(filePath);
					$("#audio_fileId").val(fileId);
					$("#audioFileName").val(audioFileName);
				}
			}else{
				tipError("上传异常");
			}
		}
		function delimg(obj,r){
			$(".weui_uploader_input").val("");
			obj.remove();
			$("#hid"+r).remove();
			$(".weui_uploader_input_wrp").show();
		}
		function ajaxFileUpload() {
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
			        	var hidden = "<input type='hidden' id='hid"+r+"' name='fujianUrl' arrt_name='"+item.oldFileName+"' value='"+item.filePath+"'>";
			        	$(".weui_uploader_files").append(hidden);
			        	var li = "<li class='weui_uploader_file' style='background-image:url(${ctx}/images/file.png);margin-top: 10px;' onclick='delimg(this,\""+r+"\")' alt='"+item.oldFileName+"' title='"+item.oldFileName+"'><span style='font-size: 3px;position: absolute;margin-top: 75px;width: 79px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;' alt='"+item.oldFileName+"' title='"+item.oldFileName+"'>"+item.oldFileName+"</span></li>";
						$(".weui_uploader_files").append(li);
			         } else {
			        	 tipError('上传失败');
			         }
				}
			});
		}
		function getFj(){
			var fujianUrl = "";
			$("input[name='fujianUrl']").each(function(){
				if(fujianUrl==""){
					fujianUrl = $(this).val() + "_" + $(this).attr("arrt_name");
				}else{
					fujianUrl = fujianUrl + "," + $(this).val() + "_" + $(this).attr("arrt_name");
				}
			})
			return fujianUrl;
		}
	</script>
</body>
</html>