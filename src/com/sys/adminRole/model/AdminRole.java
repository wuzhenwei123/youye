package com.sys.adminRole.model;

import java.util.Date;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月04日 21:27:20
 */
public class AdminRole extends BaseModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private Integer roleId;
		private String roleName;
		private Date createTime;
		private Integer state;
		private Integer defaule;
		private Integer roleType;
		
		public Integer getRoleId() {
			return roleId;
		}
	
		public void setRoleId(Integer roleId) {
			this.roleId = roleId;
		}
		public String getRoleName() {
			return roleName;
		}
	
		public void setRoleName(String roleName) {
			this.roleName = roleName;
		}
		public Date getCreateTime() {
			return createTime;
		}
	
		public void setCreateTime(Date createTime) {
			this.createTime = createTime;
		}
		public Integer getState() {
			return state;
		}
	
		public void setState(Integer state) {
			this.state = state;
		}
		public Integer getDefaule() {
			return defaule;
		}
	
		public void setDefaule(Integer defaule) {
			this.defaule = defaule;
		}
		public Integer getRoleType() {
			return roleType;
		}
	
		public void setRoleType(Integer roleType) {
			this.roleType = roleType;
		}
}