<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	
<script type="text/javascript">
var fileSn;
var fileNm;
var fileItem;
var fileCount = "0"; //수정화면에서 파일을 처음 업로드 할때
var sttusCtn = ""; //저장:01, 요청:02 구분

var uploadFileGrid = {
		id: 'uploadFileGrid',
		div: {
			gridDiv: '#uploadFileGrid'
		},
		proxy: {
			url: '/ctms/h01/selectRequestFileNm.do',
			param: {'FILE_MASTR_SN' : fileMarsterSn},
			type: 'post',
			dataType: 'json',
			//페이징 true, false 로 지정
			paging: false,
			//처음 시작시 데이터 로딩
			autoLoad: true
		},
		gridPros: { 
		//showStateColumn: true,
	    showRowNumColumn : true,
	    showRowCheckColumn : true,
	    //rowCheckToRadio : true,
	    enableColumnResize : false,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
		height: 240,
	    // 한 화면 페이징 버턴 개수 5개로 지정
	    //showPageButtonCount : 4,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",

	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃
		columnLayout : [{
		dataField : "FILE_MASTR_SN",
		headerText : "파일순번",
		editable : true	,
		visible : false
	},{
		dataField : "DETAIL_SN",
		headerText : "상세순번",
		editable : true	,
		visible : false
	},{
		dataField : "ORGINL_FILE_NM",
		headerText : "파일명",
		editable : true	
	},{
		dataField : "FRST_CREDE",
		headerText : "등록일",
		dataType : "date",
		formatString : "yyyy-mm-dd",
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
			    		//var fileNm;
			    		//fileNm = data.result;
			    		//console.log(data.result);
			    		AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	
			    		AUIGrid.removeAjaxLoader(me.id);
				    	
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



$(document).ready(function(){	
	uploadFileGrid.createGrid();
	mkSetDatePickerYYMMDD("#txtInputWorkingDate");
	//maxlength 
	$("#txtTitle").attr("maxlength", 66);
	$("#txtContents").attr("maxlength", 1332);
	
	//모듈 selectbox 
	var moduleBoxText;
	moduleBoxText += "<option value=''></option>";
	for(var i=0; moduleCode.length > i; i++){
		moduleBoxText += "<option value='"+moduleCode[i].CODE+"'>"+moduleCode[i].NAME+"</option>";
 	}
	$("#selectModule").append(moduleBoxText);
	
	//요청구분 selectbox 
	var requestBoxText;
	requestBoxText += "<option value=''></option>";
	for(var i=0; requestCode.length > i; i++){
		requestBoxText += "<option value='"+requestCode[i].CODE+"'>"+requestCode[i].NAME+"</option>";
 	}
	$("#selectRequest").append(requestBoxText);
	
	//과제조회버튼 클릭
 	$("#btnSearchTask").click(function(){ 		
		var param={};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
 	});
	
	//목록 버튼클릭
	$("#btnRequestList").click(function(){
		fileMarsterSn ="";
		layerClose();		
	});
	
	//첨부파일 버튼클릭
	$("#btnSearchFile").click(function(){		
		var param={ PROGRAM_ID : "CTMH0102" ,FILE_SN : $("#txtInputFileSn").val()};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1105.do", param, 1);
		
	});
	
	//저장버튼 클릭
	$("#btnRequestSave").click(function(){		
		if($("#txtInputTaskNo").val() == ""){
			alert("과제번호를 입력해 주세요");
			return;
		}
		if($("#txtInputWorkingDate").val() == ""){
			alert("작업희망일을 입력해 주세요");
			return;
		}
		if($("#selectModule").val() == ""){
			alert("모듈을 선택해 주세요");
			return;
		}
		if($("#selectRequest").val() == ""){
			alert("요청구분을 선택해 주세요");
			return;
		}
		if($("#txtTitle").val() == ""){
			alert("제목을 입력해 주세요");
			return;
		}
		
		if(confirm("저장 하시겠습니까?") == true){
			//확인진행
		}else{
			return;
		}
		
		if(moduleDiv == "0"){ //CTMS에서 팝업을 열었을때
			sttusCtn = "01";
		}else{ //DMC에서 팝업을 열었을때
			sttusCtn = "02";
		}
		
		fn_insertRequest();	
		
	});
	
	//셀 더블클릭
	AUIGrid.bind(uploadFileGrid.id, "cellDoubleClick", function(event){
		var item;
		item = event.item;
		fn_downFile(item.FILE_MASTR_SN, item.DETAIL_SN);
	});
	
	
	//첨부파일 삭제
	$("#btnDeleteFile").click(function(){
		
		AUIGrid.removeCheckedRows(uploadFileGrid.id);
		var arJson = [];
		
		var removeItems = AUIGrid.getRemovedItems(uploadFileGrid.id);
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CRUD = 'D';
			removeItems[i].LAST_UPDUSR = userId;			
			arJson.push(removeItems[i]);
		}
		
		$.ajax({
			  url : '/ctms/h01/insertUploadFile.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {	
				  if(data.success) {			
					  var params = {'FILE_MASTR_SN' : paramItem.FILE_MASTR_SN};
							
					  uploadFileGrid.proxy.param = params; 	
					  uploadFileGrid.load();
				  } else {					  
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});//ajax
	});
	
	//삭제버튼 클릭
	$("#btnRequestDelete").click(function(){
		if(confirm("삭제 하시겠습니까?") == true){
			//확인진행
		}else{
			return;
		}
		
		var arJson = [];
		var requestInfo = {'CRUD' : 'D', 'SN' : paramItem.SN};
		arJson.push(requestInfo);
		
		$.ajax({
			  url : './insertRequestForm.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {	
				  if(data.success) {
					  fileMarsterSn = "";
					  layerClose();
					  requestGrid.load();					  
				  } else {					  
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});//ajax				
	});
	
	//요청버튼 클릭
	$("#btnRequest").click(function(){
		if(confirm("요청 하시겠습니까?") == true){
			//확인진행
		}else{
			return;
		}
		sttusCtn = "02";
		fn_insertRequest();
		
	});
	
}); 

window.onresize = function() {
	if (typeof uploadFileGrid.id !== "undefined") {
		AUIGrid.resize(uploadFileGrid.id);
	}
}


function fn_insertRequest(){
	//console.log($("#txtInputFileSn").val());
	var dataDivision;
	if(modiCount == "0"){ //신규
		dataDivision = "C";
	}else if(modiCount = "1"){//수정
		dataDivision = "U";
	} 
	
	var sttus = "";
	if(sttusCtn == "01"){
		sttus = "04";
	}else{
		sttus = "01";
	}
	//console.log("dataDivision::"+dataDivision);
	//console.log("sttus:::"+sttus);
	var arJson = [];
	var requestInfo = {'TASK_SN' : $("#txtInputTaskSn").val(),
					   'RQESTER' : userId, 'PSITN' : user_dept, 
					   'OPERT_HOPEDE' : $("#txtInputWorkingDate").val(),
					   'MODULESE' : $("#selectModule").val(), 
					   'REQUSTSE' : $("#selectRequest").val(),
					   'SJ' : $("#txtTitle").val(),
					   'CN' : $("#txtContents").val(), 
					   'LAST_UPDUSR' : userId,
					   'ROLE' : user_role,
					   'FILE_MASTR_SN' : $("#txtInputFileSn").val(), 
					   'SN' : $("#txtInputRequestSn").val(),
					   'CRUD' : dataDivision,
					   'STTUS' : sttus};
	

	arJson.push(requestInfo);
	

	$.ajax({
		  url : '/ctms/h01/insertRequestForm.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {	
			  if(data.success) {	
				  fileMarsterSn = "";
				  layerClose();	
				  fn_GridLoad();
				 
			  } else {					  
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
}

//임시저장일때만 입력/수정 가능
function fn_disabled(){	
	if(paramItem.STTUS != "04" || paramItem.STTUS != "03"){
		if(paramItem.STTUS == "01"){
			$("#btnSearchTask").attr("disabled",true);
			$("#btnRequestSave").attr("disabled",true);
			$("#txtInputBelong").attr("disabled",true);
			$("#txtInputWorkingDate").attr("disabled",true);
			$("#selectModule").attr("disabled",true);
			$("#selectRequest").attr("disabled",true);
			$("#txtTitle").attr("disabled",true);
			$("#txtContents").attr("disabled",true);
			$("#btnSearchFile").attr("disabled",true);
			$("#btnDeleteFile").attr("disabled",true);
			
			$("#btnRequestDelete").hide();
			$("#btnRequestSave").hide();
			$("#btnSearchTask").hide();
			$("#btnSearchFile").hide();
			$("#btnDeleteFile").hide();
			$("#btnRequest").hide();
		}else if(paramItem.STTUS == "02"){
			$("#btnSearchTask").attr("disabled",true);
			$("#btnRequestSave").attr("disabled",true);
			$("#txtInputBelong").attr("disabled",true);
			$("#txtInputWorkingDate").attr("disabled",true);
			$("#selectModule").attr("disabled",true);
			$("#selectRequest").attr("disabled",true);
			$("#txtTitle").attr("disabled",true);
			$("#txtContents").attr("disabled",true);
			$("#btnSearchFile").attr("disabled",true);
			$("#btnDeleteFile").attr("disabled",true);
			
			$("#btnRequestDelete").show();
			$("#btnRequestSave").hide();
			$("#btnSearchTask").hide();
			$("#btnSearchFile").hide();
			$("#btnDeleteFile").hide();
			$("#btnRequest").hide();
		}
		
	}
}

function fn_downFile(fileMastrSn, fileSn){
	window.open("<c:url value='/com/z02/selectDmFileDetailByPk.do?FILE_MASTR_SN="+fileMastrSn+"&DETAIL_SN="+fileSn+"'/>");
}

//신규화면일때
function fn_newPopup(){
	$("#txtInputRequester").val(userId);
	$("#txtInputBelong").val(user_dept); //작성자 부서
	$("#txtInputRole").val(user_role); //작성자 역할
	$("#btnRequestDelete").hide();
	fileSn = "";
	if(moduleDiv == "1"){
		$("#btnRequest").hide();
	}
	
}




//수정화면일때 데이터 받기
function fn_popupDetail(){
	
	var currDate = paramItem.OPERT_HOPEDE.split("-");
	var formatDate = new Date(currDate);
	var day = formatDate.getDate();
	var month = formatDate.getMonth();
	var year = formatDate.getFullYear();
	month += 1;
	var zero = "";
	if(month.length < 1, 2){
		zero += "0";
	}
	
	var date = year + "-"  + zero+month + "-" + day;	
	//console.log(date_str);
	$("#txtInputTaskSn").val(paramItem.TASK_SN); //과제순번
	$("#txtInputTaskNo").val(paramItem.TASK_NO); //과제번호	
	$("#txtInputRequester").val(paramItem.RQESTER); // 요청자
	$("#txtInputWorkingDate").val(date); //작업희망일	
	$("#selectModule").val(paramItem.MODULESE); //모듈
	$("#selectRequest").val(paramItem.REQUSTSE); //요청구분
	$("#txtTitle").val(paramItem.SJ); //제목
	$("#txtContents").val(paramItem.CN); //내용
	$("#txtInputRequestSn").val(paramItem.SN); //request Form 순번
	$("#txtInputBelong").val(paramItem.PSITN); //작성자 부서
	$("#txtInputRole").val(paramItem.ROLE); //작성자 역할
	
	
	
}

function fn_setTaskNo(){
	$("#txtInputTaskSn").val(returnTaskValue.TASK_SN);
	$("#txtInputTaskNo").val(returnTaskValue.TASK_NO);
}

function fn_fileSn(){
	//console.log("modiCount::"+modiCount);
	if(modiCount == "0"){ //신규
		$("#txtInputFileSn").val(fileItem.ATCH_FILE_SN);
	}else if(modiCount == "1"){ //수정
		if(fileCount == "0"){
			//$("#txtInputFileSn").val(paramItem.FILE_MASTR_SN);
		}else{
			$("#txtInputFileSn").val(fileItem.ATCH_FILE_SN);
			fileCount = "0";
		}
		
	}
	//console.log("txtInputFileSn:::"+$("#txtInputFileSn").val());
	
	$.ajax({
		    url: "/ctms/h01/selectRequestFileNm.do",
		    type: "post",
		    dataType: "json",
		    data: {'FILE_MASTR_SN' : $("#txtInputFileSn").val()},//me.proxy.param,
		    success:function(data){
		    	if(data.success) {
		    		var fileName;
		    		fileName = data.result;		    		
		    		
		    		var addFileName="";		    		
		    			    		
		    		for(var i=0; i<fileName.length; i++){
		    			addFileName += fileName[i].ORGINL_FILE_NM + ",";		    			
		    		}
		    		var subFileName = addFileName.substring(0,addFileName.length-1);
		    		
		    		
		    		$("#txtInputFileNm").val(subFileName);
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




</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd800" >	
			<section class="conBox100 popup_conBox" style='margin:0px;'>
				<div class="popup_conBoxInner">		

		            <table class="tb001">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="" />
						</colgroup>
		           		<tbody>
							<tr>
								<th>과제번호<span class="must_01"></span></th>
                                <td>
                                	<input type="hidden" id="txtInputRequestSn">
                                	<input type="hidden" id="txtInputTaskSn">
                                    <input type="text" id="txtInputTaskNo" disabled>
									<input type="button" id="btnSearchTask" value="조회" >
                                </td>
                                <th>소속<span class="must_01"></span></th>
                                <td>                  
                                	<input type="hidden" id="txtInputRole">                          	
                                    <input type="text" id="txtInputBelong" disabled style="width:100%;">
								</td>
							</tr>
							<tr>
								<th>요청자<span class="must_01"></span></th>
								<td>
									<input type="text" id="txtInputRequester" disabled style="width:100%;">
								</td>
							
                                <th>작업희망일<span class="must_01"></span></th>
                                <td>
                                	<div class="dateBox">
                                		<input type="text" id="txtInputWorkingDate" disabled style="width: 120px;"/>
                                	</div>
                                </td>
							</tr>
							<tr>
								<th>모듈<span class="must_01"></span></th>
								<td>
									<select id="selectModule" name="selectModule" style="width:100%;">
									</select>
								</td>
								<th>요청구분<span class="must_01"></span></th>
								<td>
									<select id="selectRequest" name="selectRequest" style="width:100%;">
									</select>
								</td>	
							</tr>
							<tr>												
								<th>제목<span class="must_01"></span></th>
                                <td colspan="3">
                                    <input type="text" id="txtTitle" name="txtTitle" style="width:100%;"> 
                                </td>  											 										
							</tr>		
							<tr>
                                <th>내용</th>
                                <td colspan="3" style="padding-top:4px; padding-bottom: 0px;">
                                    <textarea rows="3" id="txtContents" name="txtContents" style="width:100%;"> </textarea>
                                </td> 
							</tr>	
							<tr>
                                <th>첨부파일</th>
                                <td colspan="3">
                                	<input type="text" style="width:75%;">
                                	<input type="hidden" id="txtInputFileSn" name="txtInputFileSn">

									<input type="button" id="btnSearchFile" value="파일찾기">			                               
									<input type="button" id="btnDeleteFile" value="삭제">
                                </td>
							</tr>
						</tbody>
					</table>						
						
								
                    <article class="mgT15">					                   
                        <div id="uploadFileGrid" class="gridHeiSz04 grid_wrap tb01_2"></div> 
                    </article>


					<article class="mgT20">
						<div style="text-align: center">
							<input type="button" id="btnRequest" value="요청">
							<input type="button" id="btnRequestDelete" value="삭제">
			                <input type="button" id="btnRequestSave" value="저장">
			                <input type="button" id="btnRequestList" value="닫기">
						</div>
					</article>

				</div>
			</section>
	    </div>
	</section>

</body>
</html>