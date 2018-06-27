<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
<head>
	<title>新增yyCourseClassify</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/select2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx}/plus/date/skin/WdatePicker.css">
	<link href="<c:url value='/plus/webuploader/webuploader.css'/>" rel="stylesheet">
	<link rel="stylesheet" href="${ctx}/css/style.css" />
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
	</style>
</head>
<body id="wrapper">
	<div id="content">
	  <div id="content-header">
	      <h1>
	  		<c:if test="${not empty yyCourseClassify.id}">修改</c:if>    
	  		<c:if test="${empty yyCourseClassify.id}">添加</c:if>    
	      </h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate">
	            	<input type="hidden" name="level" id="level"  value="${level}" required/>
	            	<input type="hidden" name="parent_id" id="parent_id"  value="${pId}" required/>
	            	<input type="hidden" name="mId" id="mId"  value="${yyCourseClassify.id}" required/>
	            	<div class="control-group">
		                <label class="control-label">名称:</label>
		                <div class="controls">
		                  <input type="text" name="mName" id="mName"  value="${yyCourseClassify.name}" required/>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">封面:</label>
		                <div class="controls">
		                  <table>
			                  <tbody>
			                    <tr>
			                      <td>
			                      	<c:if test="${not empty yyCourseClassify.img_url}"><img alt="" src="${pic}${yyCourseClassify.img_url}" class="headimg" id="exe_img" style="width: 98px;height: 98px;"></c:if>
			                      	<c:if test="${empty yyCourseClassify.img_url}"><img alt="" src="${ctx}/images/loading.gif" class="headimg" id="exe_img" style="display: none;width: 98px;height: 98px;"></c:if>
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<div class="btn btn-inverse btn-mini" id="filePicker" style="padding: 0px 15px !important;"><i class="icon-upload-alt"></i> 浏览</div>
			                      </td>
			                    </tr>
			                    
			                  </tbody>
			                </table>
		                  <input type="hidden" name="mImg_url" id="mImg_url"  value="${yyCourseClassify.img_url}"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">简介:</label>
		                <div class="controls">
		                  <textarea rows="4" cols="4" name="mInfo" id="mInfo">${yyCourseClassify.info}</textarea>
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
	<script src="${ctx}/plus/layui/layui.js"></script> 
	<script src="${ctx}/js/common.js"></script> 
	
	
	<script type="text/javascript">
		var add_form;
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
					$("#mImg_url").val(filePath);
				}
			}else{
				tipError("上传异常");
			}
		}
	</script>
</body>
</html>