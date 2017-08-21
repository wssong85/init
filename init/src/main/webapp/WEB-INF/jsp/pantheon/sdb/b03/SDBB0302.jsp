<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>기관등록</title>
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>
<script type="text/javascript">
var INSTT_NO = "${INSTT_NO}";
$(function(){	
	setAccodian();
	btninit();
	setinit();
	init();		
});

function btninit(){
	
	$('#btnInit').click(function() {
		$('#inputForm').each(function(){
			this.reset();
			$("#mode").val('C');
		});		
		
		$('label[popup_type=Label]').text('');
		 
		
	});
	$('#btnSave').click(function() {
		 
		if (!mkValidation()) {
			return;
		}
		
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		if ($('#mode').val() =='U'){
			updelform();	
		}else{				
			saveform();
		}
		
		
		
	});
	
	$('#btnDel').click(function(){			
		var mode = $("#mode").val();
		if(!confirm('삭제하시겠습니까?')){
			return;
		}
		if (mode =='U'){
			del_mode = 'D';
		}
		var params = {
				CURD : del_mode,					
				INSTT_NO : $("#hdinstt_no").val()
				};		
		$.ajax({
			url : "<c:url value='/sdb/b03/insertOrganList.do'/>",
			  type: 'post',
			  contentType : "application/json; charset=UTF-8",
			  data : JSON.stringify(params),
			  dataType : "json",
			  success : function(data) {
				  if(data.success){
						alert("성공");
						window.location.href = "/sdb/b03/SDBB0301.do"
				  }else{
						alert(data.errmsg);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(errorThrown);
				  alert(textStatus);
			  }			
		});
	
	 });
	
}

function setinit(){
	<c:forEach var="result" items="${printType}" varStatus="status">
	$("#slinstt_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType11}" varStatus="status">
		$("#slreprt_ty").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType10}" varStatus="status">
		$("#slqualf").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	$('#txttelno').mkTel();	
	$('#txtfax').mkTel();
	
}

function init(){
	if(INSTT_NO !=""){
		$("#slinstt_se").val(INSTT_NO);
		$("#mode").val("U`");
	}else{
		$("#mode").val("C");		
	}
	
	if(INSTT_NO != null && INSTT_NO !=""){
		var params = {
				INSTT_NO : INSTT_NO,
			};
			$.ajax({
				type		: "POST",
				url			: "/sdb/b03/selectOrganInfo.do",
				data		: params,
				dataType	: "json",
				 success : function(data) {					 
					  if(data.success){							
						  $("#hdinstt_no").val(data.result.INSTT_NO);
						  $("#hdinstt_nm").val(data.result.INSTT_NM);
						  $("#txtinstt_nm").val(data.result.INSTT_NM_KOR);
						  $("#txtinstt_nm_eng").text(data.result.INSTT_NM_ENG);
						  $("#txtinstt_code").val(data.result.INSTT_CODE);
						  $("#txtnation_code").val(data.result.NATION_CODE);
						  $("#txtadres").val(data.result.ADRES);
						  $("#txtadres_eng").text(data.result.ENG_ADRES);
						  $("#hdadres_dstnc").val(data.result.ADRES_DSTNC);
						  $("#txtadres_dstnc").val(data.result.ADRES_DSTNC_KOR);
						  $("#txtadres_dstnc_eng").text(data.result.ADRES_DSTNC_ENG);
						  $("#hdadres_cty").val(data.result.ADRES_CTY);
						  $("#txtadres_cty").val(data.result.ADRES_CTY_KOR);
						  $("#txtadres_cty_eng").text(data.result.ADRES_CTY_ENG);
						  $("#hdadres_lclty").val(data.result.ADRES_LCLTY);
						  $("#txtadres_lclty").val(data.result.ADRES_LCLTY_KOR);
						  $("#txtadres_lclty_eng").text(data.result.ADRES_LCLTY_ENG);
						  $("#txtadres_zip").val(data.result.ADRES_ZIP);
						  $("#hdreportr").val(data.result.REPORTR);
						  $("#txtreportr").val(data.result.REPORTR_KOR);
						  $("#txtreportr_eng").text(data.result.REPORTR_ENG);
						  $("#hdreportr_appn_nm").val(data.result.REPORTR_APPN_NM);
						  $("#txtreportr_appn_nm").val(data.result.REPORTR_APPN_NM_KOR);
						  $("#txtreportr_appn_nm_eng").text(data.result.REPORTR_APPN_NM_ENG);
						  $("#hdreportr_middle_nm").val(data.result.REPORTR_MIDDLE_NM);
						  $("#txtreportr_middle_nm").val(data.result.REPORTR_MIDDLE_NM_KOR);
						  $("#txtreportr_middle_nm_eng").text(data.result.REPORTR_MIDDLE_NM_ENG);
						  $("#hdreportr_family_nm").val(data.result.REPORTR_FAMILY_NM);
						  $("#txtreportr_family_nm").val(data.result.REPORTR_FAMILY_NM_KOR);
						  $("#txtreportr_family_nm_eng").text(data.result.REPORTR_FAMILY_NM_ENG);
						  $("#hdreportr_dept").val(data.result.REPORTR_DEPT);
						  $("#txtreportr_dept").val(data.result.REPORTR_DEPT_KOR);
						  $("#txtreportr_dept_eng").text(data.result.REPORTR_DEPT_ENG);
						  $("#slqualf").val(data.result.QUALF);
						  $("#slreprt_ty").val(data.result.REPRT_TY);
						  $("#txtreprt_ty_detail").val(data.result.REPRT_TY_DETAIL);
						  $("#txtreprt_ty_detail").val(data.result.REPRT_TY_DETAIL_KOR);
						  $("#txtreprt_ty_detail_eng").text(data.result.REPRT_TY_DETAIL_ENG);
						  $("#hdclass").val(data.result.CLASS);
						  $("#txtclass").val(data.result.CLASS_KOR);
						  $("#txtclass_eng").text(data.result.CLASS_ENG);
						  $("#hdmajor").val(data.result.MAJOR);
						  $("#txtmajor").val(data.result.MAJOR_KOR);
						  $("#txtmajor_eng").text(data.result.MAJOR_ENG);
						  $("#hdreprt_sj").val(data.result.REPRT_SJ);
						  $("#txtreprt_sj").val(data.result.REPRT_SJ_KOR);
						  $("#txtreprt_sj_eng").text(data.result.REPRT_SJ_ENG);
						  $("#hdspcltyrealm").val(data.result.SPCLTYREALM);
						  $("#txtspcltyrealm").val(data.result.SPCLTYREALM_KOR);
						  $("#txtspcltyrealm_eng").text(data.result.SPCLTYREALM_ENG);
						  $("#txtemail").val(data.result.EMAIL);
						  
						  var txt_telno = (isNull(data.result.TELNO  )) ? '' : data.result.TELNO;
						  var txt_fax = (isNull(data.result.FAX  )) ? '' : data.result.FAX;
						  $("#txttelno").val(txt_telno.replace(/-/g, ''));
						  $("#txtfax").val(txt_fax.replace(/-/g, ''));
						  $("#slinstt_se").val(data.result.INSTT_SE);									
						  $("#mode").val("U");						  
					  }else{
							alert(data.message);
					  }
				  }, 
				error		: function(xhr, textStatus, errorThrown){
					//alert(textStatus);
					alert("실패");
				}
			});
	}
}	

function setAccodian(){
	 for(var ai=0; ai<3; ai++){
	    aiP = ai+1;
	
		(function(aiE){ 
			$(".accordion_0"+aiE+" > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".accordion_con_0"+aiE+"").slideToggle(20);
					$(this).toggleClass('open');
					//그리드 리사이징
					//AUIGrid.resize(grNarrative_Q.id);
					AUIGrid.resize(myGridOption.id);
				}
			});
			
			$(".accordion_con_02").css({"display":""}); //시작시 아코디온 펼쳐짐
			$(".accordion_con_03").css({"display":"none"});
		
		})(aiP); //반복문 적용끝
	
	} //반복문끝
}

function updelform(){
	var param = {
			TRGET_CODE 	: $("#hdinstt_no").val(), 
			TRGETNM 	: "Instt",
			TRGET_MODE  : $('#mode').val(),
			UPDATE_ID	: '${loginMap.USER_ID}'						
		};
	mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
}


function saveform(){
	var params = {
			CURD 					: $("#mode").val(),
			INSTT_NO				: $("#hdinstt_no").val(),
			INSTT_NM				: $("#hdinstt_nm").val(),
			INSTT_NM_KOR			: $("#txtinstt_nm").val(),
			INSTT_NM_ENG			: $("#txtinstt_nm_eng").text(),
			INSTT_CODE				: $("#txtinstt_code").val(),
			NATION_CODE				: $("#txtnation_code").val(),
			ADRES					: $("#txtadres").val(),
			ENG_ADRES				: $("#txtadres_eng").text(),
			ADRES_DSTNC				: $("#hdadres_dstnc").val(),
			ADRES_DSTNC_KOR			: $("#txtadres_dstnc").val(),
			ADRES_DSTNC_ENG			: $("#txtadres_dstnc_eng").text(),
			ADRES_CTY				: $("#hdadres_cty").val(),
			ADRES_CTY_KOR			: $("#txtadres_cty").val(),
			ADRES_CTY_ENG			: $("#txtadres_cty_eng").text(),
			ADRES_LCLTY				: $("#hdadres_lclty").val(),
			ADRES_LCLTY_KOR			: $("#txtadres_lclty").val(),
			ADRES_LCLTY_ENG			: $("#txtadres_lclty_eng").text(),
			ADRES_ZIP				: $("#txtadres_zip").val(),
			REPORTR					: $("#hdreportr").val(),
			REPORTR_KOR				: $("#txtreportr").val(),
			REPORTR_ENG				: $("#txtreportr_eng").text(),
			REPORTR_APPN_NM			: $("#hdreportr_appn_nm").val(),
			REPORTR_APPN_NM_KOR		: $("#txtreportr_appn_nm").val(),
			REPORTR_APPN_NM_ENG		: $("#txtreportr_appn_nm_eng").text(),
			REPORTR_MIDDLE_NM		: $("#hdreportr_middle_nm").val(),
			REPORTR_MIDDLE_NM_KOR	: $("#txtreportr_middle_nm").val(),
			REPORTR_MIDDLE_NM_ENG	: $("#txtreportr_middle_nm_eng").text(),
			REPORTR_FAMILY_NM		: $("#hdreportr_family_nm").val(),
			REPORTR_FAMILY_NM_KOR	: $("#txtreportr_family_nm").val(),
			REPORTR_FAMILY_NM_ENG	: $("#txtreportr_family_nm_eng").text(),
			REPORTR_DEPT			: $("#hdreportr_dept").val(),
			REPORTR_DEPT_KOR		: $("#txtreportr_dept").val(),
			REPORTR_DEPT_ENG		: $("#txtreportr_dept_eng").text(),
			QUALF					: $("#slqualf").val(),
			REPRT_TY				: $("#slreprt_ty").val(),
			REPRT_TY_DETAIL			: $("#hdreprt_ty_detail").val(),
			REPRT_TY_DETAIL_KOR		: $("#txtreprt_ty_detail").val(),
			REPRT_TY_DETAIL_ENG		: $("#txtreprt_ty_detail_eng").text(),
			CLASS					: $("#hdclass").val(),
			CLASS_KOR				: $("#txtclass").val(),
			CLASS_ENG				: $("#txtclass_eng").text(),
			MAJOR					: $("#hdmajor").val(),
			MAJOR_KOR				: $("#txtmajor").val(),
			MAJOR_ENG				: $("#txtmajor_eng").text(),
			REPRT_SJ				: $("#hdreprt_sj").val(),
			REPRT_SJ_KOR			: $("#txtreprt_sj").val(),
			REPRT_SJ_ENG			: $("#txtreprt_sj_eng").text(),
			SPCLTYREALM				: $("#hdspcltyrealm").val(),
			SPCLTYREALM_KOR			: $("#txtspcltyrealm").val(),
			SPCLTYREALM_ENG			: $("#txtspcltyrealm_eng").text(),
			EMAIL					: $("#txtemail").val(),
			TELNO					: $("#txttelno").val(),
			FAX						: $("#txtfax").val(),
			INSTT_SE				: $("#slinstt_se").val(),
			UPDATE_ID 				: '${loginMap.USER_ID}'			
			};	 
	//alert(params);
	//return;
	$.ajax({
		  url : "<c:url value='/sdb/b03/insertOrganList.do'/>",
		  type: 'post',
		  contentType : "application/json; charset=UTF-8",
		  data : JSON.stringify(params),
		  dataType : "json",
		  success : function(data) {
			  if(data.success){
					//alert("성공");
					window.location.href = "/sdb/b03/SDBB0301.do"
			  }else{
					alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert("실패");
		  }
	});
	
}

function saveLayer(p_mode){		
	saveform();				
}

function EnglishNotation(idKorean, idEng){
	var txtKorean = $.trim($('#'+idKorean).val());
	var txtEng = $.trim($('#'+idEng).text());
	var param = {
			ID_KOREAN : idKorean,
			ID_ENG : idEng,
			KOREAN : txtKorean,
			ENG : txtEng
		};
		
		mkLayerPopupOpen("/sdb/c02/popupSDBC0218.do", param);
		return false;
}

</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0301&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0301&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
    <section id="mainCon">
        <div class="mainConInner">
            <article class="mainTitBox">
				<h3>${progrmMap.MENU_NM}</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						 <li>${progrmMap.UPPER_MENU_NM}</li>
						<li>${progrmMap.MENU_NM}</li>
					</ul>
				</nav>
			</article>
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
			<form id="inputForm">
				<input type="hidden" id="mode" value="C"/>
				<input type="hidden" id="hdinstt_no" />
			<div class="conBoxInner">						
				<!-- 상단 그리드  상단메뉴라인 시작-->
				<article class="conTitBtn">
					<!-- 상단 그리드 왼쪽 메뉴 시작 -->
					<div class="conTitBtnL"></div>
					<!-- 상단 그리드 왼쪽  메뉴 끝 -->
					<!-- 상단 그리드 오른쪽 메뉴 시작-->
					<div class="conTitBtnR">
						<input type="button" id="btnInit" value="초기화"/>
						<input type="button" id="btnSave" value="저장"/>
						<input type="button" id="btnDel" value="삭제"/>
					</div>
					<!-- 상단 그리드 오른쪽 메뉴 끝-->
				</article>
				<!-- 상단 그리드  상단메뉴라인 끝-->				
				<ul class="mgT50">



							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="25%" />
									<col width="12%" />
									<col width="20%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>Agency Type <span class="must_01"></span></th>
										<td colspan="5">
											<select id="slinstt_se" valireqire="Agency Type">
												<option value=''>===선택하세요===</option>								
											</select>
										</td>
									</tr>
									<tr>
										<th>Site<span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id = "txtinstt_nm"style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtinstt_nm','txtinstt_nm_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdinstt_nm" />
											<label popup_type="Label" id="txtinstt_nm_eng"></label>											
											
										</td>
										<th>Site No.<span class="must_01"></span></th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id ="txtinstt_code" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Country(code)</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtnation_code" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Address</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtaddrone" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtaddrone','txtaddrone_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdaddrone" />
											<label popup_type="Label" id="txtaddrone_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Reporter Street</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtadres_dstnc" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtadres_dstnc','txtadres_dstnc_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdadres_dstnc" />
											<label popup_type="Label" id="txtadres_dstnc_eng"></label>
										</td>
										<th>Reporter City</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtadres_cty" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtadres_cty','txtadres_cty_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdadres_cty" />
											<label popup_type="Label" id="txtadres_cty_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Reporter state or province</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtadres_lclty" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtadres_lclty','txtadres_lclty_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdadres_lclty" />
											<label popup_type="Label" id="txtadres_lclty_eng"></label>
										</td>
										<th>Reporter postcode</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtadres_zip" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Reporter</th>
										<td colspan="5">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtreportr" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtreportr','txtreportr_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreportr" />
											<label popup_type="Label" id="txtreportr_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Reporter given name</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtreportr_appn_nm" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtreportr_appn_nm','txtreportr_appn_nm_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreportr_appn_nm" />
											<label popup_type="Label" id="txtreportr_appn_nm_eng"></label>
										</td>
										<th>Reporter middle name</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtreportr_middle_nm" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtreportr_middle_nm','txtreportr_middle_nm_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreportr_middle_nm" />
											<label popup_type="Label" id="txtreportr_middle_nm_eng"></label>
										</td>
										<th>Reporter family name</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtreportr_family_nm" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtreportr_family_nm','txtreportr_family_nm_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreportr_family_nm" />
											<label popup_type="Label" id="txtreportr_family_nm_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Reporter department</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtreportr_dept" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtreportr_dept','txtreportr_dept_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreportr_dept" />
											<label popup_type="Label" id="txtreportr_dept_eng"></label>
										</td>
										<th>Qualification</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<select id="slqualf" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Report Type</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slreprt_ty" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Report Type Specify</th>
										<td colspan="3" style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtreprt_ty_detail" rows="2" style="width: 100%;"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtreprt_ty_detail','txtreprt_ty_detail_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreprt_ty_detail" />
											<label popup_type="Label" id="txtreprt_ty_detail_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Title</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtclass" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtclass','txtclass_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdclass" />
											<label popup_type="Label" id="txtclass_eng"></label>
										</td>
										<th>Specialty</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtmajor" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtmajor','txtmajor_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdmajor" />
											<label popup_type="Label" id="txtmajor_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Email</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtemail" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Phone</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txttelno" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>FAX</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtfax" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
				            <ul class="mgT20">
				                <li class="accordion_03">
				                	<a heft="#void" class="close"><span>[Q내역]</span></a>
				                    <div class="accordion_con_03 close">

				                        auigrid 영역 

				                    </div>
				                </li>
				            </ul>
				    
			</form>
			</section>
		  <!-- 컨텐츠박스 끝-->
       </div>
   </section>	
</body>
</html>