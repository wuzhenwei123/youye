<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title }</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	
	<link rel="stylesheet" href="${ctx }/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx }/css/style.css" />
	
	<script src="${ctx }/matrix/js/jquery.min.js"></script> 
	<script src="${ctx}/matrix/js/nicescroll/jquery.nicescroll.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.ui.custom.js"></script> 
	<script src="${ctx }/matrix/js/bootstrap.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.uniform.js"></script> 
	<script src="${ctx }/matrix/js/jquery.validate.js"></script> 
	<script src="${ctx }/matrix/js/matrix.js"></script>
	<script src="${ctx }/js/common.js"></script> 
</head>

<body style="background:#fff;" id="wrapper">
	<div id="content1">
	  <div id="content-header">
	      <h1>修改密码</h1>
	  </div>
		<div class="container-fluid">
		  <div class="widget-box">
		  	  <div class="widget-content">
			  	  <form id="add-form" class="form-horizontal" method="post" novalidate="novalidate">
		              <div id="form-wizard-1" class="step ui-formwizard-content" style="display: block;">
		                <div class="control-group">
		                  <label class="control-label">原始密码</label>
		                  <div class="controls">
		                    <input id="oPasswd" type="text" name="oPasswd" >
		                  </div>
		                </div>
		                <div class="control-group">
		                  <label class="control-label">新密码</label>
		                  <div class="controls">
		                    <input id="nPasswd" type="password" name="nPasswd"/>
		                  </div>
		                </div>
		                <div class="control-group">
		                  <label class="control-label">确认新密码</label>
		                  <div class="controls">
		                    <input id="rPasswd" type="password" name="rPasswd"/>
		                  </div>
		                </div>
		              </div>
	            </form>
		  	  </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
		var add_form;
		$(document).ready(function(){
			add_form = $("#add-form").validate({
				rules: {
					oPasswd:"required",
					nPasswd:{
						required:true,
						minlength:6,
						maxlength:36
					},
					rPasswd: {
						required:true,
						minlength:6,
						maxlength:36,
						equalTo:"#nPasswd"
				 	}
				},
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
 