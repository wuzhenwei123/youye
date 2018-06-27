<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${_title}</title>
	<meta charset="UTF-8" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>	
	<link rel="stylesheet" href="${ctx }/matrix/css/uniform.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-style2.css" />
	<link rel="stylesheet" href="${ctx }/matrix/css/matrix-media.css" />
	<link rel="stylesheet" href="${ctx }/css/style.css" />
	<link href="${ctx }/plus/ztree/css/metroStyle/metroStyle.css" rel="stylesheet" />
	<%@ include file="/WEB-INF/page/common/js.jsp" %>	
	<script src="${ctx}/plus/layui/layui.js"></script> 
	<script src="${ctx}/js/common.js"></script> 
	
	<script src="${ctx}/plus/layui/layui.js"></script> 
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
	      <h1>课程体系管理</h1>
	  </div>
		<div class="container-fluid">
		<input type="hidden" id="clickId">
		<div class="row-fluid">
		  	<div class="span3" >
		  		<div class="widget-box" style="border: 3px solid #ddd;height: 450px;overflow: auto;">
		  		
		  		<ul id="treeDemo" class="ztree" style="overflow: auto;"></ul>
		  	
		  	</div>
		  	</div>
		    <div class="span9">
		    	
		   		<div class="widget-box">
		          <perm:tag permPath="/yyCourse/addYyCourse" >
				    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
					</perm:tag>
					<perm:tag permPath="/yyCourse/removeAllYyCourse" >
				    <button class="btn btn-danger" onclick="delAll()"><i class="icon-trash"></i>批量删除</button>
					</perm:tag>
					<perm:tag permPath="/yyCourse/function_set" >
				    <button class="btn btn-inverse" onclick="function_set()"><i class="icon-cogs"></i>职能匹配</button>
					</perm:tag>
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
	var zTree ;
	var setting = {
		async : {
			enable : true,//开启异步加载处理
			url : encodeURI(encodeURI("${ctx}/yyCourseClassify/getRootNode")),
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
			isMove: true
// 	        editNameSelectAll: true  
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			beforeRemove : beforeRemove,
			beforeDrop: zTreeBeforeDrop,
// 			beforeRename : beforeRename,
			beforeEditName: beforeEditName,
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
	function zTreeBeforeDrop(treeId, treeNodes, targetNode, moveType) {
		 var oldPid=treeNodes[0].pId;
	     var targetPid=targetNode.pId;
	     if(oldPid!=targetPid){
	        alert("只能在同一模块下面移动位置");
	        return false;
	     }
	     if(oldPid=="root"||targetPid=="root"){
	        alert("只能移动子模块的节点。");
	     	return false;
	     }
	     var sort_id = targetNode.sort_id-1;
	     var param = "id=" + treeNodes[0].id+"&sort_id="+sort_id; 
	     $.post(encodeURI(encodeURI("${ctx}/yyCourseClassify/updateYyCourseClassify1?"+ param)), function(data) {
         	var result = eval('('+data+')'); 
	            if (result.code == '1') {
	            	return true;
	            }else{
	            	return false;
	            }
         });
	}
	function beforeRemove(treeId, treeNode) {
		if (confirm("确认删除节点【" + treeNode.name + "】吗?")) { 
            var param = "id=" + treeNode.id;  
            $.post(encodeURI(encodeURI("${ctx}/yyCourseClassify/removeYyCourseClassify?"+ param)), function(data) {
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
			searchData(1,treeNode.id);
		}
		$(".node_name").css("color","#797979");
		$("#"+treeNode.tId+"_span").css("color","red");
	}
	
	function beforeEditName(treeId, treeNode, newName) {
		top.art.dialog.open('<c:url value="/yyCourseClassify/toAddLevelCourse?id='+treeNode.id+'&level='+treeNode.level+'&pId='+treeNode.id+'"/>',
				{
					id:147,
					fixed:true,
					esc:true,
					title:'修改',
					width: '730px',
					height:'400px',
				    cancelVal: '取消',
			        cancel: true, //为true等价于function(){}
			        okVal : "保存",
					ok:function(){
						var iframe = this.iframe.contentWindow;
				        var flag = iframe.validate();
				        var img_url = getIframeVal(iframe,"mImg_url");
// 				        if(img_url==""){
// 				        	tipError("请上传封面");
// 				        	flag = false;
// 				        	return flag;
// 				        }
				        if(flag){
							updateCourse(iframe,treeNode);
				        }
	      				return flag;
					}
				});
		return true;
	}
	
	function beforeRename(treeId, treeNode, newName) {
		if (newName.length == 0) {
			layer.msg("节点名称不能为空.");
			return false;
		}
		if(treeNode.level<3){
			var param = "id=" + treeNode.id + "&name=" + newName;
			$.post(encodeURI(encodeURI("${ctx}/yyCourseClassify/updateYyCourseClassify?"
					+ param)));
		}else{
			top.art.dialog.open('<c:url value="/yyCourseClassify/toAddLevelCourse?id='+treeNode.id+'&level='+treeNode.level+'&pId='+treeNode.id+'"/>',
			{
				id:147,
				fixed:true,
				esc:true,
				title:'修改课程',
				width: '730px',
				height:'400px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "保存",
				ok:function(){
					var iframe = this.iframe.contentWindow;
			        var flag = iframe.validate();
// 			        var img_url = getIframeVal(iframe,"mImg_url");
// 			        if(img_url==""){
// 			        	tipError("请上传封面");
// 			        	flag = false;
// 			        	return flag;
// 			        }
			        if(flag){
						updateCourse(iframe,treeNode);
			        }
      				return flag;
				}
			});
		}
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
// 				if(treeNode.level<2){
// 					layer.prompt({title: '添加节点', formType: 2}, function(text, index){
// 						if(text==""){
// 							layer.msg('请输入名称');
// 						}else{
// 							var param = treeNode.level + "&pId="+ treeNode.id + "&name=" + text;
// 							var zTree = $.fn.zTree.getZTreeObj("treeDemo");
// 							$.post(encodeURI(encodeURI("${ctx}/yyCourseClassify/addNodes?level="+ param)), function(data) {
// 								if ($.trim(data) != null) {
// 									var treenode = eval("("+$.trim(data)+")");
// 									console.log(treenode);
// 									zTree.addNodes(treeNode, {
// 										pId : treeNode.id,
// 										name : text
// 									}, true);
// 								}
// 							})
// 							layer.close(index);
// 						}
						  
// 					});
// 				}else{
					top.art.dialog.open('<c:url value="/yyCourseClassify/toAddLevelCourse?level='+treeNode.level+'&pId='+treeNode.id+'"/>',
					{
						id:147,
						fixed:true,
						esc:true,
						title:'添加',
						width: '730px',
						height:'400px',
					    cancelVal: '取消',
				        cancel: true, //为true等价于function(){}
				        okVal : "保存",
						ok:function(){
							var iframe = this.iframe.contentWindow;
					        var flag = iframe.validate();
					        var img_url = getIframeVal(iframe,"mImg_url");
// 					        if(img_url==""){
// 					        	tipError("请上传封面");
// 					        	flag = false;
// 					        	return flag;
// 					        }
					        if(flag){
					        	updateCourse(iframe,treeNode);
					        }
		      				return flag;
						}
					});
// 				}
			});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_" + treeNode.tId).unbind().remove();
	};
	$(document).ready(function() {
		$.fn.zTree.init($("#treeDemo"), setting);
		layer.config({extend: '../extend/layer.ext.js'});
		searchData(1,0);
	});
	
	
	function searchData(pageNo,classify_id){
		parent.layer.load();
		var returnNum = $("#returnNum").val();
		var sortColumn = $("#sortColumn").val();
	    var id = $("#fId").val();
	    var name = $("#fName").val();
	    var code = $("#fCode").val();
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
	    	str+= "<th class=\"sortTh\" id=\"th_name\" column='name'>知识点名称</th>";
	    	str+= "<th class=\"sortTh\" id=\"th_code\" column='code'>知识点编号</th>";
	    	str+= "<th class=\"sortTh\" id=\"th_code\" column='code'>视频状态</th>";
	    	str+= "<th class=\"sortTh\" id=\"th_code\" column='code'>音频状态</th>";
	    	str+= "<th class=\"sortTh\" id=\"th_when_long\" column='when_long'>时长</th>";
	    	str+= "<th class=\"sortTh\" id=\"th_sort_id\" column='sort_id'>显示顺序</th>";
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
	        
		        tableStr += "<td>" + result.items[k].name + "</td>";
		        tableStr += "<td>" + result.items[k].code + "</td>";
		        if(result.items[k].video_state=="2"){
		        	tableStr += "<td>转码中</td>";
		        }else if(result.items[k].video_state=="1"){
		        	tableStr += "<td>转码成功</td>";
		        }else if(result.items[k].video_state=="0"){
		        	tableStr += "<td>转码失败</td>";
		        }else{
		        	tableStr += "<td></td>";
		        }
		        if(result.items[k].audio_state=="2"){
		        	tableStr += "<td>转码中</td>";
		        }else if(result.items[k].audio_state=="1"){
		        	tableStr += "<td>转码成功</td>";
		        }else if(result.items[k].audio_state=="0"){
		        	tableStr += "<td>转码失败</td>";
		        }else{
		        	tableStr += "<td></td>";
		        }
		        tableStr += "<td>" + result.items[k].when_long + "秒</td>";
		        tableStr += "<td>" + result.items[k].sort_id + "</td>";
	        tableStr += "<td>";
        	tableStr += "<perm:tag permPath='/yyCourse/updateYyCourse' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
        	tableStr += "<perm:tag permPath='/yyCourse/removeYyCourse' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
//         	tableStr += "<perm:tag permPath='/yyCourse/function_set' ><button class=\"btn btn-mini btn-inverse\" onclick='function_set(" + result.items[k].id + ");'><i class=\"icon-cogs\"></i>职能匹配</button></perm:tag>";
        	if(result.items[k].video_state=="1"){
        		tableStr += "<button class=\"btn btn-mini btn-success\" onclick='showVideo(" + result.items[k].id + ");'><i class=\"icon-facetime-video\"></i>预览视频</button>";
        	}
        	if(result.items[k].audio_state=="1"){
        		tableStr += "<button class=\"btn btn-mini btn-warning\" onclick='showAudio(" + result.items[k].id + ");'><i class=\"icon-facetime-video\"></i>预览音频</button>";
        	}
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
			var clickId = $("#clickId").val();
			if(clickId!=""){
				top.art.dialog.open('<c:url value="/yyCourse/toAdd"/>',
				{
					id:456,
					fixed:true,
					esc:true,
					title:'添加知识点',
					width: '730px',
					height:'400px',
				    cancelVal: '取消',
			        cancel: true, //为true等价于function(){}
			        okVal : "保存",
					ok:function(){
						var iframe = this.iframe.contentWindow;
				        var flag = iframe.validate();
				        var img_url = getIframeVal(iframe,"aImg_url");
				        if(img_url==""){
				        	tipError("请上传封面");
				        	flag = false;
				        	return flag;
				        }
						var video_url = getIframeVal(iframe,"aVideo_url");
						if(video_url==""){
							tipError("请上传视频");
				        	flag = false;
				        	return flag;
				        }
						var mp3_url = getIframeVal(iframe,"aMp3_url"); 
						if(mp3_url==""){
							tipError("请上传音频");
				        	flag = false;
				        	return flag;
				        }
				        if(flag){
							add(iframe);
				        }
		  				return flag;
					}
				});
			}else{
				tipError("请选择课程");
			}
		} 
		function add(iframe){
		var id = getIframeVal(iframe,"aId");
		var name = getIframeVal(iframe,"aName");
		var code = getIframeVal(iframe,"aCode");
		var classify_id = $("#clickId").val();
		var img_url = getIframeVal(iframe,"aImg_url");
		var video_url = getIframeVal(iframe,"aVideo_url");
		var mp3_url = getIframeVal(iframe,"aMp3_url");
		var info = getIframeVal(iframe,"aInfo");
		var when_long = getIframeVal(iframe,"aWhen_long");
		var sort_id = getIframeVal(iframe,"aSort_id");
		var video_fileId = getIframeVal(iframe,"video_fileId");
		var audio_fileId = getIframeVal(iframe,"audio_fileId");
		var audioFileName = getIframeVal(iframe,"audioFileName");
		var videoFileName = getIframeVal(iframe,"videoFileName");
		var fujianUrl = iframe.getFj();
		var flag = true;
	    if (flag){ 
	        $.post("<c:url value='/yyCourse/addYyCourse'/>",
	        	{
	    		id : id,
	    		name : name,
	    		audioFileName : audioFileName,
	    		video_fileId : video_fileId,
	    		videoFileName : videoFileName,
	    		audio_fileId : audio_fileId,
	    		code : code,
	    		fujianUrl : fujianUrl,
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
		            	var clickId = $("#clickId").val();
		            	searchData(1,clickId);
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
			title:'编辑知识点',
			esc:true,
			width: '730px',
			height:'400px',
		    cancelVal: '取消',
	        cancel: true, //为true等价于function(){}
	        okVal : "更新",
			ok:function(){
				var iframe = this.iframe.contentWindow;
		        var flag = iframe.validate();
		        var img_url = getIframeVal(iframe,"mImg_url");
		        if(img_url==""){
		        	tipError("请上传封面");
		        	flag = false;
		        	return flag;
		        }
				var video_url = getIframeVal(iframe,"mVideo_url");
				if(video_url==""){
					tipError("请上传视频");
		        	flag = false;
		        	return flag;
		        }
				var mp3_url = getIframeVal(iframe,"mMp3_url"); 
				if(mp3_url==""){
					tipError("请上传音频");
		        	flag = false;
		        	return flag;
		        }
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
		var video_fileId = getIframeVal(iframe,"video_fileId");
		var audio_fileId = getIframeVal(iframe,"audio_fileId");
		var audioFileName = getIframeVal(iframe,"audioFileName");
		var videoFileName = getIframeVal(iframe,"videoFileName");
		var fujianUrl = iframe.getFj();
		var flag = true;
	    if (flag){ 
	        $.post("<c:url value='/yyCourse/updateYyCourse'/>",
	        	{
	    		id : id,
	    		name : name,
	    		audioFileName : audioFileName,
	    		videoFileName : videoFileName,
	    		video_fileId : video_fileId,
	    		fujianUrl : fujianUrl,
	    		audio_fileId : audio_fileId,
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
		            	var clickId = $("#clickId").val();
		            	searchData(1,clickId);
		            	tipOk("更新成功!");
		             } else {
		            	 tipError(result.message);
		             }
	        });
	    }
		}
		function updateCourse(iframe,treeNode){
		var id = getIframeVal(iframe,"mId");
		var name = getIframeVal(iframe,"mName");
		var level = getIframeVal(iframe,"level");
		var parent_id = getIframeVal(iframe,"parent_id");
		var img_url = getIframeVal(iframe,"mImg_url");
		var info = getIframeVal(iframe,"mInfo");
		var flag = true;
	    if (flag){
	    	var url = "${ctx}/yyCourseClassify/addNodes";
	    	if(id!=""){
	    		url = "${ctx}/yyCourseClassify/updateYyCourseClassify";
	    	}
	        $.post("<c:url value='"+url+"'/>",
	        	{
	    		id : id,
	    		name : name,
	    		pId : parent_id,
	    		img_url : img_url,
	    		level : level,
	    		info : info,
				 _t:Math.random()},
	        	function(data){
					var zTree = $.fn.zTree.getZTreeObj("treeDemo");
					if(id!=""){
						var result = eval('('+data+')'); 
			            if (result.code == '1') {
			            	treeNode.name = name;
			            	zTree.updateNode(treeNode);
			            	tipOk("更新成功!");
			             } else {
			            	 tipError(result.message);
			             }
					}else{
						if ($.trim(data) != null) {
							var treenode = eval("("+$.trim(data)+")");
							zTree.addNodes(treeNode, {
								pId : treeNode.id,
								id : treenode.items,
								name : name
							}, true);
							tipOk("添加成功!");
						}else{
							tipError(result.message);
						}
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
			            	var clickId = $("#clickId").val();
			            	searchData(1,clickId);
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
			            	var clickId = $("#clickId").val();
			            	searchData(1,clickId);
			              	tipOk("删除成功!");
			             } else {
			            	 tipError(result.message);
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
	
	function showVideo(id){
		top.art.dialog.open('<c:url value="/yyCourse/showVideo?id='+id+'"/>',
				{
					id:456,
					fixed:true,
					esc:true,
					title:'预览视频',
					width: '730px',
					height:'400px',
				    cancelVal: '关闭',
			        cancel: true, //为true等价于function(){}
			      
				});
	}
	function showAudio(id){
		top.art.dialog.open('<c:url value="/yyCourse/showAudio?id='+id+'"/>',
				{
					id:456,
					fixed:true,
					esc:true,
					title:'预览音频',
					width: '730px',
					height:'400px',
				    cancelVal: '关闭',
			        cancel: true, //为true等价于function(){}
			      
				});
	}
	
	function function_set(){
		var clickId = $("#clickId").val();
		if(clickId!=""){
			top.art.dialog.open('<c:url value="/yyCourse/function_set?id='+clickId+'"/>',
					{
						id:456,
						fixed:true,
						esc:true,
						title:'职能匹配',
						width: '730px',
						height:'400px',
					    cancelVal: '关闭',
				        cancel: true, //为true等价于function(){}
				      
					});
		}else{
			tipError("请选择课程");
		}
		
	}
	</script>
</body>
</html>
