package com.sys.adminSkins.model;

import java.util.Date;

import com.base.model.BaseModel;
/**
 * @author	keeny
 * @time	2015年02月10日 10:38:45
 */
public class AdminSkins extends BaseModel implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
		private Integer skinId;
		private Integer adminId;
		private String dialog;
		private String style;
		private String kkpager;
		private String skStyle;
		private Integer navgSet;
		private Integer navgType;
		
		public Integer getNavgType() {
			return navgType;
		}

		public void setNavgType(Integer navgType) {
			this.navgType = navgType;
		}

		public Integer getNavgSet() {
			return navgSet;
		}

		public void setNavgSet(Integer navgSet) {
			this.navgSet = navgSet;
		}

		public String getSkStyle() {
			return skStyle;
		}

		public void setSkStyle(String skStyle) {
			this.skStyle = skStyle;
		}

		public Integer getSkinId() {
			return skinId;
		}
	
		public void setSkinId(Integer skinId) {
			this.skinId = skinId;
		}
		public Integer getAdminId() {
			return adminId;
		}
	
		public void setAdminId(Integer adminId) {
			this.adminId = adminId;
		}
		public String getDialog() {
			return dialog;
		}
	
		public void setDialog(String dialog) {
			this.dialog = dialog;
		}
		public String getStyle() {
			return style;
		}
	
		public void setStyle(String style) {
			this.style = style;
		}
		public String getKkpager() {
			return kkpager;
		}
	
		public void setKkpager(String kkpager) {
			this.kkpager = kkpager;
		}
}