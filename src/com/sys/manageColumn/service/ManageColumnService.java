package com.sys.manageColumn.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.manageColumn.dao.ManageColumnDAO;
import com.sys.manageColumn.model.ManageColumn;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月04日 18:53:45
 */
 @Service("manageColumnService")
public class ManageColumnService {

	@Resource(name = "manageColumnDao")
    private ManageColumnDAO manageColumnDAO;
    
    public ResponseList<ManageColumn> getManageColumnList(ManageColumn manageColumn) {
        return manageColumnDAO.getManageColumnList(manageColumn);
    }
    
    public List<ManageColumn> getManageColumnBaseList(ManageColumn manageColumn) {
        return manageColumnDAO.getManageColumnBaseList(manageColumn);
    }
    public List<ManageColumn> getManageColumnListByRole(ManageColumn manageColumn) {
    	return manageColumnDAO.getManageColumnListByRole(manageColumn);
    }
    
    public int getManageColumnListCount(ManageColumn manageColumn) {
        return manageColumnDAO.getManageColumnListCount(manageColumn);
    }

    public ManageColumn getManageColumn(ManageColumn manageColumn) { 
        return manageColumnDAO.getManageColumn(manageColumn);
    }

    public int insertManageColumn(ManageColumn manageColumn) throws Exception {
        return manageColumnDAO.insertManageColumn(manageColumn);
    }

    public int updateManageColumn(ManageColumn manageColumn) throws Exception {
        return manageColumnDAO.updateManageColumn(manageColumn);
    }
    
    public int removeManageColumn(ManageColumn manageColumn) throws Exception {
        return manageColumnDAO.removeManageColumn(manageColumn);
    }
    
}
