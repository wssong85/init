<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<script type="text/javascript">
var grCmSysConect = {
 	id: '',
 	div: {
 		gridDiv: '#grCmSysConect',
 		paging: {
 			pagingDiv: 'pgCmSysConect',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: "<c:url value='/com/f04/selectCmSysConectListByCondition.do'/>",
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
	    editable : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true
 	},
 	columnLayout : [{
 		dataField : "CONECT_DT",
 		headerText : '<spring:message code="comf0401.gr.CONECT_DT"/>',
 		formatString : "yyyy-mm-dd HH:MM:ss",
 		dataType:"date",
 		width: 150
 	},{
 		dataField : "USER_ID",
 		headerText : '<spring:message code="comf0401.gr.USER_ID"/>'
 	},{
 		dataField : "USER_NM",
 		headerText : '<spring:message code="comf0401.gr.USER_NM"/>'
 	},{
 		dataField : "CONECT_SE_NM",
 		headerText : '<spring:message code="comf0401.gr.CONECT_SE_NM"/>'
 	},{
 		dataField : "CONECT_IP",
 		headerText : '<spring:message code="comf0401.gr.CONECT_IP"/>'
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
 		
 		me.div.paging.currentPage = goPage;
 		
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
	grCmSysConect.createGrid();
	
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
	
	$('#btnCmDtaAtrailSearch').click(function() {
		var params = {
			'SDATE': $('#txtStartDate').val(),
			'EDATE': $('#txtEnd').val(),
			'USER_NM': $('#txtUserNm').val(),
			'USER_SE_CODE': $('#selectModules').val()
		};
		
		grCmSysConect.proxy.param = params;
		grCmSysConect.load();
	});
	
	$('#btnCmDtaAtrailExcel').click(function() {
		
		var data = AUIGrid.getGridData(grCmSysConect.id);
		
		if(data.length) {
			AUIGrid.setProperty(grCmSysConect.id, "exportURL", "<c:url value='/com/z02/downloadAuiGridFile.do'/>");
			AUIGrid.exportToXlsx(grCmSysConect.id, true);
		} else {
			alert('data is null!!');
		}
	});
	
});

$(window).on('resize', function(){
	if (grCmSysConect.id) {
		AUIGrid.resize(grCmSysConect.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMF0401&&UPPER_MENU_ID=COMF" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMF0401&&UPPER_MENU_ID=COMF" charEncoding="utf-8"/>
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
						<label style="width:65px;text-align:right;display:block;float:left;"><spring:message code="comf0401.table.th.1" />: </label>
					</th>
					<td style="width:270px">
						<div class="dateBox" ><input id="txtStartDate" type="text" style="width:120px;" /></div>
						~
						<div class="dateBox" ><input id="txtEndDate" type="text" style="width:120px;" /></div>
					</td>
					<th style="width:72px">
						<label style="width:65px;text-align:right;display:block;float:left;"><spring:message code="comf0401.table.th.2" />: </label>
					</th>
					<td style="width:80px">
						<input type="text" id="txtUserNm" style="width:80px"/>
					</td>
					<td style="width:5px">
					</td>
					<td style="width:215px">
						<select id="selectModules" style="width:88px;vertical-align: top;">
							<option>===selected===</option>
						</select>
						<input type="button" id="btnCmDtaAtrailSearch" value=<spring:message code="btn.search.1" />>
						<input type="button" id="btnCmDtaAtrailExcel" value=<spring:message code="comf0501.table.th.3" />>
					</td>
				</tr>
				</tbody>
				</table>
				</div>
				</article>
				
				<article class="mgT20">
					<div id="grCmSysConect" class="gridHeiSz17 grid_wrap tb01_2"></div>
					<div id="pgCmSysConect" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				</article>
			</div>
		</section>
		</div>
	</section>
</div>
</body>
</html>