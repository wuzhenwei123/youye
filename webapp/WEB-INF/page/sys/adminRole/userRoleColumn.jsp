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
	      <h1>菜单 & 按钮 权限</h1>
	      <div class="refreshbtn text-right">
	      	<button class="btn btn-success" onclick="refresh()"><i class="icon-refresh"></i>清空缓存</button>
	      </div>
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
	   var zTree ;
	   var setting = {
			   callback: {
					onCheck: zTreeOnCheck
				},
				check: {
					enable: true
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
		// 更新菜单选中事件
		function zTreeOnCheck(event,treeId,treeNode){
			if (treeNode.checked) {
				ck = 'add';
			}else{
				ck = 'move';
				$.uniform.update($('input[id^="med_'+treeNode.id+'"]').removeAttr("checked"));
			}
			 $.post("<c:url value='/adminRole/updateRoleColumnNew'/>",
	        	{
	    		roleId : '${roleId}',
	    		columnId : treeNode.id,
	    		ck:ck,
				 _t:Math.random()},
	        	function(data){
		        	var result = eval('('+data+')'); 
		            if (result.code == '1') {
		              	tipOk('更新成功');
		             } else {
		            	 tipError(result.message);
		             }
	        });
		}
		//更新方法
		function updateRoleMed(columnID,mid){
			
			var medObj = $("#med_"+columnID+"_"+mid);
			var ck;
			if (medObj.attr('checked')) {
				ck = 'add';
				var node = zTree.getNodeByParam("id", columnID, null);
				zTree.checkNode(node, true, true);
			}else{
				ck = 'move';
				var node = zTree.getNodeByParam("id", columnID, null);
				zTree.checkNode(node, false, true);
			}
			 $.post("<c:url value='/adminRole/updateRoleMed'/>",
	        	{
	    		roleId : '${roleId}',
	    		mid : mid,
	    		ck:ck,
				 _t:Math.random()},
	        	function(data){
		        	var result = eval('('+data+')'); 
		            if (result.code == '1') {
		              	tipOk('更新成功');
		             } else {
		            	 tipError(result.message);
		             }
	        });
		}
		// 刷新session
		function refresh(){
			$.get("<c:url value='/manageAdminUser/refreshSession'/>",
        	{
			 _t:Math.random()},
        	function(data){
	        	var result = eval('('+data+')'); 
	            if (result.code == '1') {
	              	tipOk('缓存已清，请按F5刷新当前页面');
	             } else {
	            	 tipError(result.message);
	             }
       		});
		}
		// 获取选中菜单
		function getSelectedNodes(){
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getCheckedNodes(true);
			return nodes;
		}
		
		//获取选中操作方法
		function getSelectMed(){
			var mids = '';
			$("[name='opName']").each(function(){
				if($(this).attr("checked")){
					mids += $(this).attr("value")+",";
				}
			})
			return mids;
		}
	</script>
</body>
</html>
