<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript" src="<c:url value='/resource/editor/js/HuskyEZCreator.js' />" charset="utf-8"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/pantheon/common/ctms/ctms.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/pantheon/common/jquery.form.min.js' />"></script>
<script type="text/javascript" src="<c:url value="/resource/jfile/json.js" />"></script>
<script type="text/javascript" src="<c:url value="/resource/jfile/jwork/jwork.fileUpload.js" />"></script>
<script type="text/javascript" src="<c:url value="/resource/jfile/jwork/jwork.fileDownload.js" />"></script>
<script type="text/javascript" src="<c:url value="/resource/jfile/swfupload/swfupload/swfupload.js" />"></script>
<script type="text/javascript" src="<c:url value="/resource/jfile/swfupload/js/swfupload.queue.js" />"></script>
<script type="text/javascript">
var oEditors = [];
var multi_selector = null;
var V_ATCH_FILE_SN;
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

    <c:if test="${NOTICE != null}">
    $.ajax({
        url: "<c:url value='/com/z02/selectDmFileDetailListByPk.do'/>",
        type: 'post',
        dataType: 'json',
        data: {'FILE_MASTR_SN' : '${NOTICE.FILE_MASTR_SN}'},
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

function fn_insert(){

	var arJson = [];
	var requestInfo = {	   "SN" : P_NOTICE_SN
				         , "TASK_SN" : P_TASK_SN
				         , "MODULE_SE" : $("#selectModule").val()
				         , "NOTICE_SE": $("input[name=noticeDivision]:checked").val()
				         , "SJ" : $("#txtNoticeSj").val()
				         , "CRUD" : P_CRUD
				         , "CN" : oEditors.getById['txtNoticeCn'].getContents()
				         , "ATCH_FILE_SN" : V_ATCH_FILE_SN
			         };

	arJson.push(requestInfo);

	$.ajax({
		  url : '/ctms/a01/insertNotice.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {	
			  if(data.success) {						
				  layerClose();
				  fn_callBack();
			  } else {					  
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});

}

function fn_selectNoticeInfo(){
	
	var paramData = {
			NOTICE_SN : P_NOTICE_SN
		};

	$.ajax({
		url : '/ctms/a01/selectNoticeInfo.do',
		type : 'post',
// 		dataType : 'json',
		data : paramData,
		success : function(data) {
			if (data.success) {
				var notice = data.result;
				$("input:radio[name='noticeDivision']:radio[value='"+notice.NOTICE_SE+"']").attr("checked",true);
				$("#selectModule").val(notice.MODULE_SE); //모듈 구분
				$("#txtInputUserNm").val(notice.FRST_CRTR); //작성자	
				$("#txtNoticeSj").val(notice.SJ); //제목
				$("#txtNoticeCn").val(notice.CN); //내용

			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
}

$(function(){

    //makeFileAttachment();

    $('#txtInputDate').val(fn_getToday());

    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "txtNoticeCn",
        //SmartEditor2Skin.html 파일이 존재하는 경로
        sSkinURI: "/resource/editor/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : false,
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
            fOnBeforeUnload : function(){

            }
        },
        fOnAppLoad : function(){
            //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
            <c:if test="${NOTICE != null}">
//          oEditors.getById["txtNoticeCn"].exec("PASTE_HTML", []);
            </c:if>
        },
        fCreator: "createSEditor2"
    });

    $(function() {
    	
    	if(P_CRUD == "C"){
    		$("#txtInputUserNm").val("${USER_ID}");
    	}
    	else{
    		fn_selectNoticeInfo();
    	}

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
    				V_ATCH_FILE_SN = data.result;
    			} else {
    				alert(data.message);
    			}
    		},
    		error: function(){
    			alert("file upload error!!");
    		}
    	});

    });

	//닫기버튼
	$("#btnClose").click(function(){
		layerClose();
	});
	
	//저장버튼
	$("#btnSave").click(function(){
		if(!$.trim(!$("#txtNoticeSj").val())){
			alert("제목을 작성해 주세요");
			return;
		}
		
		if(!$.trim(!$("#txtNoticeCn").val())){
			alert("내용을 작성해 주세요");
			return;
		}
		
		if(confirm("저장 하시겠습니까?")){
			fn_insert();
		}
	});
	

	//과제조회버튼 클릭
 	$("#btnSearchTask").click(function(){ 		
		var param={};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
 	});

	//삭제버튼
	$("#btnDelete").click(function(){
		if(confirm("삭제 하시겠습니까?") == true){
			P_CRUD = "D";
			fn_insert();
		}
	});

});


</script>


<title>공지사항 상세 등록</title>
</head>
<body>
    <section class="popupWrap">
        <div class="popup wd900" >

            <section class="conBox100 popup_conBox" style='margin:0px;'>
                <div class="popup_conBoxInner">
                    <div class="conTitBtnR">
                        <input type="button" id="btnDelete" value="삭제">
                        <input type="button" id="btnSave" value="저장">
                        <input type="button" id="btnClose" value="목록">
                    </div>
                    <table class="tb02">
                        <tbody>
                           <tr>
                                <th><span class="must_01"></span>구분</th>
                                <td>
                                     <input type="radio" id="rdAll" name="noticeDivision" value="01" checked disabled><label for="rdAll" class="raLab" ><span>전체</span></label>
                                     <input type="radio" id="rdTask" name="noticeDivision" value="02" disabled><label for="rdTask" class="raLab" > <span>과제</span></label>
                                </td>
                           </tr>
                           <tr>
                                <th><span class="must_01"></span>모듈</th>
                                <td>
                                    <select id="selectModule" name="MODULE">
                                        <c:forEach items="${ moduleCode }" var="mCode">
                                            <option value='${mCode.CMMN_CODE}'>${mCode.CMMN_CODE_NM}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                           </tr>
                           <tr>
                                <th><span class="must_01"></span>과제</th>
                                <td>
                                    <input type="hidden" id="txtInputTaskSn" name="txtInputTaskSn" >
                                    <input type="text" id="txtInputTaskNo" name="txtInputTaskNo" disabled> <!-- input type="button" id="btnSearchTask" value="조회" -->
                                </td>
                           </tr>
                           <tr>
                                <th><span class="must_01"></span>작성자</th>
                                <td>
                                    <input type="text" id="txtInputUserNm" name="txtInputUserNm" maxlength="32" disabled>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="must_01"></span>작성일</th>
                                <td>
                                    <div class="dateBox" ><input id="txtInputDate" name="txtInputDate" type="text" disabled/></div>
                                </td>
                            </tr>
                            <tr>
                                <th><span class="must_01"></span>제목</th>
                                <td>
                                    <input type="text" id="txtNoticeSj" name="txtNoticeSj" style="width:100%;">
                                </td>
                            </tr>
                            <tr>
                                <th>내용</th>
                                <td>
                                    <textarea name="txtNoticeCn" id="txtNoticeCn" rows="10" cols="30" style="width:100%; height:300px"></textarea>
                                </td>
                            </tr>
                            <!-- tr>
                                <th>첨부파일</th>
                                <td style=" padding: 10px ;">
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
                                </td>
                            </tr-->
                        </tbody>



                    </table>

                </div>
            </section>
        </div>
    </section>

</body>
</html>