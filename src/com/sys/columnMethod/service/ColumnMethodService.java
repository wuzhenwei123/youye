package com.sys.columnMethod.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.columnMethod.dao.ColumnMethodDAO;
import com.sys.columnMethod.model.ColumnMethod;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月04日 20:46:28
 */
 @Service("columnMethodService")
public class ColumnMethodService {

	@Resource(name = "columnMethodDao")
    private ColumnMethodDAO columnMethodDAO;
    
    public ResponseList<ColumnMethod> getColumnMethodList(ColumnMethod columnMethod) {
        return columnMethodDAO.getColumnMethodList(columnMethod);
    }
    
    public List<ColumnMethod> getColumnMethodBaseList(ColumnMethod columnMethod) {
        return columnMethodDAO.getColumnMethodBaseList(columnMethod);
    }
    
    public int getColumnMethodListCount(ColumnMethod columnMethod) {
        return columnMethodDAO.getColumnMethodListCount(columnMethod);
    }

    public ColumnMethod getColumnMethod(ColumnMethod columnMethod) { 
        return columnMethodDAO.getColumnMethod(columnMethod);
    }

    public int insertColumnMethod(ColumnMethod columnMethod) throws Exception {
        return columnMethodDAO.insertColumnMethod(columnMethod);
    }

    public int updateColumnMethod(ColumnMethod columnMethod) throws Exception {
        return columnMethodDAO.updateColumnMethod(columnMethod);
    }
    
    public int removeColumnMethod(ColumnMethod columnMethod) throws Exception {
        return columnMethodDAO.removeColumnMethod(columnMethod);
    }
    
}
