<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title>LAB</title>
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

$(function(){
	setAccodian();
	btnInit();	
	init();
	setInit();
	grLab_List.createGrid();

});

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

function setInit(){
	
	//mkSetDatePickerYYMMDD("#txttest_dte");
	$('#Labinput').hide();	
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
		url			: "/sdb/c02/selectDemographicsLab.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {				 
			if(data.success){
			 	$("#hdtest_rcord_cmmn_memo").val(data.result.TEST_RCORD_CMMN_MEMO);
			 	$("#txttest_rcord_cmmn_memo").val(data.result.TEST_RCORD_CMMN_MEMO_KOR);
			 	$("#txttest_rcord_cmmn_memo_eng").text(data.result.TEST_RCORD_CMMN_MEMO_ENG);
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
			
	$('#btnAdd').click(function(){
		$('#iform').each(function() {
			this.reset();
		});
		$('label[popup_type=Label]').text('');
		$('#Labinput').show();	
		$('#mode').val("C");
	});
	
	$('#btnSave').click(function(){	
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		
		if($('#Labinput').css('display')=='none'){
			saveformDemographics();
		}else{
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
}



function updelform(){
	var param = {
			TRGET_CODE 	: $("#hdmafu_no").val(), 
			TRGETNM 	: "LAB",
			TRGET_MODE  : $('#mode').val(),
			UPDATE_ID	: '${loginMap.USER_ID}'						
		};
	mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
}


function saveform(){
	var params = {
			CURD 						: $.trim($("#mode").val()),
			TEST_NO						: $.trim($("#hdtest_no").val()),
			HRMFLNS_CASE_CODE			: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE					: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO					: $.trim($("#hdfollow_no").val()),
			TEST_DTES					: $.trim($("#txttest_dtes").val()),
			TEST						: $.trim($("#hdtest").val()),
			TEST_KOR					: $.trim($("#txttest").val()),
			TEST_ENG					: $.trim($("#txttest_eng").text()),
			UNIT						: $.trim($("#hdunit").val()),
			UNIT_KOR					: $.trim($("#txtunit").val()),
			UNIT_ENG					: $.trim($("#txtunit_eng").text()),
			LOW_SCOPE					: $.trim($("#txtlow_scope").val()),
			RESULT						: $.trim($("#hdresult").val()),
			RESULT_KOR					: $.trim($("#txtresult").val()),
			RESULT_ENG					: $.trim($("#txtresult_eng").text()),
			MEMO						: $.trim($("#hdmemo").val()),
			MEMO_KOR					: $.trim($("#txtmemo").val()),
			MEMO_ENG					: $.trim($("#txtmemo_eng").text()),
			TEST_RCORD_CMMN_MEMO		: $.trim($("#hdtest_rcord_cmmn_memo").val()),
			TEST_RCORD_CMMN_MEMO_KOR	: $.trim($("#txttest_rcord_cmmn_memo").val()),
			TEST_RCORD_CMMN_MEMO_ENG	: $.trim($("#txttest_rcord_cmmn_memo_eng").text()),
			UPDATE_ID 			: '${loginMap.USER_ID}'
		};
		$.ajax({
			url : '/sdb/c02/insertLabInfo.do',
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
					$('#Labinput').hide();
					$("#mode").val('C');
					grLab_List.load();
					
					
				} else {
					alert(data.errmsg);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
			}
		});
	
}

function saveformDemographics(){
	var params = {
			CURD 						: 'DEMO',
			TEST_NO						: $.trim($("#hdtest_no").val()),
			HRMFLNS_CASE_CODE			: $.trim($("#hdhrmflns_case_code").val()),
			PRDUCT_CODE					: $.trim($("#hdprduct_code").val()),
			FOLLOW_NO					: $.trim($("#hdfollow_no").val()),			
			TEST_RCORD_CMMN_MEMO		: $.trim($("#hdtest_rcord_cmmn_memo").val()),
			TEST_RCORD_CMMN_MEMO_KOR	: $.trim($("#txttest_rcord_cmmn_memo").val()),
			TEST_RCORD_CMMN_MEMO_ENG	: $.trim($("#txttest_rcord_cmmn_memo_eng").text()),
			UPDATE_ID 			: '${loginMap.USER_ID}'
		};
		$.ajax({
			url : '/sdb/c02/insertLabInfo.do',
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
					$('#Labinput').hide();
					$("#mode").val('C');
					grLab_List.load();
					
					
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



var grLab_List = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grLab_List.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grLab_List',
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
	url: '/sdb/c02/selectLabList.do',
	param: {
		HRMFLNS_CASE_CODE : $('#hdhrmflns_case_code').val(),
		PRDUCT_CODE : $('#hdprduct_code').val()	,
		FOLLOW_NO : $('#hdfollow_no').val()
	},
	type: 'post',
	dataType: 'json',
	//페이징 true, false 로 지정
	paging: false,
	//처음 시작시 데이터 로딩
	autoLoad: true
},
  //AUI 그리드 옵션
  gridPros : {
	'selectionMode' : 'singleRow',
	'editable' : false,
	usePaging : false,
	enableFilter : true,
	pageRowCount : 10,
	showPageButtonCount : 10,
	fixedColumnCount : 2,
	headerHeight : 40,
	rowHeight : 37
},
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "TEST_DTES",
    headerText : "Date",
    width : 100
  },{
    dataField : "TEST",
    headerText : "TEST",
    width : 100
  },{
    dataField : "UNIT",
    headerText : "Unit",
    width : 100
  },{
    dataField : "LOW_SCOPE",
    headerText : "RANGE",
    width : 140
  },{
    dataField : "RESULT",
    headerText : "Result",
    width : 80
  },{
    dataField : "MEMO",
    headerText : "Comments"
  },{
    dataField : "USE_AT",
    headerText : "Deleted",
    width : 80
  },{
    dataField : "TEST_NO",
    headerText : "TEST NO",
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

	selectionMode = AUIGrid.getProperty(grLab_List.id, "selectionMode");

	var selectedItems = AUIGrid.getSelectedItems(grLab_List.id);
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

	var params ={
			TEST_NO : rowItem.TEST_NO
	}
	$.ajax({
		type		: "POST",
		url			: "/sdb/c02/selectLabListInfo.do",
		contentType : "application/json; charset=UTF-8",
		data : JSON.stringify(params),
		dataType : "json",
		success : function(data) {				 
			if(data.success){
				$('#Labinput').show();
				$('#hdtest_no').val(data.result.TEST_NO);
				$('#txttest_dtes').val(data.result.TEST_DTES);
				$('#hdtest').val(data.result.TEST);
				$('#txttest').val(data.result.TEST_KOR);
				$('#txttest_eng').text(data.result.TEST_ENG);
				$('#hdunit').val(data.result.UNIT);
				$('#txtunit').val(data.result.UNIT_KOR);
				$('#txtunit_eng').text(data.result.UNIT_ENG);
				$('#txtlow_scope').val(data.result.LOW_SCOPE);
				$('#hdresult').val(data.result.RESULT);
				$('#txtresult').val(data.result.RESULT_KOR);
				$('#txtresult_eng').text(data.result.RESULT_ENG);
				$('#hdmemo').val(data.result.MEMO);
				$('#txtmemo').val(data.result.MEMO_KOR);
				$('#txtmemo_eng').text(data.result.MEMO_ENG);
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
 if (typeof grLab_List.id !== "undefined") {
   AUIGrid.resize(grLab_List.id);
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
					//AUIGrid.resize(grLab_List.id);
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
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
								
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
							<li id="tabLab" class="port_back tab_menu">LAB</li>
							<li id="tabDrug" class="tab_menu">DRUG</li>
							<li id="tabCasulity" class="tab_menu">CASUALITY</li>
							<li id="tabNarrative" class="tab_menu">NARRATIVE</li>
							<li id="tabAssessment" class="tab_menu">ASSESSMENT</li>
						</ul>
					</div>

					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="btnInit" class="btn mgL3" value="초기화">												
						<input type="button" id="btnAdd" class="btn mgL3" value="추가">									
						<input type="button" id="btnSave" class="btn mgL3" value=<spring:message code="button.save" />>
						<input type="button" id="btnDel" class="btn mgL3" value=<spring:message code="button.delete" />>
						<input type="button" id="btnExcel" value="엑셀">
						<input type="button" id="btnAudit" class="btn mgL3" value="A" title="Audit Trail">
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
												<textarea id="txttest_rcord_cmmn_memo" rows="3" style="width: 100%;"></textarea>
											</th>
											<td style="vertical-align: top; ">
												<input type="button" class="oneBtn" value="Q" style="vertical-align: top;" />
												<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" onclick="EnglishNotation('txttest_rcord_cmmn_memo','txttest_rcord_cmmn_memo_eng');"/>
											</td>
										</tr>
									</table>
									<input type="hidden" id="hdtest_rcord_cmmn_memo" />
									<label popup_type="Label" id="txttest_rcord_cmmn_memo_eng"></label>
								</td>
							</tr>
						</tbody>
					</table>

 					<article class="mgT16">
                        <div id="grLab_List" class="gridHeiSz03 grid_wrap tb01_2"></div>
                    </article>
					
						<input type="hidden" id="hdhrmflns_case_code" />
						<input type="hidden" id="hdprduct_code" />
						<input type="hidden" id="hdfollow_no" />
						<input type="hidden" id="hdtest_no" />
						<input type="hidden" id="mode" />
					<form id="iform">
					<ul class="mgT20" id="Labinput">
					    <li class="accordion_02">
					    	<a href="#void" class="close">LAB</a>
					        <div class="accordion_con_02">
								<table class="tb001">
									<colgroup>
										<col width="12%" />
										<col width="20%" />
										<col width="12%" />
										<col width="20%" />
										<col width="12%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="txttest_dtes" style="width: 130px;" data-datatype="DATE" data-yyuk="Y" data-mmuk="Y" data-dduk="Y" >
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Test<span class="must_01"></span></th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txttest" style="width:100%;">
														</th>
														<td >
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txttest','txttest_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdtest" />
												<label popup_type="Label" id="txttest_eng"></label>												
											</td>
											<th>Unit</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtunit" style="width:100%;">
														</th>
														<td>
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtunit','txtunit_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdunit" />
												<label popup_type="Label" id="txtunit_eng"></label>
											</td>
										</tr>
										<tr>
											<th>Range</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtlow_scope" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Result<span class="must_01"></span></th>
											<td colspan="3">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="txtresult" style="width:100%;">
														</th>
														<td>
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtresult','txtresult_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdresult" />
												<label popup_type="Label" id="txtresult_eng"></label>
												
											</td>
										</tr>
										<tr>
											<th>Comments</th>
											<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="txtmemo" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtmemo','txtmemo_eng');"/>
														</td>
													</tr>
												</table>
												<input type="hidden" id="hdmemo" />
												<label popup_type="Label" id="txtmemo_eng"></label>
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
