<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />


<title></title>
<style>
</style>
<script type="text/javascript">
	var EDCC0114_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCC0114_grid',
			paging : {
				pagingDiv : 'EDCC0114_grid_paging',
				totalRowCount : 500,
				rowCount : 20,
				pageButtonCount : 5,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectPatientList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			// 			paging : true,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			usePaging : true,
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "SUBJECT_NO"
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "PATNT_NO",
			headerText : '<spring:message code="edc.lbl.PATIENT_NO" />',
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "SUBJECT_NO",
			headerText : "Subject_No",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "SUBJECT_NO",
			headerText : "Subject_No",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "FRST_CREDE",
			headerText : '<spring:message code="edc.lbl.INPUT_DATE" />',
			editable : false,
			formatString : "yyyy-mm-dd HH:MM:ss",
			dataType : "date",
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	$(document).ready(function() {
		var grid_param = new Object();
		grid_param.TASK_SN = $("#frm_main #TASK_SN").val();

		EDCC0114_grid.proxy.param = grid_param;
		EDCC0114_grid.createGrid();
	});

	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCC0114_grid !== "undefined") {
			AUIGrid.resize(EDCC0114_grid);
		}
	};

	function saveGrid() {
		var arJson = [];
		var rowItems = AUIGrid.getEditedRowItems(EDCC0114_grid.id);
		fn_makeArr(arJson, rowItems, "U");
		rowItems = AUIGrid.getRemovedItems(EDCC0114_grid.id);
		fn_makeArr(arJson, rowItems, "D");

		if (arJson.length > 0) {
			AUIGrid.showAjaxLoader(EDCC0114_grid.id);
			$.ajax({
				url : './updatePatientList.do',
				data : JSON.stringify(arJson),
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						EDCC0114_grid.load();
						alert("성공");
					} else {
						alert(data.message);
					}
					AUIGrid.removeAjaxLoader(EDCC0114_grid.id);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		} else {
			alert("변경 없음");
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0114&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0114&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
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
						<article class="conTitBox">
							<h6></h6>
						</article>
						<article class="conTitBtnR">
							<%-- <button type="button" class="save_01" onclick="saveGrid()" title="<spring:message code="btn.save" />" able>
								<spring:message code="btn.save" />
							</button> --%>
						</article>
						<article class="mgT16">
							<div id="EDCC0114_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
						</article>

						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
						</form>

					</div>
				</section>
				<!-- 컨텐츠박스 끝-->
			</div>
		</section>
	</div>
</body>
</html>