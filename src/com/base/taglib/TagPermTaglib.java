package com.base.taglib;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.base.utils.ApplicationContextHolder;
import com.base.utils.CacheCore;
import com.base.utils.SessionName;
import com.sys.adminRoleMethod.model.AdminRoleMethod;
import com.sys.adminRoleMethod.service.AdminRoleMethodService;
import com.sys.manageAdminUser.model.ManageAdminUser;

public class TagPermTaglib extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private String permPath;
	
	/** 操作权限BEN **/
	private static AdminRoleMethodService adminRoleMethodService = (AdminRoleMethodService) ApplicationContextHolder.getBean("adminRoleMethodService");
	
	public String getPermPath() {
		return permPath;
	}

	public void setPermPath(String permPath) {
		this.permPath = permPath;
	}

	public int doEndTag() throws JspException {
		int result = SKIP_BODY;
		try {
			HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
			ManageAdminUser adminUser = (ManageAdminUser) request.getSession().getAttribute(SessionName.ADMIN_USER);
			// 获得标签体对象
			BodyContent bodyContent = this.getBodyContent();
			// 获得标签体文本
			String tagBody = bodyContent.getString();
			@SuppressWarnings("unchecked")
			List<AdminRoleMethod> mlist = (List<AdminRoleMethod>) CacheCore.getInstens().get(SessionName.USER_ROLE_LIST+adminUser.getAdminId());
			if(mlist == null){
				AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
				adminRoleMethod.setRoleId(adminUser.getRoleId());
				mlist = adminRoleMethodService.getAdminRoleMethodBaseList(adminRoleMethod);
				CacheCore.getInstens().put(SessionName.USER_ROLE_LIST+adminUser.getAdminId(), mlist);
			}
			for (AdminRoleMethod adminRoleMethod : mlist) {
				if(adminRoleMethod.getActionPath()!=null && adminRoleMethod.getActionPath().equals(permPath)){
					JspWriter out = this.bodyContent.getEnclosingWriter();
					out.print(tagBody);
					break;
				}
			}
//			HttpServletRequest request = (HttpServletRequest) this.pageContext.getRequest();
//			ManageAdminUser adminUser = (ManageAdminUser) request.getSession().getAttribute(SessionName.ADMIN_USER);
//			// 1. 未登录 返回SKIP_BODY
//			if (adminUser != null) {
//				AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
//				adminRoleMethod.setRoleId(adminUser.getRoleId());
//				adminRoleMethod.setActionPath(permPath);
//				int count = adminRoleMethodService.getAdminRoleMethodListCount(adminRoleMethod);
//				JspWriter out = this.bodyContent.getEnclosingWriter();
//				if(count == 0){
//				}else{
//					out.print(tagBody);
//				}
//			}
		} catch (IOException e) {
			throw new JspException(e);
		}

		return result;
	}

	public int doStartTag() throws JspException {
		// SKIP_BODY, EVAL_BODY_INCLUDE, EVAL_BODY_BUFFERED
		int result = EVAL_BODY_BUFFERED;
		return result;
	}

}