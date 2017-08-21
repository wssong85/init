<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>EDC Designer</title>


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
				<c:forEach items="${ EDC057 }" var="list">
				var obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0218_grid, "DOMN_SE_CODE", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC041 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0218_grid, "CODING_AT", codeList);

				codeList = new Array();
				<c:forEach items="${ EDC050 }" var="list">
				obj = new Object();
				obj.code = "${ list.CODE }";
				obj.value = "${ list.VALUE }";
				codeList.push(obj);
				</c:forEach>
				fn_setCodeList(EDCK0218_grid, "DICARY_SE_CODE", codeList);

				var gridParam = new Object();
				gridParam.TASK_SN = $("#frm_main #TASK_SN").val();
				gridParam.EDC_VER = $("#frm_main #EDC_VER").val();
				EDCK0218_grid.proxy.param = gridParam;
				EDCK0218_grid.createGrid();

				if (AUIGrid.getRowCount(EDCK0218_grid.id) > 0) {
					editMode(false);
				} else {
					editMode(true);
				}
			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0218_grid.id != "undefined") {
			AUIGrid.resize(EDCK0218_grid.id);
		}
	};
	var EDCK0218_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0218_grid',
			paging : {
				pagingDiv : 'EDCK0218_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectCodingList.do',
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
			enableFilter : false,
			headerHeight : 40,
			rowHeight : 37,
			//fixedColumnCount : 7,
			selectionMode : "singleCell",
			//enableCellMerge : true,
			rowIdField : "CODING_SN"
		},
		columnLayout : [ {
			dataField : "DOMN_SE_CODE",
			headerText : '<spring:message code="edc.lbl.DOMN_SE_CODE" />' + "<span class='must_01'></span>",
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
			dataField : "DOMN_VRIABL_SN",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />' + "<span class='must_01'></span>",
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
			dataField : "CODING_AT",
			headerText : '<spring:message code="edc.lbl.CODING_AT" />' + "<span class='must_01'></span>",
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
			dataField : "DICARY_SE_CODE",
			headerText : '<spring:message code="edc.lbl.DICARY_SE_CODE" />' + "<span class='must_01'></span>",
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
			dataField : "DICARY_VER",
			headerText : '<spring:message code="edc.lbl.DICARY_VER" />' + "<span class='must_01'></span>",
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
			dataField : "CODING_SN",
			headerText : "CODING_SN",
			visible : false,
			editable : false
		}, {
			dataField : "CRUD",
			headerText : "CRUD",
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
			AUIGrid.bind(me.id, 'addRow', function(event) {
				var codeList = getCodingVariable(event.items[0].DOMN_SE_CODE);
				fn_setCodeList(me, "DOMN_VRIABL_SN", codeList);
			});

			AUIGrid.bind(me.id, 'cellEditEnd', function(event) {
				if (event.dataField == "DOMN_SE_CODE") {
					if (event.value) {
						var codeList = getCodingVariable(event.value);
						fn_setCodeList(me, "DOMN_VRIABL_SN", codeList);
					}
				} else if (event.dataField == "DICARY_SE_CODE") {
					if (event.value) {
						var param = new Object();
						param.URL = "./selectDictionaryVersionList.do";
						param.TASK_SN = $("#frm_main #TASK_SN").val();
						param.EDC_VER = $("#frm_main #EDC_VER").val();
						param.DICARY_SE_CODE = event.item.DICARY_SE_CODE;
						var codeList = fn_makeSelectList(param);
						fn_setCodeList(me, "DICARY_VER", codeList);
					}
				} else if (event.dataField == "DOMN_VRIABL_SN") {
					if (event.value) {
						if (AUIGrid.getItemsByValue(me.id, "DOMN_VRIABL_SN", event.value).length > 1) {
							alert("이미 존재함");
							return event.oldValue;
						}
					}
				}
			});
			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				if (event.dataField == "DOMN_VRIABL_SN") {
					if (event.value && event.value != event.oldValue) {
						if (AUIGrid.getItemsByValue(me.id, "DOMN_VRIABL_SN", event.value).length > 0) {
							alert("이미 존재함");
							return event.oldValue;
						}
					}
				}
				return event.value;
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);

			var rowItems = AUIGrid.getGridData(me.id);
			for (var i = 0; i < rowItems.length; i++) {
				var domn_se_code = rowItems[i].DOMN_SE_CODE;
				if (domn_se_code) {
					var codeList = getCodingVariable(domn_se_code);
					fn_setCodeList(me, "DOMN_VRIABL_SN", codeList);
				}
				AUIGrid.refresh(me.id);
			}
		}
	};
	function getCodingVariable(domn_se_code) {
		var param = new Object();
		param.URL = "./selectCodingVariableList.do";
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.EDC_VER = $("#frm_main #EDC_VER").val();
		param.DOMN_SE_CODE = domn_se_code;
		return fn_makeSelectList(param);
	}
	function addRow() {
		var item = {
			TASK_SN : $("#frm_main #TASK_SN").val(),
			EDC_VER : $("#frm_main #EDC_VER").val(),
			DOMN_SE_CODE : "01"
		};
		AUIGrid.addRow(EDCK0218_grid.id, item, "first");
	}
	function saveGrid() {
		var rowItems = AUIGrid.getGridData(EDCK0218_grid.id);
		var b = true;
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].DOMN_VRIABL_SN || rowItems[i].DOMN_VRIABL_SN.length <= 0) {
				b = false;
				alert("DOMN_VRIABL_SN 필수 입력");
				AUIGrid.setSelectionByIndex(EDCK0218_grid.id, i);
				break;
			} else if (!rowItems[i].CODING_AT || rowItems[i].CODING_AT.length <= 0) {
				b = false;
				alert("CODING_AT 필수 입력");
				AUIGrid.setSelectionByIndex(EDCK0218_grid.id, i);
				break;
			} else if (!rowItems[i].DICARY_SE_CODE || rowItems[i].DICARY_SE_CODE.length <= 0) {
				b = false;
				alert("DICARY_SE_CODE 필수 입력");
				AUIGrid.setSelectionByIndex(EDCK0218_grid.id, i);
				break;
			} else if (!rowItems[i].DICARY_VER || rowItems[i].DICARY_VER.length <= 0) {
				b = false;
				alert("DICARY_VER 필수 입력");
				AUIGrid.setSelectionByIndex(EDCK0218_grid.id, i);
				break;
			}

		}
		if (b) {
			var arJson = [];
			v_rowItems = AUIGrid.getAddedRowItems(EDCK0218_grid.id);
			fn_makeArr(arJson, v_rowItems, "C");
			v_rowItems = AUIGrid.getEditedRowItems(EDCK0218_grid.id);
			fn_makeArr(arJson, v_rowItems, "U");
			v_rowItems = AUIGrid.getRemovedItems(EDCK0218_grid.id);
			fn_makeArr(arJson, v_rowItems, "D");

			if (arJson.length > 0) {
				AUIGrid.showAjaxLoader(EDCK0218_grid.id);
				$.ajax({
					url : './insertCodingList.do',
					data : JSON.stringify(arJson),
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0218_grid.load();
							alert("성공");
						} else {
							alert(data.message);
						}
						AUIGrid.removeAjaxLoader(EDCK0218_grid.id);
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
	function editMode(e) {
		if (!e) {
			mkDisabled(); //컨트롤 비활성화
			AUIGrid.setProperty(EDCK0218_grid.id, {
				"editable" : false
			});
			$("button").hide();
			$("#btn_edit").show();
		} else {
			mkEnabled(); //컨트롤 활성화

			var selIdx = AUIGrid.getSelectedIndex(EDCK0218_grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(EDCK0218_grid.id, EDCK0218_grid.gridPros.selectionMode);
				AUIGrid.setProperty(EDCK0218_grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(EDCK0218_grid.id, selIdx[0], selIdx[1])
			} else {
				AUIGrid.setProperty(EDCK0218_grid.id, {
					"editable" : true
				});
			}

			$("button").show();
			$("#btn_edit").hide();
		}
	}
</script>
</head>

<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0218&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0218&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />

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
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
								<li id="tab_menu9" class="port_back tab_menu">Coding</li>
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
								<button type="button" class="add_01" onclick="addRow()" title="<spring:message code="btn.rowAdd" />" able>
									<spring:message code="btn.rowAdd" />
								</button>
								<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0218_grid)" title="<spring:message code="btn.rowDelete" />" able>
									<spring:message code="btn.rowDelete" />
								</button>
								<button type="button" class="save_01" onclick="saveGrid()" title="<spring:message code="btn.save" />" able>
									<spring:message code="btn.save" />
								</button>
							</div>
						</section>

						<article class="mgT16">
							<div id="EDCK0218_grid" class="gridHeiSz13 grid_wrap tb01_2"></div>
						</article>


					</div>
				</section>

			</div>
		</section>
	</div>
</body>
</html>