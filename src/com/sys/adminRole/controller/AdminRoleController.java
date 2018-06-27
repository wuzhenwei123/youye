package com.sys.adminRole.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONArray;

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

import com.sys.adminRole.model.AdminRole;
import com.sys.adminRole.service.AdminRoleService;
import com.sys.adminRoleColumn.model.AdminRoleColumn;
import com.sys.adminRoleColumn.service.AdminRoleColumnService;
import com.sys.adminRoleMethod.model.AdminRoleMethod;
import com.sys.adminRoleMethod.service.AdminRoleMethodService;
import com.sys.columnMethod.model.ColumnMethod;
import com.sys.columnMethod.service.ColumnMethodService;
import com.sys.manageAdminUser.model.ManageAdminUser;
import com.sys.manageColumn.model.ManageColumn;
import com.sys.manageColumn.service.ManageColumnService;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.controller.BaseController;

/**
 * @author keeny
 * @time 2015年02月04日 21:27:20
 */
@Controller
@RequestMapping("/adminRole")
public class AdminRoleController extends BaseController {

	// private static Logger logger =
	// Logger.getLogger(AdminRoleController.class); //Logger

	@Autowired
	private AdminRoleService adminroleService = null;
	@Autowired
	private AdminRoleColumnService adminrolecolumnService = null;// 角色菜单关系表
	@Autowired
	private ManageColumnService managecolumnService = null;// 菜单
	@Autowired
	private ColumnMethodService columnmethodService = null;// 菜单对应操作
	@Autowired
	private AdminRoleMethodService adminrolemethodService = null; // 角色操作方法对应关系

	/***************** 页面中转 *********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/sys/adminRole/adminRoleIndex";
	}

	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/sys/adminRole/adminRoleAdd";
	}

	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate( HttpServletRequest request, HttpServletResponse response, Model model) {

		Integer roleId = RequestHandler.getInteger(request, "roleId");// 角色
		AdminRole adminrole1 = new AdminRole();
		adminrole1.setRoleId(roleId);
		AdminRole adminrole = adminroleService.getAdminRole(adminrole1);
		model.addAttribute("adminrole", adminrole);

		return "/sys/adminRole/adminRoleUpdate";
	}

	/**
	 * 
	 * @time : 2015年2月5日 下午5:18:33
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @Description: 设置菜单权限列表
	 */
	@RequestMapping(value = "/toUserRoleColumn", method = RequestMethod.GET)
	public String toUserRoleColumn(HttpServletRequest request, HttpServletResponse response, Model model) {
		Integer roleId = RequestHandler.getInteger(request, "roleId");// 角色
		AdminRoleColumn adminRoleColumn = new AdminRoleColumn();
		adminRoleColumn.setRoleId(roleId);
		List<AdminRoleColumn> roleColumList = adminrolecolumnService.getAdminRoleColumnBaseList(adminRoleColumn);// 角色对应菜单

		ManageColumn manageColumn = new ManageColumn();
		// manageColumn.setState(1);
		List<ManageColumn> columnList = managecolumnService.getManageColumnBaseList(manageColumn);// 获取所有菜单
		List<Map<String, Object>> nodesList = new ArrayList<Map<String, Object>>();

		AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
		adminRoleMethod.setRoleId(roleId);
		List<AdminRoleMethod> roleMedList = adminrolemethodService.getAdminRoleMethodBaseList(adminRoleMethod);// 角色-操作方法关系
																												// 集合

		for (ManageColumn manageColumn2 : columnList) {
			Map<String, Object> map = new HashMap<String, Object>();
			if (manageColumn2.getParentColumnID() == -1) {
				map.put("pId", 0);
			} else {
				map.put("pId", manageColumn2.getParentColumnID());
			}
			map.put("id", manageColumn2.getColumnId());
			map.put("name", manageColumn2.getColumnName());
			map.put("open", true);// 默认打开
			map.put("checked", false);// 默认不选上

			// ---------------查询菜单对应方法
			ColumnMethod columnMethod = new ColumnMethod();
			columnMethod.setColumnId(manageColumn2.getColumnId());
			List<ColumnMethod> medList = columnmethodService.getColumnMethodBaseList(columnMethod);

			List<Map<String, Object>> medReList = new ArrayList<Map<String, Object>>();
			for (ColumnMethod med : medList) {
				Map<String, Object> medMap = new HashMap<String, Object>();
				medMap.put("mid", med.getMid());
				medMap.put("name", med.getMethodName());
				medMap.put("checked", false);// 默认不选上

				for (AdminRoleMethod method : roleMedList) {
					if (method.getMid().equals(med.getMid())) {
						medMap.put("checked", true);
						break;
					}
				}

				medReList.add(medMap);
			}
			// ---------------查询菜单对应方法
			map.put("meds", JSONArray.fromObject(medReList).toString());

			if (manageColumn2.getState() == 0) {
				map.put("nocheck", true);// 禁止选中
			}

			for (AdminRoleColumn adminRoleColumn2 : roleColumList) {// 遍历菜单，看是否自己有权限
				if (adminRoleColumn2.getColumnId().equals(manageColumn2.getColumnId())) {
					map.put("checked", true);
					break;
				}
			}

			nodesList.add(map);
		}

		JSONArray array = JSONArray.fromObject(nodesList);
		String resultString = array.toString();

		model.addAttribute("roleId", roleId);
		model.addAttribute("nodes", resultString);
		return "/sys/adminRole/userRoleColumn";
	}

	/**
	 * @time : 2015年2月6日 上午9:23:05
	 * @param roleId
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @Description: 更新角色，权限菜单
	 */
	@Deprecated
	@RequestMapping(value = "/updateRoleColumn", method = RequestMethod.POST)
	public String updateRoleColumn(HttpServletRequest request, HttpServletResponse response, Model model) {

		try {
			Integer roleId = RequestHandler.getInteger(request, "roleId");// 角色
			String nodeStr = RequestHandler.getString(request, "nodeStr");// 选中菜单集合
			String mids = RequestHandler.getString(request, "mids");// 操作方法集合

			AdminRoleColumn adminRoleColumn = new AdminRoleColumn();
			adminRoleColumn.setRoleId(roleId);

			adminrolecolumnService.removeAdminRoleColumnByRoleId(adminRoleColumn);
			JSONArray nodeArr = JSONArray.fromObject(nodeStr);// 选择的菜单
			if (nodeArr != null) {
				for (Object object : nodeArr) {

					Map<String, Object> columnMap = (Map<String, Object>) object;
					Integer columnId = (Integer) columnMap.get("id");// 菜单ID

					adminRoleColumn.setColumnId(columnId);
					adminrolecolumnService.insertAdminRoleColumn(adminRoleColumn);//插入菜单权限
				}
			}

			AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
			adminRoleMethod.setRoleId(roleId);
			adminrolemethodService.removeAdminRoleMethodByRoleId(adminRoleMethod);
			if (mids != null && !"".equals(mids)) {
				String[] midstr = mids.split(",");
				for (String mid : midstr) {
					if(!"".equals(mid)){
						adminRoleMethod.setMid(Integer.valueOf(mid));
						adminrolemethodService.insertAdminRoleMethod(adminRoleMethod);//插入操作权限
					}
				}
			}
			
			writeSuccessMsg("ok", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}

		return null;
	}
	/**
	 * 更新操作方法
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateRoleMed", method = RequestMethod.POST)
	public String updateRoleMed(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		try {
			Integer roleId = RequestHandler.getInteger(request, "roleId");// 角色
			String mid = RequestHandler.getString(request, "mid");// 操作方法ID
			String ck = RequestHandler.getString(request, "ck");// 操作类型，删除 OR 添加
			
			if(ck.equals("add")){
				//开始处理菜单
				ColumnMethod columnMethod = new ColumnMethod();
				columnMethod.setMid(Integer.valueOf(mid));
				List<ColumnMethod> columnMethodBaseList = columnmethodService.getColumnMethodBaseList(columnMethod);//操作方法所属菜单
				if(columnMethodBaseList!=null){
					ColumnMethod columnMethod2 = columnMethodBaseList.get(0);
					AdminRoleColumn adminRoleColumn = new AdminRoleColumn();
					adminRoleColumn.setRoleId(roleId);
					adminRoleColumn.setColumnId(columnMethod2.getColumnId());
					int adminRoleColumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(adminRoleColumn);
					if(adminRoleColumnListCount == 0){//如果此操作方法上的菜单没有授权，这里要进行授权
						AdminRoleColumn roleColumn1 = new AdminRoleColumn();
						roleColumn1.setRoleId(roleId);
						roleColumn1.setColumnId(columnMethod2.getColumnId());
						adminrolecolumnService.insertAdminRoleColumn(roleColumn1);
					}
					
					//开始检查 父节点是否授权
					ManageColumn manageColumn = new ManageColumn();
					manageColumn.setColumnId(columnMethod2.getColumnId());
					ManageColumn manageColumn2 = managecolumnService.getManageColumn(manageColumn);
					Integer parentColumnID = manageColumn2.getParentColumnID();
					
					adminRoleColumn = new AdminRoleColumn();
					adminRoleColumn.setRoleId(roleId);
					adminRoleColumn.setColumnId(parentColumnID);
					adminRoleColumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(adminRoleColumn);
					if(adminRoleColumnListCount == 0){//最上级未授权，这里开始授权
						AdminRoleColumn roleColumn1 = new AdminRoleColumn();
						roleColumn1.setRoleId(roleId);
						roleColumn1.setColumnId(parentColumnID);
						adminrolecolumnService.insertAdminRoleColumn(roleColumn1);
					}
				}
				
				AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
				adminRoleMethod.setRoleId(roleId);
				adminRoleMethod.setMid(Integer.valueOf(mid));
				adminrolemethodService.insertAdminRoleMethod(adminRoleMethod);//插入操作权限
			}
			if(ck.equals("move")){
				ColumnMethod columnMethod = new ColumnMethod();
				columnMethod.setMid(Integer.valueOf(mid));
				List<ColumnMethod> columnMethodBaseList = columnmethodService.getColumnMethodBaseList(columnMethod);//操作方法所属菜单
				if(columnMethodBaseList!=null){
					boolean isDelColumn = true;//是否要删除父授权
					ColumnMethod columnMethod2 = columnMethodBaseList.get(0);
					columnMethod = new ColumnMethod();
					columnMethod.setColumnId(columnMethod2.getColumnId());
					List<ColumnMethod> columnMethodBaseList2 = columnmethodService.getColumnMethodBaseList(columnMethod);//此操作方法的兄弟操作方法
					for (ColumnMethod columnMethod3 : columnMethodBaseList2) {
						if(columnMethod3.getMid().intValue() == Integer.valueOf(mid).intValue()){//排除自己
							continue;
						}
						AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
						adminRoleMethod.setRoleId(roleId);
						adminRoleMethod.setMid(columnMethod3.getMid());
						int adminRoleMethodListCount = adminrolemethodService.getAdminRoleMethodListCount(adminRoleMethod);
						if(adminRoleMethodListCount!=0){//有兄弟节点已被授权，不能删除父授权
							isDelColumn = false;
							break;
						}
					}
					if(isDelColumn){
						//开始检查 父节点是否授权
						AdminRoleColumn adminRoleColumn = new AdminRoleColumn();
						adminRoleColumn.setRoleId(roleId);
						adminRoleColumn.setColumnId(columnMethod2.getColumnId());
						adminrolecolumnService.removeAdminRoleColumnByRoleIdColumnId(adminRoleColumn);//删除所属菜单权限
						
						boolean isDelParent = true;//是否删除父授权
						ManageColumn manageColumn = new ManageColumn();
						manageColumn.setColumnId(columnMethod2.getColumnId());
						ManageColumn manageColumn2 = managecolumnService.getManageColumn(manageColumn);//获取当前菜单
						
						Integer parentColumnID = manageColumn2.getParentColumnID();
						manageColumn = new ManageColumn();
						manageColumn.setParentColumnID(parentColumnID);
						List<ManageColumn> manageColumnBaseList = managecolumnService.getManageColumnBaseList(manageColumn);//获取兄弟菜单
						if(manageColumnBaseList!=null && manageColumnBaseList.size() == 1){//只有一个菜单，则父菜单取消授权
							isDelParent = true;
						}else{
							for (ManageColumn manageColumn3 : manageColumnBaseList) {//兄弟节点，如果有一个兄弟节点授权了。则其父不取消授权
								if(manageColumn3.getColumnId().intValue() == manageColumn2.getColumnId().intValue()){//排除当前节点
									continue;
								}
								adminRoleColumn = new AdminRoleColumn();
								adminRoleColumn.setRoleId(roleId);
								adminRoleColumn.setColumnId(manageColumn3.getColumnId());
								int adminRoleColumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(adminRoleColumn);//查看兄弟节点是否授权
								if(adminRoleColumnListCount != 0){//兄弟节点已授权，父节点不取消授权
									isDelParent = false;
									break;
								}
							}
						}
						if(isDelParent){
							AdminRoleColumn roleColumn = new AdminRoleColumn();
							roleColumn.setRoleId(roleId);
							roleColumn.setColumnId(parentColumnID);
							adminrolecolumnService.removeAdminRoleColumnByRoleIdColumnId(roleColumn);
						}
					}
				}
				
				
				AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
				adminRoleMethod.setRoleId(roleId);
				adminRoleMethod.setMid(Integer.valueOf(mid));
				adminrolemethodService.removeAdminRoleMethodByRoleIdMid(adminRoleMethod);
			}
			writeSuccessMsg("ok", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		
		return null;
	}
	@RequestMapping(value = "/updateRoleColumnNew", method = RequestMethod.POST)
	public String updateRoleColumnNew(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		try {
			Integer roleId = RequestHandler.getInteger(request, "roleId");// 角色
			Integer columnId = RequestHandler.getInteger(request, "columnId");// 菜单ID
			String ck = RequestHandler.getString(request, "ck");// 操作类型，删除 OR 添加
			
			if(ck.equals("add")){
				ManageColumn manageColumn = new ManageColumn();
				manageColumn.setColumnId(columnId);
				ManageColumn manageColumn2 = managecolumnService.getManageColumn(manageColumn);
				
				if(manageColumn2.getParentColumnID()==-1){//父菜单，下面所有授权
					manageColumn = new ManageColumn();
					manageColumn.setParentColumnID(columnId);
					List<ManageColumn> manageColumnBaseList = managecolumnService.getManageColumnBaseList(manageColumn);
					for (ManageColumn manageColumn3 : manageColumnBaseList) {
						AdminRoleColumn roleColumn = new AdminRoleColumn();
						roleColumn.setRoleId(roleId);
						roleColumn.setColumnId(manageColumn3.getColumnId());
						
						int adminRoleColumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(roleColumn);
						if(adminRoleColumnListCount == 0)
						{
							adminrolecolumnService.insertAdminRoleColumn(roleColumn);//插入操作权限
						}
					}
				}else{//子菜单，要授权其父菜单
					
					Integer parentColumnID = manageColumn2.getParentColumnID();
					AdminRoleColumn roleColumn1 = new AdminRoleColumn();
					roleColumn1.setRoleId(roleId);
					roleColumn1.setColumnId(parentColumnID);
					int adminRoleColumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(roleColumn1);
					if(adminRoleColumnListCount == 0){//父菜单没有授权，这里要授权
						adminrolecolumnService.insertAdminRoleColumn(roleColumn1);//插入操作权限
					}
				}
				AdminRoleColumn roleColumn = new AdminRoleColumn();
				roleColumn.setRoleId(roleId);
				roleColumn.setColumnId(columnId);
				int adminRoleColumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(roleColumn);
				if(adminRoleColumnListCount == 0){
					adminrolecolumnService.insertAdminRoleColumn(roleColumn);//插入操作权限
				}
			}
			if(ck.equals("move")){
				ManageColumn manageColumn = new ManageColumn();
				manageColumn.setColumnId(columnId);
				ManageColumn manageColumn2 = managecolumnService.getManageColumn(manageColumn);
				
				if(manageColumn2.getParentColumnID()==-1){//父菜单，下面所有取消授权
					manageColumn = new ManageColumn();
					manageColumn.setParentColumnID(columnId);
					List<ManageColumn> manageColumnBaseList = managecolumnService.getManageColumnBaseList(manageColumn);
					for (ManageColumn manageColumn3 : manageColumnBaseList) {
						AdminRoleColumn roleColumn = new AdminRoleColumn();
						roleColumn.setRoleId(roleId);
						roleColumn.setColumnId(manageColumn3.getColumnId());
						adminrolecolumnService.removeAdminRoleColumnByRoleIdColumnId(roleColumn);
						
						// 开始处理菜单下操作方法
						ColumnMethod columnMethod = new ColumnMethod();
						columnMethod.setColumnId(manageColumn3.getColumnId());
						List<ColumnMethod> columnMethodBaseList = columnmethodService.getColumnMethodBaseList(columnMethod);
						for (ColumnMethod columnMethod2 : columnMethodBaseList) {
							AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
							adminRoleMethod.setRoleId(roleId);
							adminRoleMethod.setMid(columnMethod2.getMid());
							adminrolemethodService.removeAdminRoleMethodByRoleIdMid(adminRoleMethod);
						}
					}
				}else{//如果其父菜单下只有一个子菜单，则把父菜单取消授权
					boolean isDelParent = true;//是否删除父授权
					Integer parentColumnID = manageColumn2.getParentColumnID();
					manageColumn = new ManageColumn();
					manageColumn.setParentColumnID(parentColumnID);
					List<ManageColumn> manageColumnBaseList = managecolumnService.getManageColumnBaseList(manageColumn);
					if(manageColumnBaseList!=null && manageColumnBaseList.size() == 1){//只有一个菜单，则父菜单取消授权
						isDelParent = true;
					}else{
						for (ManageColumn manageColumn3 : manageColumnBaseList) {//兄弟节点，如果有一个兄弟节点授权了。则其父不取消授权
							if(manageColumn3.getColumnId().intValue() == columnId.intValue()){//排除当前节点
								continue;
							}
							AdminRoleColumn adminRoleColumn = new AdminRoleColumn();
							adminRoleColumn.setRoleId(roleId);
							adminRoleColumn.setColumnId(manageColumn3.getColumnId());
							int adminRoleColumnListCount = adminrolecolumnService.getAdminRoleColumnListCount(adminRoleColumn);//查看兄弟节点是否授权
							if(adminRoleColumnListCount != 0){//兄弟节点已授权，父节点不取消授权
								isDelParent = false;
								break;
							}
						}
					}
					if(isDelParent){
						AdminRoleColumn roleColumn = new AdminRoleColumn();
						roleColumn.setRoleId(roleId);
						roleColumn.setColumnId(parentColumnID);
						adminrolecolumnService.removeAdminRoleColumnByRoleIdColumnId(roleColumn);
					}
				}
				AdminRoleColumn roleColumn = new AdminRoleColumn();
				roleColumn.setRoleId(roleId);
				roleColumn.setColumnId(columnId);
				adminrolecolumnService.removeAdminRoleColumnByRoleIdColumnId(roleColumn);
				// 开始处理菜单下操作方法
				
				ColumnMethod columnMethod = new ColumnMethod();
				columnMethod.setColumnId(columnId);
				List<ColumnMethod> columnMethodBaseList = columnmethodService.getColumnMethodBaseList(columnMethod);
				for (ColumnMethod columnMethod2 : columnMethodBaseList) {
					AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
					adminRoleMethod.setRoleId(roleId);
					adminRoleMethod.setMid(columnMethod2.getMid());
					adminrolemethodService.removeAdminRoleMethodByRoleIdMid(adminRoleMethod);
				}
			}
			writeSuccessMsg("ok", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		
		return null;
	}

	/************* Public Methods *************/

	@RequestMapping(value = "/getAdminRoleList", method = RequestMethod.GET)
	public String getAdminRoleList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminRole adminrole = requst2Bean(request,AdminRole.class);

			int adminroleListCount = adminroleService.getAdminRoleListCount(adminrole);
			ResponseList<AdminRole> adminroleList = null;
			if (adminroleListCount > 0) {
				adminroleList = adminroleService.getAdminRoleList(adminrole);
			} else {
				adminroleList = new ResponseList<AdminRole>();
			}
			// 设置数据总数
			adminroleList.setTotalResults(adminroleListCount);

			writeSuccessMsg("ok", adminroleList, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/getAdminRoleBaseList", method = RequestMethod.GET)
	public String getAdminRoleBaseList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminRole adminrole = new AdminRole();

			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrole.setRoleId(roleId);

			String roleName = RequestHandler.getString(request, "roleName");
			adminrole.setRoleName(roleName);

			Date createTime = RequestHandler.getDate(request, "createTime");
			adminrole.setCreateTime(createTime);

			Integer state = RequestHandler.getInteger(request, "state");
			adminrole.setState(state);

			Integer defaule = RequestHandler.getInteger(request, "defaule");
			adminrole.setDefaule(defaule);

			Integer roleType = RequestHandler.getInteger(request, "roleType");
			adminrole.setRoleType(roleType);

			List<AdminRole> adminroleList = adminroleService.getAdminRoleBaseList(adminrole);

			writeSuccessMsg("ok", adminroleList, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/addAdminRole", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {

			AdminRole adminrole = new AdminRole();

			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrole.setRoleId(roleId);
			String roleName = RequestHandler.getString(request, "roleName");
			adminrole.setRoleName(roleName);
			Date createTime = RequestHandler.getDate(request, "createTime");
			adminrole.setCreateTime(new Date());
			Integer state = RequestHandler.getInteger(request, "state");
			adminrole.setState(state);
			Integer defaule = RequestHandler.getInteger(request, "defaule");
			adminrole.setDefaule(defaule);
			Integer roleType = RequestHandler.getInteger(request, "roleType");
			adminrole.setRoleType(roleType);

			adminroleService.insertAdminRole(adminrole);

			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/updateAdminRole", method = RequestMethod.POST)
	public String updateAdminRole(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminRole adminrole = new AdminRole();

			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrole.setRoleId(roleId);

			String roleName = RequestHandler.getString(request, "roleName");
			adminrole.setRoleName(roleName);

			Date createTime = RequestHandler.getDate(request, "createTime");
			adminrole.setCreateTime(createTime);

			Integer state = RequestHandler.getInteger(request, "state");
			adminrole.setState(state);

			Integer defaule = RequestHandler.getInteger(request, "defaule");
			adminrole.setDefaule(defaule);

			Integer roleType = RequestHandler.getInteger(request, "roleType");
			adminrole.setRoleType(roleType);

			adminroleService.updateAdminRole(adminrole);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeAdminRole", method = RequestMethod.POST)
	public String removeAdminRole(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminRole adminrole = new AdminRole();
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			adminrole.setRoleId(roleId);

			adminroleService.removeAdminRole(adminrole);
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeAllAdminRole", method = RequestMethod.POST)
	public String removeAllAdminRole(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			String roleIds = RequestHandler.getString(request, "roleIds");
			if (roleIds != null) {
				String[] roleIdStr = roleIds.split(",");
				if (roleIdStr != null && roleIdStr.length != 0) {
					for (String roleId : roleIdStr) {
						AdminRole adminRole = new AdminRole();
						adminRole.setRoleId(Integer.valueOf(roleId));
						adminroleService.removeAdminRole(adminRole);
					}
				}
			}
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
}
