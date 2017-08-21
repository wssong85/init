<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		$(function(){
			createIpType();
			buttonActive();
			console.log("info : ${info}");
		});
		
		function createIpType(){
			var tableIpCode = "<table>";
			<c:forEach var="ip" items="${list}" varStatus="status">
				tableIpCode += "<tr><th>${ip.IP_TYPE}</th>";
				tableIpCode += "<td><lable>${ip.IP_CODE}</label></td></tr>";
			</c:forEach>
			tableIpCode += "</table>";
			$("#divIpInfo").append(tableIpCode);
		}
		
		function buttonActive(){
			$("#btnClose").click(function(){
				layerClose();
			});
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd500">
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5>취소확인</h5>
					</article>
					<article class="mgT5">
						<table class="tb01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:80%"/>
							</colgroup>
							<tbody>
								<tr>
									<th>요청자</th>
									<td><label>${info.DLVY_RQESTER_ID }</label></td>
								</tr>
								<tr>
									<th>IP코드</th>
									<td><div id="divIpInfo"></div></td>
								</tr>
								<tr>
									<th>취소구분</th>
									<td><label>${info.CANCEL_TYPE }</label></td>
								</tr>
								<tr>
									<th>취소사유</th>
									<td><label>${info.CANCEL_COMMENT }</label></td>
								</tr>
								<tr>
									<th>취소자</th>
									<td><label>${info.CANCEL_ID }</label></td>
								</tr>
								<tr>
									<th>취소일</th>
									<td><label>${info.DLVY_CNCDE }</label></td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>
</body>
</html>