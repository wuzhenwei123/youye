<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>yyUserStudy</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/select2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx}/css/style.css" />
	<style type="text/css">
		#content{
			margin-left:0px;
		}
	</style>
</head>
<body id="wrapper">
	<div id="content">
	  <div id="content-header">
	      <h1>编辑yyUserStudy</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content nopadding">
	            <form class="form-horizontal" method="post" action="#" name="update-form" id="update-form" novalidate="novalidate">
	            	<input type="hidden" name="mId" id="mId"  value="${yyuserstudy.id}" required/>
	            	<div class="control-group">
		                <label class="control-label">user_id:</label>
		                <div class="controls">
		                  <input type="text" name="mUser_id" id="mUser_id"  value="${yyuserstudy.user_id}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">theme_id:</label>
		                <div class="controls">
		                  <input type="text" name="mTheme_id" id="mTheme_id"  value="${yyuserstudy.theme_id}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">theme_name:</label>
		                <div class="controls">
		                  <input type="text" name="mTheme_name" id="mTheme_name"  value="${yyuserstudy.theme_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">module_id:</label>
		                <div class="controls">
		                  <input type="text" name="mModule_id" id="mModule_id"  value="${yyuserstudy.module_id}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">module_name:</label>
		                <div class="controls">
		                  <input type="text" name="mModule_name" id="mModule_name"  value="${yyuserstudy.module_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">lesson_id:</label>
		                <div class="controls">
		                  <input type="text" name="mLesson_id" id="mLesson_id"  value="${yyuserstudy.lesson_id}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">lesson_name:</label>
		                <div class="controls">
		                  <input type="text" name="mLesson_name" id="mLesson_name"  value="${yyuserstudy.lesson_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">point_id:</label>
		                <div class="controls">
		                  <input type="text" name="mPoint_id" id="mPoint_id"  value="${yyuserstudy.point_id}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">point_name:</label>
		                <div class="controls">
		                  <input type="text" name="mPoint_name" id="mPoint_name"  value="${yyuserstudy.point_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">long_time:</label>
		                <div class="controls">
		                  <input type="text" name="mLong_time" id="mLong_time"  value="${yyuserstudy.long_time}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">create_time:</label>
		                <div class="controls">
		                  <input type="text" name="mCreate_time" id="mCreate_time" value="<fmt:formatDate value="${yyuserstudy.create_time}" type="both"/>" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">start_time:</label>
		                <div class="controls">
		                  <input type="text" name="mStart_time" id="mStart_time" value="<fmt:formatDate value="${yyuserstudy.start_time}" type="both"/>" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">end_time:</label>
		                <div class="controls">
		                  <input type="text" name="mEnd_time" id="mEnd_time" value="<fmt:formatDate value="${yyuserstudy.end_time}" type="both"/>" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">is_over:</label>
		                <div class="controls">
		                  <input type="text" name="mIs_over" id="mIs_over"  value="${yyuserstudy.is_over}" required/>
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
		});
		function validate(){
			var flag = update_form.form();
			return flag;
		}
	</script>
</body>
</html>