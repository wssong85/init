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
.bottom_arrow_btn_01{  width:49.5%; float:right; height:67px; text-align:center; padding-top:18px; box-sizing: border-box;}

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
				<c:forEach items="${ EDC016 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				EDCK0204_grid.columnLayout[4].editRenderer.list = codeList;

				var grid_param = new Object();
				grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
				grid_param.EDC_VER = $("#frm_main #EDC_VER").val();

				EDCK0204_grid.proxy.param = grid_param;
				EDCK0204_grid.createGrid();

				EDCK0204_grid2.proxy.param = grid_param;
				EDCK0204_grid2.createGrid();

				EDCK0204_grid3.createGrid();
				if (AUIGrid.getRowCount(EDCK0204_grid.id) > 0) {
					editMode(1);
				} else {
					editMode(2);
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
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : true,
			enableFilter : false,
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
			headerText : "GROUP_LBL" + "<span class='must_01'></span>",
		}, {
			dataField : "GROUP_SE_CODE",
			headerText : "GROUP_SE_CODE" + "<span class='must_01'></span>",
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
			headerText : "GROUP_DC"
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
				return fn_checkGridNull(event);
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
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : false,
			editable : false,
			enableFilter : false,
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
			editable : false
		}, {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM",
			editable : false
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE",
			editable : false
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : "UPPER_CDISC_SUBMIT_VALUE",
			editable : false
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_ROLE",
			headerText : "VRIABL_ROLE",
			editable : false
		}, {
			dataField : "CTRL_FOM",
			headerText : "CTRL_FOM",
			editable : false
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : "VRIABL_TY_CODE",
			editable : false
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO",
			editable : false
		}, {
			dataField : "VRIABL_LBL",
			headerText : "VRIABL_LBL",
			editable : false
		}, {
			dataField : "CORE_CODE",
			headerText : "CORE_CODE",
			editable : false
		}, {
			dataField : "VRIABL_DC",
			headerText : "VRIABL_DC",
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
			editable : true,
			enableFilter : false,
			headerHeight : 40,
			rowHeight : 37,
			fixedColumnCount : 7,
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
			headerText : "DOMN_NM",
			editable : false
		}, {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM",
			editable : false
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE",
			editable : false
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : "UPPER_CDISC_SUBMIT_VALUE",
			editable : false
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE",
			style : "edc_column_style",
			editable : false
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_ROLE",
			headerText : "VRIABL_ROLE",
			editable : false
		}, {
			dataField : "CTRL_FOM",
			headerText : "CTRL_FOM",
			editable : false
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : "VRIABL_TY_CODE",
			editable : false
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO",
			editable : false
		}, {
			dataField : "VRIABL_LBL",
			headerText : "VRIABL_LBL",
			editable : false
		}, {
			dataField : "CORE_CODE",
			headerText : "CORE_CODE",
			editable : false
		}, {
			dataField : "VRIABL_DC",
			headerText : "VRIABL_DC",
			editable : false
		}, {
			dataField : "CRUD",
			headerText : "Delete",
			visible : false,
			editable : false,
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
			AUIGrid.bind(me.id, 'cellClick', function(event) {
				fn_deleteGridRow(me, event);
				if (AUIGrid.getProperty(me.id, "editable")) {
					if (event.dataField == "CDISC_SUBMIT_VALUE") {
						var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
						var param = new Object();
						param.TASK_SN = $("#frm_main #TASK_SN").val();
						param.VRIABL_SN = rowItem.VRIABL_SN;
						param.DOMN_VRIABL_SN = rowItem.DOMN_VRIABL_SN;
						param.CDISC_UPPER_CODE = rowItem.CDISC_UPPER_CODE;
						mkLayerPopupOpen("/edc/k02/popupEDCK0204Sub01.do", param);
						AUIGrid.resize(EDCK0204Sub01_grid.id);
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
		AUIGrid.addRow(EDCK0204_grid.id, item, "first");
	}
	function saveGrid() {
		var rowItems = AUIGrid.getGridData(EDCK0204_grid.id);
		for (var i = 0; i < rowItems.length; i++) {
			var item = {
				GROUP_ORDR : (i + 1)
			};
			AUIGrid.updateRow(EDCK0204_grid.id, item, i, true);
		}

		var arJson = [];
		rowItems = AUIGrid.getAddedRowItems(EDCK0204_grid.id);
		fn_makeArr(arJson, rowItems, "C");
		rowItems = AUIGrid.getEditedRowItems(EDCK0204_grid.id);
		fn_makeArr(arJson, rowItems, "U");
		rowItems = AUIGrid.getRemovedItems(EDCK0204_grid.id);
		fn_makeArr(arJson, rowItems, "D");

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
						alert("성공");
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
			alert("변경 없음");
		}
	}

	// 선택 행들 위로 한 단계 올림
	function moveRowsToUp(c) {
		if (c == "1") {
			AUIGrid.moveRowsToUp(EDCK0204_grid.id);
		} else {
			AUIGrid.moveRowsToUp(EDCK0204_grid3.id);
		}
	};

	// 선택 행들 아래로 한 단계 올림
	function moveRowsToDown(c) {
		if (c == "1") {
			AUIGrid.moveRowsToDown(EDCK0204_grid.id);
		} else {
			AUIGrid.moveRowsToDown(EDCK0204_grid3.id);
		}
	};
	function moveVariable() {
		var selectedItems = AUIGrid.getSelectedItems(EDCK0204_grid.id);
		if (selectedItems.length <= 0) {
			alert("그룹선택없음");
		} else {
			var ret = "";
			var checkedItems = AUIGrid.getCheckedRowItems(EDCK0204_grid2.id);
			for (var i = 0; i < checkedItems.length; i++) {
				if (checkedItems[i].item.CDISC_UPPER_CODE == null) {
					var rows = AUIGrid.getRowsByValue(EDCK0204_grid3.id, "DOMN_VRIABL_SN", [ checkedItems[i].item.DOMN_VRIABL_SN ]);
					if (rows.length > 0) {
						ret += rows[0].VRIABL_NM + "\n";
					}
				}
			}
			if (ret != "") {
				ret += "이미 존재하는 Variable";
				alert(ret);
			} else {
				for (var i = 0; i < checkedItems.length; i++) {
					checkedItems[i].item.GROUP_SN = selectedItems[0].item.GROUP_SN
					AUIGrid.addRow(EDCK0204_grid3.id, checkedItems[i].item, "last");
				}
				AUIGrid.setAllCheckedRows(EDCK0204_grid2.id, false);
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
		var ret = "";
		var rowItems = AUIGrid.getGridData(EDCK0204_grid3.id);
		for (var i = 0; i < rowItems.length; i++) {
			var rowItem = rowItems[i];
			if (rowItem.CDISC_UPPER_CODE != null && rowItem.CL_CODE_SN == null) {
				ret += (i + 1) + "행 " + rowItem.VRIABL_NM + "\n";
			}
		}
		if (ret != "") {
			ret += "코드리스트 선택필요";
			alert(ret);
		} else {
			for (var i = 0; i < rowItems.length; i++) {
				var item = {
					VRIABL_ORDR : (i + 1)
				};
				AUIGrid.updateRow(EDCK0204_grid3.id, item, i, true);
			}

			var arJson = [];
			rowItems = AUIGrid.getAddedRowItems(EDCK0204_grid3.id);
			fn_makeArr(arJson, rowItems, "C");
			rowItems = AUIGrid.getEditedRowItems(EDCK0204_grid3.id);
			fn_makeArr(arJson, rowItems, "U");
			rowItems = AUIGrid.getRemovedItems(EDCK0204_grid3.id);
			fn_makeArr(arJson, rowItems, "D");

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
							alert("성공");
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
				alert("변경 없음");
			}
		}
	}

	function popupUserVariable() {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		mkLayerPopupOpen("/edc/k02/popupEDCK0205.do", param);
		AUIGrid.resize(EDCK0205_grid.id);
	}
	function editMode(c) {
		if (c == 1) {
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
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0204&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0204&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />

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
							<li id="tab_menu3" class="port_back tab_menu">Group</li>
							<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
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
							<h6>Group</h6>
						</article>
						<article class="conTitBtnR">
							<button type="button" onclick="moveRowsToUp(1)" able>▲</button>
							<button type="button" onclick="moveRowsToDown(1)" able>▼</button>
							<button type="button" onclick="addRow()" able>행추가</button>
							<button type="button" onclick="fn_deleteRow(EDCK0204_grid)" able>행삭제</button>
							<button type="button" onclick="saveGrid()" able>저장</button>
						</article>
						<article class="mgT16">
							<div id="EDCK0204_grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>

					<div class="conSbtLn right_001">
					 	<div style="height:29px;">
							<div class="conTitBtnL">
								<label>Domain :</label>
								<select id="CDISC_DOMN_SN" name="CDISC_DOMN_SN" able style="width:100px;">
									<option value="">선택</option>
									<c:forEach items="${ DOMAIN }" var="list">
										<option value="${ list.CODE }">${ list.VALUE }</option>
									</c:forEach>
								</select>
								<button type="button" onclick="searchVariable()" able>검색</button>
							</div>
							<article class="conTitBtnR">
								<button type="button" onclick="popupUserVariable()" able>User Variable</button>
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
							<h6>Variable</h6>
						</article>
						<article class="conTitBtnR">
							<button type="button" onclick="moveRowsToUp(3)" able>▲</button>
							<button type="button" onclick="moveRowsToDown(3)" able>▼</button>
							<button type="button" onclick="fn_deleteRow(EDCK0204_grid3)" able>행삭제</button>
							<button type="button" onclick="saveGrid2()" able>저장</button>
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