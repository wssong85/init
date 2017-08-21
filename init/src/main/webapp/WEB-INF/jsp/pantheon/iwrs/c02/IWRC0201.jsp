<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>

	<script type="text/javascript">
	var gridRequest = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
		 	id: 'gridRequest',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridRequest',
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
		 		url: '/iwrs/c02/selectRequestInfo.do',
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
		 	},{ 
		 		dataField : "INSTT_NAME",
		 		headerText : "Site",
		 		filter : {
		 			showIcon : true
		 		}
		 	},{
		 		dataField : "DLVY_RQESTER_NM",
		 		headerText : "요청자",
		 		filter : {
		 			showIcon : true
		 		}
		 	},{
		 		dataField : "DLVY_RQESTDE",
		 		headerText : "요청일",
				formatString : "yyyy-mm-dd",
		 		dataType:"date",
		 		filter : {
		 			showIcon : true
		 		}
		 	},{
		 		dataField : "DLVY_REQUST_COMMENT",
		 		headerText : "요청메모",
		 		filter : {
		 			showIcon : true
		 		}
		 	},{
		 		dataField : "DLVY_REQUST_CNFIRM_AT",
		 		headerText : "담당자확인",
		 		renderer : { // HTML 템플릿 렌더러 사용
					type : "TemplateRenderer"
				},
				// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
				labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
					if(!value)	return "";
					var template = "";
					if(("${ROLE}" == "CRA" || "${ROLE}" == "CRM") && value == "N"){
						template = '<a href="#" onclick="javascript:showCraPopup(\'' + item.INSTT_CODE + '\', \'' + item.DLVYREQUSTMANAGE_CODE + '\');return false;">' + value + '</a>';
					}else{
						template = value;
					}
					return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
				},
		 		filter : {
		 			showIcon : true
		 		}
		 	},{
		 		dataField : "DLVYREQUSTMANAGE_CODE",
		 		headerText : "베송요청코드",
		 		visible : false
		 	}],
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
		 		retStr += "<select onchange='javascript:grClCode.moveToPage(grClCode.div.paging.currentPage, this.value)'>"
		 		if(grClCode.div.paging.rowCount == 20) {
		 			retStr += "<option value=20 selected=true>20</option>"
		 		} else {
		 			retStr += "<option value=20>20</option>"
		 		}
		 		if(grClCode.div.paging.rowCount == 50) {
		 			retStr += "<option value=50 selected=true>50</option>"
		 		} else {
		 			retStr += "<option value=50>50</option>"
		 		}
		 		if(grClCode.div.paging.rowCount == 100) {
		 			retStr += "<option value=100 selected=true>100</option>"
		 		} else {
		 			retStr += "<option value=100>100</option>"
		 		}
		 		if(grClCode.div.paging.rowCount == 300) {
		 			retStr += "<option value=300 selected=true>300</option>"
		 		} else {
		 			retStr += "<option value=300>300</option>"
		 		}
		 		if(grClCode.div.paging.rowCount == 500) {
		 			retStr += "<option value=500 selected=true>500</option>"
		 		} else {
		 			retStr += "<option value=500>500</option>"
		 		}
		 		retStr += "</select>"
		 		
		 		// 처음
		 		retStr += "<a href='javascript:grClCode.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
		 
		 		// 이전
		 		retStr += "<a href='javascript:grClCode.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'>prev</span></a>";
		 
		 		for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage); i<=len; i++) {
		 			if (goPage == i) {
		 				retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
		 			} else {
		 				retStr += "<a href='javascript:grClCode.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
		 				retStr += i;
		 				retStr += "</span></a>";
		 			}
		 			
		 			if (i >= me.div.paging.totalPage) {
		 				break;
		 			}
		 
		 		}
		 
		 		// 다음
		 		retStr += "<a href='javascript:grClCode.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'>next</span></a>";
		 
		 		// 마지막
		 		retStr += "<a href='javascript:grClCode.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>";
		 		
		 
		 
		 		document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
		 	},
		 	//페이징 에서 어느 페이지로 갈 것인지 지정
		 	moveToPage: function(goPage, rowCount) {
		 		var me = this;
		 		
		 		if(!me.div.paging.pagingDiv) { 
		 			return;
		 		}
		 		
		 		// 현재 페이지 보관
		 		me.div.paging.currentPage = goPage;
		 		
		 		// selectBox에서 요청시, 1페이지부터 시작
		 		if(rowCount) {
		 			me.div.paging.rowCount = rowCount;
		 			me.div.paging.currentPage = 1;
		 			goPage = 1;
		 		}
		 		
		 		me.load(me.div.paging.rowCount, goPage);
		 	}
		};
	
		$(function(){
			gridRequest.createGrid();
		});
		
		function showCraPopup(instt_code, dlvyrequstmanage_code){
			var param = {
					INSTT_CODE : instt_code,
					DLVYREQUSTMANAGE_CODE : dlvyrequstmanage_code,
					PAGE_ID : "IWRC0201"
			};
			
			mkLayerPopupOpen("/iwrs/c01/popupIwrc0103.do", param);
		}
		
		function updateRequestInfo(instt_code, dlvyrequstmanage_code){
			var param = {
					INSTT_CODE : instt_code,
					DLVYREQUSTMANAGE_CODE : dlvyrequstmanage_code
			};
// 			console.log(dlvyrequstmanage_code);
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : "/iwrs/c02/updateRequestInfo.do",
				success :function(data){
					if(data.result == true){
						//alert("등록하였습니다.");
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		window.onresize = function() {
			if (typeof gridRequest.id !== "undefined") {
				AUIGrid.resize(gridRequest.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRC0201&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRC0201&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>
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
						<article class="mgT5">
							<div id="gridRequest" class="gridHeiSz14 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>