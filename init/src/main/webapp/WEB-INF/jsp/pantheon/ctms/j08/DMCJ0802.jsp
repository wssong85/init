<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<!-- 상단 css, js 임포트 호출 -->


<script type="text/javascript">
var idCount = "01"; 
var checkToRadio = false;
var overlapCnt = false; //true 중복체크 완료 , false 충복체크 미완료
var checkValues = []; //수정화면일때 기존 역할 값 저장
var p_task_no;
var p_user_nm;
var p_cntrct_sttus;
var p_user_type = "";

//글쓰기 권한(송신) 그리드
var checkRoleGrid = {
	 	id: 'checkRoleGrid',
	 	div: {
	 		gridDiv: '#checkRoleGrid'
	 	},
	 	proxy: {
	 		url: './selectRoleId.do',
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
		   // rowIdField : "isChecked",
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
			editable : true
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
	 		//AUIGrid.showAjaxLoader(me.id);
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {	 
	 		    		console.log(data.result);
	 		    		console.log(data.param);
	 		    		checkRoleGridCode = data.result;
	 			    	//AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
	 		    	} else {
	 		    		//AUIGrid.removeAjaxLoader(me.id);
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
 	
 	//사용자구분에 따라 disible, clickCount가 true이면 수정화면
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
 			if($("#user_se_code").val()  == "01"){
 				p_user_type = "Y";
 				p_user_se_code = "01";
 			}else if($("#user_se_code").val()  == "02"){
 				p_user_type = "N"; 	
 				p_user_se_code = "02";
 			}
 			
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
		$("#txtInputKunnr").val("");
		$("#txtInputID").val("");
		$("#txtInputInttNm").val("");
		$("#txtInputUserNm").val("");
		$("#txtInputUserEngNm").val("");
		$("#txtInputTelNo").val("");
		$("#txtInputEmail").val("");
		
		idCount = $("#user_se_code").val();	
		
		if(idCount == "02"){ //외부
			insttCodeList();
		}
		fn_userSe();
	});

	
	//저장버튼 클릭
	$("#btnRoleSave").click(function(){
		console.log("txtInputInttNm:::"+$("#txtInputInttNm").val());
		var vUserId = $("#txtInputID").val();
		var insttTy;
		if(idCount == "01"){
			insttTy = "01"
		}else{
			insttTy = $("#insttType").val();	
			console.log(insttTy);
		}		
		
		if(overlapCnt == false){
			alert("아이디 중복체크를 해주세요");
			return;
		}
		
		if(!$("#txtInputTaskSn").val()){
			alert("과제를 선택해 주세요.");
			return;
		}
		
		if(!$("#txtInputID").val()){
			alert("아이디를 입력해 주세요.");
			!$("#txtInputID").focus();
			return;
		}
		
// 		if(!fn_CheckUserIdEng(vUserId)){
// 			alert("영문/숫자만 입력 가능합니다.");
// 			$("#txtInputID").focus();
// 			return;
// 		}
		
// 		if(!fn_CheckUserId1(vUserId)){
// 			alert("소문자만 입력 가능합니다.");
// 			$("#txtInputID").focus();
// 			return;
// 		}
		
// 		if(vUserId.length < 5){
// 			alert("ID는 5자 이상입력해 주세요.");
// 			$("#txtInputID").focus();
// 			return;
// 		}
		
		if(vUserId.length > 15){
			alert("ID는 15자 이하로 입력해 주세요.");
			$("#txtInputID").focus();
			return;
		}
		
		if(!$("#txtInputInttNm").val()){
			alert("기관을 입력해 주세요.");
			return;
		}
		
		if(!$("#txtInputEmail").val()){
			alert("이메일을 입력해 주세요.");
			$("#txtInputEmail").focus();
			return;
		}
		
		if(!$("#txtInputEmail").val()){
			alert("이메일을 입력해 주세요.");
			$("#txtInputEmail").focus();
			return;
		}
		
		if(!fn_Email($("#txtInputEmail").val())){
			alert("이메일 형식이 잘못되었습니다.");
			$("#txtInputEmail").focus();
			return;
		}
		
		
// 		if(!fn_CheckUserIdEng($("#txtInputUserEngNm").val())){
// 			alert("영문명은 영문만 입력 가능합니다.");
// 			$("#txtInputUserEngNm").focus();
// 			return;
// 		}
		
		var checkItems = AUIGrid.getCheckedRowItems(checkRoleGrid.id);
		if(checkItems =="" || checkItems == null){
			alert("역할을 선택해 주세요.");
			return;
		}
		
		
		if(confirm("저장 하시겠습니까?") == true){			
			//확인 진행				
		}else{
			return;
		}
		
		var crud = "";
		if(clickCount == true){ //수정화면일때
			crud = "U";
		}else{
			crud = "C";
		}
		
		var arJson = [];	
	
		var editedItems = AUIGrid.getCheckedRowItems(checkRoleGrid.id);			
		var inputUserId = $("#txtInputID").val();
		// 수정된 행 아이템들(배열)
		console.log("Kunnr::::"+$("#txtInputKunnr").val());
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CODE = checkItems[i].item.CODE;
			editedItems[i].USER_ID = inputUserId;
			editedItems[i].TASK_NO = $("#txtInputTaskNo").val();
			editedItems[i].TASK_SN = $("#txtInputTaskSn").val();
			editedItems[i].LAST_UPDUSR = userId;
			editedItems[i].KUNNR = $("#txtInputKunnr").val();
			editedItems[i].STD_TIME_SN = $("#standardTime").val();
			editedItems[i].USER_NM = $("#txtInputUserNm").val();
			editedItems[i].PASSWORD = "";
			editedItems[i].USER_ENGNM = $("#txtInputUserEngNm").val();
			editedItems[i].EMAIL = $("#txtInputEmail").val();
			editedItems[i].TELNO = $("#txtInputTelNo").val();
			editedItems[i].INSTT_TY = insttTy;
			editedItems[i].USER_SE_CODE = $("#user_se_code").val();
			editedItems[i].CRUD = crud;
			editedItems[i].INSTT_CODE = $("#txtInputKunnr").val();
			
			
			editedItems[i].ROLE_ID = checkItems[i].item.CODE;
			
			arJson.push(editedItems[i]);		
		}
		
		
		$.ajax({
			  url : './insertTaskUser.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {		
					  var params={"USER_ID" : inputUserId, "EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : $("#txtInputUserNm").val()/*userName*/}; //$("#txtInputEmail").val() 
					  //passwordEmail(params); //비밀번호 수정 이메일 발송
					  layerClose();
					  clickCount = false;
					  overlapCnt = true;
					  taskUserGrid.load();				  
				  } else {					  
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
		
	});
	
	//구분 라디오버튼 선택
	$(":input:radio[name='rdOperationSe']").click(function(){		
		
		AUIGrid.setAllCheckedRows(checkRoleGrid.id, false);
	});
	
	//체크박스 선택
	AUIGrid.bind(checkRoleGrid.id, "rowCheckClick", function(event){	
		var rowValue = event.item.CODE;
		var radioCheck = $(":input:radio[name='rdOperationSe']:checked").val();
		if(clickCount == true){	//수정화면이면
			if(radioCheck == "01"){ //01운영 02테스트용				
// 				AUIGrid.setCheckedRowsByValue(checkRoleGrid.id, 'CODE', checkValues);
// 	 			alert("역할은 수정할 수 없습니다.");
			}
		}else{			
			if(radioCheck == "01"){ //01운영 02테스트용				
				AUIGrid.setCheckedRowsByValue(checkRoleGrid.id, "CODE",rowValue);
			}
		}
		
		
	});
	
	//중복체크 버튼클릭
	$("#btnOverlapId").click(function(){
		var vUserId = $("#txtInputID").val();
		
		if(!$("#txtInputTaskSn").val()){
			alert("과제를 선택해주세요.");
			return;
		}
		if(!vUserId){
			alert("아이디를 입력해 주세요.");
			return;
		}
		
// 		if(!fn_CheckUserIdEng(vUserId)){
// 			alert("영문/숫자만 입력 가능합니다.");
// 			$("#txtInputID").focus();
// 			return;
// 		}
		
// 		if(!fn_CheckUserId1(vUserId)){
// 			alert("소문자만 입력 가능합니다.");
// 			$("#txtInputID").focus();
// 			return;
// 		}
		
// 		if(vUserId.length < 5){
// 			alert("5자 이상입력해 주세요.");
// 			$("#txtInputID").focus();
// 			return;
// 		}
		
		if(vUserId.length > 15){
			alert("15자 이하로 입력해 주세요.");
			$("#txtInputID").focus();
			return;
		}
		
		
		$.ajax({
 		    url: './selectOverlapUserInfo.do',
 		    type: 'post',
 		    dataType: 'json',
 		    data: {'TASK_SN' : $("#txtInputTaskSn").val(), 'USER_ID' : vUserId},
 		    success:function(data){
 		    	if(data.success) {	 
 		    		
 			    	if(data.result == "" || data.result == null){
 			    		alert("사용가능한 아이디 입니다.");
 			    		overlapCnt = true; //중복체크 완료
 			    	}else{ 			    		
 			    		alert("중복된 아이디가 있습니다.");
 			    		overlapCnt = false; //중복체크 미완료
 			    	}
 		    	} else { 		    		
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
	});
	
	
// 	$("#txtInputUserEngNm").keyup(function(){
// 		$(this).val($(this).val().replace(/[^\!-z]/g,""));
// 		console.log("keyup");
// 	});
	
});

function passwordEmail(param){
	$.ajax({
		    url: "<c:url value='/com/anonymous/selectCmUserForFindId.do'/>",
		    type: 'post',
		    dataType: 'json',
		    data: {
		    	'USER_NM' : param['USER_NM'],
		    	'EMAIL' : 'kimbokmin@cj.net'//param['EMAIL']
		    },
		    success:function(data){
		    	if(data.success) {
		    		$.ajax({
		    		    url: "<c:url value='/com/anonymous/updateCmUserForSendTmpMail.do'/>",
		    		    type: 'post',
		    		    dataType: 'json',
		    		    data: {
		    		    	'USER_ID': param['USER_ID'],
		    		    	'USER_NM' : param['USER_NM'],
		    		    	'EMAIL' : 'kimbokmin@cj.net' //param['EMAIL']
		    		    },
		    		    success:function(data){
		    		    	if(data.success) {
		    		    		//alert('<spring:message code="comf0101.msg.2"/>');
		    		    	} else {
		    		    		alert(data.message);
		    		    	}
		    		    },
		    		error : function(jqXHR, textStatus, errorThrown){
		    			alert(textStatus);
		    		}
		    	});
		    	} else {
		    		alert(data.message);
		    	}
		    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
	
	
}
/**
 * 영문 소문자 + 숫자만 들어가도록 id 체크
 * @param value
 * @returns
 */
function fn_CheckUserId1(value) {
	var check = /^[a-z0-9]{0,32}$/g;
	return check.test(value);
}

function fn_CheckUserIdEng(value){
	var check = /^[a-zA-Z0-9]*$/;
	return check.test(value);
}

function fn_Email(value){
	var check = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	return check.test(value);
}
function fn_userRoleInfo(){	
	$.ajax({
		    url: './selectUserRoleInfo.do',
		    data: {'TASK_SN' : paramItem.TASK_SN, 'USER_ID' : paramItem.USER_ID},//me.proxy.param,
		    type: 'post',
		    dataType: 'json',		    
		    success:function(data){
		    	if(data.success) {
		    		var items = data.result;		    		
		    		
		    		checkValues = [];
		    		for(i = 0; i<items.length; i++){
		    			checkValues[i] = items[i].ROLE_ID;	    			
		    			
		    		}
		    	
		    		AUIGrid.setCheckedRowsByValue(checkRoleGrid.id, 'CODE', checkValues);
		    		
		    		
		    		
		    	} else {
		    		
		    		alert(data.message);
		    	}
		    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
		});
}

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
	if(clickCount == false){ //수정화면이 아닐때
		if(idCount == "01"){ //사용자 구분이 내부사용자일때
			$("input[name=txtInputUserNm]").attr("disabled",true);		
			$("input[name=txtInputInttNm]").attr("disabled",true);		
			$("input[name=txtInputEmail]").attr("disabled",true);		
			$("input[name=txtInputTelNo]").attr("disabled",true);
			//$("input[name=txtInputUserEngNm]").attr("disabled",true);		
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
		
		overlapCnt = true;
		idCount = paramItem.USER_SE_CODE;
		insttCodeList();
		fn_userRoleInfo();
		$("#txtInputTaskSn").val(paramItem.TASK_SN);
		$("#txtInputTaskNo").val(paramItem.TASK_NO);
		$("#txtInputUserEngNm").val(paramItem.USER_ENGNM);
		$("#insttType").val(paramItem.INSTT_TY);
		$("#txtInputID").val(paramItem.USER_ID);
		$("#txtInputKunnr").val(paramItem.DEPT_CD);
		//$("#txtInputInttNm").val(paramItem.DEPT_NM);
		$("#txtInputInttNm").val(paramItem.DEPT_NM)
		$("#standardTime").val(paramItem.STD_TIME_SN);
		$("#insttType").attr("disabled",true);
		$("#btnSearchTask").hide();
		$("#btnInputID").hide();
		$("#btnInttNm").hide();
		$("#btnOverlapId").hide();
		
		$("#txtInputUserNm").attr("disabled",true);
		//$("#txtInputUserEngNm").attr("disabled",true);
		$("#txtInputTelNo").attr("disabled",true);
		$("#txtInputEmail").attr("disabled",true);
		
		if(paramItem.INSTT_TY == "02" || paramItem.INSTT_TY =="03"){
				
		}
		
		$("#user_se_code").val(paramItem.USER_SE_CODE);
		$("#txtInputUserNm").val(paramItem.USER_NM);
		$("#txtInputUserEngNm").val(paramItem.USER_ENGNM);
		$("#txtInputTelNo").val(paramItem.TELNO);
		$("#txtInputEmail").val(paramItem.EMAIL);
		$("#standardTime").val(paramItem.STD_TIME_SN);	
		$("select[name=user_se_code]").attr("disabled",true);
		$("input[name=rdOperationSe]").attr("disabled",true);
		if(idCount == "01"){ //사용자구분이 내부사용자일때				
			$("input[name=txtInputInttNm]").attr("disabled",true);	
			$("input[name=txtInputID]").attr("disabled",true);	
			$("select[name=insttType]").attr("disabled",true);
			$("#insttType").empty();
		}else{			
			$("input[name=txtInputInttNm]").attr("disabled",true);
			$("input[name=txtInputID]").attr("disabled",true);	
			$("#insttType").val(paramItem.INSTT_TY);
			
		}
	}
	
}

function fn_setInstt(){
	//returnValue.INSTT_CODE;	
	$("#txtInputInttNm").val(returnValue.INSTT_NAME);
	$("#txtInputKunnr").val(returnValue.KUNNR);
	
}




//사용자 정보
function fn_setUserInfo(){
	$("#txtInputID").val(returnValue.USER_ID);
	$("#txtInputUserNm").val(returnValue.USER_NM);
	$("#txtInputTelNo").val(returnValue.TELNO);
	$("#txtInputEmail").val(returnValue.EMAIL);
	$("#txtInputInttNm").val(returnValue.DEPT_NM);
	$("#txtInputKunnr").val(returnValue.KUNNR_CODE);	
	var r_userid = returnValue.USER_ID;
	$.ajax({
	    url: './selectUserRoleId.do',
	    data: {'USER_ID' : r_userid},//me.proxy.param,
	    type: 'post',
	    dataType: 'json',		    
	    success:function(data){
	    	if(data.success) {
	    		
	    		var items = data.result;		    		
	    		
	    		checkValues = [];
	    		for(i = 0; i<items.length; i++){
	    			checkValues[i] = items[i].ROLE_ID;	    			
	    			
	    		}
	    	
	    		AUIGrid.setCheckedRowsByValue(checkRoleGrid.id, 'CODE', checkValues);
	    	} else {
	    		
	    		alert(data.message);
	    	}
	    },
	error : function(jqXHR, textStatus, errorThrown){
		alert(textStatus);
	}
	});
	
	
}

function fn_setTaskNo(){
	$("#txtInputTaskSn").val(returnTaskValue.TASK_SN);
	$("#txtInputTaskNo").val(returnTaskValue.TASK_NO);
	
	
}






</script>
</head>
<body>

				<section class="popupWrap">
					<div class="popup wd800" >	
						<section class="conBox100 popup_conBox" style='margin:0px;'>
							<div class="popup_conBoxInner">

					             <table class="tb001">
									<colgroup>
										<col width="13%" />
										<col width="37%" />
										<col width="13%" />
										<col width="" />
									</colgroup>
					           		<tbody>
										<tr>					
											<th>운영 구분<span class="must_01"></span></th>
											<td> 
                                                <input type="radio" id="ra01" name="rdOperationSe" value="01" checked><label for="ra01" class="raLab"><span>운영</span></label>
                                                <input type="radio" id="ra02" name="rdOperationSe" value="02"><label for="ra02" class="raLab"><span>테스트</span></label>
                                            </td>
                                            <th>사용자 구분<span class="must_01"></span></th>
											<td>
												<select id="user_se_code" name="user_se_code" style="width:100%;">
												</select>
											</td>	
										</tr>	
										<tr>					
											<th>과제번호<span class="must_01"></span></th>
                                            <td>
                                            	<input type="hidden" id="txtInputTaskSn">
                                                <input type="text" id="txtInputTaskNo" disabled style="width:70%;">
												<input type="button" id="btnSearchTask" value="조회" >
                                            </td>
                                            <th>아이디<span class="must_01"></span></th>
                                            <td>
                                                <input type="text" id="txtInputID" name="txtInputID" maxlength="32" style="width:40%;">
												<input type="button" id="btnInputID" value="조회" > 
                                                <input type="button" id="btnOverlapId" value="중복체크" >
                                            </td>                      
										</tr>
										<tr>		
											<th id="insttNmType">기관 유형<span class="must_01"></span></th>
											<td>
												<select id="insttType" name="insttType" style="width:100%;">
												</select>
											</td>												
                                            <th>기관명<span class="must_01"></span></th>
                                            <td>
                                            	<input type="hidden" id="txtInputKunnr" disabled>
                                                <input type="text" id="txtInputInttNm" disabled style="width:70%;">
												<input type="button" id="btnInttNm" value="조회" >
                                            </td> 
										</tr>		
										<tr>
                                            <th>사용자명</th>
                                            <td>
                                                <input type="text" id="txtInputUserNm" name="txtInputUserNm" maxlength="66" style="width:100%;"> 
                                            </td> 
                                            <th>영문명</th>
                                            <td>
                                                <input type="text" id="txtInputUserEngNm" name="txtInputUserEngNm" maxlength="200" style="width:100%;"> 
                                            </td> 
										</tr>	
										<tr>
                                            <th>연락처</th>
                                            <td>
                                                <input type="text" id="txtInputTelNo" name="txtInputTelNo" maxlength="20" style="width:100%;"> 
                                            </td>  
                                            <th>이메일<span class="must_01"></span></th>
                                            <td>
                                                <input type="text" id="txtInputEmail" name="txtInputEmail" maxlength="100" style="width:100%;">  
                                            </td> 
										</tr>	
										<tr>
										 	 
										</tr>
										<tr>
											<th>표준시간<span class="must_01"></span></th>
                                            <td>
                                                <select id="standardTime" name="standardTime" style="width:100%;">
												</select>
                                            </td>  
											<th>역할<span class="must_01"></span></th>
                                            <td>
                                            </td>
										</tr>
									</tbody>
								</table>
								
								
			                    <article class="mgT15">					                   
			                        <div id="checkRoleGrid" class="gridHeiSz04 grid_wrap tb01_2"></div>					                         
			                    </article>


								

								<article class="mgT20">
									<div style="text-align: center">
						                <input type="button" id="btnRoleSave" value="저장">
						                <input type="button" id="btnList" value="닫기">
					                </div>
								</article>



							</div>
						</section>
				    </div>
				</section>

</body>
</html>