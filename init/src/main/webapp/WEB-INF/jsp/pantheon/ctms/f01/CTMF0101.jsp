<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta http-equiv="Content-Script-Type" content="text/javascript"/>
<meta http-equiv="Content-Style-Type" content="text/css"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>

<title>전체 계약 리스트</title>

<script type="text/javascript">
var contractListGrid = {
		id: '',
	 	div: {
	 		gridDiv: '#contractListGrid',
	 		paging: {
	 			pagingDiv: 'pgcontractListGrid',
	 			totalRowCount: 500,
	 			rowCount: 20,
	 			pageButtonCount: 5,
	 			currentPage: 1,
	 			totalPage: 0
	 		},
	 	},
	 	proxy: {
	 		url: './selectTotalcontractListGrid.do',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: true,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
		    // 페이징 사용
		   /*  usePaging : true,
		    pageRowCount : 5,
		    showPageButtonCount : 5, */
		    showStateColumn: true,
		    showRowNumColumn : true,
		    showRowCheckColumn : true,
		    //rowCheckToRadio : true,
		    enableColumnResize : false,
		    enableMovingColumn : false,
		    editable : false,
		    enableFilter : true,
			//height: 265,
		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows",

		    displayTreeOpen : true,
		    
		    
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "TASK_SN",
			headerText : "과제순번",
			editable : true	,
			visible : false
		},{
			dataField : "TASK_NO",
			headerText : "과제번호",
			editable : true	
		},{
			dataField : "USER_NM",
			headerText : "연구자",
			visible : true			
		},{
			dataField : "USER_ID",
			headerText : "ID",
			editable : true			
		},{
			dataField : "EMAIL",
			headerText : "E-mail",
			editable : true
		},{
			dataField : "TELNO",
			headerText : "전화번호",	
			editable : true
		},{
			dataField : "GOAL_NO",
			headerText : "목표례수",
			editable : true
		},{
			dataField : "IRB_AT",
			headerText : "IRB 여부",	
			editable : true
		},{
			dataField : "STTUS",
			headerText : "상태",	
			editable : true
		},{
			dataField : "STTUS_DTE",
			headerText : "상태날짜",	
			dataType : "date",
	 	 	formatString : "yyyy-mm-dd",			
			editable : true
		},{
			dataField : "",
			headerText : "구분",	
			editable : true
			
		},{
			dataField : "FILE_CNT",
			headerText : "계약서",	
			editable : false,
			renderer : {
				type : "ButtonRenderer",				
				onclick : function(rowIndex, columnIndex, value, item){
					 var param = {							 
							 parent_value : item.ATCH_FILE
						};					
					if(item.ATCH_FILE != null || item.ATCH_FILE != '0'){
						mkLayerPopupOpen("/ctms/f01/popupCTMF0104.do", param);
					}
				}
			},
		},{
			dataField : "ATCH_FILE",  //15
			headerText : "파일순번",
			editable : false,
			visible : false
		}],
		
		
	 	//AUI 그리드 생성
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	//AUI 그리드 이벤트 
	 	binding: function() {
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		
	 		if(me.proxy.paging && !v1 && !v2) {
	 			me.proxy.param.page = me.div.paging.currentPage;		
	 			me.proxy.param.count= me.div.paging.rowCount;		
	 		}
	 		
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
	 		    data: me.proxy.param,//{'TASK_NO' : SearchData, 'USER_ID' : userId},
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
	 			    	
	 			    	
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader(me.id);
	 		    		alert(data.message);
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
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



$(document).ready(function(){
	contractListGrid.createGrid();
});


window.onresize = function() {
	// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
	if (typeof contractListGrid.id !== "undefined") {
		AUIGrid.resize(contractListGrid.id);
	}
};
</script>
</head>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMF0101&UPPER_MENU_ID=CTMF" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMF0101&UPPER_MENU_ID=CTMF" charEncoding="utf-8"/>
    <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>전체 계약 리스트</h3>

                <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Report</a></li>
                    </ul>
                </nav>
            </article>


            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>전체계약</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 전체메뉴라인 시작-->        
                    <article class="conGridUpper">

                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                             	과제번호 : <input type="text" id="taskNo" name="taskNo" class="pdR15"><input type="button" class="btn mgL3" onclick="fn_searchClick()" value="검색">
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT20">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->                        
                         <div id="contractListGrid" class="gridHeiSz10 grid_wrap tb01_2"></div>
						 <div id="pgcontractListGrid" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>

            </section>
            <!-- 컨텐츠박스 끝-->



        </div>
    </section>

</div>

</body>
</html>