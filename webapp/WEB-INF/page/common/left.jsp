<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!--sidebar-menu-->
<style>
	.slimScrollDiv{
		position: absolute!important;
		overflow:visible!important;
	}
	.sidebar{
	    width: 220px!important;
		overflow:visible!important;
	}
</style>



<div id="sidebar" style="overflow: visible!important;width:220px;" class="sidebar">

    <ul>
        <li class="submenu active">
            <a class="menu_a" link="${ctx }/manageAdminUser/welcome"><i class="icon icon-home"></i><span>首页</span></a> 
        </li>
        <c:forEach items="${system_columnList }" var="column">
        <li class="submenu"> 
            <a href="#">
                <i class="icon ${column.columnImg }"></i>
                <span>${column.columnName }</span> 
                <span class="label label-important">${fn:length(column.childs)}</span>
            </a>
            <ul>
            	<c:forEach items="${column.childs }" var="cColumn">
                <li><a class="menu_a" link="${ctx }${cColumn.columnUrl }"><i class="icon icon-caret-right"></i>${cColumn.columnName }</a></li>
            	</c:forEach>
            </ul>
        </li>
        </c:forEach>
    </ul>
</div>
<!--sidebar-menu-->
   