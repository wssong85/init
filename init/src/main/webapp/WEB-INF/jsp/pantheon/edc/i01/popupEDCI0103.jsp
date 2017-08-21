<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>

<script type="text/javascript">
	var subjectNo;
	
	$(function() {
	});
	
	function fn_newForm(){
		$("#SUBJECT_NO").val(g_selRowData.SUBJECT_NO);
		$("#USER_ID").val(_user.USER_ID);
		$("#SANCLINE_SN").val(g_SanclineSn);
		$("#TASK_NO").val(g_TaskSn);
	}
	
	function fn_viewForm(){
		
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
									<th>해제 사유</th>
									<td style="padding: 7px 7px 7px 7px;">
										<textarea id="RELIS_RESN" name="RELIS_RESN" rows="4" style="width: 100%;"></textarea>
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