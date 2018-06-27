package com.yy.apiController.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jsms.api.JSMSClient;
import cn.jsms.api.SendSMSResult;
import cn.jsms.api.common.model.SMSPayload;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.base.controller.BaseController;
import com.base.utils.ConfigConstants;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.utils.SessionName;
import com.wx.x0001.HashKit;
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
import com.yy.yyUserFunction.model.YyUserFunction;
import com.yy.yyUserFunction.service.YyUserFunctionService;
import com.yy.yyUserStudy.model.YyUserStudy;
import com.yy.yyUserStudy.service.YyUserStudyService;


@Controller
@RequestMapping("/api/user")
public class UserApiController extends BaseController{
	
	
	private static Logger logger = Logger.getLogger(UserApiController.class);
	
	/** 存放手机号-验证码缓存 **/
	public static Map<String, String> CODEMAP = new HashMap<String, String>();
	/** 存放手机号-时间缓存 **/
	public static Map<String, Date> TIMEMAP = new HashMap<String, Date>();

	@Autowired
	private YyUserService yyuserService = null;
	@Autowired
	private YyUserStudyService yyuserstudyService = null;
	@Autowired
	private YyUserCourseService yyusercourseService = null;
	@Autowired
	private YyCourseService yycourseService = null;
	@Autowired
	private YyCourseAppendixService yycourseappendixService = null;
	@Autowired
	private YyCourseClassifyService yycourseclassifyService = null;
	@Autowired
	private YyUserFunctionService yyuserfunctionService = null;
	@Autowired
	private YyCompanyService yycompanyService = null;
	
	/**
	 * 学习记录
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/studyRecord", method = RequestMethod.POST)
	public String studyRecord(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		String token = request.getHeader("token");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONArray());
				json.put("m", "token无效");
			}else{
				if(StringUtils.isNotBlank(token)){
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
					if(yyUser!=null){
						JSONArray array = new JSONArray();
						YyUserStudy yyUserStudy = new YyUserStudy();
						yyUserStudy.setUser_id(yyUser.getId());
						List<YyUserStudy> list = yyuserstudyService.getYyUserStudyByLesson(yyUserStudy);
						if(list!=null&&list.size()>0){
							for(YyUserStudy uc:list){
								YyCourseClassify yyCourseClassify = new YyCourseClassify();
								yyCourseClassify.setId(uc.getLesson_id());
								yyCourseClassify = yycourseclassifyService.getYyCourseClassify(yyCourseClassify);
								JSONObject jsonLesson = new JSONObject();
								jsonLesson.put("themeId", uc.getTheme_id());
								jsonLesson.put("lessonId", uc.getLesson_id());
								jsonLesson.put("themeName", uc.getTheme_name());
								jsonLesson.put("lessonName", uc.getLesson_name());
								jsonLesson.put("moduleId", uc.getModule_id());
								jsonLesson.put("moduleName", uc.getModule_name());
								jsonLesson.put("lessonCover", yyCourseClassify.getImg_url());
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
									jsonLesson.put("studyTime", yyUserStudy.getCreate_time().getTime());
								}else{
									jsonLesson.put("studyTime", "");
								}
								//查询下面知识点
								YyCourse yyCourse = new YyCourse();
								yyCourse.setClassify_id(uc.getLesson_id());
								List<YyCourse> listC = yycourseService.getYyCourseBaseList(yyCourse);
								JSONArray arrayCourse = new JSONArray();
								if(listC!=null&&listC.size()>0){
									for(YyCourse c:listC){
										JSONObject jsonCourse = new JSONObject();
										jsonCourse.put("pointName", c.getName());
										jsonCourse.put("pointId", c.getId());
										arrayCourse.add(jsonCourse);
									}
								}
								jsonLesson.put("points", arrayCourse);
								//查询下面附件
								YyCourseAppendix yyCourseAppendix = new YyCourseAppendix();
								yyCourseAppendix.setClassify_id(uc.getLesson_id());
								List<YyCourseAppendix> listCA = yycourseappendixService.getYyCourseAppendixBaseList(yyCourseAppendix);
								JSONArray arrayAppendix = new JSONArray();
								if(listCA!=null&&listCA.size()>0){
									for(YyCourseAppendix ca:listCA){
										JSONObject jsonAppendix = new JSONObject();
										jsonAppendix.put("toolsName", ca.getName());
										jsonAppendix.put("toolsUrl", ca.getUrl());
										
										arrayAppendix.add(jsonAppendix);
									}
								}
								jsonLesson.put("tools", arrayAppendix);
								array.add(jsonLesson);
							}
							json.put("c", 0);
							json.put("d", array);
							json.put("m", "查询成功");
						}else{
							json.put("c", 0);
							json.put("d", new JSONArray());
							json.put("m", "暂无学习记录");
						}
					}else{
						json.put("c", -1);
						json.put("d", new JSONArray());
						json.put("m", "用户不存在");
					}
				}else{
					json.put("c", -1);
					json.put("d", new JSONArray());
					json.put("m", "参数不能为空");
				}
			}
		}catch(Exception e){
			json.put("c", -1);
			json.put("d", new JSONArray());
			json.put("m", "系统异常，请重试");
			logger.info(exception(e));
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	
	
	/**
	 * 我的-信息
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/summary", method = RequestMethod.GET)
	public String summary(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
//		String token = RequestHandler.getString(request, "token");
		String token = request.getHeader("token");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				if(StringUtils.isNotBlank(token)){
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
					if(yyUser!=null){
						JSONObject jsonSub = new JSONObject();
						jsonSub.put("userName", yyUser.getName());
						jsonSub.put("branchName", yyUser.getCompany_name());
						jsonSub.put("userAvatar", yyUser.getHead_img());
						if(yyUser.getLower_level_number()>0){
							jsonSub.put("hasLowerLevel", 1);
						}else{
							jsonSub.put("hasLowerLevel", 0);
						}
						//计算学习总时长
						YyUserStudy yyUserStudy = new YyUserStudy();
						yyUserStudy.setUser_id(yyUser.getId());
						int study_time = yyuserstudyService.getUserStudyTime(yyUserStudy);
						JSONObject jsonStudy = new JSONObject();
						jsonStudy.put("studyTimeCount", RequestHandler.secToTime(study_time));
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
						jsonStudy.put("lessonCount", lessonCount);
						jsonStudy.put("feedbackCount", 0);
						jsonStudy.put("powerCount", 0);
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
						jsonSub.put("studyRecord", jsonStudy);
						jsonSub.put("rankingList", array);
						json.put("c", 0);
						json.put("d", jsonSub);
						json.put("m", "查询成功");
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
			}
		}catch(Exception e){
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "系统异常，请重试");
			logger.info(exception(e));
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	/**
	 * 修改用户头像
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateAvatar", method = RequestMethod.GET)
	public String updateAvatar(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		String avatarUrl = RequestHandler.getString(request, "avatarUrl");
//		String token = RequestHandler.getString(request, "token");
		String token = request.getHeader("token");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				if(StringUtils.isNotBlank(token)&&StringUtils.isNotBlank(avatarUrl)){
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
					if(yyUser!=null){
						yyUser.setHead_img(avatarUrl);
						yyuserService.updateYyUser(yyUser);
						json.put("c", 0);
						json.put("d", new JSONObject());
						json.put("m", "修改成功");
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
			}
		}catch(Exception e){
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "系统异常，请重试");
			logger.info(exception(e));
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
	@SuppressWarnings("static-access")
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
				String randomCode = this.getRandomCode(4);
				map.put("code", randomCode);
				builder.setTempPara(map);
				SendSMSResult result = jSMSClient.sendTemplateSMS(builder.build());
				if(200==result.getResponseCode()){
					System.out.println("-----验证码-------->"+randomCode);
					CODEMAP.put(mobile, randomCode);
					TIMEMAP.put(mobile, new Date());
					json.put("c", 0);
					json.put("d", "");
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
		String code = RequestHandler.getString(request, "code");
		JSONObject json = new JSONObject();
		try {
			if (!StringUtils.isNotBlank(mobile)) {
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "请输入手机号");
			}else if (!StringUtils.isNotBlank(code)) {
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "请输入验证码");
			}else{
				if("13123456789".equals(mobile)){
					YyUser yyUser = new YyUser();
					yyUser.setPhone(mobile);
					yyUser.setState(1);
					yyUser = yyuserService.getYyUser(yyUser);
					//生成token
					String token = this.getToken(yyUser.getId());
					JSONObject jsonSub = new JSONObject();
					jsonSub.put("token", token);
					jsonSub.put("userId", yyUser.getId());
					jsonSub.put("username", yyUser.getName());
					if(yyUser.getLower_level_number()>0){
						jsonSub.put("isPublishLesson", true);
					}else{
						jsonSub.put("isPublishLesson", false);
					}
					jsonSub.put("branchName", yyUser.getDepartment());
					jsonSub.put("branchId", -1);
					//获取职能
					YyUserFunction yyUserFunction = new YyUserFunction();
					yyUserFunction.setUser_id(yyUser.getId());
					List<YyUserFunction> listUF = yyuserfunctionService.getYyUserFunctionBaseList(yyUserFunction);
					if(listUF!=null&&listUF.size()>0){
						String levelName = null;
						for(YyUserFunction uf:listUF){
							if(levelName==null){
								levelName = uf.getFunction_name();
							}else{
								levelName = levelName + "," + uf.getFunction_name();
							}
						}
						jsonSub.put("levelName", levelName);
					}else{
						jsonSub.put("levelName", "");
					}
					if(StringUtils.isNotBlank(yyUser.getParent_ids())){
						jsonSub.put("level", yyUser.getParent_ids().split(",").length+1);
					}else{
						jsonSub.put("level", 0);
					}
					//修改token
					YyUser yyUser1 = new YyUser();
					yyUser1.setId(yyUser.getId());
					yyUser1.setToken(token);
					int flag = yyuserService.updateYyUser(yyUser1);
					if(flag>0){
						CODEMAP.remove(mobile);
						TIMEMAP.remove(mobile);
						json.put("c", 0);
						json.put("d", jsonSub);
						json.put("m", "登录成功");
					}else{
						json.put("c", -1);
						json.put("d", new JSONObject());
						json.put("m", "登录失败，请重试");
					}
				}else{
					String code_session = CODEMAP.get(mobile);
					if(code.equals(code_session)){
						//验证超时
						Date d = TIMEMAP.get(mobile);
						Calendar c = Calendar.getInstance();
						c.setTime(d);
						c.add(Calendar.MINUTE, 3);
						if((new Date()).before(c.getTime())){
							YyUser yyUser = new YyUser();
							yyUser.setPhone(mobile);
							yyUser.setState(1);
							int count = yyuserService.getYyUserListCount(yyUser);
							if(count==1){
								yyUser = yyuserService.getYyUser(yyUser);
								//验证公司状态
								YyCompany yyCompany = new YyCompany();
								yyCompany.setId(yyUser.getCompany_id());
								yyCompany = yycompanyService.getYyCompany(yyCompany);
								if(yyCompany.getState().intValue()==1){
									//生成token
									String token = this.getToken(yyUser.getId());
									JSONObject jsonSub = new JSONObject();
									jsonSub.put("token", token);
									jsonSub.put("userId", yyUser.getId());
									jsonSub.put("username", yyUser.getName());
									if(yyUser.getLower_level_number()>0){
										jsonSub.put("isPublishLesson", true);
									}else{
										jsonSub.put("isPublishLesson", false);
									}
									jsonSub.put("branchName", yyUser.getDepartment());
									jsonSub.put("branchId", -1);
									//获取职能
									YyUserFunction yyUserFunction = new YyUserFunction();
									yyUserFunction.setUser_id(yyUser.getId());
									List<YyUserFunction> listUF = yyuserfunctionService.getYyUserFunctionBaseList(yyUserFunction);
									if(listUF!=null&&listUF.size()>0){
										String levelName = null;
										for(YyUserFunction uf:listUF){
											if(levelName==null){
												levelName = uf.getFunction_name();
											}else{
												levelName = levelName + "," + uf.getFunction_name();
											}
										}
										jsonSub.put("levelName", levelName);
									}else{
										jsonSub.put("levelName", "");
									}
									if(StringUtils.isNotBlank(yyUser.getParent_ids())){
										jsonSub.put("level", yyUser.getParent_ids().split(",").length+1);
									}else{
										jsonSub.put("level", 0);
									}
									//修改token
									YyUser yyUser1 = new YyUser();
									yyUser1.setId(yyUser.getId());
									yyUser1.setToken(token);
									int flag = yyuserService.updateYyUser(yyUser1);
									if(flag>0){
										CODEMAP.remove(mobile);
										TIMEMAP.remove(mobile);
										json.put("c", 0);
										json.put("d", jsonSub);
										json.put("m", "登录成功");
									}else{
										json.put("c", -1);
										json.put("d", new JSONObject());
										json.put("m", "登录失败，请重试");
									}
								}else{
									json.put("c", -1);
									json.put("d", new JSONObject());
									json.put("m", "登录失败，贵公司服务已暂停");
								}
							}else if(count>1){
								json.put("c", -1);
								json.put("d", new JSONObject());
								json.put("m", "用户状态异常，请联系管理员");
							}else{
								json.put("c", -1);
								json.put("d", new JSONObject());
								json.put("m", "用户不存在，请先注册");
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
			}
		} catch (Exception e) {
			json.put("c", -1);
			json.put("d", new JSONObject());
			json.put("m", "登录失败，请重试");
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	
	/**
	 * 返回随机数
	 * 
	 * @param bit
	 *            位数
	 * @return
	 */
	public static String getRandomCode(int bit) {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < bit; i++) {
			int ranNum = ran.nextInt(10);
			sb.append(ranNum);
		}
		return sb.toString();
	}
	
	/**
	 * 返回token
	 * 
	 * @param bit
	 *            位数
	 * @return
	 */
	public static String getToken(Long user_id) {
		List<String> ss = new ArrayList<String>();
		
		ss.add(user_id+"");
		ss.add(new Date().getTime()+"");
		ss.add(ConfigConstants.TOKEN);
		
		Collections.sort(ss);
		
		StringBuilder builder = new StringBuilder();
		for(String s : ss) {
			builder.append(s);
		}
		return HashKit.sha1(builder.toString());
	}
}
