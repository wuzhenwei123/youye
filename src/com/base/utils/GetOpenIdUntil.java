package com.base.utils;


import com.alibaba.fastjson.JSONObject;
import com.base.utils.https.HttpUtils;
import com.wx.utils.https.HttpRequest;

public class GetOpenIdUntil {
	
	/**
	 * 第三方获取aouth2.0网页认证
	 */
	public static String getAuthorizeCode(String state) throws Exception {
		StringBuffer getCodeUrl = new StringBuffer();
        getCodeUrl.append("https://open.weixin.qq.com/connect/oauth2/authorize?");
        getCodeUrl.append("appid="+ConfigConstants.APPID);
        String backUri = ConfigConstants.REDIRECT_URI; 
        backUri = backUri.replaceAll(":","%3A");
        backUri = backUri.replaceAll("/","%2F");

        getCodeUrl.append("&redirect_uri="+backUri); //重定向url
        getCodeUrl.append("&&response_type=code&scope=snsapi_base");
        getCodeUrl.append("&state="+state); //扩展参数
        getCodeUrl.append("#wechat_redirect");
        return getCodeUrl.toString();
	}
	
	/**
	 * 第三方获取aouth2.0网页认证
	 */
	
	public static JSONObject getOpenId(String APPID, String code ,String SECRET) throws Exception {
//		String jsonStr = HttpRequest.sendGet("https://api.weixin.qq.com/sns/oauth2/access_token", "appid="+APPID+"&secret="+SECRET+"&code="+code+"&grant_type=authorization_code");
		
		String param = "appid="+APPID+"&secret="+SECRET+"&code="+code+"&grant_type=authorization_code";
    	String jsonStr = HttpUtils.httpsRequest("https://api.weixin.qq.com/sns/oauth2/access_token", "GET", param);
		
		JSONObject json = JSONObject.parseObject(jsonStr);
		return json;
	}

}
