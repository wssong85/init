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
.left_001{margin-top:15px; width:39.5%; float:left;}
.right_001{margin-top:15px; width:59.5%; float:right;}


.detail_wrap_01{ overflow-x:auto; margin:0px 0 0px 0; }

table.tb002 {width:100%; border-top: 1px solid #7287e4; margin-bottom:15px;}
.tb002 th { color:#333;border-right: 1px solid #e6e6e6;border-left: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6; font-family:'NanumGothicBold'; background:#f6f7ff; height:28px; font-size:12px; line-height:15px; padding:3px 4px 3px 12px; text-align:center; vertical-align:middle; Letter-spacing:0px; box-sizing: border-box; }
.tb002 td { font-family:'NanumGothic';border-right: 1px solid #e6e6e6;border-left: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6; color:#555; background:#FFFFFF; height:36px;  padding:4px 4px 4px 12px; vertical-align:middle; font-size:12px; Letter-spacing:0px; box-sizing: border-box;  }
.tb002 tr:last-child {border-bottom: 1px solid #e6e6e6; } 
.tb002 tr:last-child td {border-bottom: 0px;}

table.tb003, .tb003 th, .tb003 td{ border:none !important;}



#div_set{margin-top:10px;}
#div_set label{word-break:break-all;word-wrap:break-word; display:block; margin:5px 0 10px 0;}
</style>

<script>

function Con_Resize(){
	var con_boxd = $('.right_001').height();
	console.log(con_boxd);
	$('.left_001').css({"height": con_boxd + 42 + "px"});
	$('.grid_wrap').css({"height": con_boxd4 + "px"});
}



//화면 로드, 리사이즈, 스크롤
$(window).load(function() {
	Con_Resize();
});

$(window).resize(function() {
	Con_Resize();
});

$(window).scroll(function(){
	Con_Resize();
});

</script>


<script type="text/javascript">
	var medical_arr = [];
	medical_arr.push("07");
	medical_arr.push("08");
	medical_arr.push("09");

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
				<c:forEach items="${ EDC019 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0209_grid, "VRIABL_SE_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC041 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0209_grid, "DICARY_USE_AT", codeList);
				EDCK0209_grid.createGrid();
				AUIGrid.setGridData(EDCK0209_grid.id, []);

				EDCK0209_grid2.createGrid();
			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0209_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0209_grid.id);
		}
		
		if (typeof EDCK0209_grid2.id !== "undefined") {
			AUIGrid.resize(EDCK0209_grid2.id);
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
			headerText : "DOMN_NM",
			editable : false
		}, {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM",
			editable : false
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : "UPPER_CDISC_SUBMIT_VALUE",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE",
			editable : false
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_SE_CODE",
			headerText : "VRIABL_SE_CODE",
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
			dataField : "DICARY_VER",
			headerText : "DICARY_VER",
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : "", //key-value Object 로 구성된 리스트
				keyField : "code", // key 에 해당되는 필드명
				valueField : "value" // value 에 해당되는 필드명
			},
			labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
				return fn_checkCodeList(this, value);
			}
		}, {
			dataField : "DICARY_USE_AT",
			headerText : "DICARY_USE_AT",
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
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE",
			editable : false
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : "VRIABL_TY_CODE",
			editable : false
		}, {
			dataField : "VRIABL_ROLE",
			headerText : "VRIABL_ROLE",
			editable : false
		}, {
			dataField : "ESSNTL_AT",
			headerText : "ESSNTL_AT",
			editable : false
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO",
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
			AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
				var flag = true;
				var field = "DICARY_VER";
				if (event.dataField == field) {
					var VRIABL_SE_CODE = event.item.VRIABL_SE_CODE;
					if (medical_arr.indexOf(VRIABL_SE_CODE) != -1) {
						var param = new Object();
						param.QUERY = "selectEDCCodeList";
						param.FLAG = "DICTIONARY_VER";
						param.VRIABL_SE_CODE = VRIABL_SE_CODE;

						var codeList = fn_makeSelectList(param);

						if (codeList.length > 0) {
							fn_setCodeList(me, field, codeList)
						} else {
							flag = false;
							alert("용어사전 없음");
						}
					} else {
						flag = false;
						alert("용어사전 선택이 필요");
					}
				} else if (event.dataField == "DICARY_USE_AT") {
					var VRIABL_SE_CODE = event.item.VRIABL_SE_CODE;
					if (medical_arr.indexOf(VRIABL_SE_CODE) != -1) {
					} else {
						flag = false;
						alert("용어사전 선택이 필요");
					}
				}
				return flag;
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
			url : '/selectLayoutList',
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
			dataField : "SET_TY_CODE",
			headerText : "SET_TY_CODE"
		}, {
			dataField : "VRIABL_SE_CODE",
			headerText : "VRIABL_SE_CODE"
		}, {
			dataField : "DICARY_VER",
			headerText : "DICARY_VER"
		}, {
			dataField : "DICARY_USE_AT",
			headerText : "DICARY_USE_AT"
		}, {
			dataField : "DC_CN",
			headerText : "DC_CN"
		}, {
			dataField : "DC_FONT_CODE",
			headerText : "DC_FONT_CODE"
		}, {
			dataField : "DC_FONT_MG",
			headerText : "DC_FONT_MG"
		}, {
			dataField : "DC_LINK_CODE",
			headerText : "DC_LINK_CODE"
		}, {
			dataField : "DC_FONT_COLLR",
			headerText : "DC_FONT_COLLR"
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : "UPPER_CDISC_SUBMIT_VALUE"
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

	function makeLine() {
		var checkedItems = AUIGrid.getCheckedRowItems(EDCK0209_grid.id);
		if (checkedItems.length > 0) {
			if (checkedItems.length <= 2) {
				var cnt = $("#div_layout div[name=div_set]").length;
				var rowIdField = AUIGrid.getProperty(EDCK0209_grid2.id, "rowIdField");
				var str = "<div id='div_set' name='div_set'style='margin-top:15px;clear:both; overflow:hidden; '>";
				var set_sn = fn_createGuid();
				var set_row_sn = fn_createGuid();
				var set_ordr = (cnt + 1);
				var set_row_ordr = 1;
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + set_sn + "' />";
				str += "<input type='hidden' id='set_row_sn' name='set_row_sn' value='" + set_row_sn + "' />";
				str += "<table class='tb002' style='margin-bottom:5px;'><colgroup><col width='15%'><col width=''></colgroup><tbod><tr>";
				for (var i = 0; i < checkedItems.length; i++) {
					checkedItems[i].item.SET_TY_CODE = "01";
					checkedItems[i].item.SET_SN = set_sn;
					checkedItems[i].item.SET_ROW_SN = set_row_sn;
					checkedItems[i].item.SET_ORDR = set_ordr;
					checkedItems[i].item.SET_ROW_ORDR = set_row_ordr;
					checkedItems[i].item.SET_VRIABL_ORDR = (i + 1);

					AUIGrid.addRow(EDCK0209_grid2.id, checkedItems[i].item, "first");
					var row = AUIGrid.getItemByRowIndex(EDCK0209_grid2.id, 0);
					var set_vriabl_sn = row[rowIdField];
					if (i == 0) {
						var label = row.VRIABL_NM;
						str += "<th>" + label + "</th>";
						str += "<td>";
					}
					str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + set_vriabl_sn + "' />";
					if (i == 0) {
						str += "<input type='text' id='" + set_vriabl_sn + "' name='" + set_vriabl_sn + "' readonly='readonly' />";
					} else {
						str += "<label>" + checkedItems[i].item.UPPER_CDISC_SUBMIT_VALUE + "</label>";

					}
				}
				str += "</td>";
				str += "</tr></tbody></table>";
				str += "<article style='margin-bottom:10px;'><button type=\"button\" onclick=\"deleteSet(this);\">Delete</button></article></div>";
				console.log(str);
				$("#div_layout").append(str);
				AUIGrid.setAllCheckedRows(EDCK0209_grid.id, false);
			} else {
				alert("두개 이하 선택");
			}
		} else {
			alert("선택없음");
		}
	}
	function makeTable(c) {
		var checkedItems = AUIGrid.getCheckedRowItems(EDCK0209_grid.id);
		if (checkedItems.length > 0) {
			var cnt = $("#div_layout div[name=div_set]").length;
			var rowIdField = AUIGrid.getProperty(EDCK0209_grid2.id, "rowIdField");
			var set_row_sn = fn_createGuid();
			var set_sn = fn_createGuid();
			var set_ordr = (cnt + 1);
			var set_row_ordr = 1;
			var str = "<div id='div_set' name='div_set' style='margin-top:15px;clear:both; overflow:hidden; '>";
			var str2 = "";
			for (var i = 0; i < checkedItems.length; i++) {
				checkedItems[i].item.SET_TY_CODE = "02";
				checkedItems[i].item.SET_SN = set_sn;
				checkedItems[i].item.SET_ROW_SN = set_row_sn;
				checkedItems[i].item.SET_ORDR = set_ordr;
				checkedItems[i].item.SET_ROW_ORDR = set_row_ordr;
				checkedItems[i].item.SET_VRIABL_ORDR = (i + 1);

				AUIGrid.addRow(EDCK0209_grid2.id, checkedItems[i].item, "first");
				if (i == 0) {
					str += "<input type='hidden' id='set_sn' name='set_sn' value='" + set_sn + "' />";
					str += "<input type='hidden' id='set_row_sn' name='set_row_sn' value='" + set_row_sn + "' />";
					str += "<table class='tb002' style='margin-bottom:5px;'><colgroup><col width='25%'><col width='25%'><col width='25%'><col width=''></colgroup><tbod><tr>";
				}

				var row = AUIGrid.getItemByRowIndex(EDCK0209_grid2.id, 0);
				var set_vriabl_sn = row[rowIdField];
				var label = row.VRIABL_NM;
				str += "<th>" + label + "</th>";
				str2 += "<td>";
				str2 += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + set_vriabl_sn + "' />";
				str2 += "<input type='text' id='" + set_vriabl_sn + "' name='" + set_vriabl_sn + "' readonly='readonly' style='width:90%' />";
				str2 += "</td>";
			}
			str += "</tr><tr>";
			str += str2;
			str += "</tr></tbody></table>";
			str += "<article style='margin-bottom:10px;'><button type=\"button\" onclick=\"popupTable(this);\">설정</button> ";
			str += "<button type=\"button\" onclick=\"deleteSet(this);\">Delete</button></article></div>";
			console.log(str);
			$("#div_layout").append(str);
			AUIGrid.setAllCheckedRows(EDCK0209_grid.id, false);
		} else {
			alert("선택없음");
		}
	}
	function makeDescription() {
		if ($("#frm_main #GROUP_SN").val() != "") {
			var rowIdField = AUIGrid.getProperty(EDCK0209_grid2.id, "rowIdField");
			var set_row_sn = fn_createGuid();
			var set_sn = fn_createGuid();
			var item = {
				SET_TY_CODE : "04",
				SET_SN : set_sn,
				SET_ROW_SN : set_row_sn
			};
			AUIGrid.addRow(EDCK0209_grid2.id, item, "first");
			var row = AUIGrid.getItemByRowIndex(EDCK0209_grid2.id, 0);
			var set_vriabl_sn = row[rowIdField];
			var str = "<div id='div_set' name='div_set'>";
			str += "<input type='hidden' id='set_sn' name='set_sn' value='" + set_sn + "' />";
			str += "<input type='hidden' id='set_row_sn' name='set_row_sn' value='" + set_row_sn + "' />";
			str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + set_vriabl_sn + "' />";
			str += "<label>Description</label>";
			str += "<button type=\"button\" onclick=\"popupDescription(this);\">설정</button> ";
			str += "<button type=\"button\" onclick=\"deleteSet(this);\">Delete</button></div>";
			console.log(str);
			$("#div_layout").append(str);
		} else {
			alert("그룹 선택 필요");
		}
	}
	function deleteSet(obj) {
		$(obj).parent().find("input[id=set_vriabl_sn]").each(function(index, entry) {
			var item = AUIGrid.getItemByRowId(EDCK0209_grid2.id, $(this).val());
			AUIGrid.removeRowByRowId(EDCK0209_grid2.id, $(this).val());
		});
		$(obj).parent().remove();
	}
	function popupDescription(obj) {
		var param = AUIGrid.getGridData(EDCK0209_grid2.id)[0];
		if (AUIGrid.isAddedById(EDCK0209_grid2.id, param.SET_VRIABL_SN)) {
			param.CRUD = "C";
		} else {
			param.CRUD = "U";
		}
		mkLayerPopupOpen("/edc/k02/popupEDCK0210.do", param);
	}
	function popupTable(obj) {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		mkLayerPopupOpen("/edc/k02/popupEDCK0205.do", param);
		AUIGrid.resize(EDCK0205_grid.id);
	}
	function saveGrid() {
		var sortingInfo = [];
		sortingInfo.push({
			dataField : "SET_ORDR",
			sortType : 1
		});
		sortingInfo.push({
			dataField : "SET_ROW_ORDR",
			sortType : 1
		});
		sortingInfo.push({
			dataField : "SET_VRIABL_ORDR",
			sortType : 1
		});
		AUIGrid.setSorting(EDCK0209_grid2.id, sortingInfo);

		rowItems = AUIGrid.getAddedRowItems(EDCK0209_grid2.id);
		for (var i = 0; i < rowItems.length; i++) {
			rowItems[i].CRUD = "C";
			AUIGrid.updateRowsById(EDCK0209_grid2.id, rowItems[i]);
		}
		rowItems = AUIGrid.getEditedRowItems(EDCK0209_grid2.id);
		for (var i = 0; i < rowItems.length; i++) {
			rowItems[i].CRUD = "U";
			AUIGrid.updateRowsById(EDCK0209_grid2.id, rowItems[i]);
		}
		rowItems = AUIGrid.getRemovedItems(EDCK0209_grid2.id);
		for (var i = 0; i < rowItems.length; i++) {
			rowItems[i].CRUD = "D";
			AUIGrid.updateRowsById(EDCK0209_grid2.id, rowItems[i]);
		}

		var arJson = [];
		rowItems = AUIGrid.getGridData(EDCK0209_grid2.id);
		for (var i = 0; i < rowItems.length; i++) {
			arJson.push(rowItems[i]);
		}

		if (arJson.length > 0) {
			AUIGrid.showAjaxLoader(EDCK0209_grid.id);
			$.ajax({
				url : './insertLayoutList.do',
				data : JSON.stringify(arJson),
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						alert("성공");
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
			alert("변경 없음");
		}
	}
	function editMode(c) {
		if (c == 1) {
			mkDisabled(); //컨트롤 비활성화
			AUIGrid.setProperty(EDCK0209_grid.id, {
				"editable" : false
			});
			$("button").hide();
			$("#btn_edit").show();
		} else {
			mkEnabled(); //컨트롤 활성화
			AUIGrid.setProperty(EDCK0209_grid.id, {
				"editable" : true
			});
			$("button").show();
			$("#btn_edit").hide();
		}
	}
	function selectVisit() {
		if ($("#frm_main #VISIT_SN").val() != "") {
			var param = new Object();
			param.QUERY = "selectEDCCodeList";
			param.FLAG = "GROUP";
			param.TASK_SN = $("#frm_main #TASK_SN").val();
			param.EDC_VER = $("#frm_main #EDC_VER").val();
			param.VISIT_SN = $("#frm_main #VISIT_SN").val();
			param.location = "frm_main #GROUP_SN";
			param.defaultLabel = "선택";
			fn_makeSelectbox(param);
		}
		$("#div_layout").empty();
		AUIGrid.setGridData(EDCK0209_grid.id, []);
		AUIGrid.setGridData(EDCK0209_grid2.id, []);
	}
	function selectGroup() {
		if ($("#frm_main #GROUP_SN").val() != "") {
			var grid_param = new Object();
			grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
			grid_param.EDC_VER = $("#frm_main #EDC_VER").val();
			grid_param.VISIT_SN = $("#frm_main #VISIT_SN").val();
			grid_param.GROUP_SN = $("#frm_main #GROUP_SN").val();

			EDCK0209_grid.proxy.param = grid_param;
			EDCK0209_grid.load();

			var gridItems = AUIGrid.getGridData(EDCK0209_grid.id);
			if (gridItems.length > 0) {
				for (var i = 0; i < gridItems.length; i++) {
					if (gridItems[i].SET_NO != null) {
						AUIGrid.addRow(EDCK0209_grid2.id, gridItems[i], "last");
						AUIGrid.removeRow(EDCK0209_grid2.id, AUIGrid.rowIdToIndex(EDCK0209_grid2.id, gridItems[i].VRIABL_SN));
					}
				}
			}
		}
		$("#div_layout").empty();
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
					<h3>EDC Designer</h3>
					<nav id="pathNav">
						<ul>
							<li>
								<img src="/images/pantheon/common/pathNavIco.png" alt="">Home
							</li>
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
								<button type="button" id="btn_edit" onclick="editMode(2)" able>수정</button>
							</div>
						</section>


						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
							<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">

							<div class="conSbtLn left_001">
								<div style="overflow: hidden;">
									<div class="conTitBtnL" style="margin-bottom: 6px;">
										<label>Visit :</label>
										<select id="VISIT_SN" name="VISIT_SN" onchange="selectVisit();" style="width: 60px;">
											<option value="">선택</option>
											<c:forEach items="${ VISIT }" var="list">
												<option value="${ list.CODE }">${ list.VALUE }</option>
											</c:forEach>
										</select>
										&nbsp;&nbsp; <label>Group :</label>
										<select id="GROUP_SN" name="GROUP_SN" onchange="selectGroup();" style="width: 60px;">
											<option value="">선택</option>
										</select>
									</div>
									<article class="conTitBtnR">
										<button type="button" id="btn_line" able onclick="makeLine();" title="Line">L</button>
										<button type="button" id="btn_table" able onclick="makeTable(1);" title="Table">T1</button>
										<button type="button" id="btn_table2" able onclick="makeTable(2);" title="Table2">T2</button>
										<button type="button" id="btn_description" able onclick="makeDescription();" title="Description">D</button>
									</article>
								</div>

								<article class="mgT16">
									<div id="EDCK0209_grid" class="gridHeiSz14 grid_wrap tb01_2"></div>
								</article>

							</div>
						</form>


						<div class="conSbtLn right_001">
							<div style="height: 29px;">
								<article class="conTitBtnR">
									<button type="button" able onclick="saveLayout();">저장</button>
								</article>
							</div>
							<article class="mgT11">
								<div id="EDCK0209_grid2" class="gridHeiSz05 grid_wrap tb01_2"></div>
								<!-- 
							<div id="EDCK0209_grid_paging2" class="aui-grid-paging-panel my-grid-paging-panel"></div>
							 -->
							 
							 

								<div class="detail_wrap_01">

									
										<div id='div_set' name='div_set'>
											<table class="tb002" style="width:900px;">
												<tr>
													<th style="width:100px;">AEACN</th>
													<td style="width:300px;"><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td style="width:200px;"><label>NY</label></td>
													<td style="width:300px;">
														<button type="button" id="" title="Delete">Del</button>
													</td>
												</tr>
											</table>
										</div>
										
										
										<div id='div_set' name='div_set'>
											<table class="tb002" style="width:800px;">
												<tr>
													<th style="width:200px;">AEACN</th>
													<th style="width:200px;">AECONTRT</th>
													<th style="width:200px;">AELOC</th>
													<td style="width:200px;"></td>
												</tr>
												<tr>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td>
														<button type="button" onclick="">설정</button>
														<button type="button" onclick="">Delete</button>
													</td>
												</tr>
											</table>
										</div>




										
										<div id='div_set' name='div_set'>
											<table class="tb002" style="width:2000px;">
												<tr>
													<th style="width:200px;">AEACN</th>
													<th style="width:200px;">AECONTRT</th>
													<th style="width:200px;">AELOC</th>
													<th style="width:200px;">AELOC</th>
													<th style="width:200px;">AELOC</th>
													<th style="width:200px;">AELOC</th>
													<th style="width:200px;">AELOC</th>
													<th style="width:200px;">AELOC</th>
													<th style="width:200px;">AELOC</th>
													<th style="width:200px;"></th>
												</tr>
												<tr>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td>
														<button type="button" onclick="">설정</button>
														<button type="button" onclick="">Delete</button>
													</td>
												</tr>
											</table>
										</div>



										<div id='div_set' name='div_set'>
											<table class="tb002" style="width:400px;">
												<tr>
													<th style="width:200px;">AELOC</th>
													<td rowspan="2" style="width:200px;">
														<button type="button" onclick="">설정</button>
														<button type="button" onclick="">Delete</button>
													</td>
												</tr>
												<tr>
													<td><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
												</tr>
											</table>
										</div>





										<div id='div_set' name='div_set'>
											<table class='tb002' style="width:500px;">
												<tr>
													<th style="width:100px;">AELOC</th>
													<td style="width:200px;"><input type='text' id='' name='' readonly='readonly' style="width:100%;" /></td>
													<td style="width:200px;">
														<button type="button" onclick="deleteSet(this);">Delete</button>
													</td>
												</tr>
											</table>
										</div>





										<div id='div_set' name='div_set'>
											<table class='tb002 tb003' style="width:700px;">
												<tr>
													<td style="width:500px;"><span style="font-size:80px; line-height:90px;">Description</span></td>
													<td style="width:200px;">
														<button type="button" onclick="popupDescription(this);">설정</button>
														<button type="button" onclick="deleteSet(this);">Delete</button>
													</td>
												</tr>
											</table>
										</div>
										
										
										
										
										
										
										
										

								
								</div>

							 	<!-- 
								<div id="div_layout" class="grid_wrap tb01_2" style="min-height: 375px; height: auto;">
									<div id='div_set' name='div_set'>
										<input type='hidden' id='set_sn' name='set_sn' value='3faf6684-49dc-48b5-8ffa-905183bcbabd' />
										<input type='hidden' id='set_row_sn' name='set_row_sn' value='c332b2a9-c8ed-4267-88b4-db0082c07d7c' />
										<table class='tb002' style='margin-bottom:10px;'>
											<colgroup>
												<col width='15%'>
												<col width=''>
												<col width='15%'>
											</colgroup>
											<tbody>
												<tr>
													<th>AEACN</th>
													<td style="border-right:none;">
														<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='3AC4F295-C085-19EB-EA79-50075F3841B7' />
														<input type='text' id='3AC4F295-C085-19EB-EA79-50075F3841B7' name='3AC4F295-C085-19EB-EA79-50075F3841B7' readonly='readonly' />
														<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='2E4C43CA-661C-905E-A2CD-50075F557D7F' />
														<label style="display:inline;">NY</label>
													</td>
													<td style="border-left:none;">
														<button type="button" onclick="deleteSet(this);">Delete</button>
													</td>
												</tr>
											</tbody>
										</table>

									</div>

									<div id='div_set' name='div_set'>
										<input type='hidden' id='set_sn' name='set_sn' value='fffbce63-2b2b-41ee-967b-effb1b2d1aba' />
										<input type='hidden' id='set_row_sn' name='set_row_sn' value='7cdf6d25-3da4-44d6-8a8d-c8a5664e1a7e' />
										<table class='tb002' style='margin-bottom:5px;'>
											<colgroup>
												<col width='33%'>
												<col width='33%'>
												<col width=''>
											</colgroup>
											<tbody>
											<tr>
												<th>AEACN</th>
												<th>AECONTRT</th>
												<th>AELOC</th>
											</tr>
											<tr>
												<td>
													<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='92D21A36-60FD-CF1D-7B84-5007834EFEB1' />
													<input type='text' id='92D21A36-60FD-CF1D-7B84-5007834EFEB1' name='92D21A36-60FD-CF1D-7B84-5007834EFEB1' readonly='readonly' style="width:90%;" />
												</td>
												<td>
													<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='E03DDCE2-4EB5-DA8D-8B4B-5007835CB81C' />
													<input type='text' id='E03DDCE2-4EB5-DA8D-8B4B-5007835CB81C' name='E03DDCE2-4EB5-DA8D-8B4B-5007835CB81C' readonly='readonly' style="width:90%;" />
												</td>
												<td>
													<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='CB45104A-1173-4531-3D59-50078365E4EB' />
													<input type='text' id='CB45104A-1173-4531-3D59-50078365E4EB' name='CB45104A-1173-4531-3D59-50078365E4EB' readonly='readonly' style="width:90%;" />
												</td>
											</tr>
											</tbody>
										</table>
										<article style='margin-bottom:10px;'>
											<button type="button" onclick="popupTable(this);">설정</button>
											<button type="button" onclick="deleteSet(this);">Delete</button>
										</article>
									</div>

									<div id='div_set' name='div_set'>
										<input type='hidden' id='set_sn' name='set_sn' value='d77a267d-7161-4505-9417-bebfd56b4089' />
										<input type='hidden' id='set_row_sn' name='set_row_sn' value='81a667d5-7d08-437a-9c46-7deaa49fcae8' />
										<table class='tb002' style='margin-bottom:5px;'>
											<colgroup>
												<col width='15%'>
												<col width=''>
											</colgroup>
											<tbody>
												<tr>
													<th>AELOC</th>
													<td>
														<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='3ED937C8-7AC0-7701-10D4-5007944ABF4D' />
														<input type='text' id='3ED937C8-7AC0-7701-10D4-5007944ABF4D' name='3ED937C8-7AC0-7701-10D4-5007944ABF4D' readonly='readonly' />
													</td>
												</tr>
											</tbody>
										</table>
										<button type="button" onclick="deleteSet(this);">Delete</button>
									</div>

									<div id='div_set' name='div_set'>
										<input type='hidden' id='set_sn' name='set_sn' value='072e0419-bc44-4fb0-9ddc-f58d657fd57b' />
										<input type='hidden' id='set_row_sn' name='set_row_sn' value='12624ee5-c52d-413b-b281-f707ec5518a2' />
										<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='95367D78-A31B-EEAB-8488-500798FABF30' />
										<label>Description</label>
										<button type="button" onclick="popupDescription(this);">설정</button>
										<button type="button" onclick="deleteSet(this);">Delete</button>
									</div>
								</div>
								 -->
							</article>
						</div>

					</div>
				</section>

			</div>
		</section>
	</div>
</body>
</html>