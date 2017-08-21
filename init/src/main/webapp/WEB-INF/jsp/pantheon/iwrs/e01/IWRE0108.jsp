<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<style>
		table.tb004 {
			width: 100%;
			border-top: 1px solid #7287e4;
			margin-bottom: 5px;
		}
		
		table.tb004 th {
			color: #333;
			border-right: 1px solid #e6e6e6;
			border-left: 1px solid #e6e6e6;
			border-bottom: 1px solid #e6e6e6;
			font-family: 'NanumGothicBold';
			background: #f6f7ff;
			height: 28px;
			font-size: 12px;
			line-height: 15px;
			padding: 3px 4px 3px 4px;
			text-align: center;
			vertical-align: middle;
			Letter-spacing: 0px;
			box-sizing: border-box;
		}
		
		table.tb004 td {
			font-family: 'NanumGothic';
			border-right: 1px solid #e6e6e6;
			border-left: 1px solid #e6e6e6;
			border-bottom: 1px solid #e6e6e6;
			color: #555;
			background: #FFFFFF;
			height: 36px;
			padding: 4px 4px 4px 4px;
			vertical-align: middle;
			font-size: 12px;
			Letter-spacing: 0px;
			box-sizing: border-box;
		}
		
		table.tb004 tr:last-child {
			border-bottom: 1px solid #e6e6e6;
		}
		
		table.tb004 tr:last-child td {
			border-bottom: 0px;
		}
		
		table.tb004_no_border, table.tb004_no_border tr, table.tb004_no_border th, table.tb004_no_border td {
			border: none !important;
		}
		
		table.tbl_query tr td {
			border: none !important;
			cursor: pointer;
		}
		
		table.tbl_query td.crf_query_status {
			text-align: center;
			vertical-align: top;
			font-weight: bold;
			padding-top: 8px;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			buttonActive();
		});
		
		function buttonActive(){
			$("#btnQuerySave").click(function(){
				if(!window.confirm("저장하시겠습니까?")){
					return;
				}
				if(!mkValidation()){
					return;
				}
				
				var param = {
						RESN : $("#txtResn").val(),
						QUERY_END_TYPE : $("input:radio[name=end_type]:checked").val(),
						QUERY_SN : "${QUERY_SN}",
						QUERY_GROUP : "${QUERY_GROUP}",
						QUERY_CN : "${QUERY_CN}",
						RTUN_NO : "${RTUN_NO}",
						DLVY_SE_CODE : "${DLVY_SE_CODE}",
						QUERY_SE_CODE : "${QUERY_SE_CODE}"
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
					<h6>Query 확인</h6>
					<article class="mgT5">
						<table class="tb004">
							<colgroup>
								<col width="25%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>
										<lbael>쿼리 응답</lbael>
									</th>
								</tr>
								<tr>
									<td>
										<textarea style="width: 100%; height: 50px;" id="txtResn" valireqire="Query 응답"></textarea>
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