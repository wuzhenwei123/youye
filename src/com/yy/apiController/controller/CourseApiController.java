package com.yy.apiController.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.base.controller.BaseController;
import com.base.utils.ConfigConstants;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
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
@RequestMapping("/api/lesson")
public class CourseApiController extends BaseController{

	private static Logger logger = Logger.getLogger(CourseApiController.class);
	
	@Autowired
	private YyCourseClassifyService yycourseclassifyService = null;
	@Autowired
	private YyCourseService yycourseService = null;
	@Autowired
	private YyUserService yyuserService = null;
	@Autowired
	private YyUserCourseService yyusercourseService = null;
	@Autowired
	private YyUserStudyService yyuserstudyService = null;
	@Autowired
	private YyCourseAppendixService yycourseappendixService = null;
	
	
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
		String token = request.getHeader("token");
		String start_time = RequestHandler.getString(request, "start_time");
		String end_time = RequestHandler.getString(request, "end_time");
		Long pointId = RequestHandler.getLong(request, "pointId");
		Integer long_time = RequestHandler.getInteger(request, "long_time");
		Integer is_over = RequestHandler.getInteger(request, "is_over");
		JSONObject json = new JSONObject();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				if(StringUtils.isNotBlank(token)&&pointId!=null&&long_time!=null&&StringUtils.isNotBlank(start_time)&&StringUtils.isNotBlank(end_time)){
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
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
	 * 首页轮播图
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/bannerList", method = RequestMethod.GET)
	public String bannerList(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		try{
//			YyCourseClassify yyCourseClassify = new YyCourseClassify();
//			yyCourseClassify.setRowStart(0);
//			yyCourseClassify.setRowCount(4);
//			yyCourseClassify.setLevel(3);
//			yyCourseClassify.setSortColumn("a.id desc");
//			ResponseList<YyCourseClassify> list = yycourseclassifyService.getYyCourseClassifyList(yyCourseClassify);
			//轮播图
			YyCourseClassify yyCourseClassify = new YyCourseClassify();
			yyCourseClassify.setRowStart(0);
			yyCourseClassify.setRowCount(4);
			yyCourseClassify.setLevel(3);
			yyCourseClassify.setFenye(1L);
			yyCourseClassify.setSortColumn("a.id desc");
			List<YyCourseClassify> listBanner = yycourseclassifyService.getCourseClassifyParents(yyCourseClassify);
			JSONArray array = new JSONArray();
			if(listBanner!=null&&listBanner.size()>0){
				for(YyCourseClassify cc:listBanner){
					JSONObject jsonSub = new JSONObject();
					jsonSub.put("id", cc.getId());
					jsonSub.put("type", 0);
					jsonSub.put("target", "");
					jsonSub.put("themeId", cc.getTheme_id());
					jsonSub.put("themeName", cc.getTheme_name());
					jsonSub.put("moduleName", cc.getModule_name());
					jsonSub.put("lessonName", cc.getName());
					jsonSub.put("image", cc.getImg_url()!=null?cc.getImg_url():"");
					array.add(jsonSub);
				}
//				Iterator<Object> it = list.iterator();
//				while(it.hasNext()){
//					JSONObject jsonSub = new JSONObject();
//					YyCourseClassify cc = (YyCourseClassify)it.next();
//					jsonSub.put("id", cc.getId());
//					jsonSub.put("type", 0);
//					jsonSub.put("target", "");
//					jsonSub.put("themeId", "");
//					jsonSub.put("themeName", "");
//					jsonSub.put("moduleName", "");
//					jsonSub.put("image", cc.getImg_url()!=null?cc.getImg_url():"");
//					array.add(jsonSub);
//				}
			}
			json.put("c", 0);
			json.put("d", array);
			json.put("m", "查询成功");
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
	 * 学习列表
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/studyList", method = RequestMethod.GET)
	public String studyList(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
//		String token = RequestHandler.getString(request, "token");
		String token = request.getHeader("token");
		Integer type = RequestHandler.getInteger(request, "type");//0必修，1选修
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONArray());
				json.put("m", "token无效");
			}else{
				if(type!=null&&StringUtils.isNotBlank(token)){
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
					if(yyUser!=null){
						YyUserCourse yyUserCourse = new YyUserCourse();
						yyUserCourse.setUser_id(yyUser.getId());
						yyUserCourse.setStyle(type);
						List<YyUserCourse> list = yyusercourseService.getUserStudyList(yyUserCourse);
						if(list!=null&&list.size()>0){
							JSONArray array = new JSONArray();
							YyUserCourse yyUserCourse1 = new YyUserCourse();
							yyUserCourse1.setUser_id(yyUser.getId());
							yyUserCourse1.setStyle(type);
							List<YyUserCourse> list2 = yyusercourseService.getUserStudyStateList(yyUserCourse1);
							if(list2!=null&&list2.size()>0){
								for(YyUserCourse uc1:list){
									JSONObject jsonSub = new JSONObject();
									int count = 0;//总课数
									int status = 0;//未开始
									int overDays = 0;
									for(YyUserCourse uc2:list2){
										if(uc2.getCourse_classify_id().intValue()==uc1.getCourse_classify_id().intValue()){
											if(uc2.getStudy_state()==1){//已学完
												count = count + uc2.getCount();
												uc1.setStudyProgress(uc2.getCount());
												status = 1;
											}
											if(uc2.getStudy_state()<1){//未学完
												count = count + uc2.getCount();
											}
											if(type.intValue()==0){//必修
												overDays = yyusercourseService.differentDays(new Date(), uc2.getOver_time());
												if(overDays<0){
													overDays = 0;
												}
											}
										}
									}
									uc1.setOverDays(overDays);
									jsonSub.put("lessonId", uc1.getLessonId());
									jsonSub.put("lessonName", uc1.getLessonName());
									jsonSub.put("moduleId", uc1.getModuleId());
									jsonSub.put("moduleName", uc1.getModuleName());
									jsonSub.put("themeId", uc1.getThemeId());
									jsonSub.put("themeName", uc1.getThemeName());
									jsonSub.put("studyProgress", uc1.getStudyProgress()!=null?uc1.getStudyProgress():0);
									jsonSub.put("studyCount", count);
									jsonSub.put("status", status);
									jsonSub.put("overDays", overDays);
									array.add(jsonSub);
								}
							}
							json.put("c", 0);
							json.put("d", array);
							json.put("m", "查询成功");
						}else{
							json.put("c", 0);
							json.put("d", new JSONArray());
							json.put("m", "暂无课程");
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
	 * 首页主题列表
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/themeList", method = RequestMethod.GET)
	public String themeList(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		try{
			YyCourseClassify yyCourseClassify = new YyCourseClassify();
			yyCourseClassify.setParent_id(1L);
			yyCourseClassify.setSortColumn("a.sort_id asc");
			List<YyCourseClassify> list = yycourseclassifyService.getYyCourseClassifyBaseList(yyCourseClassify);
			if(list!=null&&list.size()>0){
				JSONArray array = new JSONArray();
				for(YyCourseClassify cc:list){
					JSONObject jsonSub = new JSONObject();
					jsonSub.put("themeId", cc.getId());
					jsonSub.put("themeName", cc.getName());
					jsonSub.put("themeColor", "");
					jsonSub.put("themeSelectedIcon", "");
					jsonSub.put("themeDefaultIcon", "");
					array.add(jsonSub);
				}
				json.put("d", array);
				json.put("c", 0);
				json.put("m", "查询成功");
			}else{
				json.put("c", -1);
				json.put("d", new JSONObject());
				json.put("m", "暂无数据");
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
	 * 添加/移除 到课程表
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation", method = RequestMethod.GET)
	public String operation(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		Long lessonId = RequestHandler.getLong(request, "lessonId");
		Integer type = RequestHandler.getInteger(request, "type");
//		String token = RequestHandler.getString(request, "token");
		String token = request.getHeader("token");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				if(lessonId!=null&&type!=null&&StringUtils.isNotBlank(token)){
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
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
									json.put("c", 0);
									json.put("d", new JSONObject());
									json.put("m", "添加成功");
								}else{
									json.put("c", -1);
									json.put("d", new JSONObject());
									json.put("m", "该课程没有知识点，暂时无法添加");
								}
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
	 * 知识点详情
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pointDetail", method = RequestMethod.GET)
	public String pointDetail(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		Long pointId = RequestHandler.getLong(request, "pointId");
//		String token = RequestHandler.getString(request, "token");
		String token = request.getHeader("token");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				JSONObject json1 = new JSONObject();
				if(pointId!=null&&StringUtils.isNotBlank(token)){
					YyCourse yyCourse = new YyCourse();
					yyCourse.setId(pointId);
					yyCourse = yycourseService.getYyCourse(yyCourse);
					if(yyCourse!=null){
						json1.put("pointId", yyCourse.getId());
						json1.put("pointName", yyCourse.getName());
						json1.put("pointCover", yyCourse.getImg_url()!=null?yyCourse.getImg_url():"");
						json1.put("pointVideoCover", yyCourse.getImg_url()!=null?yyCourse.getImg_url():"");
						json1.put("pointVideoUrl", yyCourse.getVideo_play());
						json1.put("pointDesc", yyCourse.getInfo());
						json1.put("lessonId", yyCourse.getClassify_id());
						
						String lessonName = "";
						String moduleName = "";
						Long themeId = 0L;
						//查询父级
						YyCourseClassify yyCourseClassifyP = new YyCourseClassify();
						yyCourseClassifyP.setId(yyCourse.getClassify_id());
						yyCourseClassifyP.setSortColumn("a.sort_id asc");
						yyCourseClassifyP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyP);
						if(yyCourseClassifyP!=null){
							json1.put("lessonName", yyCourseClassifyP.getName());
							lessonName =  yyCourseClassifyP.getName();
							//查询父级
							YyCourseClassify yyCourseClassifyPP = new YyCourseClassify();
							yyCourseClassifyPP.setId(yyCourseClassifyP.getParent_id());
							yyCourseClassifyPP.setSortColumn("a.sort_id asc");
							yyCourseClassifyPP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyPP);
							if(yyCourseClassifyPP!=null){
								json1.put("moduleId", yyCourseClassifyPP.getId());
								json1.put("moduleName", yyCourseClassifyPP.getName());
								moduleName = yyCourseClassifyPP.getName();
								//查询父级
								YyCourseClassify yyCourseClassifyPPP = new YyCourseClassify();
								yyCourseClassifyPPP.setId(yyCourseClassifyPP.getParent_id());
								yyCourseClassifyPPP.setSortColumn("a.sort_id asc");
								yyCourseClassifyPPP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyPPP);
								if(yyCourseClassifyPPP!=null){
									json1.put("themeId", yyCourseClassifyPPP.getId());
									themeId = yyCourseClassifyPPP.getId();
									json1.put("themeName", yyCourseClassifyPPP.getName());
								}else{
									json1.put("themeId", 0);
									json1.put("themeName", "");
								}
							}else{
								json1.put("moduleId", 0);
								json1.put("moduleName", "");
							}
						}else{
							json1.put("lessonName", "");
							json1.put("moduleId", 0);
							json1.put("moduleName", "");
							json1.put("themeId", 0);
							json1.put("themeName", "");
						}
						//查询附件
						JSONArray arrayAppendix = new JSONArray();
						YyCourseAppendix yyCourseAppendix = new YyCourseAppendix();
						yyCourseAppendix.setCourse_id(yyCourse.getId());
						List<YyCourseAppendix> listAppendix = yycourseappendixService.getYyCourseAppendixBaseList(yyCourseAppendix);
						if(listAppendix!=null&&listAppendix.size()>0){
							for(YyCourseAppendix ca:listAppendix){
								JSONObject jsonAppendix = new JSONObject();
								jsonAppendix.put("toolsUrl", ca.getUrl());
								jsonAppendix.put("toolsName", ca.getName());
								jsonAppendix.put("themeId", themeId);
								jsonAppendix.put("lessonName", lessonName);
								jsonAppendix.put("moduleName", moduleName);
								
								arrayAppendix.add(jsonAppendix);
							}
						}
						json1.put("tools", arrayAppendix);
						//查询用户身份
						YyUser yyUser = new YyUser();
						yyUser.setToken(token);
						yyUser = yyuserService.getYyUser(yyUser);
						//其他知识点
						YyCourse yyCourse1 = new YyCourse();
						yyCourse1.setOtherId(pointId);
						yyCourse1.setClassify_id(yyCourse.getClassify_id());
						List<YyCourse> listC = yycourseService.getYyCourseBaseList(yyCourse1);
						JSONArray array = new JSONArray();
						if(listC!=null&&listC.size()>0){
							for(YyCourse course:listC){
								JSONObject jsonSub = new JSONObject();
								jsonSub.put("pointVideoUrl", course.getVideo_play());
								jsonSub.put("pointId", course.getId());
								jsonSub.put("pointVideoTime", course.getWhen_long());
								jsonSub.put("pointCover", course.getImg_url()!=null?course.getImg_url():"");
								jsonSub.put("pointVideoCover", course.getImg_url()!=null?course.getImg_url():"");
								jsonSub.put("pointDesc", course.getInfo());
								jsonSub.put("pointName", course.getName());
								if(yyUser!=null){
									YyUserCourse yyUserCourse = new YyUserCourse();
									yyUserCourse.setUser_id(yyUser.getId());
									yyUserCourse.setCourse_id(course.getId());
									List<YyUserCourse> listCC = yyusercourseService.getYyUserCourseBaseList(yyUserCourse);
									if(listCC!=null&&listCC.size()>0){
										YyUserCourse uc = listCC.get(0);
										jsonSub.put("studyStatus", uc.getStudy_state()==1?1:0);
									}else{
										jsonSub.put("studyStatus", 0);
									}
								}else{
									jsonSub.put("studyStatus", 0);
								}
								array.add(jsonSub);
							}
						}
						
						json1.put("points", array);
						json.put("d", json1);
						json.put("c", 0);
						json.put("m", "查询成功");
					}else{
						json.put("c", -1);
						json.put("d", new JSONObject());
						json.put("m", "暂无数据");
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
	 * 模块列表
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/moduleList", method = RequestMethod.GET)
	public String moduleList(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		Long themeId = RequestHandler.getLong(request, "themeId");
		JSONObject json = new JSONObject();
		try{
			if(themeId!=null){
				//获取子分类
				YyCourseClassify yyCourseClassify = new YyCourseClassify();
				yyCourseClassify.setParent_id(themeId);
				yyCourseClassify.setSortColumn("a.sort_id asc");
				System.out.println("-----------111--------");
				List<YyCourseClassify> list1 = yycourseclassifyService.getYyCourseClassifyBaseList(yyCourseClassify);
				if(list1!=null&&list1.size()>0){
					JSONArray array = new JSONArray();
					for(YyCourseClassify cc:list1){
						JSONObject jsonSub = new JSONObject();
						jsonSub.put("moduleId", cc.getId());
						jsonSub.put("moduleName", cc.getName());
						jsonSub.put("themeId", themeId);
						//获取子分类
						YyCourseClassify yyCourseClassify2 = new YyCourseClassify();
						yyCourseClassify2.setParent_id(cc.getId());
						yyCourseClassify2.setSortColumn("a.sort_id asc");
						System.out.println("-------------------");
						List<YyCourseClassify> list2 = yycourseclassifyService.getYyCourseClassifyBaseList(yyCourseClassify2);
						JSONArray array2 = new JSONArray();
						if(list2!=null&&list2.size()>0){
							for(YyCourseClassify cc2:list2){
								JSONObject jsonSub2 = new JSONObject();
								jsonSub2.put("lessonId", cc2.getId());
								jsonSub2.put("lessonName", cc2.getName());
								jsonSub2.put("lessonCover", cc2.getImg_url()!=null?cc2.getImg_url():"");
								array2.add(jsonSub2);
							}
						}
						jsonSub.put("lessons", array2);
						array.add(jsonSub);
						json.put("d", array);
						json.put("c", 0);
						json.put("m", "查询成功");
					}
				}else{
					json.put("c", -1);
					json.put("d", new JSONObject());
					json.put("m", "暂无数据");
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
			logger.info(exception(e));
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	
	/**
	 * 课程详情接口
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lessonDetail", method = RequestMethod.GET)
	public String lessonDetail(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		Long lessonId = RequestHandler.getLong(request, "lessonId");
//		String token = RequestHandler.getString(request, "token");
		String token = request.getHeader("token");
		JSONObject json = new JSONObject();
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				if(lessonId!=null&&StringUtils.isNotBlank(token)){
					
					YyCourseClassify yyCourseClassify = new YyCourseClassify();
					yyCourseClassify.setId(lessonId);
					yyCourseClassify.setSortColumn("a.sort_id asc");
					yyCourseClassify = yycourseclassifyService.getYyCourseClassify(yyCourseClassify);
					if(yyCourseClassify!=null&&yyCourseClassify.getId().intValue()>0){
						JSONObject jsonSub = new JSONObject();
						jsonSub.put("lessonCover", yyCourseClassify.getImg_url()!=null?yyCourseClassify.getImg_url():"");
						jsonSub.put("lessonDesc", yyCourseClassify.getInfo());
						jsonSub.put("lessonId", lessonId);
						jsonSub.put("lessonName", yyCourseClassify.getName());
						//查询加入课程状态
						//查询用户身份
						YyUser yyUser = new YyUser();
						yyUser.setToken(token);
						yyUser = yyuserService.getYyUser(yyUser);
						if(yyUser!=null){
							YyUserCourse yyUserCourse = new YyUserCourse();
							yyUserCourse.setUser_id(yyUser.getId());
							yyUserCourse.setCourse_classify_id(lessonId);
							int count = yyusercourseService.getYyUserCourseListCount(yyUserCourse);
							if(count>0){
								List<YyUserCourse> listUC = yyusercourseService.getYyUserCourseBaseList(yyUserCourse);
								for(YyUserCourse cccc:listUC){
									jsonSub.put("studyType", cccc.getStyle());
								}
	 							jsonSub.put("joinStatus", 1);
							}else{
								jsonSub.put("joinStatus", 0);
								jsonSub.put("studyType", 1);
							}
						}else{
							jsonSub.put("joinStatus", 0);
						}
						//查询父级
						YyCourseClassify yyCourseClassifyP = new YyCourseClassify();
						yyCourseClassifyP.setId(yyCourseClassify.getParent_id());
						yyCourseClassifyP.setSortColumn("a.sort_id asc");
						yyCourseClassifyP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyP);
						if(yyCourseClassifyP!=null){
							jsonSub.put("moduleId", yyCourseClassify.getParent_id());
							jsonSub.put("moduleName", yyCourseClassifyP.getName());
							//查询父级
							YyCourseClassify yyCourseClassifyPP = new YyCourseClassify();
							yyCourseClassifyPP.setId(yyCourseClassifyP.getParent_id());
							yyCourseClassifyPP.setSortColumn("a.sort_id asc");
							yyCourseClassifyPP = yycourseclassifyService.getYyCourseClassify(yyCourseClassifyPP);
							if(yyCourseClassifyPP!=null){
								jsonSub.put("themeId", yyCourseClassifyP.getParent_id());
								jsonSub.put("themeName", yyCourseClassifyPP.getName());
							}
						}
						//查询视频
						YyCourse yyCourse = new YyCourse();
						yyCourse.setClassify_id(lessonId);
						List<YyCourse> list = yycourseService.getYyCourseBaseList(yyCourse);
						if(list!=null&&list.size()>0){
							JSONArray array = new JSONArray();
							for(YyCourse course:list){
								JSONObject jsonCousre = new JSONObject();
								jsonCousre.put("pointId", course.getId());
								jsonCousre.put("pointName", course.getName());
								jsonCousre.put("pointDesc", course.getInfo());
								jsonCousre.put("pointVideoTime", course.getWhen_long());
								jsonCousre.put("pointCover", course.getImg_url()!=null?course.getImg_url():"");
								if(yyUser!=null){
									YyUserCourse yyUserCourse = new YyUserCourse();
									yyUserCourse.setUser_id(yyUser.getId());
									yyUserCourse.setCourse_id(course.getId());
									List<YyUserCourse> listC = yyusercourseService.getYyUserCourseBaseList(yyUserCourse);
									if(listC!=null&&listC.size()>0){
										YyUserCourse uc = listC.get(0);
										jsonCousre.put("studyStatus", uc.getStudy_state()==1?1:0);
									}else{
										jsonCousre.put("studyStatus", 0);
									}
								}
								array.add(jsonCousre);
							}
							jsonSub.put("points", array);
						}
						json.put("c", 0);
						json.put("d", jsonSub);
						json.put("m", "查询成功");
					}else{
						json.put("c", -1);
						json.put("d", new JSONObject());
						json.put("m", "查无此课程");
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
}
