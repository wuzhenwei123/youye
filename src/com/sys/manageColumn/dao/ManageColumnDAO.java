package com.sys.manageColumn.dao;

import java.util.List;

import com.sys.manageColumn.model.ManageColumn;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月04日 18:53:45
 */
@Repository("manageColumnDao")
public class ManageColumnDAO extends BaseDao {
	
	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	public ResponseList<ManageColumn> getManageColumnList(ManageColumn manageColumn) {
		List<ManageColumn> list = sqlMapClient.queryForList("ManageColumn.getManageColumnList", manageColumn);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	public List<ManageColumn> getManageColumnBaseList(ManageColumn manageColumn) {
		return sqlMapClient.queryForList("ManageColumn.getManageColumn", manageColumn);
	}

	public List<ManageColumn> getManageColumnListByRole(ManageColumn manageColumn) {
		return sqlMapClient.queryForList("ManageColumn.getManageColumnListByRole", manageColumn);
	}

	public int getManageColumnListCount(ManageColumn manageColumn) {
		return (Integer) sqlMapClient.queryForObject("ManageColumn.getManageColumnListCount", manageColumn);
	}

	public ManageColumn getManageColumn(ManageColumn manageColumn) {
		return (ManageColumn) sqlMapClient.queryForObject("ManageColumn.getManageColumn", manageColumn);
	}

	public int insertManageColumn(ManageColumn manageColumn) throws Exception {
		return (Integer) sqlMapClient.insert("ManageColumn.insertManageColumn", manageColumn);
	}

	public int updateManageColumn(ManageColumn manageColumn) throws Exception {
		return sqlMapClient.update("ManageColumn.updateManageColumn", manageColumn);
	}

	public int removeManageColumn(ManageColumn manageColumn) throws Exception {
		return sqlMapClient.delete("ManageColumn.removeManageColumn", manageColumn);
	}

}
