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
	      <h1>系统账户管理</h1>
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
		              <label class="control-label name_label">用户ID:</label>
		              <div class="controls name_control">
		                <input type="text" class="span8 name_span" id="fAdminId"/>
		              </div>
		            </div>
		            <div class="control-group name_title">
		              <label class="control-label name_label">用户名:</label>
		              <div class="controls name_control">
		                <input type="text" class="span8 name_span" id="fAdminName"/>
		              </div>
		            </div>
		            <div class="control-group name_title">
		              <label class="control-label name_label">昵称:</label>
		              <div class="controls name_control">
		                <input type="text" class="span8 name_span" id="fNickName"/>
		              </div>
		            </div>
		            <div class="control-group name_title">
		              <label class="control-label name_label">真实姓名:</label>
		              <div class="controls name_control">
		                <input type="text" class="span8 name_span" id="fRealName" />
		              </div>
		            </div>
		            <div class="control-group name_title">
		              <label class="control-label name_label">手机号码:</label>
		              <div class="controls name_control">
		                <input type="text" class="span8 name_span" id="fMobile" />
		              </div>
		            </div>
		            <div class="control-group name_title">
		              <label class="control-label name_label">角色:</label>
		              <div class="controls name_contro name_selectl">
		                <select id="fRoleId" class="span12"> 
	                       <option value="">--请选择--</option> 
			    			<c:forEach items="${roleList }" var="role">
	                       <option value="${role.roleId }">${role.roleName }</option> 
			    			</c:forEach>
		               	</select> 
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
		<perm:tag permPath="/manageAdminUser/toAdd" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
		<perm:tag permPath="/manageAdminUser/removeAllManageAdminUser" >
	    <button class="btn btn-danger" onclick="delAll()"><i class="icon-trash"></i>批量删除</button>
		</perm:tag>
		  <div class="row-fluid">
		    <div class="span12">
		   		<div class="widget-box">
		          <!-- <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
		            <h5>列表</h5>
		          </div> -->
		          <div class="widget-content tab_con">
		            <table class="table table-bordered table-striped  with-check" id="exampleDTC"></table>
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
		    var adminId = $("#fAdminId").val();
		    var adminName = $("#fAdminName").val();
		    var nickName = $("#fNickName").val();
		    var passwd = $("#fPasswd").val();
		    var realName = $("#fRealName").val();
		    var mobile = $("#fMobile").val();
		    var phone = $("#fPhone").val();
		    var lastLogin = $("#fLastLogin").val();
		    var loginIP = $("#fLoginIP").val();
		    var pwdModifyTime = $("#fPwdModifyTime").val();
		    var state = $("#fState").val();
		    var createTime = $("#fCreateTime").val();
		    var createrId = $("#fCreaterId").val();
		    $.getJSON("<c:url value='/manageAdminUser/getManageAdminUserList'/>",
	        {
		    	roleId:roleId,
	        	sortColumn:sortColumn,
	    		adminId : adminId,
	    		adminName : encodeURI(adminName),
	    		nickName : encodeURI(nickName),
	    		passwd : passwd,
	    		realName : encodeURI(realName),
	    		mobile : mobile,
	    		phone : phone,
	    		lastLogin : lastLogin,
	    		loginIP : loginIP,
	    		pwdModifyTime : pwdModifyTime,
	    		state : state,
	    		createTime : createTime,
	    		createrId : createrId,
	    		pageNo: pageNo,
	    		rowCount: returnNum, 
				_t: Math.random()
	        },function(data){
	            var result = data;
	            parent.layer.closeAll('loading');
	            if (result.code == 1) {
	                setTableStr(result, pageNo, returnNum);
	            } else {
	            	tipError(result.message);
	            } 
		    });
		}
		function genTableHeader(){
			var str = "<thead><tr>" ;
				str+= "<th><input id=\"checkAllBtn\" type='checkbox' value='ON' onclick=\"checkAll('checkAllBtn','checkName');\" name='check-all'></th>";
		    	str+= "<th width='30'>序号</th>";
		    	str+= "<th class='sortTh' width='50'  id='th_adminId' column='adminId'>用户ID<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' id='th_adminName' column='adminName' >用户名<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' id='th_nickName' column='nickName' >昵称<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' id='th_realName' column='realName' >真实姓名<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' id='th_mobile' column='mobile' >手机<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' id='th_phone' column='phone' >电话<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' id='th_roleName' column='roleName' >角色名称<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' width='135' id='th_lastLogin' column='lastLogin' >最后登陆日期<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class='sortTh' width='50'  id='th_state'column='state' >状态</th>";
		    	str+= "<th class='sortTh' width='135' id='th_createTime' column='createTime' >创建日期<i class=\"icon-sort\"></i></th>";
		    	str+= "<th width='50' >创建人</th>";
				str+= "<th width='100'>操作</th>";
				str+= "</tr></thead>";
			return str;
		}
		function setTableStr(result, pageNo, returnNum){
			var tableStr = "";
		    tableStr += genTableHeader();
	        tableStr += "<tbody>";
		    var number = (pageNo - 1) * returnNum;
		    for (var k=0; k<result.items.length; k++){      
		        tableStr += "<tr>";
		        tableStr += "<td ><input type=\"checkbox\" id='"+result.items[k].adminId+"'value=\"0\" name=\"checkName\" /></td>";
		        tableStr += "<td>" + (number + k + 1) + "</td>";
		        tableStr += "<td>" + result.items[k].adminId + "</td>";
		        tableStr += "<td>" + result.items[k].adminName + "</td>";
		        tableStr += "<td>" + result.items[k].nickName + "</td>";
		        tableStr += "<td>" + result.items[k].realName + "</td>";
		        tableStr += "<td>" + result.items[k].mobile + "</td>";
		        tableStr += "<td>" + result.items[k].phone + "</td>";
		        tableStr += "<td>" + result.items[k].roleName + "</td>";
		        tableStr += "<td>" + genDateTimeAll(result.items[k].lastLogin) + "</td>";
				if(result.items[k].state == 1){
		        tableStr += "<td class='text-green'>正常</td>";
				}else{
		        tableStr += "<td class='text-red'>禁用</td>";
				}
		        tableStr += "<td>" + genDateTimeAll(result.items[k].createTime) + "</td>";
		        tableStr += "<td>" + result.items[k].createrName + "</td>";
		        tableStr += "<td>";
	        	tableStr += "<perm:tag permPath='/manageAdminUser/updateManageAdminUser' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].adminId + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/manageAdminUser/removeManageAdminUser' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].adminId + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
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
		// 添加
 		function toAdd(){
   			top.art.dialog.open('<c:url value="/manageAdminUser/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'添加用户',
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
 		function add(iframe){
			var adminId = getIframeVal(iframe,"aAdminId");
			var adminName = getIframeVal(iframe,"aAdminName");
			var nickName = getIframeVal(iframe,"aNickName");
			var passwd = getIframeVal(iframe,"aPasswd");
			var realName = getIframeVal(iframe,"aRealName");
			var mobile = getIframeVal(iframe,"aMobile");
			var phone = getIframeVal(iframe,"aPhone");
			var lastLogin = getIframeVal(iframe,"aLastLogin");
			var loginIP = getIframeVal(iframe,"aLoginIP");
			var pwdModifyTime = getIframeVal(iframe,"aPwdModifyTime");
			var state = getIframeVal(iframe,"aState");
			var createTime = getIframeVal(iframe,"aCreateTime");
			var createrId = getIframeVal(iframe,"aCreaterId");
			var roleId = getIframeVal(iframe,"aRoleId");
			var flag = validateForm(iframe,'addForm');
		    if (flag){ 
		        $.post("<c:url value='/manageAdminUser/addManageAdminUser'/>",
		        	{
		        	roleId:roleId,
		    		adminId : adminId,
		    		adminName : adminName,
		    		nickName : nickName,
		    		passwd : passwd,
		    		realName : realName,
		    		mobile : mobile,
		    		phone : phone,
		    		lastLogin : lastLogin,
		    		loginIP : loginIP,
		    		pwdModifyTime : pwdModifyTime,
		    		state : state,
		    		createTime : createTime,
		    		createrId : createrId,
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
 		// 更新
		function toUpdate(id) {
			top.art.dialog.open('<c:url value="/manageAdminUser/toUpdate?adminId='+id+'"/>',
			{
				id:123,
				fixed:true,
				esc:true,
				title:"编辑用户",
				width: '730px',
				height:'400px',
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
			var adminId = getIframeVal(iframe,"mAdminId");
			var adminName = getIframeVal(iframe,"mAdminName");
			var nickName = getIframeVal(iframe,"mNickName");
			var passwd = getIframeVal(iframe,"mPasswd");
			var realName = getIframeVal(iframe,"mRealName");
			var mobile = getIframeVal(iframe,"mMobile");
			var phone = getIframeVal(iframe,"mPhone");
			var lastLogin = getIframeVal(iframe,"mLastLogin");
			var loginIP = getIframeVal(iframe,"mLoginIP");
			var pwdModifyTime = getIframeVal(iframe,"mPwdModifyTime");
			var state = getIframeVal(iframe,"mState");
			var createTime = getIframeVal(iframe,"mCreateTime");
// 			var createrId = getIframeVal(iframe,"mCreaterId");
			var roleId = getIframeVal(iframe,"mRoleId");
		    if (true){ 
		        $.post("<c:url value='/manageAdminUser/updateManageAdminUser'/>",
		        	{
		        	roleId:roleId,
		    		adminId : adminId,
		    		adminName : adminName,
		    		nickName : nickName,
		    		passwd : passwd,
		    		realName : realName,
		    		mobile : mobile,
		    		phone : phone,
		    		lastLogin : lastLogin,
		    		loginIP : loginIP,
		    		pwdModifyTime : pwdModifyTime,
		    		state : state,
		    		createTime : createTime,
// 		    		createrId : createrId,
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
   		    if(ids == ''){
   		    	tipOk("请选择!");
   		    }else{
   		    	parent.layer.msg('你确定要删除吗？', {
  	   			  time: 0 //不自动关闭
  	   			  ,btn: ['确定', '取消']
  	   			  ,yes: function(index){
  	   				$.post("<c:url value='/manageAdminUser/removeAllManageAdminUser'/>",
		        	{
						adminIds :ids,
						ranNum:Math.random()},
			        	function(data){
				        	var result = eval('('+data+')'); 
				            if (result.code == '1') {
				            	goCurrentPage();
				            	tipOk("删除完成!");
				             } else {
				            	 tipError(result.message);
				             }
			        });
   			        return true;
  	   			  }
  	   			});
   		    }
   			
   		}
		// 单条删除
		function del(adminId){
   		   if (adminId != ""){ 
	   			parent.layer.msg('你确定要删除吗？', {
	   			  time: 0 //不自动关闭
	   			  ,btn: ['确定', '取消']
	   			  ,yes: function(index){
	   			 	$.post("<c:url value='/manageAdminUser/removeManageAdminUser'/>",
   		        	{
   						adminId	:adminId,
   						ranNum:Math.random()
   					},
   		        	function(data){
   			        	var result = eval('('+data+')'); 
   			            if (result.code == '1') {
   			            	goCurrentPage();
   			              	tipOk("删除成功!");
   			             } else {
   			              	tipError("删除失败!");
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
