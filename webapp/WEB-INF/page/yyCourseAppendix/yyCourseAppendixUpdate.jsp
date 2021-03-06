<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>yyCourseAppendix</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/select2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-media.css" />
	<link href="<c:url value='/plus/webuploader/webuploader.css'/>" rel="stylesheet">
	<link rel="stylesheet" href="${ctx}/css/style.css" />
	<style type="text/css">
		#content{
			margin-left:0px;
		}
		#filePicker{
			height: 25px;
			line-height: 0px !important;
		}
	</style>
</head>
<body id="wrapper">
	<div id="content">
	  <div id="content-header">
	      <h1>编辑工具</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content nopadding">
	            <form class="form-horizontal" method="post" action="#" name="update-form" id="update-form" novalidate="novalidate">
	            	<input type="hidden" name="mId" id="mId"  value="${yycourseappendix.id}" required/>
<!-- 	            	<div class="control-group"> -->
<!-- 		                <label class="control-label">course_id:</label> -->
<!-- 		                <div class="controls"> -->
<!-- 		                  <input type="text" name="mCourse_id" id="mCourse_id"  value="${yycourseappendix.course_id}" required/> -->
<!-- 		            	</div> -->
<!-- 		            </div> -->
					<div class="control-group">
		                <label class="control-label">工具名称:</label>
		                <div class="controls">
		                  <input type="text" name="mName" id="mName"  value="${yycourseappendix.name}" required readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">工具:</label>
		                <div class="controls">
		                	<table>
			                  <tbody>
			                    <tr>
			                      <td>
			                      	<img alt="" src="${ctx}/images/file.png" class="headimg" id="file_img" style="width: 98px;height: 98px;">
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<div class="btn btn-inverse btn-mini" id="filePicker" style="padding: 0px 15px !important;"><i class="icon-upload-alt"></i> 浏览</div>
			                      </td>
			                    </tr>
			                    
			                  </tbody>
			                </table>
		                  <input type="hidden" name="mUrl" id="mUrl"  value="${yycourseappendix.url}" required/>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">状态:</label>
		                <div class="controls">
		                	<select id="mState" >
		                		<option value="1" <c:if test="${yycourseappendix.state==1}">selected</c:if>>正常</option>
		                		<option value="0" <c:if test="${yycourseappendix.state==0}">selected</c:if>>禁用</option>
		                	</select>
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
	<script src="${ctx}/plus/date/WdatePicker.js"></script>
	<script src="${ctx}/matrix/js/matrix.js"></script> 
	<script type="text/javascript" src="<c:url value='/plus/webuploader/webuploader.min.js'/>"></script>
	<script src="${ctx}/js/common.js"></script> 
	
	<script type="text/javascript">
		var update_form;
		$(document).ready(function(){
			update_form = $("#update-form").validate({
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
			upload('${ctx}','filePicker',uploadCallBack,'file','web_pic','');
		});
		function validate(){
			var flag = update_form.form();
			return flag;
		}
		function uploadCallBack(response){
			if(response.code == '1'){
				var fileList = response.list;
				if(fileList.length == 1){
					var filePath = fileList[0].filePath;
					var fileName = fileList[0].oldFileName;
					$("#file_img").attr("src","${ctx}/images/file.png");
					$("#file_img").show();
					$("#mUrl").val(filePath);
					$("#mName").val(fileName);
				}
			}else{
				tipError("上传异常");
			}
		}
	</script>
</body>
</html>