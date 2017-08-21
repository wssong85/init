<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<style>
.aui-grid-tooltip-wrapper{ }
table.tb001{ width:100%; border-top: 1px solid #dbdbdb; margin:5px 0; }
table.tb001 tr td{ background:#ffffff; width:80px; height:auto; font-size:11px; line-height:15px; padding:3px 5px; vertical-align:top;  border: 1px solid #dbdbdb;}
table.tb001 tr:first-child td{ font-family:'NanumGothicBold'; background:#f6f7ff; text-align:center; padding:6px 5px; color:black;}
</style>

<script>
	var taskSn = ${loginMap.TASK_SN};
	var _userId = "${loginMap.USER_ID}";
	var g_rowData = {};
	
	var grid_csList = {
		 	id: '',
		 	div: {
				gridDiv : 'grid_wrap',
				paging : {
					pagingDiv : 'grid_paging',
					totalRowCount : 500,
					rowCount : 10,
					pageButtonCount : 4,
					currentPage : 1,
					totalPage : 0,
				},
		 	},
		 	proxy: {
				url : "<c:url value='/edc/g01/selectCsList.do'/>",
				param : {'TASK_SN':taskSn, 'DOMN_SE_CODE':'01'},
		 		type: 'post',
		 		dataType: 'json',
		 		paging: false,
		 		autoLoad: true
		 	},
		 	gridPros: {
			    showRowNumColumn : true,
			    showRowCheckColumn : false,
			    showTooltip : true,
			    tooltipSensitivity : 300,
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    
		 	    editable : true,
			    enableFilter : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
	
			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "singleRows",
	
			    displayTreeOpen : false
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{ 
								dataField : "INSTT_FORM_SN",
								headerText : "INSTT_FORM_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "VISIT_SN",
								headerText : "VISIT_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "SN",
								headerText : "SN",
								editable : false,
								visible : false
							},{ 
								dataField : "VISIT_GROUP_SN",
								headerText : "VISIT_GROUP_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "SET_ROW_SN",
								headerText : "SET_ROW_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "VRIABL_ROW_SN",
								headerText : "VRIABL_ROW_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "SET_VRIABL_SN",
								headerText : "SET_VRIABL_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "STRE_VALUE",
								headerText : "STRE_VALUE",
								editable : false,
								visible : false
							},{ 
								dataField : "INNSER_VALUE",
								headerText : "INNSER_VALUE",
								editable : false,
								visible : false
							},{ 
								dataField : "VRIABL_SN",
								headerText : "VRIABL_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "CODING_SN",
								headerText : "CODING_SN",
								editable : false,
								visible : false
							},{ 
								dataField : "PV_CNFIRM_CODE",
								headerText : "PV_CNFIRM_CODE",
								editable : false,
								visible : false
							},{ 
								dataField : "CRA_CNFIRM_CODE",
								headerText : "CRA_CNFIRM_CODE",
								editable : false,
								visible : false
							},{ 
								dataField : "DICARY_SE_CODE",
								headerText : "DICARY_SE_CODE",
								editable : false,
								visible : false
							},{ 
								dataField : "DICARY_VER",
								headerText : "DICARY_VER",
								editable : false,
								visible : false
							},{ 
								dataField : "INSTT_NM",
								headerText : '<spring:message code="edcg01.gr.INSTT_NM" />',	//"Site",
								editable : false,
								filter : {
									showIcon : true
								}
							},{
								dataField : "SUBJECT_NO",
								headerText : '<spring:message code="edcg01.gr.SUBJECT_NO" />',	//"Subject",
								editable : false,
								filter : {
									showIcon : true
								}
							},{
								dataField : "VISIT_LBL",
								headerText : '<spring:message code="edcg01.gr.VISIT_LBL" />',	//"Visit",
								editable : false,
								filter : {
									showIcon : true
								}
							},{
								dataField : "DICARY_SE_NM",
								headerText : '<spring:message code="edcg01.gr.INPUT" />',	//"입력",
								editable : false,
								tooltip : {
									tooltipFunction : function(rowIndex, columnIndex, value, headerText, item, dataField){
										var rsltData;
										var params = AUIGrid.getItemByRowIndex("grid_wrap", rowIndex); 
										
										$.ajax({
											url : "<c:url value='/edc/g01/selectDicaryInfo.do'/>",
											type : 'post',
// 											contentType : "application/json; charset=UTF-8",
											data : params,
											doNotAjaxSetup:true,
											success : function(data, textStatus, jqXHR){
												if(data.success){
													rsltData = data.result;
												}else{
													//AUIGrid.removeAjaxLoader(grid_csList.id);
													alert(data.message);
												}
											},
											error : function(jqXHR, textStatus, errorThrown){
												alert(textStatus);
											}
										});
										
										var str = "<table class='tb001'>";
										for(var i=0; i<rsltData.length; i++){
											var rsltDataRow = rsltData[i];
											var keys = Object.keys(rsltDataRow);
											
											str += "<tr>";
											for(var j in keys){
												str += "<td>"+rsltDataRow[keys[j]]+"</td>";
											}
											str += "</tr>";
										}
										str += "</tr></table>";
										
										return str;
									}
								},
								filter : {
									showIcon : true
								}
							},{
								dataField : "GROUP_LBL",
								headerText : '<spring:message code="edcg01.gr.GROUP_LBL" />',	//"CRF",
								editable : false,
								filter : {
									showIcon : true
								}
							},{
								dataField : "ABN_RCT",
								headerText : '<spring:message code="edcg01.gr.ADV_REACT" />',	//"이상반응",
								editable : false,
								filter : {
									showIcon : true
								}
							},{
								dataField : "RUSR_CODING",
								headerText : '<spring:message code="edcg01.gr.RSRCH_CODING" />',	//"연구자 Coding",
								editable : false,
								filter : {
									showIcon : true
								}
							},{
								dataField : "INNER_CODING",
								headerText : '<spring:message code="edcg01.gr.INNR_CODING" />',	//"내부 Coding",
								editable : false,
								filter : {
									showIcon : true
								}
							},{
								dataField : "PV_CNFIRM_NM",
								headerText : '<spring:message code="edcg01.gr.PV_CNFIRM_CODE" />',	//"Coder",
								editable : true,
								editRenderer : {
									type : "DropDownListRenderer",
									list : ["확인", "수정"]
								},
								filter : {
									showIcon : true
								}
							},{
								dataField : "CRA_CNFIRM_NM",
								headerText : '<spring:message code="edcg01.gr.CRA_CNFIRM_CODE" />',	//"CRA",
								editable : true,
								editRenderer : {
									type : "DropDownListRenderer",
									list : ["확인", "Query"]
								},
								filter : {
									showIcon : true
								}
							}],
		 	
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		gridMainID = me.id;
		 		
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	
		 	//AUI 그리드 이벤트 
		 	binding: function() {
		 		var me = this;
		 		
		 		AUIGrid.bind(me.id, "cellClick", function(event) {
				});
		 		

		 		
				AUIGrid.bind(me.id, "cellEditBegin", function(event) {
					g_rowData = event.item;
					if(event.dataField == "PV_CNFIRM_NM"){
						if(event.value != "미확인"){
							return false;
						}
					}else if(event.dataField == "CRA_CNFIRM_NM"){
						if(event.item.PV_CNFIRM_CODE != "02"){
							return false;
						}
					}
				});
				
				AUIGrid.bind(me.id, "cellEditEndBefore", function(event){
					if(event.dataField == "PV_CNFIRM_NM"){
						if(event.value == "수정"){
							var params = new Object();
							mkLayerPopupOpen("<c:url value='/edc/g01/popupEDCG0106.do'/>", params);	//coding 작성 popup
						}
					}else if(event.dataField == "CRA_CNFIRM_NM"){
						if(event.value == "Query"){
							var params = new Object();
							params = event.item;
							mkLayerPopupOpen("<c:url value='/edc/g01/popupEDCG0104.do'/>", params);	//Query 발행 popup
						}
					}
					return event.value;
				});
				
				AUIGrid.bind(me.id, "cellEditEnd", function(event){
					if(event.dataField == "PV_CNFIRM_NM"){
						if(event.value == "확인"){
							event.item.gbn = "PV";
							event.item.PV_CNFIRM_CODE = "02";
							fn_chngPvCraCode(event.item);	//PV_CNFIRM_CODE update
						}
					}else if(event.dataField == "CRA_CNFIRM_NM"){
						if(event.value == "확인"){
							event.item.gbn = "CRA";
							event.item.CRA_CNFIRM_CODE = "02";
							fn_chngPvCraCode(event.item);	//CRA_CNFIRM_CODE update
						}
					}
				});
	
		 	},
		 	load: function(v1, v2) {
		 		var me = this;
		 		fn_load(me, v1, v2)
		 	}
		};	
		
	$(document).ready(function(){
	
		$("#frm_main #TASK_SN").val(taskSn);
		
		grid_csList.createGrid();		
		
		//검색버튼 클릭
		$('#btnSearch').click(function(){
			var params = {
			};
			
			params.INSTT_NM = $('#INSTT_NM').val();
			params.SUBJECT_NO = $('#SUBJECT_NO').val();
			params.TASK_SN = $('#TASK_SN').val();
			params.DOMN_SE_CODE = $('#DOMN_SE_CODE').val();
			
			grid_csList.proxy.param = params;
			grid_csList.load();
		})
		
	});
	
	function fn_chngPvCraCode(e){	//PV_CNFIRM_CODE update
		var params = {};
	
		params.INSTT_FORM_SN = e.INSTT_FORM_SN;
		params.SUBJECT_NO = e.SUBJECT_NO;
		params.VISIT_SN = e.VISIT_SN;
		params.SN = e.SN;
		params.VISIT_GROUP_SN = e.VISIT_GROUP_SN;
		params.SET_ROW_SN = e.SET_ROW_SN;
		params.VRIABL_ROW_SN = e.VRIABL_ROW_SN;
		params.SET_VRIABL_SN = e.SET_VRIABL_SN;
	
		if(e.gbn == "PV"){
			params.PV_CNFIRM_CODE = e.PV_CNFIRM_CODE;
		}else if(e.gbn == "CRA"){
			params.CRA_CNFIRM_CODE = e.CRA_CNFIRM_CODE;
		}
		var arJson = params;
	
		$.ajax({
			url : "<c:url value='/edc/g01/updateEdcCfVriablByPvCraCnfirmCode.do'/>",
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(arJson),
			success : function(data, textStatus, jqXHR){
				if(data.success){
					grid_csList.load();
				}else{
					AUIGrid.removeAjaxLoader(grid_csList.id);
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	}
	
	// 윈도우 리사이징 이벤트
	$(window).resize(function(){
		if (grid_csList.id) {
			AUIGrid.resize(grid_csList.id);
		}
	});
</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCG0103&&UPPER_MENU_ID=EDCG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCG0101&&UPPER_MENU_ID=EDCG" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>${ progrmMap.MENU_NM }</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="<c:url value='/images/pantheon/common/pathNavIco.png' />" alt="">Home</li>
						<li>${ progrmMap.UPPER_MENU_NM }</li>
						<li>${ progrmMap.MENU_NM }</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner">
						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="tab_01" class="tab_menu" onclick="fn_moveTab('EDCG0101');"><spring:message code="edcg01.tab.CASE_HIST" /></li><!-- 병력 -->
								<li id="tab_02" class="port_back tab_menu"><spring:message code="edcg01.tab.ADV_REACT" /></li><!-- 이상반응 -->
								<li id="tab_03" class="tab_menu" onclick="fn_moveTab('EDCG0102');"><spring:message code="edcg01.tab.PRE_JOIN_DRUG" /></li><!-- 선행/병용약물 -->
							</ul>
						</div>
						<article style="overflow:hidden;">
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold';"><spring:message code="edcg01.lbl.INSTT_NM" /> :</span><!-- Site -->
								<input type="text" id="INSTT_NM" name="INSTT_NM" style="width: 200px;">
								<span style="font-family:'NanumGothicBold'; margin-left: 20px;"><spring:message code="edcg01.lbl.SUBJECT_NO" /> :</span><!-- Subject -->
								<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" style="width: 140px;">
								<button class="oneBtn" id="btnSearch" type="sumit">
									<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png' />" alt='<spring:message code="button.search" />'><!-- 검색 -->
								</button>
							</div>
							<div class="conTitBtnR">									
								<input type="button" id="btnFormDownload" 	class="popup_01" value='<spring:message code="edcg01.btn.FORM_DOWNLOAD" />'><!-- 양식 다운로드 -->
								<input type="button" id="btnUpload" 		class="popup_02" value='<spring:message code="edcg01.btn.UPLOAD" />'><!-- 업로드 -->
								<input type="button" id="btnPkgCoding" 		class="popup_03" value='<spring:message code="edcg01.btn.BATCH_CODING" />'><!-- 일괄 Coding -->
							</div>
						</article>
	 					<article class="mgT16">
	                        <div id="grid_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                    </article>
	                    <form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="DOMN_SE_CODE" name="DOMN_SE_CODE" value="03">
						</form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>


</html>