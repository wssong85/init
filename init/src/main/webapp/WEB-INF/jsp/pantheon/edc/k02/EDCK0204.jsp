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
	height: 67px;
	text-align: center;
	padding-top: 18px;
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
				<c:forEach items="${ EDC016 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0204_grid, "GROUP_SE_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC037 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0204_grid2, "VRIABL_TY_CODE", codeList);
				fn_setCodeList(EDCK0204_grid3, "VRIABL_TY_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC039 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0204_grid2, "CORE_CODE", codeList);
				fn_setCodeList(EDCK0204_grid3, "CORE_CODE", codeList);

				var grid_param = new Object();
				grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
				grid_param.EDC_VER = $("#frm_main #EDC_VER").val();

				EDCK0204_grid.proxy.param = grid_param;
				EDCK0204_grid.createGrid();

				EDCK0204_grid2.proxy.param = grid_param;
				EDCK0204_grid2.createGrid();
				AUIGrid.setGridData(EDCK0204_grid2.id, []);

				EDCK0204_grid3.createGrid();
				AUIGrid.setGridData(EDCK0204_grid3.id, []);
				if (AUIGrid.getRowCount(EDCK0204_grid.id) > 0) {
					editMode(false);
				} else {
					editMode(true);
				}

				$("#CDISC_DOMN_SN").select2();
			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0204_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0204_grid.id);
		}
		if (typeof EDCK0204_grid2.id !== "undefined") {
			AUIGrid.resize(EDCK0204_grid2.id);
		}
		if (typeof EDCK0204_grid3.id !== "undefined") {
			AUIGrid.resize(EDCK0204_grid3.id);
		}
	};
	var EDCK0204_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0204_grid',
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
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />' + "<span class='must_01'></span>",
			sortable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "GROUP_SE_CODE",
			headerText : '<spring:message code="edc.lbl.GROUP_SE_CODE" />' + "<span class='must_01'></span>",
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
			dataField : "GROUP_DC",
			headerText : '<spring:message code="edc.lbl.GROUP_DC" />',
			sortable : false,
			filter : {
				showIcon : true
			}
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
			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				if (event.dataField == "GROUP_SE_CODE") {
					if (event.oldValue == "06" && event.value != event.oldValue) {
						alert('<spring:message code="edc.lbl.REGIST" />' + '<spring:message code="edc.groupNoChange.msg" />');
						return event.oldValue;
					} else if (event.oldValue == "07" && event.value != event.oldValue) {
						alert('<spring:message code="edc.lbl.RANDOM" />' + '<spring:message code="edc.groupNoChange.msg" />');
						return event.oldValue;
					} else if (event.value == "02" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "GROUP_SE_CODE", "02").length > 0) {
							alert("CM " + '<spring:message code="edc.oneGroup.msg" />');
							return event.oldValue;
						}
					} else if (event.value == "03" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "GROUP_SE_CODE", "03").length > 0) {
							alert("AE " + '<spring:message code="edc.oneGroup.msg" />');
							return event.oldValue;
						}
					} else if (event.value == "04" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "GROUP_SE_CODE", "04").length > 0) {
							alert("EOS " + '<spring:message code="edc.oneGroup.msg" />');
							return event.oldValue;
						}
					} else if (event.value == "05" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "GROUP_SE_CODE", "05").length > 0) {
							alert("e-Sign " + '<spring:message code="edc.oneGroup.msg" />');
							return event.oldValue;
						}
					} else if (event.value == "06" && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "GROUP_SE_CODE", "05").length > 0) {
							alert('<spring:message code="edc.lbl.REGIST" />' + ' <spring:message code="edc.oneGroup.msg" />');
							return event.oldValue;
						}
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
					grid_param.GROUP_SN = rowItem.GROUP_SN;
					grid_param.TASK_SN = rowItem.TASK_SN;
					grid_param.EDC_VER = rowItem.EDC_VER;
					EDCK0204_grid3.proxy.param = grid_param;
					EDCK0204_grid3.load();
				} else {
					AUIGrid.setGridData(EDCK0204_grid3.id, []);
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	var EDCK0204_grid2 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0204_grid2',
			paging : {
				pagingDiv : 'EDCK0204_grid_paging2',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectVariableList.do',
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
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			fixedColumnCount : 3,
			selectionMode : "singleRow",
			rowIdField : "DOMN_VRIABL_SN"
		},
		columnLayout : [ {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN",
			editable : false,
			visible : false
		}, {
			dataField : "DOMN_NM",
			headerText : "DOMN_NM",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VRIABL_LBL",
			headerText : '<spring:message code="edc.lbl.VRIABL_LBL" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.UPPER_CDISC_SUBMIT_VALUE" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_ROLE",
			headerText : '<spring:message code="edc.lbl.VRIABL_ROLE" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CTRL_FOM",
			headerText : '<spring:message code="edc.lbl.CTRL_FOM" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : '<spring:message code="edc.lbl.VRIABL_TY_CODE" />',
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
			dataField : "CORE_CODE",
			headerText : '<spring:message code="edc.lbl.CORE_CODE" />',
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
			dataField : "VRIABL_DC",
			headerText : "VRIABL_DC",
			headerText : '<spring:message code="edc.lbl.VRIABL_DC" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "USER_DFN_AT",
			headerText : "USER_DFN_AT",
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
	var EDCK0204_grid3 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0204_grid3',
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
			url : './selectGroupInsideList.do',
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
			fixedColumnCount : 6,
			editableOnFixedCell : true,
			selectionMode : "singleRow",
			rowIdField : "VRIABL_SN"
		},
		columnLayout : [ {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_SN",
			headerText : "VRIABL_SN",
			editable : false,
			visible : false
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_ORDR",
			headerText : "VRIABL_ORDR",
			editable : false,
			visible : false
		}, {
			dataField : "DOMN_NM",
			headerText : '<spring:message code="edc.lbl.DOMN_NM" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VRIABL_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VRIABL_LBL",
			headerText : '<spring:message code="edc.lbl.VRIABL_LBL" />',
			headerText : "CRF_LBL_ONE",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.UPPER_CDISC_SUBMIT_VALUE" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.CDISC_SUBMIT_VALUE" />',
			sortable : false,
			style : "edc_column_style",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_ROLE",
			headerText : '<spring:message code="edc.lbl.VRIABL_ROLE" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CTRL_FOM",
			headerText : '<spring:message code="edc.lbl.CTRL_FOM" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : '<spring:message code="edc.lbl.VRIABL_TY_CODE" />',
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
			dataField : "CORE_CODE",
			headerText : '<spring:message code="edc.lbl.CORE_CODE" />',
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
			dataField : "VRIABL_DC",
			headerText : '<spring:message code="edc.lbl.VRIABL_DC" />',
			sortable : false,
			editable : false
		}, {
			dataField : "USER_DFN_AT",
			headerText : "USER_DFN_AT",
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
			dataField : "CRUD",
			headerText : "Delete",
			visible : false,
			editable : false
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
				if (AUIGrid.getProperty(me.id, "editable")) {
					if (event.dataField == "CDISC_SUBMIT_VALUE") {
						if (event.item.CDISC_UPPER_CODE != null) {
							var param = new Object();
							param.TASK_SN = $("#frm_main #TASK_SN").val();
							param.VRIABL_SN = event.item.VRIABL_SN;
							param.DOMN_VRIABL_SN = event.item.DOMN_VRIABL_SN;
							param.CDISC_UPPER_CODE = event.item.CDISC_UPPER_CODE;
							param.PAGE = "EDCK0204";
							mkLayerPopupOpen("/edc/k02/popupEDCK0204Sub01.do", param);
							AUIGrid.resize(EDCK0204Sub01_grid.id);
						}
					}
				}
			});
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
			GROUP_SE_CODE : "01"
		};
		AUIGrid.addRow(EDCK0204_grid.id, item, "last");
	}
	function saveGrid() {
		AUIGrid.forceEditingComplete(EDCK0204_grid.id, null, false);

		var msg1 = '<spring:message code="edc.required.msg" />';
		var msg2 = '<spring:message code="edc.byte.msg" />';
		var rowItems = AUIGrid.getGridData(EDCK0204_grid.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].GROUP_LBL || rowItems[i].GROUP_LBL.length <= 0) {
				alert("GROUP_LBL" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0204_grid.id, i);
				return false;
			}

			var text_byte = 200;
			var text = rowItems[i].GROUP_LBL;
			if (fn_getByte(text) > text_byte) {
				alert("GROUP_LBL" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0204_grid.id, i);
				return false;
			}

			text = rowItems[i].GROUP_DC;
			if (fn_getByte(text) > text_byte) {
				alert("GROUP_DC" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0204_grid.id, i);
				return false;
			}
		}

		if (confirm('<spring:message code="edc.save.msg" />')) {
			var arJson = [];
			for (var i = 0; i < rowItems.length; i++) {
				rowItems[i].GROUP_ORDR = (i + 1);

				if (AUIGrid.isAddedById(EDCK0204_grid.id, rowItems[i].GROUP_SN)) {
					rowItems[i].CRUD = "C";
				} else if (AUIGrid.isEditedById(EDCK0204_grid.id, rowItems[i].GROUP_SN)) {
					rowItems[i].CRUD = "U";
				} else if (AUIGrid.isRemovedById(EDCK0204_grid.id, rowItems[i].GROUP_SN)) {
					rowItems[i].CRUD = "D";
				} else {
					rowItems[i].CRUD = "U";
				}
				arJson.push(rowItems[i]);
			}

			if (arJson.length > 0) {
				AUIGrid.showAjaxLoader(EDCK0204_grid.id);
				$.ajax({
					url : './insertGroupList.do',
					data : JSON.stringify(arJson),
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0204_grid.load();
							alert('<spring:message code="edc.save.confirm.msg" />');
						} else {
							alert(data.message);
						}
						AUIGrid.removeAjaxLoader(EDCK0204_grid.id);
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
	function moveRowsToUp(grid) {
		AUIGrid.moveRowsToUp(grid.id);
	};

	// 선택 행들 아래로 한 단계 올림
	function moveRowsToDown(grid) {
		AUIGrid.moveRowsToDown(grid.id);
	};

	function moveVariable() {
		var selectedItems = AUIGrid.getSelectedItems(EDCK0204_grid.id);
		if (selectedItems.length <= 0) {
			alert('<spring:message code="edc.groupSelect.msg" />');
		} else {
			if (!AUIGrid.isAddedById(EDCK0204_grid.id, selectedItems[0].item[EDCK0204_grid.gridPros.rowIdField])) {
				var ret = "";
				var checkedItems = AUIGrid.getCheckedRowItems(EDCK0204_grid2.id);
				if (checkedItems.length == 0) {
					alert('<spring:message code="edc.notSelect.msg" />');
				} else {
					for (var i = 0; i < checkedItems.length; i++) {
						if (checkedItems[i].item.CDISC_UPPER_CODE == null) {
							var rowItems = AUIGrid.getItemsByValue(EDCK0204_grid3.id, "DOMN_VRIABL_SN", checkedItems[i].item.DOMN_VRIABL_SN);
							if (rowItems.length > 0) {
								ret += rowItems[0].VRIABL_NM + "\n";
							}
						}
					}
					if (ret != "") {
						ret += '<spring:message code="edc.sameVariable.msg" />';
						alert(ret);
					} else {
						for (var i = 0; i < checkedItems.length; i++) {
							checkedItems[i].item.GROUP_SN = selectedItems[0].item.GROUP_SN
							checkedItems[i].item.TASK_SN = selectedItems[0].item.TASK_SN
							checkedItems[i].item.EDC_VER = selectedItems[0].item.EDC_VER
							AUIGrid.addRow(EDCK0204_grid3.id, checkedItems[i].item, "last");
						}
						AUIGrid.setAllCheckedRows(EDCK0204_grid2.id, false);
					}
				}
			} else {
				alert('<spring:message code="edc.save.group.msg" />');
			}
		}
	}
	function searchVariable() {
		var grid_param = new Object();
		grid_param.CDISC_DOMN_SN = $("#CDISC_DOMN_SN").val();
		EDCK0204_grid2.proxy.param = grid_param;
		EDCK0204_grid2.load();
	}

	function saveGrid2() {
		AUIGrid.forceEditingComplete(EDCK0204_grid3.id, null, false);
		if (confirm('<spring:message code="edc.save.msg" />')) {
			var msg = "";
			var rowItems = AUIGrid.getGridData(EDCK0204_grid3.id);
			var b = true;
			for (var i = 0; i < rowItems.length; i++) {
				if (AUIGrid.isRemovedById(EDCK0204_grid3.id, rowItems[i].VRIABL_SN)) {
					rowItems.splice(i, 1);
				}
			}
			for (var i = 0; i < rowItems.length; i++) {
				var i_rowItem = rowItems[i];
				for (var j = i + 1; j < rowItems.length; j++) {
					var j_rowItem = rowItems[j];
					if (i_rowItem.DOMN_VRIABL_SN == j_rowItem.DOMN_VRIABL_SN && i_rowItem.CL_CODE_SN == j_rowItem.CL_CODE_SN) {
						msg += (i + 1) + " : " + i_rowItem.VRIABL_NM + "\n";
						msg += (j + 1) + " : " + j_rowItem.VRIABL_NM + "\n";
						b = false;
						break;
					}
				}
				if (!b) {
					break;
				}
			}
			if (msg != "") {
				msg += '<spring:message code="edc.sameItem.msg" />';
				alert(msg);
			} else {
				var v_rowItems = AUIGrid.getGridData(EDCK0204_grid3.id);
				var arJson = [];
				for (var i = 0; i < v_rowItems.length; i++) {
					v_rowItems[i].VRIABL_ORDR = (i + 1);

					if (AUIGrid.isAddedById(EDCK0204_grid3.id, v_rowItems[i].VRIABL_SN)) {
						v_rowItems[i].CRUD = "C";
					} else if (AUIGrid.isEditedById(EDCK0204_grid3.id, v_rowItems[i].VRIABL_SN)) {
						v_rowItems[i].CRUD = "U";
					} else if (AUIGrid.isRemovedById(EDCK0204_grid3.id, v_rowItems[i].VRIABL_SN)) {
						v_rowItems[i].CRUD = "D";
					} else {
						v_rowItems[i].CRUD = "U";
					}
					arJson.push(v_rowItems[i]);
				}

				if (arJson.length > 0) {
					AUIGrid.showAjaxLoader(EDCK0204_grid3.id);
					$.ajax({
						url : './insertGroupInsideList.do',
						data : JSON.stringify(arJson),
						type : 'post',
						contentType : "application/json; charset=UTF-8",
						success : function(data, textStatus, jqXHR) {
							if (data.success) {
								EDCK0204_grid3.load();
								alert('<spring:message code="edc.save.confirm.msg" />');
							} else {
								alert(data.message);
							}
							AUIGrid.removeAjaxLoader(EDCK0204_grid3.id);
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
	}

	function popupUserVariable(c) {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		var url
		if (!c) {
			c = "EDCK0206";
		}
		var url = "./popup" + c + ".do";
		mkLayerPopupOpen(url, param);
		if (c == "EDCK0205") {
			AUIGrid.resize(EDCK0205_grid.id);
			AUIGrid.resize(EDCK0205_grid2.id);
		} else if (c == "EDCK0206") {
			AUIGrid.resize(EDCK0206_grid.id);
			AUIGrid.resize(EDCK0206_grid2.id);
		}
	}

	function editMode(e) {
		if (!e) {
			mkDisabled(); //컨트롤 비활성화

			AUIGrid.setProperty(EDCK0204_grid.id, {
				"editable" : false
			});

			AUIGrid.setProperty(EDCK0204_grid3.id, {
				"editable" : false
			});

			$("button").hide();
			$("#btn_edit").show();
		} else {
			mkEnabled(); //컨트롤 활성화

			var selIdx = AUIGrid.getSelectedIndex(EDCK0204_grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(EDCK0204_grid.id, EDCK0204_grid.gridPros.selectionMode);
				AUIGrid.setProperty(EDCK0204_grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(EDCK0204_grid.id, selIdx[0], selIdx[1])
			} else {
				AUIGrid.setProperty(EDCK0204_grid.id, {
					"editable" : true
				});
			}
			AUIGrid.clearSelection(EDCK0204_grid3.id, EDCK0204_grid3.gridPros.selectionMode);
			AUIGrid.setProperty(EDCK0204_grid3.id, {
				"editable" : true
			});
			$("button").show();
			$("#btn_edit").hide();
		}
	}

	function deleteGroup(grid) {
		var rowItem = AUIGrid.getSelectedItems(grid.id)[0].item;
		if (rowItem.GROUP_SE_CODE == "06") {
			alert('<spring:message code="edc.noDelete.msg" />');
		} else {
			fn_deleteRow(grid);
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0204&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0204&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />

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
								<li id="tab_menu3" class="port_back tab_menu">Group</li>
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
								<li id="tab_menu9" class="tab_menu" onclick="fn_moveTab('EDCK0218');">Coding</li>
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
									<spring:message code="edc.lbl.GROUP" />
								</h6>
							</article>
							<article class="conTitBtnR">
								<button type="button" onclick="moveRowsToUp(EDCK0204_grid)" able>▲</button>
								<button type="button" onclick="moveRowsToDown(EDCK0204_grid)" able>▼</button>
								<button type="button" class="add_01" onclick="addRow()" title="<spring:message code="btn.rowAdd"/>" able>
									<spring:message code="btn.rowAdd" />
								</button>
								<button type="button" class="del_01" onclick="deleteGroup(EDCK0204_grid)" title="<spring:message code="btn.rowDelete" />" able>
									<spring:message code="btn.rowDelete" />
								</button>
								<button type="button" class="save_01" onclick="saveGrid()" title="<spring:message code="btn.save" />" able>
									<spring:message code="btn.save" />
								</button>
							</article>
							<article class="mgT16">
								<div id="EDCK0204_grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
							</article>
						</div>

						<div class="conSbtLn right_001">
							<div style="height: 29px;">
								<div class="conTitBtnL">
									<label><spring:message code="edc.lbl.DOMN_NM" /></label>
									<select id="CDISC_DOMN_SN" name="CDISC_DOMN_SN" able style="width: 100px;">
										<option value=""><spring:message code="edc.lbl.SELECT" /></option>
										<c:forEach items="${ DOMAIN }" var="list">
											<option value="${ list.CODE }">${ list.VALUE }</option>
										</c:forEach>
									</select>
									<button type="button" class="oneBtn" onclick="searchVariable()" able>
										<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="<spring:message code="btn.search.1" />">
									</button>
								</div>
								<article class="conTitBtnR">
									<button type="button" onclick="popupUserVariable()" title="<spring:message code="edc.btn.USER_VARIABLE"/>" able>
										<spring:message code="edc.btn.USER_VARIABLE" />
									</button>
								</article>
							</div>
							<article class="mgT11">
								<div id="EDCK0204_grid2" class="gridHeiSz05 grid_wrap tb01_2"></div>
								<div id="EDCK0204_grid_paging2" class="aui-grid-paging-panel my-grid-paging-panel"></div>
							</article>
						</div>

						<div class="bottom_arrow_btn_01">
							<button class="big_arrow_btn_01" type="button" onclick="moveVariable();" able>▼</button>
						</div>


						<div class="conSbtLn right_002">
							<article class="conTitBox">
								<h6>
									<spring:message code="edc.lbl.VARIABLE" />
								</h6>
							</article>
							<article class="conTitBtnR">
								<button type="button" onclick="moveRowsToUp(EDCK0204_grid3)" able>▲</button>
								<button type="button" onclick="moveRowsToDown(EDCK0204_grid3)" able>▼</button>
								<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0204_grid3)" title="<spring:message code="btn.rowDelete" />" able>
									<spring:message code="btn.rowDelete" />
								</button>
								<button type="button" class="save_01" onclick="saveGrid2()" title="<spring:message code="btn.save" />" able>
									<spring:message code="btn.save" />
								</button>
							</article>
							<article class="mgT16">
								<div id="EDCK0204_grid3" class="gridHeiSz05 grid_wrap tb01_2"></div>
							</article>
						</div>

					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>