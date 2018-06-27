package com.wx.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.jsms.api.JSMSClient;
import cn.jsms.api.SendSMSResult;
import cn.jsms.api.common.model.SMSPayload;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.base.controller.BaseController;
import com.base.utils.ConfigConstants;
import com.base.utils.MatrixUtil;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.utils.SessionName;
import com.sys.manageAdminUser.model.ManageAdminUser;
import com.sys.manageAdminUser.service.ManageAdminUserService;
import com.wx.service.WeiXinService;
import com.wx.utils.WxMenuUtils;
import com.wx.x0001.WeiXin;
import com.wx.x0001.vo.recv.WxRecvEventMsg;
import com.wx.x0001.vo.recv.WxRecvMsg;
import com.wx.x0001.vo.recv.WxRecvTextMsg;
import com.wx.x0001.vo.send.WxSendMsg;
import com.wx.x0001.vo.send.WxSendNewsMsg;
import com.wx.x0001.vo.send.WxSendNewsMsgItem;
import com.wx.x0001.vo.send.WxSendTextMsg;
import com.yy.apiController.controller.UserApiController;
import com.yy.yyCompany.model.YyCompany;
import com.yy.yyCompany.service.YyCompanyService;
import com.yy.yyCourse.model.YyCourse;
import com.yy.yyCourse.service.YyCourseService;
import com.yy.yyCourseAppendix.model.YyCourseAppendix;
import com.yy.yyCourseAppendix.service.YyCourseAppendixService;
import com.yy.yyCourseClassify.model.YyCourseClassify;
import com.yy.yyCourseClassify.service.YyCourseClassifyService;
import com.yy.yyUser.model.YyUser;
import com.yy.yyUser.service.YyUserService;
import com.yy.yyUserCourse.model.YyUserCourse;
import com.yy.yyUserCourse.service.YyUserCourseService;
import com.yy.yyUserStudy.model.YyUserStudy;
import com.yy.yyUserStudy.service.YyUserStudyService;

@Controller
@RequestMapping("/weixin")
public class WeiXinController extends BaseController{
	
	Logger log = Logger.getLogger(WeiXinController.class);
	
	@Autowired
	private WeiXinService weiXinService;
	@Autowired
	private ManageAdminUserService manageadminuserService = null;// 用户
	@Autowired
	private YyUserService yyuserService = null;
	@Autowired
	private YyCourseClassifyService yycourseclassifyService = null;
	@Autowired
	private YyUserCourseService yyusercourseService = null;
	@Autowired
	private YyCourseService yycourseService = null;
	@Autowired
	private YyCourseAppendixService yycourseappendixService = null;
	@Autowired
	private YyUserStudyService yyuserstudyService = null;
	@Autowired
	private YyCompanyService yycompanyService = null;
	
	
	@RequestMapping("/access")
	public String weixin(HttpServletResponse response,
			HttpServletRequest request) {
		String signature = request.getParameter("signature");
		String timestamp = request.getParameter("timestamp");
		String nonce = request.getParameter("nonce");
		String echostr = request.getParameter("echostr");

		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String appid = request.getParameter("appid");
		// 验证接口配置消息的时候会调用
		if (null != timestamp && null != nonce && null != echostr
				&& null != signature) {
			if (WeiXin.access(ConfigConstants.TOKEN, signature, timestamp, nonce)) {
				try {
					PrintWriter writer = response.getWriter();
					writer.print(echostr);
					writer.flush();
					writer.close();
					return null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println("--------------->"+appid);
		if (StringUtils.isNotBlank(code)) {
			try {
				String access_token = WxMenuUtils.getAccessCode(ConfigConstants.APPID, ConfigConstants.APPSECRET, code);
				JSONObject json = JSONObject.parseObject(access_token);
				String openId = json.getString("openid");
				System.out.println("------------openId--------------"+openId);
				request.setAttribute("openId", openId);
				request.getSession().setAttribute("session_openId", openId);
				String states[] = state.split("_");
				if("c".equals(states[0])){//boss注册
					return  "redirect:/yyUser/toReg?openId="+ openId + "&company_id="+states[1];
				}else if("a".equals(states[0])){//员工注册
					return  "redirect:/yyUser/toReg?openId="+ openId + "&company_id="+states[1] + "&parent_id=" + states[2];
				}
				boolean b = weiXinService.isBind(openId, request);
				if(b){
					if("learn".equals(states[0])){//学习
						return  "redirect:/weixin/toLearn?openId="+ openId;
					}else if("course".equals(states[0])){//课程
						return  "redirect:/weixin/toCourse?openId="+ openId;
					}else if("myinfo".equals(states[0])){//个人中心
						return  "redirect:/weixin/toMyInfo?openId="+ openId;
					}else if("mycode".equals(states[0])){//我的二维码
						return  "redirect:/weixin/toMyCode?openId="+ openId ;
					}
				}else{
					return  "redirect:/weixin/toLogin?openId="+ openId ;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (null != timestamp && null != nonce && null != signature) {
			if (WeiXin.access(ConfigConstants.TOKEN, signature, timestamp, nonce)) {// 验证消息的真实性
				try {
					WxRecvMsg msg = WeiXin.recv(request.getInputStream());
					WxSendMsg sendMsg = WeiXin.builderSendByRecv(msg);
					String openId = msg.getFromUser();
					if (msg instanceof WxRecvEventMsg) {
						WxRecvEventMsg m = (WxRecvEventMsg) msg;
						String event = m.getEvent();
						boolean xx = true;
						if ("subscribe".equals(event)) {
							String content = "";
							sendMsg = new WxSendTextMsg(sendMsg, content);
						}else if("unsubscribe".equals(event)){//取消关注
							//解除绑定
//							weiXinService.unBindWx(openId);
						}else if("CLICK".equals(event)){
							System.out.println("---------------"+m.getEventKey());
							if("BM".equals(m.getEventKey())){
								String content = "即将开通此服务，敬请期待。";
								sendMsg = new WxSendTextMsg(sendMsg, content);
							}else if("SC".equals(m.getEventKey())){
								String content = "即将开通此服务，敬请期待。";
								sendMsg = new WxSendTextMsg(sendMsg, content);
							}
						}else if("SCAN".equals(event)){
							String ticket = m.getTicket();
							String content = "";
							sendMsg = new WxSendTextMsg(sendMsg, content);
						}else if("LOCATION".equals(event)){
							String str = weiXinService.getBaiDuLocationXY(m.getLatitude(),m.getLongitude());
						}
						WeiXin.send(sendMsg, response.getOutputStream());
					}else if(msg instanceof WxRecvTextMsg){
						WxRecvTextMsg m = (WxRecvTextMsg) msg;
						String content =  m.getContent();
						String basepath = request.getSession().getServletContext().getRealPath("/");
						if(content.contains("合作")){//机构验证
							sendMsg = new WxSendTextMsg(sendMsg, "您的帐号已被暂停，如有疑问，请拨打96199咨询。");
							WeiXin.send(sendMsg, response.getOutputStream());
						}
					}
				} catch (Exception e) {
					log.info(exception(e));
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	
	/**
	 * 解除绑定
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/unBind", method = RequestMethod.POST)
	public String unBind(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		try{
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			yyuserService.unBind(yyUser);
			request.getSession().removeAttribute(SessionName.ADMIN_USER_NAME);
			request.getSession().removeAttribute(SessionName.ADMIN_USER_ID);
			request.getSession().removeAttribute(SessionName.ADMIN_USER);
			json.put("c", 0);
		}catch(Exception e){
			json.put("c", -1);
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return  null;
	}
	/**
	 * 测试
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toSetting", method = RequestMethod.GET)
	public String toSetting(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		super.getJsticket(request);
		return  "/wx/set";
	}
	
	/**
	 * 删除学习任务
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/delLearnTask", method = RequestMethod.POST)
	public String delLearnTask(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		super.getJsticket(request);
		Long userCourseId = RequestHandler.getLong(request, "userCourseId");
		JSONObject json = new JSONObject();
		try{
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			YyUserCourse yyUserCourse = new YyUserCourse();
			yyUserCourse.setId(userCourseId);
			List<YyUserCourse> list = yyusercourseService.getYyUserCourseParent(yyUserCourse);
			if(list!=null&&list.size()>0){
				yyUserCourse = list.get(0);
				//查询课程分配人员
				YyUserCourse usercourse = new YyUserCourse();
				usercourse.setCourse_classify_id(yyUserCourse.getCourse_classify_id());
				usercourse.setUser_parent_id(yyUser.getId());
				usercourse.setStyle(0);
				List<YyUserCourse> listU = yyusercourseService.getStudyUser(usercourse);
				if(listU!=null&&listU.size()>0){
					for(YyUserCourse u:listU){
						yyusercourseService.removeYyUserCourse(u);
					}
				}
				json.put("c", 0);
			}
		}catch(Exception e){
			json.put("c", -1);
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return  null;
	}
	
	/**
	 * 删除学习任务
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateLearnTask", method = RequestMethod.POST)
	public String updateLearnTask(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		super.getJsticket(request);
		Long userCourseId = RequestHandler.getLong(request, "userCourseId");
		String over_time = RequestHandler.getString(request, "over_time");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		JSONObject json = new JSONObject();
		try{
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			YyUserCourse yyUserCourse = new YyUserCourse();
			yyUserCourse.setId(userCourseId);
			List<YyUserCourse> list = yyusercourseService.getYyUserCourseParent(yyUserCourse);
			if(list!=null&&list.size()>0){
				yyUserCourse = list.get(0);
				//查询课程分配人员
				YyUserCourse usercourse = new YyUserCourse();
				usercourse.setCourse_classify_id(yyUserCourse.getCourse_classify_id());
				usercourse.setUser_parent_id(yyUser.getId());
				usercourse.setStyle(0);
				List<YyUserCourse> listU = yyusercourseService.getStudyUser(usercourse);
				if(listU!=null&&listU.size()>0){
					for(YyUserCourse u:listU){
						u.setOver_time(sf.parse(over_time));
						yyusercourseService.updateYyUserCourse(u);
					}
				}
				json.put("c", 0);
			}
		}catch(Exception e){
			json.put("c", -1);
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return  null;
	}
	
	/**
	 * 编辑学习任务
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toLearnTask", method = RequestMethod.GET)
	public String toLearnTask(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		super.getJsticket(request);
		Long userCourseId = RequestHandler.getLong(request, "userCourseId");
		String over_time = RequestHandler.getString(request, "over_time");
		try{
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			YyUserCourse yyUserCourse = new YyUserCourse();
			yyUserCourse.setId(userCourseId);
			List<YyUserCourse> list = yyusercourseService.getYyUserCourseParent(yyUserCourse);
			if(list!=null&&list.size()>0){
				yyUserCourse = list.get(0);
				//查询课程分配人员
				YyUserCourse usercourse = new YyUserCourse();
				usercourse.setCourse_classify_id(yyUserCourse.getCourse_classify_id());
				usercourse.setUser_parent_id(yyUser.getId());
				usercourse.setStyle(0);
				List<YyUserCourse> listU = yyusercourseService.getStudyUser(usercourse);
				model.addAttribute("yyUserCourse", yyUserCourse);
				model.addAttribute("listU", listU);
				model.addAttribute("over_time", over_time);
				model.addAttribute("userCourseId", userCourseId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return  "/wx/updateTeamLesson";
	}
	
	/**
	 * 测试
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		String openId = RequestHandler.getString(request, "openId");
//		weiXinService.isBind(openId, request);
		super.getJsticket(request);
		
		
		return  "/wx/test2";
	}
	
	/**
	 * 团队管理-课程管理
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toTeamLessonList", method = RequestMethod.GET)
	public String toTeamLessonList(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		try{
			super.getJsticket(request);
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			//查询用户下属所有课程
			YyUserCourse yyUserCourse = new YyUserCourse();
			yyUserCourse.setUser_parent_id(yyUser.getId());
			yyUserCourse.setStyle(0);
			List<YyUserCourse> listC = yyusercourseService.getYyUserCourseByUser(yyUserCourse);
			if(listC!=null&&listC.size()>0){
				for(YyUserCourse uc:listC){
					//最后riqi 
					YyUserCourse usercourseLast = new YyUserCourse();
					usercourseLast.setCourse_classify_id(uc.getCourse_classify_id());
					usercourseLast.setUser_parent_id(yyUser.getId());
					usercourseLast.setStyle(0);
					usercourseLast.setSortColumn("a.over_time desc");
					List<YyUserCourse> listULast = yyusercourseService.getYyUserCourseBaseList(usercourseLast);
					if(listULast!=null&&listULast.size()>0){
						YyUserCourse lastUser = listULast.get(0);
						if(lastUser.getOver_time()!=null){
							uc.setOverDays(yyusercourseService.differentDays(new Date(), lastUser.getOver_time()));
							uc.setOver_time(lastUser.getOver_time());
						}
					}else{
						uc.setOverDays(0);
					}
					//查询课程分配人员
					YyUserCourse usercourse = new YyUserCourse();
					usercourse.setCourse_classify_id(uc.getCourse_classify_id());
					usercourse.setUser_parent_id(yyUser.getId());
					usercourse.setStyle(0);
					List<YyUserCourse> listU = yyusercourseService.getStudyUser(usercourse);
					if(listU!=null&&listU.size()>0){
						uc.setListUC(listU);
						uc.setCount(listU.size());
					}else{
						uc.setCount(0);
					}
				}
			}
			model.addAttribute("listC", listC);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "myinfo");
		return  "/wx/teamLesson";
	}
	
	/**
	 * 团队管理-数据统计
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toTeamAnalytics", method = RequestMethod.GET)
	public String toTeamAnalytics(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		try{
			super.getJsticket(request);
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			//查询用户下属
			YyUser yyUserChild = new YyUser();
			yyUserChild.setParent_id(yyUser.getId());
			List<YyUser> listChild = yyuserService.getYyUserBaseList(yyUserChild);
			String user_names = null;
			String study_times = null;
			String course_counts = null;
			if(listChild!=null&&listChild.size()>0){
				for(YyUser child:listChild){
					if(user_names==null){
						user_names = "'" + child.getName() + "'";
					}else{
						user_names = user_names + ",'" + child.getName() + "'";
					}
					//查询学习时间
					YyUserStudy yyUserStudy = new YyUserStudy();
					yyUserStudy.setUser_id(child.getId());
					int study_time = yyuserstudyService.getUserStudyTime(yyUserStudy);
					child.setStudy_time(RequestHandler.secToTime(study_time));
					if(study_times==null){
						study_times = RequestHandler.secToTime(study_time) + "";
					}else{
						study_times = study_times + "," +RequestHandler.secToTime(study_time);
					}
					//计算完成课程数量
					YyUserCourse yyUserCourse = new YyUserCourse();
					yyUserCourse.setUser_id(child.getId());
					yyUserCourse.setStyle(0);
					List<YyUserCourse> list = yyusercourseService.getUserStudyList(yyUserCourse);
					Set<Long> set = new HashSet<Long>();
					int lessonCount = 0;
					int lessonCounting = 0;
					if(list!=null&&list.size()>0){
						for(YyUserCourse uc:list){
							set.add(uc.getCourse_classify_id());
						}
						Iterator<Long> it = set.iterator();
						while(it.hasNext()){
							Long lessonId = it.next();
							boolean b = true;
							for(YyUserCourse uc:list){
								if(lessonId.intValue()==uc.getCourse_classify_id().intValue()&&uc.getStudy_state().intValue()!=1){
									b = false;
									break;
								}
							}
							if(b){
								lessonCount = lessonCount + 1;
							}
						}
						lessonCounting = list.size() - lessonCount;
						child.setLesson_count(list.size());
						if(course_counts==null){
							course_counts = "" + list.size();
						}else{
							course_counts = course_counts + "," + list.size();
						}
					}else{
						if(course_counts==null){
							course_counts = "" + 0;
						}else{
							course_counts = course_counts + "," + 0;
						}
						child.setLesson_count(0);
					}
					//计算完成课程数量结束
					child.setStudied_count(lessonCount);
					child.setStuding_count(lessonCounting);
				}
			}
			model.addAttribute("listChild", listChild);
			model.addAttribute("user_names", user_names);
			model.addAttribute("study_times", study_times);
			model.addAttribute("course_counts", course_counts);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "myinfo");
		return  "/wx/team";
	}
	
	/**
	 * 修改用户头像
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/updateAvatar", method = RequestMethod.POST)
	public String updateAvatar(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		String avatarUrl = RequestHandler.getString(request, "avatarUrl");
		try{
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			YyUser yyUser1= new YyUser();
			yyUser1.setId(yyUser.getId());
			yyUser1.setHead_img(avatarUrl);
			yyuserService.updateYyUser(yyUser1);
			yyUser.setHead_img(avatarUrl);
			request.getSession().setAttribute(SessionName.ADMIN_USER, yyUser);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 学习记录
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toStudyRecord", method = RequestMethod.GET)
	public String toStudyRecord(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		try{
			super.getJsticket(request);
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			YyUserStudy yyUserStudy = new YyUserStudy();
			yyUserStudy.setUser_id(yyUser.getId());
			List<YyUserStudy> list = yyuserstudyService.getYyUserStudyByLesson(yyUserStudy);
			if(list!=null&&list.size()>0){
				for(YyUserStudy uc:list){
					YyCourseClassify yyCourseClassify = new YyCourseClassify();
					yyCourseClassify.setId(uc.getLesson_id());
					yyCourseClassify = yycourseclassifyService.getYyCourseClassify(yyCourseClassify);
					uc.setImg_url(yyCourseClassify.getImg_url());
					//查询最后一次学习时间
					YyUserStudy yyUserStudy1 = new YyUserStudy();
					yyUserStudy1.setUser_id(yyUser.getId());
					yyUserStudy1.setLesson_id(uc.getLesson_id());
					yyUserStudy1.setRowCount(1);
					yyUserStudy1.setRowStart(0);
					yyUserStudy1.setSortColumn("a.create_time desc");
					ResponseList<YyUserStudy> listStudy = yyuserstudyService.getYyUserStudyList(yyUserStudy1);
					if(listStudy!=null&&listStudy.size()>0){
						Iterator<Object> it = listStudy.iterator();
						while(it.hasNext()){
							yyUserStudy = (YyUserStudy)it.next();
						}
					}
					if(yyUserStudy!=null&&yyUserStudy.getId()!=null){
						uc.setLastStudyTime(yyusercourseService.differentDays(yyUserStudy.getCreate_time(), new Date()));
					}
					//查询下面知识点
					YyCourse yyCourse = new YyCourse();
					yyCourse.setClassify_id(uc.getLesson_id());
					List<YyCourse> listC = yycourseService.getYyCourseBaseList(yyCourse);
					uc.setListCourse(listC);
					//查询下面附件
					YyCourseAppendix yyCourseAppendix = new YyCourseAppendix();
					yyCourseAppendix.setClassify_id(uc.getLesson_id());
					List<YyCourseAppendix> listCA = yycourseappendixService.getYyCourseAppendixBaseList(yyCourseAppendix);
					uc.setListAppendix(listCA);
				}
			}
			model.addAttribute("list", list);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "myinfo");
		return  "/wx/studyRecord";
	}
	
	/**
	 * 个人中心
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toMyInfo", method = RequestMethod.GET)
	public String toMyInfo(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		try{
			super.getJsticket(request);
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			//计算学习总时长
			YyUserStudy yyUserStudy = new YyUserStudy();
			yyUserStudy.setUser_id(yyUser.getId());
			int study_time = yyuserstudyService.getUserStudyTime(yyUserStudy);
			model.addAttribute("studyTimeCount", RequestHandler.secToTime(study_time));
			//计算完成课程数量
			YyUserCourse yyUserCourse = new YyUserCourse();
			yyUserCourse.setUser_id(yyUser.getId());
			List<YyUserCourse> list = yyusercourseService.getUserStudyList(yyUserCourse);
			Set<Long> set = new HashSet<Long>();
			int lessonCount = 0;
			if(list!=null&&list.size()>0){
				for(YyUserCourse uc:list){
					set.add(uc.getCourse_classify_id());
				}
				Iterator<Long> it = set.iterator();
				while(it.hasNext()){
					Long lessonId = it.next();
					boolean b = true;
					for(YyUserCourse uc:list){
						if(lessonId.intValue()==uc.getCourse_classify_id().intValue()&&uc.getStudy_state().intValue()!=1){
							b = false;
							break;
						}
					}
					if(b){
						lessonCount = lessonCount + 1;
					}
				}
			}
			//计算完成课程数量结束
			model.addAttribute("lessonCount", lessonCount);
			model.addAttribute("feedbackCount", 0);
			model.addAttribute("powerCount", 0);
			//同级小伙伴数据
			YyUser yyUser1 = new YyUser();
			yyUser1.setParent_id(yyUser.getParent_id());
			yyUser1.setUser_id(yyUser.getId());
			List<YyUser> listUser = yyuserService.getYyUserBaseList(yyUser1);
			JSONArray array = new JSONArray();
			if(listUser!=null&&listUser.size()>0){
				for(YyUser u:listUser){
					//计算学习总时长
					YyUserStudy yyUserStudyOther = new YyUserStudy();
					yyUserStudyOther.setUser_id(yyUser.getId());
					int study_time_other = yyuserstudyService.getUserStudyTime(yyUserStudyOther);
					JSONObject jsonOther = new JSONObject();
					jsonOther.put("studyTimeCount", RequestHandler.secToTime(study_time_other));
					//计算完成课程数量
					YyUserCourse yyUserCourseOther = new YyUserCourse();
					yyUserCourseOther.setUser_id(u.getId());
					List<YyUserCourse> listOther = yyusercourseService.getUserStudyList(yyUserCourseOther);
					Set<Long> set_other = new HashSet<Long>();
					int lessonCountOther = 0;
					if(listOther!=null&&listOther.size()>0){
						for(YyUserCourse uc:listOther){
							set_other.add(uc.getCourse_classify_id());
						}
						Iterator<Long> it = set_other.iterator();
						while(it.hasNext()){
							Long lessonId = it.next();
							boolean b = true;
							for(YyUserCourse uc:listOther){
								if(lessonId.intValue()==uc.getCourse_classify_id().intValue()&&uc.getStudy_state().intValue()!=1){
									b = false;
									break;
								}
							}
							if(b){
								lessonCountOther = lessonCountOther + 1;
							}
						}
					}
					//计算完成课程数量结束
					jsonOther.put("lessonCount", lessonCount);
					jsonOther.put("feedbackCount", 0);
					jsonOther.put("position", 0);
					jsonOther.put("userName", u.getName());
					array.add(jsonOther);
				}
			}
			//同级小伙伴结束
			model.addAttribute("rankingList", array);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "myinfo");
		return  "/wx/myInfo";
	}
	
	/**
	 * 课程
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toCourse", method = RequestMethod.GET)
	public String toCourse(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		Long theme_id = RequestHandler.getLong(request, "theme_id"); 
		try{
			super.getJsticket(request);
			//轮播图
			YyCourseClassify yyCourseClassify = new YyCourseClassify();
			yyCourseClassify.setRowStart(0);
			yyCourseClassify.setRowCount(4);
			yyCourseClassify.setLevel(3);
			yyCourseClassify.setFenye(1L);
			yyCourseClassify.setSortColumn("a.id desc");
			List<YyCourseClassify> listBanner = yycourseclassifyService.getCourseClassifyParents(yyCourseClassify);
			//查询主题下面数据
			YyCourseClassify theme = new YyCourseClassify();
			theme.setParent_id(1L);
			theme.setSortColumn("a.sort_id asc");
			List<YyCourseClassify> listTheme = yycourseclassifyService.getYyCourseClassifyBaseList(theme);
			
			//查询主题下面数据
			if(theme_id==null){
				theme_id = listTheme.get(0).getId();
			}
			YyCourseClassify yyCourseClassifySub1 = new YyCourseClassify();
			yyCourseClassifySub1.setParent_id(theme_id);
			yyCourseClassifySub1.setSortColumn("a.sort_id asc");;
			List<YyCourseClassify> listSub1 = yycourseclassifyService.getYyCourseClassifyBaseList(yyCourseClassifySub1);
			if(listSub1!=null&&listSub1.size()>0){
				for(YyCourseClassify cc:listSub1){
					//查询模块下面数据
					YyCourseClassify yyCourseClassifySub2 = new YyCourseClassify();
					yyCourseClassifySub2.setParent_id(cc.getId());
					yyCourseClassifySub2.setSortColumn("a.sort_id asc");;
					List<YyCourseClassify> listSub2 = yycourseclassifyService.getYyCourseClassifyBaseList(yyCourseClassifySub2);
					cc.setListSub(listSub2);;
				}
			}
			
			model.addAttribute("listTheme", listTheme);
			model.addAttribute("listBanner", listBanner);
			model.addAttribute("listSub1", listSub1);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "course");
		model.addAttribute("theme_id", theme_id);
		return  "/wx/course";
	}
	
	
	/**
	 * 视频统计
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/studyRecord", method = RequestMethod.POST)
	public String studyRecord(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
//		String token = RequestHandler.getString(request, "token");
		String start_time = RequestHandler.getString(request, "start_time");
		String end_time = RequestHandler.getString(request, "end_time");
		Long pointId = RequestHandler.getLong(request, "pointId");
		Integer long_time = RequestHandler.getInteger(request, "long_time");
		Integer is_over = RequestHandler.getInteger(request, "is_over");
		JSONObject json = new JSONObject();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			if(pointId!=null&&long_time!=null&&StringUtils.isNotBlank(start_time)&&StringUtils.isNotBlank(end_time)){
				//查询用户身份
				YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
				if(yyUser!=null){
					YyUserStudy yyUserStudy = new YyUserStudy();
					yyUserStudy.setCreate_time(new Date());
					yyUserStudy.setEnd_time(sf.parse(end_time));
					yyUserStudy.setStart_time(sf.parse(start_time));
					yyUserStudy.setLong_time(long_time);
					yyUserStudy.setPoint_id(pointId);
					//获取父级信息
					yyUserStudy = yyuserstudyService.getParentMsgByPointId(yyUserStudy);
					yyUserStudy.setIs_over(is_over);
					yyUserStudy.setUser_id(yyUser.getId());
					yyuserstudyService.insertYyUserStudy(yyUserStudy);
					//判断是否播放完成
					//计算学习总时长
					YyUserStudy yyUserStudy1 = new YyUserStudy();
					yyUserStudy1.setUser_id(yyUser.getId());
					yyUserStudy1.setPoint_id(pointId);
					int study_time = yyuserstudyService.getUserStudyTime(yyUserStudy1);
					if(is_over.intValue()==1){
						if(study_time>=yyUserStudy.getCount_time()){
							YyUserCourse yyUserCourse = new YyUserCourse();
							yyUserCourse.setUser_id(yyUser.getId());
							yyUserCourse.setCourse_id(pointId);
							yyUserCourse.setStudy_state(1);
							yyusercourseService.updateYyUserCourseByUserAndPointId(yyUserCourse);
						}else{
							YyUserCourse yyUserCourse = new YyUserCourse();
							yyUserCourse.setUser_id(yyUser.getId());
							yyUserCourse.setCourse_id(pointId);
							yyUserCourse.setStudy_state(0);
							yyusercourseService.updateYyUserCourseByUserAndPointId(yyUserCourse);
						}
					}else{
						if(study_time>=yyUserStudy.getCount_time()){
							//是否有过看完记录
							YyUserStudy yyUserStudy2 = new YyUserStudy();
							yyUserStudy2.setIs_over(1);
							yyUserStudy2.setUser_id(yyUser.getId());
							yyUserStudy2.setPoint_id(pointId);
							int count = yyuserstudyService.getYyUserStudyListCount(yyUserStudy2);
							if(count>0){
								YyUserCourse yyUserCourse = new YyUserCourse();
								yyUserCourse.setUser_id(yyUser.getId());
								yyUserCourse.setCourse_id(pointId);
								yyUserCourse.setStudy_state(1);
								yyusercourseService.updateYyUserCourseByUserAndPointId(yyUserCourse);
							}else{
								YyUserCourse yyUserCourse = new YyUserCourse();
								yyUserCourse.setUser_id(yyUser.getId());
								yyUserCourse.setCourse_id(pointId);
								yyUserCourse.setStudy_state(0);
								yyusercourseService.updateYyUserCourseByUserAndPointId(yyUserCourse);
							}
						}else{
							YyUserCourse yyUserCourse = new YyUserCourse();
							yyUserCourse.setUser_id(yyUser.getId());
							yyUserCourse.setCourse_id(pointId);
							yyUserCourse.setStudy_state(0);
							yyusercourseService.updateYyUserCourseByUserAndPointId(yyUserCourse);
						}
					}
					json.put("c", 0);
					json.put("d", new JSONObject());
					json.put("m", "保存成功");
				}else{
					json.put("c", -1);
					json.put("d", new JSONObject());
					json.put("m", "用户不存在");
				}
			}else{
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "参数不能为空");
			}
		}catch(Exception e){
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "系统异常，请重试");
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	
	/**
	 * 看视频
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toVideo", method = RequestMethod.GET)
	public String toVideo(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		Long pointId = RequestHandler.getLong(request, "id");
		try{
			super.getJsticket(request);
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			YyCourse yyCourse = new YyCourse();
			yyCourse.setId(pointId);
			yyCourse = yycourseService.getYyCourse(yyCourse);
			if(yyCourse!=null){
				model.addAttribute("pointId", yyCourse.getId());
				model.addAttribute("pointCover", yyCourse.getImg_url()!=null?yyCourse.getImg_url():"");
				model.addAttribute("pointVideoCover", yyCourse.getImg_url()!=null?yyCourse.getImg_url():"");
				model.addAttribute("pointVideoUrl", yyCourse.getVideo_play());
				model.addAttribute("pointDesc", yyCourse.getInfo());
				model.addAttribute("lessonId", yyCourse.getClassify_id());
				model.addAttribute("pointName", yyCourse.getName());
				model.addAttribute("yyCourse", yyCourse);
				//查询附件
				YyCourseAppendix yyCourseAppendix = new YyCourseAppendix();
				yyCourseAppendix.setCourse_id(yyCourse.getId());
				List<YyCourseAppendix> listAppendix = yycourseappendixService.getYyCourseAppendixBaseList(yyCourseAppendix);
				model.addAttribute("listAppendix", listAppendix);
				//查询父级
				YyCourseClassify yyCourseClassifyP = new YyCourseClassify();
				yyCourseClassifyP.setId(yyCourse.getClassify_id());
				yyCourseClassifyP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyP);
				if(yyCourseClassifyP!=null){
					model.addAttribute("lessonName", yyCourseClassifyP.getName());
					//查询父级
					YyCourseClassify yyCourseClassifyPP = new YyCourseClassify();
					yyCourseClassifyPP.setId(yyCourseClassifyP.getParent_id());
					yyCourseClassifyPP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyPP);
					if(yyCourseClassifyPP!=null){
						model.addAttribute("moduleId", yyCourseClassifyPP.getId());
						model.addAttribute("moduleName", yyCourseClassifyPP.getName());
						//查询父级
						YyCourseClassify yyCourseClassifyPPP = new YyCourseClassify();
						yyCourseClassifyPPP.setId(yyCourseClassifyPP.getParent_id());
						yyCourseClassifyPPP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyPPP);
						if(yyCourseClassifyPPP!=null){
							model.addAttribute("themeId", yyCourseClassifyPPP.getId());
							model.addAttribute("themeName", yyCourseClassifyPPP.getName());
						}else{
							model.addAttribute("themeId", 0);
							model.addAttribute("themeName", "");
						}
					}else{
						model.addAttribute("moduleId", 0);
						model.addAttribute("moduleName", "");
					}
				}else{
					model.addAttribute("lessonName", "");
					model.addAttribute("moduleId", 0);
					model.addAttribute("moduleName", "");
					model.addAttribute("themeId", 0);
					model.addAttribute("themeName", "");
				}
				//其他知识点
				YyCourse yyCourse1 = new YyCourse();
				yyCourse1.setOtherId(pointId);
				yyCourse1.setClassify_id(yyCourse.getClassify_id());
				List<YyCourse> listC = yycourseService.getYyCourseBaseList(yyCourse1);
				if(listC!=null&&listC.size()>0){
					for(YyCourse course:listC){
						course.setWhen_long_str(yycourseService.secToTime(course.getWhen_long()));
						if(yyUser!=null){
							YyUserCourse yyUserCourse = new YyUserCourse();
							yyUserCourse.setUser_id(yyUser.getId());
							yyUserCourse.setCourse_id(course.getId());
							List<YyUserCourse> listCC = yyusercourseService.getYyUserCourseBaseList(yyUserCourse);
							if(listCC!=null&&listCC.size()>0){
								YyUserCourse uc = listCC.get(0);
								course.setStudy_state(uc.getStudy_state()<1?0:1);
							}else{
								course.setStudy_state(0);
							}
						}else{
							course.setStudy_state(0);
						}
					}
				}
				model.addAttribute("listC", listC);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "learn");
		return  "/wx/video";
	}
	
	/**
	 * 添加/移除 到课程表
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation", method = RequestMethod.POST)
	public String operation(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		Long lessonId = RequestHandler.getLong(request, "lessonId");
		Integer type = RequestHandler.getInteger(request, "type");
//		String token = RequestHandler.getString(request, "token");
		try{
			
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			if(yyUser!=null){
				if(type.intValue()==0){//加入课程
					//查询是否已经加入课程
					YyUserCourse yyUserCourse = new YyUserCourse();
					yyUserCourse.setUser_id(yyUser.getId());
					yyUserCourse.setCourse_classify_id(lessonId);
					int count = yyusercourseService.getYyUserCourseListCount(yyUserCourse);
					if(count==0){
						YyCourse yyCourse = new YyCourse();
						yyCourse.setClassify_id(lessonId);
						List<YyCourse> listC = yycourseService.getYyCourseBaseList(yyCourse);
						if(listC!=null&&listC.size()>0){
							for(YyCourse course:listC){
								YyUserCourse yyUserCourse1 = new YyUserCourse();
								yyUserCourse1.setCourse_classify_id(lessonId);
								yyUserCourse1.setUser_id(yyUser.getId());
								yyUserCourse1.setCourse_id(course.getId());
								yyUserCourse1.setStudy_state(-1);
								yyUserCourse1.setStyle(1);
								yyusercourseService.insertYyUserCourse(yyUserCourse1);
							}
						}
						json.put("c", 0);
						json.put("d", new JSONObject());
						json.put("m", "添加成功");
					}else{
						json.put("c", -1);
						json.put("d", new JSONObject());
						json.put("m", "课程已经存在");
					}
				}else if(type.intValue()==1){//移除课程
					YyUserCourse yyUserCourse = new YyUserCourse();
					yyUserCourse.setUser_id(yyUser.getId());
					yyUserCourse.setCourse_classify_id(lessonId);
					int flag = yyusercourseService.removeYyUserCourseByOther(yyUserCourse);
					if(flag>0){
						json.put("c", 0);
						json.put("d", new JSONObject());
						json.put("m", "移除成功");
					}else{
						json.put("c", -1);
						json.put("d", new JSONObject());
						json.put("m", "移除失败，请重试");
					}
				}
			}else{
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "用户不存在");
			}
		}catch(Exception e){
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "系统异常，请重试");
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	
	/**
	 * 课程详情
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toLessonDetail", method = RequestMethod.GET)
	public String toLessonDetail(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		Long lessonId = RequestHandler.getLong(request, "lessonId");
		Long id = RequestHandler.getLong(request, "id");
		try{
			super.getJsticket(request);
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			YyCourseClassify yyCourseClassify = new YyCourseClassify();
			yyCourseClassify.setId(lessonId);
			yyCourseClassify = yycourseclassifyService.getYyCourseClassify(yyCourseClassify);
			if(yyCourseClassify!=null&&yyCourseClassify.getId().intValue()>0){
				model.addAttribute("lessonCover", yyCourseClassify.getImg_url()!=null?yyCourseClassify.getImg_url():"");
				model.addAttribute("lessonDesc", yyCourseClassify.getInfo());
				model.addAttribute("lessonId", lessonId);
				model.addAttribute("lessonName", yyCourseClassify.getName());
				//查询加入课程状态
				//查询用户身份
				if(yyUser!=null){
					YyUserCourse yyUserCourse = new YyUserCourse();
					yyUserCourse.setUser_id(yyUser.getId());
					yyUserCourse.setCourse_classify_id(lessonId);
					int count = yyusercourseService.getYyUserCourseListCount(yyUserCourse);
					if(count>0){
						List<YyUserCourse> listUC = yyusercourseService.getYyUserCourseBaseList(yyUserCourse);
						for(YyUserCourse cccc:listUC){
							model.addAttribute("studyType", cccc.getStyle());
						}
						model.addAttribute("joinStatus", 1);
					}else{
						model.addAttribute("joinStatus", 0);
					}
				}else{
					model.addAttribute("joinStatus", 0);
				}
				//查询父级
				YyCourseClassify yyCourseClassifyP = new YyCourseClassify();
				yyCourseClassifyP.setId(yyCourseClassify.getParent_id());
				yyCourseClassifyP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyP);
				if(yyCourseClassifyP!=null){
					model.addAttribute("moduleId", yyCourseClassify.getParent_id());
					model.addAttribute("moduleName", yyCourseClassifyP.getName());
					//查询父级
					YyCourseClassify yyCourseClassifyPP = new YyCourseClassify();
					yyCourseClassifyPP.setId(yyCourseClassifyP.getParent_id());
					yyCourseClassifyPP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyPP);
					if(yyCourseClassifyPP!=null){
						model.addAttribute("themeId", yyCourseClassifyP.getParent_id());
						model.addAttribute("themeName", yyCourseClassifyPP.getName());
					}
				}
				//查询视频
				YyCourse yyCourse = new YyCourse();
				yyCourse.setClassify_id(lessonId);
				List<YyCourse> list = yycourseService.getYyCourseBaseList(yyCourse);
				if(list!=null&&list.size()>0){
					for(YyCourse course:list){
						YyUserCourse yyUserCourse = new YyUserCourse();
						yyUserCourse.setUser_id(yyUser.getId());
						yyUserCourse.setCourse_id(course.getId());
						List<YyUserCourse> listC = yyusercourseService.getYyUserCourseBaseList(yyUserCourse);
						if(listC!=null&&listC.size()>0){
							YyUserCourse uc = listC.get(0);
							course.setStudy_state(uc.getStudy_state()<1?0:1);
						}else{
							course.setStudy_state(0);
						}
						course.setWhen_long_str(yycourseService.secToTime(course.getWhen_long()));
					}
				}
				model.addAttribute("listPoint", list);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "learn");
		return  "/wx/lessonDetail";
	}
	
	/**
	 * 去学习
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toLearn", method = RequestMethod.GET)
	public String toLearn(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		try{
			super.getJsticket(request);
			YyUser yyUser = (YyUser)request.getSession().getAttribute(SessionName.ADMIN_USER);
			//轮播图
			YyCourseClassify yyCourseClassify = new YyCourseClassify();
			yyCourseClassify.setRowStart(0);
			yyCourseClassify.setRowCount(4);
			yyCourseClassify.setLevel(3);
			yyCourseClassify.setFenye(1L);
			yyCourseClassify.setSortColumn("a.id desc");
			List<YyCourseClassify> listBanner = yycourseclassifyService.getCourseClassifyParents(yyCourseClassify);
//			List<YyCourseClassify> listBanner = new ArrayList<YyCourseClassify>();
//			if(list!=null){
//				Iterator<Object> it = list.iterator();
//				while(it.hasNext()){
//					YyCourseClassify cc = (YyCourseClassify)it.next();
//					listBanner.add(cc);
//				}
//			}
			//轮播图结束
			
			List<YyUserCourse> listB = new ArrayList<YyUserCourse>();//我的必修课
			List<YyUserCourse> listX = new ArrayList<YyUserCourse>();//我的选修课
			YyUserCourse yyUserCourse = new YyUserCourse();
			yyUserCourse.setUser_id(yyUser.getId());
			List<YyUserCourse> listMyCourse = yyusercourseService.getYyUserCourseParent(yyUserCourse);
			if(listMyCourse!=null&&listMyCourse.size()>0){
				YyUserCourse yyUserCourse1 = new YyUserCourse();
				yyUserCourse1.setUser_id(yyUser.getId());
				List<YyUserCourse> list2 = yyusercourseService.getUserStudyStateList(yyUserCourse1);
				for(YyUserCourse uc1:listMyCourse){
					int count = 0;//总课数
					int status = 0;//未开始
					int overDays = 0;
					uc1.setStudyProgress(0);
					if(list2!=null&&list2.size()>0){
						for(YyUserCourse uc2:list2){
							if(uc2.getCourse_classify_id().intValue()==uc1.getCourse_classify_id().intValue()){
								if(uc2.getStudy_state().intValue()==1){//已学完
									count = count + uc2.getCount();
									uc1.setStudyProgress(uc2.getCount());
									status = 1;
								}
								if(uc2.getStudy_state().intValue()!=1){//未学完
									count = count + uc2.getCount();
								}
								if(uc1.getStyle().intValue()==0){//必修
									overDays = yyusercourseService.differentDays(new Date(), uc2.getOver_time());
									if(overDays<0){
										overDays = 0;
									}
								}
							}
						}
						uc1.setStudyCount(count);
						uc1.setOverDays(overDays);
						uc1.setStatus(status);
						if(uc1.getStyle().intValue()==0){//必修
							listB.add(uc1);
						}else{
							listX.add(uc1);
						}
					}
				}
			}
			
			model.addAttribute("listB", listB);
			model.addAttribute("listX", listX);
			model.addAttribute("listBanner", listBanner);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("nav", "learn");
		return "/wx/learn";
	}
	
	/**
	 * 我的二维码
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toMyCode", method = RequestMethod.GET)
	public String toMyCode(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		String openId = RequestHandler.getString(request, "openId");
		try{
			String fileToday = DateFormatUtils.format(new Date(), "yyyy/MM/dd");
			String uuName = System.currentTimeMillis() + UUID.randomUUID().toString().split("-")[0];// 新文件名
			
			YyUser yyUser = new YyUser();
			yyUser.setOpenId(openId);
			yyUser.setState(1);
			yyUser = yyuserService.getYyUser(yyUser);
			if(yyUser!=null&&yyUser.getId()>0){
				//生成二维码
				String state = "a_" + yyUser.getCompany_id() + "_" + yyUser.getId();
				String url = ConfigConstants.URL_PATH + "/redirect_uri.jsp?state="+state;
				//二维码地址
				// 获取保存文件的最终路径
				String saveFilePath = ConfigConstants.UPLOAD_FILE_ROOT ;
				String newFileName =  File.separator + fileToday + File.separator + uuName + ".jpg";// 新路径
				if(!new File(saveFilePath+File.separator + fileToday + File.separator).exists()){
					new File(saveFilePath+File.separator + fileToday + File.separator).mkdirs();
				}
				
		        String format = "jpg";  
		        File outputFile = new File(saveFilePath + newFileName);  
		        MatrixUtil.writeToFile(MatrixUtil.toQRCodeMatrix(url, null, null), format, outputFile);  
		        String result = MatrixUtil.decode(outputFile);
				model.addAttribute("imgUrl",  newFileName.replace("\\", "/"));
			}else{
				return "/wx/tip";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("openId", openId);
		return "/wx/myCode";
	}
	
	/**
	 * 去登录
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/toLogin", method = RequestMethod.GET)
	public String toLogin(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		String openId = RequestHandler.getString(request, "openId");
		try{
			super.getJsticket(request);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("openId", openId);
		return "/wx/login";
	}
	
	/**
	 * 登录
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		String mobile = RequestHandler.getString(request, "mobile");
		String openId = RequestHandler.getString(request, "openId");
		String code = RequestHandler.getString(request, "code");
		JSONObject json = new JSONObject();
		try {
			if (!StringUtils.isNotBlank(mobile)) {
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "请输入手机号");
			}
//			else if (!StringUtils.isNotBlank(code)) {
//				json.put("c", -1);
//				json.put("d", new JSONObject());
//				json.put("m", "请输入验证码");
//			}
			else if (!StringUtils.isNotBlank(openId)) {
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "参数错误");
			}else{
				String code_session = UserApiController.CODEMAP.get(mobile);
//				if(code.equals(code_session)){
				if(true){
					//验证超时
//					Date d = UserApiController.TIMEMAP.get(mobile);
//					Calendar c = Calendar.getInstance();
//					c.setTime(d);
//					c.add(Calendar.MINUTE, 1);
//					if((new Date()).before(c.getTime())){
					if(true){
						YyUser yyUser = new YyUser();
						yyUser.setPhone(mobile);
						yyUser.setState(1);
						int count = yyuserService.getYyUserListCount(yyUser);
						if(count==1){
							boolean b = false;
							yyUser = yyuserService.getYyUser(yyUser);
							//验证公司状态
							YyCompany yyCompany = new YyCompany();
							yyCompany.setId(yyUser.getCompany_id());
							yyCompany = yycompanyService.getYyCompany(yyCompany);
							if(yyCompany.getState().intValue()==1){
								if(StringUtils.isNotBlank(yyUser.getOpenId())){
									if(yyUser.getOpenId().equals(openId)){
										b = true;
									}else{
										json.put("c", -1);
										json.put("d", new JSONObject());
										json.put("m", "用户状态异常，请联系管理员");
									}
								}else{
									YyUser yyUserOpenId = new YyUser();
									yyUserOpenId.setOpenId(openId);
									int countOp = yyuserService.getYyUserListCount(yyUserOpenId);
									if(countOp==0){
										yyUser.setOpenId(openId);
										yyuserService.updateYyUser(yyUser);
										b = true;
									}else{
										json.put("c", -1);
										json.put("d", new JSONObject());
										json.put("m", "用户状态异常，请联系管理员");
									}
								}
							}else{
								json.put("c", -1);
								json.put("d", new JSONObject());
								json.put("m", "登录失败，贵公司服务已暂停");
							}
							
							//生成token
//							String token = UserApiController.getToken(yyUser.getId());
//							JSONObject jsonSub = new JSONObject();
//							jsonSub.put("token", token);
//							jsonSub.put("userId", yyUser.getId());
//							jsonSub.put("username", yyUser.getName());
//							if(yyUser.getLower_level_number()>0){
//								jsonSub.put("isPublishLesson", true);
//							}else{
//								jsonSub.put("isPublishLesson", false);
//							}
//							jsonSub.put("branchName", yyUser.getDepartment());
//							jsonSub.put("branchId", -1);
//							jsonSub.put("levelName", yyUser.getLevelName());
//							if(StringUtils.isNotBlank(yyUser.getParent_ids())){
//								jsonSub.put("level", yyUser.getParent_ids().split(",").length+1);
//							}else{
//								jsonSub.put("level", 0);
//							}
//							//修改token
//							YyUser yyUser1 = new YyUser();
//							yyUser1.setId(yyUser.getId());
//							yyUser1.setToken(token);
//							int flag = yyuserService.updateYyUser(yyUser1);
//							if(flag>0){
							UserApiController.CODEMAP.remove(mobile);
							UserApiController.TIMEMAP.remove(mobile);
							if(b){
								YyUser session_user = new YyUser();
								session_user.setId(yyUser.getId());
								session_user = yyuserService.getYyUser(session_user);
								// 正常
								request.getSession().setAttribute(SessionName.ADMIN_USER_NAME, session_user.getName());
								request.getSession().setAttribute(SessionName.ADMIN_USER_ID, session_user.getId());
								request.getSession().setAttribute(SessionName.ADMIN_USER, session_user);
								
								json.put("c", 0);
//								json.put("d", jsonSub);
								json.put("m", "登录成功");
							}else{
								json.put("c", -1);
								json.put("d", new JSONObject());
								json.put("m", "用户状态异常，请联系管理员");
							}
							
//							}else{
//								json.put("c", -1);
//								json.put("d", new JSONObject());
//								json.put("m", "登录失败，请重试");
//							}
						}else{
							json.put("c", -1);
							json.put("d", new JSONObject());
							json.put("m", "用户不存在，请先扫码注册");
						}
					}else{
						json.put("c", -1);
						json.put("d", new JSONObject());
						json.put("m", "验证码已过期，请重新输入");
					}
				}else{
					json.put("c", -1);
					json.put("d", new JSONObject());
					json.put("m", "验证码错误，请重新输入");
				}
			}
		} catch (Exception e) {
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "系统异常，请重试");
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	
	/**
	 * 发送验证码
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sendsms", method = RequestMethod.GET)
	public String sendCode(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		String mobile = RequestHandler.getString(request, "mobile");
		JSONObject json = new JSONObject();
		try {
			if (!StringUtils.isNotBlank(mobile)) {
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "请输入手机号");
			}else{
				JSMSClient jSMSClient = new JSMSClient(ConfigConstants.DEV_SECRET, ConfigConstants.DEV_KEY);
				SMSPayload.Builder builder = SMSPayload.newBuilder();
				builder.setMobileNumber(mobile);
				builder.setTempId(1);
				builder.setTTL(60);
				Map<String,String> map = new HashMap<String,String>();
				String randomCode = UserApiController.getRandomCode(4);
				map.put("code", randomCode);
				builder.setTempPara(map);
				SendSMSResult result = jSMSClient.sendTemplateSMS(builder.build());
				if(200==result.getResponseCode()){
					System.out.println("-----验证码-------->"+randomCode);
					UserApiController.CODEMAP.put(mobile, randomCode);
					UserApiController.TIMEMAP.put(mobile, new Date());
					json.put("c", 0);
					json.put("d", randomCode);
					json.put("m", "验证码已经发送，请注意查收");
				}else{
					json.put("c", -1);
					json.put("d", new JSONObject());
					json.put("m", "发送失败，请重试");
				}
			}
		} catch (Exception e) {
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "发送失败，请重试");
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
        response.setHeader("Cache-Control","no-cache");
        response.getWriter().write(json.toString());
		return null;
	}
	
	
	/**
	 * 测试
	 * 
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/saveImageToDisk", method = RequestMethod.GET)
	public String saveImageToDisk(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		String mediaId = RequestHandler.getString(request, "mediaId");
		String accessToken = weiXinService.getAccessToken(ConfigConstants.APPID, ConfigConstants.APPSECRET);
		String saveFilePath = ConfigConstants.UPLOAD_FILE_ROOT;
		String fileToday = DateFormatUtils.format(new Date(), "yyyy/MM/dd");
		File file = new File(saveFilePath + File.separator + fileToday + File.separator);
		if(!file.exists()){
			file.mkdirs();
		}
		JSONObject json = new JSONObject();
		try{
			weiXinService.saveImageToDisk(accessToken, mediaId, mediaId, saveFilePath + File.separator + fileToday + File.separator);
			json.put("c", 0);
			json.put("d", File.separator + fileToday + File.separator + mediaId + ".jpg");
			json.put("m", "上传成功");
		}catch(Exception e){
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "上传失败，系统异常");
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
        response.setHeader("Cache-Control","no-cache");
        response.getWriter().write(json.toString());
		return  null;
	}
	
	
}
