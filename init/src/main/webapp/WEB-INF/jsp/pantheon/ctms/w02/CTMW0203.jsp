<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>Subject CRF Version Report</title>
<style>
/* .ctms_center {	 text-align: center; border:1px solid red;} */
.ctms_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.ctms_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>
<script type="text/javascript">
var taskSn = "1";
var ctmw0203Grid = {
	 	id: 'ctmw0203Grid',
	 	div: {
	 		gridDiv: '#ctmw0203Grid'
	 	},
	 	proxy: {
	 		url: './selectCTMW0203.do',
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
			children : [{
				dataField : "LAND1",
				headerText : "Country",	
				editable : false,
				labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
					var me = ctmw0203Grid;
					var retStr = "";
					
					for(var i=0; me.columnLayout[0].children[0].editRenderer.list.length > i; i++) {
						if(me.columnLayout[0].children[0].editRenderer.list[i]['CMMN_CODE'] == value) {
							retStr = me.columnLayout[0].children[0].editRenderer.list[i]['CMMN_CODE_NM'];
							break;
						}
					}
					return retStr == "" ? value : retStr;
			    },
			    editRenderer : {
		 			type : "DropDownListRenderer",
		 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		 			list : null,
		 			keyField : "CMMN_CODE",
		 			valueField : "CMMN_CODE_NM"
		 		 }
			},{
				dataField : "",
				headerText : "SITE_ID",	
				editable : false				
			},{
				dataField : "",
				headerText : "SITE_NAME",	
				editable : false
			}]
	 		
		},{
			
			headerText : "Subject",
			children : [{
				dataField : "SUBJECT_NO",
				headerText : "ID",	
				editable : false
			},{
				dataField : "SUBJECT_STTUS_CODE",
				headerText : "Status",	
				editable : false
			},{
				dataField : "VISIT_LBL",
				headerText : "Visit",	
				editable : false
			}]
		},{
			headerText : "CRF",
			children : [{
				dataField : "CRF_VER",
				headerText : "CRF_EFFECTIVE",	
				editable : false
			},{
				dataField : "CRF_EFFECTIVE",
				headerText : "Effective",	
				editable : false
			}]
		},{
			headerText : "EDC",
			children : [{
				dataField : "EDC_VER",
				headerText : "Version",	
				editable : false
			},{
				dataField : "EDC_EFFECTIVE",
				headerText : "Effective",	
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
	 		    		ctmw0203Grid.columnLayout[0].children[0].editRenderer.list = data.stCode; 	    
	 			    	//AUIGrid.removeAjaxLoader(me.id);
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
	 	}
	};

window.onresize = function() {
	if (typeof ctmw0203Grid.id !== "undefined") {
		AUIGrid.resize(ctmw0203Grid.id);
	}
}

$(document).ready(function() {
	ctmw0203Grid.createGrid();	      
	
	$("#btnExcel").click(function(){
		console.log(ctmw0203Grid.columnLayout[0].children[0].editRenderer.list);
		console.log(ctmw0203Grid.columnLayout[0]);
		//.editRenderer.list
	});
});
</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMW0203&UPPER_MENU_ID=CTMW" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMW0203&UPPER_MENU_ID=CTMW" charEncoding="utf-8"/>
<section id="mainCon">

	  <!-- 컨텐츠박스 시작-->
                   
	  		<!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>Subject CRF Version Report</h5>
                    </article>
                    <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Study info</a></li>
                        <li><a href="#">Subject CRF Version Report</a></li>
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
                         <div id="ctmw0203Grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
	
</body>
</html>










