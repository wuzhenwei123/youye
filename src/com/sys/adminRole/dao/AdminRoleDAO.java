package com.sys.adminRole.dao;

import java.util.List;

import com.sys.adminRole.model.AdminRole;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月04日 21:27:20
 */
@Repository("adminRoleDao")
public class AdminRoleDAO extends BaseDao {

	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	public ResponseList<AdminRole> getAdminRoleList(AdminRole adminRole) {
		List<AdminRole> list = sqlMapClient.queryForList("AdminRole.getAdminRoleList", adminRole);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	public List<AdminRole> getAdminRoleBaseList(AdminRole adminRole) {
		return sqlMapClient.queryForList("AdminRole.getAdminRole", adminRole);
	}

	public int getAdminRoleListCount(AdminRole adminRole) {
		return (Integer) sqlMapClient.queryForObject("AdminRole.getAdminRoleListCount", adminRole);
	}

	public AdminRole getAdminRole(AdminRole adminRole) {
		return (AdminRole) sqlMapClient.queryForObject("AdminRole.getAdminRole", adminRole);
	}

	public int insertAdminRole(AdminRole adminRole) throws Exception {
		return (Integer) sqlMapClient.insert("AdminRole.insertAdminRole", adminRole);
	}

	public int updateAdminRole(AdminRole adminRole) throws Exception {
		return sqlMapClient.update("AdminRole.updateAdminRole", adminRole);
	}

	public int removeAdminRole(AdminRole adminRole) throws Exception {
		return sqlMapClient.delete("AdminRole.removeAdminRole", adminRole);
	}

}
