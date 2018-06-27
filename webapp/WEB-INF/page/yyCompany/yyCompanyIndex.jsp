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
	      <h1>公司管理</h1>
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
		                <label class="control-label name_label">公司名称:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fName"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">编码:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCode"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">统一社会信用代码:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCredit_code"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">所属行业:</label>
	                	<div class="controls name_control">
			                <select name="fIndustry_id" id="fIndustry_id" class="span8 name_span">
			                	<option value="">--请选择--</option>
		            			<c:forEach items="${listIndustry}" var="industry">
		            				<option value="${industry.id}">${industry.name}</option>
		            			</c:forEach>
		            		</select>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">员工数量:</label>
	                	<div class="controls name_control">
			                <select name="fEmployees_id" id="fEmployees_id" class="span8 name_span">
		            			<option value="">--请选择--</option>
		            			<c:forEach items="${listEmployees}" var="employees">
		            				<option value="${employees.id}">${employees.name}</option>
		            			</c:forEach>
		            		</select>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">营业额:</label>
	                	<div class="controls name_control">
			                <select name="fTurnover_id" id="fTurnover_id"  class="span8 name_span">
		            			<option value="">--请选择--</option>
		            			<c:forEach items="${listTurnover}" var="turnover">
		            				<option value="${turnover.id}">${turnover.name}</option>
		            			</c:forEach>
		            		</select>
			            </div>
	                </div>
	                
	                <div class="control-group name_title">
		                <label class="control-label name_label">服务开始时间:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fStart_time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">服务结束时间:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fEnd_time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">状态:</label>
	                	<div class="controls name_control name_select">
	                    <select id="fState" class="span12"> 
	                        <option value="">--全部--</option> 
	                        <option value="1">活跃</option> 
		                    <option value="0">停用</option> 
		                    <option value="-1">欠费</option> 
	                	</select> 
                	     </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">联系人姓名:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fContact_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">联系人手机:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fContact_phone"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">负责人姓名:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCharge_name"/>
			            </div>
	                </div>
	                <div class="control-group name_title">
		                <label class="control-label name_label">负责人手机:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fCharge_phone"/>
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
		<perm:tag permPath="/yyCompany/addYyCompany" >
	    <button class="btn btn-success" onclick="toAdd()"><i class="icon-plus"></i>添加</button>
		</perm:tag>
		<perm:tag permPath="/yyCompany/removeAllYyCompany" >
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
		    var credit_code = $("#fCredit_code").val();
		    var industry_id = $("#fIndustry_id").val();
		    var industry_name = $("#fIndustry_name").val();
		    var employees_id = $("#fEmployees_id").val();
		    var employees_name = $("#fEmployees_name").val();
		    var turnover_id = $("#fTurnover_id").val();
		    var turnover_name = $("#fTurnover_name").val();
		    var start_time = $("#fStart_time").val();
		    var end_time = $("#fEnd_time").val();
		    var state = $("#fState").val();
		    var contact_name = $("#fContact_name").val();
		    var contact_phone = $("#fContact_phone").val();
		    var charge_name = $("#fCharge_name").val();
		    var charge_phone = $("#fCharge_phone").val();
		    var remark1 = $("#fRemark1").val();
		    var remark2 = $("#fRemark2").val();
		    var remark3 = $("#fRemark3").val();
		    $.getJSON("<c:url value='/yyCompany/getYyCompanyList'/>",
	        {
	        	sortColumn:sortColumn,
	    		id : id,
	    		name : name,
	    		code : code,
	    		credit_code : credit_code,
	    		industry_id : industry_id,
	    		industry_name : industry_name,
	    		employees_id : employees_id,
	    		employees_name : employees_name,
	    		turnover_id : turnover_id,
	    		turnover_name : turnover_name,
	    		start_time : start_time,
	    		end_time : end_time,
	    		state : state,
	    		contact_name : contact_name,
	    		contact_phone : contact_phone,
	    		charge_name : charge_name,
	    		charge_phone : charge_phone,
	    		remark1 : remark1,
	    		remark2 : remark2,
	    		remark3 : remark3,
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
		    	str+="<th>操作</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_name\" column='name'>公司名称</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_code\" column='code'>编号</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_credit_code\" column='credit_code'>统一社会信用代码</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_industry_id\" column='industry_id'>所属行业</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_employees_name\" column='employees_name'>员工数量</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_turnover_name\" column='turnover_name'>营业额</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_start_time\" width='135' column='start_time'>服务起始日期</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_state\" column='state'>状态</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_contact_name\" column='contact_name'>联系人姓名</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_contact_phone\" column='contact_phone'>联系人电话</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_charge_name\" column='charge_name'>负责人姓名</th>";
		    	str+= "<th class=\"sortTh\" id=\"th_charge_phone\" column='charge_phone'>负责人电话</th>";
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
		        tableStr += "<td>";
	        	tableStr += "<perm:tag permPath='/yyCompany/updateYyCompany' ><button class=\"btn btn-mini btn-info\" onclick='toUpdate(" + result.items[k].id + ");'><i class=\"icon-edit\"></i> 编辑</button></perm:tag>";
	        	tableStr += "<perm:tag permPath='/yyCompany/removeYyCompany' ><button class=\"btn btn-mini btn-danger\" onclick='del(" + result.items[k].id + ");'><i class=\"icon-trash\"></i>删除</button></perm:tag>";
	        	if(result.items[k].state==1){
		        	tableStr += "<perm:tag permPath='/yyCompany/stopYyCompany' ><button class=\"btn btn-mini btn-success\" onclick='stopYyCompany(" + result.items[k].id + ",this," + result.items[k].state + ");'><i class=\"icon-minus-sign\"></i>停用</button></perm:tag>";
	        	}else if(result.items[k].state == 0){
	        		tableStr += "<perm:tag permPath='/yyCompany/stopYyCompany' ><button class=\"btn btn-mini btn-success\" onclick='stopYyCompany(" + result.items[k].id + ",this," + result.items[k].state + ");'><i class=\"icon-ok\"></i>启用</button></perm:tag>";
	        	}
	        	tableStr += "<perm:tag permPath='/yyCompany/qRCode' ><button class=\"btn btn-mini btn-warning\" onclick='toqRCode(" + result.items[k].id + ");'><i class=\"icon-qrcode\"></i>获取二维码</button></perm:tag>";
	        	tableStr += "</td>";
			        tableStr += "<td>" + result.items[k].name + "</td>";
			        tableStr += "<td>" + result.items[k].code + "</td>";
			        tableStr += "<td>" + result.items[k].credit_code + "</td>";
			        tableStr += "<td>" + result.items[k].industry_name + "</td>";
			        tableStr += "<td>" + result.items[k].employees_name + "</td>";
			        tableStr += "<td>" + result.items[k].turnover_name + "</td>";
			        tableStr += "<td>" + genDateTimeAll(result.items[k].start_time) + "~" + genDateTimeAll(result.items[k].end_time) + "</td>";
					if(result.items[k].state == 1){
			        tableStr += "<td class='text-green' id='state"+result.items[k].id+"'>活跃</td>";
					}else if(result.items[k].state == 0){
			        tableStr += "<td class='text-red' id='state"+result.items[k].id+"'>停用</td>";
					}else if(result.items[k].state == -1){
			        tableStr += "<td class='text-red' id='state"+result.items[k].id+"'>欠费</td>";
					}else{
						tableStr += "<td class='text-red'></td>";
					}
			        tableStr += "<td>" + result.items[k].contact_name + "</td>";
			        tableStr += "<td>" + result.items[k].contact_phone + "</td>";
			        tableStr += "<td>" + result.items[k].charge_name + "</td>";
			        tableStr += "<td>" + result.items[k].charge_phone + "</td>";
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
   			top.art.dialog.open('<c:url value="/yyCompany/toAdd"/>',
			{
				id:456,
				fixed:true,
				esc:true,
				title:'添加公司',
				width: '730px',
				height:'400px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "保存",
				ok:function(){
					var iframe = this.iframe.contentWindow;
			        var flag = iframe.validate();
			        var aLearningStyle_id = iframe.document.getElementsByName("aLearningStyle_id");
			        var learningStyle_id = "";
			        for(var i=0;i<aLearningStyle_id.length;i++){
			        	if(aLearningStyle_id[i].checked){
			        		if(learningStyle_id==""){
			        			learningStyle_id = aLearningStyle_id[i].value;
			        		}else{
			        			learningStyle_id = learningStyle_id + "," + aLearningStyle_id[i].value;
			        		}
			        	}
			        }
			        if(learningStyle_id==""){
			        	tipError("请选择学习风格");
			        	flag = false;
			        }else{
			        	flag = true;
			        }
			        if(flag){
						add(iframe,learningStyle_id);
			        }
      				return flag;
				}
			});
   		} 
   		function add(iframe,learningStyle_id){
			var id = getIframeVal(iframe,"aId");
			var name = getIframeVal(iframe,"aName");
			var code = getIframeVal(iframe,"aCode");
			var credit_code = getIframeVal(iframe,"aCredit_code");
			var industry_id = getIframeVal(iframe,"aIndustry_id");
			var industry_name = getIframeVal(iframe,"aIndustry_name");
			var employees_id = getIframeVal(iframe,"aEmployees_id");
			var employees_name = getIframeVal(iframe,"aEmployees_name");
			var turnover_id = getIframeVal(iframe,"aTurnover_id");
			var turnover_name = getIframeVal(iframe,"aTurnover_name");
			var start_time = getIframeVal(iframe,"aStart_time");
			var end_time = getIframeVal(iframe,"aEnd_time");
			var state = getIframeVal(iframe,"aState");
			var contact_name = getIframeVal(iframe,"aContact_name");
			var contact_phone = getIframeVal(iframe,"aContact_phone");
			var charge_name = getIframeVal(iframe,"aCharge_name");
			var charge_phone = getIframeVal(iframe,"aCharge_phone");
			var remark1 = getIframeVal(iframe,"aRemark1");
			var remark2 = getIframeVal(iframe,"aRemark2");
			var remark3 = getIframeVal(iframe,"aRemark3");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyCompany/addYyCompany'/>",
		        	{
		    		id : id,
		    		name : name,
		    		code : code,
		    		credit_code : credit_code,
		    		industry_id : industry_id,
		    		industry_name : industry_name,
		    		employees_id : employees_id,
		    		employees_name : employees_name,
		    		turnover_id : turnover_id,
		    		turnover_name : turnover_name,
		    		start_time : start_time,
		    		end_time : end_time,
		    		state : state,
		    		learningStyle_id : learningStyle_id,
		    		contact_name : contact_name,
		    		contact_phone : contact_phone,
		    		charge_name : charge_name,
		    		charge_phone : charge_phone,
		    		remark1 : remark1,
		    		remark2 : remark2,
		    		remark3 : remark3,
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
			top.art.dialog.open('<c:url value="/yyCompany/toUpdate?id='+id+'"/>',
			{
				id:123,
				fixed:true,
				title:'编辑公司',
				esc:true,
				width: '730px',
				height:'400px',
			    cancelVal: '取消',
		        cancel: true, //为true等价于function(){}
		        okVal : "更新",
				ok:function(){
					var iframe = this.iframe.contentWindow;
			        var flag = iframe.validate();
			        var mLearningStyle_id = iframe.document.getElementsByName("mLearningStyle_id");
			        var learningStyle_id = "";
			        for(var i=0;i<mLearningStyle_id.length;i++){
			        	if(mLearningStyle_id[i].checked){
			        		if(learningStyle_id==""){
			        			learningStyle_id = mLearningStyle_id[i].value;
			        		}else{
			        			learningStyle_id = learningStyle_id + "," + mLearningStyle_id[i].value;
			        		}
			        	}
			        }
			        if(learningStyle_id==""){
			        	tipError("请选择学习风格");
			        	flag = false;
			        }else{
			        	flag = true;
			        }
			        if(flag){
						update(iframe,learningStyle_id);
			        }
      				return flag;
				}
			});
		}
		// 执行更新
   		function update(iframe,learningStyle_id){
			var id = getIframeVal(iframe,"mId");
			var name = getIframeVal(iframe,"mName");
			var code = getIframeVal(iframe,"mCode");
			var credit_code = getIframeVal(iframe,"mCredit_code");
			var industry_id = getIframeVal(iframe,"mIndustry_id");
			var industry_name = getIframeVal(iframe,"mIndustry_name");
			var employees_id = getIframeVal(iframe,"mEmployees_id");
			var employees_name = getIframeVal(iframe,"mEmployees_name");
			var turnover_id = getIframeVal(iframe,"mTurnover_id");
			var turnover_name = getIframeVal(iframe,"mTurnover_name");
			var start_time = getIframeVal(iframe,"mStart_time");
			var end_time = getIframeVal(iframe,"mEnd_time");
			var state = getIframeVal(iframe,"mState");
			var contact_name = getIframeVal(iframe,"mContact_name");
			var contact_phone = getIframeVal(iframe,"mContact_phone");
			var charge_name = getIframeVal(iframe,"mCharge_name");
			var charge_phone = getIframeVal(iframe,"mCharge_phone");
			var remark1 = getIframeVal(iframe,"mRemark1");
			var remark2 = getIframeVal(iframe,"mRemark2");
			var remark3 = getIframeVal(iframe,"mRemark3");
			var flag = true;
		    if (flag){ 
		        $.post("<c:url value='/yyCompany/updateYyCompany'/>",
		        	{
		    		id : id,
		    		name : name,
		    		code : code,
		    		credit_code : credit_code,
		    		learningStyle_id : learningStyle_id,
		    		industry_id : industry_id,
		    		industry_name : industry_name,
		    		employees_id : employees_id,
		    		employees_name : employees_name,
		    		turnover_id : turnover_id,
		    		turnover_name : turnover_name,
		    		start_time : start_time,
		    		end_time : end_time,
		    		state : state,
		    		contact_name : contact_name,
		    		contact_phone : contact_phone,
		    		charge_name : charge_name,
		    		charge_phone : charge_phone,
		    		remark1 : remark1,
		    		remark2 : remark2,
		    		remark3 : remark3,
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
  	   				$.post("<c:url value='/yyCompany/removeAllYyCompany'/>",
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
	   			 	$.post("<c:url value='/yyCompany/removeYyCompany'/>",
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
		
		function toqRCode(id){
			top.art.dialog.open('<c:url value="/yyCompany/toqRCode?id='+id+'"/>',
					{
						id:123,
						fixed:true,
						title:'获取二维码',
						esc:true,
						width: '730px',
						height:'500px',
					    cancelVal: '取消',
				        cancel: true, //为true等价于function(){}
				        button: [  
		                	{  
		                    	name: '下载8CM',  
		                     	callback: function () {
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyCompany/downQRCode?id="+id+"&type=1&imgUrl="+imgUrl;
	                    	    	return false;
		                     	}  
		                 	},{  
		                    	name: '下载12CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyCompany/downQRCode?id="+id+"&type=2&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	},{  
		                    	name: '下载15CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyCompany/downQRCode?id="+id+"&type=3&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	},{  
		                    	name: '下载30CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyCompany/downQRCode?id="+id+"&type=4&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	},{  
		                    	name: '下载50CM',  
		                     	callback: function () {  
		                     		var iframe = this.iframe.contentWindow;
			                    	var imgUrl = iframe.document.getElementById("imgUrl").value;
	                    	    	window.location.href = "${ctx}/yyCompany/downQRCode?id="+id+"&type=5&imgUrl="+imgUrl;
		                     		return false;
		                     	}  
		                 	}
				        ],
					});
		}
		
		function stopYyCompany(id,obj,state){
			var msg = "";
			if(state=="1"){
				msg = "停用";
				state = 0;
			}else if(state=="0"){
				msg = "启用";
				state = 1;
			}
			if (id != ""){ 
	   			parent.layer.msg('你确定要'+msg+'该公司服务吗？', {
	   			  time: 0 //不自动关闭
	   			  ,btn: ['确定', '取消']
	   			  ,yes: function(index){
	   			 	$.post("<c:url value='/yyCompany/stopYyCompany'/>",
   		        	{
   						id	:id,
   						state	:state,
   						ranNum:Math.random()
   					},
   		        	function(data){
   			        	var result = eval('('+data+')'); 
   			            if (result.code == '1') {
   			              	tipOk(msg+"成功!");
   			            	 goCurrentPage();
   			              	if(state=="0"){
   			              		$(obj).html('<i class=\"icon-ok\"></i>启用');
   			              		$("#state"+id).html("停用");
   			              		$("#state"+id).attr("class","text-red");
   			              	}else if(state=="1"){
   			              		$(obj).html('<i class=\"icon-minus-sign\"></i>停用');
   			              		$("#state"+id).html("活跃");
   			              		$("#state"+id).attr("class","text-green");
   			              	}
   			             } else {
   			              	tipError(msg+"失败!");
   			             }
   			        });
	   			  }
	   			});
	   	  	}
		}
	</script>
</body>
</html>
