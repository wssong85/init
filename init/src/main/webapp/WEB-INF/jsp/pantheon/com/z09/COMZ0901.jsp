<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style type="text/css">
/* 커스텀 칼럼 스타일 정의 */
.aui-grid-user-custom-left {
	text-align:left;
}
.aui-grid-user-custom-left .aui-checkLabelBox .aui-checkbox {
	margin-left: 10px;
}
</style>

<!-- <title>결재선 설정</title> -->
<script type="text/javascript">

var vComment = '';

var grCmJobUser = {
 	id: '',
 	div: {
 		gridDiv: '#grCmJobUser'
 	},
 	proxy: {
 		url: "<c:url value='/com/z09/selectCmJobUserListForAll.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: true
 	},
 	gridPros: {
 		showStateColumn: true,
	    showRowNumColumn : true,
	    showRowCheckColumn : true,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    softRemoveRowMode: false,
	    rowIdField: 'UNIQUE_ID'
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "DEPT_NM",
 		headerText : '<spring:message code="comz0901.gr.DEPT_NM"/>',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USER_NM",
 		headerText : '<spring:message code="comz0901.gr.USER_NM"/>',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UNIQUE_ID",
 		headerText : "UNIQUE_ID",
 		filter : {
 			showIcon : true
 		},
 		visible: false
 	}],
 	//AUI 그리드 생성
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
 	//AUI 그리드 이벤트 
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
			e.item['SANCTN_CODE'] = '02';
			e.item['SANCTN_ORDR'] = 0;
			e.item['CONFMER_ID'] = e.item['USER_ID'];
			e.item['CONFMER_NM'] = e.item['USER_NM'];
			e.item['USE_YN'] = 'Y';
			
 			AUIGrid.addRow(grCmSancline.id, e.item, 'last');
 			AUIGrid.removeRow(me.id, 'selectedIndex');
		});
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
 			    	
 			    	if(grCmSancline.id) {
	 			    	var arrGrCmSancline = AUIGrid.getGridData(grCmSancline.id);

	 			    	if(arrGrCmSancline) {
	 			    		
	 			    		if(!arrGrCmSancline.length) {
	 			    			return;
	 			    		}
	 			    		
							var arrUniqueId = [];
							
		 			    	for(var i = 0; i < arrGrCmSancline.length; i++) {
		 			    		arrUniqueId.push(arrGrCmSancline[i]['UNIQUE_ID']);
		 			    	}
		 			    	
		 			    	AUIGrid.removeRowByRowId(me.id, arrUniqueId);
	 			    	}
 			    	}

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

var grCmSancline = {
 	id: '',
 	div: {
 		gridDiv: '#grCmSancline'
 	},
 	proxy: {
 		url: "<c:url value='/com/z09/selectCmSanClineDetailListByPk.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: false
 	},
 	gridPros: {
 		showStateColumn: true,
	    showRowNumColumn : true,
	    showRowCheckColumn : true,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    enableFilter : true,
	    editable : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    softRemoveRowMode: false,
	    rowIdField: 'UNIQUE_ID'
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "SANCTN_CODE",
 		headerText : '<spring:message code="comz0901.gr.SANCTN_CODE"/>',
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
			var me = grCmSancline;
			var retStr = "";
		    	
			for(var i = 0; i < me.columnLayout[0].editRenderer.list.length; i++) {
				if(me.columnLayout[0].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[0].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			
			if(!retStr) {
				return AUIGrid.getItemByRowIndex(me.id, rowIndex)['CMMN_CODE_NM'];
			} else {
				return retStr;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : '',
			keyField : "CMMN_CODE",
			valueField : "CMMN_CODE_NM"
		}
 	},{
 		dataField : "SANCTN_ORDR",
 		headerText : "순차합의순서",
 		editRenderer : {
 		    type : "NumberStepRenderer",
 		   	showEditorBtnOver: true,
 		    min : 0,
 		    max : 20
 		},
 		visible: false
 	},{
 		dataField : "DEPT_NM",
 		headerText : '<spring:message code="comz0901.gr.DEPT_NM"/>',
 		editable : false
 	},{
 		dataField : "CONFMER_NM",
 		headerText : '<spring:message code="comz0901.gr.CONFMER_NM"/>',
 		editable : false
 	},{
 		dataField : "CONFMER_ID",
 		headerText : "CONFMER_ID",
 		visible: false
 	},{
 		dataField : "UNIQUE_ID",
 		headerText : "UNIQUE_ID",
 		visible: false
 	},{
 		dataField : "STTUS_ORDR",
 		headerText : "STTUS_ORDR",
 		visible: false
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		
 		var me = this;
 		
 		$.ajax({
 		    url: "<c:url value='/com/common/selectQueryDataList.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		   	data: {'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'COM003'},
 		    success:function(data){
 		    	if(data.success) {
 			    	me.columnLayout[0].editRenderer.list = data.result;
 			    	
			 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			 		
					window.setTimeout(function(){
						AUIGrid.resize(me.id);
					}, 0.5);
			 		
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
 	//AUI 그리드 이벤트 
 	binding: function() {
 		var me = this;
 		
		AUIGrid.bind(me.id, 'headerClick', function(event) {
			return false;
		});
		
		AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
			AUIGrid.addRow(grCmJobUser.id, AUIGrid.getSelectedItems(me.id)[0].item, 'last');
 			AUIGrid.removeRow(me.id, 'selectedIndex');
		});
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
 			    	grCmJobUser.load();
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

function loadCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.SANCLINE_SN + ">" + this.SANCLINE_NM + "</option> ";
	});

	target.append(dataArr);
}

function f_requestComment(v) {
	
	vComment = v;
	
	f_cmSanclineRequest();
}

function f_cmSanclineRequest() {
	
	if(!vComment) {
		alert('코멘트는 필수 입니다.');
		return;
	}
	
	if(!$('#txtCmSanclineRequest').val()) {
		alert('<spring:message code="comz09.message.2"/>');
		return;
	}
	
	var arrSanctnCode = AUIGrid.getColumnValues(grCmSancline.id, 'SANCTN_CODE');
	
	if(!fn_hasValueByArr(arrSanctnCode, '01') || !fn_hasValueByArr(arrSanctnCode, '07')) {
		alert('<spring:message code="comz09.message.3"/>');
		return;
	}
	
	if(fn_hasValueByArr(arrSanctnCode, '01') > 1 || fn_hasValueByArr(arrSanctnCode, '02') > 1 || 
			fn_hasValueByArr(arrSanctnCode, '07') > 1) {
		alert('<spring:message code="comz09.message.4"/>');
		return;
	}
	
	if(arrSanctnCode[0] != '01') {
		alert('<spring:message code="comz09.message.5"/>');
		return;
	}
	
	if(!fn_checkGroupingByArr(arrSanctnCode)) {
		alert('<spring:message code="comz09.message.6"/>');
		return;
	}
	
	var bCheck = false;
	for(var i = 0; i < arrSanctnCode.length; i++) {
		if(arrSanctnCode[i] == '07') {
			bCheck = true;								
		}
		
		if(arrSanctnCode[i] == '02') {
			bCheck = false;
		}
	}
	
	if(!bCheck) {
		alert('<spring:message code="comz09.message.7"/>');
		return;
	}
	
	var auiItems = AUIGrid.getGridData(grCmSancline.id);
	var vCount = 1;		
	for(var i = 0; i < auiItems.length; i++) {
		if(auiItems[i]['SANCTN_CODE'] != '05') {
			AUIGrid.updateRowsById(grCmSancline.id, {
				'UNIQUE_ID': auiItems[i]['UNIQUE_ID'],
				'STTUS_ORDR': (i+1),
				'SANCTN_ORDR': 0
			});
		} else {
			AUIGrid.updateRowsById(grCmSancline.id, {
				'UNIQUE_ID': auiItems[i]['UNIQUE_ID'],
				'STTUS_ORDR': (i+1),
				'SANCTN_ORDR': vCount
			});
			vCount++;
		}
	}
	
	var paramData = AUIGrid.getGridData(grCmSancline.id);
	paramData[0].REQUST_NM = $('#txtCmSanclineRequest').val();
	paramData[0].REQUST_COMMENT = vComment;
	
	$.ajax({
		url : "<c:url value='/com/z09/insertCmSanctnRequstByCmSanClineDetailInfo.do'/>",
		type: 'post',
		contentType: "application/json; charset=UTF-8",
		data : JSON.stringify(paramData),
		success : function(data, textStatus, jqXHR) {
			if(data.success) {
				alert('<spring:message code="comz09.message.8"/>');
				//함수이름 f_requestRequstNo
				${callbackFunction}(data.REQUST_NO);
				$("#btnCmSanclineClose").trigger('click');
			} else {
				AUIGrid.removeAjaxLoader(grCmSancline.id);
				alert(data.message);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
		}
	});
}

var requstNm = '';

$(function() {
	requstNm = '${REQUST_NM}';
	$('#txtCmSanclineRequest').val(requstNm);
	grCmJobUser.createGrid();
	grCmSancline.createGrid();
	
	$("#btnCmSanclineUp").click(function() {
		AUIGrid.moveRowsToUp(grCmSancline.id);
	});
	
	$("#btnCmSanclineDown").click(function() {
		AUIGrid.moveRowsToDown(grCmSancline.id);
	});
	
	$("#btnInit").click(function() {
		$.ajax({
			url : "<c:url value='/com/z09/selectCmSanClineListForComboBox.do'/>",
			success : function(data) {
				loadCombo($("#selectCmSancline"), data.result);
		        $("#selectCmSancline").val("");
			}
		});
		
		AUIGrid.destroy(grCmJobUser.id);
		AUIGrid.destroy(grCmSancline.id);
		grCmJobUser.createGrid();
		grCmSancline.createGrid();
	});
	
	$("#btnAdd").click(function() {
		var checkedItems = AUIGrid.getCheckedRowItems(grCmJobUser.id);
		
		if(!checkedItems.length) {
			return;
		}
		
		if(checkedItems.length > 11) {
			alert('<spring:message code="comz09.message.1"/>');
			return;
		}
		
		for(var i = 0; i < checkedItems.length; i++) {
			
			checkedItems[i].item['SANCTN_CODE'] = '02';
			checkedItems[i].item['SANCTN_ORDR'] = 0;
			checkedItems[i].item['CONFMER_ID'] = checkedItems[i].item['USER_ID'];
			checkedItems[i].item['CONFMER_NM'] = checkedItems[i].item['USER_NM'];
			checkedItems[i].item['USE_YN'] = 'Y';
			
			AUIGrid.addRow(grCmSancline.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grCmJobUser.id);
		
	});
	
	$("#btnCmSanclineDelete").click(function() {
		var checkedItems = AUIGrid.getCheckedRowItems(grCmSancline.id);
		
		if(!checkedItems.length) {
			return;
		}
		
		if(checkedItems.length > 11) {
			alert('<spring:message code="comz09.message.1"/>');
			return;
		}
		
		for(var i = 0; i < checkedItems.length; i++) {
			AUIGrid.addRow(grCmJobUser.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grCmSancline.id);
	});
	
	$("#btnCmSanclineRequest").click(function() {
		
		if(vComment) {
			
			f_cmSanclineRequest();
			
		} else {
			
			mkLayerPopupOpen("<c:url value='/com/z09/popupCOMZ0904.do'/>", {'callbackFunction': 'f_requestComment'}, 3);
			
		}

	});
	
	$("#btnCmSanclineClose").click(function() {
		layerClose(1);
	});
	
	$("#btnCmSanclineManageMent").click(function() {
		mkLayerPopupOpen("<c:url value='/com/z09/popupCOMZ0902.do'/>", null, 2);
	});
	
	$("#selectCmSancline").change(function() {
		if($('#selectCmSancline option:selected').val()) {
			grCmSancline.proxy.param = {'SANCLINE_SN': $('#selectCmSancline option:selected').val()};
			grCmSancline.load();
		}
	});
	
	$.ajax({
		url : "<c:url value='/com/z09/selectCmSanClineListForComboBox.do'/>",
		success : function(data) {
			loadCombo($("#selectCmSancline"), data.result);
	        $("#selectCmSancline").val("");
		}
	});
});
</script>
</head>
<body>
<div id="wrap">
	<!-- 메인 시작 -->
	<section class="popupWrap">
	<div class="popup popup1 wd1000"> 

            <section class="conBox50 conBox" style="float: left; width:48%; padding:0;">
                <div class="conBoxInner" style="padding-bottom: 0px;">

                    <article class="conTitBox">
                        <h5><spring:message code="comz0901.title.1" /></h5>
                    </article>


                    <article class="conTitBtnR">
                    	<input type="button" id="btnInit" value="초기화" class="reset_01">
                    </article>


                    <article class="mgT16">
                        <div id="grCmJobUser" class="gridHeiSz12 grid_wrap tb01_2"></div>
                    </article>

                </div>
            </section>

			<div>
				<input type="button" id="btnAdd" class="big_arrow_btn_01" value="▶">
			</div>
			
			<div>
				<input type="button" id="btnCmSanclineDelete" class="big_arrow_btn_02" value="◀">
			</div>

<style>

.big_arrow_btn_01 { position:absolute; transition-duration:0s !important; left:48.6%; top:38%; padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; }
.big_arrow_btn_02 { position:absolute; transition-duration:0s !important; left:48.6%; top:49%; padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; }

</style>


            <section class="conBox50 conBox" style="float: right; width:48%;  padding:0; ">
                <div class="conBoxInner" style="padding-bottom: 0px;">
                

                    <article class="conTitBox">
                        <h5><spring:message code="comz0901.title.2" /></h5>
                    </article>


                    <article class="conTitBtnR">
                        <select id="selectCmSancline" style="width:100px">
							<option>===selected===</option>
						</select>
                        <input type="button" id="btnCmSanclineUp" value="▲">
                        <input type="button" id="btnCmSanclineDown" value="▼">
                        <!-- <input type="button" id="btnCmSanclineDelete" value="행삭제"> -->
                        
                    </article>

					

                    <article class="mgT16">
                        <div id="grCmSancline" class="gridHeiSz12 grid_wrap tb01_2"></div>
                    </article>


                </div>
            </section>



			<div style="clear:both; text-align: center; padding:10px 10px 10px 0;">
				<input type="button" id="btnCmSanclineClose" value=<spring:message code="btn.close" />>
				
                   <article class="conTitBtnR" style="position: absolute; right: 10px;">
                   	<input type="text" id="txtCmSanclineRequest" name="REQUST_NM" readOnly="true" style="display:none;">
                   	<input type="button" id="btnCmSanclineRequest" value=<spring:message code="comz0901.btn.1" />>
                   	<input type="button" id="btnCmSanclineManageMent" value=<spring:message code="comz0901.btn.2" />>
                   </article>
				
			</div>



	</div>
	</section>
	<!-- 메인 끝 -->
</div>
</body>
</html>