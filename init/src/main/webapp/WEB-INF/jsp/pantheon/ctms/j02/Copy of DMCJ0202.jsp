<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기관 조회</title>
<script type="text/javascript">	
var roleCodevalue;
var roleTaskSn;
var returnRoleValue; //사용자 권한팝업 데이터 저장
var returnTaskValue; //과제조회 팝업 데이터 저장
var gridDataCount = 0; //그리드 구분 1:grSend, 2:grReception
var roleUserId; //DMCJ1107 팝업오픈시 유저아이디 
var roleUserRoleId; //DMCJ1107 팝업오픈시 롤아이디
var roleUserInfo;
var radioCheck = "01";
var moduleData;   //모듈, 공지구분, 과제명 조회데이터
$(document).ready(function() {
	$("#txtInputTaskSN").val(""); 	
	/////////모듈 select box append
	var ModuleSelectBoxText;
 	for(var i=0; DMCJ01code.length > i; i++){
 		ModuleSelectBoxText += "<option value='"+DMCJ01code[i].CODE+"'>"+DMCJ01code[i].NAME+"</option>";
 	}
 	$("#selectModule").append(ModuleSelectBoxText);
 	/////////
 	
	grSend.createGrid();
	grReception.createGrid();
	
	
	
	$(":input:radio[name='noticeDivision']").click(function(){
		radioCheck = $(":radio[name='noticeDivision']:checked").val();
		$("#txtInputTaskSN").val("");
		$("#txtInputTaskNo").val("");
		//grSend.load();
		//grReception.load();
	});
	$("#btnSearchTask").click(function(){

		if(radioCheck == "02" ){
			var param={};
			 mkLayerPopupOpen("/DMCJ1106.do", param, 2);
		}
		
	});
	$("#btnList").click(function(){
		layerClose(1);	
		notice_sn = "";
	});
	
	AUIGrid.bind(grSend.id, "cellDoubleClick", function(event){		
		if(radioCheck == "02"){
			if($("#txtInputTaskSN").val() != ""){
				roleInfoCellClick(event);
				gridDataCount = 1;
			}else{
				alert("과제를 선택해 주세요");
				return;
			}
		}else if(radioCheck == "01"){
			roleInfoCellClick(event);
			gridDataCount = 1;
		}
	});	
	
	AUIGrid.bind(grReception.id, "cellDoubleClick", function(event){
		
		if(radioCheck == "02"){
			if($("#txtInputTaskSN").val() != ""){
				roleInfoCellClick(event);
				gridDataCount = 2;
			}else{
				alert("과제를 선택해 주세요");
				return;
			}
		}else if(radioCheck == "01"){
			roleInfoCellClick(event);
			gridDataCount = 2;
		}
		
		
	});
	
    
	//송신 그리드 행추가
	$('#btnLeftSave').click(function() {		
			var row = {						
					
					'ROLE_ID':   '',
					'USER_ID':   '',				
					'ROLE_NM':   '',					
					'RM': '',	
					'LAST_UPDUSR' : userId,
					'MANAGE_SE'   : 'C',
					'CRUD': 'C'	
					
			};		
			AUIGrid.addRow(grSend.id, row, 'first'); // 최상단에 행 추가
	});
	
	//수신 그리드 행추가
	$('#btnRightSave').click(function() {		
			var row = {		
					
					'ROLE_ID':   '',
					'USER_ID':   '',				
					'ROLE_NM':   '',					
					'RM': '',	
					'LAST_UPDUSR' : userId,
					'MANAGE_SE'   : 'R',
					'CRUD': 'C'		
					
			};		
			AUIGrid.addRow(grReception.id, row, 'first'); // 최상단에 행 추가		
	});
	
	//송신 그리드 행삭제
	$('#btnLeftDel').click(function() {	
		AUIGrid.removeCheckedRows(grSend.id);		
	});
	
	//수신 그리드 행삭제
	$('#btnRightDel').click(function() {
		AUIGrid.removeCheckedRows(grReception.id);
	});
	
	//그리드 저장
	$('#btnRoleSave').click(function() {
		var grSendIdRows = AUIGrid.getRowIndexesByValue(grSend.id, "USER_ID","");
		var grSendIdRole = AUIGrid.getRowIndexesByValue(grSend.id, "ROLE_ID","");
		var grReceptionIdRows = AUIGrid.getRowIndexesByValue(grReception.id, "USER_ID","");
		var grReceptionIdRole = AUIGrid.getRowIndexesByValue(grReception.id, "ROLE_ID","");
		//비어있는 그리드 감지
		if(grSendIdRows != "" || grSendIdRole != ""){
			alert("비어있는 행이 있습니다.");
			return;
		}
		//비어있는 그리드 감지
		if(grReceptionIdRows != "" || grReceptionIdRole != ""){
			alert("비어있는 행이 있습니다.");
			return;
		}
		if(confirm("저장하시겠습니까?") == true){
			//확인진행
		}else{
			return;
		}
		
		var arJson = [];
		var roleInfo = {'MODULE_SE' : $("#selectModule").val(), 'NOTICE_SE' : radioCheck, 
				'TASK_SN' : $("#txtInputTaskSN").val(), 'LAST_UPDUSR' : userId};
		
		arJson.push(roleInfo);
		
		$.ajax({
				  url : './insertNoticeManageData.do' ,
				  type: 'post',
				  contentType: "application/json; charset=UTF-8",
				  data : JSON.stringify(arJson),
				  success : function(data, textStatus, jqXHR) {
					  if(data.success) {							  
						   if(radioCheck == "01"){ //전체일때
							  insertGrSend();
							  insertGrReception();
							  
							  layerClose(1);	
						  }else{ //과제일때
							  if($("#txtInputTaskSN").val() == ""){ 	//과제순번이 비었을때
								  alert("과제를 선택해 주세요");
								  return;
							  }else{
								  insertGrSend();
								  insertGrReception();	
								 
								  layerClose(1);								  
								  notice_sn = "";
							  }
						  } 
					  } else {
						  
						  alert(data.message);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(textStatus);
				  }
			});
		console.log("close");
		NoticeRightGrid.load();
	});
	
});

//송신 그리드 저장
function insertGrSend(){
	var arJson = [];
	
	// 추가된 행 아이템들(배열)
	var addedRowItems = AUIGrid.getAddedRowItems(grSend.id);		
	// 수정된 행 아이템들(배열)
	var editedItems = AUIGrid.getEditedRowItems(grSend.id);
	// 삭제된 행 아이템들(배열)
	var removeItems = AUIGrid.getRemovedItems(grSend.id);
	
	for(var i = 0; i < addedRowItems.length; i++) {
		
		arJson.push(addedRowItems[i]);			
	}
	
	for(var i = 0; i < editedItems.length; i++) {
		editedItems[i].CRUD = 'U';
		editedItems[i].LAST_UPDUSR = userId;
		arJson.push(editedItems[i]);
	}
	
	for(var i = 0; i < removeItems.length; i++) {
		removeItems[i].CRUD = 'D';
		removeItems[i].LAST_UPDUSR = userId;
		arJson.push(removeItems[i]);
	}
	
	$.ajax({
		  url : './insertNoticeAuthor.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {
			  if(data.success) {
				 					   
			  } else {
				  AUIGrid.removeAjaxLoader(grSend.id);
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
}

//수신그리드 저장
function insertGrReception(){
var arJson = [];
	
	// 추가된 행 아이템들(배열)
	var addedRowItems = AUIGrid.getAddedRowItems(grReception.id);		
	// 수정된 행 아이템들(배열)
	var editedItems = AUIGrid.getEditedRowItems(grReception.id);
	// 삭제된 행 아이템들(배열)
	var removeItems = AUIGrid.getRemovedItems(grReception.id);
	
	for(var i = 0; i < addedRowItems.length; i++) {
		arJson.push(addedRowItems[i]);			
	}
	
	for(var i = 0; i < editedItems.length; i++) {
		editedItems[i].CRUD = 'U';
		editedItems[i].LAST_UPDUSR = userId;
		arJson.push(editedItems[i]);
	}
	
	for(var i = 0; i < removeItems.length; i++) {
		removeItems[i].CRUD = 'D';
		removeItems[i].LAST_UPDUSR = userId;
		arJson.push(removeItems[i]);
	}
	
	$.ajax({
		  url : './insertNoticeAuthor.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {			  
			  if(data.success) {
				    					   
			  } else {
				  AUIGrid.removeAjaxLoader(grReception.id);
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
}

//송/수신 그리드 cellClick
function roleInfoCellClick(event){
// 	roleUserRoleId = AUIGrid.getGridData(grSend.id);
	roleUserInfo   = AUIGrid.getGridData(grSend.id);	
		
	roleTaskSn = $("#txtInputTaskSN").val();
	$.ajax({
		    url: './selectCommonCodeList.do',
		    type: 'post',
 		dataType: 'json',
		    data: {'CMMN_CLCODE' : 'DMCJ03'},
		    success:function(data){
		    	if(data.success) {	 
		    		roleCodevalue = data.result;
		    		var param = {};
		    		mkLayerPopupOpen("/DMCJ1107.do", param, 3);
		    	} else {
		    		alert(data.message);
		    	}
		    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});		
}
//과제조회 팝업 데이터 저장
function fn_setTaskNo(){	
	$("#txtInputTaskNo").val(returnTaskValue.TASK_NO);
	$("#txtInputTaskSN").val(returnTaskValue.TASK_SN);	
}

//사용자 권한조회 팝업 데이터 그리드에 적용
function fn_serRoleInfo(event){
	var item = {'ROLE_ID':returnRoleValue.ROLE_ID, 'ROLE_NM':returnRoleValue.ROLE_NM, 
				'USER_ID':returnRoleValue.USER_ID, 'RM':returnRoleValue.RM};
	
    if(gridDataCount == 1){ //송신그리드
    	AUIGrid.updateRow(grSend.id, item, "selectedIndex"); //수신그리드 추가
    	var row = {		
    			
				'ROLE_ID':   '',
				'USER_ID':   '',				
				'ROLE_NM':   '',					
				'RM': '',	
				'LAST_UPDUSR' : userId,
				'MANAGE_SE'   : 'R',
				'CRUD': 'C'		
			
		};		
    	if(AUIGrid.isUniqueValue(grReception.id, 'USER_ID', event.item['USER_ID'] == true)
					&& AUIGrid.isUniqueValue(grReception.id, 'ROLE_ID', event.item['ROLE_ID']) == true) {
    		AUIGrid.addRow(grReception.id, row, 'first'); // 최상단에 행 추가
        	AUIGrid.updateRow(grReception.id, item, 0); // 송신그리드에 데이터가 입력되면 수신그리드에도 데이터를 입력한다.
			
		}
    	
    	gridDataCount = 0;
    	
    }else if(gridDataCount == 2){ //수신그리드 
    	AUIGrid.updateRow(grReception.id, item, "selectedIndex");	
    	gridDataCount = 0;
    }
	
}

//글쓰기 권한(송신) 그리드
var grSend = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grSend'
	 	},
	 	proxy: {
	 		url: './selectNoticeByPopup.do',
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
		    showStateColumn: true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : true,
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
			dataField : "SN", //0
			headerText : "순번",
			editable : false,
			visible : false
		},{
			dataField : "ROLE_ID", //1
			headerText : "권한 ID",
			editable : false,
			visible : false
		},{
			dataField : "ROLE_NM", //2
			headerText : "권한",
			editable : false
		},{
			dataField : "USER_ID", //3
			headerText : "ID",
			editable : false
		},{
			dataField : "RM", //4
			headerText : "설명",
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
	 		
	 	},
	 	load: function(v1, v2) {
	 		var me = this;	 		
	 		AUIGrid.showAjaxLoader(me.id);
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: {'MANAGE_SE' : 'C', 'NOTICE_SN' : notice_sn},//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 
	 		    		moduleData = data.result;
// 	 		    		//selectModule(모듈)
// 	 		    		$("#selectModule > option[value='"+moduleData[0].MODULE_SE+"']").attr("select", "true"); 	 		    	
// 	 		    		//noticeDivision(공지구분)
// 	 		    		$("input:radio[name='noticeDivision'][value='"+moduleData[0].NOTICE_SE+"']").prop("checked",true);
// 	 		    		//txtInputTaskSN(과제순번)
// 	 		    		$("#txtInputTaskSN").val(moduleData[0].TASK_SN);
//                         //txtInputTaskNo(과제번호)
//                         $("#txtInputTaskNo").val(moduleData[0].TASK_NO);
                        
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


//글보기 권한(수신) 그리드
var grReception = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grReception'
	 	},
	 	proxy: {
	 		url: './selectNoticeByPopup.do',
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
		    showStateColumn: true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : true,
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
			dataField : "SN", //0
			headerText : "순번",
			editable : false,
			visible : false
		},{
			dataField : "ROLE_ID", //1
			headerText : "권한 ID",
			editable : false,
			visible : false
		},{
			dataField : "ROLE_NM", //2
			headerText : "권한",
			editable : false
		},{
			dataField : "USER_ID", //3
			headerText : "ID",
			editable : false
		},{
			dataField : "RM", //4
			headerText : "설명",
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
	 		
	 	},
	 	load: function(v1, v2) {
	 		var me = this;	 		
	 		AUIGrid.showAjaxLoader(me.id);
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: {'MANAGE_SE' : 'R', 'NOTICE_SN' : notice_sn},//me.proxy.param,
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
	 	}
	};



window.onresize = function() {
	// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
	if (typeof grSend.id !== "undefined") {
		AUIGrid.resize(grSend.id);
	}
	if (typeof grReception.id !== "undefined") {
		AUIGrid.resize(grReception.id);
	}
	
};
</script>
</head>
<body>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<section class="popupWrap">
					<div class="popup popup1 wd1000" >	
						<section class="conBox100 conBox">
							<div class="conBoxInner">		
								<div class="conTitBtnR">
					                <input type="button" id="btnRoleSave" value="저장">
					                <input type="button" id="btnList" value="목록">  					                          
					            </div>					             
					            <table class="tb02">
					           		<tbody>
										<tr>
											<th>모듈</th>
											<td>
											<select id="selectModule" name="selectModule">								
																		
											</select>
											</td>
											<th>공지구분</th>
                                            <td>
                                                <input type="radio" id="rdAll" name="noticeDivision" value="01" checked><label for="rdAll" class="raLab"><span>전체</span></label>
                                                <input type="radio" id="rdTask" name="noticeDivision" value="02"><label for="rdTask" class="raLab"><span>과제</span></label>
                                            </td>
                                            <th>과제번호</th>
                                            <td>
                                            	<input type="hidden" id="txtInputTaskSN">
                                                <input type="text" id="txtInputTaskNo" disabled> <input type="button" id="btnSearchTask" value="조회" >
                                            </td>                                            
										</tr>										
									</tbody>
								</table>
								<table class="tb02">
									<tbody>
										<tr>
											<th>글쓰기 권한(송신)</th>  <th>글보기 권한(수신)</th>
										</tr>
									</tbody>
								</table>
								<table class="tb02">
									<tbody>
										<tr>
											<td>
												<div class="conTitBtnR">
						               				<input type="button" id="btnLeftSave" value="행추가">
						               			    <input type="button" id="btnLeftDel" value="삭제"> 					                          
						           				</div>
											</td>
											<td>
												<div class="conTitBtnR">
						               				<input type="button" id="btnRightSave" value="행추가">
						               			    <input type="button" id="btnRightDel" value="삭제"> 					                          
						           				</div>
											</td>
												
										</tr>										
									</tbody>									
								</table>
								<table>
									<tbody>
										<tr>
											<td>
												<!-- 그리드 시작 -->
							                    <article class="mgT10">
							                        <!-- 에이유아이 그리드가 이곳에 생성 -->							                        
							                        <div id="grSend" ></div> 
							                    </article>
							                    <!-- 그리드 끝 -->
											</td>
											<td>
												<!-- 그리드 시작 -->
							                    <article class="mgT10">
							                        <!-- 에이유아이 그리드가 이곳에 생성 -->							                       
							                        <div id="grReception" ></div>  
							                    </article>
							                    <!-- 그리드 끝 -->
											<td>
										</tr>										
									</tbody>									
								</table>
							</div>
						</section>
				    </div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>