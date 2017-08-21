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
	var gridUploadHistory = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridUploadHistory'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/c03/selectUploadHistory.do',
		 		param: {PRDUCT_CODE : $("#hdProductCode").val()},
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
				'showRowNumColumn' : true,
				reverseRowNum : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "PRDUCT_NM",
								headerText : "Product"
							}, {
								dataField : "SOURCE_TYPE",
								headerText : "Source Type"
							}, {
								dataField : "SOURCE_NO",
								headerText : "Source"
							}, {
								dataField : "ORGINL_FILE_NM",
								headerText : "File Name"
							}, {
								dataField : "",
								headerText : "Status"
							}, {
								dataField : "FRST_CREDE",
								headerText : "Inputted Time"
							}, {
								dataField : "MESSAGE",
								headerText : "Message"
							}, {
								dataField : "REGIST_ID",
								headerText : "User"
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
		 		me.proxy.param = {PRDUCT_CODE : $("#hdProductCode").val()};
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
			pageSetting();
			buttonActive();
			gridUploadHistory.createGrid();
		});
		
		function pageSetting(){
			$('#tabUpload').click(function(){
				window.location.href ="/sdb/c03/SDBC0301.do";
			});
			$('#tabHistory').click(function(){
				window.location.href ="/sdb/c03/SDBC0303.do";
			});
		}
				
		function buttonActive(){
			$("#btnProduct").click(function(){
				mkLayerPopupOpen("/sdb/b02/popupSDBB0204.do", null);
				if (typeof grProductList_Search.id !== "undefined") {
					AUIGrid.resize(grProductList_Search.id); 
				}
				return false;
			});
			
			$("#btnSearch").click(function(){
				gridUploadHistory.load();
			});
		}
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=SDBMENU_ID=SDBC0303&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0303&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>Upload History</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>유해정보등록</li>
							<li>대량Upload</li>
							<li>History</li>
						</ul>
					</nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<div class="button_tab_01">
							<ul>
								<li id="tabUpload" class="tab_menu">Upload</li>
								<li id="tabHistory" class="port_back tab_menu">History</li>
							</ul>
						</div>
						<article class="conTitBox">
							<label class="mgR5">Product</label>
							<input type="text" id="txtProductCode" class="pdR15" popup_type="ProductSearch" valireqire="PRODUCT" style="width:300px;" readonly>
							<input type="hidden" id="hdProductCode" />
							<button class="oneBtn" id="btnProduct" type="button">
								<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
							</button>
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnSearch" value="검색" />
						</article>
						<article class="mgT16">
							<div id="gridUploadHistory" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>