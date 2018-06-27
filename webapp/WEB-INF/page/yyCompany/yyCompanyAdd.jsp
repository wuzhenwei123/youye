<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en" style="background:#eee;">
<head>
	<title>新增yyCompany</title>
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
	      <h1>添加公司</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content">
	            <form class="form-horizontal" method="post" action="#" name="add-form" id="add-form" novalidate="novalidate">
	            	<div class="control-group">
		                <label class="control-label">公司名称:</label>
		                <div class="controls">
		                  <input type="text" name="aName" id="aName"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">统一社会信用代码:</label>
		                <div class="controls">
		                  <input type="text" name="aCredit_code" id="aCredit_code"  value="" required/>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">学习风格:</label>
		                <div class="controls">
	            			<c:forEach items="${listLearningStyle}" var="learningStyle">
	            				<input type="radio" name="aLearningStyle_id" value="${learningStyle.id}">${learningStyle.name}&nbsp;
	            			</c:forEach>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">所属行业:</label>
		                <div class="controls">
		            		<select name="aIndustry_id" id="aIndustry_id"  required>
		            			<c:forEach items="${listIndustry}" var="industry">
		            				<option value="${industry.id}">${industry.name}</option>
		            			</c:forEach>
		            		</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">员工数量:</label>
		                <div class="controls">
		            		<select name="aEmployees_id" id="aEmployees_id"  required>
		            			<c:forEach items="${listEmployees}" var="employees">
		            				<option value="${employees.id}">${employees.name}</option>
		            			</c:forEach>
		            		</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">营业额:</label>
		                <div class="controls">
		                	<select name="aTurnover_id" id="aTurnover_id"  required>
		            			<c:forEach items="${listTurnover}" var="turnover">
		            				<option value="${turnover.id}">${turnover.name}</option>
		            			</c:forEach>
		            		</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">服务开始时间:</label>
		                <div class="controls">
		                  <input type="text" name="aStart_time" id="aStart_time" value="" required onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'aEnd_time\');}', minDate:'%y-%M-%d', dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">服务结束时间:</label>
		                <div class="controls">
		                  <input type="text" name="aEnd_time" id="aEnd_time" value="" required onfocus="WdatePicker({minDate:'#F{$dp.$D(\'aStart_time\')||\'%y-%M-%d\';}',dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">状态:</label>
		                <div class="controls">
			                <select id="aState" class="select"> 
		                        <option value="1">活跃</option> 
		                        <option value="0">停用</option> 
		                        <option value="-1">欠费</option> 
		                	</select> 
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">联系人姓名:</label>
		                <div class="controls">
		                  <input type="text" name="aContact_name" id="aContact_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">联系人手机:</label>
		                <div class="controls">
		                  <input type="text" name="aContact_phone" id="aContact_phone"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">负责人姓名:</label>
		                <div class="controls">
		                  <input type="text" name="aCharge_name" id="aCharge_name"  value="" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">负责人手机:</label>
		                <div class="controls">
		                  <input type="text" name="aCharge_phone" id="aCharge_phone"  value="" required/>
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