<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title>Subject 목록</title>
<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>
<script type="text/javascript">
	var EDCC0101_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCC0101_grid',
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectEdcSubjectList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging: false,
		    autoLoad: true,
		},
		//AUI 그리드 옵션
		gridPros : {
			usePaging : true,
		    
		    showRowNumColumn : true,
		    showRowCheckColumn : true,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : false,
		    enableFilter : true,
		    showPageButtonCount : 5,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows",
		    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃 RNUM
		columnLayout : [ {
			dataField : "NAME1",
			headerText : "Site",
			// width : 120,
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "SUBJECT_NO",
			headerText : "Subject No",
			// width : 100,
			editable : false,
			style : "edc_column_style",
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "INSTT_FORM_SN",
			headerText : "INSTT_FORM_SN",
			width: 0,
			editable : false,
			visible : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "SUBJECT_INITIAL",
			headerText : "이니셜",
			// width: 150,
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "STRE_STTUS_CODE",
			headerText : "상태",
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "DOCMNT_AGRE_DE",
			headerText : "동의일",
			formatString : "yyyy-mm-dd",
			dataType:"date",
			// width: 200,
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "FRST_CREDE",
			headerText : "등록일",
			formatString : "yyyy-mm-dd",
			dataType:"date",
			// width: 204,
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "OPEN_QUERY",
			headerText : "오픈쿼리",
			// width: 140,
			dataType:"date",
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "ELTSGN_STTUS_CODE",
			headerText : "최종 전자서명",
			// width: 60,
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "SDV_STTUS_CODE",
			headerText : "SDV",
			// width: 60,
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "SDV_COMPT_STTUS_CODE",
			headerText : "SDV 완료 상태",
			// width: 60,
			editable : false,
		    filter : {
		    	showIcon : true
		    }
		},{
			dataField : "FREEZING_STTUS_CODE",
			headerText : "Freezing",
			width: 60,
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
				if (event.dataField == "SUBJECT_NO") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#subjectNo").val(rowItem.SUBJECT_NO);
					$("#searchForm").attr({
						action : './EDCC0102.do',
						method : 'post'
					}).submit();
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function fnInsert() {
		$("#crud").val("C");
		$("#searchForm").attr({
			action : './EDCC0104.do',
			method : 'post'
		}).submit();
	}
	function searchClick(page) {

 		var param = $("#searchForm").serialize();
 		EDCC0101_grid.proxy.param = param;
 		EDCC0101_grid.load();
	}
	$(document).ready(function() {
		EDCC0101_grid.createGrid();
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCC0101_grid.id !== "undefined") {
			AUIGrid.resize(EDCC0101_grid.id);
		}
	};
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0101&&UPPER_MENU_ID=EDCC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0101&&UPPER_MENU_ID=EDCC" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Subject 목록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Subject</li>
						<li>Subject 목록</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner">
					<form name="searchForm" id="searchForm">
					<input type="hidden" id="crud" name="crud" value="">
					<input type="hidden" id="subjectNo" name="subjectNo" value="">
						<article class="mgT10" style="overflow:hidden;">
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold';">Site</span>
								<input type="text" id="INSTT_NM" name="INSTT_NM" style="width: 140px;">
								<span style="font-family:'NanumGothicBold'; margin-left: 20px;">Subject</span>
								<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" style="width: 140px;">
								<button class="oneBtn" popup_type="ProductSearch" type="button" onclick="searchClick()">
										<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
							</div>
							<div class="conTitBtnR">									
								<input type="button" value="Patient 등록"" onclick="fnInsert()">
								<input type="button" value="연구 종료 요청" onclick="fn_upSave()">
								<input type="button" value="설정" onclick="fn_upSave()">
							</div>
						</article>

						<article class="mgT16">
	                        <div id="EDCC0101_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
						</article>

					</form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>
</html>