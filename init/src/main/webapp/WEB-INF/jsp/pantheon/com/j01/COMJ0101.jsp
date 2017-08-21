<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<script type="text/javascript">
var grCmDtaAtrail = {
 	id: '',
 	div: {
 		gridDiv: '#grCmDtaAtrail',
 		paging: {
 			pagingDiv: 'pgCmDtaAtrail',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: "<c:url value='/com/j01/selectCmDtaAtrailListByPk.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: false
 	},
 	gridPros: {
	    showRowNumColumn : true,
	    showRowCheckColumn : true,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    showStateColumn: true,
	    displayTreeOpen : true
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "UPDT_DE",
 		headerText : "Date/Time",
 		formatString : "yyyy-mm-dd HH:MM:ss",
 		dataType:"date",
 		width: 150
 	},{
 		dataField : "MODULE",
 		headerText : "Module"
 	},{
 		dataField : "TASK_NO",
 		headerText : "TASK_NO"
//  		visible: false
 	},{
 		dataField : "PROGRM_NM",
 		headerText : "PROGRM_NM"
 	},{
 		dataField : "LABEL_NM",
 		headerText : "LABEL_NM"
 	},{
 		dataField : "UPDTBFE_VALUE",
 		headerText : "Before"
 	},{
 		dataField : "AFTUPD_VALUE",
 		headerText : "After"
 	},{
 		dataField : "STRE_ETC_RESN",
 		headerText : "Reason"
 	},{
 		dataField : "STRE_RESN_CODE_NM",
 		headerText : "Reason Code"
 	},{
 		dataField : "CONECT_IP",
 		headerText : "CONECT_IP"
 	},{
 		dataField : "USER_NM",
 		headerText : "USER_NM"
 	},{
 		dataField : "USER_ID",
 		headerText : "User",
 		visible: false
 	},{
 		dataField : "COLUMN_NM",
 		headerText : "Column"
//  		visible: false
 	},{
 		dataField : "PK_NM",
 		headerText : "PK",
 		visible: false
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
 			me.proxy.param.count = v1;		
 			me.div.paging.currentPage = v2;
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
	grCmDtaAtrail.createGrid();

	$.ajax({
		url : "<c:url value='/com/common/selectQueryDataList.do'/>",
		dataType: 'json',
		type: 'post',
		data: {'QUERY': 'selectCmDtaAtrailDistinctByModules'},
		success : function(data) {
			loadCombo($("#selectModules"), data.result);
		}
	});
	
	$.ajax({
		url : "<c:url value='/com/common/selectQueryDataList.do'/>",
		dataType: 'json',
		type: 'post',
		data: {'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'EDC001'},
		success : function(data) {
			loadCombo($("#selectReasonCode"), data.result);
		}
	});
	
	function loadCombo(target, data) {
		var dataArr = [];
		var inx = 0;
		target.empty();
		
		dataArr[inx++] = "<option value=''>선택</option> ";
		
		$(data).each( function() {
			if(target.attr('id') == 'selectModules') {
				dataArr[inx++] = "<option value=" + this.MODULE + ">" + this.MODULE + "</option> ";
			} else {
				dataArr[inx++] = "<option value=" + this.CMMN_CODE + ">" + this.CMMN_CODE_NM + "</option> ";
			}
		});
		target.append(dataArr);
	}
	
	$('#btnCmDtaAtrailSearch').click(function() {
		var params = {
			'SDATE': $('#txtStartDate').val(),
			'EDATE': $('#txtEndDate').val(),
			'LABEL_NM': $('#txtlabelNm').val(),
			'PROGRM_NM': $('#txtProgrmNm').val(),
			'IP': $('#txtConectIp').val(),
			'MODULE': $('#selectModules').val(),
			'STRE_RESN_CODE': $('#selectReasonCode').val(),
			'TASK_NO': $('#txtTaskNo').val()
		};
		
		grCmDtaAtrail.proxy.param = params;
		grCmDtaAtrail.moveToPage(1, grCmDtaAtrail.div.paging.rowCount);
	});
	
	$('#txtlabelNm').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtlabelNm').val()) {
			$('#btnCmDtaAtrailSearch').trigger('click');
		}
	});
	
	$('#txtProgrmNm').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtProgrmNm').val()) {
			$('#btnCmDtaAtrailSearch').trigger('click');
		}
	});
	
	$('#txtConectIp').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtConectIp').val()) {
			$('#btnCmDtaAtrailSearch').trigger('click');
		}
	});
	
	$('#txtTaskNo').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtConectIp').val()) {
			$('#btnCmDtaAtrailSearch').trigger('click');
		}
	});
	
	$("#selectModules").change(function() {
		$('#btnCmDtaAtrailSearch').trigger('click');
	});
	
	$("#selectReasonCode").change(function() {
		$('#btnCmDtaAtrailSearch').trigger('click');
	});
	
	$('#btnCmDtaAtrailExcel').click(function() {
		
		var checkedItems = AUIGrid.getCheckedRowItems(grCmDtaAtrail.id);
		
		if(!checkedItems.length) {
			checkedItems = AUIGrid.getGridData(grCmDtaAtrail.id);
		}
		
		if(checkedItems.length) {
			AUIGrid.setProperty(grCmDtaAtrail.id, "exportURL", "<c:url value='/com/z02/downloadAuiGridFile.do'/>");
			AUIGrid.exportToXlsx(grCmDtaAtrail.id, true);
		} else {
			alert('data is null!!');
		}
	});

});

$(window).on('resize', function(){
	if (grCmDtaAtrail && grCmDtaAtrail.id) {
		AUIGrid.resize(grCmDtaAtrail.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMJ0101&&UPPER_MENU_ID=COMJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMJ0101&&UPPER_MENU_ID=COMJ" charEncoding="utf-8"/>

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

            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                 <!-- 컨텐츠 타이틀 시작-->
                 <article class="conTitBox">
                     <h5>${progrmMap.MENU_NM}</h5>
                 </article>
                 
                 <!-- 컨텐츠 타이틀 끝-->
				<article class="conTitBtn">
					<table class="tb001">
						<colgroup>
							<col width="14%" />
							<col width="20%" />
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Audit Trail Date</th>
								<td colspan="5">
									<div class="dateBox" ><input id="txtStartDate" type="text" style="width:120px;"/></div>
									<span> ~ </span>
									<div class="dateBox" ><input id="txtEndDate" type="text" style="width:120px;"/></div>
								</td>
							</tr>
							<tr>
								<th>LABEL_NM</th>
								<td><input type="text" id="txtlabelNm" value="" style="width:160px;"></td>
								<th>PROGRM_NM</th>
								<td><input type="text" id="txtProgrmNm" style="width:160px;"></td>
								<th>IP</th>
								<td><input type="text" id="txtConectIp" style="width:160px;"></td>
							</tr>
							<tr>
								<th>Module</th>
								<td>
									<select id="selectModules" style="width:160px;">
										<option>===selected===</option>
										<option value="data">data</option>
									</select>
								</td>
								<th>Reason Code</th>
								<td>
									<select id="selectReasonCode" style="width:160px;">
										<option>===selected===</option>
										<option value="data">data</option>
									</select>
								</td>
								<th>Task No</th>
								<td><input type="text" id="txtTaskNo" style="width:160px;"></td>
							</tr>
						</tbody>
					</table>
					<div style="text-align:right; margin:8px 0 0 0;">
						<input type="button" id="btnCmDtaAtrailSearch" class="btn mgL3" value=<spring:message code="btn.search.1" />>
						<input type="button" id="btnCmDtaAtrailExcel" class="btn mgL3" value=<spring:message code="btn.excelDownload" />>
					</div>
				</article>

				<article class="mgT8">
					<div id="grCmDtaAtrail" class="gridHeiSz10 grid_wrap tb01_2"></div>
					<div id="pgCmDtaAtrail" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				</article>

                </div>
            </section>

            <!-- 컨텐츠박스 끝-->
		</div>
	</section>

</div>
</body>
</html>