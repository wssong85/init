<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<style>
.order_style_01{ text-align:center; }
.order_style_01 .aui-grid-renderer-base{ text-indent:-2px;}

.use_style_01{ text-align:center; }
.use_style_01 .aui-grid-renderer-base{text-indent:-2px;}

.task_style_01{ text-align:center; }
.task_style_01 .aui-grid-renderer-base{text-indent:-2px;}


.essntl_style_01{ text-align:center; }
.essntl_style_01 .aui-grid-renderer-base{text-indent:-2px;}

</style>

<script type="text/javascript">
var grCmProgm = {
 	id: '',
 	div: {
 		gridDiv: '#grCmProgm'
 	},
 	proxy: {
 		url: "<c:url value='/com/a02/selectCmProgrm.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: true
 	},
 	gridPros: {
 		showStateColumn: true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    showRowNumColumn : true,
	    showRowCheckColumn : true,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37
	    //selectionMode : "multipleRows"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText : '<spring:message code="coma0201.gr.MODULE_CODE" /><span class="must_01"></span>',
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : null,
			keyField : "MODULE_CODE",
			valueField : "MODULE_CODE"
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPPER_MENU_ID",
 		headerText : '<spring:message code="coma0201.gr.UPPER_MENU_NM" /><span class="must_01"></span>',
 		width : 137,
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			var me = grCmProgm;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[1].editRenderer.list.length; i++) {
				if(me.columnLayout[1].editRenderer.list[i]['MENU_ID'] == value) {
					retStr = me.columnLayout[1].editRenderer.list[i]['MENU_NM'];
					break;
				}
			}
			
			if(!retStr) {
				return AUIGrid.getItemByRowIndex(me.id, rowIndex)['UPPER_MENU_NM'];
			} else {
				return retStr;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : '',
			keyField : "MENU_ID",
			valueField : "MENU_NM"
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPPER_MENU_NM",
 		headerText : '<spring:message code="coma0201.gr.UPPER_MENU_NM" /><span class="must_01"></span>',
 		visible : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ID",
 		headerText : '<spring:message code="coma0201.gr.MENU_NM" /><span class="must_01"></span>',
 		width : 157,
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
			var me = grCmProgm;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[3].editRenderer.list.length; i++) {
				if(me.columnLayout[3].editRenderer.list[i]['MENU_ID'] == value) {
					retStr = me.columnLayout[3].editRenderer.list[i]['MENU_NM'];
					break;
				}
			}
			
			if(!retStr) {
				return AUIGrid.getItemByRowIndex(me.id, rowIndex)['MENU_NM'];
			} else {
				return retStr;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : '',
			keyField : "MENU_ID",
			valueField : "MENU_NM"
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText : '<spring:message code="coma0201.gr.MENU_NM" /><span class="must_01"></span>',
 		visible : false
 	},{
 		dataField : "PROGRM_ID",
 		width : 110,
 		headerText : '<spring:message code="coma0201.gr.PROGRM_ID" /><span class="must_01"></span>',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_NM",
 		width : 167,
 		headerText : '<spring:message code="coma0201.gr.PROGRM_NM" /><span class="must_01"></span>',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_ENG_NM",
 		width : 170,
 		headerText : '<spring:message code="coma0201.gr.PROGRM_ENG_NM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_JAPAN_NM",
 		width : 180,
 		headerText : '<spring:message code="coma0201.gr.PROGRM_JAPAN_NM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_CHINA1_NM",
 		width : 180,
 		headerText : '<spring:message code="coma0201.gr.PROGRM_CHINA1_NM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_CHINA2_NM",
 		width : 190,
 		headerText : '<spring:message code="coma0201.gr.PROGRM_CHINA2_NM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_ORDR",
 		headerText : '<spring:message code="coma0201.gr.PROGRM_ORDR" />',
 		width: 106,
 		style:"order_style_01",
		editRenderer : {
			type : "NumberStepRenderer",
			min : 0,
			max : 20,
			step : 1
		},
 		filter : {
 			showIcon : true
 		},
 		visible:false
 	},{
 		dataField : "PROGRM_URL",
 		headerText : '<spring:message code="coma0201.gr.PROGRM_URL" />',
 		width: 180,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USE_YN",
 		headerText : '<spring:message code="coma0201.gr.USE_YN" />',
 		width: 96,
 		style:"use_style_01",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "TASK_AT",
 		headerText : '<spring:message code="coma0201.gr.TASK_AT" />',
 		width: 96,
 		style:"task_style_01",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "ESSNTL_AT",
 		headerText : '<spring:message code="coma0201.gr.ESSNTL_AT" />',
 		width: 96,
 		style:"essntl_style_01",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N', 'A']
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FIXING_AT",
 		headerText : '<spring:message code="coma0201.gr.FIXING_AT" />',
 		width: 96,
 		style:"essntl_style_01",
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPDATE_NM",
 		headerText : '<spring:message code="coma0201.gr.UPDATE_NM" />',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="coma0201.gr.LAST_UPDDE" />',
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		width : 96,
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
 		$.ajax({
 		    url: "<c:url value='/com/common/selectQueryDataList.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {'QUERY': 'selectCmMenuForModuleCodeByComboBox'},
 		    success:function(data){
 		    	if(data.success) {
 		    		
 			    	me.columnLayout[0].editRenderer.list = data.result;
 			    	
			 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			 		
			 		grCmRoleLmtt.createGrid();
			 		
			 		me.binding();
			 		
			 		if(me.proxy.autoLoad) {
			 			me.load();
			 		}
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
 			error : function(jqXHR, textStatus, errorThrown){
 				alert(textStatus);
 			}
 		});
 	},
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
 			
			if(AUIGrid.getSelectedIndex(me.id)[1] == 1) {
	 			$.ajax({
	 			    url: "<c:url value='/com/common/selectQueryDataList.do'/>",
	 			    type: 'post',
	 			    dataType: 'json',
	 			    data: {
	 			    	'QUERY': 'selectCmMenuByModuleCode', 
	 			    	'MODULE_CODE': AUIGrid.getSelectedItems(me.id)[0].item['MODULE_CODE']
	 			   	},
	 			    success:function(data){
	 			    	if(data.success) {
	 				    	me.columnLayout[1].editRenderer.list = data.result;
	 			    	} else {
	 			    		alert(data.message);
	 			    	}
	 			    },
	 				error : function(jqXHR, textStatus, errorThrown){
	 					alert(textStatus);
	 				}
	 			});
			} else if(AUIGrid.getSelectedIndex(me.id)[1] == 3) {
				
	 			$.ajax({
	 			    url: "<c:url value='/com/common/selectQueryDataList.do'/>",
	 			    type: 'post',
	 			    dataType: 'json',
	 			    data: {
	 			    	'QUERY': 'selectCmMenuByUpperMenuId', 
	 			    	'UPPER_MENU_ID': AUIGrid.getSelectedItems(me.id)[0].item['UPPER_MENU_ID']
	 			   	},
	 			    success:function(data){
	 			    	if(data.success) {
	 				    	me.columnLayout[3].editRenderer.list = data.result;
	 			    	} else {
	 			    		alert(data.message);
	 			    	}
	 			    },
	 				error : function(jqXHR, textStatus, errorThrown){
	 					alert(textStatus);
	 				}
	 			});
			}
 			
 			var flag = false;
 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
 			
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			if(AUIGrid.getSelectedIndex(me.id)[1] != 5) {
 				flag = true;
 			}
 			
 			return flag;
 		});
 		
 		AUIGrid.bind(me.id, 'cellEditEnd', function(event) {
 			if(AUIGrid.getSelectedIndex(me.id)[1] == 0) {
				AUIGrid.updateRow(me.id, {
					'UPPER_MENU_NM' : '',
					'UPPER_MENU_ID' : '',
					'MENU_ID' : '',
					'MENU_NM' : ''
				}, event.rowIndex);
 			}
 			
 			if(AUIGrid.getSelectedIndex(me.id)[1] == 1) {
				AUIGrid.updateRow(me.id, {
					'MENU_ID' : '',
					'MENU_NM' : ''
				}, event.rowIndex);
 			}
 		});
 		
		AUIGrid.bind(me.id, 'selectionChange', function(e) {
			grCmRoleLmtt.proxy.param['PROGRM_ID'] = e.selectedItems[0].item['PROGRM_ID'];
			grCmRoleLmtt.load();
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

var grCmRoleLmtt = {
 	id: '',
 	div: {
 		gridDiv: '#grCmRoleLmtt'
 	},
 	proxy: {
 		url: "<c:url value='/com/a02/selectCmRoleLmttByProgrmId.do'/>",
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
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,
		height: 265,
	    headerHeight: 40,
	    rowHeight: 37,
	    displayTreeOpen : true,
 	},
 	columnLayout : [{
 		dataField : "PROGRM_ID",
 		headerText : '<spring:message code="coma0201.gr.PROGRM_ID" />',
 		filter : {
 			showIcon : true
 		},
 		editable : false
 	},{
 		dataField : "ROLE_ID",
 		headerText : '<spring:message code="coma0201.gr.ROLE_ID" />',
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			var me = grCmRoleLmtt;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[1].editRenderer.list.length; i++) {
				if(me.columnLayout[1].editRenderer.list[i]['ROLE_ID'] == value) {
					retStr = me.columnLayout[1].editRenderer.list[i]['ROLE_NM'];
					break;
				}
			}
			
			if(!retStr) {
				return AUIGrid.getItemByRowIndex(me.id, rowIndex)['ROLE_NM'];
			} else {
				return retStr;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			list : '',
			keyField : "ROLE_ID",
			valueField : "ROLE_NM"
		}
 	},{
 		dataField : "USE_YN",
 		headerText : '<spring:message code="coma0201.gr.USE_YN" />',
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		width: 96,
 		style:"use_style_01",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPDATE_NM",
 		headerText : '<spring:message code="coma0201.gr.UPDATE_NM" />',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="coma0201.gr.LAST_UPDDE" />',
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
		$.ajax({
			url : "<c:url value='/com/a02/selectCmRoleByFixingAtForComboBox.do'/>",
			type: 'post',
		    dataType: 'json',
		    success:function(data){
		    	
		    	if(data.success) {
		    		
			    	me.columnLayout[1].editRenderer.list = data.result;
			    	
			 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			 		
			 		me.binding();
			 		
			 		if(me.proxy.autoLoad) {
			 			me.load();
			 		}

		    	} else {
		    		
		    		alert(data.message);
		    		
		    	}
		    	
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});

 	},
 	binding: function() {
 		var me = this;
 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
 			
 			var flag = false;
 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
 			
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
 					if(AUIGrid.getSelectedIndex(me.id)[1]) {
	 					flag = true;
 					}
 				}
 			}
 			return flag;
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

var grCmRoleLmttForSave = {
 	id: '',
 	div: {
 		gridDiv: '#grCmRoleLmttForSave'
 	},
 	proxy: {
 		url: "<c:url value='/com/a02/selectCmRoleLmttByProgrmId.do'/>",
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
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,
		height: 265,
	    headerHeight: 40,
	    rowHeight: 37,
	    displayTreeOpen : true,
 	},
 	columnLayout : [{
 		dataField : "ROLE_ID",
 		headerText : '<spring:message code="coma0201.gr.ROLE_ID" /><span class="must_01"></span>',
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			var me = grCmRoleLmttForSave;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[0].editRenderer.list.length; i++) {
				if(me.columnLayout[0].editRenderer.list[i]['ROLE_ID'] == value) {
					retStr = me.columnLayout[0].editRenderer.list[i]['ROLE_NM'];
					break;
				}
			}
			
			if(!retStr) {
				return AUIGrid.getItemByRowIndex(me.id, rowIndex)['ROLE_NM'];
			} else {
				return retStr;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			list : '',
			keyField : "ROLE_ID",
			valueField : "ROLE_NM"
		}
 	},{
 		dataField : "USE_YN",
 		headerText : '<spring:message code="coma0201.gr.USE_YN" />',
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		width: 96,
 		style:"use_style_01",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPDATE_NM",
 		headerText : '<spring:message code="coma0201.gr.UPDATE_NM" />',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="coma0201.gr.LAST_UPDDE" />',
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	}],
 	createGrid: function() {
 		var me = this;
 		
		$.ajax({
			url : "<c:url value='/com/a02/selectCmRoleByFixingAtForComboBox.do'/>",
			type: 'post',
		    dataType: 'json',
		    success:function(data){
		    	if(data.success) {
			    	me.columnLayout[0].editRenderer.list = data.result;
			    	
			 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			 		
			 		me.binding();
			 		
			 		if(me.proxy.autoLoad) {
			 			me.load();
			 		}

		    	} else {
		    		alert(data.message);
		    	}
		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});

 	},
 	binding: function() {
 		
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


$(function(){
	grCmProgm.createGrid();
	
	grCmRoleLmttForSave.createGrid();
	
	$('#btnCmProgmInit').click(function() {

		AUIGrid.destroy(grCmProgm.id);
		AUIGrid.destroy(grCmRoleLmtt.id);
		AUIGrid.destroy(grCmRoleLmttForSave.id);
		
		grCmProgm.createGrid();
		grCmRoleLmttForSave.createGrid();
		
	});
	
	$('#btnCmRoleLmttAdd').click(function() {
		var row = {
				'USE_YN': 'Y',
				'UPDATE_NM': '${loginMap.USER_NM}',
				'LAST_UPDDE': new Date(),
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmRoleLmttForSave.id, row, 'first');
	});
	
	$('#btnCmRoleLmttDelete').click(function() {
		AUIGrid.removeRow(grCmRoleLmttForSave.id, "selectedIndex");
	});
	
	$('#btnCmRoleLmttSave').click(function() {
		
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}
		
		var arJson = [];
		
		var checkedItems = AUIGrid.getCheckedRowItems(grCmProgm.id);
		
		if(!checkedItems.length) {
			alert('<spring:message code="coma0201.msg.4"/>');
			return;
		}
		
		for(var i = 0; i < checkedItems.length; i++) {
			
			if(!checkedItems[i].item['MODULE_CODE'] || !checkedItems[i].item['UPPER_MENU_ID'] ||
					!checkedItems[i].item['MENU_ID'] || !checkedItems[i].item['PROGRM_ID'] ||
					!checkedItems[i].item['PROGRM_NM'] ||!checkedItems[i].item['PROGRM_URL']) {
				alert('<spring:message code="message.validation.2"/>');
				return;
			}    
			
			checkedItems[i].item.GUBUN = 'PROGRM_ITEM';
			arJson.push(checkedItems[i].item);
			
		}
		
		var addedRowItems = AUIGrid.getAddedRowItems(grCmRoleLmttForSave.id);
		
		if(!addedRowItems.length && !confirm('<spring:message code="coma0201.msg.5"/>')) {
			return;
		}
		
		for(var i = 0; i < addedRowItems.length; i++) {
			
			if(!addedRowItems[i]['ROLE_ID']) {
				alert('<spring:message code="message.validation.2"/>');
				return;
			}    
			
			addedRowItems[i].GUBUN = 'ROLE_ITEM';
			arJson.push(addedRowItems[i]);
			
		}
		
		$.ajax({
			url : "<c:url value='/com/a02/insertCmRoleLmttByPk.do'/>",
			type: 'post',
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(arJson),
			success : function(data, textStatus, jqXHR) {
				
				if(data.success) {
					
			  		AUIGrid.setAllCheckedRows(grCmProgm.id, false);
			  		
					for(var i = 0; i < addedRowItems.length; i++) {
			  			AUIGrid.removeRow(grCmRoleLmttForSave.id, 0);
			  		}
					
			  		grCmRoleLmtt.load();
			  		
			  		alert('<spring:message code="message.save.2"/>');
			  		
				} else {
			  		AUIGrid.removeAjaxLoader(grCmRoleLmtt.id);
			  		alert(data.message);
			 	}
				
			}, 
			error : function(jqXHR, textStatus, errorThrown){
			 alert(textStatus);
			}
		});
		
	});
	
	$('#btnCmProgmAdd').click(function() {
		var row = {
				'MODULE_CODE': '',
				'MENU_ID': '',
				'MENU_NM': '',
				'MENU_ORDR': '',
				'MENU_DC': '',
				'USE_YN': 'Y',
				'TASK_AT': 'N',
				'ESSNTL_AT': 'N',
				'FIXING_AT': 'N',
				'UPDATE_NM': '${loginMap.USER_NM}',
				'LAST_UPDDE': new Date(),
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmProgm.id, row, 'first'); // 최하단에 행 추가
	});
	
	$('#btnCmProgmDelete').click(function() {
		AUIGrid.removeRow(grCmProgm.id, "selectedIndex");
	});
	
	$('#btnCmProgmSave').click(function() {
		
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}

		var arJson = [];
		
		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(grCmProgm.id);
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(grCmProgm.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(grCmProgm.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = '${loginMap.USER_ID}';
			arJson.push(editedItems[i]);
		}
				
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			arJson.push(removeItems[i]);
		}
		
		if(!arJson.length) {
			alert('<spring:message code="message.null.1"/>');
			return;
		}
		
		for(var i = 0; i < arJson.length; i++ ) {
			if(arJson[i]['CURD'] != 'D') {
				if(!arJson[i]['MODULE_CODE'] || !arJson[i]['UPPER_MENU_ID'] ||
						!arJson[i]['MENU_ID'] || !arJson[i]['PROGRM_ID'] ||
						!arJson[i]['PROGRM_NM'] ||!arJson[i]['PROGRM_URL']) {
					alert('<spring:message code="message.validation.2"/>');
					return;
				}    
			}
		}
		
		$.ajax({
			  url : "<c:url value='/com/a02/insertCmProgrm.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  alert('<spring:message code="message.save.2"/>');
					  grCmProgm.load()
				  } else {
					  AUIGrid.removeAjaxLoader(grCmProgm.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
		
	});
	
});

$(window).resize(function() {
	if (grCmProgm && grCmProgm.id) {
		AUIGrid.resize(grCmProgm.id);
	}
	
	if (grCmRoleLmtt && grCmRoleLmtt.id) {
		AUIGrid.resize(grCmRoleLmtt.id);
	}
	
	if (grCmRoleLmttForSave && grCmRoleLmttForSave.id) {
		AUIGrid.resize(grCmRoleLmttForSave.id);
	}
});
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMA0201&UPPER_MENU_ID=COMA" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMA0201&UPPER_MENU_ID=COMA" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
	<section id="mainCon">
		<div class="mainConInner">
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
				<article class="conTitBox">
					<h5><spring:message code="coma0201.title.1"/></h5>
				</article>
				
				<article class="conTitBtnR">
					<input type="button" id="btnCmProgmInit" value=<spring:message code="btn.init"/> class="reset_01" title="<spring:message code="btn.init"/>">
					<input type="button" id="btnCmProgmAdd" value=<spring:message code="btn.rowAdd"/> class="add_01" title="<spring:message code="btn.rowAdd"/>">
					<input type="button" id="btnCmProgmDelete" value=<spring:message code="btn.rowDelete"/> class="del_01" title="<spring:message code="btn.rowDelete"/>">
					<input type="button" id="btnCmProgmSave" value=<spring:message code="btn.save"/> class="save_01" title="<spring:message code="btn.save"/>">
				</article>
				
				<article class="mgT16">
					<div id="grCmProgm" class="gridHeiSz10 grid_wrap tb01_2"></div>
				</article>
			</div>
		</section>
		
		<section class="conBox50 conBox">
			<div class="conBoxInner">
			<article class="conTitBox">
				<h5><spring:message code="coma0201.title.3"/></h5>
            </article>
            
			<article class="conTitBtnR">
				<c:if test="${AUTH_BTN_GUBUN eq 'Y'}">
				<input type="button" id="btnCmRoleLmttAdd" value=<spring:message code="btn.rowAdd"/> class="add_01" title="<spring:message code="btn.rowAdd"/>">
				<input type="button" id="btnCmRoleLmttDelete" value=<spring:message code="btn.rowDelete"/> class="del_01" title="<spring:message code="btn.rowDelete"/>">
				<input type="button" id="btnCmRoleLmttSave" value=<spring:message code="btn.save"/> class="save_02" title="<spring:message code="btn.save"/>">
				</c:if>
			</article>
            
			<article class="mgT16">
					<div id="grCmRoleLmttForSave" class="gridHeiSz06 grid_wrap tb01_2"></div>
			</article>
			</div>
		</section>
		
		<section class="conBox50 conBox">
			<div class="conBoxInner">
				<article class="conTitBox">
					<h5><spring:message code="coma0201.title.2"/></h5>
	            </article>
	            
				
				<article class="mgT16">
					<div id="grCmRoleLmtt" class="gridHeiSz06 grid_wrap tb01_2"></div>
                </article>
			</div>
		</section>
		
		</div>
	</section>
	<!-- 메인 끝 -->
</div>
</body>
</html>