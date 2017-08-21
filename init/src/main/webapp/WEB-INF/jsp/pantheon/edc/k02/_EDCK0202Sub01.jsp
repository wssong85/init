<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE HTML>


<script type="text/javascript">
	
</script>



	<section class="popupWrap">
		<div class="popup wd500">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<h6>신규 버전</h6>
				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<table class="tb001">
							<colgroup>
								<col width="28%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>현재 버전 정보</th>
									<td>
										<c:if test="${ EDC_VER != '-1' }">
											<label>CRF Version : ${ CRF_VER } EDC Version : ${ CRF_VER }.${ EDC_VER }</label>
										</c:if>
										<input type="hidden" id="CRF_VER" value="${ CRF_VER }">
										<input type="hidden" id="EDC_VER" value="${ EDC_VER }">
									</td>
								</tr>
								<tr>
									<th>CRF 버전 변경</th>
									<td>
										<c:forEach items="${ EDC033 }" var="list" varStatus="status">
											<input type="radio" id="versionChange_${ status.count }" name="versionChange" value="${ list.CODE }" onclick="newVersion()">
											<label for="versionChange_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
											</label>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th>CRF 버전 선택</th>
									<td>
										<c:set var="cVer" value="${ fn:split(CRF_VER, '.') }" />
										<select id="crfVersion" name="crfVersion" disabled="disabled" onchange="setVersion();" style="width:50px;">
											<option value="${ cVer[0] }">${ cVer[0] }</option>
											<option value="${ cVer[0] + 1 }">${ cVer[0] + 1 }</option>
										</select>
										<select id="crfVersion2" name="crfVersion2" disabled="disabled" style="width:50px;">
											<option value="${ cVer[1] }">${ cVer[1] }</option>
											<option value="${ cVer[1] + 1 }">${ cVer[1] + 1 }</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>신규 버전 정보</th>
									<td>
										<label id="versionInfo"></label>
									</td>
								</tr>
								
								<tr>
									<th>변경사유</th>
									<td style="padding:7px 6px 0px 7px;">
										<textarea id="CHANGE_RESN" name="CHANGE_RESN" rows="3" style="width:100%;"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</article>
				<article class="mgT10">
					<div style="text-align:center">
						<input type="button" id="btnSave" value="저장" onclick="saveEDCVesion()" />
						<input type="button" value="닫기" onclick="layerClose();">
					</div>
				</article>
			</div>
			</section>
		</div>
	</section>




