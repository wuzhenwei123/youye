package com.sys.adminRoleColumn.controller;

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

import com.sys.adminRoleColumn.model.AdminRoleColumn;
import com.sys.adminRoleColumn.service.AdminRoleColumnService;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.controller.BaseController;
/**
 * @author	keeny
 * @time	2015年02月05日 17:27:42
 */
@Controller
@RequestMapping("/adminRoleColumn")
public class AdminRoleColumnController extends BaseController
{
	
	//private static Logger logger = Logger.getLogger(AdminRoleColumnController.class); //Logger
	
	@Autowired
	private AdminRoleColumnService adminrolecolumnService = null;
	
	/*****************页面中转*********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/adminRoleColumn/adminRoleColumnIndex";
	}
	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/adminRoleColumn/adminRoleColumnAdd";
	}
	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate(HttpServletRequest request, HttpServletResponse response, Model model)
	{	
		Integer id = RequestHandler.getInteger(request, "id");
		AdminRoleColumn adminrolecolumn1 = new AdminRoleColumn();
		adminrolecolumn1.setId(id);
		AdminRoleColumn adminrolecolumn = adminrolecolumnService.getAdminRoleColumn(adminrolecolumn1);
		model.addAttribute("adminrolecolumn", adminrolecolumn);
		
		return "/sys/adminRoleColumn/adminRoleColumnUpdate";
	}

	/************* Public Methods *************/
	
	@RequestMapping(value = "/getAdminRoleColumnList", method = RequestMethod.GET)
	public String getAdminRoleColumnList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleColumn adminrolecolumn = new AdminRoleColumn();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolecolumn.setId(id);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolecolumn.setRoleId(roleId);
			
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			adminrolecolumn.setColumnId(columnId);
			

			// 分页开始
			Integer pageNo = RequestHandler.getPageNo(request, "pageNo");
			Integer rowCount = RequestHandler.getPageSize(request, "rowCount");
			
			int from = RequestHandler.getFromByPage(pageNo, rowCount);
			adminrolecolumn.setRowStart(from);
			adminrolecolumn.setRowCount(rowCount);
			// 分页结束
			// 排序
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			adminrolecolumn.setSortColumn(sortColumn);
			
			int adminrolecolumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(adminrolecolumn);
			ResponseList<AdminRoleColumn> adminrolecolumnList = null;
			if ( adminrolecolumnListCount > 0 )
			{
				adminrolecolumnList = adminrolecolumnService.getAdminRoleColumnList(adminrolecolumn);
			} else
			{
				adminrolecolumnList = new ResponseList<AdminRoleColumn>();
			}
			// 设置数据总数
			adminrolecolumnList.setTotalResults(adminrolecolumnListCount);
			
			writeSuccessMsg("ok", adminrolecolumnList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/getAdminRoleColumnBaseList", method = RequestMethod.GET)
	public String getAdminRoleColumnBaseList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleColumn adminrolecolumn = new AdminRoleColumn();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolecolumn.setId(id);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolecolumn.setRoleId(roleId);
			
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			adminrolecolumn.setColumnId(columnId);
			
			List<AdminRoleColumn> adminrolecolumnList = adminrolecolumnService.getAdminRoleColumnBaseList(adminrolecolumn);
		
			writeSuccessMsg("ok", adminrolecolumnList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/addAdminRoleColumn", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) 
	{
		try
		{
			
			AdminRoleColumn adminrolecolumn = new AdminRoleColumn();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolecolumn.setId(id);
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolecolumn.setRoleId(roleId);
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			adminrolecolumn.setColumnId(columnId);
				
			adminrolecolumnService.insertAdminRoleColumn(adminrolecolumn);
			
			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/updateAdminRoleColumn", method = RequestMethod.POST)
	public String updateAdminRoleColumn(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleColumn adminrolecolumn = new AdminRoleColumn();
			
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolecolumn.setId(id);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrolecolumn.setRoleId(roleId);
			
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			adminrolecolumn.setColumnId(columnId);
			

			adminrolecolumnService.updateAdminRoleColumn(adminrolecolumn);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/removeAdminRoleColumn", method = RequestMethod.POST)
	public String removeAdminRoleColumn(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			AdminRoleColumn adminrolecolumn = new AdminRoleColumn();
			Integer id = RequestHandler.getInteger(request, "id");
			adminrolecolumn.setId(id);

			adminrolecolumnService.removeAdminRoleColumn(adminrolecolumn);
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	@RequestMapping(value = "/removeAllAdminRoleColumn", method = RequestMethod.POST)
	public String removeAllAdminRoleColumn(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{	
			String ids = RequestHandler.getString(request, "ids");
			if(ids != null){
				String[] idStr = ids.split(",");
				if(idStr != null && idStr.length != 0){
					for (String id : idStr) {
						AdminRoleColumn adminRoleColumn = new AdminRoleColumn();
						adminRoleColumn.setId(Integer.valueOf(id));
						adminrolecolumnService.removeAdminRoleColumn(adminRoleColumn);
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
