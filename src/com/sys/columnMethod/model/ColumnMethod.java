package com.sys.columnMethod.model;

import java.util.Date;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月04日 20:46:28
 */
public class ColumnMethod extends BaseModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private Integer mid;
		private Integer columnId;
		private String methodName;
		private String actionPath;
		private Date createTime;
		
		public Integer getMid() {
			return mid;
		}
	
		public void setMid(Integer mid) {
			this.mid = mid;
		}
		public Integer getColumnId() {
			return columnId;
		}
	
		public void setColumnId(Integer columnId) {
			this.columnId = columnId;
		}
		public String getMethodName() {
			return methodName;
		}
	
		public void setMethodName(String methodName) {
			this.methodName = methodName;
		}
		public String getActionPath() {
			return actionPath;
		}
	
		public void setActionPath(String actionPath) {
			this.actionPath = actionPath;
		}
		public Date getCreateTime() {
			return createTime;
		}
	
		public void setCreateTime(Date createTime) {
			this.createTime = createTime;
		}
}