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
	<link href="<c:url value='/plus/webuploader/webuploader.css'/>" rel="stylesheet">
	<link rel="stylesheet" href="${ctx }/css/style.css" />
	
	<script src="${ctx }/matrix/js/jquery.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.ui.custom.js"></script> 
	<script src="${ctx }/matrix/js/bootstrap.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.uniform.js"></script> 
	<script src="${ctx }/matrix/js/jquery.validate.js"></script> 
	<script src="${ctx }/matrix/js/matrix.js"></script>
	<script type="text/javascript" src="<c:url value='/plus/webuploader/webuploader.min.js'/>"></script>    
	<script src="${ctx }/js/common.js"></script> 
	<style type="text/css">
		.text-left{
			text-align: left!important;
			width: 50%;
		}
		.text-right{
			text-align: right!important;
			width: 50%;
		}
		.text-center{
			text-align: center!important;
		}
		 .innor td{
			width: 30px!important;
		}
		.headimg{
			border-radius: 50%;
			margin-top: 20px;
			height: 100px;
			width: 100px;
		}
	</style>
</head>

<body style="background:#fff;">
	<div id="content1">
	  <div id="content-header">
	      <h1>用户中心</h1>
	  </div>
		<div class="container-fluid">
		  <div class="widget-box">
		  	  <div class="widget-title"> <span class="icon"> <i class="icon-briefcase"></i> </span>
	            <h5>个人信息</h5>
	          </div>
		  	  <div class="widget-content">
				  <div class="row-fluid">
				  	<div class="span2">
				  		<form class="form-horizontal">
			                <table style="width: 100%;">
			                  <tbody>
			                    <tr>
			                      <td>
			                      <c:if test="${not empty admin_user.headImg}">
			                      	<img alt="" src="${pic}${admin_user.headImg}" class="headimg" id="headimg">
			                      </c:if>
			                      <c:if test="${empty admin_user.headImg}">
			                      	<img alt="" src="${ctx}/images/default_photo.png" class="headimg" id="headimg">
			                      </c:if>
			                      	<input id="aheadImg" type="hidden" value="${admin_user.headImg}">
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<div class="btn btn-inverse btn-mini" id="filePicker"><i class="icon-upload-alt"></i> 浏览</div>
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<strong>
			                      	用户名:
			                      	</strong>
			                      	${admin_user.adminName }
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<strong>
			                      	角色:
			                      	</strong>
			                      	${admin_user.roleName }
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<strong>
			                      	最后登陆日期:
			                      	</strong>
			                      	<fmt:formatDate value="${admin_user.lastLogin}" pattern="yyyy/MM/dd  HH:mm:ss" />
			                      </td>
			                    </tr>
			                    <tr>
			                      <td>
			                      	<strong>
			                      	注册日期:
			                      	</strong>
			                      	<fmt:formatDate value="${admin_user.createTime}" pattern="yyyy/MM/dd  HH:mm:ss" />
			                      </td>
			                    </tr>
			                  </tbody>
			                </table>
				  		</form>
		              </div>
		              <div class="span4">
			              <form name="add-form" id="add-form" class="form-horizontal">
			                <table class="table innor">
			                  <tbody>
			                    <tr>
			                      <td class="width30 text-right" width="30">昵称:</td>
			                      <td class="width70 text-left">
			                      	<input type="text" id="nickName" name="nickName" value="${admin_user.nickName }" required>
			                      </td>
			                    </tr>
			                    <tr>
			                      <td class="width30 text-right" width="30">真实姓名:</td>
			                      <td class="width70 text-left">
			                      	<input type="text" id="realName" name="realName" value="${admin_user.realName }" required>
			                      </td>
			                    </tr>
			                    <tr>
			                      <td class="width30 text-right" width="30">手机:</td>
			                      <td class="width70 text-left">
			                      	<input type="text" id="mMobile" name="mMobile" value="${admin_user.mobile }" required>
			                      </td>
			                    </tr>
			                    <tr>
			                      <td class="width30 text-right" width="30">电话:</td>
			                      <td class="width70 text-left">
			                      	<input id="phone" name="phone" type="text" value="${admin_user.phone }">
			                      </td>
			                    </tr>
			                    <tr>
			                    	<td align="center" colspan="2">
			                    		<button class="btn btn-success" onclick="update();">保存</button>
			                    	</td>
			                    </tr>
			                   </tbody>
			                </table>
			              </form>
		              </div>
				  </div>
		  	  </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
		var add_form;
		$(document).ready(function(){
			upload('${ctx}','filePicker',uploadCallBack,'','head_path','pic');
			

			jQuery.validator.addMethod("isMobile", function(value, element) {
			    var length = value.length;
			    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
			    return this.optional(element) || (length == 11 && mobile.test(value));
			}, "请正确填写您的手机号码");
			add_form = $("#add-form").validate({
				rules:{
					mMobile:{
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
	    });
		//上传回调
		function uploadCallBack(response){
			if(response.code == '1'){
				var fileList = response.list;
				if(fileList.length == 1){
					var newFileName = fileList[0].newName;
					var headimg = "${pic}"+newFileName;
					$("#headimg").attr("src",headimg);
					$("#aheadImg").val(newFileName);
				}
			}else{
				tipError("上传异常");
			}
		}
		function update(){
			var headImg = $("#aheadImg").val();
			var nickName = $("#nickName").val();
			var realName = $("#realName").val();
			var mobile = $("#mMobile").val();
			var phone = $("#phone").val();
			var flag = add_form.form();
		    if (flag){ 
		        $.post("<c:url value='/manageAdminUser/saveManageAdminUser'/>",
		        	{
		        	headImg:headImg,
		    		nickName : encodeURI(nickName,'UTF-8'),
		    		realName : encodeURI(realName,'UTF-8'),
		    		mobile : mobile,
		    		phone : phone,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	tipOk(result.message);
			            	location.reload() ;
			             } else {
			            	 tipError(result.message);
			             }
		        });
		    }
		}
	</script>
</body>
</html>
 