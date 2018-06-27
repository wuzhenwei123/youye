<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
<head>
	<title>编辑菜单</title>
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
	      <h1>编辑菜单</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="update-form" id="update-form" novalidate="novalidate">
	          	<input type="hidden" id="mColumnId" value="${managecolumn.columnId}"/>
	              <div class="control-group">
	                <label class="control-label">菜单名称</label>
	                <div class="controls">
	                  <input type="text" name="mColumnName" id="mColumnName" value="${managecolumn.columnName}" required />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">菜单路径</label>
	                <div class="controls">
	                  <input type="text" name="mColumnUrl" id="mColumnUrl" value="${managecolumn.columnUrl}" required />
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">父菜单</label>
	                <div class="controls">
		                  <select id="mParentColumnID" required onchange="chan()"> 
	                        <option <c:if test="${managecolumn.parentColumnID == column.columnId }" >selected="selected"</c:if> value="-1">--根目录--</option> 
	                        <c:forEach items="${parentColumnList }" var="column">
						    <option <c:if test="${managecolumn.parentColumnID == column.columnId }" >selected="selected"</c:if> value="${column.columnId }">${column.columnName }</option>                     
	                        </c:forEach>
	                	</select>
	                </div>
	              </div>
	              <div class="control-group">
	                <label class="control-label">状态</label>
	                <div class="controls">
	                  <select id="mState" required> 
	                    <option <c:if test="${manageadminuser.state == 1}" >selected="selected"</c:if>  value="1">正常</option> 
                        <option <c:if test="${manageadminuser.state == 0}" >selected="selected"</c:if> value="0">禁用</option>
		              </select> 
	                </div>
	              </div>
	              <div class="control-group" id="icon-div"<c:if test="${managecolumn.parentColumnID != '-1'}"> style="display: none;"</c:if>>
	                <label class="control-label">图片</label>
	                <div class="controls">
	                  <input type="hidden" name="mColumnImg" id="mColumnImg" value="${managecolumn.columnImg}" />
	                  <div data-toggle="buttons-radio" class="btn-group">
		                  <button onclick="setVal('mColumnImg','icon-th-large')" class="btn<c:if test="${managecolumn.columnImg == 'icon-th-large'}"> active</c:if>" type="button"><i class="icon-th-large"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-asterisk')" class="btn<c:if test="${managecolumn.columnImg == 'icon-asterisk'}"> active</c:if>" type="button"><i class="icon-asterisk"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-bookmark')" class="btn<c:if test="${managecolumn.columnImg == 'icon-bookmark'}"> active</c:if>" type="button"><i class="icon-bookmark"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-briefcase')" class="btn<c:if test="${managecolumn.columnImg == 'icon-briefcase'}"> active</c:if>" type="button"><i class="icon-briefcase"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-cogs')" class="btn<c:if test="${managecolumn.columnImg == 'icon-cogs'}"> active</c:if>" type="button"><i class="icon-cogs"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-user')" class="btn<c:if test="${managecolumn.columnImg == 'icon-user'}"> active</c:if>" type="button"><i class="icon-user"></i></button>
		                  <br>
		                  <button onclick="setVal('mColumnImg','icon-edit')" class="btn<c:if test="${managecolumn.columnImg == 'icon-edit'}"> active</c:if>" type="button"><i class="icon-edit"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-envelope')" class="btn<c:if test="${managecolumn.columnImg == 'icon-envelope'}"> active</c:if>" type="button"><i class="icon-envelope"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-film')" class="btn<c:if test="${managecolumn.columnImg == 'icon-film'}"> active</c:if>" type="button"><i class="icon-film"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-folder-close')" class="btn<c:if test="${managecolumn.columnImg == 'icon-folder-close'}"> active</c:if>" type="button"><i class="icon-folder-close"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-lock')" class="btn<c:if test="${managecolumn.columnImg == 'icon-lock'}"> active</c:if>" type="button"><i class="icon-lock"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-unlock')" class="btn<c:if test="${managecolumn.columnImg == 'icon-unlock'}"> active</c:if>" type="button"><i class="icon-unlock"></i></button>
		                  <br>
		                  <button onclick="setVal('mColumnImg','icon-picture')" class="btn<c:if test="${managecolumn.columnImg == 'icon-picture'}"> active</c:if>" type="button"><i class="icon-picture"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-reorder')" class="btn<c:if test="${managecolumn.columnImg == 'icon-reorder'}"> active</c:if>" type="button"><i class="icon-reorder"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-sitemap')" class="btn<c:if test="${managecolumn.columnImg == 'icon-sitemap'}"> active</c:if>" type="button"><i class="icon-sitemap"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-trash')" class="btn<c:if test="${managecolumn.columnImg == 'icon-trash'}"> active</c:if>" type="button"><i class="icon-trash"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-list-ul')" class="btn<c:if test="${managecolumn.columnImg == 'icon-list-ul'}"> active</c:if>" type="button"><i class="icon-list-ul"></i></button>
		                  <button onclick="setVal('mColumnImg','icon-comments')" class="btn<c:if test="${managecolumn.columnImg == 'icon-comments'}"> active</c:if>" type="button"><i class="icon-comments"></i></button>
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
	<script src="${ctx }/js/common.js"></script> 
	
	<script type="text/javascript">
		var form;
		$(document).ready(function(){
			form = $("#update-form").validate({
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
			var pid = $("#mParentColumnID").val();
			if(pid == '-1'){
				$("#icon-div").show();
			}else{
				$("#mColumnImg").val("");
				$("#icon-div").hide();
			}
		}
		function setVal(id,val){
			$("#"+id).val(val);
		}
		function validate(){
			var flag = form.form();
			return flag;
		}
	</script>
</body>
</html>