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
				<c:forEach items="${ VISIT }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0208_grid, "VISIT_SN", codeList);

				codeList = new Array();
				<c:forEach items="${ GROUP }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0208_grid, "GROUP_SN", codeList);

				var gridParam = new Object();
				gridParam.TASK_SN = $("#frm_main #TASK_SN").val();
				gridParam.EDC_VER = $("#frm_main #EDC_VER").val();
				EDCK0208_grid.proxy.param = gridParam;
				EDCK0208_grid.createGrid();

				editMode(false);
			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0208_grid.id != "undefined") {
			AUIGrid.resize(EDCK0208_grid.id);
		}
	};
	var EDCK0208_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0208_grid',
			paging : {
				pagingDiv : 'EDCK0208_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectDictionary.do',
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
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			//fixedColumnCount : 7,
			selectionMode : "singleCell",
			enableCellMerge : true,
			rowIdField : "RN"
		},
		columnLayout : [ {
			dataField : "VISIT_SN",
			headerText : '<spring:message code="edc.lbl.VISIT_LBL" />',
			cellMerge : true,
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
			},
			width : 100
		}, {
			dataField : "GROUP_SN",
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />',
			cellMerge : true,
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
				value = value.substring(value.indexOf("_") + 1, value.length);
				return fn_checkCodeList(this, value);
			},
			filter : {
				showIcon : true
			},
			width : 100
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : '<spring:message code="edc.lbl.VRIABL_LBL" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 100
		}, {
			dataField : "DOMN_NM",
			headerText : '<spring:message code="edc.lbl.DOMN_NM" />',
			headerText : "DOMN_NM",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 100
		}, {
			dataField : "VRIABL_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 100
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.UPPER_CDISC_SUBMIT_VALUE" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 100
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edc.lbl.CDISC_SUBMIT_VALUE" />',
			style : "edc_column_style",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 160
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 120
		}, {
			dataField : "VRIABL_LBL",
			headerText : "VRIABL_LBL",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 120
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : '<spring:message code="edc.lbl.VRIABL_TY_CODE" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 140
		}, {
			dataField : "CORE_CODE",
			headerText : '<spring:message code="edc.lbl.CORE_CODE" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 120
		}, {
			dataField : "VRIABL_ROLE",
			headerText : '<spring:message code="edc.lbl.VRIABL_ROLE" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 120
		}, {
			dataField : "CTRL_FOM",
			headerText : '<spring:message code="edc.lbl.CTRL_FOM" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 120
		}, {
			dataField : "VRIABL_DC",
			headerText : '<spring:message code="edc.lbl.VRIABL_DC" />',
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			width : 120
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			sortable : false,
			editable : false,
			visible : false
		}, {
			dataField : "VRIABL_ORDR",
			headerText : "VRIABL_ORDR",
			sortable : false,
			editable : false,
			visible : false
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			visible : false
		}, {
			dataField : "VRIABL_SN",
			headerText : "VRIABL_SN",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			visible : false
		}, {
			dataField : "RN",
			headerText : "RN",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			visible : false
		}, {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			visible : false
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
			visible : false
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN",
			sortable : false,
			editable : false,
			filter : {
				showIcon : true
			},
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
				if (AUIGrid.getProperty(me.id, "editable")) {
					if (event.dataField == "CDISC_SUBMIT_VALUE") {
						var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
						var param = new Object();
						param.TASK_SN = $("#frm_main #TASK_SN").val();
						param.VRIABL_SN = rowItem.VRIABL_SN;
						param.DOMN_VRIABL_SN = rowItem.DOMN_VRIABL_SN;
						param.CL_CODE_SN = rowItem.CL_CODE_SN;
						param.CDISC_UPPER_CODE = rowItem.CDISC_UPPER_CODE;
						param.PAGE = "EDCK0208";
						param.RN = rowItem.RN;
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
	function editMode(e) {
		if (!e) {
			mkDisabled(); //컨트롤 비활성화

			AUIGrid.setProperty(EDCK0208_grid.id, {
				"editable" : false
			});

			$("button").hide();
			$("#btn_edit").show();
		} else {
			mkEnabled(); //컨트롤 활성화

			var selIdx = AUIGrid.getSelectedIndex(EDCK0208_grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(EDCK0208_grid.id, EDCK0208_grid.gridPros.selectionMode);
				AUIGrid.setProperty(EDCK0208_grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(EDCK0208_grid.id, selIdx[0], selIdx[1])
			} else {
				AUIGrid.setProperty(EDCK0208_grid.id, {
					"editable" : true
				});
			}

			$("button").show();
			$("#btn_edit").hide();
		}
	}
	function saveGrid() {
		var arJson = [];
		var rowItems = AUIGrid.getEditedRowItems(EDCK0208_grid.id);
		fn_makeArr(arJson, rowItems, "U");

		if (arJson.length > 0) {
			AUIGrid.showAjaxLoader(EDCK0208_grid.id);
			$.ajax({
				url : './insertDictionary.do',
				data : JSON.stringify(arJson),
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						EDCK0208_grid.load();
						alert('<spring:message code="edc.save.confirm.msg" />');
					} else {
						alert(data.message);
					}
					AUIGrid.removeAjaxLoader(EDCK0208_grid.id);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		} else {
			alert('<spring:message code="edc.save.noChange" />');
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0208&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0208&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />


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
								<li id="tab_menu9" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0218');">Coding</li>
								<li id="tab_menu5" class="port_back tab_menu">Dictionary</li>
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
								<button type="button" class="save_01" onclick="saveGrid();" title="<spring:message code="btn.save" />" able>
									<spring:message code="btn.save" />
								</button>
							</div>
						</section>






						<article class="mgT16">
							<div id="EDCK0208_grid" class="gridHeiSz13 grid_wrap tb01_2"></div>
						</article>





					</div>
				</section>



			</div>
		</section>
	</div>
</body>
</html>