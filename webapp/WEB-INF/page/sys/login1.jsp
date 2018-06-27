<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>后台管理系统</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<%@ include file="/WEB-INF/page/common/css.jsp" %>
	<link rel="stylesheet" href="<c:url value='/matrix/css/matrix-login.css'/>" />
	 <style type="text/css">
        input{
            font-family: "Microsoft Yahei";
        }
        .control-label{
            color: #B2DFEE;
            padding-left: 4px;
        }
        .warm-tip{
	        margin-top: -19px;
		    position: absolute;
		    right: 10px;
		    color: #d42121;
        }
    </style>
</head>

<body>
	<input type="hidden" id="ctx" value="${ctx }" />
    <div id="loginbox">  
        <div class="control-group normal_text"> 
            <h2 style="color:#B2DFEE;font-size:28px;">校长信息系统平台</h2>
            <span style="font-size:14px;color:gray;">版权所有 &copy; 爱学棠科技有限公司 2015-2018</span>
        </div>   
        <form id="loginform" class="form-vertical">
            <div class="control-group">
                <label class="control-label">登陆账号</label>
                <span class="warm-tip" id="username_tip"></span>
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_lg">
                        	<i class="icon-user" style="font-size:16px;"></i>
                        </span>
                        <input type="text" id="username" name="username"/>
                    </div>
                </div>
            </div>
            <div class="control-group2">
                <label class="control-label">登陆密码</label>
                <span class="warm-tip" id="password_tip"></span>
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_ly">
                        	<i class="icon-lock" style="font-size:16px;"></i>
                        </span>
                        <input type="password" name="password" />
                    </div>
                </div>
            </div>
            <div class="control-group2">
                <label class="control-label">验证码</label>
                <span class="warm-tip" id="verfycode_tip"></span>
                <div class="controls">
                    <div class="main_input_box" style="text-align: left;">
                        <span class="add-on bg_ly" style="text-align: center;">
                        	<i class="icon-barcode" style="font-size:16px;"></i>
                        </span>
                        <input type="text" class="span3" name="verfycode" style="width:60%;" />
                        <img onclick="getImg()" id="verfyImg" alt="" src="${ctx }/manageAdminUser/pcrimg" style="height: 38px; width: 112px;margin-bottom:3px;line-height: 28px;">
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <span><input type="button" id="checkBtn" onclick="checkLogin()" class="btn btn-success" style="width:446px;" value=" 登&nbsp;&nbsp;&nbsp;&nbsp;录"/></span>
            </div>
            <div class="alert alert-error" id="errortip" style="display: none;">
              <strong>系统信息!</strong> <span id="errortext"></span>
         	</div>     
            <div class="control-group normal_text">
                <div style="font-size:14px;color:gray;">推荐使用webkit内核浏览器，如chrome等</div>
            </div>
        </form>
    </div>
    
    <script src="${ctx }/matrix/js/jquery.min.js"></script>  
    <script src="${ctx }/matrix/js/bootstrap.min.js"></script>  
    <script src="${ctx }/matrix/js/matrix.login.js"></script> 
	<script>
		$(document).ready(function() {
			$("#username").focus();
		});
	</script>
</body>
</html>