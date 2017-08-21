<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>

<script type="text/javascript">
var CRUD_Type = "";
	var _user = {
		'USER_ID': '${loginMap.USER_ID}'
	};

	$(document).ready(function(){
		
		var strData = { 
				RTN_SN : p_seq_no
	    };

		$.ajax({
			  url : '/ctms/j11/selectReturnReasonInfo.do' ,
			  type: 'POST',
			  data : strData,
			  dataType: 'json',
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  console.log("Strart CRUD_Type : "+CRUD_Type);
					   var sData = data.result;
					   var sRows = sData.length;
					   if(sRows > 0){
						   CRUD_Type = "U";
						   $("#cn").val(sData[0].CN);
					   }
					   else{
						   CRUD_Type = "C";
					   }
				  } else {
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});

		$("#btnSave").click(function(){
			var strData = {
					  CURD      : CRUD_Type
					, RTN_SN    : p_seq_no
					, CN        : $("#cn").val()
					, USE_AT    : "Y"
					, UPDATE_ID : _user.USER_ID
		    };
 		    
			$.ajax({
				  url : '/ctms/j11/insertReturnReasonInfo.do' ,
				  type: 'POST',
				  data : strData,
				  dataType: 'json',
				  success : function(data, textStatus, jqXHR) {
					  if(data.success) {
						   fn_callback();
						   layerClose();
					  } else {
						  alert(data.message);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(textStatus);
				  }
			});
		});

		$("#btnClose").click(function(){
			fn_callback();
			layerClose();
		});
	});

</script>



	<section class="popupWrap">
		<div class="popup wd350">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			
			
			
				<div class="popup_conBoxInner" style="padding-bottom: 20px;">
					<h5>반려사유</h5>
	
					<article class="mgT5">
						<table class="tb02">
							<colgroup>
								<col style="" />
							</colgroup>
							<tbody>						
								<tr style="border:none;;">
									<td style="padding:0;">
										<textarea name="cn" id="cn" style="width:100%;" rows="6"></textarea>
									</td>
								</tr>	
							</tbody>
						</table>
					</article>
					
					
					
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnSave" value="저장" />
							<input type="button" id="btnClose" value="취소" />
						</div>
					</article>
				</div>
			
			
			
			</section>
		</div>
	</section>




