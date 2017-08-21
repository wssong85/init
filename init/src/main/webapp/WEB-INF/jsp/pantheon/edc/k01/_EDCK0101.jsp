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
	var EDCK0101_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0101_grid',
			paging : {
				pagingDiv : 'EDCK0101_grid_paging',
				totalRowCount : 500,
				rowCount : 20,
				pageButtonCount : 5,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectStudyList.do',
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
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "RNUM",
			headerText : "No",
			editable : false,
			minWidth : 40,
			width : 40
		}, {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TASK_NO",
			headerText : "TASK_NO",
			editable : false,
			minWidth : 100,
			width : 100,
			style : "edc_column_style"
		}, {
			dataField : "TASK_NM",
			headerText : "TASK_NM",
			width : 100,
			editable : false
		}, {
			dataField : "TASK_TY_CODE",
			headerText : "TASK_TY_CODE",
			editable : false,
			width : 120
		}, {
			dataField : "CRF_VER",
			headerText : "CRF_VER",
			editable : false
		}, {
			dataField : "CRF_LAST_UPDDE",
			headerText : "CRF_LAST_UPDDE",
			editable : false,
			width : 140,
			formatString : "yyyy-mm-dd",
			dataType : "date"
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER",
			style : "edc_column_style",
			editable : false
		}, {
			dataField : "EDC_LAST_UPDDE",
			headerText : "EDC_LAST_UPDDE",
			editable : false,
			width : 140,
			formatString : "yyyy-mm-dd",
			dataType : "date"
		}, {
			dataField : "CRF_PROGRS_CODE",
			headerText : "CRF_PROGRS_CODE",
			editable : false,
			width : 140
		}, {
			dataField : "TASK_SN",
			headerText : "IWRS",
			editable : false
		}, {
			dataField : "IWRS_LAST_UPDDE",
			headerText : "IWRS_LAST_UPDDE",
			editable : false,
			width : 140,
			formatString : "yyyy-mm-dd",
			dataType : "date"
		}, {
			dataField : "CDISC_VER",
			headerText : "공지사항",
			editable : false
		}, {
			dataField : "CDISC_VER",
			headerText : "교육",
			editable : false
		}, {
			dataField : "CDISC_VER",
			headerText : "CDISC",
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
				if (event.dataField == "TASK_NO") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#frm_main #TASK_SN").val(rowItem.TASK_SN);
					$("#frm_main #CRUD").val("U");
					$("#frm_main").attr({
						action : './_EDCK0102.do',
						method : 'post'
					}).submit();
				} else if (event.dataField == "EDC_VER") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#frm_main #TASK_SN").val(rowItem.TASK_SN);
					$("#frm_main #TASK_NO").val(rowItem.TASK_NO);
					$("#frm_main #EDC_VER").val(rowItem.EDC_VER);
					var url = null;
					switch (rowItem.CRF_PROGRS_CODE) {
					case "":
						url = "/edc/k02/EDCK0202";
						break;
					case "01":
						url = "/edc/k02/EDCK0214";
						break;
					case "02":
						url = "/edc/k02/EDCK0203";
						break;
					case "03":
						url = "/edc/k02/EDCK0204";
						break;
					case "04":
						url = "/edc/k02/EDCK0207";
						break;
					case "05":
						url = "/edc/k02/EDCK0208";
						break;
					case "06":
						url = "/edc/k02/EDCK0209";
						break;
					case "07":
						url = "/edc/k02/EDCK0212";
						break;
					case "08":
						url = "/edc/k02/EDCK0202";
						break;
					case "09":
						url = "/edc/k02/EDCK0202";
						break;
					case "10":
						url = "/edc/k02/EDCK0202";
						break;
					}
					$("#frm_main").attr({
						action : url + '.do',
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
			$("#frm_search PAGE").val(goPage);
			fn_moveToPage(me, goPage, rowCount)
		}
	};

	function newDetail() {
		$("#frm_main #CRUD").val("C");
		$("#frm_main").attr({
			action : './_EDCK0102.do',
			method : 'post'
		}).submit();
	}
	function searchClick(page) {
		if (page == undefined) {
			page = 1;
		}

		$("#frm_search #PAGE").val(page);
		$("#frm_search #COUNT").val(EDCK0101_grid.div.paging.rowCount);
		var param = $("#frm_search").serialize();
		EDCK0101_grid.proxy.param = param;
		EDCK0101_grid.load();
	}
	$(document).ready(function() {
		EDCK0101_grid.createGrid();
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0101_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0101_grid.id);
		}
	};
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0101&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0101&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>과제등록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>과제관리</li>
						<li>과제등록</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">

				<div class="conBoxInner">


		            	<articla class="conTitBox">
		            		<h5>Study List</h5>
		            	</articla>

						<article class="mgT10" style="overflow:hidden;">
							<form id="frm_search" name="frm_search">
							<input type="hidden" id="PAGE" name="PAGE">
							<input type="hidden" id="COUNT" name="COUNT">
								<div class="conTitBtnL">
									<span style="font-family:'NanumGothicBold';">TASK_NO :</span>
									<input type="text" id="TASK_NO" name="TASK_NO" style="width:140px;">
									<span style="font-family:'NanumGothicBold';margin-left:30px;">TASK_NM :</span>
									<input type="text" id="TASK_NM" name="TASK_NM" style="width:140px;">
									<input type="button" class="btn mgL3" onclick="searchClick()" value="검색">
								</div>
								<div class="conTitBtnR">									
									<input type="button" onclick="newDetail()" value="신규">
								</div>
							</form>
						</article>


						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_SN }">
							<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
							<input type="hidden" id="CRUD" name="CRUD" value="U">
						</form>




						<article class="mgT16">
	                        <div id="EDCK0101_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                        <div id="EDCK0101_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>




				</div>
            </section>


		
			<section class="conBox100 conBox">
				
				<form>
					<div>
						<table>
							<tr>
								<th>내용</th>
								<td>
									<textarea rows="" id="" name=""></textarea>
								</td>
							</tr>
							<tr>
								<th>폰트</th>
								<td>
									<select id="" name=""></select>
								</td>
								<th>크기</th>
								<td>
									<select id="" name=""></select>
								</td>
								<th>링크</th>
								<td>
									<select id="" name=""></select>
								</td>
							</tr>
						</table>
						<table>
							<tbody>
								
							</tbody>
						</table>
					</div>
				</form>
		
		
				<form>
					<div>
						<table>
							<tr>
								<th>Variable</th>
								<td></td>
								<th>Query 형태</th>
								<td></td>
							</tr>
							<tr>
								<th>Query 내용</th>
								<td colspan="3"></td>
							</tr>
							<tr>
								<th>발행예외</th>
								<td colspan="3"></td>
								<td></td>
							</tr>
							<tr>
								<th>조건</th>
								<td colspan="3"></td>
								<td></td>
							</tr>
							<tr>
								<th>입력불가 Variable</th>
								<td colspan="3"></td>
								<td></td>
							</tr>
							<tr>
								<th>테스트</th>
								<td colspan="3"></td>
								<td></td>
							</tr>
						</table>
					</div>
				</form>
		


			</section>


		</div>
	</section>
</div>
</body>
</html>