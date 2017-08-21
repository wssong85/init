<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title>DEMOGRAPHICS</title>
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
.ui-datepicker .ui-datepicker-buttonpane{ display:none;}
</style>

<script type="text/javascript" src="/js/pantheon/common/unified.cubesafety.js"></script>
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

	$(function() {
		setAccodian();
		btnInit();
 		setInit();
 		init();
 		
 		myGridOption.createGrid();
		
	});
	
	function tabMove(url){
		if($.trim($('#hdhrmflns_case_code').val())=="" || $.trim($('#hdProductCode').val())=="" || $("#slfollow_no option:selected").val()==""){			
			return;
		}
		
		ids[0]= "HRMFLNS_CASE_CODE";
		vals[0]= $.trim($('#hdhrmflns_case_code').val());

		ids[1]= "PRDUCT_CODE";
		vals[1]= $.trim($('#hdProductCode').val());
		
		ids[2]= "FOLLOW_NO";
		vals[2]= $("#slfollow_no option:selected").val();
		
		ids[3]= "SOURCE_TYPE";
		vals[3]= $("#slsourcetype option:selected").val();
		
		ids[4]= "SOURCE";
		vals[4]= $("#slsource option:selected").val();
		
		ids[5]= "SITESUBJECT";
		vals[5]= $("#slsitesubject option:selected").val();
		
		ids[6]= "MAFU_NO";
		vals[6]= $("#hdmafu_no").val();
		
		POSTSends(url, ids, vals);		
	}
	function btnInit() {

		$('input[popup_type=Q]').click(function(){
			alert('쿼리팝업');
			return false;
		});	
		
		$('button[popup_type=ProductSearch], input[popup_type=ProductSearch]').click(function(){
			mkLayerPopupOpen("/sdb/b02/popupSDBB0204.do", null);
			if (typeof grProductList_Search.id !== "undefined") {
				AUIGrid.resize(grProductList_Search.id);
			}
			return false;
		});	
		
		$('button[popup_type=ReportSearch], input[popup_type=ReportSearch]').click(function(){
			mkLayerPopupOpen("/sdb/b03/popupSDBB0303.do", null);
			if (typeof grOrganList_Search.id !== "undefined") {
				AUIGrid.resize(grOrganList_Search.id);
			}
			return false;
		});	
		
		
		
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

		$('#btnCase').click(function() {
			window.location.href = "/sdb/c02/SDBC0201.do";
		});

		$('#btnInit').click(function() {
			Applybtninit();
		});
		
		$('#btnTransfer').click(function() {
			if (!confirm('전달 하시겠습니까?')) {
				return;
			}
			var params = {					
					PRDUCT_CODE						: $.trim($("#hdProductCode").val()),
					SOURCE_TYPE						: $.trim($("#slsourcetype").val()),
					SOURCE							: $.trim($("#slsource").val()),
					HRMFLNS_CASE_CODE				: $.trim($("#hdhrmflns_case_code").val()),
					FOLLOW_NO						: $.trim($("#hdfollow_no").val())				
				};
				
				$.ajax({
					url : '/sdb/c02/insertTransfer.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							alert('성공!');
							//window.location.href= "/sdb/c02/].do";
						} else {
							alert(data.message);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				}); 
				
		});
		
		$('#btnPopCase').click(function(){
			mkLayerPopupOpen("/sdb/c02/popupSDBC0219.do", null);
			if (typeof grCase_Search.id !== "undefined") {
				AUIGrid.resize(grCase_Search.id);
			}
			return false;
		});
		
		$('#btnSubjectCopy').click(function() {
			//Applybtninit();
		});
		
		$('#btnFollowUp').click(function() {
// 			if (!confirm('Folow Up 하시겠습니까?')) {
// 				return;
// 			}
//alert('111');
			var params = {					
				PRDUCT_CODE						: $.trim($("#hdProductCode").val()),				
				HRMFLNS_CASE_CODE				: $.trim($("#hdhrmflns_case_code").val()),
				FOLLOW_NO						: $.trim($("#hdfollow_no").val()),
				UPDATE_ID 						: '${loginMap.USER_ID}'
			};
			
			$.ajax({
				url : '/sdb/c02/insertFollowUp.do',
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						alert('성공!');
						//window.location.href= "/sdb/c02/].do";
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			}); 
		});
		
		
		$('#filetForm').ajaxForm({
			beforeSubmit: function (data,form,option) {
				console.log('1111');	
				if(data[0].value=="")
				{
					saveForm($("#mode").val(), $('#file_id').val());
					return false;
				}
				//submit전 행동
				return true;
				
			},
			success: function(response,status){
				var data = '';
				
				try {
					data = JSON.parse(response);	
				} catch(e) {
					data = response;
				}
				
				if(data.success) {
					console.log(data.result);
					saveForm($('#mode').val(), data.result);
				} else {
					alert(data.message);
				}
			},
			error: function(){
				alert("file upload error!!");
			}
		});

		$('#btnSave').click(function() {
			if (!confirm('저장하시겠습니까?')) {
				return;
			}
			
			//$('#slsourcetype, #slsource, #slsitesubject, #slfollow_no').val('');
			if($.trim($('#txtProductCode').val())==''){
				alert('PRODUCT 입력해주세요');
					//$('#txtProductCode').focus();
				return;
			}
			
			if($.trim($('#slsourcetype').val())==''){
				alert('SOURCE TYPE 을 선택해주세요.');
				setTimeout(function(){
					$('#slsourcetype').focus();
				}, 500);
				return;
			}
			
			if($.trim($('#slsource').val())==''){
				alert('SOURCE 를 선택해주세요.');
				setTimeout(function(){
					$('#slsource').focus();
				}, 500);
				return;
			}
			
			if (!mkValidation()) {
				return;
			}
			
			
// 			alert($.trim($("#mode").val()));
// 			return;
			
			if ( $.trim($("#mode").val()) == 'U') {
				var param = {
						TRGET_CODE 	: $("#hdmafu_no").val(),
						TRGETNM 	: "DEMOGRAPHICS",
						TRGET_MODE  : "U",
						UPDATE_ID	: '${loginMap.USER_ID}'						
					};
				mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
			}else{
				$("#filetForm").submit();
			}
		});

		$('#btnDel').click(function() {
			if ($('#mode').val() == 'U') {
				if (!confirm('삭제하시겠습니까?')) {
					return;
				}
				var param = {
						TRGET_CODE 	: $("#hdmafu_no").val(),
						TRGETNM 	: "DEMOGRAPHICS",
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
		
		$('#txtProductCode').change(function(){
			
			$('#slsourcetype, #slsource,#slsitesubject, #slfollow_no').val('');	
			$('#slsourcetype').attr('disabled', false);
			
			$('#slsource,#slsitesubject, #slfollow_no').attr('disabled', true);
		});
		
		$('#slsourcetype').change(function(){
			if($.trim($('#slsourcetype').val()) ==""){
				$('#slsource option').remove();
				return;
			}
			var params2 = {					
					PRDUCT_CODE		: $.trim($("#hdProductCode").val()),
					SOURCE_TYPE		: $.trim($("#slsourcetype").val())
				};
				$.ajax({
					url : '/sdb/c02/selectSource.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params2),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							
							$('#slsource option').remove();
							var t_default = '<option value="">===선택하세요===</option>';
							$('#slsource').append(t_default);
							for(i=0; i< data.result.length; i++){
								var t_option = "<option value='"+ data.result[i].SOURCE_CODE +"'>"+ data.result[i].SOURCE_CODE +"</option>";
								$('#slsource').append(t_option);	
							}
							
							$('#slsource,#slsitesubject, #slfollow_no').val('');	
							$('#slsource').attr('disabled', false);
							$('#slsitesubject, #slfollow_no').attr('disabled', true);
							
// 							$('#slsitesubject').val('');	
// 							$('#slsitesubject').attr('disabled', false);
// 							$('#slfollow_no').val('');	
// 							$('#slfollow_no').attr('disabled', true);
							//window.location.href= "/sdb/c01/SDBC0108.do";
						} else {
							alert(data.message);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
		});
		
		$('#slsource').change(function(){
// 			if($.trim($('#slsourcetype').val()) ==""){
// 				$('#slsource option').remove();
// 				return;
// 			}
			var params2 = {					
					PRDUCT_CODE		: $.trim($("#hdProductCode").val()),
					SOURCE_TYPE		: $.trim($("#slsourcetype").val()),
					SOURCE			: $.trim($("#slsource").val())
				};
			
				$.ajax({
					url : '/sdb/c02/selectSiteSubject.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params2),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							
							$('#slsitesubject option').remove();
							
							if(data.result.length == 0)
							{
								$('#slsitesubject').attr("disabled", true);
								//Applybtninit();
								
							}else{
								var t_default = '<option value="">===선택하세요===</option>';
								$('#slsitesubject').append(t_default);
								
								for(i=0; i< data.result.length; i++){
									var t_option = "<option value='"+ data.result[i].SITE_SUBJECT_CODE +"'>"+ data.result[i].SITE_SUBJECT_NO  +"</option>";
									$('#slsitesubject').append(t_option);	
								}
								
								$('#slsitesubject').val('');	
								$('#slsitesubject').attr('disabled', false);
								$('#slfollow_no').val('');	
								$('#slfollow_no').attr('disabled', true);
								
							}
							
							//window.location.href= "/sdb/c01/SDBC0108.do";
						} else {
							alert(data.message);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
		});
		
		
		$('#slsitesubject').change(function(){
// 			if($.trim($('#slsourcetype').val()) ==""){
// 				$('#slsource option').remove();
// 				return;
// 			}
			var txtsitesubject = $.trim($("#slsitesubject").val());
			var txtArray = txtsitesubject.split('-');
			
			var params2 = {					
				PRDUCT_CODE		: $.trim($("#hdProductCode").val()),
				SOURCE_TYPE		: $.trim($("#slsourcetype").val()),
				SOURCE			: $.trim($("#slsource").val()),
				INSTT_NO		: txtArray[0],
				TESTEE_NO		: txtArray[1]
			};
		
			$.ajax({
				url : '/sdb/c02/selectFollow.do',
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params2),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						
						$('#slfollow_no option').remove();
						
						if(data.result.length == 0)
						{
							$('#slfollow_no').attr("disabled", true);
							Applybtninit();
							
						}else{
							var t_default = '<option value="">===선택하세요===</option>';
							$('#slfollow_no').append(t_default);
							
							for(i=0; i< data.result.length; i++){
								var t_option = "<option value='"+ data.result[i].FOLLOW_NO +"'>"+ data.result[i].TXT_FOLLOW  +"</option>";
								$('#slfollow_no').append(t_option);	
							}
							
							$('#slfollow_no').val('');	
							$('#slfollow_no').attr('disabled', false);
						}
						
						//window.location.href= "/sdb/c01/SDBC0108.do";
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		});
		
		$('#slfollow_no').change(function(){
			if($.trim($('#slsourcetype').val()) ==""){
				$('#slsource option').remove();
				return;
			}
			var txtsitesubject = $.trim($("#slsitesubject").val());
			var txtArray = txtsitesubject.split('-');
			
			var params = {					
					PRDUCT_CODE		: $.trim($("#hdProductCode").val()),
					SOURCE_TYPE		: $.trim($("#slsourcetype").val()),
					SOURCE			: $.trim($("#slsource").val()),
					INSTT_NO		: txtArray[0],
					TESTEE_NO		: txtArray[1],
					FOLLOW_NO		: $.trim($("#slfollow_no").val())
				};
				$.ajax({
					url : '/sdb/c02/selectDemographics.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							$('#mode').val('U');							
							$("#hdhrmflns_case_code").val($.trim(data.result.HRMFLNS_CASE_CODE));
							$("#txtprduct_code").val($.trim(data.result.PRDUCT_CODE));
							$("#hdfollow_no").val($.trim(data.result.FOLLOW_NO));
							$("#hdmafu_no").val($.trim(data.result.MAFU_NO));
							
							$("#txtinstt_no").val($.trim(data.result.INSTT_NO));
							$("#txtinstt_code").val($.trim(data.result.INSTT_CODE));
							$("#txtlast_pysiclg_dtes").val($.trim(data.result.LAST_PYSICLG_DTES));
							$("#txttestee_no").val($.trim(data.result.TESTEE_NO));
							$("#txtclient_manage_no").val($.trim(data.result.CLIENT_MANAGE_NO));
							$("#txtetc_manage_no").val($.trim(data.result.ETC_MANAGE_NO));
							$("#txtinitial_flag").val($.trim(data.result.INITIAL_FLAG));
							$("#slsexdstn").val($.trim(data.result.SEXDSTN));
							$("#slpregnan_at").val($.trim(data.result.PREGNAN_AT));
							$("#slpregnan_pd_se").val($.trim(data.result.PREGNAN_PD_SE));
							$("#txtpregnan_pd").val($.trim(data.result.PREGNAN_PD));
							$("#txtheight").val($.trim(data.result.HEIGHT));
							$("#txtbdwgh").val($.trim(data.result.BDWGH));
							$("#txtagre_dtes").val($.trim(data.result.AGRE_DTES));
							$("#txtregist_dtes").val($.trim(data.result.REGIST_DTES));
							$("#slin_out_se").val($.trim(data.result.IN_OUT_SE));
							
							$("#txtlifyeamd").val($.trim(data.result.LIFYEAMD));
							$("#txtage").val($.trim(data.result.AGE));
							$("#slage_grup").val($.trim(data.result.AGE_GRUP));
							$("#sldifr_age_info_code").val($.trim(data.result.DIFR_AGE_INFO_CODE));
							$("#txtdifr_age_info").val($.trim(data.result.DIFR_AGE_INFO));
							$("#txtpregnan_weekco").val($.trim(data.result.PREGNAN_WEEKCO));							
							$("#txtaplcnt_safe_reprt_idntfr").val($.trim(data.result.MAFU_NO));
							$("#txtmain_nation_idntfc").val($.trim(data.result.MAIN_NATION_IDNTFC));
							$("#txtrespns_occrrnc_nation_idntfc").val($.trim(data.result.RESPNS_OCCRRNC_NATION_IDNTFC));
							$("#slreprt_knd").val($.trim(data.result.REPRT_KND));
							$("#sladit_papers_at").val($.trim(data.result.ADIT_PAPERS_AT));
							
							$("#txtpregnan_weekco").val($.trim(data.result.PREGNAN_WEEKCO));
							$("#txtparnts_age").val($.trim(data.result.PARNTS_AGE));
							$("#slparnts_sexdstn").val($.trim(data.result.PARNTS_SEXDSTN));
							$("#txtnation_code").val($.trim(data.result.NATION_CODE));
							
							$("#slqualf").val($.trim(data.result.QUALF));
							if($("#slqualf").val() =="8"){
								$('#txtqualf_etc_opinion').attr("disabled", false);
							}else{
								$('#txtqualf_etc_opinion').attr("disabled", true );
							}
							$("#slreprt_ty").val($.trim(data.result.REPRT_TY));
							if($("#slreprt_ty").val() =="5"){
								$('#txtreprt_ty_etc_opinion').attr("disabled", false);
							}else{
								$('#txtreprt_ty_etc_opinion').attr("disabled", true );
							}
							$("#txtemail").val($.trim(data.result.EMAIL));
							$("#txttelno").val($.trim(data.result.TELNO));
							$("#txtfax").val($.trim(data.result.FAX));
							
							$("#hdin_out_etc_memo").val($.trim(data.result.IN_OUT_ETC_MEMO));
							$("#txtin_out_etc_memo").val($.trim(data.result.IN_OUT_ETC_MEMO_KOR));
							$("#txtin_out_etc_memo_eng").text($.trim(data.result.IN_OUT_ETC_MEMO_ENG));							
							$("#hdparnts_nm").val($.trim(data.result.PARNTS_NM));
							$("#txtparnts_nm").val($.trim(data.result.PARNTS_NM_KOR));
							$("#txtparnts_nm_eng").text($.trim(data.result.PARNTS_NM_ENG));
							$("#hdinstt_nm").val($.trim(data.result.INSTT_NM));
							$("#txtinstt_nm").val($.trim(data.result.INSTT_NM_KOR));
							$("#txtinstt_nm_eng").text($.trim(data.result.INSTT_NM_ENG));
							$("#txtadres").val($.trim(data.result.ADRES));
							$("#hdadres_dstnc").val($.trim(data.result.ADRES_DSTNC));
							$("#txtadres_dstnc").val($.trim(data.result.ADRES_DSTNC_KOR));
							$("#txtadres_dstnc_eng").text($.trim(data.result.ADRES_DSTNC_ENG));
							$("#hdadres_cty").val($.trim(data.result.ADRES_CTY));
							$("#txtadres_cty").val($.trim(data.result.ADRES_CTY_KOR));
							$("#txtadres_cty_eng").text($.trim(data.result.ADRES_CTY_ENG));
							$("#hdadres_lclty").val($.trim(data.result.ADRES_LCLTY));
							$("#txtadres_lclty").val($.trim(data.result.ADRES_LCLTY_KOR));
							$("#txtadres_lclty_eng").text($.trim(data.result.ADRES_LCLTY_ENG));
							$("#hdadres_zip").val($.trim(data.result.ADRES_ZIP));
							$("#txtadres_zip").val($.trim(data.result.ADRES_ZIP_KOR));
							$("#txtadres_zip_eng").text($.trim(data.result.ADRES_ZIP_ENG));
							$("#hdreportr").val($.trim(data.result.REPORTR));
							$("#txtreportr").val($.trim(data.result.REPORTR_KOR));
							$("#txtreportr_eng").text($.trim(data.result.REPORTR_ENG));
							$("#hdreportr_appn_nm").val($.trim(data.result.REPORTR_APPN_NM));
							$("#txtreportr_appn_nm").val($.trim(data.result.REPORTR_APPN_NM_KOR));
							$("#txtreportr_appn_nm_eng").text($.trim(data.result.REPORTR_APPN_NM_ENG));
							$("#hdreportr_middle_nm").val($.trim(data.result.REPORTR_MIDDLE_NM));
							$("#txtreportr_middle_nm").val($.trim(data.result.REPORTR_MIDDLE_NM_KOR));
							$("#txtreportr_middle_nm_eng").text($.trim(data.result.REPORTR_MIDDLE_NM_ENG));
							$("#hdreportr_family_nm").val($.trim(data.result.REPORTR_FAMILY_NM));
							$("#txtreportr_family_nm").val($.trim(data.result.REPORTR_FAMILY_NM_KOR));
							$("#txtreportr_family_nm_eng").text($.trim(data.result.REPORTR_FAMILY_NM_ENG));
							$("#hdreportr_dept").val($.trim(data.result.REPORTR_DEPT));
							$("#txtreportr_dept").val($.trim(data.result.REPORTR_DEPT_KOR));
							$("#txtreportr_dept_eng").text($.trim(data.result.REPORTR_DEPT_ENG));
							$("#hdreprt_ty_detail").val($.trim(data.result.REPRT_TY_DETAIL));
							$("#txtreprt_ty_detail").val($.trim(data.result.REPRT_TY_DETAIL_KOR));
							$("#txtreprt_ty_detail_eng").text($.trim(data.result.REPRT_TY_DETAIL_ENG));
							$("#hdclass").val($.trim(data.result.CLASS));
							$("#txtclass").val($.trim(data.result.CLASS_KOR));
							$("#txtclass_eng").text($.trim(data.result.CLASS_ENG));
							$("#hdmajor").val($.trim(data.result.MAJOR));
							$("#txtmajor").val($.trim(data.result.MAJOR_KOR));
							$("#txtmajor_eng").text($.trim(data.result.MAJOR_ENG));
							
							$("#hdsourc_no").val($.trim(data.result.SOURC_NO));
							$("#hdparnts_no").val($.trim(data.result.PARNTS_NO));
							$("#hdreporter_no").val($.trim(data.result.REPORTER_NO));
							
							$("#hdtest_rcord_cmmn_memo").val($.trim(data.result.TEST_RCORD_CMMN_MEMO));
							$("#hdtest_rcord_cmmn_memo_kor").val($.trim(data.result.TEST_RCORD_CMMN_MEMO_KOR));
							$("#hdtest_rcord_cmmn_memo_eng").val($.trim(data.result.TEST_RCORD_CMMN_MEMO_ENG));	
							
							// 파일다운로드 관련
							var file_name= data.result.FILE_NAME;
							var file_ext= data.result.FILE_EXT;
							var file_fullname = file_name +"."+file_ext;
							  
							var detail_sn = data.result.DETAIL_SN;
							var file_mastr_sn = data.result.FILE_MASTR_SN;
							$("#egovComFileList").empty();
							if(!isNull(file_mastr_sn) && !isNull(detail_sn)){
								var t_html = '<a href="javascript:fn_downFile('+file_mastr_sn+', '+detail_sn+')">'+ file_fullname +'</a><input type="button" onclick="javascript:del_file();" value="Delete"/>';
								$("#egovComFileList").append(t_html);
								$('#egovComFileUploader').attr("disabled",true);
							}
							//$('#lbl_code').val(lbl_code);
							$('#file_id').val(file_mastr_sn);
							
							
							$("#hdrpt_no").val($.trim(data.result.RPT_NO));
							$("#txtidntfc_nation_code").val($.trim(data.result.IDNTFC_NATION_CODE));
							$("#txtoccrrnc_nation_code").val($.trim(data.result.OCCRRNC_NATION_CODE));
							$("#slreprt_ty").val($.trim(data.result.REPRT_TY));
							$("#sladi_doc_at").val($.trim(data.result.ADI_DOC_AT));
							$("#hddoc_list").val($.trim(data.result.DOC_LIST));
							$("#txtdoc_list").val($.trim(data.result.DOC_LIST_KOR));
							$("#txtdoc_list_eng").text($.trim(data.result.DOC_LIST_ENG));
							$("#slrpd_stdr_suffcn_at").val($.trim(data.result.RPD_STDR_SUFFCN_AT));
							$("#hdregl_nation_case_reprt_no").val($.trim(data.result.REGL_NATION_CASE_REPRT_NO));
							$("#txtregl_nation_case_reprt_no").val($.trim(data.result.REGL_NATION_CASE_REPRT_NO_KOR));
							$("#txtregl_nation_case_reprt_no_eng").text($.trim(data.result.REGL_NATION_CASE_REPRT_NO_ENG));
							$("#hddifr_trnsmisman_reprt_no").val($.trim(data.result.DIFR_TRNSMISMAN_REPRT_NO));
							$("#txtdifr_trnsmisman_reprt_no").val($.trim(data.result.DIFR_TRNSMISMAN_REPRT_NO_KOR));
							$("#txtdifr_trnsmisman_reprt_no_eng").text($.trim(data.result.DIFR_TRNSMISMAN_REPRT_NO_ENG));
							
							$("#hdbefore_report_manageno_sj").val($.trim(data.result.BEFORE_REPORT_MANAGENO_SJ));
							$("#txtbefore_report_manageno_sj").val($.trim(data.result.BEFORE_REPORT_MANAGENO_SJ_KOR));
							$("#txtbefore_report_manageno_sj_eng").text($.trim(data.result.BEFORE_REPORT_MANAGENO_SJ_ENG));
							$("#sltracereport_resn").val($.trim(data.result.TRACEREPORT_RESN));
							$("#hdtracereport_resn_etc_opinion").val($.trim(data.result.TRACEREPORT_RESN_ETC_OPINION));
							$("#txttracereport_resn_etc_opinion").val($.trim(data.result.TRACEREPORT_ETC_OPINION_KOR));
							$("#txttracereport_resn_etc_opinion_eng").text($.trim(data.result.TRACEREPORT_ETC_OPINION_ENG));
							$("#hdreferreport_manageno_sj").val($.trim(data.result.REFERREPORT_MANAGENO_SJ));
							$("#txtreferreport_manageno_sj").val($.trim(data.result.REFERREPORT_MANAGENO_SJ_KOR));
							$("#txtreferreport_manageno_sj_eng").text($.trim(data.result.REFERREPORT_MANAGENO_SJ_ENG));
							$("#slmdcneprfs_cnfirmcase_at").val($.trim(data.result.MDCNEPRFS_CNFIRMCASE_AT));
							$("#slreport_cancl_at").val($.trim(data.result.REPORT_CANCL_AT));
							$("#hdreport_cancl_resn").val($.trim(data.result.REPORT_CANCL_RESN));
							$("#txtreport_cancl_resn").val($.trim(data.result.REPORT_CANCL_RESN_KOR));
							$("#txtreport_cancl_resn_eng").text($.trim(data.result.REPORT_CANCL_RESN_ENG));
							
							if(data.result.SAMENSSCASE_REPORT_INSTT != null && data.result.SAMENSSCASE_REPORT_INSTT.indexOf("||")){
								var seArray = data.result.SAMENSSCASE_REPORT_INSTT.split('||');
								
								for(i=0; i< seArray.length; i++){
									if(seArray[i] == "1"){
										$('#chsamensscase_report_instt1').attr("checked", true);
									}else if(seArray[i] == "2"){			
										$('#chsamensscase_report_instt2').attr("checked", true);
									}else if(seArray[i] == "3"){			
										$('#chsamensscase_report_instt3').attr("checked", true);
									}else if(seArray[i] == "5"){			
										$('#chsamensscase_report_instt5').attr("checked", true);
										$('#txtsamensscase_etc_opinion').attr("disabled", false);
									}else if(seArray[i] == "6"){			
										$('#chsamensscase_report_instt6').attr("checked", true);
									}else if(seArray[i] == "B"){			
										$('#chsamensscase_report_insttB').attr("checked", true);
									}else if(seArray[i] == "C"){			
										$('#chsamensscase_report_insttC').attr("checked", true);
									}else if(seArray[i] == "Z"){			
										$('#chsamensscase_report_insttZ').attr("checked", true);
									}	
								}
							}							
							$("#hdsamensscase_etc_opinion").val($.trim(data.result.SAMENSSCASE_ETC_OPINION));
							$("#txtsamensscase_etc_opinion").val($.trim(data.result.SAMENSSCASE_ETC_OPINION_KOR));
							$("#txtsamensscase_etc_opinion_eng").text($.trim(data.result.SAMENSSCASE_ETC_OPINION_ENG));
							$("#hdreprt_ty_etc_opinion").val($.trim(data.result.REPRT_TY_ETC_OPINION));
							$("#txtreprt_ty_etc_opinion").val($.trim(data.result.REPRT_TY_ETC_OPINION_KOR));
							$("#txtreprt_ty_etc_opinion_eng").text($.trim(data.result.REPRT_TY_ETC_OPINION_ENG));
							$("#hdqualf_etc_opinion").val($.trim(data.result.QUALF_ETC_OPINION));
							$("#txtqualf_etc_opinion").val($.trim(data.result.QUALF_ETC_OPINION_KOR));
							$("#txtqualf_etc_opinion_eng").text($.trim(data.result.QUALF_ETC_OPINION_ENG));
							
							
						} else {
							alert(data.message);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
		});
		//$('#txtsamensscase_etc_opinion, #txtqualf_etc_opinion, #txtreprt_ty_etc_opinion').attr('disabled', true);
		$('#slqualf').change(function(){
			if($.trim($('#slqualf').val()) =="8"){
				$('#txtqualf_etc_opinion').attr("disabled", false);
			}else{
				$('#txtqualf_etc_opinion').val('');
				$('#txtqualf_etc_opinion_eng').text('');
				$('#txtqualf_etc_opinion').attr("disabled", true);
			}
		});
		
		$('#slreprt_ty').change(function(){
			if($.trim($('#slreprt_ty').val()) =="5"){
				$('#txtreprt_ty_etc_opinion').attr("disabled", false);
			}else{
				$('#txtreprt_ty_etc_opinion').val('');
				$('#txtreprt_ty_etc_opinion_eng').text('');
				$('#txtreprt_ty_etc_opinion').attr("disabled", true);
			}
		});
		$('#sltracereport_resn').change(function(){
			if($.trim($('#sltracereport_resn').val()) =="2"){
				$('#txttracereport_resn_etc_opinion').attr("disabled", false);
			}else{
				$('#txttracereport_resn_etc_opinion').val('');
				$('#txttracereport_resn_etc_opinion_eng').text('');
				$('#txttracereport_resn_etc_opinion').attr("disabled", true);
			}
		});
		
		
	}
	function fn_downFile(fileMastrSn, fileSn){
		window.open("<c:url value='/sdb/b01/selectDmFileDetailByPk.do?FILE_MASTR_SN="+fileMastrSn+"&DETAIL_SN="+fileSn+"'/>");
	}
	
	function setInit(){
		<c:forEach var="result" items="${printType2}" varStatus="status">
			$("#slsourcetype").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType32}" varStatus="status">
			$("#slreprt_knd").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType44}" varStatus="status">
			$("#sladit_papers_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			$("#sladi_doc_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			$("#slrpd_stdr_suffcn_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			$("#slpregnan_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			$("#slmdcneprfs_cnfirmcase_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			$("#slreport_cancl_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType34}" varStatus="status">
			$("#slpregnan_pd_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType35}" varStatus="status">
			$("#slin_out_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType08}" varStatus="status">
			$("#slage_grup").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType09}" varStatus="status">
			$("#sldifr_age_info_code").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType36}" varStatus="status">
			$("#slparnts_sexdstn").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType10}" varStatus="status">
			$("#slqualf").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType32}" varStatus="status">
			$("#slreprt_ty").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType07}" varStatus="status">
			$("#slsexdstn").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType76}" varStatus="status">
			$("#sltracereport_resn").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		
		<c:forEach var="result" items="${printType6}" varStatus="status">
			var ch_id = 'chsamensscase_report_instt<c:out value="${result.CMMN_CODE}"/>';
			var ap_content = "<input type='checkbox' name='chsamensscase_report_instt' id='"+ch_id+"' value='<c:out value="${result.CMMN_CODE}"/>' ><label for='"+ch_id+"' class='chcLab' style='display:inline-block; width:240px;'><span style='padding-right:10px;'><c:out value="${result.CMMN_CODE_NM}"/></span></label>"
			
			$("#i_samensscase_report_instt").append(ap_content);			
		</c:forEach>
		
		//select box 동적구성후 click event
		$('#chsamensscase_report_instt5').click(function(){
			if($('#chsamensscase_report_instt5').is(":checked")){
				$('#txtsamensscase_etc_opinion').attr("disabled",false);
			}else{
				$('#txtsamensscase_etc_opinion').val('');
				$('#txtsamensscase_etc_opinion_eng').text('');
				
				$('#txtsamensscase_etc_opinion').attr("disabled",true);
			}
		});
		
		
		$('#slsourcetype, #slsource, #slsitesubject, #slfollow_no').val('');
		//disabled 기본처리
		$('#slsourcetype, #slsource, #slsitesubject, #slfollow_no, #txtsamensscase_etc_opinion').attr('disabled', true);
		$('#txtsamensscase_etc_opinion, #txtqualf_etc_opinion, #txtreprt_ty_etc_opinion, #txttracereport_resn_etc_opinion').attr('disabled', true);
		   
		//날짜형
		//mkSetDatePickerYYMMDD("#txtagre_dte");
		//mkSetDatePickerYYMMDD("#txtregist_dte");
		//mkSetDatePickerYYMMDD("#txtlifyeamd");
		//mkSetDatePickerYYMMDD("#txtlast_pysiclg_dtes");
		
		//숫자형
		$("#txtage").mkNumber();
		$("#txtdifr_age_info").mkNumber();
		$("#txtpregnan_weekco").mkNumber();
		$("#txtparnts_age").mkNumber();
		//전화번호형		
		$("#txttelno").mkTel();
		$("#txtfax").mkTel();
		//maxlength
		$("#txtage").attr("maxlength", 3);
		$("#txtdifr_age_info").attr("maxlength", 4);
		$("#txtpregnan_weekco").attr("maxlength", 3);
		$("#txtparnts_age").attr("maxlength", 3);
 		$("#txtinitial_flag").attr("maxlength", 6);		
		
		$("input[popup_type=Q]").attr("title", "Query");
		$("input[popup_type=E]").attr("title", "English Notation");
		
	}
	
	function init() {
//		var PRDUCT_CODE = "${PRDUCT_CODE}";
		//alert(PRDUCT_CODE+"|SOURCE_TYPE|"+ SOURCE_TYPE +"|SOURCE|"+ SOURCE +"|SITESUBJECT|"+ SITESUBJECT +"|FOLLOW_NO|"+FOLLOW_NO);
		$('#hdProductCode').val(PRDUCT_CODE);
		$('#txtProductCode').val(PRDUCT_CODE);
		if(PRDUCT_CODE!=""){
			$('#txtProductCode').change();
		}
 		$('#slsourcetype').val(SOURCE_TYPE);
 		if(SOURCE_TYPE!=""){
 			$('#slsourcetype').change();
		}
 		
		$('#slsource').val(SOURCE);
		if(SOURCE!=""){
			$('#slsource').change();
		}
		
		$('#slsitesubject').val(SITESUBJECT);
		if(SITESUBJECT!=""){
			$('#slsitesubject').change();
		}
		$('#slfollow_no').val(FOLLOW_NO);
		$('#slfollow_no').change();
		
		//$('#mode').val('C');
		
		makeFileAttachment();
				
	}
	
	function makeFileAttachment(){
		//파일업로드 제한 수
		var maxFileNum = 1;
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
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
//				if ( aiE !=2 ) {
//					$(".acdMenuLst0"+aiE+"").not(this).on("click",function() {
//						if ($(".acdMenuLst0"+aiE+"").not(this).children().hasClass("close")) {
//							$(".acdMenuLst0"+aiE+"").not(this).children(".acdMenuCts0"+aiE+"").slideUp(500);
//						}
//					});
					
//					$(".acdMenuLst0"+aiE+" > a").not(this).on("click",function() {
//						if ($(".acdMenuLst0"+aiE+" > a").hasClass('open')) {
//							$(".acdMenuLst0"+aiE+" > a").not(this).removeClass('open');
//						}
//					});
//				} //조건문끝
				
				$(".accordion_con_02").css({"display":""}); //시작시 아코디온 펼쳐짐
				$(".accordion_con_03").css({"display":"none"});
			
			})(aiP); //반복문 적용끝
		
		} //반복문끝
	}
	
	function saveLayer(p_mode){		
		if(p_mode=='U'){
			if(typeof($('#egovComFileList').find("input")) != "object"){
				saveForm($("#mode").val(), $('#file_id').val());
				//alert('첨부할 파일이 존재하지 않습니다.');	
			}else{
				
				$("#filetForm").submit();
				
			}
		}
		else if(p_mode=='D'){
			if ($('#mode').val() == 'U') {
				var params = {
					CURD : 'D',
					HRMFLNS_CASE_CODE : $.trim($("#hdhrmflns_case_code").val())
				};
				$.ajax({
					type : "POST",
					url : "/sdb/c02/insertDemographics.do",
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							window.location.href= "/sdb/c01/SDBC0201.do";
						} else {
							alert(result.errmsg);
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						//alert(textStatus);
						alert("실패");
					}
				});
			} else {
	
			}
		}
	}
	
	function saveForm(mode, file_id){
		var ch_v="";
		$('input:checkbox[name="chsamensscase_report_instt"]').each(function (){
			
			if(this.checked){
				ch_v += this.value + "||";
			}
		});	
		$('#hdsamensscase_report_instt').val(ch_v);
		
		var params = {
			CURD 							: $.trim($("#mode").val()),
			PRDUCT_CODE						: $.trim($("#hdProductCode").val()),
			SOURCE_TYPE						: $.trim($("#slsourcetype").val()),
			SOURCE							: $.trim($("#slsource").val()),
			HRMFLNS_CASE_CODE				: $.trim($("#hdhrmflns_case_code").val()),
			SOURC_NO						: $.trim($("#hdsourc_no").val()),
			PARNTS_NO						: $.trim($("#hdparnts_no").val()),
			REPORTER_NO						: $.trim($("#hdreporter_no").val()),
			FOLLOW_NO						: $.trim($("#hdfollow_no").val()),
			
			//REPORT INPORMATION
			RPT_NO							: $.trim($("#hdrpt_no").val()),
			IDNTFC_NATION_CODE				: $.trim($("#txtidntfc_nation_code").val()),
			OCCRRNC_NATION_CODE				: $.trim($("#txtoccrrnc_nation_code").val()),
			REPRT_TY						: $.trim($("#slreprt_ty").val()),
			REPRT_TY_ETC_OPINION			: $.trim($("#hdreprt_ty_etc_opinion").val()),
			REPRT_TY_ETC_OPINION_KOR		: $.trim($("#txtreprt_ty_etc_opinion").val()),
			REPRT_TY_ETC_OPINION_ENG		: $.trim($("#txtreprt_ty_etc_opinion_eng").text()),
			ADI_DOC_AT						: $.trim($("#sladi_doc_at").val()),
			DOC_LIST						: $.trim($("#hddoc_list").val()),
			DOC_LIST_KOR					: $.trim($("#txtdoc_list").val()),
			DOC_LIST_ENG					: $.trim($("#txtdoc_list_eng").text()),
			RPD_STDR_SUFFCN_AT				: $.trim($("#slrpd_stdr_suffcn_at").val()),
			REGL_NATION_CASE_REPRT_NO		: $.trim($("#hdregl_nation_case_reprt_no").val()),
			REGL_NATION_CASE_REPRT_NO_KOR	: $.trim($("#txtregl_nation_case_reprt_no").val()),
			REGL_NATION_CASE_REPRT_NO_ENG	: $.trim($("#txtregl_nation_case_reprt_no_eng").text()),
			DIFR_TRNSMISMAN_REPRT_NO		: $.trim($("#hddifr_trnsmisman_reprt_no").val()),
			DIFR_TRNSMISMAN_REPRT_NO_KOR	: $.trim($("#txtdifr_trnsmisman_reprt_no").val()),
			DIFR_TRNSMISMAN_REPRT_NO_ENG	: $.trim($("#txtdifr_trnsmisman_reprt_no_eng").text()),
			
			//추가사항
			
			
			BEFORE_REPORT_MANAGENO_SJ		: $.trim($("#hdbefore_report_manageno_sj").val()),
			BEFORE_REPORT_MANAGENO_SJ_KOR	: $.trim($("#txtbefore_report_manageno_sj").val()),
			BEFORE_REPORT_MANAGENO_SJ_ENG	: $.trim($("#txtbefore_report_manageno_sj_eng").text()),
			TRACEREPORT_RESN				: $.trim($("#sltracereport_resn").val()),				
			TRACEREPORT_RESN_ETC_OPINION	: $.trim($("#hdtracereport_resn_etc_opinion").val()),
			TRACEREPORT_RESN_ETC_OPINION_KOR: $.trim($("#txttracereport_resn_etc_opinion").val()),
			TRACEREPORT_RESN_ETC_OPINION_ENG: $.trim($("#txttracereport_resn_etc_opinion_eng").text()),
			REFERREPORT_MANAGENO_SJ			: $.trim($("#hdreferreport_manageno_sj").val()),
			REFERREPORT_MANAGENO_SJ_KOR		: $.trim($("#txtreferreport_manageno_sj").val()),
			REFERREPORT_MANAGENO_SJ_ENG		: $.trim($("#txtreferreport_manageno_sj_eng").text()),
			MDCNEPRFS_CNFIRMCASE_AT			: $.trim($("#slmdcneprfs_cnfirmcase_at").val()),
			REPORT_CANCL_AT					: $.trim($("#slreport_cancl_at").val()),
			REPORT_CANCL_RESN				: $.trim($("#hdreport_cancl_resn").val()),
			REPORT_CANCL_RESN_KOR			: $.trim($("#txtreport_cancl_resn").val()),
			REPORT_CANCL_RESN_ENG			: $.trim($("#txtreport_cancl_resn_eng").text()),
			SAMENSSCASE_REPORT_INSTT		: $.trim($("#hdsamensscase_report_instt").val()),				
			SAMENSSCASE_ETC_OPINION			: $.trim($("#hdsamensscase_etc_opinion").val()),
			SAMENSSCASE_ETC_OPINION_KOR		: $.trim($("#txtsamensscase_etc_opinion").val()),
			SAMENSSCASE_ETC_OPINION_ENG		: $.trim($("#txtsamensscase_etc_opinion_eng").text()),
			
			//DEMOGRAPHICS			
			INSTT_NO						: $.trim($("#txtinstt_code").val()),					
			TESTEE_NO						: $.trim($("#txttestee_no").val()),
			CLIENT_MANAGE_NO				: $.trim($("#txtclient_manage_no").val()),
			ETC_MANAGE_NO					: $.trim($("#txtetc_manage_no").val()),
			INITIAL_FLAG					: $.trim($("#txtinitial_flag").val()),
			SEXDSTN				            : $.trim($("#slsexdstn").val()),
			PREGNAN_AT			            : $.trim($("#slpregnan_at").val()),
			PREGNAN_PD_SE		            : $.trim($("#slpregnan_pd_se").val()),
			PREGNAN_PD						: $.trim($("#txtpregnan_pd").val()),
			LAST_PYSICLG_DTES				: $.trim($("#txtlast_pysiclg_dtes").val()),
			HEIGHT				            : $.trim($("#txtheight").val()),
			BDWGH				            : $.trim($("#txtbdwgh").val()),
			AGRE_DTES			            : $.trim($("#txtagre_dtes").val()),
			REGIST_DTES						: $.trim($("#txtregist_dtes").val()),
			IN_OUT_SE			            : $.trim($("#slin_out_se").val()),
			IN_OUT_ETC_MEMO		            : $.trim($("#hdin_out_etc_memo").val()),
			IN_OUT_ETC_MEMO_KOR	            : $.trim($("#txtin_out_etc_memo").val()),
			IN_OUT_ETC_MEMO_ENG	            : $.trim($("#txtin_out_etc_memo_eng").text()),
			LIFYEAMD			            : $.trim($("#txtlifyeamd").val()),
			AGE								: $.trim($("#txtage	").val()),
			AGE_GRUP			            : $.trim($("#txtage_grup").val()),
			DIFR_AGE_INFO_CODE	            : $.trim($("#txtdifr_age_info_code").val()),
			DIFR_AGE_INFO		            : $.trim($("#txtdifr_age_info").val()),
			PREGNAN_WEEKCO					: $.trim($("#txtpregnan_weekco").val()),			
			FILE_ID	                        : file_id,
			
			//PARENT
			PARNTS_NM 		   				: $.trim($("#hdparnts_nm").val()),
			PARNTS_NM_KOR	   				: $.trim($("#txtparnts_nm").val()),
			PARNTS_NM_ENG	   				: $.trim($("#txtparnts_nm_eng").text()),
			PREGNAN_WEEKCO					: $.trim($("#txtpregnan_weekco").val()),
			PARNTS_AGE						: $.trim($("#txtparnts_age").val()),
			PARNTS_SEXDSTN					: $.trim($("#slparnts_sexdstn").val()),
			//REPORTER
			INSTT_NM						: $.trim($("#hdinstt_nm").val()),
			INSTT_NM_KOR					: $.trim($("#txtinstt_nm").val()),
			INSTT_NM_ENG					: $.trim($("#txtinstt_nm_eng").text()),
			INSTT_CODE						: $.trim($("#txtinstt_code").val()),
			NATION_CODE						: $.trim($("#txtnation_code").val()),
			ADRES							: $.trim($("#hdaddrone").val()),
			ADRES_KOR						: $.trim($("#txtaddrone").val()), 
			ADRES_ENG						: $.trim($("#txtaddrone_eng").text()),
			ADRES_DSTNC						: $.trim($("#hdadres_dstnc").val()),
			ADRES_DSTNC_KOR					: $.trim($("#txtadres_dstnc").val()),
			ADRES_DSTNC_ENG					: $.trim($("#txtadres_dstnc_eng").text()),
			ADRES_CTY						: $.trim($("#hdadres_cty").val()),
			ADRES_CTY_KOR					: $.trim($("#txtadres_cty").val()),
			ADRES_CTY_ENG					: $.trim($("#txtadres_cty_eng").text()),
			ADRES_LCLTY						: $.trim($("#hdadres_lclty").val()),
			ADRES_LCLTY_KOR					: $.trim($("#txtadres_lclty").val()),
			ADRES_LCLTY_ENG					: $.trim($("#txtadres_lclty_eng").text()),
			ADRES_ZIP	                    : $.trim($("#txtadres_zip").val()),
			REPORTR                         : $.trim($("#hdreportr").val()),
			REPORTR_KOR                     : $.trim($("#txtreportr").val()),
			REPORTR_ENG                     : $.trim($("#txtreportr_eng").text()),
			REPORTR_APPN_NM                 : $.trim($("#hdreportr_appn_nm").val()),
			REPORTR_APPN_NM_KOR             : $.trim($("#txtreportr_appn_nm").val()),
			REPORTR_APPN_NM_ENG             : $.trim($("#txtreportr_appn_nm_eng").text()),
			REPORTR_MIDDLE_NM				: $.trim($("#hdreportr_middle_nm").val()),
			REPORTR_MIDDLE_NM_KOR			: $.trim($("#txtreportr_middle_nm").val()),
			REPORTR_MIDDLE_NM_ENG			: $.trim($("#txtreportr_middle_nm_eng").text()),
			REPORTR_FAMILY_NM	            : $.trim($("#hdreportr_family_nm").val()),
			REPORTR_FAMILY_NM_KOR           : $.trim($("#txtreportr_family_nm").val()),
			REPORTR_FAMILY_NM_ENG           : $.trim($("#txtreportr_family_nm_eng").text()),
			REPORTR_DEPT                    : $.trim($("#hdreportr_dept").val()),
			REPORTR_DEPT_KOR                : $.trim($("#txtreportr_dept").val()),
			REPORTR_DEPT_ENG                : $.trim($("#txtreportr_dept_eng").text()),
			QUALF                           : $.trim($("#slqualf").val()),
			REPRT_TY						: $.trim($("#slreprt_ty").val()),
			REPRT_TY_DETAIL                 : $.trim($("#hdreprt_ty_detail").val()),
			REPRT_TY_DETAIL_KOR             : $.trim($("#txtreprt_ty_detail").val()),
			REPRT_TY_DETAIL_ENG             : $.trim($("#txtreprt_ty_detail_eng").text()),
			CLASS                           : $.trim($("#hdclass").val()),
			CLASS_KOR                       : $.trim($("#txtclass").val()),
			CLASS_ENG                       : $.trim($("#txtclass_eng").text()),
			MAJOR                           : $.trim($("#hdmajor").val()),
			MAJOR_KOR                       : $.trim($("#txtmajor").val()),
			MAJOR_ENG                       : $.trim($("#txtmajor_eng").text()),
			EMAIL							: $.trim($("#txtemail").val()),
			TELNO                           : $.trim($("#txttelno").val()),
			FAX	                            : $.trim($("#txtfax").val()),			
			QUALF_ETC_OPINION				: $.trim($("#hdqualf_etc_opinion").val()),
			QUALF_ETC_OPINION_KOR			: $.trim($("#txtqualf_etc_opinion").val()),
			QUALF_ETC_OPINION_ENG			: $.trim($("#txtqualf_etc_opinion_eng").text()),
			UPDATE_ID 						: '${loginMap.USER_ID}'
		};
		
		$.ajax({
			url : '/sdb/c02/insertDemographics.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if (data.success) {
					alert('성공!');
					//window.location.href= "/sdb/c02/SDBC0201.do";
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
			}
		}); 
		
	}
	
	function Reload_Case(mafu_no , instt_no , testee_no){
		
		var params = {
				MAFU_NO : mafu_no
				,INSTT_NO : instt_no
				,TESTEE_NO : testee_no
			};
			$.ajax({
				type : "post",
				url : "/sdb/c02/selectDemographics_Case.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						Applybtninit();
						
// 						$("#hdhrmflns_case_code").val($.trim(data.result.HRMFLNS_CASE_CODE));
// 						$("#txtprduct_code").val($.trim(data.result.PRDUCT_CODE));
// 						$("#hdfollow_no").val($.trim(data.result.FOLLOW_NO));
// 						$("#hdmafu_no").val($.trim(data.result.MAFU_NO));
						
						//$("#txtinstt_no").val($.trim(data.result.INSTT_NO));
						$("#txtinstt_code").val($.trim(data.result.INSTT_CODE));
						$("#txttestee_no").val($.trim(data.result.TESTEE_NO));
						$("#txtclient_manage_no").val($.trim(data.result.CLIENT_MANAGE_NO));
						$("#txtetc_manage_no").val($.trim(data.result.ETC_MANAGE_NO));
						$("#txtinitial_flag").val($.trim(data.result.INITIAL_FLAG));
						$("#slsexdstn").val($.trim(data.result.SEXDSTN));
						$("#slpregnan_at").val($.trim(data.result.PREGNAN_AT));
						$("#slpregnan_pd_se").val($.trim(data.result.PREGNAN_PD_SE));
						$("#txtpregnan_pd").val($.trim(data.result.PREGNAN_PD));
						$("#txtheight").val($.trim(data.result.HEIGHT));
						$("#txtbdwgh").val($.trim(data.result.BDWGH));
						$("#txtagre_dtes").val($.trim(data.result.AGRE_DTES));
						$("#txtregist_dtes").val($.trim(data.result.REGIST_DTES));
						$("#slin_out_se").val($.trim(data.result.IN_OUT_SE));
						
						$("#txtlifyeamd").val($.trim(data.result.LIFYEAMD));
						$("#txtage").val($.trim(data.result.AGE));
						$("#slage_grup").val($.trim(data.result.AGE_GRUP));
						$("#sldifr_age_info_code").val($.trim(data.result.DIFR_AGE_INFO_CODE));
						$("#txtdifr_age_info").val($.trim(data.result.DIFR_AGE_INFO));
						$("#txtpregnan_weekco").val($.trim(data.result.PREGNAN_WEEKCO));							
						
						
						$("#txtpregnan_weekco").val($.trim(data.result.PREGNAN_WEEKCO));
						$("#txtparnts_age").val($.trim(data.result.PARNTS_AGE));
						$("#slparnts_sexdstn").val($.trim(data.result.PARNTS_SEXDSTN));
						$("#txtnation_code").val($.trim(data.result.NATION_CODE));
						
						$("#slqualf").val($.trim(data.result.QUALF));
						$("#slreprt_ty").val($.trim(data.result.REPRT_TY));
						
						$("#txtemail").val($.trim(data.result.EMAIL));
						$("#txttelno").val($.trim(data.result.TELNO));
						$("#txtfax").val($.trim(data.result.FAX));
						
						$("#hdin_out_etc_memo").val($.trim(data.result.IN_OUT_ETC_MEMO));
						$("#txtin_out_etc_memo").val($.trim(data.result.IN_OUT_ETC_MEMO_KOR));
						$("#txtin_out_etc_memo_eng").text($.trim(data.result.IN_OUT_ETC_MEMO_ENG));
						$("#hdaplcnt_hold_doc_list").val($.trim(data.result.APLCNT_HOLD_DOC_LIST));
						$("#txtaplcnt_hold_doc_list").val($.trim(data.result.APLCNT_HOLD_DOC_LIST_KOR));
						$("#txtaplcnt_hold_doc_list_eng").text($.trim(data.result.APLCNT_HOLD_DOC_LIST_ENG));
						$("#hdregl_instt_reprt_no").val($.trim(data.result.REGL_INSTT_REPRT_NO));
						$("#txtregl_instt_reprt_no").val($.trim(data.result.REGL_INSTT_REPRT_NO_KOR));
						$("#txtregl_instt_reprt_no_eng").text($.trim(data.result.REGL_INSTT_REPRT_NO_ENG));
						$("#hdetc_reprt_no").val($.trim(data.result.ETC_REPRT_NO));
						$("#txtetc_reprt_no").val($.trim(data.result.ETC_REPRT_NO_KOR));
						$("#txtetc_reprt_no_eng").text($.trim(data.result.ETC_REPRT_NO_ENG));
						$("#hdrefer_ltrtre").val($.trim(data.result.REFER_LTRTRE));
						$("#txtrefer_ltrtre").val($.trim(data.result.REFER_LTRTRE_KOR));
						$("#txtrefer_ltrtre_eng").text($.trim(data.result.REFER_LTRTRE_ENG));
						$("#hdparnts_nm").val($.trim(data.result.PARNTS_NM));
						$("#txtparnts_nm").val($.trim(data.result.PARNTS_NM_KOR));
						$("#txtparnts_nm_eng").text($.trim(data.result.PARNTS_NM_ENG));
						$("#hdinstt_nm").val($.trim(data.result.INSTT_NM));
						$("#txtinstt_nm").val($.trim(data.result.INSTT_NM_KOR));
						$("#txtinstt_nm_eng").text($.trim(data.result.INSTT_NM_ENG));
						$("#txtadres").val($.trim(data.result.ADRES));
						$("#hdadres_dstnc").val($.trim(data.result.ADRES_DSTNC));
						$("#txtadres_dstnc").val($.trim(data.result.ADRES_DSTNC_KOR));
						$("#txtadres_dstnc_eng").text($.trim(data.result.ADRES_DSTNC_ENG));
						$("#hdadres_cty").val($.trim(data.result.ADRES_CTY));
						$("#txtadres_cty").val($.trim(data.result.ADRES_CTY_KOR));
						$("#txtadres_cty_eng").text($.trim(data.result.ADRES_CTY_ENG));
						$("#hdadres_lclty").val($.trim(data.result.ADRES_LCLTY));
						$("#txtadres_lclty").val($.trim(data.result.ADRES_LCLTY_KOR));
						$("#txtadres_lclty_eng").text($.trim(data.result.ADRES_LCLTY_ENG));
						$("#hdadres_zip").val($.trim(data.result.ADRES_ZIP));
						$("#txtadres_zip").val($.trim(data.result.ADRES_ZIP_KOR));
						$("#txtadres_zip_eng").text($.trim(data.result.ADRES_ZIP_ENG));
						$("#hdreportr").val($.trim(data.result.REPORTR));
						$("#txtreportr").val($.trim(data.result.REPORTR_KOR));
						$("#txtreportr_eng").text($.trim(data.result.REPORTR_ENG));
						$("#hdreportr_appn_nm").val($.trim(data.result.REPORTR_APPN_NM));
						$("#txtreportr_appn_nm").val($.trim(data.result.REPORTR_APPN_NM_KOR));
						$("#txtreportr_appn_nm_eng").text($.trim(data.result.REPORTR_APPN_NM_ENG));
						$("#hdreportr_middle_nm").val($.trim(data.result.REPORTR_MIDDLE_NM));
						$("#txtreportr_middle_nm").val($.trim(data.result.REPORTR_MIDDLE_NM_KOR));
						$("#txtreportr_middle_nm_eng").text($.trim(data.result.REPORTR_MIDDLE_NM_ENG));
						$("#hdreportr_family_nm").val($.trim(data.result.REPORTR_FAMILY_NM));
						$("#txtreportr_family_nm").val($.trim(data.result.REPORTR_FAMILY_NM_KOR));
						$("#txtreportr_family_nm_eng").text($.trim(data.result.REPORTR_FAMILY_NM_ENG));
						$("#hdreportr_dept").val($.trim(data.result.REPORTR_DEPT));
						$("#txtreportr_dept").val($.trim(data.result.REPORTR_DEPT_KOR));
						$("#txtreportr_dept_eng").text($.trim(data.result.REPORTR_DEPT_ENG));
						$("#hdreprt_ty_detail").val($.trim(data.result.REPRT_TY_DETAIL));
						$("#txtreprt_ty_detail").val($.trim(data.result.REPRT_TY_DETAIL_KOR));
						$("#txtreprt_ty_detail_eng").text($.trim(data.result.REPRT_TY_DETAIL_ENG));
						$("#hdclass").val($.trim(data.result.CLASS));
						$("#txtclass").val($.trim(data.result.CLASS_KOR));
						$("#txtclass_eng").text($.trim(data.result.CLASS_ENG));
						$("#hdmajor").val($.trim(data.result.MAJOR));
						$("#txtmajor").val($.trim(data.result.MAJOR_KOR));
						$("#txtmajor_eng").text($.trim(data.result.MAJOR_ENG));
						
						$("#hdsourc_no").val($.trim(data.result.SOURC_NO));
						$("#hdparnts_no").val($.trim(data.result.PARNTS_NO));
						$("#hdreporter_no").val($.trim(data.result.REPORTER_NO));
						
						$("#hdtest_rcord_cmmn_memo").val($.trim(data.result.TEST_RCORD_CMMN_MEMO));
						$("#hdtest_rcord_cmmn_memo_kor").val($.trim(data.result.TEST_RCORD_CMMN_MEMO_KOR));
						$("#hdtest_rcord_cmmn_memo_eng").val($.trim(data.result.TEST_RCORD_CMMN_MEMO_ENG));
						
						
						// 파일다운로드 관련
						var file_name= data.result.FILE_NAME;
						var file_ext= data.result.FILE_EXT;
						var file_fullname = file_name +"."+file_ext;
						  
						var detail_sn = data.result.DETAIL_SN;
						var file_mastr_sn = data.result.FILE_MASTR_SN;
						$("#egovComFileList").empty();
						if(!isNull(file_mastr_sn) && !isNull(detail_sn)){
							var t_html = '<a href="javascript:fn_downFile('+file_mastr_sn+', '+detail_sn+')">'+ file_fullname +'</a><input type="button" onclick="javascript:del_file();" value="Delete"/>';
							$("#egovComFileList").append(t_html);
							$('#egovComFileUploader').attr("disabled",true);
						}
						//$('#lbl_code').val(lbl_code);
						$('#file_id').val(file_mastr_sn);
						
					} else {
						alert(data.message);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert("실패");
				}
			});
		
	}
	
var testData =[
{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
}, {
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
}];

var myGridOption = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap',
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
    url: 'selectTest2.do',
    param: {},
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
    editable : true,
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
    dataField : "ID",
    headerText : "ID",
    width : 200
  },{
    dataField : "NAME",
    headerText : "NAME",
    width : 200
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],


  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
    if(me.proxy.autoLoad) {
      console.log('1');
      me.load();
    }

 

    //me.createPagingNavigator(1);
  },
  //AUI 그리드 이벤트 
  binding: function() {
    
  },
  //AUI 그리드 데이터 요청
  load: function(v1, v2) {
    var me = this;
    
    //AUIGrid.showAjaxLoader(me.id);
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
  },
  //사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
  createPagingNavigator: function(goPage) {
    var me = this;
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    this.div.paging.totalPage = Math.ceil(this.div.paging.totalRowCount/this.div.paging.rowCount);
    
    var retStr = "";
    var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * ( me.div.paging.pageButtonCount /*-3*/);
    var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount +1 ;
    prevPage = Math.max(0,prevPage );
    nextPage = Math.min(nextPage, me.div.paging.totalPage);
    if ( goPage == 0 ) { prevPage.stop() }

            //console.log(goPage)
    
    //셀렉트박스
/*
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption.div.paging.currentPage, this.value)'>"
    if(myGridOption.div.paging.rowCount == 20) {
      retStr += "<option value=20 selected=true>rows 20</option>"
    } else {
      retStr += "<option value=20>rows 20</option>"
    }
    if(myGridOption.div.paging.rowCount == 50) {
      retStr += "<option value=50 selected=true>rows 50</option>"
    } else {
      retStr += "<option value=50>rows 50</option>"
    }
    if(myGridOption.div.paging.rowCount == 100) {
      retStr += "<option value=100 selected=true>rows 100</option>"
    } else {
      retStr += "<option value=100>rows 100</option>"
    }
    if(myGridOption.div.paging.rowCount == 300) {
      retStr += "<option value=300 selected=true>rows 300</option>"
    } else {
      retStr += "<option value=300>rows 300</option>"
    }
    if(myGridOption.div.paging.rowCount == 500) {
      retStr += "<option value=500 selected=true>rows 500</option>"
    } else {
      retStr += "<option value=500>rows 500</option>"
    }
    retStr += "</select>"
    
*/

    
	// 처음
	retStr += "<span class='aui-grid-paging-grup'>";
	retStr += "<a href='javascript:myGridOption.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";

	// 이전
	retStr += "<a href='javascript:myGridOption.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";

	for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage); i<=len; i++) {
		if (goPage == i) {
			retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
		} else {
			retStr += "<a href='javascript:myGridOption.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
			retStr += i;
			retStr += "</span></a>";
		}
		
		if (i >= me.div.paging.totalPage) {
			break;
		}

	}

	// 다음
	retStr += "<a href='javascript:myGridOption.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";

	// 마지막
	retStr += "<a href='javascript:myGridOption.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>";
	retStr += "</span>";

    //el식 테스트
    document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
  },
  //페이징 에서 어느 페이지로 갈 것인지 지정
  moveToPage: function(goPage, rowCount) {
    var me = this;
    
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    // 현재 페이지 보관
    me.div.paging.currentPage = goPage ;
    
    // selectBox에서 요청시, 1페이지부터 시작
    if(rowCount) {
      me.div.paging.rowCount = rowCount;
      me.div.paging.currentPage = 1;
      goPage = 1;
    }
    
    me.load(me.div.paging.rowCount, goPage);
  }
};



//행추가, 행삭제 시작

function addRow(rowPos) {
  var item = new Object();
  
  // rowIdField 로 지정한 id 는 그리드가 row 추가 시 자동으로 중복되지 않게 생성합니다.
  // DB 에서 Insert 시 실제 PK 값 결정하십시오.
  
  /*
  item.name = $("#t_name").val();
  item.country = $("#t_country").val();
  item.color = $("#t_color").val();
  item.product = $("#t_product").val();
  item.price = $("#t_price").val();
  item.date = $("#t_date").val();
*/ 

  // parameter
  // item : 삽입하고자 하는 아이템 Object
  // rowPos : rowIndex 인 경우 해당 index 에 삽입, first : 최상단, last : 최하단, selectionUp : 선택된 곳 위, selectionDown : 선택된 곳 아래
  AUIGrid.addRow(myGridOption.id, item, rowPos);
  
   $("#t_name").val("AUI-" + (++cnt));
   $("#t_country").val(countries[cnt % countries.length ]);
}

function removeRow(rowPos) {
  AUIGrid.removeRow(myGridOption.id, rowPos);
}


// 추가, 수정, 삭제 된 아이템들 확인하기
function checkItems() {
  
  // 추가된 행 아이템들(배열)
  var addedRowItems = AUIGrid.getAddedRowItems(myGridOption.id);
   
  // 수정된 행 아이템들(배열)
  var editedRowItems = AUIGrid.getEditedRowColumnItems(myGridOption.id); 
  
  // 삭제된 행 아이템들(배열)
  var removedRowItems = AUIGrid.getRemovedItems(myGridOption.id);
  
  var i, len, name, rowItem;
  var str = "";
  
  if(addedRowItems.length > 0) {
    str += "---추가된 행\r\n";
    for(i=0, len=addedRowItems.length; i<len; i++) {
      rowItem = addedRowItems[i]; // 행아이템
      // 전체 조회
      for(var name in rowItem) {
        str += name + " : " + rowItem[name] + ", "; 
      }
      str += "\r\n";
    }
  }
  
  if(editedRowItems.length > 0) {
    str += "---수정된 행\r\n";
    for(i=0, len=editedRowItems.length; i<len; i++) {
      rowItem = editedRowItems[i]; // 행아이템
      
      // 전체 조회
      for(var name in rowItem) {
        str += name + " : " + rowItem[name] + ", "; 
      }
      str += "\r\n";
    }
  }
  
  if(removedRowItems.length > 0) {
    str += "---삭제된 행\r\n";
    for(i=0, len=removedRowItems.length; i<len; i++) {
      rowItem = removedRowItems[i]; // 행아이템
      // 전체 조회
      for(var name in rowItem) {
        str += name + " : " + rowItem[name] + ", "; 
      }
      str += "\r\n";
    }
  }
  
  // 하단에 정보 출력.
  $("#desc_info").html("추가 개수 : " + addedRowItems.length + ", 수정 개수 : " + editedRowItems.length + ", 삭제 개수 : " + removedRowItems.length); 
  
  
  if(str == "")
    str = "변경 사항 없음";
  
  alert(str);
}






// $(document).ready(function() {
//   myGridOption.createGrid();
// });


// 윈도우 리사이징 이벤트
window.onresize = function() {
 // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
 if (typeof myGridOption.id !== "undefined") {
   AUIGrid.resize(myGridOption.id);
   }
};

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

function Applybtninit(){
	$('#iform').each(function() {
		this.reset();
	});
	
	$('#iform2').each(function() {
		this.reset();
	});
	
	$('label[popup_type=Label]').text('');
	
// 	$('#txtProductCode').val('');
// 	$('#hdProductCode').val('');
	
// 	$('#slsourcetype, #slsource, #slfollow_no').val('');	
// 	$('#slsourcetype, #slsource, #slfollow_no').attr('disabled', true);
	
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
						<li>국내외 이상사례 등록</li>
						<li>이상사례</li>
					</ul>
				</nav>
			</article>
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">
						<!-- 컨텐츠 타이틀 끝-->
						<!-- 상단 그리드 전체메뉴라인 시작-->
						<div class="button_tab_01">
							<ul>
								<li id="tabDemographics" class="port_back tab_menu">DEMOGRAPHICS</li>
								<li id="tabMedicalhistory" class="tab_menu">MEDICAL HISTORY</li>
								<li id="tabDrughistory" class="tab_menu">DRUG HISTORY</li>
								<li id="tabAe" class="tab_menu">AE</li>
								<li id="tabLab" class="tab_menu">LAB</li>
								<li id="tabDrug" class="tab_menu">DRUG</li>
								<li id="tabCasulity" class="tab_menu">CASUALITY</li>
								<li id="tabNarrative" class="tab_menu">NARRATIVE</li>
								<li id="tabAssessment" class="tab_menu">ASSESSMENT</li>
							</ul>
						</div>
				<article class="conTitBtn">
					<table class="tb001">
						<colgroup>
							<col width="8%" />
							<col width="13%" />
							<col width="8%" />
							<col width="11%" />
							<col width="8%" />
							<col width="11%" />
							<col width="8%" />
							<col width="13%" />
							<col width="8%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>PRODUCT</th>
								<td>
									<input type="hidden" id="hdhrmflns_case_code" />
									<input type="hidden" id="hdmafu_no" />
									<input type="hidden" id="hdfollow_no" value="0"/>																		
									<input type="hidden" id="hdsourc_no" />
									<input type="hidden" id="hdparnts_no" />
									<input type="hidden" id="hdreporter_no" />
									<input type="hidden" id="hdtest_rcord_cmmn_memo" />
									<input type="hidden" id="hdtest_rcord_cmmn_memo_kor" />
									<input type="hidden" id="hdtest_rcord_cmmn_memo_eng" />
									<input type="hidden" id="hdrpt_no" />
															 
		                            <input type="text" id="txtProductCode" popup_type="ProductSearch" readonly style="width:80%;">
		                            <input type="hidden" id="hdProductCode"/>
		                            
		                            <button class="oneBtn" type="button"  popup_type="ProductSearch"><img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색"></button>		                                
								</td>
								<th>Source Type</th>
								<td>
									<select id="slsourcetype" style="width:100%;">
										<option value="">===선택하세요===</option>
									</select>
								</td>
								<th>SOURCE</th>
								<td>
									<select id="slsource" style="width:100%;">
										<option value="">===선택하세요===</option>
									</select>
								</td>
								<th>SITE&SUBJECT</th>
								<td>
									<select id="slsitesubject" style="width:100%;">
										<option value="">===선택하세요===</option>
									</select>
								</td>
								<th>FOLLOW NO</th>
								<td>
									<select id="slfollow_no" style="width:100%;">
										<option value="">===선택하세요===</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="10" style="text-align:right;">
									<input type="button" id="btnPopCase" class="btn mgL3" value="유사사례">
									<input type="button" id="btnInit" class="btn mgL3" value="초기화">
									<input type="button" id="btnTransfer" class="btn mgL3" value="전달">									
									<input type="button" id="btnSubjectCopy" class="btn mgL3" value="피험자복제">
									<input type="button" id="btnFollowUp" class="btn mgL3" value="Follow up">
									<input type="button" id="btnSave" class="btn mgL3" value=<spring:message code="button.save" />>
									<input type="button" id="btnDel" class="btn mgL3" value=<spring:message code="button.delete" />>
									<input type="button" id="btnAudit" class="btn mgL3" value="A" title="Audit Trail">
								</td>
							</tr>
						</tbody>
					</table>
				</article>
				
				<ul class="mgT20">
					<form id="iform">
					<input type='hidden' id='detail_sn'/>							
					<input type='hidden' id='file_id'/>							
					<input type='hidden' id='empty_file' value="YES">
					<input type="hidden" id="mode" value="C" />
				    <li class="accordion_02">
				    	<a href="#void" class="close">Report Information</a>
				        <div class="accordion_con_02">


							<table class="tb001">
								<colgroup>
									<col width="16%" />
									<col width="24%" />
									<col width="13%" />
									<col width="20%" />
									<col width="13%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>Sponsor management No.</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtaplcnt_safe_reprt_idntfr" style="width:100%;" readonly>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Identification of the country of the primary</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtidntfc_nation_code" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Identification of the country where the reaction/event occurred</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtoccrrnc_nation_code" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Type of report</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slreprt_ty" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
														<input type="text" id="txtreprt_ty_etc_opinion" style="width:100%;"/>
														<input type="hidden" id="hdreprt_ty_etc_opinion" />
														<label popup_type="Label" id="txtreprt_ty_etc_opinion_eng"></label>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Are additional documents available</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="sladi_doc_at" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Does this case fulfill the local criteria for an expedited report?</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slrpd_stdr_suffcn_at" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>									
									<tr>										
										<th>List of documents held by sender</th>
										<td colspan="5">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtdoc_list" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtdoc_list','txtdoc_list_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hddoc_list" />
											<label popup_type="Label" id="txtdoc_list_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Requlatory authority's case report number</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text"  id="txtregl_nation_case_reprt_no" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtregl_nation_case_reprt_no','txtregl_nation_case_reprt_no_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdregl_nation_case_reprt_no" />
											<label popup_type="Label" id="txtregl_nation_case_reprt_no_eng"></label>
										</td>
										<th>Other sender's case report number</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtdifr_trnsmisman_reprt_no" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtdifr_trnsmisman_reprt_no','txtdifr_trnsmisman_reprt_no_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hddifr_trnsmisman_reprt_no" />
											<label popup_type="Label" id="txtdifr_trnsmisman_reprt_no_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Previous Report Management No. / Title</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtbefore_report_manageno_sj"  style="width:100%;"/>
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"   onclick="EnglishNotation('txtbefore_report_manageno_sj','txtbefore_report_manageno_sj_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdbefore_report_manageno_sj" />
											<label popup_type="Label" id="txtbefore_report_manageno_sj_eng"></label>
										</td>
										<th>Reason of follow up</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<select id="sltracereport_resn" style="width:40%;">
															<option value=''>===selected===</option>
														</select>
														<input type="text" id="txttracereport_resn_etc_opinion" style="width:55%;"/>
														<input type="hidden" id="hdtracereport_resn_etc_opinion" />
														<label popup_type="Label" id="txttracereport_resn_etc_opinion_eng"></label>
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"   onclick="EnglishNotation('txttracereport_resn_etc_opinion','txttracereport_resn_etc_opinion_eng');"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Other sender's case Report No.</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtreferreport_manageno_sj"  style="width:100%;"/>
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtreferreport_manageno_sj','txtreferreport_manageno_sj_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreferreport_manageno_sj" />
											<label popup_type="Label" id="txtreferreport_manageno_sj_eng"></label>
										</td>
										<th>Was the case medically confirmed, if not initially from health professional?</th>
										<td colspan="3"> 
											<table class="in_table">
												<tr>
													<th>
														<select id="slmdcneprfs_cnfirmcase_at" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Report nullificaiton</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slreport_cancl_at" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Reason for nullification</th>
										<td style="padding-top:5px; padding-bottom: 2px;" colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtreport_cancl_resn"  style="width:100%;"/>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"   onclick="EnglishNotation('txtreport_cancl_resn','txtreport_cancl_resn_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdreport_cancl_resn" />
											<label popup_type="Label" id="txtreport_cancl_resn_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Same Cases reported by Agencies</th>
										<td colspan="5">
											<table class="in_table">
												<tr>
													<th style="padding-top:3px; padding-bottom:6px;">
														<table class="in_table">
															<tr>
																<th>
																	<div id="i_samensscase_report_instt"></div>
																	<input type="hidden" id="hdsamensscase_report_instt"/>
																</th>
																<td style="width:250px;vertical-align: top;">
																	<input type="text" id="txtsamensscase_etc_opinion" style="width:100%;"/>
																	<input type="hidden" id="hdsamensscase_etc_opinion" />
																	<label popup_type="Label" id="txtsamensscase_etc_opinion_eng"></label>
																</td>
															</tr>
														</table>
													</th>
													<td style="vertical-align: top;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"   onclick="EnglishNotation('txtsamensscase_etc_opinion','txtsamensscase_etc_opinion_eng');"/>
													</td>
												</tr>
											</table>
											
										</td>
									</tr>
<!-- 									<tr> -->
<!-- 										<th>Literature reference(s)</th> -->
<!-- 										<td colspan="5"> -->
<!-- 											<table class="in_table"> -->
<!-- 												<tr> -->
<!-- 													<th> -->
<!-- 														<input type="text" id="txtrefer_ltrtre" style="width:100%;"> -->
<!-- 													</th> -->
<!-- 													<td> -->
<!-- 														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/> -->
<!-- 														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtrefer_ltrtre','txtrefer_ltrtre_eng');"/> -->
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 											</table> -->
<!-- 											<input type="hidden" id="hdrefer_ltrtre" /> -->
<!-- 											<label popup_type="Label" id="txtrefer_ltrtre_eng"></label> -->
<!-- 										</td> -->
<!-- 									</tr> -->
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
				      <li class="accordion_02">
				    	<a href="#void" class="close">Primary Source Information <button class="oneBtn" type="button"  popup_type="ReportSearch" style="margin:4px 0 0 10px;"><img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색"></button></a> 
				        <div class="accordion_con_02">
							<form id="iform2">

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
										<th>Site<span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id = "txtinstt_nm"style="width:100%;" valireqire="Site" />
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="text" id ="txtinstt_code" style="width:100%;" valireqire="Site No." />
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Address</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtadres" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtadres','txtadres_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdaddrone" />
											<label popup_type="Label" id="txtadres_eng"></label>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtadres_lclty','txtadres_lclty_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdadres_lclty" />
											<label popup_type="Label" id="txtadres_lclty_eng"></label>
										</td>
										<th>Reporter Postcode</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtadres_zip" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<select id="slqualf" style="width:40%;">
															<option value=''>===selected===</option>
														</select>
														<input type="text" id="txtqualf_etc_opinion" style="width:55%;"/>
														<input type="hidden" id="hdqualf_etc_opinion" />
														<label popup_type="Label" id="txtqualf_etc_opinion_eng"></label>
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtqualf_etc_opinion','txtqualf_etc_opinion_eng');"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
<!-- 										<th>Report Type</th> -->
<!-- 										<td> -->
<!-- 											<table class="in_table"> -->
<!-- 												<tr> -->
<!-- 													<th> -->
<!-- 														<select id="slreprt_ty" style="width:100%;"> -->
<!-- 															<option value=''>===selected===</option> -->
<!-- 														</select> -->
<!-- 														<input type="text" id="txtreprt_ty_etc_opinion" style="width:100%;"/> -->
<!-- 														<input type="hidden" id="hdreprt_ty_etc_opinion" /> -->
<!-- 														<label popup_type="Label" id="txtreprt_ty_etc_opinion_eng"></label> -->
<!-- 													</th> -->
<!-- 													<td> -->
<!-- 														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/> -->
<!-- 														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtreprt_ty_etc_opinion','txtreprt_ty_etc_opinion_eng');"/> -->
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 											</table> -->
<!-- 										</td> -->
										<th>Report Type Specify</th>
										<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
							</form>
				            <ul class="mgT20">
				                <li class="accordion_03">
				                	<a heft="#void" class="close"><span>[Q내역]</span></a>
				                    <div class="accordion_con_03 close">

				                        auigrid 영역 

				                    </div>
				                </li>
				            </ul>
				        </div>
				    </li>
				    <li class="accordion_02">
				    	<a href="#void" class="close">Demographics</a>
				        <div class="accordion_con_02">
							<table class="tb001">
								<colgroup>
									<col width="25%" />
									<col width="30%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
<!-- 									<tr> -->
<!-- 										<th>Site No.<span class="must_01"></span></th> -->
<!-- 										<td colspan="3"> -->
<!-- 											<table class="in_table"> -->
<!-- 												<tr> -->
<!-- 													<th> -->
<!-- 														<select id="slinstt_no" style="width:100%;"> -->
<!-- 															<option value=''>===selected===</option> -->
<!-- 														</select> -->
<!-- 													</th> -->
<!-- 													<td style="width: 32px;"> -->
<!-- 														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/> -->
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 											</table> -->
<!-- 										</td> -->
<!-- 									</tr> -->
									<tr>
										<th>Subject No.(If you don't have your own NO in SPONTANEOUS case, it will be generated automatically when saved.)<span class="must_01"></span></th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txttestee_no"  style="width:100%;" valireqire="Subject No." />
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Sponsor Management No.</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtclient_manage_no"  style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									
									<tr>
										<th>Initial<span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtinitial_flag"  style="width:100%;" valireqire="Initial" />
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Sex</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slsexdstn" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Pregnancy</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<select id="slpregnan_at" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Pregnancy Duration</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtpregnan_pd" style="width:50%;">
														<select id="slpregnan_pd_se" style="width:49.3%; float: right;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Last menstrual period date</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtlast_pysiclg_dtes" style="width: 130px;" data-datatype="DATE" data-yyuk="Y" data-mmuk="Y" data-dduk="Y" >
														</div>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Height</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtheight" style="width:88%;"> cm
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Weight</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtbdwgh" style="width:88%;"> kg
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Informed Consent</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtagre_dtes" style="width: 130px;" data-datatype="DATE" data-yyuk="Y" data-mmuk="Y" data-dduk="Y" >
														</div>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Date of Enrollment</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtregist_dtes" style="width: 130px;" data-datatype="DATE" data-yyuk="Y" data-mmuk="Y" data-dduk="Y" >
														</div>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>In/Out</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slin_out_se" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Other specify</th>
										<td style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtin_out_etc_memo" rows="2" style="width: 100%;"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"   onclick="EnglishNotation('txtin_out_etc_memo','txtin_out_etc_memo_eng');"/>
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdin_out_etc_memo" />
											<label popup_type="Label" id="txtin_out_etc_memo_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Birth Date</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtlifyeamd"  style="width: 130px;" data-datatype="DATE" data-yyuk="Y" data-mmuk="Y" data-dduk="Y" >
														</div>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Age</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtage" style="width:83%;"> Year
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Age Groups</th>
										<td >
											<table class="in_table">
												<tr>
													<th>
														<select id="slage_grup" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
										<th>Other Age Information</th>
										<td >
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtdifr_age_info" style="width:50%;">
														<select id="sldifr_age_info_code" style="width:49.3%; float: right;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
				        </div>
				    </li>
<!-- 				    <li class="accordion_02"> -->
<!-- 				    	<a href="#void" class="close">Age Information</a> -->
<!-- 				        <div class="accordion_con_02"> -->
<!-- 							<table class="tb001"> -->
<%-- 								<colgroup> --%>
<%-- 									<col width="20%" /> --%>
<%-- 									<col width="30%" /> --%>
<%-- 									<col width="20%" /> --%>
<%-- 									<col width="" /> --%>
<%-- 								</colgroup> --%>
<!-- 								<tbody> -->
<!-- 									<tr> -->
<!-- 										<th>Birth Date</th> -->
<!-- 										<td> -->
<!-- 											<table class="in_table"> -->
<!-- 												<tr> -->
<!-- 													<th> -->
<!-- 														<div class="dateBox"> -->
<!-- 															<input type="text" id="txtlifyeamd" style="width:118px;"> -->
<!-- 														</div> -->
<!-- 													</th> -->
<!-- 													<td style="width: 32px;"> -->
<!-- 														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/> -->
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 											</table> -->
<!-- 										</td> -->
<!-- 										<th>Age</th> -->
<!-- 										<td> -->
<!-- 											<table class="in_table"> -->
<!-- 												<tr> -->
<!-- 													<th> -->
<!-- 														<input type="text" id="txtage" style="width:83%;"> Year -->
<!-- 													</th> -->
<!-- 													<td style="width: 32px;"> -->
<!-- 														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/> -->
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 											</table> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<th>Age Groups</th> -->
<!-- 										<td colspan="3"> -->
<!-- 											<table class="in_table"> -->
<!-- 												<tr> -->
<!-- 													<th> -->
<!-- 														<select id="slage_grup" style="width:100%;"> -->
<!-- 															<option value=''>===selected===</option> -->
<!-- 														</select> -->
<!-- 													</th> -->
<!-- 													<td style="width: 32px;"> -->
<!-- 														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/> -->
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 											</table> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<th>Other Age Information</th> -->
<!-- 										<td colspan="3"> -->
<!-- 											<table class="in_table"> -->
<!-- 												<tr> -->
<!-- 													<th> -->
<!-- 														<input type="text" id="txtdifr_age_info" style="width:50%;"> -->
<!-- 														<select id="sldifr_age_info_code" style="width:49.3%; float: right;"> -->
<!-- 															<option value=''>===selected===</option> -->
<!-- 														</select> -->
<!-- 													</th> -->
<!-- 													<td style="width: 32px;"> -->
<!-- 														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/> -->
<!-- 													</td> -->
<!-- 												</tr> -->
<!-- 											</table> -->
<!-- 										</td> -->
<!-- 									</tr> -->
<!-- 								</tbody> -->
<!-- 							</table> -->

<!-- 				            <ul class="mgT20"> -->
<!-- 				                <li class="accordion_03"> -->
<!-- 				                	<a heft="#void" class="close"><span>[Q내역]</span></a> -->
<!-- 				                    <div class="accordion_con_03 close"> -->

<!-- 				                        auigrid 영역  -->

<!-- 				                    </div> -->
<!-- 				                </li> -->
<!-- 				            </ul> -->
<!-- 				        </div> -->
<!-- 				    </li> -->
				    <li class="accordion_02">
				    	<a href="#void" class="close">Parent Information (For a parent-child/fetus report)</a>
				        <div class="accordion_con_02">

							<table class="tb001">
								<colgroup>
									<col width="20%" />
									<col width="30%" />
									<col width="20%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>Parent Name</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtparnts_nm"  style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtparnts_nm','txtparnts_nm_eng');"/>
													</td>
												</tr>
											</table>											
											<input type="hidden" id="hdparnts_nm" />
											<label popup_type="Label" id="txtparnts_nm_eng"></label>	
										</td>
										<th>Gestational Age</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtpregnan_weekco"  style="width:78%;"> Weeks
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Sex of Parent</th>
										<td>
											<select id="slparnts_sexdstn" style="width:100%;">
												<option value=''>===selected===</option>
											</select>
										</td>
										<th>Age of Parent</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtparnts_age"  style="width:78%;"> Years
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
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
				        </div>
				    </li>
				    </form>
				    <li class="accordion_02">
				    	<a href="#void" class="close">Source File</a>
				        <div class="accordion_con_02">


							<table class="tb001">
								<colgroup>
									<col width="16%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>Source File Upload</th>
										<td>
											<form id="filetForm" action="<c:url value='/sdb/b01/insertDmFileMstr.do'/>" method="post" enctype="multipart/form-data">
												<table class="in_table">
													<tr>
														<th>
															<input type="file" name="file_1"  id="egovComFileUploader" title="첨부파일"  style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q"/>
														</td>
													</tr>
												</table>
												<div id="egovComFileList"></div>

											</form>
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
				        </div>
				    </li>
				    
				  
				    
				</ul>
				</div>				
            </section>
            <!-- 컨텐츠박스 끝-->
		</div>
	</section>
	
</div>
</body>
</html>