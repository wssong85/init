<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript" src="/js/pantheon/common/unified.cubesafety.js"></script>
<!DOCTYPE HTML>
<style>
</style>
<script type="text/javascript">
	var dicMeddraData = {};
	var dicAtcData = {};
	var dicWhoartData = {};
	var dicKimsData = {};
	var dicKcdData = {};
	
	var grid_dicMeddra = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_dicMedddra_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
	 	},
	 	proxy : {
	 		
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
							dataField : "STRE_VALUE",
							headerText : "INSTT_FORM_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_CODE",
							headerText : "DICARY_SE_CODE",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_NM",
							headerText : "DICARY_SE_NM",
							editable : false,
							visible : false
						},{
							dataField : "ABN_RCT",
							headerText : '<spring:message code="edcg01.gr.ADV_REACT" />',	//"이상반응",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "LLC",
							headerText : 'LLC',	//"LLC",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "PT",
							headerText : 'PT',	//"PT",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "HLT",
							headerText : 'HLT',	//"HLT",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "HLGT",
							headerText : 'HLGT',	//"HLGT",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SOC",
							headerText : 'SOC',	//"SOC",
							editable : false,
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
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		fn_load(me, v1, v2)
	 	}
	};	

	var grid_dicAtc = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_dicAtc_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
	 	},
	 	proxy : {
	 		
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
							dataField : "STRE_VALUE",
							headerText : "INSTT_FORM_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_CODE",
							headerText : "DICARY_SE_CODE",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_NM",
							headerText : "DICARY_SE_NM",
							editable : false,
							visible : false
						},{
							dataField : "ABN_RCT",
							headerText : '<spring:message code="edcg01.gr.ADV_REACT" />',	//"이상반응",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "FIVE_T_LVL",
							headerText : 'FIVE_T_LVL',	//"FIVE_T_LVL",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "FOUR_T_LVL",
							headerText : 'FOUR_T_LVL',	//"FOUR_T_LVL",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "THREE_T_LVL",
							headerText : 'THREE_T_LVL',	//"THREE_T_LVL",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "TWO_T_LVL",
							headerText : 'TWO_T_LVL',	//"TWO_T_LVL",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ONE_T_LVL",
							headerText : 'ONE_T_LVL',	//"ONE_T_LVL",
							editable : false,
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
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		fn_load(me, v1, v2)
	 	}
	};

	var grid_dicWhoart = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_dicWhoart_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
	 	},
	 	proxy : {
	 		
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
							dataField : "STRE_VALUE",
							headerText : "INSTT_FORM_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_CODE",
							headerText : "DICARY_SE_CODE",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_NM",
							headerText : "DICARY_SE_NM",
							editable : false,
							visible : false
						},{
							dataField : "ABN_RCT",
							headerText : '<spring:message code="edcg01.gr.ADV_REACT" />',	//"이상반응",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "KOREAN_NM",
							headerText : 'KOREAN_NM',	//"KOREAN_NM",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ENG_NM",
							headerText : 'ENG_NM',	//"ENG_NM",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ARRN_CODE",
							headerText : 'ARRN_CODE',	//"ARRN_CODE",
							editable : false,
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
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		fn_load(me, v1, v2)
	 	}
	};

	var grid_dicKims = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_dicKims_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
	 	},
	 	proxy : {
	 		
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
							dataField : "STRE_VALUE",
							headerText : "INSTT_FORM_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_CODE",
							headerText : "DICARY_SE_CODE",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_NM",
							headerText : "DICARY_SE_NM",
							editable : false,
							visible : false
						},{
							dataField : "ABN_RCT",
							headerText : '<spring:message code="edcg01.gr.ADV_REACT" />',	//"이상반응",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "GOODS_NM",
							headerText : 'GOODS_NM',	//"GOODS_NM",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "GOODS_ENG",
							headerText : 'GOODS_ENG',	//"GOODS_ENG",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SLE_CMPNY",
							headerText : 'SLE_CMPNY',	//"SLE_CMPNY",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SLE_CMPNY_ENG",
							headerText : 'SLE_CMPNY_ENG',	//"SLE_CMPNY_ENG",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ATC_CODE",
							headerText : 'ATC_CODE',	//"ATC_CODE",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ATC_NM",
							headerText : 'ATC_NM',	//"ATC_NM",
							editable : false,
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
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		fn_load(me, v1, v2)
	 	}
	};

	var grid_dicKcd = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_dicKcd_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
	 	},
	 	proxy : {
	 		
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
							dataField : "STRE_VALUE",
							headerText : "INSTT_FORM_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_CODE",
							headerText : "DICARY_SE_CODE",
							editable : false,
							visible : false
						},{ 
							dataField : "DICARY_SE_NM",
							headerText : "DICARY_SE_NM",
							editable : false,
							visible : false
						},{
							dataField : "ABN_RCT",
							headerText : '<spring:message code="edcg01.gr.ADV_REACT" />',	//"이상반응",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "DISS_CODE",
							headerText : 'DISS_CODE',	//"DISS_CODE",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "KOREAN_NM",
							headerText : 'KOREAN_NM',	//"KOREAN_NM",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ENG_NM",
							headerText : 'ENG_NM',	//"ENG_NM",
							editable : false,
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
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		fn_load(me, v1, v2)
	 	}
	};
	
	$(document).ready(function(){
	
		var paramData = {
		};
		
		paramData.INSTT_NM = $('#INSTT_NM').val();
		paramData.SUBJECT_NO = $('#SUBJECT_NO').val();
		paramData.TASK_SN = $('#TASK_SN').val();
		paramData.DOMN_SE_CODE = $('#DOMN_SE_CODE').val();
		
		$.ajax({
			url : "<c:url value='/edc/g01/selectDistinctDAbnRct.do'/>",
			type : 'post',
// 			contentType : "application/json; charset=UTF-8",
			data : paramData,
			success : function(data, textStatus, jqXHR){
				if(data.success){
					console.log("data.result : "+data.result);
					var rsltData = data.result;
					for(var i=0; i<rsltData.length; i++){
						var tmp = rsltData[i];

						if(tmp.DICARY_SE_CODE == '01'){
							if(!AUIGrid.isCreated(grid_dicMeddra.id)){
								grid_dicMeddra.createGrid();
								AUIGrid.addRow(grid_dicMeddra.id, tmp, 'last');	
// 								$('#grid_dicMedddra_wrap').css({"display":"none"});
							}else{
								AUIGrid.addRow(grid_dicMeddra.id, tmp, 'last');	
// 								$('#grid_dicMedddra_wrap').css({"display":"block"});
							}							
						}
						else if(tmp.DICARY_SE_CODE == '02'){
							if(!AUIGrid.isCreated(grid_dicAtc.id)){
								grid_dicAtc.createGrid();
								AUIGrid.addRow(grid_dicAtc.id, tmp, 'last');	
							}else{
								AUIGrid.addRow(grid_dicAtc.id, tmp, 'last');	
							}
						}else if(tmp.DICARY_SE_CODE == '03'){
							if(!AUIGrid.isCreated(grid_dicWhoart.id)){
								grid_dicWhoart.createGrid();
								AUIGrid.addRow(grid_dicWhoart.id, tmp, 'last');	
							}else{
								AUIGrid.addRow(grid_dicWhoart.id, tmp, 'last');	
							}
						}else if(tmp.DICARY_SE_CODE == '04'){
							if(!AUIGrid.isCreated(grid_dicKims.id)){
								grid_dicKims.createGrid();
								AUIGrid.addRow(grid_dicKims.id, tmp, 'last');	
							}else{
								AUIGrid.addRow(grid_dicKims.id, tmp, 'last');	
							}
						}else if(tmp.DICARY_SE_CODE == '05'){
							if(!AUIGrid.isCreated(grid_dicKcd.id)){
								grid_dicKcd.createGrid();
								AUIGrid.addRow(grid_dicKcd.id, tmp, 'last');	
							}else{
								AUIGrid.addRow(grid_dicKcd.id, tmp, 'last');	
							}
						}
					}
				}else{
// 					AUIGrid.removeAjaxLoader(grid_csList.id);
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
		
// 		grid_dicMeddra.proxy.param = paramData;		
// 		grid_dicMeddra.createGrid();	
	});
	
	// 윈도우 리사이징 이벤트
	$(window).resize(function(){
		if (grid_dicMeddra.id) {
			AUIGrid.resize(grid_dicMeddra.id);
		}
	});
	
	
	
	
</script>

<section class="popupWrap">
	<!-- 팝업 시작 -->
	<!-- 팝업 세로는 자동지정이지만, 가로는 지정해줘야한다. wd00의 00은 픽셀 사이즈 1~100은 1단위, 1000은 10단위-->
	<!-- popup01은 popup-button01에 맞추는등, 숫자를 맞춰준다 -->
	<div class="popup popup01 wd800">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="conBoxInner">
				<!-- 팝업 내부 컨텐츠 시작 -->
				<article class="conTitBox">
					<h5>일괄 Coding</h5>
				</article>
				<article class="mgT16">
					<!-- 에이유아이 그리드가 이곳에 생성 -->
					
					<div id="grid_dicMedddra_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
				</article>
	 				<article class="mgT10">
	 					<div style="position: absolute; right: 20px; bottom: 20px;">
<%-- 						<input type="button" value="<spring:message code="btn.select" />" onclick="choiceCode();"> --%>
							<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose();">
	 					</div>
					</article>
				<!-- 팝업 내부 컨텐츠 끝 -->
			</div>
		</section>
	</div>
	<!-- 팝업 끝 -->
</section>
<!-- 팝업 wrap 끝 -->