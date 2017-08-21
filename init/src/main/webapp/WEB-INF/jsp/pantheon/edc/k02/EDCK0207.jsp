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

.edc_column_style {
	color: #5570e6;
	text-decoration: underline;
	font-weight: bold;
}

.edc_column_style:hover {
	text-decoration: underline;
	cursor: pointer;
}

.con_title_01 {
	display: block;
	height: 28px;
}

.left_001 {
	margin-top: 15px;
	width: 49.5%;
	float: left;
}

.right_001 {
	margin-top: 15px;
	width: 49.5%;
	float: right;
}

.right_002 {
	width: 49.5%;
	float: right;
}

.bottom_arrow_btn_01 {
	width: 49.5%;
	float: right;
	height: 60px;
	text-align: center;
	padding-top: 14px;
	box-sizing: border-box;
}

.big_arrow_btn_01 {
	padding: 2px 30px 5px 30px !important;
	height: 30px !important;
	background: #4c55a4 !important;
	font-size: 20px !important;
}

.big_arrow_btn_01:hover {
	background:;
	transition-duration: 1s;
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

				EDCK0207_grid2.createGrid();

				fn_setCodeList(EDCK0207_grid3, "GROUP_SE_CODE", codeList);
				EDCK0207_grid3.createGrid();

				if (AUIGrid.getRowCount(EDCK0207_grid.id) > 0) {
					editMode(false);
				} else {
					editMode(true);
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
			softRemovePolicy : "exceptNew",
			editable : true,
			enableFilter : true,
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
			headerText : '<spring:message code="edc.lbl.VISIT_LBL" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VISIT_TY",
			headerText : '<spring:message code="edc.lbl.VISIT_TY" />' + "<span class='must_01'></span>",
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
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VISIT_DAYCNT",
			headerText : '<spring:message code="edc.lbl.VISIT_DAYCNT" />' + "<span class='must_01'></span>",
			colSpan : 3,
			width : 50,
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true
			}
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
			colSpan : -1,
			width : 50,
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true
			}
		}, {
			dataField : "REFRN_BEGIN_AT",
			headerText : '<spring:message code="edc.lbl.REFRN_BEGIN_AT" />',
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
			headerText : '<spring:message code="edc.lbl.REFRN_END_AT" />',
			renderer : {
				type : "CheckBoxEditRenderer",
				checkValue : "Y", // true, false 인 경우가 기본
				unCheckValue : "N",
				checkableFunction : function(rowIndex, columnIndex, value) {
					return AUIGrid.getProperty(EDCK0207_grid.id, "editable");
				}
			}
		}, {
			dataField : "VISIT_ORDR",
			headerText : "VISIT_ORDR",
			editable : false,
			visible : false
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
				if (event.dataField == "VISIT_TY") {
					if (event.value == "05" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "VISIT_TY", "05").length > 0) {
							alert("Extension 그룹은 하나만 존재하야 합니다.");
							return event.oldValue;
						}
					} else if (event.value == "06" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "VISIT_TY", "06").length > 0) {
							alert("All 그룹은 하나만 존재하야 합니다.");
							return event.oldValue;
						}
					} else if (event.value == "07" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "VISIT_TY", "07").length > 0) {
							alert("UV 그룹은 하나만 존재하야 합니다.");
							return event.oldValue;
						}
					}
					return event.value;
				} else if (event.dataField == "REFRN_BEGIN_AT") {
					if (event.value == "Y") {
						var item = {
							REFRN_END_AT : "N"
						};
						AUIGrid.updateRow(me.id, item, event.rowIndex, true);
					}
					return event.value;
				} else if (event.dataField == "REFRN_END_AT") {
					if (event.value == "Y") {
						var item = {
							REFRN_BEGIN_AT : "N"
						};
						AUIGrid.updateRow(me.id, item, event.rowIndex, true);
					}
					return event.value;
				} else {
					return fn_checkGridNull(event);
				}
			});

			AUIGrid.bind(me.id, 'selectionChange', function(event) {
				var rowItem = event.selectedItems[0].item;
				if (!AUIGrid.isAddedById(me.id, rowItem[me.gridPros.rowIdField])) {
					var grid_param = new Object();
					grid_param.TASK_SN = rowItem.TASK_SN;
					grid_param.EDC_VER = rowItem.EDC_VER;
					grid_param.VISIT_SN = rowItem.VISIT_SN;
					EDCK0207_grid2.proxy.param = grid_param;
					EDCK0207_grid2.load();
					AUIGrid.setAllCheckedRows(EDCK0207_grid2.id, false);
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
			url : './selectGroupListForVisit.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : true,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : false,
			editable : false,
			softRemoveRowMode : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			fixedColumnCount : 4,
			selectionMode : "singleRow",
			rowIdField : "VISIT_GROUP_SN"
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
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "GROUP_SE_CODE",
			headerText : '<spring:message code="edc.lbl.GROUP_SE_CODE" />',
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
			},
			filter : {
				showIcon : true
			}
		}, {
			dataField : "GROUP_DC",
			headerText : '<spring:message code="edc.lbl.GROUP_DC" />',
			editable : false
		}, {
			dataField : "GROUP_ORDR",
			headerText : "GROUP_ORDR",
			editable : false,
			visible : false
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN",
			editable : false
		//,			visible : false
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
			softRemovePolicy : "exceptNew",
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
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "GROUP_SE_CODE",
			headerText : '<spring:message code="edc.lbl.GROUP_SE_CODE" />',
			sortable : false,
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
			},
			filter : {
				showIcon : true
			}
		}, {
			dataField : "GROUP_DC",
			headerText : '<spring:message code="edc.lbl.GROUP_DC" />',
			sortable : false,
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function addRow() {
		var i = AUIGrid.getRowCount(EDCK0207_grid.id);
		var item = {
			TASK_SN : $("#frm_main #TASK_SN").val(),
			EDC_VER : $("#frm_main #EDC_VER").val(),
			VISIT_TY : "01",
			VISIT_PREARNGE_CODE : "01",
			REFRN_BEGIN_AT : "N",
			REFRN_END_AT : "N",
			VISIT_ORDR : (i + 1)
		};
		AUIGrid.addRow(EDCK0207_grid.id, item, "last");
		AUIGrid.setGridData(EDCK0207_grid3.id, []);
	}

	function saveGrid() {
		AUIGrid.forceEditingComplete(EDCK0207_grid.id, null, false);
		var msg1 = '<spring:message code="edc.required.msg" />';
		var msg2 = '<spring:message code="edc.byte.msg" />';
		var rowItems = AUIGrid.getGridData(EDCK0207_grid.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].VISIT_LBL || rowItems[i].VISIT_LBL.length <= 0) {
				alert("VISIT_LBL" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0207_grid.id, i);
				return false;
			}

			var text_byte = 10;
			var text = rowItems[i].VISIT_AFTER_DAYCNT;
			if (fn_getByte(text) > text_byte) {
				alert("VISIT_AFTER_DAYCNT" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0207_grid.id, i);
				return false;
			}

			text = rowItems[i].VISIT_DAYCNT;
			if (fn_getByte(text) > text_byte) {
				alert("VISIT_DAYCNT" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0207_grid.id, i);
				return false;
			}
			text_byte = 200;
			text = rowItems[i].VISIT_LBL;
			if (fn_getByte(text) > text_byte) {
				alert("VISIT_LBL" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0207_grid.id, i);
				return false;
			}
		}

		if (confirm('<spring:message code="edc.save.msg" />')) {
			var rowItems = AUIGrid.getGridData(EDCK0207_grid.id);
			var arJson = [];
			for (var i = 0; i < rowItems.length; i++) {
				rowItems[i].VISIT_ORDR = (i + 1);

				if (AUIGrid.isAddedById(EDCK0207_grid.id, rowItems[i].VISIT_GROUP_SN)) {
					rowItems[i].CRUD = "C";
				} else if (AUIGrid.isEditedById(EDCK0207_grid.id, rowItems[i].VISIT_GROUP_SN)) {
					rowItems[i].CRUD = "U";
				} else if (AUIGrid.isRemovedById(EDCK0207_grid.id, rowItems[i].VISIT_GROUP_SN)) {
					rowItems[i].CRUD = "D";
				} else {
					rowItems[i].CRUD = "U";
				}
				arJson.push(rowItems[i]);
			}

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
							alert('<spring:message code="edc.save.confirm.msg" />');
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
				alert('<spring:message code="edc.save.noChange" />');
			}
		}
	}

	function saveGrid2() {
		AUIGrid.forceEditingComplete(EDCK0207_grid3.id, null, false);
		if (confirm('<spring:message code="edc.save.msg" />')) {
			var rowItems = AUIGrid.getGridData(EDCK0207_grid3.id);
			var arJson = [];
			for (var i = 0; i < rowItems.length; i++) {
				rowItems[i].GROUP_ORDR = (i + 1);

				if (AUIGrid.isAddedById(EDCK0207_grid3.id, rowItems[i].VISIT_GROUP_SN)) {
					rowItems[i].CRUD = "C";
				} else if (AUIGrid.isEditedById(EDCK0207_grid3.id, rowItems[i].VISIT_GROUP_SN)) {
					rowItems[i].CRUD = "U";
				} else if (AUIGrid.isRemovedById(EDCK0207_grid3.id, rowItems[i].VISIT_GROUP_SN)) {
					rowItems[i].CRUD = "D";
				} else {
					rowItems[i].CRUD = "U";
				}
				arJson.push(rowItems[i]);
			}

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
							alert('<spring:message code="edc.save.confirm.msg" />');
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
				alert('<spring:message code="edc.save.noChange" />');
			}
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

	function moveGroup(c) {
		if (c == 1) {
			var selectedItems = AUIGrid.getSelectedItems(EDCK0207_grid.id);
			if (selectedItems.length <= 0) {
				alert('<spring:message code="edc.visitSelect.msg" />');
			} else {
				var checkedItems = AUIGrid.getCheckedRowItems(EDCK0207_grid2.id);
				if (!AUIGrid.isAddedById(EDCK0207_grid.id, selectedItems[0].item[EDCK0207_grid.gridPros.rowIdField])) {
					for (var i = 0; i < checkedItems.length; i++) {
						checkedItems[i].item.VISIT_SN = selectedItems[0].item.VISIT_SN
						checkedItems[i].item.TASK_SN = selectedItems[0].item.TASK_SN
						checkedItems[i].item.EDC_VER = selectedItems[0].item.EDC_VER
						AUIGrid.addRow(EDCK0207_grid3.id, checkedItems[i].item, "last");
						AUIGrid.removeRowByRowId(EDCK0207_grid2.id, checkedItems[i].item.VISIT_GROUP_SN);
					}
					//AUIGrid.setAllCheckedRows(EDCK0207_grid2.id, false);
				} else {
					alert('<spring:message code="edc.save.visit.msg" />');
				}
			}
		} else {
			var rowItem = AUIGrid.getSelectedItems(EDCK0207_grid3.id)[0].item;
			if (rowItem.GROUP_SE_CODE == "06") {
				alert('<spring:message code="edc.noDelete.msg" />');
			} else if (rowItem.GROUP_SE_CODE == "07") {
				alert('<spring:message code="edc.noDelete.msg" />');
			} else {
				AUIGrid.addRow(EDCK0207_grid2.id, rowItem, "last");
				AUIGrid.removeRow(EDCK0207_grid3.id, "selectedIndex");
			}
		}

	}
	function editMode(e) {
		if (!e) {
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

	function deleteVisit(grid) {
		var rowItem = AUIGrid.getSelectedItems(grid.id)[0].item;
		if (rowItem.VISIT_TY == "08") {
			alert('<spring:message code="edc.noDelete.msg" />');
		} else {
			fn_deleteRow(grid);
		}
	}

	// 선택 행들 위로 한 단계 올림
	function moveRowsToUp(grid) {
		AUIGrid.moveRowsToUp(grid.id);
	};

	// 선택 행들 아래로 한 단계 올림
	function moveRowsToDown(grid) {
		AUIGrid.moveRowsToDown(grid.id);
	};
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0207&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0207&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />

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
				</form>

				<section class="conBox100 conBox">

					<div class="conBoxInner">


						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_menu1" class="tab_menu" onclick="fn_moveTab('EDCK0202');">CRF List</li>
								<li id="tab_menu2" class="tab_menu" onclick="fn_moveTab('EDCK0203');">Template</li>
								<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0204');">Group</li>
								<li id="tab_menu9" class="port_back tab_menu">Visit</li>
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0218');">Coding</li>
								<li id="tab_menu5" class="tab_menu" onclick="fn_moveTab('EDCK0208');">Dictionary</li>
								<li id="tab_menu6" class="tab_menu" onclick="fn_moveTab('EDCK0209');">Layout</li>
								<li id="tab_menu7" class="tab_menu" onclick="fn_moveTab('EDCK0212');">Edit Check</li>
								<li id="tab_menu8" class="tab_menu" onclick="fn_moveTab('EDCK0214');">T-Domain</li>
							</ul>
						</div>

						<section class="con_title_01">
							<articla class="conTitBox">
							<h5 id="tabTitle">${ TASK_NO }-${ EDC_VER }</h5>
							</articla>


							<div class="conTitBtnR">
								<button type="button" class="edit_01" id="btn_edit" onclick="editMode(true);" title="<spring:message code="btn.update" />">
									<spring:message code="btn.update" />
								</button>
							</div>
						</section>


						<div class="conSbtLn left_001">
							<article class="conTitBox">
								<h6>
									<spring:message code="edc.lbl.VISIT" />
								</h6>
							</article>
							<article class="conTitBtnR">
								<button type="button" onclick="moveRowsToUp(EDCK0207_grid)" able>▲</button>
								<button type="button" onclick="moveRowsToDown(EDCK0207_grid)" able>▼</button>
								<button type="button" class="add_01" onclick="addRow();" title="<spring:message code="btn.rowAdd"/>" able>
									<spring:message code="btn.rowAdd" />
								</button>
								<button type="button" class="del_01" onclick="deleteVisit(EDCK0207_grid)" title="<spring:message code="btn.rowDelete" />" able>
									<spring:message code="btn.rowDelete" />
								</button>
								<button type="button" class="save_01" onclick="saveGrid();" title="<spring:message code="btn.save" />" able>
									<spring:message code="btn.save" />
								</button>
							</article>
							<article class="mgT16">
								<div id="EDCK0207_grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
								<!-- <div id="EDCK0101_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
							</article>
						</div>


						<div class="conSbtLn right_001">
							<article class="conTitBox">
								<h6>
									<spring:message code="edc.lbl.GROUP" />
								</h6>
							</article>
							<article class="mgT16">
								<div id="EDCK0207_grid2" class="gridHeiSz05 grid_wrap tb01_2"></div>
							</article>
						</div>


						<div class="bottom_arrow_btn_01">
							<button class="big_arrow_btn_01" type="button" onclick="moveGroup(1);" able>▼</button>
						</div>


						<div class="conSbtLn right_002">
							<article class="conTitBox">
								<h6>
									<spring:message code="edc.lbl.VISIT_GROUP" />
								</h6>
							</article>
							<article class="conTitBtnR">
								<button type="button" onclick="moveRowsToUp(EDCK0207_grid3)" able>▲</button>
								<button type="button" onclick="moveRowsToDown(EDCK0207_grid3)" able>▼</button>
								<button type="button" class="del_01" onclick="moveGroup(2)" title="<spring:message code="btn.rowDelete" />" able>
									<spring:message code="btn.rowDelete" />
								</button>
								<button type="button" class="save_01" onclick="saveGrid2();" title="<spring:message code="btn.save" />" able>
									<spring:message code="btn.save" />
								</button>
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