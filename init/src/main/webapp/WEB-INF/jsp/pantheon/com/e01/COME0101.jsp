<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>

<style>
.order_style_01{ text-align:center; }
.icon_green_01 { width:12px; height:12px; border-radius: 50%; box-sizing: border-box;  display: inline-block; background: #00d27c; margin:12px 0 0 11px; }
.icon_red_01{width:12px; height:12px; border-radius: 50%; box-sizing: border-box;   display: inline-block; background: #ff3a3a;margin:12px 0 0 11px;}

</style>

<script type="text/javascript">
var grCmIntrfc = {
 	id: '',
 	div: {
 		gridDiv: '#grCmIntrfc',
 		paging: {
 			pagingDiv: 'pgCmIntrfc',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: '/com/e01/selectCmIntrfcByCondition.do',
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: true
 	},
 	gridPros: {
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
// 	    editable : true,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
// 	    displayTreeOpen : true,
 	},
 	columnLayout : [{
 		dataField : "OPERT_SN",
 		headerText : '<span style="text-align:center;">No.</span>',
 		style:"order_style_01",
 		width: 50,
 		visible: false
 	},{
 		dataField : "OPERT_DT",
 		headerText : '<spring:message code="come0101.gr.OPERT_DT"/>',
 		formatString : "yyyy-mm-dd HH:MM:ss",
 		dataType:"date",
 		width: 150
 	},{
 		dataField : "OPERT_NM",
 		headerText : '<spring:message code="come0101.gr.OPERT_NM"/>',
 		width: 150
 	},{
 		dataField : "OPERT_STTUS",
 		headerText : '<spring:message code="come0101.gr.OPERT_STTUS"/>',
 		width: 60,
 		renderer: {
 			type: 'TemplateRenderer'
 		}, 
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			if(value == '01') {
				return '<div class="icon_green_01"></div>';
			} else {
				return '<div class="icon_red_01"></div>';
			}
		}
 	},{
 		dataField : "STTUS_RESN",
 		headerText : '<spring:message code="come0101.gr.STTUS_RESN"/>'
 	}],
 	createGrid: function() {
 		var me = this;
   		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		
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
 	//페이징 에서 어느 페이지로 갈 것인지 지정
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

$(function(){
	mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -7, 0);
	grCmIntrfc.createGrid();

	$('#btnCmIntrfcSearch').click(function() {
		var params = {
			'SDATE': $('#txtStartDate').val(),
			'EDATE': $('#txtEndDate').val(),
			'OPERT_NM': $('#txtOpertNm').val()
		};
		
		grCmIntrfc.proxy.param = params; 
		grCmIntrfc.load();
	})
	
	
	$('#txtOpertNm').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $.trim($('#txtOpertNm').val())) {
			$('#btnCmIntrfcSearch').trigger('click');
		}
	});
	
});

$(window).on('resize', function(){
	if (grCmIntrfc && grCmIntrfc.id) {
		AUIGrid.resize(grCmIntrfc.id);
	}
});
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COME0101&&UPPER_MENU_ID=COME" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COME0101&&UPPER_MENU_ID=COME" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner" style="min-height:900px;">
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

            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
				<div class="conBoxInner">
	
                	<!-- 컨텐츠 타이틀 끝-->		
					<article class="conTitBtn" style="margin-top:0px;">
						<article class="conTitBox">
							<h5>${progrmMap.MENU_NM}</h5>
						</article>
						
						<div style="float:right;">
						<table>
						<tbody>
						<tr>
							<th style="width:70px">
								<label style="width:65px;text-align:right;display:block;float:left;"><spring:message code="come0101.table.th.1" />: </label>
							</th>
							<td style="width:270px">
								<div class="dateBox" ><input id="txtStartDate" type="text" style="width:120px;" /></div>
								~
								<div class="dateBox"><input id="txtEndDate" type="text" style="width:120px;" /></div>
							</td>
							<th style="width:95px">
								<label style="width:90px;text-align:right;display:block;float:left;"><spring:message code="come0101.table.th.2" />: </label>
							</th>
							<td style="width:130px">
								<input type="text" id="txtOpertNm" style="width:130px"/>
							</td>
							<td style="width:5px">
							</td>
							<td style="width:50px">
								<input type="button" id="btnCmIntrfcSearch" class="btn mgL3" value=<spring:message code="btn.search.1"/>>
							</td>
						</tr>
						</tbody>
						</table>
						</div>
					</article>

					<article class="mgT13">
						<div id="grCmIntrfc" class="gridHeiSz17 grid_wrap tb01_2"></div>
						<div id="pgCmIntrfc" class="aui-grid-paging-panel my-grid-paging-panel"></div>
					</article>
                </div>
            </section>
		</div>
	</section>
</div>
</body>
</html>