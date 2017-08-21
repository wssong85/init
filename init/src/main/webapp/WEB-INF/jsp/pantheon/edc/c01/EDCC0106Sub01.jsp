<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<script type="text/javascript">
	var popup_grid = null;
	var popup_grid2 = null;
	var popup_grid3 = null;

	var btn_id = null;
	var frm_id = null;
	var crf_id = "${CRF_ID}";

	var item = null;

	function saveQuery() {
		if ($("#frm_popup input[name=answer_type]:checked").val() == "02") {
			item.QUERY_STTUS_CODE = "03";//종료
			item.SEPARATOR = "END";
		} else {
			item.QUERY_STTUS_CODE = "02";//응답
			item.SEPARATOR = "ANSWER";
		}
		item.RESN = $("#frm_popup #resn").val();
		$.ajax({
			url : './insertCRFQuery.do',
			data : item,
			type : 'post',
			//contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					$("#" + crf_id).empty();
					
					popup_grid.load();
					var layout = fn_makeCRFObject(popup_grid);
					makeLayoutInput(layout, crf_id, popup_grid);

					popup_grid2.load();
					fn_showComment(popup_grid2, crf_id);

					popup_grid3.load();
					showQuery(popup_grid3, crf_id, "${POPUP_ORDER}");

					fn_inputControl(btn_id, frm_id, crf_id);

					layerClose("${POPUP_ORDER}");
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}

	$(document).ready(function() {
		if ("${CRF_ID}" == "crf_layout") {
			popup_grid = EDCC0106_grid;
			popup_grid2 = EDCC0106_grid2;
			popup_grid3 = EDCC0106_grid3;
			btn_id = "div_main_btn";
			frm_id = "frm_main";
		} else if ("${CRF_ID}" == "popup_crf_layout") {
			popup_grid = EDCC0109_grid;
			popup_grid2 = EDCC0109_grid2;
			popup_grid3 = EDCC0109_grid3;
			btn_id = "div_popup_btn";
			frm_id = "frm_popup";
		} else {

		}

		item = AUIGrid.getItemByRowId(popup_grid3.id, "${ QUERY_SN }");

		if (item.QUERY_TY_CODE == "01") {//시스템
			$("#div_manual").remove();
		} else {//매뉴얼
			$("#div_system").remove();
			$("#frm_popup #answer_type_1").prop("checked", true);
		}

	});
</script>
<section class="popupWrap">
	<div class="popup popup1 wd700">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="popup_conBoxInner">
				<form id="frm_popup" name="frm_popup">
					<input type="hidden" id="SET_ROW_SN" name="SET_ROW_SN" value="${ SET_ROW_SN }">
					<input type="hidden" id="VRIABL_ROW_SN" name="VRIABL_ROW_SN" value="${ VRIABL_ROW_SN }">
					<input type="hidden" id="QUERY_TY_CODE" name="QUERY_TY_CODE" value="${ QUERY_TY_CODE }">
					<input type="hidden" id="QUERY_SN" name="QUERY_SN" value="${ QUERY_SN }">
					<div id="div_manual">
						<h5>Query 확인</h5>
						<article class="mgT5">
							<table class="tb001">
								<tbody>
									<tr>
										<th><c:forEach items="${ EDC056 }" var="list" varStatus="status">
												<input type="radio" id="answer_type_${ status.count }" name="answer_type" value="${ list.CODE }">
												<label for="answer_type_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
												</label>
											</c:forEach></th>
									</tr>
									<tr>
										<td>
											<textarea style="width: 100%; height: 50px;" id="resn"></textarea>
										</td>
									</tr>
									<tr>
										<td style="color: red;">
											* 쿼리 응답 이후에 쿼리 조건에 관계되는 입력 값의 일부가 수정 될 경우, 다시 쿼리가 오픈 될 수 있습니다. <br> * 쿼리 종료 이후에 쿼리 조건에 관계되는 입력 값의 일부가 수정 될 경우, 다시 쿼리가 오픈 될 수 있습니다.
										</td>
									</tr>
								</tbody>
							</table>
						</article>
					</div>
					<div id="div_system">
						<h5>Query 응답</h5>
						<article class="mgT5">
							<table class="tb001">
								<tbody>
									<tr>
										<td>입력 값에 변동이 없을 경우, 아래 사유를 기재하고 쿼리 응답을 수행해 주십시오</td>
									</tr>
									<tr>
										<td>
											<textarea style="width: 100%; height: 50px;" id="resn"></textarea>
										</td>
									</tr>
									<tr>
										<td style="color: red;">* 쿼리 응답 이후에 쿼리 조건에 관계되는 입력 값의 일부가 수정 될 경우, 다시 쿼리가 오픈 될 수 있습니다.</td>
									</tr>
								</tbody>
							</table>
						</article>
					</div>
					<article class="mgT10">
						<div style="text-align: center">
							<input type="button" id="btnSave" value="저장" onclick="saveQuery()" />
							<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose(1);">
						</div>
					</article>
				</form>
			</div>
		</section>
	</div>
</section>