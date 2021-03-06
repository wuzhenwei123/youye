<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
 <!doctype html>
 <html lang="zh-CN">
 <head>
   <meta charset="UTF-8">
   <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
   <link rel="stylesheet" href="<c:url value='/css/main.css'/>">
   <script type="text/javascript" src="<c:url value='/js/jquery.min.js'/>"></script>
   <script type="text/javascript" src="<c:url value='/js/colResizable-1.3.min.js'/>"></script>
   <script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
   
   <link rel="stylesheet" href="<c:url value='/plus/date/skin/WdatePicker.css'/>">
   <script type="text/javascript" src="<c:url value='/plus/date/WdatePicker.js'/>"></script>
   
   <title>adminRoleColumn</title>
 </head>
 <body>
 <div id="forms">
   <div class="box">
     <div class="box_border">
       <div class="box_center">
         <form action="" class="jqtransform" id="updateForm">
          <table class="form_table pb15 pr110" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
		        <th>id</th>
			    <td><input type="text" id="mId" class="input-text lh30" size="40" value="${adminrolecolumn.id}" isNotNull="true" warnName="id" /><font color='red'>*</font></td>
            </tr>
            <tr>
		        <th>roleId</th>
			    <td><input type="text" id="mRoleId" class="input-text lh30" size="40" value="${adminrolecolumn.roleId}" isNotNull="true" warnName="roleId" /><font color='red'>*</font></td>
            </tr>
            <tr>
		        <th>columnId</th>
			    <td><input type="text" id="mColumnId" class="input-text lh30" size="40" value="${adminrolecolumn.columnId}" isNotNull="true" warnName="columnId" /><font color='red'>*</font></td>
            </tr>
          </table>
          </form>
       </div>
     </div>
   </div>
</div>
 </body>
 </html>
