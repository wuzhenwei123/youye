<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>msProvince</title>
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
	      <h1>编辑msProvince</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content nopadding">
	            <form class="form-horizontal" method="post" action="#" name="update-form" id="update-form" novalidate="novalidate">
	            	<div class="control-group">
		                <label class="control-label">id:</label>
		                <div class="controls">
		                  <input type="text" name="mId" id="mId"  value="${msprovince.id}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">provinceCode:</label>
		                <div class="controls">
		                  <input type="text" name="mProvinceCode" id="mProvinceCode"  value="${msprovince.provinceCode}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">provinceName:</label>
		                <div class="controls">
		                  <input type="text" name="mProvinceName" id="mProvinceName"  value="${msprovince.provinceName}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">countryCode:</label>
		                <div class="controls">
		                  <input type="text" name="mCountryCode" id="mCountryCode"  value="${msprovince.countryCode}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">alp:</label>
		                <div class="controls">
		                  <input type="text" name="mAlp" id="mAlp"  value="${msprovince.alp}" required/>
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