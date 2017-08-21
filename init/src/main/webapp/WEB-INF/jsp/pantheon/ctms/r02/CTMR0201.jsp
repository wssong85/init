<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>

<style>
.th_center_style{ text-align:center;}


.aui-grid-default-header{ text-indent: 0px;}
.aui-grid-default-header .aui-grid-renderer-base span:first-child{ line-height:14px; font-size:12px; display:inline-block; padding:6px 0 0 10px;}

.aui-grid-row-num-header{text-indent: 10px;}



</style>


 <script type="text/javascript">
 var taskNo = "${loginMap.TASK_NO}";
 var taskSn = "${loginMap.TASK_SN}";
 var userId ; //로그인한 유저 ID
 $(document).ready(function(){
	 fn_btnSetting();
	 pmsGrid.createGrid();
	// documentReady();
	
	//메뉴하단 행추가
		$('#btnAnnualAdd').click(function() {
			AUIGrid.setProperty(pmsGrid.id, "editable" , true ); 
			var row = {
					 'SN': ''
					,'TASK_SN':taskSn //*선택하고 들어온 과제번호가 들어가야함
					,'ANNUAL':''
					,'SUMMARY':''
					,'PERIOD_FROM':''
					,'PERIOD_TO':''
					,'SAFETY':''
					,'EFFICACY':''
					,'FDRMREPORT_PRESENTNDE':''
					,'EXAMINPD_FROM':''
					,'EXAMINPD_TO':''
					,'EXPRSE':'03'
					,'USE_AT': 'Y'
					,'FRST_CREDE' : new Date()	
					,'FRST_CRTR' : userId
					,'LAST_UPDDE': new Date()
					,'LAST_UPDUSR': userId	
					,'CRUD': 'C'
			};		
			AUIGrid.addRow(pmsGrid.id, row, 'last'); // 최하단에 행 추가
		});
	
		//메뉴하단 행삭제
		$('#btnAnnualDelete').click(function() {
			AUIGrid.removeRow(pmsGrid.id, "selectedIndex");
		});
		
		//메뉴상단 저장
		$('#btnAnnualSave').click(function() {
			if(confirm("저장하시겠습니까?") == true){
				//확인진행
			}else{
				return;
			}
			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems(pmsGrid.id);		
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems(pmsGrid.id);
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems(pmsGrid.id);
			
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
				  url : './insertAnnualReport.do' ,
				  type: 'post',
				  contentType: "application/json; charset=UTF-8",
				  data : JSON.stringify(arJson),
				  success : function(data, textStatus, jqXHR) {
					  var gridData = data;
					  
					  if(data.success) {	
						   fn_btnSetting();
						   AUIGrid.setProperty(pmsGrid.id, "editable" , false ); 
						   pmsGrid.load();
					  } else {
						  AUIGrid.removeAjaxLoader(pmsGrid.id);
						  alert(data.message);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(textStatus);
				  }
			});
		});
		
		//X버튼클릭
		$("#btnX").click(function(){
			$("#btnAnnualAdd").hide();
		    $("#btnAnnualDelete").hide();
		    $("#btnAnnualModify").show();
		    $("#btnAnnualSave").hide();
		    $("#btnX").hide();
		    AUIGrid.setProperty(pmsGrid.id, "editable" , false );
		    AUIGrid.resetUpdatedItems(pmsGrid.id, "d" );
		});
		
		//수정버튼클릭
		$("#btnAnnualModify").click(function(){
			$("#btnAnnualAdd").show();
		    $("#btnAnnualDelete").show();
		    $("#btnAnnualModify").hide();
		    $("#btnAnnualSave").show();
		    $("#btnX").show();
		    AUIGrid.setProperty(pmsGrid.id, "editable" , true );
		});
	   
 });  
 
 
 var pmsGrid = {
		 	id: '',
		 	div: {
		 		gridDiv: '#pmsGrid'
		 	},
		 	proxy: {
		 		url: './selectAnnualReportList.do',
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
			    /* usePaging : true,
			    pageRowCount : 5,
			    showPageButtonCount : 5, */
			    showStateColumn: true,
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    showRowNumColumn : true,
			    showRowCheckColumn : false,
			    //enableColumnResize : false,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,
				//height: 265,
			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 41,
			    rowHeight: 37,
			    selectionMode : "multipleCells",

			    displayTreeOpen : true,
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
			 	dataField : "ANNUAL",
			 	headerText : "연차",
			 	width : 60,
			 	filter : {
					showIcon : true
				},
			 	editable : true	
			 },{
			 	dataField : "SUMMARY",
			 	headerText : "Summary",
			 	width : 90,
			 	filter : {
					showIcon : true
				},
			 	editable : true	
			 },{
			    headerText: "기간",
			    headerStyle : "th_center_style",
			    children: [{
			    	dataField : "PERIOD_FROM",
			    	headerText : "FROM",
			    	editable : true,
			    	dataType : "date",
			    	width : 100,
			    	
			    	filter : {
						showIcon : true
					},
			        formatString : "yyyy-mm-dd",
			    	editRenderer : {
			    		type : "CalendarRenderer",
			    		showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
			    		onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
			    		showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			    	}

			    }, {
			    	dataField : "PERIOD_TO",
			    	headerText : "TO",
			    	editable : true,
			    	dataType : "date",
			    	width : 100,
			    	filter : {
						showIcon : true
					},
			        formatString : "yyyy-mm-dd",
			    	editRenderer : {
			    		type : "CalendarRenderer",
			    		showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
			    		onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
			    		showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
			    	}
			    }]    
			 },{
			 	dataField : "SAFETY",
			 	headerText : "Safety",
			 	filter : {
					showIcon : true
				},
			 	editable : true 	
			 },{
			 	dataField : "EFFICACY",
			 	headerText : "efficacy",
			 	//width : 120,
			 	filter : {
					showIcon : true
				},
			 	editable : true 	
			 },{
			 	dataField : "FDRMREPORT_PRESENTNDE",
			 	headerText : "정기보고<br>제출일",	
			 	editable : true,
			 	dataType : "date",
			 	width : 100,
		        formatString : "yyyy-mm-dd",
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
				    headerText: "조사기간",
				    headerStyle : "th_center_style",
				    children: [{
				    	dataField : "EXAMINPD_FROM",
				     	headerText : "조사기간<br>FROM",	
				     	editable : true,
				     	dataType : "date",
				        formatString : "yyyy-mm-dd",
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
				    }, {
				    	dataField : "EXAMINPD_TO",
				     	headerText : "조사기간<br>TO",	
				     	editable : true,
				     	width : 120,
				     	dataType : "date",
				        formatString : "yyyy-mm-dd",
				        filter : {
							showIcon : true
						},
				     	editRenderer : {
				    		type : "CalendarRenderer",
				    		showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
				    		onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				    		showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
				    	}
				    }]    
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
		 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {
		 		    		userId = data.USER_ID;		 		    		
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.result);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 			    	AUIGrid.setProperty(pmsGrid.id, "editable" , false ); 
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

function fn_btnSetting(){
    $("#btnAnnualAdd").hide();
    $("#btnAnnualDelete").hide();
    $("#btnAnnualModify").show();
    $("#btnAnnualSave").hide();
    $("#btnX").hide();
}
 
//AUIGrid 생성 후 반환 ID
 //var myGridID;
window.onresize = function() {
	if (typeof pmsGrid.id !== "undefined") {
		AUIGrid.resize(pmsGrid.id);
	}
}
 
 

 

 </script>
<title>PMS 연차보고서</title>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMR0201&UPPER_MENU_ID=CTMR" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMR0201&UPPER_MENU_ID=CTMR" charEncoding="utf-8"/>
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

            <section class="conBox100 conBox">
                <div class="conBoxInner" style="min-height:900px;">

                    
                    <div>
	                    <article class="conTitBtnR">
	                        <input type="button" id="btnAnnualAdd" value="행추가" class="add_01" title="행추가">
	                        <input type="button" id="btnAnnualDelete" value="행삭제" class="del_01" title="행삭제">
	                        <input type="button" id="btnAnnualModify" value="수정" class="edit_01" title="수정">
	                        <input type="button" id="btnAnnualSave" value="저장" class="save_01" title="저장">
	                        <input type="button" id="btnX" value="취소"  class="close_01" title="취소">
	                    </article>
                    </div>



                    <article class="mgT40">
                         <div id="pmsGrid" class="gridHeiSz17 grid_wrap tb01_2"></div>
                    </article>



                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
	</div>
</section>
</div>
</body>
</html>