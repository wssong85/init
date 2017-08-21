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
</style>

<script type="text/javascript">
var HRMFLNS_CASE_CODE = "${HRMFLNS_CASE_CODE}";
var PRDUCT_CODE = "${PRDUCT_CODE}";

	$(function() {
		setAccodian();
		btnInit();
 		setInit();
 		init();
		
	});
	function btnInit() {
		//$('#txtSource_eng, #txtOtherInfo1_eng, #txtOtherInfo2_eng, #txtOtherInfo3_eng, #btnE')
		//$('.sdbLal, #btnE')
		$('label[popup_type=Label], input[popup_type=E]').click(
			function() {
				var multi = new Array;
				multi = $(this).siblings();
				var idKorean;
				var idEng;
				var txtCode;
				var txtKorean;
				var txtEng;
				// Label 클릭시 Selector
				if (multi.context) {
					txtEng = multi.context.textContent;
						idEng = multi.context.id;	
				}
				//textarea, input, label
				for (i = 0; i < multi.length; i++) {
					if (multi[i].tagName == "TEXTAREA"
							|| (multi[i].tagName == "INPUT" && multi[i].type == "text")) {
						txtKorean = $.trim(multi[i].value);
						idKorean = $.trim($.trim(multi[i].id));
					}else if (multi[i].tagName == "LABEL"){
							txtEng = $.trim(multi[i].textContent);
							idEng = $.trim($.trim(multi[i].id));									
					}
				}
				
				var param = {
					ID_KOREAN : idKorean,
					ID_ENG : idEng,
					KOREAN : txtKorean,
					ENG : txtEng
				};

				mkLayerPopupOpen("/sdb/c02/popupSDBC0218.do", param);
				//return false;
			});

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
		
		
		$('#tabDemographics').click(function() {
			window.location.href = "/sdb/c02/SDBC0201.do";
		});
		$('#tabMedicalhistory').click(function() {
			window.location.href = "/sdb/c02/SDBC0202.do";
		});
		$('#tabDrughistory').click(function() {
			window.location.href = "/sdb/c02/SDBC0203.do";
		});
		$('#tabAe').click(function() {
			window.location.href = "/sdb/c02/SDBC0204.do";
		});
		$('#tabLab').click(function() {
			window.location.href = "/sdb/c02/SDBC0205.do";
		});
		$('#tabDrug').click(function() {
			window.location.href = "/sdb/c02/SDBC0206.do";
		});
		$('#tabCasulity').click(function() {
			window.location.href = "/sdb/c02/SDBC0207.do";
		});
		$('#tabNarrative').click(function() {
			window.location.href = "/sdb/c02/SDBC0208.do";
		});
		$('#tabAssessment').click(function() {
			window.location.href = "/sdb/c02/SDBC0209.do";
		});

		$('#btnCase').click(function() {
			window.location.href = "/sdb/c02/SDBC0201.do";
		});

		$('#btnInit').click(function() {
			var check_code = $("#txtEtcno").val();
			$('#iform').each(function() {
				this.reset();
			});
			
			$('label[popup_type=Label]').text('');
			$("#txtEtcno").val(check_code);
		});

		$('#btnSave').click(function() {

			if (!mkValidation()) {
				return;
			}	
			if (!confirm('저장하시겠습니까?')) {
				return;
			}
			if ( $.trim($("#mode").val()) == 'U') {
				var param = {
						TRGET_CODE 	: $("#txtEtcno").val(),
						TRGETNM 	: "ETC",
						TRGET_MODE  : "U",
						UPDATE_ID	: '${loginMap.USER_ID}'						
					};
				//alert(param);
	//			return;
				mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
			}else{
				var params = {
					CURD 							: $.trim($("#mode").val()),
					PRDUCT_CODE						: $.trim($("#hdProductCode").val()),
					SOURCE_TYPE						: $.trim($("#slsourcetype").val()),
					SOURCE							: $.trim($("#slsource").val()),
					HRMFLNS_CASE_CODE				: HRMFLNS_CASE_CODE,
					//MANUFATORER
					APLCNT_SAFE_REPRT_IDNTFR		: $.trim($("#txtaplcnt_safe_reprt_idntfr").val()),
					MAIN_NATION_IDNTFC				: $.trim($("#txtmain_nation_idntfc").val()),
					RESPNS_OCCRRNC_NATION_IDNTFC	: $.trim($("#txtrespns_occrrnc_nation_idntfc").val()),
					REPRT_KND						: $.trim($("#slreprt_knd").val()),
					ADIT_PAPERS_AT					: $.trim($("#sladit_papers_at").val()),
					APLCNT_HOLD_DOC_LIST			: $.trim($("#hdaplcnt_hold_doc_list").val()),
					APLCNT_HOLD_DOC_LIST_KOR		: $.trim($("#txtaplcnt_hold_doc_list").val()),
					APLCNT_HOLD_DOC_LIST_ENG		: $.trim($("#txtaplcnt_hold_doc_list_eng").val()),
					RPD_REPRT_AT					: $.trim($("#slrpd_reprt_at").val()),
					REGL_INSTT_REPRT_NO				: $.trim($("#hdregl_instt_reprt_no").val()),
					REGL_INSTT_REPRT_NO_KOR			: $.trim($("#txtregl_instt_reprt_no").val()),
					REGL_INSTT_REPRT_NO_ENG			: $.trim($("#txtregl_instt_reprt_no_eng").val()),
					ETC_REPRT_NO					: $.trim($("#hdetc_reprt_no").val()),
					ETC_REPRT_NO_KOR				: $.trim($("#txtetc_reprt_no").val()),
					ETC_REPRT_NO_ENG				: $.trim($("#txtetc_reprt_no_eng").val()),
					REFER_LTRTRE					: $.trim($("#txtrefer_ltrtre").val()),
					REFER_LTRTRE_KOR				: $.trim($("#txtrefer_ltrtre").val()),
					REFER_LTRTRE_ENG				: $.trim($("#txtrefer_ltrtre").val()),
					//DEMOGRAPHICS
					INSTT_NO						: $.trim($("#slinstt_no").val()),
					TESTEE_NO						: $.trim($("#txttestee_no").val()),
					CLIENT_MANAGE_NO				: $.trim($("#txtclient_manage_no").val()),
					ETC_MANAGE_NO					: $.trim($("#txtetc_manage_no").val()),
					INITIAL_FLAG					: $.trim($("#txtinitial_flag").val()),
					SEXDSTN				            : $.trim($("#slsexdstn").val()),
					PREGNAN_AT			            : $.trim($("#slpregnan_at").val()),
					PREGNAN_PD_SE		            : $.trim($("#slpregnan_pd_se").val()),
					PREGNAN_PD						: $.trim($("#txtpregnan_pd").val()),
					HEIGHT				            : $.trim($("#txtheight").val()),
					BDWGH				            : $.trim($("#txtbdwgh").val()),
					AGRE_DTE			            : $.trim($("#txtagre_dte").val()),
					REGIST_DTE						: $.trim($("#txtregist_dte").val()),
					IN_OUT_SE			            : $.trim($("#slin_out_se").val()),
					IN_OUT_ETC_MEMO		            : $.trim($("#hdin_out_etc_memo").val()),
					IN_OUT_ETC_MEMO_KOR	            : $.trim($("#txtin_out_etc_memo").val()),
					IN_OUT_ETC_MEMO_ENG	            : $.trim($("#txtin_out_etc_memo_eng").val()),
					LIFYEAMD			            : $.trim($("#txtlifyeamd").val()),
					AGE								: $.trim($("#txtage	").val()),
					AGE_GRUP			            : $.trim($("#txtage_grup").val()),
					DIFR_AGE_INFO_CODE	            : $.trim($("#txtdifr_age_info_code").val()),
					DIFR_AGE_INFO		            : $.trim($("#txtdifr_age_info").val()),
					PREGNAN_WEEKCO					: $.trim($("#txtpregnan_weekco").val()),
					FILE_ID	                        : $.trim($("#txtfile_id").val()),
					//PARENT
					PARNTS_NM 		   				: $.trim($("#txtparnts_nm ").val()),
					PREGNAN_WEEKCO					: $.trim($("#txtpregnan_weekco").val()),
					PARNTS_AG						: $.trim($("#txtparnts_ag").val()),
					PARNTS_SEXDSTN					: $.trim($("#slparnts_sexdstn").val()),
					//REPORTER
					NATION_CODE						: $.trim($("#txtnation_code").val()),
					ADDRONE							: $.trim($("#hdaddrone").val()),
					ADDRONE_KOR						: $.trim($("#txtaddrone").val()),
					ADDRONE_ENG						: $.trim($("#txtaddrone_eng").val()),
					ADRES_DSTNC						: $.trim($("#hdadres_dstnc").val()),
					ADRES_DSTNC_KOR					: $.trim($("#txtadres_dstnc").val()),
					ADRES_DSTNC_ENG					: $.trim($("#txtadres_dstnc_eng").val()),
					ADRES_CTY						: $.trim($("#hdadres_cty").val()),
					ADRES_CTY_KOR					: $.trim($("#txtadres_cty").val()),
					ADRES_CTY_ENG					: $.trim($("#txtadres_cty_eng").val()),
					ADRES_LCLTY						: $.trim($("#hdadres_lclty").val()),
					ADRES_LCLTY_KOR					: $.trim($("#txtadres_lclty").val()),
					ADRES_LCLTY_ENG					: $.trim($("#txtadres_lclty_eng").val()),
					ADRES_ZIP	                    : $.trim($("#txtadres_zip").val()),
					REPORTR                         : $.trim($("#hdreportr").val()),
					REPORTR_KOR                     : $.trim($("#txtreportr").val()),
					REPORTR_ENG                     : $.trim($("#txtreportr_eng").val()),
					REPORTR_APPN_NM                 : $.trim($("#hdreportr_appn_nm").val()),
					REPORTR_APPN_NM_KOR             : $.trim($("#txtreportr_appn_nm").val()),
					REPORTR_APPN_NM_ENG             : $.trim($("#txtreportr_appn_nm_eng").val()),
					REPORTR_MIDDLE_NM				: $.trim($("#hdreportr_middle_nm").val()),
					REPORTR_MIDDLE_NM_KOR			: $.trim($("#txtreportr_middle_nm").val()),
					REPORTR_MIDDLE_NM_ENG			: $.trim($("#txtreportr_middle_nm_eng").val()),
					REPORTR_FAMILY_NM	            : $.trim($("#hdreportr_family_nm").val()),
					REPORTR_FAMILY_NM_KOR           : $.trim($("#txtreportr_family_nm").val()),
					REPORTR_FAMILY_NM_ENG           : $.trim($("#txtreportr_family_nm_eng").val()),
					REPORTR_DEPT                    : $.trim($("#hdreportr_dept").val()),
					REPORTR_DEPT_KOR                : $.trim($("#txtreportr_dept").val()),
					REPORTR_DEPT_ENG                : $.trim($("#txtreportr_dept_eng").val()),
					QUALF                           : $.trim($("#slqualf").val()),
					REPRT_TY						: $.trim($("#slreprt_ty").val()),
					REPRT_TY_DETAIL                 : $.trim($("#hdreprt_ty_detail").val()),
					REPRT_TY_DETAIL_KOR             : $.trim($("#txtreprt_ty_detail").val()),
					REPRT_TY_DETAIL_ENG             : $.trim($("#txtreprt_ty_detail_eng").val()),
					CLASS                           : $.trim($("#hdclass").val()),
					CLASS_KOR                       : $.trim($("#txtclass").val()),
					CLASS_ENG                       : $.trim($("#txtclass_eng").val()),
					MAJOR                           : $.trim($("#hdmajor").val()),
					MAJOR_KOR                       : $.trim($("#txtmajor").val()),
					MAJOR_ENG                        : $.trim($("#txtmajor_eng").val()),
					EMAIL							: $.trim($("#txtemail").val()),
					TELNO                           : $.trim($("#txttelno").val()),
					FAX	                            : $.trim($("#txtfax").val()),
					
					UPDATE_ID 			: '${loginMap.USER_ID}'
				};
				
// 				alert(params);
// 				return;
				
				$.ajax({
					url : '/sdb/c02/insertDemographics.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							alert('아싸ㅣ성공!');
							//window.location.href= "/sdb/c02/SDBC0201.do";
						} else {
							alert(data.errmsg);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
			}
		});

		$('#btnDel').click(function() {
			if ($('#mode').val() == 'U') {
				if (!confirm('삭제하시겠습니까?')) {
					return;
				}
				var param = {
						TRGET_CODE 	: $("#txtEtcno").val(),
						TRGETNM 	: "ETC",
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
			$('#slsourcetype').val("");
			$('#slsource option').remove();
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
				alert(params2);
				$.ajax({
					url : '/sdb/c02/selectSource.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params2),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							
							$('#slsource option').remove();
							for(i=0; i< data.result.length; i++){
								var t_option = "<option value='"+ data.result[i].SOURCE_CODE +"'>"+ data.result[i].SOURCE_CODE +"</option>";
								$('#slsource').append(t_option);	
							}
							
							//window.location.href= "/sdb/c01/SDBC0108.do";
						} else {
							alert(data.errmsg);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
		});
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
			$("#slrpd_reprt_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			$("#slpregnan_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
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
		
		<c:forEach var="result" items="${printType11}" varStatus="status">
			$("#slreprt_ty").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
		
		<c:forEach var="result" items="${printType07}" varStatus="status">
			$("#slsexdstn").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>
	
		mkSetDatePickerYYMMDD("#txtagre_dte");
		mkSetDatePickerYYMMDD("#txtregist_dte");
		mkSetDatePickerYYMMDD("#txtlifyeamd");
// 		$("#txthrmflns_case_dc").attr("maxlength", 5000);
// 		$("#txtreportr_opinion").attr("maxlength", 5000);
// 		$("#txtaplcnt_opinion").attr("maxlength", 5000);
// 		$("#txtdifr_info").attr("maxlength", 5000);
// 		$("#txtrsrch_nm").attr("maxlength", 100);
// 		$("#txtspon_rsrch_no").attr("maxlength", 30);		
		
		$("input[popup_type=Q]").attr("title", "Query");
		$("input[popup_type=E]").attr("title", "English Notation");
		
	}
	
	function init() {
		if (HRMFLNS_CASE_CODE != "") {
			$('#mode').val('U');
		} else {
			$('#mode').val('C');
		}
// 		$("#txthrmflns_case_code").val(NEW_LTRTRE_NO);
// 		$('#txtPblcate_dte').val('');
		
		makeFileAttachment();
		
		var params = {
				CASE_DC_SN : 1
			};
			$.ajax({
				type : "post",
				url : "/sdb/c02/selectDemographics.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var txthrmflns_case_dc 			= (isNull(data.result.KOR)) ? '': data.result.KOR;
						//alert(txthrmflns_case_dc);
						$('#txtrefer_ltrtre').val(txthrmflns_case_dc);


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
				$(".accordion_con_02").css({"display":"none"});
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
				var formData = new FormData();
				var formTag = $('#filetForm').children();
				
				for(var i = 0; i < formTag.length; i++) {
					formData.append(formTag[i].name, formTag[i].value);
					
					if(formTag[i].type == 'file') {
						formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
					}
				}			
				
				$.ajax({
					url : '/sdb/b01/insertDmFileMstr.do',
					data : formData,
					processData : false,
					contentType : false,
					type : 'POST',
					success : function(data) {
						saveForm($("#mode").val(), data.result);
					}
				});
			}
		}
		else if(p_mode=='D'){
			if ($('#mode').val() == 'U') {
				//$('#mode').val('D');
				var params = {
					CURD : 'D',
					LTRTRE_NO : $.trim($("#txtLtrtre_no").val())
				};
				$.ajax({
					type : "POST",
					url : "/sdb/c01/insertLiteratureInfo.do",
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							window.location.href= "/sdb/c01/SDBC0106.do";
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
		var params = {
				CURD 				: $.trim($("#mode").val()),
				LTRTRE_NO 			: $.trim($("#txtLtrtre_no").val()),
				PRDUCT_CODE 		: $.trim($("#hdProductCode").val()),
				PBLCATE_DTE 		: $.trim($("#txtPblcate_dte").val()),
				LTRTRE_FILE 		: $.trim(file_id),
				LTRTRE_SJ 			: $.trim($("#hdLtrtre_sj").val()),
				LTRTRE_SJ_KOR 		: $.trim($("#txtLtrtre_sj").val()),
				LTRTRE_SJ_ENG 		: $.trim($("#txtLtrtre_sj_eng").text()),
				JRNL_INFO 			: $.trim($("#hdJrnl_info").val()),
				JRNL_INFO_KOR 		: $.trim($("#txtJrnl_info").val()),
				JRNL_INFO_ENG 		: $.trim($("#txtJrnl_info_eng").text()),
				AUTHR 				: $.trim($("#hdAuthr").val()),
				AUTHR_KOR 			: $.trim($("#txtAuthr").val()),
				AUTHR_ENG 			: $.trim($("#txtAuthr_eng").text()),
				ETC_INFO_ONE 		: $.trim($("#hdOtherInfo1").val()),
				ETC_INFO_ONE_KOR 	: $.trim($("#txtOtherInfo1").val()),
				ETC_INFO_ONE_ENG 	: $.trim($("#txtOtherInfo1_eng").text()),
				ETC_INFO_TWO 		: $.trim($("#hdOtherInfo2").val()),
				ETC_INFO_TWO_KOR 	: $.trim($("#txtOtherInfo2").val()),
				ETC_INFO_TWO_ENG 	: $.trim($("#txtOtherInfo2_eng").text()),
				ETC_INFO_THREE 		: $.trim($("#hdOtherInfo3").val()),
				ETC_INFO_THREE_KOR 	: $.trim($("#txtOtherInfo3").val()),
				ETC_INFO_THREE_ENG 	: $.trim($("#txtOtherInfo3_eng").text()),
				UPDATE_ID 			: '${loginMap.USER_ID}'
			};
			
			$.ajax({
				url : '/sdb/c01/insertLiteratureInfo.do',
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						//alert("성공");
						window.location.href= "/sdb/c01/SDBC0106.do";
						
					} else {
						alert(data.errmsg);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
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






$(document).ready(function() {
  myGridOption.createGrid();
});


// 윈도우 리사이징 이벤트
window.onresize = function() {
 // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
 if (typeof myGridOption.id !== "undefined") {
   AUIGrid.resize(myGridOption.id);
   }
};

</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<form id="iform">
	<input type='hidden' id='detail_sn'/>							
	<input type='hidden' id='file_id'/>							
	<input type='hidden' id='empty_file' value="YES">
	<input type="hidden" id="mode" value="C" />
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
							<col width="13%" />
							<col width="20%" />
							<col width="13%" />
							<col width="20%" />
							<col width="13%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>PRODUCT</th>
								<td>									 
		                            <input type="text" id="txtProductCode" popup_type="ProductSearch" readonly style="width:80%;">
		                            <input type="hidden" id="hdProductCode"/>
		                             <button class="oneBtn" type="sumit"  popup_type="ProductSearch"><img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색"></button>		                                
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
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="6" style="text-align:right;">
									<input type="button" id="btnPopCase" class="btn mgL3" value="유사사례">
									<input type="button" id="btnInit" class="btn mgL3" value="초기화">									
									<input type="button" id="btnSubjectCopy" class="btn mgL3" value="피험자복제">
									<input type="button" id="btnFollowUp" class="btn mgL3" value="Follow up">
									<input type="button" id="btnSave" class="btn mgL3" value="저장">
									<input type="button" id="btnDel" class="btn mgL3" value="삭제">
									<input type="button" id="btnAudit" class="btn mgL3" value="A" title="Audit Trail">
								</td>
							</tr>
						</tbody>
					</table>
				</article>


				<ul class="mgT20">
				    <li class="accordion_02">
				    	<a href="#void" class="close">MANUFACTURER</a>
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
										<th>Sender's(Case) Safety Report Unique Identifier</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtaplcnt_safe_reprt_idntfr" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Identification of the country of the primary</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtmain_nation_idntfc" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Identification of the country where the reaction/event occurred</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtrespns_occrrnc_nation_idntfc" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Type of report</th>
										<td colspan="5">
											<select id="slreprt_knd" style="width:100%;">
												<option value=''>===selected===</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>Are additional documents available</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="sladit_papers_at" style="width:100%;">
															<option value=''>===selected===</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>List of documents held by sender</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtaplcnt_hold_doc_list" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdaplcnt_hold_doc_list" />
											<label popup_type="Label" id="txtaplcnt_hold_doc_list_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Does this case fulfull the local criteria for an expedited report?</th>
										<td colspan="5">
											<select id="slrpd_reprt_at" style="width:100%;">
												<option value=''>===selected===</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>Requlatory authority's case report number</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text"  id="txtregl_instt_reprt_no" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdregl_instt_reprt_no" />
											<label popup_type="Label" id="txtregl_instt_reprt_no_eng"></label>
										</td>
										<th>Other sender's case report number</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtetc_reprt_no" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdetc_reprt_no" />
											<label popup_type="Label" id="txtetc_reprt_no_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Literature reference(s)</th>
										<td colspan="5">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtrefer_ltrtre" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdrefer_ltrtre" />
											<label popup_type="Label" id="txtrefer_ltrtre_eng"></label>
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
									<tr>
										<th>Site No.<span class="must_01"></span></th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<select id="slinstt_no" style="width:100%;">
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
										<th>Subject No.(If you don't have your own NO in SPONTANEOUS case, it will be generated automatically when saved.)<span class="must_01"></span></th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txttestee_no"  style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="text" id="txtinitial_flag"  style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="text" id="last_pysiclg_dte" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
															<input type="text" id="txtagre_dte" style="width:118px;">
														</div>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
															<input type="text" id="txtregist_dte" style="width:118px;">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Other specify</th>
										<td style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtContent" id="txtin_out_etc_memo" rows="2" style="width: 100%;"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdin_out_etc_memo" />
											<label popup_type="Label" id="txtin_out_etc_memo_eng"></label>
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
				    <li class="accordion_02">
				    	<a href="#void" class="close">Age Information</a>
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
										<th>Birth Date</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtlifyeamd" style="width:118px;">
														</div>
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>Age Groups</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<select id="slage_grup" style="width:100%;">
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
										<th>Other Age Information</th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtdifr_age_info" style="width:50%;">
														<select id="sldifr_age_info_code" style="width:49.3%; float: right;">
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

				                        auigrid 영역 

				                    </div>
				                </li>
				            </ul>
				        </div>
				    </li>
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
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Gestational Age</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtpregnan_weekco"  style="width:78%;"> Weeks
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
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
														<input type="text" id="txtparnts_ag"  style="width:78%;"> Years
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
				        </div>
				    </li>
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
											<form id="filetForm" action="<c:url value='/sdb/b01/insertDmFileMstr.d'/>" method="post" enctype="multipart/form-data">
												<table class="in_table">
													<tr>
														<th>
															<input type="file" name="file_1"  id="egovComFileUploader" title="첨부파일"  style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
												<div id="egovComFileList"></div>

<!-- 											<input type="button" id="" class="btn mgL3" value="다운로드"> -->
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
				    <li class="accordion_02">
				    	<a href="#void" class="close">Reporter</a>
				        <div class="accordion_con_02">


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
														<input type="text" style="width:100%;">
													</th>
													<td style="width: 32px;">
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Site No.<span class="must_01"></span></th>
										<td colspan="3">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" style="width:100%;">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdadres_cty" />
											<label popup_type="Label" id="txtadres_cty_eng"></label>
										</td>
									</tr>
									<tr>
										<th>peporter state or province</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtadres_lclty" style="width:100%;">
													</th>
													<td>
														<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
														<input type="button" class="oneBtn" popup_type="E" value="E">
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
				        </div>
				    </li>
				</ul>
						
				</div>
            </section>
            <!-- 컨텐츠박스 끝-->
		</div>
	</section>
	</form>
</div>
</body>
</html>