<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript" src="<c:url value='/resource/editor/js/HuskyEZCreator.js' />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>

<title>${progrmMap.MENU_NM}</title>
<script type="text/javascript">
var multi_selector = null;

function fn_deleteFile(v) {
	
	$('#download_'+v).remove();
	
	var hdDeleteDetailSn = $('#hdDeleteDetailSn').val();
	
	hdDeleteDetailSn += v + ',';
	
	$('#hdDeleteDetailSn').val(hdDeleteDetailSn);
	
	multi_selector.checkListCount(-1);
	
}

function fn_downFile(fileMastrSn, fileSn) {
	window.open("<c:url value='/com/z02/selectDmFileDetailByPk.do?FILE_MASTR_SN=" + fileMastrSn + "&DETAIL_SN=" + fileSn + "'/>");
}

function makeFileAttachment(){
	//파일업로드 제한 수
	var maxFileNum = 5;
	multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	
	<c:if test="${CM_NOTICE != null}">
	$.ajax({
	    url: "<c:url value='/com/z02/selectDmFileDetailListByPk.do'/>",
	    type: 'post',
	    dataType: 'json',
	    data: {'FILE_MASTR_SN' : '${CM_NOTICE.FILE_MASTR_SN}'},
	    success:function(data){
	    	if(data.success) {
	    		for(var i = 0; i < data.result.length; i++) {
	    			if(data.result[i].DETAIL_SN) {
	    				
						var tag = '<div id="download_'+ data.result[i].DETAIL_SN +'">'+
						'<a href="javascript:fn_downFile('+data.result[i].FILE_MASTR_SN+', '+data.result[i].DETAIL_SN+')">'+
						'<span style="color:blue;">'+data.result[i].FILE_NAME+' </span> '+
						'</a>'+
						' <input type="button" value="Delete" style="margin:2px;" onclick="javascript:fn_deleteFile('+data.result[i].DETAIL_SN+')">'+
						'</div>';
						
						$('#downloadFileList').append(tag);
						multi_selector.checkListCount(1);	
	    			}
	    		}
	    	}
	    },
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
	</c:if>
}

var oEditors = [];
$(function(){
	
	
	makeFileAttachment();
	mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -60, 0);
	
	<c:if test="${CM_NOTICE != null}">
		
		$('#txtStartDate').val('${CM_NOTICE.NOTICE_BGNDE}');
		$('#txtEndDate').val('${CM_NOTICE.NOTICE_ENDDE}');
		
		<c:if test="${CM_NOTICE.FIXING_AT == 'Y'}">
			$('#chkFixingAt').prop('checked', true);
		</c:if>
		
	</c:if>
	
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "txtNoticeCn",
		//SmartEditor2Skin.html 파일이 존재하는 경로
		sSkinURI: "/resource/editor/SmartEditor2Skin.html",	
		htParams : {
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,				
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			
			fOnBeforeUnload : function(){
				
			}
		}, 
		fOnAppLoad : function(){
			//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
			<c:if test="${CM_NOTICE != null}">
// 			oEditors.getById["txtNoticeCn"].exec("PASTE_HTML", ['${CM_NOTICE.NOTICE_CN}']);
			</c:if>
		},
		fCreator: "createSEditor2"
	});
	
	$('#btnCmNoticeList').click(function() {
		location.href = "<c:url value='/com/g01/COMG0101.do'/>"; 
	});
	
	$('#btnCmNoticeDelete').click(function() {
		if (confirm('<spring:message code="message.delete.1"/>')) {
			document.frCmNotice.action = "<c:url value='/com/g01/updateCmNoticeForDelete.do'/>";
			document.frCmNotice.submit();
		}
	});
	
	$('#btnCmNoticeSave').click(function() {
		if(!$.trim($('#txtNoticeSj').val())) {
			alert('<spring:message code="comg01.message.1"/>');
			return;
		}
		
		if (confirm('<spring:message code="message.save.1"/>')) {
			oEditors.getById["txtNoticeCn"].exec("UPDATE_CONTENTS_FIELD", []);
			document.frCmNotice.action = "<c:url value='/com/g01/insertCmNotice.do'/>";
			document.frCmNotice.submit();
		}
	});
});
</script>
<%-- <script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/htmlarea3.0/htmlarea.js'/>"></script> --%>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMG0102&&UPPER_MENU_ID=COMG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMG0102&&UPPER_MENU_ID=COMG" charEncoding="utf-8"/>
<section id="mainCon">
	<section class="mainConInner">
		<article class="mainTitBox">
			<h3>${progrmMap.MENU_NM}</h3>
			<nav id="pathNav">
				<ul>
					<li><img src="<c:url value='/images/pantheon/common/pathNavIco.png'/>" alt="">Home</li>
					<li>${progrmMap.UPPER_MENU_NM}</li>
					<li>${progrmMap.MENU_NM}</li>
				</ul>
			</nav>
		</article>

		
		<section class="conBox100 conBox">
			<div class="conBoxInner">
	
	
			
				<article class="conTitBtn">
					<form:form commandName="frCmNotice" name="frCmNotice" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="NOTICE_SN" value="<c:out value='${CM_NOTICE.NOTICE_SN}'/>" />
					<input type="hidden" id="hdDeleteDetailSn" name="DELETE_DETAIL_SN" value="" />
					<input type="hidden" name="FILE_MASTR_SN" value="<c:out value='${CM_NOTICE.FILE_MASTR_SN}'/>" />
					<input type="hidden" id="txtLastUpdde" name="LAST_UPDDE" style="width:100px;" readOnly="true" value="<c:out value='${CM_NOTICE.LAST_UPDDE}'/>">
					
					<c:if test="${CM_NOTICE == null}">
					<input type="hidden" id="txtUpdateNm" name="UPDATE_NM" style="width:200px;" value="<c:out value='${loginMap.USER_ID}'/>">
					</c:if>
					
					<c:if test="${CM_NOTICE != null}">
					<input type="hidden" id="txtUpdateNm" name="UPDATE_NM" style="width:200px;" value="<c:out value='${CM_NOTICE.UPDATE_NM}'/>">
					</c:if>
					
					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tr>
							<th><spring:message code="comg01.table.th.9" /></th>
							<td>
								<input type="checkbox" id="chkFixingAt" name="FIXING_AT" value="Y"><label for="chkFixingAt" class="chcLab"><span><spring:message code="comg01.table.th.9" /></span></label>
							</td>
						</tr>
						<tr>
							<th><spring:message code="comg01.table.th.10" /></th>
							<td>
								<input type="text" id="txtNoticeSj" name="NOTICE_SJ" value="<c:out value='${CM_NOTICE.NOTICE_SJ}'/>" style="width:100%;">
							</td>
						</tr>
						<tr>
							<th><spring:message code="comg01.table.th.11" /></th>
							<td>
								<div class="dateBox" ><input id="txtStartDate" name="NOTICE_BGNDE" type="text" style="width:120px;" /></div>
								<span> ~ </span>
								<div class="dateBox" ><input id="txtEndDate" name="NOTICE_ENDDE" type="text" style="width:120px;" /></div>
							</td>
	
						</tr>
						
						<tr>
							<th><spring:message code="comg01.table.th.12" /></th>
							<td style=" padding: 10px ;">
								<textarea name="NOTICE_CN" id="txtNoticeCn" rows="10" cols="30" style="width:100%; height:400px;display:none;">${CM_NOTICE.NOTICE_CN}</textarea>
							</td>
						</tr>
						<tr>
							<th><spring:message code="comg01.table.th.13" /></th>
							<td style=" padding: 10px ;">
								<p><div id="downloadFileList"/></p>
								<p><input name="file_1" id="egovComFileUploader" type="file" size="60" title=<spring:message code="comg01.input.title.1" />></p>
								<p><div id="egovComFileList"/></p>
							</td>
						</tr>
	
					</table>
					</form:form>
				</article>
				
				<div style="text-align: center; margin-top: 20px;">
					<input type="button" id="btnCmNoticeList" value=<spring:message code="comg01.table.th.14" />>
				</div>
	
	
				<div style=" position:absolute; right:25px; bottom:25px;">
					<input type="button" id="btnCmNoticeSave" value=<spring:message code="btn.save"/>>
					<input type="button" id="btnCmNoticeDelete" value=<spring:message code="btn.delete"/>>
				</div>
	
	
			</div>
		</section>


	</section>
</section>
</div>
</body>
</html>