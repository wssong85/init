<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<style>

.aui-grid-template-renderer{}

.aui-grid-template-renderer-wrapper{ 
	 height:auto !important;
}

.link_important{color: #ee3117; text-decoration:underline; font-weight: bold; display: inline-block; text-indent: 0px; }
.link_important:hover{text-decoration:underline; cursor:pointer;}
.link_normal{color: #5570e6; text-decoration:underline; font-weight: bold; display: inline-block; text-indent: 0px;}
.link_normal:hover{text-decoration:underline; cursor:pointer;}

.file_yes{background:url(/images/pantheon/contents/list_file.gif) no-repeat 0px 0px; display:inline-block; width:12px; height:12px; position: relative; top: 2px;  }

.aui-grid-selection-cell-border-lines {
	background: none;	
}

.aui-grid-body-panel .aui-grid-table tr td:hover {
	background: #eaebf4;
	background: none;
	color:#000;
}

.aui-grid-body-panel .aui-grid-table tr td:nth-child(3):hover{
	background: #eaebf4;
}

.link_area{ cursor: pointer;}


</style>
<script type="text/javascript">
var grCmNotice = {
 	id: '',
 	div: {
 		gridDiv: '#grCmNotice',
 		paging: {
 			pagingDiv: 'pgCmNotice',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: "<c:url value='/com/anonymous/selectCmNoticeListByPk.do'/>",
 		param: {
 			
 		},
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: true
 	},
 	gridPros: {
	    showRowNumColumn : false,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "singleRows",
	    displayTreeOpen : true
 	},
 	columnLayout : [{
 		dataField : "NOTICE_SN",
 		headerText : "No.",
 		width: 50
 	},{
 		dataField : "FIXING_AT",
 		headerText : '<spring:message code="comg01.gr.FIXING_AT"/>',
 		width: 80,
 		visible:false
 	},{
 		dataField : "NOTICE_SJ",
 		headerText : '<spring:message code="comg01.gr.NOTICE_SJ"/>',
 		renderer: {
 			type: 'TemplateRenderer'
 		}, 
		labelFunction : function(rowIndex, columnIndex, value, headerText, item ) {
			
			var vTmp = AUIGrid.getItemByRowIndex(grCmNotice.id, rowIndex);
			
			if(vTmp['FILE_EXIST']) {
				
				if(vTmp['FIXING_AT'] == 'Y') {
					
					return "<span class='link_important'>"+ value + "</span> <span class='file_yes'></span>";
					
				} else {
					
					return "<span class='link_normal'>"+ value + "</span> <span class='file_yes'></span>";
					
				}
				
			} else {
				
				if(vTmp['FIXING_AT'] == 'Y') {
					
					return "<span class='link_important'>"+ value + "</span> <span class='file_no'></span>";	
					
				} else {
					
					return "<span class='link_normal'>"+ value + "</span> <span class='file_no'></span>";	
					
				}
				
			}
			
		}
 	},{
 		dataField : "FILE_EXIST",
 		headerText : '<spring:message code="comg01.gr.FILE_EXIST"/>',
 		width: 80,
 		renderer: {
 			type: 'TemplateRenderer'
 		}, 
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			if(value) {
				return '<div class="signIco signIco01 green"></div>';
			} else {
				return '<div class="signIco signIco01 red"></div>';
			}
		},
		visible: false
 	},{
 		dataField : "NOTICE_CN",
 		headerText : '<spring:message code="comg01.gr.NOTICE_CN"/>',
 		visible: false
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="comg01.gr.LAST_UPDDE"/>',
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		width: 120
 	},{
 		dataField : "UPDATE_NM",
 		headerText : '<spring:message code="comg01.gr.UPDATE_NM"/>',
 		width: 120
 	},{
 		dataField : "INQIRE_NUM",
 		headerText : '<spring:message code="comg01.gr.INQIRE_NUM"/>',
 		width: 80
 	}],
 	createGrid: function() {
 		var me = this;
   		
 		me.proxy.param = {
			'SDATE': $('#txtStartDate').val(),
			'EDATE': $('#txtEndDate').val()
 		};
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellClick', function(event) {
 			if(AUIGrid.getSelectedIndex(me.id)[1] == 2) {
	 			$('#hdNoticeSn').val(event.item['NOTICE_SN']);
				document.frCmNotice.action = "<c:url value='/com/g01/COMG0102.do'/>";
				document.frCmNotice.submit();
 			}
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
//  			    		if(data.count < 10) {
//  			    			$(me.id).removeClass('gridHeiSz10');
//  			    			$(me.id).addClass('gridHeiSz0' + data.count);
//  			    		}
 			    		
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
	mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -30, 0);
	grCmNotice.createGrid();
	
	
	$('#btnCmNoticeSearch').click(function() {
		
		var params = {
				'SDATE': $('#txtStartDate').val(),
				'EDATE': $('#txtEndDate').val()
		};
		
		if($('#selectCmNoticeCondition').val() == 'NOTICE_SJ') {
			params.NOTICE_SJ = $('#txtCmNoticeCondition').val();
		} else if($('#selectCmNoticeCondition').val() == 'NOTICE_CN') {
			params.NOTICE_CN = $('#txtCmNoticeCondition').val();
		} else if($('#selectCmNoticeCondition').val() == 'UPDATE_ID') {
			params.UPDATE_ID = $('#txtCmNoticeCondition').val();
		} else if($('#selectCmNoticeCondition').val() == 'NOTICE_SJ_CN') {
			params.NOTICE_SJ_CN = $('#txtCmNoticeCondition').val();
		}
		
		grCmNotice.proxy.param = params;
		grCmNotice.moveToPage(1, grCmNotice.div.paging.rowCount);
	});
	
	$('#btnCmNoticeCreate').click(function() {
		location.href="./COMG0102.do"		
	});
	
	$('#txtCmNoticeCondition').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtCmNoticeCondition').val().trim()) {
			$('#btnCmNoticeSearch').trigger('click');
		}
	});
});

$(window).on('resize', function(){
	if (grCmNotice.id) {
		AUIGrid.resize(grCmNotice.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMG0101&&UPPER_MENU_ID=COMG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMG0101&&UPPER_MENU_ID=COMG" charEncoding="utf-8"/>
<form:form commandName="frCmNotice" name="frCmNotice"  method="post">
	<input type="hidden" name="NOTICE_SN" value="" id="hdNoticeSn"/>
</form:form>
	<!-- 메인 시작 -->
	<section id="mainCon">
		<section class="mainConInner" style="min-height:900px;">
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
					<div style="float:right;">
					<table>
					<tbody>
					<tr>
						<th style="width:70px">
							<label style="width:65px;text-align:right;display:block;float:left;"><spring:message code="comg01.table.th.7" />: </label>
						</th>
						<td style="width:270px">
							<div class="dateBox"><input id="txtStartDate" type="text" style="width:120px;" /></div>
							~
							<div class="dateBox"><input id="txtEndDate" type="text" style="width:120px;" /></div>
						</td>
						<th style="width:110px">
							<select id="selectCmNoticeCondition" style="width:100px">
								<option value="NOTICE_SJ"><spring:message code="comg01.table.th.1" /></option>
								<option value="NOTICE_CN"><spring:message code="comg01.table.th.2" /></option>
								<option value="UPDATE_ID"><spring:message code="comg01.table.th.3" /></option>
								<option value="NOTICE_SJ_CN"><spring:message code="comg01.table.th.4" /></option>
							</select>
						</th>
						<td style="width:200px">
							<input type="text" id="txtCmNoticeCondition" style="width:200px"/>
						</td>
						<td style="width:5px">
						</td>
						<td>
							<input type="button" id="btnCmNoticeSearch" class="btn mgL3" value=<spring:message code="btn.search.1" />>
						</td>
					</tr>
					</tbody>
					</table>
					</div>
					</article>
					
					<article class="mgT20">
						<div id="grCmNotice" class="gridHeiSz10 grid_wrap tb01_2"></div>
						<div id="pgCmNotice" class="aui-grid-paging-panel my-grid-paging-panel"></div>
					</article>
	
					
					<div style="position:absolute; right:20px; bottom:14px;">
						<input type="button" id="btnCmNoticeCreate" class="btn mgL3" value=<spring:message code="comg01.table.th.8" />>
					</div>
					
				</div>
			</section>
		</section>
	</section>
</div>
</body>
</html>