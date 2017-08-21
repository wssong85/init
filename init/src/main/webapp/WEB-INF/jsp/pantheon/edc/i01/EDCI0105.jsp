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
	});
	
	
	
	function btnBlndCnclCfrm(){
		//check validation
		var relisConfmNo = $("#frm_popup5 #RELIS_CONFM_NO").val();
		var usrId = $("#frm_popup5 #USER_ID").val();
		var pwd = $("#frm_popup5 #PASSWORD").val();
		
		if(relisConfmNo == ""){
			alert("인증번호를 입력해 주세요.");
			return false;
		}
		
		if(usrId == ""){
			alert("사용자 아이디를 입력해 주세요.");
			return false;
		}
		
		if(pwd == ""){
			alert("비밀번호를 입력해 주세요.");
			return false;
		}
		
		$.ajax({
			url : './updateEdcCfSubjectByBlindSttusCd.do',
			type: 'post',
			dataType: 'json',
			data : paramData,
			contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
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
					<h5>눈가림 해제 승인번호 입력</h5>
				</article>

				<article class="mgT5">
					<form id="frm_popup5" name="frm_popup5">
						<input type="hidden" id="SUBJECT_NO" name="SUBJECT_NO" value="">
						<input type="hidden" id="TASK_NO" name="TASK_NO" value="">
						<table class="tb001">
							<colgroup>
								<col width="30%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>승인 번호</th>
									<td style="padding: 7px 7px 7px 7px;">
										<input type="text" id="RELIS_CONFM_NO" value="" />
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
						<input type="button" onClick="btnBlndCnclCfrm();" value="눈가림 해제" />
						<input type="button" value="닫기" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>