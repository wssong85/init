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
	<title>Insert title here</title>
	<script type="text/javascript">
		$(function(){
			createPageController();
			buttonActive();
			selectActive();
		});
		
		function createPageController(){
			<c:forEach var="result" items="${printType}" varStatus="status">
				$("#sltPrintType").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			</c:forEach>
			<c:forEach var="result" items="${siteType}" varStatus="status">
				$("#sltSite").append("<option value='<c:out value="${result.INSTT_CODE}"/>'>" + '<c:out value="${result.NAME1}"/>' + "</option>");
			</c:forEach>
			<c:forEach var="result" items="${subjectType}" varStatus="status">
				$("#sltSubject").append("<option value='<c:out value="${result.SUBJECT_NO}"/>'>" + '<c:out value="${result.SUBJECT_NO}"/>' + "</option>");
			</c:forEach>
			<c:forEach var="result" items="${ipType}" varStatus="status">
				$("#sltIpType").append("<option value='<c:out value="${result.IP_TYPE}"/>'>" + '<c:out value="${result.IP_TYPE}"/>' + "</option>");
			</c:forEach>
			
			$("#trSite").hide();
			$("#trSubject").hide();
			$("#trIpType").hide();
		}
		
		function buttonActive(){
			$("#btnPrint").click(function(){
				if($("#sltPrintType option:selected").val() == "01"){
					var param = {
							MRD_NAME : "IP_ACCOUNTABILITY_BY_SITE.mrd"
					};

					var f = document.createElement("form");
					
					$.each(param, function(key, value){
						var obj;
						obj = document.createElement("input");
						obj.setAttribute("type", "hidden");
						obj.setAttribute("name", key);
						obj.setAttribute("value", value);
						f.appendChild(obj);	
					});
					
					window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
					
					f.setAttribute("method", "post");
					f.setAttribute("action", "/com/system/CommonRD.do");
					f.setAttribute("target", "popForm");
					document.body.appendChild(f);
					f.submit();	
				}else{
					var param = {
							MRD_NAME : "IP_ACCOUNTABILITY_BY_SUBJECT.mrd"
					};

					var f = document.createElement("form");
					
					$.each(param, function(key, value){
						var obj;
						obj = document.createElement("input");
						obj.setAttribute("type", "hidden");
						obj.setAttribute("name", key);
						obj.setAttribute("value", value);
						f.appendChild(obj);	
					});
					
					window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
					
					f.setAttribute("method", "post");
					f.setAttribute("action", "/com/system/CommonRD.do");
					f.setAttribute("target", "popForm");
					document.body.appendChild(f);
					f.submit();
				}
			});
			
			$("#btnClose").click(function(){
				layerClose();	
			});
		}
		
		function selectActive(){
			$("#sltPrintType").change(function(){
				if($("#sltPrintType option:selected").val() == "01"){
					$("#trSite").show();
					$("#trSubject").hide();
					$("#trIpType").show();
				}else if($("#sltPrintType option:selected").val() == "02"){
					$("#trSite").hide();
					$("#trSubject").show();
					$("#trIpType").hide();
				}else{
					$("#trSite").hide();
					$("#trSubject").hide();
					$("#trIpType").hide();
				}
			});
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd500 hei250">
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5>IP수불문서 출력 설정</h5>
					</article>
					<article class="mgT5">
						<table class="tb01">
							<colgroup>
								<col style="width:30%;" />
								<col style="width:70%;" />
							</colgroup>
							<tbody>
								<tr>
									<th>출력구분</th>
									<td>
										<select id="sltPrintType" valireqire="출력구분">
											<option value="">---선택하세요---</option>
										</select>
									</td>
								</tr>
								<tr id="trSite">
									<th>Site</th>
									<td>
										<select id="sltSite" valireqire="Site">
											<option value="">---선택하세요---</option>
										</select>
									</td>
								</tr>
								<tr id="trSubject">
									<th>Subject</th>
									<td>
										<select id="sltSubject" valireqire="Subject">
											<option value="">---선택하세요---</option>
										</select>
									</td>
								</tr>
								<tr id="trIpType">
									<th>IP Type</th>
									<td>
										<select id="sltIpType" valireqire="Ip Type">
											<option value="">---선택하세요---</option>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnPrint" value="출력" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>
</body>
</html>