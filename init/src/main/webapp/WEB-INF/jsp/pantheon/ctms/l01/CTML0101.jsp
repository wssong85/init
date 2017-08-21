<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript" src="<c:url value='/js/pantheon/edc/EDC.js'/>"></script>
<title>전체 계약 리스트</title>

<script type="text/javascript">
var _user = {
	'USER_ID': '${loginMap.USER_ID}'
};

var g_updateYn = 'N';
var n_rowSelect;
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
		    url: './selectInitInfoList.do',
		    param: {},
		    type: 'post',
		    dataType: 'json',
		    //페이징 true, false 로 지정
		    paging: true,
		    //처음 시작시 데이터 로딩
		    autoLoad: true,
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
    		   	, headerText : "과제번호"
    		   	, editable : false
    			, width: 120
    			, visible : false
    		   }
    		   ,{
      		   	  dataField : "INSTT_CODE"
      		   	, headerText : "연구기관<span class='must_01'></span>"
      		   	, editable : true
      			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
      				var me = myGridOption;
					var retStr = "";
					for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
						if(me.columnLayout[2].editRenderer.list[i]['INSTT_CODE'] == value) {
							retStr = me.columnLayout[2].editRenderer.list[i]['INSTT_NAME'];
							break;
						}
					}
					return retStr == "" ? value : retStr;
      		    }
    			, editRenderer : {
    				type : "DropDownListRenderer",
    				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
    				keyField : "INSTT_CODE",
    				valueField : "INSTT_NAME",
    				list : null,
    				// 드랍 리스트의 개별 아이템에 대하여 출력할 양식을 HTML 로 작성하여 반환하면 리스트로 출력됩니다.
    				listTemplateFunction : function(rowIndex, columnIndex, text, item, dataField, listItem) {
    					var html = '<div style="display:block;text-align:left;white-space:nowrap">';

    					for(var n in listItem) {
    						if(n != "flag") {
    							//html += '<span style="display:inline-block;width:80px;">' + listItem[n] + '</span>';
    						}
    					}
    					html += '<span style="display:inline-block;width:90px;">' + listItem["INSTT_CODE"] + '</span>';
    					html += '<span style="display:inline-block;width:300px;">' + listItem["INSTT_NAME"] + '</span>';
    					html += '<span style="display:inline-block;width:100px;">' + listItem["TELF1"] + '</span>';
    					html += '</div>';
    					return html;
    				}
    			  }
	    		, filter : {
	    	 		showIcon : true
	    	 	  }
      		   }
    		   ,{
       		   	  dataField : "PLAN_SE"
                , headerText : "계획<span class='must_01'></span>"
                , editable : true
       		   	, width: 180
      			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
      				var me = myGridOption;
					var retStr = "";
					for(var i=0; me.columnLayout[3].editRenderer.list.length > i; i++) {
						if(me.columnLayout[3].editRenderer.list[i]['CODE'] == value) {
							retStr = me.columnLayout[3].editRenderer.list[i]['NAME'];
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
      		   	  dataField : "PLAN_NM"
      		   	, headerText : "과제번호"
      		   	, editable : false
      			, width: 120
      			, visible : false
      		   }
               ,{
                  dataField : "PLAN_BEGIN"
                , headerText : "계획일(시작)<span class='must_01'></span>"
                , editable : true
            	, dataType : "date"
                , formatString : "yyyy-mm-dd"
            	, width:120
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
                  dataField : "PLAN_END"
                , headerText : "계획일(끝)<span class='must_01'></span>"
                , editable : true
                , dataType : "date"
                , formatString : "yyyy-mm-dd"
                , width:120
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
                   dataField : "EXECUT_BEGIN"
                 , headerText : "실행(시작)"
                 , editable : false
                 , dataType : "date"
                 , formatString : "yyyy-mm-dd"
                 , width:120
                 , editRenderer : {
                         type : "CalendarRenderer",
                         showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
                         onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
                         showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
					}
                 }
                ,{
                   dataField : "EXECUT_END"
                 , headerText : "실행(끝)"
                 , editable : false
                 , dataType : "date"
                 , formatString : "yyyy-mm-dd"
                 , width:120
                 , editRenderer : {
                         type : "CalendarRenderer",
                         showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 출력 여부
                         onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
                         showExtraDays : true // 지난 달, 다음 달 여분의 날짜(days) 출력
                     }
                 }
                ,{
                   dataField : "CHARGER_ID"
                 , headerText : "담당자<span class='must_01'></span>"
                 , editable : true
                 , visible : true
                 , width: 150
       			 , labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
						var me = myGridOption;
						var retStr = "";
						for(var i=0; me.columnLayout[8].editRenderer.list.length > i; i++) {
							if(me.columnLayout[8].editRenderer.list[i]['USER_ID'] == value) {
								retStr = me.columnLayout[8].editRenderer.list[i]['USER_NM'];
								break;
							}
						}
						return retStr == "" ? value : retStr;	
      		       }
                 , editRenderer : {
 	     			type : "DropDownListRenderer",
 	     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 	     			list : null,
 	     			keyField : "USER_ID",
 	     			valueField : "USER_NM"
 	     		  }
                 , filter : {
 	    	 		showIcon : true
 	    	 	  }
               }
		  ],
		  //AUI 그리드 생성
		  createGrid: function() {
		    var me = this;
		    
		    //이후 객체.id 로 AUIGrid 컨트롤
		    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
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

				//addRow 된 행은 수정가능, 그렇지 않은 경우 수정불가 처리하려 했으나 isAddedById 계속 false 만 리턴함.. ㅡ,.ㅡ;;
				if(event.dataField == "INSTT_CODE"
						|| event.dataField == "PLAN_SE"
						|| event.dataField == "PLAN_BEGIN"
						|| event.dataField == "PLAN_END"
						|| event.dataField == "CHARGER_ID"
				){

					if(AUIGrid.isAddedById(me.id, event.item.id)){
						//return true;
					}
					else{
						//return false;
					}
				}

			});

			AUIGrid.bind(me.id, "cellEditEnd", function(event) {

				var selectItem = AUIGrid.getSelectedItems(me.id);
				var selectData = selectItem[0];
				var dataField  = selectData.dataField;
				var headerText = selectData.headerText;

				if(AUIGrid.getSelectedIndex(me.id)[1] == 2 //연구기관 변경시
						|| AUIGrid.getSelectedIndex(me.id)[1] == 3 //계획 
						|| AUIGrid.getSelectedIndex(me.id)[1] == 4 //계획 시작
						|| AUIGrid.getSelectedIndex(me.id)[1] == 5 //계획 끝
						|| AUIGrid.getSelectedIndex(me.id)[1] == 8) {
					var gridData   = AUIGrid.getGridData(me.id);
					var gridRows   = gridData.length;
					var clickRow   = event.rowIndex;
					var cInsttCode = gridData[clickRow].INSTT_CODE;
					var cPlanCode  = gridData[clickRow].PLAN_SE;
					var cUserId    = gridData[clickRow].CHARGER_ID;
					var cPlanBegin = gridData[clickRow].PLAN_BEGIN;
					var cPlanEnd   = gridData[clickRow].PLAN_END;
					
					var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
					cPlanBegin = cPlanBegin.replace(regExp, "");

					for(g=0; gridRows>g; g++){
						if(clickRow != g){
							var gData = gridData[g];
							var insttCode = gData.INSTT_CODE;
							var planCode  = gData.PLAN_SE;
							var userId    = gData.CHARGER_ID;
							var planBegin = gData.PLAN_BEGIN;
							var planEnd   = gData.PLAN_END;

							//연구기관, 계획, 담당자 같은지 확인.
							if((cInsttCode == insttCode) 
									&& (cPlanCode  == planCode ) 
									&& (cUserId    == userId   ) 
									&& (cPlanBegin == planBegin) 
									&& (cPlanEnd   == planEnd  )){
								alert(headerText+" 중복입니다.!! ");
								var userData;
								if(dataField == "INSTT_CODE") userData = { INSTT_CODE : "" };
								if(dataField == "PLAN_SE"   ) userData = { PLAN_SE    : "" };
								if(dataField == "CHARGER_ID") userData = { CHARGER_ID : "" };
								if(dataField == "PLAN_BEGIN") userData = { PLAN_BEGIN : "" };
								if(dataField == "PLAN_END"  ) userData = { PLAN_END   : "" };

								AUIGrid.updateRow(me.id, userData, clickRow);
							} // if
						} // if
					} // for
					
					if(!fn_checkPlanDate(cPlanBegin, cPlanEnd)){
						if(AUIGrid.getSelectedIndex(me.id)[1] == 4){
							alert("계획 시작일자가 종료일자보다 클 수 없습니다.");
							if(dataField == "PLAN_BEGIN") userData = { PLAN_BEGIN : "" };
						}
						else if(AUIGrid.getSelectedIndex(me.id)[1] == 5){
							alert("계획 종료일자가 시작일자 보다 작을 수 없습니다.");
							if(dataField == "PLAN_END"  ) userData = { PLAN_END   : "" };
						}
						AUIGrid.updateRow(me.id, userData, clickRow);
					}
				} // if
			});
					
					

			AUIGrid.bind(me.id, "cellClick", function(event) {
				n_rowSelect = event.rowIndex;
			});

		  },
		  //AUI 그리드 데이터 요청
		  init: function(v1, v2) {

		 		var me = this;
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		param = {'CMMN_CLCODE':'CTM003', 'TASK_SN':'${loginMap.TASK_SN}'};
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    //dataType: me.proxy.dataType,
		 		    data: param,
		 		    success:function(data){
		 		    	if(data.success) {
		 		    		
		 		    		g_updateYn = "N";
		 		    		
		 		    		me.columnLayout[2].editRenderer.list = data.insttlist;
		 		    		me.columnLayout[3].editRenderer.list = data.planlist;
		 		    		me.columnLayout[8].editRenderer.list = data.cralist;
		 		    		me.createGrid();

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
		 		
		 		var searchArr = {'TASK_SN':'${loginMap.TASK_SN}'};

		 		
				$.ajax({
					  url : './selectMileStonePlanList.do' ,
					  type: 'post',
					  //contentType: "application/json; charset=UTF-8",
					  data : searchArr,
					  success : function(data, textStatus, jqXHR) {
						  var gridData = data;

						  if(data.success) {
							  g_updateYn = "N";
							  AUIGrid.removeAjaxLoader(me.id);
							  AUIGrid.setGridData(me.id, data.result);
							  AUIGrid.setSelectionByIndex(me.id, 0);
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
	
	$("#btnRowCopy" ).hide();
	$("#btnAddrow"  ).hide();
	$("#btnRowDel"  ).hide();
	$("#btnUpdateYN").show();
	$("#btnSave"    ).hide();
	$("#btnClose"   ).hide();

	myGridOption.init();
	
	AUIGrid.setProperty("#grid_wrap", "editable" , false );
	
	// 탭메뉴
	$('#tab_menu1').click(function(){
		$("#frm").attr({
			action : './CTML0101.do',
			method : 'post'
		}).submit();
// 		window.location.href ="./CTML0101.do";
	});
	$('#tab_menu2').click(function(){
		$("#frm").attr({
			action : './CTML0102.do',
			method : 'post'
		}).submit();
		//window.location.href ="./CTML0102.do";
	});
	
	$('#btnClose').click(function(){
		AUIGrid.setProperty("#grid_wrap", "editable", false);

		$("#btnRowCopy" ).hide();
		$("#btnAddrow"  ).hide();
		$("#btnRowDel"  ).hide();
		$("#btnUpdateYN").show();
		$("#btnSave"    ).hide();
		$("#btnClose"   ).hide();
	});

	$('#btnUpdateYN').click(function(){	 //수정여부
		AUIGrid.setProperty("#grid_wrap", "editable", true);
	
		$("#btnRowCopy" ).show();
		$("#btnAddrow"  ).show();
		$("#btnRowDel"  ).show();
		$("#btnUpdateYN").hide();
		$("#btnSave"    ).show();
		$("#btnClose"   ).show();
	});

	$('#btnAddrow').click(function(){	 //행추가

        AUIGrid.setProperty("#grid_wrap", "editable" , true ); 
        var row = {
                  'SN': ''
                , 'TASK_SN': '${loginMap.TASK_SN}'
                , 'INSTT_CODE': ''
                , 'INSTT_NM': ''
                , 'PLAN_SE': ''
                , 'PLAN_BEGIN': ''
                , 'PLAN_END': ''
                , 'EXECUT_BEGIN': ''
                , 'EXECUT_END': ''
                , 'PLAN_DETAIL': ''
                , 'USER_NM': ''
                , 'CHARGER_ID': ''
                , 'UPDATE_ID': _user.USER_ID
                , 'LAST_UPDDE': new Date()
                , 'USE_AT': 'Y'
                , 'CURD': 'C'
        };      
        AUIGrid.addRow("#grid_wrap", row, 'first'); // 최하단에 행 추가
        var addRowIndex = AUIGrid.getRowCount("#grid_wrap");
        n_rowSelect = (addRowIndex - 1);
	});
	
	$('#btnRowCopy').click(function(){	 //계획 복사

		if( n_rowSelect >= 0 ){
			var gridData = AUIGrid.getGridData("#grid_wrap");
			var gData    = gridData[n_rowSelect];
	        AUIGrid.setProperty("#grid_wrap", "editable" , true ); 
	        var row = {
	                  'SN'          : ''
	                , 'TASK_SN'     : '${loginMap.TASK_SN}'
	                , 'INSTT_CODE'  : gData.INSTT_CODE
	                , 'PLAN_SE'     : gData.PLAN_SE
	                , 'PLAN_BEGIN'  : gData.PLAN_BEGIN
	                , 'PLANDE_END'  : gData.PLAN_END
	                , 'PLAN_DETAIL' : gData.PLAN_DETAIL
	                , 'CHARGER_ID'  : ''
	                , 'UPDATE_ID'   : _user.USER_ID
	                , 'LAST_UPDDE'  : new Date()
	                , 'USE_AT'      : 'Y'
	                , 'CURD'        : 'C'
	        };      
	        AUIGrid.addRow("#grid_wrap", row, (n_rowSelect+1)); // 선택row의 다음
		}

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
					  url : './insertMileStonePlanInfo.do' ,
					  type: 'post',
					  contentType: "application/json; charset=UTF-8",
					  data : JSON.stringify(arJson),
					  success : function(data, textStatus, jqXHR) {
						  var gridData = data;
						  
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

function fn_checkVal(){
	var gridData   = AUIGrid.getGridData("#grid_wrap");
	
	for(i=0; gridData.length > i; i++){
		var gData = gridData[i];
		var insttCode = gData.INSTT_CODE.length;
		var planCode  = gData.PLAN_SE   .length;
		var planBegin = gData.PLAN_BEGIN.length;
		var planEnd   = gData.PLAN_END  .length;
		var chargerId = gData.CHARGER_ID.length;
		
		if(insttCode > 0 && planCode > 0 && planBegin > 0 && planEnd > 0 && chargerId > 0){
			
		}
		else{
			var colNo = 0;
			if(chargerId <=0) colNo = 8;
			if(planEnd   <=0) colNo = 5;
			if(planBegin <=0) colNo = 4;
			if(planCode  <=0) colNo = 3;
			if(insttCode <=0) colNo = 2;
			
			AUIGrid.setSelectionByIndex("#grid_wrap", 0, colNo); // 첫번째 셀 선택되도록 지정
			alert((i+1)+"번째 해당 필수 값을 입력 하세요.");
			
			return false;
		}

	}
	
	return true;
}

function fn_checkPlanDate(startDate, endDate){
	var start = startDate.replace(/\//g, "");
	var end   = endDate  .replace(/\//g, "");
	if(start.length > 0 && end.length > 0){
		if(start > end){
			return false;
		}
	}
	return true;
}

function updateGridRow() {
	var item = {};
	item.STTUS = $("#rdo_status").val();
	item.GOAL_CO = $("#in_goalCo").val();
    myGridOption.updateGrid();
}

function fn_searchClick(){	
	myGridOption.load();
}

function setFieldToEditWindow(gridItem) {
	$("#rdo_status").html(gridItem.STTUS);
	$("#in_goalCo").val(gridItem.GOAL_CO);
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
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>Project Part</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>MILESTONE</li>
						<li>Project Part</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner">

						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_menu1" class="port_back tab_menu">계획리스트</li>
								<li id="tab_menu2" class="tab_menu">Milestone</li>
							</ul>
						</div>
							

						<article class="conGridUpper">
							<div class="conTitBtnR">									
	                        	<input type="button" id="btnRowCopy"  value="계획복사">
	                            <input type="button" id="btnAddrow"   value="행추가" class="add_01" title="행추가" >
	                            <input type="button" id="btnRowDel"   value="행삭제" class="del_01" title="행삭제" >
	                            <input type="button" id="btnUpdateYN" value="수정" class="edit_01" title="수정" >
	                            <input type="button" id="btnSave"     value="저장" class="save_01" title="저장" >
	                            <input type="button" id="btnClose"    value="닫기" class="close_01" title="닫기" >
							</div>
						</article>

						<article class="mgT43">
	                        <div id="grid_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
	                        <div id="CTML0101_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>

						<form id="frm" name="frm">
							<input id="TASK_SN" type="hidden" name="TASK_SN" value='${loginMap.TASK_SN}'>
						</form>


				</div>
            </section>



		</div>
	</section>

</div>
</body>
</html>