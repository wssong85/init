<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false" />
  <title>Study 등록/수정/삭제</title>
<script type="text/javascript">
var PRTCL_NO = "${PRTCL_NO}";
var NEW_PRTCL_NO = "${NEW_PRTCL_NO}";

$(function(){
	btnInit();
	setInit();
	setAccodian();
	init();
	//그리드
	grStudy_Q.createGrid();
	
});

function btnInit(){	
	$('input[popup_type=Q]').click(function(){
		alert('쿼리팝업');
		return false;
	});
	
	$('input[popup_type=protocol], button[popup_type=protocol]').click(function(){
		mkLayerPopupOpen("/sdb/c01/popupSDBC0103.do", null);
		if (typeof grEdc.id !== "undefined") {
			AUIGrid.resize(grEdc.id);
		}		
		return false;
	});
	
	$('button[popup_type=ProductSearch], input[popup_type=ProductSearch]').click(function(){
		mkLayerPopupOpen("/sdb/b02/popupSDBB0204.do", null);
		if (typeof grProductList_Search.id !== "undefined") {
			AUIGrid.resize(grProductList_Search.id); 
		}
		return false;
	});
			
	$('#tabTrial').click(function(){
		window.location.href ="/sdb/c01/SDBC0101.do";
	});
	$('#tabSpontaneous').click(function(){
		window.location.href ="/sdb/c01/SDBC0104.do";
	});
	$('#tabLiterature').click(function(){
		window.location.href ="/sdb/c01/SDBC0106.do";  
	});	
	$('#tabEtc').click(function(){
		window.location.href ="/sdb/c01/SDBC0108.do";
	});
	$('#tabICSR').click(function(){
		window.location.href ="/sdb/c01/SDBC0110.do";
	});
	
	$('#btnInit').click(function() {
		//var check_code = $("#tx	tEtcno").val();
		$('#iform').each(function() {
			this.reset();
		});
		
		$('label[popup_type=Label]').text('');
	});
	
	$('#slrymslmdong_ctrl_data_trnsmis_a').change(function(){
		if($('#slrymslmdong_ctrl_data_trnsmis_a').val()=="Y"){
			$('#txtrymslmdong_ctrl_data_trnsmisde').attr("disabled", false);
			$('#data_trnsmisde .ui-datepicker-trigger').show();
		}else{
			$('#txtrymslmdong_ctrl_data_trnsmisde').attr("disabled", true);
			$('#data_trnsmisde .ui-datepicker-trigger').hide();
			
		}
	});
	
	$('#slrsrch_knd_code').change(function(){
		if($('#slrsrch_knd_code').val()=="30"){
			$('#slclinc_ty_code').attr("disabled", false);
			$('#txtrsrch_knd_etc_matter_memo').attr("disabled", true);
			
		}else if($('#slrsrch_knd_code').val()=="50"){
			$('#slclinc_ty_code').attr("disabled", true);
			$('#txtrsrch_knd_etc_matter_memo').attr("disabled", false);
		}
		else{
			$('#slclinc_ty_code').attr("disabled", true);
			$('#txtrsrch_knd_etc_matter_memo').attr("disabled", true);
		}
	});

	$('#slmfds_confm_at').change(function(){
		if($('#slmfds_confm_at').val()=="Y"){
			$('#txtmfds_confm_dte').attr("disabled", false);
			$('#confm_dte .ui-datepicker-trigger').show();
		}else{
			$('#txtmfds_confm_dte').attr("disabled", true);
			$('#confm_dte .ui-datepicker-trigger').hide();
			
		}
	});
	
	$('#slrymslmdong_ctrl_at').change(function(){
		if($('#slrymslmdong_ctrl_at').val()=="Y"){
			$('#txtrymslmdong_ctrl_cmpnynm').attr("disabled", false);
			$('#txtrymslmdong_ctrl_prductnm').attr("disabled", false);
			
		}else{
			$('#txtrymslmdong_ctrl_cmpnynm').attr("disabled", true);
			$('#txtrymslmdong_ctrl_prductnm').attr("disabled", true);
			
		}
	});
	
	
	$('#btnSave').click(function(){
		if (!mkValidation()) {
			return;
		}		
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		if($.trim($("#mode").val())=='U'){
			var param = {
				TRGET_CODE 	: $("#txtprtcl_no").val(),
				TRGETNM 	: "STU",
				TRGET_MODE  : "U",
				UPDATE_ID	: '${loginMap.USER_ID}'						
			};
			mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
		}
		else{
			var params = {
				CURD 							: $.trim($("#mode").val()),
				PRTCL_NO						: $.trim($("#txtprtcl_no").val()),
				PRDUCT_CODE						: $.trim($("#hdProductCode").val()),
				RSRCH_KND_CODE					: $.trim($("#slrsrch_knd_code").val()),
				CLINC_TY_CODE					: $.trim($("#slclinc_ty_code").val()),
				MFDS_CONFM_AT					: $.trim($("#slmfds_confm_at").val()),
				MFDS_CONFM_DTE					: $.trim($("#txtmfds_confm_dte").val()),
				FRT_PATNT_OCCRRNCDE				: $.trim($("#txtfrt_patnt_occrrncde").val()),
				LAST_PATNT_OCCRRNCDE			: $.trim($("#txtlast_patnt_occrrncde").val()),
				RYMSLMDONG_CTRL_AT				: $.trim($("#slrymslmdong_ctrl_at").val()),
				RYMSLMDONG_CTRL_DATA_TRNSMIS_A	: $.trim($("#txtrymslmdong_ctrl_data_trnsmis_a").val()),
				RYMSLMDONG_CTRL_DATA_TRNSMISDE	: $.trim($("#txtrymslmdong_ctrl_data_trnsmisde").val()),
				SAFEHELTH_DTA_LOCK_DTE			: $.trim($("#txtsafehelth_dta_lock_dte").val()),
				SAFE_POPLTN						: $.trim($("#txtsafe_popltn").val()),
				MEDDRA_VER						: $.trim($("#slmeddra_ver").val()),
				KCM_VER							: $.trim($("#slkcm_ver").val()),
				WHOART_VER						: $.trim($("#slwhoart_ver").val()),
				ATC_VER							: $.trim($("#slatc_ver").val()),
				//다국어 관련필드
				RSRCH_KND_ETC_MATTER_MEMO		: $.trim($("#hdrsrch_knd_etc_matter_memo").val()),
				RSRCH_KND_ETC_MATTER_MEMO_KOR	: $.trim($("#txtrsrch_knd_etc_matter_memo").val()),
				RSRCH_KND_ETC_MATTER_MEMO_ENG	: $.trim($("#txtrsrch_knd_etc_matter_memo_eng").text()),
				PRTCL_NM						: $.trim($("#hdprtcl_nm").val()),
				PRTCL_NM_KOR					: $.trim($("#txtprtcl_nm").val()),
				PRTCL_NM_ENG					: $.trim($("#txtprtcl_nm_eng").text()),				
				RYMSLMDONG_CTRL_CMPNYNM			: $.trim($("#hdrymslmdong_ctrl_cmpnynm").val()),
				RYMSLMDONG_CTRL_CMPNYNM_KOR		: $.trim($("#txtrymslmdong_ctrl_cmpnynm").val()),
				RYMSLMDONG_CTRL_CMPNYNM_ENG		: $.trim($("#txtrymslmdong_ctrl_cmpnynm_eng").text()),
				RYMSLMDONG_CTRL_PRDUCTNM		: $.trim($("#hdrymslmdong_ctrl_prductnm").val()),
				RYMSLMDONG_CTRL_PRDUCTNM_KOR	: $.trim($("#txtrymslmdong_ctrl_prductnm").val()),
				RYMSLMDONG_CTRL_PRDUCTNM_ENG	: $.trim($("#txtrymslmdong_ctrl_prductnm_eng").text()),				
				ETC_INFO_ONE 					: $.trim($("#hdOtherInfo1").val()),
				ETC_INFO_ONE_KOR 				: $.trim($("#txtOtherInfo1").val()),
				ETC_INFO_ONE_ENG 				: $.trim($("#txtOtherInfo1_eng").text()),
				ETC_INFO_TWO 					: $.trim($("#hdOtherInfo2").val()),
				ETC_INFO_TWO_KOR 				: $.trim($("#txtOtherInfo2").val()),
				ETC_INFO_TWO_ENG 				: $.trim($("#txtOtherInfo2_eng").text()),
				ETC_INFO_THREE 					: $.trim($("#hdOtherInfo3").val()),
				ETC_INFO_THREE_KOR 				: $.trim($("#txtOtherInfo3").val()),
				ETC_INFO_THREE_ENG 				: $.trim($("#txtOtherInfo3_eng").text()),
				UPDATE_ID 						: '${loginMap.USER_ID}'
			};
			$.ajax({
				url : '/sdb/c01/insertStudyInfo.do',
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						alert("성공");
						window.location.href= "/sdb/c01/SDBC0101.do";
						
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		}
	});
	

	$('#btnDel').click(function() {
		if ($.trim($("#mode").val()) == 'U') {
			if (!confirm('삭제하시겠습니까?')) {
				return;
			}
			var param = {
				TRGET_CODE 	: $("#txtprtcl_no").val(),
				TRGETNM 	: "STU",
				TRGET_MODE  : "D",
				UPDATE_ID	: '${loginMap.USER_ID}'						
			};
			mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
		} 
	});

	$('#btnAudit').click(function() {
		alert('Audit팡법');
		return false;
	});
	
	
}

function saveLayer(p_mode){		
	if(p_mode=='U'){
		var params = {
			CURD 							: $.trim($("#mode").val()),
			PRTCL_NO						: $.trim($("#txtprtcl_no").val()),
			PRDUCT_CODE						: $.trim($("#hdProductCode").val()),
			RSRCH_KND_CODE					: $.trim($("#slrsrch_knd_code").val()),
			CLINC_TY_CODE					: $.trim($("#slclinc_ty_code").val()),
			MFDS_CONFM_AT					: $.trim($("#slmfds_confm_at").val()),
			MFDS_CONFM_DTE					: $.trim($("#txtmfds_confm_dte").val()),
			FRT_PATNT_OCCRRNCDE				: $.trim($("#txtfrt_patnt_occrrncde").val()),
			LAST_PATNT_OCCRRNCDE			: $.trim($("#txtlast_patnt_occrrncde").val()),
			RYMSLMDONG_CTRL_AT				: $.trim($("#slrymslmdong_ctrl_at").val()),
			RYMSLMDONG_CTRL_DATA_TRNSMIS_A	: $.trim($("#txtrymslmdong_ctrl_data_trnsmis_a").val()),
			RYMSLMDONG_CTRL_DATA_TRNSMISDE	: $.trim($("#txtrymslmdong_ctrl_data_trnsmisde").val()),
			SAFEHELTH_DTA_LOCK_DTE			: $.trim($("#txtsafehelth_dta_lock_dte").val()),
			SAFE_POPLTN						: $.trim($("#txtsafe_popltn").val()),
			MEDDRA_VER						: $.trim($("#slmeddra_ver").val()),
			KCM_VER							: $.trim($("#slkcm_ver").val()),
			WHOART_VER						: $.trim($("#slwhoart_ver").val()),
			ATC_VER							: $.trim($("#slatc_ver").val()),
			//다국어 관련필드
			RSRCH_KND_ETC_MATTER_MEMO		: $.trim($("#hdrsrch_knd_etc_matter_memo").val()),
			RSRCH_KND_ETC_MATTER_MEMO_KOR	: $.trim($("#txtrsrch_knd_etc_matter_memo").val()),
			RSRCH_KND_ETC_MATTER_MEMO_ENG	: $.trim($("#txtrsrch_knd_etc_matter_memo_eng").text()),
			PRTCL_NM						: $.trim($("#hdprtcl_nm").val()),
			PRTCL_NM_KOR					: $.trim($("#txtprtcl_nm").val()),
			PRTCL_NM_ENG					: $.trim($("#txtprtcl_nm_eng").text()),				
			RYMSLMDONG_CTRL_CMPNYNM			: $.trim($("#hdrymslmdong_ctrl_cmpnynm").val()),
			RYMSLMDONG_CTRL_CMPNYNM_KOR		: $.trim($("#txtrymslmdong_ctrl_cmpnynm").val()),
			RYMSLMDONG_CTRL_CMPNYNM_ENG		: $.trim($("#txtrymslmdong_ctrl_cmpnynm_eng").text()),
			RYMSLMDONG_CTRL_PRDUCTNM		: $.trim($("#hdrymslmdong_ctrl_prductnm").val()),
			RYMSLMDONG_CTRL_PRDUCTNM_KOR	: $.trim($("#txtrymslmdong_ctrl_prductnm").val()),
			RYMSLMDONG_CTRL_PRDUCTNM_ENG	: $.trim($("#txtrymslmdong_ctrl_prductnm_eng").text()),				
			ETC_INFO_ONE 					: $.trim($("#hdOtherInfo1").val()),
			ETC_INFO_ONE_KOR 				: $.trim($("#txtOtherInfo1").val()),
			ETC_INFO_ONE_ENG 				: $.trim($("#txtOtherInfo1_eng").text()),
			ETC_INFO_TWO 					: $.trim($("#hdOtherInfo2").val()),
			ETC_INFO_TWO_KOR 				: $.trim($("#txtOtherInfo2").val()),
			ETC_INFO_TWO_ENG 				: $.trim($("#txtOtherInfo2_eng").text()),
			ETC_INFO_THREE 					: $.trim($("#hdOtherInfo3").val()),
			ETC_INFO_THREE_KOR 				: $.trim($("#txtOtherInfo3").val()),
			ETC_INFO_THREE_ENG 				: $.trim($("#txtOtherInfo3_eng").text()),
			UPDATE_ID 						: '${loginMap.USER_ID}'
		};
		$.ajax({
			url : '/sdb/c01/insertStudyInfo.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if (data.success) {
					//alert("성공");
					window.location.href= "/sdb/c01/SDBC0101.do";
					
				} else {
					alert(data.errmsg);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
			}
		});
	}
	else if(p_mode=='D'){		
		var params = {
			CURD : 'D',
			PRTCL_NO : $.trim($("#txtprtcl_no").val())
		};
		$.ajax({
			type : "POST",
			url : "/sdb/c01/insertStudyInfo.do",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if (data.success) {
					//alert("성공");
					window.location.href= "/sdb/c01/SDBC0101.do";
		
				} else {
					alert(result.errmsg);
				}
			},
			error : function(xhr, textStatus, errorThrown) {
				//alert(textStatus);
				alert("실패");
			}
		});
	} 	
}

function setInit(){
	<c:forEach var="result" items="${printType}" varStatus="status">
	$("#slrsrch_knd_code").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	<c:forEach var="result" items="${printType2}" varStatus="status">
	$("#slclinc_ty_code").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	<c:forEach var="result" items="${printType3}" varStatus="status">
	$("#slmfds_confm_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	<c:forEach var="result" items="${printType3}" varStatus="status">
	$("#slrymslmdong_ctrl_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	<c:forEach var="result" items="${printType3}" varStatus="status">
	$("#slrymslmdong_ctrl_data_trnsmis_a").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	mkSetDatePickerYYMMDD("#txtmfds_confm_dte");
	mkSetDatePickerYYMMDD("#txtfrt_patnt_occrrncde", "#txtlast_patnt_occrrncde");
	//mkSetDatePickerYYMMDD("#txtlast_patnt_occrrncde");
	mkSetDatePickerYYMMDD("#txtrymslmdong_ctrl_data_trnsmisde");
	mkSetDatePickerYYMMDD("#txtsafehelth_dta_lock_dte");
	$('#txtmfds_confm_dte').val('');
	$('#txtfrt_patnt_occrrncde').val('');
	$('#txtlast_patnt_occrrncde').val('');
	$('#txtrymslmdong_ctrl_data_trnsmisde').val('');
	$('#txtsafehelth_dta_lock_dte').val('');
	
	$("#txtmfds_confm_dte").attr("maxlength", 10);
	$("#txtfrt_patnt_occrrncde").attr("maxlength", 10);
	$("#txtlast_patnt_occrrncde").attr("maxlength", 10);
	$("#txtrymslmdong_ctrl_data_trnsmisde").attr("maxlength", 10);
	$("#txtsafehelth_dta_lock_dte").attr("maxlength", 10);
	
	$("#txtprtcl_nm").attr("maxlength", 100);
	$("#txtrsrch_knd_etc_matter_memo").attr("maxlength", 150);
	$("#txtrymslmdong_ctrl_cmpnynm").attr("maxlength", 100);	
	$("#txtrymslmdong_ctrl_prductnm").attr("maxlength", 40);
	
	$("#txtsafe_popltn").attr("maxlength", 5);	
	
	$('#txtrymslmdong_ctrl_data_trnsmisde').attr("disabled", true);
	//달력버튼 hide
	$('#data_trnsmisde .ui-datepicker-trigger').hide();
	
	$('#slclinc_ty_code').attr("disabled", true);
	$('#txtrsrch_knd_etc_matter_memo').attr("disabled", true);
	$('#txtrymslmdong_ctrl_cmpnynm').attr("disabled", true);
	$('#txtrymslmdong_ctrl_prductnm').attr("disabled", true);
	$('#txtmfds_confm_dte').attr("disabled", true);
	$('#confm_dte .ui-datepicker-trigger').hide();
	

	
	$("input[popup_type=Q]").attr("title", "Query");
	$("input[popup_type=E]").attr("title", "English Notation");
	
	//숫자만 허용
	$('#txtsafe_popltn').mkNumber();
	
	
}

function setAccodian(){
	 for(var ai=0; ai<3; ai++){
	    aiP = ai+1;
	
		(function(aiE){ 
			$(".acdMenuLst0"+aiE+" > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".acdMenuCts0"+aiE+"").slideToggle(500);
					$(this).toggleClass('open');
					//그리드 리사이징
					AUIGrid.resize(grStudy_Q.id);
				}
			});
			
			if ( aiE !=2 ) {
				$(".acdMenuLst0"+aiE+"").not(this).on("click",function() {
					if ($(".acdMenuLst0"+aiE+"").not(this).children().hasClass("close")) {
						$(".acdMenuLst0"+aiE+"").not(this).children(".acdMenuCts0"+aiE+"").slideUp(500);
					}
				});
				
				$(".acdMenuLst0"+aiE+" > a").not(this).on("click",function() {
					if ($(".acdMenuLst0"+aiE+" > a").hasClass('open')) {
						$(".acdMenuLst0"+aiE+" > a").not(this).removeClass('open');
					}
				});
			} //조건문끝
		
		})(aiP); //반복문 적용끝
	
	} //반복문끝
}

window.onresize = function() {
	if (typeof grStudy_Q.id !== "undefined") {
		AUIGrid.resize(grStudy_Q.id);
	}

}

function init(){
	if (PRTCL_NO != "") {
		$('#mode').val('U');
	} else {
		$('#mode').val('C');
	}
	$("#txtprtcl_no").val(NEW_PRTCL_NO);
	
	//수정모드인 경우
	if (PRTCL_NO != null && PRTCL_NO != "") {
		// 여기붙터 해야됨
		var params = {
				PRTCL_NO : PRTCL_NO
			};
			$.ajax({
				type : "post",
				url : "/sdb/c01/selectStudyInfo.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var prtcl_no   = (isNull(data.result.PRTCL_NO  )) ? '' : data.result.PRTCL_NO;
						var prduct_code   = (isNull(data.result.PRDUCT_CODE  )) ? '' : data.result.PRDUCT_CODE;
						var prductnm_code   = (isNull(data.result.PRDUCTNM_CODE  )) ? '' : data.result.PRDUCTNM_CODE;
						
						
						var rsrch_knd_code = (isNull(data.result.RSRCH_KND_CODE)) ? '' : data.result.RSRCH_KND_CODE;
						var clinc_ty_code  = (isNull(data.result.CLINC_TY_CODE )) ? '' : data.result.CLINC_TY_CODE ;
						var mfds_confm_at = (isNull(data.result.MFDS_CONFM_AT)) ? '' : data.result.MFDS_CONFM_AT;
						var mfds_confm_dte = (isNull(data.result.MFDS_CONFM_DTE)) ? '' : data.result.MFDS_CONFM_DTE;
						var frt_patnt_occrrncde = (isNull(data.result.FRT_PATNT_OCCRRNCDE)) ? '' : data.result.FRT_PATNT_OCCRRNCDE;
						var last_patnt_occrrncde = (isNull(data.result.LAST_PATNT_OCCRRNCDE)) ? '' : data.result.LAST_PATNT_OCCRRNCDE;
						var rymslmdong_ctrl_at = (isNull(data.result.RYMSLMDONG_CTRL_AT)) ? '' : data.result.RYMSLMDONG_CTRL_AT;
						var rymslmdong_ctrl_cmpnynm = (isNull(data.result.RYMSLMDONG_CTRL_CMPNYNM)) ? '' : data.result.RYMSLMDONG_CTRL_CMPNYNM;
						var rymslmdong_ctrl_prductnm = (isNull(data.result.RYMSLMDONG_CTRL_PRDUCTNM)) ? '' : data.result.RYMSLMDONG_CTRL_PRDUCTNM;
						var rymslmdong_ctrl_data_trnsmis_a = (isNull(data.result.RYMSLMDONG_CTRL_DATA_TRNSMIS_A)) ? '' : data.result.RYMSLMDONG_CTRL_DATA_TRNSMIS_A;
						var rymslmdong_ctrl_data_trnsmisde = (isNull(data.result.RYMSLMDONG_CTRL_DATA_TRNSMISDE)) ? '' : data.result.RYMSLMDONG_CTRL_DATA_TRNSMISDE;
						var safehelth_dta_lock_dte = (isNull(data.result.SAFEHELTH_DTA_LOCK_DTE)) ? '' : data.result.SAFEHELTH_DTA_LOCK_DTE;
						var safe_popltn = (isNull(data.result.SAFE_POPLTN)) ? '' : data.result.SAFE_POPLTN;
						var meddra_ver = (isNull(data.result.MEDDRA_VER)) ? '' : data.result.MEDDRA_VER;
						var kcm_ver = (isNull(data.result.KCM_VER)) ? '' : data.result.KCM_VER;
						var whoart_ver = (isNull(data.result.WHOART_VER)) ? '' : data.result.WHOART_VER;
						var atc_ver = (isNull(data.result.ATC_VER)) ? '' : data.result.ATC_VER;
						var prtcl_nm  = (isNull(data.result.PRTCL_NM )) ? '' : data.result.PRTCL_NM ;
						var rsrch_knd_etc_matter_memo  = (isNull(data.result.RSRCH_KND_ETC_MATTER_MEMO )) ? '' : data.result.RSRCH_KND_ETC_MATTER_MEMO;
						var safe_popltn = (isNull(data.result.SAFE_POPLTN)) ? '' : data.result.SAFE_POPLTN;
						var etc_info_one  = (isNull(data.result.ETC_INFO_ONE )) ? '' : data.result.ETC_INFO_ONE;
						var etc_info_two = (isNull(data.result.ETC_INFO_TWO)) ? '' : data.result.ETC_INFO_TWO;
						var etc_info_three  = (isNull(data.result.ETC_INFO_THREE )) ? '' : data.result.ETC_INFO_THREE ;
						var prtcl_nm_kor = (isNull(data.result.PRTCL_NM_KOR)) ? '' : data.result.PRTCL_NM_KOR;
						var prtcl_nm_eng = (isNull(data.result.PRTCL_NM_ENG)) ? '' : data.result.PRTCL_NM_ENG;
						var rsrch_knd_etc_matter_memoe_kor = (isNull(data.result.RSRCH_KND_ETC_MATTER_MEMOE_KOR)) ? '' : data.result.RSRCH_KND_ETC_MATTER_MEMOE_KOR;
						var rsrch_knd_etc_matter_memo_eng = (isNull(data.result.RSRCH_KND_ETC_MATTER_MEMO_ENG)) ? '' : data.result.RSRCH_KND_ETC_MATTER_MEMO_ENG;
						var rymslmdong_ctrl_cmpnynm_kor = (isNull(data.result.RYMSLMDONG_CTRL_CMPNYNM_KOR)) ? '' : data.result.RYMSLMDONG_CTRL_CMPNYNM_KOR;
						var rymslmdong_ctrl_cmpnynm_eng   = (isNull(data.result.RYMSLMDONG_CTRL_CMPNYNM_ENG  )) ? '' : data.result.RYMSLMDONG_CTRL_CMPNYNM_ENG;
						var rymslmdong_ctrl_prductnm_kor = (isNull(data.result.RYMSLMDONG_CTRL_PRDUCTNM_KOR)) ? '' : data.result.RYMSLMDONG_CTRL_PRDUCTNM_KOR;
						var rymslmdong_ctrl_prductnm_eng   = (isNull(data.result.RYMSLMDONG_CTRL_PRDUCTNM_ENG  )) ? '' : data.result.RYMSLMDONG_CTRL_PRDUCTNM_ENG ;
						var etc_info_one_kor = (isNull(data.result.ETC_INFO_ONE_KOR)) ? '' : data.result.ETC_INFO_ONE_KOR;
						var etc_info_one_eng = (isNull(data.result.ETC_INFO_ONE_ENG)) ? '' : data.result.ETC_INFO_ONE_ENG;
						var etc_info_two_kor = (isNull(data.result.ETC_INFO_TWO_KOR)) ? '' : data.result.ETC_INFO_TWO_KOR;
						var etc_info_two_eng = (isNull(data.result.ETC_INFO_TWO_ENG)) ? '' : data.result.ETC_INFO_TWO_ENG;
						var etc_info_three_kor = (isNull(data.result.ETC_INFO_THREE_KOR)) ? '' : data.result.ETC_INFO_THREE_KOR;
						var etc_info_three_eng = (isNull(data.result.ETC_INFO_THREE_ENG)) ? '' : data.result.ETC_INFO_THREE_ENG;
						
						$("#txtprtcl_no").val(prtcl_no);
						$("#hdProductCode").val(prduct_code);
						$("#txtProductCode").val(prductnm_code);
						$("#slrsrch_knd_code").val(rsrch_knd_code);
						$("#slclinc_ty_code").val(clinc_ty_code);
						$("#slmfds_confm_at").val(mfds_confm_at);
						$("#txtmfds_confm_dte").val(mfds_confm_dte);
						$("#txtfrt_patnt_occrrncde").val(frt_patnt_occrrncde);
						$("#txtlast_patnt_occrrncde").val(last_patnt_occrrncde);
						$("#slrymslmdong_ctrl_at").val(rymslmdong_ctrl_at);
						$("#txtrymslmdong_ctrl_cmpnynm").val(rymslmdong_ctrl_cmpnynm);
						$("#txtrymslmdong_ctrl_prductnm").val(rymslmdong_ctrl_prductnm);
						$("#slrymslmdong_ctrl_data_trnsmis_a").val(rymslmdong_ctrl_data_trnsmis_a);
						$("#txtrymslmdong_ctrl_data_trnsmisde").val(rymslmdong_ctrl_data_trnsmisde);
						$("#txtsafehelth_dta_lock_dte").val(safehelth_dta_lock_dte);
						$("#txtsafe_popltn").val(safe_popltn);
						$("#slmeddra_ver").val(meddra_ver);
						$("#slkcm_ver").val(kcm_ver);
						$("#slwhoart_ver").val(whoart_ver);
						$("#slatc_ver").val(atc_ver);
						
						//다국어 코드
						$('#hdprtcl_nm').val(prtcl_nm);
						$('#hdrsrch_knd_etc_matter_memo').val(rsrch_knd_etc_matter_memo);
						$('#hdrymslmdong_ctrl_cmpnynm').val(rymslmdong_ctrl_cmpnynm);
						$('#hdrymslmdong_ctrl_prductnm').val(rymslmdong_ctrl_prductnm);
						$('#hdOtherInfo1').val(etc_info_one);
						$('#hdOtherInfo2').val(etc_info_two);
						$('#hdOtherInfo3').val(etc_info_three);				
						//다국어 한글
						$("#txtprtcl_nm").val(prtcl_nm_kor);
						$("#txtrsrch_knd_etc_matter_memo").val(rsrch_knd_etc_matter_memoe_kor);
						$("#txtrymslmdong_ctrl_cmpnynm").val(rymslmdong_ctrl_cmpnynm_kor);
						$("#txtrymslmdong_ctrl_prductnm").val(rymslmdong_ctrl_prductnm_kor);
						$("#txtOtherInfo1").val(etc_info_two_kor);
						$("#txtOtherInfo2").val(etc_info_two_kor);
						$("#txtOtherInfo3").val(etc_info_three_kor);
						//다국어 영어
						$("#txtprtcl_nm_eng").text(prtcl_nm_eng);
						$("#txtrsrch_knd_etc_matter_memo_eng").text(rsrch_knd_etc_matter_memo_eng);
						$("#txtrymslmdong_ctrl_cmpnynm_eng").text(rymslmdong_ctrl_cmpnynm_eng);
						$("#txtrymslmdong_ctrl_prductnm_eng").text(rymslmdong_ctrl_prductnm_eng);
						$("#txtOtherInfo1_eng").text(etc_info_one_eng);
						$("#txtOtherInfo2_eng").text(etc_info_two_eng);
						$("#txtOtherInfo3_eng").text(etc_info_three_eng);
						
						

							if($('#slrymslmdong_ctrl_data_trnsmis_a').val()=="Y"){
								$('#txtrymslmdong_ctrl_data_trnsmisde').attr("disabled", false);
								$('#data_trnsmisde .ui-datepicker-trigger').show();
							}else{
								$('#txtrymslmdong_ctrl_data_trnsmisde').attr("disabled", true);
								$('#data_trnsmisde .ui-datepicker-trigger').hide();
								
							}
						// 
							if($('#slrsrch_knd_code').val()=="05"){
								$('#slclinc_ty_code').attr("disabled", false);
								$('#txtrsrch_knd_etc_matter_memo').attr("disabled", true);
								
							}else if($('#slrsrch_knd_code').val()=="07"){
								$('#slclinc_ty_code').attr("disabled", true);
								$('#txtrsrch_knd_etc_matter_memo').attr("disabled", false);
							}
							else{
								$('#slclinc_ty_code').attr("disabled", true);
								$('#txtrsrch_knd_etc_matter_memo').attr("disabled", true);
							}

							if($('#slmfds_confm_at').val()=="Y"){
								$('#txtmfds_confm_dte').attr("disabled", false);
								$('#confm_dte .ui-datepicker-trigger').show();
							}else{
								$('#txtmfds_confm_dte').attr("disabled", true);
								$('#confm_dte .ui-datepicker-trigger').hide();
								
							}
						
							if($('#slrymslmdong_ctrl_at').val()=="Y"){
								$('#txtrymslmdong_ctrl_cmpnynm').attr("disabled", false);
								$('#txtrymslmdong_ctrl_prductnm').attr("disabled", false);
								
							}else{
								$('#txtrymslmdong_ctrl_cmpnynm').attr("disabled", true);
								$('#txtrymslmdong_ctrl_prductnm').attr("disabled", true);
								
							}
						
						$("#mode").val("U"); // 여기부터 해야함~~
					} else {
						alert(data.errmsg);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert("실패");
				}
			});
	}	
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

var grStudy_Q = {
	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grStudy_Q.id);
	id : 'grStudy_Q',
	//AUI그리드 생성할 div 및 페이징 옵션
	div : {
		gridDiv : '#grStudy_Q',
		
	},
	//데이터 연계 옵션
	proxy : {
		url : './selectEtcList.do',
		param : {
			PRDUCT_CODE : $('#hdProductCode').val()
		},
		type : 'post',
		dataType : 'json',
		//페이징 true, false 로 지정
		paging : false,
		//처음 시작시 데이터 로딩
		autoLoad : true
	},
	//AUI 그리드 옵션
	gridPros : {
		selectionMode : 'singleRow',
		editable : false,
		usePaging : false,
		enableFilter : true,
		pageRowCount : 10,
		showPageButtonCount : 10,
		headerHeight : 40,	
		rowHeight : 37
	},
	//AUI 그리드 레이아웃
	columnLayout : [ {
		dataField : "ETC_INFO_NO",
		headerText : "쿼리번호",
		width : 200,
		filter : {
 			showIcon : true
 		}
	}, {
		dataField : "SOURC",
		headerText : "Category",
		width : 300,
		filter : {
 			showIcon : true
 		}
	}, {
		dataField : "AE_COUNT",
		headerText : "Variable",
		width : 120,
		filter : {
 			showIcon : true
 		}
	}, {
		dataField : "ADR_COUNT",
		headerText : "쿼리내용",
		width : 120,
		filter : {
 			showIcon : true
 		}
	}, {
		dataField : "UAE_COUNT",
		headerText : "ID",
		width : 120,
		filter : {
 			showIcon : true
 		}
	}, {
		dataField : "SAE_COUNT",
		headerText : "등록자",
		width : 120,
		filter : {
 			showIcon : true
 		}
	} ],
	//AUI 그리드 생성
	createGrid : function() {
		var me = this;

		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid
				.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		AUIGrid.bind(me.id, "cellDoubleClick",
				auiGridCellDoubleClickHandler);
		me.binding();

		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 이벤트 
	binding : function() {
		var me = this;

	},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		var param = {
			PRDUCT_CODE : $('#hdProductCode').val()
		};
		AUIGrid.showAjaxLoader(me.id);
		$.ajax({
			url : me.proxy.url,
			type : me.proxy.type,
			dataType : me.proxy.dataType,
			data : param,
			success : function(data) {
				if (data.success) {
					AUIGrid.removeAjaxLoader(me.id);
					AUIGrid.setGridData(me.id, data.result);
					AUIGrid.setSelectionByIndex(me.id, 0);
					
				} else {
					AUIGrid.removeAjaxLoader(me.id);
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
};

function auiGridCellDoubleClickHandler() {

	var str = "";
	var i, rowItem, rowInfoObj, dataField;

	selectionMode = AUIGrid.getProperty(grStudy_Q.id, "selectionMode");

	var selectedItems = AUIGrid.getSelectedItems(grStudy_Q.id);
	if (selectedItems.length <= 0) {
		alert("없음");
		return;
	}

	rowInfoObj = selectedItems[0];
	rowItem = rowInfoObj.item;
	if(rowItem.USE_AT =="Deleted"){
		alert('삭제된 행입니다.');
		return;
	}
		
	$('#iETC_INFO_NO').val(rowItem.ETC_INFO_NO);
	$('#iform').submit();
}




</script>
</head>

<body>
	<div id="wrap">
		<!-- 헤더 호출 -->
		<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
		<!-- 레프트 호출 -->
		<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
		<form id="iform">
		<input type="hidden" id="mode" value="C" />
		<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Source별 등록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>Source별 등록</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner">
					<form id="iform">
					<input type="hidden" id="mode" value="C" />
					

						<div class="button_tab_01">
							<ul>
								<li id="tabTrial" class="port_back tab_menu">Study</li>
								<li id="tabSpontaneous" class="tab_menu">Spontaneous</li>
								<li id="tabLiterature" class="tab_menu">Literature</li>
								<li id="tabEtc" class="tab_menu">Etc</li>
								<li id="tabICSR" class="tab_menu">ICSR</li>
							</ul>
						</div>
						<!-- 상단 검색과 버튼 시작 -->
						<article>
							<div class="conTitBtnL">
								PRODUCT <span class="must_01"></span> : 
								<input type="text" id="txtProductCode" class="pdR15" popup_type="ProductSearch" valireqire="PRODUCT" style="width:300px;" readonly>
								<input type="hidden" id="hdProductCode" />
								<button class="oneBtn" popup_type="ProductSearch" type="sumit">
										<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
							</div>

							<div class="conTitBtnR">
								<input type="button" id="btnCase" value="CASE">
								<input type="button" id="btnInit" value="초기화">
								<input type="button" id="btnSave" value="저장">
								<input type="button" id="btnDel" value="삭제">
								<input type="button" id="btnAudit" value="A" title="Audit Trail">
							</div>
						</article>
						<!-- 상단 검색과 버튼 끝 -->

						<!-- 테이블 시작 -->
						<article class="mgT44">
							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="25%" />
									<col width="12%" />
									<col width="19%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>Protocol Number <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtprtcl_no" popup_type="protocol" valireqire="Protocol Number" style="width:80%;" />
														<button class="oneBtn" popup_type="protocol" type="sumit"><img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색"></button>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										<th>Protocol Title</th>
										<td colspan="3" style="padding-top:3px; padding-bottom:4px; height:42px;">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtprtcl_nm" tabindex="1" style="width:100%;"/>
													</th>
													<td>
														<input class="oneBtn" popup_type="Q" type="button" value="Q"/>
														<input class="oneBtn" popup_type="E" type="button" value="E"
														onclick="EnglishNotation('txtprtcl_nm','txtprtcl_nm_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdprtcl_nm" />
											<label class="label_02" popup_type="Label" id="txtprtcl_nm_eng" style="margin-top:1px;"></label>
										</td>
									</tr>
									<tr>
										<th>Study Type <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slrsrch_knd_code" tabindex="2" valireqire="Study Type" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Clinical Trial Type</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slclinc_ty_code" tabindex="3" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Other Surveillance Specify</th>
										<td style="padding-top:4px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtrsrch_knd_etc_matter_memo" rows="1" style="width:100%;"  tabindex="4"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" popup_type="E" type="button" value="E" style="vertical-align: top;" 
														onclick="EnglishNotation('txtrsrch_knd_etc_matter_memo','txtrsrch_knd_etc_matter_memo_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdrsrch_knd_etc_matter_memo" />
											<label class="label_02" popup_type="Label" id="txtrsrch_knd_etc_matter_memo_eng"></label>
										</td>
									</tr>
									<tr>
										<th>MFDS Protocol Approval <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slmfds_confm_at" tabindex="5" style="width:100%;" valireqire="MFDS Protocol Approva">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>MFDS Protocol Approval Date</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox" id="confm_dte">
															<input type="text" id="txtmfds_confm_dte" tabindex="6" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>
										<th>Date of First Patient In</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtfrt_patnt_occrrncde" tabindex="7" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>										
									</tr>
									<tr>
										<th>Date of Last Patient Out</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtlast_patnt_occrrncde" tabindex="8" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>
										<th>Active Control <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slrymslmdong_ctrl_at" tabindex="9" valireqire="Active Control" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Name of Company(of Active Control)</th>
										<td style="padding-top:4px;">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtrymslmdong_ctrl_cmpnynm" style="width:100%;"  tabindex="10"/> 
													</th>
													<td>
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
														<input class="oneBtn" popup_type="E" type="button" value="E"
														onclick="EnglishNotation('txtrymslmdong_ctrl_cmpnynm','txtrymslmdong_ctrl_cmpnynm_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdrymslmdong_ctrl_cmpnynm" />
											<label class="label_02" popup_type="Label" id="txtrymslmdong_ctrl_cmpnynm_eng"></label>
										</td>										
									</tr>
									<tr>
										<th>Brand Name (of Active Control)</th>
										<td style="padding-top:4px;">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtrymslmdong_ctrl_prductnm" style="width:100%;" tabindex="11"/> 
													</th>
													<td>
														<input class="oneBtn" popup_type="Q" type="button" value="Q"/>
														<input class="oneBtn" popup_type="E" type="button" value="E" 
														onclick="EnglishNotation('txtrymslmdong_ctrl_prductnm','txtrymslmdong_ctrl_prductnm_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdrymslmdong_ctrl_prductnm" />
											<label class="label_02" popup_type="Label" id="txtrymslmdong_ctrl_prductnm_eng"></label>
										</td>
										<th>Active Control Data Transfer</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slrymslmdong_ctrl_data_trnsmis_a" tabindex="12" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Date of Data Transfer</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox" id="data_trnsmisde">
															<input type="text" id="txtrymslmdong_ctrl_data_trnsmisde" tabindex="13" style="width:114px;" />
														</div> 
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>										
									</tr>
									<tr>
										<th>Date of Safety Data Lock</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtsafehelth_dta_lock_dte" tabindex="14" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>
										<th>Safety Population</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtsafe_popltn" tabindex="15" style="width:100%;" />
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>MedDRA</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slmeddra_ver" tabindex="16" style="width:100%;">
															<option value="">====선택====</option>
															<option value="12.0">12.0</option>
															<option value="15.0">15.0</option>
															<option value="15.1">15.1</option>
															<option value="16.0">16.0</option>
															<option value="16.1">16.1</option>
															<option value="17.0">17.0</option>
															<option value="17.1">17.1</option>
															<option value="18.0">18.0</option>
															<option value="18.1">18.1</option>
															<option value="19.0">19.0</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>										
									</tr>
									<tr>
										<th>KCD</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slkcm_ver" tabindex="17" style="width:100%;">
															<option value="">====선택====</option>
															<option value="6">6</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>WHOART</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slwhoart_ver" tabindex="18" style="width:100%;">
															<option value="">====선택====</option>
															<option value="092">092</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>ATC</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slatc_ver" tabindex="19" style="width:100%;">
															<option value="">====선택====</option>
															<option value="2012">2012</option>
															<option value="2013">2013</option>
															<option value="2014">2014</option>
															<option value="2015">2015</option>
															<option value="2016">2016</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>										
									</tr>	
									<tr>
										<th>Other Information 1</th>
										<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtOtherInfo1" rows="2" style="width: 100%;" tabindex="20"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtOtherInfo1','txtOtherInfo1_eng');" />
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdOtherInfo1" />
											<label class="label_01" popup_type="Label" id="txtOtherInfo1_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Other Information 2</th>
										<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtOtherInfo2" rows="2" style="width: 100%;" tabindex="21"></textarea> 
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtOtherInfo2','txtOtherInfo2_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdOtherInfo2" /> 
											<label class="label_01" popup_type="Label" id="txtOtherInfo2_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Other Information 3</th>
										<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtOtherInfo3" rows="2" style="width:100%;" tabindex="22"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" 
														onclick="EnglishNotation('txtOtherInfo3','txtOtherInfo3_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdOtherInfo3" />
											<label class="label_01" popup_type="Label" id="txtOtherInfo3_eng"></label>
										</td>
									</tr>						
								</tbody>
							</table>
						</article>
						
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

						
						 <!-- 아코디언 메뉴 시작 -->
                            <article class="mgT10">
                                <ul id="acdMenu01">
                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">[Q 내역]</a>
                                        <div class="acdMenuCts acdMenuCts01 close">
                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            	<article class="mgT5">
												<!-- 에이유아이 그리드가 이곳에 생성 -->
												<div id="grStudy_Q" class="gridHeiSz10 grid_wrap tb01_2" style></div>
											</article>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->
                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->
						<!-- 테이블 끝 -->

						
					</form>
				</div>
            </section>
		</div>
	</section>
	</form>
	</div>	
</body>
</html>