<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var _user = null;

var grCmSanctnProcess = {
 	id: '',
 	div: {
 		gridDiv: '#grCmSanctnProcess',
 		paging: {
 			pagingDiv: '',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: "<c:url value='/com/z09/selectCmSanctnProcessListByPk.do'/>",
 		param: {
 			'REQUST_NO': '${REQUST_NO}' 
 		},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: true
 	},
 	gridPros: {
	    enableFilter : false,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	columnLayout : [{
 		dataField : "SANCTN_CODE_NM",
 		headerText : '<spring:message code="comz0903.gr.SANCTN_CODE_NM"/>'
 	},{
 		dataField : "DEPT_NM",
 		headerText : '<spring:message code="comz0903.gr.DEPT_NM"/>'
 	},{
 		dataField : "SANCTNER_NM",
 		headerText : '<spring:message code="comz0903.gr.SANCTNER_NM"/>'
 	},{
 		dataField : "SANCTNER_ID",
 		headerText : '<spring:message code="comz0903.gr.SANCTNER_ID"/>'
 	},{
 		dataField : "STTUS_CODE_NM",
 		headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>'
 	},{
 		dataField : "SANCTN_CODE",
 		headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>',
 		visible : false
 	},{
 		dataField : "STTUS_CODE",
 		headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>',
		visible : false 		
 	},{
 		dataField : "SANCTN_DT",
 		headerText : '<spring:message code="comz0903.gr.SANCTN_DT"/>',
 		formatString : "yyyy-mm-dd HH:MM:ss",
 		dataType:"date",
 		width: 200
 	},{
 		dataField : "SANCTN_COMMENT",
 		headerText : '<spring:message code="comz0903.gr.SANCTN_COMMENT"/>'
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
		window.setTimeout(function(){
			AUIGrid.resize(me.id);
		}, 1.5);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;

		AUIGrid.bind(me.id, 'headerClick', function(event) {
			return false;
		});
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
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
					
 			    	if(data.result[0].REQUST_STTUS_CODE != '01') {
 			    		//3333버튼 disable
 			    		$('#btnElectronicAppr').attr('disabled', true);
 			    		alert('<spring:message code="comz09.message.19"/>');
 			    	}
 			    	
 			    	if(data.result[0].SANCTNER_ID == _user.USER_ID) {
 			    		$('#raCmSanctnProcessCancle').attr('disabled', false);
 			    	} else {
 			    		$('#raCmSanctnProcessCancle').attr('disabled', true);
 			    	}
 			    	
 			    	
//  					for(var i = 0; i < data.result.length; i++) {
//  						if(data.result[i]['SANCTNER_ID'] == _user.USER_ID && data.result[i]['SANCTN_CODE'] != '01') {
//  							alert('이미 승인 및 반려를 진행했습니다.');
//  							return;
//  						}
//  					}
 			    	
 			    	//data.result[0].REQUST_STTUS_CODE_NM
 		    	} else {
 		    		AUIGrid.removeAjaxLoader(me.id);
 		    		alert(data.message);
 		    		
	 		   		window.setTimeout(function(){
	 					AUIGrid.resize(me.id);
	 				}, 1.5);

 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
 	}
};


function processConfirm() {
	
	if($(":radio[name='raCmSanctnProcess']:checked").val() == '02') {
		if(!window.confirm('<spring:message code="comz09.message.20"/>')){
			return;
		}
	} else if($(":radio[name='raCmSanctnProcess']:checked").val() == '03') {
		if(!window.confirm('<spring:message code="comz09.message.21"/>')){
			return;
		}
	} else {
		return;
	}
	
	if(!mkValidation()){
		return;
	}
	
	if($.trim($('#txtUserId').val()) != _user.USER_ID) {
// 		alert('접속한 아이디로 입력해 주십시오.');
		alert('<spring:message code="comz09.message.22"/>');
		return;
	}
	
	if(!$.trim($('#txtCmsanctnProcessComent').val())) {
		alert('코멘트는 필수로 입력해 주십시오.');
		return;
	}
	
	var gridData = AUIGrid.getGridData(grCmSanctnProcess.id);
	var paramData = '';
	
	if($(":radio[name='raCmSanctnProcess']:checked").val() != '05') {
		var items01 = AUIGrid.getItemsByValue(grCmSanctnProcess.id, 'SANCTN_CODE', '01')
		
		for(var i = 0; i < items01.length; i++) {
			if(items01[i]['SANCTNER_ID'] == $('#txtUserId').val()) {
// 				alert('기안자는 승인 및 반려 할 수 없습니다.');
				alert('<spring:message code="comz09.message.23"/>');
				return;
			}
		}
	}
	
	var items06 = AUIGrid.getItemsByValue(grCmSanctnProcess.id, 'SANCTN_CODE', '06');
	
	for(var i = 0; i < items06.length; i++) {
		if(items06[i]['SANCTNER_ID'] == $('#txtUserId').val()) {
// 			alert('참조자는 승인 및 반려 할 수 없습니다.');
			alert('<spring:message code="comz09.message.24"/>');
			return;
		}
	}
	
	if($(":radio[name='raCmSanctnProcess']:checked").val() != '05') {
		for(var i = 0; i < gridData.length; i++) {
			if(gridData[i]['SANCTNER_ID'] == $('#txtUserId').val() && gridData[i]['STTUS_CODE'] != '01') {
				alert('<spring:message code="comz09.message.25"/>');
// 				alert('이미 승인 및 반려를 진행했습니다.');
				return;
			}
		}
	}
	
	var arrColumns = AUIGrid.getColumnValues(grCmSanctnProcess.id, 'SANCTN_CODE');

	if(fn_hasValueByArr(arrColumns, '01') == 0) {
// 		alert('요청이 완료된 문서입니다.');
		alert('<spring:message code="comz09.message.27"/>');
		return;
	}
	
	for(var i = 0; i < gridData.length; i++) {
		if(gridData[i]['STTUS_CODE'] == '01' && 
				(gridData[i]['SANCTN_CODE'] == '02' || gridData[i]['SANCTN_CODE'] == '05' || gridData[i]['SANCTN_CODE'] == '07')) {
			if($('#txtUserId').val() != gridData[i]['SANCTNER_ID']) {
// 				alert('결재순서가 아닙니다.');					
				alert('<spring:message code="comz09.message.26"/>');					
				return;			
			} else {
				paramData = gridData[i];
				break;
			}
		}
		
		if(gridData[i]['STTUS_CODE'] == '01' && gridData[i]['SANCTN_CODE'] == '04') {
			
			var arrTmp = AUIGrid.getItemsByValue(grCmSanctnProcess.id, 'SANCTN_CODE', '04');
							
			for(var j = 0; j < arrTmp.length; j++) {
				if($('#txtUserId').val() == arrTmp[j]['SANCTNER_ID']) {
					paramData = arrTmp[j];
					break;
				}
			}
			
			if(paramData) {
				break;
			} else {
// 				alert('결재순서가 아닙니다.');
				alert('<spring:message code="comz09.message.26"/>');
				return;
			}
		}
	}
	
	if(!paramData) {
// 		alert('요청이 완료된 문서입니다.');
		alert('<spring:message code="comz09.message.27"/>');
		return;
	}
	
	paramData.USER_ID = $("#txtUserId").val(); 
	paramData.PASSWORD = $("#txtPassword").val();
	paramData.STTUS_CODE = $(":radio[name='raCmSanctnProcess']:checked").val();
	paramData.SANCTN_COMMENT = $("#txtCmsanctnProcessComent").val();
	
// 	if($(":radio[name='raCmSanctnProcess']:checked").val() == '05' && !paramData.SANCTN_COMMENT) {
// 		alert('반려시 코멘트는 필수 입니다.');
// 		alert('<spring:message code="comz09.message.28"/>');
// 		return;
// 	}
	
	$.ajax({
		url : "<c:url value='/com/z09/updateCmSanctnProcessByPk.do'/>",
		type: 'post',
		dataType: 'json',
		data : paramData,
		success : function(data, textStatus, jqXHR) {
			if(data.success) {
				alert(data.message);
				//함수이름 f_requestRequstNo_2
				if(data.REQUST_NO) {
					${callbackFunction}(data.REQUST_NO);
				}
				
				if('${CALLBACK_TRUE}') {
					${callbackFunction}();
				}
				
				$('#btnCmSanctnProcessClose').trigger('click');
			} else {
				alert(data.message);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}

function processCancle() {
// 	if(!window.confirm("취소하시겠습니까?")){
	if(!window.confirm('<spring:message code="comz09.message.29"/>')){
		return;
	}
	
	if(!mkValidation()){
		return;
	}
	
	if($('#txtUserId').val() != _user.USER_ID) {
// 		alert('접속한 아이디로 입력해 주십시오.');
		alert('<spring:message code="comz09.message.22"/>');
		return;
	}
	
	if(!$.trim($('#txtCmsanctnProcessComent').val())) {
		alert('코멘트는 필수로 입력해 주십시오.');
		return;
	}
	
	var paramData = {
		'STTUS_CODE': $(":radio[name='raCmSanctnProcess']:checked").val(),
		'REQUST_NO': AUIGrid.getGridData(grCmSanctnProcess.id)[0]['REQUST_NO']
	};
	
	paramData.USER_ID = $("#txtUserId").val(); 
	paramData.PASSWORD = $("#txtPassword").val();
	paramData.SANCTN_COMMENT = $("#txtCmsanctnProcessComent").val();
	
	$.ajax({
		url : "<c:url value='/com/z09/updateCmSanctnProcessByPk.do'/>",
		type: 'post',
		dataType: 'json',
		data : paramData,
		success : function(data, textStatus, jqXHR) {
			if(data.success) {
				alert(data.message);
				$('#btnCmSanctnProcessClose').trigger('click');
			} else {
				alert(data.message);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}


$(function(){
	_user = {'USER_ID': '${loginMap.USER_ID}'};
	grCmSanctnProcess.createGrid();
	
	$('#btnCmSanctnProcessClose').click(function(){
		layerClose();
	});
	
	$('#btnElectronicAppr').click(function() {
		if($(":radio[name='raCmSanctnProcess']:checked").val() == '05') {
			processCancle();
		} else {
			processConfirm();
		}
	});
	
	if('${GUBUN}') {
		$('#divCmSanctn').hide();
	}
});

$(window).resize(function() {
	if (grCmSanctnProcess && grCmSanctnProcess.id) {
		AUIGrid.resize(grCmSanctnProcess.id);
	}
});

</script>
</head>
<body>
<section class="popupWrap">
<div class="popup wd800"> 

<!-- <div id="wrap"> -->
<%-- <c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMA0201&UPPER_MENU_ID=COMB" charEncoding="utf-8"/> --%>
<%-- <c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMA0201&UPPER_MENU_ID=COMB" charEncoding="utf-8"/> --%>
	<!-- 메인 시작 -->
<!-- 	<section id="mainCon"> -->
		<section class="conBox100 conBox" style="padding:0;">
			<div class="conBoxInner" style="padding-bottom: 0px;">
				<article class="mgT16">
					<div id="grCmSanctnProcess" class="gridHeiSz06 grid_wrap tb01_2"></div>
				</article>
			</div>
		</section>
		
		
		
		<section class="conBox100 conBox" style="padding:0;">
			<div id="divCmSanctn" class="conBoxInner">
				<article class="conTitBox">
					<h5><spring:message code="comz0903.title.2" /></h5>
				</article>
				
				<article class="mgT6">
				<table class="tb001">
					<tbody>
						<tr>
							<th><spring:message code="comz0903.table.th.1" /></th>
							<td><input type="text" id="txtUserId" valireqire="사용자아이디" /></td>
						</tr>
						<tr>
							<th><spring:message code="comz0903.table.th.2" /></th>
							<td><input type="password" id="txtPassword" valireqire="비밀번호" /></td>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<th><spring:message code="comz0903.table.th.3" /></th>
							<td>
							<input type="radio" id="raCmSanctnProcessCreate" name="raCmSanctnProcess" value="02" checked><label for="raCmSanctnProcessCreate" class="raLab"><span><spring:message code="comz0903.radio.1" /></span></label>
							<input type="radio" id="raCmSanctnProcessUpdate" name="raCmSanctnProcess" value="03"><label for="raCmSanctnProcessUpdate" class="raLab"><span><spring:message code="comz0903.radio.2" /></span></label>
							<input type="radio" id="raCmSanctnProcessCancle" name="raCmSanctnProcess" value="05"><label for="raCmSanctnProcessCancle" class="raLab"><span><spring:message code="comz0903.radio.3" /></span></label>
							</td>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<th><spring:message code="comz0903.table.th.4" /></th>
							<td style="padding-top: 7px; padding-bottom: 2px; ">
								<textarea id="txtCmsanctnProcessComent" style="width: 98.8%;" rows="3"></textarea>
							</td>						
						</tr>
					</tbody>
				</table>
				</article>
				
				<article class="mgT17">
					<div style="text-align:center">
						<input type="button" id="btnElectronicAppr" value=<spring:message code="btn.confirm" />>
						<input type="button" id="btnCmSanctnProcessClose" value=<spring:message code="btn.close" />>
					</div>
				</article>
			</div>
		</section>
	<!-- 메인 끝 -->
<!-- </div> -->
</div>
</section>
</body>
</html>