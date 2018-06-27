<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
 <!doctype html>
 <html lang="zh-CN">
 <head>
   <meta charset="UTF-8">
   <title>AdminSkins</title>
 </head>
 <body>
  <div class="container">
    <div id="search_bar" class="mt100">
       <div class="box">
          <div class="box_border">
            <div class="box_center pt10 pb10">
              <table class="search_table pr111" border="0" cellpadding="0" cellspacing="0">
	            <tr>
			        <th>skinId:</th>
				    <td><input type="text" id="fSkinId" class="input-text lh25" size="10"></td>
	            </tr>
	            <tr>
			        <th>adminId:</th>
				    <td><input type="text" id="fAdminId" class="input-text lh25" size="10"></td>
	            </tr>
	            <tr>
			        <th>dialog:</th>
				    <td><input type="text" id="fDialog" class="input-text lh25" size="10"></td>
	            </tr>
	            <tr>
			        <th>style:</th>
				    <td><input type="text" id="fStyle" class="input-text lh25" size="10"></td>
	            </tr>
	            <tr>
			        <th>kkpager:</th>
				    <td><input type="text" id="fKkpager" class="input-text lh25" size="10"></td>
	            </tr>
	        </table>
            </div>
            <div class="box_bottom pb5 pt5 pr10" style="border-top:1px solid #dadada;">
              <div class="search_bar_btn" style="text-align:center;">
                 <input type="button" name="button" class="btn btn82 btn_search" onclick="searchData('1')" value="查询">  
              </div>
            </div>
          </div>
        </div>
    </div>
    
    <input type="hidden" id="currPage" value="1"><!-- 当前页码 -->
	<input type="hidden" id="returnNum" value="10"><!-- 分页返回 -->
	<input type="hidden" id="sortColumn" value=""><!-- 排序字段 -->
    
     <div id="button" class="mt10" style="float: ${system_skins.skStyle}">
       <input type="button" id="checkAllBtn" class="btn btn82 btn_nochecked" onclick="checkAll('checkAllBtn','checkName');" value="全选"> 
       <perm:tag permPath="/adminSkins/toAdd" >
       <input type="button" class="btn btn82 btn_add" onclick="toAdd();" value="新增"> 
       </perm:tag>
       <perm:tag permPath="/adminSkins/removeAllAdminSkins" >
       <input type="button" class="btn btn82 btn_del" onclick="delAll();" value="删除"> 
       </perm:tag>
     </div>
    
     <div id="table" class="mt10" style="float: ${system_skins.skStyle}">
        <div class="box span10 oh" id="tableBody">
        </div>
      	<div class="page mt10" style="float: ${system_skins.skStyle}">
      		<div id="kkpager"></div>
     	 </div>
     </div>
     
   </div> 
   
   <script type="text/javascript">
	    $(document).ready(function(){
	    	searchData(1);
	    });
		function searchData(pageNo){
			var returnNum = $("#returnNum").val();
			var sortColumn = $("#sortColumn").val();
		    var skinId = $("#fSkinId").val();
		    var adminId = $("#fAdminId").val();
		    var dialog = $("#fDialog").val();
		    var style = $("#fStyle").val();
		    var kkpager = $("#fKkpager").val();
		    $.getJSON("<c:url value='/adminSkins/getAdminSkinsList'/>",
	        {
	        	sortColumn:sortColumn,
	    		skinId : skinId,
	    		adminId : adminId,
	    		dialog : dialog,
	    		style : style,
	    		kkpager : kkpager,
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
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_skinId' column='skinId' >skinId</th>";
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_adminId' column='adminId' >adminId</th>";
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_dialog' column='dialog' >dialog</th>";
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_style' column='style' >style</th>";
		    	str+= "<th onselectstart='return false' class='sortTh' id='th_kkpager' column='kkpager' >kkpager</th>";
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
		        tableStr += "<td class='td_center'><input type='checkbox' name='checkName' id='" + result.items[k].skinId + "'/></td>";
		        tableStr += "<td class='td_center'>" + (number + k + 1) + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].skinId + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].adminId + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].dialog + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].style + "</td>";
		        tableStr += "<td class='td_center'>" + result.items[k].kkpager + "</td>";
		        tableStr += "<td class=\"op_class td_center\">";
		        tableStr += "<perm:tag permPath='/adminSkins/updateAdminSkins' ><a href='javascript:void(0);' onclick='toUpdate(" + result.items[k].skinId + ");return false;'>编辑</a></perm:tag>";
		        tableStr += "<perm:tag permPath='/adminSkins/removeAdminSkins' ><a href='javascript:void(0);' onclick='del(" + result.items[k].skinId + ");return false;'>删除</perm:tag></a>";
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
			top.art.dialog.open('<c:url value="/adminSkins/toUpdate?skinId='+id+'"/>',
			{
				id:123,
				fixed:true,
				esc:true,
				title:'adminSkins',
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
			var skinId = getIframeVal(iframe,"mSkinId");
			var adminId = getIframeVal(iframe,"mAdminId");
			var dialog = getIframeVal(iframe,"mDialog");
			var style = getIframeVal(iframe,"mStyle");
			var kkpager = getIframeVal(iframe,"mKkpager");
			var flag = true ;
		    if (flag){ 
		        $.post("<c:url value='/adminSkins/updateAdminSkins'/>",
		        	{
		    		skinId : skinId,
		    		adminId : adminId,
		    		dialog : dialog,
		    		style : style,
		    		kkpager : kkpager,
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
   			top.art.dialog.open('<c:url value="/adminSkins/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'adminSkins',
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
			var skinId = getIframeVal(iframe,"aSkinId");
			var adminId = getIframeVal(iframe,"aAdminId");
			var dialog = getIframeVal(iframe,"aDialog");
			var style = getIframeVal(iframe,"aStyle");
			var kkpager = getIframeVal(iframe,"aKkpager");
			var flag = true ;
		    if (flag){ 
		        $.post("<c:url value='/adminSkins/addAdminSkins'/>",
		        	{
		    		skinId : skinId,
		    		adminId : adminId,
		    		dialog : dialog,
		    		style : style,
		    		kkpager : kkpager,
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
	   			    	$.post("<c:url value='/adminSkins/removeAllAdminSkins'/>",
			        	{
							skinIds :ids,
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
   		function del(skinId){
   		   if (skinId != ""){ 
	   			top.art.dialog({
	   				title:'警告',
	   			    lock: true,
	   			    background: '#600', // 背景色
	   			    opacity: 0.87,	// 透明度
	   			    content: '你确定要删除吗?',
	   			    icon: 'error',
	   			    ok: function () {
	   			    	$.post("<c:url value='/adminSkins/removeAdminSkins'/>",
			        	{
							skinId	:skinId,
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
