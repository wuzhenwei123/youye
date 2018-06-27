package com.sys.manageColumn.model;

import java.util.Date;
import java.util.List;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月04日 18:53:45
 */
public class ManageColumn extends BaseModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private Integer columnId;
		private String columnName;
		private String columnUrl;
		private Integer parentColumnID;
		private Integer state;
		private Integer columnOrder;
		private String columnImg;
		private String parentColumnName;
		
		private Integer roleId;
		public Integer getRoleId() {
			return roleId;
		}

		public void setRoleId(Integer roleId) {
			this.roleId = roleId;
		}

		private List<ManageColumn> childs;
		
		public List<ManageColumn> getChilds() {
			return childs;
		}

		public void setChilds(List<ManageColumn> childs) {
			this.childs = childs;
		}

		public String getParentColumnName() {
			return parentColumnName;
		}

		public void setParentColumnName(String parentColumnName) {
			this.parentColumnName = parentColumnName;
		}

		public Integer getColumnId() {
			return columnId;
		}
	
		public void setColumnId(Integer columnId) {
			this.columnId = columnId;
		}
		public String getColumnName() {
			return columnName;
		}
	
		public void setColumnName(String columnName) {
			this.columnName = columnName;
		}
		public String getColumnUrl() {
			return columnUrl;
		}
	
		public void setColumnUrl(String columnUrl) {
			this.columnUrl = columnUrl;
		}
		public Integer getParentColumnID() {
			return parentColumnID;
		}
	
		public void setParentColumnID(Integer parentColumnID) {
			this.parentColumnID = parentColumnID;
		}
		public Integer getState() {
			return state;
		}
	
		public void setState(Integer state) {
			this.state = state;
		}
		public Integer getColumnOrder() {
			return columnOrder;
		}
	
		public void setColumnOrder(Integer columnOrder) {
			this.columnOrder = columnOrder;
		}
		public String getColumnImg() {
			return columnImg;
		}
	
		public void setColumnImg(String columnImg) {
			this.columnImg = columnImg;
		}
}