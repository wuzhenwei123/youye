<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title }</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/css/style.css" />
	<%@ include file="/WEB-INF/page/common/js.jsp" %>	
	<script src="${ctx}/js/common.js"></script> 
</head>

<body style="background:#fff;">
    <input type="hidden" id="currPage" value="1"><!-- 当前页码 -->
	<input type="hidden" id="returnNum" value="10"><!-- 分页返回 -->
	<input type="hidden" id="sortColumn" value=" columnOrder ASC "><!-- 排序字段 -->
	<div id="content1">
	  <div id="content-header">
	      <h1>菜单管理</h1>
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
		          	<c:if test="${not empty parentColumnList }">
		          		<div class="control-group name_title">
			              <label class="control-label name_label">父菜单:</label>
			              <div class="controls name_control name_select">
			                <select class="span12" id="fParentColumnID">
			                	<option value="-1">--根目录--</option> 
		                        <c:forEach items="${parentColumnList }" var="column">
							    <option value="${column.columnId }">${column.columnName }</option>                     
		                        </c:forEach>
			                </select>
			              </div>
			            </div>
		          	</c:if>
		            <div class="control-group name_title">
		              <label class="control-label name_label">菜单名称:</label>
		              <div class="controls name_control">
		                <input type="text" class="span8 name_span" id="fColumnName"/>
		              </div>
		            </div>
		            <div class="control-group name_title">
		              <label class="control-label name_label">状态:</label>
		              <div class="controls name_control name_select">
		                <select class="span12" id="fState">
		                	<option value="">--全部--</option> 
	                        <option value="1">正常</option> 
	                        <option value="0">禁用</option> 
		                </select>
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
		<perm:tag permPath="/manageColumn/toAdd" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
<%-- 		<perm:tag permPath="/manageColumn/removeAllManageColumn" > --%>
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
	    var columnId = $("#fColumnId").val();
	    var columnName = $("#fColumnName").val();
	    var columnUrl = $("#fColumnUrl").val();
	    var parentColumnID = $("#fParentColumnID").val();
	    var state = $("#fState").val();
	    var columnOrder = $("#fColumnOrder").val();
	    var columnImg = $("#fColumnImg").val();
	    $.getJSON("<c:url value='/manageColumn/getManageColumnList'/>",
        {
        	sortColumn:sortColumn,
    		columnId : columnId,
    		columnName : columnName,
    		columnUrl : columnUrl,
    		parentColumnID : parentColumnID,
    		state : state,
    		columnOrder : columnOrder,
    		columnImg : columnImg,
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
	    	str+= "<th  class=\"check-col\"><input id=\"checkAllBtn\" type='checkbox' class='checkbox check-all' value='ON' onclick=\"checkAll('checkAllBtn','checkName');\" name='check-all'></th>";
	    	str+= "<th width='30' >序号</th>";
	    	str+= "<th width='50' class=\"sortTh\" id=\"th_columnId\" column='columnId'  >菜单ID<i class=\"icon-sort\"></i></th>";
	    	str+= "<th id=\"th_columnName\" class='sortTh' column='columnName'>菜单名称<i class=\"icon-sort\"></i></th>";
	    	str+= "<th>菜单路径</th>";
	    	str+= "<th id=\"th_parentColumnID\" class='sortTh' column='parentColumnID'  >父菜单<i class=\"icon-sort\"></i></th>";
	    	str+= "<th width='30'>图标</th>";
	    	str+= "<th width='50' class=\"sortTh\" id=\"th_state\" column='state'>状态<i class=\"icon-sort\"></i></th>";
	    	str+= "<th width='50'>排序</th>";
			str+="<th>操	作</th>";
			str+="</tr></thead>";
		return str;
	}
	function setTableStr(result, pageNo, returnNum){
	 	var tableStr = "";
	    tableStr += genTableHeader();
	    var number = (pageNo - 1) * returnNum;
        tableStr += "<tbody>";
	    for (var k=0; k<result.items.length; k++){      
	        tableStr += "<tr>";
	        tableStr += "<td ><input type=\"checkbox\" id='"+result.items[k].columnId+"' value=\"0\" name=\"checkName\" /></td>";
	        tableStr += "<td >" + (number + k + 1) + "</td>";
	        tableStr += "<td >" + result.items[k].columnId + "</td>";
	        tableStr += "<td >" + result.items[k].columnName + "</td>";
	        tableStr += "<td >" + result.items[k].columnUrl + "</td>";
	        tableStr += "<td >" + (result.items[k].parentColumnID == -1?"根目录":result.items[k].parentColumnName) +"</td>";
	        var columnIm = result.items[k].columnImg;
	        tableStr += "<td ><i class='" + columnIm +"'></i></td>";
	        if(result.items[k].state == 1){
	        tableStr += "<td class='text-green'>正常</td>";
			}else{
	        tableStr += "<td class='text-red'>禁用</td>";
			}
	        tableStr += "<td ><a class='btn btn-mini' onclick=\"move('"+result.items[k].parentColumnID+"','" + result.items[k].columnId + "','up')\" ><i title=\"上移动\" class='icon-caret-up' /></a><a class='btn btn-mini' onclick=\"move('"+result.items[k].parentColumnID+"','" + result.items[k].columnId + "','down')\" ><i title=\"下移动\" class='icon-caret-down' /></a></td>"; 
	        tableStr += "<td>";
        	tableStr += "<perm:tag permPath='/manageColumn/toUpdate' ><button class='btn btn-mini btn-info' href='javascript:void(0);' onclick='toUpdate(" + result.items[k].columnId + ");return false;'><i class='icon-edit' />编辑</button></perm:tag>";
        	tableStr += "<perm:tag permPath='/manageColumn/removeManageColumn' ><button class='btn btn-mini btn-danger' href='javascript:void(0);' onclick='del(" + result.items[k].columnId + ");return false;'><i class='icon-trash' />删除</button></perm:tag>";
        	tableStr += "</td>";
	        tableStr += "</tr>";            
	    }
	    tableStr += "</tbody>";
	    $("#exampleDTC").html(tableStr);
	    $("#currPage").val(pageNo);	
	    initForm();
	    initTh();
	    genPageTag(pageNo,result.totalResults,returnNum,'page-div');
	}
	//上下移动
	function move(parentColumnID,columnId,sign){
		var sortColumn = $("#sortColumn").val();
	      $.post("<c:url value='/manageColumn/moveColumn'/>",
        	{
    		columnId : columnId,
    		sign : sign,
    		parentColumnID:parentColumnID,
    		sortColumn:sortColumn,
			 _t:Math.random()},
        	function(data){
	        	var result = eval('('+data+')'); 
	        	goCurrentPage();
	        	parent.layer.msg(result.message, {time: 800});
        });
	}
	function toUpdate(id) {
		top.art.dialog.open('<c:url value="/manageColumn/toUpdate?columnId='+id+'"/>',
		{
			id:123,
			fixed:true,
			esc:true,
			title:'更新菜单',
			width: '700px',
			height:'426px',
		    cancelVal: '取消',
	        cancel: true, //为true等价于function(){}
	        okVal : "更新",
			ok:function(){
				var iframe = this.iframe.contentWindow;
		        var flag = iframe.validate();
		        if(flag){
					update(iframe);
		        }
  				return flag;
			}
		});
	}
		// 执行更新
	function update(iframe){
		var columnId = getIframeVal(iframe,"mColumnId");
		var columnName = getIframeVal(iframe,"mColumnName");
		var columnUrl = getIframeVal(iframe,"mColumnUrl");
		var parentColumnID = getIframeVal(iframe,"mParentColumnID");
		var state = getIframeVal(iframe,"mState");
		var columnOrder = getIframeVal(iframe,"mColumnOrder");
		var columnImg = getIframeVal(iframe,"mColumnImg");
		var flag = true ;
	    if (flag){ 
	        $.post("<c:url value='/manageColumn/updateManageColumn'/>",
	        	{
	    		columnId : columnId,
	    		columnName : columnName,
	    		columnUrl : columnUrl,
	    		parentColumnID : parentColumnID,
	    		state : state,
	    		columnOrder : columnOrder,
	    		columnImg : columnImg,
				 _t:Math.random()},
	        	function(data){
					var result = eval('('+data+')'); 
		            if (result.code == '1') {
		            	goCurrentPage();
		            	tipOk("更新成功!");
		            } else {
		            	 tipError(result.message);
		            }
	        });
	    }
	}
	
		
	// 添加
	function toAdd(){
		top.art.dialog.open('<c:url value="/manageColumn/toAdd"/>',
		{
			id:456,
			fixed:true,
			esc:true,
			title:'新增菜单',
			width: '700px',
			height:'426px',
		    cancelVal: '取消',
	        cancel: true, //为true等价于function(){}
	        okVal : "保存",
			ok:function(){
				var iframe = this.iframe.contentWindow;
		         var flag = iframe.validate();
		        if(flag){
					add(iframe);
		        }
 				return flag;
			}
		});
		}
		// 执行添加
	function add(iframe){
		var columnId = getIframeVal(iframe,"aColumnId");
		var columnName = getIframeVal(iframe,"aColumnName");
		var columnUrl = getIframeVal(iframe,"aColumnUrl");
		var parentColumnID = getIframeVal(iframe,"aParentColumnID");
		var state = getIframeVal(iframe,"aState");
		var columnOrder = getIframeVal(iframe,"aColumnOrder");
		var columnImg = getIframeVal(iframe,"aColumnImg");
		var flag = true ;
	    if (flag){ 
	        $.post("<c:url value='/manageColumn/addManageColumn'/>",
	        	{
	    		columnId : columnId,
	    		columnName : columnName,
	    		columnUrl : columnUrl,
	    		parentColumnID : parentColumnID,
	    		state : state,
	    		columnOrder : columnOrder,
	    		columnImg : columnImg,
				 _t:Math.random()},
	        	function(data){
					var result = eval('('+data+')'); 
		            if (result.code == '1') {
		            	goCurrentPage();
		            	tipOk("保存成功!");
		             } else {
		            	 tipError(result.message);
		             }
	        });
	    }
	}
	// 删除所选
	function delAll(){
		var ids = '';
		$("[name='checkName']").each(function(){
		    	var ck = $(this).attr("checked");
		    	if(ck == 'checked'){
		    		ids+=$(this).attr("id")+",";
		    	}else{
		    	}
			})
		if(ids!=''){
			parent.layer.msg('你确定要删除吗？', {
   			  time: 0 //不自动关闭
   			  ,btn: ['确定', '取消']
   			  ,yes: function(index){
   					$.post("<c:url value='/manageColumn/removeAllManageColumn'/>",
 			        	{
 							columnIds :ids,
 							ranNum:Math.random()
 						},
 			        	function(data){
 				        	var result = eval('('+data+')'); 
 				            if (result.code == '1') {
 				            	goCurrentPage();
			            		tipOk("删除完成!");
 				             } else {
 				            	tipError(result.message);
 				             }
 				        });
   			  }
   			});
		}else{
			tipOk("请选择待删除条目!");
		}
	}
		// 单条删除
	function del(columnId){
	   if (columnId != ""){
		   parent.layer.msg('你确定要删除吗？', {
  			  time: 0 //不自动关闭
  			  ,btn: ['确定', '取消']
  			  ,yes: function(index){
  				$.post("<c:url value='/manageColumn/removeManageColumn'/>",
	        	{
					columnId:columnId,
					ranNum:Math.random()
				},
	        	function(data){
		        	var result = eval('('+data+')'); 
		            if (result.code == '1') {
		            	goCurrentPage();
		              	tipOk("删除成功!");
		             } else {
		            	 tipError(result.message);
		             }
		        });
  			  }
  		 });
   	   }
    }
	function goCurrentPage(){
		var pageNo = $("#currPage").val();           
	  	searchData(pageNo);
	}
</script>
</body>
</html>
 