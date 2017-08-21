<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title>MEDICAL HISTORY</title>
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

$(function(){
	setAccodian();
	btnInit();	
	init();
	setInit();
	
	grMedHistory_List.createGrid();

});

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
		grMedHistory_List.load();
	});
	
	$('#btnExcel').click(function(){
		var data = AUIGrid.getGridData(grStudy.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grMedHistory_List.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grMedHistory_List.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
	
	$('#btnAdd').click(function(){
		$('#iform').each(function() {
			this.reset();
		});
		$('label[popup_type=Label]').text('');
		$('#Medicalinput').show();	
		$('#mode').val("C");
	});
	
	$('#btnSave').click(function(){	
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		
		if($('#Medicalinput').css('display')=='none'){
			saveDemographicsMedical();
		}else{
			if (!mkValidation()) {
				return;
			}
			alert($('#mode').val());
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
}

function init(){
	
	$("#hdhrmflns_case_code").val(HRMFLNS_CASE_CODE);
	$("#hdprduct_code").val(PRDUCT_CODE);
	$("#hdfollow_no").val(FOLLOW_NO);
	$("#hdmafu_no").val(MAFU_NO);
	
	
	var params ={
			HRMFLNS_CASE_CODE : HRMFLNS_CASE_CODE,
			PRDUCT_CODE : PRDUCT_CODE,
			FOLLOW_NO : FOLLOW_NO			
	}
	$.ajax({
		type		: "POST",
		url			: "/sdb/c02/selectDemographicsMedi.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {				 
			if(data.success){
			 	$("#hdmdlc_rcord_cmmn_memo").val(data.result.MDLC_RCORD_CMMN_MEMO);
			 	$("#txtmdlc_rcord_cmmn_memo").val(data.result.MDLC_RCORD_CMMN_MEMO_KOR);
			 	$("#txtmdlc_rcord_cmmn_memo_eng").text(data.result.MDLC_RCORD_CMMN_MEMO_ENG);
 				$('#mode').val('U'); 
				  
			}else{
				
			}
		  }, 
		error		: function(xhr, textStatus, errorThrown){
			alert("실패");
		}
	});
	
	$('#mode').val("C");
}

function setInit(){
	<c:forEach var="result" items="${printType}" varStatus="status">
		$("#slcntnc_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>


// 	mkSetDatePickerYYMMDD("#txtbegin_dte");
// 	mkSetDatePickerYYMMDD("#txtend_dte");
	
	$('#Medicalinput').hide();	
}


function updelform(){
	var param = {
			TRGET_CODE 	: $("#hdmafu_no").val(), 
			TRGETNM 	: "MedH",
			TRGET_MODE  : $('#mode').val(),
			UPDATE_ID	: '${loginMap.USER_ID}'						
		};
	mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
}


function saveform(){
	var params = {
			CURD 						: $.trim($("#mode").val()),
			MDLC_RCORD_NO				: $.trim($("#hdmdlc_rcord_no").val()),
			HRMFLNS_CASE_CODE			: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE					: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO					: $.trim($("#hdfollow_no").val()),
			MDLC_RCORD_NM				: $.trim($("#hdmdlc_rcord_nm").val()),
			MDLC_RCORD_NM_KOR			: $.trim($("#txtmdlc_rcord_nm").val()),
			MDLC_RCORD_NM_ENG			: $.trim($("#txtmdlc_rcord_nm_eng").text()),
			//KCD_USE_AT					: $.trim($("#txtkcd_use_at").val()),
			KCD_VER						: $.trim($("#txtkcd_ver").val()),
			KCD_CODE					: $.trim($("#txtkcd_code").val()),
			//MEDDRA_USE_AT				: $.trim($("#txtmeddra_use_at").val()),
			MEDDRA_VER					: $.trim($("#txtmeddra_ver").val()),
			MEDDRA_LTT_CODE				: $.trim($("#txtmeddra_ltt_code").val()),
			BEGIN_DTES					: $.trim($("#txtbegin_dtes").val()),
			CNTNC_AT					: $.trim($("#txtcntnc_at").val()),
			END_DTES					: $.trim($("#txtend_dtes").val()),
			RCORD_MEMO					: $.trim($("#hdrcord_memo").val()),
			RCORD_MEMO_KOR				: $.trim($("#txtrcord_memo").val()),
			RCORD_MEMO_ENG				: $.trim($("#txtrcord_memo_eng").text()),
			MDLC_RCORD_CMMN_MEMO		: $.trim($("#hdmdlc_rcord_cmmn_memo").val()),
			MDLC_RCORD_CMMN_MEMO_KOR	: $.trim($("#txtmdlc_rcord_cmmn_memo").val()),
			MDLC_RCORD_CMMN_MEMO_ENG	: $.trim($("#txtmdlc_rcord_cmmn_memo_eng").text()),
			
			UPDATE_ID 					: '${loginMap.USER_ID}'
		};
		$.ajax({
			url : '/sdb/c02/insertMedicalHistory.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if (data.success) {					
					//window.location.href= "/sdb/c01/SDBC0101.do";
					$('#iform').each(function() {
						this.reset();
					});
					$('label[popup_type=Label]').text('');
					$('#Medicalinput').hide();
					$("#mode").val('C');
					grMedHistory_List.load();
					
					
				} else {
					alert(data.errmsg);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
			}
		});
	
}



function saveDemographicsMedical(){
	var params = {
			CURD 						: 'DEMO',
			MDLC_RCORD_NO				: $.trim($("#hdmdlc_rcord_no").val()),
			HRMFLNS_CASE_CODE			: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE					: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO					: $.trim($("#hdfollow_no").val()),			
			MDLC_RCORD_CMMN_MEMO		: $.trim($("#hdmdlc_rcord_cmmn_memo").val()),
			MDLC_RCORD_CMMN_MEMO_KOR	: $.trim($("#txtmdlc_rcord_cmmn_memo").val()),
			MDLC_RCORD_CMMN_MEMO_ENG	: $.trim($("#txtmdlc_rcord_cmmn_memo_eng").text()),
			UPDATE_ID 					: '${loginMap.USER_ID}'
		};
		$.ajax({
			url : '/sdb/c02/insertMedicalHistory.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params),
			dataType : "json",
			success : function(data) {
				if (data.success) {					
					//window.location.href= "/sdb/c01/SDBC0101.do";
					$('#iform').each(function() {
						this.reset();
					});
					$('label[popup_type=Label]').text('');
					$('#Medicalinput').hide();
					$("#mode").val('C');
					grMedHistory_List.load();
					
					
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
	
// 	$('#txtProductCode').val('');
// 	$('#hdProductCode').val('');
	
// 	$('#slsourcetype, #slsource, #slfollow_no').val('');	
// 	$('#slsourcetype, #slsource, #slfollow_no').attr('disabled', true);
	
}



var grMedHistory_List = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grMedHistory_List.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grMedHistory_List',
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
	url: '/sdb/c02/selectMedicalList.do',
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
    dataField : "MDLC_RCORD_NM",
    headerText : "Disease / Surgical procedure / etc.",
    width : 240
  },{
    dataField : "BEGIN_DTES",
    headerText : "Start Date",
    width : 100
  },{
    dataField : "CNTNC_AT",
    headerText : "Continuing",
    width : 100
  },{
    dataField : "END_DTES",
    headerText : "End Date",
    width : 100
  },{
    dataField : "RCORD_MEMO",
    headerText : "Comments"
  },{
    dataField : "USE_AT",
    headerText : "Deleted",
    width : 80
  
  },{
    dataField : "MDLC_RCORD_NO",
    headerText : "MDLC_RCORD_NO",
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

	selectionMode = AUIGrid.getProperty(grMedHistory_List.id, "selectionMode");

	var selectedItems = AUIGrid.getSelectedItems(grMedHistory_List.id);
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
	$('#hdmdlc_rcord_no').val(rowItem.MDLC_RCORD_NO);
	
	var params ={
			MDLC_RCORD_NO : rowItem.MDLC_RCORD_NO
	}
	$.ajax({
		type		: "POST",
		url			: "/sdb/c02/selectMedicalHistoryInfo.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {				 
			if(data.success){
				$('#Medicalinput').show();
				//$('#hdmdlc_rcord_no').val(data.result.MDLC_RCORD_NO);
				$("#hdmdlc_rcord_nm").val(data.result.MDLC_RCORD_NM);
				$("#txtmdlc_rcord_nm").val(data.result.MDLC_RCORD_NM_KOR);
				$("#txtmdlc_rcord_nm_eng").text(data.result.MDLC_RCORD_NM_ENG);
				//$("#txtkcd_use_at").val(data.result.);
				$("#txtkcd_ver").val(data.result.KCD_VER);
				$("#txtkcd_code").val(data.result.KCD_CODE);
				//$("#txtmeddra_use_at").val(data.result.);
				$("#txtmeddra_ver").val(data.result.MEDDRA_VER);
				$("#txtmeddra_ltt_code").val(data.result.MEDDRA_LTT_CODE);
				$("#txtbegin_dtes").val(data.result.BEGIN_DTES);
				$("#slcntnc_at").val(data.result.CNTNC_AT);
				$("#txtend_dtes").val(data.result.END_DTES);
				$("#hdrcord_memo").val(data.result.RCORD_MEMO);
				$("#txtrcord_memo").val(data.result.RCORD_MEMO_KOR);
				$("#txtrcord_memo_eng").text(data.result.RCORD_MEMO_ENG);
				$('#mode').val('U'); 
				  
			  }else{
					alert(result.errmsg);
			  }
		  }, 
		error		: function(xhr, textStatus, errorThrown){
			//alert(textStatus);
			alert("실패");
		}
	});
	
}

window.onresize = function() {
 if (typeof grMedHistory_List.id !== "undefined") {
   AUIGrid.resize(grMedHistory_List.id);
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
					//AUIGrid.resize(grMedHistory_List.id);
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
							<li id="tabMedicalhistory" class="port_back tab_menu">MEDICAL HISTORY</li>
							<li id="tabDrughistory" class="tab_menu">DRUG HISTORY</li>
							<li id="tabAe" class="tab_menu">AE</li>
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


					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>General Comment</th>
								<td style="padding-top:5px; padding-bottom: 2px;">
									<table class="in_table">
										<tr>
											<th>
												<textarea id="txtmdlc_rcord_cmmn_memo" rows="3" style="width: 100%;"></textarea>
											</th>
											<td style="vertical-align: top; width: 32px;">
												<input type="button" class="oneBtn" value="Q" style="vertical-align: top;" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
 					<article class="mgT16">
                        <div id="grMedHistory_List" class="gridHeiSz03 grid_wrap tb01_2"></div>
                        <!-- <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
                    </article>
                    
                    <input type="hidden" id="hdhrmflns_case_code" />
					<input type="hidden" id="hdprduct_code" />
					<input type="hidden" id="hdfollow_no" />
					<input type="hidden" id="hdmafu_no" />
					
					<input type="hidden" id="hdmdlc_rcord_no" />
					<input type="hidden" id="mode" />
					
                    <form id="iform">
					<ul class="mgT20" id="Medicalinput">
					    <li class="accordion_02">
					    	<a href="#void" class="close">MEDICAL HISTORY No.1</a>
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
											<th colspan="2">Disease / Surgical procedure / etc.<span class="must_01"></span></th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtmdlc_rcord_nm" style="width:100%;">
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtmdlc_rcord_nm','txtmdlc_rcord_nm_eng');"/>
														</td>
													</tr>
												</table>										
												<input type="hidden" id="hdmdlc_rcord_nm" />
												<label popup_type="Label" id="txtmdlc_rcord_nm_eng"></label>
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
											<th>Team</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="txtkcd_term" rows="2" style="width: 100%;"></textarea>
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
															<select id="slmeddra_ver" style="width:100%;">
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
															<textarea id="txtmeddra_ltt_term" rows="2" style="width: 100%;"></textarea>
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
															<input type="text" id="txtmeddra_ltt_code" style="width:100%;">
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
											<th colspan="2">Comments</th>
											<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="txtrcord_memo" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txtrcord_memo','txtrcord_memo_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdrcord_memo" />
												<label popup_type="Label" id="txtrcord_memo_eng"></label>
											</td>
										</tr>
									</tbody>
								</table>
	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grQ" class="gridHeiSz04 grid_wrap tb01_2"></div>
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
	</form>
</div>
</body>
</html>