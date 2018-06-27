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
	      <h1>公司用户管理</h1>
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
		                <label class="control-label name_label">姓名:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fName" style="width: 150px !important;"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">工号:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fUser_number" style="width: 150px !important;"/>
			            </div>
	                </div>
		            <div class="name_query_btn">
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
		    var nick_name = $("#fNick_name").val();
		    var user_number = $("#fUser_number").val();
		    var company_id = $("#fCompany_id").val();
		    var is_manager = $("#fIs_manager").val();
		    var parent_id = $("#fParent_id").val();
		    var parent_ids = $("#fParent_ids").val();
		    var sex = $("#fSex").val();
		    var login_name = $("#fLogin_name").val();
		    var password = $("#fPassword").val();
		    var state = $("#fState").val();
		    var head_img = $("#fHead_img").val();
		    var phone = $("#fPhone").val();
		    var mail = $("#fMail").val();
		    var lower_level_number = $("#fLower_level_number").val();
		    var parent_name = $("#fParent_name").val();
		    var create_time = $("#fCreate_time").val();
		    var job = $("#fJob").val();
		    var job_level = $("#fJob_level").val();
		    var department = $("#fDepartment").val();
		    var job_info = $("#fJob_info").val();
		    var history_job = $("#fHistory_job").val();
		    var remark1 = $("#fRemark1").val();
		    var remark2 = $("#fRemark2").val();
		    var remark3 = $("#fRemark3").val();
		    $.getJSON("<c:url value='/yyUser/getYyUserList'/>",
	        {
	        	sortColumn:sortColumn,
	        	user_id : '${user_id}',
	    		name : name,
	    		nick_name : nick_name,
	    		user_number : user_number,
	    		company_id : '${company_id}',
	    		is_manager : is_manager,
	    		parent_id : parent_id,
	    		parent_ids : parent_ids,
	    		sex : sex,
	    		login_name : login_name,
	    		password : password,
	    		state : state,
	    		head_img : head_img,
	    		phone : phone,
	    		mail : mail,
	    		lower_level_number : lower_level_number,
	    		parent_name : parent_name,
	    		create_time : create_time,
	    		job : job,
	    		job_level : job_level,
	    		department : department,
	    		job_info : job_info,
	    		history_job : history_job,
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
		    	str+= "<th class=\"sortTh\" id=\"th_name\" column='name'>姓名</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_user_number\" column='user_number'>工号</th>";
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
			        tableStr += "<td>" + result.items[k].user_number + "</td>";
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
