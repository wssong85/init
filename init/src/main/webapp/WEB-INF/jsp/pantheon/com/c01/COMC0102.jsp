<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var grPopupCdiscDomn = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grPopupCdiscDomn'
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
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DOMN_NM",
 		headerText : "Dataset",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DOMN_DC",
 		headerText : "Description",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DOMN_CLASS",
 		headerText : "Class",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DOMN_STRCT",
 		headerText : "Structure",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DOMN_PURPS",
 		headerText : "Purpose",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DOMN_KEYS",
 		headerText : "Keys",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "DOMN_LOCATION",
 		headerText : "Location",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
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

var grPopupCdiscDomnVriabl = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grPopupCdiscDomnVriabl'
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
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CDISC_UPPER_CODE",
 		headerText : "Codelist Code",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CDISC_DOMN.DOMN_NM",
 		headerText : "Domain Name",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "LBL_ORDR",
 		headerText : "OrderNum",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "VRIABL_NM",
 		headerText : "Variable Name",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "VRIABL_LBL",
 		headerText : "Variable Label",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "VRIABL_TY_CODE",
 		headerText : "Type",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CTRL_FOM",
 		headerText : "Controlled Terms",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CRF_LBL_ONE",
 		headerText : "CRF LABEL1",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CRF_LBL_TWO",
 		headerText : "CRF LABEL2",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "VRIABL_ROLE",
 		headerText : "Role",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "VRIABL_DC",
 		headerText : "CDISC Notes",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CORE_CODE",
 		headerText : "Core",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
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

var grPopupCdiscClCode = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grPopupCdiscClCode'
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
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "VALIDATION",
 		headerText : '<spring:message code="comc02.gr.VALIDATION"/>',
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CDISC_CODE",
 		headerText : "Code",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CDISC_UPPER_CODE",
 		headerText : "Codelist Code",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "ESTN_POSBL_AT",
 		headerText : "Codelist Extensible (Yes/No)",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CODE_NM",
 		headerText : "Codelist Name",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CDISC_SUBMIT_VALUE",
 		headerText : "CDISC Submission Value",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CDISC_SYNONM",
 		headerText : "CDISC Synonym(s)",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "CDISC_DFN",
 		headerText : "CDISC Definition",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
				return "<span style='color:red;'>fail</span>";
			} else {
				return value;
			}
		}
 	},{
 		dataField : "NCI_NM",
 		headerText : "NCI Preferred Term",
		renderer : {
			type : "TemplateRenderer"
		},
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(value == 'fail') {
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

/*
var grPopupCdiscClCode = {
 	id: '',
 	failCount: 0,
 	div: {
 		gridDiv: '#grPopupCdiscClCode'
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
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "VALIDATION",
 		headerText : "유효성"
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
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
*/


$(function() {
	
	var vCdiscData = null;
	
	$("#btnClose").click(function(){ 				
		layerClose();
	});
	
	$('#btnSave').click(function(){
		if($('#divDomain').text() != 'domain VALIDATION(SUCCESS)') {
			alert('<spring:message code="comc0102.msg.1"/>');
			return;
		}
		
		if($('#divVariable').text() != 'variable VALIDATION(SUCCESS)') {
			alert('<spring:message code="comc0102.msg.2"/>');
			return;
		}
		
		if($('#divTerminology').text() != 'terminology VALIDATION(SUCCESS)') {
			alert('<spring:message code="comc0102.msg.3"/>');
			return;
		}
		
		if(!vCdiscData) {
			return;
		}
		
		if(fn_getByte($('#txtCdiscVer').val()) > 6) {
			alert('<spring:message code="comc0102.msg.4"/>');  
			return;
		}
		
		if(!$.trim($('#txtCdiscVer').val())) {
			alert('<spring:message code="comc0102.msg.5"/>');  
			return;
		}
		
		if(fn_getByte($('#txtRuleNm').val()) > 200) {
			alert('<spring:message code="comc0102.msg.6"/>');  
			return;
		}
		
		if(!$.trim($('#txtRuleNm').val())) {
			alert('<spring:message code="comc0102.msg.7"/>');  
			return;
		}
		
		if(fn_getByte($('#txtRuleDc').val()) > 4000) {
			alert('<spring:message code="comc0102.msg.8"/>');  
			return;
		}
		
		if(!$.trim($('#txtRuleDc').val())) {
			alert('설명을 입력해 주십시오.');  
			return;
		}
		var arrParam = vCdiscData;
		
		arrParam.push({
			'CDISC_VER': $('#txtCdiscVer').val()
			,'RULE_NM': $('#txtRuleNm').val()
			,'RULE_DC': $('#txtRuleDc').val()
			,'CDISC_SE_CODE': $('#selectCdiscSeCode').val()
			,'GUBUN': 'rule'
		});
		
		$.ajax({
			url : "<c:url value='/com/c01/insertCdiscByExcelList.do'/>",
			type: 'post',
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(vCdiscData),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					vCdiscData.pop();
					alert('<spring:message code="comc0102.msg.9"/>');
					${callbackFunction}();
					$("#btnClose").trigger('click');
				} else {
					vCdiscData.pop();
					alert(data.message);
				}
	
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				vCdiscData.pop();
				alert(textStatus);
			}
		});

	});
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
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
				AUIGrid.setGridData(grPopupCdiscDomn.id, data.listDomain);
				AUIGrid.setGridData(grPopupCdiscDomnVriabl.id, data.listVariable);
				AUIGrid.setGridData(grPopupCdiscClCode.id, data.listTerminology);
				
				if(data.listDomain && data.listDomain.length) {
					$('#divDomain').text('domain VALIDATION(SUCCESS)');
				} else {
					$('#divDomain').text('domain VALIDATION(FAIL)');
				}
				
				if(data.listVariable && data.listVariable.length) {
					$('#divVariable').text('variable VALIDATION(SUCCESS)');
				} else {
					$('#divVariable').text('variable VALIDATION(FAIL)');
				}
				
				if(data.listTerminology && data.listTerminology.length) {
					$('#divTerminology').text('terminology VALIDATION(SUCCESS)');	
				} else {
					$('#divTerminology').text('terminology VALIDATION(FAIL)');
				}
				
				if(data.failCountDomain) {
					$('#divDomain').text('domain VALIDATION(FAIL:' + data.failCountDomain +')');
				}
				
				if(data.failCountVariable) {
					$('#divVariable').text('variable VALIDATION(FAIL:' + data.failCountVariable +')');
				}
				
				if(data.failCountTerminology) {
					$('#divTerminology').text('terminology VALIDATION(FAIL:' + data.failCountTerminology +')');
				}
				
				vCdiscData = data.listAllData;
			} else {
				alert(data.message);
			}
			
		},
		error: function(a,b){
			alert("file upload error!!");
		}
	});
	
	grPopupCdiscDomn.createGrid();
	grPopupCdiscDomnVriabl.createGrid();
	grPopupCdiscClCode.createGrid();
});

window.onresize = function() {
	if(grPopupCdiscDomn && grPopupCdiscDomn.id) {
		AUIGrid.resize(grPopupCdiscDomn.id);
	}
	if(grPopupCdiscDomnVriabl && grPopupCdiscDomnVriabl.id) {
		AUIGrid.resize(grPopupCdiscDomnVriabl.id);
	}
	if(grPopupCdiscClCode && grPopupCdiscClCode.id) {
		AUIGrid.resize(grPopupCdiscClCode.id);
	}
}

</script>

<section class="popupWrap">
	<div class="popup wd760">
		<section class="conBox100 popup_conBox" style="margin:0px;height:500px; overflow-y:auto;">
		<div class="popup_conBoxInner">
			<h5><spring:message code="comc0102.title.1" /></h5>
			<article class="mgT5">
				<table class="tb001">
					<colgroup>
						<col width="10%" />
						<col width="" />
						<col width="10%" />
						<col width="" />
						<col width="10%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="comc0102.table.th.1" /></th>
							<td><input type="text" id="txtCdiscVer" name="CDISC_VER" style="width:100%;"></td>
							<th><spring:message code="comc0102.table.th.2" /></th>
							<td><input type="text" id="txtRuleNm" name="RULE_NM" style="width:100%;"></td>
							<th><spring:message code="comc0102.table.th.3" /></th>
							<td>
								<select id="selectCdiscSeCode" name="CDISC_SE_CODE" style="width:100px">
									<option option="SDTM">SDTM</option>
									<option option="ODM">ODM</option>
								</select>
							</td>
						</tr>
						<tr>
							<th><spring:message code="comc0102.table.th.4" /></th>
							<td colspan="5" style="padding:7px 4px 0px 12px;">
								<textarea id="txtRuleDc" name="RULE_DC" rows="1" style="width:100%;"></textarea>
							</td>
						</tr>
						<tr>
							<th><spring:message code="comc0102.table.th.5" /></th>
							<td colspan="5">
							<form id="frUpload" action="<c:url value='/com/c01/selectExcellForCdisc.do'/>" method="post" enctype="multipart/form-data">
				 				<div class="fileInputArea" style="width:88%;">
									<input type="text" id="fileName" readonly="readonly" style="width:83%;">
					 				<input type="button" value="<spring:message code="comc02.form.file" />" class="fileInputBtn" />
					 				<input type="file" name="file_1"class="fileIuputHid" style="width:100%;">
				 				</div>
								<input type="submit" id="submitUpload" value=<spring:message code="btn.upload" />>
							</form>
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			
			<article class="mgT5">
				<div id="divDomain">domain</div>
 				<div id="grPopupCdiscDomn" class="gridHeiSz05 grid_wrap tb01_2"></div>
			</article>
			
			<article class="mgT32">
				<div id="divVariable">variable</div>
 				<div id="grPopupCdiscDomnVriabl" class="gridHeiSz05 grid_wrap tb01_2"></div>
			</article>
			
			<article class="mgT32">
				<div id="divTerminology">terminology</div>
 				<div id="grPopupCdiscClCode" class="gridHeiSz05 grid_wrap tb01_2"></div>
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