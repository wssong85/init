<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var grPopupEdcCrWhoart = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grPopupEdcCrWhoart'
 	},
 	proxy: {
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
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
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	columnLayout : [{
 		dataField : "VALIDATION",
 		headerText : '<spring:message code="comc02.gr.VALIDATION"/>',
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			if(value == '*') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "ARRN_CODE",
 		headerText : "ARRN_CODE",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			if(value == '*') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "KOREAN_NM",
 		headerText : "KOREAN_NM",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
			if(value == '*') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "ENG_NM",
 		headerText : "ENG_NM",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) {
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
	grPopupEdcCrWhoart.createGrid();
	
	$("#btnClose").click(function(){ 				
		layerClose();
	});
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});
	
	$("#btnSave").click(function() {
		if(!$.trim($('#txtDicaryVer').val())) {
			alert('<spring:message code="comc02.msg.1"/>');
			return;
		}
		
		if(grPopupEdcCrWhoart.failCount) {
			alert('<spring:message code="comc02.msg.2"/>');
			return;
		}
		
		var arrData = AUIGrid.getGridData(grPopupEdcCrWhoart.id);

		arrData.push({
			'CURD' : 'M',
			'DICARY_VER': $('#txtDicaryVer').val()
		});
		
		$.ajax({
			url : "<c:url value='/com/c01/insertEdcCrWhoartByExcelList.do'/>",
			type: 'post',
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(arrData),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					alert('<spring:message code="comc02.msg.5"/>');
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
					grPopupEdcCrWhoart.failCount = data.count;
				} else {
					$('#h6Validation').text('VALIDATION : SUCCESS');
					grPopupEdcCrWhoart.failCount = data.count;
				}
				AUIGrid.setGridData(grPopupEdcCrWhoart.id, data.result);
			} else {
				alert(data.message);
			}
		},
		error: function(){
			alert("file upload error!!");
		}
	});

});

$(window).resize(function() {
	if(grPopupEdcCrWhoart && grPopupEdcCrWhoart.id) {
		AUIGrid.resize(grPopupEdcCrWhoart.id);
	}
});
</script>

<section class="popupWrap">
	<div class="popup wd760">
		<section class="conBox100 popup_conBox" style="margin:0px;height:500px; overflow-y:auto;">
		<div class="popup_conBoxInner">
			<h5><spring:message code="comc02.title.3" /></h5>
			<article class="mgT5">
				<table class="tb001">
					<colgroup>
						<col width="20%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="comc02.table.th.1" /></th>
							<td><input type="text" id="txtDicaryVer" name="DICARY_VER" style="width:100%;"></td>
						</tr>
						<tr>
							<th><spring:message code="comc02.table.th.2" /></th>
							<td>
							<form id="frUpload" action="<c:url value='/com/c02/selectWhoartListByExcel.do'/>" method="post" enctype="multipart/form-data">
				 				<div class="fileInputArea" style="width:86%;">
					 				<input type="text" id="fileName" readonly="readonly" style="width:81%;">
					 				<input type="button" value="<spring:message code="comc02.form.file" />" class="fileInputBtn" />
					 				<input type="file" name="file_1" class="fileIuputHid" style="width:100%;">
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
 				<div id="grPopupEdcCrWhoart" class="gridHeiSz08 grid_wrap tb01_2"></div>
			</article>
		</div>
		</section>
		
		<article class="mgT10">
			<div style="text-align:center;padding:10px;">
				<input type="button" id="btnSave" value=<spring:message code="btn.save"/>>
				<input type="button" id="btnClose" value=<spring:message code="btn.close" />>
			</div>
		</article>
	</div>
</section>


