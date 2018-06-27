<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
<head>
	<title>新增yyUser</title>
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
	      <h1>添加公司用户</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate">
	            	<div class="control-group">
		                <label class="control-label">姓名:</label>
		                <div class="controls">
		                  <input type="text" name="aName" id="aName"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">昵称:</label>
		                <div class="controls">
		                  <input type="text" name="aNick_name" id="aNick_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">工号:</label>
		                <div class="controls">
		                  <input type="text" name="aUser_number" id="aUser_number"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">隶属公司:</label>
		                <div class="controls">
		                  <input type="text" onclick="showCompany()" readonly="readonly" name="aCompany_name" id="aCompany_name"  value="" required/>
		                  <input type="hidden" name="aCompany_id" id="aCompany_id"  value="" required/>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">直接上级:</label>
		                <div class="controls">
		                  <input type="text" onclick="showUser()" name="aParent_name" id="aParent_name" readonly="readonly"  value=""/>
		                  <input type="hidden" name="aParent_id" id="aParent_id"  value=""/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">是否是超级管理员:</label>
		                <div class="controls">
		                	<select id="aIs_super_manager" required> 
		                        <option value="0">否</option> 
		                        <option value="1">是</option> 
		                	</select>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">是否是普通管理员:</label>
		                <div class="controls">
		                	<select id="aIs_manager" required> 
		                        <option value="0">否</option> 
		                        <option value="1">是</option> 
		                	</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">性别:</label>
		                <div class="controls">
		                <select id="aSex" required> 
	                        <option value="1">男</option> 
	                        <option value="2">女</option> 
	                	</select> 
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">登录名:</label>
		                <div class="controls">
		                  <input type="text" name="aLogin_name" id="aLogin_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">登录密码:</label>
		                <div class="controls">
		                  <input type="password" name="aPassword" id="aPassword"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">状态:</label>
		                <div class="controls">
			                <select id="aState" class="select"> 
		                        <option value="1">正常</option> 
		                        <option value="0">禁用</option> 
		                	</select> 
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">手机:</label>
		                <div class="controls">
		                  <input type="text" name="aPhone" id="aPhone"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">邮箱:</label>
		                <div class="controls">
		                  <input type="text" name="aMail" id="aMail"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">学习下级人数:</label>
		                <div class="controls">
		                  <input type="text" name="aLower_level_number" id="aLower_level_number"  value=""/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">入职时间:</label>
		                <div class="controls">
		                  <input type="text" name="aCreate_time" id="aCreate_time" value="" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">职位:</label>
		                <div class="controls">
		                  <input type="text" name="aJob" id="aJob"  value=""/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">职级:</label>
		                <div class="controls">
		                  <input type="text" name="aJob_level" id="aJob_level"  value=""/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">部门:</label>
		                <div class="controls">
		                  <input type="text" name="aDepartment" id="aDepartment"  value=""/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">负责职能:</label>
		                <div class="controls">
		                  <input type="hidden" name="aJob_info" id="aJob_info"  value="${yyuser.job_info}"/>
		                  <input type="text" name="aJob_info" id="aJob_info_str" readonly="readonly" onclick="showfunction()" value="${yyuser.levelName}"/>
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
				        	$("#aCompany_id").val(radio[i].value);
				        	$("#aCompany_name").val(iframe.document.getElementById("r_"+radio[i].value).value);
				        }  
				    }  
				}
			});
		}
		
		function showUser(){
			var aCompany_id = $("#aCompany_id").val();
			if(aCompany_id==""){
				tipError("请选择隶属公司");
			}else{
				top.art.dialog.open('<c:url value="/yyUser/showUser?company_id='+aCompany_id+'"/>',
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
					        	$("#aParent_id").val(radio[i].value);
					        	$("#aParent_name").val(iframe.document.getElementById("r_"+radio[i].value).value);
					        }  
					    }  
					}
				});
			}
		}
		
		function showfunction(){
			var aJob_info = $("#aJob_info").val();
			top.art.dialog.open('<c:url value="/yyUser/function_set?job_info='+aJob_info+'&userId=${yyuser.id}"/>',
			{
				id:965,
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
					$("#aJob_info").val(selNodeId);
					$("#aJob_info_str").val(selNodeName);
				}
			});
		}
	</script>
</body>
</html>