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
			headerText : "CRF_VER",
			editable : false
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER",
			editable : false,
			style : "edc_column_style"
		}, {
			dataField : "CHANGE_RESN",
			headerText : "CHANGE_RESN",
			editable : false
		}, {
			dataField : "BNDE_APPLC_CODE",
			headerText : "BNDE_APPLC_CODE",
			editable : false
		}, {
			dataField : "BNDE_APPLC_DE",
			headerText : "BNDE_APPLC_DE",
			editable : false,
			formatString : "yyyy-mm-dd",
			dataType : "date"
		}, {
			dataField : "CRF_PROGRS_CODE",
			headerText : "CRF_PROGRS_CODE",
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
		$("#frm_popup input[name=versionChange][value=02]").prop("checked", true);
		newVersion();
	}
	function newVersion() {
		var edcVer;
		if ($("#frm_popup #EDC_VER").val() == "-1") {
			$("#frm_popup input[name=versionChange]").prop("disabled", true);
			$("#frm_popup #crfVersion").prop("disabled", true);
			$("#frm_popup #crfVersion2").prop("disabled", true);
			edcVer = 0;
		} else {
			if ($("#frm_popup input[name=versionChange]:checked").val() == "01") {
				$("#frm_popup #crfVersion").prop("disabled", false);
				$("#frm_popup #crfVersion2").prop("disabled", false);
				$("#frm_popup #crfVersion option:eq(1)").show();
				$("#frm_popup #crfVersion option:eq(0)").prop("selected", true);
				$("#frm_popup #crfVersion2 option:eq(0)").hide();
				$("#frm_popup #crfVersion2 option:eq(1)").prop("selected", true);
				edcVer = $("#frm_popup #EDC_VER").val();
			} else {
				$("#frm_popup #crfVersion option:eq(1)").hide();
				$("#frm_popup #crfVersion option:eq(0)").prop("selected", true);
				$("#frm_popup #crfVersion2 option:eq(0)").show();
				$("#frm_popup #crfVersion2 option:eq(0)").prop("selected", true);
				$("#frm_popup #crfVersion").prop("disabled", true);
				$("#frm_popup #crfVersion2").prop("disabled", true);
				edcVer = Number($("#frm_popup #EDC_VER").val()) + 1;
			}
		}
		var crfVer = $("#frm_popup #crfVersion").val() + "." + $("#frm_popup #crfVersion2").val();
		var str = "CRF Version : " + crfVer + " EDC Version : " + crfVer + "." + edcVer;
		$("#versionInfo").text(str);
	}
	function setVersion() {
		var index = $("#frm_popup #crfVersion option").index($("#frm_popup #crfVersion option:selected"));
		if (index == 1) {
			$("#frm_popup #crfVersion2 option:eq(0)").show();
			$("#frm_popup #crfVersion2 option:eq(0)").prop("selected", true);
			$("#frm_popup #crfVersion2 option:eq(1)").hide();
		} else {
			$("#frm_popup #crfVersion2 option:eq(0)").hide();
			$("#frm_popup #crfVersion2 option:eq(1)").show();
			$("#frm_popup #crfVersion2 option:eq(1)").prop("selected", true);
		}
		var crfVer = $("#frm_popup #crfVersion").val() + "." + $("#frm_popup #crfVersion2").val();
		var edcVer = $("#frm_popup #EDC_VER").val();
		var str = "CRF Version : " + crfVer + " EDC Version : " + crfVer + "." + edcVer;
		$("#versionInfo").text(str);
	}
	function saveEDCVesion() {
		var param = new Object();
		param.TASK_SN = $("#frm_main #TASK_SN").val();
		param.CHANGE_RESN = $("#frm_popup #CHANGE_RESN").val();

		if ($.trim(param.CHANGE_RESN) == "") {
			alert("사유 없음");
		} else {
			if ($("#frm_popup input[name=versionChange]:checked").val() == "02") {
				param.CRF_VER = "N"
			} else {
				param.CRF_VER = $("#frm_popup #crfVersion").val() + "." + $("#frm_popup #crfVersion2").val();
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
			alert("날짜 선택 필요");
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
			alert("EDC버전 선택필요");
		} else {
			fn_moveTab(c);
		}
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
								<li id="tab_menu1" class="port_back tab_menu">CRF List</li>
								<li id="tab_menu2" class="tab_menu" onclick="checkEDCVersion('EDCK0203');">Template</li>
								<li id="tab_menu3" class="tab_menu" onclick="checkEDCVersion('EDCK0204');">Group</li>
								<li id="tab_menu4" class="tab_menu" onclick="checkEDCVersion('EDCK0207');">Visit</li>
								<li id="tab_menu5" class="tab_menu" onclick="checkEDCVersion('EDCK0208');">Dictionary</li>
								<li id="tab_menu6" class="tab_menu" onclick="checkEDCVersion('EDCK0209');">Layout</li>
								<li id="tab_menu7" class="tab_menu" onclick="checkEDCVersion('EDCK0212');">Edit Check</li>
								<li id="tab_menu8" class="tab_menu" onclick="checkEDCVersion('EDCK0214');">T-Domain</li>
							</ul>
						</div>



		            	<articla class="conTitBox">
		            		<h5 id="tabTitle">${ TASK_NO } - ${ EDC_VER }</h5>
		            	</articla>



						<div class="conTitBtnR">
							<input type="button" onclick="popupNewVersion();" value="신규">
							<input type="button" onclick="" value="승인요청">
							<input type="button" onclick="" value="승인">
							<input type="button" onclick="" value="승인이력">
							<input type="button" onclick="" value="일괄적용">
							<input type="button" onclick="" value="사용자Variable">
							<input type="button" onclick="" value="Blind결재선">
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
            </section>



		</div>
	</section>
</div>
</body>
</html>