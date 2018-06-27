package com.sys.manageAdminUser.dao;

import java.util.List;

import com.sys.manageAdminUser.model.ManageAdminUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月04日 11:09:21
 */
@Repository("manageAdminUserDao")
public class ManageAdminUserDAO extends BaseDao {

	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	public ResponseList<ManageAdminUser> getManageAdminUserList(ManageAdminUser manageAdminUser) {
		List<ManageAdminUser> list = sqlMapClient.queryForList("ManageAdminUser.getManageAdminUserList", manageAdminUser);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	public List<ManageAdminUser> getManageAdminUserBaseList(ManageAdminUser manageAdminUser) {
		return sqlMapClient.queryForList("ManageAdminUser.getManageAdminUser", manageAdminUser);
	}

	public int getManageAdminUserListCount(ManageAdminUser manageAdminUser) {
		return (Integer) sqlMapClient.queryForObject("ManageAdminUser.getManageAdminUserListCount", manageAdminUser);
	}

	public ManageAdminUser getManageAdminUser(ManageAdminUser manageAdminUser) {
		return (ManageAdminUser) sqlMapClient.queryForObject("ManageAdminUser.getManageAdminUser", manageAdminUser);
	}

	public int insertManageAdminUser(ManageAdminUser manageAdminUser) throws Exception {
		return (Integer) sqlMapClient.insert("ManageAdminUser.insertManageAdminUser", manageAdminUser);
	}

	public int updateManageAdminUser(ManageAdminUser manageAdminUser) throws Exception {
		return sqlMapClient.update("ManageAdminUser.updateManageAdminUser", manageAdminUser);
	}

	public int removeManageAdminUser(ManageAdminUser manageAdminUser) throws Exception {
		return sqlMapClient.delete("ManageAdminUser.removeManageAdminUser", manageAdminUser);
	}

}
