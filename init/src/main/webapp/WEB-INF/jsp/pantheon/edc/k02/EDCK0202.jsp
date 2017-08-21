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
	$(document).ready(function() {
		if ($("#frm_main #TASK_SN").val() == "") {
			alert('<spring:message code="edc.taskSelect.msg" />');
			location.replace("./EDCK0201.do");
		} else {
			var grid_param = new Object();
			grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
			EDCK0202_grid.proxy.param = grid_param;
			EDCK0202_grid.createGrid();

			$("#tab ul li").click(function() {
				if ($("#frm_main #EDC_VER").val() == "") {
					$("#tab_menu1").addClass("port_back").siblings().removeClass("port_back");
				}
			});

		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0202_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0202_grid.id);
		}
	};
	var EDCK0202_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0202_grid',
			paging : {
				pagingDiv : 'EDCK0202_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectCRFList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			reverseRowNum : true,
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : false,
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "EDC_VER"
		},
		columnLayout : [ {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			editable : false,
			visible : false
		}, {
			dataField : "CRF_VER",
			headerText : "CRF Ver",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "EDC_VER",
			headerText : "EDC Ver",
			editable : false,
			style : "edc_column_style",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CHANGE_RESN",
			headerText : '<spring:message code="edc.lbl.CHANGE_RESN" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "BNDE_APPLC_CODE",
			headerText : '<spring:message code="edc.lbl.BNDE_APPLC_CODE" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "BNDE_APPLC_DE",
			headerText : '<spring:message code="edc.lbl.BNDE_APPLC_DE" />',
			editable : false,
			formatString : "yyyy-mm-dd HH:MM:ss",
			dataType : "date",
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CRF_PROGRS_CODE",
			headerText : '<spring:message code="edc.lbl.CRF_PROGRS_CODE" />',
			editable : false,
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
			AUIGrid.bind(me.id, 'cellClick', function(event) {
				if (event.dataField == "EDC_VER") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#frm_main #EDC_VER").val(rowItem.EDC_VER);
					$("#tabTitle").text($("#frm_main #TASK_NO").val() + " - " + $("#frm_main #EDC_VER").val());
				} else if (event.dataField == "CHANGE_RESN" || event.dataField == "BNDE_APPLC_CODE" || event.dataField == "BNDE_APPLC_DE") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					var param = new Object();
					param.TASK_SN = rowItem.TASK_SN;
					param.EDC_VER = rowItem.EDC_VER;
					mkLayerPopupOpen("/edc/k02/popupEDCK0202Sub02.do", param);
					changeReason();
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function popupNewVersion() {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		mkLayerPopupOpen("/edc/k02/popupEDCK0202Sub01.do", param);
		$("#frm_popup input[name=change_ver][value=02]").prop("checked", true);
		newVersion();
	}
	function newVersion() {
		var edc_ver;
		if ($("#frm_popup #EDC_VER").val() == "") {
			$("#frm_popup input[name=change_ver]").prop("disabled", true);
			$("#frm_popup #crf_version").prop("disabled", true);
			$("#frm_popup #crf_version2").prop("disabled", true);
			edc_ver = 0;
		} else {
			if ($("#frm_popup input[name=change_ver]:checked").val() == "01") {
				$("#frm_popup #crf_version").prop("disabled", false);
				$("#frm_popup #crf_version2").prop("disabled", false);
				$("#frm_popup #crf_version option:eq(1)").show();
				$("#frm_popup #crf_version option:eq(0)").prop("selected", true);
				$("#frm_popup #crf_version2 option:eq(0)").hide()
				$("#frm_popup #crf_version2 option:eq(1)").hide();
				$("#frm_popup #crf_version2 option:eq(2)").show();
				$("#frm_popup #crf_version2 option:eq(2)").prop("selected", true);
				edc_ver = $("#frm_popup #EDC_VER").val();
			} else {
				$("#frm_popup #crf_version option:eq(1)").hide();
				$("#frm_popup #crf_version option:eq(0)").prop("selected", true);
				$("#frm_popup #crf_version2 option:eq(0)").hide()
				$("#frm_popup #crf_version2 option:eq(1)").show();
				$("#frm_popup #crf_version2 option:eq(2)").hide();
				$("#frm_popup #crf_version2 option:eq(1)").prop("selected", true);
				$("#frm_popup #crf_version").prop("disabled", true);
				$("#frm_popup #crf_version2").prop("disabled", true);
				edc_ver = $("#frm_popup #NEW_EDC_VER").val();
			}
		}
		var crf_ver = $("#frm_popup #crf_version").val() + "." + $("#frm_popup #crf_version2").val();
		var str = "CRF Version : " + crf_ver + " EDC Version : " + crf_ver + "." + edc_ver;
		$("#versionInfo").text(str);
	}
	function setVersion() {
		var edc_ver = $("#frm_popup #EDC_VER").val();
		var index = $("#frm_popup #crf_version option").index($("#frm_popup #crf_version option:selected"));
		if (index == 1) {
			$("#frm_popup #crf_version2 option:eq(0)").show();
			$("#frm_popup #crf_version2 option:eq(0)").prop("selected", true);
			$("#frm_popup #crf_version2 option:eq(1)").hide();
			$("#frm_popup #crf_version2 option:eq(2)").hide();
			edc_ver = 0;
		} else {
			$("#frm_popup #crf_version2 option:eq(0)").hide();
			$("#frm_popup #crf_version2 option:eq(1)").hide();
			$("#frm_popup #crf_version2 option:eq(2)").show();
			$("#frm_popup #crf_version2 option:eq(2)").prop("selected", true);
		}
		var crf_ver = $("#frm_popup #crf_version").val() + "." + $("#frm_popup #crf_version2").val();
		var str = "CRF Version : " + crf_ver + " EDC Version : " + crf_ver + "." + edc_ver;
		$("#versionInfo").text(str);
	}
	function saveEDCVesion() {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.CHANGE_RESN = $("#frm_popup #CHANGE_RESN").val();

		if ($.trim(param.CHANGE_RESN) == "") {
			alert('<spring:message code="edc.inputReason.msg" />');
		} else {
			if ($("#frm_popup input[name=change_ver]:checked").val() == "02") {
				param.CRF_VER = "N"
			} else {
				param.CRF_VER = $("#frm_popup #crf_version").val() + "." + $("#frm_popup #crf_version2").val();
			}
			$.ajax({
				url : './insertEDCVersion.do',
				data : param,
				type : 'post',
				//contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						layerClose();
						EDCK0202_grid.load();
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

	function changeReason() {
		if ($("#frm_popup input[name=BNDE_APPLC_CODE]:checked").val() == "01") {
			$("#frm_popup #BNDE_APPLC_DE").val("");
			$("#frm_popup #BNDE_APPLC_DE").prop("disabled", true);
		} else {
			$("#frm_popup #BNDE_APPLC_DE").prop("disabled", false);
		}
	}
	function saveChangeReason() {
		if ($("#frm_popup input[name=BNDE_APPLC_CODE]:checked").val() == "02" && $("#frm_popup #BNDE_APPLC_DE").val() == "") {
			alert('<spring:message code="edc.activeDate.msg" />');
		} else {
			var param = $("#frm_popup").serialize();
			$.ajax({
				url : './updateChangeReason.do',
				data : param,
				type : 'post',
				//contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						layerClose();
						EDCK0202_grid.load();
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
	function checkEDCVersion(c) {
		if ($("#frm_main #EDC_VER").val() == "") {
			alert('<spring:message code="edc.edcSelect.msg" />');
		} else {
			fn_moveTab(c);
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

	function popupBlindApproval() {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		$.ajax({
			url : './selectTaskBlindPk.do',
			data : param,
			type : 'post',
			//contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					data.result.TYPE = "BLIND";
					mkLayerPopupOpen('/com/z09/popupCOMZ0902.do', data.result, 2);
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
	function updateTaskBlindPk(sancline_sn) {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.SANCLINE_SN = sancline_sn;
		$.ajax({
			url : './updateTaskBlindPk.do',
			data : param,
			type : 'post',
			//contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0202&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0202&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
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
								<li id="tab_menu1" class="port_back tab_menu">CRF List</li>
								<li id="tab_menu2" class="tab_menu" onclick="checkEDCVersion('EDCK0203');">Template</li>
								<li id="tab_menu3" class="tab_menu" onclick="checkEDCVersion('EDCK0204');">Group</li>
								<li id="tab_menu4" class="tab_menu" onclick="checkEDCVersion('EDCK0207');">Visit</li>
								<li id="tab_menu9" class="tab_menu" onclick="checkEDCVersion('EDCK0218');">Coding</li>
								<li id="tab_menu5" class="tab_menu" onclick="checkEDCVersion('EDCK0208');">Dictionary</li>
								<li id="tab_menu6" class="tab_menu" onclick="checkEDCVersion('EDCK0209');">Layout</li>
								<li id="tab_menu7" class="tab_menu" onclick="checkEDCVersion('EDCK0212');">Edit Check</li>
								<li id="tab_menu8" class="tab_menu" onclick="checkEDCVersion('EDCK0214');">T-Domain</li>
							</ul>
						</div>



						<article class="conTitBox">
							<h5>
								<label id="tabTitle">${ TASK_NO } - ${ EDC_VER }</label>
							</h5>
						</article>

						<div class="conTitBtnR">
							<input type="button" onclick="popupNewVersion();" value="<spring:message code="btn.new" />">
							<input type="button" onclick="" value="<spring:message code="edc.btn.CONFIRM_REQUEST" />">
							<input type="button" onclick="" value="<spring:message code="edc.btn.CONFIRM" />">
							<input type="button" onclick="" value="<spring:message code="edc.btn.CONFIRM_HISTORY" />">
							<input type="button" onclick="" value="<spring:message code="edc.btn.BATCH_APPLY" />">
							<input type="button" onclick="popupUserVariable();" value="<spring:message code="edc.btn.USER_VARIABLE" />">
							<input type="button" onclick="popupBlindApproval();" value="<spring:message code="edc.btn.BLIND_CONFIRM" />">
						</div>

						<article class="mgT16">
							<div id="EDCK0202_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
							<div id="EDCK0202_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>

						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
							<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
						</form>
					</div>
			</div>
		</section>
	</div>
</body>
</html>