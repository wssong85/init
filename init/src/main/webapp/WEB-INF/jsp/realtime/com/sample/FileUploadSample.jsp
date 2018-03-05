<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <%@ taglib uri="http://www.egovframe.go.kr/tags/ext/jfile/jsp" prefix="jwork"%> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%-- <script type="text/javascript" src="<c:url value="/resource/jfile/json.js" />"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resource/jfile/jwork/jwork.fileUpload.js" />"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resource/jfile/jwork/jwork.fileDownload.js" />"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resource/jfile/swfupload/swfupload/swfupload.js" />"></script> --%>
<%-- <script type="text/javascript" src="<c:url value="/resource/jfile/swfupload/js/swfupload.queue.js" />"></script> --%>
<script type="text/javascript" src="<c:url value='/js/pantheon/com/aui/jquery-1.12.1.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/pantheon/common/jquery.form.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>


<%-- 	<link href="<c:url value="/resource/jfile/jqueryui/1.8/themes/base/jquery.ui.all.css" />" rel="stylesheet" type="text/css"/> --%>
<%-- 	<script type="text/javascript" src="<c:url value="/resource/jfile/jqueryform/2.4/jquery.form.js" />"></script> --%>
<%-- 	<script type="text/javascript" src="<c:url value="/resource/jfile/jqueryui/1.8/jquery.ui.core.js" />"></script> --%>
<%-- 	<script type="text/javascript" src="<c:url value="/resource/jfile/jqueryui/1.8/jquery.ui.widget.js" />"></script> --%>
<%-- 	<script type="text/javascript" src="<c:url value="/resource/jfile/jqueryui/1.8/jquery.ui.tabs.js" />"></script> --%>
<%-- 	<script type="text/javascript" src="<c:url value="/resource/jfile/json2.js" />"></script> --%>

<script type="text/javascript">
$(document).ready(function() {
	//문서로딩 후, MultiSelector 생성
	makeFileAttachment();
});

function makeFileAttachment(){
	//파일업로드 제한 수
	var maxFileNum = 3;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
}

$(function() {
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

});


</script>
<title>파일업로드 샘플</title>
</head>
<body>
	<form id="ajaxForm" action="<c:url value='/com/z02/insertDmFileMstr.do'/>" method="post" enctype="multipart/form-data">
		<p>
			Type: <input type="text" name="type" value="genericFileMulti" size="60" />
		</p>
		<p>
			<input name="file_1" id="egovComFileUploader" type="file" size="60" title="첨부파일입력"/>
		</p>
		<p>
			<div id="egovComFileList"></div>
		</p>
		<p>
			<input type="submit" value="업로드" />
		</p>
	</form>
	
</body>
</html>