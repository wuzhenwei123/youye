package com.sys.adminSkins.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sys.adminSkins.dao.AdminSkinsDAO;
import com.sys.adminSkins.model.AdminSkins;
import com.base.utils.ResponseList;

/**
 * @author	keeny
 * @time	2015年02月10日 10:38:45
 */
 @Service("adminSkinsService")
public class AdminSkinsService {

	@Resource(name = "adminSkinsDao")
    private AdminSkinsDAO adminSkinsDAO;
    
    public ResponseList<AdminSkins> getAdminSkinsList(AdminSkins adminSkins) {
        return adminSkinsDAO.getAdminSkinsList(adminSkins);
    }
    
    public List<AdminSkins> getAdminSkinsBaseList(AdminSkins adminSkins) {
        return adminSkinsDAO.getAdminSkinsBaseList(adminSkins);
    }
    
    public int getAdminSkinsListCount(AdminSkins adminSkins) {
        return adminSkinsDAO.getAdminSkinsListCount(adminSkins);
    }

    public AdminSkins getAdminSkins(AdminSkins adminSkins) { 
        return adminSkinsDAO.getAdminSkins(adminSkins);
    }

    public int insertAdminSkins(AdminSkins adminSkins) throws Exception {
        return adminSkinsDAO.insertAdminSkins(adminSkins);
    }

    public int updateAdminSkins(AdminSkins adminSkins) throws Exception {
        return adminSkinsDAO.updateAdminSkins(adminSkins);
    }
    
    public int removeAdminSkins(AdminSkins adminSkins) throws Exception {
        return adminSkinsDAO.removeAdminSkins(adminSkins);
    }
    
}
