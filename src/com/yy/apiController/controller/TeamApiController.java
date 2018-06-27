package com.yy.apiController.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.base.controller.BaseController;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.yy.yyCourse.service.YyCourseService;
import com.yy.yyCourseClassify.model.YyCourseClassify;
import com.yy.yyCourseClassify.service.YyCourseClassifyService;
import com.yy.yyUser.model.YyUser;
import com.yy.yyUser.service.YyUserService;
import com.yy.yyUserCourse.model.YyUserCourse;
import com.yy.yyUserCourse.service.YyUserCourseService;
import com.yy.yyUserStudy.model.YyUserStudy;
import com.yy.yyUserStudy.service.YyUserStudyService;

@Controller
@RequestMapping("/api/team")
public class TeamApiController extends BaseController{

	private static Logger logger = Logger.getLogger(TeamApiController.class);
	
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
	
	/**
	 * 数据统计
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/analytics", method = RequestMethod.GET)
	public String analytics(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		String token = request.getHeader("token");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				if(StringUtils.isNotBlank(token)){
					JSONObject jsonSub = new JSONObject();
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
					JSONArray arrayDetail = new JSONArray();
					JSONArray arrayReport = new JSONArray();
					if(yyUser!=null){
						//查询用户下属
						YyUser yyUserChild = new YyUser();
						yyUserChild.setParent_id(yyUser.getId());
						List<YyUser> listChild = yyuserService.getYyUserBaseList(yyUserChild);
						if(listChild!=null&&listChild.size()>0){
							for(YyUser child:listChild){
								JSONObject jsonSubChild = new JSONObject();
								JSONObject jsonSubReport = new JSONObject();
								//查询学习时间
								YyUserStudy yyUserStudy = new YyUserStudy();
								yyUserStudy.setUser_id(child.getId());
								int study_time = yyuserstudyService.getUserStudyTime(yyUserStudy);
								jsonSubChild.put("studyTimeCount", RequestHandler.secToTime(study_time));
								jsonSubReport.put("studyTimeCount", RequestHandler.secToTime(study_time));
								jsonSubChild.put("userName", child.getName());
								jsonSubReport.put("userName", child.getName());
								jsonSubReport.put("feedbackCount", 0);
								jsonSubReport.put("position", 0);
								jsonSubReport.put("lessonCount", 0);
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
											if(lessonId.intValue()==uc.getCourse_classify_id().intValue()&&uc.getStudy_state()==0){
												b = false;
												break;
											}
										}
										if(b){
											lessonCount = lessonCount + 1;
										}
									}
									lessonCounting = list.size() - lessonCount;
									jsonSubReport.put("lessonCount", list.size());
								}
								//计算完成课程数量结束
								jsonSubChild.put("studiedCount", lessonCount);
								jsonSubChild.put("studyingCount", lessonCounting);
								arrayDetail.add(jsonSubChild);
								arrayReport.add(jsonSubReport);
							}
						}
						jsonSub.put("dataDetail", arrayDetail);
						jsonSub.put("dataReport", arrayReport);
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
	 * 课程管理
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/lessonList", method = RequestMethod.GET)
	public String lessonList(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		String token = request.getHeader("token");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
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
					JSONArray array = new JSONArray();
					if(yyUser!=null){
						//查询用户下属所有课程
						YyUserCourse yyUserCourse = new YyUserCourse();
						yyUserCourse.setUser_parent_id(yyUser.getId());
						yyUserCourse.setStyle(0);
						List<YyUserCourse> listC = yyusercourseService.getYyUserCourseByUser(yyUserCourse);
						if(listC!=null&&listC.size()>0){
							for(YyUserCourse uc:listC){
								JSONObject jsonSub = new JSONObject();
								jsonSub.put("themeId", uc.getThemeId());
								jsonSub.put("themeName", uc.getThemeName());
								jsonSub.put("lessonId", uc.getLessonId());
								jsonSub.put("lessonName", uc.getLessonName());
								jsonSub.put("moduleId", uc.getModuleId());
								jsonSub.put("moduleName", uc.getModuleName());
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
										jsonSub.put("finishTime", sf.format(lastUser.getOver_time()));
										jsonSub.put("overDays", yyusercourseService.differentDays(new Date(), lastUser.getOver_time()));
									}
								}else{
									jsonSub.put("finishTime", 0);
									jsonSub.put("overDays", 0);
								}
								//查询课程分配人员
								YyUserCourse usercourse = new YyUserCourse();
								usercourse.setCourse_classify_id(uc.getCourse_classify_id());
								usercourse.setUser_parent_id(yyUser.getId());
								usercourse.setStyle(0);
								List<YyUserCourse> listU = yyusercourseService.getStudyUser(usercourse);
								JSONArray arrayUser = new JSONArray();
								if(listU!=null&&listU.size()>0){
									for(YyUserCourse user:listU){
										arrayUser.add(user.getUser_name());
									}
									jsonSub.put("memberCount", listU.size());
								}else{
									jsonSub.put("memberCount", 0);
								}
								jsonSub.put("members", arrayUser);
								array.add(jsonSub);
							}
						}
						json.put("c", 0);
						json.put("d", array);
						json.put("m", "查询成功");
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
	
}
