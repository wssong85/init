<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>연구자 Progress Note</title>
<script type="text/javascript">

var _user = {
		'USER_ID': '${loginMap.USER_ID}'
	};
var g_TaskSn   = ${loginMap.TASK_SN};//'${TASK_SN}';
var gridMainID;
var userList = [];
var irblist = [];

function getInsttId(userId) {
	var item;
	
	$.each(irblist, function(n, v) {
		if(v.USER_ID == userId) {
			item = v;
			return false;
		}
	});
	return item;
};

var grCtmPrgs = {
 	id: '',
 	div: {
 		gridDiv: '#grCtmPrgs'
 	},
 	proxy: {
 		url: '/ctms/z13/selectIRBBasicInfoList.do',
 		param: {
 			'TASK_SN': g_TaskSn
 		},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: true
 	},
 	gridPros: {
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    
 	    editable : true,
	    enableFilter : true,
	    
	    softRemoveRowMode  : true,
	    softRemovePolicy   : "exceptNew",

	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "singleRows",

	    displayTreeOpen : false,

 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
  		  dataField : "SN"
 		, headerText : "SN"
	   	, editable : false
		, visible : false
 	},{
  		  dataField : "TASK_SN"
 		, headerText : "TASK_SN"
	   	, editable : false
		, visible : false
 	},{
  		  dataField : "TASK_NO"
 		, headerText : '<spring:message code="ctms.gr.TASK_NO" />'	//과제번호
	   	, editable : false
		, visible : false
		, validator : function(oldValue, newValue, rowItem){
			var isValid = false;
			if(!newValue == ""){
				isValid = true;
			}
			return {"validate":isValid, "message":"필수입력 항목"};
		}
 	},{
		  dataField : "INSTT_ID"
 		, headerText : '<spring:message code="ctms.gr.INSTT_CODE" />'	//기관코드
	   	, editable : false
		, visible : false
 	},{
 		  dataField : "INSTT_NM"
 		, headerText : '<spring:message code="ctms.gr.INSTT_NAME" /><span style="color:red">*</span>'	//기관명
 		, width : 200
	   	, editable : false
		, visible : true
		, filter : {
			showIcon : true
		  }
 	},{
		  dataField : "USER_ID"
 		, headerText : '<spring:message code="ctms.gr.USER_ID" />'	//사용자ID
	   	, editable : true
		, visible : false
 	},{
 		  dataField : "USER_NM"
 		, headerText : '<spring:message code="ctms.gr.RSRCHUSER" /><span style="color:red">*</span>'	//사용자명
 	 	, width : 100
		, filter : {
			showIcon : true
		  }
 		, editRenderer : {
 			type : "RemoteListRenderer",
 			showEditorBtnOver : true,		//마우스 오버 시 에디터 버튼 보이기
 			fieldName : "USER_ID",			//event.value에서 보여주는 값.
 			remoter : function(request, response){		//remoter 지정 필수		
 				if(String(request.term).length < 2){
 					alert('<spring:message code="ctms.error.minlength" />');	//2글자 이상 입력하십시오.
 					response(false);		//데이터 요청이 없는 경우 반드시 false 삽입해야 함.
 					return;
 				} 				
 				$.ajax({
 					url: '/ctms/z13/selectUserInfoList.do',
 					data:{TASK_SN: g_TaskSn , USER_NM: request.term },
  				 	type: 'post',
  				 	dataType: 'json',
 					success: function(data){
 						//userList = data;
 						irblist = data.irblist
 						response(data.irblist);
 						if(data.success) {
		 			    	console.log("data.success : "+data.success);
		 		    	} else {
		 		    		console.log("data.else : "+data.success);
		 		    	}
 					}
 					,error : function(jqXHR, textStatus, errorThrown){
							alert(textStatus);
						}
 				})	//end of ajax
 			},
			listTemplateFunction : function(rowIndex, columnIndex, text, item, dataField, listItem) {
				var html = '<div>';
				html += '<span style="width:80px; text-align:left;">' + listItem.INSTT_ID + '</span>';
				html += '<span style="width:200px; text-align:left;">' + listItem.INSTT_NM + '</span>';
				html += '<span style="width:100px; padding-left:20px;">' + listItem.USER_ID + '</span>';
				html += '<span style="width:200px; padding-left:20px;">' + listItem.USER_NM + '</span>';
				html += '</div>';
				return html;
			} 	 		
 		}
 	},{
 		  dataField : "ISESTATN"
 		, headerText : '<spring:message code="ctms.gr.ISESTATN" />'	//내역
	   	, editable : true
		, visible : true
		, filter : {
			showIcon : true
		  }
 	},{
 		  dataField : "DETAIL_CN"
 		, headerText : '<spring:message code="ctms.gr.DETAIL_CN" />'	//상세내용
	   	, editable : true
		, visible : true
		, filter : {
			showIcon : true
		  }
 	},{
 		  dataField : "FRST_CREAT_DE"
 		, headerText : '<spring:message code="gr.FRST_CREDE" />'	//등록일
 		, dataType : "date"
 		, formatString : "yyyy-mm-dd"
 	 	, width : 100
	   	, editable : false
		, visible : true
		, filter : {
			showIcon : true
		  }
 	}],
 	
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		gridMainID = me.id;
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
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
				if(event.dataField == "USER_NM") {
					
					var insttId = getInsttId(event.value);
					
					if(typeof insttId  === "undefined") {
						return;
					}
					
 					AUIGrid.updateRow("#grCtmPrgs", { INSTT_ID : insttId.INSTT_ID, INSTT_NM : insttId.INSTT_NM, USER_ID : insttId.USER_ID, USER_NM : insttId.USER_NM }, event.rowIndex);
				}
				break;

			}

		});
		
 		AUIGrid.bind(me.id, 'cellClick', function(event) {
//   			if(AUIGrid.getSelectedIndex(me.id)[1] == 3) {
//  	 			$('#hdNoticeSn').val(event.item['NOTICE_SN']);
//  				document.frCmNotice.action = "<c:url value='/CMT/z13/CMTZ1301.do'/>";
//  				document.frCmNotice.submit();
//   			}
		});

 		AUIGrid.bind(me.id, "cellClick", function(event) {
			n_rowSelect = event.rowIndex;
		});
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		if(me.proxy.paging && !v1 && !v2) {
 			me.proxy.param.page = me.div.paging.currentPage;		
 			me.proxy.param.count= me.div.paging.rowCount;		
 		}
 		
 		if(v1 && v2) {
 			me.proxy.param.page = v2;	
 			me.div.paging.currentPage = v2;
 			me.proxy.param.count = v1;		
 			me.div.paging.rowCount = v1;		
 		}
 		
 		AUIGrid.showAjaxLoader(me.id);

 		$.ajax({
		    url : '/ctms/z13/selectIRBBasicInfoList.do' ,//변경
		    type: 'post',
 		    data: me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
					AUIGrid.setGridData(me.id, data.irblist);
					irbBasicInfo = data.irblist;
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	$("#btnMAddrow").hide();
					$("#btnMDelete").hide();
					$("#btnMClose" ).hide();
					$("#btnMSave"  ).hide();
					$("#btnMUpdate").show();
					
					AUIGrid.setProperty("#grCtmPrgs", "editable", false);
					
 		    	} else {
 		    		AUIGrid.removeAjaxLoader("#grCtmPrgs");
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
 	}
};


function checkSelection() {
	var selectedItems = AUIGrid.getSelectedItems(gridMainID);
	if(selectedItems.length <= 0)
		return;
	
	var firstItem = selectedItems[0];
	
	// 행 상태 체크하기
	var state = getItemState(firstItem.item);
	
	return state;
}

// 아이템 상태 반환
function getItemState(curItem) {
	
	var rowIdField = AUIGrid.getProperty(gridMainID, "rowIdField");
	var rowIdValue = curItem[rowIdField];

	// 추가된 행인지 여부 검사.
	var isAdded = AUIGrid.isAddedById(gridMainID, rowIdValue );
	if(isAdded) return "Added";
	
	// 수정된 행인지 여부 검사
	var isEdited = AUIGrid.isEditedById(gridMainID, rowIdValue );
	if(isEdited) return "Edited";
	
	// 삭제된 행인지 여부 검사
	var isRemoved = AUIGrid.isRemovedById(gridMainID, rowIdValue );
	if(isRemoved) return "Removed";

	return "Normal";
}

function getUpdateCheck(){
	
	var rows = AUIGrid.getRowCount("#grCtmPrgs");
	
	if(rows >0 ){
        var added  = AUIGrid.getAddedRowItems ("#grCtmPrgs");
		var edited = AUIGrid.getEditedRowItems("#grCtmPrgs");
		var remove = AUIGrid.getRemovedItems  ("#grCtmPrgs");
		return (added.length)+(edited.length)+(remove.length);
	}
	return 0;
}

function fn_checkVal(){
	var gridData = AUIGrid.getGridData("#grCtmPrgs");
	
	for(i=0; gridData.length > i; i++){
		
		var gData     = gridData[i];
		var insttId   = gData.INSTT_ID.length;
		var insttNm   = gData.INSTT_NM.length;
		var userId 	  = gData.USER_ID.length;
		var userNm 	  = gData.USER_NM.length;
		var isestatn  = gData.ISESTATN;
		var detailCn  = gData.DETAIL_CN;
		
		if(insttId>0 || insttNm>0){	//기관 입력 check
			
		}else{
			AUIGrid.setSelectionByIndex("#grCtmPrgs", i, 3);
			alert("기관명은 필수 입력입니다.");
			
			return false;
		}
		
		if(userId>0 || userNm>0){	//연구자 입력 check
			
		}else{
			AUIGrid.setSelectionByIndex("#grCtmPrgs", i, 5);
			alert("연구자명은 필수 입력입니다.");
			
			return false;
		}
		
		if(isestatn != null){		//내역 길이 check
			
			if(isestatn.length > 0){
				var strLen = isestatn.length;
				var totalByte = 0;
				var oneChar = "";
				
		        for (var j = 0; j < strLen; j++) {
		        	oneChar = isestatn.charAt(j);
		            if (escape(oneChar).length > 4) {
		                totalByte += 3;
		            } else {
		                totalByte++;
		            }
		        }
				console.log("totalByte : "+totalByte);
				if(totalByte > 498){ // DB Size 1000일 경우 한글  334자 1002로 error, 한글, 영문 byte합 1333
					AUIGrid.setSelectionByIndex("#grCtmPrgs", i, 7);
					alert("내역은 500자를 넘을 수 없습니다.");
					return false;
				}
			}
		}		//내역 길이 check end
		

		if(detailCn != null){		//상세내용 길이 check

			if(detailCn.length > 0){
				var strLen = detailCn.length;
				var totalByte = 0;
				var oneChar = "";
				
		        for (var k = 0; k < strLen; k++) {
		        	oneChar = detailCn.charAt(k);
		            if (escape(oneChar).length > 4) {
		                totalByte += 3;
		            } else {
		                totalByte++;
		            }
		        }
				console.log("totalByte : "+totalByte);
				if(totalByte > 1998){ // DB Size 1000일 경우 한글  334자 1002로 error, 한글, 영문 byte합 1333
					AUIGrid.setSelectionByIndex("#grCtmPrgs", i, 8);
					alert("상세내용은 2000자를 넘을 수 없습니다.");
					return false;
				}
			}
		}		//상세내용 길이 check end
		
	}	//end for
	return true;
}

$(function(){

//  $("#btnMAddrow").hide();
// 	$("#btnMDelete").hide();
// 	$("#btnMSave"  ).hide();
	
	grCtmPrgs.createGrid();
	
	//버튼 클릭 이벤트
	$('#btnMUpdate').click(function(){	 //수정여부	
		AUIGrid.setProperty("#grCtmPrgs", "editable", true);
		$("#btnMAddrow").show();
		$("#btnMDelete").show();
		$("#btnMSave"  ).show();
		$("#btnMClose" ).show();			
		$("#btnMUpdate").hide();
	});

	$('#btnMClose').click(function(){	 //수정여부	
			AUIGrid.setProperty("#grCtmPrgs", "editable", false);
			$("#btnMAddrow").hide();
			$("#btnMDelete").hide();
			$("#btnMClose" ).hide();
			$("#btnMSave"  ).hide();		
			$("#btnMUpdate").show();
	});
	
	$('#btnMAddrow').click(function(){	 //행추가
		
// 		if(getUpdateCheck() > 0){
// 			alert("변경내역이 존재 합니다. 변경 내역을 저장하세요.");
// 			return;
// 		}
	
        AUIGrid.setProperty("#grCtmPrgs", "editable" , true );
        
        var row = {
        				'INSTT_ID'  		: ''
	    		   	  , 'INSTT_NM'  		: ''
			    	  , 'USER_ID'   		: ''
		    		  , 'USER_NM'   		: ''
	    		   	  , 'ISESTATN'  		: ''
	    		   	  , 'DETAIL_CN'			: ''
	    		   	  , 'USE_AT'			: 'Y'
	                  , 'FRST_CREAT_DE'     : new Date()
	                  , 'TASK_SN'			: g_TaskSn
	                  , 'UPDATE_ID'			: _user.USER_ID
	                  , 'CURD'				: 'C'
        };
        AUIGrid.addRow("#grCtmPrgs", row, 'first');
	});

	$('#btnMDelete').click(function(){	 //행삭제
		var state = checkSelection();
		if(state == "Added"){
			g_deleteChange = "Y";
			AUIGrid.removeRow("#grCtmPrgs", "selectedIndex");
		}
		else{
			AUIGrid.removeRow("#grCtmPrgs", "selectedIndex");
		}
	});
	

	$('#btnMSave').click(function(){	 //저장

		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems("#grCtmPrgs");
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems("#grCtmPrgs");
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems("#grCtmPrgs");
		
		var cnt = 0;
		for(var i = 0; i < addedRowItems.length; i++) {
			var usrId = addedRowItems[i].USER_ID;
			
			arJson.push(addedRowItems[i]);
			cnt++;
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = _user.USER_ID;
			arJson.push(editedItems[i]);
			cnt++;
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			
			removeItems[i].CURD = 'D';
			removeItems[i].UPDATE_ID = _user.USER_ID;
			arJson.push(removeItems[i]);
			cnt++;
		}
		
		if(!fn_checkVal()) return;
		
		if(cnt > 0){
			if(confirm('<spring:message code="common.save.msg" />')){
				$.ajax({
					  url : '/ctms/z13/insertIRBBasicInfo.do' ,//변경 
					  type: 'post',
					  contentType: "application/json; charset=UTF-8",
					  data : JSON.stringify(arJson),
					  success : function(data, textStatus, jqXHR) {
						  var gridData = data;
						  
						  if(data.success) {
							  alert("저장되었습니다.");
							  grCtmPrgs.load();
						  } else {
							  AUIGrid.removeAjaxLoader("#grCtmPrgs");
							  alert(data.message);
						  }
					  }, 
					  error : function(jqXHR, textStatus, errorThrown){
						  alert(textStatus);
					  }
				});
			}
		} // if
		else{
			alert("변경 내역이 없습니다.");
		}

	}); // Main 저장
	
	$('#btnCtmPrgsSearch').click(function() {
		
		var params = {
				'TASK_SN': g_TaskSn
		};
		
		if($('#selectCtmPrgsCondition').val() == 'INSTT_NM') {
			params.INSTT_NM = $('#txtCtmPrgsCondition').val();
		} else if($('#selectCtmPrgsCondition').val() == 'USER_NM') {
			params.USER_NM = $('#txtCtmPrgsCondition').val();
		}
		
		grCtmPrgs.proxy.param = params;
		grCtmPrgs.load();
	});
	
});

//윈도우 리사이징 이벤트
window.onresize = function() {
	if (grCtmPrgs !== "undefined") {
		AUIGrid.resize(grCtmPrgs.id);
	}
};

</script>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1301&&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
		<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1301&&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
		
		<!-- 메인 시작 -->
		<!-- 연구자 Progress Note -->
		<section id="mainCon">		
			<article class="mainTitBox">
				<h3>${ progrmMap.MENU_NM }</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>${ progrmMap.UPPER_MENU_NM }</li>
						<li>${ progrmMap.MENU_NM }</li>
					</ul>
				</nav>
			</article>
			<div class="conBoxInner">
				
				<article class="mgB40">
					<!-- 검색 -->
					<div style="float:left;">
						<select id="selectCtmPrgsCondition" style="width:105px">
							<option value="INSTT_NM"><spring:message code="ctms.gr.INSTT_NAME" /></option>
							<option value="USER_NM"><spring:message code="ctms.gr.RSRCHUSER" /></option>
						</select>
						<input type="text" id="txtCtmPrgsCondition" style="width:200px"/>
						<input type="button" id="btnCtmPrgsSearch" class="btnmgL3" value='<spring:message code="button.search" />'>
					</div>
					<!-- 버튼 -->
	                <div class="conTitBtnR">
	                    <input type="button" id="btnMAddrow" class='add_01' 	title='<spring:message code="btn.rowAdd" />' 	value='<spring:message code="btn.rowAdd" />'>
	                    <input type="button" id="btnMDelete" class='del_01' 	title='<spring:message code="btn.rowDelete" />' value='<spring:message code="btn.rowDelete" />'>
	                    <input type="button" id="btnMUpdate" class='edit_01' 	title='<spring:message code="button.update" />' value='<spring:message code="button.update" />'>
	                    <input type="button" id="btnMClose"  class='close_01'	title='<spring:message code="button.update" />' value='<spring:message code="button.update" />'>
	                    <input type="button" id="btnMSave"   class='save_01' 	title='<spring:message code="btn.save" />' 		value='<spring:message code="btn.save" />'>
	                </div>
				</article>
				
				<article class="mgT20">
					<div id="grCtmPrgs" class="gridHeiSz10"></div>
				</article>
			</div>
		</section>
	</div>
</body>