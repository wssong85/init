<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		 	id: 'grDrugStock',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grDrugStock',
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
		 		url: '/iwrs/d02/selectDrugStock.do',
		 		param: { instt_code : $("#sltSite option:selected").val()},
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
								dataField : "INSTT_CODE",
								headerText : "Site",
						 		visible : false
							}, {
								dataField : "INSTT_NAME",
								headerText : "Site",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_TYPE",
								headerText : "IP Type",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_CODE",
								headerText : "IP Code",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_STTUS_CODE",
								headerText : "상태",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "WRHOUSNGDE",
								headerText : "입고일",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "MNFCTURNO",
								headerText : "제조번호",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "VALIDPD",
								headerText : "사용(유효)기간",
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
		 		    data: {instt_code : $("#sltSite option:selected").val()},
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
			<c:forEach var="result" items="${insttlist}" varStatus="status">
				$("#sltSite").append("<option value='<c:out value="${result.INSTT_CODE}"/>'>" + '<c:out value="${result.NAME1}"/>' + "</option>");
			</c:forEach>
			
			if("${role}" == "PHARM"){
				$("#sltSite").val("${insttcode}").attr("selected", true);
				$("#sltSite").attr("disabled", true);
			}
			
			gridDrugStock.createGrid();
			
			buttonActive();
			
			$("#sltSite").change(function(){
				gridDrugStock.load();
			});
		});
		
		function buttonActive(){
			$("#btnDown").click(function(){
				var data = AUIGrid.getGridData(gridDrugStock.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "IP_List"
					};
					AUIGrid.setProperty(gridDrugStock.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(gridDrugStock.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
		}
				
		window.onresize = function() {
			if (typeof gridDrugStock.id !== "undefined") {
				AUIGrid.resize(gridDrugStock.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRD0201&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRD0201&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
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
						<article class="conGridUpper">	
		                    <!-- 상단 그리드 왼쪽 메뉴 시작 -->
		                    <div class="conTitBtnL">
								<select id="sltSite">
									<option value="">=====전  체=====</option>
								</select>
		                    </div>
		                    <!-- 상단 그리드 왼쪽  메뉴 끝 -->
		                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
		                    <div class="conTitBtnR">
								<input type="button" id="btnDown" value="엑셀" />
		                    </div>
		                    <!-- 상단 그리드 오른쪽 메뉴 끝-->
		
		                </article>
						<article class="mgT40">
							<div id="grDrugStock" class="gridHeiSz14 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>