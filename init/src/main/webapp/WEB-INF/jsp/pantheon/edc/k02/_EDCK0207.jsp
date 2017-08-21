<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/com/common.do" flush="false" />

<title>EDC Designer</title>
<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}


.con_title_01{ display:block; height:28px;}
.left_001{margin-top:15px; width:49.5%; float:left;}
.right_001{margin-top:15px; width:49.5%; float:right;}
.right_002{ width:49.5%; float:right;}
.bottom_arrow_btn_01{  width:49.5%; float:right; height:60px; text-align:center; padding-top:14px; box-sizing: border-box;}

.big_arrow_btn_01 { padding:2px 30px 5px 30px !important; height:30px !important; background:#4c55a4 !important;  font-size: 20px !important; }
.big_arrow_btn_01:hover{background:; transition-duration:1s;}

</style>




<script type="text/javascript">
	$(document).ready(function() {
		if ($("#frm_main #TASK_SN").val() == "") {
			alert("과제선택필요");
			location.replace("./EDCK0201.do");
		} else {
			if ($("#frm_main #EDC_VER").val() == "") {
				alert("버전선택필요");
				fn_moveTab('EDCK0202');
			} else {
				var codeList = new Array();
				<c:forEach items="${ EDC034 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>

				fn_setCodeList(EDCK0207_grid, "VISIT_TY", codeList)

				codeList = new Array();
				<c:forEach items="${ EDC018 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>

				fn_setCodeList(EDCK0207_grid, "VISIT_PREARNGE_CODE", codeList);

				var grid_param = new Object();
				grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
				grid_param.EDC_VER = $("#frm_main #EDC_VER").val();

				EDCK0207_grid.proxy.param = grid_param;
				EDCK0207_grid.createGrid();

				codeList = new Array();
				<c:forEach items="${ EDC016 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>

				fn_setCodeList(EDCK0207_grid2, "GROUP_SE_CODE", codeList);

				EDCK0207_grid2.proxy.param = grid_param;
				EDCK0207_grid2.createGrid();

				fn_setCodeList(EDCK0207_grid3, "GROUP_SE_CODE", codeList);
				EDCK0207_grid3.createGrid();

				if (AUIGrid.getRowCount(EDCK0207_grid.id) > 0) {
					editMode(1);
				} else {
					editMode(2);
				}
			}
		}
	});
	
	
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0207_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0207_grid.id);
		}
		if (typeof EDCK0207_grid2.id !== "undefined") {
			AUIGrid.resize(EDCK0207_grid2.id);
		}
		if (typeof EDCK0207_grid3.id !== "undefined") {
			AUIGrid.resize(EDCK0207_grid3.id);
		}
	};
	var EDCK0207_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0207_grid',
			paging : {
				pagingDiv : '',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectVisitInfoList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : true,
			enableFilter : false,
			headerHeight : 40,
			rowHeight : 37,
			editableOnFixedCell : true,
			fixedColumnCount : 4,
			selectionMode : "singleRow",
			rowIdField : "VISIT_SN"
		},
		columnLayout : [ {
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
			dataField : "VISIT_SN",
			headerText : "VISIT_SN",
			editable : false,
			visible : false
		}, {
			dataField : "VISIT_LBL",
			headerText : "VISIT_LBL" + "<span class='must_01'></span>"
		}, {
			dataField : "VISIT_TY",
			headerText : "VISIT_TY" + "<span class='must_01'></span>",
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : null, //key-value Object 로 구성된 리스트
				keyField : "code", // key 에 해당되는 필드명
				valueField : "value" // value 에 해당되는 필드명
			},
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				return fn_checkCodeList(this, value);
			}
		}, {
			dataField : "VISIT_DAYCNT",
			headerText : "Window Visit" + "<span class='must_01'></span>",
			colSpan : 3
		}, {
			dataField : "VISIT_PREARNGE_CODE",
			//headerText : "VISIT_PREARNGE_CODE",
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : null, //key-value Object 로 구성된 리스트
				keyField : "code", // key 에 해당되는 필드명
				valueField : "value" // value 에 해당되는 필드명
			},
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				return fn_checkCodeList(this, value);
			},
			colSpan : -1
		}, {
			dataField : "VISIT_AFTER_DAYCNT",
			//headerText : "VISIT_AFTER_DAYCNT",
			colSpan : -1
		}, {
			dataField : "REFRN_BEGIN_AT",
			headerText : "REFRN_BEGIN_AT",
			renderer : {
				type : "CheckBoxEditRenderer",
				checkValue : "Y", // true, false 인 경우가 기본
				unCheckValue : "N",
				checkableFunction : function(rowIndex, columnIndex, value) {
					return AUIGrid.getProperty(EDCK0207_grid.id, "editable");
				}
			}
		}, {
			dataField : "REFRN_END_AT",
			headerText : "REFRN_END_AT",
			renderer : {
				type : "CheckBoxEditRenderer",
				checkValue : "Y", // true, false 인 경우가 기본
				unCheckValue : "N",
				checkableFunction : function(rowIndex, columnIndex, value) {
					return AUIGrid.getProperty(EDCK0207_grid.id, "editable");
				}
			}
		}, {
			dataField : "CRUD",
			headerText : "Delete",
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
			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				return fn_checkGridNull(event);
			});
			AUIGrid.bind(me.id, 'selectionChange', function(event) {
				var rowItem = event.selectedItems[0].item;
				if (!AUIGrid.isAddedById(me.id, rowItem[me.gridPros.rowIdField])) {
					var grid_param = new Object();
					grid_param.GROUP_SN = rowItem.GROUP_SN;
					grid_param.TASK_SN = rowItem.TASK_SN;
					grid_param.EDC_VER = rowItem.EDC_VER;
					grid_param.VISIT_SN = rowItem.VISIT_SN;
					EDCK0207_grid3.proxy.param = grid_param;
					EDCK0207_grid3.load();
				} else {
					AUIGrid.setGridData(EDCK0207_grid3.id, []);
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	var EDCK0207_grid2 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0207_grid2',
			paging : {
				pagingDiv : 'EDCK0207_grid_paging2',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectGroupList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : true,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : false,
			editable : false,
			enableFilter : false,
			headerHeight : 40,
			rowHeight : 37,
			fixedColumnCount : 4,
			selectionMode : "singleRow",
			rowIdField : "GROUP_SN"
		},
		columnLayout : [ {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN",
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
			dataField : "GROUP_LBL",
			headerText : "GROUP_LBL",
			editable : false
		}, {
			dataField : "GROUP_SE_CODE",
			headerText : "GROUP_SE_CODE",
			editable : false,
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : null, //key-value Object 로 구성된 리스트
				keyField : "code", // key 에 해당되는 필드명
				valueField : "value" // value 에 해당되는 필드명
			},
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				return fn_checkCodeList(this, value);
			}
		}, {
			dataField : "GROUP_DC",
			headerText : "GROUP_DC",
			editable : false
		}, {
			dataField : "GROUP_ORDR",
			headerText : "GROUP_ORDR",
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
			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				return fn_checkGridNull(event);
			});
			AUIGrid.bind(me.id, 'cellClick', function(event) {
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	var EDCK0207_grid3 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0207_grid3',
			paging : {
				pagingDiv : '',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectVisitInsideList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			fixedColumnCount : 5,
			selectionMode : "singleRow",
			rowIdField : "VISIT_GROUP_SN"
		},
		columnLayout : [ {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN",
			editable : false,
			visible : false
		}, {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN",
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
			dataField : "GROUP_LBL",
			headerText : "GROUP_LBL",
			editable : false
		}, {
			dataField : "GROUP_SE_CODE",
			headerText : "GROUP_SE_CODE",
			editable : false,
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : null, //key-value Object 로 구성된 리스트
				keyField : "code", // key 에 해당되는 필드명
				valueField : "value" // value 에 해당되는 필드명
			},
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				return fn_checkCodeList(this, value);
			}
		}, {
			dataField : "GROUP_DC",
			headerText : "GROUP_DC",
			editable : false
		}, {
			dataField : "GROUP_ORDR",
			headerText : "GROUP_ORDR",
			editable : false,
			visible : false
		}, {
			dataField : "CRUD",
			headerText : "Delete",
			editable : false,
			visible : false,
			style : "edc_column_style",
			labelFunction : function(rowIndex, columnIndex, value, headerText, item) {
				return fn_deleteCRUD(value);
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function addRow() {
		var item = {
			TASK_SN : $("#frm_main #TASK_SN").val(),
			EDC_VER : $("#frm_main #EDC_VER").val(),
			VISIT_TY : "01",
			VISIT_PREARNGE_CODE : "01",
			REFRN_BEGIN_AT : "N",
			REFRN_END_AT : "N"
		};
		AUIGrid.addRow(EDCK0207_grid.id, item, "last");
		AUIGrid.setGridData(EDCK0207_grid3.id, []);
	}

	function saveGrid() {
		var arJson = [];
		var rowItems = AUIGrid.getAddedRowItems(EDCK0207_grid.id);
		fn_makeArr(arJson, rowItems, "C");
		rowItems = AUIGrid.getEditedRowItems(EDCK0207_grid.id);
		fn_makeArr(arJson, rowItems, "U");
		rowItems = AUIGrid.getRemovedItems(EDCK0207_grid.id);
		fn_makeArr(arJson, rowItems, "D");
		if (arJson.length > 0) {
			AUIGrid.showAjaxLoader(EDCK0207_grid.id);
			$.ajax({
				url : './insertVisitInfoList.do',
				data : JSON.stringify(arJson),
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						EDCK0207_grid.load();
						alert("성공");
					} else {
						alert(data.message);
					}
					AUIGrid.removeAjaxLoader(EDCK0207_grid.id);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		} else {
			alert("변경 없음");
		}
	}

	function saveGrid2() {
		var rowItems = AUIGrid.getGridData(EDCK0207_grid3.id);
		for (var i = 0; i < rowItems.length; i++) {
			var item = {
				GROUP_ORDR : (i + 1)
			};
			AUIGrid.updateRow(EDCK0207_grid3.id, item, i, true);
		}

		var arJson = [];
		rowItems = AUIGrid.getAddedRowItems(EDCK0207_grid3.id);
		fn_makeArr(arJson, rowItems, "C");
		rowItems = AUIGrid.getEditedRowItems(EDCK0207_grid3.id);
		fn_makeArr(arJson, rowItems, "U");
		rowItems = AUIGrid.getRemovedItems(EDCK0207_grid3.id);
		fn_makeArr(arJson, rowItems, "D");

		if (arJson.length > 0) {
			AUIGrid.showAjaxLoader(EDCK0207_grid3.id);
			$.ajax({
				url : './insertVisitInsideList.do',
				data : JSON.stringify(arJson),
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						EDCK0207_grid3.load();
						alert("성공");
					} else {
						alert(data.message);
					}
					AUIGrid.removeAjaxLoader(EDCK0207_grid3.id);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		} else {
			alert("변경 없음");
		}
	}

	// 선택 행들 위로 한 단계 올림
	function moveRowsToUp() {
		AUIGrid.moveRowsToUp(EDCK0207_grid3.id);
	};

	// 선택 행들 아래로 한 단계 올림
	function moveRowsToDown() {
		AUIGrid.moveRowsToDown(EDCK0207_grid3.id);
	};

	function moveGroup() {
		var selectedItems = AUIGrid.getSelectedItems(EDCK0207_grid.id);
		if (selectedItems.length <= 0) {
			alert("방문선택없음");
		} else {
			var checkedItems = AUIGrid.getCheckedRowItems(EDCK0207_grid2.id);
			if (!AUIGrid.isAddedById(EDCK0207_grid.id, selectedItems[0].item[EDCK0207_grid.gridPros.rowIdField])) {
				for (var i = 0; i < checkedItems.length; i++) {
					checkedItems[i].item.VISIT_SN = selectedItems[0].item.VISIT_SN
					checkedItems[i].item.TASK_SN = selectedItems[0].item.TASK_SN
					checkedItems[i].item.EDC_VER = selectedItems[0].item.EDC_VER
					AUIGrid.addRow(EDCK0207_grid3.id, checkedItems[i].item, "last");
				}
				AUIGrid.setAllCheckedRows(EDCK0207_grid2.id, false);
			} else {
				alert("방문저장필요");
			}
		}
	}
	function editMode(c) {
		if (c == 1) {
			mkDisabled(); //컨트롤 비활성화
			AUIGrid.setProperty(EDCK0207_grid.id, {
				"editable" : false
			});
			AUIGrid.setProperty(EDCK0207_grid3.id, {
				"editable" : false
			});
			$("button").hide();
			$("#btn_edit").show();
		} else {
			mkEnabled(); //컨트롤 활성화

			var selIdx = AUIGrid.getSelectedIndex(EDCK0207_grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(EDCK0207_grid.id, EDCK0207_grid.gridPros.selectionMode);
				AUIGrid.setProperty(EDCK0207_grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(EDCK0207_grid.id, selIdx[0], selIdx[1])
			} else {
				AUIGrid.setProperty(EDCK0207_grid.id, {
					"editable" : true
				});
			}

			AUIGrid.setProperty(EDCK0207_grid3.id, {
				"editable" : true
			});
			$("button").show();
			$("#btn_edit").hide();
		}
	}
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0207&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0207&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>EDC Designer</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>과제관리</li>
						<li>EDC Designer</li>
					</ul>
				</nav>
			</article>

			<form id="frm_main" name="frm_main">
				<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
				<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
				<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
			</form>


            <section class="conBox100 conBox">

				<div class="conBoxInner">


					<div id="tab" class="tab tab01">
						<ul>
							<li id="tab_menu1" class="tab_menu" onclick="fn_moveTab('EDCK0202');">CRF List</li>
							<li id="tab_menu2" class="tab_menu" onclick="fn_moveTab('EDCK0203');">Template</li>
							<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0204');">Group</li>
							<li id="tab_menu4" class="port_back tab_menu">Visit</li>
							<li id="tab_menu5" class="tab_menu" onclick="fn_moveTab('EDCK0208');">Dictionary</li>
							<li id="tab_menu6" class="tab_menu" onclick="fn_moveTab('EDCK0209');">Layout</li>
							<li id="tab_menu7" class="tab_menu" onclick="fn_moveTab('EDCK0212');">Edit Check</li>
							<li id="tab_menu8" class="tab_menu" onclick="fn_moveTab('EDCK0214');">T-Domain</li>
						</ul>
					</div>
						

					<section class="con_title_01">
		            	<articla class="conTitBox">
		            		<h5 id="tabTitle">${ TASK_NO } - ${ EDC_VER }</h5>
		            	</articla>


						<div class="conTitBtnR">
							<button type="button" id="btn_edit" onclick="editMode(2);">수정</button>
						</div>
					</section>




					<div class="conSbtLn left_001">
						<article class="conTitBox">
							<h6>Visit</h6>
						</article>
						<article class="conTitBtnR">
							<button type="button" onclick="addRow();" able>행추가</button>
							<button type="button" onclick="fn_deleteRow(EDCK0207_grid)" able>행삭제</button>
							<button type="button" onclick="saveGrid();" able>저장</button>
						</article>
						<article class="mgT16">
							<div id="EDCK0207_grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
                    			 <!-- <div id="EDCK0101_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
						</article>
					</div>




					<div class="conSbtLn right_001">
						<article class="conTitBox">
							<h6>Group</h6>
						</article>
						<article class="mgT16">
							<div id="EDCK0207_grid2" class="gridHeiSz05 grid_wrap tb01_2"></div>
						</article>
					</div>


					<div class="bottom_arrow_btn_01">
						<button class="big_arrow_btn_01" type="button" onclick="moveGroup();" able>▼</button>
					</div>	





					<div class="conSbtLn right_002">
						<article class="conTitBox">
							<h6>Visit Group</h6>
						</article>
						<article class="conTitBtnR">
							<button type="button" onclick="moveRowsToUp();" able>▲</button>
							<button type="button" onclick="moveRowsToDown();" able>▼</button>
							<button type="button" onclick="fn_deleteRow(EDCK0207_grid3)" able>행삭제</button>
							<button type="button" onclick="saveGrid2();" able>저장</button>
						</article>
						<article class="mgT16">
							<div id="EDCK0207_grid3" class="gridHeiSz05 grid_wrap tb01_2"></div>
						</article>
					</div>






				</div>
            </section>



		</div>
	</section>
</div>
</body>
</html>