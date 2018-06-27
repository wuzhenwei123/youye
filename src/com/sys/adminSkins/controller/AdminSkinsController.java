package com.sys.adminSkins.controller;

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

import com.sys.adminSkins.model.AdminSkins;
import com.sys.adminSkins.service.AdminSkinsService;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.utils.SessionName;
import com.base.controller.BaseController;

/**
 * @author keeny
 * @time 2015年02月10日 10:38:45
 */
@Controller
@RequestMapping("/adminSkins")
public class AdminSkinsController extends BaseController {

	// private static Logger logger =
	// Logger.getLogger(AdminSkinsController.class); //Logger

	@Autowired
	private AdminSkinsService adminskinsService = null;

	/***************** 页面中转 *********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/sys/adminSkins/adminSkinsIndex";
	}

	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model) {
		AdminSkins adminskins1 = new AdminSkins();
		Integer adminId = Integer.valueOf(request.getSession().getAttribute(SessionName.ADMIN_USER_ID).toString());
		adminskins1.setAdminId(adminId);
		AdminSkins adminskins = adminskinsService.getAdminSkins(adminskins1);
		model.addAttribute("adminskins", adminskins);
		return "/sys/adminSkins/adminSkinsAdd";
	}

	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate( HttpServletRequest request, HttpServletResponse response, Model model) {
		Integer skinId = RequestHandler.getInteger(request, "skinId");
		AdminSkins adminskins1 = new AdminSkins();
		adminskins1.setSkinId(skinId);
		AdminSkins adminskins = adminskinsService.getAdminSkins(adminskins1);
		model.addAttribute("adminskins", adminskins);

		return "/sys/adminSkins/adminSkinsUpdate";
	}

	/************* Public Methods *************/

	@RequestMapping(value = "/getAdminSkinsList", method = RequestMethod.GET)
	public String getAdminSkinsList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminSkins adminskins = new AdminSkins();

			Integer skinId = RequestHandler.getInteger(request, "skinId");
			adminskins.setSkinId(skinId);

			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminskins.setAdminId(adminId);

			String dialog = RequestHandler.getString(request, "dialog");
			adminskins.setDialog(dialog);

			String style = RequestHandler.getString(request, "style");
			adminskins.setStyle(style);

			String kkpager = RequestHandler.getString(request, "kkpager");
			adminskins.setKkpager(kkpager);

			// 分页开始
			Integer pageNo = RequestHandler.getPageNo(request, "pageNo");
			Integer rowCount = RequestHandler.getPageSize(request, "rowCount");

			int from = RequestHandler.getFromByPage(pageNo, rowCount);
			adminskins.setRowStart(from);
			adminskins.setRowCount(rowCount);
			// 分页结束
			// 排序
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			adminskins.setSortColumn(sortColumn);

			int adminskinsListCount = adminskinsService.getAdminSkinsListCount(adminskins);
			ResponseList<AdminSkins> adminskinsList = null;
			if (adminskinsListCount > 0) {
				adminskinsList = adminskinsService.getAdminSkinsList(adminskins);
			} else {
				adminskinsList = new ResponseList<AdminSkins>();
			}
			// 设置数据总数
			adminskinsList.setTotalResults(adminskinsListCount);

			writeSuccessMsg("ok", adminskinsList, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}

	@RequestMapping(value = "/getAdminSkinsBaseList", method = RequestMethod.GET)
	public String getAdminSkinsBaseList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminSkins adminskins = new AdminSkins();

			Integer skinId = RequestHandler.getInteger(request, "skinId");
			adminskins.setSkinId(skinId);

			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminskins.setAdminId(adminId);

			String dialog = RequestHandler.getString(request, "dialog");
			adminskins.setDialog(dialog);

			String style = RequestHandler.getString(request, "style");
			adminskins.setStyle(style);

			String kkpager = RequestHandler.getString(request, "kkpager");
			adminskins.setKkpager(kkpager);

			List<AdminSkins> adminskinsList = adminskinsService.getAdminSkinsBaseList(adminskins);

			writeSuccessMsg("ok", adminskinsList, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}

	@RequestMapping(value = "/addAdminSkins", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {

			AdminSkins adminskins = new AdminSkins();

			Integer skinId = RequestHandler.getInteger(request, "skinId");
			adminskins.setSkinId(skinId);
			Integer navgSet = RequestHandler.getInteger(request, "navgSet");
			adminskins.setNavgSet(navgSet);
			Integer navgType = RequestHandler.getInteger(request, "navgType");
			adminskins.setNavgType(navgType);
			// Integer adminId = RequestHandler.getInteger(request, "adminId");

			Integer adminId = Integer.valueOf(request.getSession().getAttribute(SessionName.ADMIN_USER_ID).toString());
			adminskins.setAdminId(adminId);
			
			String dialog = RequestHandler.getString(request, "dialog");
			adminskins.setDialog(dialog);
			String style = RequestHandler.getString(request, "style");
			adminskins.setStyle(style);
			String kkpager = RequestHandler.getString(request, "kkpager");
			adminskins.setKkpager(kkpager);

			adminskinsService.insertAdminSkins(adminskins);

			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}

	@RequestMapping(value = "/saveSkins", method = RequestMethod.POST)
	public String saveSkins(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminSkins adminskins = new AdminSkins();

			Integer adminId = Integer.valueOf(request.getSession().getAttribute(SessionName.ADMIN_USER_ID).toString());
			adminskins.setAdminId(adminId);
			
			AdminSkins adminskins1 = adminskinsService.getAdminSkins(adminskins);
			
			Integer skinId = RequestHandler.getInteger(request, "skinId");
			adminskins.setSkinId(skinId);

			Integer navgSet = RequestHandler.getInteger(request, "navgSet");
			adminskins.setNavgSet(navgSet);
			Integer navgType = RequestHandler.getInteger(request, "navgType");
			adminskins.setNavgType(navgType);

			String dialog = RequestHandler.getString(request, "dialog");
			adminskins.setDialog(dialog);

			String style = RequestHandler.getString(request, "style");
			adminskins.setStyle(style);

			String kkpager = RequestHandler.getString(request, "kkpager");
			adminskins.setKkpager(kkpager);
			
			String skStyle = RequestHandler.getString(request, "skStyle");
			adminskins.setSkStyle(skStyle);
			
			if(adminskins1 == null){
				int skinsId = adminskinsService.insertAdminSkins(adminskins);
				adminskins = new AdminSkins();
				adminskins.setSkinId(skinsId);
				adminskins = adminskinsService.getAdminSkins(adminskins);
			}else{
				adminskins.setSkinId(adminskins1.getSkinId());
				adminskinsService.updateAdminSkins(adminskins);
				adminskins = new AdminSkins();
				adminskins.setSkinId(adminskins1.getSkinId());
				adminskins = adminskinsService.getAdminSkins(adminskins);
			}
			
			if(adminskins!=null){
				if(adminskins.getNavgSet() == null){//1左导航2右导航 默认左导航
					addSession(request, SessionName.SYSTEM_SKINS_NAGSET, "sidebar-left");
				}else{//1左导航2右导航
					if(adminskins.getNavgSet() == 1){
						addSession(request, SessionName.SYSTEM_SKINS_NAGSET, "sidebar-left");
					}else{
						addSession(request, SessionName.SYSTEM_SKINS_NAGSET, "sidebar-right");
					}
				}
			}else{
				addSession(request, SessionName.SYSTEM_SKINS_NAGSET, "sidebar-left");
			}
			request.getSession().setAttribute(SessionName.SYSTEM_SKINS, adminskins);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}
	@RequestMapping(value = "/updateSaveAdminSkins", method = RequestMethod.POST)
	public String updateSaveAdminSkins(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminSkins adminskins = new AdminSkins();
			
			Integer skinId = RequestHandler.getInteger(request, "skinId");
			adminskins.setSkinId(skinId);
			
			Integer navgSet = RequestHandler.getInteger(request, "navgSet");
			adminskins.setNavgSet(navgSet);
			Integer navgType = RequestHandler.getInteger(request, "navgType");
			adminskins.setNavgType(navgType);
			
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminskins.setAdminId(adminId);
			
			String dialog = RequestHandler.getString(request, "dialog");
			adminskins.setDialog(dialog);
			
			String style = RequestHandler.getString(request, "style");
			adminskins.setStyle(style);
			
			String kkpager = RequestHandler.getString(request, "kkpager");
			adminskins.setKkpager(kkpager);
			
			String skStyle = RequestHandler.getString(request, "skStyle");
			adminskins.setSkStyle(skStyle);
			
			if(skinId == null){
				adminskinsService.insertAdminSkins(adminskins);
			}else{
				adminskinsService.updateAdminSkins(adminskins);
			}
			request.getSession().setAttribute(SessionName.SYSTEM_SKINS, adminskins);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}
	@RequestMapping(value = "/updateAdminSkins", method = RequestMethod.POST)
	public String updateAdminSkins(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminSkins adminskins = new AdminSkins();
			
			Integer skinId = RequestHandler.getInteger(request, "skinId");
			adminskins.setSkinId(skinId);
			
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			adminskins.setAdminId(adminId);
			
			Integer navgSet = RequestHandler.getInteger(request, "navgSet");
			adminskins.setNavgSet(navgSet);
			Integer navgType = RequestHandler.getInteger(request, "navgType");
			adminskins.setNavgType(navgType);
			
			String dialog = RequestHandler.getString(request, "dialog");
			adminskins.setDialog(dialog);
			
			String style = RequestHandler.getString(request, "style");
			adminskins.setStyle(style);
			
			String kkpager = RequestHandler.getString(request, "kkpager");
			adminskins.setKkpager(kkpager);
			
			adminskinsService.updateAdminSkins(adminskins);
			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeAdminSkins", method = RequestMethod.POST)
	public String removeAdminSkins(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			AdminSkins adminskins = new AdminSkins();
			Integer skinId = RequestHandler.getInteger(request, "skinId");
			adminskins.setSkinId(skinId);

			adminskinsService.removeAdminSkins(adminskins);
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeAllAdminSkins", method = RequestMethod.POST)
	public String removeAllAdminSkins(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			String skinIds = RequestHandler.getString(request, "skinIds");
			if (skinIds != null) {
				String[] skinIdStr = skinIds.split(",");
				if (skinIdStr != null && skinIdStr.length != 0) {
					for (String skinId : skinIdStr) {
						AdminSkins adminSkins = new AdminSkins();
						adminSkins.setSkinId(Integer.valueOf(skinId));
						adminskinsService.removeAdminSkins(adminSkins);
					}
				}
			}
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e) {
			writeErrorMsg(exception(e), null, response);
		}
		return null;
	}
}
