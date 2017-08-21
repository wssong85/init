<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
// Blind목록(연구자) - EDCI0101 화면에서 호출
var param = {'REQUST_NO':g_selRowData.REQUST_NO, 'SUBJECT_NO':g_selRowData.SUBJECT_NO}
var rsltData;
var paramData = '';
var paramData2 = '';

$(document).ready(function(){
	$("#frm_popup #SUBJECT_NO").val(g_selRowData.SUBJECT_NO);
	$("#frm_popup #TASK_SN").val(g_selRowData.TASK_SN);
	$("#frm_popup #SANCLINE_SN").val(g_selRowData.SANCLINE_SN);
	$("#frm_popup #INSTT_FORM_SN").val(g_selRowData.INSTT_FORM_SN);
})

function btnReqBlndRelisSave(){		//해제요청 처리
	
			
	var relisResn = $("#frm_popup #RELIS_RESN").val();
	var usrId = $("#frm_popup #USER_ID").val();
	var pwd = $("#frm_popup #PASSWORD").val();
	
	//해제요청 처리 전 validation
	if(relisResn.length > 0){	//해제사유 length check
		var strLen = relisResn.length;
		var totalByte = 0;
		var oneChar = "";
		
        for (var k = 0; k < strLen; k++) {
        	oneChar = relisResn.charAt(k);
            if (escape(oneChar).length > 4) {
                totalByte += 3;
            } else {
                totalByte++;
            }
        }
		console.log("totalByte : "+totalByte);
		if(totalByte > 4000){ // DB Size 1000일 경우 한글  334자 1002로 error, 한글, 영문 byte합 1333
			alert("해제사유는 4000 byte를 넘을 수 없습니다.");
			return false;
		}
	}else{
		alert("해제사유를 입력해 주세요.");
		return false;
	}

	//User ID null check		
	if(usrId == ""){
		alert("사용자 아이디를 입력해 주세요.");
		return false;
	}else{
		console.log("usrId : "+usrId+", g_user : "+g_user);
		if(usrId !=g_user){
			alert('접속한 아이디를 입력해 주십시오.');
			return false;
		}
	}
	
	//password null check		
	if(pwd == ""){
		alert("비밀번호를 입력해 주세요.");
		return false;
	}
	
	var arJson = [];
	var roleInfo = {
			  'SUBJECT_NO' : $("#frm_popup #SUBJECT_NO").val()
			, 'INSTT_FORM_SN' : $("#frm_popup #INSTT_FORM_SN").val()
			, 'SANCLINE_SN' : $("#frm_popup #SANCLINE_SN").val()
			, 'TASK_SN' : $("#frm_popup #TASK_SN").val()
			, 'RELIS_RESN' : $("#frm_popup #RELIS_RESN").val()
			, 'USER_ID' : $("#frm_popup #USER_ID").val()
			, 'PASSWORD' : $("#frm_popup #PASSWORD").val()
	};
	
	arJson.push(roleInfo);
	
	$.ajax({
		url : './insertEdcSanctnRequstByEdcSanClineDetailInfo.do',
		data : JSON.stringify(roleInfo),
		type : 'post',
		contentType : "application/json; charset=UTF-8",
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				layerClose();
				grid.load();
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
			
}
</script>
<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="conBoxInner">
				<!-- 팝업 내부 컨텐츠 시작 -->
				<article class="conTitBox">
					<h5>눈가림 해제 요청</h5>
				</article>

				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<input type="hidden" id="SUBJECT_NO" name="SUBJECT_NO" value="${ SUBJECT_NO }">
						<input type="hidden" id="INSTT_FORM_SN" name="INSTT_FORM_SN" value="${ INSTT_FORM_SN }">
						<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN } }">
						<input type="hidden" id="SANCLINE_SN" name="SANCLINE_SN" value="${ SANCLINE_SN }">
						<table class="tb001">
							<colgroup>
								<col width="30%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>해제 사유</th>
									<td style="padding: 7px 7px 7px 7px;">
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
						<input type="button" onClick="btnReqBlndRelisSave();" value="해제 요청" />
						<input type="button" value="닫기" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>