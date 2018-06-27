<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title}</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx}/css/style.css" />
	<link href="${ctx }/plus/ztree/css/metroStyle/metroStyle.css" rel="stylesheet" />
	<%@ include file="/WEB-INF/page/common/js.jsp" %>	
	<script src="${ctx}/js/common.js"></script> 
	<script type="text/javascript" src="${ctx}/plus/layer/layer.js"></script> 
	<script type="text/javascript" src="${ctx}/plus/ztree/jquery.ztree.core.js"></script>  
	<script type="text/javascript" src="${ctx}/plus/ztree/jquery.ztree.excheck.js"></script> 
	<script type="text/javascript" src="${ctx}/plus/ztree/jquery.ztree.exedit.js"></script>
	<style type="text/css">
	   	.ztree li a.curSelectedNode{
	   		background-color: #FFFFFF;
	   		border: 0px solid #FFFFFF;
	   		text-decoration: none;
	   	}
	   	.ztree li a{
	   		text-decoration: none;
	   	}
	   	.ztree li a:hover{
	   		text-decoration: none;
	   	}
	 	.ztree li ul .med{
	   		color:blue;
	   	}
	   	.line{
	   		height: 100%;
	   	}
	   	.refreshbtn{
	   		position: absolute;
	   		margin-top: -40px;
	   		right: 20px;
	   	}
   </style>  
</head>

<body style="background:#fff;">
    <input type="hidden" id="currPage" value="1"><!-- 当前页码 -->
	<input type="hidden" id="returnNum" value="10"><!-- 分页返回 -->
	<input type="hidden" id="sortColumn" value=""><!-- 排序字段 -->
	<div id="content1">
	  <div id="content-header">
	      <h1>职能体系管理</h1>
	  </div>
		<div class="container-fluid">
		  <p></p>
		  <div class="row-fluid">
		    <div class="span12">
		   		<ul id="treeDemo" class="ztree" style="overflow: auto;"></ul>
		    </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
	var zTree ;
	var setting = {
		async : {
			enable : true,//开启异步加载处理
			url : encodeURI(encodeURI("${ctx}/yyFunction/getRootNode")),
			autoParam : [ "id" ],
			dataFilter : filter,
			contentType : "application/json",
			type : "get"
		},
		view : {
			addHoverDom : addHoverDom,
			removeHoverDom : removeHoverDom,
			fontCss : {color:"#797979"}
		},
		edit : {
			enable: true, //单独设置为true时，可加载修改、删除图标  
	        editNameSelectAll: true  
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			beforeRemove : beforeRemove,
			beforeRename : beforeRename,
			
			beforeClick : beforeClick  //单击事件  
// 	        onRemove: onRemove, //移除事件  
// 	        onRename: onRename //修改事件  
		}
	};
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes)
			return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	function beforeRemove(treeId, treeNode) {
		if (confirm("确认删除节点【" + treeNode.name + "】吗?")) { 
            var param = "id=" + treeNode.id;  
            $.post(encodeURI(encodeURI("${ctx}/yyFunction/removeYyFunction?"+ param)), function(data) {
            	var result = eval('('+data+')'); 
	            if (result.code == '1') {
	            	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	            	zTree.removeNode(treeNode);
	            }else{
	            	layer.msg("请先删除子节点");
	            	return false;
	            }
            });  
        } else {  
            return false;  
        } 
		return false;  
	}
	function beforeClick(treeId, treeNode) {
		if(!treeNode.isParent){
			$("#clickId").val(treeNode.id);
		}
		$(".node_name").css("color","#797979");
		$("#"+treeNode.tId+"_span").css("color","red");
	}
	function beforeRename(treeId, treeNode, newName) {
		if (newName.length == 0) {
			layer.msg("节点名称不能为空.");
			return false;
		}
		var param = "id=" + treeNode.id + "&name=" + newName;
		$.post(encodeURI(encodeURI("${ctx}/yyFunction/updateYyFunction?"
				+ param)));
		return true;
	}

	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
			return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_" + treeNode.tId);
		if (btn)
			btn.bind("click", function() {
				layer.prompt({title: '添加节点', formType: 2}, function(text, index){
					if(text==""){
						layer.msg('请输入名称');
					}else{
						var param ="&pId="+ treeNode.id + "&name=" + text;
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						$.post(encodeURI(encodeURI("${ctx}/yyFunction/addNodes?level=1"+ param)), function(data) {
							if ($.trim(data) != null) {
								var treenode = eval("("+$.trim(data)+")");
								zTree.addNodes(treeNode, {
									pId : treeNode.id,
									name : text
								}, true);
							}
						})
						layer.close(index);
					}
					  
				});
			});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_" + treeNode.tId).unbind().remove();
	};
	$(document).ready(function() {
		$.fn.zTree.init($("#treeDemo"), setting);
		layer.config({extend: '../extend/layer.ext.js'});
	});
		function searchData(pageNo){
			parent.layer.load();
			var returnNum = $("#returnNum").val();
			var sortColumn = $("#sortColumn").val();
		    var id = $("#fId").val();
		    var name = $("#fName").val();
		    var parent_id = $("#fParent_id").val();
		    $.getJSON("<c:url value='/yyFunction/getYyFunctionList'/>",
	        {
	        	sortColumn:sortColumn,
	    		id : id,
	    		name : name,
	    		parent_id : parent_id,
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
		    	str+= "<th class=\"sortTh\" id=\"th_parent_id\" column='parent_id'>parent_id<i class=\"icon-sort\"></i></th>";
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
			        tableStr += "<td>" + result.items[k].parent_id + "</td>";
		        tableStr += "<td>";
	        	tableStr += "<perm:tag permPath='/yyFunction/updateYyFunction' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/yyFunction/removeYyFunction' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
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
   			top.art.dialog.open('<c:url value="/yyFunction/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'添加yyFunction',
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
			var parent_id = getIframeVal(iframe,"aParent_id");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyFunction/addYyFunction'/>",
		        	{
		    		id : id,
		    		name : name,
		    		parent_id : parent_id,
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
			top.art.dialog.open('<c:url value="/yyFunction/toUpdate?id='+id+'"/>',
			{
				id:123,
				fixed:true,
				title:'yyFunction',
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
			var parent_id = getIframeVal(iframe,"mParent_id");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyFunction/updateYyFunction'/>",
		        	{
		    		id : id,
		    		name : name,
		    		parent_id : parent_id,
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
  	   				$.post("<c:url value='/yyFunction/removeAllYyFunction'/>",
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
	   			 	$.post("<c:url value='/yyFunction/removeYyFunction'/>",
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
