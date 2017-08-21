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
	<meta charset="utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<script type="text/javascript">
		$(function(){
			activeButton();
			setPageController();
		});
		
		function activeButton(){
			$("#btnSave").click(function(){
				saveIpStatus();
			});
			
			$("#btnClose").click(function(){
				layerClose();
			});
		}
		
		function setPageController(){
			$("input[name=ipstatus]").change(function() {
				var radioValue = $(this).val();
				if (radioValue == "06") {
					$("#trError").show();
					$("#trQc").hide();
					$("#trErrorComment").show();
					$("input[name=iperror][value=damage]").prop("checked", "checked");
					$("#txtErrorEtc").attr("disabled", true);
					$("#txtErrorEtc").removeAttr("valireqire");
					$("#txtQcEtc").removeAttr("valireqire");
					$("#txtErrorEtc").val("");
				} else {
					$("#trError").hide();
					$("#trQc").show();
					$("#trErrorComment").hide();
					$("input[name=ipqc][value=sample]").prop("checked", true);
					$("#txtQcEtc").attr("disabled", true);
					$("#txtErrorEtc").removeAttr("valireqire");
					$("#txtQcEtc").removeAttr("valireqire");
					$("#txtQcEtc").val("");
				}
			});
			
			$("input[name=iperror]").change(function() {
				
				var radioValue = $(this).val();
				if (radioValue == "07") {
					$("#txtErrorEtc").attr("disabled", false);
					$("#txtErrorEtc").attr("valireqire", "기타");
				} else {
					$("#txtErrorEtc").attr("disabled", true);
					$("#txtErrorEtc").val("");
					$("#txtErrorEtc").removeAttr("valireqire");
				}
			});
			
			$("input[name=ipqc]").change(function() {
				var radioValue = $(this).val();
				if (radioValue == "02") {
					$("#txtQcEtc").attr("disabled", false);
					$("#txtQcEtc").attr("valireqire", "기타");
				} else {
					$("#txtQcEtc").attr("disabled", true);
					$("#txtQcEtc").val("");
					$("#txtQcEtc").removeAttr("valireqire");
				}
			});
			
			$("#trError").show();
			$("#trQc").hide();
			mkDisabled();
		}
		
		function saveIpStatus(){
			if(!window.confirm("저장하시겠습니까?")){
				return;
			}
			if(!mkValidation()){
				return;
			}
			
			var ip_error_code = "";
			var ip_etc = "";
			
			if($("input[name=ipstatus]:checked").val() == "06"){
				ip_error_code = $("input[name=iperror]:checked").val();
				ip_etc = $("#txtErrorEtc").val();
			}else{
				ip_error_code = $("input[name=ipqc]:checked").val();
				ip_etc = $("#txtQcEtc").val();
			}
			
			var param = {
					ip_code : "${ip_code}",
					ip_type : "${ip_type}",
					creat_code : "${creat_code}",
					ip_sttus_code : $("input[name=ipstatus]:checked").val(),
					ip_error_code : ip_error_code,
					ip_etc : ip_etc,
					ip_error_comment : $("#txtErrorComment").val(),
					user_id : $("#txtUserId").val(),
					password : $("#txtPass").val()
			}
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : "/iwrs/d04/updateIpStatus.do",
				success :function(data){
					if(data.result){
						alert(data.message);
						grFactoryInven.load();
						layerClose();
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd500">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<h6>IP상태등록</h6>
					<article class="mgT5">
						<table class="tb001">
							<colgroup>
								<col style="width:30%;" />
								<col style="width:70%;" />
							</colgroup>
							<tbody>
								<tr>
									<th>IP 상태<span class="must_01"></th>
									<td>
										<input type="radio" id="rdoIpError" name="ipstatus" value="06" checked="checked" /><label for="rdoIpError">오류</label>
										<input type="radio" id="rdoIpQc" name="ipstatus" value="08" /><label for="rdoIpQc">QC</label>
									</td>
								</tr>
								<tr>
									<th>IP 코드<span class="must_01"></th>
		 							<td>
		 								<input type="text" id="txtIpCode" value="${ip_code }" disabled="disabled" />
									</td>
								</tr>
								<tr id="trError">
									<th>오류<span class="must_01"></th>
									<td style="padding:7px 6px 0px 7px;">
										<input type="radio" id="rdoDamage" name="iperror" value="02" checked="checked" /><label for="rdoDamage">파손</label>
										<input type="radio" id="rdoOmission" name="iperror" value="01" /><label for="rdoOmission">분실</label><br/>
										<input type="radio" id="rdoErrorEtc" name="iperror" value="07" /><label for="rdoErrorEtc">기타</label><br/>
										<textarea id="txtErrorEtc" row="3" class="wd100Pct" maxLength="1333" able></textarea>
									</td>
								</tr>
								<tr id="trQc">
									<th>QC<span class="must_01"></th>
									<td style="padding:7px 6px 0px 7px;">
										<input type="radio" id="rdoSample" name="ipqc" value="01" checked="checked" /><label for="rdoSample">샘플링</label><br/>
										<input type="radio" id="rdoQcEtc" name="ipqc" value="02" /><label for="rdoQcEtc">기타</label>
										<textarea id="txtQcEtc" row="3" class="wd100Pct" maxLength="1333" able></textarea>
									</td>
								</tr>
								<tr id="trErrorComment">
									<th>오류코멘트</th>
									<td style="padding:7px 6px 0px 7px;">
										<textarea id="txtErrorComment" rows="3" class="wd100Pct" maxLength="1333"></textarea>
									</td>
								</tr>
								<tr>
									<th>사용자아이디<span class="must_01"></th>
									<td><input type="text" id="txtUserId" valireqire="사용자아이디" /></td>
								</tr>
								<tr>
									<th>비밀번호<span class="must_01"></th>
									<td><input type="password" id="txtPass" valireqire="비밀번호" /></td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnSave" value="저장" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>	
</body>
</html>