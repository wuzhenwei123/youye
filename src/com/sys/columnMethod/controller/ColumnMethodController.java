package com.sys.columnMethod.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;

import java.util.List;

import javax.activation.URLDataSource;
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
import com.sys.adminRoleMethod.model.AdminRoleMethod;
import com.sys.adminRoleMethod.service.AdminRoleMethodService;
import com.sys.columnMethod.model.ColumnMethod;
import com.sys.columnMethod.service.ColumnMethodService;
import com.sys.manageColumn.model.ManageColumn;
import com.sys.manageColumn.service.ManageColumnService;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.controller.BaseController;
/**
 * @author	keeny
 * @time	2015年02月04日 20:46:28
 */
@Controller
@RequestMapping("/columnMethod")
public class ColumnMethodController extends BaseController
{
	
	//private static Logger logger = Logger.getLogger(ColumnMethodController.class); //Logger
	
	@Autowired
	private ColumnMethodService columnmethodService = null;
	@Autowired
	private AdminRoleColumnService adminrolecolumnService = null;// 角色菜单关系表
	@Autowired
	private ManageColumnService managecolumnService = null;// 菜单
	@Autowired
	private AdminRoleMethodService adminrolemethodService = null; // 角色操作方法对应关系
	
	/*****************页面中转*********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/columnMethod/columnMethodIndex";
	}
	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "/sys/columnMethod/columnMethodAdd";
	}
	/**
	 * @time : 2015年2月6日 下午3:01:15
	 * @param columnId
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @Description: 添加操作方法
	 */
	@RequestMapping(value = "/toAddMed", method = RequestMethod.GET)
	public String toAddMed(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		Integer columnId = RequestHandler.getInteger(request, "columnId");
		ManageColumn manageColumn = new ManageColumn();
		manageColumn.setColumnId(columnId);
		ManageColumn column = managecolumnService.getManageColumn(manageColumn);
		model.addAttribute("column", column);
		return "/sys/columnMethod/columnAdd";
	}
	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate(HttpServletRequest request, HttpServletResponse response, Model model)
	{	
	    Integer mid = RequestHandler.getInteger(request, "mid");
		ColumnMethod columnmethod1 = new ColumnMethod();
		columnmethod1.setMid(mid);
		ColumnMethod columnmethod = columnmethodService.getColumnMethod(columnmethod1);
		model.addAttribute("columnmethod", columnmethod);
		
		return "/sys/columnMethod/columnMethodUpdate";
	}

	/************* Public Methods *************/
	/**
	 * @time : 2015年2月6日 下午1:36:25
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @Description: 获取菜单树
	 */
	@RequestMapping(value = "/getColumnTree", method = RequestMethod.GET)
	public String toUserRoleColumn(HttpServletRequest request, HttpServletResponse response, Model model) {

		ManageColumn manageColumn = new ManageColumn();
	    manageColumn.setState(1);
		List<ManageColumn> columnList = managecolumnService.getManageColumnBaseList(manageColumn);// 获取所有菜单
		List<Map<String, Object>> nodesList = new ArrayList<Map<String, Object>>();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", 0);
		map.put("name", "根目录");
		map.put("open", true);// 默认不打开
		nodesList.add(map);
		
		for (ManageColumn manageColumn2 : columnList) {
			map = new HashMap<String, Object>();
			if (manageColumn2.getParentColumnID() == -1) {
				map.put("pId", 0);
			} else {
				map.put("pId", manageColumn2.getParentColumnID());
			}
			map.put("id", manageColumn2.getColumnId());
			map.put("name", manageColumn2.getColumnName());
			map.put("open", true);// 默认不打开

			// ---------------查询菜单对应方法
			ColumnMethod columnMethod = new ColumnMethod();
			columnMethod.setColumnId(manageColumn2.getColumnId());
			List<ColumnMethod> medList = columnmethodService.getColumnMethodBaseList(columnMethod);

			List<Map<String, Object>> medReList = new ArrayList<Map<String, Object>>();
			for (ColumnMethod med : medList) {
				Map<String, Object> medMap = new HashMap<String, Object>();
				medMap.put("mid", med.getMid());
				medMap.put("name", med.getMethodName());
				medReList.add(medMap);
			}
			// ---------------查询菜单对应方法
			map.put("meds", JSONArray.fromObject(medReList).toString()); 
			nodesList.add(map);
		}
		writeSuccessMsg("ok", nodesList, response);
		return null;
	}
	
	
	@RequestMapping(value = "/getColumnMethodList", method = RequestMethod.GET)
	public String getColumnMethodList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			ColumnMethod columnmethod = new ColumnMethod();
			
			Integer mid = RequestHandler.getInteger(request, "mid");
			columnmethod.setMid(mid);
			
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			columnmethod.setColumnId(columnId);
			
			String methodName = RequestHandler.getString(request, "methodName");
			columnmethod.setMethodName(methodName);
			
			String actionPath = RequestHandler.getString(request, "actionPath");
			columnmethod.setActionPath(actionPath);
			
			Date createTime = RequestHandler.getDate(request, "createTime");
			columnmethod.setCreateTime(createTime);
			

			// 分页开始
			Integer pageNo = RequestHandler.getPageNo(request, "pageNo");
			Integer rowCount = RequestHandler.getPageSize(request, "rowCount");
			
			int from = RequestHandler.getFromByPage(pageNo, rowCount);
			columnmethod.setRowStart(from);
			columnmethod.setRowCount(rowCount);
			// 分页结束
			// 排序
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			columnmethod.setSortColumn(sortColumn);
			
			int columnmethodListCount = columnmethodService.getColumnMethodListCount(columnmethod);
			ResponseList<ColumnMethod> columnmethodList = null;
			if ( columnmethodListCount > 0 )
			{
				columnmethodList = columnmethodService.getColumnMethodList(columnmethod);
			} else
			{
				columnmethodList = new ResponseList<ColumnMethod>();
			}
			// 设置数据总数
			columnmethodList.setTotalResults(columnmethodListCount);
			
			writeSuccessMsg("ok", columnmethodList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/getColumnMethodBaseList", method = RequestMethod.GET)
	public String getColumnMethodBaseList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			ColumnMethod columnmethod = new ColumnMethod();
			
			Integer mid = RequestHandler.getInteger(request, "mid");
			columnmethod.setMid(mid);
			
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			columnmethod.setColumnId(columnId);
			
			String methodName = RequestHandler.getString(request, "methodName");
			columnmethod.setMethodName(methodName);
			
			String actionPath = RequestHandler.getString(request, "actionPath");
			columnmethod.setActionPath(actionPath);
			
			Date createTime = RequestHandler.getDate(request, "createTime");
			columnmethod.setCreateTime(createTime);
			
			List<ColumnMethod> columnmethodList = columnmethodService.getColumnMethodBaseList(columnmethod);
		
			writeSuccessMsg("ok", columnmethodList, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/addColumnMethod", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) 
	{
		try
		{
			
			ColumnMethod columnmethod = new ColumnMethod();
			
			Integer mid = RequestHandler.getInteger(request, "mid");
			columnmethod.setMid(mid);
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			columnmethod.setColumnId(columnId);
			String methodName = RequestHandler.getString(request, "methodName");
			if(methodName!=null){
				columnmethod.setMethodName(URLDecoder.decode(methodName, "UTF-8"));
			}
			String actionPath = RequestHandler.getString(request, "actionPath");
			columnmethod.setActionPath(actionPath);
			Date createTime = RequestHandler.getDate(request, "createTime");
			columnmethod.setCreateTime(new Date());
				
			columnmethodService.insertColumnMethod(columnmethod);
			
			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/updateColumnMethod", method = RequestMethod.POST)
	public String updateColumnMethod(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			ColumnMethod columnmethod = new ColumnMethod();
			
			Integer mid = RequestHandler.getInteger(request, "mid");
			columnmethod.setMid(mid);
			
			Integer columnId = RequestHandler.getInteger(request, "columnId");
			columnmethod.setColumnId(columnId);
			
			String methodName = RequestHandler.getString(request, "methodName");
			if(methodName!=null){
				methodName = URLDecoder.decode(methodName, "UTF-8");
				columnmethod.setMethodName(methodName);
			}
			
			String actionPath = RequestHandler.getString(request, "actionPath");
			columnmethod.setActionPath(actionPath);
			
			Date createTime = RequestHandler.getDate(request, "createTime");
			columnmethod.setCreateTime(createTime);
			

			columnmethodService.updateColumnMethod(columnmethod);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	
	@RequestMapping(value = "/removeColumnMethod", method = RequestMethod.POST)
	public String removeColumnMethod(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{
			ColumnMethod columnmethod = new ColumnMethod();
			Integer mid = RequestHandler.getInteger(request, "mid");
			columnmethod.setMid(mid);
			
			AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
			adminRoleMethod.setMid(mid);
			int count = adminrolemethodService.getAdminRoleMethodListCount(adminRoleMethod);
			if(count == 0){
				columnmethodService.removeColumnMethod(columnmethod);
				writeSuccessMsg("删除成功", null, response);
			}else{
				writeErrorMsg("此权限已被设置，请取消权限后再来删除！", null, response);//有人已分配权限，不能删除
			}
			
		} catch (Exception e)
		{
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	@RequestMapping(value = "/removeAllColumnMethod", method = RequestMethod.POST)
	public String removeAllColumnMethod(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		try
		{	
			String mids = RequestHandler.getString(request, "mids");
			if(mids != null){
				String[] midStr = mids.split(",");
				if(midStr != null && midStr.length != 0){
					for (String mid : midStr) {
						ColumnMethod columnMethod = new ColumnMethod();
						columnMethod.setMid(Integer.valueOf(mid));
						columnmethodService.removeColumnMethod(columnMethod);
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
