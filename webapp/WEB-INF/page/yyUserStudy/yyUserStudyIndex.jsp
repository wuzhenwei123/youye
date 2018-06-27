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
	      <h1>yyUserStudy</h1>
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
		                <label class="control-label name_label">id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fId"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">user_id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fUser_id"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">theme_id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fTheme_id"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">theme_name:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fTheme_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">module_id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fModule_id"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">module_name:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fModule_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">lesson_id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fLesson_id"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">lesson_name:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fLesson_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">point_id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fPoint_id"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">point_name:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fPoint_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">long_time:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fLong_time"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">create_time:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCreate_time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">start_time:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fStart_time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">end_time:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fEnd_time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">is_over:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fIs_over"/>
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
		<perm:tag permPath="/yyUserStudy/addYyUserStudy" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
		<perm:tag permPath="/yyUserStudy/removeAllYyUserStudy" >
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
	    	searchData(1);
	    });
		function searchData(pageNo){
			parent.layer.load();
			var returnNum = $("#returnNum").val();
			var sortColumn = $("#sortColumn").val();
		    var id = $("#fId").val();
		    var user_id = $("#fUser_id").val();
		    var theme_id = $("#fTheme_id").val();
		    var theme_name = $("#fTheme_name").val();
		    var module_id = $("#fModule_id").val();
		    var module_name = $("#fModule_name").val();
		    var lesson_id = $("#fLesson_id").val();
		    var lesson_name = $("#fLesson_name").val();
		    var point_id = $("#fPoint_id").val();
		    var point_name = $("#fPoint_name").val();
		    var long_time = $("#fLong_time").val();
		    var create_time = $("#fCreate_time").val();
		    var start_time = $("#fStart_time").val();
		    var end_time = $("#fEnd_time").val();
		    var is_over = $("#fIs_over").val();
		    $.getJSON("<c:url value='/yyUserStudy/getYyUserStudyList'/>",
	        {
	        	sortColumn:sortColumn,
	    		id : id,
	    		user_id : user_id,
	    		theme_id : theme_id,
	    		theme_name : theme_name,
	    		module_id : module_id,
	    		module_name : module_name,
	    		lesson_id : lesson_id,
	    		lesson_name : lesson_name,
	    		point_id : point_id,
	    		point_name : point_name,
	    		long_time : long_time,
	    		create_time : create_time,
	    		start_time : start_time,
	    		end_time : end_time,
	    		is_over : is_over,
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
		    	str+= "<th class=\"sortTh\" id=\"th_id\" column='id'>id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_user_id\" column='user_id'>user_id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_theme_id\" column='theme_id'>theme_id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_theme_name\" column='theme_name'>theme_name<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_module_id\" column='module_id'>module_id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_module_name\" column='module_name'>module_name<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_lesson_id\" column='lesson_id'>lesson_id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_lesson_name\" column='lesson_name'>lesson_name<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_point_id\" column='point_id'>point_id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_point_name\" column='point_name'>point_name<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_long_time\" column='long_time'>long_time<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_create_time\" width='135' column='create_time'>create_time<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_start_time\" width='135' column='start_time'>start_time<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_end_time\" width='135' column='end_time'>end_time<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_is_over\" column='is_over'>is_over<i class=\"icon-sort\"></i></th>";
				str+="<th>操作</th>";
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
		        
			        tableStr += "<td>" + result.items[k].id + "</td>";
			        tableStr += "<td>" + result.items[k].user_id + "</td>";
			        tableStr += "<td>" + result.items[k].theme_id + "</td>";
			        tableStr += "<td>" + result.items[k].theme_name + "</td>";
			        tableStr += "<td>" + result.items[k].module_id + "</td>";
			        tableStr += "<td>" + result.items[k].module_name + "</td>";
			        tableStr += "<td>" + result.items[k].lesson_id + "</td>";
			        tableStr += "<td>" + result.items[k].lesson_name + "</td>";
			        tableStr += "<td>" + result.items[k].point_id + "</td>";
			        tableStr += "<td>" + result.items[k].point_name + "</td>";
			        tableStr += "<td>" + result.items[k].long_time + "</td>";
			        tableStr += "<td>" + genDateTimeAll(result.items[k].create_time) + "</td>";
			        tableStr += "<td>" + genDateTimeAll(result.items[k].start_time) + "</td>";
			        tableStr += "<td>" + genDateTimeAll(result.items[k].end_time) + "</td>";
			        tableStr += "<td>" + result.items[k].is_over + "</td>";
		        tableStr += "<td>";
	        	tableStr += "<perm:tag permPath='/yyUserStudy/updateYyUserStudy' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/yyUserStudy/removeYyUserStudy' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
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
   			top.art.dialog.open('<c:url value="/yyUserStudy/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'添加yyUserStudy',
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
			var id = getIframeVal(iframe,"aId");
			var user_id = getIframeVal(iframe,"aUser_id");
			var theme_id = getIframeVal(iframe,"aTheme_id");
			var theme_name = getIframeVal(iframe,"aTheme_name");
			var module_id = getIframeVal(iframe,"aModule_id");
			var module_name = getIframeVal(iframe,"aModule_name");
			var lesson_id = getIframeVal(iframe,"aLesson_id");
			var lesson_name = getIframeVal(iframe,"aLesson_name");
			var point_id = getIframeVal(iframe,"aPoint_id");
			var point_name = getIframeVal(iframe,"aPoint_name");
			var long_time = getIframeVal(iframe,"aLong_time");
			var create_time = getIframeVal(iframe,"aCreate_time");
			var start_time = getIframeVal(iframe,"aStart_time");
			var end_time = getIframeVal(iframe,"aEnd_time");
			var is_over = getIframeVal(iframe,"aIs_over");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyUserStudy/addYyUserStudy'/>",
		        	{
		    		id : id,
		    		user_id : user_id,
		    		theme_id : theme_id,
		    		theme_name : theme_name,
		    		module_id : module_id,
		    		module_name : module_name,
		    		lesson_id : lesson_id,
		    		lesson_name : lesson_name,
		    		point_id : point_id,
		    		point_name : point_name,
		    		long_time : long_time,
		    		create_time : create_time,
		    		start_time : start_time,
		    		end_time : end_time,
		    		is_over : is_over,
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
			top.art.dialog.open('<c:url value="/yyUserStudy/toUpdate?id='+id+'"/>',
			{
				id:123,
				fixed:true,
				title:'yyUserStudy',
				esc:true,
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
			var id = getIframeVal(iframe,"mId");
			var user_id = getIframeVal(iframe,"mUser_id");
			var theme_id = getIframeVal(iframe,"mTheme_id");
			var theme_name = getIframeVal(iframe,"mTheme_name");
			var module_id = getIframeVal(iframe,"mModule_id");
			var module_name = getIframeVal(iframe,"mModule_name");
			var lesson_id = getIframeVal(iframe,"mLesson_id");
			var lesson_name = getIframeVal(iframe,"mLesson_name");
			var point_id = getIframeVal(iframe,"mPoint_id");
			var point_name = getIframeVal(iframe,"mPoint_name");
			var long_time = getIframeVal(iframe,"mLong_time");
			var create_time = getIframeVal(iframe,"mCreate_time");
			var start_time = getIframeVal(iframe,"mStart_time");
			var end_time = getIframeVal(iframe,"mEnd_time");
			var is_over = getIframeVal(iframe,"mIs_over");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyUserStudy/updateYyUserStudy'/>",
		        	{
		    		id : id,
		    		user_id : user_id,
		    		theme_id : theme_id,
		    		theme_name : theme_name,
		    		module_id : module_id,
		    		module_name : module_name,
		    		lesson_id : lesson_id,
		    		lesson_name : lesson_name,
		    		point_id : point_id,
		    		point_name : point_name,
		    		long_time : long_time,
		    		create_time : create_time,
		    		start_time : start_time,
		    		end_time : end_time,
		    		is_over : is_over,
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
  	   				$.post("<c:url value='/yyUserStudy/removeAllYyUserStudy'/>",
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
	   			 	$.post("<c:url value='/yyUserStudy/removeYyUserStudy'/>",
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
	</script>
</body>
</html>
