<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
		
	<script type="text/javascript">
	var grReportDelayList = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grReportDelayList',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grReportDelayList',
		 		paging: {
		 			pagingDiv: 'pgReportDelay',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/d02/selectReportDelayList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: true,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		paging : true,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "HRMFLNS_CASE_CODE",
								headerText : "Manufacturing NO.",
								width : 180
							}, {
								dataField : "PRDUCTNM",
								headerText : "Brand Name"
							}, {
								dataField : "ADVERSE_EVENT",
								headerText : "Advent Event"
							}, {
								dataField : "SERIUSFMNM_AT",
								headerText : "Seriousness"
							}, {
								dataField : "DELNGLN_NM",
								headerText : "보고기관"
							}, {
								dataField : "DELAY_DATE_CO",
								headerText : "지연날짜"
							}, {
								dataField : "REGIST_DTE",
								headerText : "접수일자",
						 		formatString : "yyyy-mm-dd",
						 		dataType:"date"
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
		 		
		 		//autoLoad로 처음 화면 데이터 로딩 
		 		if(me.proxy.paging && !v1 && !v2) {
		 			me.proxy.param.page = me.div.paging.currentPage;		
		 			me.proxy.param.count= me.div.paging.rowCount;		
		 		}
		 		
		 		//moveToPage 로 데이터 요청
		 		if(v1 && v2) {
		 			me.proxy.param.page = v2;	
		 			me.div.paging.currentPage = v2;
		 			me.proxy.param.count = v1;		
		 			me.div.paging.rowCount = v1;		
		 		}
		 		
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
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 			    	//샘플때문에 페이징 나타나게 하기위해 임의의 값 넣어줌 
//		  			    	data.count = 13;
//		  			    	console.log(data.count);
		 			    	//paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
		 			    	if(data.count && me.proxy.paging) {
		 			    		
		 			    		me.div.paging.totalRowCount = data.count;
		 			    		me.createPagingNavigator(me.div.paging.currentPage);
		 			    	}
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
// 		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	},
		 	//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		 	createPagingNavigator: function(goPage) {
		 		var me = this;
		 
		 		if(!me.div.paging.pagingDiv) { 
		 			return;
		 		}
		 		
		 		fn_createPagingNavigator(me, goPage);
		 	},
		 	//페이징 에서 어느 페이지로 갈 것인지 지정
		 	moveToPage: function(goPage, rowCount) {
		 		var me = this;
		 		
		 		if(!me.div.paging.pagingDiv) { 
		 			return;
		 		}
		 		
		 		fn_moveToPage(me, goPage, rowCount);
		 	}
		};
			
		$(function(){
			grReportDelayList.createGrid();
			buttonActive();
		});

		
		$(window).resize(function(){
			if(grReportDelayList.id){
				AUIGrid.resize(grReportDelayList.id);
			}
		});


		function buttonActive(){
			$("#btnSearch").click(function(){
				if($("#sltType option:selected").val()){
					var selected = $("#sltType option:selected").val();
					var params = {
						type : selected,
						value : $("#txtSearch").val()
					};
				}
				
				grReportDelayList.proxy.param = params;
				grReportDelayList.load();
			});
			
			
			$("#btnDown").click(function(){
				var data = AUIGrid.getGridData(grReportDelayList.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "Delivery_List"
					};
					AUIGrid.setProperty(grReportDelayList.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(grReportDelayList.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
		}
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBD0201&UPPER_MENU_ID=SDBD" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBD0201&UPPER_MENU_ID=SDBD" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.UPPER_MENU_NM}</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>${progrmMap.UPPER_MENU_NM}</li>
						</ul>
					</nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="conTitBox">
							<select id="sltType" style="width:150px;vertical-align: top;">
								<option value="">====선   택====</option>
								<option value="CASE">CASE</option>
								<option value="PRODUCT">PRODUCT</option>
								<option value="INSTT">보고기간</option>
							</select>
							<input type="text" id="txtSearch" />
							<input type="button" id="btnSearch" value="검색" />
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnDown" value="엑셀" />
						</article>
						<article class="mgT15">
							<div id="grReportDelayList" class="gridHeiSz14 grid_wrap tb01_2"></div>
							<div id="pgReportDelay" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>