package com.sys.adminRole.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.adminRole.dao.AdminRoleDAO;
import com.sys.adminRole.model.AdminRole;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月04日 21:27:20
 */
 @Service("adminRoleService")
public class AdminRoleService {

	@Resource(name = "adminRoleDao")
    private AdminRoleDAO adminRoleDAO;
    
    public ResponseList<AdminRole> getAdminRoleList(AdminRole adminRole) {
        return adminRoleDAO.getAdminRoleList(adminRole);
    }
    
    public List<AdminRole> getAdminRoleBaseList(AdminRole adminRole) {
        return adminRoleDAO.getAdminRoleBaseList(adminRole);
    }
    
    public int getAdminRoleListCount(AdminRole adminRole) {
        return adminRoleDAO.getAdminRoleListCount(adminRole);
    }

    public AdminRole getAdminRole(AdminRole adminRole) { 
        return adminRoleDAO.getAdminRole(adminRole);
    }

    public int insertAdminRole(AdminRole adminRole) throws Exception {
        return adminRoleDAO.insertAdminRole(adminRole);
    }

    public int updateAdminRole(AdminRole adminRole) throws Exception {
        return adminRoleDAO.updateAdminRole(adminRole);
    }
    
    public int removeAdminRole(AdminRole adminRole) throws Exception {
        return adminRoleDAO.removeAdminRole(adminRole);
    }
    
}
