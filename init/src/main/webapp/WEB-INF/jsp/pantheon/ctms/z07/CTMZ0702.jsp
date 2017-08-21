<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript">
var g_taskSn = "${loginMap.TASK_SN}";
var g_taskNo = "${loginMap.TASK_NO}";
var g_userId = "${loginMap.USER_ID}";
var g_taskSe = "${loginMap.TASK_TY_CODE}";


var visitReportGrid = {
	 	id: 'visitReportGrid',
	 	div: {
	 		gridDiv: '#visitReportGrid'
	 	},
	 	proxy: {
	 		url: './selectTitleList.do',
	 		param: {'TASK_SN' : g_taskSn},
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
		    enableCellMerge : false,
		    showStateColumn: false,
		    reverseRowNum : true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : false,
		    enableFilter : true,
		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleCells",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "REPORT_SE",
			headerText : "구분",
			filter : {
				showIcon : true
			},
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = visitReportGrid;
				var retStr = "";
				
				for(var i=0; me.columnLayout[0].editRenderer.list.length > i; i++) {
					if(me.columnLayout[0].editRenderer.list[i]['CMMN_CODE'] == value) {
						retStr = me.columnLayout[0].editRenderer.list[i]['CMMN_CODE_NM'];
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
			dataField : "TASK_NO",
			headerText : "연구제목",
			filter : {
				showIcon : true
			}
		},{
			dataField : "NAME1",
			headerText : "연구기관",
			filter : {
				showIcon : true
			}	
		},{
			dataField : "OPRTN_DE",
			headerText : "일시",
			filter : {
				showIcon : true
			}			
		},{
			dataField : "USER_NM",
			headerText : "담당자",
			filter : {
				showIcon : true
			}
		},{
			dataField : "FRST_CREAT_DE",
			headerText : "작성일시",
			filter : {
				showIcon : true
			}			
		},{
			dataField : "REPORT_SN",
			headerText : "REPORT_SN",
			visible : false		
		},{
			dataField : "MILESTONE_SN",
			headerText : "MILESTONE_SN",
			visible : false		
		},{
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			visible : false		
		},{
			dataField : "INSTT_CODE",
			headerText : "INSTT_CODE",
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
	 		var me = this;
	 		
	 		AUIGrid.bind(me.id, "cellDoubleClick", function(event){
	 			var url;
	 			console.log(event.item.REPORT_SE);
	 			if(event.item.REPORT_SE == "H00"){
	 				url = "/ctms/z07/CTMZ0701.do";
	 			}
	 			
	 			var f = document.createElement("form");
	 			
	 			var objs ;
	 			var value ;
	 			var params = {'MILESTONE_SN' : event.item.MILESTONE_SN,
	 						  'INSTT_CODE' : event.item.INSTT_CODE
	 						  };
	 			
	 			for(var key in params){
	 				value = params[key];
	 				objs = document.createElement("input");
	 				objs.setAttribute("type", "hidden");
	 				objs.setAttribute("id", key);
	 				objs.setAttribute("name", key);
	 				objs.setAttribute("value", value);
	 				f.appendChild(objs);
	 			}
	 			
	 			f.setAttribute("method", "post");
	 			f.setAttribute("action", url);
	 			document.body.appendChild(f);
	 			f.submit();
	 		});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		me.columnLayout[0].editRenderer.list = data.param;
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
	
	
$(document).ready(function() {
	visitReportGrid.createGrid();
	AUIGrid.resize(visitReportGrid.id);	
}); 


function exportAs(){
// 	var chkbox = document.getElementById("chkbox");
// 	AUIGrid.exportToXlsx(visitReportGrid.id, chkbox.checked);
//	AUIGrid.setProperty(visitReportGrid.id, "exportURL", "./CTMZ0203.do");
	
}


$(window).resize(function(){
	if (visitReportGrid.id) {
		AUIGrid.resize(visitReportGrid.id);
	}	
});
</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0702&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0702&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<section id="mainCon">
	<div class="mainConInner">
	  <!-- 컨텐츠박스 시작-->
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
	  		<!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
            	<article class="mainTitBox">
           
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="mgT16">
                                <!-- mgT은 위로 55px을 띄운다는것 1부터 100까지는 1단위, 100부터 1000까지는 10단위
                                 주로 타이틀이나 메뉴 밑에 부분은 mgT16 mgT55 mgT43을 사용한다-->
                                <table class="tb02">
                                    <tbody>               
                                        <tr>
						                  <!-- 상단 그리드 오른쪽 메뉴 시작-->
						                  <article class="conTitBtnR">
						                  	  <input type="button" id="btnExcel" onclick="exportAs()" value="Excel">
						                  </article>
						                  <!-- 상단 그리드 오른쪽 메뉴 끝-->
                                        </tr>
                                    </tbody>
                                </table>
                            </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                         <div id="visitReportGrid" class="gridHeiSz17 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
	</div>
	</section>
</body>
</html>










