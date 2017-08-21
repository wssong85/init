<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<style>


.aui-grid-template-renderer{}

.aui-grid-template-renderer-wrapper{ 
	 height:auto !important;
}

.search_yes{background:url(/images/pantheon/contents/search.png) no-repeat 0px 0px; display:inline-block; width:12px; height:12px; position: relative; top: 2px; left: 80%;  }

.tmp_style_01{ }
.tmp_style_01 .aui-grid-renderer-base .aui-grid-button-renderer{ padding:4px 2.2em 7px 1.2em;}

</style>

<script type="text/javascript">
var resultObj;
var gridItem = ""; //행추가할때 과제번호 복사
var gridrowIndex; //셀클릭 row
var irbList; //IRB 유무 공통코드
var sttus; //상태 공통코드
var editCnt = 0; //edit true(1)/false(0) 상태
var existingData; //기존데이터저장
var returnValue;//popup 결과
var returnCnt = 0; // 리턴 종류 없음(0),과제정보(1), 기관정보(2)
var userId ; //로그인한 유저 ID
var taskNo;
var rsrchOverLapitems; //중복체크 조회한 데이터 담기
var p_cntrct_sttus = "N";

$(document).ready(function() {
	$("#btnAddrow").hide();
	$("#btnRowDel").hide();	
	$("#btnSave").hide();
	$("#btnX").hide();
	$.ajax({
		    url: './selectPaperContractList.do',
		    type: 'post',
		    dataType: 'json',
		    data: {
		    	//'CMMN_CLCODE' : 'CTMS001'
		   	},
		    success:function(data){
		    	if(data.success) {
		    		irbList = data.irbList;		
			    			    	
		    	} else {
		    		alert(data.message);
		    	}
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	
	paperGrid.createGrid();

	//더블클릭
	AUIGrid.bind(paperGrid.id, "cellDoubleClick", auiGridcellClickHandler); //check Click
	//클릭
	AUIGrid.bind(paperGrid.id, "cellClick", function(event){
		gridItem = event.item;
		gridrowIndex = event.rowIndex;
	}); //check Click
	

	

	//메뉴하단 행추가
	$('#btnAddrow').click(function() {
		AUIGrid.setProperty(paperGrid.id, "editable" , true ); 
		editCnt = 1;
		var row = {			
				'CNTRCT_SN' : '',
				'TASK_SN': gridItem.TASK_SN,
				'TASK_NO': gridItem.TASK_NO,
				'INSTT_CODE' : '',
				'HSPTL_NM': '',
				'USER_NM': '',
				'USER_ID': '',
				'EMAIL': '',
				'TELNO': '',
				'GOAL_NO': '',
				'IRB_AT': '',
				'STTUS': '',
				'FILE_CNT' : '0',
				'ATCH_FILE': '',
				'ATCHMNFL': '',
				'UPDATE_ID': userId,
				'LAST_UPDDE': '',				
				'USE_AT': 'Y',
				'CONFM_ENNC' : '',
				'KUNNR' : '',
				'CURD': 'C',
				'ROLE_ID' : 'ROLE_PI'
		};
		if(gridItem == ""){
			AUIGrid.addRow(paperGrid.id, row, 'first'); // 최하단에 행 추가
		}else{
			AUIGrid.addRow(paperGrid.id, row, gridrowIndex+1); 
		}
		
	});
	
	$('#SERCHBUTTON').click(function(){		
		taskNo = $("#TASK_NO").val();
		paperGrid.load();
		AUIGrid.setProperty(paperGrid.id, "editable" , false ); 
	});
	
	$('#btnUpdateYN').click(function(){			
	    editCnt = 1;		    
	 	AUIGrid.setProperty(paperGrid.id, "editable" , true );
 		$("#btnAddrow").show();
		$("#btnRowDel").show();	
		$("#btnSave").show();
		$("#btnX").show();
	    $("#btnUpdateYN").hide();
	});
	
	$("#btnX").click(function(){
		editCnt = 0;
		gridItem = "";
		AUIGrid.setProperty(paperGrid.id, "editable" , false );		
		$("#btnAddrow").hide();
		$("#btnRowDel").hide();	
		$("#btnSave").hide();
		$("#btnX").hide();
	    $("#btnUpdateYN").show();	    
	    AUIGrid.resetUpdatedItems(paperGrid.id, "d" );
	    AUIGrid.setSelectionByIndex(paperGrid.id, 0 );
	});
	
	
	
	//메뉴하단 행삭제
	$('#btnRowDel').click(function() {
		AUIGrid.removeRow(paperGrid.id, "selectedIndex");
		
		
	});
	
	AUIGrid.bind(paperGrid.id, "cellEditEnd", function(event) {
		if(event.columnIndex == 6){
			
		}

	});
	
	//메뉴상단 저장
	$('#btnSave').click(function() {
		//아이디 과제 중복체크	
		var selectGrid = AUIGrid.getSelectedItems(paperGrid.id);
		console.log(selectGrid[0].rowIndex);
		var overlapItems = AUIGrid.getItemByRowIndex(paperGrid.id, selectGrid[0].rowIndex); 
		var dataResult = [];
		
		//console.log(dataReslut);		
		
		//그리드 모든 데이터
		var getGridItems = AUIGrid.getGridData(paperGrid.id);
		var rowIndex = AUIGrid.getRowCount(paperGrid.id);
		
		for(var i=0; i<rowIndex; i++ ){
			if(!getGridItems[i].TASK_SN){alert("과제를 선택해 주세요.");  AUIGrid.setSelectionByIndex(paperGrid.id, i, 2); return;}
			if(!getGridItems[i].INSTT_CODE){alert("기관을 선택해주세요."); AUIGrid.setSelectionByIndex(paperGrid.id, i, 4); return;}			
			if(!getGridItems[i].USER_NM){alert("연구자명을 입력해주세요."); AUIGrid.setSelectionByIndex(paperGrid.id, i, 5); return;}
			if(!getGridItems[i].USER_ID){alert("아이디를 입력해주세요."); AUIGrid.setSelectionByIndex(paperGrid.id, i, 6); return;}
			if(!getGridItems[i].EMAIL){alert("이메일을 입력해주세요."); AUIGrid.setSelectionByIndex(paperGrid.id, i, 7); return;}
			if(!getGridItems[i].GOAL_NO){alert("목표례수를 입력해 주세요."); AUIGrid.setSelectionByIndex(paperGrid.id, i, 9); return;}
			if(!getGridItems[i].IRB_AT){alert("IRB 유무를 선택해 주세요."); AUIGrid.setSelectionByIndex(paperGrid.id, i, 10); return;}
			
		}
		
		if(confirm("저장하시겠습니까?") == true){
			//확인 진행
		}else{
			return;
		}
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(paperGrid.id);
		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(paperGrid.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(paperGrid.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = userId;
			arJson.push(editedItems[i]);
		}
		$.ajax({
			  url : './insertPaperContractByCNT.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {						   
					   AUIGrid.setProperty(paperGrid.id, "editable" , false ); 
					   editCnt = "0";
					   paperGrid.load();
				  } else {
					  
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	}); 
});



function fn_OverLap(){
		
	if(rsrchOverLapitems[0].USE_YN == "Y"){
		alert("중복된 아이디가 있습니다.");
		console.log("22222");
		return;
	}
		
}

function fn_setTaskNo(){
	
	fn_setInstt();
	
}
function fn_setRsrchUserInfo(){
	var item = {
		   INSTT_CODE : returnValue.INSTT_CODE
	     , HSPTL_NM : returnValue.HSPTL_NM
	     , USER_ID : returnValue.USER_ID
	     , USER_NM : returnValue.USER_NM
	     , EMAIL : returnValue.EMAIL
	     , TELNO : returnValue.TELNO		
	};
	AUIGrid.updateRow(paperGrid.id, item, "selectedIndex");
	//AUIGrid.setProperty(paperGrid.id, "editable" , true );
}

function fn_setUserId(){
	var item = {
			   USER_ID : returnValue.USER_ID		    
		};
		AUIGrid.updateRow(paperGrid.id, item, "selectedIndex");
		//AUIGrid.setProperty(paperGrid.id, "editable" , true );
}

function fn_setUserInfo(){
	var item = {TASK_SN : returnValue.TASK_SN
		  , TASK_NO : returnValue.TASK_NO
		  , INSTT_CODE : returnValue.INSTT_CODE
		  , HSPTL_NM : returnValue.INSTT_NAME
		  ,	USER_ID : returnValue.USER_ID
		  , USER_NM : returnValue.USER_NM
		  ,	EMAIL : returnValue.EMAIL
		  , TEL_NO : returnValue.TELNO  
	}; 
	AUIGrid.updateRow(paperGrid.id, item, "selectedIndex");
	
}
	 
	
function fn_setInstt(){

	var item; 
	
	switch(returnCnt){
	case "1" : //과제정보
		item = {TASK_NO : returnTaskValue.TASK_NO, TASK_SN : returnTaskValue.TASK_SN}; 
		break;
	case "2" : //기관정보
		item = {INSTT_CODE : returnValue.KUNNR
			  , HSPTL_NM : returnValue.INSTT_NAME
			  , KUNNR : returnValue.KUNNR
			  , ADDRESS : returnValue.ADDRESS
			  , ORT01 : returnValue.ORT01
			  , STRAS : returnValue.STRAS
			  , PSTLZ : returnValue.PSTLZ
			  , REGIO : returnValue.REGIO
				}; 		
		break;
	
	default :
	}
	AUIGrid.updateRow(paperGrid.id, item, "selectedIndex");
	
}
function fn_rsrchCallback(){
	//AUIGrid.setProperty(paperGrid.id, "editable" , true );
}

////cell Click 메소드
function auiGridcellClickHandler(event){
	
// 	gridItem = event.item;
// 	gridrowIndex = event.rowIndex;
	
	if(editCnt == 1){
		if(event.columnIndex == "4"){
			returnCnt = "2"; //기관정보
			p_instt_name = "";		
			p_instt_type = "";
			p_taskSn = "";
			var param = {};
			mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
			
		}
		if(event.columnIndex == "5"){ //연구자 정보			
			if(!gridItem.TASK_SN){
				alert("과제를 선택해 주세요");
				return;
			}
			var param = {};
			mkLayerPopupOpen("/ctms/j11/popupDMCJ1108.do", param, 1);
			AUIGrid.setProperty(paperGrid.id, "editable" , false );
			AUIGrid.resize(rsrchGrid.id);
		}
		
		if(event.columnIndex == "2"){ //과제검색 컬럼 
			returnCnt = "1"; //과제정보				
			p_task_no = "";
			p_user_nm = "";
			var param = {};
			mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
		}
		
		if(event.columnIndex == "6"){ //ID 입력팝업 
			if(!gridItem.TASK_SN){
				alert("과제를 선택해 주세요");
				return;
			}
			var param = {};
			mkLayerPopupOpen("/ctms/f01/popupCTMF0106.do", param, 1);
		}
		
	}
	
	
}



var paperGrid = {
	 	id: 'paperGrid',
	 	div: {
	 		gridDiv: '#paperGrid'
	 	},
	 	proxy: {
	 		url: './selectPaperContractList.do',
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
		    usePaging : true,
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
		    selectionMode : "multipleCells",
            //rowIdField : "USER_ID",
		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "CNTRCT_SN", //0
			headerText : "계약순번",
			editable : true,
			visible : false,			
			width: 120
		},{
			dataField : "TASK_SN", //1
			headerText : "과제순번",
			editable : true,			
			visible : false,
			width: 120
		},{
			dataField : "TASK_NO", //2
			headerText : "과제번호<span class='must_01'></span>",
			editable : false,
			filter : {
				showIcon : true
			},
			width: 200,
			renderer: {
	 			type: 'TemplateRenderer'
	 		},
		
			labelFunction : function(rowIndex, columnIndex, value, headerText, item ) {
				
				if(item.TASK_NO == "" || item.TASK_NO == null) {					
					return "<span class='search_yes'></span>";
				}else{
					return item.TASK_NO;
				}
			}
		},{
			dataField : "INSTT_CODE", //3
			headerText : "기관코드<span class='must_01'></span>",
			editable : true,			
			visible : false,
			width: 120
		},{
			dataField : "HSPTL_NM", //4
			headerText : "기관명<span class='must_01'></span>",
			editable : false,
			filter : {
				showIcon : true
			},
			width: 200,
			renderer: {
	 			type: 'TemplateRenderer'
	 		},
		
			labelFunction : function(rowIndex, columnIndex, value, headerText, item ) {
				
				if(item.HSPTL_NM == ""  || item.HSPTL_NM == null) {
					return "<span class='search_yes'></span>";
				}else{
					return item.HSPTL_NM;
				}
			}
		},{
			dataField : "USER_NM", //5
			headerText : "연구자<span class='must_01'></span>",
			editable : true,	
			filter : {
				showIcon : true
			},
			
			editRenderer : {
	 			type: "InputEditRenderer", 	
	 			showEditorBtnOver : true,
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 200){ 
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
	 		},
		},{
			dataField : "USER_ID", //6
			headerText : "ID<span class='must_01'></span>",
			width : 120,
			filter : {
				showIcon : true
			},
			editable : false,			
		},{
			dataField : "EMAIL", //7
			width : 150,
			headerText : "e-mail<span class='must_01'></span>",	
			editable : true,
			filter : {
				showIcon : true
			},			
			editRenderer : {
	 			type: "InputEditRenderer", 			
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 100){ 
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
	 		},
		},{
			dataField : "TELNO", //8
			headerText : "전화번호",
			width : 120,
			filter : {
				showIcon : true
			},
			editable : true,
			editRenderer : {
	 			type: "InputEditRenderer", 			
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 20){ 
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
	 		},
		},{
			dataField : "GOAL_NO", //9
			headerText : "목표례수<span class='must_01'></span>",
			width : 100,
			filter : {
				showIcon : true
			},
			editable : true,
			editRenderer : {
	 			type: "InputEditRenderer", 			
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 8){ 
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
	 		},
		},{
			dataField : "IRB_AT", //10
			headerText : "IRB 여부<span class='must_01'></span>",	
			filter : {
				showIcon : true
			},
			labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
				var me = paperGrid;
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
			dataField : "STTUS", //11
			headerText : "상태",
			filter : {
				showIcon : true
			},
			editable : false,
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
     		}
		},{
			dataField : "STTUS_DTE", //12
			headerText : "상태날짜",
			dataType : "date",
			width : 100,
			formatString : "yyyy-mm-dd",
			filter : {
				showIcon : true
			},
			editable : false
		},{
			dataField : "FILE_CNT", //13
			headerText : "계약서",	
			width : 88,
			maxWidth : 88,
			style: "tmp_style_01",
			renderer : {
				type : "ButtonRenderer",				
				onclick : function(rowIndex, columnIndex, value, item){
					 var param = {							 
							 parent_value : item.ATCH_FILE
						};
					//AUIGrid.removeAjaxLoader(myGridID);
					if(item.ATCH_FILE != null || item.ATCH_FILE != '0'){
						mkLayerPopupOpen("/ctms/f01/popupCTMF0104.do", param);
					}
				}
			},
			editable : false	
		},{
			dataField : "",  //14
			headerText : "업로드",	
			width : 120,
			maxWidth : 120,
			style: "tmp_style_01",
			renderer : {
				type : "ButtonRenderer",
				labelText: "Upload",
				onclick : function(rowIndex, columnIndex, value, item){
					 var param = {					 
							 PROGRAM_ID : "CTMF0103"
							,FILE_SN : item.ATCH_FILE
					 };
					 mkLayerPopupOpen("/ctms/j11/popupDMCJ1105.do", param, 1);
					 console.log(item.ATCH_FILE);
				}
			},
			editable : false	
		},{
			dataField : "ATCH_FILE",  //15
			headerText : "파일순번",
			editable : false,
			visible : false
		},{
			dataField : "KUNNR", //16
			headerText : "KUNNR",
			editable : false,
			visible : false
		},{
			dataField : "PSTLZ", //16
			headerText : "PSTLZ",
			editable : false,
			visible : false
		},{
			dataField : "ORT01", //16
			headerText : "ORT01",
			editable : false,
			visible : false
		},{
			dataField : "STRAS", //16
			headerText : "STRAS",
			editable : false,
			visible : false
		},{
			dataField : "ROLE_ID", //16
			headerText : "ROLE_ID",
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
	 	 	AUIGrid.bind(paperGrid.id, "cellEditBegin", function(event){
	 		// 추가된 행 아이템인지 조사하여 추가된 행인 경우만 에디팅 진입 허용
// 	 		if(event.dataField == "EMAIL"){
// 	 			if(AUIGrid.isAddedById(paperGrid.id, "EMAIL") == true){
// 	 				return true;
// 	 			}else{
// 	 				return false; // false 반환하면 기본 행위 안함(즉, cellEditBegin 의 기본행위는 에디팅 진입임)
// 	 			}
// 	 		}
	 		return true; // 다른 필드들은 편집 허용
	 	});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;	 		
	 		
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: {'TASK_NO' : taskNo},//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 		 		    		
	 		    	    userId = data.USER_ID;
	 		    	    irbList = data.irbList;
	 		    	    me.columnLayout[10].editRenderer.list = data.irbList;	
	 		    	    existingData = data.result;
	 		    	    sttus = data.sttus;	 		    	   
	 			    	
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	 			    	
	 			    	AUIGrid.setProperty(paperGrid.id, "editable" , false ); 
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





function fn_validator(value){
	var string = "";
	
	string += value;
	
	var stringLength = string.length;
	var stringByteLength = 0;
	
	stringByteLength = (function(s,b,i,c){
		for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		return b;
	})(string);
	console.log(stringByteLength + " Bytes"); 
	
	validatorCnt = stringByteLength;
}







$(window).resize(function(){
	if (paperGrid.id) {
		AUIGrid.resize(paperGrid.id);
	}	
});


</script>
</head>
<body>	
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMF0103&UPPER_MENU_ID=CTMF" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMF0103&UPPER_MENU_ID=CTMF" charEncoding="utf-8"/>
<div id="wrap">

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

                  	

                    <article class="conTitBtn">
                        <div class="conTitBtnL">
							<form id="frm" name="frm">                      	
								<span style="font-family:'NanumGothicBold';">과제번호  :</span>
								<input type="text" id="TASK_NO" name="TASK_NO" class="pdR15">	    	
								<input type="button" id="SERCHBUTTON" name = "SERCHBUTTON" value="검색">	
							</form>
                        </div>

                        <div class="conTitBtnR">
							<input type="button" id="btnAddrow" value="신규" >
							<input type="button" id="btnRowDel" value="삭제" >
							<input type="button" id="btnUpdateYN" value="수정">
							<input type="button" id="btnSave" value="저장" >
							<input type="button" id="btnX" value="X" >                            
                        </div>
                    </article>


                    <article class="mgT55">
                        <div id="paperGrid" class="gridHeiSz15 grid_wrap tb01_2"></div>                        
                    </article>


                </div>

            </section>

     
       </div>
	</section>
</div>
</body>
</html>









