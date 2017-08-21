<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title>이상반응 신속보고 목록</title>
<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>
<script type="text/javascript">
	var EDCJ0101_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCJ0101_grid',
			paging : {
				pagingDiv : 'EDCJ0101_grid_paging',
				totalRowCount : 500,
				rowCount : 20,
				pageButtonCount : 5,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectSaeRepList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : true,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			fixedColumnCount : 3,
			selectionMode : "singleRow"
		},
		//AUI 그리드 레이아웃 RNUM
		columnLayout : [ {
			dataField : "rnum",
			headerText : "No",
			editable : false,
			minWidth : 40,
			width : 40
		},{ 
			dataField : "name1",
			headerText : "Site",
			width : 120,
			editable : false
		},{
			dataField : "subjectNo",
			headerText : "Subject",
			width: 120,
			editable : false,
			style : "edc_column_style"
		},{
			dataField : "saeReprtSn",
			headerText : "SAE 보고서 순번",
			width: 0,
			editable : false,
			visible : false
		},{
			dataField : "aetNm",
			headerText : "SAE내용",
			width: 120,
			editable : false
		},{
			dataField : "reportrNm",
			headerText : "보고자",
			width: 120,
			editable : false
		},{
			dataField : "reportClCode",
			headerText : "보고상태",
			width: 120,
			editable : false
		},{
			dataField : "streSttusCode",
			headerText : "저장상태",
			width: 120,
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
				if (event.dataField == "subjectNo") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#insttFormSn").val(rowItem.insttFormSn);
					$("#subjectNo").val(rowItem.subjectNo);
					$("#saeReprtSn").val(rowItem.saeReprtSn);
					$("#searchForm").attr({
						action : './EDCJ0102.do',
						method : 'post'
					}).submit();
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		},
		//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		createPagingNavigator : function(goPage) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			fn_createPagingNavigator(me, goPage);
		},
		//페이징 에서 어느 페이지로 갈 것인지 지정
		moveToPage : function(goPage, rowCount) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			$("#searchForm PAGE").val(goPage);
			fn_moveToPage(me, goPage, rowCount)
		}
	};

	function searchClick(page) {
		if (page == undefined) {
			page = 1;
		}

		$("#searchForm #PAGE").val(page);
		$("#searchForm #COUNT").val(EDCJ0101_grid.div.paging.rowCount);
		var param = $("#searchForm").serialize();
		EDCJ0101_grid.proxy.param = param;
		EDCJ0101_grid.load();
	}
	$(document).ready(function() {
		EDCJ0101_grid.createGrid();
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCJ0101_grid.id !== "undefined") {
			AUIGrid.resize(EDCJ0101_grid.id);
		}
	};
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCJ0101&&UPPER_MENU_ID=EDCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCJ0101&&UPPER_MENU_ID=EDCJ" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>이상반응 신속보고</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>REPORT</li>
						<li>이상반응 신속보고</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">

				<div class="conBoxInner">
					<form name="searchForm" id="searchForm">
					<input type="hidden" name="insttFormSn" id="insttFormSn"/>
					<input type="hidden" name="saeReprtSn" id="saeReprtSn"/>
					<input type="hidden" name="subjectNo" id="subjectNo"/>

		            	<articla class="conTitBox">
		            		<h5>이상반응 신속보고 목록</h5>
		            	</articla>

						<article class="mgT10" style="overflow:hidden;">
							<div class="conTitBtnL">
								<input type="hidden" id="PAGE" name="PAGE">
								<input type="hidden" id="COUNT" name="COUNT">
								<span style="font-family:'NanumGothicBold';">Site</span> <input type="text" name="insttNm" id="insttNm" value="" class="pdR15"> 
								<span style="font-family:'NanumGothicBold';">Subject</span> <input type="text" name="SUBJECT_NO" id="SUBJECT_NO" value="" class="pdR15">
								<input type="button" class="btn mgL3" onclick="searchClick()" value="검색">
							</div>
							<div class="conTitBtnR">									
								<input type="button" value="PDF 인쇄" onclick="fnInsert()">
								<input type="button" value="Audit" onclick="fn_upSave()">
							</div>
						</article>

						<article class="mgT16">
	                        <div id="EDCJ0101_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                        <div id="EDCJ0101_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>

					</form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>
</html>