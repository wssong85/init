<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	
	<script type="text/javascript">
		var grFactoryInvenSummary = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grFactoryInvenSummary',
		 		paging: {
		 			pagingDiv: 'pgFactoryInven',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/d04/selectFactoryInventorySummary.do',
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
				'showRowCheckColumn' : false,
				enableFilter : true,
				showFooter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "CREAT_CODE",
								headerText : "CREAT_CODE",
								visible : false
							}, {
								dataField : "TASK_CODE",
								headerText : "TASK_CODE",
								visible : false
							}, {
								dataField : "IP_TYPE",
								headerText : "IP TYPE",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "STTUS03",
								headerText : "배송"
							}, {
								dataField : "STTUS01",
								headerText : "재고"
							}, {
								dataField : "STTUS02",
								headerText : "배송대기"
							}, {
								dataField : "STTUS04",
								headerText : "불출대기"
							}, {
								dataField : "STTUS05",
								headerText : "불출"
							}, {
								dataField : "STTUS06",
								headerText : "오류"
							}, {
								dataField : "STTUS08",
								headerText : "QC"
							}
						],
			footerLayout : [{
								labelText : "합계",
								positionField : "IP_TYPE"
							}, {
								dataField : "STTUS03",
								positionField : "STTUS03",
								operation : "SUM",
								formatString : "#,##0"
							}, {
								dataField : "STTUS01",
								positionField : "STTUS01",
								operation : "SUM",
								formatString : "#,##0"
							}, {
								dataField : "STTUS02",
								positionField : "STTUS02",
								operation : "SUM",
								formatString : "#,##0"
							}, {
								dataField : "STTUS03",
								positionField : "STTUS03",
								operation : "SUM",
								formatString : "#,##0"
							}, {
								dataField : "STTUS04",
								positionField : "STTUS04",
								operation : "SUM",
								formatString : "#,##0"
							}, {
								dataField : "STTUS05",
								positionField : "STTUS05",
								operation : "SUM",
								formatString : "#,##0"
							}, {
								dataField : "STTUS06",
								positionField : "STTUS06",
								operation : "SUM",
								formatString : "#,##0"
							}, {
								dataField : "STTUS08",
								positionField : "STTUS08",
								operation : "SUM",
								formatString : "#,##0"
							}
			            ],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);

		 		AUIGrid.setFooter(me.id, me.footerLayout);
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
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 2);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
						
					}
		 		});
		 	}
		};
		
		$(function(){
			buttonActive();
			grFactoryInvenSummary.createGrid();
		});
		
		function buttonActive(){
			$("#btnDown").click(function(){
				var data = AUIGrid.getGridData(grFactoryInvenSummary.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "Delivery_List"
					};
					AUIGrid.setProperty(grFactoryInvenSummary.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(grFactoryInvenSummary.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
		}
						
		window.onresize = function() {
			if (typeof grFactoryInven.id !== "undefined") {
				AUIGrid.resize(grFactoryInvenSummary.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRD0403&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRD0403&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
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
							<div id="grFactoryInvenSummary" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>