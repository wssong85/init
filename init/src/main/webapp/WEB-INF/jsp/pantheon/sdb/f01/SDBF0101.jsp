<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>

<style>
.sdbf_column_style {color: #5570e6; text-decoration:underline; font-weight: bold;}
.sdbf_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>

	<script type="text/javascript">

		var gridQCResultReport = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grQCResultReport',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grQCResultReport',
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
		 		url: '/sdb/f01/selectQcResultReportList.do',
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
		 		usePaging : true,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "QC_REPRT_NO",
								headerText : "QC보고서 No",
								width : 200,
								//style : "sdbf_column_style",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "　";
									var template = '<a href="#" class="sdbf_column_style" onclick="javascript:goQcResultReporter(\'' + item.PRDUCT_CODE + '\', \'' + value + '\', \'' + item.QC_REPRT_NO + '\');return false;">' + value + '</a>';
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								dataField : "PRDUCT_CODE",
								headerText : "Brand name",
								visible : false
							}, {
								dataField : "PRDUCT_NAME",
								headerText : "Brand name",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "　";
									var template = '<a href="#" onclick="javascript:goInsertProduct(\'' + item.PRDUCT_CODE + '\');return false;">' + value + '</a>';
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								dataField : "SAFE_MANAGE_CHRGDEPT_CHARGER",
								headerText : "안전관리담당자"
							}, {
								dataField : "QLMNGMT_OPRTNDE",
								headerText : "품질관리실시일",
								formatString : "yyyy-mm-dd",
						 		dataType:"date"
							}, {
								dataField : "QLMNGMT_CHARGER",
								headerText : "품질관리담당자"
							}, {
								dataField : "FRST_CREDE",
								headerText : "등록일",
								formatString : "yyyy-mm-dd",
						 		dataType:"date"
							}, {
								dataField : "SFMNGCHRG_DPRLR_SANCTNDE",
								headerText : "결재일",
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
		 		    data: { START_DATE : $("#txtStartDate").val().replace(/-/g, ""), END_DATE : $("#txtEndDate").val().replace(/-/g, "") },
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
		 				 
		 		$(".aui-grid-paging-panel").append(retStr);
		 		//document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
		 	}
		};
	
		$(function(){
			initPageSetting();
			buttonActive();
		});
		
		function initPageSetting(){
			mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -60, 0);
			gridQCResultReport.createGrid();
		}
		
		function buttonActive(){
			$("#btnCreate").click(function(){
				goQcResultReporter()
			});
			
			$("#btnSearch").click(function(){
				gridQCResultReport.load();
			});
			
			$("#btnDown").click(function(){
				var data = AUIGrid.getGridData(gridQCResultReport.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "QCReport_List"
					};
					AUIGrid.setProperty(gridQCResultReport.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(gridQCResultReport.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
		}
		
		function goQcResultReporter(prductCode, qcReprtNo){
			var f = document.createElement("form");
			
			if(prductCode == null || prductCode == undefined) prductCode = "";
			if(qcReprtNo == null || qcReprtNo == undefined) qcReprtNo = "";
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "PRDUCT_CODE");
			obj.setAttribute("value", prductCode);
			f.appendChild(obj);
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "QC_REPRT_NO");
			obj.setAttribute("value", qcReprtNo);
			f.appendChild(obj); 
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/sdb/f01/SDBF0102.do");
			document.body.appendChild(f);
			f.submit();
		}
		
		function goInsertProduct(productCode){
			alert("추후개발");
		}
		
		$(window).resize(function(){
		  if (gridQCResultReport.id) {
		    AUIGrid.resize(gridQCResultReport.id);
		    }
		});
		
	</script>
</head>
<body>
<div id="wrap">
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBF0101&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBF0101&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>	
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
					<span style="font-family:'NanumGothicBold';">등록일 :</span>
					<div class="dateBox">
						<input type="text" id="txtStartDate" style="width:114px;"/>
					</div>
					 ~ 
					<div class="dateBox">
						<input type="text" id="txtEndDate" style="width:114px;"/>
					</div>
				</article>
				<article class="conTitBtnR">
					<input type="button" id="btnCreate" value="QC보고서 생성" />
					<input type="button" id="btnSearch" value="검색" />
					<input type="button" id="btnDown" value="엑셀" />
				</article>
				<article class="mgT15">
					<div id="grQCResultReport" class="gridHeiSz15 grid_wrap tb01_2"></div>
				</article>
			</div>
		</section>
	</div>
	</section>
</div>
</body>
</html>