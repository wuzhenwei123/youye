<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title }</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	
	<link rel="stylesheet" href="${ctx }/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx }/css/style.css" />
	<link href="${ctx }/plus/ztree/css/metroStyle/metroStyle.css" rel="stylesheet" />
	
	<script src="${ctx }/matrix/js/jquery.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.ui.custom.js"></script> 
	<script src="${ctx }/matrix/js/bootstrap.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.uniform.js"></script> 
	<script src="${ctx }/matrix/js/matrix.form_common.js"></script>
	<script src="${ctx }/matrix/js/matrix.js"></script>
	<script src="${ctx }/js/common.js"></script> 
	<!-- ztree  -->
	<script type="text/javascript" src="${ctx}/plus/ztree/jquery.ztree.core.js"></script>  
	<script type="text/javascript" src="${ctx}/plus/ztree/jquery.ztree.excheck.js"></script>  
	
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

<body style="background:#eee;">
	<div id="content1">
	  <div id="content-header">
	      <h1>用户 & 职能</h1>
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
	<input type="hidden" id="selNodeId">
	<input type="hidden" id="selNodeName">
	<script type="text/javascript">
	   var zTree ;
	   var setting = {
			   callback: {
					onCheck: zTreeOnCheck
				},
				check: {
					enable: true,
					chkStyle: "checkbox",
					radioType: "all"
				},
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
		// 设置操作方法
	   function addDiyDom(treeId, treeNode) {
		   var medHtml ='';
		   var meds = JSON.parse(treeNode.meds);//操作集合
		   if(meds.length == 0)
			   return;
		   for(var i =0 ; i< meds.length;i++){
			   var med = meds[i];
			   if(med.checked){// 是否选中
				   medHtml += "|<span class='med' >"+med.name+"</span><input type='checkbox' id='med_"+treeNode.id+"_"+med.mid+"' onclick='updateRoleMed("+treeNode.id+","+med.mid+")' checked='checked' value='"+med.mid+"' name='opName' />";
			   }else{
				   medHtml += "|<span class='med' >"+med.name+"</span><input type='checkbox' id='med_"+treeNode.id+"_"+med.mid+"' onclick='updateRoleMed("+treeNode.id+","+med.mid+")' value='"+med.mid+"' name='opName' />";
			   }
		   }
		   	
			var aObj = $("#" + treeNode.tId + "_a");
			if ($("#diyBtn_"+treeNode.id).length>0) return;
			var editStr = medHtml;
			aObj.append(editStr);
		};
		     	
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, ${nodes});
			zTree = $.fn.zTree.getZTreeObj("treeDemo");
			type = { "Y":"ps", "N":"ps"};
			zTree.setting.check.chkboxType = type;
			initForm();
		});
		var function_ids = "";
		var function_names = "";
		// 更新菜单选中事件
		function zTreeOnCheck(event,treeId,treeNode){
			
			if (treeNode.checked) {
				if(function_ids==""){
					function_ids = treeNode.id;
				}else{
					function_ids = function_ids + "," + treeNode.id;
				}
				if(function_names==""){
					function_names = treeNode.name;
				}else{
					function_names = function_names + "," + treeNode.name;
				}
				$("#selNodeId").val(function_ids);
				$("#selNodeName").val(function_names);
				ck = 'add';
			}else{
				ck = 'move';
				if(function_names!=""){
					var function_ids1 = "";
					var function_names1 = "";
					var function_namesub = function_names.split(",");
					for(var i=0;i<function_namesub.length;i++){
						if(treeNode.name!=function_namesub[i]){
							if(function_names1==""){
								function_names1 = function_namesub[i];
							}else{
								function_names1 = function_names1 + "," + function_namesub[i];
							}
						}
					}
					var function_idsub = function_ids.split(",");
					for(var i=0;i<function_idsub.length;i++){
						if(treeNode.id!=function_idsub[i]){
							if(function_ids1==""){
								function_ids1 = function_idsub[i];
							}else{
								function_ids1 = function_ids1 + "," + function_idsub[i];
							}
						}
					}
					function_ids = function_ids1;
					function_names = function_names1;
					$("#selNodeId").val(function_ids);
					$("#selNodeName").val(function_names);
				}
			
				
// 				$.uniform.update($('input[id^="med_'+treeNode.id+'"]').removeAttr("checked"));
			}
			
// 			 $.post("<c:url value='/yyUser/updateFunction'/>",
// 	        	{
// 				 userId : '${userId}',
// 	    		function_id : treeNode.id,
// 	    		ck:ck,
// 				 _t:Math.random()},
// 	        	function(data){
// 		        	var result = eval('('+data+')'); 
// 		            if (result.code == '1') {
// 		              	tipOk('更新成功');
// 		             } else {
// 		            	 tipError(result.message);
// 		             }
// 	        });

			
		}
		
		// 获取选中菜单
		function getSelectedNodes(){
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getCheckedNodes(true);
			return nodes;
		}
		
	</script>
</body>
</html>
