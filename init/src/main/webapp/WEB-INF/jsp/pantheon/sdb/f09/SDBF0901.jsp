<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
		
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
	<script type="text/javascript">
		var gridSopSetting = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grSopSetting',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grSopSetting',
		 		paging: {
		 			pagingDiv: 'grid_paging',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/f09/selectSopInfo.do',
		 		param: {UPPER_SN : $("#sltPart option:selected").val()},
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
				'editable': true,
				'showStateColumn': true,
				'showRowNumColumn' : false,
				'showRowCheckColumn' : true,
				softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
				//wordWrap : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "QESTN_SN",
								headerText : "항목<span class='must_01'>",
								width : 64,
								dataType : "numeric"
							}, {
								dataField : "QESTN_CN",
								headerText : "항목내용<span class='must_01'>"
							}, {
								dataField : "SN",
								headerText : "SN",
								visible : false
							}, {
								dataField : "SE_CODE",
								headerText : "SE_CODE",
								visible : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.proxy.param = {SE_CODE : $("#sltPart option:selected").val()};
		 		
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
// 		 		AUIGrid.bind(me.id, "cellClick", auiGridCellClickHandler);
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
		 		    data: {UPPER_SN : $("#sltPart option:selected").val()},
		 		    success:function(data){
		 		    	if(data.result == "true") {
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

		 					$(".aui-grid-paging-panel").hide();
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
		 	},
		 	//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		 	createPagingNavigator: function(goPage) {
		 		var me = this;
		 
		 		if(!me.div.paging.pagingDiv) { 
		 			return;
		 		}
		 		
		 		me.div.paging.totalPage = Math.ceil(me.div.paging.totalRowCount/me.div.paging.rowCount);
		 		
		 		var retStr = "";
		 		var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * me.div.paging.pageButtonCount;
		 		var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount + 1;
		 
		 		prevPage = Math.max(0, prevPage);
		 		nextPage = Math.min(nextPage, me.div.paging.totalPage);
		 		
		 		//셀렉트박스
		 		retStr += "<select style='float:left;' onchange='javascript:gridDelivery.moveToPage(gridDelivery.div.paging.currentPage, this.value)'>"
		 		if(gridDelivery.div.paging.rowCount == 20) {
		 			retStr += "<option value=20 selected=true>20</option>"
		 		} else {
		 			retStr += "<option value=20>20</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 50) {
		 			retStr += "<option value=50 selected=true>50</option>"
		 		} else {
		 			retStr += "<option value=50>50</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 100) {
		 			retStr += "<option value=100 selected=true>100</option>"
		 		} else {
		 			retStr += "<option value=100>100</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 300) {
		 			retStr += "<option value=300 selected=true>300</option>"
		 		} else {
		 			retStr += "<option value=300>300</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 500) {
		 			retStr += "<option value=500 selected=true>500</option>"
		 		} else {
		 			retStr += "<option value=500>500</option>"
		 		}
		 		retStr += "</select>"
		 				 
		 		//$(".aui-grid-paging-panel").append(retStr);
		 		//document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
		 	}
		};
	
		$(function(){
			initPageSetting();
			buttonActive();
			selectBoxActive();
		});
		
		function initPageSetting(){
			<c:forEach var="result" items="${part}" varStatus="status">
				$("#sltPart").append("<option value='<c:out value="${result.QESTN_SN}"/>'>" + '<c:out value="${result.QESTN_CN}"/>' + "</option>");
			</c:forEach>
			
			gridSopSetting.createGrid();
		}
		
		function selectBoxActive(){
			$("#sltPart").change(function(){
				gridSopSetting.load();
			});
		}
		
		function buttonActive(){
			$("#btnSave").click(function(){
				saveSopInfo();
			});
			
			$("#btnDelete").click(function(){
				deleteSopInfo();
			});
			
			$("#btnAdd").click(function(){
				addGridAddRow();
			});
		}
		
		function addGridAddRow(){
			 var row = {
						'QESTN_SN': AUIGrid.getRowCount(gridSopSetting.id) + 1,
						'QESTN_CN': '',
						'SN': '',
						'CRUD' : 'C'
				};
			AUIGrid.addRow(gridSopSetting.id, row, 'first'); // 최하단에 행 추가
		}
		
		function saveSopInfo(){
			if(!window.confirm("저장하시겠습니까?")){
				return;
			}
			
			var items = AUIGrid.getGridData(gridSopSetting.id);
			for(var i = 0; i < items.length; i++){
				for(var j = 0; j < items.length; j++){
					if(i != j){
						if(items[i]["QESTN_SN"] == items[j]["QESTN_SN"]){
							alert("항목이 중복되었습니다.");
							return;
						}
					}
				}
				if(items[i]["QESTN_CN"].trim() == ""){
					alert("항목내용을 입력하십시오.");
					return;
				}
			}
			
			var addedRowItems = AUIGrid.getAddedRowItems(gridSopSetting.id);
			var editedRowItems = AUIGrid.getEditedRowItems(gridSopSetting.id);
			var deletedRowItems = AUIGrid.getRemovedItems(gridSopSetting.id);
			
			var param = [{
				SE_CODE : "03",
				UPPER_SN : $("#sltPart option:selected").val(),
				ADDDATA : addedRowItems,
				EDITDATA : editedRowItems,
				DELDATA : deletedRowItems
			}];
			
			$.ajax({
				type : "POST",
				async : false,
				data : {data : JSON.stringify(param) },
				url : "/sdb/f09/insertSopInfo.do",
				success :function(data){
					if(data.result == "true"){
						alert(data.message);
						gridSopSetting.load();
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		function deleteSopInfo(){
			if(!window.confirm("삭제하시겠습니까?")){
				return;
			}
			var deletedRowItems = AUIGrid.getCheckedRowItems(gridSopSetting.id);
			
			if(deletedRowItems.length <= 0){
				alert("삭제할 행을 선택하십시오.");
				return;
			}
			AUIGrid.removeCheckedRows(gridSopSetting.id);
			
// 			var param = [{
// 				SE_CODE : '03',
// 				UPPER_SN : $("#sltPart option:selected").val(),
// 				DELDATA : deletedRowItems
// 			}];
			
// 			$.ajax({
// 				type : "POST",
// 				async : false,
// 				data : {data : JSON.stringify(param) },
// 				url : "/sdb/f09/deleteSopInfo.do",
// 				success :function(data){
// 					if(data.result == "true"){
// 						alert(data.message);
// 						gridSopSetting.load();
// 					}else{
// 						alert(data.message);
// 					}
// 				}
// 			});
		}
		
		
		


		$(window).resize(function(){
			if(gridSopSetting.id){
				AUIGrid.resize(gridSopSetting.id);
			}
		});
	</script>
</head>
<body>
<div id="wrap">
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBF0901&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBF0901&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>	
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
					<select id="sltPart">
					</select>
				</article>
				<article class="conTitBtnR">
					<input type="button" id="btnSave" value="저장" />
					<input type="button" id="btnDelete" value="행삭제" />
					<input type="button" id="btnAdd" value="행추가" />
				</article>
				<article class="mgT16">
					<div id="grSopSetting" class="gridHeiSz15 grid_wrap tb01_2"></div>
				</article>
			</div>
		</section>
	</div>
	</section>
</div>
</body>
</html>