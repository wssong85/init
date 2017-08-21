<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript">
var connect;  //팝업을 불러온 부모화면 프로그램 ID
var maxFileNum = 5;
function makeFileAttachment(){
	//파일업로드 제한 수
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	
}

$(function() {
	console.log("======>"+"${map.FILE_SN}");
	connect = "${map.PROGRAM_ID}";
	if(connect == "DMCJ0302"){
		maxFileNum = 1;
	}

	//문서로딩 후, MultiSelector 생성
	makeFileAttachment();
	
	$("#btnClose").click(function(){
		layerClose(1);
	});
/*
	$('#ajaxForm').ajaxForm({
		beforeSubmit: function (data,form,option) {
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
				console.log(data.result);
			} else {
				alert(data.message);
			}
		},
		error: function(){
			alert("file upload error!!");
		}
	});
*/
	$("#btnUpload").click(function() {

		var formData = new FormData();
		var formTag = $('#ajaxForm').children();	
		console.log("formTag.length : "+formTag.length);

		formData.append("FILE_SN", "${map.FILE_SN}");

		for(var i = 0; i < formTag.length; i++) {
			formData.append(formTag[i].name, formTag[i].value);
			
			if(formTag[i].type == 'file') {
				formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
			}
		}
		
		$.ajax({
			url : '/ctms/j11/insertDmFileMstr.do',
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {

				//부모창 프로그램ID 구분
				switch(connect){
					case 'CTMF0103': //PAPER 계약									
						var item = {ATCH_FILE : data.result}; 
						AUIGrid.updateRow(paperGrid.id, item, "selectedIndex");
						break;
					
					case 'CTMV0101': //IRB info 과제별 									
						var item = {ATCH_FILE_SN : data.result}; 
						AUIGrid.updateRow(myGridSub4.id, item, "selectedIndex"); 
						//myGridSub4.load();
						break;
					case 'CTMH0102' : //request form
						fileItem = {ATCH_FILE_SN : data.result}; 
						fileCount = "1";						 
						fn_fileSn();
						uploadFileGrid.load();
						break;
					case 'DMCJ0302' : //request form
						fileItem = {ATCH_FILE_SN : data.result};
						fn_fileSn();
						break;
				default:
				}
				
				layerClose(1);
			}
		});
	});

});


</script>



<section class="popupWrap">
	<div class="popup popup1 wd500">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h6>파일 첨부</h6>
				<article class="mgT5">
					<table class="tb001">
						<colgroup>
							<col style="width: 20%;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Type</th>
								<td>
									<input type="text" name="type" value="genericFileMulti" style="width:100%;" />
								</td>
							</tr>
							<tr>
								<th>파일첨부</th>
								<td style="padding-top:5px; padding-bottom:5px;">
									<form id="ajaxForm" method="post" enctype="multipart/form-data">
										<input type="file" name="file_1" id="egovComFileUploader" style="width:100%;" title="첨부파일입력"/>
										<div id="egovComFileList"></div>
										<input type="hidden" id="FILE_SN" value="${map.FILE_SN}"/>
									</form>
								</td>
							</tr>
						</tbody>
					</table>
				</article>

				<article class="mgT10">
					<div style="text-align:center">
						<input type="button" id="btnUpload" value="업로드" />					
						<input type="button" id="btnClose" value="닫기" />
					</div>
				</article>
		</div>
		</section>
	</div>
</section>

