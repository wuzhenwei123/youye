package com.wx.service;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.base.utils.ConfigConstants;
import com.base.utils.DateFormatToString;
import com.base.utils.SessionName;
import com.base.utils.https.HttpUtils;
import com.sys.adminUserRole.dao.AdminUserRoleDAO;
import com.sys.adminUserRole.model.AdminUserRole;
import com.sys.manageAdminUser.dao.ManageAdminUserDAO;
import com.sys.manageAdminUser.model.ManageAdminUser;
import com.wx.utils.EncryptUtil;
import com.wx.utils.FileUtils;
import com.wx.utils.MD5;
import com.wx.utils.WxApiURL;
import com.wx.utils.WxMenuUtils;
import com.wx.utils.https.HttpClientConnectionManager;
import com.wx.utils.https.HttpRequest;
import com.yy.yyCompany.dao.YyCompanyDAO;
import com.yy.yyCompany.model.YyCompany;
import com.yy.yyUser.dao.YyUserDAO;
import com.yy.yyUser.model.YyUser;

@Component
@Transactional
public class WeiXinService {
	
	Logger log = Logger.getLogger(WeiXinService.class);
	
	@Resource(name = "manageAdminUserDao")
    private ManageAdminUserDAO manageAdminUserDAO;
	@Resource(name = "adminUserRoleDao")
    private AdminUserRoleDAO adminUserRoleDAO;
	@Resource(name = "yyUserDao")
    private YyUserDAO yyUserDAO;
	@Resource(name = "yyCompanyDao")
    private YyCompanyDAO yyCompanyDAO;
	

	public static Map<String, JSONObject> TOKEN_MAP = null;
	public static Map<String, JSONObject> TICKET_MAP = null;
	public static Integer LOGINNAME_COUNT = null;


	/**
	 * 获取accessToken
	 */
	public String getAccessToken(String appid, String secret) throws Exception {
		if (TOKEN_MAP == null) {
			TOKEN_MAP = new HashMap<String, JSONObject>();
		} else {
			JSONObject tokenJson = TOKEN_MAP.get(appid);
			if (tokenJson != null) {
				int expires_in = (Integer) tokenJson.getInteger("expires_in");// token时间
				Long time = (new Date()).getTime() / 1000;
				if (time.intValue() < expires_in) {
					return tokenJson.getString("access_token");
				}
			}
		}
		
//		String jsonStr = HttpRequest.sendGet("https://api.weixin.qq.com/cgi-bin/token", "grant_type=client_credential&appid=" + appid + "&secret=" + secret);
		
		String param = "grant_type=client_credential&appid=" + appid + "&secret=" + secret;
    	String jsonStr = HttpUtils.httpsRequest("https://api.weixin.qq.com/cgi-bin/token", "GET", param);
		
//		HttpGet get = HttpClientConnectionManager.getGetMethod("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appid + "&secret=" + secret);  
//        HttpResponse response = WxMenuUtils.httpclient.execute(get);  
//        String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");  
		
		JSONObject object = JSON.parseObject(jsonStr);
		if (object.getInteger("expires_in") != null) {
			Long time = (new Date()).getTime() / 1000;
			int expires_in = time.intValue() + 7000;
			object.put("expires_in", expires_in);
			TOKEN_MAP.put(appid, object);
		}
		return object.getString("access_token");
	}

	/**
	 * 获取jsapi_ticket
	 * 
	 * @param accessToken
	 * @return
	 */
	public String getTicket(String appid, String secret) throws Exception {
		if (TICKET_MAP == null) {
			TICKET_MAP = new HashMap<String, JSONObject>();
		} else {
			JSONObject ticketJson = TICKET_MAP.get(appid);
			if (ticketJson != null) {
				int expires_in = (Integer) ticketJson.getInteger("expires_in");// token时间
				Long time = (new Date()).getTime() / 1000;
				if (time.intValue() < expires_in) {
					return ticketJson.getString("ticket");
				}
			}
		}
		String accessToken = this.getAccessToken(appid, secret);
		System.out.println("accessToken========================="+accessToken);
		
//		String jsonStr = HttpRequest.sendGet("https://api.weixin.qq.com/cgi-bin/ticket/getticket", "access_token=" + accessToken + "&type=jsapi");
		
		String param = "access_token=" + accessToken + "&type=jsapi";
    	String jsonStr = HttpUtils.httpsRequest("https://api.weixin.qq.com/cgi-bin/ticket/getticket", "GET", param);
    	
//    	HttpGet get = HttpClientConnectionManager.getGetMethod("https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" + accessToken + "&type=jsapi");  
//        HttpResponse response = WxMenuUtils.httpclient.execute(get);  
//        String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");  
		
		System.out.println("jsonStr========================="+jsonStr);
		JSONObject object = JSON.parseObject(jsonStr);
		if (object.getInteger("expires_in") != null) {
			Long time = (new Date()).getTime() / 1000;
			int expires_in = time.intValue() + 7000;
			object.put("expires_in", expires_in);
			TICKET_MAP.put(appid, object);
		}
		return object.getString("ticket");
	}

	/**
	 * 获取请求js的凭据
	 * 
	 * @param appid
	 * @param secret
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getJsticket(String appid, String secret, String url) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		String noncestr = UUID.randomUUID().toString();
		String timestamp = Long.toString(System.currentTimeMillis() / 1000);
		String jsapi_ticket = this.getTicket(appid, secret);
		map.put("noncestr", noncestr);
		map.put("timestamp", timestamp);
		map.put("jsapi_ticket", jsapi_ticket);
		map.put("url", url);
		System.out.println("jsapi_ticket==============="+jsapi_ticket);
		String str = this.paramLinks(map);
		MessageDigest crypt = MessageDigest.getInstance("SHA-1");
		crypt.reset();
		crypt.update(str.getBytes("UTF-8"));
		String signature = byteToHex(crypt.digest());
		map.put("signature", signature);
		return map;
	}

	/**
	 * 获取aouth2.0网页认证返回码
	 */
	public String getAccessCode(String APPID, String SECRET, String code) throws Exception {
		
		String jsonStr = HttpRequest.sendGet(WxApiURL.GET_AOUTH_URL, "appid=" + APPID + "&secret=" + SECRET + "&code=" + code + "&grant_type=authorization_code");
		return jsonStr;
	}

	/**
	 * 获取用户基本信息
	 */

	public String getFromUserMess(String accessToken, String openID) throws Exception {
		String jsonStr = HttpRequest.sendGet(WxApiURL.GET_USERINFO_URL, "access_token=" + accessToken + "&openid=" + openID + "&lang=zh_CN");
		return jsonStr;
	}

	/**
	 * 发送客服消息
	 */

	public void sendMessage(String params, String accessToken) throws Exception {
		
		String jsonStr = HttpRequest.sendGet(WxApiURL.SEND_MESSAGE, "access_token=" + accessToken);
		System.out.println(JSON.parseObject(jsonStr).get("errmsg"));
	}

	/**
	 * 参数拼接
	 * */
	public String paramLinks(Map<String, String> params) {

		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);

		String prestr = "";

		for (int i = 0; i < keys.size(); i++) {
			String key = keys.get(i);
			String value = params.get(key);

			if (i == keys.size() - 1) {// 拼接时，不包括最后一个&字符
				prestr = prestr + key + "=" + value;
			} else {
				prestr = prestr + key + "=" + value + "&";
			}
		}

		return prestr;
	}

	private String byteToHex(final byte[] hash) {
		Formatter formatter = new Formatter();
		for (byte b : hash) {
			formatter.format("%02x", b);
		}
		String result = formatter.toString();
		formatter.close();
		return result;
	}

	
	
	
	/**
     * 获取UUID
     * @return
     */
    public String getUUID(){
        UUID uuid = UUID.randomUUID();
        String str = uuid.toString();
        // 去掉"-"符号
        String temp = str.replace("-","");
        return temp;
    }
    
   
	
	/**
	 * 从输入流中读取数据
	 * 
	 * @param inStream
	 * @return
	 * @throws Exception
	 */
	public byte[] readInputStream(InputStream inStream) throws Exception {
		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = inStream.read(buffer)) != -1) {
			outStream.write(buffer, 0, len);
		}
		byte[] data = outStream.toByteArray();// 网页的二进制数据
		outStream.close();
		inStream.close();
		return data;
	}
	
	
	
	
	public String getBaiDuLocationXY(String x, String y) {
		
		String adcode = null;
		try{
			String url1 = "http://api.map.baidu.com/geocoder/v2/";
        	String jsonStr = HttpRequest.sendGet(url1, "ak=kqbMjjFSG8p3vvAcUNNB8558y5hyRXZD&callback=renderReverse&location="+x+","+y+"&output=json&pois=0");
        	if(StringUtils.isNotBlank(jsonStr)){
        		jsonStr = jsonStr.replaceAll("renderReverse&&renderReverse", "").replaceAll("\\(", "").replaceAll("\\)", "");
        	}
        	JSONObject object = JSON.parseObject(jsonStr);
            String jsonStr1 = object.getString("result");
            JSONObject object1 = JSON.parseObject(jsonStr1);
            String jsonStr2 = object1.getString("addressComponent");
            JSONObject object2 = JSON.parseObject(jsonStr2);
            adcode = object2.getString("adcode");
		}catch(Exception e){
			e.printStackTrace();
		}
        	
		return adcode;
    }
	
	//检测是否绑定
	public boolean isBind(String openId,HttpServletRequest request){
		
		try{
			YyUser yyUser = new YyUser();
			yyUser.setOpenId(openId);
			yyUser.setState(1);
			int count = yyUserDAO.getYyUserListCount(yyUser);
			if(count==1){
				yyUser = yyUserDAO.getYyUser(yyUser);
				//验证公司状态
				YyCompany yyCompany = new YyCompany();
				yyCompany.setId(yyUser.getCompany_id());
				yyCompany = yyCompanyDAO.getYyCompany(yyCompany);
				if(yyCompany.getState().intValue()==1){
					// 正常
					request.getSession().setAttribute(SessionName.ADMIN_USER_NAME, yyUser.getName());
					request.getSession().setAttribute(SessionName.ADMIN_USER_ID, yyUser.getId());
					request.getSession().setAttribute(SessionName.ADMIN_USER, yyUser);
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	
	
	public static InputStream getInputStream(String accessToken, String mediaId) {  
        InputStream is = null;  
        String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="  
                + accessToken + "&media_id=" + mediaId;  
        try {  
            URL urlGet = new URL(url);  
            HttpURLConnection http = (HttpURLConnection) urlGet  
                    .openConnection();  
            http.setRequestMethod("GET"); // 必须是get方式请求  
            http.setRequestProperty("Content-Type",  
                    "application/x-www-form-urlencoded");  
            http.setDoOutput(true);  
            http.setDoInput(true);  
            System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒  
            System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒  
            http.connect();  
            // 获取文件转化为byte流  
            is = http.getInputStream();  
  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return is;  
  
    }  
  
    /** 
     *  
     * 获取下载图片信息（jpg） 
     *  
     *  
     *  
     * @param mediaId 
     *  
     *            文件的id 
     *  
     * @throws Exception 
     */  
  
    public static void saveImageToDisk(String accessToken, String mediaId, String picName, String picPath)  
            throws Exception {  
        InputStream inputStream = getInputStream(accessToken, mediaId);  
        byte[] data = new byte[10240];  
        int len = 0;  
        FileOutputStream fileOutputStream = null;  
        try {  
            fileOutputStream = new FileOutputStream(picPath+picName+".jpg");  
            while ((len = inputStream.read(data)) != -1) {  
                fileOutputStream.write(data, 0, len);  
            }  
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (inputStream != null) {  
                try {  
                    inputStream.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (fileOutputStream != null) {  
                try {  
                    fileOutputStream.close();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
    } 
	
}
