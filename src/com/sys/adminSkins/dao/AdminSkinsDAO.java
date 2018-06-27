package com.sys.adminSkins.dao;

import java.util.List;

import com.sys.adminSkins.model.AdminSkins;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月10日 10:38:45
 */
@Repository("adminSkinsDao")
public class AdminSkinsDAO extends BaseDao {

	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	public ResponseList<AdminSkins> getAdminSkinsList(AdminSkins adminSkins) {
		List<AdminSkins> list = sqlMapClient.queryForList("AdminSkins.getAdminSkinsList", adminSkins);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	public List<AdminSkins> getAdminSkinsBaseList(AdminSkins adminSkins) {
		return sqlMapClient.queryForList("AdminSkins.getAdminSkins", adminSkins);
	}

	public int getAdminSkinsListCount(AdminSkins adminSkins) {
		return (Integer) sqlMapClient.queryForObject("AdminSkins.getAdminSkinsListCount", adminSkins);
	}

	public AdminSkins getAdminSkins(AdminSkins adminSkins) {
		return (AdminSkins) sqlMapClient.queryForObject("AdminSkins.getAdminSkins", adminSkins);
	}

	public int insertAdminSkins(AdminSkins adminSkins) throws Exception {
		return (Integer) sqlMapClient.insert("AdminSkins.insertAdminSkins", adminSkins);
	}

	public int updateAdminSkins(AdminSkins adminSkins) throws Exception {
		return sqlMapClient.delete("AdminSkins.updateAdminSkins", adminSkins);
	}

	public int removeAdminSkins(AdminSkins adminSkins) throws Exception {
		return sqlMapClient.delete("AdminSkins.removeAdminSkins", adminSkins);
	}

}
