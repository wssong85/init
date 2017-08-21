<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/com/common.do" flush="false" />

<title>Lab 정상밤위 관리 목록</title>
<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}
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
				var gridParam = $("#frm_main").serialize();
				EDCK0214_grid.proxy.param = gridParam;
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
				EDCK0214_grid2.proxy.param = gridParam;
				EDCK0214_grid2.createGrid();

				codeList = new Array();
				<c:forEach items="${ EDC032 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0214_grid3, "TI_SE_CODE", codeList);
				EDCK0214_grid3.proxy.param = gridParam;
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
				EDCK0214_grid4.proxy.param = gridParam;
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
			headerText : "Element Code" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_LBL",
			headerText : "TE_LBL" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_BEGIN_CND",
			headerText : "TE_BEGIN_CND" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_END_CND",
			headerText : "TE_END_CND" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_PD",
			headerText : "TE_PD" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
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
			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				return fn_checkGridNull(event);
			});
			AUIGrid.bind(me.id, 'cellClick', function(event) {
				fn_deleteGridRow(me, event);
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
		if (confirm("저장?")) {
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
							alert("성공");
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
				alert("변경 없음");
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
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TA_CODE",
			headerText : "TA_CODE" + "<span class='must_01'></span>",
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
			headerText : "TA_LBL" + "<span class='must_01'></span>",
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
			headerText : "TE_NO",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TE_CODE",
			headerText : "TE_CODE" + "<span class='must_01'></span>",
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
			headerText : "TE_LBL" + "<span class='must_01'></span>",
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
			headerText : "TA_QU_CND",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TA_TRAN_RULE",
			headerText : "TA_TRAN_RULE",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TA_EPOCH",
			headerText : "TA_EPOCH" + "<span class='must_01'></span>",
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

			AUIGrid.bind(me.id, 'cellClick', function(event) {
				fn_deleteGridRow(me, event);
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	function save_EDCK0214_grid2() {
		if (confirm("저장?")) {
			var rowItems = AUIGrid.getGridData(EDCK0214_grid2.id);
			for (var i = 0; i < rowItems.length; i++) {
				var item = {
					TE_SORTORDR : (i + 1)
				};
				AUIGrid.updateRow(EDCK0214_grid2.id, item, i, true);
			}

			var arJson = [];
			rowItems = AUIGrid.getAddedRowItems(EDCK0214_grid2.id);
			fn_makeArr(arJson, rowItems, "C");
			rowItems = AUIGrid.getEditedRowItems(EDCK0214_grid2.id);
			fn_makeArr(arJson, rowItems, "U");
			rowItems = AUIGrid.getRemovedItems(EDCK0214_grid2.id);
			fn_makeArr(arJson, rowItems, "D");

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
							alert("성공");
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
				alert("변경 없음");
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
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "TI_SN"
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "TI_SN",
			headerText : "TI_SN",
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
			dataField : "TI_VER",
			headerText : "TI_VER",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TI_CODE",
			headerText : "TI_CODE" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TI_SE_CODE",
			headerText : "TI_SE_CODE" + "<span class='must_01'></span>",
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
			headerText : "TI_CL" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TI_CN",
			headerText : "TI_CN" + "<span class='must_01'></span>",
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
		if (confirm("저장?")) {
			var arJson = [];
			rowItems = AUIGrid.getAddedRowItems(EDCK0214_grid3.id);
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
							alert("성공");
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
				alert("변경 없음");
			}
		}
	}
	function versionUp_EDCK0214_grid3() {
		if (confirm("버전을 올려 작성하시겠습니까?")) {
			var param = $("#frm_main").serialize();
			$.ajax({
				url : './insertInclusionVersion.do',
				data : param,
				type : 'post',
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						EDCK0214_grid3.load();
						alert("성공");
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
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
			headerText : "TS_NO" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_GROUP_ID",
			headerText : "TS_GROUP_ID",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_PARAMTR_CODE",
			headerText : "TS_PARAMTR_CODE" + "<span class='must_01'></span>",
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
			headerText : "TS_PARAMTR" + "<span class='must_01'></span>",
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
			headerText : "TS_VALUE" + "<span class='must_01'></span>",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_NFLAVOR",
			headerText : "TS_NFLAVOR",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_VALUE_CODE",
			headerText : "TS_VALUE_CODE",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_VALUE_CODE_REFRN",
			headerText : "TS_VALUE_CODE_REFRN",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "TS_REFRN_VER",
			headerText : "TS_REFRN_VER",
			filter : {
				showIcon : true
			}
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
			AUIGrid.bind(me.id, 'cellClick', function(event) {
				fn_deleteGridRow(me, event);
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function save_EDCK0214_grid4() {
		if (confirm("저장?")) {
			var rowItems = AUIGrid.getGridData(EDCK0214_grid4.id);
			for (var i = 0; i < rowItems.length; i++) {
				var item = {
					TE_SORTORDR : (i + 1)
				};
				AUIGrid.updateRow(EDCK0214_grid4.id, item, i, true);
			}

			var arJson = [];
			rowItems = AUIGrid.getAddedRowItems(EDCK0214_grid4.id);
			fn_makeArr(arJson, rowItems, "C");
			rowItems = AUIGrid.getEditedRowItems(EDCK0214_grid4.id);
			fn_makeArr(arJson, rowItems, "U");
			rowItems = AUIGrid.getRemovedItems(EDCK0214_grid4.id);
			fn_makeArr(arJson, rowItems, "D");

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
							alert("성공");
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
				alert("변경 없음");
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
							editMode('EDCK0214_grid', '1', EDCK0214_grid);
						} else {
							editMode('EDCK0214_grid', '2', EDCK0214_grid);
						}
					} else if ($(this).attr("id") == "acd2") {
						AUIGrid.resize(EDCK0214_grid2.id);
						EDCK0214_grid2.load();
						if (AUIGrid.getRowCount(EDCK0214_grid2.id) > 0) {
							editMode('EDCK0214_grid2', '1', EDCK0214_grid2);
						} else {
							editMode('EDCK0214_grid2', '2', EDCK0214_grid2);
						}
					} else if ($(this).attr("id") == "acd3") {
						AUIGrid.resize(EDCK0214_grid3.id);
						EDCK0214_grid3.load();
						if (AUIGrid.getRowCount(EDCK0214_grid3.id) > 0) {
							editMode('EDCK0214_grid3', '1', EDCK0214_grid3);
						} else {
							editMode('EDCK0214_grid3', '2', EDCK0214_grid3);
						}
					} else if ($(this).attr("id") == "acd4") {
						AUIGrid.resize(EDCK0214_grid4.id);
						EDCK0214_grid4.load();
						if (AUIGrid.getRowCount(EDCK0214_grid4.id) > 0) {
							editMode('EDCK0214_grid4', '1', EDCK0214_grid4);
						} else {
							editMode('EDCK0214_grid4', '2', EDCK0214_grid4);
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

	function editMode(gridId, c, grid) {
		if (c == "1") {
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
				<h3>EDC Designer</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>과제관리</li>
						<li>EDC Designer</li>
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
		            		<h5 id="tabTitle">${ TASK_NO } - ${ EDC_VER }</h5>
		            	</articla>




						<article class="mgT16">
							<ul id="acdMenu01">
								<li class="acdMenuLst acdMenuLst01" id="li_EDCK0214_grid">
									<a class="acdMenuLik close" id="acd">Element</a>
									<div class="acdMenuCts acdMenuCts01 close">
										<article class="conTitBtnR">
											<button type="button" id="btn_edit" onclick="editMode('EDCK0214_grid', '2', EDCK0214_grid)">수정</button>
											<button type="button" able onclick="addRow(EDCK0214_grid)">행추가</button>
											<button type="button" able onclick="fn_deleteRow(EDCK0214_grid)">행삭제</button>
											<button type="button" able onclick="save_EDCK0214_grid()">저장</button>
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
											<button type="button" id="btn_edit" onclick="editMode('EDCK0214_grid2', '2', EDCK0214_grid2)">수정</button>
											<button type="button" able onclick="popupArm()">Arm Code</button>
											<button type="button" able onclick="addRow(EDCK0214_grid2)">행추가</button>
											<button type="button" able onclick="fn_deleteRow(EDCK0214_grid2)">행삭제</button>
											<button type="button" able onclick="moveRowsToUp_EDCK0214_grid2()">▲</button>
											<button type="button" able onclick="moveRowsToDown_EDCK0214_grid2()">▼</button>
											<button type="button" able onclick="save_EDCK0214_grid2()">저장</button>
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
											<button type="button" id="btn_edit" onclick="editMode('EDCK0214_grid3', '2', EDCK0214_grid3)">수정</button>
											<button type="button" able onclick="addRow(EDCK0214_grid3)">행추가</button>
											<button type="button" able onclick="fn_deleteRow(EDCK0214_grid3)">행삭제</button>
											<button type="button" able onclick="versionUp_EDCK0214_grid3()">버전업</button>
											<button type="button" able onclick="save_EDCK0214_grid3()">저장</button>
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
											<button type="button" id="btn_edit" onclick="editMode('EDCK0214_grid4', '2', EDCK0214_grid4)">수정</button>
											<button type="button" able onclick="addRow(EDCK0214_grid4)">행추가</button>
											<button type="button" able onclick="fn_deleteRow(EDCK0214_grid3)">행삭제</button>
											<button type="button" able onclick="save_EDCK0214_grid4()">저장</button>
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