<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>

<script type="text/javascript">
	$(document).ready(function() {
		applyCss();
	});
	function applyCss() {
		$("#frm_popup #DC_CN").css({
			"fontSize" : $("#frm_popup #DC_FONT_MG option:selected").text() + "px",
			"font-family" : $("#frm_popup #DC_FONT_CODE option:selected").text(),
			"color" : $("#frm_popup #DC_FONT_COLLR").val()
		});
	}
	function setColor(obj) {
		var color = $(obj).css("background-color");
		$("#frm_popup #DC_FONT_COLLR").val(color);
		applyCss();
	}
	function applyDescription() {
		var dc_font_mg_value = $("#frm_popup #DC_FONT_MG option:selected").text();
		var dc_font_code_value = $("#frm_popup #DC_FONT_CODE option:selected").text();
		var item = fn_serializeObject($("#frm_popup"));
		item.DC_FONT_MG_VALUE = dc_font_mg_value;
		item.DC_FONT_CODE_VALUE = dc_font_code_value;
		AUIGrid.updateRowsById(EDCK0209_grid2.id, item, true);
		var set_sn = $("#frm_popup #SET_SN").val();
		var span = $("#div_layout").find("#div_set" + set_sn + " span");
		span.text($("#frm_popup #DC_CN").val());
		span.css({
			"font-size" : dc_font_mg_value + "px",
			"line-height" : (Number(dc_font_mg_value) + 10) + "px",
			"font-family" : dc_font_code_value,
			"color" : $("#frm_popup #DC_FONT_COLLR").val()
		});
		layerClose();
	}
</script>

<style>
</style>

<section class="popupWrap">
	<div class="popup wd600">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="popup_conBoxInner">
				<h6>Description</h6>
				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="${ detail.VISIT_GROUP_SN }">
						<input type="hidden" id="SET_SN" name="SET_SN" value="${ detail.SET_SN }">
						<input type="hidden" id="SET_ROW_SN" name="SET_ROW_SN" value="${ detail.SET_ROW_SN }">
						<input type="hidden" id="SET_VRIABL_SN" name="SET_VRIABL_SN" value="${ detail.SET_VRIABL_SN }">
						<c:set var="color" value="${ detail.DC_FONT_COLLR }" />
						<c:if test="${ empty color }">
							<c:set var="color" value="#666" />
						</c:if>
						<input type="hidden" id="DC_FONT_COLLR" name="DC_FONT_COLLR" value="${ color }">
						<table class="tb001">
							<colgroup>
								<col width="15%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="edc.lbl.DC_CN" /></th>
									<td style="padding: 7px 6px 0px 7px;">
										<textarea id="DC_CN" name="DC_CN" style="width: 100%; height: 150px;">${ detail.DC_CN }</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;">
										<spring:message code="edc.lbl.DC_FONT_CODE" />
										<select id="DC_FONT_CODE" name="DC_FONT_CODE" onchange="applyCss();">
											<c:forEach items="${ EDC043 }" var="list" varStatus="status">
												<option value="${ list.CODE }" <c:if test="${ list.CODE == detail.DC_FONT_CODE}">selected="selected"</c:if>>${ list.VALUE }</option>
											</c:forEach>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="edc.lbl.DC_FONT_MG" />
										<select id="DC_FONT_MG" name="DC_FONT_MG" onchange="applyCss();">
											<c:forEach items="${ EDC044 }" var="list" varStatus="status">
												<option value="${ list.CODE }" <c:if test="${ list.CODE == detail.DC_FONT_MG}">selected="selected"</c:if>>${ list.VALUE }</option>
											</c:forEach>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="edc.lbl.DC_LINK_CODE" />
										<select id="DC_LINK_CODE" name="DC_LINK_CODE">
											<option value=""><spring:message code="edc.lbl.SELECT" /></option>
											<c:forEach items="${ EDC042 }" var="list" varStatus="status">
												<option value="${ list.CODE }" <c:if test="${ list.CODE == detail.DC_LINK_CODE}">selected="selected"</c:if>>${ list.VALUE }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="padding: 10px 0 0 0; text-align: center;">
										<spring:message code="edc.lbl.DC_FONT_COLLR" />
										<table class="in_color_01">
											<tr>
												<td style="background-color: #f2f2f2; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #87b5e9; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #b6cce4; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #e3bab6; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #d8e3b8; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #cec0da; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #b3dfec; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>

												<td style="background-color: #dbdbdb; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #4e8ddd; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #8eb0dd; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #d2998e; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #c2d59a; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #b4a3cd; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #94cfe1; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #0c0d0f; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #08223b; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #1a3d5d; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
											</tr>
											<tr>
												<td style="background-color: #a5a5a5; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #1b4987; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #4b86c0; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #bb5346; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #9cba58; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #8061a5; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #41b1c7; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>

												<td style="background-color: #262628; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #1d3453; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #376191; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #823b35; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #779438; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #5e4680; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #2f859c; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #632323; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #515b36; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #3f3154; width: 36px; height: 30px; cursor: pointer;" onclick="setColor(this);"></td>
											</tr>
										</table>
									</td>
								</tr>



							</tbody>
						</table>




					</form>
				</article>
				<article class="mgT10">
					<div style="text-align: center">
						<input type="button" id="btnSave" value="<spring:message code="edc.btn.APPLY" />" onclick="applyDescription()" />
						<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>




