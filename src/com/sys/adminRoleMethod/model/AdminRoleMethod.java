package com.sys.adminRoleMethod.model;

import java.util.Date;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月06日 10:51:33
 */
public class AdminRoleMethod extends BaseModel implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
		private Integer id;
		private Integer roleId;
		private Integer mid;
		
		private String actionPath;
		
		public String getActionPath() {
			return actionPath;
		}

		public void setActionPath(String actionPath) {
			this.actionPath = actionPath;
		}

		public Integer getId() {
			return id;
		}
	
		public void setId(Integer id) {
			this.id = id;
		}
		public Integer getRoleId() {
			return roleId;
		}
	
		public void setRoleId(Integer roleId) {
			this.roleId = roleId;
		}
		public Integer getMid() {
			return mid;
		}
	
		public void setMid(Integer mid) {
			this.mid = mid;
		}
}