package com.sys.manageAdminUser.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.adminUserRole.dao.AdminUserRoleDAO;
import com.sys.adminUserRole.model.AdminUserRole;
import com.sys.manageAdminUser.dao.ManageAdminUserDAO;
import com.sys.manageAdminUser.model.ManageAdminUser;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月04日 11:09:21
 */
 @Service("manageAdminUserService")
public class ManageAdminUserService {

	@Resource(name = "manageAdminUserDao")
    private ManageAdminUserDAO manageAdminUserDAO;
	@Resource(name = "adminUserRoleDao")
    private AdminUserRoleDAO adminUserRoleDAO;
    
    public ResponseList<ManageAdminUser> getManageAdminUserList(ManageAdminUser manageAdminUser) {
        return manageAdminUserDAO.getManageAdminUserList(manageAdminUser);
    }
    
    public List<ManageAdminUser> getManageAdminUserBaseList(ManageAdminUser manageAdminUser) {
        return manageAdminUserDAO.getManageAdminUserBaseList(manageAdminUser);
    }
    
    public int getManageAdminUserListCount(ManageAdminUser manageAdminUser) {
        return manageAdminUserDAO.getManageAdminUserListCount(manageAdminUser);
    }

    public ManageAdminUser getManageAdminUser(ManageAdminUser manageAdminUser) { 
        return manageAdminUserDAO.getManageAdminUser(manageAdminUser);
    }

    public int insertManageAdminUser(ManageAdminUser manageAdminUser) throws Exception {
        return manageAdminUserDAO.insertManageAdminUser(manageAdminUser);
    }

    public int updateManageAdminUser(ManageAdminUser manageAdminUser) throws Exception {
        return manageAdminUserDAO.updateManageAdminUser(manageAdminUser);
    }
    
    public int removeManageAdminUser(ManageAdminUser manageAdminUser) throws Exception {
    	
    	AdminUserRole adminUserRole = new AdminUserRole();
		adminUserRole.setAdminId(manageAdminUser.getAdminId());
		adminUserRoleDAO.removeAdminUserRoleByAdminId(adminUserRole);
    	
        return manageAdminUserDAO.removeManageAdminUser(manageAdminUser);
    }
    
}
