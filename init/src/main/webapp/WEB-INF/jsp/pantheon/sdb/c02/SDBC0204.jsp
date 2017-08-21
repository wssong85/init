<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title>AE</title>
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

<script type="text/javascript">
var HRMFLNS_CASE_CODE = "${HRMFLNS_CASE_CODE}";
var PRDUCT_CODE = "${PRDUCT_CODE}";
var FOLLOW_NO = "${FOLLOW_NO}";
var SOURCE_TYPE = "${SOURCE_TYPE}";
var SOURCE = "${SOURCE}";

var SITESUBJECT = "${SITESUBJECT}";
var MAFU_NO = "${MAFU_NO}";
var ids = new Array();
var vals = new Array();

function tabMove(url){
	if(HRMFLNS_CASE_CODE=="" || PRDUCT_CODE=="" || FOLLOW_NO==""){			
		return;
	}
	
	ids[0]= "HRMFLNS_CASE_CODE";
	vals[0]= HRMFLNS_CASE_CODE;

	ids[1]= "PRDUCT_CODE";
	vals[1]= PRDUCT_CODE;
	
	ids[2]= "FOLLOW_NO";
	vals[2]= FOLLOW_NO;
	
	ids[3]= "SOURCE_TYPE";
	vals[3]= SOURCE_TYPE;
	
	ids[4]= "SOURCE";
	vals[4]= SOURCE;
	
	ids[5]= "SITESUBJECT";
	vals[5]= SITESUBJECT;
	
	ids[6]= "MAFU_NO";
	vals[6]= MAFU_NO;
	
	POSTSends(url, ids, vals);		
}

$(function() {
	
	setAccodian();
 	btnInit();
 	setInit();
 	init();
 	
	grAeList.createGrid();
});

function init(){
	$("#hdhrmflns_case_code").val(HRMFLNS_CASE_CODE);
	$("#hdprduct_code").val(PRDUCT_CODE);
	$("#hdfollow_no").val(FOLLOW_NO);
	$("#hdmafu_no").val(MAFU_NO);
	$("#mode").val('C');
	
	var params ={
			HRMFLNS_CASE_CODE : HRMFLNS_CASE_CODE,
			PRDUCT_CODE : PRDUCT_CODE,
			FOLLOW_NO : FOLLOW_NO			
	}
	$.ajax({
		type		: "POST",
		url			: "/sdb/c02/selectDemoAeInfo.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {				 
			if(data.success){
				$("#txtfrt_rcept_dte").val(data.result.FRT_RCEPT_DTE);
				$("#txtlast_dte").val(data.result.LAST_DTE);
				$("#slmfds_report_at").val(data.result.MFDS_REPORT_AT);
				$("#txtmfds_report_dte").val(data.result.MFDS_REPORT_DTE);
				$("#slkids_report_at").val(data.result.KIDS_REPORT_AT);
				$("#txtkids_report_dte").val(data.result.KIDS_REPORT_DTE);
				$("#slirb_report_at").val(data.result.IRB_REPORT_AT);
				$("#txtirb_report_date").val(data.result.IRB_REPORT_DATE);
				$("#sldifr_instt_report_at").val(data.result.DIFR_INSTT_REPORT_AT);
				$("#txtdifr_instt_report_date").val(data.result.DIFR_INSTT_REPORT_DATE);
				$("#slmanufacturer_at").val(data.result.MANUFACTURER_AT);
				$("#txtmanufacturer_report_pd").val(data.result.MANUFACTURER_REPORT_PD);
				$("#txtmanufacturer_report_date").val(data.result.MANUFACTURER_REPORT_DATE);
				$("#sllegacy_health_ennc").val(data.result.LEGACY_HEALTH_ENNC);
 				$('#mode').val('U'); 
				  
			}else{
				alert(data.message);
			}
		  }, 
		error		: function(xhr, textStatus, errorThrown){
			alert("실패");
		}
	});
	
	
	
}


function setInit(){
	<c:forEach var="result" items="${printType44}" varStatus="status">
		$("#slmain_ae_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#slmfds_report_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#slkids_report_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#slirb_report_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#sldifr_instt_report_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#slmanufacturer_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#slhighlt_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#slseriusfmnm_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		$("#sllegacy_health_ennc").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType12}" varStatus="status">
		$("#slemrps_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType65}" varStatus="status">
		$("#sldrfstf_respns_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType30}" varStatus="status">
		$("#slexpect_posbl_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType23}" varStatus="status">
		$("#slseriusdo_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>

	<c:forEach var="result" items="${printType24}" varStatus="status">
		$("#slstep_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>

	<c:forEach var="result" items="${printType25}" varStatus="status">
		$("#slreportr_relation_one, #slspon_relation_one").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>

	<c:forEach var="result" items="${printType26}" varStatus="status">
		$("#slreportr_relation_two, #slspon_relation_two").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType21}" varStatus="status">
		$("#slresult_knd").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	
	
	
// 	mkSetDatePickerYYMMDD("#txtbegin_dt", "#txtend_dt");
	mkSetDatePickerYYMMDD("#txtfrt_rcept_dte");
// 	mkSetDatePickerYYMMDD("#txtlast_dte");
	mkSetDatePickerYYMMDD("#txtmfds_report_dte");
	mkSetDatePickerYYMMDD("#txtkids_report_dte");
	mkSetDatePickerYYMMDD("#txtirb_report_date");
	mkSetDatePickerYYMMDD("#txtdifr_instt_report_date");
	mkSetDatePickerYYMMDD("#txtmanufacturer_report_date");
// 	mkSetDatePickerYYMMDD("#txtdeathde");
	
	
	
	$('#txtfrt_rcept_dte, #txtlast_dte, #txtmfds_report_dte, #txtkids_report_dte, #txtirb_report_date, #txtdifr_instt_report_date, #txtmanufacturer_report_date').val('');
	
	//var regExp = /^\d{2}:\d{2}$/;
	
	
	$('#txtbegin_dt_time').inputmask("99:99");
	$('#txtend_dt_time').inputmask("99:99");
	
	$('#Aeinput').hide();
	
}

function btnInit(){
// 	$('#txtbegin_dt_time').keyup(function (){
// 		 var regExpDate = /^\[0-6]{1}[0-9]{1}:\d{2}$/;
// 		    //var regExpTelS = /^0(?:[2])(\-|)(?:\d{3}|\d{4})(\-|)\d{4}$/;
// 		    //var df = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
// 		    //return d.match(df);
// 		    return regExpDate.test(this.val());	
// 	});
	
	$('#tabDemographics').click(function() {
		var url = "/sdb/c02/SDBC0201.do";
		tabMove(url);
	});
	$('#tabMedicalhistory').click(function() {
		var url = "/sdb/c02/SDBC0202.do";
		tabMove(url);
	});
	$('#tabDrughistory').click(function() {
		var url = "/sdb/c02/SDBC0203.do";
		tabMove(url);
	});
	$('#tabAe').click(function() {
		var url = "/sdb/c02/SDBC0204.do";
		tabMove(url);
	});
	$('#tabLab').click(function() {
		var url = "/sdb/c02/SDBC0205.do";
		tabMove(url);
	});
	$('#tabDrug').click(function() {
		var url = "/sdb/c02/SDBC0206.do";
		tabMove(url);
	});
	$('#tabCasulity').click(function() {
		var url = "/sdb/c02/SDBC0207.do";
		tabMove(url);
	});
	$('#tabNarrative').click(function() {
		var url = "/sdb/c02/SDBC0208.do";
		tabMove(url);
	});
	$('#tabAssessment').click(function() {
		var url = "/sdb/c02/SDBC0209.do";
		tabMove(url);
	});
		
	$('#btnInit').click(function(){
		
		Applybtninit();
	});

	
	$('#btnSearch').click(function(){
		grAeList.load();
	});
	
	$('#btnAdd').click(function(){
		$('#iform').each(function() {
			this.reset();
		});
		$('label[popup_type=Label]').text('');
		$('#Aeinput').show();	
		$('#mode').val("C");
	});
	
	$('#btnSave').click(function(){	
				
		if($('#Aeinput').css('display')=='none'){
			if (!confirm('저장하시겠습니까?')) {
				return;
			}
			saveformDemo();
		}else{
			if (!confirm('저장하시겠습니까?')) {
				return;
			}
			
			if (!mkValidation()) {
				return;
			}
			
			if ($('#mode').val() =='U'){
				updelform();			
			}else{				
				saveform();
			}
		}
	});
	
	$('#btnDel').click(function(){
		if ($('#mode').val() =='U'){
			$('#mode').val('D');
			updelform();			
		}
		return;
	});
	
	$('#btnExcel').click(function(){
		var data = AUIGrid.getGridData(grAeList.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grAeList.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grAeList.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
	
	$('#slresult_knd').change(function(){
		if($.trim($('#slresult_knd').val()) =="" || $.trim($('#slresult_knd').val())=="6"){
			$('#txtend_dts').val('');
			$('#txtend_dt_time').val('');
			$('#txtend_dts, #txtend_dt_time').attr("disabled", true);
		}else{
			$('#txtend_dts, #txtend_dt_time').attr("disabled", false);
		}
	});
	
	$('#slseriusfmnm_at').change(function(){
		if($.trim($('#slseriusfmnm_at').val()) =="" || $.trim($('#slseriusfmnm_at').val())=="N"){
			$('input:checkbox[name="chseriusfmnm_detail_cn"]').each(function (){
				this.checked = false;				
			});	
			
			$('input[name=chseriusfmnm_detail_cn]').attr("disabled", true);
		}else{
			$('input[name=chseriusfmnm_detail_cn]').attr("disabled", false);
		}
	});
	
}

function updelform(){
	var param = {
			TRGET_CODE 	: $("#hdmafu_no").val(), 
			TRGETNM 	: "Ae",
			TRGET_MODE  : $('#mode').val(),
			UPDATE_ID	: '${loginMap.USER_ID}'						
		};
	mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
}

function saveformDemo(){
	var params = {
			CURD 							: $.trim($("#mode").val()),
			AE_NO							: $.trim($("#hdae_no").val()),
			HRMFLNS_CASE_CODE				: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE						: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO						: $.trim($("#hdfollow_no").val()),
			FRT_RCEPT_DTE					: $.trim($("#txtfrt_rcept_dte").val()),
			LAST_DTE						: $.trim($("#txtlast_dte").val()),
			MFDS_REPORT_AT					: $.trim($("#slmfds_report_at").val()),
			MFDS_REPORT_PD					: $.trim($("#txtmfds_report_pd").val()),
			MFDS_REPORT_DTE					: $.trim($("#txtmfds_report_dte").val()),
			KIDS_REPORT_AT					: $.trim($("#slkids_report_at").val()),
			KIDS_REPORT_PDt					: $.trim($("#txtkids_report_pd").val()),
			KIDS_REPORT_DTE					: $.trim($("#txtkids_report_dte").val()),
			IRB_REPORT_AT					: $.trim($("#slirb_report_at").val()),
			IRB_REPORT_PD					: $.trim($("#txtirb_report_pd").val()),
			IRB_REPORT_DATE					: $.trim($("#txtirb_report_date").val()),
			DIFR_INSTT_REPORT_AT			: $.trim($("#sldifr_instt_report_at").val()),
			DIFR_INSTT_REPORT_PD			: $.trim($("#txtdifr_instt_report_pd").val()),
			DIFR_INSTT_REPORT_DATE			: $.trim($("#txtdifr_instt_report_date").val()),
			MANUFACTURER_AT					: $.trim($("#slmanufacturer_at").val()),
			MANUFACTURER_REPORT_PD			: $.trim($("#txtmanufacturer_report_pd").val()),
			MANUFACTURER_REPORT_PD_SE		: $.trim($("#txtmanufacturer_report_pd_se").val()),
			MANUFACTURER_REPORT_DATE		: $.trim($("#txtmanufacturer_report_date").val()),
			LEGACY_HEALTH_ENNC				: $.trim($("#sllegacy_health_ennc").val()),			
			UPDATE_ID 						: '${loginMap.USER_ID}'
		};
	
	$.ajax({
		url : '/sdb/c02/insertDemoAe.do',
		type : 'post',
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {
			if (data.success) {		
				//saveform();
				$('#iform').each(function() {
					this.reset();
				});
				$('label[popup_type=Label]').text('');
				$('#Aeinput').hide();
				$("#mode").val('C');
				grAeList.load();
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("실패");
		}
	});
	
}

function saveform(){
	var ch_v="";
	$('input:checkbox[name="chseriusfmnm_detail_cn"]').each(function (){
		
		if(this.checked){
			//alert(this.value);
			ch_v += this.value + "||";
		}
		
	});	
	$('#hdseriusfmnm_detail_cn').val(ch_v);
	
	var params = {
			CURD 							: $.trim($("#mode").val()),
			AE_NO							: $.trim($("#hdae_no").val()),
			HRMFLNS_CASE_CODE				: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE						: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO						: $.trim($("#hdfollow_no").val()),
			FRT_RCEPT_DTE					: $.trim($("#txtfrt_rcept_dte").val()),
			LAST_DTE						: $.trim($("#txtlast_dte").val()),
			MFDS_REPORT_AT					: $.trim($("#slmfds_report_at").val()),
			MFDS_REPORT_PD					: $.trim($("#txtmfds_report_pd").val()),
			MFDS_REPORT_DTE					: $.trim($("#txtmfds_report_dte").val()),
			KIDS_REPORT_AT					: $.trim($("#slkids_report_at").val()),
			KIDS_REPORT_PDt					: $.trim($("#txtkids_report_pd").val()),
			KIDS_REPORT_DTE					: $.trim($("#txtkids_report_dte").val()),
			IRB_REPORT_AT					: $.trim($("#slirb_report_at").val()),
			IRB_REPORT_PD					: $.trim($("#txtirb_report_pd").val()),
			IRB_REPORT_DATE					: $.trim($("#txtirb_report_date").val()),
			DIFR_INSTT_REPORT_AT			: $.trim($("#sldifr_instt_report_at").val()),
			DIFR_INSTT_REPORT_PD			: $.trim($("#txtdifr_instt_report_pd").val()),
			DIFR_INSTT_REPORT_DATE			: $.trim($("#txtdifr_instt_report_date").val()),
			MANUFACTURER_AT					: $.trim($("#slmanufacturer_at").val()),
			MANUFACTURER_REPORT_PD			: $.trim($("#txtmanufacturer_report_pd").val()),
			MANUFACTURER_REPORT_PD_SE		: $.trim($("#txtmanufacturer_report_pd_se").val()),
			MANUFACTURER_REPORT_DATE		: $.trim($("#txtmanufacturer_report_date").val()),
			LEGACY_HEALTH_ENNC				: $.trim($("#sllegacy_health_ennc").val()),
			ADVERSE_EVENT					: $.trim($("#hdadverse_event").val()),
			ADVERSE_EVENT_KOR				: $.trim($("#txtadverse_event").val()),
			ADVERSE_EVENT_ENG				: $.trim($("#txtadverse_event_eng").text()),
			MAIN_AE_AT						: $.trim($("#slmain_ae_at").val()),
			HIGHLT_AT                		: $.trim($("#slhighlt_at").val()),
			BEGIN_DTS               		: $.trim($("#txtbegin_dts").val()),
			BEGIN_DT_TIME              		: $.trim($("#txtbegin_dt_time").val()),
			RESULT_KND                		: $.trim($("#slresult_knd").val()),
			END_DTS                			: $.trim($("#txtend_dts").val()),
			END_DT_TIME            			: $.trim($("#txtend_dt_time").val()),
			ABOVE_RESPNS_PED              	: $.trim($("#txtabove_respns_ped").val()),
			DOUBT_DRFSTF_MDCTN_INTRVL_DAIL  : $.trim($("#txtdoubt_drfstf_mdctn_intrvl_dail").val()),
			DOUBT_DRFSTF_MDCTN_INTRVL_TIME  : $.trim($("#txtdoubt_drfstf_mdctn_intrvl_time").val()),
			DOUBT_DRFSTF_MDCTN_INTRVL_MNT   : $.trim($("#txtdoubt_drfstf_mdctn_intrvl_mnt").val()),
			LAST_MDCTN_RESPNS_INTRVL_DAIL   : $.trim($("#txtlast_mdctn_respns_intrvl_dail").val()),
			LAST_MDCTN_RESPNS_INTRVL_TIME   : $.trim($("#txtlast_mdctn_respns_intrvl_time").val()),
			LAST_MDCTN_RESPNS_INTRVL_MNT    : $.trim($("#txtlast_mdctn_respns_intrvl_mnt").val()),
			SERIUSFMNM_AT                	: $.trim($("#slseriusfmnm_at").val()),
			SERIUSFMNM_DETAIL_CN            : $.trim($("#hdseriusfmnm_detail_cn").val()),
			SERIUSDO_SE                		: $.trim($("#slseriusdo_se").val()),
			STEP_SE                			: $.trim($("#slstep_se").val()),
			DRFSTF_RESPNS_SE                : $.trim($("#sldrfstf_respns_se").val()),
			EXPECT_POSBL_SE                 : $.trim($("#slexpect_posbl_se").val()),
			WHOART_AT                		: $.trim($("#txtwhoart_at").val()),
			WHOART_VER                		: $.trim($("#slwhoart_ver").val()),
			WHOART_ARRN_CODE                : $.trim($("#txtwhoart_arrn_code").val()),
			MEDDRA_AT                		: $.trim($("#txtmeddra_at").val()),
			MEDDRA_VER                		: $.trim($("#slmeddra_ver").val()),
			MEDDRA_LTT_CODE                 : $.trim($("#txtmeddra_ltt_code").val()),
			DIFR_INFO                		: $.trim($("#txtdifr_info").val()),
			REPORTR_RELATION_ONE            : $.trim($("#slreportr_relation_one").val()),
			REPORTR_RELATION_TWO            : $.trim($("#slreportr_relation_two").val()),
			SPON_RELATION_ONE               : $.trim($("#slspon_relation_one").val()),
			SPON_RELATION_TWO				: $.trim($("#slspon_relation_two").val()),
			DEATHDES               			: $.trim($("#txtdeathdes").val()),
			KCD_VER                			: $.trim($("#slkcd_ver").val()),
			KCD_DEATH_CODE                	: $.trim($("#txtkcd_death_code").val()),
			MEMO                			: $.trim($("#hdmemo").val()),
			MEMO_KOR               			: $.trim($("#txtmemo").val()),
			MEMO_ENG               			: $.trim($("#txtmemo_eng").text()),
			EMRPS_AT                		: $.trim($("#slemrps_at").val()),
			EMRPSDE                			: $.trim($("#txtemrpsde").val()),
			KCD_VER                			: $.trim($("#slkcd_ver").val()),
			KCD_EMRPS_CODE                	: $.trim($("#txtkcd_emrps_cod").val()),
			EMRPS_RESN                		: $.trim($("#hdemrps_resn").val()),
			EMRPS_RESN_KOR               	: $.trim($("#txtemrps_resn").val()),
			EMRPS_RESN_ENG               	: $.trim($("#txtemrps_resn_eng").text()),
			ETC                				: $.trim($("#hdetc").val()),
			ETC_KOR               			: $.trim($("#txtetc").val()),
			ETC_ENG            				: $.trim($("#txtetc_eng").text()),
			AE_DETAIL_CN					: $.trim($("#hdae_detail_cn").val()),
			AE_DETAIL_CN_KOR				: $.trim($("#txtae_detail_cn").val()),
			AE_DETAIL_CN_ENG				: $.trim($("#txtae_detail_cn_eng").text()),
			UPDATE_ID 						: '${loginMap.USER_ID}'
		};
	
	$.ajax({
		url : '/sdb/c02/insertAe.do',
		type : 'post',
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {
			if (data.success) {		
				saveCasuality();
// 				$('#iform').each(function() {
// 					this.reset();
// 				});
// 				$('label[popup_type=Label]').text('');
// 				$('#Aeinput').hide();
// 				$("#mode").val('C');
// 				grAeList.load();
				
				
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("실패");
		}
	});
	
}

function saveLayer(p_mode){		
	saveform();				
}

function Applybtninit(){
	$('#iform').each(function() {
		this.reset();
	});
	 	
	$('label[popup_type=Label]').text('');
	
}

function saveCasuality(){
	var params = {
			HRMFLNS_CASE_CODE				: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE						: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO						: $.trim($("#hdfollow_no").val()),
			UPDATE_ID 						: '${loginMap.USER_ID}'
	};
	$.ajax({
		url : '/sdb/c02/insertCasuality_T.do',
		type : 'post',
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {
			if (data.success) {		
				$('#iform').each(function() {
					this.reset();
				});
				$('label[popup_type=Label]').text('');
				$('#Aeinput').hide();
				$("#mode").val('C');
				grAeList.load();
				
				
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("실패");
		}
	});
}



var grAeList = {
		  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grAeList.id);
		  id: '',
		  //AUI그리드 생성할 div 및 페이징 옵션
		  div: {
		    gridDiv: '#grAeList',
		    paging: {
		      pagingDiv: 'grid_paging',
		      totalRowCount: 500,
		      rowCount: 10,
		      pageButtonCount: 4,
		      currentPage: 1,
		      totalPage: 0,
		    },
		  },
		  //데이터 연계 옵션
		  proxy: {
			url: '/sdb/c02/selectAeList.do',
			param: {
				HRMFLNS_CASE_CODE : $('#hdhrmflns_case_code').val(),
				PRDUCT_CODE : $('#hdprduct_code').val()	,
				FOLLOW_NO : $('#hdfollow_no').val()
			},
		    type: 'post',
		    dataType: 'json',
		    //페이징 true, false 로 지정
		    paging: true,
		    //처음 시작시 데이터 로딩
		    autoLoad: true,
		  },
		  //AUI 그리드 옵션
		  gridPros: {
		    // 페이징 사용
		    //usePaging : true,
		    
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : false,
		    enableFilter : true,

		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows",
		    displayTreeOpen : true,
		    

		  },
		  //AUI 그리드 레이아웃
		  columnLayout : [{
		    dataField : "ADVERSE_EVENT",
		    headerText : "Adverse Event",
		    width : '15	%'
		  },{
		    dataField : "SERIUSFMNM_AT",
		    headerText : "Seriousness"    
		  },{
		    dataField : "REPORTR_RELATION_ONE",
		    headerText : "Relatedness(Reporter)1"    
		  },{
		    dataField : "REPORTR_RELATION_TWO",
		    headerText : "Relatedness(Reporter)2"
		  },{
		    dataField : "DRFSTF_RESPNS_SE",
		    headerText : "Action taken with drug"
		  },{
		    dataField : "EXPECT_POSBL_SE",
		    headerText : "Expentedness"
		  },{
		    dataField : "USE_AT",
		    headerText : "Deleted"  
		  },{
			    dataField : "AE_NO",
			    headerText : "AE NO",
			    visible : false
		  }], 


		  createGrid: function() {
				var me = this;
				//이후 객체.id 로 AUIGrid 컨트롤
				me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
				AUIGrid.bind(me.id, "cellClick", auiGridCellClickHandler);
				 		 		
				me.binding();
				
				if(me.proxy.autoLoad) {
					me.load();
				}
			},
			//AUI 그리드 이벤트 
			binding: function() {
				var me = this;
				
			},
			//AUI 그리드 데이터 요청
			load: function(v1, v2) {
				var me = this;
				var param = {
					HRMFLNS_CASE_CODE : $('#hdhrmflns_case_code').val(),
					PRDUCT_CODE : $('#hdprduct_code').val()	,
					FOLLOW_NO : $('#hdfollow_no').val()
				};
				AUIGrid.showAjaxLoader(me.id);
				$.ajax({
				    url: me.proxy.url,
				    type: me.proxy.type,
				    dataType: me.proxy.dataType,
				    data: param,
				    success:function(data){
				    	if(data.success) {
					    	AUIGrid.removeAjaxLoader(me.id);
					    	AUIGrid.setGridData(me.id, data.result);
					    	AUIGrid.setSelectionByIndex(me.id, 0);
				    	} else {
				    		AUIGrid.removeAjaxLoader(me.id);
				    		alert(data.message);
				    	}
				    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			}
		};

		function auiGridCellClickHandler() {
			var str = "";
			var i, rowItem, rowInfoObj, dataField;

			selectionMode = AUIGrid.getProperty(grAeList.id, "selectionMode");
			
			var selectedItems = AUIGrid.getSelectedItems(grAeList.id);
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
			$('#hdae_no').val(rowItem.AE_NO);
			
			var params ={
					AE_NO : rowItem.AE_NO
			}
			$.ajax({
				type		: "POST",
				url			: "/sdb/c02/selectAeInfo.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {				 
					if(data.success){
						$('#Aeinput').show();
						
						$('#hdhrmflns_case_code').val(data.result.HRMFLNS_CASE_CODE);
						$('#hdprduct_code').val(data.result.PRDUCT_CODE);
						$('#hdfollow_no').val(data.result.FOLLOW_NO);						
						$('#hdadverse_event').val(data.result.ADVERSE_EVENT);
						$('#txtadverse_event').val(data.result.ADVERSE_EVENT_KOR);
						$('#txtadverse_event_eng').text(data.result.ADVERSE_EVENT_ENG);
						$('#slmain_ae_at').val(data.result.MAIN_AE_AT);
						$('#slhighlt_at').val(data.result.HIGHLT_AT);
						$('#txtbegin_dts').val(data.result.BEGIN_DTS);						
						$('#slresult_knd').val(data.result.RESULT_KND);
						$('#txtend_dts').val(data.result.END_DTS);
						$('#txtabove_respns_ped').val(data.result.ABOVE_RESPNS_PED);
						$('#txtdoubt_drfstf_mdctn_intrvl_dail').val(data.result.DOUBT_DRFSTF_MDCTN_INTRVL_DAIL);
						$('#txtdoubt_drfstf_mdctn_intrvl_time').val(data.result.DOUBT_DRFSTF_MDCTN_INTRVL_TIME);
						$('#txtdoubt_drfstf_mdctn_intrvl_mnt').val(data.result.DOUBT_DRFSTF_MDCTN_INTRVL_MNT);
						$('#txtlast_mdctn_respns_intrvl_dail').val(data.result.LAST_MDCTN_RESPNS_INTRVL_DAIL);
						$('#txtlast_mdctn_respns_intrvl_time').val(data.result.LAST_MDCTN_RESPNS_INTRVL_TIME);
						$('#txtlast_mdctn_respns_intrvl_mnt').val(data.result.LAST_MDCTN_RESPNS_INTRVL_MNT);
						$('#slseriusfmnm_at').val(data.result.SERIUSFMNM_AT);
						
						if(data.result.SERIUSFMNM_DETAIL_CN != null && data.result.SERIUSFMNM_DETAIL_CN.indexOf("||")){
							var seArray = data.result.SERIUSFMNM_DETAIL_CN.split('||');
							
							for(i=0; i< seArray.length; i++){
								if(seArray[i] == "1"){			
									$('#chseriusfmnm_detail_cn_1').attr("checked", true);
								}else if(seArray[i] == "2"){			
									$('#chseriusfmnm_detail_cn_2').attr("checked", true);
								}else if(seArray[i] == "3"){			
									$('#chseriusfmnm_detail_cn_3').attr("checked", true);
								}else if(seArray[i] == "4"){			
									$('#chseriusfmnm_detail_cn_4').attr("checked", true);
								}else if(seArray[i] == "5"){			
									$('#chseriusfmnm_detail_cn_5').attr("checked", true);
								}else if(seArray[i] == "6"){			
									$('#chseriusfmnm_detail_cn_6').attr("checked", true);
								}	
							}
						}
						$('#slseriusfmnm_detail_cn').val(data.result.SERIUSFMNM_DETAIL_CN);
						$('#slseriusdo_se').val(data.result.SERIUSDO_SE);
						$('#slstep_se').val(data.result.STEP_SE);
						$('#sldrfstf_respns_se').val(data.result.DRFSTF_RESPNS_SE);
						$('#slexpect_posbl_se').val(data.result.EXPECT_POSBL_SE);
						$('#txtwhoart_at').val(data.result.WHOART_AT);
						$('#slwhoart_ver').val(data.result.WHOART_VER);
						$('#txtwhoart_arrn_code').val(data.result.WHOART_ARRN_CODE);
						$('#txtmeddra_at').val(data.result.MEDDRA_AT);
						$('#slmeddra_ver').val(data.result.MEDDRA_VER);
						$('#txtmeddra_ltt_code').val(data.result.MEDDRA_LTT_CODE);
						$('#txtdifr_info').val(data.result.DIFR_INFO);
						$('#slreportr_relation_one').val(data.result.REPORTR_RELATION_ONE);
						$('#slreportr_relation_two').val(data.result.REPORTR_RELATION_TWO);
						$('#slspon_relation_one').val(data.result.SPON_RELATION_ONE);
						$('#slspon_relation_two').val(data.result.SPON_RELATION_TWO);
						$('#txtdeathdes').val(data.result.DEATHDES);
						$('#slkcd_ver').val(data.result.KCD_VER);
						$('#txtkcd_death_code').val(data.result.KCD_DEATH_CODE);
						$('#hdmemo').val(data.result.MEMO);
						$('#txtmemo').val(data.result.MEMO_KOR);
						$('#txtmemo_eng').text(data.result.MEMO_ENG);
						$('#slemrps_at').val(data.result.EMRPS_AT);
						$('#txtemrpsde').val(data.result.EMRPSDE);
						$('#slkcd_ver').val(data.result.KCD_VER);
						$('#txtkcd_emrps_cod').val(data.result.KCD_EMRPS_CODE);
						$('#hdemrps_resn').val(data.result.EMRPS_RESN);
						$('#txtemrps_resn').val(data.result.EMRPS_RESN_KOR);
						$('#txtemrps_resn_eng').text(data.result.EMRPS_RESN_ENG);
						$('#hdetc').val(data.result.ETC);
						$('#txtetc').val(data.result.ETC_KOR);
						$('#txtetc_eng').text(data.result.ETC_ENG);
						$("#hdae_detail_cn").val(data.result.AE_DETAIL_CN);
						$("#txtae_detail_cn").val(data.result.AE_DETAIL_CN_KOR);
						$("#txtae_detail_cn_eng").text(data.result.AE_DETAIL_CN_ENG);
						
						$('#mode').val('U'); 
						  
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

window.onresize = function() {
	if (typeof grAeList.id !== "undefined") {
	 AUIGrid.resize(grAeList.id);
	 }
};

function setAccodian(){
	 for(var ai=0; ai<3; ai++){
	    aiP = ai+1;
	
		(function(aiE){ 
			$(".accordion_0"+aiE+" > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".accordion_con_0"+aiE+"").slideToggle(20);
					$(this).toggleClass('open');
					//그리드 리사이징
					//AUIGrid.resize(myGridOption.id);
				}
			});

			$(".accordion_con_02").css({"display":""});
			$(".accordion_con_03").css({"display":"none"});			
		
		})(aiP); //반복문 적용끝
	
	} //반복문끝
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
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0201&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0201&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>								
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>이상사례</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>이상사례</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">
					<div class="button_tab_01">
						<ul>
							<li id="tabDemographics" class="tab_menu">DEMOGRAPHICS</li>
							<li id="tabMedicalhistory" class="tab_menu">MEDICAL HISTORY</li>
							<li id="tabDrughistory" class="tab_menu">DRUG HISTORY</li>
							<li id="tabAe" class="port_back tab_menu">AE</li>
							<li id="tabLab" class="tab_menu">LAB</li>
							<li id="tabDrug" class="tab_menu">DRUG</li>
							<li id="tabCasulity" class="tab_menu">CASUALITY</li>
							<li id="tabNarrative" class="tab_menu">NARRATIVE</li>
							<li id="tabAssessment" class="tab_menu">ASSESSMENT</li>
						</ul>
					</div>

					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="btnInit" value="초기화">									
						<input type="button" id="btnSearch" value="검색">
						<input type="button" id="btnAdd" value="추가">
						<input type="button" id="btnSave" value="저장">
						<input type="button" id="btnDel" value="삭제">
						<input type="button" id="btnExcel" value="엑셀">
						<input type="button" id="btnAudit" value="내역">
					</article>
					<input type="hidden" id="hdhrmflns_case_code" />
					<input type="hidden" id="hdprduct_code" />
					<input type="hidden" id="hdfollow_no" />
					<input type="hidden" id="hdmafu_no" />
					<input type="hidden" id="hdae_no" />
					<input type="hidden" id="mode" />
					
                    
					<ul class="mgT20">
					    <li class="accordion_02">
					    	<a href="#void" class="close">Report</a>
					        <div class="accordion_con_02">
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="15%" />
										<col width="10%" />
										<col width="20%" />
										<col width="12%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Date of 1st Received<span class="must_01"></span></th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtfrt_rcept_dte" style="width:100%;">
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Date of Finalization</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtlast_dte" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Case for MFDS Report?</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slmfds_report_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Report Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtmfds_report_dte" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											
										</tr>
										<tr>
											<th>Case for KIDS Report?</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slkids_report_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Report Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtkids_report_dte" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Case for IRB Report?</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slirb_report_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Report Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtirb_report_date" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Case for Other Report?</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="sldifr_instt_report_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Report Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtdifr_instt_report_date" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Case for Manufacturer Report?</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slmanufacturer_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Report Due</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtmanufacturer_report_pd" style="width:17%; padding:0 2px;">
															Days															
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Report Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtmanufacturer_report_date" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Was the case medically confirmed, if not initially from health professional?</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<select id="sllegacy_health_ennc" style="width:100%;">
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
									</tbody>
								</table>
	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap" class="gridHeiSz04 grid_wrap tb01_2"></div>
					                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
					                    </div>
					                </li>
					            </ul>


					        </div>
					    </li>
	
					</ul>
					
					<article class="mgT16" style="margin-bottom: 16px;">
                        <div id="grAeList" class="gridHeiSz03 grid_wrap tb01_2"></div>
                        <!-- <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
                    </article>
                    <form id="iform">
                    <ul class="mgT20" id ="Aeinput">
					    <li class="accordion_02">
					    	<a href="#void" class="close">Adverse Event No.1</a>
					        <div class="accordion_con_02">
	
	
								<table class="tb001">
									<colgroup>
										<col width="10%" />
										<col width="8%" />
										<col width="20%" />
										<col width="10%" />
										<col width="20%" />
										<col width="10%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th colspan="2">Adverse Event<span class="must_01"></span></th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtadverse_event" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtadverse_event','txtadverse_event_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdadverse_event" />
												<label popup_type="Label" id="txtadverse_event_eng"></label>											
											</td>
										</tr>
										<tr>
											<th colspan="2">Main AE<span class="must_01"></span></th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slmain_ae_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Is Highlight Adverse Event?</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slhighlt_at" style="width:100%;">
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
											<th>WHOART</th>
											<th>Version</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Term</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="vertical-align: top; width: 32px;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
											</td>
											<th>ARRN Code</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
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
											<th>MedDRA</th>
											<th>Version</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>LLT</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="vertical-align: top; width: 32px;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
											</td>
											<th>LLT Code</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
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
											<th colspan="2">Start Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtbegin_dts" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Start Time</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtbegin_dt_time" style="width: 120px;" >
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Outcome</th>
											<td colspan="5">
												<select id="slresult_knd" style="width:100%;">
													<option value=''>===selected===</option>
												</select>
											</td>
										</tr>
										<tr>
											<th colspan="2">End Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtend_dts" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>End Time</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtend_dt_time" style="width: 120px;" >
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Duration of event</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtabove_respns_ped"  style="width:50px;"> Day
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Time interval between beginning of suspect drug administration and start of AE</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtdoubt_drfstf_mdctn_intrvl_dail"  style="width:50px;"> Day
															&nbsp;&nbsp;
															<input type="text" id="txtdoubt_drfstf_mdctn_intrvl_time" style="width:50px;"> Hours
															&nbsp;&nbsp;
															<input type="text" id="txtdoubt_drfstf_mdctn_intrvl_mnt" style="width:50px;"> Min
															
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Time interval between last dose and start of reaction/event</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtlast_mdctn_respns_intrvl_dail" style="width:50px;"> Day
															&nbsp;&nbsp;
															<input type="text" id="txtlast_mdctn_respns_intrvl_time"  style="width:50px;"> Hours
															&nbsp;&nbsp;
															<input type="text" id="txtlast_mdctn_respns_intrvl_mnt"  style="width:50px;"> Min
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Seriousness<span class="must_01"></span></th>
											<td style="vertical-align:top;">
												<table class="in_table">
													<tr>
														<th>
															<select id="slseriusfmnm_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Seriousness Details</th>
											<td colspan="3"  >
												<table class="in_table">
													<tr>
														<th>
															<div>
																<input type="checkbox" name="chseriusfmnm_detail_cn" id="chseriusfmnm_detail_cn_1" value='1' ><label for="chseriusfmnm_detail_cn_1" class="chcLab"><span>Results in death</span></label><br/>
																<input type="checkbox" name="chseriusfmnm_detail_cn" id="chseriusfmnm_detail_cn_2" value='2'><label for="chseriusfmnm_detail_cn_2" class="chcLab"><span>Is life-threatening</span></label><br/>
																<input type="checkbox" name="chseriusfmnm_detail_cn" id="chseriusfmnm_detail_cn_3" value='3'><label for="chseriusfmnm_detail_cn_3" class="chcLab"><span>Requires inpatient hospitalization or prologation of existing hospitalization</span></label><br/>
																<input type="checkbox" name="chseriusfmnm_detail_cn" id="chseriusfmnm_detail_cn_4" value='4'><label for="chseriusfmnm_detail_cn_4" class="chcLab"><span>Results in persistent or significant disability/incapacity</span></label><br/>
																<input type="checkbox" name="chseriusfmnm_detail_cn" id="chseriusfmnm_detail_cn_5" value='5'><label for="chseriusfmnm_detail_cn_5" class="chcLab"><span>Is a congentital anomaly birth defect</span></label><br/>
																<input type="checkbox" name="chseriusfmnm_detail_cn" id="chseriusfmnm_detail_cn_6" value='6'><label for="chseriusfmnm_detail_cn_6" class="chcLab"><span>Other medically important condition</span></label>
																<input type="hidden" id="hdseriusfmnm_detail_cn" />
															</div>
														</th>
														<td style="width: 32px;vertical-align:top;padding-top:5px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Severity1</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slseriusdo_se" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>NCICTC</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slstep_se" style="width:100%;">
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
											<th colspan="2">Relatedness<br>(Reporter)1</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slreportr_relation_one" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Relatedness<br>(Reporter)2</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slreportr_relation_two" style="width:100%;">
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
											<th colspan="2">Relatedness<br>(Sponsor)1</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slspon_relation_one" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Relatedness<br>(Sponsor)2</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slspon_relation_two" style="width:100%;">
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
											<th colspan="2">Action taken with drug</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<select id="sldrfstf_respns_se" style="width:100%;">
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
											<th colspan="2">Expectedness</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<select id="slexpect_posbl_se" style="width:100%;">
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
											<th colspan="2">Date of Death</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtdeathdes" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>AE Detail Content</th>
											<td colspan="3">												
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtae_detail_cn" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtae_detail_cn','txtae_detail_cn_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdae_detail_cn" />
												<label popup_type="Label" id="txtae_detail_cn_eng"></label>
											</td>
										</tr>
										<tr>
											<th>KCD OF Death</th>
											<th>Version</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slkcd_ver" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Term</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="width: 32px; vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
											</td>
											<th>Code</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="txtkcd_death_code" style="width:100%;">
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
											<th colspan="2">Reported cause of death</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtmemo" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtmemo','txtmemo_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdmemo" />
												<label popup_type="Label" id="txtmemo_eng"></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">Was autopsy done?</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<select id="slemrps_at" style="width:100%;">
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
											<th>KCD OF Autopsy</th>
											<th>Version</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slkcd_ver" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Term</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="width: 32px; vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
											</td>
											<th>Code</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="txtkcd_emrps_cod" style="width:100%;">
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
											<th colspan="2">Autopsy-determined cause of death</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtemrps_resn" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtemrps_resn','txtemrps_resn_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdemrps_resn" />
												<label popup_type="Label" id="txtemrps_resn_eng"></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">Ohter Information</th>
											<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="txtetc" id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtetc','txtetc_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdetc" />
												<label popup_type="Label" id="txtetc_eng"></label>
											</td>
										</tr>
									</tbody>
								</table>
	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap" class="gridHeiSz04 grid_wrap tb01_2"></div>
					                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					</ul>
					</form>
				
				</div>
            </section>
		</div>
	</section>
	
</div>
</body>
</html>