<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>CRF Status Report : visit</title>
<style>
/* .ctms_center {	 text-align: center; border:1px solid red;} */
.ctms_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.ctms_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>
<script type="text/javascript">
var taskSn = "1";
var ctmw0202Grid = {
	 	id: 'ctmw0202Grid',
	 	div: {
	 		gridDiv: '#ctmw0202Grid'
	 	},
	 	proxy: {
	 		url: './selectCTMW0202.do',
	 		param: {'TASK_SN' : taskSn},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
		    // 페이징 사용
		   /*  usePaging : true,
		    pageRowCount : 5,
		    showPageButtonCount : 5, */
		    usePaging : true,
		    enableCellMerge : true,
		    showStateColumn: true,
		    reverseRowNum : false,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
		    enableFilter : true,
		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "singleRow",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{			
			headerText : "Site",
			style : "ctms_column_style",
			minWidth : 100,
			width : 100,
			children : [{
				dataField : "LAND1",
				headerText : "Country",	
				editable : true
			},{
				dataField : "SITE_ID",
				headerText : "SITE ID",	
				editable : true				
			},{
				dataField : "SITE_NAME",
				headerText : "SITE NAME",	
				editable : true
			}]
	 		
		},{
			headerText : "연구자",
			children : [{
				dataField : "USER_ID",
				headerText : "User ID",	
				editable : false
			},{
				dataField : "USER_NM",
				headerText : "연구자",	
				editable : false
			}]

			
		},{			
			headerText : "Visit",			
			children : [{
				dataField : "VISIT_LBL",
				headerText : "Visit",	
				editable : false
			}]
		},{			
			headerText : "Case Report Form",
			children : [{
				dataField : "GOAL_NO",
				headerText : "Expected Total",	
				editable : false
			},{
				dataField : "ENTERED",
				headerText : "Entered",	
				editable : false
			},{
				dataField : "VERIFIED",
				headerText : "Verified",	
				editable : false
			},{
				dataField : "FROZEN",
				headerText : "Frozen",	
				editable : false
			},{
				dataField : "FROZEN",
				headerText : "Locked",	
				editable : false
			},{
				dataField : "OPEN_QUERY",
				headerText : "Open Queries",	
				editable : false
			},{
				dataField : "CLOSE_QUERY",
				headerText : "Closed Queries",	
				editable : false
			}]
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
	 		
	 		//AUIGrid.showAjaxLoader(me.id);
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 		 		    		
	 		    	     	    
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	 			    	
	 		    	} else {
	 		    		//AUIGrid.removeAjaxLoader(me.id);
	 		    		alert(data.message);
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};

window.onresize = function() {
	if (typeof ctmw0202Grid.id !== "undefined") {
		AUIGrid.resize(ctmw0202Grid.id);
	}
}

$(document).ready(function() {
	ctmw0202Grid.createGrid();
});
</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMW0202&UPPER_MENU_ID=CTMW" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMW0202&UPPER_MENU_ID=CTMW" charEncoding="utf-8"/>
<section id="mainCon">

	  <!-- 컨텐츠박스 시작-->
                   
	  		<!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>CRF Status Report : visit</h5>
                    </article>
                    <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Study info</a></li>
                        <li><a href="#">CRF Status Report : visit</a></li>
                    </ul>
               		</nav>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <div>
                    <article class="conTitBtnR">
                        <input type="button" id="btnExcel" value="Excel">                       
                    </article>
                    </div>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                         <div id="ctmw0202Grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
	
</body>
</html>










