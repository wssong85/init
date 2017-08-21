<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript">
var overlapCheck = "0"; //중복체크 여부 0:미체크 1:체크
$(function() {
	//적용버튼
	$("#btnApply").click(function(){
		if(overlapCheck == "0"){
			alert("아이디 중복체크를 해주세요.");
			return;
		}
		
		returnValue = {
				USER_ID : $("#txtInputId").val()	 			
			};
		
		layerClose(1);
		fn_setUserId();
	});
	
	//닫기버튼
	$("#btnClose").click(function(){
		layerClose(1);
	});
	
	//중복체크 버튼
	$("#btnSearchId").click(function(){
		if( $("#txtInputId").val() == ""){
			alert("아이디를 입력해주세요.");
			return;
		}
		$.ajax({
 		    url: './selectRsrchUSerOverlap.do',
 		    type: 'post',
 		    dataType: 'json',
 		    data: {'TASK_SN' : gridItem.TASK_SN, 'USER_ID' : $("#txtInputId").val()},//me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 		    		console.log(data.result);
 		    		if(data.result == "" || data.result == null){
 		    			alert("사용가능한 아이디 입니다.");
 		    			overlapCheck = "1";
 		    		}else{
 		    			alert("중복된 아이디가 있습니다.");
 		    			overlapCheck = "0";
 		    			return;
 		    		}
 		    		
 		    	} else {	 		    		
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
	});

	
});


</script>



<section class="popupWrap">
	<div class="popup popup1 wd500">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h6>아이디 검색</h6>
				<article class="mgT5">
					<table class="tb001">
						<colgroup>
							<col style="width: 20%;" />
							<col style="" />
						</colgroup>
						<tbody>							
							<tr>
								<th>아이디</th>
								<td>									
									<input type="text" name="txtInputId" id="txtInputId" style="width:50%; ime-mode:disabled;" maxlength = "32" "/>	
									<input type="button" name="btnSearchId" id="btnSearchId" value="중복체크" />									
									
								</td>
							</tr>
						</tbody>
					</table>
				</article>

				<article class="mgT10">
					<div style="text-align:center">
						<input type="button" id="btnApply" value="적용" />					
						<input type="button" id="btnClose" value="닫기" />
					</div>
				</article>
		</div>
		</section>
	</div>
</section>

