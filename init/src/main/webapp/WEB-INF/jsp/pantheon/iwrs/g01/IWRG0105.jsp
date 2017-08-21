<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<jsp:include page="/com/common.do" flush="false"/>

	<style>
		.view_block_01{ display: block; border:1px solid red; margin-bottom:30px;}
		.hide_block_01{ display: none;}
		
		.view_block_02{ display: block; border:1px solid blue; margin-bottom:30px;}
		.hide_block_02{ display: none;}
	</style>

	<script type="text/javascript">
		var gridArmRatio = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grArmRatio'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectArmRaioInfo.do',
		 		param: {TASK_SN : "${TASK_SN}"},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': true,
				'showStateColumn': false,
				'showRowNumColumn' : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "TA_RATE",
								headerText : "Ratio"
							}, {
								dataField : "TA_CODE",
								headerText : "ARM Code",
								editable : false
							}, {
								dataField : "TA_LBL",
								headerText : "ARM",
								editable : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 	
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
		
		var gridFactor = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grFactor'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectRandomizationList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "SE_CODE",
								headerText : "Factor Name",
							    width : 150,
							    cellMerge : true
							}, {
								dataField : "STTUS_CODE",
								headerText : "Label",
							    width : 150,
							    cellMerge : true
							}, {
								dataField : "CODE_TY",
								headerText : "No of Levels",
							    width : 150
							}, {
								dataField : "CODE_TY",
								headerText : "Level Description"
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 	
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
		
		var gridElement = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grElement'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectRandomizationList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "SE_CODE",
								headerText : "Element Code"
							}, {
								dataField : "STTUS_CODE",
								headerText : "Element"
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 	
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}	
		}
		
		var gridElementArm = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grElementArm'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectRandomizationList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "SE_CODE",
								headerText : "Sequence"
							}, {
								dataField : "STTUS_CODE",
								headerText : "Arm Code"
							}, {
								dataField : "STTUS_CODE",
								headerText : "Arm Name"
							}, {
								dataField : "STTUS_CODE",
								headerText : "Ratio"
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 	
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}	
		}
		
		var gridCodeConfiguration = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grCodeConfiguration'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectRandomizationList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': true,
				'showStateColumn': false,
				'showRowNumColumn' : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "CONF_TY",
								headerText : "Type",
						 		filter : {
						 			showIcon : true
						 		},
								labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
									var me = gridCodeConfiguration;
									var retStr = "";
									
									for(var i = 0; i < me.columnLayout[0].editRenderer.list.length; i++) {
										if(me.columnLayout[0].editRenderer.list[i]['CMMN_CODE'] == value) {
											retStr = me.columnLayout[0].editRenderer.list[i]['CMMN_CODE_NM'];
											break;
										}
									}
									if(retStr) {
										return retStr;	
									} else {
										return value;
									}
								},
								editRenderer : {
									type : "DropDownListRenderer",
									showEditorBtnOver: true,
									list : '',
									keyField : "CMMN_CODE",
									valueField : "CMMN_CODE_NM"
								}
							}, {
								dataField : "CONF_SIZE",
								headerText : "설정(길이)"
							}, {
								dataField : "CONF_VALUE",
								headerText : "값"
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		$.ajax({
					url : "<c:url value='/com/common/selectQueryDataList.do'/>",
					type: 'post',
					dataType: 'json',
					data:{'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'IWRS021'},
					success : function(data) {
						if(data.success) {
							me.columnLayout[0].editRenderer.list = data.result;
						} else {
					    	alert(data.message);
					    }
					},
					error : function(jqXHR, textStatus, errorThrown){
							alert(textStatus);
					}
				});
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 이벤트 
		 	binding: function() {
		 		var me = this;
		 		
		 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
		 			
		 			var flag = false;
		 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
		 			
		 			for(var i = 0; i < addedRowItems.length; i++) {
		 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
		 					flag = true;
		 				}
		 			}
		 			
		 			if(AUIGrid.getSelectedIndex(me.id)[1] > 1 && AUIGrid.getSelectedIndex(me.id)[1] < 10) {
		 				flag = true;
		 			}
		 			
		 			return flag;
		 		});
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 	
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}	
		}
		
		var gridBlock = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grBlock'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectRandomizationList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': true,
				'showStateColumn': true,
				'showRowNumColumn' : true,
				'showRowCheckColumn' : true,
				softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
				enableFilter : true,
		 		sortable : false,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "BLCK_SIZE",
								headerText : "크기",
								editable : false
							}, {
								dataField : "BLCK_CO",
								headerText : "블록수"
							}, {
								dataField : "CREAT_CO",
								headerText : "생성 수",
								editable : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	binding: function() {
		 		var me = this;
		 		
				AUIGrid.bind(me.id, 'cellEditEnd', function(e) {
					var item ={
							"CREAT_CO" : e.item.BLCK_SIZE * e.item.BLCK_CO
					};
					AUIGrid.updateRow(me.id, item, e.rowIndex); 
				});
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 	
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}	
		}
		
		
		
		
		
		
		$(function() {
			init();
			event();
		});
		
		function init(){
			gridArmRatio.createGrid();
			gridFactor.createGrid();
			gridElement.createGrid();
			gridElementArm.createGrid();
			gridCodeConfiguration.createGrid();
			gridBlock.createGrid();

			$("#divRandomSetting").hide();
			$("#liArmRatio").hide();
			$("#liFactor").hide();
			$("#liElement").hide();
			$("#liCodeConfiguration").hide();
			$("#liRandomization").hide();
			$("#liSetting").hide();
			
			<c:forEach var="result" items="${IWRS019}" varStatus="status">
				$("#sltType").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			</c:forEach>
			
			<c:forEach var="result" items="${IWRS006}" varStatus="status">
				$("#sltFactorYn").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			</c:forEach>
			
			<c:forEach var="result" items="${visit}" varStatus="status">
				$("#sltVisit").append("<option value='<c:out value="${result.VISIT_SN}"/>'>" + '<c:out value="${result.VISIT_LBL}"/>' + "</option>");
			</c:forEach>
		}
		
		function event(){
			setAccodian_02();
			
			$("#sltType").change(function(){
				$(".accordion_02 > a").not(this).removeClass('open');
				$(".accordion_con_02").css({"display":"none"});
				if($("#sltType option:selected").val() == ""){
					$("#divRandomSetting").hide();
				}else if($("#sltType option:selected").val() == "01"){
					$("#divRandomSetting").show();
					$("#liArmRatio").show();
					$("#liFactor").hide();
					$("#liElement").hide();
					$("#liCodeConfiguration").show();
					$("#liRandomization").show();
					$("#liSetting").hide();
				}else if($("#sltType option:selected").val() == "02"){
					$("#divRandomSetting").show();
					$("#liArmRatio").hide();
					$("#liFactor").hide();
					$("#liElement").show();
					$("#liCodeConfiguration").show();
					$("#liRandomization").show();
					$("#liSetting").hide();
				}else if($("#sltType option:selected").val() == "03"){
					$("#divRandomSetting").show();
					$("#liArmRatio").show();
					$("#liFactor").hide();
					$("#liElement").hide();
					$("#liCodeConfiguration").show();
					$("#liRandomization").hide();
					$("#liSetting").show();
				}
			});
			
			$("#sltFactorYn").change(function(){
				if($("#sltFactorYn option:selected").val() == "Y"){
					$("#liFactor").show();
				}else{
					$("#liFactor").hide();
				}
			});
			
			$("#btnCreatEdit").click(function(){
				
			});
			
			$("#btnCreatSave").click(function(){
				var param = {
					TASK_SN : "${TASK_SN}",
					IWRS_VER : "${IWRS_VER}",
					SE_CODE : "01",
					STTUS_CODE : "01",
					CODE_TY : "01",
					RULE_TY : $("#sltType option:selected").val(),
					STRTFY_AT : $("#sltFactorYn option:selected").val(),
					VISIT_SN : $("#sltVisit option:selected").val(),
					EDC_VER : "${EDC_VER}",
					OPER_TY : "01",
					USE_AT : "Y"
				};
				
				$.ajax({
					type : "POST",
					async : false,
					data : param,
					url : "/iwrs/g01/insertCodeCreat.do",
					success :function(data){
						if(data.result){
							alert(data.message);
							$("#hCreateCode").val(data.CREAT_CODE);
						}else{
							alert(data.message);
						}
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			});
			
			$("#btnArmRatioEdit").click(function(){
				
			});
			
			$("#btnArmRatioSave").click(function(){
				var gridData = AUIGrid.getGridData(gridArmRatio.id);
				var param = [{
					CREAT_CODE : $("#hCreateCode").val(),
					EDC_VER : "${EDC_VER}",
					USE_AT : "Y",
					DATA : gridData
				}];
				
				$.ajax({
					type : "POST",
					async : false,
					data : {data : JSON.stringify(param) },
					url : "/iwrs/g01/insertArmRatioInfo.do",
					success :function(data){
						if(data.result){
							alert(data.message);
							$("#hArmRatio").val(data.ratio);
							alert(data.ratio);
						}else{
							alert(data.message);
						}
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			});
			
			$("#btnAddCodeConfiguration").click(function(){
				var row = {
						'CRUD' : 'C'
				};
				AUIGrid.addRow(gridCodeConfiguration.id, row, 'last'); // 최하단에 행 추가
			});
			
			$("#btnCodeConfigurationEdit").click(function(){
				
			});
			
			$("#btnCodeConfigurationSave").click(function(){
				var gridData = AUIGrid.getGridData(gridCodeConfiguration.id);
				var param = [{
					CREAT_CODE : $("#hCreateCode").val(),
					USE_AT : "Y",
					DATA : gridData
				}];
				
				$.ajax({
					type : "POST",
					async : false,
					data : {data : JSON.stringify(param) },
					url : "/iwrs/g01/insertCodeConfigurationInfo.do",
					success :function(data){
						if(data.result){
							alert(data.message);
						}else{
							alert(data.message);
						}
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			});
			
			$("#btnAddRandomizationCode").click(function(){
				var rowCount = AUIGrid.getRowCount(gridBlock.id) + 1;	
				var row = {
						BLCK_SIZE : $("#hArmRatio").val() * rowCount,
						'CRUD' : 'C'
				};
				AUIGrid.addRow(gridBlock.id, row, 'last'); // 최하단에 행 추가
			});
			
			$("#btnDelRandomizationCode").click(function(){
				
			});
			
			$("#btnRandomizationCodeSave").click(function(){
				var gridData = AUIGrid.getGridData(gridBlock.id);
				var param = [{
					CREAT_CODE : $("#hCreateCode").val(),
					OPER_TY : "Y",
					SEED_CO : $("#txtSeed").val(),
					BLCK_SEED_CO : $("#txtBlockSeed").val(),
					USE_AT : "Y",
					ADIT_AT : "N",
					DATA : gridData
				}];
				
				$.ajax({
					type : "POST",
					async : false,
					data : {data : JSON.stringify(param) },
					url : "/iwrs/g01/insertRandomSeed.do",
					success :function(data){
						if(data.result){
							alert(data.message);
						}else{
							alert(data.message);
						}
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			});
			
			$("#btnGeneration").click(function(){
				var gridData = AUIGrid.getGridData(gridBlock.id);
				var param = {
					CREAT_CODE : $("#hCreateCode").val(),
					EDC_VER : "${EDC_VER}",
					ADIT_AT : "N",
					OPER_TY : "01"
				};
				
				$.ajax({
					type : "POST",
					async : false,
					data : param,
					url : "/iwrs/g01/insertRandomizationInfo.do",
					success :function(data){
						if(data.result){
							alert(data.message);
						}else{
							alert(data.message);
						}
					}, 
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
				});
			});
		}
		
		$(window).resize(function(){
			if (gridArmRatio.id) {
				AUIGrid.resize(gridArmRatio.id);
			}
			if (gridFactor.id) {
				AUIGrid.resize(gridFactor.id);
			}
			if (gridElement.id) {
				AUIGrid.resize(gridElement.id);
			}
			if (gridElementArm.id) {
				AUIGrid.resize(gridElementArm.id);
			}
			if (gridCodeConfiguration.id) {
				AUIGrid.resize(gridCodeConfiguration.id);
			}
			if (gridBlock.id) {
				AUIGrid.resize(gridBlock.id);
			}
		});
		
		
		
		function setAccodian_02(acc_select){
			$(".accordion_02 > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".accordion_con_02").slideToggle(0);				
					$(this).toggleClass('open');
					AUIGrid.resize(gridArmRatio.id);
					AUIGrid.resize(gridFactor.id);
					AUIGrid.resize(gridElement.id);
					AUIGrid.resize(gridElementArm.id);
					AUIGrid.resize(gridCodeConfiguration.id);
					AUIGrid.resize(gridBlock.id);
				}
			});
			
			$(".accordion_02").not(this).on("click",function() {		
				if ($(".accordion_02").not(this).children().hasClass("close")) {
					$(".accordion_02").not(this).children(".accordion_con_02").slideUp(0);
				}
			});
		
			$(".accordion_02 > a").not(this).on("click",function() {
				if ($(".accordion_02 > a").hasClass('open')) {
					$(".accordion_02 > a").not(this).removeClass('open');
					
				}
			});
		
			$(".accordion_con_02").css({"display":"none"});
			
			var acc_click = acc_select - 1;
			$(".accordion_wrap > li > a").eq(acc_click).trigger("click");
		
		}		
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=IWRG0105&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=IWRG0105&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>${progrmMap.UPPER_MENU_NM}</li>
	                        <li>${progrmMap.MENU_NM}</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner" style="min-height:900px;">
					
						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="tabVersionList" class="tab_menu">목록</li>
								<li id="tabRandomList" class="port_back tab_menu">Randomization</li>
								<li id="tabIpList" class="tab_menu">IP</li>
								<li id="tabScreenDesign" class="tab_menu">화면디자인</li>
							</ul>
						</div>


						<article style="position:relative;">
							<h5>CJ 연구과제8</h5>
							<div class="tab_small">
								<ul>
									<li id="tabRealRandomization" class="port_back tab_menu_s">무작위배정코드</li>
									<li id="tabAddRandomization" class="tab_menu_s">추가 무작위배정코드</li>
									<li id="tabTestRandomization" class="tab_menu_s">테스트 코드</li>
								</ul>
							</div>
						</article>
						
						<!-- 시스템 Radio -->
						<div class="view_block_01 mgT20">
							<div class="mgT5" style="height:30px;">
								<div class="conTitBtnL" style="width:80%;">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">설계 디자인 </span>
									&nbsp;
									<select id="sltType" style="width:80%; vertical-align:top;">
										<option value="">====선택====</option>
									</select>
									<input type="hidden" id="hCreateCode" value="" />
									<input type="hidden" id="hArmRatio" value="" />
								</div>
								<div class="conTitBtnR">
									<input id="btnCreatEdit" type="button" value="수정">
									<input id="btnCreatSave" type="button" value="저장">
									<input id="btnGeneration" type="button" value="생성">
								</div>
							</div>
							<div class="mgT5" style="height:30px;">
								<div class="conTitBtnL" style="width:48%;">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">배정시점 설정 </span>
									&nbsp;
									<select id="sltVisit" style="width:100px;vertical-align:top;">
										<option value="">==선택==</option>
									</select>
								</div>
								<div class="conTitBtnR" style="width:48%;">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">층화 </span>
									&nbsp;
									<select id="sltFactorYn" style="width:100px; vertical-align:top;">
										<option value="">==선택==</option>
									</select>
								</div>
							</div>
						</div>
						
						<!-- Block Randomization -->
						<div id="divRandomSetting" class="view_block_02">
							
							<ul class="mgT10 accordion_wrap">
							    <li id="liArmRatio" class="accordion_02">
							    	<a href="#void" class="close">Arm Ratio</a>
							        <div class="accordion_con_02">
							        	<div style="height:38px;">
											<div class="conTitBtnR">
												<input id="btnArmRatioEdit" type="button" value="수정">
												<input id="btnArmRatioSave" type="button" value="저장">
											</div>
										</div>
							        	<div id="grArmRatio" class="gridHeiSz03 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li id="liFactor" class="accordion_02">
							    	<a href="#void" class="close">Factor</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnR">
												<input type="button" value="Diagram 보기">
											</div>
										</div>
							        	<div id="grFactor" class="gridHeiSz05 grid_wrap tb01_2"></div>
							        </div>
								</li>
								<li id="liElement" class="accordion_02">
							    	<a href="#void" class="close">Element & Arm</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Element</span>
											</div>
										</div>
							        	<div id="grElement" class="gridHeiSz03 grid_wrap tb01_2"></div>
							        	
							        	
							        	<div style="height:10px;"></div>
							        	
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Arm Ratio</span>
											</div>
											<div class="conTitBtnR">
												<input type="button" value="추가">
											</div>
										</div>
							        	
							        	<div id="grElementArm" class="gridHeiSz03 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li id="liCodeConfiguration" class="accordion_02">
							    	<a href="#void" class="close">Code Configuration</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:0px;">Code Sample </span>
												&nbsp;
												<input type="text" style="width:200px;">
											</div>
											<div class="conTitBtnR">
												<input id="btnAddCodeConfiguration" type="button" value="추가">
												<input id="btnCodeConfigurationEdit" type="button" value="수정">
												<input id="btnCodeConfigurationSave" type="button" value="저장">
											</div>
										</div>
										<div id="grCodeConfiguration" class="gridHeiSz04 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li id="liRandomization" class="accordion_02">
							    	<a href="#void" class="close">Randomization Code</a>
							        <div class="accordion_con_02">
							        
										<div style="height:38px;">
											<div class="conTitBtnL">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Seed</span>
											</div>
											<div class="conTitBtnR">
												<input type="button" value="Diagram 보기">
											</div>
										</div>
										
										<table class="tb001">
											<colgroup>
												<col width="15%" />
												<col width="35%" />
												<col width="15%" />
												<col width="" />
											</colgroup>
											<tbody>
												<tr>
													<th>Seed</th>
													<td>
										 				<input id="txtSeed" type="text"  style="width:100%;">
													</td>
													<th>Block Seed</th>
													<td>
										 				<input id="txtBlockSeed" type="text"  style="width:100%;">
													</td>
												</tr>
											</tbody>
										</table>										
										<div style="height:10px;"></div>
										<div style="height:38px;">
											<div class="conTitBtnL">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Blocks</span>
											</div>
											<div class="conTitBtnR">
												<input id="btnAddRandomizationCode" type="button" value="행추가">
												<input id="btnDelRandomizationCode" type="button" value="행삭제">
												<input id="btnRandomizationCodeSave" type="button" value="저장">
											</div>
										</div>
							        	<div id="grBlock" class="gridHeiSz05 grid_wrap tb01_2"></div>
							        </div>
								</li>
								<li id="liSetting" class="accordion_02">
							    	<a href="#void" class="close">배정설정</a>
							        <div class="accordion_con_02">
										<table class="tb001">
											<colgroup>
												<col width="20%" />
												<col width="" />
											</colgroup>
											<tbody>
												<tr>
													<th>초기 배정용 Seed</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
												</tr>
												<tr>
													<th>초기 배정인원</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
												</tr>
												<tr>
													<th>층화그룹별최대피험자수</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
												</tr>
											</tbody>
										</table>
							        </div>
								</li>
							</ul>
						</div>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>