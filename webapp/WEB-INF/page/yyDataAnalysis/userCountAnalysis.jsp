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
	<script src="${ctx}/js/echarts.simple.min.js"></script>
	<script type="text/javascript" src="${ctx}/plus/layer/layer.js"></script>
</head>

<body style="background:#fff;">
	<div id="content1">
	  <div id="content-header">
	      <h1>用户数据</h1>
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
		                <label class="control-label name_label">按年份查看:</label>
	                	<div class="controls name_control">
			                <input type="text" class="span8 name_span" id="fYear_str" onfocus="WdatePicker({dateFmt:'yyyy',minDate:'2017'})" readonly="readonly"/>
			            </div>
	                </div>
		            <div class="name_query_btn">
		              <button type="button" class="btn btn-success" onclick="searchData()"><i class="icon-search"></i> 查询</button>
		            </div>
		            <div style="height:10px;clear:both;"></div>
		          </form>
		        </div>
		      </div>
		    </div>
		  </div>
		  <a href="${ctx}/yyDataAnalysisController/toUserAnalysis" style="font-size: 15px;font-weight:bold;">用户数量</a>&nbsp;|&nbsp;<a href="${ctx}/yyDataAnalysisController/toUserCountAnalysis" style="font-size: 15px;font-weight:bold;">用户累计数量</a>|&nbsp;<a href="${ctx}/yyDataAnalysisController/toUserStudyAnalysis" style="font-size: 15px;font-weight:bold;">用户平均每月学习时长</a>
		  <div class="row-fluid">
		    <div class="span12">
		   			<div id="main" style="width: 98%;height: 400px;">
					</div>
		    </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
		var myChart = echarts.init(document.getElementById('main'));
		$(document).ready(function(){
	    	searchData();
	    });

		function searchData(){
			var index = layer.load(0, {shade: false});
			var year_str = $("#fYear_str").val();
			$.getJSON("${ctx}/yyDataAnalysisController/userCountAnalysis",
	    		{
					year_str:year_str,
					_t: Math.random()
		        },function(data){
	            var result = data;
	            if (result.code == 1) {
	            	layer.close(index);
	            	var json = eval("("+result.items+")");
	            	var option = "{title: {text: '"+json.year_str+"年用户累计数量',left: '50%'},color: ['#feb830','#1eb4ec'],";
	            	option = option+ "tooltip: {trigger: 'axis',axisPointer: { type: 'shadow' }},";
	            	option = option+ "legend: {data: ['当月用户数量', '用户累计数量'],align: 'right',right: 30},";
	            	option = option+ "grid: {left: '3%',right: '4%', bottom: '3%',containLabel: true},";
	            	option = option+ "toolbox: {feature: {saveAsImage: {}}},xAxis: [{type: 'category',data: ["+json.mouthY_str+"]}],";
	            	option = option+ "yAxis: [{type: 'value'}],";
	            	option = option+ "series: [{name: '当月用户数量',label: {normal: {show: true,position: 'top'}},type: 'bar',data: ["+json.data_str+"]},";
	            	option = option+ "{name: '用户累计数量',label: {normal: {show: true,position: 'top'}},type: 'bar',data: ["+json.data_str1+"]}]}";
	            	myChart.setOption(eval("("+option+")"));
	            } else {
	            	tipError("系统异常!");
	            } 
		    });
		}
		
	</script>
</body>
</html>
