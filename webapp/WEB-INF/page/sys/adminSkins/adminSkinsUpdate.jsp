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
   
   <title>adminSkins</title>
 </head>
 <body>
 <div id="forms">
   <div class="box">
     <div class="box_border">
       <div class="box_center">
         <form action="" class="jqtransform" id="updateForm">
          <table class="form_table pb15 pr110" width="100%" border="0" cellpadding="0" cellspacing="0">
          	<input type="hidden" id="mSkinId" class="input-text lh30" size="40" value="${adminSkins.skinId}" />
          	<input type="hidden" id="mAdminId" class="input-text lh30"  size="40" value="${adminSkins.adminId}" isNotNull="true" warnName="adminId" />
            <tr>
		        <th>当前风格</th>
			    <td>
			    弹框
			    <div id="mDialogDiv">
				    <c:if test="${adminSkins.dialog == '' || empty adminSkins.dialog }">
				    	<img class="img" title="默认皮肤" src="${ctx }/plus/dialog/images/default.png">
				    </c:if>
				    <c:if test="${adminSkins.dialog != '' }">
						<c:choose>
							<c:when test="${adminSkins.dialog == 'default' }">
						    	<img class="img" title="默认皮肤" src="${ctx }/plus/dialog/images/default.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'aero' }">
						    	<img class="img" title="默认皮肤" src="${ctx }/plus/dialog/images/aero.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'chrome' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/chrome.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'opera' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/opera.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'simple' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/simple.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'idialog' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/idialog.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'twitter' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/twitter.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'blue' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/blue.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'black' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/black.png">
							</c:when>
							<c:when test="${adminSkins.dialog == 'green' }">
						    	<img class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/green.png">
							</c:when>
						</c:choose>
				    </c:if>
			    </div>
			    分页
				<div id="mKkpagerDiv">			    
			    <c:if test="${adminSkins.kkpager == '' || empty adminSkins.kkpager }">
			    	<img class="img" title="蓝色风格" src="${ctx }/plus/kkpager/images/blue.png">
			    </c:if>
			    <c:if test="${adminSkins.kkpager != '' }">
					<c:choose>
						<c:when test="${adminSkins.kkpager == 'blue' }">
					    	<img class="img" title="蓝色风格" src="${ctx }/plus/kkpager/images/blue.png">
						</c:when>
						<c:when test="${adminSkins.kkpager == 'orange' }">
					    	<img class="img" title="橘色风格" src="${ctx }/plus/kkpager/images/orange.png">
						</c:when>
					</c:choose>
			    </c:if>
		        </div> 
			    功能组排序
				<div id="mSkStyleDiv">			    
			    <c:if test="${adminSkins.skStyle == '' || empty adminSkins.skStyle }">
			    	<img class="img" title="居左" width="400" src="${ctx }/plus/skStyle/images/left.png">
			    </c:if>
			    <c:if test="${adminSkins.skStyle != '' }">
					<c:choose>
						<c:when test="${adminSkins.skStyle == 'left' }">
					    	<img class="img" width="400" title="居左" src="${ctx }/plus/skStyle/images/left.png">
						</c:when>
						<c:when test="${adminSkins.skStyle == 'right' }">
					    	<img class="img" width="400" title="居右" src="${ctx }/plus/skStyle/images/right.png">
						</c:when>
					</c:choose>
			    </c:if>
		        </div> 
			    </td>
            </tr>
            <tr>
		        <th>弹框风格</th>
			    <td>
			    	<input type="hidden" id="mDialog" class="input-text lh30" size="40" value="${adminSkins.dialog}" /><font color='red'>*</font>
			    	<img onclick="setVal('mDialog','default');" class="img" title="默认皮肤" src="${ctx }/plus/dialog/images/default.png">
			    	<img onclick="setVal('mDialog','aero');" class="img" title="windows7毛玻璃风格" src="${ctx }/plus/dialog/images/aero.png">
			    	<img onclick="setVal('mDialog','chrome');" class="img" title="chrome浏览器(xp)风格" src="${ctx }/plus/dialog/images/chrome.png">
			    	<img onclick="setVal('mDialog','opera');" class="img" title="opera 11浏览器内置对话框风格" src="${ctx }/plus/dialog/images/opera.png">
			    	<img onclick="setVal('mDialog','simple');" class="img" title="简单风格" src="${ctx }/plus/dialog/images/simple.png">
			    	<img onclick="setVal('mDialog','idialog');" class="img" title="苹果风格" src="${ctx }/plus/dialog/images/idialog.png">
			    	<img onclick="setVal('mDialog','twitter');" class="img" title="twitter风格" src="${ctx }/plus/dialog/images/twitter.png">
			    	<img onclick="setVal('mDialog','blue');" class="img" title="蓝色风格" src="${ctx }/plus/dialog/images/blue.png">
			    	<img onclick="setVal('mDialog','black');" class="img" title="黑色风格" src="${ctx }/plus/dialog/images/black.png">
			    	<img onclick="setVal('mDialog','green');" class="img" title="绿色风格" src="${ctx }/plus/dialog/images/green.png">
			    </td>
            </tr>
<!--             <tr> -->
<!-- 		        <th>主题风格</th> -->
<%-- 			    <td><input type="hidden" id="mStyle" class="input-text lh30" size="40" value="${adminSkins.style}" isNotNull="true" warnName="style" /><font color='red'>*</font></td> --%>
<!--             </tr> -->
            <tr>
		        <th>分页风格</th>
			    <td>
			    	<input type="hidden" id="mKkpager" class="input-text lh30" size="40" value="${adminSkins.kkpager}" /><font color='red'>*</font>
			    	<img class="img" onclick="setVal('mKkpager','blue');" title="蓝色风格" src="${ctx }/plus/kkpager/images/blue.png">
			    	<img class="img" onclick="setVal('mKkpager','orange');" title="橘色风格" src="${ctx }/plus/kkpager/images/orange.png">
			    </td>
            </tr>
            <tr>
		        <th>功能组排序</th>
			    <td>
			    	<input type="hidden" id="mSkStyle" class="input-text lh30" size="40" value="${adminSkins.skStyle}" /><font color='red'>*</font>
			    	靠左<input type="radio" onclick="setVal('mSkStyle','left');" name="skStyle" />
			    	靠右<input type="radio" onclick="setVal('mSkStyle','right');" name="skStyle" />
			    </td>
            </tr>
          </table>
          </form>
       </div>
     </div>
   </div>
</div>
<script type="text/javascript">
	function setVal(id ,val){
		$("#"+id).val(val);
		
		var fodle = '';
		if(id == 'mDialog'){
			fodle = 'dialog';
		}else if(id == 'mKkpager'){
			fodle = 'kkpager';
		}else{
			fodle = 'skStyle';
		}
		
		var img = "<img class=\"img\" width=\"400\" src=\"${ctx }/plus/"+fodle+"/images/"+val+".png\">";
		$("#"+id+"Div").html(img);
	}
</script>
 </body>
 </html>
