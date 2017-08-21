<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<!-- 상단 css, js 임포트 호출 -->

<html>
<head>

<script type="text/javascript">
var userId = "${USER_ID}"; //로그인한 유저 ID
var userBelong;
//AUIGrid 생성 후 반환 ID
var SearchData;
var moduleCode;
var requestCode;
var paramItem;
var p_seq_no;
var modiCount ="0"; //0이면 insert 1이면 update
//popup 결과
var returnValue;
//기관 조회 popup
var p_instt_name; //기관명  like 검색
var fileMarsterSn;
var user_role;//유저 역할 
var user_role_id;
var user_dept;//유저 부서/기관

var moduleDiv = "1"; //DMC에서 팝업을 열었는지 구분 0:CTMS 1:DMC
$(document).ready(function() {	
	fn_userInfo();
	AUIGrid.setProperty(requestDmcGrid.id, "editable" , false ); 
	//////검색버튼
	$("#SearchBtn").click(function(){	
		SearchData = $("#SearchInput").val();
		var params = {
				'TASK_NO': $("#SearchInput").val()
			   ,'USER_ID' : userId
			   ,'ROLE_ID' : user_role_id
			};
			
		    requestDmcGrid.proxy.param = params; 			
		    requestDmcGrid.load();
		
	});
	
	//////신규버튼
	$("#btnRequestAdd").click(function(){
		modiCount = "0";
		moduleDiv = "1";
		var param = {};
		mkLayerPopupOpen("/ctms/h01/CTMH0102.do", param);
		fn_newPopup();
		AUIGrid.resize(uploadFileGrid.id);		
	});
	
	AUIGrid.bind(requestDmcGrid.id, "cellDoubleClick", function(event){
		modiCount = "1";
		paramItem = event.item;
		fileMarsterSn = paramItem.FILE_MASTR_SN;
		var param = {};
		mkLayerPopupOpen("/ctms/h01/CTMH0102.do", param);
		fn_popupDetail();
		fn_disabled();
		AUIGrid.resize(uploadFileGrid.id);
	});
	
	//승인버튼
	$("#btnRequestAC").click(function(){
		var items = AUIGrid.getCheckedRowItems(requestDmcGrid.id);
		if(items.length <= 0){
			alert("Request 정보를 선택해 주세요.");
			return;
		}
		if(confirm("승인하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		
var arJson = [];		
		
		// 수정된 행 아이템들(배열)		
		var editedItems = AUIGrid.getCheckedRowItems(requestDmcGrid.id);	
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].item.CRUD = 'U'; 			
			editedItems[i].item.LAST_UPDUSR = userId;
			editedItems[i].item.APPROVAL = "02";	
			
			arJson.push(editedItems[i].item);
		}		
		
		$.ajax({
			  url : './insertRequestForm.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {					
					  requestDmcGrid.load();			
				  } else {
					  AUIGrid.removeAjaxLoader(rerchMange.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	
	//반려버튼
	$("#btnRequestReturn").click(function(){
		var items = AUIGrid.getCheckedRowItems(requestDmcGrid.id);	
		if(items.length <= 0){
			alert("REQUEST 정보를 선택해 주세요.");
			return;
		}	
		if(items.length >= 2){
			alert("반려는 한건씩 가능합니다.");
			return;
		}
		if(confirm("반려 하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		
		var userIdSeq = items[0].item.RQESTER.substr(0,10);
		
		var seq = "CJ04" + items[0].item.RQESTER.substr(0,10) + items[0].item.SN + items[0].item.TASK_SN;
		p_seq_no = seq; //업무별 구분자 + 해당업무 seq
		console.log(seq);
		var param = {};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1102.do", param);
	});
	
});

$(window).resize(function(){
	if (typeof requestDmcGrid.id !== "undefined") {
		AUIGrid.resize(requestDmcGrid.id);
	}
});


function fn_callback(){
	var arJson = [];		
	
	// 수정된 행 아이템들(배열)		
	var editedItems = AUIGrid.getCheckedRowItems(requestDmcGrid.id);	
	for(var i = 0; i < editedItems.length; i++) {
		editedItems[i].item.CRUD = 'U'; 
		editedItems[i].item.LAST_UPDUSR = userId;
		editedItems[i].item.APPROVAL = "03";	
		
		arJson.push(editedItems[i].item);
	}		
	
	$.ajax({
		  url : './insertRequestForm.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {
			  if(data.success) {					
				  requestDmcGrid.load();					
			  } else {
				  AUIGrid.removeAjaxLoader(rerchMange.id);
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
}

function fn_userInfo(){
	$.ajax({
	    url: "./selectUserInfo.do",
	    type: "post",
	    dataType: "json",
	    data: {'USER_ID' : userId},//me.proxy.param,
	    success:function(data){
	    	if(data.success) {
	    		var item = data.result;		    		
	    		user_role_id = item[0].ROLE_ID;	    		
	    		user_role = item[0].ROLE_NM;
	    		user_dept = item[0].DEPT_NM;
	    		
	    		var params = {
	    				'TASK_NO': $("#SearchInput").val()
	    			   ,'USER_ID' : userId
	    			   ,'ROLE_ID' : user_role_id
	    			};
	    			
	    		    requestDmcGrid.proxy.param = params; 	
	    		    requestDmcGrid.createGrid();
	    	} else {	    		
	    		alert(data.message);
	    	}
	    },
		error : function(jqXHR, textStatus, errorThrown){
		alert(textStatus);
		}
	});
}

function fn_GridLoad(){
	requestDmcGrid.load();
}

var requestDmcGrid = {
		id: '',
	 	div: {
	 		gridDiv: '#requestDmcGrid',
	 		
	 	},
	 	proxy: {
	 		url: './selectRequestList.do',
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
		    showStateColumn: false,
		    showRowNumColumn : true,
		    showRowCheckColumn : true,	
		    reverseRowNum : true,
		    //enableColumnResize : false,
		    enableMovingColumn : false,
		    editable : false,
		    usePaging : true,
		    enableFilter : true,
		    headerHeight: 40,
		    rowHeight: 37,
		    displayTreeOpen : true
		    
		    
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
			dataField : "MODULESE",
			headerText : "모듈",
			visible : true,
			editable : false,	
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = requestDmcGrid;
				var retStr = "";
				for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
					if(me.columnLayout[2].editRenderer.list[i]['CODE'] == value) {
						retStr = me.columnLayout[2].editRenderer.list[i]['NAME'];
						break;
					}
				}
				return retStr == "" ? value : retStr;
		    },
		    editRenderer : {
     			type : "DropDownListRenderer",
     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
     			list : null,
     			keyField : "CODE",
     			valueField : "NAME"
     		 }
		},{
			dataField : "REQUSTSE",
			headerText : "요청구분",
			editable : true,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = requestDmcGrid;
				var retStr = "";
				for(var i=0; me.columnLayout[3].editRenderer.list.length > i; i++) {
					if(me.columnLayout[3].editRenderer.list[i]['CODE'] == value) {
						retStr = me.columnLayout[3].editRenderer.list[i]['NAME'];
						break;
					}
				}
				return retStr == "" ? value : retStr;
		    },
		    editRenderer : {
     			type : "DropDownListRenderer",
     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
     			list : null,
     			keyField : "CODE",
     			valueField : "NAME"
     		 }
		},{
			dataField : "SJ",
			headerText : "제목",
			editable : true
		},{
			dataField : "RQESTER",
			headerText : "요청자",
			visible : false,
			editable : true
		},{
			dataField : "USER_NM",
			headerText : "요청자",
			editable : true
		},{
			dataField : "ROLE",
			headerText : "역할",	
			editable : true
		},{
			dataField : "PSITN",
			headerText : "소속",	
			editable : true
		},{
			dataField : "FRST_CREDE",
			headerText : "등록일",	
			dataType : "date",
	 	 	formatString : "yyyy-mm-dd",
			editable : false,
			editable : true
		},{
			dataField : "STTUS",
			headerText : "상태",	
			editable : true,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {							
				var me = requestDmcGrid;				
				var retStr = "";
				for(var i=0; me.columnLayout[10].editRenderer.list.length > i; i++) {
					if(me.columnLayout[10].editRenderer.list[i]['CODE'] == value) {
						retStr = me.columnLayout[10].editRenderer.list[i]['NAME'];
						break;
					}
				}
				return retStr == "" ? value : retStr;
		    },
		    editRenderer : {
     			type : "DropDownListRenderer",
     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
     			list : null,
     			keyField : "CODE",
     			valueField : "NAME"
     		 }
		},{
			dataField : "FILE_MASTR_SN",
			headerText : "파일순번",	
			editable : true,
			visible : false
		},{
			dataField : "OPERT_HOPEDE",
			headerText : "작업희망일",	
			editable : true,
			dataType : "date",
	 	 	formatString : "yyyy-mm-dd",
			visible : false
		},{
			dataField : "CN",
			headerText : "내용",	
			editable : true,
			visible : false
		},{
			dataField : "SN",
			headerText : "순번",	
			editable : true,
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
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,//{'TASK_NO' : SearchData, 'USER_ID' : userId},
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		$("#SearchInput").val("");
	 		    	    //userId = data.USER_ID;
	 		    	    moduleCode = data.moduleCode;
	 		    	    requestCode = data.requestCode;
	 		    	    
	 		    	    me.columnLayout[2].editRenderer.list = data.moduleCode;
	 		    	    me.columnLayout[3].editRenderer.list = data.requestCode;
	 		    	    me.columnLayout[10].editRenderer.list = data.requestSttus;
	 		    		 			    	
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



</script>
</head>
<body>
<div id="wrap">

<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0401&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0401&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
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
                   
                    <!-- 컨텐츠 타이틀 끝-->
					<div>
						<span style="font-family:'NanumGothicBold';">과제번호  :</span>
						<input type="text" id="SearchInput"  class="pdR15">
						<input id="SearchBtn" type="button" class="btn mgL3" value="검색">
         			  
	         			<article class='conTitBtnR'>						
							<input id="btnRequestAdd" type="button"  value="등록">
							<input id="btnRequestAC" type="button"  value="승인">
							<input id="btnRequestReturn" type="button"  value="반려">
						</article>
          			 </div>
           
				
                    <!-- 그리드 시작 -->
                    <article class="mgT20">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->                        
                         <div id="requestDmcGrid" class="gridHeiSz17 grid_wrap tb01_2"></div>						 
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










