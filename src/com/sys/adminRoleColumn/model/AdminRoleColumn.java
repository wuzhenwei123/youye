package com.sys.adminRoleColumn.model;

import java.util.Date;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月05日 17:27:42
 */
public class AdminRoleColumn extends BaseModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private Integer id;
		private Integer roleId;
		private Integer columnId;
		
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
		public Integer getColumnId() {
			return columnId;
		}
	
		public void setColumnId(Integer columnId) {
			this.columnId = columnId;
		}
}