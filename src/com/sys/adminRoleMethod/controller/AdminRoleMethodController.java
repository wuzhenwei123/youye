package com.sys.adminRoleMethod.controller;

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

import com.sys.adminRoleMethod.model.AdminRoleMethod;
import com.sys.adminRoleMethod.service.AdminRoleMethodService;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.controller.BaseController;
/**
 * @author	keeny
 * @time	2015年02月06日 10:51:32
 */
@Controller
@RequestMapping("/adminRoleMethod")
public class AdminRoleMethodController extends BaseController
{
	
	//private static Logger logger = Logger.getLogger(AdminRoleMethodController.class); //Logger
	
	@Autowired
	private AdminRoleMethodService adminrolemethodService = null;
	
	/*****************页面中转*********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/adminRoleMethod/adminRoleMethodIndex";
	}
	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/adminRoleMethod/adminRoleMethodAdd";
	}
	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate( HttpServletRequest request, HttpServletResponse response, Model model)
	{	
		Integer id = RequestHandler.getInteger(request, "id");
		AdminRoleMethod adminrolemethod1 = new AdminRoleMethod();
		adminrolemethod1.setId(id);
		AdminRoleMethod adminrolemethod = adminrolemethodService.getAdminRoleMethod(adminrolemethod1);
		model.addAttribute("adminrolemethod", adminrolemethod);
		
		return "/sys/adminRoleMethod/adminRoleMethodUpdate";
	}

	/************* Public Methods *************/
	
	@RequestMapping(value = "/getAdminRoleMethodList", method = RequestMethod.GET)
	public String getAdminRoleMethodList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleMethod adminrolemethod = new AdminRoleMethod();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolemethod.setId(id);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolemethod.setRoleId(roleId);
			
			Integer mid = RequestHandler.getInteger(request, "mid");
			adminrolemethod.setMid(mid);
			

			// 分页开始
			Integer pageNo = RequestHandler.getPageNo(request, "pageNo");
			Integer rowCount = RequestHandler.getPageSize(request, "rowCount");
			
			int from = RequestHandler.getFromByPage(pageNo, rowCount);
			adminrolemethod.setRowStart(from);
			adminrolemethod.setRowCount(rowCount);
			// 分页结束
			// 排序
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			adminrolemethod.setSortColumn(sortColumn);
			
			int adminrolemethodListCount = adminrolemethodService.getAdminRoleMethodListCount(adminrolemethod);
			ResponseList<AdminRoleMethod> adminrolemethodList = null;
			if ( adminrolemethodListCount > 0 )
			{
				adminrolemethodList = adminrolemethodService.getAdminRoleMethodList(adminrolemethod);
			} else
			{
				adminrolemethodList = new ResponseList<AdminRoleMethod>();
			}
			// 设置数据总数
			adminrolemethodList.setTotalResults(adminrolemethodListCount);
			
			writeSuccessMsg("ok", adminrolemethodList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/getAdminRoleMethodBaseList", method = RequestMethod.GET)
	public String getAdminRoleMethodBaseList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleMethod adminrolemethod = new AdminRoleMethod();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolemethod.setId(id);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolemethod.setRoleId(roleId);
			
			Integer mid = RequestHandler.getInteger(request, "mid");
			adminrolemethod.setMid(mid);
			
			List<AdminRoleMethod> adminrolemethodList = adminrolemethodService.getAdminRoleMethodBaseList(adminrolemethod);
		
			writeSuccessMsg("ok", adminrolemethodList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/addAdminRoleMethod", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) 
	{
		try
		{
			
			AdminRoleMethod adminrolemethod = new AdminRoleMethod();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolemethod.setId(id);
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolemethod.setRoleId(roleId);
			Integer mid = RequestHandler.getInteger(request, "mid");
			adminrolemethod.setMid(mid);
				
			adminrolemethodService.insertAdminRoleMethod(adminrolemethod);
			
			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/updateAdminRoleMethod", method = RequestMethod.POST)
	public String updateAdminRoleMethod(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleMethod adminrolemethod = new AdminRoleMethod();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolemethod.setId(id);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolemethod.setRoleId(roleId);
			
			Integer mid = RequestHandler.getInteger(request, "mid");
			adminrolemethod.setMid(mid);
			

			adminrolemethodService.updateAdminRoleMethod(adminrolemethod);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/removeAdminRoleMethod", method = RequestMethod.POST)
	public String removeAdminRoleMethod(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleMethod adminrolemethod = new AdminRoleMethod();
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolemethod.setId(id);

			adminrolemethodService.removeAdminRoleMethod(adminrolemethod);
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	@RequestMapping(value = "/removeAllAdminRoleMethod", method = RequestMethod.POST)
	public String removeAllAdminRoleMethod(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{	
			String ids = RequestHandler.getString(request, "ids");
			if(ids != null){
				String[] idStr = ids.split(",");
				if(idStr != null && idStr.length != 0){
					for (String id : idStr) {
						AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
						adminRoleMethod.setId(Integer.valueOf(id));
						adminrolemethodService.removeAdminRoleMethod(adminRoleMethod);
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
