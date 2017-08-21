<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>

<style>
.th_center_style{ text-align:center;}

.aui-grid-default-header{ text-indent: 0px;}
.aui-grid-default-header .aui-grid-renderer-base span:first-child{ line-height:14px; font-size:12px; display:inline-block; padding:6px 0 0 10px;}

.aui-grid-row-num-header{text-indent: 10px;}
</style>


	<script type="text/javascript">
		var gridLiterature = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grLiterature',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grLiterature'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/f02/selectLiterature.do',
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
				'editable': true,
				'showStateColumn': true,
				'showRowNumColumn' : false,
				'showRowCheckColumn' : true,
				softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    enableFilter : true,
			    headerHeight: 41,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "CMPNY_NM",
								headerText : "회사명<br>Name of<br>company",
								width : 90,
								filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "PRDUCT_NM",
								headerText : "제품명<br>Name of<br>product<span class='must_01'></span>",
								filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "KWRD",
								headerText : "키워드<br>Key<br>word<span class='must_01'></span>",
								filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "SEARCH_SITE",
								headerText : "검색 사이트<br>Website of<br>literature<br>searched",
								width : 110,
								filter : {
						 			showIcon : true
						 		}
							}, {
								headerText : "검색시행일<br>Date of Search",
								headerStyle : "th_center_style",
								children : [
								            	{
								            		dataField : "SEARCH_OPERTNDE_ONE",
								            		headerText : "PVA1", 
								            		dataType : "date",
								            		width : 100,
								            		formatString: "yyyy-mm-dd", 
								            		editRenderer: { type: "CalendarRenderer", showEditorBtnOver: true }
								            	},
								            	{
								            		dataField : "SEARCH_OPERTNDE_TWO",
								            		headerText : "PVA2", 
								            		dataType : "date",
								            		width : 100,
								            		formatString: "yyyy-mm-dd", 
								            		editRenderer: { type: "CalendarRenderer", showEditorBtnOver: true }
								            	}
								            ]
							}, {
								headerText : "검토논문개수<br>No. of Reviewed Paper",
								headerStyle : "th_center_style",
								children : [
								            	{
								            		dataField : "EXMNT_THESIS_CO_ONE",
								            		headerText : "PVA1", 
								            		editRenderer : { type: "InputEditRenderer",
							            							 onlyNumeric: true }
								            	},
								            	{
								            		dataField : "EXMNT_THESIS_CO_TWO",
								            		headerText : "PVA2", 
								            		editRenderer : { type: "InputEditRenderer",
				            							 			 onlyNumeric: true }
								            	}
								            ]
							}, {
								headerText : "보고논문개수<br>No. of Reportable Paper",
								headerStyle : "th_center_style",
								children : [
								            	{
								            		dataField : "REPORT_THESIS_CO_ONE",
								            		headerText : "PVA1", 
								            		editRenderer : { type: "InputEditRenderer",
				            							 			 onlyNumeric: true }
								            	},
								            	{
								            		dataField : "REPORT_THESIS_CO_TWO",
								            		headerText : "PVA2", 
								            		editRenderer : { type: "InputEditRenderer",
				            							 			 onlyNumeric: true }
								            	}
								            ]
							}, {
								headerText : "보고건수<br>Reportable cases",
								headerStyle : "th_center_style",
								children : [
								            	{
								            		dataField : "REPORT_NUM_ONE",
								            		headerText : "PVA1", 
								            		editRenderer : { type: "InputEditRenderer",
				            							 			 onlyNumeric: true }
								            	},
								            	{
								            		dataField : "REPORT_NUM_TWO",
								            		headerText : "PVA2", 
								            		editRenderer : { type: "InputEditRenderer",
				            							 			 onlyNumeric: true }
								            	}
								            ]
							}, {
								dataField : "THESISURL",
								headerText : "논문 URL",
								width : 120,
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
		 		    data: {  },
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
			initPageSetting();
			buttonActive();
		});
		
		function initPageSetting(){
			gridLiterature.createGrid();
		}
		
		function buttonActive(){
			$("#btnInit").click(function(){
				initGridRow();
			});
			
			$("#btnSave").click(function(){
				saveLiterature();
			});
			
			$("#btnAdd").click(function(){
				var row = {
						'LTRTRE_SEARCH_SN': '',
						'CMPNY_NM': '',
						'PRDUCT_NM': '',
						'KWRD': '',
						'SEARCH_SITE': '',
						'SEARCH_OPERTNDE_ONE': '',
						'SEARCH_OPERTNDE_TWO': '',
						'EXMNT_THESIS_CO_ONE': '',
						'EXMNT_THESIS_CO_TWO': '',
						'REPORT_THESIS_CO_ONE': '',
						'REPORT_THESIS_CO_TWO': '',
						'REPORT_NUM_ONE': '',
						'REPORT_NUM_TWO': '',
						'THESISURL': '',
						'CRUD' : 'C'
				};
				AUIGrid.addRow(gridLiterature.id, row, 'first'); // 최하단에 행 추가
			});
			
			$("#btnDelete").click(function(){
				AUIGrid.removeCheckedRows(gridLiterature.id);
			});
		}
		
		function initGridRow(){
			var row = {
					'LTRTRE_SEARCH_SN': '',
					'CMPNY_NM': '',
					'PRDUCT_NM': '',
					'KWRD': '',
					'SEARCH_SITE': '',
					'SEARCH_OPERTNDE_ONE': '',
					'SEARCH_OPERTNDE_TWO': '',
					'EXMNT_THESIS_CO_ONE': '',
					'EXMNT_THESIS_CO_TWO': '',
					'REPORT_THESIS_CO_ONE': '',
					'REPORT_THESIS_CO_TWO': '',
					'REPORT_NUM_ONE': '',
					'REPORT_NUM_TWO': '',
					'THESISURL': ''
			};
			AUIGrid.updateRow(gridLiterature.id, row, "selectedIndex");
		}
		
		function saveLiterature(){
			var addedRowItems = AUIGrid.getAddedRowItems(gridLiterature.id);
			var editedRowItems = AUIGrid.getEditedRowItems(gridLiterature.id);
			var deletedRowItems = AUIGrid.getRemovedItems(gridLiterature.id);
		
			for(var i = 0; i < addedRowItems.length; i++){
				if(addedRowItems[i]["PRDUCT_NM"].trim() == ""){
					alert("제품명을 입력하십시오.");
					AUIGrid.setSelectionByIndex(gridLiterature.id, i, 1);
					return;
				}
				if(addedRowItems[i]["KWRD"].trim() == ""){
					alert("키워드를 입력하십시오.");
					AUIGrid.setSelectionByIndex(gridLiterature.id, i, 2);
					return;
				}
			}
			
			for(var i = 0; i < editedRowItems.length; i++){
				if(editedRowItems[i]["PRDUCT_NM"].trim() == ""){
					alert("제품명을 입력하십시오.");
					AUIGrid.setSelectionByIndex(gridLiterature.id, i, 1);
					return;
				}
				if(editedRowItems[i]["KWRD"].trim() == ""){
					alert("키워드를 입력하십시오.");
					AUIGrid.setSelectionByIndex(gridLiterature.id, i, 2);
					return;
				}
			}
			console.log(deletedRowItems)
			var param = [{
					ADDED : addedRowItems,
					EDITED : editedRowItems,
					DELETED : deletedRowItems
			}];
			
			$.ajax({
				type : "POST",
				async : false,
				data : {data : JSON.stringify(param) },
				url : "/sdb/f02/insertLiterature.do",
				success :function(data){
					if(data.result == true){
						alert(data.message);
						gridLiterature.load();
					}else{
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
		
		
		
		$(window).resize(function(){
			if(gridLiterature.id){
				AUIGrid.resize(gridLiterature.id);
			}
		});
		
	</script>
</head>
<body>
<div id="wrap">
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBF0201&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBF0201&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>	
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
						<h5>문헌검색</h5>
					</article>
					<article class="conTitBtnR">
						<input type="button" id="btnInit" value="초기화" />
						<input type="button" id="btnSave" value="저장" />
						<input type="button" id="btnAdd" value="행추가" />
						<input type="button" id="btnDelete" value="행삭제" />
					</article>
					<article class="mgT16">
						<div id="grLiterature" class="gridHeiSz15 grid_wrap tb01_2"></div>
					</article>
				</div>
			</section>
		</div>
	</section>
</div>
</body>
</html>