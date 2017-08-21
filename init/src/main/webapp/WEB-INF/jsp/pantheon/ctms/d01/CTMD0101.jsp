<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript">
var userId ; //로그인한 유저 ID

var SystemStudyGrid = {
	 	id: 'SystemStudyGrid',
	 	div: {
	 		gridDiv: '#SystemStudyGrid'
	 	},
	 	proxy: {
	 		url: '',
	 		param: {},
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
		    enableCellMerge : true,
		    showStateColumn: true,
		    reverseRowNum : true,
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
		    selectionMode : "multipleRows",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "",
			headerText : "과제번호",
			editable : true,
			filter : {
				showIcon : true
			}
		},{
			dataField : "",
			headerText : "Ver",			
			editable : false,
			cellMerge : true,			
			filter : {
				showIcon : true
			}
		},{
			dataField : "",
			headerText : "소속",
			filter : {
				showIcon : true
			}
			
		},{
			dataField : "",
			headerText : "사용자",
			editable : true,
			filter : {
				showIcon : true
			}
			
		},{
			dataField : "",
			headerText : "수료여부",
			editable : true,
			filter : {
				showIcon : true
			}
		},{
			dataField : "",
			headerText : "사용자구분",	
			editable : true,
			filter : {
				showIcon : true
			}
			
		},{
			dataField : "",
			headerText : "수료일",	
			editable : true,
			filter : {
				showIcon : true
			}
			
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
	 			    	//AUIGrid.setGridData(me.id, data.result);
	 			    	//AUIGrid.setSelectionByIndex(me.id, 0);	 			    	
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader(me.id);
	 		    		alert(data.message);
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};

$(document).ready(function() {
	$("#btnTaskEdu").click(function(){
		$(location).attr("href","/ctms/d01/CTMD0102.do");
	});
	
	
}); 



window.onresize = function() {
	SystemStudyGrid.createGrid();
	if (typeof SystemStudyGrid.id !== "undefined") {
		AUIGrid.resize(SystemStudyGrid.id);
	}
}
</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMD0101&UPPER_MENU_ID=CTMD" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMD0101&UPPER_MENU_ID=CTMD" charEncoding="utf-8"/>
<section id="mainCon">

	  <!-- 컨텐츠박스 시작-->
                   
	  		<!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">
					 <!-- 상단 그리드 전체메뉴라인 시작-->   
		            <div class="button_tab_01">
						<ul>				
							<li id="btnSystemEdu" class="port_back tab_menu">시스템 교육</li>
							<li id="btnTaskEdu" class="tab_menu">과제 교육</li>
						</ul>
					</div>
                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>시스템 교육</h5>
                    </article>
                    <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Education</a></li>
                        <li><a href="#">시스템 및 과제</a></li>
                    </ul>
               		</nav>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <div>
                    <article class="conTitBtnR">
                        <input type="button" id="btnPrint" value="출력">                       
                    </article>
                    </div>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                         <div id="SystemStudyGrid" class="grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
	
</body>
</html>










