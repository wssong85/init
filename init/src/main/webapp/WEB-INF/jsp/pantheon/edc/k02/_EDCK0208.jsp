<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/com/common.do" flush="false" />

<title>EDC Designer</title>


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
				var gridParam = new Object();
				gridParam.TASK_SN = $("#frm_main #TASK_SN").val();
				gridParam.EDC_VER = $("#frm_main #EDC_VER").val();
				EDCK0208_grid.proxy.param = gridParam;
				EDCK0208_grid.createGrid();

				editMode(1);
			}
		}
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0208_grid.id !== "undefined") {
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
			showStateColumn : false,
			editable : true,
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
			headerText : "VISIT_LBL",
			cellMerge : true,
			editable : false
		}, {
			dataField : "GROUP_LBL",
			headerText : "GROUP_LBL",
			cellMerge : true,
			editable : false,
			width: 100
		}, {dataField : "RN",
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
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE",
			editable : false,
			width: 100
		}, {
			dataField : "UNIT_VALUE",
			headerText : "UNIT_VALUE",
			editable : false,
			width: 100
		}, {
			dataField : "DOMN_NM",
			headerText : "DOMN_NM",
			editable : false,
			width: 100
		}, {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM",
			editable : false,
			width: 100
		}, {
			dataField : "UPPER_CDISC_SUBMIT_VALUE",
			headerText : "UPPER_CDISC_SUBMIT_VALUE",
			editable : false,
			width: 205
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE",
			editable : false,
			width: 160
		}, {
			dataField : "VRIABL_ROLE",
			headerText : "VRIABL_ROLE",
			editable : false,
			width: 120
		}, {
			dataField : "CTRL_FOM",
			headerText : "CTRL_FOM",
			editable : false,
			width: 120
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : "VRIABL_TY_CODE",
			editable : false,
			width: 140
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO",
			editable : false,
			width: 120
		}, {
			dataField : "VRIABL_LBL",
			headerText : "VRIABL_LBL",
			editable : false,
			width: 120
		}, {
			dataField : "CORE_CODE",
			headerText : "CORE_CODE",
			editable : false,
			width: 120
		}, {
			dataField : "VRIABL_DC",
			headerText : "VRIABL_DC",
			editable : false,
			width: 120
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
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	function editMode(c) {
		if (c == 1) {
			mkDisabled(); //컨트롤 비활성화
			$("button").hide();
			$("#btn_edit").show();
		} else {
			mkEnabled(); //컨트롤 활성화
			$("button").show();
			$("#btn_edit").hide();
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
							<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0204');">Group</li>
							<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0207');">Visit</li>
							<li id="tab_menu5" class="port_back tab_menu">Dictionary</li>
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
							<button type="button" onclick="saveGrid();">저장</button>
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