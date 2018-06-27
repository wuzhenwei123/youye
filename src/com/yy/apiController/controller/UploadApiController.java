package com.yy.apiController.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.base.controller.BaseController;
import com.base.utils.DateFormatToString;
import com.base.utils.ConfigConstants;
import com.base.utils.PicCompression;
import com.base.utils.RequestHandler;
import com.base.utils.ResponseList;
import com.base.vod.VodDemo;
import com.yy.yyCourse.model.YyCourse;
import com.yy.yyCourse.service.YyCourseService;
import com.yy.yyCourseAppendix.model.YyCourseAppendix;
import com.yy.yyCourseAppendix.service.YyCourseAppendixService;
import com.yy.yyCourseClassify.model.YyCourseClassify;
import com.yy.yyCourseClassify.service.YyCourseClassifyService;
import com.yy.yyUser.model.YyUser;
import com.yy.yyUser.service.YyUserService;
import com.yy.yyUserCourse.service.YyUserCourseService;
import com.yy.yyUserStudy.service.YyUserStudyService;

/**
 * @author keeny
 * @time 2015年02月04日 21:27:20
 */
@Controller
@RequestMapping("/api")
public class UploadApiController extends BaseController {

	
	private static Logger logger = Logger.getLogger(UploadApiController.class);
	
	@Autowired
	private YyUserService yyuserService = null;
	@Autowired
	private YyUserStudyService yyuserstudyService = null;
	@Autowired
	private YyUserCourseService yyusercourseService = null;
	@Autowired
	private YyCourseClassifyService yycourseclassifyService = null;
	@Autowired
	private YyCourseAppendixService yycourseappendixService = null;
	@Autowired
	private YyCourseService yycourseService = null;
	
	/**
	 * 搜索
	 * @param response
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(HttpServletResponse response,HttpServletRequest request, Model model) throws Exception{
		JSONObject json = new JSONObject();
		String token = request.getHeader("token");
		String keyword = RequestHandler.getString(request, "keyword");
		try{
			if(!super.checkToken(request)){
				json.put("c", 20002);
				json.put("d", new JSONObject());
				json.put("m", "token无效");
			}else{
				if(StringUtils.isNotBlank(keyword)&&StringUtils.isNotBlank(token)){
					//查询用户身份
					YyUser yyUser = new YyUser();
					yyUser.setToken(token);
					yyUser = yyuserService.getYyUser(yyUser);
					
					if(yyUser!=null){
						JSONObject jsonSub = new JSONObject();
						JSONArray arrayLesson = new JSONArray();
						JSONArray arrayTool = new JSONArray();
						JSONArray arrayPoint = new JSONArray();
						YyCourseClassify yyCourseClassify = new YyCourseClassify();
						yyCourseClassify.setKeyword(keyword);
						List<YyCourseClassify> list = yycourseclassifyService.getYyCourseClassifyBaseList(yyCourseClassify);
						Set<Long> set = new HashSet<Long>();
						if(list!=null&&list.size()>0){
							for(YyCourseClassify cc:list){
								if(cc.getLevel()==3){
									Integer cc_size1 = set.size();
									set.add(cc.getId());
									Integer cc_size2 = set.size();
									if(cc_size2!=cc_size1){
										jsonSub = this.getSearchResult(jsonSub, cc, arrayLesson,arrayTool,arrayPoint);
									}
								}else if(cc.getLevel()==2){
									//查询下面的课程
									YyCourseClassify yyCourseClassifySub = new YyCourseClassify();
									yyCourseClassifySub.setParent_id(cc.getId());
									List<YyCourseClassify> listSub = yycourseclassifyService.getYyCourseClassifyBaseList(yyCourseClassifySub);
									if(listSub!=null&&listSub.size()>0){
										for(YyCourseClassify ccSub:listSub){
											Integer cc_size1 = set.size();
											set.add(ccSub.getId());
											Integer cc_size2 = set.size();
											if(cc_size2!=cc_size1){
												jsonSub = this.getSearchResult(jsonSub, ccSub, arrayLesson,arrayTool,arrayPoint);
											}
										}
									}
								}else if(cc.getLevel()==1){
									//查询下面的课程
									YyCourseClassify yyCourseClassifySub = new YyCourseClassify();
									yyCourseClassifySub.setTheme_id(cc.getId());
									List<YyCourseClassify> listSub = yycourseclassifyService.getCourseClassifyByKeyWord(yyCourseClassifySub);
									if(listSub!=null&&listSub.size()>0){
										for(YyCourseClassify ccSub:listSub){
											Integer cc_size1 = set.size();
											set.add(ccSub.getId());
											Integer cc_size2 = set.size();
											if(cc_size2!=cc_size1){
												jsonSub = this.getSearchResult(jsonSub, ccSub, arrayLesson,arrayTool,arrayPoint);
											}
										}
									}
								}
								
							}
							
						}
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
	
	@RequestMapping(value = "/upload")
	public String upload(HttpServletRequest request, HttpServletResponse response,String proVal,String type) throws Exception{
		
		JSONObject json = new JSONObject();
		json.put("c", -1);
		json.put("d", new JSONObject());
		List<Map<String, Object>> reList = new ArrayList<Map<String, Object>>();
		// 获取文件扩展名
		try {
			String fileToday = DateFormatUtils.format(new Date(), "yyyy/MM/dd");
			
			// 获取保存文件的最终路径
			String saveFilePath = ConfigConstants.UPLOAD_FILE_ROOT;
//			String proPath = ConfigConstants.getPropValue(proVal);
			if (saveFilePath == null) {
				writeErrorMsg("保持图片根目录不能为空", null, response);
				return null;
			}
			// 获取文件
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			List<MultipartFile> uploadlist = multipartRequest.getFiles("file");
			
			String oldFileName = "", newFileName = "";
			for (int i = 0; i < uploadlist.size(); i++) {
				MultipartFile item = (MultipartFile) uploadlist.get(i);
				if (!item.isEmpty()) {// 处理文件上传域// 忽略其他不是文件域的所有表单信息
					String uuName = System.currentTimeMillis() + UUID.randomUUID().toString().split("-")[0];// 新文件名
					String filename = item.getOriginalFilename();// 取到客户端完整 路径+文件名
					oldFileName = FilenameUtils.getName(filename);// 取到文件名
					oldFileName = new String( oldFileName.getBytes("ISO-8859-1"), "UTF-8");
					String ext = FilenameUtils.getExtension(filename);// 扩展名
					newFileName =  File.separator + fileToday + File.separator + uuName + "." + ext;// 新路径
					File file = new File(saveFilePath + newFileName);
					if (!file.getParentFile().exists()) {
						file.getParentFile().mkdirs();
					}
					SaveFileFromInputStream(item.getInputStream(), saveFilePath, newFileName);//源文件
					if (StringUtils.isNotBlank(type) && type.equals("pic")) {
						PicCompression .resize(file,file);//等比例压缩文件
						PicCompression .resize(file, new File(getSPic( file.getAbsolutePath(), "_200")), 200);//200像素文件
						PicCompression .resize(file, new File(getSPic( file.getAbsolutePath(), "_100")), 100);//100像素文件
					}
					Map<String, Object> rtnMap = new HashMap<String, Object>();
					rtnMap.put("filePath", newFileName.replace("\\", "/"));
					rtnMap.put("fileName", oldFileName);
					rtnMap.put("fileSize", item.getSize());
					rtnMap.put("oldFileName", filename);
					reList.add(rtnMap);
					json.put("d", newFileName.replace("\\", "/"));
					json.put("m", "上传成功");
					json.put("c", 0);
				}else{
					json.put("m", "上传失败，请重试");
				}
			}
		} catch (Exception e) {
			json.put("m", "系统异常，请重试");
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.setHeader("Cache-Control","no-cache");
		response.getWriter().write(json.toString());
		return null;
	}
	
	/**
	 * 
	 * @param stream 文件流
	 * @param path 路径
	 * @param filename 文件名称
	 * @throws IOException
	 */
	private void SaveFileFromInputStream(InputStream stream, String path, String filename) throws IOException {
		FileOutputStream fs = new FileOutputStream(path + "/" + filename);
		byte[] buffer = new byte[1024 * 1024];
		int byteread = 0;
		while ((byteread = stream.read(buffer)) != -1) {
			fs.write(buffer, 0, byteread);
			fs.flush();
		}
		fs.close();
		stream.close();
	}
	private String getSPic(String path, String exName) {

		if (path != null) {
			String ex = path.substring(path.lastIndexOf("."), path.length());
			String fp = path.substring(0, path.lastIndexOf(".")) + exName;
			return fp + ex;
		}
		return null;
	}
	
	/**
	 * 关键字搜索
	 * @param jsonSub
	 * @param cc
	 * @return
	 */
	public JSONObject getSearchResult(JSONObject jsonSub,YyCourseClassify cc,JSONArray arrayLesson,JSONArray arrayTool,JSONArray arrayPoint){
		try{
			
			JSONObject jsonLession = new JSONObject();
			jsonLession.put("lessonId", cc.getId());
			jsonLession.put("lessonName", cc.getName());
			//获取父级信息
			YyCourseClassify ccLession = new YyCourseClassify();
			ccLession.setId(cc.getId());
			List<YyCourseClassify> pLessonList = yycourseclassifyService.getCourseClassifyParents(ccLession);
			if(pLessonList!=null&&pLessonList.size()>0){
				ccLession = pLessonList.get(0);
				jsonLession.put("themeId", ccLession.getTheme_id());
				jsonLession.put("moduleName", ccLession.getModule_name());
			}else{
				jsonLession.put("themeId", "");
				jsonLession.put("moduleName", "");
			}
			arrayLesson.add(jsonLession);
			//查询所有工具
			YyCourseAppendix yyCourseAppendix = new YyCourseAppendix();
			yyCourseAppendix.setClassify_id(cc.getId());
			List<YyCourseAppendix> listCa = yycourseappendixService.getYyCourseAppendixBaseList(yyCourseAppendix);
			if(listCa!=null&&listCa.size()>0){
				for(YyCourseAppendix ca:listCa){
					JSONObject jsonTool = new JSONObject();
					jsonTool.put("toolsName", ca.getName());
					jsonTool.put("toolsUrl", ca.getUrl());
					jsonTool.put("lessonName", ca.getCourse_name());
					if(pLessonList!=null&&pLessonList.size()>0){
						ccLession = pLessonList.get(0);
						jsonTool.put("themeId", ccLession.getTheme_id());
						jsonTool.put("moduleName", ccLession.getModule_name());
					}else{
						jsonTool.put("themeId", "");
						jsonTool.put("moduleName", "");
					}
					arrayTool.add(jsonTool);
				}
			}
			//查询下面所有知识点
			YyCourse yyCourse = new YyCourse();
			yyCourse.setClassify_id(cc.getId());
			List<YyCourse> listC = yycourseService.getYyCourseListByClassify(yyCourse);
			if(listC!=null&&listC.size()>0){
				for(YyCourse c:listC){
					JSONObject jsonCourse = new JSONObject();
					jsonCourse.put("videoTime", c.getWhen_long());
					jsonCourse.put("videoCover", c.getImg_url());
					jsonCourse.put("lessonName", c.getLesson_name());
					jsonCourse.put("moduleName", c.getModule_name());
					jsonCourse.put("themeId", c.getTheme_id());
					jsonCourse.put("contentPointId", c.getId());
					jsonCourse.put("contentPointName", c.getName());
					
					arrayPoint.add(jsonCourse);
				}
			}
			jsonSub.put("lesson", arrayLesson);
			jsonSub.put("tools", arrayTool);
			jsonSub.put("contentPoint", arrayPoint);
		}catch(Exception e){
			e.printStackTrace();
		}
		return jsonSub;
	}
	
}
