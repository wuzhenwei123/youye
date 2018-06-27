package com.sys.adminRoleMethod.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.adminRoleMethod.dao.AdminRoleMethodDAO;
import com.sys.adminRoleMethod.model.AdminRoleMethod;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月06日 10:51:33
 */
 @Service("adminRoleMethodService")
public class AdminRoleMethodService {

	@Resource(name = "adminRoleMethodDao")
    private AdminRoleMethodDAO adminRoleMethodDAO;
    
    public ResponseList<AdminRoleMethod> getAdminRoleMethodList(AdminRoleMethod adminRoleMethod) {
        return adminRoleMethodDAO.getAdminRoleMethodList(adminRoleMethod);
    }
    
    public List<AdminRoleMethod> getAdminRoleMethodBaseList(AdminRoleMethod adminRoleMethod) {
        return adminRoleMethodDAO.getAdminRoleMethodBaseList(adminRoleMethod);
    }
    
    public int getAdminRoleMethodListCount(AdminRoleMethod adminRoleMethod) {
        return adminRoleMethodDAO.getAdminRoleMethodListCount(adminRoleMethod);
    }

    public AdminRoleMethod getAdminRoleMethod(AdminRoleMethod adminRoleMethod) { 
        return adminRoleMethodDAO.getAdminRoleMethod(adminRoleMethod);
    }

    public int insertAdminRoleMethod(AdminRoleMethod adminRoleMethod) throws Exception {
        return adminRoleMethodDAO.insertAdminRoleMethod(adminRoleMethod);
    }

    public int updateAdminRoleMethod(AdminRoleMethod adminRoleMethod) throws Exception {
        return adminRoleMethodDAO.updateAdminRoleMethod(adminRoleMethod);
    }
    
    public int removeAdminRoleMethod(AdminRoleMethod adminRoleMethod) throws Exception {
        return adminRoleMethodDAO.removeAdminRoleMethod(adminRoleMethod);
    }
    public int removeAdminRoleMethodByRoleId(AdminRoleMethod adminRoleMethod) throws Exception {
    	return adminRoleMethodDAO.removeAdminRoleMethodByRoleId(adminRoleMethod);
    }
    public int removeAdminRoleMethodByRoleIdMid(AdminRoleMethod adminRoleMethod) throws Exception {
    	return adminRoleMethodDAO.removeAdminRoleMethodByRoleIdMid(adminRoleMethod);
    }
    
}
