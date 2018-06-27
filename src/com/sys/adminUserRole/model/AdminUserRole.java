package com.sys.adminUserRole.model;

import java.util.Date;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月04日 22:35:44
 */
public class AdminUserRole extends BaseModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private Integer id;
		private Integer adminId;
		private Integer roleId;
		
		public Integer getId() {
			return id;
		}
	
		public void setId(Integer id) {
			this.id = id;
		}
		public Integer getAdminId() {
			return adminId;
		}
	
		public void setAdminId(Integer adminId) {
			this.adminId = adminId;
		}
		public Integer getRoleId() {
			return roleId;
		}
	
		public void setRoleId(Integer roleId) {
			this.roleId = roleId;
		}
}