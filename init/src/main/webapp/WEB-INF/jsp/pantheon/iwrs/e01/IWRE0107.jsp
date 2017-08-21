<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script type="text/javascript">
		$(function(){
			pageInit();
			buttonActive();
		});
		
		function pageInit(){
			<c:forEach var="result" items="${item}" varStatus="status">
				$("#sltItem").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			</c:forEach>
		}
		
		function buttonActive(){
			$("#btnQuerySave").click(function(){
				if(!window.confirm("저장하시겠습니까?")){
					return;
				}
				if(!mkValidation()){
					return;
				}
				
				var param = {
						QUERY_SE_CODE : $("#sltItem option:selected").val(),
						QUERY_CN : $("#txtMemo").val()
				}
				${callbackFunction}(param);
				layerClose();
			});
			
			$("#btnClose").click(function(){
				layerClose();
			});
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd700">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<h6>Query 작성</h6>
					<article class="mgT5">
						<table class="tb001">
							<colgroup>
								<col width="25%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>쿼리 생성 항목<span class='must_01'></th>
									<td>
										<select id="sltItem" valireqire="쿼리생성 항목">
											<option value="">==== 선   택 ====</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>쿼리 내용<span class='must_01'></th>
									<td>
										<textarea id="txtMemo" rows="4" style="width:100%;" valireqire="쿼리 내용" maxLength="1333"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnQuerySave" value="저장" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>	
</body>
</html>