<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/page/common/config.jsp" %>
    <script src="${ctx }/js/common.js"></script> 
 <!--Header-part-->
<div id="header">
  <h1><a></a></h1>
<%--   <h1><a>${_title }</a></h1> --%>
</div>
<!--close-Header-part--> 

<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
    <ul class="nav">
        <li  class="dropdown" id="profile-messages" >
            <a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle">
                <i class="icon icon-user"></i>&nbsp;
                <span class="text">欢迎你，${admin_user.nickName }</span>&nbsp;
                <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
                <li><a href="javascript:gotoLink('${ctx }/manageAdminUser/toUserCenter');"><i class="icon-user"></i> 个人中心</a></li>
                <li><a href="javascript:modifyPasswd();"><i class="icon-user"></i> 修改密码</a></li>
            </ul>
        </li>
        <li class=""><a title="" href="${ctx }/manageAdminUser/loginout"><i class="icon icon-share-alt"></i> <span class="text">&nbsp;退出系统</span></a></li>
    </ul>
</div>
<!--close-top-Header-menu-->
<script type="text/javascript">
	function modifyPasswd(){
		top.art.dialog.open('<c:url value="/manageAdminUser/toUpdatePasswd"/>',
		{
			id:123,
			fixed:true,
			esc:true,
			title:"修改密码",
			width: '730px',
			height:'270px',
		    cancelVal: '取消',
	        cancel: true, //为true等价于function(){}
	        okVal : "修改",
			ok:function(){
				var iframe = this.iframe.contentWindow;
		        var flag = iframe.validate();
		        if(flag){
		        	updatePasswd(iframe);
		        }
    			return flag;
			}
		});
	}
	function updatePasswd(iframe){
		var oldPasswd = getIframeVal(iframe,"oPasswd");
		var newPasswd = getIframeVal(iframe,"nPasswd");
		var rPasswd = getIframeVal(iframe,"rPasswd");
        $.post("<c:url value='/manageAdminUser/updatePasswd'/>",
       	{
   		passwd : oldPasswd,
   		newPasswd : newPasswd,
   		rPasswd : rPasswd,
		 _t:Math.random()},
       	function(data){
        	var result = eval('('+data+')'); 
            if (result.code == '1') {
            	 parent.layer.msg('更新成功!', {time: 2000});
             } else {
            	parent.layer.msg(result.message, {icon: 5});
             }
        });
	}
</script>