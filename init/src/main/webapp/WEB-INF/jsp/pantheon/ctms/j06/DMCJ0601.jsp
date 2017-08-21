<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>연구자 관리</title>
<script type="text/javascript">

var userId = '${loginMap.USER_ID}'; //로그인한 유저 ID
var validatorCnt;
var rejdgeMerge;
var sttusCode019;
var sttusCode020;
var p_seq_no;
var sendEmail = "";
var userName = "";
//AUIGrid 생성 후 반환 ID

$(document).ready(function() {
	rerchMange.createGrid();
	//연구자검색버튼
	$("#btnRsrchSearch").click(function(){ 
		var param = {};
		mkLayerPopupOpen("./popupDMCJ0602.do", param);
		AUIGrid.resize(rsrchSearch.id);
	});
	
	//승인버튼	
	$("#btnAcknowledgment").click(function(){ 
		var items = AUIGrid.getCheckedRowItems(rerchMange.id);		
		if(items.length <= 0){
			alert("연구자 정보를 선택해 주세요.");
			return;
		}	
		
		if(confirm("승인하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		var arJson = [];		
		
		// 수정된 행 아이템들(배열)		
		var editedItems = AUIGrid.getCheckedRowItems(rerchMange.id);	
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].item.CRUD = 'U'; //승인
			editedItems[i].item.LAST_UPDUSR = userId;
			editedItems[i].item.APPROVAL = "03";	
			
			arJson.push(editedItems[i].item);
		}		
		
		$.ajax({
			  url : './insertRsrchManage.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {					
					  rerchMange.load();					
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
	$("#btnCompanion").click(function(){
		var items = AUIGrid.getCheckedRowItems(rerchMange.id);	
		if(items.length <= 0){
			alert("연구자 정보를 선택해 주세요.");
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
		
		

		var userIdSeq = items[0].item.USER_ID.substr(0,10);
		
		
		var seq = "CJ06" + items[0].item.USER_ID.substr(0,10) + items[0].item.INSTT_CODE + items[0].item.TASK_SN;
		p_seq_no = seq; //업무별 구분자 + 해당업무 seq
		console.log(seq);
		var param = {};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1102.do", param);
	});
	
	//삭제버튼
	$("#btnDelete").click(function(){
		var removeItems = AUIGrid.getCheckedRowItems(rerchMange.id);
		if(removeItems.length <= 0){
			alert("연구자 정보를 선택해 주세요.");
			return;
		}	
		if(confirm("삭제 하시겠습니까?") == true){			
			//확인 진행
		}else{
			return;
		}
		
		var arJson = [];		
		
		// 삭제된 행 아이템들(배열)
		//var removeItems = AUIGrid.getCheckedRowItems(rerchMange.id);
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].item.CRUD = 'D';
			removeItems[i].item.LAST_UPDUSR = userId;
			arJson.push(removeItems[i].item);
		}
		
		$.ajax({
			  url : './insertRsrchManage.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  rerchMange.load();
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
	
	$("#btnPwReissuance").click(function(){
		
		var items = AUIGrid.getCheckedRowItems(rerchMange.id);		
		if(items.length >= 2){
			alert("이메일전송은 한건씩 가능합니다.");
			return;
		}	
		
		userName = items[0].item.USER_NM;
		sendEmail = items[0].item.EMAIL;
			
		console.log(sendEmail);
	    if(sendEmail == ""){
	    	alert("연구자정보를 선택해 주세요.");
	    	return;
	    }
		
		if(confirm("이메일을 발송하시겠습니까? "+sendEmail) == true){			
			//확인 진행
		}else{
			return;
		}
		var arJson = [];
		var emailInfo = {"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/};
		arJson.push(emailInfo);
		


		$.ajax({
 		    url: './insertPasswordEmail.do',
 		    type: 'post', 		
			contentType: "application/json; charset=UTF-8",
 		    dataType: 'json',
 		    data: JSON.stringify(arJson), 		  
 		    success:function(data){
 		    	sendEmail = "";
 		    	userName = "";
 		    	if(data.success) {
 		    		 			    	
 		    	} else { 		    		
 		    		alert(data.message);
 		    	}
 		    },
 		    error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
				alert(errorThrown);
				alert(jqXHR.responseText);				
			}
			
 		});
  	});
	
});
function fn_callback(){
	var arJson = [];		
	
	// 수정된 행 아이템들(배열)		
	var editedItems = AUIGrid.getCheckedRowItems(rerchMange.id);	
	for(var i = 0; i < editedItems.length; i++) {
		editedItems[i].item.CRUD = 'U'; 
		editedItems[i].item.LAST_UPDUSR = userId;
		editedItems[i].item.APPROVAL = "04";	
		
		arJson.push(editedItems[i].item);
	}		
	
	$.ajax({
		  url : './insertRsrchManage.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {
			  if(data.success) {					
				  rerchMange.load();					
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

var rerchMange = {
	 	id: 'rerchMange',
	 	div: {
	 		gridDiv: '#rerchMange'
	 	},
	 	proxy: {
	 		url: './selectRsrchManage.do',
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
		    showRowCheckColumn : true,
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
			dataField : "TASK_SN",
			headerText : "과제순번",
			editable : false,
			visible : false
		},{
			dataField : "TASK_NO",
			headerText : "과제번호",
			width : 120,
			editable : false	
		},{
			dataField : "INSTT_CODE",
			headerText : "기관코드",
			editable : false,
			visible : false
		},{
			dataField : "HSPTL_NM",
			headerText : "기관명",	
			width : 150,
			editable : false
		},{
			dataField : "ADDRONE",
			headerText : "시도",
			width : 200,
			editable : false			
		},{
			dataField : "ADDRTWO",//5
			headerText : "지역",
			editable : false			
		},{
			dataField : "USER_NM",
			headerText : "연구자",	
			editable : false
		},{
			dataField : "USER_ID",
			headerText : "ID",
			width : 100,
			editable : false
		},{
			dataField : "EMAIL",
			headerText : "E-mail",
			width : 120,
			editable : false
		},{
			dataField : "TELNO",
			headerText : "전화번호",
			width : 120,
			editable : false
		},{
			dataField : "GOAL_NO",//10
			headerText : "목표례수",	
			editable : false
		},{
			dataField : "IRB_AT",
			headerText : "IRB여부",	
			editable : false
		},{
			dataField : "CONFM_SE",
			headerText : "승인여부",	
			editable : false,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = rerchMange;
				var retStr = "";
				
				for(var i=0; me.columnLayout[12].editRenderer.list.length > i; i++) {
					if(me.columnLayout[12].editRenderer.list[i]['CMMN_CODE'] == value) {
						retStr = me.columnLayout[12].editRenderer.list[i]['CMMN_CODE_NM'];
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
			dataField : "STTUS",
			headerText : "상태",	
			editable : false,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = rerchMange;
				var retStr = "";
				
				for(var i=0; sttusCode020.length > i; i++) {
					if(sttusCode020[i]['CMMN_CODE'] == value && value == "07" || value == "08") {
						retStr = sttusCode020[i]['CMMN_CODE_NM'];
						break;
					}else if(sttusCode019[i]['CMMN_CODE'] == value && value != ""){
						retStr = sttusCode019[i]['CMMN_CODE_NM'];
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
			dataField : "STTUS_DTE",
			headerText : "상태날짜",	
			editable : false,
			dataType : "date",
			width : 120,
	        formatString : "yyyy-mm-dd"
		},{
			dataField : "CNTRCT_SE",//14
			headerText : "구분",
			width : 120,
			editable : false,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = rerchMange;
				var retStr = "";
				
				for(var i=0; me.columnLayout[15].editRenderer.list.length > i; i++) {
					if(me.columnLayout[15].editRenderer.list[i]['CMMN_CODE'] == value) {
						retStr = me.columnLayout[15].editRenderer.list[i]['CMMN_CODE_NM'];
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
	 		    		me.columnLayout[15].editRenderer.list = data.cmCode1; //계약 구분
	 		    		sttusCode019 = data.cmCode2; //전자계약 상태
	 		    		sttusCode020 = data.cmCode3; //Paper계약 상태
	 		    		me.columnLayout[12].editRenderer.list = data.cmCode4;//승인여부
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



$(window).resize(function(){
	if (typeof rerchMange.id !== "undefined") {
		AUIGrid.resize(rerchMange.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0601&UPPER_MENU_ID=DMCJ" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0601&UPPER_MENU_ID=DMCJ" charEncoding="utf-8" />
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
	  <!-- 컨텐츠박스 시작-->
                   

            <section class="conBox100 conBox">
                <div class="conBoxInner">



                    <article class="conTitBtnR">
                        <input type="button" id="btnRsrchSearch" value="연구자검색">
                        <input type="button" id="btnPwReissuance" value="P/W 재발급">
                        <input type="button" id="btnAcknowledgment" value="승인">
                        <input type="button" id="btnCompanion" value="반려">
                        <input type="button" id="btnDelete" value="삭제">                        
                    </article>



                    <article class="mgT44">
                         <div id="rerchMange" class="gridHeiSz15 grid_wrap tb01_2"></div>
                    </article>


                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
		</div>
	</section>
</div>
</body>
</html>










