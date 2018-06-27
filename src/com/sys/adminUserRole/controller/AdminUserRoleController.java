package com.sys.adminUserRole.controller;

import java.util.Date;
import org.apache.log4j.Logger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sys.adminUserRole.model.AdminUserRole;
import com.sys.adminUserRole.service.AdminUserRoleService;
import com.sys.manageAdminUser.model.ManageAdminUser;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.controller.BaseController;
/**
 * @author	keeny
 * @time	2015年02月04日 22:35:44
 */
@Controller
@RequestMapping("/adminUserRole")
public class AdminUserRoleController extends BaseController
{
	
	//private static Logger logger = Logger.getLogger(AdminUserRoleController.class); //Logger
	
	@Autowired
	private AdminUserRoleService adminuserroleService = null;
	
	/*****************页面中转*********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/adminUserRole/adminUserRoleIndex";
	}
	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/adminUserRole/adminUserRoleAdd";
	}
	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate(HttpServletRequest request, HttpServletResponse response, Model model)
	{	
		Integer id = RequestHandler.getInteger(request, "id");
		AdminUserRole adminuserrole1 = new AdminUserRole();
		adminuserrole1.setId(id);
		AdminUserRole adminuserrole = adminuserroleService.getAdminUserRole(adminuserrole1);
		model.addAttribute("adminuserrole", adminuserrole);
		
		return "/sys/adminUserRole/adminUserRoleUpdate";
	}

	/************* Public Methods *************/
	
	@RequestMapping(value = "/getAdminUserRoleList", method = RequestMethod.GET)
	public String getAdminUserRoleList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminUserRole adminuserrole = requst2Bean(request,AdminUserRole.class);
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminuserrole.setId(id);
			
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminuserrole.setAdminId(adminId);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminuserrole.setRoleId(roleId);
			// 排序
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			adminuserrole.setSortColumn(sortColumn);
			
			int adminuserroleListCount = adminuserroleService.getAdminUserRoleListCount(adminuserrole);
			ResponseList<AdminUserRole> adminuserroleList = null;
			if ( adminuserroleListCount > 0 )
			{
				adminuserroleList = adminuserroleService.getAdminUserRoleList(adminuserrole);
			} else
			{
				adminuserroleList = new ResponseList<AdminUserRole>();
			}
			// 设置数据总数
			adminuserroleList.setTotalResults(adminuserroleListCount);
			
			writeSuccessMsg("ok", adminuserroleList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/getAdminUserRoleBaseList", method = RequestMethod.GET)
	public String getAdminUserRoleBaseList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminUserRole adminuserrole = new AdminUserRole();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminuserrole.setId(id);
			
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminuserrole.setAdminId(adminId);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminuserrole.setRoleId(roleId);
			
			List<AdminUserRole> adminuserroleList = adminuserroleService.getAdminUserRoleBaseList(adminuserrole);
		
			writeSuccessMsg("ok", adminuserroleList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/addAdminUserRole", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) 
	{
		try
		{
			
			AdminUserRole adminuserrole = new AdminUserRole();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminuserrole.setId(id);
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminuserrole.setAdminId(adminId);
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminuserrole.setRoleId(roleId);
				
			adminuserroleService.insertAdminUserRole(adminuserrole);
			
			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/updateAdminUserRole", method = RequestMethod.POST)
	public String updateAdminUserRole(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminUserRole adminuserrole = new AdminUserRole();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminuserrole.setId(id);
			
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminuserrole.setAdminId(adminId);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminuserrole.setRoleId(roleId);
			

			adminuserroleService.updateAdminUserRole(adminuserrole);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/removeAdminUserRole", method = RequestMethod.POST)
	public String removeAdminUserRole(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminUserRole adminuserrole = new AdminUserRole();
			Integer id = RequestHandler.getInteger(request, "id");
			adminuserrole.setId(id);

			adminuserroleService.removeAdminUserRole(adminuserrole);
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	@RequestMapping(value = "/removeAllAdminUserRole", method = RequestMethod.POST)
	public String removeAllAdminUserRole(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{	
			String ids = RequestHandler.getString(request, "ids");
			if(ids != null){
				String[] idStr = ids.split(",");
				if(idStr != null && idStr.length != 0){
					for (String id : idStr) {
						AdminUserRole adminUserRole = new AdminUserRole();
						adminUserRole.setId(Integer.valueOf(id));
						adminuserroleService.removeAdminUserRole(adminUserRole);
					}
				}
			}
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
}
