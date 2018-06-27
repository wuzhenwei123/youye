package com.base.controller;

import java.util.Date;
import java.util.Enumeration;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.base.exception.BaseException;
import com.base.utils.ConfigConstants;
import com.base.utils.MD5;
import com.base.utils.ResultRsp;
import com.base.utils.SessionName;
import com.base.utils.StandardOutput;
import com.wx.service.WeiXinService;
import com.yy.yyCompany.model.YyCompany;
import com.yy.yyCompany.service.YyCompanyService;
import com.yy.yyUser.model.YyUser;
import com.yy.yyUser.service.YyUserService;

/**
 * 
 * @author zhanglib
 *
 */
@Controller
public class BaseController extends BaseException {
	protected static MD5 MD5 = new MD5();
	
	@Autowired
	private WeiXinService weiXinService;
	@Autowired
	private YyUserService yyuserService = null;
	@Autowired
	private YyCompanyService yycompanyService = null;
	
	private static Logger logger = Logger.getLogger(BaseController.class); // Logger
	final static String[] patterns = { 
		"yyyyMMdd", 
		"yyyy-MM-dd",
		"yyyy-MM-dd HH:mm:ss", 
		"yyyy.MM.dd", 
		"yyyy/MM/dd HH:mm:ss" 
		};// 限定日期的格式字符串数组

	@ExceptionHandler(RuntimeException.class)
	public String operateExp(RuntimeException ex, HttpServletRequest request) {
		String exceptionCode = exception(ex);
		logger.info("系统异常" + exceptionCode);
		request.setAttribute("errorTips", exceptionCode);
		return "/sys/exception/exception";
	}

	public static <T> T requst2Bean(HttpServletRequest request, Class<T> bean) {
		T t = null;
		try {
			t = bean.newInstance();
			Enumeration<?> parameterNames = request.getParameterNames();
			DateConverter convert = new DateConverter();// 写一个日期转换器
			convert.setPatterns(patterns);
			ConvertUtils.register(convert, Date.class);
			while (parameterNames.hasMoreElements()) {
				String name = (String) parameterNames.nextElement();
				String value = request.getParameter(name);
				if (value != null && !"".equals(value) && !"null".equals(value)) {
					BeanUtils.setProperty(t, name, value);// 使用BeanUtils来设置对象属性的值
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return t;

	}

	protected void writeSuccessMsg(String message, Object data,
			HttpServletResponse paramHttpServletResponse) {
		ResultRsp localObject = new ResultRsp("1", message, data);
		StandardOutput.printObject(paramHttpServletResponse, localObject);
	}

	protected void write(Object data,
			HttpServletResponse paramHttpServletResponse) {
		StandardOutput.print(paramHttpServletResponse, data);
	}

	protected void writeErrorMsg(String message, Object data,
			HttpServletResponse paramHttpServletResponse) {
		ResultRsp localObject = new ResultRsp("-1", message, data);
		StandardOutput.printObject(paramHttpServletResponse, localObject);
	}

	protected void addSession(HttpServletRequest request, String key,
			Object value) {
		if (key != null) {
			request.getSession().setAttribute(key, value);
		}
	}
	
	protected void writeJsonObject(Object data,
			HttpServletResponse paramHttpServletResponse) {
		StandardOutput.printObject(paramHttpServletResponse, data);
	}

	protected void removeSession(HttpServletRequest request, String key) {
		if (key != null) {
			request.getSession().removeAttribute(key);
		}
	}
	
	/**
	 * 微信分享获取的参数
	 * @param request
	 */
	protected void getJsticket(HttpServletRequest request){
		String   url  = request.getScheme()+"://"; //请求协议 http 或 https  
		url+=request.getHeader("host");  // 请求服务器  
		url+=request.getRequestURI();     // 工程名    
		if(request.getQueryString()!=null) //判断请求参数是否为空
		url+="?"+request.getQueryString();   // 参数 
		System.out.println("url================="+url);
		try {
			Map<String,String> map = weiXinService.getJsticket(ConfigConstants.APPID, ConfigConstants.APPSECRET, url);
			request.setAttribute("noncestr", map.get("noncestr"));
			request.setAttribute("timestamp", map.get("timestamp"));
			request.setAttribute("signature", map.get("signature"));
			request.setAttribute("appid", ConfigConstants.APPID);
			request.setAttribute("server_href", ConfigConstants.URL_PATH);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected Object getSession(HttpServletRequest request, String key) {
		if (key != null) {
			return request.getSession().getAttribute(key);
		}
		return null;
	}
	protected Integer getCurrentAdminUserId(HttpServletRequest request) {
		Object obj = getSession(request, SessionName.ADMIN_USER_ID);
		if(obj != null){
			return Integer.valueOf(obj.toString());
		}
		return null;
	}
	
	
	public String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Real-IP");
        if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
            return ip;
        }
        ip = request.getHeader("X-Forwarded-For");
        if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个IP值，第一个为真实IP。
            int index = ip.indexOf(',');
            if (index != -1) {
                return ip.substring(0, index);
            } else {
                return ip;
            }
        } else {
            return request.getRemoteAddr();
        }
    }
	
	/**
	 * 验证token有效性
	 * @param request
	 * @return
	 */
	protected boolean checkToken(HttpServletRequest request){
		String token = request.getHeader("token");
		if(StringUtils.isNotBlank(token)){
			//查询用户身份
			YyUser yyUser = new YyUser();
			yyUser.setToken(token);
			yyUser = yyuserService.getYyUser(yyUser);
			if(yyUser!=null&&yyUser.getId()>0){
				//验证公司状态
				YyCompany yyCompany = new YyCompany();
				yyCompany.setId(yyUser.getCompany_id());
				yyCompany = yycompanyService.getYyCompany(yyCompany);
				if(yyCompany.getState().intValue()==1){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
	}
}
