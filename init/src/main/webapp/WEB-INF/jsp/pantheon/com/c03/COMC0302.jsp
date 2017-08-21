<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%-- <jsp:include page="/com/popup/popupCommon.do" flush="false"/> --%>

<script>

var grEdcCrKcd2 = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grEdcCrKcd2'
 	},
 	proxy: {
 		url: './selectCmMenuListForUpperMenuId.do',
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		//페이징 true, false 로 지정
 		paging: false,
 		//처음 시작시 데이터 로딩
 		autoLoad: false
 	},
 	gridPros: {
 		showStateColumn: true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    enableFilter : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "VALIDATION",
 		headerText : '<spring:message code="comc03.gr.VALIDATION"/>',
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == '*') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DISS_CODE",
 		headerText : '<spring:message code="comc03.gr.DISS_CODE"/>',
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == '*') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "KOREAN_NM",
 		headerText : '<spring:message code="comc03.gr.KOREAN_NM"/>',
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == '*') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "ENG_NM",
 		headerText : '<spring:message code="comc03.gr.ENG_NM"/>',
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == '*') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
		window.setTimeout(function(){
			AUIGrid.resize(me.id);
		}, 0.5);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 	},
 	load: function() {
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

$(function() {
	$("#btnClose").click(function(){ 				
		layerClose();
	});
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});
	
	$("#btnSave").click(function() {
		if(!$.trim($('#txtDicaryVer').val())) {
			alert('<spring:message code="comc03.msg.1"/>');
			return;
		}
		
		if(grEdcCrKcd2.failCount) {
			alert('<spring:message code="comc03.msg.2"/>');
			return;
		}
		
		var arrData = AUIGrid.getGridData(grEdcCrKcd2.id);

		arrData.push({
			'CURD' : 'M',
			'DICARY_VER': $('#txtDicaryVer').val()
		});
		
		$.ajax({
			url : "<c:url value='/com/c03/insertEdcCrKcdByExcelList.do'/>",
			type: 'post',
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(arrData),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					alert('<spring:message code="comc03.msg.3"/>');
					${callbackFunction}();
					$("#btnClose").trigger('click');
				} else {
					alert(data.message);
				}
	
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});

	$('#frUpload').ajaxForm({
		beforeSubmit: function (data,form,option) {
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
				if(data.count) {
					$('#h6Validation').text('VALIDATION : FAIL (' + data.count + ')');
					grEdcCrKcd2.failCount = data.count;
				} else {
					$('#h6Validation').text('VALIDATION : SUCCESS');
					grEdcCrKcd2.failCount = 0;
				}
				AUIGrid.setGridData(grEdcCrKcd2.id, data.result);
			} else {
				alert(data.message);
			}
			
		},
		error: function(){
			alert("file upload error!!");
		}

	});
	
	grEdcCrKcd2.createGrid();
});

window.onresize = function() {
	if (grEdcCrKcd2.id) {
		AUIGrid.resize(grEdcCrKcd2.id);
	}
}
</script>

<section class="popupWrap">
	<div class="popup wd760">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5><spring:message code="comc03.title.1" /></h5>
			<article class="mgT5">
				<table class="tb001">
					<colgroup>
						<col width="20%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="comc02.table.th.1" /></th>
							<td>
								<input type="text" id="txtDicaryVer" style="width:100%;">
							</td>
						</tr>
						<tr>
							<th><spring:message code="comc02.table.th.2" /></th>
							<td>
							<form id="frUpload" action="<c:url value='/com/c03/selectExcellForKcd.do'/>" method="post" enctype="multipart/form-data">
				 				<div class="fileInputArea" style="width:86%;">
					 				<input type="text" id="fileName" readonly="readonly" style="width:81%;">
					 				<input type="button" value="<spring:message code="comc02.form.file" />" class="fileInputBtn" />
					 				<input type="file" name="file_1" name="file_1"class="fileIuputHid" style="width:100%;">
				 				</div>
								<input type="submit" id="submitUpload" value=<spring:message code="btn.upload" />>
							</form>								
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			
			<h6 id="h6Validation" class="mgT10"></h6>
			<article class="mgT5">
 				<div id="grEdcCrKcd2" class="gridHeiSz08 grid_wrap tb01_2"></div>
			</article>
			
			<article class="mgT10">
				<div style="text-align:center">
				<input type="button" id="btnSave" value=<spring:message code="btn.save"/>>
				<input type="button" id="btnClose" value=<spring:message code="btn.close" />>
				</div>
			</article>
		</div>
		</section>
	</div>
</section>