package com.sys.manageAdminUser.controller;

import java.awt.Color;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.patchca.color.ColorFactory;
import org.patchca.filter.predefined.CurvesRippleFilterFactory;
import org.patchca.filter.predefined.DiffuseRippleFilterFactory;
import org.patchca.filter.predefined.DoubleRippleFilterFactory;
import org.patchca.filter.predefined.MarbleRippleFilterFactory;
import org.patchca.filter.predefined.WobbleRippleFilterFactory;
import org.patchca.service.ConfigurableCaptchaService;
import org.patchca.utils.encoder.EncoderHelper;
import org.patchca.word.RandomWordFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sys.adminRole.model.AdminRole;
import com.sys.adminRole.service.AdminRoleService;
import com.sys.adminRoleColumn.service.AdminRoleColumnService;
import com.sys.adminRoleMethod.model.AdminRoleMethod;
import com.sys.adminRoleMethod.service.AdminRoleMethodService;
import com.sys.adminSkins.model.AdminSkins;
import com.sys.adminSkins.service.AdminSkinsService;
import com.sys.adminUserRole.model.AdminUserRole;
import com.sys.adminUserRole.service.AdminUserRoleService;
import com.sys.manageAdminUser.model.ManageAdminUser;
import com.sys.manageAdminUser.service.ManageAdminUserService;
import com.sys.manageColumn.model.ManageColumn;
import com.sys.manageColumn.service.ManageColumnService;
import com.sys.manageException.model.ManageException;
import com.base.utils.CacheCore;
import com.base.utils.Common;
import com.base.utils.DateFormatToString;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.utils.SessionName;
import com.base.utils.patchca.MyCustomBackgroundFactory;
import com.base.controller.BaseController;

/**
 * @author keeny
 * @time 2015年02月04日 11:09:21
 */
@Controller
@RequestMapping("/manageAdminUser")
public class ManageAdminUserController extends BaseController {

	private static ConfigurableCaptchaService cs = new ConfigurableCaptchaService();
	private static Random random = new Random();

	// private static Logger logger =
	// Logger.getLogger(ManageAdminUserController.class); //Logger
	@Autowired
	private AdminRoleService adminroleService = null;// 角色
	@Autowired
	private AdminUserRoleService adminuserroleService = null;// 用户角色关系
	@Autowired
	private ManageAdminUserService manageadminuserService = null;// 用户
	@Autowired
	private ManageColumnService managecolumnService = null;// 菜单
	@Autowired
	private AdminRoleColumnService adminrolecolumnService = null;// 角色菜单关系表
	@Autowired
	private AdminSkinsService adminskinsService = null;// 风格
	@Autowired
	private AdminRoleMethodService adminrolemethodService = null;//操作权限

	static {
		// cs.setColorFactory(new SingleColorFactory(new Color(25, 60, 170)));
		cs.setColorFactory(new ColorFactory() {
			@Override
			public Color getColor(int x) {
				int[] c = new int[3];
				int i = random.nextInt(c.length);
				for (int fi = 0; fi < c.length; fi++) {
					if (fi == i) {
						c[fi] = random.nextInt(71);
					} else {
						c[fi] = random.nextInt(256);
					}
				}
				return new Color(c[0], c[1], c[2]);
			}
		});
		RandomWordFactory wf = new RandomWordFactory();
		wf.setCharacters("1234567890");
		wf.setMaxLength(4);
		wf.setMinLength(4);
		cs.setWordFactory(wf);
		cs.setBackgroundFactory(new MyCustomBackgroundFactory());
	}

	/***************** 页面中转 *********************/
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String init(HttpServletRequest request, HttpServletResponse response, Model model) {
		AdminRole adminRole = new AdminRole();
		adminRole.setState(1);
		List<AdminRole> roleList = adminroleService.getAdminRoleBaseList(adminRole);
		model.addAttribute("roleList", roleList);
		return "/sys/manageAdminUser/manageAdminUserIndex";
	}
	@RequestMapping(value = "/toUpdatePasswd", method = RequestMethod.GET)
	public String toUpdatePasswd(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/sys/manageAdminUser/updatePasswd";
	}
	/**
	 * 刷新session
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/refreshSession", method = RequestMethod.GET)
	public String refreshSession(HttpServletRequest request, HttpServletResponse response, Model model) {
		this.loginInfo(request);
		writeSuccessMsg("ok", null, response);
		return null;
	}

	@RequestMapping(value = "/toLogin", method = RequestMethod.GET)
	public String toLogin(HttpServletRequest request, HttpServletResponse response, Model model) {
		Object userObj = request.getSession().getAttribute(SessionName.ADMIN_USER);
		if (userObj != null) {
			loginInfo(request);
			return "/sys/main";

		}
		return "/sys/login";
	}

	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/sys/welcome";
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String toMain(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/sys/main";
	}

	@RequestMapping(value = "/toAdd", method = RequestMethod.GET)
	public String toAdd(HttpServletRequest request, HttpServletResponse response, Model model) {

		AdminRole adminRole = new AdminRole();
		adminRole.setState(1);
		List<AdminRole> roleList = adminroleService.getAdminRoleBaseList(adminRole);
		model.addAttribute("roleList", roleList);

		return "/sys/manageAdminUser/manageAdminUserAdd";
	}

	@RequestMapping(value = "/loginout", method = RequestMethod.GET)
	public String loginout(HttpServletRequest request, HttpServletResponse response, Model model) {

		request.getSession().removeAttribute(SessionName.ADMIN_USER_NAME);
		request.getSession().removeAttribute(SessionName.ADMIN_USER_ID);
		request.getSession().removeAttribute(SessionName.ADMIN_USER);

		return "redirect:/manageAdminUser/toLogin";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
//		String toURL = "/manageAdminUser/toLogin";

		ManageAdminUser manageadminuser = new ManageAdminUser();
		String adminName = RequestHandler.getString(request, "adminName");
		manageadminuser.setAdminName(adminName);
		String passwd = RequestHandler.getString(request, "passwd");

		String verify = RequestHandler.getString(request, "verify");

		if (StringUtils.isEmpty(adminName) || StringUtils.isEmpty(passwd) || StringUtils.isEmpty(verify)) {
			writeSuccessMsg("-1", null, response);
			return null;
		}

		Object token = request.getSession().getAttribute(SessionName.TOKEN);// 验证码
		if (token == null || !verify.equalsIgnoreCase(token.toString())) {
			writeSuccessMsg("-2", null, response);
			return null;
		}

		String resutl = null;
		int count = manageadminuserService.getManageAdminUserListCount(manageadminuser);
		if (count == 0) {
			// 没有用户
			resutl = "-3";
		} else if (count == 1) {
			ManageAdminUser adminUser = manageadminuserService.getManageAdminUser(manageadminuser);
			if (adminUser.getPasswd().equals(MD5.getMD5ofStr(passwd))) {
//				toURL = "/manageAdminUser/main";
				// 正常
				request.getSession().setAttribute(SessionName.ADMIN_USER_NAME, adminUser.getAdminName());
				request.getSession().setAttribute(SessionName.ADMIN_USER_ID, adminUser.getAdminId());
				request.getSession().setAttribute(SessionName.ADMIN_USER, adminUser);
				if (adminUser.getLastLogin() != null && !"".equals(adminUser.getLastLogin())) {
					request.getSession().setAttribute(SessionName.ADMIN_USER_LAST_LOGIN, DateFormatToString.getStringByDate(adminUser.getLastLogin()));
				}
				adminUser.setLastLogin(new Date());
				adminUser.setLoginIP(Common.getLocalIp());
				manageadminuserService.updateManageAdminUser(adminUser);
				loginInfo(request);
				resutl = "1";
			} else {
				// 密码错误
				resutl = "-4";
			}
		} else {
			// 多个用户
			resutl = "-5";
		}
		writeSuccessMsg(resutl, null, response);
		return null;
	}

	/**
	 * 注册登录信息
	 * 
	 * @time : 2015年3月6日 下午1:42:17
	 * @param request
	 */
	private void loginInfo(HttpServletRequest request) {

		// --------------------------------根据权限输出菜单
		ManageAdminUser adminUser = (ManageAdminUser) getSession(request, SessionName.ADMIN_USER);
		ManageColumn manageColumn = new ManageColumn();
		manageColumn.setState(1);
		manageColumn.setRoleId(adminUser.getRoleId());
		manageColumn.setParentColumnID(-1);// 一级菜单
		manageColumn.setSortColumn(" columnOrder ASC ");
		List<ManageColumn> parentList = managecolumnService.getManageColumnListByRole(manageColumn);
		for (ManageColumn manageColumn2 : parentList) {
			manageColumn = new ManageColumn();
			manageColumn.setParentColumnID(manageColumn2.getColumnId());
			manageColumn.setState(1);
			manageColumn.setRoleId(adminUser.getRoleId());
			manageColumn.setSortColumn(" columnOrder ASC ");
			List<ManageColumn> childs = managecolumnService.getManageColumnListByRole(manageColumn);// 二级菜单
			manageColumn2.setChilds(childs);
		}
		addSession(request, SessionName.SYSTEM_COLUMN_LIST, parentList);

//		AdminSkins adminSkins = new AdminSkins();
//		adminSkins.setAdminId(adminUser.getAdminId());
//		adminSkins = adminskinsService.getAdminSkins(adminSkins);// 获取风格
		
		AdminRoleMethod adminRoleMethod = new AdminRoleMethod();
		adminRoleMethod.setRoleId(adminUser.getRoleId());
		List<AdminRoleMethod> mlist = adminrolemethodService.getAdminRoleMethodBaseList(adminRoleMethod);
		CacheCore.getInstens().put(SessionName.USER_ROLE_LIST+adminUser.getAdminId(), mlist);
	}

	@RequestMapping(value = "/toSkins", method = RequestMethod.GET)
	public String toSkins(HttpServletRequest request, HttpServletResponse response, Model model) {
		Integer adminId = RequestHandler.getInteger(request, "adminId");
		AdminSkins adminSkins = new AdminSkins();
		adminSkins.setAdminId(adminId);
		AdminSkins adminSkins1 = adminskinsService.getAdminSkins(adminSkins);
		if (adminSkins1 == null) {
			adminSkins1 = new AdminSkins();
		}
		adminSkins1.setAdminId(adminId);

		model.addAttribute("adminSkins", adminSkins1);

		return "/sys/adminSkins/adminSkinsUpdate";
	}

	@RequestMapping(value = "/toUpdate", method = RequestMethod.GET)
	public String toUpdate(HttpServletRequest request, HttpServletResponse response, Model model) {

		Integer adminId = RequestHandler.getInteger(request, "adminId");
		ManageAdminUser manageadminuser1 = new ManageAdminUser();
		manageadminuser1.setAdminId(adminId);
		ManageAdminUser manageadminuser = manageadminuserService.getManageAdminUser(manageadminuser1);
		model.addAttribute("manageadminuser", manageadminuser);

		AdminRole adminRole = new AdminRole();
		adminRole.setState(1);
		List<AdminRole> roleList = adminroleService.getAdminRoleBaseList(adminRole);// 角色列表
		model.addAttribute("roleList", roleList);

		return "/sys/manageAdminUser/manageAdminUserUpdate";
	}

	/**
	 * @time : 2015年2月9日 下午1:51:49
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @Description: 个人中心
	 */
	@RequestMapping(value = "/toUserCenter", method = RequestMethod.GET)
	public String toUserCenter(HttpServletRequest request, HttpServletResponse response, Model model) {
		Object id = request.getSession().getAttribute(SessionName.ADMIN_USER_ID);
		if (id != null) {
			Integer adminId = Integer.valueOf(id.toString());
			ManageAdminUser manageadminuser1 = new ManageAdminUser();
			manageadminuser1.setAdminId(adminId);
			ManageAdminUser manageadminuser = manageadminuserService.getManageAdminUser(manageadminuser1);
			model.addAttribute("manageadminuser", manageadminuser);

			AdminRole adminRole = new AdminRole();
			adminRole.setState(1);
			List<AdminRole> roleList = adminroleService.getAdminRoleBaseList(adminRole);// 角色列表
			model.addAttribute("roleList", roleList);
		} else {
			return "/login";
		}

		return "/sys/manageAdminUser/userCenter";
	}

	/************* Public Methods *************/

	@RequestMapping(value = "/getManageAdminUserList", method = RequestMethod.GET)
	public String getManageAdminUserList(HttpServletRequest request, HttpServletResponse response, Model model) {
		ManageAdminUser manageadminuser = requst2Bean(request,ManageAdminUser.class);
		try {
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			manageadminuser.setAdminId(adminId);
			
			Integer roleId = RequestHandler.getInteger(request, "roleId");
			manageadminuser.setRoleId(roleId);

			String adminName = RequestHandler.getString(request, "adminName");
			if(adminName!=null){
				manageadminuser.setAdminName(URLDecoder.decode(adminName, "UTF-8"));
			}

			String nickName = RequestHandler.getString(request, "nickName");
			if(nickName!=null){
				manageadminuser.setNickName(URLDecoder.decode(nickName, "UTF-8"));
			}

			String passwd = RequestHandler.getString(request, "passwd");
			manageadminuser.setPasswd(passwd);

			String realName = RequestHandler.getString(request, "realName");
			if(realName!=null){
				manageadminuser.setRealName(URLDecoder.decode(realName, "UTF-8"));
			}

			String mobile = RequestHandler.getString(request, "mobile");
			manageadminuser.setMobile(mobile);

			String phone = RequestHandler.getString(request, "phone");
			manageadminuser.setPhone(phone);

			Date lastLogin = RequestHandler.getDate(request, "lastLogin");
			manageadminuser.setLastLogin(lastLogin);

			String loginIP = RequestHandler.getString(request, "loginIP");
			manageadminuser.setLoginIP(loginIP);

			Date pwdModifyTime = RequestHandler.getDate(request, "pwdModifyTime");
			manageadminuser.setPwdModifyTime(pwdModifyTime);

			Integer state = RequestHandler.getInteger(request, "state");
			manageadminuser.setState(state);

			Date createTime = RequestHandler.getDate(request, "createTime");
			manageadminuser.setCreateTime(createTime);

			Integer createrId = RequestHandler.getInteger(request, "createrId");
			manageadminuser.setCreaterId(createrId);

			// 排序
			String sortColumn = RequestHandler.getString(request, "sortColumn");
			manageadminuser.setSortColumn(sortColumn);

			int manageadminuserListCount = manageadminuserService.getManageAdminUserListCount(manageadminuser);
			ResponseList<ManageAdminUser> manageadminuserList = null;
			if (manageadminuserListCount > 0) {
				manageadminuserList = manageadminuserService.getManageAdminUserList(manageadminuser);
			} else {
				manageadminuserList = new ResponseList<ManageAdminUser>();
			}
			// 设置数据总数
			manageadminuserList.setTotalResults(manageadminuserListCount);

			writeSuccessMsg("ok", manageadminuserList, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/getManageAdminUserBaseList", method = RequestMethod.GET)
	public String getManageAdminUserBaseList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageAdminUser manageadminuser = new ManageAdminUser();

			Integer adminId = RequestHandler.getInteger(request, "adminId");
			manageadminuser.setAdminId(adminId);

			String adminName = RequestHandler.getString(request, "adminName");
			manageadminuser.setAdminName(adminName);

			String nickName = RequestHandler.getString(request, "nickName");
			manageadminuser.setNickName(nickName);

			String passwd = RequestHandler.getString(request, "passwd");
			manageadminuser.setPasswd(passwd);

			String realName = RequestHandler.getString(request, "realName");
			manageadminuser.setRealName(realName);

			String mobile = RequestHandler.getString(request, "mobile");
			manageadminuser.setMobile(mobile);

			String phone = RequestHandler.getString(request, "phone");
			manageadminuser.setPhone(phone);

			Date lastLogin = RequestHandler.getDate(request, "lastLogin");
			manageadminuser.setLastLogin(lastLogin);

			String loginIP = RequestHandler.getString(request, "loginIP");
			manageadminuser.setLoginIP(loginIP);

			Date pwdModifyTime = RequestHandler.getDate(request, "pwdModifyTime");
			manageadminuser.setPwdModifyTime(pwdModifyTime);

			Integer state = RequestHandler.getInteger(request, "state");
			manageadminuser.setState(state);

			Date createTime = RequestHandler.getDate(request, "createTime");
			manageadminuser.setCreateTime(createTime);

			Integer createrId = RequestHandler.getInteger(request, "createrId");
			manageadminuser.setCreaterId(createrId);

			List<ManageAdminUser> manageadminuserList = manageadminuserService.getManageAdminUserBaseList(manageadminuser);

			writeSuccessMsg("ok", manageadminuserList, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/addManageAdminUser", method = RequestMethod.POST)
	public String addUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {

			ManageAdminUser manageadminuser = new ManageAdminUser();

			String adminName = RequestHandler.getString(request, "adminName");
			manageadminuser.setAdminName(adminName);
			String nickName = RequestHandler.getString(request, "nickName");
			manageadminuser.setNickName(nickName);
			String passwd = RequestHandler.getString(request, "passwd");
			manageadminuser.setPasswd(MD5.getMD5ofStr(passwd));
			String realName = RequestHandler.getString(request, "realName");
			manageadminuser.setRealName(realName);
			String mobile = RequestHandler.getString(request, "mobile");
			manageadminuser.setMobile(mobile);
			String phone = RequestHandler.getString(request, "phone");
			manageadminuser.setPhone(phone);
			String headImg = RequestHandler.getString(request, "headImg");
			manageadminuser.setHeadImg(headImg);
			Date lastLogin = RequestHandler.getDate(request, "lastLogin");
			manageadminuser.setLastLogin(lastLogin);
			String loginIP = RequestHandler.getString(request, "loginIP");
			manageadminuser.setLoginIP(loginIP);
			Date pwdModifyTime = RequestHandler.getDate(request, "pwdModifyTime");
			manageadminuser.setPwdModifyTime(pwdModifyTime);
			Integer state = RequestHandler.getInteger(request, "state");
			manageadminuser.setState(state);
			// Date createTime = RequestHandler.getDate(request, "createTime");
			manageadminuser.setCreateTime(new Date());
			// Integer createrId = RequestHandler.getInteger(request,
			// "createrId");
			manageadminuser.setCreaterId(Integer.valueOf(request.getSession().getAttribute(SessionName.ADMIN_USER_ID).toString()));

			Integer roleId = RequestHandler.getInteger(request, "roleId");

			ManageAdminUser manageadminuser1 = new ManageAdminUser();
			manageadminuser1.setAdminName(adminName);
			int count = manageadminuserService.getManageAdminUserListCount(manageadminuser1);// 用户名验证
			if (count != 0) {
				writeErrorMsg("用户名不能重复", null, response);
				return null;
			}

			Integer adminId = manageadminuserService.insertManageAdminUser(manageadminuser);

			if (roleId != null) {
				AdminUserRole adminUserRole = new AdminUserRole();
				adminUserRole.setAdminId(adminId);
				AdminUserRole adminUserRole2 = adminuserroleService.getAdminUserRole(adminUserRole);
				adminUserRole.setRoleId(roleId);
				if (adminUserRole2 == null) {
					adminuserroleService.insertAdminUserRole(adminUserRole);
				} else {
					adminUserRole2.setRoleId(roleId);
					adminuserroleService.updateAdminUserRole(adminUserRole2);
				}
			}

			writeSuccessMsg("添加成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	/**
	 * 
	 * @time : 2015年2月9日 下午2:18:27
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @Description: 用于保存个人用户页面信息
	 */
	@RequestMapping(value = "/saveManageAdminUser", method = RequestMethod.POST)
	public String saveManageAdminUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageAdminUser manageadminuser = new ManageAdminUser();

			Integer adminId = Integer.valueOf(getSession(request, SessionName.ADMIN_USER_ID).toString());
			manageadminuser.setAdminId(adminId);

			String adminName = RequestHandler.getString(request, "adminName");
			manageadminuser.setAdminName(adminName);

			String nickName = RequestHandler.getString(request, "nickName");
			if (nickName != null) {
				nickName = URLDecoder.decode(nickName, "UTF-8");
				manageadminuser.setNickName(nickName);
			}

			String realName = RequestHandler.getString(request, "realName");

			if (realName != null) {
				realName = URLDecoder.decode(realName, "UTF-8");
				manageadminuser.setRealName(realName);
			}

			String mobile = RequestHandler.getString(request, "mobile");
			manageadminuser.setMobile(mobile);

			String phone = RequestHandler.getString(request, "phone");
			manageadminuser.setPhone(phone);

			Date lastLogin = RequestHandler.getDate(request, "lastLogin");
			manageadminuser.setLastLogin(lastLogin);

			String loginIP = RequestHandler.getString(request, "loginIP");
			manageadminuser.setLoginIP(loginIP);

			Date pwdModifyTime = RequestHandler.getDate(request, "pwdModifyTime");
			manageadminuser.setPwdModifyTime(pwdModifyTime);

			Integer state = RequestHandler.getInteger(request, "state");
			manageadminuser.setState(state);

			Date createTime = RequestHandler.getDate(request, "createTime");
			manageadminuser.setCreateTime(createTime);

			Integer createrId = RequestHandler.getInteger(request, "createrId");
			manageadminuser.setCreaterId(createrId);

			String headImg = RequestHandler.getString(request, "headImg");
			manageadminuser.setHeadImg(headImg);

			// Integer roleId = RequestHandler.getInteger(request, "roleId");

			manageadminuserService.updateManageAdminUser(manageadminuser);
			manageadminuser = new ManageAdminUser();
			manageadminuser.setAdminId(adminId);

			ManageAdminUser adminUser = manageadminuserService.getManageAdminUser(manageadminuser);
			writeSuccessMsg("更新成功", null, response);

			request.getSession().setAttribute(SessionName.ADMIN_USER, adminUser);
			loginInfo(request);

		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/updateManageAdminUser", method = RequestMethod.POST)
	public String updateManageAdminUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageAdminUser manageadminuser = new ManageAdminUser();

			Integer adminId = RequestHandler.getInteger(request, "adminId");
			manageadminuser.setAdminId(adminId);

			String adminName = RequestHandler.getString(request, "adminName");
			manageadminuser.setAdminName(adminName);

			ManageAdminUser manageadminuser1 = new ManageAdminUser();
			manageadminuser1.setAdminName(adminName);
			List<ManageAdminUser> userList = manageadminuserService.getManageAdminUserBaseList(manageadminuser1);// 用户名验证
			if (userList != null && userList.size() != 0) {
				boolean b = false;
				for (ManageAdminUser manageAdminUser2 : userList) {
					if(!manageAdminUser2.getAdminId().equals(adminId)){
						b = true;
						break;
					}
				}
				if(b){
					writeErrorMsg("用户名不能重复", null, response);
					return null;
				}
			}
			
			String nickName = RequestHandler.getString(request, "nickName");
			manageadminuser.setNickName(nickName);

			String realName = RequestHandler.getString(request, "realName");
			manageadminuser.setRealName(realName);

			String mobile = RequestHandler.getString(request, "mobile");
			manageadminuser.setMobile(mobile);

			String phone = RequestHandler.getString(request, "phone");
			manageadminuser.setPhone(phone);

			Date lastLogin = RequestHandler.getDate(request, "lastLogin");
			manageadminuser.setLastLogin(lastLogin);

			String loginIP = RequestHandler.getString(request, "loginIP");
			manageadminuser.setLoginIP(loginIP);

			Date pwdModifyTime = RequestHandler.getDate(request, "pwdModifyTime");
			manageadminuser.setPwdModifyTime(pwdModifyTime);

			Integer state = RequestHandler.getInteger(request, "state");
			manageadminuser.setState(state);

			Date createTime = RequestHandler.getDate(request, "createTime");
			manageadminuser.setCreateTime(createTime);

			Integer createrId = RequestHandler.getInteger(request, "createrId");
			manageadminuser.setCreaterId(createrId);

			String headImg = RequestHandler.getString(request, "headImg");
			manageadminuser.setHeadImg(headImg);

			Integer roleId = RequestHandler.getInteger(request, "roleId");

			if (roleId != null) {
				AdminUserRole adminUserRole = new AdminUserRole();
				adminUserRole.setAdminId(adminId);
				AdminUserRole adminUserRole2 = adminuserroleService.getAdminUserRole(adminUserRole);
				adminUserRole.setRoleId(roleId);
				if (adminUserRole2 == null) {
					adminuserroleService.insertAdminUserRole(adminUserRole);
				} else {
					adminUserRole2.setRoleId(roleId);
					adminuserroleService.updateAdminUserRole(adminUserRole2);
				}
			}
			manageadminuserService.updateManageAdminUser(manageadminuser);

			manageadminuser = new ManageAdminUser();
			manageadminuser.setAdminId(adminId);

			ManageAdminUser adminUser = manageadminuserService.getManageAdminUser(manageadminuser);
			String passwd = RequestHandler.getString(request, "passwd");
			if (StringUtils.isNotBlank(passwd) && !adminUser.getPasswd().equals(passwd)) {// 密码已修改
				manageadminuser.setPasswd(MD5.getMD5ofStr(passwd));
				manageadminuser.setPwdModifyTime(new Date());
				manageadminuserService.updateManageAdminUser(manageadminuser);
			}

			Object sessionUserId = request.getSession().getAttribute(SessionName.ADMIN_USER_ID);
			if (adminId.equals(sessionUserId.toString())) {
//				request.getSession().setAttribute(SessionName.ADMIN_USER, adminUser);
			}

			writeSuccessMsg("修改成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}
	@RequestMapping(value = "/updatePasswd", method = RequestMethod.POST)
	public String updatePasswd(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageAdminUser manageadminuser = new ManageAdminUser();
			
			Integer adminId = Integer.valueOf(getSession(request, SessionName.ADMIN_USER_ID).toString());
			manageadminuser.setAdminId(adminId);
			
			String passwd = RequestHandler.getString(request, "passwd");
			String newPasswd = RequestHandler.getString(request, "newPasswd");
			String rPasswd = RequestHandler.getString(request, "rPasswd");
			
			if(StringUtils.isNotBlank(passwd) && StringUtils.isNotBlank(newPasswd) && StringUtils.isNotBlank(rPasswd)){
				if(newPasswd.equals(rPasswd)){
					ManageAdminUser manageadminuser1 = manageadminuserService.getManageAdminUser(manageadminuser);
					
					if(manageadminuser1.getPasswd().equals(MD5.getMD5ofStr(passwd))){
						manageadminuser.setPasswd(MD5.getMD5ofStr(newPasswd));
						manageadminuserService.updateManageAdminUser(manageadminuser);
						writeSuccessMsg("修改成功", null, response);
						
					}else{
						writeErrorMsg("原始密码不正确", null, response);
					}
				}else{
					writeErrorMsg("新密码不一致", null, response);
				}
			}else{
				writeErrorMsg("密码不能为空", null, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeManageAdminUser", method = RequestMethod.POST)
	public String removeManageAdminUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			ManageAdminUser manageadminuser = new ManageAdminUser();
			Integer adminId = RequestHandler.getInteger(request, "adminId");
			manageadminuser.setAdminId(adminId);

			manageadminuserService.removeManageAdminUser(manageadminuser);
			writeSuccessMsg("删除成功", null, response);
		} catch (Exception e) {
			e.printStackTrace();
			writeErrorMsg("系统异常", null, response);
		}
		return null;
	}

	@RequestMapping(value = "/removeAllManageAdminUser", method = RequestMethod.POST)
	public String removeAllManageAdminUser(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			String adminIds = RequestHandler.getString(request, "adminIds");
			if (adminIds != null) {
				String[] adminIdStr = adminIds.split(",");
				if (adminIdStr != null && adminIdStr.length != 0) {
					for (String adminId : adminIdStr) {
						ManageAdminUser manageAdminUser = new ManageAdminUser();
						manageAdminUser.setAdminId(Integer.valueOf(adminId));
						manageadminuserService.removeManageAdminUser(manageAdminUser);
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

	@RequestMapping("/pcrimg")
	public void crimg(HttpServletRequest request, HttpServletResponse response) throws IOException {
		switch (random.nextInt(5)) {
		case 0:
			cs.setFilterFactory(new CurvesRippleFilterFactory(cs.getColorFactory()));
			break;
		case 1:
			cs.setFilterFactory(new MarbleRippleFilterFactory());
			break;
		case 2:
			cs.setFilterFactory(new DoubleRippleFilterFactory());
			break;
		case 3:
			cs.setFilterFactory(new WobbleRippleFilterFactory());
			break;
		case 4:
			cs.setFilterFactory(new DiffuseRippleFilterFactory());
			break;
		}
		HttpSession session = request.getSession(false);
		if (session == null) {
			session = request.getSession();
		}
		setResponseHeaders(response);
		String token = EncoderHelper.getChallangeAndWriteImage(cs, "png", response.getOutputStream());
		session.setAttribute(SessionName.TOKEN, token);
	}

	protected void setResponseHeaders(HttpServletResponse response) {
		response.setContentType("image/png");
		response.setHeader("Cache-Control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		long time = System.currentTimeMillis();
		response.setDateHeader("Last-Modified", time);
		response.setDateHeader("Date", time);
		response.setDateHeader("Expires", time);
	}
}
