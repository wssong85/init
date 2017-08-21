<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var _user = {
		'USER_ID' : '${loginMap.USER_ID}'
	};
	var g_eduInfo;
	var g_roleList;
	var s_roleList = [];
	var paramData;
	var returnEdcSn;
	var fileItem;
	var fileDetail;

	$(document).ready(function() {

		fn_init();
		fn_initLoad();

		//과제조회버튼 클릭
		$("#btnSearchTaskNo").click(function() {
			var param = {};
			mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
		});

		//기관조회버튼 클릭
		$("#btnSearchRole").click(function() {
			var param = {};
			p_instt_name = "";
			mkLayerPopupOpen("/ctms/j03/popupDMCJ0303.do", param, 2);
		});

		//모듈 변경시
		$("input[name=raPopEduGubun]").change(function() {
			var radioValue = $(this).val();
			fn_setInputBox(radioValue);
		});

		//모듈 변경시
		$("#selModuleSystem").change(function() {
			moduleCode = $("#selModuleSystem").val();
		});
		//모듈 변경시
		$("#selModuleTask").change(function() {
			moduleCode = $("#selModuleTask").val();
		});
		
		//저장버튼 클릭
		$("#btnEduSave").click(function() {
			
			if(!fn_checkVal()) return;

			if(confirm("저장 하시겠습니까?")){
				
// 				$("#filetForm").submit();
				fn_saveStart();
			}

		});
		
		//저장버튼 클릭
		$("#btnNewEduSave").click(function() {
			
			g_CRUD = "C";

			var eduInfo = {
				'EDC_SN'       : g_EDC_SN,
				'MODULE'       : g_MODULE,
				'TASK_SN'      : $("#txtTaskSn").val(),
				'TASK_NO'      : $("#txtTaskNo").val(),
				'TASK_NM'      : $("#txtTaskNm").val(),
				'SJ'           : $("#txtSj").val(),
				'ROLE_NM'      : $("#txtRoleNm").val(),
				'VER'          : $("#txtVer").val(),
				'ATCH_FILE_SN' : fileItem.ATCH_FILE_SN,
				'CN'           : $("#txtCn").val(),
				'USE_AT'       : 'Y',
				'CURD'         : 'C'
			};

			fn_saveEduInfo(eduInfo);

		});

		$("#btnEduClose").click(function() {
			layerClose();
		});

		$('#filetForm').ajaxForm({
			beforeSubmit: function (data,form,option) {
							
				if(data[0].value=="")
				{
					//saveForm($("#mode").val(), $('#file_id').val());
					return false;
				}
				//submit전 행동
				return true;
				
			},
			success: function(response,status){
				var data = '';
				
				try {
					data = JSON.parse(response);	
				} catch(e) {
					data = response;
				}
				
				if(data.success) {
					fileItem = {ATCH_FILE_SN : data.result};
					console.log("data.result : ATCH_FILE_SN >> "+data.result);
				} else {
					alert(data.message);
				}
			},
			error: function(){
				alert("file upload error!!");
			}
		});

		$(".fileIuputHid").change(function(){
		   var fileVal = $(this).val();
		   $("#filetForm").submit();
		   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
		});

	});
	
	function fn_checkVal(){

		var radioValue = $('input:radio[name="raPopEduGubun"]:checked').val();
		var sModule = "";
		if(radioValue == "T"){
			sModule = $("#selModuleTask").val();
		}
		if(radioValue == "S"){
			sModule = $("#selModuleSystem").val();
		}

		var sTaskSn = $("#txtTaskSn").val();
		var sSj     = $("#txtSj").val();
		var sRole   = $("#txtRoleNm").val();
		
		if (radioValue == "T") { //시스템
			if(!sTaskSn){
				alert("과제번호는 필수 입니다.");
				return false;
			}
		}
		if(!sModule){
			alert("모듈은 필수 선택 입니다.");
			$("#selModuleCode").focus();
			return false;
		}
		if(!sSj){
			alert("제목은 필수 입력 입니다.");
			$("#txtSj").focus();
			return false;
		}
		
		var sjLength = (function(s,b,i,c){
		    for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		    return b
		})(sSj);

		if(sjLength >= 101){
			alert("제목은 영문 100자, 한글 33자 이상 입력 할 수 없습니다.");
			var cutSj = sSj.substr(0, 99);
			$("#txtSj").val(cutSj);
			return false;
		}

		if(!sRole){
			alert("역할을 선택하여 주십시오.");
			$("#txtRoleNm").focus();
			return false;
		}

		var sFileNm = $("#fileName").val();
		if(!sFileNm){
			alert("첨부파일을 선택하세요.");
			return false;
		}
		
		return true;

	}

	function fn_saveStart(){
		if (g_CRUD == "C") {
			var radioValue = $('input:radio[name="raPopEduGubun"]:checked').val();
			if(radioValue == "S"){
				g_MODULE = $("#selModuleSystem").val();	
			}
			else if(radioValue == "T"){
				g_MODULE = $("#selModuleTask").val();	
			}
		}

		var eduInfo = {
			'EDC_SN' : g_EDC_SN,
			'MODULE' : g_MODULE,
			'TASK_SN' : $("#txtTaskSn").val(),
			'TASK_NO' : $("#txtTaskNo").val(),
			'TASK_NM' : $("#txtTaskNm").val(),
			'SJ' : $("#txtSj").val(),
			'ROLE_NM' : $("#txtRoleNm").val(),
			'VER' : $("#txtVer").val(),
			'ATCH_FILE_SN' : fileItem.ATCH_FILE_SN,
			'CN' : $("#txtCn").val(),
			'USE_AT' : 'Y',
			'CURD' : g_CRUD
		};

		fn_saveEduInfo(eduInfo);
	}
	function fn_saveEduInfo(eduInfo){
		var arJson = [];
		arJson.push(eduInfo);
		$.ajax({
			url : '/ctms/j03/insertEduInfo.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(arJson),
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					if (g_CRUD == "C") {
						g_EDC_SN = data.edcSn;
					}
					
					fn_saveRole();
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}

	function fn_saveRole() {
		var arJson = [];
		for (var i = 0; i < s_roleList.length; i++) {
			s_roleList[i].EDC_SN = g_EDC_SN;
			s_roleList[i].MODULE = g_MODULE;
			arJson.push(s_roleList[i]);
		}

		$.ajax({
			url : '/ctms/j03/insertEduRoleInfo.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(arJson),
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					grEducation.load();
					layerClose();
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}

	function fn_init() {
		$("#thTask").hide();
		$("#thSystem").show();
		$("#txtTaskSn").hide();
		$("#txtTaskNo").hide();
		$("#btnSearchTaskNo").hide();

		fn_comboModuleSystem();

		if (g_CRUD == "C") {
			$("#txtVer").val("1.0");
			$("#btnNewEduSave").hide();

			paramData = {
				EDC_SN : '',
				MODULE : ''
			};
			
			fileItem = {ATCH_FILE_SN : ""};
		} else {
			paramData = {
				EDC_SN : g_EDC_SN,
				MODULE : g_MODULE
			};
			
			$("#raPopSystem").attr("disabled",true);
			$("#raPopTask").attr("disabled",true);

			//$("#btnSearchRole").attr("disabled",true);
			$("#btnSearchTaskNo").attr("disabled",true);
		}
	}

	function fn_initLoad() {
		$.ajax({
			url : '/ctms/j03/selectEduInfo.do',
			type : 'post',
			dataType : 'json',
			data : paramData,
			success : function(data) {
				if (data.success) {
					g_eduInfo = data.eduInfo;
					g_roleList = data.roleList;

					if(g_eduInfo){
						fn_setEduInfo();
					}
					if(g_roleList){
						for(i=0; g_roleList.length > i; i++){
							if( g_roleList[i].ROLE_YN == "Y" ){
								s_roleList.push(g_roleList[i]);
							}
						}
					}
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
/*
	function fn_fileSn(){
		if(fileItem){
			
			var paramData = { FILE_MASTR_SN : fileItem.ATCH_FILE_SN };

			$.ajax({
				url : '/ctms/j11/selectDmFileDetail.do',
				type : 'post',
				dataType : 'json',
				data : paramData,
				success : function(data) {
					if (data.success) {
						fileDetail = data.fileInfo;

						var fileName = fileDetail.ORGINL_FILE_NM + "." + fileDetail.ORGINL_EXTSN_NM;
						$("#txtFileInfo").val(fileName);

					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		}
	}
*/
	function fn_setEduInfo(){
		if(g_eduInfo.TASK_SN){
 			fn_setInputBox("T");
 			$("input:radio[name=raPopEduGubun]:input[value='T']").attr("checked", true);
 			$("#selModuleTask").val(g_eduInfo.MODULE);
 			$("#selModuleTask").attr("disabled",true);
		}
		else{
 			fn_setInputBox("S");
 			$("input:radio[name=raPopEduGubun]:input[value='S']").attr("checked", true);
 			$("#selModuleSystem").val(g_eduInfo.MODULE);
 			$("#selModuleSystem").attr("disabled",true);
		}
		
		$("#txtTaskSn").val(g_eduInfo.TASK_SN);
		$("#txtTaskNo").val(g_eduInfo.TASK_NO);
		$("#txtTaskNm").val(g_eduInfo.TASK_NM);
		$("#txtSj"    ).val(g_eduInfo.SJ     );
		$("#txtRoleNm").val(g_eduInfo.ROLE_NM);
		$("#txtVer"   ).val(g_eduInfo.VER    );
		$("#txtCn"    ).val(g_eduInfo.CN     );

		fileItem = {ATCH_FILE_SN : g_eduInfo.ATCH_FILE_SN};

		var fileName = g_eduInfo.ORGINL_FILE_NM + "." + g_eduInfo.ORGINL_EXTSN_NM;
		$("#fileName").val(fileName);

		if(g_eduInfo.EDC_AT == "N"){
			var radioValue = $('input:radio[name="raPopEduGubun"]:checked').val();
			if(radioValue == "S"){
				$("#selModuleSystem").attr("disabled",true);
			}
			if(radioValue == "T"){
				$("#selModuleTask").attr("disabled",true);
			}
			
			$("#btnSearchRole").attr("disabled",true);
			$("#btnFileSelect").hide();
			$("#file_1").hide();
			$("#txtCn").attr("disabled",true);
			$("#btnNewEduSave").attr("disabled",true);
			$("#btnEduSave").attr("disabled",true);
		}
/*
		var tag = '<div id="download_'+ g_eduInfo.DETAIL_SN +'">'+
		'<a href="javascript:fn_downFile('+g_eduInfo.ATCH_FILE_SN+', '+g_eduInfo.DETAIL_SN+')">'+
		'<span style="color:blue;">'+fileName+' </span> '+
		'</a>'+
//		' <input type="button" value="Delete" style="margin:2px;" onclick="javascript:fn_deleteFile('+data.result[i].DETAIL_SN+')">'+
		'</div>';
		
		$('#downloadFileList').append(tag);
*/
	}

	function fn_setInputBox(value){
		if (value == "S") {
			$("#txtTaskSn").val("");
			$("#txtTaskNo").val("");
			$("#thTask").hide();
			$("#thSystem").show();
			$("#txtTaskSn").hide();
			$("#txtTaskNo").hide();
			$("#btnSearchTaskNo").hide();
	
			fn_comboModuleSystem();
		} else if (value == "T") {
			$("#thTask").show();
			$("#thSystem").hide();
			$("#txtTaskSn").show();
			$("#txtTaskNo").show();
			$("#btnSearchTaskNo").show();
	
			fn_comboModuleTask();
		}
	}
	function fn_comboModuleSystem() {
		var moduleCodeText = "<option value=''>선택</option>";
		for (var i = 0; com007List.length > i; i++) {
			moduleCodeText += "<option value='"+com007List[i].CODE+"'>" + com007List[i].NAME + "</option>";
		}
		$("#selModuleSystem").empty();
		$("#selModuleSystem").append(moduleCodeText);
	}

	function fn_comboModuleTask() {
		var moduleCodeText = "<option value=''>선택</option>";
		for (var i = 0; com007List.length > i; i++) {
			if (com007List[i].CODE == "EDC" || com007List[i].CODE == "IWRS") {
				moduleCodeText += "<option value='"+com007List[i].CODE+"'>" + com007List[i].NAME + "</option>";
			}
		}
		$("#selModuleTask").empty();
		$("#selModuleTask").append(moduleCodeText);
	}

	function fn_setTaskNo() {
		$("#txtTaskSn").val(returnTaskValue.TASK_SN);
		$("#txtTaskNo").val(returnTaskValue.TASK_NO);
	}
	
	function fn_downFile(fileMastrSn, fileSn) {
		window.open("<c:url value='/com/z02/selectDmFileDetailByPk.do?FILE_MASTR_SN=" + fileMastrSn + "&DETAIL_SN=" + fileSn + "'/>");
	}
	
	function fn_fileDown(){
		window.open("<c:url value='/com/z02/selectDmFileDetailByPk.do?FILE_MASTR_SN=" + g_eduInfo.ATCH_FILE_SN + "&DETAIL_SN=" + g_eduInfo.DETAIL_SN + "'/>");
	}
</script>



<section class="popupWrap">
	<div class="popup wd800">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h6>교육관리 작성</h6>
			<article class="mgT5">
				<table class="tb001">
					<colgroup>
						<col style="width: 15%;" />
						<col style="width: 45%;" />
						<col style="width: 15%;" />
						<col style="" />
					</colgroup>
					<tbody>
						<tr>
							<th>구분<span class='must_01'></span></th>
							<td colspan="3">
								<input type="radio" id="raPopSystem" name="raPopEduGubun" value="S" checked><label for="raPopSystem" class="raLab"><span>시스템</span></label>
								<input type="radio"	id="raPopTask" name="raPopEduGubun" value="T"><label for="raPopTask" class="raLab"><span>과제</span></label>
							</td>
						</tr>
						<tr id="thSystem">
							<th>모듈<span class='must_01'></span></th>
							<td colspan="3">
								<select id="selModuleSystem" name="selModuleCode" style="width:100%"></select>
							</td>
						</tr>
						<tr id="thTask">
							<th>모듈<span class='must_01'></span></th>
							<td>
								<select id="selModuleTask" name="selModuleCode" style="width:100%"></select>
							</td>
							<th>과제 번호<span class='must_01'></span></th>
							<td>
								<input type="hidden" id="txtTaskSn" name="txtTaskSn">
								<input type="text" id="txtTaskNo" name="txtTaskNo"	readonly="readonly" style="width:64%">
								<input type="button" id="btnSearchTaskNo" value="조회">
							</td>
						</tr>
						<tr>
							<th>제목<span class='must_01'></span></th>
							<td colspan=3>
								<input type="text" id="txtSj" name="txtSj"	maxLength="100" style="width: 100%">
							</td>
						</tr>
						<tr>
							<th>역할<span class='must_01'></span></th>
							<td>
								<input type="text" id="txtRoleNm" name="txtRoleNm"	readonly="readonly" style="width:80%">
								<input type="button" id="btnSearchRole" value="조회">
							</td>
							<th>Ver</th>
							<td>
								<input type="text" id="txtVer" name="txtVer" maxLength="5" readonly="readonly" style="width:100%">
							</td>
						</tr>
						<tr>
							<th>파일첨부<span class='must_01'></span></th>
							<td colspan="3">
								<form id="filetForm" action="<c:url value='/com/z02/insertDmFileMstr.do'/>" method="post" enctype="multipart/form-data">
					 				<div class="fileInputArea" style="width:86%;">
										<input type="text" id="fileName" readonly="readonly" onclick="fn_fileDown();" style="width:82%;">						 				
						 				<input type="button" value="파일 선택" class="fileInputBtn" />
						 				<input type="file" name="file_1" id="file_1" class="fileIuputHid" style="width:100%;">
					 				</div>
									<!-- input type="submit" id="submitUpload" value="업로드" /-->
								</form>
								<!-- form id="filetForm" action="<c:url value='/sdb/b01/insertDmFileMstr.do'/>" method="post" enctype="multipart/form-data">
									 <input type="file" name="file_1"  id="egovComFileUploader" size="60" title="첨부파일" />
									 <p><div id="downloadFileList"/></p>
									 <div id="egovComFileList"></div>
								</form-->
								<!-- input type="text" id="txtFileInfo" name="txtFileInfo" readonly="readonly" style="width: 80%">
								<input type="button" id="btnFile" value="파일 선택" /-->
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<th>변경사유</th>
							<td colspan="3" style="padding-top: 7px;">
								<textarea name="txtCn" id="txtCn" style="width: 100%" rows="3" MaxLength="4000"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			<article class="mgT10">
				<div style="text-align:center">
				    <input type="button" id="btnNewEduSave" value="개정">
					<input type="button" id="btnEduSave" value="저장">
					<input type="button" id="btnEduClose" value="닫기">
				</div>
			</article>
		</div>
		</section>
	</div>
</section>

