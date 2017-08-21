<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>
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
</style>
<script type="text/javascript">
	var msg1 = '<spring:message code="edc.required.msg" />';
	var msg2 = '<spring:message code="edc.byte.msg" />';

	$(document).ready(function() {
		if ($("#frm_main #TASK_SN").val() == "") {
			alert('<spring:message code="edc.taskSelect.msg" />');
			location.replace("./EDCK0201.do");
		} else {
			if ($("#frm_main #EDC_VER").val() == "") {
				alert('<spring:message code="edc.edcSelect.msg" />');
				fn_moveTab('EDCK0202');
			} else {
				var grid_param = $("#frm_main").serialize();
				EDCK0214_grid.proxy.param = grid_param;
				EDCK0214_grid.createGrid();

				var codeList = new Array();
				<c:forEach items="${ ARM_CODE }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid2, "TA_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ ARM_LABEL }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid2, "TA_LBL", codeList);

				codeList = new Array();
				<c:forEach items="${ ELEMENT_CODE }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid2, "TE_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ ELEMENT_LABEL }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid2, "TE_LBL", codeList);
				EDCK0214_grid2.proxy.param = grid_param;
				EDCK0214_grid2.createGrid();

				codeList = new Array();
				<c:forEach items="${ EDC032 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid3, "TI_SE_CODE", codeList);
				EDCK0214_grid3.proxy.param = grid_param;
				EDCK0214_grid3.createGrid();

				codeList = new Array();
				<c:forEach items="${ EDC }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid4, "TS_PARAMTR_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid4, "TS_PARAMTR", codeList);
				EDCK0214_grid4.proxy.param = grid_param;
				EDCK0214_grid4.createGrid();

				toggleClass();
			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0214_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0214_grid.id);
		}
		if (typeof EDCK0214_grid2.id !== "undefined") {
			AUIGrid.resize(EDCK0214_grid2.id);
		}
		if (typeof EDCK0214_grid3.id !== "undefined") {
			AUIGrid.resize(EDCK0214_grid3.id);
		}
		if (typeof EDCK0214_grid4.id !== "undefined") {
			AUIGrid.resize(EDCK0214_grid4.id);
		}
	};
	var EDCK0214_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0214_grid',
			paging : {
				pagingDiv : 'EDCK0214_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectElementList.do',
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
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "TE_SN"
		},
		//AUI 그리드 레이아웃
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
			dataField : "TE_SN",
			headerText : "TE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TE_CODE",
			headerText : '<spring:message code="edc.lbl.TE_CODE" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_LBL",
			headerText : '<spring:message code="edc.lbl.TE_LBL" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_BEGIN_CND",
			headerText : '<spring:message code="edc.lbl.TE_BEGIN_CND" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_END_CND",
			headerText : '<spring:message code="edc.lbl.TE_END_CND" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_PD",
			headerText : '<spring:message code="edc.lbl.TE_PD" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function addRow(grid) {
		var item = {
			TASK_SN : $("#frm_main #TASK_SN").val(),
			EDC_VER : $("#frm_main #EDC_VER").val()
		};
		AUIGrid.addRow(grid.id, item, "first");
	}

	function save_EDCK0214_grid() {
		AUIGrid.forceEditingComplete(EDCK0214_grid.id, null, false);
		var rowItems = AUIGrid.getGridData(EDCK0214_grid.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].TE_CODE || rowItems[i].TE_CODE.length <= 0) {
				alert("TE_CODE" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			if (!rowItems[i].TE_LBL || rowItems[i].TE_LBL.length <= 0) {
				alert("TE_LBL" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			if (!rowItems[i].TE_BEGIN_CND || rowItems[i].TE_BEGIN_CND.length <= 0) {
				alert("TE_BEGIN_CND" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			if (!rowItems[i].TE_END_CND || rowItems[i].TE_END_CND.length <= 0) {
				alert("TE_END_CND" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			if (!rowItems[i].TE_PD || rowItems[i].TE_PD.length <= 0) {
				alert("TE_PD" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			var text_byte = 200;
			var text = rowItems[i].TE_CODE;
			if (fn_getByte(text) > text_byte) {
				alert("TE_CODE" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			text = rowItems[i].TE_LBL;
			if (fn_getByte(text) > text_byte) {
				alert("TE_LBL" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			text_byte = 300;
			text = rowItems[i].TE_BEGIN_CND;
			if (fn_getByte(text) > text_byte) {
				alert("TE_BEGIN_CND" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			text = rowItems[i].TE_END_CND;
			if (fn_getByte(text) > text_byte) {
				alert("TE_END_CND" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}

			text = rowItems[i].TE_PD;
			if (fn_getByte(text) > text_byte) {
				alert("TE_PD" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid.id, i);
				return false;
			}
		}

		if (confirm('<spring:message code="edc.save.msg" />')) {
			var rowItems = AUIGrid.getGridData(EDCK0214_grid.id);
			var arJson = [];
			var rowItems = AUIGrid.getAddedRowItems(EDCK0214_grid.id);
			fn_makeArr(arJson, rowItems, "C");
			rowItems = AUIGrid.getEditedRowItems(EDCK0214_grid.id);
			fn_makeArr(arJson, rowItems, "U");
			rowItems = AUIGrid.getRemovedItems(EDCK0214_grid.id);
			fn_makeArr(arJson, rowItems, "D");
			if (arJson.length > 0) {
				AUIGrid.showAjaxLoader(EDCK0214_grid.id);
				$.ajax({
					url : './insertElementList.do',
					data : JSON.stringify(arJson),
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0214_grid.load();
							alert('<spring:message code="edc.save.confirm.msg" />');
						} else {
							alert(data.message);
						}
						AUIGrid.removeAjaxLoader(EDCK0214_grid.id);
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

	var EDCK0214_grid2 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0214_grid2',
			paging : {
				pagingDiv : 'EDCK0214_grid2_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectArmList.do',
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
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "RN"
		},
		columnLayout : [ {
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
			dataField : "TA_SN",
			headerText : "TA_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TA_NO",
			headerText : "TA_NO",
			headerText : '<spring:message code="edc.lbl.TA_NO" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TA_CODE",
			headerText : '<spring:message code="edc.lbl.TA_CODE" />' + "<span class='must_01'></span>",
			sortable : false,
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
			dataField : "TA_LBL",
			headerText : '<spring:message code="edc.lbl.TA_LBL" />' + "<span class='must_01'></span>",
			sortable : false,
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
			dataField : "TA_DETAIL_SN",
			headerText : "TA_DETAIL_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TE_SN",
			headerText : "TE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TE_NO",
			headerText : '<spring:message code="edc.lbl.TE_NO" />' + "<span class='must_01'></span>",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_CODE",
			headerText : '<spring:message code="edc.lbl.TE_CODE" />' + "<span class='must_01'></span>",
			sortable : false,
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
			dataField : "TE_LBL",
			headerText : '<spring:message code="edc.lbl.TE_LBL" />' + "<span class='must_01'></span>",
			sortable : false,
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
			dataField : "TA_QU_CND",
			headerText : '<spring:message code="edc.lbl.TA_QU_CND" />',
			sortable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TA_TRAN_RULE",
			headerText : '<spring:message code="edc.lbl.TA_TRAN_RULE" />',
			sortable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TA_EPOCH",
			headerText : '<spring:message code="edc.lbl.TA_EPOCH" />' + "<span class='must_01'></span>",
			sortable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_SORTORDR",
			headerText : "TE_SORTORDR",
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
			AUIGrid.bind(me.id, "cellEditEnd", function(event) {
				if (event.dataField == "TA_LBL") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					var item = {
						TA_CODE : rowItem.TA_LBL,
						TA_SN : rowItem.TA_LBL
					};
					AUIGrid.updateRow(me.id, item, event.rowIndex, false);
				} else if (event.dataField == "TA_CODE") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					var item = {
						TA_LBL : rowItem.TA_CODE,
						TA_SN : rowItem.TA_CODE
					};
					AUIGrid.updateRow(me.id, item, event.rowIndex, false);
				} else if (event.dataField == "TE_LBL") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					var item = {
						TE_CODE : rowItem.TE_LBL,
						TE_SN : rowItem.TE_LBL
					};
					AUIGrid.updateRow(me.id, item, event.rowIndex, false);
				} else if (event.dataField == "TE_CODE") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					var item = {
						TE_LBL : rowItem.TE_CODE,
						TE_SN : rowItem.TE_CODE
					};
					AUIGrid.updateRow(me.id, item, event.rowIndex, false);
				}
			});

			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				return fn_checkGridNull(event);
			});

		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	function save_EDCK0214_grid2() {
		AUIGrid.forceEditingComplete(EDCK0214_grid2.id, null, false);

		var rowItems = AUIGrid.getGridData(EDCK0214_grid2.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].TA_CODE || rowItems[i].TA_CODE.length <= 0) {
				alert("TA_CODE" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid2.id, i);
				return false;
			}

			if (!rowItems[i].TA_LBL || rowItems[i].TA_LBL.length <= 0) {
				alert("TA_LBL" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid2.id, i);
				return false;
			}

			if (!rowItems[i].TE_CODE || rowItems[i].TE_CODE.length <= 0) {
				alert("TE_CODE" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid2.id, i);
				return false;
			}

			if (!rowItems[i].TE_LBL || rowItems[i].TE_LBL.length <= 0) {
				alert("TE_LBL" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid2.id, i);
				return false;
			}

			if (!rowItems[i].TA_EPOCH || rowItems[i].TA_EPOCH.length <= 0) {
				alert("TA_EPOCH" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid2.id, i);
				return false;
			}

			var text_byte = 300;
			text = rowItems[i].TA_EPOCH;
			if (fn_getByte(text) > text_byte) {
				alert("TA_EPOCH" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid2.id, i);
				return false;
			}
		}

		if (confirm('<spring:message code="edc.save.msg" />')) {
			var arJson = [];
			for (var i = 0; i < rowItems.length; i++) {
				rowItems[i].TE_SORTORDR = (i + 1);

				if (AUIGrid.isAddedById(EDCK0214_grid2.id, rowItems[i].RN)) {
					rowItems[i].CRUD = "C";
				} else if (AUIGrid.isEditedById(EDCK0214_grid2.id, rowItems[i].RN)) {
					rowItems[i].CRUD = "U";
				} else if (AUIGrid.isRemovedById(EDCK0214_grid2.id, rowItems[i].RN)) {
					rowItems[i].CRUD = "D";
				} else {
					rowItems[i].CRUD = "U";
				}
				arJson.push(rowItems[i]);
			}

			if (arJson.length > 0) {
				AUIGrid.showAjaxLoader(EDCK0214_grid2.id);
				$.ajax({
					url : './insertArmList.do',
					data : JSON.stringify(arJson),
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0214_grid2.load();
							alert('<spring:message code="edc.save.confirm.msg" />');
						} else {
							alert(data.message);
						}
						AUIGrid.removeAjaxLoader(EDCK0214_grid2.id);
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
	function moveRowsToUp_EDCK0214_grid2() {
		AUIGrid.moveRowsToUp(EDCK0214_grid2.id);
	};

	// 선택 행들 아래로 한 단계 올림
	function moveRowsToDown_EDCK0214_grid2() {
		AUIGrid.moveRowsToDown(EDCK0214_grid2.id);
	};

	var EDCK0214_grid3 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0214_grid3',
			paging : {
				pagingDiv : 'EDCK0214_grid3_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectInclusionList.do',
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
			showStateColumn : false,
			softRemovePolicy : "exceptNew",
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "TI_SN"
		},
		//AUI 그리드 레이아웃
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
			dataField : "TI_SN",
			headerText : "TI_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TI_VER",
			headerText : '<spring:message code="edc.lbl.TI_VER" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TI_CODE",
			headerText : '<spring:message code="edc.lbl.TI_CODE" />',
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TI_SE_CODE",
			headerText : '<spring:message code="edc.lbl.TI_SE_CODE" />' + "<span class='must_01'></span>",
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
			dataField : "TI_CL",
			headerText : '<spring:message code="edc.lbl.TI_CL" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TI_CN",
			headerText : '<spring:message code="edc.lbl.TI_CN" />' + "<span class='must_01'></span>",
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function save_EDCK0214_grid3() {
		AUIGrid.forceEditingComplete(EDCK0214_grid3.id, null, false);
		var rowItems = AUIGrid.getGridData(EDCK0214_grid3.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].TI_CODE || rowItems[i].TI_CODE.length <= 0) {
				alert("TI_CODE" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid3.id, i);
				return false;
			}

			if (!rowItems[i].TI_SE_CODE || rowItems[i].TI_SE_CODE.length <= 0) {
				alert("TI_SE_CODE" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid3.id, i);
				return false;
			}

			if (!rowItems[i].TI_CL || rowItems[i].TI_CL.length <= 0) {
				alert("TI_CL" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid3.id, i);
				return false;
			}

			if (!rowItems[i].TI_CN || rowItems[i].TI_CN.length <= 0) {
				alert("TI_CN" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid3.id, i);
				return false;
			}

			var text_byte = 10;
			text = rowItems[i].TI_CL;
			if (fn_getByte(text) > text_byte) {
				alert("TI_CL" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid3.id, i);
				return false;
			}

			text_byte = 300;
			text = rowItems[i].TI_CODE;
			if (fn_getByte(text) > text_byte) {
				alert("TI_CODE" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid3.id, i);
				return false;
			}

			text = rowItems[i].TI_CN;
			if (fn_getByte(text) > text_byte) {
				alert("TI_CN" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid3.id, i);
				return false;
			}

		}

		if (confirm('<spring:message code="edc.save.msg" />')) {
			var arJson = [];
			fn_makeArr(arJson, rowItems, "C");
			rowItems = AUIGrid.getEditedRowItems(EDCK0214_grid3.id);
			fn_makeArr(arJson, rowItems, "U");
			rowItems = AUIGrid.getRemovedItems(EDCK0214_grid3.id);
			fn_makeArr(arJson, rowItems, "D");

			if (arJson.length > 0) {
				AUIGrid.showAjaxLoader(EDCK0214_grid3.id);
				$.ajax({
					url : './insertInclusionList.do',
					data : JSON.stringify(arJson),
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0214_grid3.load();
							alert('<spring:message code="edc.save.confirm.msg" />');
						} else {
							alert(data.message);
						}
						AUIGrid.removeAjaxLoader(EDCK0214_grid3.id);
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
	function versionUp_EDCK0214_grid3() {
		if (confirm('<spring:message code="edc.tiVersionUp.msg" />')) {
			if (AUIGrid.getRowCount(EDCK0214_grid3.id) > 0) {
				var param = $("#frm_main").serialize();
				$.ajax({
					url : './insertInclusionVersion.do',
					data : param,
					type : 'post',
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0214_grid3.load();
							alert('<spring:message code="edc.save.confirm.msg" />');
						} else {
							alert(data.message);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert(textStatus);
					}
				});
			} else {
				alert('<spring:message code="edc.noTiData.msg" />');
			}
		}
	}

	var EDCK0214_grid4 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0214_grid4',
			paging : {
				pagingDiv : 'EDCK0214_grid4_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectTrialSummaryList.do',
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
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "TS_SN"
		},
		columnLayout : [ {
			dataField : "TS_SN",
			headerText : "TS_SN",
			visible : false
		}, {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			visible : false
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER",
			visible : false
		}, {
			dataField : "TS_NO",
			headerText : '<spring:message code="edc.lbl.TS_NO" />' + "<span class='must_01'></span>",
			width : 70,
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true
			}
		}, {
			dataField : "TS_GROUP_ID",
			headerText : '<spring:message code="edc.lbl.TS_GROUP_ID" />',
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_PARAMTR_CODE",
			headerText : '<spring:message code="edc.lbl.TS_PARAMTR_CODE" />' + "<span class='must_01'></span>",
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
			dataField : "TS_PARAMTR",
			headerText : '<spring:message code="edc.lbl.TS_PARAMTR" />' + "<span class='must_01'></span>",
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
			dataField : "TS_VALUE",
			headerText : '<spring:message code="edc.lbl.TS_VALUE" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_NFLAVOR",
			headerText : '<spring:message code="edc.lbl.TS_NFLAVOR" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_VALUE_CODE",
			headerText : '<spring:message code="edc.lbl.TS_VALUE_CODE" />' + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_VALUE_CODE_REFRN",
			headerText : '<spring:message code="edc.lbl.TS_VALUE_CODE_REFRN" />',
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_REFRN_VER",
			headerText : '<spring:message code="edc.lbl.TS_REFRN_VER" />',
			filter : {
				showIcon : true
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
			AUIGrid.bind(me.id, "cellEditEnd", function(event) {
				if (event.dataField == "TS_PARAMTR_CODE") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					var item = {
						TS_PARAMTR : rowItem.TS_PARAMTR_CODE
					};
					AUIGrid.updateRow(me.id, item, event.rowIndex, false);
				} else if (event.dataField == "TS_PARAMTR") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					var item = {
						TS_PARAMTR_CODE : rowItem.TS_PARAMTR
					};
					AUIGrid.updateRow(me.id, item, event.rowIndex, false);
				}
			});
			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				return fn_checkGridNull(event);
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function save_EDCK0214_grid4() {
		AUIGrid.forceEditingComplete(EDCK0214_grid4.id, null, false);
		var rowItems = AUIGrid.getGridData(EDCK0214_grid4.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].TS_NO || rowItems[i].TS_NO.length <= 0) {
				alert("TS_NO" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

			/* 	if (!rowItems[i].TS_PARAMTR_CODE || rowItems[i].TS_PARAMTR_CODE.length <= 0) {
					alert("TS_PARAMTR_CODE" + "\n" + msg1);
					AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
					return false;
				}

				if (!rowItems[i].TS_PARAMTR || rowItems[i].TS_PARAMTR.length <= 0) {
					alert("TS_PARAMTR" + "\n" + msg1);
					AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
					return false;
				} */

			if (!rowItems[i].TS_VALUE || rowItems[i].TS_VALUE.length <= 0) {
				alert("TS_VALUE" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

			var text_byte = 6;
			text = rowItems[i].TS_VALUE;
			if (fn_getByte(text) > text_byte) {
				alert("TS_VALUE" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

			text_byte = 200;
			text = rowItems[i].TS_GROUP_ID;
			if (fn_getByte(text) > text_byte) {
				alert("TS_GROUP_ID" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

			text_byte = 300;
			text = rowItems[i].TS_VALUE;
			if (fn_getByte(text) > text_byte) {
				alert("TS_VALUE" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}
			text = rowItems[i].TS_NFLAVOR;
			if (fn_getByte(text) > text_byte) {
				alert("TS_NFLAVOR" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

			text = rowItems[i].TS_VALUE_CODE;
			if (fn_getByte(text) > text_byte) {
				alert("TS_VALUE_CODE" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

			text = rowItems[i].TS_VALUE_CODE_REFRN;
			if (fn_getByte(text) > text_byte) {
				alert("TS_VALUE_CODE_REFRN" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

			text = rowItems[i].TS_REFRN_VER;
			if (fn_getByte(text) > text_byte) {
				alert("TS_REFRN_VER" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214_grid4.id, i);
				return false;
			}

		}

		if (confirm('<spring:message code="edc.save.msg" />')) {
			var arJson = [];
			for (var i = 0; i < rowItems.length; i++) {

				if (AUIGrid.isAddedById(EDCK0214_grid4.id, rowItems[i].TS_SN)) {
					rowItems[i].CRUD = "C";
					arJson.push(rowItems[i]);
				} else if (AUIGrid.isEditedById(EDCK0214_grid4.id, rowItems[i].TS_SN)) {
					rowItems[i].CRUD = "U";
					arJson.push(rowItems[i]);
				} else if (AUIGrid.isRemovedById(EDCK0214_grid4.id, rowItems[i].TS_SN)) {
					rowItems[i].CRUD = "D";
					arJson.push(rowItems[i]);
				}

			}
			if (arJson.length > 0) {
				AUIGrid.showAjaxLoader(EDCK0214_grid4.id);
				$.ajax({
					url : './insertTrialSummary.do',
					data : JSON.stringify(arJson),
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0214_grid4.load();
							alert('<spring:message code="edc.save.confirm.msg" />');
						} else {
							alert(data.message);
						}
						AUIGrid.removeAjaxLoader(EDCK0214_grid4.id);
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

	function toggleClass() {
		$(".acdMenuLst01 > a").on("click", function() {
			if ($(this).hasClass("close")) {
				$(this).siblings(".acdMenuCts01").slideToggle(500);
				$(this).toggleClass('open');
				if ($(this).hasClass("open")) {
					if ($(this).attr("id") == "acd") {
						AUIGrid.resize(EDCK0214_grid.id);
						EDCK0214_grid.load();
						if (AUIGrid.getRowCount(EDCK0214_grid.id) > 0) {
							editMode('EDCK0214_grid', false, EDCK0214_grid);
						} else {
							editMode('EDCK0214_grid', true, EDCK0214_grid);
						}
					} else if ($(this).attr("id") == "acd2") {
						AUIGrid.resize(EDCK0214_grid2.id);
						EDCK0214_grid2.load();
						if (AUIGrid.getRowCount(EDCK0214_grid2.id) > 0) {
							editMode('EDCK0214_grid2', false, EDCK0214_grid2);
						} else {
							editMode('EDCK0214_grid2', true, EDCK0214_grid2);
						}
					} else if ($(this).attr("id") == "acd3") {
						AUIGrid.resize(EDCK0214_grid3.id);
						EDCK0214_grid3.load();
						if (AUIGrid.getRowCount(EDCK0214_grid3.id) > 0) {
							editMode('EDCK0214_grid3', false, EDCK0214_grid3);
						} else {
							editMode('EDCK0214_grid3', true, EDCK0214_grid3);
						}
					} else if ($(this).attr("id") == "acd4") {
						AUIGrid.resize(EDCK0214_grid4.id);
						EDCK0214_grid4.load();
						if (AUIGrid.getRowCount(EDCK0214_grid4.id) > 0) {
							editMode('EDCK0214_grid4', false, EDCK0214_grid4);
						} else {
							editMode('EDCK0214_grid4', true, EDCK0214_grid4);
						}
					}

				}
			}
		});

		$(".acdMenuLst01").not(this).on("click", function() {
			if ($(".acdMenuLst01").not(this).children().hasClass("close")) {
				$(".acdMenuLst01").not(this).children(".acdMenuCts01").slideUp(500);
			}
		});

		$(".acdMenuLst01 > a").not(this).on("click", function() {
			if ($(".acdMenuLst01 > a").hasClass('open')) {
				$(".acdMenuLst01 > a").not(this).removeClass('open');

			}
		});
	}
	function popupArm() {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.EDC_VER = $("#frm_main #EDC_VER").val();
		mkLayerPopupOpen("/edc/k02/popupEDCK0214Sub01.do", param);
		AUIGrid.resize(EDCK0214Sub01_grid.id);
	}

	function editMode(gridId, e, grid) {
		if (!e) {
			$("#li_" + gridId + " [able]").attr("disabled", true);
			$("#li_" + gridId + " button").hide();
			$("#li_" + gridId + " #btn_edit").show();
			AUIGrid.setProperty(grid.id, {
				"editable" : false
			});
		} else {
			$("#li_" + gridId + " [able]").attr("disabled", false);
			$("#li_" + gridId + " button").show();
			$("#li_" + gridId + " #btn_edit").hide();
			var selIdx = AUIGrid.getSelectedIndex(grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(grid.id, grid.gridPros.selectionMode);
				AUIGrid.setProperty(grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(grid.id, selIdx[0], selIdx[1])
			} else {
				AUIGrid.setProperty(grid.id, {
					"editable" : true
				});
			}
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0214&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0214&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />




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


						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_menu1" class="tab_menu" onclick="fn_moveTab('EDCK0202');">CRF List</li>
								<li id="tab_menu2" class="tab_menu" onclick="fn_moveTab('EDCK0203');">Template</li>
								<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0204');">Group</li>
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
								<li id="tab_menu9" class="tab_menu" onclick="fn_moveTab('EDCK0218');">Coding</li>
								<li id="tab_menu5" class="tab_menu" onclick="fn_moveTab('EDCK0208');">Dictionary</li>
								<li id="tab_menu6" class="tab_menu" onclick="fn_moveTab('EDCK0209');">Layout</li>
								<li id="tab_menu7" class="tab_menu" onclick="fn_moveTab('EDCK0212');">Edit Check</li>
								<li id="tab_menu8" class="port_back tab_menu">T-Domain</li>
							</ul>
						</div>



						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
							<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
						</form>



						<articla class="conTitBox">
						<h5 id="tabTitle">${ TASK_NO }-${ EDC_VER }</h5>
						</articla>




						<article class="mgT16">
							<ul id="acdMenu01">
								<li class="acdMenuLst acdMenuLst01" id="li_EDCK0214_grid">
									<a class="acdMenuLik close" id="acd">Element</a>
									<div class="acdMenuCts acdMenuCts01 close">
										<article class="conTitBtnR">
											<button type="button" class="edit_01" id="btn_edit" onclick="editMode('EDCK0214_grid', true, EDCK0214_grid)" title="<spring:message code="btn.update" />">
												<spring:message code="btn.update" />
											</button>
											<button type="button" class="add_01" onclick="addRow(EDCK0214_grid)" title="<spring:message code="btn.rowAdd"/>" able>
												<spring:message code="btn.rowAdd" />
											</button>
											<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0214_grid)" title="<spring:message code="btn.update" />" able>
												<spring:message code="btn.rowDelete" />
											</button>
											<button type="button" class="save_01" onclick="save_EDCK0214_grid()" title="<spring:message code="btn.save" />" able>
												<spring:message code="btn.save" />
											</button>
										</article>
										<article class="mgT35">
											<div id="EDCK0214_grid" class="gridHeiSz05 grid_wrap tb01_2"></div>
										</article>
									</div>
								</li>




								<li class="acdMenuLst acdMenuLst01" id="li_EDCK0214_grid2">
									<a class="acdMenuLik close" id="acd2">Arm</a>
									<div class="acdMenuCts acdMenuCts01 close">
										<article class="conTitBtnR">
											<button type="button" class="edit_01" id="btn_edit" onclick="editMode('EDCK0214_grid2', true, EDCK0214_grid2)" title="<spring:message code="btn.update" />">
												<spring:message code="btn.update" />
											</button>
											<button type="button" onclick="popupArm()" able>Arm Code</button>
											<button type="button" class="add_01" onclick="addRow(EDCK0214_grid2)" title="<spring:message code="btn.rowAdd"/>" able>
												<spring:message code="btn.rowAdd" />
											</button>
											<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0214_grid2)" title="<spring:message code="btn.rowDelete" />" able>
												<spring:message code="btn.rowDelete" />
											</button>
											<button type="button" onclick="moveRowsToUp_EDCK0214_grid2()" able>▲</button>
											<button type="button" onclick="moveRowsToDown_EDCK0214_grid2()" able>▼</button>
											<button type="button" class="save_01" onclick="save_EDCK0214_grid2()" title="<spring:message code="btn.save" />" able>
												<spring:message code="btn.save" />
											</button>
										</article>
										<article class="mgT35">
											<div id="EDCK0214_grid2" class="gridHeiSz05 grid_wrap tb01_2"></div>
										</article>
									</div>
								</li>




								<li class="acdMenuLst acdMenuLst01" id="li_EDCK0214_grid3">
									<a class="acdMenuLik close" id="acd3">Inclusion/Exclusion</a>
									<div class="acdMenuCts acdMenuCts01 close">
										<article class="conTitBtnR">
											<button type="button" class="edit_01" id="btn_edit" onclick="editMode('EDCK0214_grid3', true, EDCK0214_grid3)" title="<spring:message code="btn.update" />">
												<spring:message code="btn.update" />
											</button>
											<button type="button" onclick="versionUp_EDCK0214_grid3()" able>버전업</button>
											<button type="button" class="add_01" onclick="addRow(EDCK0214_grid3)" title="<spring:message code="btn.rowAdd"/>" able>
												<spring:message code="btn.rowAdd" />
											</button>
											<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0214_grid3)" title="<spring:message code="btn.rowDelete" />" able>
												<spring:message code="btn.rowDelete" />
											</button>
											<button type="button" class="save_01" onclick="save_EDCK0214_grid3()" title="<spring:message code="btn.save" />" able>
												<spring:message code="btn.save" />
											</button>
										</article>
										<article class="mgT35">
											<div id="EDCK0214_grid3" class="gridHeiSz05 grid_wrap tb01_2"></div>
										</article>
									</div>
								</li>




								<li class="acdMenuLst acdMenuLst01" id="li_EDCK0214_grid4">
									<a class="acdMenuLik close" id="acd4">Trial Summary</a>
									<div class="acdMenuCts acdMenuCts01 close">
										<article class="conTitBtnR">
											<button type="button" class="edit_01" id="btn_edit" onclick="editMode('EDCK0214_grid4', true, EDCK0214_grid4)" title="<spring:message code="btn.update" />">
												<spring:message code="btn.update" />
											</button>
											<button type="button" class="add_01" onclick="addRow(EDCK0214_grid4)" title="<spring:message code="btn.rowAdd"/>" able>
												<spring:message code="btn.rowAdd" />
											</button>
											<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0214_grid3)" title="<spring:message code="btn.rowDelete" />" able>
												<spring:message code="btn.rowDelete" />
											</button>
											<button type="button" class="save_01" onclick="save_EDCK0214_grid4()" title="<spring:message code="btn.save" />" able>
												<spring:message code="btn.save" />
											</button>
										</article>
										<article class="mgT35">
											<div id="EDCK0214_grid4" class="gridHeiSz05 grid_wrap tb01_2"></div>
										</article>
									</div>
								</li>


							</ul>
						</article>




					</div>
				</section>



			</div>
		</section>
	</div>
</body>
</html>