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
	      <h1>公司账户管理</h1>
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
			                <input type="text" class="span8 name_span" id="fName"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">昵称:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fNick_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">工号:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fUser_number"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">是否是管理员:</label>
	                	<div class="controls name_control">
			            <select id="fIs_manager" class="span12"> 
	                        <option value="">--全部--</option> 
	                        <option value="1">是</option> 
	                        <option value="0">否</option> 
	                	</select> 
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">登录账号:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fLogin_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">状态:</label>
	                	<div class="controls name_control name_select">
	                    <select id="fState" class="span12"> 
	                        <option value="">--全部--</option> 
	                        <option value="1">正常</option> 
	                        <option value="0">禁用</option> 
	                	</select> 
                	     </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">手机:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fPhone"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">邮箱:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fMail"/>
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
		<perm:tag permPath="/yyUser/addYyUser" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
		<perm:tag permPath="/yyUser/removeAllYyUser" >
	    <button class="btn btn-danger" onclick="delAll()"><i class="icon-trash"></i>批量删除</button>
		</perm:tag>
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
			$.ajaxSetup({ 
			    async : false 
			});
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
	    		id : id,
	    		name : name,
	    		nick_name : nick_name,
	    		user_number : user_number,
	    		company_id : company_id,
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
		    	str+= "<th><input id=\"checkAllBtn\" type='checkbox' value='ON' onclick=\"checkAll('checkAllBtn','checkName');\" name='check-all'></th>";
		    	str+= "<th>序号</th>";
		    	str+="<th>操作</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_name\" column='name'>姓名</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_nick_name\" column='nick_name'>昵称</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_user_number\" column='user_number'>工号</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_company_id\" column='company_id'>所属公司</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_is_manager\" column='is_manager'>是否是管理员</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_parent_id\" column='parent_id'>直属上级</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_sex\" column='sex'>性别</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_login_name\" column='login_name'>登录名</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_state\" column='state'>状态</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_phone\" column='phone'>手机</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_mail\" column='mail'>邮箱</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_lower_level_number\" column='lower_level_number'>学习下级人数</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_create_time\" width='135' column='create_time'>入职时间</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_job\" column='job'>职位</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_department\" column='department'>部门</th>";
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
		        tableStr += "<td>";
	        	tableStr += "<perm:tag permPath='/yyUser/updateYyUser' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/yyUser/removeYyUser' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
	        	if(result.items[k].state==1){
		        	tableStr += "<perm:tag permPath='/yyUser/stopYyUser' ><button class=\"btn btn-mini btn-success\" onclick='stopYyUser(" + result.items[k].id + ",this," + result.items[k].state + ");'><i class=\"icon-minus-sign\"></i>停用</button></perm:tag>";
	        	}else if(result.items[k].state == 0){
	        		tableStr += "<perm:tag permPath='/yyUser/stopYyUser' ><button class=\"btn btn-mini btn-success\" onclick='stopYyUser(" + result.items[k].id + ",this," + result.items[k].state + ");'><i class=\"icon-ok\"></i>启用</button></perm:tag>";
	        	}
	        	
	        	tableStr += "<perm:tag permPath='/yyUser/qRCode' ><button class=\"btn btn-mini btn-warning\" onclick='toqRCode(" + result.items[k].id + ");'><i class=\"icon-qrcode\"></i>获取二维码</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/yyUser/showCourse' ><button class=\"btn btn-mini btn-success\" onclick='showCourse(" + result.items[k].id + ");'><i class=\"icon-volume-down\"></i>查看分配课程</button></perm:tag>";
	        	tableStr += "</td>";
			        tableStr += "<td>" + result.items[k].name + "</td>";
			        tableStr += "<td>" + result.items[k].nick_name + "</td>";
			        tableStr += "<td>" + result.items[k].user_number + "</td>";
			        tableStr += "<td>" + result.items[k].company_name + "</td>";
			        if(result.items[k].is_manager == 1){
			        tableStr += "<td class='text-green'>是</td>";
					}else{
			        tableStr += "<td class='text-red'>否</td>";
					}
			        tableStr += "<td>" + result.items[k].parent_name + "</td>";
			        if(result.items[k].sex == 1){
			        tableStr += "<td class='text-green'>男</td>";
					}else{
			        tableStr += "<td class='text-red'>女</td>";
					}
			        tableStr += "<td>" + result.items[k].login_name + "</td>";
					if(result.items[k].state == 1){
			        tableStr += "<td class='text-green'>正常</td>";
					}else{
			        tableStr += "<td class='text-red'>禁用</td>";
					}
			        tableStr += "<td>" + result.items[k].phone + "</td>";
			        tableStr += "<td>" + result.items[k].mail + "</td>";
			        tableStr += "<td>" + result.items[k].lower_level_number + "</td>";
			        tableStr += "<td>" + genDateTimeAll(result.items[k].create_time) + "</td>";
			        tableStr += "<td>" + result.items[k].job + "</td>";
			        tableStr += "<td>" + result.items[k].department + "</td>";
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
   			top.art.dialog.open('<c:url value="/yyUser/toAdd"/>',
			{
				id:45699,
				fixed:true,
				esc:true,
				title:'添加公司用户',
				width: '730px',
				height:'400px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "保存",
				ok:function(){
					var iframe = this.iframe.contentWindow;
					var flag = iframe.validate();
					$.ajaxSettings.async = false;
			        //验证登录名是否存在
			        var login_name = getIframeVal(iframe,"aLogin_name");
			        $.get("<c:url value='/yyUser/checkUserLoginName'/>",
		        	{
		    		login_name : login_name,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	if(flag){
			            		iframe.document.getElementById("aLogin_name").style.borderColor="#468847";
					        }
			             } else {
			            	 flag = false;
			            	 iframe.document.getElementById("aLogin_name").style.borderColor="#b94a48";
			            	 tipError(result.message);
			            	 return false;
			             }
			        });
			      	//验证手机号是否存在
			        var phone = getIframeVal(iframe,"aPhone");
			        $.get("<c:url value='/yyUser/checkUserPhone'/>",
		        	{
			        	phone : phone,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	if(flag){
			            		iframe.document.getElementById("aPhone").style.borderColor="#468847";
					        }
			             } else {
			            	 flag = false;
			            	 iframe.document.getElementById("aPhone").style.borderColor="#b94a48";
			            	 tipError(result.message);
			            	 return false;
			             }
			        });
			        if(flag){
			        	add(iframe);
			        }
			        return flag;
				}
			});
   		} 
   		function add(iframe){
			var id = getIframeVal(iframe,"aId");
			var name = getIframeVal(iframe,"aName");
			var nick_name = getIframeVal(iframe,"aNick_name");
			var user_number = getIframeVal(iframe,"aUser_number");
			var company_id = getIframeVal(iframe,"aCompany_id");
			var is_manager = getIframeVal(iframe,"aIs_manager");
			var parent_id = getIframeVal(iframe,"aParent_id");
			var parent_ids = getIframeVal(iframe,"aParent_ids");
			var sex = getIframeVal(iframe,"aSex");
			var login_name = getIframeVal(iframe,"aLogin_name");
			var password = getIframeVal(iframe,"aPassword");
			var state = getIframeVal(iframe,"aState");
			var head_img = getIframeVal(iframe,"aHead_img");
			var phone = getIframeVal(iframe,"aPhone");
			var mail = getIframeVal(iframe,"aMail");
			var lower_level_number = getIframeVal(iframe,"aLower_level_number");
			var parent_name = getIframeVal(iframe,"aParent_name");
			var create_time = getIframeVal(iframe,"aCreate_time");
			var job = getIframeVal(iframe,"aJob");
			var job_level = getIframeVal(iframe,"aJob_level");
			var department = getIframeVal(iframe,"aDepartment");
			var job_info = getIframeVal(iframe,"aJob_info");
			var history_job = getIframeVal(iframe,"aHistory_job");
			var remark1 = getIframeVal(iframe,"aRemark1");
			var remark2 = getIframeVal(iframe,"aRemark2");
			var remark3 = getIframeVal(iframe,"aRemark3");
			var company_name = getIframeVal(iframe,"aCompany_name");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyUser/addYyUser'/>",
		        	{
		    		id : id,
		    		name : name,
		    		nick_name : nick_name,
		    		user_number : user_number,
		    		company_id : company_id,
		    		is_manager : is_manager,
		    		parent_id : parent_id,
		    		parent_ids : parent_ids,
		    		sex : sex,
		    		login_name : login_name,
		    		company_name : company_name,
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
		    		job_info_str : job_info,
		    		history_job : history_job,
		    		remark1 : remark1,
		    		remark2 : remark2,
		    		remark3 : remark3,
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
			top.art.dialog.open('<c:url value="/yyUser/toUpdate?id='+id+'"/>',
			{
				id:123,
				fixed:true,
				title:'编辑公司用户',
				esc:true,
				width: '730px',
				height:'400px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "更新",
				ok:function(){
					var iframe = this.iframe.contentWindow;
					var flag = iframe.validate();
					$.ajaxSettings.async = false;
			      //验证登录名是否存在
			        var login_name = getIframeVal(iframe,"mLogin_name");
			        var id = getIframeVal(iframe,"mId");
			        $.get("<c:url value='/yyUser/checkUserLoginName'/>",
		        	{
		    		id : id,
		    		login_name : login_name,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	if(flag){
			            		iframe.document.getElementById("mLogin_name").style.borderColor="#468847";
					        }
			             } else {
			            	 flag = false;
			            	 tipError(result.message);
			            	 iframe.document.getElementById("mLogin_name").style.borderColor="#b94a48";
			            	 return false;
			             }
			        });
			      //验证手机号是否存在
			        var phone = getIframeVal(iframe,"mPhone");
			        $.get("<c:url value='/yyUser/checkUserPhone'/>",
		        	{
			        id : id,
			        phone : phone,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	if(flag){
			            		iframe.document.getElementById("mPhone").style.borderColor="#468847";
					        }
			             } else {
			            	 flag = false;
			            	 iframe.document.getElementById("mPhone").style.borderColor="#b94a48";
			            	 tipError(result.message);
			            	 return false;
			             }
			        });
			        if(flag){
			        	update(iframe);
			        }
			        return flag;
				}
			});
		}
		// 执行更新
   		function update(iframe){
			var id = getIframeVal(iframe,"mId");
			var name = getIframeVal(iframe,"mName");
			var nick_name = getIframeVal(iframe,"mNick_name");
			var user_number = getIframeVal(iframe,"mUser_number");
			var company_id = getIframeVal(iframe,"mCompany_id");
			var is_manager = getIframeVal(iframe,"mIs_manager");
			var parent_id = getIframeVal(iframe,"mParent_id");
			var parent_ids = getIframeVal(iframe,"mParent_ids");
			var sex = getIframeVal(iframe,"mSex");
			var login_name = getIframeVal(iframe,"mLogin_name");
			var password = getIframeVal(iframe,"mPassword");
			var state = getIframeVal(iframe,"mState");
			var head_img = getIframeVal(iframe,"mHead_img");
			var phone = getIframeVal(iframe,"mPhone");
			var mail = getIframeVal(iframe,"mMail");
			var lower_level_number = getIframeVal(iframe,"mLower_level_number");
			var parent_name = getIframeVal(iframe,"mParent_name");
			var create_time = getIframeVal(iframe,"mCreate_time");
			var job = getIframeVal(iframe,"mJob");
			var job_level = getIframeVal(iframe,"mJob_level");
			var department = getIframeVal(iframe,"mDepartment");
			var job_info = getIframeVal(iframe,"mJob_info");
			var history_job = getIframeVal(iframe,"mHistory_job");
			var remark1 = getIframeVal(iframe,"mRemark1");
			var remark2 = getIframeVal(iframe,"mRemark2");
			var remark3 = getIframeVal(iframe,"mRemark3");
			var company_name = getIframeVal(iframe,"mCompany_name");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyUser/updateYyUser'/>",
		        	{
		    		id : id,
		    		name : name,
		    		nick_name : nick_name,
		    		user_number : user_number,
		    		company_id : company_id,
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
		    		job_info_str : job_info,
		    		history_job : history_job,
		    		remark1 : remark1,
		    		remark2 : remark2,
		    		remark3 : remark3,
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
  	   				$.post("<c:url value='/yyUser/removeAllYyUser'/>",
		        	{
						ids :ids,
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
		function del(id){
   		   if (id != ""){ 
	   			parent.layer.msg('你确定要删除吗？', {
	   			  time: 0 //不自动关闭
	   			  ,btn: ['确定', '取消']
	   			  ,yes: function(index){
	   			 	$.post("<c:url value='/yyUser/removeYyUser'/>",
   		        	{
   						id	:id,
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
		function toqRCode(id){
			top.art.dialog.open('<c:url value="/yyUser/toqRCode?parent_id='+id+'"/>',
					{
						id:1233,
						fixed:true,
						title:'获取二维码',
						esc:true,
						width: '730px',
						height:'400px',
					    cancelVal: '取消',
				        cancel: true, //为true等价于function(){}
				        button: [  
		                	{  
		                    	name: '下载8CM',  
		                     	callback: function () {
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyUser/downQRCode?id="+id+"&type=1&imgUrl="+imgUrl;
	                    	    	return false;
		                     	}  
		                 	},{  
		                    	name: '下载12CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyUser/downQRCode?id="+id+"&type=2&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	},{  
		                    	name: '下载15CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyUser/downQRCode?id="+id+"&type=3&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	},{  
		                    	name: '下载30CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyUser/downQRCode?id="+id+"&type=4&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	},{  
		                    	name: '下载50CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyUser/downQRCode?id="+id+"&type=5&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	}
				        ],
					});
		}
		
		function showCourse(id){
			top.art.dialog.open('<c:url value="/yyUser/toShowCourse?id='+id+'"/>',
			{
				id:45666,
				fixed:true,
				esc:true,
				title:'课程详情',
				width: '100%',
				height:'400px',
			    cancelVal: '关闭',
		        cancel: true //为true等价于function(){}
			});
		}
		
		function stopYyUser(id,obj,state){
			var msg = "";
			if(state=="1"){
				msg = "停用";
				state = 0;
			}else if(state=="0"){
				msg = "启用";
				state = 1;
			}
			if (id != ""){ 
	   			parent.layer.msg('你确定要'+msg+'该用户吗？', {
	   			  time: 0 //不自动关闭
	   			  ,btn: ['确定', '取消']
	   			  ,yes: function(index){
	   			 	$.post("<c:url value='/yyUser/stopYyUser'/>",
   		        	{
   						id	:id,
   						state	:state,
   						ranNum:Math.random()
   					},
   		        	function(data){
   			        	var result = eval('('+data+')'); 
   			            if (result.code == '1') {
   			              	tipOk(msg+"成功!");
   			            	 goCurrentPage();
   			              	if(state=="0"){
   			              		$(obj).html('<i class=\"icon-ok\"></i>启用');
   			              		$("#state"+id).html("停用");
   			              		$("#state"+id).attr("class","text-red");
   			              	}else if(state=="1"){
   			              		$(obj).html('<i class=\"icon-minus-sign\"></i>停用');
   			              		$("#state"+id).html("活跃");
   			              		$("#state"+id).attr("class","text-green");
   			              	}
   			             } else {
   			              	tipError(msg+"失败!");
   			             }
   			        });
	   			  }
	   			});
	   	  	}
		}
	</script>
</body>
</html>
