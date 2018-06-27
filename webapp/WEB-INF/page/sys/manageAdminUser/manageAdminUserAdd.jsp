<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
<head>
	<title>新增用户</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx }/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/select2.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx }/css/style.css" />
	<style type="text/css">
		#content{
			margin-left:0px;
		}
	</style>
</head>
<body id="wrapper">
	<div id="content">
	  <div id="content-header">
	      <h1>新增用户</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate">
	              <div class="control-group">
	                <label class="control-label">用户名</label>
	                <div class="controls">
	                  <input type="text" name="aAdminName" id="aAdminName" required />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">昵称</label>
	                <div class="controls">
	                  <input type="text" name="aNickName" id="aNickName" required />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">密码</label>
	                <div class="controls">
	                  <input type="password" name="aPasswd" id="aPasswd" required minlength="6" maxlength="36" />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">真实姓名</label>
	                <div class="controls">
	                  <input type="text" name="aRealName" id="aRealName" required />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">手机</label>
	                <div class="controls">
	                  <input type="text" id="aMobile" name = "aMobile" required>
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">电话</label>
	                <div class="controls">
	                  <input type="text" id="aPhone" name="aPhone">
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">状态</label>
	                <div class="controls">
	                  <select id="aState" required> 
	                    <option value="1">正常</option> 
	                    <option value="0">禁用</option> 
		              </select> 
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">角色</label>
	                <div class="controls">
	                  <select id="aRoleId" name="aRoleId" required> 
	                       <option value="">--请选择--</option> 
			    			<c:forEach items="${roleList }" var="role">
	                       <option value="${role.roleId }">${role.roleName }</option> 
			    			</c:forEach>
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

	<script src="${ctx }/matrix/js/jquery.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.ui.custom.js"></script> 
	<script src="${ctx }/matrix/js/bootstrap.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.uniform.js"></script> 
	<script src="${ctx }/matrix/js/select2.min.js"></script> 
    <script src="${ctx }/js/jquery.slimscroll.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.validate.js"></script> 
	<script src="${ctx }/matrix/js/matrix.js"></script> 
	<script src="${ctx }/js/common.js"></script> 
	
	<script type="text/javascript">
		var add_form;
		$(document).ready(function(){
			jQuery.validator.addMethod("isMobile", function(value, element) {
			    var length = value.length;
			    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			    return this.optional(element) || (length == 11 && mobile.test(value));
			}, "请正确填写您的手机号码");
			add_form = $("#add-form").validate({
				rules:{
					aMobile:{
						required:true,
						isMobile:"请正确填写您的手机号码"
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
			$("#wrapper").slimscroll({
				height:'100%',
				width : '100%'
			}); 
		});
		function validate(){
			var flag = add_form.form();
			return flag;
		}
	</script>
</body>
</html>


