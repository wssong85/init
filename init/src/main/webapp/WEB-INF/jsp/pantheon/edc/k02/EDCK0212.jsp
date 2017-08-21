<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>EDC Designer</title>

<style>
#tab li {
	padding: 0 20px !important;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		if ($("#frm_main #TASK_SN").val() == "") {
			alert('<spring:message code="edc.taskSelect.msg" />');
			location.replace("./EDCK0201.do");
		} else {
			if ($("#frm_main #EDC_VER").val() == "") {
				alert('<spring:message code="edc.edcSelect.msg" />');
				fn_moveTab('EDCK0202');
			} else {
				var gridParam = new Object();
				gridParam.TASK_SN = $("#frm_main #TASK_SN").val();
				gridParam.EDC_VER = $("#frm_main #EDC_VER").val();
				EDCK0212_grid.proxy.param = gridParam;
				EDCK0212_grid.createGrid();

			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0212_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0212_grid.id);
		}
	};
	var EDCK0212_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0212_grid',
			paging : {
				pagingDiv : 'EDCK0212_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectAllEditCheckList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : false,
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			//fixedColumnCount : 7,
			selectionMode : "singleCell",
			enableCellMerge : true,
			rowIdField : "RN"
		},
		columnLayout : [ {
			dataField : "VISIT_LBL",
			headerText : '<spring:message code="edc.lbl.VISIT_LBL" />',
			cellMerge : true,
			editable : false,
			width : 100,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "GROUP_LBL",
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />',
			cellMerge : true,
			editable : false,
			width : 100,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : '<spring:message code="edc.lbl.VISIT_LBL" />',
			editable : false,
			width : 100,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VRIABL_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			editable : false,
			width : 100,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "SET_ROW_ORDR",
			headerText : "SEQ",
			editable : false,
			width : 100,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.CDISC_SUBMIT_VALUE" />',
			editable : false,
			width : 160,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "QUERY_SE_CODE",
			headerText : '<spring:message code="edc.lbl.QUERY_SE_CODE" />',
			editable : false,
			width : 100,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "QUERY_MSSAGE",
			headerText : '<spring:message code="edc.lbl.QUERY_MSSAGE" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "RN",
			headerText : "RN",
			editable : false,
			visible : false
		}, {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			editable : false,
			visible : false
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER",
			editable : false,
			visible : false
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN",
			editable : false,
			visible : false
		}, {
			dataField : "SET_SN",
			headerText : "SET_SN",
			editable : false,
			visible : false
		}, {
			dataField : "SET_ROW_SN",
			headerText : "SET_ROW_SN",
			editable : false,
			visible : false
		}, {
			dataField : "SET_VRIABL_SN",
			headerText : "SET_VRIABL_SN",
			editable : false,
			visible : false
		}, {
			dataField : "EDITCECK_SN",
			headerText : "EDITCECK_SN",
			editable : false,
			visible : false
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
				if (event.dataField == "CRF_LBL_ONE" || event.dataField == "VRIABL_NM" || event.dataField == "CDISC_SUBMIT_VALUE" || event.dataField == "QUERY_SE_CODE" || event.dataField == "QUERY_MSSAGE") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#frm_main #VISIT_GROUP_SN").val(rowItem.VISIT_GROUP_SN);
					$("#frm_main #SET_SN").val(rowItem.SET_SN);
					$("#frm_main #SET_ROW_SN").val(rowItem.SET_ROW_SN);
					$("#frm_main #SET_VRIABL_SN").val(rowItem.SET_VRIABL_SN);
					$("#frm_main #EDITCECK_SN").val(rowItem.EDITCECK_SN);
					if (rowItem.EDITCECK_SN == null) {
						$("#frm_main #CRUD").val("C");
					} else {
						$("#frm_main #CRUD").val("U");
					}

					$("#frm_main").attr({
						action : "./EDCK0213.do",
						method : 'post'
					}).submit();
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0212&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0212&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />

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

				<form id="frm_main" name="frm_main">
					<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
					<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
					<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
					<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN">
					<input type="hidden" id="SET_SN" name="SET_SN">
					<input type="hidden" id="SET_ROW_SN" name="SET_ROW_SN">
					<input type="hidden" id="SET_VRIABL_SN" name="SET_VRIABL_SN">
					<input type="hidden" id="EDITCECK_SN" name="EDITCECK_SN">
					<input type="hidden" id="CRUD" name="CRUD">
				</form>


				<section class="conBox100 conBox">

					<div class="conBoxInner">


						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_menu1" class="tab_menu" onclick="fn_moveTab('EDCK0202');">CRF List</li>
								<li id="tab_menu2" class="tab_menu" onclick="fn_moveTab('EDCK0203');">Template</li>
								<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0204');">Group</li>
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
								<li id="tab_menu9" class="tab_menu" onclick="fn_moveTab('EDCK0218');">Coding</li>
								<li id="tab_menu5" class="tab_menu" onclick="fn_moveTab('EDCK0208');">Dictionary</li>
								<li id="tab_menu6" class="tab_menu" onclick="fn_moveTab('EDCK0209');">Layout</li>
								<li id="tab_menu7" class="port_back tab_menu">Edit Check</li>
								<li id="tab_menu8" class="tab_menu" onclick="fn_moveTab('EDCK0214');">T-Domain</li>
							</ul>
						</div>


						<section class="con_title_01">
							<articla class="conTitBox">
							<h5 id="tabTitle">${ TASK_NO }-${ EDC_VER }</h5>
							</articla>
						</section>

						<article class="mgT16">
							<div id="EDCK0212_grid" class="gridHeiSz13 grid_wrap tb01_2"></div>
						</article>


					</div>
				</section>

			</div>
		</section>
	</div>
</body>
</html>