<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title }</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link href="${ctx }/plus/ztree/css/metroStyle/metroStyle.css" rel="stylesheet" />
	<link rel="stylesheet" href="${ctx}/css/style.css" />
	<%@ include file="/WEB-INF/page/common/js.jsp" %>	
	<!-- ztree  -->
	<script type="text/javascript" src="${ctx}/plus/ztree/jquery.ztree.core.js"></script>  
	<script type="text/javascript" src="${ctx}/plus/ztree/jquery.ztree.excheck.js"></script>  
	<script src="${ctx}/js/common.js"></script> 
	
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
   </style>
</head>

<body style="background:#fff;">
    <input type="hidden" id="currPage" value="1"><!-- 当前页码 -->
	<input type="hidden" id="returnNum" value="10"><!-- 分页返回 -->
	<input type="hidden" id="sortColumn" value=" createTime ASC "><!-- 排序字段 -->
	
	<div id="content1">
	  <div id="content-header">
	      <h1>操作管理</h1>
	  </div>
		<div class="container-fluid">
		  <div class="row-fluid">
		    <div class="span12">
		   		<div class="widget-box">
		          <div class="widget-content tab_con">
		            <ul id="treeDemo" class="ztree" style="overflow: auto;"></ul>
		          </div>
		        </div>
		    </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
	var $modal = $('#temModal');
	    var zTree ;
	    var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		view: {
			addDiyDom: addDiyDom,
			fontCss : {color:"#797979"}
		}
	};
    $(document).ready(function(){
    	parent.layer.load();
    	getColumnTreeNodes();
    });
	// 设置操作方法
    function addDiyDom(treeId, treeNode) {
 	   
		var addHtml = "<perm:tag permPath='/columnMethod/toAddMed' ><img title='添加' src=\"${ctx}/images/add.png\" onclick='toAdd("+treeNode.id+");' ></perm:tag>";//添加按钮 
		
 	   	var medHtml ='';
		if(!treeNode.meds)
			return;
 	  	var meds = JSON.parse(treeNode.meds);//操作集合
 	  	
 	   	for(var i =0 ; i< meds.length;i++){
 		   var med = meds[i];
		   medHtml += "|<span class='med' >"+med.name+"</span><perm:tag permPath='/columnMethod/toUpdate' ><img src=\"${ctx}/images/edit.png\" title='编辑' onclick='toUpdate("+med.mid+")'/></perm:tag><perm:tag permPath='/columnMethod/toAddMed' ><img src=\"${ctx}/images/remove.png\" title='删除' onclick='del("+med.mid+")' /></perm:tag>";
 	   	}
 	   if(treeNode.level == 2){
	 	  	medHtml += "|"+addHtml;
 	   }
 	   var aObj = $("#" + treeNode.tId + "_a");
 		if ($("#diyBtn_"+treeNode.id).length>0) return;
 		var editStr = medHtml;
 		aObj.append(editStr);
 	};
 	// 获取菜单树
 	function getColumnTreeNodes(){
 		$.getJSON("<c:url value='/columnMethod/getColumnTree'/>",
	        {
				_t: Math.random()
	        },function(data){
	            var result = data;
	            if (result.code == 1) {
	            	$.fn.zTree.init($("#treeDemo"), setting, result.items);
	    			zTree = $.fn.zTree.getZTreeObj("treeDemo");
	    			type = { "Y":"ps", "N":"ps"};
	    			zTree.setting.check.chkboxType = type;
	            } else {
	            	tipError(result.message);
	            } 
	            parent.layer.closeAll('loading');
		    });
 	}
	function searchData(pageNo){
		var returnNum = $("#returnNum").val();
		var sortColumn = $("#sortColumn").val();
	    var mid = $("#fMid").val();
	    var columnId = $("#fColumnId").val();
	    var methodName = $("#fMethodName").val();
	    var actionPath = $("#fActionPath").val();
	    var createTime = $("#fCreateTime").val();
	    $.getJSON("<c:url value='/columnMethod/getColumnMethodList'/>",
        {
        	sortColumn:sortColumn,
    		mid : mid,
    		columnId : columnId,
    		methodName : methodName,
    		actionPath : actionPath,
    		createTime : createTime,
    		pageNo: pageNo,
    		rowCount: returnNum, 
			_t: Math.random()
        },function(data){
            var result = data;
            if (result.code == 1) {
                setTableStr(result, pageNo, returnNum);
            } else {
            	tipError(result.message);
            } 
	    });
	}
	function genTableHeader(){
		var str = "<tr>" ;
	    	str+= "<th width='30'>#</th>";
	    	str+= "<th width='50'>序号</th>";
	    	str+= "<th onselectstart='return false' class='sortTh' id='th_mid' column='mid' >方法ID</th>";
	    	str+= "<th onselectstart='return false' class='sortTh' id='th_columnId' column='columnId' >菜单名称</th>";
	    	str+= "<th onselectstart='return false' class='sortTh' id='th_methodName' column='methodName' >方法名称</th>";
	    	str+= "<th onselectstart='return false' class='sortTh' id='th_actionPath' column='actionPath' >方法路径</th>";
	    	str+= "<th onselectstart='return false' class='sortTh' width='135' id='th_createTime' column='createTime' >创建日期</th>";
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
	        tableStr += "<td class='td_center'><input type='checkbox' name='checkName' id='" + result.items[k].mid + "'/></td>";
	        tableStr += "<td class='td_center'>" + (number + k + 1) + "</td>";
	        tableStr += "<td class='td_center'>" + result.items[k].mid + "</td>";
	        tableStr += "<td class='td_center'>" + result.items[k].columnId + "</td>";
	        tableStr += "<td class='td_center'>" + result.items[k].methodName + "</td>";
	        tableStr += "<td class='td_center'>" + result.items[k].actionPath + "</td>";
	        tableStr += "<td class='td_center'>" + genDateTimeAll(result.items[k].createTime) + "</td>";
	        tableStr += "<td class=\"op_class td_center\"><a href='javascript:void(0);' onclick='toUpdate(" + result.items[k].mid + ");return false;'>编辑</a><a href='javascript:void(0);' onclick='del(" + result.items[k].mid + ");return false;'>删除</a></TD>";
	        tableStr += "</tr>";            
	    }
	    
	    $("#tableBody").html(tableStr);
	    $("#currPage").val(pageNo);	
	    initForm();
	    initTh();
	    initTr();
	    
	    genPageTag(pageNo,result.totalResults,returnNum);
	}

		// 更新
	function toUpdate(id) {
		top.art.dialog.open('<c:url value="/columnMethod/toUpdate?mid='+id+'"/>',
		{
			id:123,
			fixed:true,
			esc:true,
			title:'更新方法',
			width: '700px',
			height:'200px',
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
	function update(iframe){
		var mid = getIframeVal(iframe,"mMid");
		var columnId = getIframeVal(iframe,"mColumnId");
		var methodName = getIframeVal(iframe,"mMethodName");
		var actionPath = getIframeVal(iframe,"mActionPath");
		var createTime = getIframeVal(iframe,"mCreateTime");
		var flag = true ;
	    if (flag){ 
	        $.post("<c:url value='/columnMethod/updateColumnMethod'/>",
	        	{
	    		mid : mid,
	    		columnId : columnId,
	    		methodName : encodeURI(methodName,"UTF-8"),
	    		actionPath : actionPath,
	    		createTime : createTime,
				 _t:Math.random()},
	        	function(data){
		        	var result = eval('('+data+')'); 
		            if (result.code == '1') {
		            	getColumnTreeNodes();
		              	tipOk('更新成功');
		             } else {
		            	tipError(result.message);
		             }
	        });
	    }
		}
		// 添加 方法
		function toAdd(columnId){
			top.art.dialog.open('<c:url value="/columnMethod/toAddMed?columnId='+columnId+'"/>',
		{
			id:456,
			fixed:true,
			esc:true,
			title:'添加方法',
			width: '730px',
			height:'300px',
		    cancelVal: '取消',
	        cancel: true, //为true等价于function(){}
	        okVal : "保存",
			ok:function(){
				var iframe = this.iframe.contentWindow;
		         var flag = iframe.validate();
		        if(flag){
		        	addMed(columnId,iframe);
		        }
  				return flag;
			}
		});
		}
		// 执行添加
		function addMed(columnId,iframe){
			var methodName = getIframeVal(iframe,"aMethodName");
			var actionPath = getIframeVal(iframe,"aActionPath");
			var flag = true ;
		    if (flag){ 
		        $.post("<c:url value='/columnMethod/addColumnMethod'/>",
		        	{
		    		columnId : columnId,
		    		methodName : encodeURI(methodName,"UTF-8"),
		    		actionPath : actionPath,
					 _t:Math.random()},
		        	function(data){
			        	var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	getColumnTreeNodes();
			              	tipOk('保存成功');
			             } else {
			            	 tipError(result.message);
			             }
		        });
		    }
		}
		function add(iframe){
		var mid = getIframeVal(iframe,"aMid");
		var columnId = getIframeVal(iframe,"aColumnId");
		var methodName = getIframeVal(iframe,"aMethodName");
		var actionPath = getIframeVal(iframe,"aActionPath");
		var createTime = getIframeVal(iframe,"aCreateTime");
		var flag = true ;
	    if (flag){ 
	        $.post("<c:url value='/columnMethod/addColumnMethod'/>",
	        	{
	    		mid : mid,
	    		columnId : columnId,
	    		methodName : methodName,
	    		actionPath : actionPath,
	    		createTime : createTime,
				 _t:Math.random()},
	        	function(data){
		        	var result = eval('('+data+')'); 
		            if (result.code == '1') {
		            	getColumnTreeNodes();
		              	tipOk('保存成功');
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
   			    	$.post("<c:url value='/columnMethod/removeAllColumnMethod'/>",
		        	{
						mids :ids,
						ranNum:Math.random()},
			        	function(data){
				        	var result = eval('('+data+')'); 
				            if (result.code == '1') {
				            	getColumnTreeNodes();
				            	tipOk("删除成功!");
				             } else {
				            	 tipError("删除失败!"+result.message);
				             }
			        });
   			        return true;
   			    },
   			    cancel: true
   			});
		    }
			
		}
		// 单条删除
		function del(mid){
		   if (mid != ""){
			  parent.layer.msg('你确定要删除吗？', {
   			  time: 0 //不自动关闭
   			  ,btn: ['确定', '取消']
   			  ,yes: function(index){
   					$.post("<c:url value='/columnMethod/removeColumnMethod'/>",
 			        	{
 							mid	:mid,
 							ranNum:Math.random()
 						},
 			        	function(data){
 				        	var result = eval('('+data+')'); 
 				            if (result.code == '1') {
 				            	getColumnTreeNodes();
 				              	tipOk("删除成功!");
 				             } else {
 				              	tipError("删除失败!"+result.message);
 				             }
 				        });
   			  }
   			});
			 	
	   	 }
				
	    }
	</script>
</body>
</html>
