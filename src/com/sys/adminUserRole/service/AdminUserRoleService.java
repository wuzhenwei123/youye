package com.sys.adminUserRole.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.adminUserRole.dao.AdminUserRoleDAO;
import com.sys.adminUserRole.model.AdminUserRole;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月04日 22:35:44
 */
 @Service("adminUserRoleService")
public class AdminUserRoleService {

	@Resource(name = "adminUserRoleDao")
    private AdminUserRoleDAO adminUserRoleDAO;
    
    public ResponseList<AdminUserRole> getAdminUserRoleList(AdminUserRole adminUserRole) {
        return adminUserRoleDAO.getAdminUserRoleList(adminUserRole);
    }
    
    public List<AdminUserRole> getAdminUserRoleBaseList(AdminUserRole adminUserRole) {
        return adminUserRoleDAO.getAdminUserRoleBaseList(adminUserRole);
    }
    
    public int getAdminUserRoleListCount(AdminUserRole adminUserRole) {
        return adminUserRoleDAO.getAdminUserRoleListCount(adminUserRole);
    }

    public AdminUserRole getAdminUserRole(AdminUserRole adminUserRole) { 
        return adminUserRoleDAO.getAdminUserRole(adminUserRole);
    }

    public int insertAdminUserRole(AdminUserRole adminUserRole) throws Exception {
        return adminUserRoleDAO.insertAdminUserRole(adminUserRole);
    }

    public int updateAdminUserRole(AdminUserRole adminUserRole) throws Exception {
        return adminUserRoleDAO.updateAdminUserRole(adminUserRole);
    }
    
    public int removeAdminUserRole(AdminUserRole adminUserRole) throws Exception {
        return adminUserRoleDAO.removeAdminUserRole(adminUserRole);
    }
    
}
