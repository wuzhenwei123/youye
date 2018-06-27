<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="weui-tabbar foot_nav">
    <a href="${ctx}/weixin/toLearn?openId=${openId}" class="weui-tabbar__item <c:if test="${nav=='learn'}">foot_nav_item_on</c:if>">
        <i class="weui-tabbar__icon <c:if test="${nav=='learn'}">study_icon_on</c:if><c:if test="${nav!='learn'}">study_icon</c:if>"></i>
        <p class="weui-tabbar__label" style="line-height:normal;">学习</p>
    </a>
    <a href="${ctx}/weixin/toCourse?openId=${openId}" class="weui-tabbar__item <c:if test="${nav=='course'}">foot_nav_item_on</c:if>">
       <i class="weui-tabbar__icon <c:if test="${nav=='course'}">cur_icon_on</c:if><c:if test="${nav!='course'}">cur_icon</c:if>"></i>
       <p class="weui-tabbar__label" style="line-height:normal;">课程</p>
    </a>
    <a href="${ctx}/weixin/toMyInfo?openId=${openId}" class="weui-tabbar__item <c:if test="${nav=='myinfo'}">foot_nav_item_on</c:if>">
       <i class="weui-tabbar__icon <c:if test="${nav=='myinfo'}">my_icon_on</c:if><c:if test="${nav!='myinfo'}">my_icon</c:if>"></i>
       <p class="weui-tabbar__label" style="line-height:normal;">我的</p>
    </a>
</div>