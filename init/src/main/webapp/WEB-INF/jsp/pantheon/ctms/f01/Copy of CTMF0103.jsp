<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript">
var resultObj;


$(document).ready(function() {
	documentReady();	
	
	$('#SERCHBUTTON').click(function(){		
		check();		
		AUIGrid.setProperty("#grid_wrap", "editable" , false ); 
	});
	
	$('#btnGrModify').click(function(){		
	 	//alert("수정");	 	
	 	AUIGrid.setProperty("#grid_wrap", "editable" , true ); 
	});
	
	//메뉴하단 행추가
	$('#btnClCodeadd').click(function() {
		AUIGrid.setProperty("#grid_wrap", "editable" , true ); 
		var row = {
				'TASK_NO': '',
				'INSTT_CODE' : '1',
				'HSPTL_NM': '',
				'USER_NM': '',
				'USER_ID': '',
				'EMAIL': '',
				'TELNO': '',
				'GOAL_CO': '',
				'IRB_YN': '',
				'STTUS': '',
				'ATCHMNFL': '',
				'UPDATE_ID': 'admin',
				'LAST_UPDDE': new Date(),				
				'USE_AT': 'Y',
				'CURD': 'C'
		};		
		AUIGrid.addRow("#grid_wrap", row, 'last'); // 최하단에 행 추가
	});
	
	//메뉴하단 행삭제
	$('#btnClCodeDelete').click(function() {
		AUIGrid.removeRow("#grid_wrap", "selectedIndex");
	});
	
	//메뉴상단 저장
	$('#btnClCodeSave').click(function() {
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap");
		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems("#grid_wrap");
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems("#grid_wrap");
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);			
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = 'admin';
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
					   AUIGrid.setProperty("#grid_wrap", "editable" , false ); 
					   $("#grid_wrap").load();
				  } else {
					  AUIGrid.removeAjaxLoader("#grid_wrap");
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
});

//AUIGrid 생성 후 반환 ID
var myGridID;

function documentReady() {  	
	
	// AUIGrid 그리드를 생성합니다.
	createAUIGrid();
	
	AUIGrid.showAjaxLoader(myGridID);
	$.ajax({
		  url : './selectPaperContractList.do',
// 		  data : {
// 		    sampleInput : "sampleData"
// 		  },
		  success : function(data, textStatus, jqXHR) {
			  resultObj = data.result;
			  //console.log(resultObj[0].HSPTL_NM);
			  if(data.success) {
				  AUIGrid.removeAjaxLoader(myGridID);
				  AUIGrid.setGridData(myGridID, data.result);
				  dropData = AUIGrid.setGridData(myGridID, data.result);
			  } else {
				  AUIGrid.removeAjaxLoader(myGridID);
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});

	
};


function check(){
	var url = './selectPaperContractList.do?';
	var TASK_NO = $("#frm").serialize();
	
 	console.log(TASK_NO);
// 	alert(TASK_NO);
	$.ajax({
		url : url+TASK_NO,
		type : 'post',
		contentType : "application/json; charset=UTF-8",
 		//data : {'TASK_NO' : TASK_NO,,
// {'TASK_NO' : '', 'TASK_NO2': 'ttt'} post 방식
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				  AUIGrid.removeAjaxLoader(myGridID);
				  AUIGrid.setGridData(myGridID, data.result);
			} else {
				  AUIGrid.removeAjaxLoader(myGridID);
				  alert(data.message);
			}
			//AUIGrid.removeAjaxLoader(myGridID);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
	
}



// AUIGrid 칼럼 설정
var columnLayout = [{
	dataField : "TASK_NO",
	headerText : "과제번호",
	editable : true,
	width: 120
},{
	dataField : "INSTT_CODE",
	headerText : "기관번호",
	editable : false,
	visible : false,
	width: 120
},{
	dataField : "HSPTL_NM",
	headerText : "기관명",
	editable : true,
	width: 120
},{
	dataField : "USER_NM",
	headerText : "연구자",
	editable : true,	
},{
	dataField : "USER_ID",
	headerText : "ID",
	editable : true
},{
	dataField : "EMAIL",
	headerText : "e-mail",	
	editable : true
},{
	dataField : "TELNO",
	headerText : "전화번호",
	editable : true
},{
	dataField : "GOAL_CO",
	headerText : "목표례수",
	editable : true
},{
	dataField : "IRB_AT",
	headerText : "IRB 여부",		
	editRenderer : {
		type : "DropDownListRenderer",
		showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기		
	},
	editable : true
},{
	dataField : "STTUS",
	headerText : "종류",
	editable : true
},{
	dataField : "FILE_CNT",
	headerText : "계약서",
	renderer : {
		type : "ButtonRenderer",
		onclick : function(rowIndex, columnIndex, value, item) {
			 //ATCH_POP(resultObj[rowIndex].ATCH_FILE);		
			 var param = {};
			//AUIGrid.removeAjaxLoader(myGridID);
			mkLayerPopupOpen("./CTMF0105.do",param);
		}
	},
	editable : false	
},{
	dataField : "ATCH_FILE",
	headerText : "파일순번",
	editable : false,
	visible : false
}];

//modal 팝업 생성
function ATCH_POP(val){	
	var url = './CTMF0105.do';
	var option = "dialogWidth:300;dialogHeight:300px;status:no;help:no";    
	var arrVal =  new Array();
	arrVal[0] = val;
    window.showModalDialog(url,arrVal, option); 
}

//AUIGrid 를 생성합니다.
function createAUIGrid() {
	myGridID = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);

}
var auiGridProps = {};

auiGridProps.usePaging = 30;
auiGridProps.selectionMode = "singleRow";
auiGridProps.editable = false;
auiGridProps.enableFilter = true;
auiGridProps.usePaging = false;
</script>
</head>
<body>	
<div id="wrap">
<c:import url="/com/topHeader.do" charEncoding="utf-8"/>
<c:import url="/com/lnb.do" charEncoding="utf-8"/>
	 <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>루프린즈를 투여한 관찰 연구</h3>

                <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Report</a></li>
                    </ul>
                </nav>
            </article>
	<!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>Paper 계약</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드  상단메뉴라인 시작-->        
                    <article class="conTitBtn">

                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                        <!--검색 설정 숨겨진 부분 시작-->
                        <!--
                            <ul class="disNn">
                                <li><input type="checkbox" id="direction" value="direction" checked="checked">
                                    <label for="direction">진행 방향 : forward(or backword)</label>
                                </li>
                                <li><input type="checkbox" id="caseSensitive" value="caseSensitive">
                                    <label for="caseSensitive">대소문자 구분(caseSensitive)</label>
                                </li>
                                <li><input type="checkbox" id="wholeWord" value="wholeWord">
                                    <label for="wholeWord">온전한 단어(wholeWord)</label>
                                </li>
                                <li><input type="checkbox" id="wrapSearch" value="wrapSearch" checked="checked">
                                    <label for="wrapSearch">끝에서 되돌리기(wrapSearch)</label>
                                </li>
                            </ul>
                            -->
                            <!--검색 설정 숨겨진 부분 끝-->       
                            <form id="frm" name="frm">                      	
                            과제번호 : <input type="text" id="TASK_NO" name="TASK_NO" class="pdR15">	    	
                            <input type="button" id="SERCHBUTTON" name = "SERCHBUTTON" value="검색">	
                              </form>
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        
                        <div class="conTitBtnR">
							<input type="button" id="btnClCodeadd" value="행추가">
							<input type="button" id="btnClCodeDelete" value="행삭제">
							<input type="button" id="btnGrModify" value="수정">
							<input type="button" id="btnClCodeSave" value="저장">                            
                        </div>
                      
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="grid_wrap tb01_2"></div>                        
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









