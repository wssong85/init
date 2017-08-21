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
	var popup_grid4 = null;

	var crf_id = null;

	function changeEndType() {
		/* if ($("#frm_popup input[name=end_type]:checked").val() == "02") {
			$("#frm_popup #resn").prop("disabled", true);
		} else {
			$("#frm_popup #resn").prop("disabled", false);
		} */
	}

	function saveQuery() {
		var param = null;
		if ("${ SEPARATOR }" == "END") {
			var query_sn = $("#frm_popup #QUERY_SN").val();
			param = AUIGrid.getItemByRowId(popup_grid3.id, query_sn);
			param.QUERY_STTUS_CODE = "03";//종료
			if ($("#frm_popup input[name=end_type]:checked").val() == "01") {//종료
				param.RESN = $("#frm_popup #resn").val();
				param.SEPARATOR = "END";
			} else {//재오픈
				param.NEW_QUERY_CN = $("#frm_popup #resn").val();
				param.RESN = "재오픈";
				param.SEPARATOR = "REOPEN";
			}
		} else {
			var rn = $("#frm_popup #RN").val();
			param = AUIGrid.getItemByRowId(popup_grid.id, rn);
			if ($("#frm_popup input[name=open_type]:checked").val() == "02") {
				param.QUERY_STTUS_CODE = "01";//오픈
			} else {
				param.QUERY_STTUS_CODE = "04";//예비
			}
			param.QUERY_CN = $("#frm_popup #query_cn").val();
			param.SEPARATOR = "OPEN";
		}
		param.QUERY_TY_CODE = "02";

		$.ajax({
			url : './insertCRFQuery.do',
			data : param,
			type : 'post',
			//contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					$("#" + crf_id).empty();

					popup_grid.load();
					var layout = fn_makeCRFObject(popup_grid);

					if ("${grid_id}" == "EDCC0108_grid") {
						makeLayoutSDV(layout, crf_id, "${POPUP_ORDER}", popup_grid);
					} else if ("${grid_id}" == "EDCC0107_grid") {
						makeLayoutQuery(layout, crf_id, "${POPUP_ORDER}", popup_grid);
					} else if ("${grid_id}" == "EDCC0110_grid") {
						makeLayoutQuery(layout, crf_id, "${POPUP_ORDER}", popup_grid);
					} else if ("${grid_id}" == "EDCC0111_grid") {
						makeLayoutSDV(layout, crf_id, "${POPUP_ORDER}", popup_grid);
					}

					popup_grid2.load();
					fn_showComment(popup_grid2, crf_id);

					popup_grid3.load();
					showQuery(popup_grid3, crf_id, "${POPUP_ORDER}", popup_grid);

					if ("${grid_id}" == "EDCC0108_grid") {
						popup_grid4.load();
						showSDV(popup_grid4, crf_id);
					}

					$("#" + crf_id + " [read]").prop("disabled", true);

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

	function popupClose() {
		layerClose("${POPUP_ORDER}");
	}

	$(document).ready(function() {
		$("#frm_popup #open_type_1").prop("checked", true);
		$("#frm_popup #end_type_1").prop("checked", true);

		if ("${grid_id}" == "EDCC0108_grid") {
			popup_grid = EDCC0108_grid;
			popup_grid2 = EDCC0108_grid2;
			popup_grid3 = EDCC0108_grid3;
			popup_grid4 = EDCC0108_grid4;
			crf_id = "crf_layout";
		} else if ("${grid_id}" == "EDCC0107_grid") {
			popup_grid = EDCC0107_grid;
			popup_grid2 = EDCC0107_grid2;
			popup_grid3 = EDCC0107_grid3;
			crf_id = "crf_layout";
		} else if ("${grid_id}" == "EDCC0110_grid") {
			popup_grid = EDCC0110_grid;
			popup_grid2 = EDCC0110_grid2;
			popup_grid3 = EDCC0110_grid3;
			crf_id = "popup_crf_layout";
		} else if ("${grid_id}" == "EDCC0111_grid") {
			popup_grid = EDCC0111_grid;
			popup_grid2 = EDCC0111_grid2;
			popup_grid3 = EDCC0111_grid3;
			popup_grid4 = EDCC0111_grid4;
			crf_id = "popup_crf_layout";
		} else {

		}

		if ("${ SEPARATOR }" == "END") {
			$("#query_open").hide();
			$("#query_end").show();
		} else {
			$("#query_open").show();
			$("#query_end").hide();
			var set_row_sn = $("#frm_popup #SET_ROW_SN").val();
			var vriabl_row_sn = $("#frm_popup #VRIABL_ROW_SN").val();

			var str = "<select id='RN'>";
			var rowItems = AUIGrid.getGridData(popup_grid.id);
			for (var i = 0; i < rowItems.length; i++) {
				if (rowItems[i].SET_ROW_SN == set_row_sn && rowItems[i].VRIABL_ROW_SN == vriabl_row_sn) {
					if (rowItems[i].VRIABL_SE_CODE != "07" && rowItems[i].VRIABL_SE_CODE != "08" && rowItems[i].VRIABL_SE_CODE != "11") {
						str += "<option value='" + rowItems[i].RN + "'>";
						str += rowItems[i].CRF_LBL_ONE;
						str += "</option>";
					}
				}
			}
			str += "</select>";

			$("#frm_popup #th_variable_select").html(str);

		}
	});
</script>
<section class="popupWrap">
	<div id="div_popup" class="popup popup${POPUP_ORDER} wd500">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="popup_conBoxInner">
				<form id="frm_popup" name="frm_popup">
					<input type="hidden" id="SET_ROW_SN" name="SET_ROW_SN" value="${ SET_ROW_SN }">
					<input type="hidden" id="VRIABL_ROW_SN" name="VRIABL_ROW_SN" value="${ VRIABL_ROW_SN }">
					<input type="hidden" id="SEPARATOR" name="SEPARATOR" value="${ SEPARATOR }">
					<input type="hidden" id="QUERY_SN" name="QUERY_SN" value="${ QUERY_SN }">
					<div id="query_open">
						<h5>Query 발행</h5>

						<article class="mgT5">

							<table class="tb001">
								<tbody>
									<tr>
										<th id="th_variable_select"></th>
										<th><c:forEach items="${ EDC054 }" var="list" varStatus="status">
												<input type="radio" id="open_type_${ status.count }" name="open_type" value="${ list.CODE }" onclick="changeEndType();">
												<label for="open_type_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
												</label>
											</c:forEach></th>
									</tr>
									<tr>
										<td colspan="2">
											<textarea style="width: 100%; height: 50px;" id="query_cn"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</article>
						<article class="mgT10">
							<div style="text-align: center">
								<input type="button" id="btnSave" value="저장" onclick="saveQuery()" />
								<input type="button" value="<spring:message code="btn.close" />" onclick="popupClose();">
							</div>
						</article>
					</div>
					<div id="query_end">
						<h5>Query 종료</h5>

						<article class="mgT5">
							<table class="tb001">
								<colgroup>
									<col width="28%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th><c:forEach items="${ EDC053 }" var="list" varStatus="status">
												<input type="radio" id="end_type_${ status.count }" name="end_type" value="${ list.CODE }" onclick="changeEndType();">
												<label for="end_type_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
												</label>
											</c:forEach></th>
									</tr>
									<tr>
										<td>
											<textarea style="width: 100%; height: 50px;" id="resn"></textarea>
										</td>
									</tr>
								</tbody>
							</table>

						</article>
						<article class="mgT10">
							<div style="text-align: center">
								<input type="button" id="btnSave" value="저장" onclick="saveQuery()" />
								<input type="button" value="<spring:message code="btn.close" />" onclick="popupClose();">
							</div>
						</article>
					</div>
				</form>
			</div>
		</section>
	</div>
</section>