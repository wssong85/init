<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript">


	var noticeGrid = {
	 	id: 'noticeGrid',
	 	div: {
	 		gridDiv: '#noticeGrid'
	 	},
	 	proxy: {
	 		url: '/ctms/a01/selectNotice.do',
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
// 		    height : 250,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "SJ",
			headerText : "제목",
			editable : false,
			filter : {
				showIcon : true
			}
		},{
			dataField : "FRST_CRTR",
			headerText : "작성자",			
			editable : false,		
			width : 150,
			filter : {
				showIcon : true
			}
		},{
			dataField : "FRST_CREAT_DE",
			headerText : "작성일",
			dataType : "date",
	        formatString : "yyyy-mm-dd",
			editable : false,		
			width : 150,
			filter : {
				showIcon : true
			}
		},{
			dataField : "MODULE_SE",
			headerText : "모듈 구분",			
	        visible : false,
			editable : false			
		},{
			dataField : "NOTICE_SE",
			headerText : "공지 구분",			
	        visible : false,
			editable : false
		},{
			dataField : "CN",
			headerText : "내용",			
	        visible : false,
			editable : false
		},{
			dataField : "ATCH_FILE_SN",
			headerText : "파일 순번",			
	        visible : false,
			editable : false
		},{
			dataField : "TASK_SN",
			headerText : "과제 순번",			
	        visible : false,
			editable : false
		},{
			dataField : "SN",
			headerText : "순번",			
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
	 		var me = this;
	 		AUIGrid.bind(me.id, "cellDoubleClick", function(event){
	 			P_NOTICE_SN = event.item.SN;
	 			P_CRUD      = "U";
	 			var param = {};
	 			mkLayerPopupOpen("/ctms/a01/popupCTMA0102.do", param);
	 		});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
		
	 		AUIGrid.showAjaxLoader(me.id);
	 		
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

	 			    	notificationGrid.load();

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
	};

	var notificationGrid = {
		 	id: 'notificationGrid',
		 	div: {
		 		gridDiv: '#notificationGrid'
		 	},
		 	proxy: {
		 		url: '/ctms/a01/selectNotifyCtmsList.do',
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
// 			    enableCellMerge : true,
// 			    showStateColumn: true,
			    reverseRowNum : true,
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    showRowNumColumn : true,
// 			    showRowCheckColumn : false,
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    editable : false,
// 			    enableFilter : true,
			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
//	 		    height : 250,
			    headerHeight: 40,
			    rowHeight: 37,
// 			    selectionMode : "multipleRows",

// 			    displayTreeOpen : true,
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
				dataField : "NOTIFY_SN",
				headerText : "NOTIFY_SN",
				visible : false
			},{
				dataField : "REQUEST_SN",
				headerText : "REQUEST_SN",			
				visible : false
			},{
				dataField : "JOB_TYPE",
				headerText : "JOB_TYPE",			
		        visible : false	
			},{
				dataField : "TASK_NO",
				headerText : "과제번호",
		        visible : true,
		        editable : false
			},{
				dataField : "JOB_NM",
				headerText : "업무유형",			
		        visible : true,
		        editable : false
			},{
				dataField : "TASK_SN",
				headerText : "과제번호",			
		        visible : false
			},{
				dataField : "NOTIFY_SJ",
				headerText : "업무내용",			
		        visible : true,
		        editable : false
			},{
				dataField : "CHARGER_ID",
				headerText : "CHARGER_ID",			
		        visible : false
			},{
				dataField : "TASK_SN",
				headerText : "과제 순번",			
		        visible : false,
				editable : false
			},{
				dataField : "LINK_URL",
				headerText : "LINK_URL",			
		        visible : false,
				editable : false
			},{
				dataField : "LINK_KEY",
				headerText : "LINK_KEY",			
		        visible : false,
				editable : false
			},{
				dataField : "LINK_VALUE",
				headerText : "LINK_VALUE",			
		        visible : false,
				editable : false
			},{
				dataField : "NOTIFY_BEGIN",
				headerText : "NOTIFY_BEGIN",			
		        visible : false,
				editable : false
			},{
				dataField : "NOFTIFY_END",
				headerText : "NOFTIFY_END",			
		        visible : false,
				editable : false
			},{
				dataField : "UPDT_DE",
				headerText : "알람일",			
		        visible : true,
		        dataType : "date",
		 		formatString : "yyyy-mm-dd",
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
		 			fn_jobNotification(event.item);
		 		});
		 	},
		 	load: function(v1, v2) {
		 		var me = this;
			
		 		AUIGrid.showAjaxLoader(me.id);
		 		
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
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
		 		});
		 	},
		};

//공지사항 작성/수정/삭제 후 실행함수
function fn_callBack(){
	noticeGrid.load();
}

function fn_jobNotification(item){

	var jobType   = item.JOB_TYPE;
	var keySize   = 0;
	var valueSize = 0;
	var params    = {};

	if (typeof item.LINK_KEY !== "undefined") {
		if(item.LINK_KEY){
			keySize   = item.LINK_KEY.length;
			valueSize = item.LINK_VALUE.length;
		}
   	}

	if(keySize > 0 && valueSize > 0){
		var keys   = item.LINK_KEY.split(",");
		var values = item.LINK_VALUE.split(",");
		
		if(keys.length == values.length){
			var keys   = keykey.split(",");
			var values = valuevalue.split(",");
			
			for(var i=0; keys.length > i; i++){
				params[keys[i]] = values[i];
			}
		}
		else{
			console.log("key 갯수와 values 갯수가 틀림!!!");
		}
	}

	$("#frm").attr({
		  action : item.LINK_URL
		, method : 'post'
		, dataType: "json"
		, data : params
	}).submit();
}

var P_CRUD      = "";
var P_NOTICE_SN = ""; //공지사항 순번
var P_TASK_SN   = ""; //과제순번
var P_TASK_NO   = ""; //과제순번
var P_MODULE    = "01" ; //CTMS:01, EDC:02, IWRS:03, SafetyDB:04
var P_NOTICE_SE = "01"; //공지구분 전체:01, 과제:02
$(document).ready(function(){
	noticeGrid.createGrid();
	notificationGrid.createGrid();

	$("#btnWriting").click(function(){	
	    /* paranModuleCode
	    01:CTMS
		02:EDC
		03:IWRS
		04:SafetyDB
		*/
		/* parandivisionCode
	 	 01:전체
		 02:과제
	
		*/
// 		noticeSn = ""; //공지사항 순번
// 		pranTasksn = ""; //과제순번
// 		paranModuleCode = "01" ; //모듈
// 		parandivisionCode = "02"; //공지구분 전체, 과제
		P_CRUD = "C";
		var param = {};			
		mkLayerPopupOpen("/ctms/a01/popupCTMA0102.do", param);
	});
});


$(window).resize(function() {
	if (typeof noticeGrid.id !== "undefined") {
		AUIGrid.resize(noticeGrid.id);
	}
});


</script>


<title>메인(전체)</title>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMA0101&UPPER_MENU_ID=CTMA" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMA0101&UPPER_MENU_ID=CTMA" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">


            <section class="conBox100 conBox">
                <div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>공지사항</h5>
                    </article>
                    <article class="conTitBtnR">
                        <input type="button" id="btnWriting" value="글쓰기" />
                    </article>
                    <article class="mgT16">
                        <div id="noticeGrid" class="gridHeiSz07 grid_wrap tb01_2"></div>
                        
                    </article>
                </div>
            </section>



            <section class="conBox100 conBox">
                <div class="conBoxInner">
                    <article class="conTitBox">
                         <h5>업무 알림</h5>
                    </article>
                    <article class="mgT16">
                        <div id="notificationGrid" class="gridHeiSz10 grid_wrap tb01_2"></div>
                    </article>
                </div>
            </section>

		</div>
	</section>

</div>
</body>
</html>