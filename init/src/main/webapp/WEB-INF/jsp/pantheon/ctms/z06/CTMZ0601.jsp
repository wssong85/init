<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>

<style>
.con_title_01{ display:block; height:28px;}
.left_001{margin-top:15px; width:29.5%; float:left;}
.right_001{margin-top:15px; width:69.5%; float:right;}
.right_002{ width:49.5%; float:right;}
</style>


 <script type="text/javascript">
var taskSn = "${loginMap.TASK_SN}";
var taskNo = "${loginMap.TASK_NO}";
var userId = "${loginMap.USER_ID}";
var taskSe = "${loginMap.TASK_TY_CODE}";
 
var taskInsttGrid = {
	 	id: 'taskInsttGrid',
	 	div: {
	 		gridDiv: '#taskInsttGrid',			
	 	},
	 	proxy: {
	 		url: '/ctms/z01/selectInsttInfo.do',
	 		param: {'TASK_SN' : taskSn},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: true,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
	 		usePaging : false,
 		    showStateColumn: false,
 		    rowCheckToRadio : false,
 		    reverseRowNum : true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : false,
		    enableMovingColumn : false,
		    editable : true,
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
		 	dataField : "TASK_SN",
		 	headerText : "과제순번",
		 	visible : false,		 	
		 	editable : false
		 },{
		 	dataField : "TASK_NO",
		 	headerText : "과제번호",
		 	visible : false,		 
		 	editable : false
		 },{
		 	dataField : "INSTT_CODE",
		 	headerText : "기관코드",
		 	visible : false,		 	
		 	editable : false
		 },{
		 	dataField : "HSPTL_NM",
		 	headerText : "기관명",		 	
		 	editable : false	
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
	 			var params1 = {
	 					'TASK_SN': taskSn,
	 					'INSTT_CODE' : event.item.INSTT_CODE,
	 					'JOB_SE' : taskSe, 					
	 					'USER_ID' : userId,
	 				};
	 			console.log(params1);
	 			taskVisitGrid.proxy.param = params1; 	 			
	 			taskVisitGrid.load();
	 			
	 			
	 		});
	 		
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 				 				 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {		 		    			 		    		
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
	 		    	} else {		 		    		
	 		    		alert(data.message);		 		    		
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};
 
 
var taskVisitGrid = {
	 	id: 'taskVisitGrid',
	 	div: {
	 		gridDiv: '#taskVisitGrid',			
	 	},
	 	proxy: {
	 		url: '/ctms/z01/selectVisitReportInfo.do',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: true,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
	 		usePaging : false,
 		    showStateColumn: false,
 		    rowCheckToRadio : false,
 		    reverseRowNum : true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : false,
		    enableMovingColumn : false,
		    editable : true,
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
		 	dataField : "OPRTN_DE",
		 	headerText : "방문일시",
		 	visible : true,
		 	dataType : "date",
		 	formatString : "yyyy-mm-dd",
		 	editable : false
		 },{
		 	dataField : "REPORT_SE",
		 	headerText : "구분",
		 	visible : true,
		 	editable : false,
		 	labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = taskVisitGrid;
				var retStr = "";
				
				for(var i=0; me.columnLayout[1].editRenderer.list.length > i; i++) {
					if(me.columnLayout[1].editRenderer.list[i]['CMMN_CODE'] == value) {
						retStr = me.columnLayout[1].editRenderer.list[i]['CMMN_CODE_NM'];
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
		 	dataField : "USER_NM",
		 	headerText : "등록자",
		 	editable : false	
		 },{
		 	dataField : "FRST_CREAT_DE",
		 	headerText : "등록일",
		 	dataType : "date",
		 	formatString : "yyyy-mm-dd",
		 	editable : false	
		 },{
			 dataField : "MILESTONE_SN",
			 headerText : "MILESTONE_SN",			 	
			 editable : false,
			 visible : false
		 },{
			 dataField : "INSTT_CODE",
			 headerText : "INSTT_CODE",			 	
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
	 		var me = this;
	 		
	 		AUIGrid.bind(me.id, "cellDoubleClick", function(event){
	 			var params = {'MILESTONE_SN' : event.item.MILESTONE_SN,
	 						  'REPORT_SE' : event.item.REPORT_SE,
	 						  'INSTT_CODE' : event.item.INSTT_CODE
				  };
	 			fn_reportSe(params);
	 			
	 		});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 				 				 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 	 		    	
	 		    		me.columnLayout[1].editRenderer.list = data.param;
	 		    		
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
	 		    	} else {		 		    		
	 		    		alert(data.message);		 		    		
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};
 
var taskEvaluationGrid = {
	 	id: 'taskEvaluationGrid',
	 	div: {
	 		gridDiv: '#taskEvaluationGrid',			
	 	},
	 	proxy: {
	 		url: '/ctms/z01/selectInsttInfo.do',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: true,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
	 		usePaging : false,
 		    showStateColumn: false,
 		    rowCheckToRadio : false,
 		    reverseRowNum : true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : false,
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
		 	dataField : "TASK_SN",
		 	headerText : "과제순번",
		 	visible : true,
		 	editable : false
		 },{
		 	dataField : "INSTT_CODE",
		 	headerText : "기관코드",
		 	visible : true,
		 	editable : false
		 },{
		 	dataField : "NAME1",
		 	headerText : "기관명",
		 	editable : false	
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
	 				 				 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {		 		    			 		    		
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
	 		    	} else {		 		    		
	 		    		alert(data.message);		 		    		
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};
 $(document).ready(function(){
	 taskInsttGrid.createGrid();
	 taskVisitGrid.createGrid();
	 taskEvaluationGrid.createGrid();
 });  
 
 function fn_reportSe(items){
	 var url;
	 switch (items.REPORT_SE){
	 	case "A01" :
	 		url = "/ctms/z02/CTMZ0201.do";
	 		params = items;
	 	break;
	 	
	 	case "A02" :
	 		url = "/ctms/z02/CTMZ0202.do";
	 		params = items;
	 	break;
	 	
	 	case "B01" :
	 		url = "/ctms/z04/CTMZ0401.do";
	 		params = items;
	 	break;
	 	
	 	case "B02" :
	 		url = "/ctms/z04/CTMZ0402.do";
	 		params = items;
	 	break;
	 }
	 
	 var f = document.createElement("form");
		
	 var objs ;
	 var value ;	
	
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
 }


 $(window).on('resize', function(){
		if (taskInsttGrid.id) {
			AUIGrid.resize(taskInsttGrid.id);
		}
	});
 
 
 

 </script>
<title>기관방문 리스트</title>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0101&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0101&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>



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


					<section class="con_title_01">
		            	<articla class="conTitBox">
		            		<h5>기관방문 전체</h5>
		            	</articla>
					</section>
                    
                   
					<div class="conSbtLn left_001">
						<article class="mgT16">
							<div id="taskInsttGrid" class="gridHeiSz12 grid_wrap tb01_2"></div>								
						</article>
					</div>




					<div class="conSbtLn right_001">
						<article class="mgT16">
							 <div id="taskVisitGrid" class="gridHeiSz07 grid_wrap tb01_2"></div>
						</article>
						
						<article class="mgT32">
							  <div id="taskEvaluationGrid" class="gridHeiSz03 grid_wrap tb01_2"></div> 
						</article>
					</div>
                   

                </div>
            </section>

	 
	
		</div>
	</section>
</div>
</body>
</html>