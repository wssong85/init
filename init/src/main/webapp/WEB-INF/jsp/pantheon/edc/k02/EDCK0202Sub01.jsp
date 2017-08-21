<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<script type="text/javascript">
	
</script>
<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="popup_conBoxInner">

				<h5>신규 버전</h5>


				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<table class="tb001">
							<colgroup>
								<col width="28%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="edc.lbl.CRF_VER_INFO" /></th>
									<td>
										<c:if test="${ EDC_VER != null }">
											<label>CRF Version : ${ CRF_VER } EDC Version : ${ CRF_VER }.${ EDC_VER }</label>
										</c:if>
										<input type="hidden" id="CRF_VER" value="${ CRF_VER }">
										<input type="hidden" id="EDC_VER" value="${ EDC_VER }">
										<input type="hidden" id="NEW_EDC_VER" value="${ NEW_EDC_VER }">
									</td>
								</tr>
								<tr>
									<th><spring:message code="edc.lbl.CHANGE_CRF_VER" /></th>
									<td>
										<c:forEach items="${ EDC033 }" var="list" varStatus="status">
											<input type="radio" id="change_ver_${ status.count }" name="change_ver" value="${ list.CODE }" onclick="newVersion()">
											<label for="change_ver_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
											</label>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th><spring:message code="edc.lbl.CRF_SELECT" /></th>
									<td>
										<c:set var="c_ver" value="${ fn:split(CRF_VER, '.') }" />
										<select id="crf_version" name="crf_version" disabled="disabled" onchange="setVersion();">
											<option value="${ c_ver[0] }">${ c_ver[0] }</option>
											<option value="${ c_ver[0] + 1 }">${ c_ver[0] + 1 }</option>
										</select>
										<select id="crf_version2" name="crf_version2" disabled="disabled">
											<option value="0">0</option>
											<option value="${ c_ver[1] }">${ c_ver[1] }</option>
											<option value="${ c_ver[1] + 1 }">${ c_ver[1] +1 }</option>
										</select>
									</td>
								</tr>
								<tr>
									<th><spring:message code="edc.lbl.NEW_CRF_VER_INFO" /></th>
									<td>
										<label id="versionInfo"></label>
									</td>
								</tr>
								<tr>
									<th><spring:message code="edc.lbl.CHANGE_RESN" /></th>
									<td style="padding: 7px 6px 0px 7px;">
										<textarea id="CHANGE_RESN" name="CHANGE_RESN" rows="3" style="width: 100%;"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</article>
				<article class="mgT10">
					<div style="text-align: center">
						<input type="button" id="btnSave" value="<spring:message code="btn.save" />" onclick="saveEDCVesion()" />
						<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>