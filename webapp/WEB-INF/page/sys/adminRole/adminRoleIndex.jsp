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
	<input type="hidden" id="sortColumn" value=" createTime ASC "><!-- 排序字段 -->
	<div id="content1">
	  <div id="content-header">
	      <h1>角色管理</h1>
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
		              <label class="control-label name_label">角色名称:</label>
		              <div class="controls name_control">
		                <input type="text" class="span8 name_span" id="fRoleName"/>
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
		            <div class="control-group name_title">
		              <label class="control-label name_label">角色类型:</label>
		              <div class="controls name_control name_select">
		                <select id="fRoleType" class="span12"> 
	                        <option value="">--全部--</option> 
	                        <option value="1">超级管理</option> 
	                        <option value="0">普通管理</option> 
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
		<perm:tag permPath="/adminRole/toAdd" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
		<perm:tag permPath="/adminRole/removeAllAdminRole" >
	    <button class="btn btn-danger" onclick="delAll()"><i class="icon-trash"></i>批量删除</button>
		</perm:tag>
		  <div class="row-fluid">
		    <div class="span12">
		   		<div class="widget-box">
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
		    var roleId = $("#fRoleId").val();
		    var roleName = $("#fRoleName").val();
		    var createTime = $("#fCreateTime").val();
		    var state = $("#fState").val();
		    var defaule = $("#fDefaule").val();
		    var roleType = $("#fRoleType").val();
		    $.getJSON("<c:url value='/adminRole/getAdminRoleList'/>",
	        {
	        	sortColumn:sortColumn,
	    		roleId : roleId,
	    		roleName : roleName,
	    		createTime : createTime,
	    		state : state,
	    		defaule : defaule,
	    		roleType : roleType,
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
		    	str+= "<th width='50'>序号</th>";
		    	str+= "<th>角色ID</th>";
		    	str+= "<th class='sortTh' id='th_roleName' column='roleName' >角色名称<i class=\"icon-sort\"></i></th>";
		    	str+= "<th>状态</th>";
		    	str+= "<th>是否默认</th>";
		    	str+= "<th class='sortTh' id='th_roleType' column='roleType' >类型<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' width='135' id='th_createTime' column='createTime' >创建日期<i class=\"icon-sort\"></i></th>";
				str+="<th>操	作</th>";
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
		    	tableStr += "<td ><input type=\"checkbox\" id='"+result.items[k].roleId+"'value=\"0\" name=\"checkNames\" /></td>";
		        tableStr += "<td>" + (number + k + 1) + "</td>";
		        tableStr += "<td>" + result.items[k].roleId + "</td>";
		        tableStr += "<td>" + result.items[k].roleName + "</td>";
		        if(result.items[k].state == 1){
		        tableStr += "<td class='text-green'>正常</td>";
				}else{
		        tableStr += "<td class='text-red'>禁用</td>";
				}
		        tableStr += "<td>" + (result.items[k].defaule==1?"默认":"非默认") + "</td>";
		        tableStr += "<td>" + (result.items[k].roleType==1?"超级管理":"普通管理") + "</td>";
		        tableStr += "<td>" + genDateTimeAll(result.items[k].createTime) + "</td>";
		        tableStr += "<td>";
		        tableStr += "<perm:tag permPath='/adminRole/toUpdate' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].roleId + ");return false;'><i class=\"icon-edit\"></i>编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/adminRole/removeRoleColumn' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].roleId + ");return false;'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
		        tableStr += "<perm:tag permPath='/adminRole/toUserRoleColumn' ><button class=\"btn btn-mini btn-info\" onclick='column(" + result.items[k].roleId + ");return false;'><i class=\"icon-reorder\"></i>菜单</button></perm:tag>";
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
		// 设置菜单权限
		function column(id) {
			top.art.dialog.open('<c:url value="/adminRole/toUserRoleColumn?roleId='+id+'"/>',
			{
				id:123,
				fixed:true,
				esc:true,
				title:'设置菜单权限',
				width: '730px',
				height:'400px'
			});
		}
		// 添加
 		function toAdd(){
   			top.art.dialog.open('<c:url value="/adminRole/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'添加角色',
				width: '730px',
				height:'400px',
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
			var roleId = getIframeVal(iframe,"aRoleId");
			var roleName = getIframeVal(iframe,"aRoleName");
			var createTime = getIframeVal(iframe,"aCreateTime");
			var state = getIframeVal(iframe,"aState");
			var defaule = getIframeVal(iframe,"aDefaule");
			var roleType = getIframeVal(iframe,"aRoleType");
			var flag = true ;
		    if (flag){ 
		        $.post("<c:url value='/adminRole/addAdminRole'/>",
		        	{
		    		roleId : roleId,
		    		roleName : roleName,
		    		createTime : createTime,
		    		state : state,
		    		defaule : defaule,
		    		roleType : roleType,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	goCurrentPage();
			              	tipOk('保存成功');
			             } else {
			            	 tipError(result.message);
			             }
		        });
		    }
   		}
 		// 更新
		function toUpdate(id) {
			top.art.dialog.open('<c:url value="/adminRole/toUpdate?roleId='+id+'"/>',
			{
				id:123,
				fixed:true,
				esc:true,
				width: '730px',
				height:'300px',
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
			var roleId = getIframeVal(iframe,"mRoleId");
			var roleName = getIframeVal(iframe,"mRoleName");
			var createTime = getIframeVal(iframe,"mCreateTime");
			var state = getIframeVal(iframe,"mState");
			var defaule = getIframeVal(iframe,"mDefaule");
			var roleType = getIframeVal(iframe,"mRoleType");
			var flag = true ;
		    if (flag){ 
		        $.post("<c:url value='/adminRole/updateAdminRole'/>",
		        	{
		    		roleId : roleId,
		    		roleName : roleName,
		    		createTime : createTime,
		    		state : state,
		    		defaule : defaule,
		    		roleType : roleType,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	goCurrentPage();
			              	tipOk('更新成功');
			             } else {
			            	 tipError(result.message);
			             }
		        });
		    }
   		}
   		// 删除所选
   		function delAll(){
   			var ids = '';
   			$("[name='checkNames']").each(function(){
	   		    	var ck = $(this).attr("checked");
	   		    	if(ck == 'checked'){
	   		    		ids+=$(this).attr("id")+",";
	   		    	}else{
	   		    	}
	   		})
   		    if(ids == ''){
   		 		tipOk('请选择');
   		    }else{
   		    	parent.layer.msg('你确定要删除吗？', {
  	   			  time: 0 //不自动关闭
  	   			  ,btn: ['确定', '取消']
  	   			  ,yes: function(index){
  	   				$.post("<c:url value='/adminRole/removeAllAdminRole'/>",
		        	{
						roleIds :ids,
						ranNum:Math.random()},
			        	function(data){
				        	var result = eval('('+data+')'); 
				            if (result.code == '1') {
				            	goCurrentPage();
				             	tipOk('删除完成');
				             } else {
				            	tipError(result.message);
				             }
			        });
  	   			  }
  	   			});
   		    }
   			
   		}
   		// 单条删除
   		function del(roleId){
   		   if (roleId != ""){ 
   				parent.layer.msg('你确定要删除吗？', {
	   			  time: 0 //不自动关闭
	   			  ,btn: ['确定', '取消']
	   			  ,yes: function(index){
	   				$.post("<c:url value='/adminRole/removeAdminRole'/>",
		        	{
						roleId	:roleId,
						ranNum:Math.random()},
			        	function(data){
				        	var result = eval('('+data+')'); 
				            if (result.code == '1') {
				            	goCurrentPage();
				             	tipOk('删除完成');
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
