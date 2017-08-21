<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />


<title></title>
<style>
.edc_column_style {
	color: #5570e6;
	text-decoration: underline;
	font-weight: bold;
}

.edc_column_style:hover {
	text-decoration: underline;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	var EDCK0201_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0201_grid',
			paging : {
				pagingDiv : 'EDCK0201_grid_paging',
				totalRowCount : 500,
				rowCount : 20,
				pageButtonCount : 5,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectStudyList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			// 			paging : true,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			usePaging : true,
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			fixedColumnCount : 3,
			selectionMode : "singleRow",
			rowIdField : "TASK_SN"
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			/* dataField : "RNUM",
			headerText : "No",
			editable : false,
			minWidth : 40,
			width : 40
			}, { */
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			visible : false
		}, {
			dataField : "TASK_NO",
			headerText : '<spring:message code="edc.lbl.TASK_NO" />',
			editable : false,
			minWidth : 100,
			width : 100,
			style : "edc_column_style",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TASK_NM",
			headerText : '<spring:message code="edc.lbl.TASK_NM" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TASK_TY_CODE",
			headerText : '<spring:message code="edc.lbl.TASK_TY_CODE" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CRF_VER",
			headerText : "CRF Ver",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CRF_LAST_UPDDE",
			headerText : '<spring:message code="edc.lbl.CRF_LAST_UPDDE" />',
			editable : false,
			formatString : "yyyy-mm-dd",
			dataType : "date",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "EDC_VER",
			headerText : "EDC Ver",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "EDC_LAST_UPDDE",
			headerText : '<spring:message code="edc.lbl.EDC_LAST_UPDDE" />',
			editable : false,
			formatString : "yyyy-mm-dd",
			dataType : "date",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CRF_PROGRS_CODE",
			headerText : '<spring:message code="edc.lbl.STTUS" />',
			editable : false,
			visible : false,
			filter : {
				showIcon : true
			}
		} ],
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;
			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			me.binding();
			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;
			AUIGrid.bind(me.id, 'cellClick', function(event) {
				if (event.dataField == "TASK_NO") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#frm_main #TASK_SN").val(rowItem.TASK_SN);
					$("#frm_main #TASK_NO").val(rowItem.TASK_NO);
					$("#CRUD").val("U");
					$("#frm_main").attr({
						action : './EDCK0202.do',
						method : 'post'
					}).submit();
				} else if (event.dataField == "EDC_VER") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#frm_main #TASK_SN").val(rowItem.TASK_SN);
					$("#frm_main #TASK_NO").val(rowItem.TASK_NO);
					$("#frm_main #EDC_VER").val(rowItem.EDC_VER);
					var url = null;
					switch (rowItem.CRF_PROGRS_CODE) {
					case "01":
						url = "/edc/k02/EDCK0214";
						break;
					case "02":
						url = "/edc/k02/EDCK0203";
						break;
					case "03":
						url = "/edc/k02/EDCK0204";
						break;
					case "04":
						url = "/edc/k02/EDCK0207";
						break;
					case "05":
						url = "/edc/k02/EDCK0208";
						break;
					case "06":
						url = "/edc/k02/EDCK0209";
						break;
					case "07":
						url = "/edc/k02/EDCK0212";
						break;
					case "08":
						url = "/edc/k02/EDCK0202";
						break;
					case "09":
						url = "/edc/k02/EDCK0202";
						break;
					case "10":
						url = "/edc/k02/EDCK0202";
						break;
					default:
						url = "/edc/k02/EDCK0202";
						break;
					}
					$("#frm_main").attr({
						action : url + '.do',
						method : 'post'
					}).submit();
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		},
		//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		createPagingNavigator : function(goPage) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			// 			fn_createPagingNavigator(me, goPage);
		},
		//페이징 에서 어느 페이지로 갈 것인지 지정
		moveToPage : function(goPage, rowCount) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			// 			$("#frm_search #PAGE").val(goPage);
			// 			fn_moveToPage(me, goPage, rowCount)
		}
	};
	function searchClick(page) {
		// 		if (page == undefined) {
		// 			page = 1;
		// 		}

		// 		$("#frm_search #PAGE").val(page);
		// 		$("#frm_search #COUNT").val(EDCK0101_grid.div.paging.rowCount);
		var param = $("#frm_search").serialize();
		EDCK0201_grid.proxy.param = param;
		EDCK0201_grid.load();
	}
	$(document).ready(function() {
		EDCK0201_grid.createGrid();
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0201_grid !== "undefined") {
			AUIGrid.resize(EDCK0201_grid);
		}
	};
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0201&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0201&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
					<nav id="pathNav">
						<ul>
							<li>
								<img src="/images/pantheon/common/pathNavIco.png" alt="">Home
							</li>
							<li>${progrmMap.UPPER_MENU_NM}</li>
							<li>${progrmMap.MENU_NM}</li>
						</ul>
					</nav>
				</article>


				<section class="conBox100 conBox">
					<div class="conBoxInner">

						<article class="mgT10" style="overflow: hidden;">
							<form id="frm_search" name="frm_search">
								<input type="hidden" id="PAGE" name="PAGE">
								<input type="hidden" id="COUNT" name="COUNT">
								<div class="conTitBtnL">
									<span style="font-family: 'NanumGothicBold';"><spring:message code="edc.lbl.TASK_NO" /></span>
									<input type="text" id="TASK_NO" name="TASK_NO" style="width: 140px;">
									<span style="font-family: 'NanumGothicBold'; margin-left: 30px;"><spring:message code="edc.lbl.TASK_NM" /></span>
									<input type="text" id="TASK_NM" name="TASK_NM" style="width: 140px;">
									<input type="button" class="btn mgL3" onclick="searchClick()" value="<spring:message code="btn.search.1" />">
								</div>
							</form>
						</article>


						<article class="mgT16">
							<div id="EDCK0201_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
							<div id="EDCK0201_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>

						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="">
							<input type="hidden" id="EDC_VER" name="EDC_VER" value="">
							<input type="hidden" id="CRUD" name="CRUD" value="U">
						</form>

					</div>
				</section>
				<!-- 컨텐츠박스 끝-->
			</div>
		</section>
	</div>
</body>
</html>