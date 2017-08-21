<%@page pageEncoding="UTF-8"%>


<%
	final String pathUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>보고서</title>
</head>
<body>


<!--------------메일 시작-------------->


<table width="720" border="0" cellspacing="0" cellpadding="0" align="center" style="background:#5570e6;  border-radius:8px 8px 0px 0px;">
	<tr>
		<td style="padding:0px; width:130px;"><a href="#link" target="_blank"><img src="<%=pathUrl%>/images/pantheon/mail/logo.png" border="0" /></a></td>
		<th style="font-family:'맑은 고딕', sans-serif; font-size:14px; line-height:20px; color:#ffffff; text-align:right; padding:20px 30px 20px 0px;">
			※ 결재문서가 발송되었습니다.
		</th>
	</tr>
</table>





<table width="720" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td style="padding:10px;border:1px solid #cccccc; border-top:none;  border-radius:0px 0px 8px 8px; height:200px; text-align:center; vertical-align:top;">
		
			<div style="margin:10px 0 10px 0;">
				<div style="background:#6e85e9; border-radius:4px; font-size:14px;line-height:20px; width:180px; margin:0 auto; font-family:'맑은 고딕', sans-serif;">
					<a href="#" style="text-decoration:none; color:#ffffff; display:block;padding:10px 0 12px 0; font-weight: bold;" target="_blank">보고서 바로가기</a>
				</div>
			</div>
		
		
			<div style="font-size:14px;line-height:16px;font-family:'맑은 고딕', sans-serif; color:#303030; margin:20px 0 20px 0; letter-spacing:0px;">바로가기가 안 될 경우 브라우저 <strong>팝업창 차단 설정</strong>이 되어 있는지 확인해주시기 바랍니다.</div>



			<div style="border-bottom:1px solid #7287e4;"></div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse; border-spacing:0;  ">
				<colgroup>
					<col width="110px" />
					<col width="" />
				</colgroup>
				<tr>
					<th style="font-size:12px;line-height:15px; font-family:'맑은 고딕', sans-serif; color:#000000; text-align:left; background:#f6f7ff; border-bottom:1px solid #e6e6e6;border-right:1px solid #e6e6e6; padding:10px 10px 10px 20px;">제목</th>
					<td style="font-size:12px;line-height:15px; font-family:'맑은 고딕', sans-serif; color:#555555;  text-align:left; padding:10px; border-bottom:1px solid #e6e6e6;">[CJ_TLS_P01] 연구기관방문보고서_예수병원_임주현</td>
				</tr>
				<tr>
					<th style="font-size:12px;line-height:15px; font-family:'맑은 고딕', sans-serif; color:#000000; text-align:left; background:#f6f7ff; border-bottom:1px solid #e6e6e6;border-right:1px solid #e6e6e6; padding:10px 10px 10px 20px;">기안자</th>
					<td style="font-size:12px;line-height:15px; font-family:'맑은 고딕', sans-serif; color:#555555;  text-align:left; padding:10px; border-bottom:1px solid #e6e6e6;">문현준님(임상정보팀)</td>
				</tr>
				<tr>
					<th style="font-size:12px;line-height:15px; font-family:'맑은 고딕', sans-serif; color:#000000; text-align:left; background:#f6f7ff; border-bottom:1px solid #e6e6e6;border-right:1px solid #e6e6e6; padding:10px 10px 10px 20px;">기안일자</th>
					<td style="font-size:12px;line-height:15px; font-family:'맑은 고딕', sans-serif; color:#555555;  text-align:left; padding:10px; border-bottom:1px solid #e6e6e6;">2016-05-30 10:08:06</td>
				</tr>
			</table>
			
			<div style="height:7px; font:0/0 arial;"></div>


		</td>
	</tr>
</table>


<!--------------메일 끝-------------->





</body>
</html>
