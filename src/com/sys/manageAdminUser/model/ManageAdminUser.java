package com.sys.manageAdminUser.model;

import java.util.Date;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月04日 11:09:21
 */
public class ManageAdminUser extends BaseModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private Integer adminId;
		private String adminName;
		private String nickName;
		private String passwd;
		private String realName;
		private String mobile;
		private String phone;
		private String headImg;
		private Date lastLogin;
		private String loginIP;
		private Date pwdModifyTime;
		private Integer state;
		private Date createTime;
		private Integer createrId;
		private Integer roleId;
		private String roleName;
		private String createrName;
		
		public String getRoleName() {
			return roleName;
		}

		public void setRoleName(String roleName) {
			this.roleName = roleName;
		}

		public String getCreaterName() {
			return createrName;
		}

		public void setCreaterName(String createrName) {
			this.createrName = createrName;
		}

		public Integer getRoleId() {
			return roleId;
		}

		public void setRoleId(Integer roleId) {
			this.roleId = roleId;
		}

		public String getHeadImg() {
			return headImg;
		}

		public void setHeadImg(String headImg) {
			this.headImg = headImg;
		}

		public Integer getAdminId() {
			return adminId;
		}
	
		public void setAdminId(Integer adminId) {
			this.adminId = adminId;
		}
		public String getAdminName() {
			return adminName;
		}
	
		public void setAdminName(String adminName) {
			this.adminName = adminName;
		}
		public String getNickName() {
			return nickName;
		}
	
		public void setNickName(String nickName) {
			this.nickName = nickName;
		}
		public String getPasswd() {
			return passwd;
		}
	
		public void setPasswd(String passwd) {
			this.passwd = passwd;
		}
		public String getRealName() {
			return realName;
		}
	
		public void setRealName(String realName) {
			this.realName = realName;
		}
		public String getMobile() {
			return mobile;
		}
	
		public void setMobile(String mobile) {
			this.mobile = mobile;
		}
		public String getPhone() {
			return phone;
		}
	
		public void setPhone(String phone) {
			this.phone = phone;
		}
		public Date getLastLogin() {
			return lastLogin;
		}
	
		public void setLastLogin(Date lastLogin) {
			this.lastLogin = lastLogin;
		}
		public String getLoginIP() {
			return loginIP;
		}
	
		public void setLoginIP(String loginIP) {
			this.loginIP = loginIP;
		}
		public Date getPwdModifyTime() {
			return pwdModifyTime;
		}
	
		public void setPwdModifyTime(Date pwdModifyTime) {
			this.pwdModifyTime = pwdModifyTime;
		}
		public Integer getState() {
			return state;
		}
	
		public void setState(Integer state) {
			this.state = state;
		}
		public Date getCreateTime() {
			return createTime;
		}
	
		public void setCreateTime(Date createTime) {
			this.createTime = createTime;
		}
		public Integer getCreaterId() {
			return createrId;
		}
	
		public void setCreaterId(Integer createrId) {
			this.createrId = createrId;
		}
}