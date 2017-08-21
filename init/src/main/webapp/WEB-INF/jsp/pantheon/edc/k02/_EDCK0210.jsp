<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE HTML>


<script type="text/javascript">
	$(document).ready(function() {
		applyCss();
	});
	function applyCss() {
		console.log("fontSize" + $("#frm_popup #DC_FONT_MG option:selected").text());
		console.log("font" + $("#frm_popup #DC_FONT_CODE option:selected").text());
		console.log("color" + $("#frm_popup #DC_FONT_COLLR").val());
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
		var item = fn_serializeObject($("#frm_popup"));
		AUIGrid.updateRowsById(EDCK0209_grid2.id, item, true);
		var vriabl_set_sn = $("#frm_popup #VRIABL_SET_SN").val();
		$("#div_layout").find("div[id=div_set]").each(function(index, entry) {
			if (vriabl_set_sn == $(this).find("#VRIABL_SET_SN").val()) {
				$(this).find("label").text($("#frm_popup #DC_CN").val());
				$(this).find("label").css({
					"fontSize" : $("#frm_popup #DC_FONT_MG option:selected").text(),
					"font-family" : $("#frm_popup #DC_FONT_CODE option:selected").text(),
					"color" : $("#frm_popup #DC_FONT_COLLR").val()
				});
				return false;
			}
		});
		layerClose();
	}
</script>


<style>
	table.in_color_01{ width:100%;}
	table.in_color_01 td{ border:none;}
</style>



	<section class="popupWrap">
		<div class="popup wd600">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<h6>Description</h6>
				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="${ detail.VISIT_GROUP_SN }">
						<input type="hidden" id="VRIABL_SET_SN" name="VRIABL_SET_SN" value="${ detail.VRIABL_SET_SN }">
						<input type="hidden" id="DC_FONT_COLLR" name="DC_FONT_COLLR" value="${ detail.DC_FONT_COLLR }">
						<table class="tb001">
							<colgroup>
								<col width="15%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>DC_CN</th>
									<td style="padding:7px 6px 0px 7px;">
										<textarea id="DC_CN" name="DC_CN" style="width:100%; height:150px;">${ detail.DC_CN }</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align:center;">
										DC_FONT_CODE:
										<select id="DC_FONT_CODE" name="DC_FONT_CODE" onchange="applyCss();">
											<c:forEach items="${ EDC043 }" var="list" varStatus="status">
												<option id="${ list.CODE }" <c:if test="${ list.CODE == detail.DC_FONT_CODE}">selected="selected"</c:if>>${ list.VALUE }</option>
											</c:forEach>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										DC_FONT_MG:
										<select id="DC_FONT_MG" name="DC_FONT_MG" onchange="applyCss();">
											<c:forEach items="${ EDC044 }" var="list" varStatus="status">
												<option id="${ list.CODE }" <c:if test="${ list.CODE == detail.DC_FONT_MG}">selected="selected"</c:if>>${ list.VALUE }</option>
											</c:forEach>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										DC_LINK_CODE:
										<select id="DC_LINK_CODE" name="DC_LINK_CODE">
											<c:forEach items="${ EDC042 }" var="list" varStatus="status">
												<option id="${ list.CODE }" <c:if test="${ list.CODE == detail.DC_LINK_CODE}">selected="selected"</c:if>>${ list.VALUE }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="padding:10px 0 0 0; text-align:center;">
										DC_FONT_COLLR:
										<table class="in_color_01">
											<tr>
												<td style="background-color: #f2f2f2; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #87b5e9; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #b6cce4; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #e3bab6; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #d8e3b8; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #cec0da; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #b3dfec; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>

												<td style="background-color: #dbdbdb; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #4e8ddd; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #8eb0dd; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #d2998e; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #c2d59a; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #b4a3cd; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #94cfe1; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #0c0d0f; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #08223b; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #1a3d5d; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
											</tr>
											<tr>
												<td style="background-color: #a5a5a5; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #1b4987; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #4b86c0; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #bb5346; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #9cba58; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #8061a5; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #41b1c7; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>

												<td style="background-color: #262628; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #1d3453; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #376191; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #823b35; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #779438; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #5e4680; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #2f859c; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #632323; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #515b36; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
												<td style="background-color: #3f3154; width: 20px; height: 20px; cursor: pointer;" onclick="setColor(this);"></td>
											</tr>
										</table>
									</td>
								</tr>

								

							</tbody>
						</table>
						
						
						
						
					</form>
				</article>
				<article class="mgT10">
					<div style="text-align:center">
						<input type="button" id="btnSave" value="적용" onclick="applyDescription()" />
						<input type="button" value="닫기" onclick="layerClose();">
					</div>
				</article>
			</div>
			</section>
		</div>
	</section>




