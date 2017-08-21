<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->


<script type="text/javascript">
var idCount = "01"; 
var p_task_no;
var p_user_nm;
var p_cntrct_sttus;
var p_user_type = "Y";

//글쓰기 권한(송신) 그리드
var checkRoleGrid = {
	 	id: 'checkRoleGrid',
	 	div: {
	 		gridDiv: '#checkRoleGrid'
	 	},
	 	proxy: {
	 		url: './selectCommonCodeList.do',
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
		    rowCheckToRadio : false,
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
		    height : 190,
		    selectionMode : "singleRow",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "CODE", //1
			headerText : "ROLE_ID",
			editable : false			
		},{
			dataField : "NAME", //2
			headerText : "ROLE_NAME",
			editable : false
		},{
			dataField : "USER_ID", //2
			headerText : "USER_ID",
			editable : false
		},{
			dataField : "TASK_SN", //2
			headerText : "TASK_SN",
			editable : false
		},{
			dataField : "TASK_NO", //2
			headerText : "TASK_NO",
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
	 		    data: {'CMMN_CLCODE' : 'DMCJ03'},//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 
	 		    		checkRoleGridCode = data.result;
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
	
//var p_instt_name;
$(document).ready(function(){
	//checkRoleGrid.createGrid();
	checkRoleGrid.createGrid();
	//paramItem
	
	//standardTime user_se_code
	/////////유저구분코드 select box append
	var userSeCodeText;
	for(var i=0; userSeCode.length > i; i++){
		userSeCodeText += "<option value='"+userSeCode[i].CODE+"'>"+userSeCode[i].NAME+"</option>";
 	}
	$("#user_se_code").append(userSeCodeText);
	
	
 	
	/////////표준시간 select box append
	var standardTimeText;
 	for(var i=0; standardTime.length > i; i++){
 		standardTimeText += "<option value='"+standardTime[i].STD_TIME_SN+"'>"+standardTime[i].STD_TIME_NM+"</option>";
 	}
 	$("#standardTime").append(standardTimeText);
 	///////////////////////////////
 	
 	//사용자구분에 따라 disible, clickCount가 1이면 수정화면
	fn_userSe();
 	
	//과제조회버튼 클릭
 	$("#btnSearchTask").click(function(){
 		if(clickCount == false){
 			var param={};
 			mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
 		}
 		
 	});
 	//기관조회버튼 클릭
 	$("#btnInttNm").click(function(){
 		if(clickCount == false){
	 		var param={  };
	 		p_instt_name = "";
			mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
 		}
 	});
 	
 	//사용자조회버튼 클릭
 	$("#btnInputID").click(function(){
 		if(clickCount == false){
 			var param={};
 			mkLayerPopupOpen("/ctms/j11/popupDMCJ1104.do", param, 1);
 		}
 		
 	});
 	
	$("#btnList").click(function(){
		//gridReset();
		layerClose();	
		clickCount = false;
		
	});
	
	$("#user_se_code").change(function(){	
		idCount = $("#user_se_code").val();	
		if(idCount == "01"){
			p_user_type = "Y";
		}else{
			p_user_type = "N";
			insttCodeList();
		}
		fn_userSe();
	
		
		
	});

	
	//저장버튼 클릭
	$("#btnRoleSave").click(function(){
		//$("#txtInputKunnr").val("9");
		var insttTy;
		if(idCount == "01"){
			insttTy = "01"
		}else{
			insttTy = $("#insttType").val();
			console.log("insttTy::::"+insttTy);
		}
		AUIGrid.updateAllToValue(checkRoleGrid.id, "USER_ID", $("#txtInputID").val());
		if(confirm("저장 하시겠습니까?") == true){			
			//확인 진행			
		}else{
			return;
		}
		var arJson = [];
		var taskUserInfo = {'USER_ID' : $("#txtInputID").val(), 'TASK_NO' : $("#txtInputTaskNo").val(),	
						'TASK_SN' : $("#txtInputTaskSn").val(), 'LAST_UPDUSR' : userId, 'KUNNR' : $("#txtInputKunnr").val(),
						'STD_TIME_SN' : $("#standardTime").val(), 'USER_NM' : $("#txtInputUserNm").val(), 'PASSWORD' : '1234',
						'USER_ENGNM' : $("#txtInputUserEngNm").val(), 'EMAIL' : $("#txtInputEmail").val(),
						'TELNO' : $("#txtInputTelNo").val(), 'INSTT_TY' : insttTy, 'USER_SE_CODE' : $("#user_se_code").val()};
	
		arJson.push(taskUserInfo);
		
		$.ajax({
			  url : './insertTaskUser.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {
					  insertRole();
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

function insttCodeList(){
	/////////기관유형 select box append
	var insttCodeText;
 	for(var i=1; insttCode.length > i; i++){
 		insttCodeText += "<option value='"+insttCode[i].CODE+"'>"+insttCode[i].NAME+"</option>";
 	}
 	$("#insttType").append(insttCodeText);
 	////////////////////////////////
}

function fn_userSe(){
	
	console.log("idCount:::"+idCount);
	if(clickCount == false){ //수정화면이 아닐때
		if(idCount == "01"){ //사용자 구분이 내부사용자일때
			$("input[name=txtInputUserNm]").attr("disabled",true);		
			$("input[name=txtInputInttNm]").attr("disabled",true);		
			$("input[name=txtInputEmail]").attr("disabled",true);		
			$("input[name=txtInputTelNo]").attr("disabled",true);
			$("input[name=txtInputUserEngNm]").attr("disabled",true);		
			$("input[name=txtInputID]").attr("disabled",true);	
			$("select[name=insttType]").attr("disabled",true);	
			$("#insttType").empty();		
			
		}else{
			$("input[name=txtInputUserNm]").attr("disabled",false);
			$("input[name=txtInputInttNm]").attr("disabled",false);		
			$("input[name=txtInputEmail]").attr("disabled",false);		
			$("input[name=txtInputTelNo]").attr("disabled",false);
			$("input[name=txtInputUserEngNm]").attr("disabled",false);
			$("input[name=txtInputID]").attr("disabled",false);	
			$("select[name=insttType]").attr("disabled",false);			
			
		}
	}else if(clickCount == true){ //수정화면일때
		idCount = paramItem.USER_SE_CODE;
		$("#txtInputTaskSn").val(paramItem.TASK_SN);
		$("#txtInputTaskNo").val(paramItem.TASK_NO);
		$("#insttType").val(paramItem.INSTT_TY);
		$("#txtInputID").val(paramItem.USER_ID);
		$("#txtInputKunnr").val(paramItem.USER_ID);
		$("#txtInputInttNm").val(paramItem.INSTT_NM);
		console.log(paramItem.INSTT_TY);
		if(paramItem.INSTT_TY == "02" || paramItem.INSTT_TY =="03"){
				
		}
		
		console.log($("#insttType").val());
		$("#user_se_code").val(paramItem.USER_SE_CODE);
		$("#txtInputUserNm").val(paramItem.USER_NM);
		$("#txtInputUserEngNm").val(paramItem.USER_ENGNM);
		$("#txtInputTelNo").val(paramItem.TELNO);
		$("#txtInputEmail").val(paramItem.EMAIL);
		$("#standardTime").val(paramItem.STD_TIME_SN);	
		$("select[name=user_se_code]").attr("disabled",true);	
		if(idCount == "01"){ //사용자구분이 내부사용자일때
			$("input[name=txtInputUserNm]").attr("disabled",true);		
			$("input[name=txtInputInttNm]").attr("disabled",true);		
			$("input[name=txtInputEmail]").attr("disabled",true);		
			$("input[name=txtInputTelNo]").attr("disabled",true);
			$("input[name=txtInputUserEngNm]").attr("disabled",true);		
			$("input[name=txtInputID]").attr("disabled",true);	
			$("select[name=insttType]").attr("disabled",true);	
			$("#insttType").empty();	
		}else{
			
			$("input[name=txtInputInttNm]").attr("disabled",true);
			$("input[name=txtInputID]").attr("disabled",true);	
			//$("select[name=insttType]").attr("disabled",true);
			$("#insttType").val(paramItem.INSTT_TY);
			
		}
	}
	
}

function fn_setInstt(){
	returnValue.INSTT_CODE;	
	$("#txtInputInttNm").val(returnValue.INSTT_NAME);
	$("#txtInputKunnr").val(returnValue.KUNNR);
	console.log("returnValue.KUNNR:::"+returnValue.KUNNR);
}

function insertRole(){
	
	var arJson = [];	
	
	var editedItems = AUIGrid.getCheckedRowItems(checkRoleGrid.id);	
	// 수정된 행 아이템들(배열)
	for(var i = 0; i < editedItems.length; i++) {	
		
		editedItems[i].CODE = editedItems[i].item.CODE;
		editedItems[i].USER_ID = editedItems[i].item.USER_ID;		
		editedItems[i].TASK_SN = editedItems[i].item.TASK_SN;
		editedItems[i].TASK_NO = editedItems[i].item.TASK_NO;
		editedItems[i].LAST_UPDUSR = userId;
		
		arJson.push(editedItems[i]);
		console.log(editedItems[i]);
	}
	
	
	
	$.ajax({
		  url : './insertTaskUserByRole.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {
			  var gridData = data;
			  
			  if(data.success) {	
				  layerClose();
				  clickCount = false;
				  taskUserGrid.load();
			  } else {
				  
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});

}

//사용자 정보
function fn_setUserInfo(){
	$("#txtInputID").val(returnValue.USER_ID);
	$("#txtInputUserNm").val(returnValue.USER_NM);
	$("#txtInputTelNo").val(returnValue.TELNO);
	$("#txtInputEmail").val(returnValue.EMAIL);
	$("#txtInputInttNm").val(returnValue.DEPT_NM);
}

function fn_setTaskNo(){
	$("#txtInputTaskSn").val(returnTaskValue.TASK_SN);
	$("#txtInputTaskNo").val(returnTaskValue.TASK_NO);
	AUIGrid.updateAllToValue(checkRoleGrid.id, "TASK_SN", returnTaskValue.TASK_SN);
	AUIGrid.updateAllToValue(checkRoleGrid.id, "TASK_NO", returnTaskValue.TASK_NO);
	
}






</script>
</head>
<body>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<section class="popupWrap">
					<div class="popup wd1000" >	
						<section class="conBox100 conBox">
							<div class="conBoxInner">		
								<div class="conTitBtnR">								
					                <input type="button" id="btnRoleSave" value="저장">
					                <input type="button" id="btnList" value="목록">  					                          
					            </div>					             
					            <table class="tb02">
					           		<tbody>
										<tr>					
											</select>
											</td>
											<th>과제번호</th>
                                            <td>
                                            	<input type="hidden" id="txtInputTaskSn">
                                                <input type="text" id="txtInputTaskNo" disabled> <input type="button" id="btnSearchTask" value="조회" >
                                            </td>
                                                                 
										</tr>	
										<tr>					
											<th>사용자 구분</th>
											<td>
											<select id="user_se_code" name="user_se_code">
											</select>
											</td>	
                                            
                                            <th id="insttNmType">기관 유형</th>
											<td>
											<select id="insttType" name="insttType">
											</select>
											</td>		
                                            		
                                                                         
										</tr>
										<tr>												
											<th>아이디</th>
                                            <td>
                                                <input type="text" id="txtInputID" name="txtInputID"> <input type="button" id="btnInputID" value="조회" >
                                            </td>  
                                            <th>기관명</th>
                                            <td>
                                            	<input type="hidden" id="txtInputKunnr" disabled>
                                                <input type="text" id="txtInputInttNm" disabled> <input type="button" id="btnInttNm" value="조회" >
                                            </td> 
											 										
										</tr>		
										<tr>
											
                                            <th>사용자명</th>
                                            <td>
                                                <input type="text" id="txtInputUserNm" name="txtInputUserNm"> 
                                            </td> 
                                            <th>영문명</th>
                                            <td>
                                                <input type="text" id="txtInputUserEngNm" name="txtInputUserEngNm"> 
                                            </td> 
										</tr>	
										<tr>
                                            <th>연락처</th>
                                            <td>
                                                <input type="text" id="txtInputTelNo" name="txtInputTelNo"> 
                                            </td>  
                                            <th>이메일</th>
                                            <td>
                                                <input type="text" id="txtInputEmail" name="txtInputEmail"> 
                                            </td> 
										</tr>	
										<tr>
										 	 
										</tr>
										<tr>
											<th>표준시간</th>
                                            <td>
                                                <select id="standardTime" name="standardTime">
												</select>
                                            </td>  
										</tr>
										<tr>
											<th>역할</th>
										</tr>
									</tbody>
									<table class="tb02">
					           		<tbody>
					           			<!-- 그리드 시작 -->
					                    <article class="mgT10">					                   
					                        <!-- 에이유아이 그리드가 이곳에 생성 -->							                        
					                        <div id="checkRoleGrid" ></div> 
					                    </article>
					                    <!-- 그리드 끝 -->
					           		</tbody>
					           		</table>
								</table>
								
								
							
							</div>
						</section>
				    </div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>