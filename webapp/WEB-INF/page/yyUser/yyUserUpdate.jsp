<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>yyUser</title>
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
	      <h1>编辑公司用户</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content nopadding">
	            <form class="form-horizontal" method="post" action="#" name="update-form" id="update-form" novalidate="novalidate">
	            	<input type="hidden" name="mId" id="mId"  value="${yyuser.id}" required/>
	            	<div class="control-group">
		                <label class="control-label">姓名:</label>
		                <div class="controls">
		                  <input type="text" name="mName" id="mName"  value="${yyuser.name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">昵称:</label>
		                <div class="controls">
		                  <input type="text" name="mNick_name" id="mNick_name"  value="${yyuser.nick_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">工号:</label>
		                <div class="controls">
		                  <input type="text" name="mUser_number" id="mUser_number"  value="${yyuser.user_number}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">隶属公司:</label>
		                <div class="controls">
		                  <input type="hidden" name="mCompany_id" id="mCompany_id"  value="${yyuser.company_id}" required/>
		            	  <input type="text" onclick="showCompany()" readonly="readonly" name="mCompany_name" id="mCompany_name"  value="${yyuser.company_name}" required/>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">直接上级:</label>
		                <div class="controls">
		                  <input type="text" onclick="showUser()" name="mParent_name" id="mParent_name" readonly="readonly"  value="${yyuser.parent_name}"/>
		                  <input type="hidden" name="mParent_id" id="mParent_id"  value="${yyuser.parent_id}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">是否是超级管理员:</label>
		                <div class="controls">
		            		<select id="mIs_super_manager" required> 
		                        <option value="0" <c:if test="${yyuser.is_super_manager==0}">selected</c:if>>否</option> 
		                        <option value="1" <c:if test="${yyuser.is_super_manager==1}">selected</c:if>>是</option> 
		                	</select>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">是否是普通管理员:</label>
		                <div class="controls">
		            		<select id="mIs_manager" required> 
		                        <option value="0" <c:if test="${yyuser.is_manager==0}">selected</c:if>>否</option> 
		                        <option value="1" <c:if test="${yyuser.is_manager==1}">selected</c:if>>是</option> 
		                	</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">性别:</label>
		                <div class="controls">
		            		<select id="mSex" required> 
		                        <option value="1" <c:if test="${yyuser.sex==1}">selected</c:if>>男</option> 
		                        <option value="2" <c:if test="${yyuser.sex==2}">selected</c:if>>女</option> 
		                	</select> 	
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">登录名:</label>
		                <div class="controls">
		                  <input type="text" name="mLogin_name" id="mLogin_name"  value="${yyuser.login_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">登录密码:</label>
		                <div class="controls">
		                  <input type="password" name="mPassword" id="mPassword"  value="${yyuser.password}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">状态:</label>
		                <div class="controls">
			                <select id="mState" class="select" required> 
		                        <option <c:if test="${yyuser.state== 1}" >selected="selected"</c:if>  value="1">正常</option> 
		                        <option <c:if test="${yyuser.state== 0}" >selected="selected"</c:if> value="0">禁用</option> 
		                	</select> 
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">手机:</label>
		                <div class="controls">
		                  <input type="text" name="mPhone" id="mPhone"  value="${yyuser.phone}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">邮箱:</label>
		                <div class="controls">
		                  <input type="text" name="mMail" id="mMail"  value="${yyuser.mail}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">学习下级人数:</label>
		                <div class="controls">
		                  <input type="text" name="mLower_level_number" id="mLower_level_number"  value="${yyuser.lower_level_number}" />
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">入职时间:</label>
		                <div class="controls">
		                  <input type="text" name="mCreate_time" id="mCreate_time" value="<fmt:formatDate value="${yyuser.create_time}" type="both"/>" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">职位:</label>
		                <div class="controls">
		                  <input type="text" name="mJob" id="mJob"  value="${yyuser.job}" />
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">职级:</label>
		                <div class="controls">
		                  <input type="text" name="mJob_level" id="mJob_level"  value="${yyuser.job_level}" />
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">部门:</label>
		                <div class="controls">
		                  <input type="text" name="mDepartment" id="mDepartment"  value="${yyuser.department}" />
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">负责职能:</label>
		                <div class="controls">
		                  <input type="hidden" name="mJob_info" id="mJob_info"  value="${function_ids}"/>
		                  <input type="text" name="mJob_info" id="mJob_info_str" readonly="readonly"  value="${function_names}"/>
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
		function showCompany(){
   			top.art.dialog.open('<c:url value="/yyCompany/showCompany"/>',
			{
				id:111,
				fixed:true,
				esc:true,
				title:'选择公司',
				width: '500px',
				height:'350px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "确定",
				ok:function(){
					var iframe = this.iframe.contentWindow;
					var radio = iframe.document.getElementsByName("checkName1");  
				    for (var i=0; i<radio.length; i++) {  
				        if (radio[i].checked) { 
				        	$("#mCompany_id").val(radio[i].value);
				        	$("#mCompany_name").val(iframe.document.getElementById("r_"+radio[i].value).value);
				        }  
				    }  
				}
			});
		}
		function showfunction(fId){
			var mJob_info = $("#mJob_info").val();
			top.art.dialog.open('<c:url value="/yyUser/function_set?job_info='+mJob_info+'&userId=${yyuser.id}"/>',
			{
				id:963,
				fixed:true,
				esc:true,
				title:'选择职能',
				width: '500px',
				height:'350px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "确定",
				ok:function(){
					var iframe = this.iframe.contentWindow;
					var selNodeId = iframe.document.getElementById("selNodeId").value;  
					var selNodeName = iframe.document.getElementById("selNodeName").value;  
					$("#mJob_info").val(selNodeId);
					$("#mJob_info_str").val(selNodeName);
				}
			});
		}
		
		function showUser(){
			var aCompany_id = $("#mCompany_id").val();
			if(aCompany_id==""){
				tipError("请选择隶属公司");
			}else{
				top.art.dialog.open('<c:url value="/yyUser/showUser?company_id='+aCompany_id+'&user_id=${yyuser.id}"/>',
				{
					id:222,
					fixed:true,
					esc:true,
					title:'选择直属上级',
					width: '500px',
					height:'350px',
				    cancelVal: '取消',
			        cancel: true, //为true等价于function(){}
			        okVal : "确定",
					ok:function(){
						var iframe = this.iframe.contentWindow;
						var radio = iframe.document.getElementsByName("checkName1");  
					    for (var i=0; i<radio.length; i++) {  
					        if (radio[i].checked) { 
					        	$("#mParent_id").val(radio[i].value);
					        	$("#mParent_name").val(iframe.document.getElementById("r_"+radio[i].value).value);
					        }  
					    }  
					}
				});
			}
		}
	</script>
</body>
</html>