<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
var ua = navigator.userAgent.toLowerCase();
if (ua.match(/MicroMessenger/i) != "micromessenger") {//非微信
 	window.location.href="http://admin.yoitree.com.cn/tip.jsp";
}

wx.config({
    debug: false,
    appId: '${appid}', 
    timestamp: ${timestamp}, 
    nonceStr: '${noncestr}', 
    signature: '${signature}',
    jsApiList: [
    	'onMenuShareTimeline',
		'onMenuShareAppMessage',
		'chooseImage',
		'uploadImage',
		'hideMenuItems'
    ] 
});
wx.ready(function(){
	wx.hideMenuItems({
	    menuList: [
	    	'menuItem:share:qq',
	    	'menuItem:share:weiboApp',
	    	'menuItem:favorite',
	    	'menuItem:editTag',
	    	'menuItem:delete',
	    	'menuItem:copyUrl',
	    	'menuItem:originPage',
	    	'menuItem:readMode',
	    	'menuItem:openWithQQBrowse',
	    	'menuItem:openWithSafari',
	    	'menuItem:share:email',
	    	'menuItem:share:brand'
	    ]
	});
});
if (typeof WeixinJSBridge == "undefined"){
   if( document.addEventListener ){
       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
   }else if (document.attachEvent){
       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
   }
}else{
   onBridgeReady();
}

function onBridgeReady(){
	
// 	wx.onMenuShareTimeline({
// 	    title: '${mscomposition.title}', // 分享标题
// 	    link: '${server_href}/msComposition/yulan?id=${composition_id}', // 分享链接
// 	    imgUrl: '${server_href}/images/wx/k_logo_img.png', // 分享图标
// 	    success: function () { 
// 	    	$.get("${ctx}/zuowen/fenxiang?composition_id=${composition_id}",function(data){});
// 	    },
// 	    cancel: function () { 
// 	        用户取消分享后执行的回调函数
// 	    }
// 	});
// 	wx.onMenuShareAppMessage({
// 	    title: '${mscomposition.title}', // 分享标题
// 	    desc: '${mscomposition.title}', // 分享描述
// 	    link: '${server_href}/msComposition/yulan?id=${composition_id}', // 分享链接
// 	    imgUrl: '${server_href}/images/wx/k_logo_img.png', // 分享图标
// 	    type: 'link', // 分享类型,music、video或link，不填默认为link
// 	    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
// 	    success: function () { 
// 	        用户确认分享后执行的回调函数
// 	    	$.get("${ctx}/zuowen/fenxiang?composition_id=${composition_id}",function(data){});
// 	    },
// 	    cancel: function () { 
// 	        用户取消分享后执行的回调函数
// 	    }
// 	});
}
</script>