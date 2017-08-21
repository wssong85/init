<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	
	<script type="text/javascript">
		var gridDrugStock = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grErrorLog',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grErrorLog',
		 		paging: {
		 			pagingDiv: '',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/d03/selectErrorLog.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : false,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "INSTT_NM",
								headerText : "Site",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_ERROR_REGISTER_ID",
								headerText : "등록자",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "SUBJECT_CODE",
								headerText : "스크리닝 번호",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "VISIT_CODE",
								headerText : "방문",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_CODE",
								headerText : "오류IP",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_ERROR_CODE",
								headerText : "상태",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_ERROR_COMMENT",
								headerText : "코멘트",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "LAST_UPDDE",
								headerText : "오류기록시간",
						 		filter : {
						 			showIcon : true
						 		}
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 		
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 		
		 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result == "ok") {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
		
		$(function(){
			gridDrugStock.createGrid();
			
			buttonActive();
		});
		
		function buttonActive(){
			$("#btnDown").click(function(){
				var data = AUIGrid.getGridData(gridDrugStock.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "Delivery_List"
					};
					AUIGrid.setProperty(gridDrugStock.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(gridDrugStock.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
		}
		
		function pageLink(insttCode, ipType, viewType){
			alert("추후개발");
		}
		
		window.onresize = function() {
			if (typeof gridDrugStock.id !== "undefined") {
				AUIGrid.resize(gridDrugStock.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRD0301&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRD0301&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>${progrmMap.UPPER_MENU_NM}</li>
	                        <li>${progrmMap.MENU_NM}</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="conTitBox">
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnDown" value="엑셀" />
						</article>
						<article class="mgT15">
							<div id="grErrorLog" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>