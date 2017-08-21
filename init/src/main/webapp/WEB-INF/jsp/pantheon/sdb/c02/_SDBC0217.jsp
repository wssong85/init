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
	<title>저장/삭제</title>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<script type="text/javascript">
	
	var txttrget_code = "${TRGET_CODE}";
	var txttrgetnm	  = "${TRGETNM}";
	var txttrget_mode = "${TRGET_MODE}";

	$(function(){
		init_child()
		btnInit_child();

	});

		function init_child(){			
						
			setTimeout(function(){
				$('#txtreason').focus();
			}, 500);
			
			$("#txtreason").attr("maxlength", 1000);
		}

		function btnInit_child(){
			$("#popupbtnSave").click(function(){
				if($.trim($('#txtreason').val())==""){
					alert('Reason을 입력해주세요.');
					return;
				}
				if(txttrget_mode=='U'){
					txt_mode = '수정사유';
				}else if(txttrget_mode=='D'){
					txt_mode = '삭제사유';
				}else{
					txt_mode = '';
				}

				var params = {
					TRGET_CODE			: txttrget_code,
					TRGETNM	 			: txttrgetnm,
					TRGET_MODE			: txt_mode,
					CN	 				: $.trim($("#txtreason").val()),										
					UPDATE_ID 			: '${loginMap.USER_ID}'
				};
				
				$.ajax({
					url : '/sdb/c02/insertReason.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							layerClose();
							saveLayer(txttrget_mode);
						} else {
							alert(data.errmsg);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
						layerClose();
					}
				});
			
			});
			
			
			$("#btnClose").click(function(){ 				
				layerClose();
			});
			
		}

	</script>
</head>
<body>



	<section class="popupWrap">
		<div class="popup wd400">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<h6>Reason of modify/delete</h6>
				<article class="mgT5">
					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th rowspan="2">Reason</th>
								<td style="padding:6px 6px 6px 6px;">
									<select id="" style="width:100%;">
										<option value="">====선택====</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="padding:7px 6px 0px 7px;">
									<textarea id="txtreason" rows="4" style="width:100%;" valireqire="Reason"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</article>
				<article class="mgT10">
					<div style="text-align:center">
						<input type="button" id="popupbtnSave" value="적용" />
						<input type="button" id="btnClose" value="닫기" />
					</div>
				</article>
			</div>
			</section>
		</div>
	</section>



</body>
</html>