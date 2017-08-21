<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>

<script type="text/javascript">
	$(function() {
		mkSetDatePickerYYMMDD("#BNDE_APPLC_DE");
		var BNDE_APPLC_DE = "${ detail.BNDE_APPLC_DE }";
		if (BNDE_APPLC_DE == "") {
			$("#frm_popup input[name=BNDE_APPLC_CODE][value=01]").prop("checked", true);
		} else {
			BNDE_APPLC_DE = BNDE_APPLC_DE.substring(0, 10);
			$("#BNDE_APPLC_DE").val(BNDE_APPLC_DE);
		}

	});
</script>
<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="conBoxInner">
				<!-- 팝업 내부 컨텐츠 시작 -->
				<article class="conTitBox">
					<h5>변경 설정</h5>
				</article>

				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ detail.TASK_SN }">
						<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ detail.EDC_VER }">
						<table class="tb001">
							<colgroup>
								<col width="20%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>변경사유</th>
									<td style="padding: 7px 6px 0px 7px;">
										<textarea id="CHANGE_RESN" name="CHANGE_RESN" rows="4" style="width: 100%;">${ detail.CHANGE_RESN }</textarea>
									</td>
								</tr>
								<tr>
									<th>적용방법</th>
									<td>
										<c:forEach items="${ EDC031 }" var="list" varStatus="status">
											<input type="radio" id="BNDE_APPLC_CODE_${ status.count }" name="BNDE_APPLC_CODE" value="${ list.CODE }" onclick="changeReason()" <c:if test="${ list.CODE == detail.BNDE_APPLC_CODE}">checked="checked"</c:if>>
											<label for="BNDE_APPLC_CODE_${ status.count }" class="raLab"> <span>${ list.VALUE }</span> <label> </label>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th>적용일자</th>
									<td>
										<div class="dateBox">
											<input type="text" id="BNDE_APPLC_DE" name="BNDE_APPLC_DE" value="${ detail.BNDE_APPLC_DE }" />
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</article>
				<article class="mgT10">
					<div style="text-align: center">
						<input type="button" id="btnSave" value="<spring:message code="btn.save" />" onclick="saveChangeReason()" />
						<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>