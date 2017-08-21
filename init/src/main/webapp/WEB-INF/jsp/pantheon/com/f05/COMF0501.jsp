<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<script type="text/javascript">
$(document).ready(function() {
	mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -7, 0);
	grCmProgrmConect.createGrid();
});

$(window).on('resize', function(){
	if (grCmProgrmConect.id) {
		AUIGrid.resize(grCmProgrmConect.id);
	}
});

var grCmProgrmConect = {
 	id: '',
 	div: {
 		gridDiv: '#grCmProgrmConect',
 		paging: {
 			pagingDiv: 'pgCmProgrmConect',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		}
 	},
 	proxy: {
 		url: "<c:url value='/com/f05/selectCmProgrmConectListByPk.do'/>",
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
	    editable : true,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    displayTreeOpen : true,
 	},
 	columnLayout : [{
 		dataField : "CONECT_DT",
 		headerText : '<spring:message code="comf0501.gr.CONECT_DT"/>',
 		formatString : "yyyy-mm-dd",
 		dataType:"date"
 	},{
 		dataField : "USER_NM",
 		headerText : '<spring:message code="comf0501.gr.USER_NM"/>'
 	},{
 		dataField : "PROGRM_NM",
 		headerText : '<spring:message code="comf0501.gr.PROGRM_NM"/>'
 	},{
 		dataField : "PROGRM_URL",
 		headerText : '<spring:message code="comf0501.gr.PROGRM_URL"/>'
 	},{
 		dataField : "CONECT_IP",
 		headerText : 'IP'
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
	$.ajax({
		url : "<c:url value='/com/common/selectQueryDataList.do'/>",
		type: 'post',
		dataType: 'json',
		data:{'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'COM001'},
		success : function(data) {
			if(data.success) {
				loadCombo($("#selectModules"), data.result);
				$("#selectModules").val("");
			}
		}
	});
	
	function loadCombo(target, data) {
		var dataArr = [];
		var inx = 0;
		target.empty();

		$(data).each( function() {
			dataArr[inx++] = "<option value=" + this.CMMN_CODE + ">" + this.CMMN_CODE_NM + "</option> ";
		});

		target.append(dataArr);
	}
	
	$('#txtUserNm').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtUserNm').val()) {
			$('#btnCmDtaAtrailSearch').trigger('click');
		}
	});
	
	$('#txtProgrmNm').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtProgrmNm').val()) {
			$('#btnCmDtaAtrailSearch').trigger('click');
		}
	});
	
	$('#btnCmDtaAtrailSearch').click(function() {
		var params = {
			'SDATE': $('#txtStartDate').val(),
			'EDATE': $('#txtEnd').val(),
			'USER_NM': $('#txtUserNm').val(),
			'USER_SE_CODE': $('#selectModules').val(),
			'PROGRM_NM': $('#txtProgrmNm').val()
		};
		
		grCmProgrmConect.proxy.param = params;
		grCmProgrmConect.load();
	});
	
	$('#btnCmDtaAtrailExcel').click(function() {
		
		var data = AUIGrid.getGridData(grCmProgrmConect.id);
		
		if(data.length) {
			AUIGrid.setProperty(grCmProgrmConect.id, "exportURL", "<c:url value='/com/z02/downloadAuiGridFile.do'/>");
			AUIGrid.exportToXlsx(grCmProgrmConect.id, true);
		} else {
			alert('데이터 확인');
		}
	});
	
});
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMF0501&&UPPER_MENU_ID=COMF" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMF0501&&UPPER_MENU_ID=COMF" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
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

				<article class="mgB40">
				
				<div style="float:left;">
					<h5>${progrmMap.MENU_NM}</h5>
				</div>
				
				<div style="float:right;">
				<table>
				<tbody>
				<tr>
					<th style="width:70px">
						<label style="width:65px;text-align:right;display:block;float:left;"><spring:message code="comf0501.table.th.1" />: </label>
					</th>
					<td style="width:270px">
						<div class="dateBox" ><input id="txtStartDate" type="text" style="width:120px;" /></div>
						~
						<div class="dateBox"><input id="txtEndDate" type="text" style="width:120px;" /></div>
					</td>
					<th style="width:72px">
						<label style="width:65px;text-align:right;display:block;float:left;"><spring:message code="comf0501.table.th.2" />: </label>
					</th>
					<td style="width:80px">
						<input type="text" id="txtUserNm" style="width:80px"/>
					</td>
					
					<td style="width:5px">
					</td>
					
					<td style="width:100px">
						<select id="selectModules" style="width:100px;vertical-align: top;">
							<option>===selected===</option>
						</select>
					</td>
					
					<th>
					<label style="width:80px;text-align:right;display:block;float:left;"><spring:message code="comf0501.table.th.4" />: </label>
					</th>
					<td style="width:120px">
						<input type="text" id="txtProgrmNm" style="width:120px"/>
					</td>
					
					<td style="width:5px">
					</td>
					<td>
						<input type="button" id="btnCmDtaAtrailSearch" value=<spring:message code="btn.search.1" />>
						<input type="button" id="btnCmDtaAtrailExcel" value=<spring:message code="comf0401.table.th.3" />>
					</td>
					
					
					
				</tr>
				</tbody>
				</table>
				</div>
				</article>
				
				<article class="mgT20">
					<div id="grCmProgrmConect" class="gridHeiSz17 grid_wrap tb01_2"></div>
					<div id="pgCmProgrmConect" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				</article>
			</div>
		</section>
		
		</div>
	</section>
</div>
</body>
</html>