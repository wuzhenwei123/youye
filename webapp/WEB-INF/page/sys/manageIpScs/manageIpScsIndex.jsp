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
	<input type="hidden" id="sortColumn" value="a.id desc"><!-- 排序字段 -->
	<div id="content1">
	  <div id="content-header">
	      <h1>请求IP列表</h1>
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
		                <label class="control-label name_label">请求IP:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fRequestIP"/>
			            </div>
	                </div>
<!-- 	                <div class="control-group name_title"> -->
<!-- 		                <label class="control-label name_label">requestCount:</label> -->
<!-- 	                	<div class="controls name_control"> -->
<!-- 			                <input type="text" class="span8 name_span" id="fRequestCount"/> -->
<!-- 			            </div> -->
<!-- 	                </div> -->
	                 <div class="control-group name_title">
		                <label class="control-label name_label">监控日期:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span2 name_span" id="fCreateTime1" onfocus="WdatePicker({dateFmt:'yyyyMMdd'})" readonly="readonly"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">至</label>
	                	<div class="controls name_control">
			                <input type="text" class="span2 name_span" id="fCreateTime2" onfocus="WdatePicker({dateFmt:'yyyyMMdd'})" readonly="readonly"/>
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
<%-- 		<perm:tag permPath="/manageIpScs/addManageIpScs" > --%>
<!-- 	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button> -->
<%-- 		</perm:tag> --%>
<%-- 		<perm:tag permPath="/manageIpScs/removeAllManageIpScs" > --%>
<!-- 	    <button class="btn btn-danger" onclick="delAll()"><i class="icon-trash"></i>批量删除</button> -->
<%-- 		</perm:tag> --%>
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
		    var requestIP = $("#fRequestIP").val();
		    var requestCount = $("#fRequestCount").val();
		    var requestDateTime = $("#fRequestDateTime").val();
		    var createTime1 = $("#fCreateTime1").val();
		    var createTime2 = $("#fCreateTime2").val();
		    $.getJSON("<c:url value='/manageIpScs/getManageIpScsList'/>",
	        {
		    	createTime1:createTime1,
		    	createTime2:createTime2,
	        	sortColumn:sortColumn,
	    		id : id,
	    		requestIP : requestIP,
	    		requestCount : requestCount,
	    		requestDateTime : requestDateTime,
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
		    	str+= "<th><input id=\"checkAllBtn\" type='checkbox' value='ON' onclick=\"checkAll('checkAllBtn','checkName');\" name='check-all'></th>";
		    	str+= "<th>序号</th>";
// 		    	str+= "<th class=\"sortTh\" id=\"th_id\" column='id'>id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th>请求IP</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_requestCount\" column='requestCount'>次数<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_requestDateTime\" column='requestDateTime'>日期<i class=\"icon-sort\"></i></th>";
// 				str+="<th>操作</th>";
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
		        tableStr += "<td ><input type=\"checkbox\" id='"+result.items[k].id+"' value=\"0\" name=\"checkName\" /></td>";
		        tableStr += "<td >" + (number + k + 1) + "</td>";
		        
// 			        tableStr += "<td>" + result.items[k].id + "</td>";
			        tableStr += "<td>" + result.items[k].requestIP + "</td>";
			        tableStr += "<td>" + result.items[k].requestCount + "</td>";
			        tableStr += "<td>" + result.items[k].requestDateTime + "</td>";
// 		        tableStr += "<td>";
// 	        	tableStr += "<perm:tag permPath='/manageIpScs/updateManageIpScs' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
// 	        	tableStr += "<perm:tag permPath='/manageIpScs/removeManageIpScs' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
// 	        	tableStr += "</td>";
		        tableStr += "</tr>";            
		    }
		    tableStr += "</tbody>";
		    $("#exampleDTC").html(tableStr);
		    $("#currPage").val(pageNo);	
		    initForm();
		    initTh();
		    genPageTag(pageNo,result.totalResults,returnNum,'page-div');
		}
		function goCurrentPage(){
			var pageNo = $("#currPage").val();           
		  	searchData(pageNo);
		}
	</script>
</body>
</html>
