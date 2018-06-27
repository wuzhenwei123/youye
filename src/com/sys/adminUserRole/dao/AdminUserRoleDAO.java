package com.sys.adminUserRole.dao;

import java.util.List;

import com.sys.adminUserRole.model.AdminUserRole;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月04日 22:35:44
 */
@Repository("adminUserRoleDao")
public class AdminUserRoleDAO extends BaseDao {

	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	public ResponseList<AdminUserRole> getAdminUserRoleList(AdminUserRole adminUserRole) {
		List<AdminUserRole> list = sqlMapClient.queryForList("AdminUserRole.getAdminUserRoleList", adminUserRole);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	public List<AdminUserRole> getAdminUserRoleBaseList(AdminUserRole adminUserRole) {
		return sqlMapClient.queryForList("AdminUserRole.getAdminUserRole", adminUserRole);
	}

	public int getAdminUserRoleListCount(AdminUserRole adminUserRole) {
		return (Integer) sqlMapClient.queryForObject("AdminUserRole.getAdminUserRoleListCount", adminUserRole);
	}

	public AdminUserRole getAdminUserRole(AdminUserRole adminUserRole) {
		return (AdminUserRole) sqlMapClient.queryForObject("AdminUserRole.getAdminUserRole", adminUserRole);
	}

	public int insertAdminUserRole(AdminUserRole adminUserRole) throws Exception {
		return (Integer) sqlMapClient.insert("AdminUserRole.insertAdminUserRole", adminUserRole);
	}

	public int updateAdminUserRole(AdminUserRole adminUserRole) throws Exception {
		return sqlMapClient.update("AdminUserRole.updateAdminUserRole", adminUserRole);
	}

	public int removeAdminUserRole(AdminUserRole adminUserRole) throws Exception {
		return sqlMapClient.delete("AdminUserRole.removeAdminUserRole", adminUserRole);
	}
	public int removeAdminUserRoleByAdminId(AdminUserRole adminUserRole) throws Exception {
		return sqlMapClient.delete("AdminUserRole.removeAdminUserRoleByAdminId", adminUserRole);
	}

}
