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
	<title>다국어 입력</title>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<script type="text/javascript">
	
	var txtid_korean = "${ID_KOREAN}";
	var txtid_eng = "${ID_ENG}";
	var txtkorean = "${KOREAN}";
	var txteng = "${ENG}";
		$(function(){
			init()
			btnInit();

		});

		function init(){			
			$('#txtkorean').val($.trim(txtkorean));
			$('#txteng').val($.trim(txteng));			
			setTimeout(function(){
				$('#txteng').focus();
			}, 500);
			
			$("#txtkorean").attr("maxlength", 150);
			$("#txteng").attr("maxlength", 150);
		}
		function btnInit(){
			$("#popupbtnSave").click(function(){
				$('#'+txtid_korean).val($('#txtkorean').val());
				$('#'+txtid_eng).html($('#txteng').val());
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
		<section class="conBox100 conBox">
        	<div class="conBoxInner">
				<h5>English Notation</h5>
				<article class="mgT5">
					<table class="tb01">
						<colgroup>
							<col style="width:50%;" />
							<col style="width:50%;" />
						</colgroup>
						<tbody>						
 							<tr>
								<th>LAB Comment</th>
								<td><textarea id="txtlab" style="width:100%;" rows="12" able></textarea></td>
								
							</tr>
							<tr>
								<th>작성자</th>
								<td><input type="text" id="txtwriter"/></td>
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