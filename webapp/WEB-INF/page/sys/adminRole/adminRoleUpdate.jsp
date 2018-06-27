<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title></title>
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
	      <h1>编辑角色</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content nopadding">
	          	<input type="hidden" id="mRoleId"  value="${adminrole.roleId}" />
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate">
	              <div class="control-group">
	                <label class="control-label">角色名称</label>
	                <div class="controls">
	                  <input type="text" name="mRoleName" id="mRoleName" value="${adminrole.roleName}" required />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">状态</label>
	                <div class="controls">
	                  <select id="mState" required> 
	                    <option <c:if test="${adminrole.state == 1}" >selected="selected"</c:if>  value="1">正常</option> 
                        <option <c:if test="${adminrole.state == 0}" >selected="selected"</c:if> value="0">禁用</option>
		              </select> 
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">默认角色</label>
	                <div class="controls">
	                  <select id="mDefaule" required> 
	                    <option <c:if test="${adminrole.defaule == 1}" >selected="selected"</c:if>  value="1">默认角色</option> 
                        <option <c:if test="${adminrole.defaule == 0}" >selected="selected"</c:if> value="0">非默认角色</option>
		              </select> 
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">角色类型</label>
	                <div class="controls">
	                  <select id="mRoleType" required> 
	                    <option <c:if test="${adminrole.roleType == 1}" >selected="selected"</c:if>  value="1">普通管理</option> 
                        <option <c:if test="${adminrole.roleType == 0}" >selected="selected"</c:if> value="0">超级管理</option>
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