<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title>DRUG</title>
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
	init();
	setInit();
	
	grDrug_List.createGrid();
});


function setInit(){
	<c:forEach var="result" items="${printType73}" varStatus="status">
		$("#sldrfstfrole_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType12}" varStatus="status">
		$("#slcntnc_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>

	<c:forEach var="result" items="${printType13}" varStatus="status">
		$("#slintrvl_unit").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType65}" varStatus="status">
		$("#slabove_respns_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>

	<c:forEach var="result" items="${printType15}" varStatus="status">
		$("#sldrfstf_wthdraw___cpcty_dcrs_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType16}" varStatus="status">
		$("#slrecr_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	
// 	mkSetDatePickerYYMMDD("#txtbegin_dte");
// 	mkSetDatePickerYYMMDD("#txtend_dte");
	
	$('#Druginput').hide();
}

function btnInit(){
	
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
		grDrug_List.load();
	});
	
	$('#btnAdd').click(function(){
		$('#iform').each(function() {
			this.reset();
		});
		$('label[popup_type=Label]').text('');
		$('#Druginput').show();	
		$('#mode').val("C");
	});
	
	$('#btnSave').click(function(){	
				
		if($('#Druginput').css('display')=='none'){
			return;
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
		var data = AUIGrid.getGridData(grDrug_List.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grDrug_List.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grDrug_List.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
}

function init(){
	$("#hdhrmflns_case_code").val(HRMFLNS_CASE_CODE);
	$("#hdprduct_code").val(PRDUCT_CODE);
	$("#hdfollow_no").val(FOLLOW_NO);
	$("#hdmafu_no").val(MAFU_NO);
	$("#mode").val('C');
}

function updelform(){
	var param = {
			TRGET_CODE 	: $("#hdmafu_no").val(), 
			TRGETNM 	: "DrugH",
			TRGET_MODE  : $('#mode').val(),
			UPDATE_ID	: '${loginMap.USER_ID}'						
		};
	mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
}


function saveform(){
	var params = {
			CURD 						: $.trim($("#mode").val()),
			MEDCIN_INFO_NO				: $.trim($("#hdmedcin_info_no").val()),
			HRMFLNS_CASE_CODE			: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE					: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO					: $.trim($("#hdfollow_no").val()),			
			HRMFLNS_CASE_CODE			: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE					: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO					: $.trim($("#hdfollow_no").val()),
			DRFSTFROLE_SE				: $.trim($("#sldrfstfrole_se").val()),
			MEDCIN_RECOED_NM			: $.trim($("#hdmedcin_recoed_nm").val()),
			MEDCIN_RECOED_NM_KOR		: $.trim($("#txtmedcin_recoed_nm").val()),
			MEDCIN_RECOED_NM_ENG		: $.trim($("#txtmedcin_recoed_nm_eng").text()),
			MEDCIN_NM					: $.trim($("#hdmedcin_nm").val()),
			MEDCIN_NM_KOR				: $.trim($("#txtmedcin_nm").val()),
			MEDCIN_NM_ENG				: $.trim($("#txtmedcin_nm_eng").text()),
			MFDS_BRAND_CODE				: $.trim($("#txtmfds_brand_code").val()),
			MFDS_GNRL_CODE				: $.trim($("#txtmfds_gnrl_code").val()),
			UNCONFM_MEDCINNM			: $.trim($("#txtunconfm_medcinnm").val()),
			BEGIN_DTES					: $.trim($("#txtbegin_dtes").val()),
			CNTNC_AT					: $.trim($("#slcntnc_at").val()),
			END_DTES					: $.trim($("#txtend_dtes").val()),
			MDCTN_PD					: $.trim($("#txtmdctn_pd").val()),
			RSTRCT_FORM					: $.trim($("#hdrstrct_form").val()),
			RSTRCT_FORM_KOR				: $.trim($("#txtrstrct_form").val()),
			RSTRCT_FORM_ENG				: $.trim($("#txtrstrct_form_eng").text()),
			COURS						: $.trim($("#hdcours").val()),
			COURS_KOR					: $.trim($("#txtcours").val()),
			COURS_ENG					: $.trim($("#txtcours_eng").text()),
			BATCH_LT_NO					: $.trim($("#txtbatch_lt_no").val()),
			FDQNT						: $.trim($("#hdfdqnt").val()),
			FDQNT_KOR					: $.trim($("#txtfdqnt").val()),
			FDQNT_ENG					: $.trim($("#txtfdqnt_eng").text()),
			UNIT						: $.trim($("#hdunit").val()),
			UNIT_KOR					: $.trim($("#txtunit").val()),
			UNIT_ENG					: $.trim($("#txtunit_eng").text()),
			NCOUNT						: $.trim($("#txtncount").val()),
			INTRVL						: $.trim($("#txtintrvl").val()),
			INTRVL_UNIT					: $.trim($("#slintrvl_unit").val()),
			DIFR_USAGE_USER_INFO		: $.trim($("#hddifr_usage_user_info").val()),
			DIFR_USAGE_USER_INFO_KOR	: $.trim($("#txtdifr_usage_user_info").val()),
			DIFR_USAGE_USER_INFO_ENG	: $.trim($("#txtdifr_usage_user_info_eng").text()),
			SGN_MEMO					: $.trim($("#hdsgn_memo").val()),
			SGN_MEMO_KOR				: $.trim($("#txtsgn_memo").val()),
			SGN_MEMO_ENG				: $.trim($("#txtsgn_memo_eng").text()),
			ABOVE_RESPNS_SE				: $.trim($("#slabove_respns_se").val()),
			DRFSTF_WTHDRAW___CPCTY_DCRS_SE	: $.trim($("#sldrfstf_wthdraw___cpcty_dcrs_se").val()),
			RECR_SE						: $.trim($("#slrecr_se").val()),
			DIFR_INFO					: $.trim($("#hddifr_info").val()),
			DIFR_INFO_KOR				: $.trim($("#txtdifr_info").val()),
			DIFR_INFO_ENG				: $.trim($("#txtdifr_info_eng").text()),
			ATC_AT						: $.trim($("#txtatc_at").val()),
			ATC_VER						: $.trim($("#slatc_ver").val()),
			ATC_CODE					: $.trim($("#txtatc_code").val()),
			KCD_AT						: $.trim($("#txtkcd_at").val()),
			KCD_VER						: $.trim($("#slkcd_ver").val()),
			KCD_CODE					: $.trim($("#txtkcd_code").val()),
			MEDDRA_AT					: $.trim($("#txtmeddra_at").val()),
			MEDDRA_VER					: $.trim($("#txtmeddra_ver").val()),
			MEDDRA_LTT_CODE				: $.trim($("#txtmeddra_ltt_code").val()),
			REPORTR_DC_AT				: $.trim($("#txtreportr_dc_at").val()),
			REPORTR_DC_SE				: $.trim($("#txtreportr_dc_se").val()),
			SPON_DC_AT					: $.trim($("#txtspon_dc_at").val()),
			SPON_DC_SE					: $.trim($("#txtspon_dc_se").val()),
			UPDATE_ID 					: '${loginMap.USER_ID}'
		};
	
	
		$.ajax({
			url : '/sdb/c02/insertDrug.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if (data.success) {					
					saveCasuality();
// 					$('#iform').each(function() {
// 						this.reset();
// 					});
// 					$('label[popup_type=Label]').text('');
// 					$('#Druginput').hide();
// 					$("#mode").val('C');
// 					grDrug_List.load();
					
					
				} else {
					alert(data.errmsg);
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
	var params2 = {
			HRMFLNS_CASE_CODE				: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE						: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO						: $.trim($("#hdfollow_no").val()),
			UPDATE_ID 						: '${loginMap.USER_ID}'
	};
	//alert(params.UPDATE_ID);
	//return;
	$.ajax({
		url : '/sdb/c02/insertCasuality_T.do',
		type : 'post',
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params2),
		dataType : "json",
		success : function(data) {
			if (data.success) {		
				$('#iform').each(function() {
					this.reset();
				});
				$('label[popup_type=Label]').text('');
				$('#Druginput').hide();
				$("#mode").val('C');
				grDrug_List.load();
				
				
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("실패");
		}
	});
}



var grDrug_List = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grDrug_List.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grDrug_List',
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
	url: '/sdb/c02/selectDrugList.do',
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
    dataField : "DRFSTFROLE_SE",
    headerText : "Drug Role"
  },{
    dataField : "MEDCIN_RECOED_NM",
    headerText : "Name of drug as reported",
    width : 180
  },{
    dataField : "BEGIN_DTES",
    headerText : "Start Date",   
    width : 100
    
  },{
    dataField : "END_DTES",
    headerText : "End Date",    
    width : 100
  },{
    dataField : "SGN_MEMO",
    headerText : "Indication",
    width : 110
  },{
    dataField : "ABOVE_RESPNS_SE",
    headerText : "Action Taken with drug",
    width : 170
  },{
    dataField : "DRFSTF_WTHDRAW___CPCTY_DCRS_SE",
    headerText : "Outcome for Drug withdrawn or dose reduced",
    width : 300
  },{
    dataField : "RECR_SE",
    headerText : "Did reaction recur on readministration?",
    width : 260
  },{
    dataField : "USE_AT",
    headerText : "Deleted",
    width : 80  
  },{
    dataField : "MEDCIN_INFO_NO",
    headerText : "MEDCIN_INFO_NO",
    visible : false
  }],
  
  


  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
    if(me.proxy.autoLoad) {
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

  },
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

	selectionMode = AUIGrid.getProperty(grDrug_List.id, "selectionMode");
	
	var selectedItems = AUIGrid.getSelectedItems(grDrug_List.id);
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
	$('#hdmedcin_rcord_no').val(rowItem.MEDCIN_INFO_NO);
	
	var params ={
			MEDCIN_INFO_NO : rowItem.MEDCIN_INFO_NO
	}
	$.ajax({
		type		: "POST",
		url			: "/sdb/c02/selectDrugInfo.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {				 
			if(data.success){				
 				$('#Druginput').show();
 				
 				$('#hdmedcin_info_no').val(data.result.MEDCIN_INFO_NO);
 				$('#hdhrmflns_case_code').val(data.result.HRMFLNS_CASE_CODE);
 				$('#hdprduct_code').val(data.result.PRDUCT_CODE);
 				$('#hdfollow_no').val(data.result.FOLLOW_NO);
 				$('#sldrfstfrole_se').val(data.result.DRFSTFROLE_SE);
 				$('#hdmedcin_recoed_nm').val(data.result.MEDCIN_RECOED_NM);
 				$('#txtmedcin_recoed_nm').val(data.result.MEDCIN_RECOED_NM_KOR);
 				$('#txtmedcin_recoed_nm_eng').text(data.result.MEDCIN_RECOED_NM_ENG);
 				$('#hdmedcin_nm').val(data.result.MEDCIN_NM);
 				$('#txtmedcin_nm').val(data.result.MEDCIN_NM_KOR);
 				$('#txtmedcin_nm_eng').text(data.result.MEDCIN_NM_ENG);
 				$('#txtmfds_brand_code').val(data.result.MFDS_BRAND_CODE);
 				$('#txtmfds_gnrl_code').val(data.result.MFDS_GNRL_CODE);
 				$('#txtunconfm_medcinnm').val(data.result.UNCONFM_MEDCINNM);
 				$('#txtbegin_dtes').val(data.result.BEGIN_DTES);
 				$('#slcntnc_at').val(data.result.CNTNC_AT);
 				$('#txtend_dtes').val(data.result.END_DTES);
 				$('#txtmdctn_pd').val(data.result.MDCTN_PD);
 				$('#hdrstrct_form').val(data.result.RSTRCT_FORM);
 				$('#txtrstrct_form').val(data.result.RSTRCT_FORM_KOR);
 				$('#txtrstrct_form_eng').text(data.result.RSTRCT_FORM_ENG);
 				$('#hdcours').val(data.result.COURS);
 				$('#txtcours').val(data.result.COURS_KOR);
 				$('#txtcours_eng').text(data.result.COURS_ENG);
 				$('#txtbatch_lt_no').val(data.result.BATCH_LT_NO);
 				$('#hdfdqnt').val(data.result.FDQNT);
 				$('#txtfdqnt').val(data.result.FDQNT_KOR);
 				$('#txtfdqnt_eng').text(data.result.FDQNT_ENG);
 				$('#hdunit').val(data.result.UNIT);
 				$('#txtunit').val(data.result.UNIT_KOR);
 				$('#txtunit_eng').text(data.result.UNIT_ENG);
 				$('#txtncount').val(data.result.NCOUNT);
 				$('#txtintrvl').val(data.result.INTRVL);
 				$('#slintrvl_unit').val(data.result.INTRVL_UNIT);
 				$('#hddifr_usage_user_info').val(data.result.DIFR_USAGE_USER_INFO);
 				$('#txtdifr_usage_user_info').val(data.result.DIFR_USAGE_USER_INFO_KOR);
 				$('#txtdifr_usage_user_info_eng').text(data.result.DIFR_USAGE_USER_INFO_ENG);
 				$('#hdsgn_memo').val(data.result.SGN_MEMO);
 				$('#txtsgn_memo').val(data.result.SGN_MEMO_KOR);
 				$('#txtsgn_memo_eng').text(data.result.SGN_MEMO_ENG);
 				$('#slabove_respns_se').val(data.result.ABOVE_RESPNS_SE);
 				$('#sldrfstf_wthdraw___cpcty_dcrs_se').val(data.result.DRFSTF_WTHDRAW___CPCTY_DCRS_SE);
 				$('#slrecr_se').val(data.result.RECR_SE);
 				$('#hddifr_info').val(data.result.DIFR_INFO);
 				$('#txtdifr_info').val(data.result.DIFR_INFO_KOR);
 				$('#txtdifr_info_eng').text(data.result.DIFR_INFO_ENG);
 				$('#txtatc_at').val(data.result.ATC_AT);
 				$('#slatc_ver').val(data.result.ATC_VER);
 				$('#txtatc_code').val(data.result.ATC_CODE);
 				$('#txtkcd_at').val(data.result.KCD_AT);
 				$('#slkcd_ver').val(data.result.KCD_VER);
 				$('#txtkcd_code').val(data.result.KCD_CODE);
 				$('#txtmeddra_at').val(data.result.MEDDRA_AT);
 				$('#txtmeddra_ver').val(data.result.MEDDRA_VER);
 				$('#txtmeddra_ltt_code').val(data.result.MEDDRA_LTT_CODE);
 				$('#txtreportr_dc_at').val(data.result.REPORTR_DC_AT);
 				$('#txtreportr_dc_se').val(data.result.REPORTR_DC_SE);
 				$('#txtspon_dc_at').val(data.result.SPON_DC_AT);
 				$('#txtspon_dc_se').val(data.result.SPON_DC_SE);
 				$('#mode').val('U'); 
				  
			  }else{
					alert(data.result.errmsg);
			  }
		  }, 
		error		: function(xhr, textStatus, errorThrown){
			//alert(textStatus);
			alert("실패");
		}
	});
	
}
window.onresize = function() {
 if (typeof grDrug_List.id !== "undefined") {
   AUIGrid.resize(grDrug_List.id);
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
					//AUIGrid.resize(grDrug_List.id);
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
							<li id="tabAe" class="tab_menu">AE</li>
							<li id="tabLab" class="tab_menu">LAB</li>
							<li id="tabDrug" class="port_back tab_menu">DRUG</li>
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
 					<article class="mgT16" style="margin-bottom: 16px;">
                        <div id="grDrug_List" class="gridHeiSz03 grid_wrap tb01_2"></div>
                        <!-- <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
                    </article>
                    <input type="hidden" id="hdhrmflns_case_code" />
					<input type="hidden" id="hdprduct_code" />
					<input type="hidden" id="hdfollow_no" />
					<input type="hidden" id="hdmafu_no" />
					<input type="hidden" id="hdmedcin_info_no" />
					<input type="hidden" id="mode" />
					
                    <form id="iform">
					<ul class="mgT20" id="Druginput">
					    <li class="accordion_02">
					    	<a href="#void" class="close">DRUG No.1</a>
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
											<th colspan="2">Drug Role<span class="must_01"></span></th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<select id="sldrfstfrole_se" style="width:100%;">
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
											<th colspan="2">Name of drug as reported<span class="must_01"></span></th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtmedcin_recoed_nm" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtmedcin_recoed_nm','txtmedcin_recoed_nm_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdmedcin_recoed_nm" />
												<label popup_type="Label" id="txtmedcin_recoed_nm_eng"></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">Generic Name</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtmedcin_nm" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtmedcin_nm','txtmedcin_nm_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdmedcin_nm" />
												<label popup_type="Label" id="txtmedcin_nm_eng"></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">MFDS Brand Term(Kor)</th>
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
											<th>MFDS Brand Code</th>
											<td><input type="text" id="txtmfds_brand_code" style="width:100%;"></td>
											<th>MFDS Brand Term(Eng)</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<textarea id="" rows="2" style="width: 100%;"></textarea>
											</td>
										</tr>
										<tr>
											<th colspan="2">Not approved medication</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtunconfm_medcinnm" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">MFDS Generic Term(Kor)</th>
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
											<th>MFDS Generic Code</th>
											<td><input type="text" id="txtmfds_gnrl_code" style="width:100%;"></td>
											<th>MFDS Generic Term(Eng)</th>
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
										</tr>
										<tr>
											<th>ATC</th>
											<th>Version</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slatc_ver" style="width:100%;">
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
												<input type="text" id="txtatc_code" style="width:100%;">
											</td>
										</tr>
										<tr>
											<th colspan="2">Start Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtbegin_dtes" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											
											<th>Continuing</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slcntnc_at" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>End Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txtend_dtes" style="width: 120px;" />
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
											<th colspan="2">Duration of drug administration</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtmdctn_pd" style="width:50px;"> Day
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Pharmaceutical form</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtrstrct_form" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtrstrct_form','txtrstrct_form_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdrstrct_form" />
												<label popup_type="Label" id="txtrstrct_form_eng"></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">Route</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtcours" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtcours','txtcours_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdcours" />
												<label popup_type="Label" id="txtcours_eng"></label>
											</td>
											<th>Batch/lot number</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtbatch_lt_no" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Dose</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtfdqnt" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtfdqnt','txtfdqnt_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdfdqnt" />
												<label popup_type="Label" id="txtfdqnt_eng"></label>
											</td>
											<th>Unit</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtunit" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtunit','txtunit_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdunit" />
												<label popup_type="Label" id="txtunit_eng"></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">Frequency</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtncount" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Interval</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtintrvl" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Interval Unit</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="slintrvl_unit" style="width:100%;">
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
											<th colspan="2">Other Dosage/Usage Information</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtdifr_usage_user_info" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E" onclick="EnglishNotation('txtdifr_usage_user_info','txtdifr_usage_user_info_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hddifr_usage_user_info" />
												<label popup_type="Label" id="txtdifr_usage_user_info_eng"></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">Indication</th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtsgn_memo" style="width:100%;">
														</th>
														<td>
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtsgn_memo','txtsgn_memo_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdsgn_memo" />
												<label popup_type="Label" id="txtsgn_memo_eng"></label>
											</td>
										</tr>
										<tr>
											<th>KCD</th>
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
															<input type="text" id="txtkcd_code" style="width:100%;">
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
														<td style="width: 32px; vertical-align: top;">
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
															<input type="text" id="" style="width:100%;">
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
															<select id="slabove_respns_se" style="width:100%;">
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
											<th colspan="2">Outcome for Drug withdrawn or Does reduced</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="sldrfstf_wthdraw___cpcty_dcrs_se" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Did reaction recur on readministration?</th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<select id="slrecr_se" style="width:100%;">
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
											<th colspan="2">Ohter Information</th>
											<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="txtdifr_info" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtdifr_info','txtdifr_info_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hddifr_info" />
												<label popup_type="Label" id="txtdifr_info_eng"></label>
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
				</div>
            </section>
		</div>
	</section>
</div>
</body>
</html>