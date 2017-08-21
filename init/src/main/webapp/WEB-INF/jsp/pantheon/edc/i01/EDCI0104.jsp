<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
//Blind목록(현업) - EDCI0102 화면에서 호출
var param = {'REQUST_NO':g_selRowData.REQUST_NO, 'SUBJECT_NO':g_selRowData.SUBJECT_NO}
var rsltData;
var paramData = '';
var paramData2 = '';

$(document).ready(function(){
	$("#USER_ID").val(_user.USER_ID);
	
	$.ajax({
		url : '/com/z09/selectCmSanctnProcessListByPk.do',
		data : param,
		type : 'post',
		//contentType : "application/json; charset=UTF-8",
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				rsltData = data.result;
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
	
	console.log("rsltData[0]:"+rsltData[0].REQUST_NO);
	chkSnctn();
})

function chkSnctn(){
	//전체를 돌려요~
	var cntSanctnCd = 0;		//SANCTN_CODE
	
	for(var i=0;i<rsltData.length; i++){
		
		if(rsltData[i].SANCTN_CODE == '01'){
			if(rsltData[i].SANCTNER_ID ==  _user.USER_ID) {
				alert('기안자는 승인 및 반려 할 수 없습니다.');
				layerClose();
				grid.load();
				return;
			}
		}
		
		if(rsltData[i].SANCTN_CODE == '06'){	//결재구분이 '참조'인 경우
			if(rsltData[i].SANCTNER_ID == _user.USER_ID){	//USER_ID가 참조자인 경우
				alert('참조자는 승인 및 반려 할 수 없습니다.');
				layerClose();
				grid.load();
				return false;
			}
		}
		console.log("==========================  "+i+"   ===========================");
		console.log("SANCTNER_ID : "+rsltData[i].SANCTNER_ID);
		console.log("_user.USER_ID : "+_user.USER_ID);
		console.log("rsltData[i].STTUS_CODE : "+rsltData[i].STTUS_CODE);
		if(rsltData[i].SANCTNER_ID == _user.USER_ID && rsltData[i].STTUS_CODE != '01') {	//결재자 아이디에 USER_ID가 있고, 결재처리 상태가 '요청'이 아닌 경우
			alert('이미 승인 및 반려를 진행했습니다.');
			layerClose();
			grid.load();
			return;
		}
		
		if(rsltData[i].SANCTN_CODE == '01'){	//요청 완료 문서 check
			cntSanctnCd++;
		}	
		
		if(rsltData[i].STTUS_CODE == '01' && 		//결재처리상태가 '요청' 이고,
				(rsltData[i].SANCTN_CODE == '02' || rsltData[i].SANCTN_CODE == '05' || rsltData[i].SANCTN_CODE == '07')) {	//결재구분이 '조정, 순차합의, 결제' 중 하나인 경우
			if(_user.USER_ID != rsltData[i].SANCTNER_ID) {	// 결재자 ID와 userId가 다른 경우
				alert('결재순서가 아닙니다.');		
				layerClose();
				grid.load();			
				return;			
			} else {
				paramData2 = rsltData[i];
				break;
			}
		}	
	}
	
	if(cntSanctnCd == 0) {
		alert('요청이 완료된 문서입니다.');
		layerClose();
		grid.load();
		return;
	}
	
	for(var i=0;i<rsltData.length; i++){		
		
		if(rsltData[i].STTUS_CODE == '01' && rsltData[i].SANCTN_CODE == '04') {
			
			if(rsltData[i].SANCTN_CODE == '04'){
				if(_user.USER_ID == rsltData[i].SANCTNER_ID) {
					paramData2 = rsltData[i];
					break;
				}
			}
		}
	}
	
	if(!paramData2) {
		alert('결재순서가 아닙니다.');
		layerClose();
		grid.load();
		return;
	}
	
	paramData = paramData2;
	
	if(!paramData) {
		alert('요청이 완료된 문서입니다.');
		layerClose();
		grid.load();
		return;
	}
}

function chkEndOfSanctn(){

	$.ajax({
		url : '/edc/i01/updateCmSanctnRslt.do',
		type: 'post',
		dataType: 'json',
		data : paramData,
		success : function(data, textStatus, jqXHR) {
			if(data.success) {
				alert(data.message);
				//함수이름 f_requestRequstNo_2
				if(data.REQUST_NO) {
					${callbackFunction}(data.REQUST_NO);
				}
				$('#btnCmSanctnProcessClose').trigger('click');
			} else {
				alert(data.message);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}

function processConfirm() {
	
	if($(":radio[name='STTUS_CODE']:checked").val() == '02') {
		if(!window.confirm("승인하시겠습니까?")){
			return;
		}
	} else if($(":radio[name='STTUS_CODE']:checked").val() == '03') {
		if(!window.confirm("거부하시겠습니까?")){
			return;
		}
	} else {
		return;
	}
	
	if(!mkValidation()){
		return;
	}
	
	if($('#USER_ID').val() != _user.USER_ID) {
		alert('접속한 아이디를 입력해 주십시오.');
		return;
	}
	
	paramData.USER_ID = $("#USER_ID").val(); 
	paramData.PASSWORD = $("#PASSWORD").val();
	paramData.STTUS_CODE = $(":radio[name='STTUS_CODE']:checked").val();
	paramData.SANCTN_COMMENT = $("#RELIS_RESN").val();
	console.log("user_id : "+$("#USER_ID").val());
	console.log("paramData.USER_ID : "+paramData.USER_ID );
	
	if($(":radio[name='STTUS_CODE']:checked").val() == '03' && !paramData.SANCTN_COMMENT) {
		alert('반려시 코멘트는 필수 입니다.');
		return;
	}
	
	//결재선 check
	chkSnctn();
	
	//결제처리, 결제 후 SMS 발송
	chkEndOfSanctn();
	
	layerClose();
	grid.load();
}


</script>
<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="conBoxInner">
				<!-- 팝업 내부 컨텐츠 시작 -->
				<article class="conTitBox">
					<h5>눈가림 해제 승인</h5>
				</article>

				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<input type="hidden" id="SUBJECT_NO" name="SUBJECT_NO" value="">
						<input type="hidden" id="SANCLINE_SN" name="SANCLINE_SN" value="">
						<input type="hidden" id="TASK_NO" name="TASK_NO" value="">
						<table class="tb001">
							<colgroup>
								<col width="30%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<td colspan="2" style="padding: 7px 7px 7px 7px;">
										<input type="radio" id="reqCnfrm" name="STTUS_CODE" value="02" checked><label for="reqCnfrm" class="raLab"><span>해제승인</span></label>
										<br>
										<input type="radio" id="reqCnl" name="STTUS_CODE" value="03"  ><label for="reqCnl" class="raLab"><span>거부</span></label>
										<textarea id="RELIS_RESN" name="RELIS_RESN" rows="4" style="width: 80%;"></textarea>
									</td>
								</tr>
								<tr>
									<th>사용자 아이디</th>
									<td style="padding: 7px 7px 7px 7px;">
										<input type="text" id="USER_ID" value="" />
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td style="padding: 7px 7px 7px 7px;">
										<div class="dateBox">
											<input type="password" id="PASSWORD" name="사용자 Password" />
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</article>
				<article class="mgT10">
					<div style="text-align: center">
						<input type="button" onClick="processConfirm();" value="확인" />
						<input type="button" value="닫기" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>