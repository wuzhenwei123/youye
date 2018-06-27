package com.sys.adminRoleMethod.dao;

import java.util.List;

import com.sys.adminRoleMethod.model.AdminRoleMethod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月06日 10:51:32
 */
@Repository("adminRoleMethodDao")
public class AdminRoleMethodDAO extends BaseDao {

	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	@SuppressWarnings("unchecked")
	public ResponseList<AdminRoleMethod> getAdminRoleMethodList(AdminRoleMethod adminRoleMethod) {
		List<AdminRoleMethod> list = sqlMapClient.queryForList("AdminRoleMethod.getAdminRoleMethodList", adminRoleMethod);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	@SuppressWarnings("unchecked")
	public List<AdminRoleMethod> getAdminRoleMethodBaseList(AdminRoleMethod adminRoleMethod) {
		return sqlMapClient.queryForList("AdminRoleMethod.getAdminRoleMethod", adminRoleMethod);
	}

	public int getAdminRoleMethodListCount(AdminRoleMethod adminRoleMethod) {
		return (Integer) sqlMapClient.queryForObject("AdminRoleMethod.getAdminRoleMethodListCount", adminRoleMethod);
	}

	public AdminRoleMethod getAdminRoleMethod(AdminRoleMethod adminRoleMethod) {
		return (AdminRoleMethod) sqlMapClient.queryForObject("AdminRoleMethod.getAdminRoleMethod", adminRoleMethod);
	}

	public int insertAdminRoleMethod(AdminRoleMethod adminRoleMethod) throws Exception {
		return (Integer) sqlMapClient.insert("AdminRoleMethod.insertAdminRoleMethod", adminRoleMethod);
	}

	public int updateAdminRoleMethod(AdminRoleMethod adminRoleMethod) throws Exception {
		return sqlMapClient.update("AdminRoleMethod.updateAdminRoleMethod", adminRoleMethod);
	}

	public int removeAdminRoleMethod(AdminRoleMethod adminRoleMethod) throws Exception {
		return sqlMapClient.delete("AdminRoleMethod.removeAdminRoleMethod", adminRoleMethod);
	}

	public int removeAdminRoleMethodByRoleId(AdminRoleMethod adminRoleMethod) throws Exception {
		return sqlMapClient.delete("AdminRoleMethod.removeAdminRoleMethodByRoleId", adminRoleMethod);
	}
	public int removeAdminRoleMethodByRoleIdMid(AdminRoleMethod adminRoleMethod) throws Exception {
		return sqlMapClient.delete("AdminRoleMethod.removeAdminRoleMethodByRoleIdMid", adminRoleMethod);
	}

}
