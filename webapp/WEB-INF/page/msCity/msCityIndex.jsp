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

<body style="background:#eee;">
    <input type="hidden" id="currPage" value="1"><!-- 当前页码 -->
	<input type="hidden" id="returnNum" value="10"><!-- 分页返回 -->
	<input type="hidden" id="sortColumn" value=""><!-- 排序字段 -->
	<div id="content1">
	  <div id="content-header">
	      <h1>msCity</h1>
	  </div>
		<div class="container-fluid">
		  <div class="row-fluid">
		    <div class="span12">
		      <div class="widget-box">
		        <div class="widget-title" data-toggle="collapse" href="#search-coll"> 
		        	<span class="icon"><i class="icon-chevron-down"></i></span>
		          	<h5>高级检索</h5>
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
		                <label class="control-label name_label">cityCode:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCityCode"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">cityName:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCityName"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">provinceCode:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fProvinceCode"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">countryCode:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCountryCode"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">alp:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fAlp"/>
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
		<perm:tag permPath="/msCity/addMsCity" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
		<perm:tag permPath="/msCity/removeAllMsCity" >
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
		    var cityCode = $("#fCityCode").val();
		    var cityName = $("#fCityName").val();
		    var provinceCode = $("#fProvinceCode").val();
		    var countryCode = $("#fCountryCode").val();
		    var alp = $("#fAlp").val();
		    $.getJSON("<c:url value='/msCity/getMsCityList'/>",
	        {
	        	sortColumn:sortColumn,
	    		id : id,
	    		cityCode : cityCode,
	    		cityName : cityName,
	    		provinceCode : provinceCode,
	    		countryCode : countryCode,
	    		alp : alp,
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
		    	str+= "<th class=\"sortTh\" id=\"th_cityCode\" column='cityCode'>cityCode<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_cityName\" column='cityName'>cityName<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_provinceCode\" column='provinceCode'>provinceCode<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_countryCode\" column='countryCode'>countryCode<i class=\"icon-sort\"></i></th>";
		    	str+= "<th class=\"sortTh\" id=\"th_alp\" column='alp'>alp<i class=\"icon-sort\"></i></th>";
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
			        tableStr += "<td>" + result.items[k].cityCode + "</td>";
			        tableStr += "<td>" + result.items[k].cityName + "</td>";
			        tableStr += "<td>" + result.items[k].provinceCode + "</td>";
			        tableStr += "<td>" + result.items[k].countryCode + "</td>";
			        tableStr += "<td>" + result.items[k].alp + "</td>";
		        tableStr += "<td>";
	        	tableStr += "<perm:tag permPath='/msCity/updateMsCity' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/msCity/removeMsCity' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
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
   			top.art.dialog.open('<c:url value="/msCity/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'添加msCity',
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
			var cityCode = getIframeVal(iframe,"aCityCode");
			var cityName = getIframeVal(iframe,"aCityName");
			var provinceCode = getIframeVal(iframe,"aProvinceCode");
			var countryCode = getIframeVal(iframe,"aCountryCode");
			var alp = getIframeVal(iframe,"aAlp");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/msCity/addMsCity'/>",
		        	{
		    		id : id,
		    		cityCode : cityCode,
		    		cityName : cityName,
		    		provinceCode : provinceCode,
		    		countryCode : countryCode,
		    		alp : alp,
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
			top.art.dialog.open('<c:url value="/msCity/toUpdate?id='+id+'"/>',
			{
				id:123,
				fixed:true,
				title:'msCity',
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
			var cityCode = getIframeVal(iframe,"mCityCode");
			var cityName = getIframeVal(iframe,"mCityName");
			var provinceCode = getIframeVal(iframe,"mProvinceCode");
			var countryCode = getIframeVal(iframe,"mCountryCode");
			var alp = getIframeVal(iframe,"mAlp");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/msCity/updateMsCity'/>",
		        	{
		    		id : id,
		    		cityCode : cityCode,
		    		cityName : cityName,
		    		provinceCode : provinceCode,
		    		countryCode : countryCode,
		    		alp : alp,
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
  	   				$.post("<c:url value='/msCity/removeAllMsCity'/>",
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
	   			 	$.post("<c:url value='/msCity/removeMsCity'/>",
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
