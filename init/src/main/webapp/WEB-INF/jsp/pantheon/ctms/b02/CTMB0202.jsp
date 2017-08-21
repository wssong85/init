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
var columnLayout;
var taskCnt;
var taskNoGrid;
var accHeaderId;
var delHeaderId;
var delSearch;
var initId ="";
var buttonId;
var userId = "${map.USER_ID}";
var taskEndAt = 'N';

$(document).ready(function() {
	selectGrid();
	$("#SummaryBtn").click(function(){
		$(location).attr("href","/ctms/b02/CTMB0201.do");
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
			  url : './selectPmsTask_NoList.do',		
			  data : {'TASK_NO' : grid, 'USER_ID' : userId, 'TASK_END_AT' : taskEndAt},
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
		taskTag += "    	<p>";
		taskTag += "			<div id='"+taskInfo[i].TASK_NO+"' class='gridHeiSz03 grid_wrap tb01_2'></div>";	
		taskTag += "    	</p>";
		taskTag += "    </div>";
		taskTag += "</li>";	    
	}
	
	$("#acdMenu01").append(taskTag);
	toggleClass();

	//화면 처음 시작시 첫번째 과제를 자동으로 open
	$("#"+initId+"Z").siblings(".acdMenuCts01").slideToggle(0);
	$("#"+initId+"Z").toggleClass('open');
	
	createGrid();

	
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
		selectionMode : "singleRow",	
		editable : false,
		enableFilter : true,
		headerHeight: 40,
		rowHeight: 37
		//height: 100,
	};

	// 실제로 #grid_wrap 에 그리드 생성	
	
	var gridP= gridPID.substring(0,gridPID.length-1);	
	
	AUIGrid.create(gridP, columnLayout, auiGridProps);
	

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
			  url : "./selectPmsStatusGrid.do",
	 		  data : {'TASK_NO' : gridPID},
			  success : function(data, textStatus, jqXHR) {

				  if(data.success) {					  
					  AUIGrid.setGridData(gridPID, data.result);		    		
			    	  AUIGrid.removeAjaxLoader(gridPID); // 로딩바 제거		    	 
			    	  
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



//칼럼 레이아웃 생성
function getColumnLayout() {
	
	//AUI 그리드 레이아웃
 	columnLayout = [{ 
 		dataField : "RSRCH_DATE",
 		headerText : "기간",	 		
 		editable : false		
 	},{
 		dataField : "TRGTER_CO",
 		headerText : "목표례수",
 		editable : false
 	},{
 		dataField : "INSTT_CODE",
 		headerText : "계약기관수",	 		
 		editable : false
 	},{
 		dataField : "GOAL_CO",
 		headerText : "계약례수",	 	
 		editable : false
 	},{
 		dataField : "FREEZING_INSTT",
 		headerText : "종료기관수",
 		editable : false
		
 	},{
 		dataField : "FREEZING_SUBJECT",
 		headerText : "종료례수",	 	 		
 		editable : false
 		
 	},{
 		dataField : "AE",
 		headerText : "AE",	 	 		
 		editable : false
 		
 	},{
 		dataField : "ADR",
 		headerText : "ADR",	 	 		
 		editable : false
 		
 	},{
 		dataField : "SAE",
 		headerText : "SAE",	 	 		
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
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMB0202&UPPER_MENU_ID=CTMB" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMB0201&UPPER_MENU_ID=CTMB" charEncoding="utf-8"/>
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
						<li id="SummaryBtn" class="tab_menu">Summary</li>
						<li id="StautsBtn" class="port_back tab_menu">Stauts</li>
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