<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>yyCompany</title>
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
	      <h1>编辑公司</h1>
	  </div>
	  <div class="container-fluid">
	    <div class="row-fluid">
	      <div class="span12">
	        <div class="widget-box">
	          <div class="widget-content nopadding">
	            <form class="form-horizontal" method="post" action="#" name="update-form" id="update-form" novalidate="novalidate">
	            	<input type="hidden" name="mId" id="mId"  value="${yycompany.id}" required/>
	            	<div class="control-group">
		                <label class="control-label">公司名称:</label>
		                <div class="controls">
		                  <input type="text" name="mName" id="mName"  value="${yycompany.name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">统一社会信用代码:</label>
		                <div class="controls">
		                  <input type="text" name="mCredit_code" id="mCredit_code"  value="${yycompany.credit_code}" required/>
		            	</div>
		            </div>
		            <div class="control-group">
		                <label class="control-label">学习风格:</label>
		                <div class="controls">
	            			<c:forEach items="${listLearningStyle}" var="learningStyle">
	            				<input <c:forEach items="${listCompanyLearnStyle}" var="cl"><c:if test="${learningStyle.id==cl.learning_style_id}">checked</c:if></c:forEach> type="radio" name="mLearningStyle_id" value="${learningStyle.id}">${learningStyle.name}&nbsp;
	            			</c:forEach>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">所属行业:</label>
		                <div class="controls">
		            		<select name="mIndustry_id" id="mIndustry_id"  required>
		            			<c:forEach items="${listIndustry}" var="industry">
		            				<option value="${industry.id}" <c:if test="${industry.id==yycompany.industry_id}">selected</c:if>>${industry.name}</option>
		            			</c:forEach>
		            		</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">员工数量:</label>
		                <div class="controls">
		                	<select name="mEmployees_id" id="mEmployees_id"  required>
		            			<c:forEach items="${listEmployees}" var="employees">
		            				<option value="${employees.id}" <c:if test="${employees.id==yycompany.employees_id}">selected</c:if>>${employees.name}</option>
		            			</c:forEach>
		            		</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">营业额:</label>
		                <div class="controls">
		            		<select name="mTurnover_id" id="mTurnover_id"  required>
		            			<c:forEach items="${listTurnover}" var="turnover">
		            				<option value="${turnover.id}" <c:if test="${turnover.id==yycompany.turnover_id}">selected</c:if>>${turnover.name}</option>
		            			</c:forEach>
		            		</select>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">服务开始时间:</label>
		                <div class="controls">
		                  <input type="text" name="mStart_time" id="mStart_time" value="<fmt:formatDate value="${yycompany.start_time}" type="both"/>" required onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'mEnd_time\');}', minDate:'%y-%M-%d', dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">服务结束时间:</label>
		                <div class="controls">
		                  <input type="text" name="mEnd_time" id="mEnd_time" value="<fmt:formatDate value="${yycompany.end_time}" type="both"/>" required onfocus="WdatePicker({minDate:'#F{$dp.$D(\'mStart_time\')||\'%y-%M-%d\';}',dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">状态:</label>
		                <div class="controls">
			                <select id="mState" class="select" required> 
		                        <option <c:if test="${yycompany.state== 1}" >selected="selected"</c:if>  value="1">正常</option> 
		                        <option <c:if test="${yycompany.state== 0}" >selected="selected"</c:if> value="0">禁用</option> 
		                	</select> 
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">联系人姓名:</label>
		                <div class="controls">
		                  <input type="text" name="mContact_name" id="mContact_name"  value="${yycompany.contact_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">联系人手机:</label>
		                <div class="controls">
		                  <input type="text" name="mContact_phone" id="mContact_phone"  value="${yycompany.contact_phone}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">负责人姓名:</label>
		                <div class="controls">
		                  <input type="text" name="mCharge_name" id="mCharge_name"  value="${yycompany.charge_name}" required/>
		            	</div>
		            </div>
	            	<div class="control-group">
		                <label class="control-label">负责人手机:</label>
		                <div class="controls">
		                  <input type="text" name="mCharge_phone" id="mCharge_phone"  value="${yycompany.charge_phone}" required/>
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