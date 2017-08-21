

<%@page pageEncoding="UTF-8"%>    




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


//과제조회 팝업 데이터 저장
function fn_setTaskNo(){	
	$("#txtInputTaskNo").val(returnTaskValue.TASK_NO);
	$("#txtInputTaskSN").val(returnTaskValue.TASK_SN);	
}

//사용자 권한조회 팝업 데이터 그리드에 적용
function fn_serRoleInfo(event){
	var item = {'ROLE_ID':returnRoleValue.ROLE_ID, 'ROLE_NM':returnRoleValue.ROLE_NM, 'RM':returnRoleValue.RM};
	
    if(gridDataCount == 1){ //송신그리드
    	AUIGrid.updateRow(grSend.id, item, "selectedIndex"); //수신그리드 추가
    	var row = {		
    			
				'ROLE_ID':   '',
				'ROLE_NM':   '',					
				'RM': '',	
				'LAST_UPDUSR' : userId,
				'MANAGE_SE'   : 'R',
				'CRUD': 'C'		
			
		};		
    	if(AUIGrid.isUniqueValue(grReception.id, 'ROLE_ID', event.item['ROLE_ID']) == true) {
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
	 	id: 'grSend',
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
			width:150,
			editable : true,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = grSend;
				var retStr = "";
				
				for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
					if(me.columnLayout[2].editRenderer.list[i]['CODE'] == value) {
						retStr = me.columnLayout[2].editRenderer.list[i]['NAME'];
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
	 		
	 		AUIGrid.bind(grSend.id, "cellDoubleClick", function(event){
	 			if(event.columnIndex == 3){
	 				var param={};
					mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
	 			}
	 			
	 		});
	 		
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
	 		    		me.columnLayout[2].editRenderer.list = data.roleId;
// 	 		    		
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
	 	id: 'grReception',
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
			editable : true,
			labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
				var me = grReception;
				var retStr = "";
				
				for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
					if(me.columnLayout[2].editRenderer.list[i]['CODE'] == value) {
						retStr = me.columnLayout[2].editRenderer.list[i]['NAME'];
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
	 		    		me.columnLayout[2].editRenderer.list = data.roleId;
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
			 mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
		}
		
	});
	$("#btnList").click(function(){
		layerClose();	
		notice_sn = "";
	});
	
    
	//송신 그리드 행추가
	$('#btnLeftSave').click(function() {		
			var row = {						
					
					'ROLE_ID':   '',
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
		var grSendIdRole = AUIGrid.getRowIndexesByValue(grSend.id, "ROLE_ID","");
		var grReceptionIdRole = AUIGrid.getRowIndexesByValue(grReception.id, "ROLE_ID","");
		//비어있는 그리드 감지
		if(grSendIdRole != ""){
			alert("비어있는 행이 있습니다.");
			return;
		}
		//비어있는 그리드 감지
		if(grReceptionIdRole != ""){
			alert("비어있는 행이 있습니다.");
			return;
		}
		if(confirm("저장하시겠습니까?") == true){
			//확인진행
		}else{
			return;
		}
		
		var arJson = [];
		var roleInfo = {'MODULE_SE' : $("#selectModule").val()
				      , 'NOTICE_SE' : radioCheck 
				      , 'TASK_SN'   : $("#txtInputTaskSN").val()
				      , 'LAST_UPDUSR' : userId
		    };
		
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
							  
							  layerClose();	
						  }else{ //과제일때
							  if($("#txtInputTaskSN").val() == ""){ 	//과제순번이 비었을때
								  alert("과제를 선택해 주세요");
								  return;
							  }else{
								  insertGrSend();
								  insertGrReception();	
								 
								  layerClose();								  
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



<section class="popupWrap">
	<div class="popup wd1000" >	
		<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<h5>신규</h5>

				<div style="height:5px;"></div>
				
				<table class="tb001">
					<colgroup>
						<col width="10%" />
						<col width="23%" />
						<col width="10%" />
						<col width="23%" />
						<col width="10%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>모듈  </th>
							<td>
								<select id="selectModule" name="selectModule" style="width:100%;">								
								</select>
							</td>
							<th>공지구분 </th>
							<td>
                                      <input type="radio" id="rdAll" name="noticeDivision" value="01" checked><label for="rdAll" class="raLab"><span>전체</span></label>
                                      <input type="radio" id="rdTask" name="noticeDivision" value="02"><label for="rdTask" class="raLab"><span>과제</span></label>
							</td>
							<th>과제번호 </th>
							<td>
								<input type="hidden" id="txtInputTaskSN">
								<input type="text" id="txtInputTaskNo" disabled style="width:150px;">
								<input type="button" id="btnSearchTask" value="조회" >
							</td>
						</tr>
					</tbody>
				</table>

				
				<div style="height:10px;"></div>


				<div style=" width:50%; display:inline-block; padding:6px; box-sizing: border-box; ">
                    <article class="conTitBox">
                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">글쓰기 권한(송신)</h6>
                    </article>
                    

                    <article class="conTitBtnR">
                        <input type="button" id="btnLeftSave" value="행추가">
                        <input type="button" id="btnLeftDel" value="행삭제">
                    </article>
                    
					<div style="height:10px;"></div>

					<div id="grSend" class="gridHeiSz06 grid_wrap tb01_2"></div>
				</div>
                   
                   
                   <div style=" width:49.54%; display:inline-block; padding:6px; box-sizing: border-box; ">
                    <article class="conTitBox">
                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">글보기 권한(수신)</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnRightSave" value="행추가">
                        <input type="button" id="btnRightDel" value="행삭제">
                    </article>
                    
					<div style="height:10px;"></div>
					
					<div id="grReception" class="gridHeiSz06 grid_wrap tb01_2"></div>
				</div>
			                    




				<div style="text-align:center; margin-top:10px;">
	                <input type="button" id="btnRoleSave" value="저장">
	                <input type="button" id="btnList" value="닫기">  					                          
	            </div>

			</div>
		</section>
    </div>
</section>

