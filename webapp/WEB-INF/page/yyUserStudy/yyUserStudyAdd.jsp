<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
<head>
	<title>新增yyUserStudy</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/select2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx}/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx}/plus/date/skin/WdatePicker.css">
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
	      <h1>添加yyUserStudy</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate">
	            	<div class="control-group">
		                <label class="control-label">user_id:</label>
		                <div class="controls">
		                  <input type="text" name="aUser_id" id="aUser_id"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">theme_id:</label>
		                <div class="controls">
		                  <input type="text" name="aTheme_id" id="aTheme_id"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">theme_name:</label>
		                <div class="controls">
		                  <input type="text" name="aTheme_name" id="aTheme_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">module_id:</label>
		                <div class="controls">
		                  <input type="text" name="aModule_id" id="aModule_id"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">module_name:</label>
		                <div class="controls">
		                  <input type="text" name="aModule_name" id="aModule_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">lesson_id:</label>
		                <div class="controls">
		                  <input type="text" name="aLesson_id" id="aLesson_id"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">lesson_name:</label>
		                <div class="controls">
		                  <input type="text" name="aLesson_name" id="aLesson_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">point_id:</label>
		                <div class="controls">
		                  <input type="text" name="aPoint_id" id="aPoint_id"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">point_name:</label>
		                <div class="controls">
		                  <input type="text" name="aPoint_name" id="aPoint_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">long_time:</label>
		                <div class="controls">
		                  <input type="text" name="aLong_time" id="aLong_time"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">create_time:</label>
		                <div class="controls">
		                  <input type="text" name="aCreate_time" id="aCreate_time" value="" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">start_time:</label>
		                <div class="controls">
		                  <input type="text" name="aStart_time" id="aStart_time" value="" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">end_time:</label>
		                <div class="controls">
		                  <input type="text" name="aEnd_time" id="aEnd_time" value="" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">is_over:</label>
		                <div class="controls">
		                  <input type="text" name="aIs_over" id="aIs_over"  value="" required/>
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
		});
		function validate(){
			var flag = add_form.form();
			return flag;
		}
	</script>
</body>
</html>