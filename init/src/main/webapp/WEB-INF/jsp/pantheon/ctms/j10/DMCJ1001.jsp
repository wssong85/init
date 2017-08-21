<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript">
var irbList; //IRB 유무 공통코드
var cntrctSe; // 계약구분 공통코드
var userId ; //로그인한 유저 ID
var taskNo ;
var sttus; //상태 공통코드
//AUIGrid 생성 후 반환 ID

$(document).ready(function() {
	contractGrid.createGrid();	
	
	$("#searchTaskNo").click(function(){
		taskNo = $("#myInput").val();		
		contractGrid.load();
	});
	
}); 


var contractGrid = {
	 	id: '',
	 	div: {
	 		gridDiv: '#contractGrid'
	 	},
	 	proxy: {
	 		url: './selectContractList.do',
	 		param: {'TASK_NO' : taskNo},
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
		    
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : false,
		    enableMovingColumn : false,
		    'showStateColumn': true,
		    editable : true,
		    enableFilter : true,
			height: 265,
		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "TASK_NO",
			headerText : "과제번호",
			editable : false,
			width: 120
		},{
			dataField : "INSTT_CODE",
			headerText : "기관코드",
			editable : false,
			visible : false,
			width: 120
		},{
			dataField : "HSPTL_NM",
			headerText : "기관명",
			editable : false,
			width: 120,			
		},{
			dataField : "USER_NM",
			headerText : "연구자",
			editable : false,	
		},{
			dataField : "USER_ID",
			headerText : "ID",
			editable : false
		},{
			dataField : "EMAIL",
			headerText : "e-mail",	
			editable : false
		},{
			dataField : "TELNO",
			headerText : "전화번호",
			editable : false
		},{
			dataField : "GOAL_NO",
			headerText : "목표례수",
			editable : false
		},{
			dataField : "IRB_AT",
			headerText : "IRB 여부",		
			labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
  				var reStr = "";
  				for(var i=0, len=irbList.length; i<len; i++){  				
  					if(irbList[i]["CODE"] == value){
  						reStr = irbList[i]["NAME"];
  						break;
  					}
  				}
  				return reStr;
  		    },
			Renderer : {
     			type : "DropDownListRenderer",
     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
     			list : irbList,
     			keyField : "CODE",
     			valueField : "NAME"
     		},
			editable : false
		},{
			dataField : "STTUS",
			headerText : "상태",
			labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
  				var reStr = "";
  				for(var i=0, len=sttus.length; i<len; i++){  				
  					if(sttus[i]["CODE"] == value){
  						reStr = sttus[i]["NAME"];
  						break;
  					}
  				}
  				return reStr;
  		    },
			Renderer : {
     			type : "DropDownListRenderer",
     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
     			list : sttus,
     			keyField : "CODE",
     			valueField : "NAME"
     		},
			editable : false
		},{
			dataField : "STTUS_DTE",
			headerText : "상태변경 날짜",	
			dataType : "date",
			formatString : "yyyy-mm-dd",
			editable : false
		},{
			dataField : "CNTRCT_SE",
			headerText : "종류",
			labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
  				var reStr = "";
  				for(var i=0, len=cntrctSe.length; i<len; i++){  				
  					if(cntrctSe[i]["CODE"] == value){
  						reStr = cntrctSe[i]["NAME"];
  						break;
  					}
  				}
  				return reStr;
  		    },
			Renderer : {
     			type : "DropDownListRenderer",
     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
     			list : cntrctSe,
     			keyField : "CODE",
     			valueField : "NAME"
     		},
			editable : false
		},{
			dataField : "FILE_CNT",
			headerText : "계약서",				
			renderer : {
				type : "ButtonRenderer",				
				onclick : function(rowIndex, columnIndex, value, item){
					 var param = {							 
							 parent_value : item.ATCH_FILE
						};
					//AUIGrid.removeAjaxLoader(myGridID);
					if(item.ATCH_FILE != null){
// 						mkLayerPopupOpen("/CTMF0104.do", param);
						mkLayerPopupOpen("/CTMF0104.do", param);
					}
				}
			},
			editable : false	
		},{
			dataField : "ATCH_FILE",
			headerText : "계약번호",			
			visible : false,
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
	 		
	 		AUIGrid.showAjaxLoader(me.id);
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: {'TASK_NO' : taskNo},//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	
	 		    		irbList = data.irbList;
	 		    		cntrctSe = data.cntrctSe;
	 		    		sttus = data.sttus;
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
	 	}
	};
window.onresize = function() {
	if (typeof contractGrid.id !== "undefined") {
		AUIGrid.resize(contractGrid.id);
	}
} 
</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=DMCJ1001&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=DMCJ1001&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
<section id="mainCon">

	  <!-- 컨텐츠박스 시작-->
                   
	  		<!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>계약관리</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <div>
	                                            
	          			과제번호 : <input type="text" id="myInput"  class="pdR15"><input id="searchTaskNo" type="button" class="btn mgL3" value="검색">         
	                  
                    </div>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->
					
                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                         <div id="contractGrid" class="grid_wrap tb01_2"></div>
                    </article>
                   
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
	
</body>
</html>










