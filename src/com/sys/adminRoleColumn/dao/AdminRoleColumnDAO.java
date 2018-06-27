package com.sys.adminRoleColumn.dao;

import java.util.List;

import com.sys.adminRoleColumn.model.AdminRoleColumn;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月05日 17:27:42
 */
@Repository("adminRoleColumnDao")
public class AdminRoleColumnDAO extends BaseDao {
	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	public ResponseList<AdminRoleColumn> getAdminRoleColumnList(AdminRoleColumn adminRoleColumn) {
		List<AdminRoleColumn> list =  sqlMapClient.queryForList("AdminRoleColumn.getAdminRoleColumnList", adminRoleColumn);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	public List<AdminRoleColumn> getAdminRoleColumnBaseList(AdminRoleColumn adminRoleColumn) {
		return  sqlMapClient.queryForList("AdminRoleColumn.getAdminRoleColumn", adminRoleColumn);
	}

	public int getAdminRoleColumnListCount(AdminRoleColumn adminRoleColumn) {
		return (Integer) sqlMapClient.queryForObject("AdminRoleColumn.getAdminRoleColumnListCount", adminRoleColumn);
	}

	public AdminRoleColumn getAdminRoleColumn(AdminRoleColumn adminRoleColumn) {
		return (AdminRoleColumn) sqlMapClient.queryForObject("AdminRoleColumn.getAdminRoleColumn", adminRoleColumn);
	}

	public int insertAdminRoleColumn(AdminRoleColumn adminRoleColumn) throws Exception {
		return (Integer) sqlMapClient.insert("AdminRoleColumn.insertAdminRoleColumn", adminRoleColumn);
	}

	public int updateAdminRoleColumn(AdminRoleColumn adminRoleColumn) throws Exception {
		return sqlMapClient.update("AdminRoleColumn.updateAdminRoleColumn", adminRoleColumn);
	}

	public int removeAdminRoleColumn(AdminRoleColumn adminRoleColumn) throws Exception {
		return sqlMapClient.delete("AdminRoleColumn.removeAdminRoleColumn", adminRoleColumn);
	}

	public int removeAdminRoleColumnByRoleId(AdminRoleColumn adminRoleColumn) throws Exception {
		return sqlMapClient.delete("AdminRoleColumn.removeAdminRoleColumnByRoleId", adminRoleColumn);
	}
	public int removeAdminRoleColumnByRoleIdColumnId(AdminRoleColumn adminRoleColumn) throws Exception {
		return sqlMapClient.delete("AdminRoleColumn.removeAdminRoleColumnByRoleIdColumnId", adminRoleColumn);
	}

}
