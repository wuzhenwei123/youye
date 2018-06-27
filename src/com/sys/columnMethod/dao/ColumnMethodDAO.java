package com.sys.columnMethod.dao;

import java.util.List;

import com.sys.columnMethod.model.ColumnMethod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.base.dao.BaseDao;
import com.base.dao.IbatisBaseDaoImpl;
import com.base.utils.ResponseList;

/**
 * @author keeny
 * @time 2015年02月04日 20:46:28
 */
@Repository("columnMethodDao")
public class ColumnMethodDAO extends BaseDao {

	@Autowired
	private IbatisBaseDaoImpl sqlMapClient;

	/**
	 * query a list
	 */
	public ResponseList<ColumnMethod> getColumnMethodList(ColumnMethod columnMethod) {
		List<ColumnMethod> list = sqlMapClient.queryForList("ColumnMethod.getColumnMethodList", columnMethod);
		return buildResponseList(list);
	}

	/**
	 * query a base list
	 */
	public List<ColumnMethod> getColumnMethodBaseList(ColumnMethod columnMethod) {
		return sqlMapClient.queryForList("ColumnMethod.getColumnMethod", columnMethod);
	}

	public int getColumnMethodListCount(ColumnMethod columnMethod) {
		return (Integer) sqlMapClient.queryForObject("ColumnMethod.getColumnMethodListCount", columnMethod);
	}

	public ColumnMethod getColumnMethod(ColumnMethod columnMethod) {
		return (ColumnMethod) sqlMapClient.queryForObject("ColumnMethod.getColumnMethod", columnMethod);
	}

	public int insertColumnMethod(ColumnMethod columnMethod) throws Exception {
		return (Integer) sqlMapClient.insert("ColumnMethod.insertColumnMethod", columnMethod);
	}

	public int updateColumnMethod(ColumnMethod columnMethod) throws Exception {
		return sqlMapClient.update("ColumnMethod.updateColumnMethod", columnMethod);
	}

	public int removeColumnMethod(ColumnMethod columnMethod) throws Exception {
		return sqlMapClient.delete("ColumnMethod.removeColumnMethod", columnMethod);
	}

}
