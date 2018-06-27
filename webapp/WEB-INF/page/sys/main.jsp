<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${_title }</title>
    <meta charset="UTF-8" />
    <%@ include file="/WEB-INF/page/common/css.jsp" %>
    <link rel="stylesheet" href="<c:url value='/matrix/css/matrix-style.css?t=<%=Math.random() %>'/>" />
    <link rel="stylesheet" href="<c:url value='/matrix/css/matrix-media.css'/>" />
    <link rel="stylesheet" href="${ctx }/plus/layer/skin/layer.css" />
    <link rel="stylesheet" href="<c:url value='/plus/dialog/skins/twitter.css'/>">
	<script type="text/javascript" src="<c:url value='/plus/dialog/artDialog.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/plus/dialog/plugins/iframeTools.source.js'/>"></script>
    <style type="text/css">
    	.slimScrollDiv{
			height:100%!important;
		}
    </style>
</head>
<body>
   <%@ include file="/WEB-INF/page/common/header.jsp" %>
    <!--start-top-serch-->
<!--     <div id="search"> -->
<!--         <input type="text" placeholder="搜索..."/> -->
<!--         <button type="submit" class="tip-bottom" title="Search"><i class="icon-search icon-white"></i></button> -->
<!--     </div> -->
    <!--close-top-serch-->

   <%@ include file="/WEB-INF/page/common/left.jsp" %>
   
    <!--main-container-part-->
    <div id="content">
        <!--breadcrumbs-->
        <div id="content-header">
          <div id="breadcrumb"> <a href="javascript:gotoLink('${ctx }/manageAdminUser/welcome');"><i class="icon-home"></i> 首页</a><span id="erji" style="padding-left: 10px;">控制面板</span></div>
        </div>
        <!--End-breadcrumbs-->
        <iframe src="${ctx }/manageAdminUser/welcome" id="iframe-main" frameborder='0' style="width:100%;"></iframe>
    </div>
    <!--end-main-container-part-->
	<%@ include file="/WEB-INF/page/common/footer.jsp" %>

    <script src="${ctx }/matrix/js/excanvas.min.js"></script> 
    <script src="${ctx }/matrix/js/jquery.min.js"></script> 
    <script src="${ctx}/js/jquery.slimscroll.min.js"></script> 
    <script src="${ctx }/matrix/js/matrix.niceScroll.js"></script> 
    <script src="${ctx }/matrix/js/jquery.ui.custom.js"></script> 
    <script src="${ctx }/matrix/js/bootstrap.min.js"></script> 
    
    <script src="${ctx }/matrix/js/matrix.js"></script> 
	<script src="${ctx }/plus/layer/layer.js"></script>  

    <script type="text/javascript">
	    //初始化相关元素高度
	    function init(){
	        $("body").height($(window).height()-80);
	        $("#iframe-main").height($(window).height()-120);
	        $("#sidebar").height($(window).height()-50);
	    }
	
	    $(function(){
	        init();
	        $(window).resize(function(){
	            init();
	        });
	    });
    </script>
</body>
</html>

 