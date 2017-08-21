<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title>${progrmMap.MENU_NM}</title>
<script>
var grCdiscRule = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grCdiscRule'
 	},
 	proxy: {
 		param: {},
 		url: "<c:url value='/com/c01/selectCdiscRuleList.do'/>",
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: true
 	},
 	gridPros: {
 		showStateColumn: true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    enableFilter : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	columnLayout : [{
 		dataField : "CDISC_VER",
 		headerText : '<spring:message code="comc0101.gr.CDISC_VER"/>',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FRST_CREDE",
 		headerText : '<spring:message code="comc0101.gr.FRST_CREDE"/>',
 		dataType:"date",
 		formatString : "yyyy-mm-dd",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDUSR_NM",
 		headerText : '<spring:message code="comc0101.gr.LAST_UPDUSR"/>',
 		filter : {
 			showIcon : true
 		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
		window.setTimeout(function(){
			AUIGrid.resize(me.id);
		}, 0.5);
		
		grCdiscDomn.createGrid();
		grCdiscClCode.createGrid();
		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 		
		AUIGrid.bind(me.id, 'selectionChange', function(e) {
			grCdiscDomn.proxy.param['CDISC_RULE_SN'] = e.selectedItems[0].item['CDISC_RULE_SN'];
			grCdiscDomn.load();
			
			grCdiscClCode.proxy.param['CDISC_RULE_SN'] = e.selectedItems[0].item['CDISC_RULE_SN'];
			grCdiscClCode.load();
		});

 	},
 	load: function() {
 		var me = this;
 		
 		AUIGrid.showAjaxLoader(me.id);
 		
 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	if(data.count && me.proxy.paging) {
 			    		me.div.paging.totalRowCount = data.count;
 			    		me.createPagingNavigator(me.div.paging.currentPage);
 			    	}
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

var grCdiscDomn = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grCdiscDomn',
 		paging: {
 			pagingDiv: 'pgCdiscDomn',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		}
 	},
 	proxy: {
 		param: {},
 		url: "<c:url value='/com/c01/selectCdiscDomnListByCdiscRuleSn.do'/>",
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: false
 	},
 	gridPros: {
 		showStateColumn: true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    enableFilter : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	columnLayout : [{
 		dataField : "DOMN_NM",
 		headerText : "Dataset",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "DOMN_DC",
 		headerText : "Description",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "DOMN_CLASS",
 		headerText : "Class",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "DOMN_STRCT",
 		headerText : "Structure",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "DOMN_PURPS",
 		headerText : "Purpose",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "DOMN_KEYS",
 		headerText : "Keys",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "DOMN_LOCATION",
 		headerText : "Location",
 		filter : {
 			showIcon : true
 		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
		window.setTimeout(function(){
			AUIGrid.resize(me.id);
		}, 0.5);
 		
		grCdiscDomnVriabl.createGrid();
		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 		
		AUIGrid.bind(me.id, 'selectionChange', function(e) {
			grCdiscDomnVriabl.proxy.param['CDISC_DOMN_SN'] = e.selectedItems[0].item['CDISC_DOMN_SN'];
			grCdiscDomnVriabl.load();
		});
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		if(me.proxy.paging && !v1 && !v2) {
 			me.proxy.param.page = me.div.paging.currentPage;		
 			me.proxy.param.count= me.div.paging.rowCount;		
 		}
 		
 		if(v1 && v2) {
 			me.proxy.param.page = v2;	
 			me.div.paging.currentPage = v2;
 			me.proxy.param.count = v1;		
 			me.div.paging.rowCount = v1;		
 		}
 		
 		AUIGrid.showAjaxLoader(me.id);
 		
 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	if(data.count && me.proxy.paging) {
 			    		me.div.paging.totalRowCount = data.count;
 			    		me.createPagingNavigator(me.div.paging.currentPage);
 			    	}
 		    	} else {
 		    		AUIGrid.removeAjaxLoader(me.id);
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
 	},
	createPagingNavigator : function(goPage) {
		var me = this;
		if (!me.div.paging.pagingDiv) {
			return;
		}
		fn_createPagingNavigator(me, goPage);
	},
 	moveToPage: function(goPage, rowCount) {
 		var me = this;
 		
 		if(!me.div.paging.pagingDiv) { 
 			return;
 		}
 		
 		// 현재 페이지 보관
 		me.div.paging.currentPage = goPage;
 		
 		// selectBox에서 요청시, 1페이지부터 시작
 		if(rowCount) {
 			me.div.paging.rowCount = rowCount;
 			me.div.paging.currentPage = 1;
 			goPage = 1;
 		}
 		
 		me.load(me.div.paging.rowCount, goPage);
 	}
};

var grCdiscDomnVriabl = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grCdiscDomnVriabl',
 		paging: {
 			pagingDiv: 'pgCdiscDomnVriabl',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		}
 	},
 	proxy: {
 		param: {},
 		url: "<c:url value='/com/c01/selectCdiscDomnVriablListByCdiscDomnSn.do'/>",
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: false
 	},
 	gridPros: {
 		showStateColumn: true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    enableFilter : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	columnLayout : [{
 		dataField : "CDISC_UPPER_CODE",
 		headerText : "Codelist Code",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "DOMN_NM",
 		headerText : "Domain Name",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LBL_ORDR",
 		headerText : "OrderNum",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "VRIABL_NM",
 		headerText : "Variable Name",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "VRIABL_LBL",
 		headerText : "Variable Label",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "VRIABL_TY_CODE",
 		headerText : "Type",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CTRL_FOM",
 		headerText : "Controlled Terms",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CRF_LBL_ONE",
 		headerText : "CRF LABEL1",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CRF_LBL_TWO",
 		headerText : "CRF LABEL2",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "VRIABL_ROLE",
 		headerText : "Role",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "VRIABL_DC",
 		headerText : "CDISC Notes",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CORE_CODE",
 		headerText : "Core",
 		filter : {
 			showIcon : true
 		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
		window.setTimeout(function(){
			AUIGrid.resize(me.id);
		}, 0.5);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		if(me.proxy.paging && !v1 && !v2) {
 			me.proxy.param.page = me.div.paging.currentPage;		
 			me.proxy.param.count= me.div.paging.rowCount;		
 		}
 		
 		if(v1 && v2) {
 			me.proxy.param.page = v2;	
 			me.div.paging.currentPage = v2;
 			me.proxy.param.count = v1;		
 			me.div.paging.rowCount = v1;		
 		}
 		
 		AUIGrid.showAjaxLoader(me.id);
 		
 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	if(data.count && me.proxy.paging) {
 			    		me.div.paging.totalRowCount = data.count;
 			    		me.createPagingNavigator(me.div.paging.currentPage);
 			    	}
 		    	} else {
 		    		AUIGrid.removeAjaxLoader(me.id);
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
 	},
	createPagingNavigator : function(goPage) {
		var me = this;
		if (!me.div.paging.pagingDiv) {
			return;
		}
		fn_createPagingNavigator(me, goPage);
	},
 	moveToPage: function(goPage, rowCount) {
 		var me = this;
 		
 		if(!me.div.paging.pagingDiv) { 
 			return;
 		}
 		
 		// 현재 페이지 보관
 		me.div.paging.currentPage = goPage;
 		
 		// selectBox에서 요청시, 1페이지부터 시작
 		if(rowCount) {
 			me.div.paging.rowCount = rowCount;
 			me.div.paging.currentPage = 1;
 			goPage = 1;
 		}
 		
 		me.load(me.div.paging.rowCount, goPage);
 	}
};

var grCdiscClCode = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grCdiscClCode',
 		paging: {
 			pagingDiv: 'pgCdiscClCode',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		}
 	},
 	proxy: {
 		param: {},
 		url: "<c:url value='/com/c01/selectCdiscClCodeByCdiscRuleSn.do'/>",
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: false
 	},
 	gridPros: {
 		showStateColumn: true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    enableFilter : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "CDISC_CODE",
 		headerText : "Code",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CDISC_UPPER_CODE",
 		headerText : "Codelist Code",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "ESTN_POSBL_AT",
 		headerText : "Codelist Extensible (Yes/No)",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CODE_NM",
 		headerText : "Codelist Name",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CDISC_SUBMIT_VALUE",
 		headerText : "CDISC Submission Value",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CDISC_SYNONM",
 		headerText : "CDISC Synonym(s)",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "CDISC_DFN",
 		headerText : "CDISC Definition",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "NCI_NM",
 		headerText : "NCI Preferred Term",
 		filter : {
 			showIcon : true
 		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
		window.setTimeout(function(){
			AUIGrid.resize(me.id);
		}, 0.5);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		if(me.proxy.paging && !v1 && !v2) {
 			me.proxy.param.page = me.div.paging.currentPage;		
 			me.proxy.param.count= me.div.paging.rowCount;		
 		}
 		
 		if(v1 && v2) {
 			me.proxy.param.page = v2;	
 			me.div.paging.currentPage = v2;
 			me.proxy.param.count = v1;		
 			me.div.paging.rowCount = v1;		
 		}
 		
 		AUIGrid.showAjaxLoader(me.id);
 		
 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	if(data.count && me.proxy.paging) {
 			    		me.div.paging.totalRowCount = data.count;
 			    		me.createPagingNavigator(me.div.paging.currentPage);
 			    	}
 		    	} else {
 		    		AUIGrid.removeAjaxLoader(me.id);
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
 	},
	createPagingNavigator : function(goPage) {
		var me = this;
		if (!me.div.paging.pagingDiv) {
			return;
		}
		fn_createPagingNavigator(me, goPage);
	},
 	moveToPage: function(goPage, rowCount) {
 		var me = this;
 		
 		if(!me.div.paging.pagingDiv) { 
 			return;
 		}
 		
 		// 현재 페이지 보관
 		me.div.paging.currentPage = goPage;
 		
 		// selectBox에서 요청시, 1페이지부터 시작
 		if(rowCount) {
 			me.div.paging.rowCount = rowCount;
 			me.div.paging.currentPage = 1;
 			goPage = 1;
 		}
 		
 		me.load(me.div.paging.rowCount, goPage);
 	}
};

function callbackFunction() {
	grCdiscRule.load();
}

$(function(){
	$('.popup_01').click(function(){
		mkLayerPopupOpen("/com/c01/COMC0102.do", {
			'callbackFunction': 'callbackFunction'
		});
	});
	
	$('#btnDownload').click(function(){
		window.open("<c:url value='/data/excel/cdisc.xlsx'/>");
	});
	
	grCdiscRule.createGrid();
});

$(window).resize(function() {
	if (grCdiscRule && grCdiscRule.id) {
   		AUIGrid.resize(grCdiscRule.id);
	}
});
</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMC0101&UPPER_MENU_ID=COMC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMC0101&UPPER_MENU_ID=COMC" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>${progrmMap.MENU_NM}</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="<c:url value='/images/pantheon/common/pathNavIco.png'/>" alt="">Home</li>
						<li>${progrmMap.UPPER_MENU_NM}</li>
						<li>${progrmMap.MENU_NM}</li>
					</ul>
				</nav>
			</article>
			
            <section class="conBox100 conBox">
				<div class="conBoxInner">
                    <article class="conTitBox">
                        <h5><spring:message code="comc0101.title.1" /></h5>
                    </article>
							
					<div class="conTitBtnR">									
						<input type="button" class="popup_01" value=<spring:message code="btn.upload"/> >
						<input type="button" id="btnDownload" value=<spring:message code="btn.formDownload"/> >
					</div>

 					<article class="mgT16">
                        <div id="grCdiscRule" class="gridHeiSz04 grid_wrap tb01_2"></div>
                    </article>
				</div>
            </section>

            <section class="conBox100 conBox">
				<div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>domain</h5>
                    </article>
							
 					<article class="mgT16">
                        <div id="grCdiscDomn" class="gridHeiSz10 grid_wrap tb01_2"></div>
                        <div id="pgCdiscDomn" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
				</div>
            </section>
            
            <section class="conBox100 conBox">
				<div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>variable</h5>
                    </article>
							
 					<article class="mgT16">
                        <div id="grCdiscDomnVriabl" class="gridHeiSz10 grid_wrap tb01_2"></div>
                        <div id="pgCdiscDomnVriabl" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
				</div>
            </section>

            <section class="conBox100 conBox">
				<div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>terminology</h5>
                    </article>
							
 					<article class="mgT16">
                        <div id="grCdiscClCode" class="gridHeiSz10 grid_wrap tb01_2"></div>
                        <div id="pgCdiscClCode" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
				</div>
            </section>


		</div>
	</section>
</div>
</body>
</html>