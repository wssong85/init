<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title>${progrmMap.MENU_NM}</title>
<script>
var grEdcCrMdic = {
 	id: '',
 	gridHeight: 'gridHeiSz10',
 	div: {
 		gridDiv: '#grEdcCrMdic'
 	},
 	proxy: {
 		url: "<c:url value='/com/c03/selectEdcCrMdicByDicarySeCode.do'/>",
 		param: {'DICARY_SE_CODE':'01'},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
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
 		dataField : "DICARY_VER",
 		headerText : '<spring:message code="comc02.gr.DICARY_VER"/>',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FRST_CREDE",
 		headerText : '<spring:message code="comc02.gr.FRST_CREDE"/>',
 		dataType:"date",
 		formatString : "yyyy-mm-dd",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FRST_CRTR_NM",
 		headerText : '<spring:message code="comc02.gr.FRST_CRTR_NM"/>',
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
 		
 		grEdcCrMeddra.createGrid();
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 		
		AUIGrid.bind(me.id, 'selectionChange', function(e) {
			grEdcCrMeddra.proxy.param['DICARY_VER'] = e.selectedItems[0].item['DICARY_VER'];
			grEdcCrMeddra.proxy.param['DICARY_SE_CODE'] = e.selectedItems[0].item['DICARY_SE_CODE'];
			grEdcCrMeddra.load();
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
 			    	
 			    	try {
	 			    	if(data.result.length < 10) {
							$(me.id).removeClass(me.gridHeight);
							me.gridHeight = 'gridHeiSz0' + data.result.length;
							$(me.id).addClass('gridHeiSz0' + data.result.length);
	 			    	} else {
	 			    		$(me.id).removeClass(me.gridHeight);
	 			    		me.gridHeight = 'gridHeiSz10';
	 			    		$(me.id).addClass('gridHeiSz10');
	 			    	}
 			    	} catch(e) {
 			    		
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


var grEdcCrMeddra = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grEdcCrMeddra',
 		paging: {
 			pagingDiv: 'pgEdcCrMeddra',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		}
 	},
 	proxy: {
 		url: "<c:url value='/com/c02/selectEdcCrMeddraByPk.do'/>",
 		param: {},
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
 		dataField : "LLT_CODE",
 		headerText : "LLT_CODE",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LLT",
 		headerText : "LLT",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PT",
 		headerText : "PT",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "HLT",
 		headerText : "HLT",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "HLGT",
 		headerText : "HLGT",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "SOC",
 		headerText : "SOC",
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
	grEdcCrMdic.load();
}

$(function(){
	grEdcCrMdic.createGrid();
	
	$('#btnDownload').click(function(){
		window.open("<c:url value='/data/excel/meddra.xlsx'/>");
	});
	
	// 팝업레이어
	$('.popup_01').click(function(){
		mkLayerPopupOpen("<c:url value='/com/c02/COMC0205.do'/>", {
			'callbackFunction': 'callbackFunction'
		});
	});
	
	// 탭메뉴
	$('#tab_01').click(function(){
		window.location.href ="<c:url value='/com/c02/COMC0201.do'/>";
	});
	$('#tab_02').click(function(){
		window.location.href ="<c:url value='/com/c02/COMC0202.do'/>";
	});
	$('#tab_03').click(function(){
		window.location.href ="<c:url value='/com/c02/COMC0203.do'/>";
	});
	$('#tab_04').click(function(){
		window.location.href ="<c:url value='/com/c02/COMC0204.do'/>";
	});
});

$(window).resize(function() {
	if(grEdcCrMdic && grEdcCrMdic.id) {
		AUIGrid.resize(grEdcCrMdic.id);
	}
	if(grEdcCrMeddra && grEdcCrMeddra.id) {
		AUIGrid.resize(grEdcCrMeddra.id);
	}
});
</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMC0201&UPPER_MENU_ID=COMC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMC0201&UPPER_MENU_ID=COMC" charEncoding="utf-8"/>

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
				
					<div id="tab" class="tab tab01 mgT16">
						<ul>
							<li id="tab_01" class="port_back tab_menu">MedDRA</li>
							<li id="tab_02" class="tab_menu" onClick="">ATC</li>
							<li id="tab_03" class="tab_menu" onClick="">WHOART</li>
							<li id="tab_04" class="tab_menu" onClick="">KIMS</li>
						</ul>
					</div>

					<article style="overflow:hidden;">
						<div class="conTitBtnR">									
							<input type="button" class="popup_01" value=<spring:message code="btn.upload" />>
							<input type="button" id="btnDownload" value=<spring:message code="btn.formDownload" />>
						</div>
					</article>

 					<article class="mgT16">
                        <div id="grEdcCrMdic" class="gridHeiSz04 grid_wrap tb01_2"></div>
                    </article>
				</div>
            </section>

            <section class="conBox100 conBox">
				<div class="conBoxInner">
				
                    <article class="conTitBox">
                        <h5>MedDRA</h5>
                    </article>

 					<article class="mgT16">
                        <div id="grEdcCrMeddra" class="gridHeiSz10 grid_wrap tb01_2"></div>
                        <div id="pgEdcCrMeddra" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    
				</div>
            </section>

		</div>
	</section>
</div>
</body>
</html>