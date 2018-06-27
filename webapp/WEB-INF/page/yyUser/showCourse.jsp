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
	<link rel="stylesheet" href="${ctx}/plus/date/skin/WdatePicker.css">
	<link href="${ctx }/plus/ztree/css/metroStyle/metroStyle.css" rel="stylesheet" />
	
	<script src="${ctx }/matrix/js/jquery.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.ui.custom.js"></script> 
	<script src="${ctx }/matrix/js/bootstrap.min.js"></script> 
	<script src="${ctx }/matrix/js/jquery.uniform.js"></script> 
	<script src="${ctx }/matrix/js/matrix.form_common.js"></script>
	<script src="${ctx }/matrix/js/matrix.js"></script>
	<script src="${ctx}/plus/date/WdatePicker.js"></script>
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

<body style="background:#fff;overflow:hidden;">
	<div id="content1">
	  <div id="content-header">
	      <h1>课程分配</h1>
	  </div>
		<div class="container-fluid">
		  <div class="row-fluid">
		    <div class="span12">
		    	<div class="widget-box" style="height: 320px;overflow: auto;width: 60%;border-right: 1px solid rgb(205, 205, 205);float: left;">
		            <ul id="treeDemo" class="ztree" style="overflow: auto;"></ul>
		            
		        </div>
                <div class="controls" style="float: left;margin-left: 5px;margin-top: 10px;">
	                <input type="text" placeholder="开始时间" name="start_time" id="start_time"  value="" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
	                <br>
	                <input type="text" placeholder="结束时间" name="over_time" id="over_time"  value="" required onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
            	</div>
		    </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
	   var zTree ;
	   var setting = {
			   callback: {
				   	beforeCheck: zTreeBeforeCheck,
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
					fontCss : {color:"#797979"}
				}
			};
		     	
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, ${nodes});
			zTree = $.fn.zTree.getZTreeObj("treeDemo");
			type = { "Y":"ps", "N":"ps"};
			zTree.setting.check.chkboxType = type;
			initForm();
		});
		function zTreeBeforeCheck(treeId,treeNode){
			if (!treeNode.checked) {
				var over_time = $("#over_time").val();
				if(over_time==""){
					tipError("请选择结束时间");
					return false;  
				}
			}
		}
		
		// 更新菜单选中事件
		function zTreeOnCheck(event,treeId,treeNode){
			if (treeNode.checked) {
				ck = 'add';
			}else{
				ck = 'move';
				if (confirm("确认要取消【" + treeNode.name + "】课程分配吗?取消后相关学习记录会一并被删除。")) { 
					
		        } else {  
		            return false;  
		        } 
			}
			$.post("<c:url value='/yyUser/updateUserStudy'/>",
	        	{
				user_id : '${user_id}',
	    		lession_id : treeNode.id,
	    		level : treeNode.level,
	    		over_time : $("#over_time").val(),
	    		start_time : $("#start_time").val(),
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
		
		// 获取选中菜单
		function getSelectedNodes(){
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = treeObj.getCheckedNodes(true);
			return nodes;
		}
		
	</script>
</body>
</html>
