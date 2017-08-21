<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

 
<head>

<jsp:include page="/com/common.do" flush="false"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
var columnLayout; // 컬럼레이아웃 저장
var taskCnt;
var taskNoGrid;
var accHeaderId;
var delHeaderId; //삭제할 그리드 id저장
var delSearch;   //검색버튼 클릭 할때 삭제할 id저장
var initId ="";  
var buttonId;
var addGridId; //행추가할 그리드 이름
var addGridData;
var userId;
var userSelectId = "${map.USER_ID}";
var taskEndAt = "N";


$(document).ready(function() {
	selectGrid();
	
	$("#StautsBtn").click(function(){
		$(location).attr("href","/ctms/b03/CTMB0302.do");
	});
	

	//메뉴하단 행추가
	$(document).on("click","#addButton",function() {
		//console.log("resultObj[0].TASK_SN:::"+resultObj.TASK_SN);
		AUIGrid.setProperty(addGridId, "editable" , true );
		var row = {			
				'TASK_SN' : addGridData[0].TASK_SN
				,'PRODUCT_NM' : addGridData[0].PRODUCT_NM
				,'TASK_NM': addGridData[0].TASK_NM
				,'STUDY_NM':addGridData[0].STUDY_NM 
				,'TRGTER_CO':addGridData[0].TRGTER_CO
				,'VISIT_INFO':''
				,'COST':''
				,'VER':addGridData[0].VER			
				,'USE_AT': 'Y'
				,'FRST_CREDE' : new Date()	
				,'FRST_CRTR' :userSelectId
				,'LAST_UPDDE': new Date()
				,'LAST_UPDUSR': userSelectId
				,'CRUD': 'C'
		};		
		
			AUIGrid.addRow(gridP, row, 'first'); // 최상단에 행 추가
		
		
		
	});
	
	//메뉴하단 행삭제
	$(document).on("click","#delButton",function(){	
		AUIGrid.removeRow(addGridId, "selectedIndex");
	});
	
	//수정버튼 클릭
	$(document).on("click","#modiButton",function(){	
		AUIGrid.setProperty(addGridId, "editable" , true );
		console.log("addGridId:::"+addGridId);
		$("#modiButton").hide();
		$("#addButton").show();
		$("#delButton").show();
		$("#saveButton").show();
		$("#XButton").show();
	});
	
	$(document).on("click", "#XButton", function(){
		btnController();
		AUIGrid.resetUpdatedItems(addGridId, "d" );
		AUIGrid.setProperty(addGridId, "editable" , false );	
	});
		
	
	
	//메뉴상단 저장
	$(document).on("click","#saveButton",function() {
		var subItem = accHeaderId.substring(0,accHeaderId.length-1);
		console.log(subItem);
		var itemData = AUIGrid.getGridData(subItem);
		console.log(itemData[0].VISIT_INFO);
		
		for(var i=0; i<itemData.length; i++){
			if(itemData[i].VISIT_INFO == ""){
				alert("VISIT 정보를 입력해 주세요.");
				return;
			}
		}
		
		if(confirm("저장하시겠습니까?") == true){
			//확인 진행
		}else{
			return;
		}
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(addGridId);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(addGridId);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(addGridId);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CRUD = 'U';
			editedItems[i].LAST_UPDUSR = userSelectId;			
			arJson.push(editedItems[i]);
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CRUD = 'D';
			removeItems[i].LAST_UPDUSR = userSelectId;			
			arJson.push(removeItems[i]);
		}
		$.ajax({
			  url : './insertAssignmentbyNisGrid.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {	
					   AUIGrid.destroy(addGridId);
					   createGrid();
					   AUIGrid.setProperty(addGridId, "editable" , false );
					  
				  } else {
					  AUIGrid.removeAjaxLoader(addGridId);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
		
	});
	
	
	$("#StautsBtn").click(function(){
		$(location).attr("href","/ctms/b03/CTMB0302.do");
	});
	//버튼 클릭시 해당 모듈 이동
// 	$(document).on("click","#dmcBtn",function() {
// 		//$(location).attr("href","http://localhost:8080/sample/accordion.do");
// 		alert("dmc");
// 		console.log(buttonId);
// 	});
	$(document).on("click","#ctmsBtn",function() {
		alert("ctms");		
		console.log(buttonId);
	});
	$(document).on("click","#edcBtn",function() {
		alert("edc");
		console.log(buttonId);
	});
	$(document).on("click","#iwrsBtn",function() {
		alert("iwrs");
		console.log(buttonId);
	}); 
	
	$("#myButton").click(function(){	
	
		$("#acdMenu01").empty();
		
		//acdMenu();	
		selectGrid($("#myInput").val());
	});
	
	
	
});

function selectGrid(grid){
	$(function(){
		$.ajax({
			  url : './selectNISTask_NoList.do',		
			  data : {'TASK_NO' : grid, 'USER_ID' : userSelectId, 'TASK_END_AT' : taskEndAt},
			  success : function(data, textStatus, jqXHR) {
			  taskCnt = data.result;				 
				  if(data.success) {
					  if(data.result == ""){
						  return;
					  }			  
					  acdMenu();		
					  
				  } else {
					  
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});	
	});
}


//accordion id 받기
function accHeader(id){		
	
	accHeaderId = id;
	var del = delHeaderId.substring(0,delHeaderId.length-1);	
	AUIGrid.destroy(del);
	AUIGrid.destroy(delSearch);
	delSearch="";

	
}
function btnController(){	
	$("#modiButton").show();
	$("#addButton").hide();
	$("#delButton").hide();
	$("#saveButton").hide();
	$("#XButton").hide();
}

//button id 받기
function accButton(id){	
	buttonId = id.substring(0,id.length-1);
}

function acdMenu(){
    var rows = taskCnt.length;
	var taskInfo = taskCnt;
	var taskTag = "";
	
	if(rows > 0){
		taskNoGrid=taskInfo[0].TASK_NO;
		initId=taskInfo[0].TASK_NO;		
		accHeaderId=taskInfo[0].TASK_NO+"Z";
	}			
		
	for(i=0; i<rows; i++){		
		
		taskTag += "<li class='acdMenuLst acdMenuLst01'>";
		taskTag += "    <a class='acdMenuLik close' id='"+taskInfo[i].TASK_NO+"Z"+"' onclick='javascript:accHeader(this.id)'>"+taskInfo[i].TASK_NO+"</a>";
		taskTag += "    <div class='acdBtnGr' id='"+taskInfo[i].TASK_NO+"A"+"' onclick='javascript:accButton(this.id)'>";
// 		taskTag += "    	<input id= 'dmcBtn' class='acdBtn' type='button' value='DMC'>";
		taskTag += "    	<input id= 'ctmsBtn' class='acdBtn' type='button' value='CTMS' style='position:relative; top:-2px;'>";
		taskTag += "    	<input id= 'edcBtn' class='acdBtn' type='button' value='EDC' style='position:relative; top:-2px;'>";
		taskTag += "    	<input id= 'iwrsBtn' class='acdBtn' type='button' value='IWRS' style='position:relative; top:-2px;'>";
		taskTag += "    </div>";	 	
		taskTag += "    <div  class='acdMenuCts acdMenuCts01 close'>";		
		taskTag += "    <div class='conTitBtnR'>";
		taskTag += "			<input id='addButton'  type='button' class='btn mgL3' value='행 추가'>";	
		taskTag += "			<input id='delButton'  type='button' class='btn mgL3' value='행 삭제'>";
		taskTag += "			<input id='modiButton'  type='button' class='btn mgL3' value='수정'>";
		taskTag += "			<input id='saveButton'  type='button' class='btn mgL3' value='저장'>";
		taskTag += "			<input id='XButton'  type='button' class='btn mgL3' value='X'>";
		taskTag += "    </div>";
		taskTag += "    <article class='mgT38'>";
		taskTag += "			<div id='"+taskInfo[i].TASK_NO+"' class='gridHeiSz15 grid_wrap tb01_2'></div>";
		taskTag += "    </article>";
		taskTag += "    </div>";
		taskTag += "</li>";	    
	}
	
	$("#acdMenu01").append(taskTag);
	toggleClass();

	//화면 처음 시작시 첫번째 과제를 자동으로 open
	$("#"+initId+"Z").siblings(".acdMenuCts01").slideToggle(0);
	$("#"+initId+"Z").toggleClass('open');
	
	createGrid();
	btnController();
	
}

function toggleClass(){
	$(".acdMenuLst01 > a").on("click",function() {		
		if ($(this).hasClass("close")) {
			$(this).siblings(".acdMenuCts01").slideToggle(0);				
			$(this).toggleClass('open');						
		    createGrid();
		}				
	});

	$(".acdMenuLst01").not(this).on("click",function() {		
		if ($(".acdMenuLst01").not(this).children().hasClass("close")) {
			$(".acdMenuLst01").not(this).children(".acdMenuCts01").slideUp(0);			
		}
	});

	$(".acdMenuLst01 > a").not(this).on("click",function() {
		if ($(".acdMenuLst01 > a").hasClass('open')) {
			$(".acdMenuLst01 > a").not(this).removeClass('open');
			
		}
	});
}

function createGrid(){	
	if(accHeaderId){			
		delHeaderId = accHeaderId;			
		createAUIGrid(accHeaderId);
		requestData(accHeaderId);
				
	}
	
}

//AUIGrid 를 생성합니다.
function createAUIGrid(gridPID) {
	//alert("createAUIGrid");
	// type에 맞는 칼럼 레이아웃 	
	var columnLayout = getColumnLayout();	
	var auiGridProps = {
			
		// singleRow 선택모드
	 	showStateColumn: true,
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",
		selectionMode : "singleRow",	
		editable : false,
		enableFilter : true,
		headerHeight: 40,
		rowHeight: 37
	};

	// 실제로 #grid_wrap 에 그리드 생성	
	
	gridP= gridPID.substring(0,gridPID.length-1);	
	addGridId = gridP;
	AUIGrid.create(gridP, columnLayout, auiGridProps);
	AUIGrid.setCellMerge(gridP, true );

};

 function requestData(gridPID) {
	 var gridPID;
	 if(initId!=""){
	 	gridPID = initId;
	 	initId="";
	 }else{
		gridPID = gridPID.substring(0,gridPID.length-1);
	 }
		AUIGrid.showAjaxLoader(gridPID); // 로딩바 출력

		 $.ajax({
			  url : "./selectAssignmentbyNisGrid.do",
	 		  data : {'TASK_NO' : gridPID},
			  success : function(data, textStatus, jqXHR) {
				  console.log("gridPID::::"+gridPID);
				  if(data.success) {			
					  //행추가할때 데이터 복사를 위한 변수
					  addGridData = data.result;
					  AUIGrid.setGridData(gridPID, data.result);		    		
			    	  AUIGrid.removeAjaxLoader(gridPID); // 로딩바 제거
			    	  userId = data.USER_ID; //로그인한 유저 ID 받기
	 				  
				  } else {
					  AUIGrid.removeAjaxLoader(gridPID);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }			  
		});		 
}


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
//칼럼 레이아웃 생성
function getColumnLayout() {
	
	//AUI 그리드 레이아웃
 	columnLayout = [{ 
 		dataField : "SN",
 		headerText : "순번",	 
 		visible : false,
 		editable : false		
 	},{ 
 		dataField : "PRODUCT_NM",
 		headerText : "제품명",	 
 		cellMerge : true,
 		editable : false		
 	},{
 		dataField : "STUDY_NM",
 		headerText : "스터디명",
 		cellMerge : true,
 		editable : false
 	},{
 		dataField : "TRGTER_CO",
 		headerText : "목표례수",
 		cellMerge : true,
 		editable : false
 	},{
 		dataField : "VISIT_INFO",
 		headerText : "Visit 정보<span class='must_01'></span>",	 	
 		editable : true,
 		editRenderer : {
 			type: "InputEditRenderer",
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 60){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
 			}
 		}
 	},{
 		dataField : "COST",
 		headerText : "Cost", 	
 		dataType : "numeric",
 		editRenderer : {
 			type : "InputEditRenderer",
 			onlyNumeric : true,
 			validator : function(oldValue, newValue, rowItem){
 				var isValid = false; 	
 				
 				fn_validator(newValue);
 				
 				if(validatorCnt <= 50){ 
 					isValid = true;
 				} 			
 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
  			}
 		}
		
 	},{
 		dataField : "VER",
 		headerText : "P.T 정보",
 		cellMerge : true,
 		editable : false
 		
 	}]
		
	
	return columnLayout;
};


function fn_lnbResize2(v) {
	setTimeout(function() {
		AUIGrid.resize(v);
	}, 90);
}


$(window).resize(function(){
// 	if (accHeaderId) {
// 		AUIGrid.resize(accHeaderId);
// 	}
	
    if($('.grid_wrap') && $('.grid_wrap').length) {
    	for(var i = 0; i < $('.grid_wrap').length; i++) {
        	try {
        		fn_lnbResize2($('.grid_wrap')[i].id);	
        	} catch(e) {
        	}
    	}
    }

});


</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMB0301&UPPER_MENU_ID=CTMB" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMB0301&UPPER_MENU_ID=CTMB" charEncoding="utf-8"/>
<div id="wrap">

	<!-- 메인 시작 -->
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
         <div class="conBoxInner" style="min-height:900px;">

           <div class="button_tab_01">
				<ul>				
					<li id="SummaryBtn" class="port_back tab_menu">Summary</li>
					<li id="StautsBtn" class="tab_menu">Stauts</li>
				</ul>
           </div>
          
          	<span style="font-family:'NanumGothicBold';">과제번호  :</span>
           <input type="text" id="myInput"  class="pdR15">
           <input id="myButton" type="button" class="btn mgL3" value="검색">
           

            <article class="mgT16">                	
	            	<ul id="acdMenu01">                                   
                     </ul>
            </article>
        </div>
    </section>
    
</div>
</section>
</div>

</body>
</html>