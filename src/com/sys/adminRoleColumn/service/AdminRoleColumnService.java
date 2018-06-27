package com.sys.adminRoleColumn.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.adminRoleColumn.dao.AdminRoleColumnDAO;
import com.sys.adminRoleColumn.model.AdminRoleColumn;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月05日 17:27:42
 */
 @Service("adminRoleColumnService")
public class AdminRoleColumnService {

	@Resource(name = "adminRoleColumnDao")
    private AdminRoleColumnDAO adminRoleColumnDAO;
    
    public ResponseList<AdminRoleColumn> getAdminRoleColumnList(AdminRoleColumn adminRoleColumn) {
        return adminRoleColumnDAO.getAdminRoleColumnList(adminRoleColumn);
    }
    
    public List<AdminRoleColumn> getAdminRoleColumnBaseList(AdminRoleColumn adminRoleColumn) {
        return adminRoleColumnDAO.getAdminRoleColumnBaseList(adminRoleColumn);
    }
    
    public int getAdminRoleColumnListCount(AdminRoleColumn adminRoleColumn) {
        return adminRoleColumnDAO.getAdminRoleColumnListCount(adminRoleColumn);
    }

    public AdminRoleColumn getAdminRoleColumn(AdminRoleColumn adminRoleColumn) { 
        return adminRoleColumnDAO.getAdminRoleColumn(adminRoleColumn);
    }

    public int insertAdminRoleColumn(AdminRoleColumn adminRoleColumn) throws Exception {
        return adminRoleColumnDAO.insertAdminRoleColumn(adminRoleColumn);
    }

    public int updateAdminRoleColumn(AdminRoleColumn adminRoleColumn) throws Exception {
        return adminRoleColumnDAO.updateAdminRoleColumn(adminRoleColumn);
    }
    
    public int removeAdminRoleColumn(AdminRoleColumn adminRoleColumn) throws Exception {
        return adminRoleColumnDAO.removeAdminRoleColumn(adminRoleColumn);
    }
    public int removeAdminRoleColumnByRoleId(AdminRoleColumn adminRoleColumn) throws Exception {
    	return adminRoleColumnDAO.removeAdminRoleColumnByRoleId(adminRoleColumn);
    }
    public int removeAdminRoleColumnByRoleIdColumnId(AdminRoleColumn adminRoleColumn) throws Exception {
    	return adminRoleColumnDAO.removeAdminRoleColumnByRoleIdColumnId(adminRoleColumn);
    }
}
