<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>이력관리(Audit Trail)</title>
<script type="text/javascript">
$(document).ready(function() {
	mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -7, 0);
	grCmDtaAtrail.createGrid();
});

$(window).on('resize', function(){
	if (grCmDtaAtrail.id) {
		AUIGrid.resize(grCmDtaAtrail.id);
	}
});

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
 		url: './selectCmDtaAtrailListByPk.do',
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		//페이징 true, false 로 지정
 		paging: true,
 		//처음 시작시 데이터 로딩
 		autoLoad: false
 	},
 	gridPros: {
// 		'selectionMode': 'singleRow',
// 		'editable': true,
// 		'showStateColumn': true,
// 	    headerHeight: 48,
// 	    rowHeight: 37
	    
	    // 페이징 사용
	    //usePaging : true,
	    
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,

	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,

 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "UPDT_DE",
 		headerText : "Date/Time",
 		formatString : "yyyy-mm-dd HH:MM:ss",
 		dataType:"date"
 	},{
 		dataField : "USER_ID",
 		headerText : "User"
 	},{
 		dataField : "MODULE",
 		headerText : "Module"
 	},{
 		dataField : "TABLE_NM",
 		headerText : "Table"
 	},{
 		dataField : "COLUMN_NM",
 		headerText : "Column"
 	},{
 		dataField : "PK_NM",
 		headerText : "PK"
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
 		dataField : "CONECT_IP",
 		headerText : "CONECT_IP"
 	},{
 		dataField : "LABEL_NM",
 		headerText : "LABEL_NM"
 	},{
 		dataField : "PROGRM_NM",
 		headerText : "PROGRM_NM"
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
   		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
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
 	//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
 	createPagingNavigator: function(goPage) {
 		var me = this;
 
 		if(!me.div.paging.pagingDiv) { 
 			return;
 		}
 		
 		me.div.paging.totalPage = Math.ceil(me.div.paging.totalRowCount/me.div.paging.rowCount);
 		
 		var retStr = "";
 		var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * me.div.paging.pageButtonCount;
 		var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount + 1;
 
 		prevPage = Math.max(0, prevPage);
 		nextPage = Math.min(nextPage, me.div.paging.totalPage);
 		if ( goPage == 0 ) { prevPage.stop() }
 		
 		//셀렉트박스
 		retStr += "<select class='rowSel' onchange='javascript:grCmDtaAtrail.moveToPage(grCmDtaAtrail.div.paging.currentPage, this.value)'>"
 		if(me.div.paging.rowCount == 20) {
 			retStr += "<option value=20 selected=true>20</option>"
 		} else {
 			retStr += "<option value=20>20</option>"
 		}
 		if(me.div.paging.rowCount == 50) {
 			retStr += "<option value=50 selected=true>50</option>"
 		} else {
 			retStr += "<option value=50>50</option>"
 		}
 		if(me.div.paging.rowCount == 100) {
 			retStr += "<option value=100 selected=true>100</option>"
 		} else {
 			retStr += "<option value=100>100</option>"
 		}
 		if(me.div.paging.rowCount == 300) {
 			retStr += "<option value=300 selected=true>300</option>"
 		} else {
 			retStr += "<option value=300>300</option>"
 		}
 		if(me.div.paging.rowCount == 500) {
 			retStr += "<option value=500 selected=true>500</option>"
 		} else {
 			retStr += "<option value=500>500</option>"
 		}
 		retStr += "</select>"


 		




 		
 		// 처음
 		retStr += "<span class='aui-grid-paging-grup'>";
 		retStr += "<a href='javascript:grCmDtaAtrail.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";
 
 		// 이전
 		retStr += "<a href='javascript:grCmDtaAtrail.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
 
 		for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage); i<=len; i++) {
 			if (goPage == i) {
 				retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
 			} else {
 				retStr += "<a href='javascript:grCmDtaAtrail.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
 				retStr += i;
 				retStr += "</span></a>";
 			}
 			
 			if (i >= me.div.paging.totalPage) {
 				break;
 			}
 
 		}
 
 		// 다음
 		retStr += "<a href='javascript:grCmDtaAtrail.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
 
 		// 마지막
 		retStr += "<a href='javascript:grCmDtaAtrail.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>";
 		retStr += "</span>";
 		
 		
 		document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
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
	$.ajax({
		url : '/com/common/selectQueryDataList.do',
		dataType: 'json',
		type: 'post',
		data: {'QUERY': 'selectCmDtaAtrailDistinctByModules'},
		success : function(data) {
			loadCombo($("#selectModules"), data.result);
		}
	});
	
	function loadCombo(target, data) {
		var dataArr = [];
		var inx = 0;
		target.empty();
		$(data).each( function() {
			dataArr[inx++] = "<option value=" + this.MODULE + ">" + this.MODULE + "</option> ";
		});
		target.append(dataArr);
	}
	
	$('#btnCmDtaAtrailSearch').click(function() {
		var params = {
			'SDATE': $('#txtStartDate').val(),
			'EDATE': $('#txtEndDate').val(),
			'TABLE_NM': $('#txtTable').val(),
			'COLUMN_NM': $('#txtColumn').val(),
			'PK_NM': $('#txtPk').val(),
			'MODULE': $('#selectModules').val()
		};
		
		grCmDtaAtrail.proxy.param = params; 
		grCmDtaAtrail.load();
// 		$.ajax({
// 			  url : './selectCmDtaAtrailListByPk.do',
// 			  type: 'post',
// 			  data : params,
// 			  success : function(data, textStatus, jqXHR) {
// 				  if(data.success) {
// 					  grCmDtaAtrail.load()
// 				  } else {
// 					  AUIGrid.removeAjaxLoader(grCmDtaAtrail.id);
// 					  alert(data.message);
// 				  }
// 			  }, 
// 			  error : function(jqXHR, textStatus, errorThrown){
// 				  alert(textStatus);
// 			  }
// 		});
	})
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
				<h3>이력관리(Audit Trail)</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>이력관리(AUDIT TRAIL)</li>
						<li>이력관리(Audit Trail)</li>
					</ul>
				</nav>
			</article>



            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                 <!-- 컨텐츠 타이틀 시작-->
                 <article class="conTitBox">
                     <h5>이력관리(Audit Trail)</h5>
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
									<div class="dateBox" ><input id="txtStartDate" type="text"/></div>
									<span> ~ </span>
									<div class="dateBox" ><input id="txtEndDate" type="text"/></div>
								</td>
							</tr>
							<tr>
								<th>LABEL_NM</th>
								<td><input type="text" value="" style="width:160px;"></td>
								<th>PROGRM_NM</th>
								<td><input type="text" value="" style="width:160px;"></td>
								<th>IP</th>
								<td><input type="text" value="" style="width:160px;"></td>
							</tr>
							<tr>
								<th>Module</th>
								<td>
									<select id="" style="width:160px;">
										<option>===selected===</option>
										<option value="data">data</option>
									</select>
								</td>
								<th>Reason code</th>
								<td colspan="3">
									<select id="" style="width:160px;">
										<option>===selected===</option>
										<option value="data">data</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<div style="text-align:right; margin:8px 0 0 0;">
						<input type="button" id="btnCmDtaAtrailSearch" class="btn mgL3" value="검색">
					</div>
				</article>



				<article class="mgT20">
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