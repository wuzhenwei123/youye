<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/common/config.jsp" %>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fontello-icon-cancel-1"></i></button>
     <h4>系统设置</h4>
</div>
<div class="modal-body">
    <form id="addForm" class="well well-nice form-horizontal">
         <div class="control-group input-append">
             <label class="control-label" for="aNavgType">导航样式</label>
             <div class="controls">
	             <c:set value="${adminskins.navgType}" var="navgType"></c:set>
	                <c:if test="${empty navgType }">
	                <c:set value="1" var="navgType"></c:set>
	              </c:if>
                 <input type="hidden" id="aNavgType" value="1">
                 <div class="btn-group" data-toggle="buttons-radio">
                     <button type="button" onclick="setVal('aNavgType','1')" class="btn btn-glyph <c:if test="${navgType eq '1'}">active</c:if>">全导航</button>
                     <button type="button" onclick="setVal('aNavgType','2')" class="btn btn-glyph <c:if test="${navgType eq '2'}">active</c:if>">上导航</button>
                     <button type="button" onclick="setVal('aNavgType','3')" class="btn btn-glyph <c:if test="${navgType eq '3'}">active</c:if>">左导航</button>
                 </div>
             </div>
         </div>
         <div class="control-group input-append">
             <label class="control-label" for="aNavgSet">导航样式</label>
             <div class="controls">
	              <c:set value="${adminskins.navgSet}" var="navgSet"></c:set>
	                <c:if test="${empty navgSet }">
	                <c:set value="1" var="navgSet"></c:set>
	              </c:if>
                 <input type="hidden" id="aNavgSet" value="${navgSet }">
                 <div class="btn-group" data-toggle="buttons-radio">
                     <button type="button" onclick="setVal('aNavgSet','1')" class="btn btn-glyph <c:if test="${navgSet eq '1'}">active</c:if>">靠左</button>
                     <button type="button" onclick="setVal('aNavgSet','2')" class="btn btn-glyph <c:if test="${navgSet eq '2'}">active</c:if>">靠右</button>
                 </div>
             </div>
         </div>
     </form>
 </div>
 <div class="modal-footer">
     <button type="button" data-dismiss="modal" class="btn btn-boo">取消</button>
     <button type="submit" class="btn btn-green" onclick="add()">保存</button>
 </div>
<script type="text/javascript">
	
	function setVal(id,val){
		$("#"+id).val(val);
	}
	
	//执行添加
	function add(){
		var navgType = getVal("aNavgType");
		var navgSet = getVal("aNavgSet");
	    $.post("<c:url value='/adminSkins/saveSkins'/>",
       	{
	    	navgType : navgType,
	    	navgSet : navgSet,
			 _t:Math.random()
		},
       	function(data){
        	var result = eval('('+data+')'); 
            if (result.code == '1') {
//               	tipOk('保存成功');
             } else {
//             	 tipError(result.message);
             }
            location.reload();
//         	$modal.modal('hide');
       });
	}
</script>