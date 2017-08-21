<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript" src="<c:url value='/js/pantheon/edc/EDC.js'/>"></script>
<title>과제별 수탁기관</title>

<script type="text/javascript">
var _user = {
	'USER_ID': '${loginMap.USER_ID}'
};
var g_USER_ID;
var g_TaskSn = '${TASK_SN}';
var g_TaskNo = '${TASK_NO}';
var g_rowSelect;
var insttList = [];

var myGridOption = {
		  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
		  id: '',
		  //AUI그리드 생성할 div 및 페이징 옵션
		  div: {
		    gridDiv: '#grid_wrap',
		    paging: {
		      pagingDiv: 'grid_paging',
		      totalRowCount: 500,
		      rowCount: 10,
		      pageButtonCount: 4,
		      currentPage: 1,
		      totalPage: 0,
		    },
		  },
		  //데이터 연계 옵션
		  proxy: {
		    url: './selectInitTaskTrust.do',
		    param: {},
		    type: 'post',
		    dataType: 'json',
		    //페이징 true, false 로 지정
		    paging: true,
		    //처음 시작시 데이터 로딩
		    autoLoad: false,
		  },
		  //AUI 그리드 옵션
		  gridPros: {
		    // 페이징 사용
		    //usePaging : true,
		    
		    showRowNumColumn : true,
		    showRowCheckColumn : false,

		    showStateColumn    : true,
		    
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    
		    enableColumnResize : true,
		    enableMovingColumn : true,
		    editable : true,
		    enableFilter : true,
		    
		    showFooter : true,

		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    //selectionMode : "multipleRows",

		    displayTreeOpen : true,

		  },
		  //AUI 그리드 레이아웃
		  columnLayout : [
    		   {
    		   	  dataField : "SN"
    		   	, headerText : "순번"
    		   	, visible : false
    		   	, editable : false
    		   	//width: 120
    		   }
    		   ,{
    		   	  dataField : "TASK_SN"
    		   	, headerText : "과제순번"
    		   	, editable : false
    			, width: 120
    			, visible : false
    		   }
    		   ,{
     		   	  dataField : "TASK_NO"
     		   	, headerText : "과제번호<span style='color:red'>*</span>"
     		   	, editable : false
     			, width: 120
     			, visible : false
     		   }
    		   ,{
       		   	  dataField : "INSTT_CODE"
       		   	, headerText : "수탁기관"
       		   	, editable : true
       		    , visible : true
       		   	, width: 60
       		   }
    		   ,{
      		   	  dataField : "INSTT_NAME"
      		   	, headerText : "수탁기관<span style='color:red'>*</span>"
      		   	, editable : true
      		   	, width: 250
      		   	, filter : {
      				showIcon : true
      			  }
      		    , editRenderer : {
      				type : "RemoteListRenderer",
      				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
      				fieldName : "INSTT_NAME", // remoter 에서 가져온 데이터 중 실제 그리드에 적용시킬 필드명 (단순 배열이 아닌 경우 반드시 지정해야 함.)
      				remoter : function( request, response ) { // remoter 지정 필수
      					if(request.term && String(request.term).length < 2) {
      						alert("2글자 이상 입력하십시오.");
      						response(false); // 데이터 요청이 없는 경우 반드시 false 삽입하십시오.
      						return;
      					}

      					// 데이터 요청
      					$.ajax({
      						url: '/ctms/j11/selectInsttList.do',
      						data: { INSTT_NM : request.term },
      				 		type: 'post',
      				 		dataType: 'json',
      						success: function(data) {
      							if(data.success) {
      			 			    	console.log("data.success : "+data.success);
      			 		    	} else {
      			 		    		console.log("data.else : "+data.success);
      			 		    	}

      							insttList = data.result;
      							// 성공 시 완전한 배열 객체로 삽입하십시오.
      							response(data.result);
      						},
      				 		error : function(jqXHR, textStatus, errorThrown){
      							alert(textStatus);
      						}
      					}); // end of ajax
      				},
      				listTemplateFunction : function(rowIndex, columnIndex, text, item, dataField, listItem) {
      					var html = '<div>';
      					html += '<span style="width:80px; text-align:left;">' + listItem.INSTT_CODE + '</span>';
      					html += '<span style="width:200px; text-align:left;">' + listItem.INSTT_NAME + '</span>';
      					html += '<span style="width:100px; padding-left:20px;">' + listItem.BIZ_NO + '</span>';
      					html += '<span style="width:200px; padding-left:20px;">' + listItem.ADDRESS + '</span>';
      					html += '</div>';
      					return html;
      				}
      			  }
      		   }
    		   ,{
     		   	  dataField : "USER_ID"
     		   	, headerText : "사용자ID"
     		   	, editable : false
     			, width: 100
     			, visible : true
     			, filter : {
      				showIcon : true
      			  }
     		   }
    		   ,{
     		   	  dataField : "USER_NAME"
     		   	, headerText : "사용자"
     		   	, editable : false
     			, width: 100
     			, visible : true
     			, filter : {
      				showIcon : true
      			  }
     		   }
    		   ,{
      		   	  dataField : "ODR"
      		   	, headerText : "차수"
      		   	, editable : true
      			, width: 100
      			, visible : true
      			, dataType : "numeric"
      			, editRenderer : {
          			  onlyNumeric : true
          			, validator : function(oldValue, newValue, rowItem) {
          				var isValid = false;
          				var numVal = Number(newValue);
          				if(newValue.length <= 3) {
          					isValid = true;
          				}
          				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
          				return { "validate" : isValid, "message"  : "차수는 999보다 클 수 없습니다." };
          			  }
          		  } // editRenderer
          		, filter : {
      				showIcon : true
      			  }
      		   }
    		   ,{
       		   	  dataField : "RCPMNY_DTE"
       		   	, headerText : "입금일"
       		   	, editable : true
       			, width: 120
       			, visible : true
       			, formatString : "yyyy-mm-dd"
       		 	, dataType:"date"
       			, editRenderer : {
            		type : "CalendarRenderer",
            		showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
            		onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
            		showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
                  }
    		    , filter : {
     				showIcon : true
     			  }
       		   }
    		   ,{
       		   	  dataField : "RCPMNY_AM"
       		   	, headerText : "입금액"
       		   	, editable : true
       			, width: 150
       			, visible : true
       			, dataType : "numeric"
          		, formatString : "#,##0"
          		, editRenderer : {
        			  type : "InputEditRenderer"
        			, onlyNumeric : true
        			, validator : function(oldValue, newValue, rowItem) {
        				var isValid = false;
        				var numVal = Number(newValue);
        				if(newValue.length <= 15) {
        					isValid = true;
        				}
        				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
        				return { "validate" : isValid, "message"  : "15 자리 보다 작은 수를 입력하세요." };
        			  }
        		  } // editRenderer
        		, filter : {
        				showIcon : true
        	      }
       		   }
    		   ,{
       		   	  dataField : "PYMNT_SE_CODE"
                , headerText : "지급구분"
                , editable : true
       		   	, width: 150
      			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
      				var me = myGridOption;
					var retStr = "";
					for(var i=0; me.columnLayout[10].editRenderer.list.length > i; i++) {
						if(me.columnLayout[10].editRenderer.list[i]['CODE'] == value) {
							retStr = me.columnLayout[10].editRenderer.list[i]['NAME'];
							break;
						}
					}
					return retStr == "" ? value : retStr;
      		    }
	       		, editRenderer : {
	     			type : "DropDownListRenderer",
	     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
	     			list : null,
	     			keyField : "CODE",
	     			valueField : "NAME"
	     		  }
	       		, filter : {
	    	 		showIcon : true
	    	 	  }
       		   }
    		   ,{
       		   	  dataField : "RM"
       		   	, headerText : "비고"
       		   	, editable : true
       			, visible : true
       			, editRenderer : {
      			  type : "InputEditRenderer"
      			, validator : function(oldValue, newValue, rowItem) {
	      				var isValid = false;
	      				if(newValue.length <= 1000) {
	      					isValid = true;
	      				}
	      				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	      				return { "validate" : isValid, "message"  : "비고는 1000 자를  넘을 수 없습니다." };
	      			  }
	      		  } // editRenderer
	      		, filter : {
      				showIcon : true
      			  }
               }
		  ],
		  footerObject : [ {
				labelText : "합계",
				positionField : "#base"
			}, {
				dataField : "RCPMNY_AM",
				positionField : "RCPMNY_AM",
				operation : "SUM",
				formatString : "#,##0"
			}
		  ]
		  //AUI 그리드 생성
		  , createGrid: function() {
			    var me = this;
			    
			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			 	// 푸터 객체 세팅
				AUIGrid.setFooter(me.div.gridDiv, me.footerObject);

			    me.binding();
	
			    if(me.proxy.autoLoad) {
			    	console.log("me.load()....");
					me.load();
			    }
		  },

		  //AUI 그리드 이벤트 
		  binding: function() {
			var me = this;

			AUIGrid.bind(me.id, "cellEditBegin", function(event) {

			});

			AUIGrid.bind(me.id, "cellEditEnd", function(event) {

				switch(event.type) {
					case "cellEditEnd" :
					if(event.dataField == "INSTT_NAME") {

						var insttItem = getInsttItem(event.value);
						if(typeof insttItem === "undefined") {
							return;
						}
						
						AUIGrid.updateRow("#grid_wrap", { INSTT_CODE : insttItem.INSTT_CODE}, event.rowIndex);
					}
					break;

				}

			});

			AUIGrid.bind(me.id, "cellDoubleClick", function(event) {
				g_rowSelect = event.rowIndex;

				if(AUIGrid.getProperty("#grid_wrap", "editable")){
					if(event.dataField == "USER_NAME"){
						fn_userSearchPopup();
					}
					
// 					if(event.dataField == "INSTT_NAME"){
// 						fn_searchInsttPopup();
// 					}
				}
			});

		  },
		  //AUI 그리드 데이터 요청
		  init: function(v1, v2) {
			  console.log("me.init()....");
		 		var me = this;
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    //dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {
		 		    		me.columnLayout[10].editRenderer.list = data.CTMS013;
		 		    		me.createGrid();
		 		    		AUIGrid.setProperty("#grid_wrap", "editable", false);
		 		    		
		 		    		AUIGrid.setGridData(me.id, []);
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
		  load: function(v1, v2) {
		 		var me = this;
		 		
		 		AUIGrid.showAjaxLoader(me.id);

		 		var searchArr = {
		 				  TASK_SN : '${TASK_SN}'
		 		        , SEARCH_TYPE : $("#SEARCH_TYPE").val()
		 		        , SEARCH_COND : $("#SEARCH_COND").val()
		 		    };

				$.ajax({
					  url : '/ctms/b04/selectTaskTrustInsttList.do' ,
					  type: 'post',
					  //contentType: "application/json; charset=UTF-8",
					  data : searchArr,
					  success : function(data, textStatus, jqXHR) {

						  if(data.success) {
							  AUIGrid.removeAjaxLoader(me.id);
							  AUIGrid.setGridData(me.id, data.result);
							  AUIGrid.setSelectionByIndex(me.id, 0);
							  $("#btnAddrow").hide();
							  $("#btnRowDel").hide();
							  $("#btnSave"  ).hide();
							  AUIGrid.setProperty("#grid_wrap", "editable", false);
						  } else {
							  AUIGrid.removeAjaxLoader("#grid_wrap");
							  alert(data.message);
						  }
					  },
					  error : function(jqXHR, textStatus, errorThrown){
						  alert(textStatus);
					  }
				});
		  }

		};

$(document).ready(function() {

	$("#btnAddrow").hide();
	$("#btnRowDel").hide();
	$("#btnSave"  ).hide();

	myGridOption.init();
	
	$('#btnUpdateYN').click(function(){	 //수정여부
		if(AUIGrid.getProperty("#grid_wrap", "editable")){
			AUIGrid.setProperty("#grid_wrap", "editable", false);
			$("#btnAddrow").hide();
			$("#btnRowDel").hide();
			$("#btnSave"  ).hide();
		}
		else{
			AUIGrid.setProperty("#grid_wrap", "editable", true);
			$("#btnAddrow").show();
			$("#btnRowDel").show();
			$("#btnSave"  ).show();
		}
	});

	$('#btnAddrow').click(function(){	 //행추가

        AUIGrid.setProperty("#grid_wrap", "editable" , true ); 
        var row = {
        	         'TASK_SN' : g_TaskSn
        	       , 'SN' : ''
        	       , 'TASK_SE' : ''
        	       , 'INSTT_CODE' : ''
        	       , 'INSTT_NAME' : ''
        	       , 'USER_ID' : ''
        	       , 'USER_NAME' : ''
        	       , 'ODR' : ''
        	       , 'RCPMNY_DTE' : ''
        	       , 'RCPMNY_AM' : ''
        	       , 'PYMNT_SE_CODE' : ''
        	       , 'RM' : ''
        	       , 'UPDATE_ID': _user.USER_ID
        	       , 'LAST_UPDDE': new Date()
        	       , 'USE_AT': 'Y'
        	       , 'CURD': 'C'
        };      
        AUIGrid.addRow("#grid_wrap", row, 'first'); // 최하단에 행 추가
        var addRowIndex = AUIGrid.getRowCount("#grid_wrap");
        n_rowSelect = (addRowIndex - 1);
	});
	
	$('#btnRowDel').click(function(){	 //행삭제
		AUIGrid.removeRow("#grid_wrap", "selectedIndex");
	});
	
	$('#btnSave').click(function(){	 //저장

		var arJson = [];

		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap");
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems("#grid_wrap");
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems("#grid_wrap");
		
		var cnt = 0;
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);
			cnt++;
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = 'admin';
			arJson.push(editedItems[i]);
			cnt++;
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			editedItems[i].CURD = 'D';
			editedItems[i].UPDATE_ID = 'admin';
			arJson.push(editedItems[i]);
			cnt++;
		}
		
		if(!fn_checkVal()) return;;
		
		if( cnt > 0 ){
			if(confirm("저장 하시겠습니까?")){
				$.ajax({
					url : './insertTaskTrustInstt.do' ,
					type: 'post',
					contentType: "application/json; charset=UTF-8",
					data : JSON.stringify(arJson),
					success : function(data, textStatus, jqXHR) {

						if(data.success) {
							alert("저장되었습니다.");
							myGridOption.load();
							AUIGrid.setProperty("#grid_wrap", "editable" , false ); 
					  	} else {
						  	AUIGrid.removeAjaxLoader("#grid_wrap");
							alert(data.message);
						}
					}, 
						error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			}
		}
		else{
			alert("변경된 내역 없습니다.");
		}

	}); // 저장

});

function getInsttItem(insttName) {
	var item;
	$.each(insttList, function(n, v) {
		if(v.INSTT_NAME == insttName) {
			item = v;
			return false;
		}
	});
	return item;
};

//var p_task_no = "";       //과제번호로  사용자 like 검색
//var p_user_nm;            //사용자명  like 검색
//var p_cntrct_sttus = "Y"; //기관&연구자 승인건만 조회 "Y", N:모두검색
var p_user_type    = "N"; //CM_USER 테이블만 사용 사용자 조회 : 외부사용자 N, 내부사용자 Y  <=== 무조건 ""이 아닐 경우 순수 유저 조회.
var p_autoLoad     = false;
function fn_userSearchPopup(rowIndex){
	console.log("fn_userSearchPopup.......");
	var param = {};
	mkLayerPopupOpen("/DMCJ1104.do", param);
}

function fn_setUserInfo(){
	userData = { 
		USER_ID   : returnValue.USER_ID
	  , USER_NAME : returnValue.USER_NM
	};

	AUIGrid.updateRow("#grid_wrap", userData, g_rowSelect);
}

function fn_searchInsttPopup(){
	p_instt_name = $("#insttNm").val();
	var param = {};
	console.log("fn_searchInstt.......");
	mkLayerPopupOpen("/DMCJ1103.do", param);
}

function fn_setInstt(){
	$("#insttNo").val(returnValue.INSTT_CODE);
	$("#insttNm").val(returnValue.INSTT_NAME);
	userData = { 
		INSTT_CODE : returnValue.INSTT_CODE
	  , INSTT_NAME : returnValue.INSTT_NAME
	};

	AUIGrid.updateRow("#grid_wrap", userData, g_rowSelect);
}

function fn_checkVal(){
	var gridData = AUIGrid.getGridData("#grid_wrap");
	
	for(i=0; gridData.length > i; i++){
		var gData     = gridData[i];
		var insttCode = gData.INSTT_CODE.length;
		var odr       = gData.ODR.length;
		var rcpmnyAm  = gData.RCPMNY_AM.length;
		var rm        = gData.RM;
    	       
		if(insttCode > 0){
			
		}
		else{
			var colNo = 0;
			if(insttCode <=0) colNo = 4;
			
			AUIGrid.setSelectionByIndex("#grid_wrap", i, 4);
			alert("수탁기관은 필수 입력입니다.");
			
			return false;
		}
		
		if(odr > 0 && odr > 3){
			AUIGrid.setSelectionByIndex("#grid_wrap", i, 7);
			alert("차수는 999를 넘을 수 없습니다.");

			return false;
		}
		
		if(rm != null){

			if(rm.length > 0){
				var strLen = rm.length;
				var totalByte = 0;
				var oneChar = "";
				
		        for (var i = 0; i < strLen; i++) {
		        	oneChar = rm.charAt(i);
		            if (escape(oneChar).length > 4) {
		                totalByte += 3;
		            } else {
		                totalByte++;
		            }
		        }
				console.log("totalByte : "+totalByte);
				if(totalByte > 999){ // DB Size 1000일 경우 한글  334자 1002로 error, 한글, 영문 byte합 1333
					AUIGrid.setSelectionByIndex("#grid_wrap", i, 11);
					alert("비고는 1000자를 넘을 수 없습니다.");
					return false;
				}
			}
		}

	} // for
	
	return true;
}

function fn_searchClick(){
	myGridOption.load();
}

window.onresize = function() {
	// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
	if (typeof myGridOption.id !== "undefined") {
		AUIGrid.resize(myGridOption.id);
	}
};

</script>
</head>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMB0101&UPPER_MENU_ID=CTMB" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMB0401&UPPER_MENU_ID=CTMB" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
    <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>과제별 수탁기관</h3>

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
                        <h5>${TASK_NO}</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 전체메뉴라인 시작-->        
                    <article class="conTitBtn">

                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
							<select id="SEARCH_TYPE" class="select">
								<option value="1" >수탁기관</option>
								<option value="2" >담당자</option>
							</select>
                            <input type="text" id="SEARCH_COND" name="SEARCH_COND" class="pdR15"><input type="button" class="btn mgL3" onclick="fn_searchClick()" value="검색">
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <div class="conTitBtnR">
                            <input type="button" id="btnAddrow"   value="행추가">
                            <input type="button" id="btnRowDel"   value="행삭제">
                            <input type="button" id="btnUpdateYN" value="수정">
                            <input type="button" id="btnSave"     value="저장">
                        </div>
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
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