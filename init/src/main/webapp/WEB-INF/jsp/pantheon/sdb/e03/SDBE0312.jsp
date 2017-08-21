<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<style>
		.grid_wrap a{color: #5570e6 !important; text-decoration:underline; font-weight: bold;}
		.grid_wrap a:hover{color: #5570e6 !important; text-decoration:underline; cursor:pointer;}
	</style>
	<script type="text/javascript">
	var gridQuery = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'gridQuery',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridQuery',
		 		paging: {
		 			pagingDiv: 'pgQuery',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		}
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/e03/selectQueryList.do',
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
		 		usePaging : true,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : false,
				'showRowCheckColumn' : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "PRDUCT_CODE",
								headerText : "제품",
								visible : false
							}, {
								dataField : "PRDUCT_NM",
								headerText : "제품"
							}, {
								dataField : "PROGRM_ID",
								headerText : "프로그램",
								visible : false
							}, {
								dataField : "PROGRM_NM",
								headerText : "프로그램"
							}, {
								dataField : "SE_NO",
								headerText : "Group"
							}, {
								dataField : "COLUMNNM",
								headerText : "Variable"
							}, {
								dataField : "PBLSHR_ID",
								headerText : "발행자"
							}, {
								dataField : "PBLICTE_DT",
								headerText : "발행일",
								dataType : "date",
								formatString : "yyyy-mm-dd"
							}, {
								dataField : "QUERY_STTUS_CODE",
								headerText : "상태"
							}, {
								dataField : "QUERY_TY_CODE",
								headerText : "구분"
							}, {
								dataField : "QUERY_SN",
								headerText : "Query ID"
							}, {
								dataField : "QUERY_CN",
								headerText : "Query"
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
		 		    	if(data.result) {
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
			buttonActive();
			gridQuery.createGrid();
		});
		
		var querySn = "";
		function buttonActive(){
			$("#btnIpDeliDoc").click(function(){
				var activeItems = AUIGrid.getCheckedRowItems(gridQuery.id);
				if(activeItems.length == 0){
					alert("체크한 항목이 없습니다.");
					return;
				}
				for(var i = 0; i < activeItems.length; i++){
					if(activeItems[i].item.QUERY_STTUS_CODE == "03"){
						alert("이미 종료된 쿼리입니다.");
						return;
					}
				}
				var query_sn = [];
				for(var i = 0; i < activeItems.length; i++) {
					query_sn.push( activeItems[i].item.QUERY_SN );
				}
				querySn = query_sn.join(",");
				
				var param = {
						callbackFunction : "endQuery",
						QUERY_NO : querySn
					};
				
				mkLayerPopupOpen("/iwrs/f01/popupIwrf0102.do", param);
			});
		}
		
		function endQuery(value){
			var param = {
					QUERY_NO : value.QUERY_NO,
					QUERY_STTUS_CODE : "03",
					RESN : value.RESN
			};
// 			console.log(param);
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : '/sdb/e03/updateQueryEndInfo.do',
				success :function(data){
					if(data.result){
						alert(data.message);
						gridQuery.load();
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBE0312&UPPER_MENU_ID=SDBE" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBE0312&UPPER_MENU_ID=SDBE" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>Query 현황</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>Query</li>
							<li>Query 현황</li>
						</ul>
					</nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="conTitBox">
<!-- 							<h5>배송현황</h5> -->
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnIpDeliDoc" value="일괄종료" />
						</article>
						<article class="mgT16">
							<div id="gridQuery" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>