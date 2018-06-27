<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title}</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/css/style.css" />
	<%@ include file="/WEB-INF/page/common/js.jsp" %>	
	<script src="${ctx}/js/common.js"></script> 
</head>

<body style="background:#fff;">
    <input type="hidden" id="currPage" value="1"><!-- 当前页码 -->
	<input type="hidden" id="returnNum" value="10"><!-- 分页返回 -->
	<input type="hidden" id="sortColumn" value=""><!-- 排序字段 -->
	<div id="content1">
	  <div id="content-header">
	      <h1>选择公司</h1>
	  </div>
		<div class="container-fluid">
		  <div class="row-fluid">
		    <div class="span12">
		      <div class="widget-box">
		        <div class="widget-title" data-toggle="collapse" href="#search-coll"> 
		        	<span class="icon"><i class="icon-chevron-down"></i></span>
		          	<h5>检索</h5>
		        </div>
		        <div class="widget-content nopadding collapse" id="search-coll">
		          <form class="form-horizontal">
	                <div class="control-group name_title">
		                <label class="control-label name_label">公司名称:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fName" style="width: 150px !important;"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">编码:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCode" style="width: 150px !important;"/>
			            </div>
	                </div>
		            <div class="name_query_btn" style="text-align: center;">
		              <button type="button" class="btn btn-success" onclick="searchData(1)"><i class="icon-search"></i> 查询</button>
		            </div>
		            <div style="height:10px;clear:both;"></div>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div>
		  <div class="row-fluid">
		    <div class="span12">
		   		<div class="widget-box">
		          <!-- <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
		            <h5>列表</h5>
		          </div> -->
		          <div class="widget-content tab_con">
		            <table class="table table-bordered table-striped with-check" id="exampleDTC"></table>
		          </div>
		          <div>
		            <div class="pagination alternate text-right" id="page-div"></div>
		          </div>
		        </div>
		    </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
	    	searchData(1);
	    });
		function searchData(pageNo){
			parent.layer.load();
			var returnNum = $("#returnNum").val();
			var sortColumn = $("#sortColumn").val();
		    var id = $("#fId").val();
		    var name = $("#fName").val();
		    var code = $("#fCode").val();
		    var credit_code = $("#fCredit_code").val();
		    var industry_id = $("#fIndustry_id").val();
		    var industry_name = $("#fIndustry_name").val();
		    var employees_id = $("#fEmployees_id").val();
		    var employees_name = $("#fEmployees_name").val();
		    var turnover_id = $("#fTurnover_id").val();
		    var turnover_name = $("#fTurnover_name").val();
		    var start_time = $("#fStart_time").val();
		    var end_time = $("#fEnd_time").val();
		    var state = $("#fState").val();
		    var contact_name = $("#fContact_name").val();
		    var contact_phone = $("#fContact_phone").val();
		    var charge_name = $("#fCharge_name").val();
		    var charge_phone = $("#fCharge_phone").val();
		    var remark1 = $("#fRemark1").val();
		    var remark2 = $("#fRemark2").val();
		    var remark3 = $("#fRemark3").val();
		    $.getJSON("<c:url value='/yyCompany/getYyCompanyList'/>",
	        {
	        	sortColumn:sortColumn,
	    		id : id,
	    		name : name,
	    		code : code,
	    		credit_code : credit_code,
	    		industry_id : industry_id,
	    		industry_name : industry_name,
	    		employees_id : employees_id,
	    		employees_name : employees_name,
	    		turnover_id : turnover_id,
	    		turnover_name : turnover_name,
	    		start_time : start_time,
	    		end_time : end_time,
	    		state : state,
	    		contact_name : contact_name,
	    		contact_phone : contact_phone,
	    		charge_name : charge_name,
	    		charge_phone : charge_phone,
	    		remark1 : remark1,
	    		remark2 : remark2,
	    		remark3 : remark3,
	    		pageNo: pageNo,
	    		rowCount: returnNum, 
				_t: Math.random()
	        },function(data){
	            var result = data;
	            parent.layer.closeAll('loading');
	            if (result.code == 1) {
	                setTableStr(result, pageNo, returnNum);
	            } else {
	            	tipError("系统异常!");
	            } 
		    });
		}
		function genTableHeader(){
			var str = "<thead><tr>" ;
		    	str+= "<th></th>";
		    	str+= "<th>序号</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_name\" column='name'>公司名称</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_code\" column='code'>编号</th>";
				str+="</tr></thead>";
			return str;
		}
		function setTableStr(result, pageNo, returnNum){
			var tableStr = "";
		    tableStr += genTableHeader();
	        tableStr += "<tbody>";
		    var number = (pageNo - 1) * returnNum;
		    for (var k=0; k<result.items.length; k++){      
		        tableStr += "<tr>";
		        tableStr += "<td ><input type=\"hidden\" value='"+result.items[k].name+"' id='r_"+result.items[k].id+"'/><input type=\"radio\" id='"+result.items[k].id+"' value='"+result.items[k].id+"' name=\"checkName1\" /></td>";
		        tableStr += "<td >" + (number + k + 1) + "</td>";
			        tableStr += "<td>" + result.items[k].name + "</td>";
			        tableStr += "<td>" + result.items[k].code + "</td>";
		        tableStr += "</tr>";            
		    }
		    tableStr += "</tbody>";
		    $("#exampleDTC").html(tableStr);
		    $("#currPage").val(pageNo);	
// 		    initForm();
		    initTh();
		    genPageTag(pageNo,result.totalResults,returnNum,'page-div');
		}
	</script>
</body>
</html>
