<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<script type="text/javascript">
var grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : 'grid_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		
		//데이터 연계 옵션
		proxy : {
			url : './selectAeList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : true,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow"
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "NAME1",
			headerText : "Site",
			width : 120,
			editable : false
		}, {
			dataField : "SUBJECT_NO",
			headerText : "Subject",
			width: 80,
			editable : false
		}, {
			dataField : "ROW_NO",
			headerText : "No",
			width: 80,
			editable : false
		}, {
			dataField : "VAR1",
			headerText : "증상 및 증후",
			width: 120,
			editable : false
		}, {
			dataField : "VAR2",
			headerText : "발현일",
			width: 80,
			editable : false
		}, {
			dataField : "VAR3",
			headerText : "종료일",
			width: 80,
			editable : false
		}, {
			dataField : "VAR4",
			headerText : "경과",
			width: 100,
			editable : false
		},{
			dataField : "VAR5",
			headerText : "중증도",
			width: 100,
			editable : false
		},{
			dataField : "VAR6",
			headerText : "인과관계",
			width: 100,
			editable : false
		},{
			dataField : "VAR7",
			headerText : "IP에 대한 조치",
			width: 100,
			editable : false
		},{
			dataField : "VAR8",
			headerText : "그외 조치",
			width: 100,
			editable : false
		},{
			dataField : "VAR9",
			headerText : "결과",
			width: 100,
			editable : false
		} ],
		
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;
			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			//autoLoad로 처음 화면 데이터 로딩 
			if (me.proxy.paging && !v1 && !v2) {
				me.proxy.param.page = me.div.paging.currentPage;
				me.proxy.param.count = me.div.paging.rowCount;
			}
			//moveToPage 로 데이터 요청
			if (v1 && v2) {
				me.proxy.param.page = v2;
				me.div.paging.currentPage = v2;
				me.proxy.param.count = v1;
				me.div.paging.rowCount = v1;
			}
			AUIGrid.showAjaxLoader(me.id);
			$.ajax({
				url : me.proxy.url,
				type : me.proxy.type,
				dataType : me.proxy.dataType,
				data : me.proxy.param,
				success : function(data) {
					if (data.success) {
						AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						AUIGrid.setSelectionByIndex(me.id, 0);
						//샘플때문에 페이징 나타나게 하기위해 임의의 값 넣어줌 
						data.count = 13;
						if (data.count && me.proxy.paging) {
							me.div.paging.totalRowCount = data.count;
							me.createPagingNavigator(me.div.paging.currentPage);
						}
					} else {
						AUIGrid.removeAjaxLoader(me.id);
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		},
		//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		createPagingNavigator : function(goPage) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			me.div.paging.totalPage = Math.ceil(me.div.paging.totalRowCount / me.div.paging.rowCount);
			var prevPage = parseInt((goPage - 1) / me.div.paging.pageButtonCount) * me.div.paging.pageButtonCount;
			var nextPage = ((parseInt((goPage - 1) / me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount + 1;
			prevPage = Math.max(0, prevPage);
			nextPage = Math.min(nextPage, me.div.paging.totalPage);
			document.getElementById(me.div.paging.pagingDiv).innerHTML = makePaging("grid", me, goPage);
		},
		//페이징 에서 어느 페이지로 갈 것인지 지정
		moveToPage : function(goPage, rowCount) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			// 현재 페이지 보관
			me.div.paging.currentPage = goPage;
			// selectBox에서 요청시, 1페이지부터 시작
			if (rowCount) {
				me.div.paging.rowCount = rowCount;
				me.div.paging.currentPage = 1;
				goPage = 1;
			}
			me.load(me.div.paging.rowCount, goPage);
		}
	};

	$(document).ready(function() {
		grid.createGrid();
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof grid.id !== "undefined") {
			AUIGrid.resize(grid.id);
		}
	};
	
	function getGridData(){
		var paramData = new Object();
		paramData.subjectNo = $("#subjectNo").val();
		paramData.name = $("#name").val();
		
		grid.proxy.param = paramData;
		grid.load();
	}

</script>
</head>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCJ0301&&UPPER_MENU_ID=EDCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCJ0301&&UPPER_MENU_ID=EDCJ" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
		<form name="searchForm" id="searchForm">
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">
                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>AE list</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드  상단메뉴라인 시작-->        
                    <article class="conTitBtn">
                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                        	Site : <input type="text" name="name" id="name" value="" class="pdR15"> Subject : <input type="text" name="subjectNo" id="subjectNo" value="" class="pdR15">
							<input type="button" class="btn mgL3" onclick="getGridData()" value="검색"> 
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->
                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    <!-- 그리드 끝 -->
                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
        </form>
    	</div>
	</section>
</div>
</body>
</html>
