<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<script src="<c:url value="/js/pantheon/edc/edc.js" />"></script>

<title>EDC Designer</title>
<style>
#tab li {
	padding: 0 20px !important;
}
</style>

<script type="text/javascript">
	var page_edit = false;
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
				<c:forEach items="${ VISIT }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0213_grid, "VISIT_SN", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC011 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0213_grid, "CND_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC012 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0213_grid, "CND_RELATE_CODE", codeList);

				var gridParam = new Object();
				gridParam.TASK_SN = $("#frm_main #TASK_SN").val();
				gridParam.EDC_VER = $("#frm_main #EDC_VER").val();
				gridParam.VISIT_GROUP_SN = $("#frm_main #VISIT_GROUP_SN").val();
				gridParam.SET_SN = $("#frm_main #SET_SN").val();
				gridParam.SET_ROW_SN = $("#frm_main #SET_ROW_SN").val();
				gridParam.SET_VRIABL_SN = $("#frm_main #SET_VRIABL_SN").val();
				gridParam.EDITCECK_SN = $("#frm_main #EDITCECK_SN").val();

				EDCK0213_grid.proxy.param = gridParam;
				EDCK0213_grid.createGrid();

				EDCK0213_grid2.proxy.param = gridParam;
				EDCK0213_grid2.createGrid();
				if ($("#CRUD").val() == 'C') {
					page_edit = true;
					editMode();
					$("#frm_main #tr_disable").hide();
				} else {
					page_edit = false;
					editMode();
				}
			}
			editTest();
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0213_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0213_grid.id);
		}
		if (typeof EDCK0213_grid2.id !== "undefined") {
			AUIGrid.resize(EDCK0213_grid2.id);
		}
	};

	var EDCK0213_grid2 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0213_grid2',
			paging : {
				pagingDiv : 'EDCK0213_grid2_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectAllVariableList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showTooltip : true,
			tooltipSensitivity : 0,
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : false,
			editable : false,
			enableFilter : false,
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
			editable : false
		}, {
			dataField : "GROUP_LBL",
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />',
			cellMerge : true,
			editable : false
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : '<spring:message code="edc.lbl.VISIT_LBL" />',
			editable : false
		}, {
			dataField : "VRIABL_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			editable : false
		}, {
			dataField : "SET_ROW_ORDR",
			headerText : "SEQ",
			editable : false,
			width : 100
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.CDISC_SUBMIT_VALUE" />',
			editable : false
		}, {
			dataField : "CODE_LIST",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			editable : false,
			tooltip : {
				show : true,
				tooltipFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
					var str = value;
					if (value) {
						str = "<ul style='list-style-type:disc; list-style-position: inside;'>";
						var arr = value.split(",");
						for (var i = 0; i < arr.length; i++) {
							str += "<li>" + arr[i] + "</li>";

						}
						str += "</ul>";
					}
					return str;
				}
			}
		}, {
			dataField : "NOMFRM_NM",
			headerText : '<spring:message code="edc.lbl.NOMFRM_NM" />',
			editable : false,
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				return "#" + value + "#";
			}
		}, {
			dataField : "VRIABL_SE_CODE",
			headerText : "VRIABL_SE_CODE",
			editable : false,
			visible : false
		}, {
			dataField : "CODING_AT",
			headerText : "CODING_AT",
			editable : false,
			visible : false
		}, {
			dataField : "UPPER_CDISC_CODE",
			headerText : "UPPER_CDISC_CODE",
			editable : false,
			visible : false
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

	var EDCK0213_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0213_grid',
			paging : {
				pagingDiv : 'EDCK0213_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectDisableList.do',
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
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			//fixedColumnCount : 7,
			selectionMode : "singleCell",
			enableCellMerge : true,
			rowIdField : "INPUT_LMTT_SN"
		},
		columnLayout : [ {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			visible : false,
			editable : false
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER",
			visible : false,
			editable : false
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN",
			visible : false,
			editable : false
		}, {
			dataField : "SET_VRIABL_SN",
			headerText : "SET_VRIABL_SN",
			visible : false,
			editable : false
		}, {
			dataField : "EDITCECK_SN",
			headerText : "EDITCECK_SN",
			visible : false,
			editable : false
		}, {
			dataField : "INPUT_LMTT_SN",
			headerText : "INPUT_LMTT_SN",
			visible : false,
			editable : false
		}, {
			dataField : "VISIT_SN",
			headerText : '<spring:message code="edc.lbl.VRIABL_LBL" />',
			headerText : "VISIT_SN",
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
			dataField : "LMTT_VISIT_GROUP_SN",
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />',
			headerText : "LMTT_VISIT_GROUP_SN",
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : "", //key-value Object 로 구성된 리스트
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
			dataField : "LMTT_SET_SN",
			headerText : "LMTT_SET_SN",
			visible : false
		}, {
			dataField : "LMTT_SET_ROW_SN",
			headerText : "LMTT_SET_ROW_SN",
			visible : false
		}, {
			dataField : "LMTT_SET_VRIABL_SN",
			headerText : "LMTT_SET_VRIABL_SN",
			visible : false
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN",
			headerText : '<spring:message code="edc.lbl.VISIT_LBL" />',
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : "", //key-value Object 로 구성된 리스트
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
			dataField : "SET_ROW_ORDR",
			headerText : "Seq",
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : "", //key-value Object 로 구성된 리스트
				keyField : "code", // key 에 해당되는 필드명
				valueField : "value" // value 에 해당되는 필드명
			},
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				return fn_checkCodeList(this, value);
			},
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
			AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
				var flag = true;
				if (event.dataField == "LMTT_VISIT_GROUP_SN") {
					var codeList = getVisitGroup(event.item.VISIT_SN);
					fn_setCodeList(me, "LMTT_VISIT_GROUP_SN", codeList);
				} else if (event.dataField == "DOMN_VRIABL_SN") {
					var codeList = getVariable(event.item.LMTT_VISIT_GROUP_SN);
					fn_setCodeList(me, "DOMN_VRIABL_SN", codeList);
				} else if (event.dataField == "SET_ROW_ORDR") {
					var codeList = getSeqCode(event.item.LMTT_VISIT_GROUP_SN, event.item.DOMN_VRIABL_SN);
					fn_setCodeList(me, "SET_ROW_ORDR", codeList);
				}
				return flag;
			});
			AUIGrid.bind(me.id, 'cellEditEnd', function(event) {
				if (event.dataField == "DOMN_VRIABL_SN") {
					if (event.value) {
						var codeList = getSeqCode(event.item.LMTT_VISIT_GROUP_SN, event.item.DOMN_VRIABL_SN);
						fn_setCodeList(me, "SET_ROW_ORDR", codeList);
						var set_row_ordr = null;
						if (codeList && codeList.length > 0) {
							set_row_ordr = codeList[0].code;
						}
						if (set_row_ordr) {
							var arr = set_row_ordr.split("@");
							var domn_vriabl_sn = arr[3]
							if (domn_vriabl_sn == "") {
								domn_vriabl_sn = null;
							}
							var code_item = {
								SET_ROW_ORDR : set_row_ordr,
								LMTT_SET_SN : arr[0],
								LMTT_SET_ROW_SN : arr[1],
								LMTT_SET_VRIABL_SN : arr[2],
								DOMN_VRIABL_SN : domn_vriabl_sn
							};
							AUIGrid.updateRow(me.id, code_item, event.rowIndex);
						}
					}
				} else if (event.dataField == "SET_ROW_ORDR") {
					if (event.value) {
						var value = event.value;
						var arr = value.split("@");
						var domn_vriabl_sn = arr[3]
						if (domn_vriabl_sn == "") {
							domn_vriabl_sn = null;
						}
						var item = {
							LMTT_SET_SN : arr[0],
							LMTT_SET_ROW_SN : arr[1],
							LMTT_SET_VRIABL_SN : arr[2],
							DOMN_VRIABL_SN : domn_vriabl_sn
						};
						AUIGrid.updateRow(me.id, item, event.rowIndex);
					}
				} else if (event.dataField == "VISIT_SN" || event.dataField == "LMTT_VISIT_GROUP_SN") {
					if (event.value) {
						var item = {};
						if (event.dataField == "VISIT_SN") {
							item.LMTT_VISIT_GROUP_SN = null;
						}
						item.LMTT_SET_SN = null;
						item.LMTT_SET_ROW_SN = null;
						item.LMTT_SET_VRIABL_SN = null;
						item.DOMN_VRIABL_SN = null;
						item.SET_ROW_ORDR = null;
						AUIGrid.updateRow(me.id, item, event.rowIndex);
					}
				}
			});
			AUIGrid.bind(me.id, 'ready', function(event) {
				var rowItems = AUIGrid.getGridData(me.id);
				for (var i = 0; i < rowItems.length; i++) {
					var lmtt_visit_group_sn = rowItems[i].LMTT_VISIT_GROUP_SN;
					var domn_vriabl_sn = rowItems[i].DOMN_VRIABL_SN;
					var set_row_ordr = rowItems[i].SET_ROW_ORDR;
					if (lmtt_visit_group_sn) {
						var codeList = getVisitGroup(rowItems[i].VISIT_SN);
						fn_setCodeList(me, "LMTT_VISIT_GROUP_SN", codeList);
						if (domn_vriabl_sn) {
							var codeList = getVariable(lmtt_visit_group_sn);
							fn_setCodeList(me, "DOMN_VRIABL_SN", codeList);
							if (set_row_ordr) {
								var codeList = getSeqCode(lmtt_visit_group_sn, domn_vriabl_sn);
								if (codeList.length > 0) {
									fn_setCodeList(me, "SET_ROW_ORDR", codeList);
								}
							}
						}
					}
					AUIGrid.updateRowsById(me.id, rowItems[i]);
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function getVisitGroup(visit_sn) {
		var param = new Object();
		param.URL = "/com/common/selectQueryDataList.do";
		param.QUERY = "selectEDCCodeList";
		param.FLAG = "VISIT_GROUP";
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.EDC_VER = $("#frm_main #EDC_VER").val();
		param.VISIT_SN = visit_sn;

		return fn_makeSelectList(param);
	}
	function getVariable(lmtt_visit_group_sn) {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.EDC_VER = $("#frm_main #EDC_VER").val();
		param.VISIT_GROUP_SN = lmtt_visit_group_sn;
		var codeList = new Array();
		$.ajax({
			url : "./selectEditVariableList.do",
			data : param,
			async : false,
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					$(data.result).each(function(index, entry) {
						var obj = new Object();
						obj.code = entry.DOMN_VRIABL_SN;
						obj.value = entry.CRF_LBL_ONE + "( " + entry.VRIABL_NM + " )"
						codeList.push(obj);
					});
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
		return codeList;
	}
	function getSeqCode(lmtt_visit_group_sn, domn_vriabl_sn) {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.EDC_VER = $("#frm_main #EDC_VER").val();
		param.VISIT_GROUP_SN = lmtt_visit_group_sn;
		param.DOMN_VRIABL_SN = domn_vriabl_sn;
		var codeList = new Array();
		$.ajax({
			url : "./selectEditSeqList.do",
			data : param,
			async : false,
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					$(data.result).each(function(index, entry) {
						var obj = new Object();
						obj.code = entry.CODE;
						var value = null;
						if (entry.SET_ROW_ORDR) {
							value = entry.SET_ROW_ORDR;
							if (entry.CDISC_SUBMIT_VALUE != null) {
								value += "( " + entry.CDISC_SUBMIT_VALUE + " )";
							}
						}
						obj.value = value;
						codeList.push(obj);
					});
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
		return codeList;
	}
	function addRow(grid) {
		var cnd_relate_code = null;
		if (AUIGrid.getRowCount(grid.id) != 0) {
			cnd_relate_code = "01";
		}
		var item = {
			TASK_SN : $("#frm_main #TASK_SN").val(),
			EDC_VER : $("#frm_main #EDC_VER").val(),
			VISIT_GROUP_SN : $("#frm_main #VISIT_GROUP_SN").val(),
			SET_SN : $("#frm_main #SET_SN").val(),
			SET_ROW_SN : $("#frm_main #SET_ROW_SN").val(),
			SET_VRIABL_SN : $("#frm_main #SET_VRIABL_SN").val(),
			EDITCECK_SN : $("#frm_main #EDITCECK_SN").val(),
			CND_RELATE_CODE : cnd_relate_code,
			CND_CODE : "01"
		};

		AUIGrid.addRow(grid.id, item, "first");
	}
	function saveEditCheck() {
		AUIGrid.forceEditingComplete(EDCK0213_grid.id, null, false);
		AUIGrid.forceEditingComplete(EDCK0213_grid.id, null, false);
		var msg = null;
		if ($("#frm_main #CRUD").val() == "D") {
			msg = '<spring:message code="edc.delete.msg" />';
		} else {
			var b = true;
			var rowItems = AUIGrid.getGridData(EDCK0213_grid.id);
			for (var i = 0; i < rowItems.length; i++) {
				for (var j = i + 1; j < rowItems.length; j++) {
					if (rowItems[i].LMTT_SET_VRIABL_SN == rowItems[j].LMTT_SET_VRIABL_SN) {
						msg = (i + 1) + " / " + (j + 1) + '<spring:message code="edc.sameItem.msg" />';
						b = false;
						break;
					}
				}
				if (!b) {
					break;
				}
			}

			if (!b) {
				alert(msg);
				return false;
			} else {
				msg = '<spring:message code="edc.save.msg" />';
			}
		}
		if (confirm(msg)) {
			var param = new Object();
			param.BASE = JSON.stringify(fn_serializeObject($("#frm_main")));

			var arJson = new Array();
			var rowItems = AUIGrid.getAddedRowItems(EDCK0213_grid.id);
			fn_makeArr(arJson, rowItems, "C");
			rowItems = AUIGrid.getEditedRowItems(EDCK0213_grid.id);
			fn_makeArr(arJson, rowItems, "U");
			rowItems = AUIGrid.getRemovedItems(EDCK0213_grid.id);
			fn_makeArr(arJson, rowItems, "D");
			if (arJson.length > 0) {
				param.DISABLE_LIST = JSON.stringify(arJson);
			}

			$.ajax({
				url : './insertEditCheck.do',
				data : param,
				type : 'post',
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						if ($("#frm_main #CRUD").val() == "C") {
							$("#frm_main #CRUD").val("U");
							$("#frm_main #EDITCECK_SN").val(data.EDITCECK_SN);
						}
						$("#frm_main").attr({
							action : './EDCK0213.do',
							method : 'post'
						}).submit();
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

	function editMode() {
		if (!page_edit) {
			mkDisabled(); //컨트롤 비활성화

			AUIGrid.setProperty(EDCK0213_grid.id, {
				"editable" : false
			});

			$("button").hide();
			$("#btn_edit").show();
			$("#btn_new").show();
		} else {
			mkEnabled(); //컨트롤 활성화

			var selIdx = AUIGrid.getSelectedIndex(EDCK0213_grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(EDCK0213_grid.id, EDCK0213_grid.gridPros.selectionMode);
				AUIGrid.setProperty(EDCK0213_grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(EDCK0213_grid.id, selIdx[0], selIdx[1])
			} else {
				AUIGrid.setProperty(EDCK0213_grid.id, {
					"editable" : true
				});
			}

			$("button").show();
			$("#btn_edit").hide();
		}
		$("#btn_new").show();
		$("#btn_list").show();
		$("#btn_test").show();
	}
	function changeQueryType(obj) {
		var val = $(obj).val();
		if (val == "01") {
			$("#frm_main #tr_disable").show();
			AUIGrid.resize(EDCK0213_grid.id);
		} else {
			$("#frm_main #tr_disable").hide();
			AUIGrid.setGridData(EDCK0213_grid.id, []);
		}
	}
	function newDetail() {
		$("#frm_main #CRUD").val("C");
		$("#frm_main").attr({
			action : './EDCK0213.do',
			method : 'post'
		}).submit();
	}

	function editTest() {
		var cnd_nomfrm = $("#frm_main #CND_NOMFRM").val();
		var index = 0;
		var nextIndex = 0;
		var temp_arr = [];
		var cnt = 1;
		for (;; cnt++) {
			nextIndex = cnd_nomfrm.indexOf("#", index);
			if (cnt > 1) {
				temp_arr.push(cnd_nomfrm.substring(index, nextIndex).toUpperCase());
				cnt = 0;
			}

			if (nextIndex == -1) {
				break;
			}
			index = nextIndex + 1;
		}

		var arr = [];
		$.each(temp_arr, function(i, el) {
			if ($.inArray(el, arr) === -1)
				arr.push(el);
		});

		var str = "<table class=\"tb001\" >";
		str += "<tr>";
		str += "<th>" + '<spring:message code="edc.lbl.VISIT_LBL" />' + "</th>";
		str += "<th>" + '<spring:message code="edc.lbl.GROUP_LBL" />' + "</th>";
		str += "<th>" + '<spring:message code="edc.lbl.VRIABL_LBL" />' + "</th>";
		str += "<th>" + 'Seq' + "</th>";
		str += "<th>" + '<spring:message code="edc.lbl.INPUT" />' + "</th>";
		str += "<th>" + '<spring:message code="edc.lbl.NOMFRM_NM" />' + "</th>";
		str += "</tr>";
		if (arr.length > 0) {
			for (var i = 0; i < arr.length; i++) {
				var rowItems = AUIGrid.getItemsByValue(EDCK0213_grid2.id, "NOMFRM_NM", arr[i]);
				if (rowItems.length > 0) {
					str += "<tr>";
					str += "<td>";
					str += rowItems[0].VISIT_LBL;
					str += "</td>";
					str += "<td>";
					str += rowItems[0].GROUP_LBL;
					str += "</td>";
					str += "<td>";
					str += rowItems[0].CRF_LBL_ONE;
					str += "</td>";
					str += "<td>";
					if (rowItems[0].SET_ROW_ORDR) {
						str += rowItems[0].SET_ROW_ORDR;
					}
					str += "</td>";
					str += "<td>";
					str += fn_makeInputType(rowItems[0], rowItems[0].SEQ, rowItems[0].RN, null);
					str += "</td>";
					str += "<td>";
					str += "#" + rowItems[0].NOMFRM_NM + "#";
					str += "</td>";
					str += "</tr>";
				}
			}
		} else {
			str += "<tr><td colspan=\"6\" style=\"text-align : center;\">";
			str += "<img src=\"/images/pantheon/common/AUIGrid/info2.png\" />";
			str += "No Data to display";
			str += "</td></tr>";
		}
		str += "</table>";
		$("#div_test").html(str);
	}
	function valueTest() {
		if (!page_edit) {
			var f = eval
			var cnd_nomfrm = $("#frm_main #CND_NOMFRM").val();
			$("#div_test").find("[save]").each(function(i, el) {
				var d = AUIGrid.getItemByRowId(EDCK0213_grid2.id, $(this).attr("name")).NOMFRM_NM;
				f("var " + d + "='" + $(this).val() + "'");
			});

			cnd_nomfrm = cnd_nomfrm.replace(/#/gi, "");
			if (f(cnd_nomfrm)) {
				alert('<spring:message code="edc.editCheck.msg" />');
			} else {
				var query_mssage = $("#frm_main #QUERY_MSSAGE").val();
				alert(query_mssage);
			}
		} else {
			alert('<spring:message code="edc.editCheck.save.msg" />');
		}
	}

	function average(array) {
		var sum = 0.0;

		for (var i = 0; i < array.length; i++)
			sum += array[i];

		return sum / array.length;
	}
</script>
</head>
<body>

	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0213&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0213&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />

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
								<li id="tab_menu7" class="port_back tab_menu">Edit Check</li>
								<li id="tab_menu8" class="tab_menu" onclick="fn_moveTab('EDCK0214');">T-Domain</li>
							</ul>
						</div>


						<section class="con_title_01">
							<articla class="conTitBox">
							<h5 id="tabTitle">${ detail.TASK_NO }-${ detail.EDC_VER }</h5>
							</articla>

							<div class="conTitBtnR">
								<button type="button" id="btn_edit" onclick="page_edit = true; editMode();">
									<spring:message code="btn.update" />
								</button>
								<button type="button" id="btn_new" onclick="newDetail();">
									<spring:message code="btn.new" />
								</button>
								<button type="button" onclick="saveEditCheck();" able>
									<spring:message code="btn.save" />
								</button>
								<button type="button" id="btn_list" onclick="fn_moveTab('EDCK0212');">
									<spring:message code="edc.btn.GOTO_LIST" />
								</button>
							</div>
						</section>

						<article class="mgT16">
							<form id="frm_main" name="frm_main">
								<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ detail.TASK_SN }">
								<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ detail.TASK_NO }">
								<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ detail.EDC_VER }">
								<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="${ detail.VISIT_GROUP_SN }">
								<input type="hidden" id="SET_SN" name="SET_SN" value="${ detail.SET_SN }">
								<input type="hidden" id="SET_ROW_SN" name="SET_ROW_SN" value="${ detail.SET_ROW_SN }">
								<input type="hidden" id="SET_VRIABL_SN" name="SET_VRIABL_SN" value="${ detail.SET_VRIABL_SN }">
								<input type="hidden" id="EDITCECK_SN" name="EDITCECK_SN" value="${ detail.EDITCECK_SN }">
								<input type="hidden" id="CRUD" name="CRUD" value="${ detail.CRUD }">
								<table class="tb001">
									<colgroup>
										<col width="10%" />
										<col width="40%" />
										<col width="5%" />
										<col width="5%" />
										<col width="15%" />
										<col width="25%" />
									</colgroup>
									<tbody>
										<tr>
											<th><spring:message code="edc.lbl.VRIABL_LBL" /></th>
											<td>${detail.VISIT_LBL }&nbsp;-&nbsp;${detail.GROUP_LBL }&nbsp;-&nbsp;${detail.CRF_LBL_ONE }&nbsp;(&nbsp;${detail.VRIABL_NM }&nbsp;)</td>
											<th>Seq</th>
											<td>${ detail.SET_ROW_ORDR }</td>
											<th><spring:message code="edc.lbl.CDISC_SUBMIT_VALUE" /></th>
											<td>${detail.CDISC_SUBMIT_VALUE }</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.QUERY_MSSAGE" /><span class='must_01'></span></th>
											<td colspan="3">
												<input type="text" id="QUERY_MSSAGE" name="QUERY_MSSAGE" value="${detail.QUERY_MSSAGE }" style="width: 100%;" able>
											</td>
											<th><spring:message code="edc.lbl.QUERY_SE_CODE" /><span class='must_01'></span></th>
											<td>
												<select id="QUERY_SE_CODE" name="QUERY_SE_CODE" onchange="changeQueryType(this);" able>
													<c:forEach items="${ EDC013 }" var="list">
														<option value="${ list.CODE }" <c:if test="${ list.CODE == detail.QUERY_SE_CODE}">selected="selected"</c:if>>${ list.VALUE }</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.EXCEPTION" /></th>
											<td colspan="5"></td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.CND_NOMFRM" /></th>
											<td colspan="5" style="padding-bottom: 20px;">
												<div id="EDCK0213_grid2" class="gridHeiSz05 grid_wrap tb01_2"></div>
												<textarea rows="4" id="CND_NOMFRM" name="CND_NOMFRM" style="width: 100%;" able>${ detail.CND_NOMFRM }</textarea>
											</td>
										</tr>
										<tr id="tr_disable" <c:if test="${detail.QUERY_SE_CODE != '01' }">style="display: none;"</c:if>>
											<th><spring:message code="edc.lbl.DISABLE" /></th>
											<td colspan="5" style="padding-bottom: 20px;">
												<article style="padding: 10px; text-align: right;">
													<button type="button" onclick="addRow(EDCK0213_grid)" title="<spring:message code="btn.rowAdd"/>" able>
														<spring:message code="btn.rowAdd" />
													</button>
													<button type="button" onclick="fn_deleteRow(EDCK0213_grid)" able>
														<spring:message code="btn.rowDelete" />
													</button>
												</article>

												<div id="EDCK0213_grid" class="gridHeiSz05 grid_wrap tb01_2"></div>

											</td>
										</tr>
									</tbody>
								</table>


							</form>
						</article>

						<article class="mgT16">
							<section class="con_title_01">
								<articla class="conTitBox">
								<h5>Test</h5>
								</articla>

								<div class="conTitBtnR">
									<button type="button" id="btn_test" onclick="valueTest()">Test</button>
								</div>
							</section>
						</article>
						<article class="mgT16" id="div_test"></article>
					</div>
				</section>

			</div>
		</section>
	</div>
</body>
</html>



