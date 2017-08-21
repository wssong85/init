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
table.in_table tr:last-child{ border: none;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

<script type="text/javascript">

var testData_01 =[
{
  "Source(s) of the case identifier":"input Q E",
  "Case identifiers":"input Q E"
}, {
  "Source(s) of the case identifier":"input Q E",
  "Case identifiers":"input Q E"
}, {
  "Source(s) of the case identifier":"input Q E",
  "Case identifiers":"input Q E"
}, {
  "Source(s) of the case identifier":"input Q E",
  "Case identifiers":"input Q E"
}];


var myGridOption_01 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_01'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Source(s) of the case identifier",
    headerText : "Source(s) of the case identifier"

  },{
    dataField : "Case identifiers",
    headerText : "Case identifiers"


  
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_01);
  }
};



var testData_02 =[
{
	"Identification number of the report which is linked to this report":"input Q E"
}, {
	"Identification number of the report which is linked to this report":"input Q E"
}, {
	"Identification number of the report which is linked to this report":"input Q E"

}];


var myGridOption_02 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_02'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Identification number of the report which is linked to this report",
    headerText : "Identification number of the report which is linked to this report"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_02);
  }
};


var testData_03 =[
{
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"

}];



var myGridOption_03 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_03'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "data_01",
    headerText : "data_01"
  },{
    dataField : "data_02",
    headerText : "data_02"
  },{
    dataField : "data_03",
    headerText : "data_03"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_03);
  }
};



var testData_04 =[
{
  "Reporter Title":"input Q E",
  "Reporter Give Name":"input Q E",
  "Reporter Middle Name":"input Q E",
  "Reporter Family Name":"input Q E",
  "Reporter Organization":"input Q E",
  "Reporter Department":"input Q E",
  "Reporter Street":"input Q E",
  "Reporter City":"input Q E",
  "Reporter State":"input Q E",
  "Reporter Postcode":"input Q E",
  "Reporter Country":"input Q E",
  "Qualification":"input Q E",
  "Literature reference(s)":"input Q E"
}, {
  "Reporter Title":"input Q E",
  "Reporter Give Name":"input Q E",
  "Reporter Middle Name":"input Q E",
  "Reporter Family Name":"input Q E",
  "Reporter Organization":"input Q E",
  "Reporter Department":"input Q E",
  "Reporter Street":"input Q E",
  "Reporter City":"input Q E",
  "Reporter State":"input Q E",
  "Reporter Postcode":"input Q E",
  "Reporter Country":"input Q E",
  "Qualification":"input Q E",
  "Literature reference(s)":"input Q E"
}];



var myGridOption_04 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_04'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Reporter Title",
    headerText : "Reporter Title"
  },{
    dataField : "Reporter Give Name",
    headerText : "Reporter Give Name"
  },{
    dataField : "Reporter Middle Name",
    headerText : "Reporter Middle Name"
  },{
    dataField : "Reporter Family Name",
    headerText : "Reporter Family Name"
  },{
    dataField : "Reporter Organization",
    headerText : "Reporter Organization"
  },{
    dataField : "Reporter Department",
    headerText : "Reporter Department"
  },{
    dataField : "Reporter Street",
    headerText : "Reporter Street"
  },{
    dataField : "Reporter City",
    headerText : "Reporter City"
  },{
    dataField : "Reporter State",
    headerText : "Reporter State"
  },{
    dataField : "Reporter Postcode",
    headerText : "Reporter Postcode"
  },{
    dataField : "Reporter Country",
    headerText : "Reporter Country"
  },{
    dataField : "Qualification",
    headerText : "Qualification"
  },{
    dataField : "Literature reference(s)",
    headerText : "Literature reference(s)"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_04);
  }
};



var testData_05 =[
{
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"
}, {
  "data_01":"1111",
  "data_02":"2222",
  "data_03":"3333"

}];




var myGridOption_05 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_05'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "data_01",
    headerText : "data_01"
  },{
    dataField : "data_02",
    headerText : "data_02"
  },{
    dataField : "data_03",
    headerText : "data_03"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_05);
  }
};





$(function() {
	myGridOption_01.createGrid();
	myGridOption_02.createGrid();
	myGridOption_03.createGrid();
	myGridOption_04.createGrid();
	myGridOption_05.createGrid();
	setAccodian();
	
	//mkSetDatePickerYYMMDD("#day_01");
	//mkSetDatePickerYYMMDD("#day_02");

	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal);
	});
	
});


$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if (myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
	}
	if (myGridOption_03.id) {
		AUIGrid.resize(myGridOption_03.id);
	}
	if (myGridOption_04.id) {
		AUIGrid.resize(myGridOption_04.id);
	}
	if (myGridOption_05.id) {
		AUIGrid.resize(myGridOption_05.id);
	}
});



function setAccodian(){
	 for(var ai=0; ai<3; ai++){
	    aiP = ai+1;
	
		(function(aiE){ 
			$(".accordion_0"+aiE+" > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".accordion_con_0"+aiE+"").slideToggle(20);
					$(this).toggleClass('open');
					//그리드 리사이징
					AUIGrid.resize(myGridOption_01.id);
					AUIGrid.resize(myGridOption_02.id);
					AUIGrid.resize(myGridOption_03.id);
					AUIGrid.resize(myGridOption_04.id);
					AUIGrid.resize(myGridOption_05.id);
				}
			});

			$(".accordion_con_02").css({"display":"none"});
			$(".accordion_con_03").css({"display":"none"});
		
		})(aiP);	
	}
}



</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
	<form id="iform">
	<input type='hidden' id=''/>							
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>국외사례리스트</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>국외사례</li>
						<li>국외사례리스트</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">





					<div class="button_tab_01">
						<ul>
							<li id="" class="port_back tab_menu">레포트 정보</li>
							<li id="" class="tab_menu">환자정보</li>
						</ul>
					</div>


                    <article class="conTitBtnR">
						<input type="button" id="btnSave" class="btn mgL3" value="저장">
						<input type="button" id="btnDel" class="btn mgL3" value="내역">
                    </article>
					<div style="clear:both; "></div>


					<article class="conTitBtn">
						<table class="tb001">
							<colgroup>
								<col width="10%" />
								<col width="15%" />
								<col width="11%" />
								<col width="15%" />
								<col width="10%" />
								<col width="15%" />
								<col width="8%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>PRODUCT</th>
									<td>									 
			                            <input type="text" id="txtProductCode" popup_type="ProductSearch" readonly style="width:70%;">
			                            <input type="hidden" id="hdProductCode"/>
			                            <button class="oneBtn" type="sumit"  popup_type="ProductSearch"><img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색"></button>
									</td>
									<th>Source Type</th>
									<td>
										<select id="slsourcetype" style="width:100%;">
											<option value="">Source Type</option>
											<option value="">Source data_01</option>
										</select>
									</td>
									<th>SOURCE</th>
									<td>
										<select id="slsourcetype" style="width:100%;">
											<option value="">SOURCE</option>
											<option value="">Source data_01</option>
										</select>
									</td>
									<th>Subject</th>
									<td>
										<select id="slsourcetype" style="width:100%;">
											<option value="">Subject</option>
											<option value="">Source data_01</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>업로드</th>
									<td colspan="7">

						 				<div class="fileInputArea" style="width:500px;">
							 				<input type="text" id="fileName" readonly="readonly" style="width:418px;">
							 				<input type="button" value="파일 선택" class="fileInputBtn" />
							 				<input type="file" class="fileIuputHid" style="width:100%;">
						 				</div>
										<input type="button" id="btnFollowUp" class="btn mgL3" value="업로드">
									</td>

								</tr>
							</tbody>
						</table>
					</article>



	
					<ul class="mgT20">
					    <li class="accordion_02">
					    	<a href="#void" class="close">레포트 정보</a>
					    	
					        <div class="accordion_con_02">
					        	<h6>Report Information</h6>
					        	<div style="height:5px;"></div>
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th colspan="2">Safety Report Version Number<span class="must_01"></span></th>
											<td colspan="2">
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
											<th colspan="2">Sender's (Case) Safety Report Unique Identifier<span class="must_01"></span></th>
											<td colspan="2">
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
											<th>Identification of the country of the promary<span class="must_01"></span></th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Date of this transmission<span class="must_01"></span></th>
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
											<th>Type of report<span class="must_01"></span></th>
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
											<th>Serious</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="radio" id="a11" name="a1"><label for="a11" class="raLab"><span>Yes</span></label>
															<input type="radio" id="a12" name="a1"><label for="a12" class="raLab"><span>No</span></label>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Seriousness criteria</th>
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
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Date report was first received from source</th>
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
											<th>Date of receipt of the most recent information for this report</th>
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
											<th>Are additional documents available</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="radio" id="b11" name="b1"><label for="b11" class="raLab"><span>Yes</span></label>
															<input type="radio" id="b12" name="b1"><label for="b12" class="raLab"><span>No</span></label>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>List of documents held by sender</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Does this case fulfill the local criteria for an expedited report?</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="radio" id="c11" name="c1"><label for="c11" class="raLab"><span>Yes</span></label>
															<input type="radio" id="c12" name="c1"><label for="c12" class="raLab"><span>No</span></label>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>Regulatory authority's case rerport number</th>
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
											<th>Other sender's case report number</th>
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
											<th colspan="2">Other case identifiers in previous transmissions</th>
											<td colspan="2">
												<table class="in_table">
													<tr>
														<th>
															<input type="checkbox" name="" id="d4" ><label for="d4" class="chcLab"><span>Yes</span></label>
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


								<div style=" width:50%; display:inline-block; padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Report Duplicate</h6>
				                    </article>
				                    
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
				
									<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>
								</div>
			                    
			                    
			                    <div style=" width:49.54%; display:inline-block; padding:6px; box-sizing: border-box; ">
				                    <article class="conTitBox">
				                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Linked Report</h6>
				                    </article>
				
				                    <article class="conTitBtnR">
				                        <input type="button" id="" value="행추가">
				                        <input type="button" id="" value="행삭제">
				                    </article>
				                    
									<div style="height:10px;"></div>
									
									<div id="grid_wrap_02" class="gridHeiSz03 grid_wrap tb01_2"></div>
								</div>
			                    

								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="30%" />
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Report nullification</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="checkbox" name="" id="e4" ><label for="e4" class="chcLab"><span>Yes</span></label>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Reason for nullification</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th colspan="2">Was the case medically confirmed, if not initially from health professional?</th>
											<td colspan="2">
												<table class="in_table">
													<tr>
														<th>
															<input type="radio" id="f11" name="f1"><label for="f11" class="raLab"><span>Yes</span></label>
															<input type="radio" id="f12" name="f1"><label for="f12" class="raLab"><span>No</span></label>
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

			
			
			
								<div style="height:20px;"></div>
			
			
			




					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_03" class="gridHeiSz03 grid_wrap tb01_2"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					    
					    
					    
					    <li class="accordion_02">
					    	<a href="#void" class="close">기본 정보</a>

					        <div class="accordion_con_02">
					        	<h6 style="display:inline-block;">Primary Source</h6>

			                    <article class="conTitBtnR">
									<input type="button" id="btnDel" class="btn mgL3" value="행추가">
									<input type="button" id="btnDel" class="btn mgL3" value="행삭제">
			                    </article>
								<div style="clear:both; height:10px; "></div>
					        	
					        	
								<div id="grid_wrap_04" class="gridHeiSz03 grid_wrap tb01_2"></div>
	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_05" class="gridHeiSz03 grid_wrap tb01_2"></div>
					                    </div>
					                </li>
					            </ul>
					        </div>
					    </li>
					    
					    
					    
					    <li class="accordion_02">
					    	<a href="#void" class="close">보고자/수신자 정보</a>
					        <div class="accordion_con_02">
					        	<h6>Sender</h6>
					        	<div style="height:5px;"></div>
								<table class="tb001">
									<colgroup>
										<col width="15%" />
										<col width="35%" />
										<col width="15%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Sender Type</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Sender Organization</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Sender Organization</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Sender Title</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Sender Give Name</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Sender Middle Name</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Sender Family Name</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Sender Street Address</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Sender City</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Sender State</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Sender Postcode</th>
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
											<th>Sender Country Code</th>
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
											<th>Sender Tel</th>
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
											<th>Sender Tel Extension</th>
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
											<th>Sender Tel Countrycode</th>
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
											<th>Sender Fax</th>
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
											<th>Sender Fax Extension</th>
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
											<th>Sender Fax Countrycode</th>
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
											<th>Sender Email Address</th>
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
											<th></th>
											<td></td>
										</tr>


									</tbody>
								</table>
	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_06" class="gridHeiSz03 grid_wrap tb01_2">auigrid 영역</div>
					                    </div>
					                </li>
					            </ul>
					            
					            <div style="height:20px;"></div>
					            
					        	<h6>Receiver</h6>
					        	<div style="height:5px;"></div>
									<table class="tb001">
									<colgroup>
										<col width="15%" />
										<col width="35%" />
										<col width="15%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Receiver Type</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Receiver Organization</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Receiver Organization</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Receiver Title</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Receiver Give Name</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Receiver Middle Name</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Receiver Family Name</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Receiver Street Address</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Receiver City</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
											<th>Receiver State</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td>
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
															<input type="button" class="oneBtn" popup_type="E" value="E">
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
										<tr>
											<th>Receiver Postcode</th>
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
											<th>Receiver Country Code</th>
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
											<th>Receiver Tel</th>
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
											<th>Receiver Tel Extension</th>
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
											<th>Receiver Tel Countrycode</th>
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
											<th>Receiver Fax</th>
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
											<th>Receiver Fax Extension</th>
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
											<th>Receiver Fax Countrycode</th>
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
											<th>Receiver Email Address</th>
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
											<th></th>
											<td></td>
										</tr>


									</tbody>
								</table>
	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap_07" class="gridHeiSz03 grid_wrap tb01_2">auigrid 영역</div>
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
	</form>
</div>
</body>
</html>