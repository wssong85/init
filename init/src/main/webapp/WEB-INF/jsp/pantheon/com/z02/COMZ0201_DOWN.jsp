<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/js/pantheon/com/aui/jquery-1.12.1.min.js' />"></script>
<script type="text/javascript">
function fn_downFile(fileMastrSn, fileSn){
	window.open("<c:url value='/com/z02/selectDmFileDetailByPk.do?FILE_MASTR_SN="+fileMastrSn+"&DETAIL_SN="+fileSn+"'/>");
}

$(document).ready(function() {
	$.ajax({
	    url: '/com/z02/selectDmFileDetailListByPk.do',
	    type: 'post',
	    dataType: 'json',
	    data: {'FILE_MASTR_SN' : '${MstrSn}'},
	    success:function(data){
	    	if(data.success) {
	    		for(var i = 0; i < data.result.length; i++) {
					var tag = '<br><a href="javascript:fn_downFile('+data.result[i].FILE_MASTR_SN+', '+data.result[i].DETAIL_SN+')">'+data.result[i].FILE_NAME+'</a>';
					$('#downloadtest').append(tag);
	    		}
	    	}
	    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
});
//	
</script>
<title>파일다운로드 샘플</title>
</head>
<body>
	<div id="downloadtest"/>
</body>
</html>