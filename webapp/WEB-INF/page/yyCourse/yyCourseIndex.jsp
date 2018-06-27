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
	      <h1>yyCourse</h1>
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
		                <label class="control-label name_label">name:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fName"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">code:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCode"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">classify_id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fClassify_id"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">img_url:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fImg_url"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">video_url:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fVideo_url"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">mp3_url:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fMp3_url"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">info:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fInfo"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">when_long:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fWhen_long"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">sort_id:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fSort_id"/>
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
		<perm:tag permPath="/yyCourse/addYyCourse" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
		<perm:tag permPath="/yyCourse/removeAllYyCourse" >
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
		    var name = $("#fName").val();
		    var code = $("#fCode").val();
		    var classify_id = $("#fClassify_id").val();
		    var img_url = $("#fImg_url").val();
		    var video_url = $("#fVideo_url").val();
		    var mp3_url = $("#fMp3_url").val();
		    var info = $("#fInfo").val();
		    var when_long = $("#fWhen_long").val();
		    var sort_id = $("#fSort_id").val();
		    $.getJSON("<c:url value='/yyCourse/getYyCourseList'/>",
	        {
	        	sortColumn:sortColumn,
	    		id : id,
	    		name : name,
	    		code : code,
	    		classify_id : classify_id,
	    		img_url : img_url,
	    		video_url : video_url,
	    		mp3_url : mp3_url,
	    		info : info,
	    		when_long : when_long,
	    		sort_id : sort_id,
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
		    	str+= "<th class=\"sortTh\" id=\"th_name\" column='name'>name<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_code\" column='code'>code<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_classify_id\" column='classify_id'>classify_id<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_img_url\" column='img_url'>img_url<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_video_url\" column='video_url'>video_url<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_mp3_url\" column='mp3_url'>mp3_url<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_info\" column='info'>info<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_when_long\" column='when_long'>when_long<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_sort_id\" column='sort_id'>sort_id<i class=\"icon-sort\"></i></th>";
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
			        tableStr += "<td>" + result.items[k].name + "</td>";
			        tableStr += "<td>" + result.items[k].code + "</td>";
			        tableStr += "<td>" + result.items[k].classify_id + "</td>";
			        tableStr += "<td>" + result.items[k].img_url + "</td>";
			        tableStr += "<td>" + result.items[k].video_url + "</td>";
			        tableStr += "<td>" + result.items[k].mp3_url + "</td>";
			        tableStr += "<td>" + result.items[k].info + "</td>";
			        tableStr += "<td>" + result.items[k].when_long + "</td>";
			        tableStr += "<td>" + result.items[k].sort_id + "</td>";
		        tableStr += "<td>";
	        	tableStr += "<perm:tag permPath='/yyCourse/updateYyCourse' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/yyCourse/removeYyCourse' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
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
   			top.art.dialog.open('<c:url value="/yyCourse/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'添加yyCourse',
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
			var name = getIframeVal(iframe,"aName");
			var code = getIframeVal(iframe,"aCode");
			var classify_id = getIframeVal(iframe,"aClassify_id");
			var img_url = getIframeVal(iframe,"aImg_url");
			var video_url = getIframeVal(iframe,"aVideo_url");
			var mp3_url = getIframeVal(iframe,"aMp3_url");
			var info = getIframeVal(iframe,"aInfo");
			var when_long = getIframeVal(iframe,"aWhen_long");
			var sort_id = getIframeVal(iframe,"aSort_id");
			var fujianUrl = "";
			$("input[name='fujianUrl']").each(function(){
				if(fujianUrl==""){
					fujianUrl = $(this).val() + "_" + $(this).attr("arrt_name");
				}else{
					fujianUrl = fujianUrl + "," + $(this).val() + "_" + $(this).attr("arrt_name");
				}
			})
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyCourse/addYyCourse'/>",
		        	{
		    		id : id,
		    		name : name,
		    		code : code,
		    		classify_id : classify_id,
		    		img_url : img_url,
		    		video_url : video_url,
		    		mp3_url : mp3_url,
		    		fujianUrl : fujianUrl,
		    		info : info,
		    		when_long : when_long,
		    		sort_id : sort_id,
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
			top.art.dialog.open('<c:url value="/yyCourse/toUpdate?id='+id+'"/>',
			{
				id:123,
				fixed:true,
				title:'yyCourse',
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
			var name = getIframeVal(iframe,"mName");
			var code = getIframeVal(iframe,"mCode");
			var classify_id = getIframeVal(iframe,"mClassify_id");
			var img_url = getIframeVal(iframe,"mImg_url");
			var video_url = getIframeVal(iframe,"mVideo_url");
			var mp3_url = getIframeVal(iframe,"mMp3_url");
			var info = getIframeVal(iframe,"mInfo");
			var when_long = getIframeVal(iframe,"mWhen_long");
			var sort_id = getIframeVal(iframe,"mSort_id");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyCourse/updateYyCourse'/>",
		        	{
		    		id : id,
		    		name : name,
		    		code : code,
		    		classify_id : classify_id,
		    		img_url : img_url,
		    		video_url : video_url,
		    		mp3_url : mp3_url,
		    		info : info,
		    		when_long : when_long,
		    		sort_id : sort_id,
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
  	   				$.post("<c:url value='/yyCourse/removeAllYyCourse'/>",
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
	   			 	$.post("<c:url value='/yyCourse/removeYyCourse'/>",
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
