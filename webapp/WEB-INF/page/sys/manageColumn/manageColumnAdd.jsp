<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
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
	      <h1>新增菜单</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate">
	              <div class="control-group">
	                <label class="control-label">菜单名称</label>
	                <div class="controls">
	                  <input type="text" name="aColumnName" id="aColumnName" required />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">菜单路径</label>
	                <div class="controls">
	                  <input type="text" name="aColumnUrl" id="aColumnUrl" required />
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
	                <label class="control-label">父菜单</label>
	                <div class="controls">
	                  	<select id="aParentColumnID" required onchange="chan()"> 
	                        <option value="-1">--根目录--</option> 
	                        <c:forEach items="${parentColumnList }" var="column">
						    <option value="${column.columnId }">${column.columnName }</option>                     
	                        </c:forEach>
	                	</select>
	                </div>
	              </div>
	              <div class="control-group" id="icon-div">
	                <label class="control-label">菜单图标</label>
	                <div class="controls">
	                	 <input type="hidden" value="icon-th-large" id="aColumnImg">
	                  	<div data-toggle="buttons-radio" class="btn-group">
		                  <button onclick="setVal('aColumnImg','icon-th-large')" class="btn active" type="button"><i class="icon-th-large"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-asterisk')" class="btn" type="button"><i class="icon-asterisk"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-bookmark')" class="btn" type="button"><i class="icon-bookmark"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-briefcase')" class="btn" type="button"><i class="icon-briefcase"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-cogs')" class="btn" type="button"><i class="icon-cogs"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-user')" class="btn" type="button"><i class="icon-user"></i></button>
		                  <br>
		                  <button onclick="setVal('aColumnImg','icon-edit')" class="btn" type="button"><i class="icon-edit"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-envelope')" class="btn" type="button"><i class="icon-envelope"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-film')" class="btn" type="button"><i class="icon-film"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-folder-close')" class="btn" type="button"><i class="icon-folder-close"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-lock')" class="btn" type="button"><i class="icon-lock"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-unlock')" class="btn" type="button"><i class="icon-unlock"></i></button>
		                  <br>
		                  <button onclick="setVal('aColumnImg','icon-picture')" class="btn" type="button"><i class="icon-picture"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-reorder')" class="btn" type="button"><i class="icon-reorder"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-sitemap')" class="btn" type="button"><i class="icon-sitemap"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-trash')" class="btn" type="button"><i class="icon-trash"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-list-ul')" class="btn" type="button"><i class="icon-list-ul"></i></button>
		                  <button onclick="setVal('aColumnImg','icon-comments')" class="btn" type="button"><i class="icon-comments"></i></button>
		                </div>
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
	<script src="${ctx}/plus/date/WdatePicker.js"></script>
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
		function chan(){
			var pid = $("#aParentColumnID").val();
			if(pid == '-1'){
				$("#icon-div").show();
			}else{
				$("#aColumnImg").val("");
				$("#icon-div").hide();
			}
		}
		function setVal(id,val){
			$("#"+id).val(val);
		}
		function validate(){
			var flag = add_form.form();
			return flag;
		}
	</script>
</body>
</html>