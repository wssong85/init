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
	var gridNotification = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'gridNotification',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridNotification'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/a01/selectNotification.do',
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
				selectionMode: 'singleRow',
				editable: false,
				showStateColumn: false,
				showRowNumColumn : true,
				reverseRowNum : true,
				enableFilter : false,
				pageRowCount : 5,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "FRST_CREAT_DE",
								headerText : "일자",
								formatString : "yyyy-mm-dd",
						 		dataType:"date",
								width:140
							}, {
								dataField : "SJ",
								headerText : "제목",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "　";
									var template = "";
									template = '<a href="#" onclick="javascript:popupNotification(\'' + item.SN + '\');return false;">' + value + '</a>';
									return template;
								}
							}, {
								dataField : "FRST_CRTR",
								headerText : "작성자",
								width:150
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
			gridNotification.createGrid();
		});
		
		function buttonActive(){
			$("#btnMore").click(function(){
				
			});
		}
		
		function popupNotification(sn){
			alert("팝업은 CTMS 팝업 완성 후 연결");
		}
		
		window.onresize = function() {
			if (typeof gridNotification.id !== "undefined") {
				AUIGrid.resize(gridNotification.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRA0101&UPPER_MENU_ID=IWRA" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRA0101&UPPER_MENU_ID=IWRA" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="conTitBox">
	                        <h5>공지사항</h5>
	                    </article>
	                    <article class="mgT16">
	                        <div id="gridNotification" class="gridHeiSz05 grid_wrap tb01_2"></div>
	                    </article>
					</div>
				</section>
				<section class="conBox100 conBox">
	                <div class="conBoxInner">
	                    <article class="conTitBox">
	                         <h5>Summary</h5>
	                    </article>
	                    <article class="mgT16">
	                        <div id="" class="gridHeiSz05 grid_wrap tb01_2"></div>
	                    </article>
	                </div>
	            </section>
			</div>
		</section>
	</div>
</body>
</html>