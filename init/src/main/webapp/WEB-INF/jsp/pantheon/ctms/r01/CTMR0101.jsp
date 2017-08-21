<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript">
var pmsCnt = "${loginMap.TASK_TY_CODE}";  //선택하고 들어온 과제번호 구분 확인 01:임상 02:NIS 03:PMS
var taskNo = "${loginMap.TASK_NO}"; //*선택하고 들어온 과제번호가 들어가야함
var taskSn = "${loginMap.TASK_SN}"; //*선택하고 들어온 과제번호가 들어가야함
var userId = "${loginMap.USER_ID}"; //로그인한 유저 ID
var validatorCnt;
var rejdgeMerge;
//AUIGrid 생성 후 반환 ID

$(document).ready(function() {
	prGrid.createGrid();
	AUIGrid.setProperty(prGrid.id, "editable" , false );
	btnController();
	//과제가 PMS이면 재심사기간 컬럼 보여주기
	if(pmsCnt == "03"){
		AUIGrid.showColumnByDataField(prGrid.id, "REJDGE");
	}
	
	//수정버튼 클릭
	$('#btnProtocolModify').click(function(){	
		AUIGrid.setProperty(prGrid.id, "editable" , true ); 
		$("#btnProtocolAdd").show();
		$("#btnProtocolDelete").show();
		$("#btnProtocolModify").hide();
		$("#btnProtocolSave").show();
		$("#btnProtocolX").show();
	});
	//X버튼 클릭
	$('#btnProtocolX').click(function(){
		btnController();
		AUIGrid.setProperty(prGrid.id, "editable" , false ); 
		AUIGrid.resetUpdatedItems(prGrid.id, "d" );
	});
	
	//메뉴하단 행추가
	$('#btnProtocolAdd').click(function() {		
		var rejdge ;
		if(rejdgeMerge != ""){
			rejdge = rejdgeMerge[0].REJDGE;
		}
		var row = {
				 'SN' : ''
				,'TASK_SN': taskSn //*선택하고 들어온 과제번호가 들어가야함
				,'VER': ''
				,'REJDGE':rejdge
				,'CONFMDE': ''
				,'FRMLA_OFFIC_PRESENTNDE': ''
				,'CHGHY': ''
				,'RM': ''
				,'TASK_TY_CODE': ''	
				,'USE_AT': 'Y'
				,'FRST_CREDE' : new Date()	
				,'FRST_CRTR' :userId
				,'LAST_UPDDE': new Date()
				,'LAST_UPDUSR': userId	
				,'CRUD': 'C'
		};		
		AUIGrid.addRow(prGrid.id, row, 'first'); // 최상단에 행 추가
		
	});
	
	//메뉴하단 행삭제
	$('#btnProtocolDelete').click(function() {
		AUIGrid.removeRow(prGrid.id, "selectedIndex");
	});
	
	//메뉴상단 저장
	$('#btnProtocolSave').click(function() {
		var verItems = AUIGrid.getColumnValues(prGrid.id, "VER");
		var confmdeItems = AUIGrid.getColumnValues(prGrid.id, "CONFMDE");
		var frmlaOfficPItems = AUIGrid.getColumnValues(prGrid.id, "FRMLA_OFFIC_PRESENTNDE");
		var rowIndex = AUIGrid.getRowCount(prGrid.id);
		for(i=0; i<rowIndex; i++){
			if(verItems[i] == ""){
				alert("Ver을 입력해 주세요.");				
				return AUIGrid.setSelectionByIndex(prGrid.id, i, 0);
			}
			
			if(confmdeItems[i] == ""){
				alert("승인일 을 입력해 주세요.");
				return AUIGrid.setSelectionByIndex(prGrid.id, i, 2);
			}
			
			if(frmlaOfficPItems[i] == ""){
				alert("식약처 제출일 을 입력해 주세요.");
				return AUIGrid.setSelectionByIndex(prGrid.id, i, 3);
			}
		}
		
		if(confirm("저장하시겠습니까?") == true){
			//확인 진행
		}else{
			return;
		}
		 if(pmsCnt == "03"){
			var rows = AUIGrid.getRowIndexesByValue(prGrid.id, "REJDGEPD", null);
			
			if(rows <= 0){
				alert(rows);
				return;
			}
		} 
		
		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(prGrid.id);		
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(prGrid.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(prGrid.id);
		
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
			  url : './insertProtocolList.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {					    
					   console.log("prGrid::"+prGrid);
					   prGrid.load();
					   
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
function btnController(){
	$("#btnProtocolAdd").hide();
	$("#btnProtocolDelete").hide();
	$("#btnProtocolModify").show();
	$("#btnProtocolSave").hide();
	$("#btnProtocolX").hide();
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

var prGrid = {
	 	id: 'prGrid',
	 	div: {
	 		gridDiv: '#prGrid'
	 	},
	 	proxy: {
	 		url: './selectProtocolList.do',
	 		param: {'TASK_SN' : taskSn},
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

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "VER",
			headerText : "ver<span class='must_01'></span>",
			editable : true,
			width : 100,
			editRenderer : {
	 			type: "InputEditRenderer", 			
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 10){ 
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
	 		},
			filter : {
				showIcon : true
			}
		},{
			dataField : "REJDGE",
			headerText : "재심사기간",
			visible : false,
			editable : false,
			cellMerge : true,
			width : 200,
			filter : {
				showIcon : true
			}
		},{
			dataField : "CONFMDE",
			headerText : "승인일<span class='must_01'></span>",
			
			editable : true,
			width : 120,
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			}	
		},{
			dataField : "FRMLA_OFFIC_PRESENTNDE",
			headerText : "식약처 제출일<span class='must_01'></span>",


			editable : true,
			width : 120,
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "CalendarRenderer",
				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			}
		},{
			dataField : "CHGHY",
			headerText : "변경사유",
			editable : true,
			editRenderer : {
	 			type: "InputEditRenderer", 			
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
			filter : {
				showIcon : true
			}
		},{
			dataField : "RM",
			headerText : "비고",	
			editable : true,
			filter : {
				showIcon : true
			},
			editRenderer : {
	 			type: "InputEditRenderer", 			
	 			validator : function(oldValue, newValue, rowItem){
	 				var isValid = false; 	
	 				
	 				fn_validator(newValue);
	 				
	 				if(validatorCnt <= 200){ 
	 					isValid = true;
	 				} 			
	 			    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	 				return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
	 			}
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
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		
	 		
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 		 		    		
	 		    	    userId = data.USER_ID;	 		    	    
	 		    	    rejdgeMerge = data.result;	 		    	    
	 			    	
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
	if (typeof prGrid.id !== "undefined") {
		AUIGrid.resize(prGrid.id);
	}
}
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMR0101&UPPER_MENU_ID=CTMR" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMR0101&UPPER_MENU_ID=CTMR" charEncoding="utf-8"/>


	  <!-- 컨텐츠박스 시작-->
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
                <div class="conBoxInner" style="min-height:900px;">

                    <div>
	                    <article class="conTitBtnR">
	                        <input type="button" id="btnProtocolAdd"  class="add_01" title="행추가">
	                        <input type="button" id="btnProtocolDelete"  class="del_01" title="행삭제">
	                        <input type="button" id="btnProtocolModify"  class="edit_01" title="수정">
	                        <input type="button" id="btnProtocolSave"  class="save_01" title="저장">
	                        <input type="button" id="btnProtocolX"  class="close_01" title="취소">
	                    </article>
                    </div>



                    <article class="mgT40">
                         <div id="prGrid" class="gridHeiSz17 grid_wrap tb01_2"></div>
                    </article>


                </div>
            </section>

	 </div>
	</section>

</div>
</body>
</html>










