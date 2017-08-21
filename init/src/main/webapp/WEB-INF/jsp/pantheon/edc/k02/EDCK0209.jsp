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

.con_title_01 {
	display: block;
	height: 28px;
}

.left_001 {
	margin-top: 15px;
	width: 39.5%;
	float: left;
}

.right_001 {
	margin-top: 15px;
	width: 59.5%;
	float: right;
}

.detail_wrap_01 {
	overflow-x: auto;
	margin: 0px 0 0px 0;
}

.ui-state-highlight {
	height: 50px;
	line-height: 50px;
	margin-bottom: 20px;
}

table.tb004 {
	width: 100%;
	border-top: 1px solid #7287e4;
	margin-bottom: 5px;
}

table.tb004 th {
	color: #333;
	border-right: 1px solid #e6e6e6;
	border-left: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	font-family: 'NanumGothicBold';
	background: #f6f7ff;
	height: 28px;
	font-size: 12px;
	line-height: 15px;
	padding: 3px 4px 3px 4px;
	text-align: center;
	vertical-align: middle;
	Letter-spacing: 0px;
	box-sizing: border-box;
}

table.tb004 td {
	font-family: 'NanumGothic';
	border-right: 1px solid #e6e6e6;
	border-left: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	color: #555;
	background: #FFFFFF;
	height: 36px;
	padding: 4px 4px 4px 4px;
	vertical-align: middle;
	font-size: 12px;
	Letter-spacing: 0px;
	box-sizing: border-box;
}

table.tb004 tr:last-child {
	border-bottom: 1px solid #e6e6e6;
}

table.tb004 tr:last-child td {
	border-bottom: 0px;
}

table.tb004_no_border, table.tb004_no_border tr, table.tb004_no_border th, table.tb004_no_border td {
	border: none !important;
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
				<c:forEach items="${ EDC019 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0209_grid, "VRIABL_SE_CODE", codeList);

				EDCK0209_grid.createGrid();
				AUIGrid.setGridData(EDCK0209_grid.id, []);

				EDCK0209_grid2.createGrid();

				$("#div_layout").sortable({
					placeholder : "ui-state-highlight",
					update : function(event, ui) {
						$("#div_layout div[name=div_set]").each(function(index, entry) {
							$(this).find("[name=set_vriabl_sn]").each(function(index2, entry2) {
								var item = {
									SET_VRIABL_SN : $(this).val(),
									SET_ORDR : (index + 1)
								};
								AUIGrid.updateRowsById(EDCK0209_grid2.id, item);
							});
						});
					}
				});
				editMode(false);
			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0209_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0209_grid.id);
		}
	};

	var EDCK0209_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0209_grid',
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
			url : './selectGroupListForLayout.do',
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
			editable : true,
			enableFilter : false,
			softRemoveRowMode : false,
			headerHeight : 40,
			rowHeight : 37,
			showEditedCellMarker : false,
			editableOnFixedCell : true,
			//fixedColumnCount : 8,
			selectionMode : "singleRow",
			rowIdField : "VRIABL_SN"
		},
		columnLayout : [ {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN",
			visible : false
		}, {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN",
			visible : false
		}, {
			dataField : "VRIABL_SN",
			headerText : "VRIABL_SN",
			visible : false
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN",
			visible : false
		}, {
			dataField : "VRIABL_ORDR",
			headerText : "VRIABL_ORDR",
			visible : false
		}, {
			dataField : "DOMN_NM",
			headerText : '<spring:message code="edc.lbl.DOMN_NM" />',
			editable : false
		}, {
			dataField : "VRIABL_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			editable : false
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.UPPER_CDISC_SUBMIT_VALUE" />',
			editable : false
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.CDISC_SUBMIT_VALUE" />',
			editable : false
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_SE_CODE",
			headerText : '<spring:message code="edc.lbl.VRIABL_SE_CODE" />',
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : null, //key-value Object 로 구성된 리스트
				keyField : "code", // key 에 해당되는 필드명
				valueField : "value" // value 에 해당되는 필드명
			},
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				if (value == null || value == "") {
					value = "01";
				}
				return fn_checkCodeList(this, value);
			}
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE",
			editable : false
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO",
			editable : false
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
			dataField : "CODING_AT",
			headerText : "CODING_AT",
			editable : false,
			visible : false
		}, {
			dataField : "CNT",
			headerText : "CNT",
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
			AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
				if (AUIGrid.getProperty(me.id, "editable")) {
					if (event.dataField == "VRIABL_SE_CODE") {
						if (event.item.CODING_AT != null) {
							alert('<spring:message code="edc.coding.msg" />');
							return false;
						}
					}
				}
				return true;
			});

		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	var EDCK0209_grid2 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0209_grid2',
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
			url : './selectLayoutList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : false,
			enableFilter : false,
			softRemoveRowMode : false,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "SET_VRIABL_SN"
		},
		columnLayout : [ {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM"
		}, {
			dataField : "SET_ORDR",
			headerText : "SET_ORDR"
		}, {
			dataField : "SET_ROW_ORDR",
			headerText : "SET_ROW_ORDR"
		}, {
			dataField : "SET_VRIABL_ORDR",
			headerText : "SET_VRIABL_ORDR"
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN"
		}, {
			dataField : "SET_SN",
			headerText : "SET_SN"
		}, {
			dataField : "SET_ROW_SN",
			headerText : "SET_ROW_SN"
		}, {
			dataField : "SET_VRIABL_SN",
			headerText : "SET_VRIABL_SN"
		}, {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN"
		}, {
			dataField : "VRIABL_SN",
			headerText : "VRIABL_SN"
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN"
		}, {
			dataField : "SET_TY_CODE",
			headerText : "SET_TY_CODE"
		}, {
			dataField : "VRIABL_SE_CODE",
			headerText : "VRIABL_SE_CODE"
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE"
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO"
		}, {
			dataField : "DC_CN",
			headerText : "DC_CN"
		}, {
			dataField : "DC_FONT_CODE",
			headerText : "DC_FONT_CODE"
		}, {
			dataField : "DC_FONT_CODE_VALUE",
			headerText : "DC_FONT_CODE_VALUE"
		}, {
			dataField : "DC_FONT_MG",
			headerText : "DC_FONT_MG"
		}, {
			dataField : "DC_FONT_MG_VALUE",
			headerText : "DC_FONT_MG_VALUE"
		}, {
			dataField : "DC_LINK_CODE",
			headerText : "DC_LINK_CODE"
		}, {
			dataField : "DC_FONT_COLLR",
			headerText : "DC_FONT_COLLR"
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN"
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE"
		}, {
			dataField : "TASK_SN",
			headerText : "TASK_SN"
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER"
		}, {
			dataField : "CRUD",
			headerText : "CRUD"
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

	function makeLayout(sArr) {
		var cnt = 1;
		$(sArr).each(function(index, entry) {
			if (entry.SET_TY_CODE == "01") {
				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				var vriabl_se_code = null;
				$(entry.row).each(function(index2, entry2) {
					var item = entry2.vriabl;
					var item_count = item.length;
					var td_width = 500;
					if (item_count > 1) {
						td_width = 300;
					}
					vriabl_se_code = item[0].VRIABL_SE_CODE;
					var label = item[0].CRF_LBL_ONE;
					str += "<table class='tb004'><tbody>";
					str += "<tr name='" + entry2.SET_ROW_SN + "' id='set_row_sn'>";
					str += "<th style='width: 20%;'>" + label + "</th>";
					str += "<td onclick=\"popupChangeVariable(this);\">";
					str += fn_makeInputType(item[0], index2, item[0].SET_VRIABL_SN);
					str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + item[0].SET_VRIABL_SN + "' />";
					if (item_count > 1) {
						str += "</td><td>";
						str += fn_makeInputType(item[1], index2, item[1].SET_VRIABL_SN);
						str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + item[1].SET_VRIABL_SN + "' />";
					}
				});
				str += "</td>";
				str += "<td style='width: 180px;'>";
				if (vriabl_se_code != "12") {
					str += "<button type=\"button\" class=\"del_01\" onclick=\"deleteSet('" + entry.SET_SN + "');\" title=\"";
					str += '<spring:message code="btn.rowDelete" />';
					str += "\" able>"
					str += '<spring:message code="btn.rowDelete" />';
					str += "</button>";
				}
				str += "</td></tr></tbody></table></div>";
				$("#div_layout").append(str);
			} else if (entry.SET_TY_CODE == "02" || entry.SET_TY_CODE == "04") {
				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				str += "<table class='tb004'>";
				$(entry.row).each(function(index2, entry2) {
					if (index2 == 0) {
						str += "<thead><tr>";
						$(entry2.vriabl).each(function(index3, entry3) {
							var label = entry3.CRF_LBL_ONE;
							str += "<th>" + label + "</th>";
						});
						str += "<td style='width: 180px;'>";
						if (entry.SET_TY_CODE == "02") {
						} else {
							str += "<button type=\"button\" class=\"add_01\" onclick=\"addTr('" + entry.SET_SN + "');\" title=\"";
							str += '<spring:message code="btn.rowAdd"/>';
							str += "\" able>";
							str += '<spring:message code="btn.rowAdd"/>';
							str += "</button>";
						}
						str += " <button type=\"button\" onclick=\"popupTable('" + entry.SET_SN + "');\" able>설정</button></td></tr></thead><tbody>";
					}
					str += "<tr name='" + entry2.SET_ROW_SN + "' id='set_row_sn'>";
					$(entry2.vriabl).each(function(index3, entry3) {
						str += "<td onclick=\"popupChangeVariable(this);\">";
						str += fn_makeInputType(entry3, (index2 + 1), entry3.SET_VRIABL_SN);
						str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + entry3.SET_VRIABL_SN + "' />";
						str += "</td>";
					});
					str += "<td><button type=\"button\" class=\"del_01\" onclick=\"deleteRow('" + entry.SET_SN + "', '" + entry2.SET_ROW_SN + "');\" title=\"";
					str += '<spring:message code="btn.rowDelete" />';
					str += "\" able>"
					str += '<spring:message code="btn.rowDelete" />';
					str += "</button>";
					str += "</td></tr>";
				});
				str += "</tbody></table></div>";
				$("#div_layout").append(str);
			} else if (entry.SET_TY_CODE == "03") {
				var item = entry.row[0].vriabl[0];
				var dc = "";
				var style = null;
				if (item.DC_CN != null && item.DC_CN != "") {
					dc = item.DC_CN;
					style = "style='font-family : " + item.DC_FONT_CODE_VALUE + "; color : " + item.DC_FONT_COLLR + "; ";
					style += "font-size : " + item.DC_FONT_MG_VALUE + "px; line-height : " + (Number(item.DC_FONT_MG_VALUE) + 10) + "px;'";
				}

				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				str += "<table class='tb004 tb004_no_border'>";
				str += "<tr name='" + entry.row[0].SET_ROW_SN + "' id='set_row_sn'>";
				str += "<td>";
				if (style != null) {
					str += "<span " + style + ">";
				} else {
					str += "<span>";
				}
				str += dc;
				str += "</span>";
				str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + item.SET_VRIABL_SN + "' />";
				str += "</td><td style='width: 180px;'>";
				str += "<button type=\"button\" onclick=\"popupDescription('" + entry.SET_SN + "');\" able>설정</button> ";
				str += "<button type=\"button\" class=\"del_01\" onclick=\"deleteSet('" + entry.SET_SN + "');\" title=\"";
				str += '<spring:message code="btn.rowDelete" />';
				str += "\" able>"
				str += '<spring:message code="btn.rowDelete" />';
				str += "</button>";
				str += "</td></tr></table></div>";
				$("#div_layout").append(str);
			}
			cnt++;
		});
		editMode(page_edit);
	}
	function addTr(set_sn) {
		var set_row_ordr = 1;
		var set_vriabl_ordr = 1;
		var tr_index = 0;
		$("#div_set" + set_sn).find("table tbody tr").each(function(index, entry) {
			$(this).find("input[name=set_vriabl_sn]").each(function(index2, entry2) {
				var item = {
					SET_VRIABL_SN : $(this).val(),
					SET_ROW_ORDR : set_row_ordr,
					SET_VRIABL_ORDR : set_vriabl_ordr
				};
				AUIGrid.updateRowsById(EDCK0209_grid2.id, item);
				set_vriabl_ordr++;
			});
			set_row_ordr++;
			tr_index++;
		});
		var set_row_sn = fn_createGuid();
		var str = "<tr name='" + set_row_sn + "' id='set_row_sn'>";
		$("#div_set" + set_sn).find("table tbody tr:last").find("input[name=set_vriabl_sn]").each(function(index2, entry2) {
			var item = AUIGrid.getItemByRowId(EDCK0209_grid2.id, $(this).val());
			item.SET_ROW_ORDR = set_row_ordr;
			item.SET_ROW_SN = set_row_sn;
			AUIGrid.addRow(EDCK0209_grid2.id, item, "first");
			var row = AUIGrid.getItemByRowIndex(EDCK0209_grid2.id, 0);

			str += "<td onclick=\"popupChangeVariable(this);\">";
			str += fn_makeInputType(row, (tr_index + 1), row.SET_VRIABL_SN);
			str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + row.SET_VRIABL_SN + "' />";
			str += "</td>";
		});
		str += "<td><button type=\"button\" class=\"del_01\" onclick=\"deleteRow('" + set_sn + "', '" + set_row_sn + "');\" title=\"";
		str += '<spring:message code="btn.rowDelete" />';
		str += "\" able>"
		str += '<spring:message code="btn.rowDelete" />';
		str += "</button>";
		str += "</td></tr>";

		$("#div_set" + set_sn).find("table tbody").append(str);
		//$("#div_set" + set_sn).find("table tbody tr:last").find("input[type=text],textarea").val("");
		editMode(page_edit);
	}
	function makeLine() {
		var checkedItems = AUIGrid.getCheckedRowItems(EDCK0209_grid.id);
		var item_count = checkedItems.length;
		if (item_count > 0) {
			var b = true;
			var msg = "";
			for (var i = 0; i < item_count; i++) {
				var i_domn_vriabl_sn = checkedItems[i].item.DOMN_VRIABL_SN
				for (var j = i + 1; j < item_count; j++) {
					if (i_domn_vriabl_sn == checkedItems[j].item.DOMN_VRIABL_SN) {
						msg += (i + 1) + " : " + checkedItems[i].item.VRIABL_NM + "\n";
						msg += (j + 1) + " : " + checkedItems[j].item.VRIABL_NM + "\n";
						b = false;
						break;
					}
				}
				if (!b) {
					break;
				}
			}
			if (!b) {
				alert(msg + '<spring:message code="edc.sameItem.msg" />');
			} else {
				if (item_count <= 2) {
					b = true;
					if (item_count == 2) {
						var unit_count = 0;
						for (var i = 0; i < item_count; i++) {
							if (checkedItems[i].item.VRIABL_SE_CODE == "11") {//unit 타입
								unit_count++;
							}
						}
						if (unit_count == 0 || unit_count == 2) {
							b = false;
						}
					}
					if (!b) {
						alert('<spring:message code="edc.lineUnit.msg" />');
					} else {
						var cnt = $("#div_layout div[name=div_set]").length;
						var set_sn = fn_createGuid();
						var set_row_sn = fn_createGuid();
						var set_ordr = (cnt + 1);
						var set_row_ordr = 1;
						var str = "<div id='div_set" + set_sn + "' name='div_set'>";
						str += "<input type='hidden' id='set_sn' name='set_sn' value='" + set_sn + "' />";
						str += "<table class='tb004'><tbody>";
						str += "<tr name='" + set_row_sn + "' id='set_row_sn'>";
						var str2 = "";
						for (var i = 0; i < item_count; i++) {
							checkedItems[i].item.SET_TY_CODE = "01";
							checkedItems[i].item.SET_SN = set_sn;
							checkedItems[i].item.SET_ROW_SN = set_row_sn;
							checkedItems[i].item.SET_ORDR = set_ordr;
							checkedItems[i].item.SET_ROW_ORDR = set_row_ordr;
							checkedItems[i].item.SET_VRIABL_ORDR = (i + 1);

							var vriabl_se_code = checkedItems[i].item.VRIABL_SE_CODE;
							if (vriabl_se_code == null) {
								checkedItems[i].item.VRIABL_SE_CODE = "01";
							}

							AUIGrid.addRow(EDCK0209_grid2.id, checkedItems[i].item, "first");
							var row = AUIGrid.getItemByRowIndex(EDCK0209_grid2.id, 0);
							if (checkedItems[i].item.VRIABL_SE_CODE == "11") {
								str2 += "<td onclick=\"popupChangeVariable(this);\">";
								str2 += fn_makeInputType(checkedItems[i].item, 0, row.SET_VRIABL_SN);
								str2 += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + row.SET_VRIABL_SN + "' />";
								str2 += "</td>";
							} else {
								var label = row.CRF_LBL_ONE;
								str += "<th style='width: 20%;'>" + label + "</th>";
								str += "<td>";
								str += fn_makeInputType(checkedItems[i].item, 0, row.SET_VRIABL_SN);
								str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + row.SET_VRIABL_SN + "' />";
								str += "</td>";
							}
						}
						str += str2;
						str += "<td style='width: 180px;'>";
						str += "<button type=\"button\" class=\"del_01\" onclick=\"deleteSet('" + set_sn + "');\" title=\"";
						str += '<spring:message code="btn.rowDelete" />';
						str += "\" able>"
						str += '<spring:message code="btn.rowDelete" />';
						str += "</button>";
						str += "</td></tr></tbody></table></div>";
						$("#div_layout").append(str);
						AUIGrid.setAllCheckedRows(EDCK0209_grid.id, false);
					}
				} else {
					alert('<spring:message code="edc.lineTwo.msg" />');
				}
			}
		} else {
			alert('<spring:message code="edc.notSelect.msg" />');
		}
	}
	function makeTable(c) {
		var checkedItems = AUIGrid.getCheckedRowItems(EDCK0209_grid.id);
		var item_count = checkedItems.length;
		if (item_count > 0) {
			var b = true;
			var msg = "";
			for (var i = 0; i < item_count; i++) {
				var i_domn_vriabl_sn = checkedItems[i].item.DOMN_VRIABL_SN
				for (var j = i + 1; j < item_count; j++) {
					if (i_domn_vriabl_sn == checkedItems[j].item.DOMN_VRIABL_SN) {
						msg += (i + 1) + " : " + checkedItems[i].item.VRIABL_NM + "\n";
						msg += (j + 1) + " : " + checkedItems[j].item.VRIABL_NM + "\n";
						b = false;
						break;
					}
				}
				if (!b) {
					break;
				}
			}
			if (!b) {
				alert(msg + '<spring:message code="edc.sameItem.msg" />');
			} else {
				var cnt = $("#div_layout div[name=div_set]").length;
				var set_sn = fn_createGuid();
				var set_row_sn = fn_createGuid();
				var set_ordr = (cnt + 1);
				var set_row_ordr = 1;

				var str = "<div id='div_set" + set_sn + "' name='div_set'>";
				var str2 = "";

				var width = 200;
				for (var i = 0; i < item_count; i++) {
					if (c == 1) {
						checkedItems[i].item.SET_TY_CODE = "02";
					} else {
						checkedItems[i].item.SET_TY_CODE = "04";
					}
					checkedItems[i].item.SET_SN = set_sn;
					checkedItems[i].item.SET_ROW_SN = set_row_sn;
					checkedItems[i].item.SET_ORDR = set_ordr;
					checkedItems[i].item.SET_ROW_ORDR = set_row_ordr;
					checkedItems[i].item.SET_VRIABL_ORDR = (i + 1);

					var vriabl_se_code = checkedItems[i].item.VRIABL_SE_CODE;
					if (!vriabl_se_code) {
						checkedItems[i].item.VRIABL_SE_CODE = "01";
					}

					AUIGrid.addRow(EDCK0209_grid2.id, checkedItems[i].item, "first");
					if (i == 0) {
						str += "<input type='hidden' id='set_sn' name='set_sn' value='" + set_sn + "' />";
						str += "<table class='tb004'><thead>";
						str += "<tr name='" + set_row_sn + "' id='set_row_sn'>";
					}

					var row = AUIGrid.getItemByRowIndex(EDCK0209_grid2.id, 0);
					var label = row.CRF_LBL_ONE;
					str += "<th>" + label + "</th>";
					str2 += "<td>";
					str2 += fn_makeInputType(checkedItems[i].item, 1, row.SET_VRIABL_SN);
					str2 += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + row.SET_VRIABL_SN + "' />";
					str2 += "</td>";
				}
				str += "<td style='width: 180px;'>";
				if (c == 1) {
				} else {
					str += "<button type=\"button\" class=\"add_01\" onclick=\"addTr('" + set_sn + "');\" title=\"";
					str += '<spring:message code="btn.rowAdd"/>';
					str += "\" able>";
					str += '<spring:message code="btn.rowAdd"/>';
					str += "</button>";
				}
				str += " <button type=\"button\" onclick=\"popupTable('" + set_sn + "');\" able>설정</button></td>";
				str += "</tr></thead><tbody><tr>";
				str += str2;
				str += "<td><button type=\"button\" class=\"del_01\" onclick=\"deleteSet('" + set_sn + "');\" title=\"";
				str += '<spring:message code="btn.rowDelete" />';
				str += "\" able>"
				str += '<spring:message code="btn.rowDelete" />';
				str += "</button>";
				str += "</td></tr></tbody></table></div>";
				$("#div_layout").append(str);
				AUIGrid.setAllCheckedRows(EDCK0209_grid.id, false);
			}
		} else {
			alert('<spring:message code="edc.notSelect.msg" />');
		}
	}
	function makeDescription() {
		if ($("#frm_main #GROUP_SN").val() != "") {
			var set_sn = fn_createGuid();
			var set_row_sn = fn_createGuid();
			var item = {
				SET_TY_CODE : "03",
				SET_SN : set_sn,
				SET_ROW_SN : set_row_sn,
				TASK_SN : $("#frm_main #TASK_SN").val(),
				EDC_VER : $("#frm_main #EDC_VER").val(),
				VISIT_GROUP_SN : $("#frm_main #VISIT_GROUP_SN").val()
			};
			AUIGrid.addRow(EDCK0209_grid2.id, item, "first");
			var row = AUIGrid.getItemByRowIndex(EDCK0209_grid2.id, 0);
			var str = "<div id='div_set" + set_sn + "' name='div_set'>";
			str += "<input type='hidden' id='set_sn' name='set_sn' value='" + set_sn + "' />";
			str += "<table class='tb004 tb004_no_border' >";
			str += "<tr name='" + set_row_sn + "' id='set_row_sn'>";
			str += "<td>";
			str += "<span>Description</span>";
			str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + row.SET_VRIABL_SN + "' />";
			str += "<td style='width: 180px;'>";
			str += "<button type=\"button\" onclick=\"popupDescription('" + set_sn + "');\" able>설정</button> ";
			str += "<button type=\"button\" class=\"del_01\" onclick=\"deleteSet('" + set_sn + "');\" title=\"";
			str += '<spring:message code="btn.rowDelete" />';
			str += "\" able>"
			str += '<spring:message code="btn.rowDelete" />';
			str += "</button>";
			str += "</td></tr></table></div>";
			$("#div_layout").append(str);
		} else {
			alert('<spring:message code="edc.groupSelect.msg" />');
		}
	}
	function deleteSet(set_sn) {
		$("#div_set" + set_sn).find("input[id=set_vriabl_sn]").each(function(index, entry) {
			AUIGrid.removeRowByRowId(EDCK0209_grid2.id, $(this).val());
		});
		$("#div_set" + set_sn).remove();

		fn_layoutSorting(EDCK0209_grid2, true);
	}
	function deleteRow(set_sn, set_row_sn) {
		var t = $("#div_set" + set_sn + " tr[name=" + set_row_sn + "]");
		t.find("input[id=set_vriabl_sn]").each(function(index, entry) {
			AUIGrid.removeRowByRowId(EDCK0209_grid2.id, $(this).val());
		});
		if ($("#div_set" + set_sn + " tbody tr").length == 1) {
			$("#div_set" + set_sn).remove();

			fn_layoutSorting(EDCK0209_grid2, true);
		} else {
			t.remove();

			var set_row_ordr = 1;
			$("#div_set" + set_sn).find("table tbody tr").each(function(index, entry) {
				var tr = $(this);
				tr.find("input[name=set_vriabl_sn]").each(function(index2, entry2) {
					var item = {
						SET_VRIABL_SN : $(this).val(),
						SET_ROW_ORDR : set_row_ordr,
					};
					AUIGrid.updateRowsById(EDCK0209_grid2.id, item);
					var item = AUIGrid.getItemByRowId(EDCK0209_grid2.id, $(this).val());
					if (item.VRIABL_SE_CODE == "07") {
						tr.find("input[id=var_value" + $(this).val() + "]").val(set_row_ordr);
					}
				});
				set_row_ordr++;
			});
		}
	}
	function popupDescription(set_sn) {
		var set_vriabl_sn = $("#div_set" + set_sn + " #set_vriabl_sn").val();
		var item = AUIGrid.getItemByRowId(EDCK0209_grid2.id, set_vriabl_sn);

		if (AUIGrid.isAddedById(EDCK0209_grid2.id, set_vriabl_sn)) {
			item.CRUD = "C";
		} else {
			item.CRUD = "U";
		}
		mkLayerPopupOpen("/edc/k02/popupEDCK0210.do", item);
	}
	function popupTable(set_sn) {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.EDC_VER = $("#frm_main #EDC_VER").val();
		param.VISIT_GROUP_SN = $("#frm_main #VISIT_GROUP_SN").val();
		param.SET_SN = set_sn;
		mkLayerPopupOpen("/edc/k02/popupEDCK0211.do", param);
	}
	function saveGrid() {
		var arJson = [];
		var rowItems = AUIGrid.getAddedRowItems(EDCK0209_grid2.id);
		fn_makeArr(arJson, rowItems, "C");
		rowItems = AUIGrid.getEditedRowItems(EDCK0209_grid2.id);
		fn_makeArr(arJson, rowItems, "U");
		rowItems = AUIGrid.getRemovedItems(EDCK0209_grid2.id);
		fn_makeArr(arJson, rowItems, "D");

		if (arJson.length > 0) {
			AUIGrid.showAjaxLoader(EDCK0209_grid.id);
			$.ajax({
				url : './insertLayoutList.do',
				data : JSON.stringify(arJson),
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						EDCK0209_grid2.load();
						$("#div_layout").empty();
						makeLayoutObject(EDCK0209_grid2);
						alert('<spring:message code="edc.save.confirm.msg" />');
					} else {
						alert(data.message);
					}
					AUIGrid.removeAjaxLoader(EDCK0209_grid.id);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		} else {
			alert('<spring:message code="edc.save.noChange" />');
		}
	}
	function selectVisit() {
		if ($("#frm_main #VISIT_SN").val() != "") {
			var param = new Object();
			param.URL = "<c:url value='/com/common/selectQueryDataList.do'/>";
			param.QUERY = "selectEDCCodeList";
			param.FLAG = "VISIT_GROUP";
			param.TASK_SN = $("#frm_main #TASK_SN").val();
			param.EDC_VER = $("#frm_main #EDC_VER").val();
			param.VISIT_SN = $("#frm_main #VISIT_SN").val();
			param.location = "frm_main #VISIT_GROUP_SN";
			param.defaultLabel = '<spring:message code="edc.lbl.SELECT" />';
			fn_makeSelectbox(param);
		}
		$("#div_layout").empty();
		AUIGrid.setGridData(EDCK0209_grid.id, []);
		AUIGrid.setGridData(EDCK0209_grid2.id, []);
	}
	function selectGroup() {
		if ($("#frm_main #VISIT_GROUP_SN").val() != "") {
			var grid_param = new Object();
			grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
			grid_param.EDC_VER = $("#frm_main #EDC_VER").val();
			grid_param.VISIT_GROUP_SN = $("#frm_main #VISIT_GROUP_SN").val();

			EDCK0209_grid.proxy.param = grid_param;
			EDCK0209_grid.load();
			AUIGrid.setAllCheckedRows(EDCK0209_grid.id, false);
			AUIGrid.setFixedColumnCount(EDCK0209_grid.id, 8);

			EDCK0209_grid2.proxy.param = grid_param;
			EDCK0209_grid2.load();
			$("#div_layout").empty();
			makeLayoutObject(EDCK0209_grid2);
		} else {
			$("#div_layout").empty();
		}
	}

	function popupChangeVariable(obj) {
		console.log(1);
		if (page_edit) {
			console.log(2);
			var set_vriabl_sn = $(obj).find("#set_vriabl_sn").val();
			var item = AUIGrid.getItemByRowId(EDCK0209_grid2.id, set_vriabl_sn);
			mkLayerPopupOpen("/edc/k02/popupEDCK0209Sub02.do", item);
			AUIGrid.resize(EDCK0209Sub02_grid.id);
		}
	}

	function tapChangeVariable(c) {
		console.log(1);
		var param = $("#frm_popup").serialize();
		if (c == "EDCK0209Sub02") {
			mkLayerPopupOpen("/edc/k02/popupEDCK0209Sub02.do", param);
			AUIGrid.resize(EDCK0209Sub02_grid.id);
		} else {
			mkLayerPopupOpen("/edc/k02/popupEDCK0209Sub01.do", param);
			AUIGrid.resize(EDCK0209Sub01_grid.id);
		}
	}

	function editMode(e) {
		page_edit = e;
		if (!e) {
			mkDisabled(); //컨트롤 비활성화

			AUIGrid.setProperty(EDCK0209_grid.id, {
				"editable" : false
			});

			$("button").hide();
			$("#btn_edit").show();

			$("#div_layout").sortable("disable");
		} else {
			mkEnabled(); //컨트롤 활성화

			var selIdx = AUIGrid.getSelectedIndex(EDCK0209_grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(EDCK0209_grid.id, EDCK0209_grid.gridPros.selectionMode);
				AUIGrid.setProperty(EDCK0209_grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(EDCK0209_grid.id, selIdx[0], selIdx[1]);
			} else {
				AUIGrid.setProperty(EDCK0209_grid.id, {
					"editable" : true
				});
			}
			$("button").show();
			$("#btn_edit").hide();

			$("#div_layout").sortable("enable");
		}
	}

	function makeLayoutObject(grid) {
		var rowItems = AUIGrid.getGridData(grid.id);
		if (rowItems.length > 0) {
			var setSn = null;
			var setRowSn = null;
			var set_ty_code = null;
			var rArr = [];
			var vArr = [];
			var sArr = [];
			for (var i = 0; i <= rowItems.length; i++) {
				if (setSn == null) {
					vArr.push(fn_setVriabl(rowItems[i]));

					setSn = rowItems[i].SET_SN;
					set_ty_code = rowItems[i].SET_TY_CODE;
					setRowSn = rowItems[i].SET_ROW_SN;
				} else if (i == rowItems.length) {
					var row = {};
					row.SET_ROW_SN = setRowSn;
					row.vriabl = vArr;
					rArr.push(row);
					var set = {};
					set.SET_SN = setSn;
					set.SET_TY_CODE = set_ty_code;
					set.row = rArr;
					sArr.push(set);
				} else if (setSn != rowItems[i].SET_SN) {
					var row = {};
					row.SET_ROW_SN = setRowSn;
					row.vriabl = vArr;
					rArr.push(row);
					var set = {};
					set.SET_SN = setSn;
					set.SET_TY_CODE = set_ty_code;
					set.row = rArr;
					sArr.push(set);
					rArr = [];
					vArr = [];

					vArr.push(fn_setVriabl(rowItems[i]));

					setSn = rowItems[i].SET_SN;
					set_ty_code = rowItems[i].SET_TY_CODE;
					setRowSn = rowItems[i].SET_ROW_SN;
				} else if (setSn == rowItems[i].SET_SN && setRowSn == rowItems[i].SET_ROW_SN) {
					vArr.push(fn_setVriabl(rowItems[i]));
				} else if (setSn == rowItems[i].SET_SN && setRowSn != rowItems[i].SET_ROW_SN) {
					var row = {};
					row.SET_ROW_SN = setRowSn;
					row.vriabl = vArr;
					rArr.push(row);
					vArr = [];

					vArr.push(fn_setVriabl(rowItems[i]));

					setRowSn = rowItems[i].SET_ROW_SN;
				}

			}
			makeLayout(sArr);
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0209&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0209&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />

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
								<li id="tab_menu6" class="port_back tab_menu">Layout</li>
								<li id="tab_menu7" class="tab_menu" onclick="fn_moveTab('EDCK0212');">Edit Check</li>
								<li id="tab_menu8" class="tab_menu" onclick="fn_moveTab('EDCK0214');">T-Domain</li>
							</ul>
						</div>


						<section class="con_title_01">
							<articla class="conTitBox">
							<h5 id="tabTitle">${ TASK_NO }-${ EDC_VER }</h5>
							</articla>
							<div class="conTitBtnR">
								<button type="button" class="edit_01" id="btn_edit" onclick="editMode(true)" title="<spring:message code="btn.update" />">
									<spring:message code="btn.update" />
								</button>
							</div>
						</section>


						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
							<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">

							<div class="conSbtLn left_001">
								<div style="overflow: hidden;">
									<div class="conTitBtnL" style="margin-bottom: 6px;">
										<label><spring:message code="edc.lbl.VISIT" /></label>
										<select id="VISIT_SN" name="VISIT_SN" onchange="selectVisit();" style="width: 60px;">
											<option value=""><spring:message code="edc.lbl.SELECT" /></option>
											<c:forEach items="${ VISIT }" var="list">
												<option value="${ list.CODE }">${ list.VALUE }</option>
											</c:forEach>
										</select>
										&nbsp;&nbsp; <label><spring:message code="edc.lbl.GROUP" /></label>
										<select id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" onchange="selectGroup();" style="width: 60px;">
											<option value=""><spring:message code="edc.lbl.SELECT" /></option>
										</select>
									</div>
									<article class="conTitBtnR">
										<button type="button" id="btn_line" able onclick="makeLine();">Line</button>
										<button type="button" id="btn_table" able onclick="makeTable(1);">Table</button>
										<button type="button" id="btn_table" able onclick="makeTable(2);">Fixed Table</button>
										<button type="button" id="btn_description" able onclick="makeDescription();">Description</button>
									</article>
								</div>

								<article class="mgT16">
									<div id="EDCK0209_grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
								</article>

							</div>
						</form>


						<div class="conSbtLn right_001" style="min-height: 690px;">
							<div style="height: 29px;">
								<article class="conTitBtnR">
									<button type="button" class="save_01" onclick="saveGrid();" title="<spring:message code="btn.save" />" able>
										<spring:message code="btn.save" />
									</button>
								</article>
							</div>
							<article class="mgT11">
								<div id="EDCK0209_grid2" class="gridHeiSz05 grid_wrap tb01_2" style="display: none;"></div>
								<div class="detail_wrap_01" id="div_layout"></div>
							</article>
						</div>

					</div>
				</section>

			</div>
		</section>
	</div>
</body>
</html>