<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}
.edc_column_style2 { color: #5570e6; font-weight: bold;}


#mainCon{padding:0px;}

#topMenu .gnb li{}
#topMenu .gnb .gnbmenu_001{ display:none;}
#topMenu .gnb .gnbmenu_002{ display:none;}
#topMenu .gnb .gnbmenu_003{ display:none;}
#topMenu .gnb .gnbmenu_004{}
#topMenu .gnb .gnbmenu_005{}
#topMenu .gnb .gnbmenu_006{}
#topMenu .gnb .gnbmenu_006_01{padding-left:0px; padding-right:24px; }
#topMenu .gnb .gnbmenu_007{ display:none;}
#topMenu .gnb .gnbmenu_008{display:none;}

</style>

<script type="text/javascript">
var test = '${MODULE_CODE}';
var eduType = "TASK";

var grCmUserTask = {
	id : '',
	div : {
		gridDiv : '#grCmUserTask',
		paging : {
			pagingDiv : 'grCmUserTask_paging',
			totalRowCount : 500,
			rowCount : 20,
			pageButtonCount : 5,
			currentPage : 1,
			totalPage : 0,
		},
	},
	proxy : {
		url : "<c:url value='/edc/a01/selectTaskList.do'/>",
		param : {'MODULE_CODE' : '${MODULE_CODE}'},
		type : 'post',
		dataType : 'json',
		paging : true,
		autoLoad : true
	},
	gridPros : {
		showRowNumColumn : false,
		showRowCheckColumn : false,
		enableColumnResize : true,
		enableMovingColumn : false,
		editable : false,
		enableFilter : true,
		headerHeight : 40,
		rowHeight : 37,
		fixedColumnCount : 3,
		selectionMode : "singleRow"
	},
	columnLayout : [{ 
		dataField : "TASK_NO",
		headerText : "과제번호",
		width : 120,
		style : "edc_column_style"
	},{
		dataField : "TASK_SN",
		headerText : "과제순번",
		visible: false
	},{
		dataField : "TASK_NM",
		headerText : "과제명",
		width: 200
	},{
		dataField : "TASK_TY_CODE_NM",
		headerText : "종류",
		width: 80
	},{
		dataField : "PROGRS_CODE_NM",
		headerText : "상태",
		width: 100
	},{
		dataField : "TASK_DC",
		headerText : "설명"
	},{
		dataField : "ROLE_NM",
		headerText : "권한",
		width: 100
	},{
		dataField : "ROLE_ID",
		headerText : "권한",
		width: 100,
		visible: false
	},{
		dataField : "TASK_TY_CODE",
		headerText : "과제구분",
		visible: false
	},{
		dataField : "EDU_TY",
		headerText : "교육",
		width: 100,
		style : "edc_column_style2"
	},{
		dataField : "EDU_YN",
		headerText : "이수여부",
		visible: false
	}],
	createGrid : function() {
		var me = this;
		
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
		me.binding();
		
		if(!me.proxy.param['MODULE_CODE']) {
			me.proxy.param['MODULE_CODE'] =  '${MODULE_CODE}';
		}
		
		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	binding : function() {
		var me = this;
		AUIGrid.bind(me.id, 'cellClick', function(event) {
			if (event.dataField == "TASK_NO") {
				var eduYn = event.item['EDU_YN'];
				$('#txtTaskSn').val(event.item['TASK_SN']);
				$('#txtTaskNo').val(event.item['TASK_NO']);
				$('#txtRoleId').val(event.item['ROLE_ID']);
				$('#txtTaskTyCode').val(event.item['TASK_TY_CODE']);
				$('#txtModuleCode').val(test);
				
    	 		$.ajax({
    	 		    url: "<c:url value='/edc/a01/selectCtmsDmcTaskRoleForDupCheck.do'/>",
    	 		    type: 'post',
    	 		    dataType: 'json',
    	 		    data: {
    	 		    	'ROLE_ID' : event.item['ROLE_ID'],
    	 		    	'MODULE_CODE' : test,
    	 		    	'TASK_SN' : event.item['TASK_SN']
    	 		    },
    	 		    success:function(data){
    	 		    	if(data.success) {
    	 		    		if(!data.count) {
    	 		    			alert('과제별 역할 권한 화면을 지정해 주십시오.');
    	 		    			return;
    	 		    		} else {
    	 		    			if(eduYn == "Y"){
	    	 						$("#frSubmit").attr({
	    	 							action: "<c:url value='/edc/system/EDCA0101.do'/>",
	    	 							method:'post',
	    	 						}).submit();
    	 		    			}
    	 		    			else{
    	 		    				taskSn   = event.item['TASK_SN'];
    	 		    				nowIndex = event.rowIndex;
    	 		    				gridId   = me.id;
    	 		    				fn_eduPopup();
    	 		    			}
    	 		    		}
    	 		    	} else {
    	 		    		alert(data.message);
    	 		    	}
    	 		    },
    				error : function(jqXHR, textStatus, errorThrown){
    					alert(textStatus);
    				}
    	 		});

			}
		});
	},
	load : function() {
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

var gridId, nowIndex, taskSn;
function fn_eduPopup(){
	var param={};
	mkLayerPopupOpen("/ctms/j03/popupDMCJ0304.do", param);
}
function fn_eduResult(){
	var userData = { EDU_TY : "이수",  EDU_YN : "Y"};
	AUIGrid.updateRow(gridId, userData, nowIndex);
}

$(function(){
	if(!test) {
		location.href = "<c:url value='/com/i01/intro.do'/>";
	}
	
	grCmUserTask.createGrid();
});

window.onresize = function() {
	if (grCmUserTask && grCmUserTask.id) {
		AUIGrid.resize(grCmUserTask.id);
	}
};

</script>
</head>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCA0101&&UPPER_MENU_ID=EDCA" charEncoding="utf-8"/>
	<form id="frSubmit" name="frSubmit">
		<input type="hidden" id="txtTaskSn" name="TASK_SN"/>
		<input type="hidden" id="txtTaskNo" name="TASK_NO"/>
		<input type="hidden" id="txtRoleId" name="ROLE_ID"/>
		<input type="hidden" id="txtModuleCode" name="MODULE_CODE"/>
		<input type="hidden" id="txtTaskTyCode" name="TASK_TY_CODE"/>
	</form>
	<section id="mainCon">
		<div class="mainConInner">
			<section class="conBox100 conBox">
                <div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>과제 선택</h5>
                    </article>
                    <article class="mgT16">
                        <div id=grCmUserTask class="gridHeiSz10 grid_wrap tb01_2"></div>
                    </article>
                </div>
            </section>
    	</div>
	</section>
</div>
</body>
</html>