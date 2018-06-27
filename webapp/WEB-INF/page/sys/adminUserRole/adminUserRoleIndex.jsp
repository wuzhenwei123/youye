<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
 <!DOCTYPE html>
<!--[if lt IE 7 ]> <html class="ie6"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie7"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html>
<!--<![endif]-->

<head>
<meta charset="utf-8">
<title>${_title }</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="description" content="">
<meta name="author" content="">

<!-- Le styles -->
<%@ include file="/WEB-INF/page/common/css.jsp" %>

</head>

<body class="sidebar-left">
  <input type="hidden" id="currPage" value="1"><!-- 当前页码 -->
	<input type="hidden" id="returnNum" value="10"><!-- 分页返回 -->
	<input type="hidden" id="sortColumn" value=" createTime ASC "><!-- 排序字段 -->
	<div class="page-container">
		<!-- 头开始 -->
	    <%@ include file="/WEB-INF/page/common/header.jsp" %>
	   	<!--  头结束 -->
	    <!-- // header-container -->
	    
	    <div id="main-container">
	        <div id="main-sidebar" class="sidebar sidebar-inverse">
	        	<!-- // 左边 -->
	        	<%@ include file="/WEB-INF/page/common/left.jsp" %>
		        <!-- // 左边 -->
	        </div>
	        <!-- // sidebar -->
	        <!--  右边开始 -->
	        <div id="main-content" class="main-content container-fluid">
	            <div id="page-content" class="page-content">
	                <section>
	                    <div class="row-fluid" style=" margin-top: 20px;">
	                    	<div class="span12 widget widget-simple widget-collapsible bg-gray-light">
	                            <div data-target="#demoB" data-toggle="collapse" class="widget-header header-small clickable collapsed">
	                                <h4><i class="fontello-icon-search-4"></i>查询</h4>
	                                <div class="widget-tool"><span class="btn btn-glyph btn-link widget-toggle-btn fontello-icon-publish"></span></div>
	                            </div>
	                            <div class="widget-content collapse" id="demoB" style="height: 0px;">
	                                <div class="widget-body">
	                                    <div class="widget-row form-inline row-fluid">
                                    		<label class="margin5">用户ID：</label>
                                            <input type="text" id="fAdminId" class="span2 margin5" placeholder="用户ID">
                                    		<label class="margin5">用户名：</label>
                                            <input type="text" id="fAdminName" class="span2 margin5" placeholder="用户名">
                                    		<label class="margin5">昵称：</label>
                                            <input type="text" id="fNickName" class="span2 margin5" placeholder="昵称">
                                    		<label class="margin5">真实姓名：</label>
                                            <input type="text" id="fRealName" class="span2 margin5" placeholder="真实姓名">
                                    		<label class="margin5">手机：</label>
                                            <input type="text" id="fMobile" class="span2 margin5" placeholder="手机">
	                                    </div>
	                                    <div class="widget-row form-inline">
                                    		<label class="margin5">电话：</label>
                                            <input type="text" id="fPhone" class="span2 margin5" placeholder="电话">
                                    		<label class="margin5">登陆日期：</label>
                                            <input type="text" id="fLastLogin" class="span2 margin5" placeholder="登陆日期">
                                            <label class="margin5">状态：</label>
						                	<select id="fState" class="span2 margin5"> 
						                        <option value="">全部</option> 
						                        <option value="1">正常</option> 
						                        <option value="0">禁用</option> 
						                	</select> 
<!--                                     		<label class="margin5">创建人：</label> -->
<!--                                             <input type="text" id="fCreaterId" class="span2 margin5" placeholder="创建人"> -->
	                                    </div>
	                                </div>
	                                <div class="widget-footer text-center">
	                                    <div class="btn-toolbar"> 
	                                    	<a href="javascript:searchData('1');" class="btn btn-green">查询</a> 
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </section>
	                <section>
	                    <div class="row-fluid">
	                    	<div class="span12 widget widget-simple bg-gray-light">
	                             <div class="widget-header">
	                                 <div class="btn-toolbar"> 
	                                 	 <div class="btn-group"> 
	                                 	 	<perm:tag permPath="/manageColumn/toAdd" >
	                                 	 	<a href="javascript:toAdd();" class="btn btn-glyph"><i class="fontello-icon-plus-1"></i>新增</a> 
	                                 	 	</perm:tag>
	                                 	 	<perm:tag permPath="/manageColumn/removeAllManageColumn" >
	                                 	 	<a href="javascript:delAll();" class="btn btn-glyph"><i class="fontello-icon-minus-1"></i>删除</a> 
	                                 	 	</perm:tag>
	                                 	</div>
	                                 </div>
	                             </div>
	                             <div class="widget-content" id="demo1">
	                                 <div class="widget-body">
	                                     <table id="exampleDTC" class="table table-striped table-content table-condensed boo-table table-hover bg-blue-light">
		                                </table>
		                                <div class="widget-footer">
		                                    <div class="btn-toolbar pull-left">
		                                    </div>
		                                    <div class="pagination pagination-btn pull-right">
		                                    	<div id="kkpager"></div>
		                                    </div>
		                                    <!-- // pagination -->
		                                </div>
	                                 </div>
	                             </div>
	                         </div>
	                    </div>
	                </section>
	            </div>
	            <!-- // page content --> 
	            
	        </div>
	       	<!--  右边结束 -->
	        <!-- // main-content --> 
	        
	    </div>
	    <!-- // main-container  -->
	    
	    <footer id="footer-fix">
	        <div id="footer-sidebar" class="footer-sidebar">
	            <div class="navbar">
	                <div class="btn-toolbar"> <a class="btn btn-glyph btn-link" href="javascript:void(0);"><i class="fontello-icon-up-open-1"></i></a> </div>
	            </div>
	        </div>
	        <!-- // footer sidebar -->
	        	<%@ include file="/WEB-INF/page/common/footer.jsp" %>
	        <!-- // footer content --> 
	        
	    </footer>
	    <!-- // footer-fix  --> 
	    
	</div>
<!-- // page-container  --> 

<!-- Le javascript --> 
<!-- Only This Demo Page --> 
<div id="temModal" class="modal hide fade" tabindex="-1" data-width="50%"></div>
   
   <script type="text/javascript">
	    $(document).ready(function(){
	    	searchData(1);
	    });
		function searchData(pageNo){
			var returnNum = $("#returnNum").val();
			var sortColumn = $("#sortColumn").val();
		    var id = $("#fId").val();
		    var adminId = $("#fAdminId").val();
		    var roleId = $("#fRoleId").val();
		    $.getJSON("<c:url value='/adminUserRole/getAdminUserRoleList'/>",
	        {
	        	sortColumn:sortColumn,
	    		id : id,
	    		adminId : adminId,
	    		roleId : roleId,
	    		pageNo: pageNo,
	    		rowCount: returnNum, 
				_t: Math.random()
	        },function(data){
	            var result = data;
	            if (result.code == 1) {
	                setTableStr(result, pageNo, returnNum);
	            } else {
	            	top.art.dialog.alert(result.message);
	            } 
		    });
		}
		function genTableHeader(){
			var str = "<tr>" ;
		    	str+= "<th width='30'>#</th>";
		    	str+= "<th width='50'>序号</th>";
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_id' column='id' >id</th>";
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_adminId' column='adminId' >adminId</th>";
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_roleId' column='roleId' >roleId</th>";
				str+="<th>操	作</th>";
				str+="</tr>";
			return str;
		}
		function setTableStr(result, pageNo, returnNum){
		 	var tableStr = "<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"list_table\">";
		    tableStr += genTableHeader();
		    var number = (pageNo - 1) * returnNum;
		    for (var k=0; k<result.items.length; k++){      
		        tableStr += "<tr  class=\"tr\">";
		        tableStr += "<td class='td_center'><input type='checkbox' name='checkName' id='" + result.items[k].id + "'/></td>";
		        tableStr += "<td class='td_center'>" + (number + k + 1) + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].id + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].adminId + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].roleId + "</td>";
		        tableStr += "<td class=\"op_class td_center\"><a href='javascript:void(0);' onclick='toUpdate(" + result.items[k].id + ");return false;'>编辑</a>";
		        tableStr += "<a href='javascript:void(0);' onclick='del(" + result.items[k].id + ");return false;'>删除</a>";
		        tableStr += "</td>";
		        tableStr += "</tr>";            
		    }
		    
		    $("#tableBody").html(tableStr);
		    $("#currPage").val(pageNo);	
		    
		    initTh();
		    initTr();
		    
		    genPageTag(pageNo,result.totalResults,returnNum);
		}

   		// 更新
		function toUpdate(id) {
			top.art.dialog.open('<c:url value="/adminUserRole/toUpdate?id='+id+'"/>',
			{
				id:123,
				fixed:true,
				esc:true,
				title:'adminUserRole',
				width: '730px',
				height:'400px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "更新",
				ok:function(){
					var iframe = this.iframe.contentWindow;
			    	if (!iframe.document.body) {
			        	return false;
			        };
			         var flag = validateForm(iframe,'updateForm');
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
			var adminId = getIframeVal(iframe,"mAdminId");
			var roleId = getIframeVal(iframe,"mRoleId");
			var flag = true ;
		    if (flag){ 
		        $.post("<c:url value='/adminUserRole/updateAdminUserRole'/>",
		        	{
		    		id : id,
		    		adminId : adminId,
		    		roleId : roleId,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			              	var pageNo = $("#currPage").val();           
			              	searchData(pageNo);
			              	top.art.dialog.tips('更新成功');
			             } else {
			            	 top.art.dialog.alert(result.message);
			             }
		        });
		    }
   		}
		
   		
   		// 添加
   		function toAdd(){
   			top.art.dialog.open('<c:url value="/adminUserRole/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'adminUserRole',
				width: '730px',
				height:'400px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "保存",
				ok:function(){
					var iframe = this.iframe.contentWindow;
			    	if (!iframe.document.body) {
			        	return false;
			        };
			         var flag = validateForm(iframe,'addForm');
			        if(flag){
						add(iframe);
			        }
      				return flag;
				}
			});
   		}
   		// 执行添加
   		function add(iframe){
			var id = getIframeVal(iframe,"aId");
			var adminId = getIframeVal(iframe,"aAdminId");
			var roleId = getIframeVal(iframe,"aRoleId");
			var flag = true ;
		    if (flag){ 
		        $.post("<c:url value='/adminUserRole/addAdminUserRole'/>",
		        	{
		    		id : id,
		    		adminId : adminId,
		    		roleId : roleId,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			              	var pageNo = $("#currPage").val();           
			              	searchData(pageNo);
			              	top.art.dialog.tips('保存成功');
			             } else {
			            	 top.art.dialog.alert(result.message);
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
   		 		top.art.dialog.tips('请选择');
   		    }else{
	   			top.art.dialog({
	   				title:'警告',
	   			    lock: true,
	   			    background: '#600', // 背景色
	   			    opacity: 0.87,	// 透明度
	   			    content: '你确定要删除吗?',
	   			    icon: 'error',
	   			    ok: function () {
	   			    	$.post("<c:url value='/adminUserRole/removeAllAdminUserRole'/>",
			        	{
							ids :ids,
							ranNum:Math.random()},
				        	function(data){
					        	var result = eval('('+data+')'); 
					            if (result.code == '1') {
					              	var pageNo = $("#currPage").val();           
					              	searchData(pageNo);
					             	top.art.dialog.tips('删除完成');
					             } else {
					            	top.art.dialog.alert(result.message);
					             }
				        });
	   			        return true;
	   			    },
	   			    cancel: true
	   			});
   		    }
   			
   		}
   		// 单条删除
   		function del(id){
   		   if (id != ""){ 
	   			top.art.dialog({
	   				title:'警告',
	   			    lock: true,
	   			    background: '#600', // 背景色
	   			    opacity: 0.87,	// 透明度
	   			    content: '你确定要删除吗?',
	   			    icon: 'error',
	   			    ok: function () {
	   			    	$.post("<c:url value='/adminUserRole/removeAdminUserRole'/>",
			        	{
							id	:id,
							ranNum:Math.random()},
				        	function(data){
					        	var result = eval('('+data+')'); 
					            if (result.code == '1') {
					              	var pageNo = $("#currPage").val();           
					              	searchData(pageNo);
					              	
					             	top.art.dialog.tips('删除完成');
					             } else {
					            	top.art.dialog.alert(result.message);
					             }
				        });
	   			        return true;
	   			    },
	   			    cancel: true
	   			});
		   	 }
   				
   	    }
   </script>
 </body>
 </html>
