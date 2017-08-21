<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title><spring:message code="comg01.title.1" /></title>
<script type="text/javascript">
//에디터
// var _editor_area = "txtNoticeCn";
// var _editor_url = "<c:url value='/html/egovframework/com/cmm/utl/htmlarea3.0/'/>";

function fn_downFile(fileMastrSn, fileSn) {
	window.open("<c:url value='/com/anonymous/selectDmFileDetailByPk.do?FILE_MASTR_SN=" + fileMastrSn + "&DETAIL_SN=" + fileSn + "'/>");
}

function fn_deleteFile(v) {
	
	$('#download_'+v).remove();
	
	var hdDeleteDetailSn = $('#hdDeleteDetailSn').val();
	
	hdDeleteDetailSn += v + ',';
	
	$('#hdDeleteDetailSn').val(hdDeleteDetailSn);
	
}

function makeFileAttachment(){
	<c:forEach items="${ LIST_FILE_DETAIL }" var="list_file_detail">
	var tt = '${list_file_detail.DETAIL_SN}';
		var tag = "<div id='download_${list_file_detail.DETAIL_SN}'>"+
		"<a href='javascript:fn_downFile(${list_file_detail.FILE_MASTR_SN}, ${list_file_detail.DETAIL_SN})'>"+
		"<span style='color:blue;'>${list_file_detail.FILE_NAME}</span>"+
		"</a>"+
		"</div>";
		$('#downloadFileList').append(tag);
	</c:forEach>
}

$(function(){
	makeFileAttachment();
	
	$('#btnCmNoticeList').click(function() {
		location.href = "<c:url value='/com/anonymous/COMZ0401.do'/>"; 
	});
});
</script>
<%-- <script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script> --%>
</head>
<body>

	<section class="conBox100 conBox" style="height:auto;">
		<div class="conBoxInner">
			

			<article class="conTitBox">
            	<h4><spring:message code="comg01.title.2" /></h4>
			</article>
			

			<article class="conTitBtn">
				<form:form commandName="frCmNotice" name="frCmNotice" method="post" enctype="multipart/form-data" >
				<input type="hidden" name="NOTICE_SN" value="<c:out value='${CM_NOTICE.NOTICE_SN}'/>" />
				<input type="hidden" name="FILE_MASTR_SN" value="<c:out value='${CM_NOTICE.FILE_MASTR_SN}'/>" />
				<table class="tb001">
					<colgroup>
						<col width="10%" />
						<col width="25%" />
						<col width="10%" />
						<col width="" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th><spring:message code="comg01.table.th.10" /></th>
						<td colspan="5"><c:out value='${CM_NOTICE.NOTICE_SJ}'/></td>
					</tr>
					<tr>
						<th><spring:message code="comg01.table.th.11" /></th>
						<td>
							<c:out value='${CM_NOTICE.NOTICE_BGNDE }'/>
							<span> ~ </span>
							<c:out value='${CM_NOTICE.NOTICE_ENDDE }'/>
						</td>
						<th><spring:message code="comg01.table.th.3" /></th>
						<td><c:out value='${CM_NOTICE.UPDATE_NM}'/></td>
						<th><spring:message code="comg01.table.th.5" /></th>
						<td><c:out value='${CM_NOTICE.LAST_UPDDE}'/></td>
					</tr>
					<tr>
						<th><spring:message code="comg01.table.th.2" /></th>
						<td colspan="5" style="height:240px; vertical-align: top;">
							${CM_NOTICE.NOTICE_CN}
						</td>
					</tr>
					<tr>
						<th><spring:message code="comg01.table.th.13" /></th>
						<td colspan="5" style=" padding: 10px ;">
							<p><div id="downloadFileList"/></p>
						</td>
					</tr>
				</table>
				</form:form>
			</article>

			<div style="text-align: center; margin-top: 20px;">
				<input type="button" id="btnCmNoticeList" value=<spring:message code="comg01.table.th.14" />>
			</div>

		</div>
	</section>

</body>
</html>