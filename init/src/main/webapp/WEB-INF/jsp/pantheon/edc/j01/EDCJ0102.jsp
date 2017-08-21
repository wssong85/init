<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	mkSetDatePickerYYMMDD("#reportDe");
	mkSetDatePickerYYMMDD("#subjectLifyeamd");
	mkSetDatePickerYYMMDD("#lastMenseDe");
	mkSetDatePickerYYMMDD("#aetBeginDe, #aetEndDe");
	mkSetDatePickerYYMMDD("#subjectSexdstn");
	mkSetDatePickerYYMMDD("#deathDe");
	
	<c:forEach var="result" items="${EDC020}" varStatus="status">
	$("#drfstfRelateCode").append("<option value='<c:out value="${result.CODE}"/>'>" + '<c:out value="${result.VALUE}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${EDC021}" varStatus="status">
	$("#drfstfMdlrtCode").append("<option value='<c:out value="${result.CODE}"/>'>" + '<c:out value="${result.VALUE}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${EDC022}" varStatus="status">
	$("#lastObservResultCode").append("<option value='<c:out value="${result.CODE}"/>'>" + '<c:out value="${result.VALUE}"/>' + "</option>");
	</c:forEach>
	
	$("#reportDe").val("${result.reportDe}");
	
	
	var codeList = new Array();
	<c:forEach items="${ EDC025 }" var="list">
	var obj = new Object();
	obj.code = "${ list.CODE }";
	obj.value = "${ list.VALUE }";
	codeList.push(obj);
	</c:forEach>

	fn_setCodeList(EDCJ0102_grid1, "dscntcResultCode", codeList);
	fn_setCodeList(EDCJ0102_grid2, "dscntcResultCode", codeList)

	codeList = new Array();
	<c:forEach items="${ EDC026 }" var="list">
	obj = new Object();
	obj.code = "${ list.CODE }";
	obj.value = "${ list.VALUE }";
	codeList.push(obj);
	</c:forEach>

	fn_setCodeList(EDCJ0102_grid1, "remdctResultCode", codeList);
	fn_setCodeList(EDCJ0102_grid2, "remdctResultCode", codeList)

	EDCJ0102_grid1.createGrid();
	EDCJ0102_grid2.createGrid();
	codeList = new Array();
	<c:forEach items="${ SDB012 }" var="list">
	obj = new Object();
	obj.code = "${ list.CODE }";
	obj.value = "${ list.VALUE }";
	codeList.push(obj);
	</c:forEach>

	fn_setCodeList(EDCJ0102_grid3, "hstcsCntncAt", codeList);

	EDCJ0102_grid3.createGrid();
	EDCJ0102_grid4.createGrid();
	
	codeList = new Array();
	obj = new Object();
	obj.code = "01";
	obj.value = "예";
	codeList.push(obj);
	obj = new Object();
	obj.code = "02";
	obj.value = "아니오";
	codeList.push(obj);

	fn_setCodeList(EDCJ0102_grid5, "aditInfoAt", codeList);
	
	EDCJ0102_grid5.createGrid();

	editMode(1);
});

// 윈도우 리사이징 이벤트
window.onresize = function() {
	if (typeof EDCJ0102_grid1.id !== "undefined") {
		AUIGrid.resize(EDCJ0102_grid1.id);
	}
	if (typeof EDCJ0102_grid2.id !== "undefined") {
		AUIGrid.resize(EDCJ0102_grid2.id);
	}
	if (typeof EDCJ0102_grid3.id !== "undefined") {
		AUIGrid.resize(EDCJ0102_grid3.id);
	}
	if (typeof EDCJ0102_grid4.id !== "undefined") {
		AUIGrid.resize(EDCJ0102_grid4.id);
	}
	if (typeof EDCJ0102_grid5.id !== "undefined") {
		AUIGrid.resize(EDCJ0102_grid5.id);
	}
};
//약물정보
var EDCJ0102_grid1 = {
	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
	id : '',
	//AUI그리드 생성할 div 및 페이징 옵션
	div : {
		gridDiv : '#EDCJ0102_grid1'
	},
	proxy : {
		url : './selectSaeRepDreAList.do',
		param : {},
		type : 'post',
		dataType : 'json',
		paging : false,
		autoLoad : false,
	},
	//AUI 그리드 옵션
	gridPros : {
		showRowNumColumn : true,
		showRowCheckColumn : false,
		enableColumnResize : true,
		enableMovingColumn : false,
		showStateColumn : true,
		editable : true,
		enableFilter : true,
		headerHeight : 40,
		rowHeight : 37,
		selectionMode : "singleRow"
	},
	columnLayout : [ {
		dataField : "subjectNo",
		headerText : "피험자 번호",
		visible : false
	}, {
		dataField : "insttFormSn",
		headerText : "기관 양식 순번",
		visible : false
	},{
		dataField : "saeReprtSn",
		headerText : "SAE 보고서 순번",
		visible : false
	},{
		dataField : "drfstfSeCode",
		headerText : "약물 순번",
		visible : false
	},{
		dataField : "drfstSeCode",
		headerText : "의심되는 약물(상품명/성분명/제조번호)",
	},{
		dataField : "ushap",
		headerText : "체형",
	},{
		dataField : "unit",
		headerText : "단위",
	}, {
		dataField : "dailcpcty",
		headerText : "일일용량",
	}, {
		dataField : "Usage",
		headerText : "용법",
	},{
		dataField : "mdctnCours",
		headerText : "투여경로"
	}, {
		dataField : "mdctnBeginDe",
		headerText : "약물투여기간-시작일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }
	}, {
		dataField : "mdctnEndDe",
		headerText : "약물투여기간-종료일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }
	}, {
		dataField : "dfme",
		headerText : "적응중"
	}, { 
		dataField : "dscntcResultCode",
		headerText : "사용중단/감량결과", //EDC025 : 사용중단/감량결과 코드
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver : true,
			list : null, //key-value Object 로 구성된 리스트
			keyField : "code", // key 에 해당되는 필드명
			valueField : "value" // value 에 해당되는 필드명
		},
		labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
			return fn_checkCodeList(this, value);
		},
		filter : {
			showIcon : true
		}
		
	}, {
		dataField : "remdctResultCode",
		headerText : "재투약결과", //EDC026 : 재투약 결과코드
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver : true,
			list : null, //key-value Object 로 구성된 리스트
			keyField : "code", // key 에 해당되는 필드명
			valueField : "value" // value 에 해당되는 필드명
		},
		labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
			return fn_checkCodeList(this, value);
		},
		filter : {
			showIcon : true
		}
	} ],
	//AUI 그리드 생성
	createGrid : function() {
		var me = this;
		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};

//기타병용약물
var EDCJ0102_grid2 = {
	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
	id : '',
	//AUI그리드 생성할 div 및 페이징 옵션
	div : {
		gridDiv : '#EDCJ0102_grid2',
	},
	proxy : {
		url : './selectSaeRepDreBList.do',
		param : {},
		type : 'post',
		dataType : 'json',
		paging : false,
		autoLoad : false,
	},
	//AUI 그리드 옵션
	gridPros : {
		showRowNumColumn : true,
		showRowCheckColumn : false,
		enableColumnResize : true,
		enableMovingColumn : false,
		showStateColumn : true,
		editable : true,
		enableFilter : true,
		headerHeight : 40,
		rowHeight : 37,
		selectionMode : "singleRow"
	},
	columnLayout : [ {
		dataField : "subjectNo",
		headerText : "피험자 번호",
		visible : false
	}, {
		dataField : "insttFormSn",
		headerText : "기관 양식 순번",
		visible : false
	},{
		dataField : "saeReprtSn",
		headerText : "SAE 보고서 순번",
		visible : false
	},{
		dataField : "drfstfSeCode",
		headerText : "약물 순번",
		visible : false
	},{
		dataField : "drfstSeCode",
		headerText : "의심되는 약물(상품명/성분명/제조번호)",
	},{
		dataField : "ushap",
		headerText : "체형",
	},{
		dataField : "unit",
		headerText : "단위",
	}, {
		dataField : "dailcpcty",
		headerText : "일일용량",
	}, {
		dataField : "usage",
		headerText : "용법",
	},{
		dataField : "mdctnCours",
		headerText : "투여경로"
	}, {
		dataField : "mdctnBeginDe",
		headerText : "약물투여기간-시작일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }		
	}, {
		dataField : "mdctnEndDe",
		headerText : "약물투여기간-종료일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }
	}, {
		dataField : "dfme",
		headerText : "적응중"
	}, {
		dataField : "dscntcResultCode", 
		headerText : "사용중단/감량결과", //EDC025 : 사용중단/감량결과 코드
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver : true,
			list : null, //key-value Object 로 구성된 리스트
			keyField : "code", // key 에 해당되는 필드명
			valueField : "value" // value 에 해당되는 필드명
		},
		labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
			return fn_checkCodeList(this, value);
		},
		filter : {
			showIcon : true
		}
	}, {
		dataField : "remdctResultCode",
		headerText : "재투약결과", //EDC026 : 재투약 결과코드
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver : true,
			list : null, //key-value Object 로 구성된 리스트
			keyField : "code", // key 에 해당되는 필드명
			valueField : "value" // value 에 해당되는 필드명
		},
		labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
			return fn_checkCodeList(this, value);
		},
		filter : {
			showIcon : true
		}
	} ],
	//AUI 그리드 생성
	createGrid : function() {
		var me = this;
		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};
//주요 병력 및 동반 질환
var EDCJ0102_grid3 = {
	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
	id : '',
	//AUI그리드 생성할 div 및 페이징 옵션
	div : {
		gridDiv : '#EDCJ0102_grid3',
	},
	proxy : {
		url : './selectSaeRepHstcsList.do',
		param : {},
		type : 'post',
		dataType : 'json',
		paging : false,
		autoLoad : false,
	},
	//AUI 그리드 옵션
	gridPros : {
		showRowNumColumn : true,
		showRowCheckColumn : false,
		enableColumnResize : true,
		enableMovingColumn : false,
		showStateColumn : true,
		editable : true,
		enableFilter : true,
		headerHeight : 40,
		rowHeight : 37,
		selectionMode : "singleRow"
	},
	columnLayout : [ {
		dataField : "subjectNo",
		headerText : "피험자 번호",
		visible : false
	}, {
		dataField : "insttFormSn",
		headerText : "기관 양식 순번",
		visible : false
	},{
		dataField : "saeReprtSn",
		headerText : "SAE 보고서 순번",
		visible : false
	},{
		dataField : "hstcsSn",
		headerText : "병력 순번",
		visible : false
	},{
		dataField : "hstcsNm",
		headerText : "질병/수술/기타"
	},{
		dataField : "hstcsBgnde",
		headerText : "시작일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }
	}, {
		dataField : "hstcsCntncAt",
		headerText : "지속 여부", // 예 아니오 알 수 없음
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver : true,
			list : null, //key-value Object 로 구성된 리스트
			keyField : "code", // key 에 해당되는 필드명
			valueField : "value" // value 에 해당되는 필드명
		},
		labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
			return fn_checkCodeList(this, value);
		},
		filter : {
			showIcon : true
		}
	}, {
		dataField : "hstcsEndde",
		headerText : "종료일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }
	}, {
		dataField : "hstcsOpinion",
		headerText : "의견"
	} ],
	//AUI 그리드 생성
	createGrid : function() {
		var me = this;
		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};

//이상약물반응 관련 약물 과거력
var EDCJ0102_grid4 = {
	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
	id : '',
	//AUI그리드 생성할 div 및 페이징 옵션
	div : {
		gridDiv : '#EDCJ0102_grid4',
	},
	proxy : {
		url : './selectSaeRepDreHstcsList.do',
		param : {},
		type : 'post',
		dataType : 'json',
		paging : false,
		autoLoad : false,
	},
	//AUI 그리드 옵션
	gridPros : {
		showRowNumColumn : true,
		showRowCheckColumn : false,
		enableColumnResize : true,
		enableMovingColumn : false,
		showStateColumn : true,
		editable : true,
		enableFilter : true,
		headerHeight : 40,
		rowHeight : 37,
		selectionMode : "singleRow"
	},
	columnLayout : [ {
		dataField : "subjectNo",
		headerText : "피험자 번호",
		visible : false
	}, {
		dataField : "insttFormSn",
		headerText : "기관 양식 순번",
		visible : false
	},{
		dataField : "saeReprtSn",
		headerText : "SAE 보고서 순번",
		visible : false
	},{
		dataField : "drfstfHstcsSn",
		headerText : "약물 병력 순번",
		visible : false
	},{
		dataField : "drfstfNm",
		headerText : "약물 명(보고된 대로)"
	},{
		dataField : "mdctnBeginDe",
		headerText : "투약시작일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }
	}, {
		dataField : "mdctnEndDe",
		headerText : "투약종료일", // 달력
		editRenderer: { type: "CalendarRenderer", 
						showEditorBtnOver: true, 
						onlyCalendar : true }
	}, {
		dataField : "dfme",
		headerText : "적응중"
	}, {
		dataField : "aet",
		headerText : "이상약물반응"
	} ],
	//AUI 그리드 생성
	createGrid : function() {
		var me = this;
		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};

// 원인 규명을 위한 검사 결과
var EDCJ0102_grid5 = {
	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
	id : '',
	//AUI그리드 생성할 div 및 페이징 옵션
	div : {
		gridDiv : '#EDCJ0102_grid5',
	},
	proxy : {
		url : './selectSaeRepInspctList.do',
		param : {},
		type : 'post',
		dataType : 'json',
		paging : false,
		autoLoad : false,
	},
	//AUI 그리드 옵션
	gridPros : {
		showRowNumColumn : true,
		showRowCheckColumn : false,
		enableColumnResize : true,
		enableMovingColumn : false,
		showStateColumn : true,
		editable : true,
		enableFilter : true,
		headerHeight : 40,
		rowHeight : 37,
		selectionMode : "singleRow"
	},
	columnLayout : [ {
		dataField : "subjectNo",
		headerText : "피험자 번호",
		visible : false
	}, {
		dataField : "insttFormSn",
		headerText : "기관 양식 순번",
		visible : false
	},{
		dataField : "saeReprtSn",
		headerText : "SAE 보고서 순번",
		visible : false
	},{
		dataField : "inspctResultSn",
		headerText : "검사 결과 순번",
		visible : false
	},{
		dataField : "inspctResultDe",
		headerText : "날짜", // 달력
		editRenderer: { type: "CalendarRenderer", 
								showEditorBtnOver: true, 
								onlyCalendar : true }
	},{
		dataField : "inspctKnd",
		headerText : "검사종류"
	}, {
		dataField : "inspctUnit",
		headerText : "단위"
	}, {
		dataField : "nrmltLwltNcl",
		headerText : "정상 하한치"
	}, {
		dataField : "nrmltUplmtNcl",
		headerText : "정상 상한치"
	}, {
		dataField : "inspctResult",
		headerText : "결과"
	}, {
		dataField : "aditInfoAt",
		headerText : "추가 정보 여부", // 라디오
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver : true,
			list : null, //key-value Object 로 구성된 리스트
			keyField : "code", // key 에 해당되는 필드명
			valueField : "value" // value 에 해당되는 필드명
		},
		labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
			return fn_checkCodeList(this, value);
		},
		filter : {
			showIcon : true
		}
	} ],
	//AUI 그리드 생성
	createGrid : function() {
		var me = this;
		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};


function addRow(val) {
	var item = {
	//	TASK_SN : $("#TASK_SN").val(),
	//	EDC_VER : $("#EDC_VER").val()
	};
	if(val == "1") AUIGrid.addRow(EDCJ0102_grid1.id, item, "last");
	if(val == "2") AUIGrid.addRow(EDCJ0102_grid2.id, item, "last");
	if(val == "3") AUIGrid.addRow(EDCJ0102_grid3.id, item, "last");
	if(val == "4") AUIGrid.addRow(EDCJ0102_grid4.id, item, "last");
	if(val == "5") AUIGrid.addRow(EDCJ0102_grid5.id, item, "last");
}

function removeRow(val) {
	if(val == "1") AUIGrid.removeRow(EDCJ0102_grid1.id, "selectedIndex");
	if(val == "2") AUIGrid.removeRow(EDCJ0102_grid2.id, "selectedIndex");
	if(val == "3") AUIGrid.removeRow(EDCJ0102_grid3.id, "selectedIndex");
	if(val == "4") AUIGrid.removeRow(EDCJ0102_grid4.id, "selectedIndex");
	if(val == "5") AUIGrid.removeRow(EDCJ0102_grid5.id, "selectedIndex");
}

function fnSave() {
	if(!confirm('저장 하시겠습니까?')) {
		return;
	}
	var param = new Object();
	param.base = JSON.stringify(fn_serializeObject($("#regForm")));

	var arJson = new Array();
	var rowItems = AUIGrid.getAddedRowItems(EDCJ0102_grid1.id);
	fn_makeArr(arJson, rowItems, "C");
	rowItems = AUIGrid.getEditedRowItems(EDCJ0102_grid1.id);
	fn_makeArr(arJson, rowItems, "U");
	rowItems = AUIGrid.getRemovedItems(EDCJ0102_grid1.id);
	fn_makeArr(arJson, rowItems, "D");
	if (arJson.length > 0) {
		param.saeRepDreAList = JSON.stringify(arJson);
	}

	arJson = new Array();
	rowItems = AUIGrid.getAddedRowItems(EDCJ0102_grid2.id);
	fn_makeArr(arJson, rowItems, "C");
	rowItems = AUIGrid.getEditedRowItems(EDCJ0102_grid2.id);
	fn_makeArr(arJson, rowItems, "U");
	rowItems = AUIGrid.getRemovedItems(EDCJ0102_grid2.id);
	fn_makeArr(arJson, rowItems, "D");
	if (arJson.length > 0) {
		param.saeRepDreBList = JSON.stringify(arJson)
	}
	
	arJson = new Array();
	rowItems = AUIGrid.getAddedRowItems(EDCJ0102_grid3.id);
	fn_makeArr(arJson, rowItems, "C");
	rowItems = AUIGrid.getEditedRowItems(EDCJ0102_grid3.id);
	fn_makeArr(arJson, rowItems, "U");
	rowItems = AUIGrid.getRemovedItems(EDCJ0102_grid3.id);
	fn_makeArr(arJson, rowItems, "D");
	if (arJson.length > 0) {
		param.saeRepHstcsList = JSON.stringify(arJson)
	}
	
	arJson = new Array();
	rowItems = AUIGrid.getAddedRowItems(EDCJ0102_grid4.id);
	fn_makeArr(arJson, rowItems, "C");
	rowItems = AUIGrid.getEditedRowItems(EDCJ0102_grid4.id);
	fn_makeArr(arJson, rowItems, "U");
	rowItems = AUIGrid.getRemovedItems(EDCJ0102_grid4.id);
	fn_makeArr(arJson, rowItems, "D");
	if (arJson.length > 0) {
		param.saeRepDreHstcsList = JSON.stringify(arJson)
	}
	
	arJson = new Array();
	rowItems = AUIGrid.getAddedRowItems(EDCJ0102_grid5.id);
	fn_makeArr(arJson, rowItems, "C");
	rowItems = AUIGrid.getEditedRowItems(EDCJ0102_grid5.id);
	fn_makeArr(arJson, rowItems, "U");
	rowItems = AUIGrid.getRemovedItems(EDCJ0102_grid5.id);
	fn_makeArr(arJson, rowItems, "D");
	if (arJson.length > 0) {
		param.saeRepInspctList = JSON.stringify(arJson)
	}
	
	$.ajax({
		url : './insertSaeRep.do',
		data : param,
		type : 'post',
		//contentType : "application/json; charset=UTF-8",
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				location.reload();
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
}

function fnList(){
	$("#regForm").attr({
		action : './EDCJ0101.do',
		method : 'post'
	}).submit();
}

function editMode(c) {
	if (c == 1) {
		mkDisabled(); //컨트롤 비활성화
		// $("button").hide();
		$("input[type=button]").hide();
		$(".ui-datepicker-trigger").hide();
		$("#btn_edit").show();
	} else {
		mkEnabled(); //컨트롤 활성화
		// $("button").show();
		$("input[type=button]").show();
		$(".ui-datepicker-trigger").show();
		$("#btn_edit").hide();
	}
}

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCJ0102&&UPPER_MENU_ID=EDCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCJ0102&&UPPER_MENU_ID=EDCJ" charEncoding="utf-8"/>

	<form name="regForm" id="regForm">
		<input type="hidden" name="subjectNo" id="subjectNo" value="${result.subjectNo}">
		<input type="hidden" name="insttFormSn" id="insttFormSn" value="${result.insttFormSn}">
		<input type="hidden" name="saeReprtSn" id="saeReprtSn" value="${result.saeReprtSn}">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>이상반응 신속보고 작성</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>REPORT</li>
							<li>이상반응 신속보고 작성</li>
						</ul>
					</nav>
				</article>


	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
						<article class="conTitBtnR">
						
	                        <input type="button" class="" id="btn_edit" onclick="editMode(2);" value="수정">
                            <input type="button" class="" onclick="fnSave()" value="저장">
                            <input type="button" class="" onclick="fnList()" value="목록">
	                    </article>
						<article class="mgT16">
							<h6>보고서정보</h6>
							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="38%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>보고 담당자</th>
										<td><input type="text" name="reportrNm" id="reportrNm" value='<c:out value="${result.reportrNm}"/>' style="width:100%;"able /></td>
										<th>전화</th>
										<td><input type="text" name="reportrTlphon" id="reportrTlphon" value='<c:out value="${result.reportrTlphon}"/>' style="width:100%;"able /></td>
									</tr>
									<tr>
										<th>팩스</th>
										<td><input type="text" name="reportrFax" id="reportrFax" value='<c:out value="${result.reportrFax}"/>' style="width:100%;"able /></td>
										<th>e-mail</th>
										<td><input type="text" name="reportrEmail" id="reportrEmail" value='<c:out value="${result.reportrEmail}"/>' style="width:100%;"able /></td>
									</tr>
									<tr>
										<th>피보험자등록번호/식별번호</th>
										<td colspan="3"><input type="text" name="subjectNo" id="subjectNo" value='<c:out value="${result.subjectNo}"/>' style="width:100%;" disabled="disabled" /></td>
									</tr>
									<tr>
										<th>임상시험 계획서 최초승인번호</th>
										<td><input type="text" name="confmOfcdocuNo" id="confmOfcdocuNo" value='<c:out value="${result.confmOfcdocuNo}"/>' style="width:100%;"able /></td>
										<th>일련번호</th>
										<td><input type="text" name="ofcdocuSeqNo" id="ofcdocuSeqNo" value='<c:out value="${result.ofcdocuSeqNo}"/>' style="width:100%;"able /></td>
									</tr>
									<tr>
										<th>보고 분류</th>
										<td>
											<c:forEach items="${ EDC028 }" var="list" varStatus="status">
												<input type="radio" id="reportClCode${ status.count }" name="reportClCode" value="${ list.CODE }" <c:if test="${ list.CODE == result.reportClCode}">checked="checked"</c:if> able>
												<label for="reportClCode${ status.count }" class="raLab" ><span>${ list.VALUE }</span></label>
											</c:forEach>
											
											<!-- <input type="radio" id="reportClCode" name="reportClCode" value="" ><label for="reportClCode" class="raLab" ><span>라디오버튼1</span></label> -->
										</td>
										<th>조회/최근 보고일</th>
										<td><div class="dateBox"><input type="text" name="reportDe" id="reportDe" value='<c:out value="${result.reportDe}"/>' style="width:100%;" able /></div></td>
									</tr>
								</tbody>
							</table>
							
							<h6 style="margin-top:20px;">시험대상자 정보</h6>
							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="38%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>시험대상자 성명 약자</th>
										<td><input type="text" name="subjectInitial" id="subjectInitial" value='<c:out value="${result.subjectInitial}"/>' style="width:100%;" disabled="disabled" /></td>
										<th>성별</th>
										<td>
											<c:forEach items="${ SDB045 }" var="list" varStatus="status">
												<input type="radio" id="subjectSexdstn${ status.count }" name="subjectSexdstn" value="${ list.CODE }" <c:if test="${ list.CODE == result.subjectSexdstn}">checked="checked"</c:if> disabled="disabled">
												<label for="subjectSexdstn${ status.count }" class="raLab" ><span>${ list.VALUE }</span></label>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th>생년월일</th>
										<td><div class="dateBox"><input type="text" name="subjectLifyeamd" id="subjectLifyeamd" value='<c:out value="${result.subjectLifyeamd}"/>' style="width:100%;" disabled="disabled" /></div></td>
										<th>나이</th>
										<td><input type="text" name="subjectAge" id="subjectAge" value='<c:out value="${result.subjectAge}"/>' style="width:100%;" disabled="disabled" /></td>
									</tr>
									<tr>
										<th>키</th>
										<td><input type="text" name="subjectHeight" id="subjectHeight" value='<c:out value="${result.subjectHeight}"/>' style="width:100%;" disabled="disabled"/></td>
										<th>몸무게</th>
										<td><input type="text" name="subjectBdwgh" id="subjectBdwgh" value='<c:out value="${result.subjectBdwgh}"/>' style="width:100%;" disabled="disabled"/></td>
									</tr>
									<tr>
										<th>진료구분</th>
										<td colspan="3">
											<c:forEach items="${ EDC029 }" var="list" varStatus="status">
												<input type="radio" id="subjectClnicCode${ status.count }" name="subjectClnicCode" value="${ list.CODE }" <c:if test="${ list.CODE == result.subjectClnicCode}">checked="checked"</c:if> able>
												<label for="subjectClnicCode${ status.count }" class="raLab" ><span>${ list.VALUE }</span></label>
											</c:forEach>
										
											<input type="text" name="subjectClnicEtc" id="subjectClnicEtc" value='<c:out value="${result.subjectClnicEtc}"/>' style="width:80%; float:right;" able /></td>
									</tr>
									<tr>
										<th>임신여부</th>
										<td>
											<input type="radio" id="pregnanAt1" name="pregnanAt" value="Y" <c:if test="${ result.pregnanAt == Y}">checked="checked"</c:if> able>
											<label for="pregnanAt1" class="raLab" ><span>예</span></label>
											<input type="radio" id="pregnanAt2" name="pregnanAt" value="N" <c:if test="${ result.pregnanAt == N}">checked="checked"</c:if> able>
											<label for="pregnanAt2" class="raLab" ><span>아니오</span></label>
										</td>
										<th>임신기간</th>
										<td><input type="text" name="pregnanPd" id="pregnanPd" value='<c:out value="${result.pregnanPd}"/>' style="width:100%;" able /></td>
									</tr>
									<tr>
										<th>마지막월경일</th>
										<td colspan="3"><div class="dateBox"><input type="text" name="lastMenseDe" id="lastMenseDe" value='<c:out value="${result.lastMenseDe}"/>' style="width:100%;" able /></div></td>
									</tr>
								</tbody>
							</table>
							
							<h6 style="margin-top:20px;">이상약물반응</h6>
							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="38%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>이상약물반응명</th>
										<td><input type="text" name="aetNm" id="aetNm" value='<c:out value="${aetResult.aetNm}"/>' style="width:100%;" disabled="disabled" /></td>
										<th>시작일</th>
										<td><div class="dateBox"><input type="text" name="aetBeginDe" id="aetBeginDe" value='<c:out value="${aetResult.aetBeginDe}"/>' style="width:100%;"  /></div></td>
									</tr>
									<tr>
										<th>종료일</th>
										<td><div class="dateBox"><input type="text" name="aetEndDe" id="aetEndDe" value='<c:out value="${aetResult.aetEndDe}"/>' style="width:100%;"  /></div></td>
										<th>의심되는 약물과의 관계</th>
										<td>
											<select id="drfstfRelateCode" tabindex="2" valireqire="Study Type" style="width:70%;">
												<option value="">====선택====</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>약물에 대한 처치</th>
										<td>
											<select id="drfstfMdlrtCode" tabindex="2" valireqire="Study Type" style="width:70%;">
												<option value="">====선택====</option>
											</select>
										</td>
										<th>최종관찰결과</th>
										<td>
											<select id="lastObservResultCode" tabindex="2" valireqire="Study Type" style="width:70%;">
												<option value="">====선택====</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>이상약물반응의 결과(중대성:Seriousness)</th>
										<td colspan="3">
											<c:forEach items="${ EDC023 }" var="list" varStatus="status">
												<input type="checkbox" id="aetResultCode${ status.count }" name="aetResultCode" value="${ list.CODE }" <c:if test="${ list.CODE == aetResult.aetResultCode}">checked="checked"</c:if> able>
												<label for="aetResultCode${ status.count }" class="raLab" ><span>${ list.VALUE }</span></label>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th>시험대상자 사망</th>
										<td>
											<input type="radio" name="deathAt" id="deathAt1" value="Y" <c:if test="${ Y == result.deathAt}">checked="checked"</c:if> able>
											<label for="deathAt1" class="raLab" ><span>예</span></label>
											<input type="radio" name="deathAt" id="deathAt2" value="Y" <c:if test="${ N == result.deathAt}">checked="checked"</c:if> able>
											<label for="deathAt2" class="raLab" ><span>아니오</span></label>
										</td>
										<th>사망일</th>
										<td><div class="dateBox"><input type="text" name="deathDe" id="deathDe" value='<c:out value="${result.deathDe}"/>' style="width:100%;" able /></div></td>
									</tr>
									<tr>
										<th>보고된 사망원인</th>
										<td><input type="text" name="deathCause" id="deathCause" value='<c:out value="${result.deathCause}"/>' style="width:100%;" able /></td>
										<th>부검여부</th>
										<td>
											<input type="radio" name="atpsyAt" id="atpsyAt1" value="Y" <c:if test="${ Y == result.atpsyAt}">checked="checked"</c:if> able>
											<label for="atpsyAt1" class="raLab" ><span>예</span></label>
											<input type="radio" name="atpsyAt" id="atpsyAt2" value="N" <c:if test="${ N == result.atpsyAt}">checked="checked"</c:if> able>
											<label for="atpsyAt2" class="raLab" ><span>아니오</span></label>
											<input type="radio" name="atpsyAt" id="atpsyAt3" value="U" <c:if test="${ U == result.atpsyAt}">checked="checked"</c:if> able>
											<label for="atpsyAt3" class="raLab" ><span>알 수 없음</span></label>
										</td>
									</tr>
								</tbody>
							</table>
						</article>
	                </div>
	            </section>

	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
	                    <article class="conTitBox">
	                        <h5>약물정보</h5>
	                    </article>

	                    <article class="conTitBtnR">
	                        <input type="button" class="add_01" onclick="addRow('1')" value="행추가">
                            <input type="button" class="del_01" onclick="removeRow('1')" value="행삭제">
	                    </article>

						<article class="mgT16">
							<div id="EDCJ0102_grid1" class="gridHeiSz03 grid_wrap tb01_2"></div>
						</article>
	                </div>
	            </section>

	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
	                    <article class="conTitBox">
	                        <h5>기타병용약물</h5>
	                    </article>

	                    <article class="conTitBtnR">
	                        <input type="button" class="add_01" onclick="addRow('2')" value="행추가">
                            <input type="button" class="del_01" onclick="removeRow('2')" value="행삭제">
	                    </article>

						<article class="mgT16">
							<div id="EDCJ0102_grid2" class="gridHeiSz03 grid_wrap tb01_2"></div>
						</article>
	                </div>
	            </section>

	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
	                    <article class="conTitBox">
	                        <h5>주요 병력 및 동반 질환</h5>
	                    </article>

	                    <article class="conTitBtnR">
	                        <input type="button" class="add_01" onclick="addRow('3')" value="행추가">
                            <input type="button" class="del_01" onclick="removeRow('3')" value="행삭제">
	                    </article>

						<article class="mgT16">
							<div id="EDCJ0102_grid3" class="gridHeiSz03 grid_wrap tb01_2"></div>
						</article>
	                </div>
	            </section>

	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
	                    <article class="conTitBox">
	                        <h5>이상약물반응 관련 약물 과거력</h5>
	                    </article>

	                    <article class="conTitBtnR">
	                        <input type="button" class="add_01" onclick="addRow('4')" value="행추가">
                            <input type="button" class="del_01" onclick="removeRow('4')" value="행삭제">
	                    </article>

						<article class="mgT16">
							<div id="EDCJ0102_grid4" class="gridHeiSz03 grid_wrap tb01_2"></div>
						</article>
	                </div>
	            </section>

	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
	                    <article class="conTitBox">
	                        <h5>원인규명을 위한 검사 결과</h5>
	                    </article>

	                    <article class="conTitBtnR">
	                        <input type="button" class="add_01" onclick="addRow('5')" value="행추가">
	                        <input type="button" class="del_01" onclick="removeRow('5')" value="행삭제">
	                    </article>

						<article class="mgT16">
							<div id="EDCJ0102_grid5" class="gridHeiSz03 grid_wrap tb01_2"></div>
						</article>
	                </div>
	            </section>

	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
						<article>
							<h6>종례기술, 추가 정보 또는 보고자의 의견</h6>
							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>종례기술</th>
										<td><input type="text" name="caseTchnlgy" id="caseTchnlgy" value='<c:out value="${result.caseTchnlgy}"/>' style="width:100%;" able /></td>
									</tr>
									<tr>
										<th>추가정보</th>
										<td><input type="text" name="aditInfo" id="aditInfo" value='<c:out value="${result.aditInfo}"/>' style="width:100%;" able /></td>
									</tr>
									<tr>
										<th>보고자의 의견</th>
										<td><input type="text" name="reportrOpinion" id="reportrOpinion" value='<c:out value="${result.reportrOpinion}"/>' style="width:100%;" able /></td>
									</tr>
								</tbody>
							</table>
							
							<h6 style="margin-top:20px;">정보 제공자(임상시험 책임자)</h6>
							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="38%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>이름</th>
										<td><input type="text" name="infoOfferNm" id="infoOfferNm" value='<c:out value="${result.infoOfferNm}"/>' style="width:100%;" disabled="disabled" /></td>
										<th>직위</th>
										<td><input type="text" name="infoOfferOfcps" id="infoOfferOfcps" value='<c:out value="${result.infoOfferOfcps}"/>' style="width:100%;" able /></td>
									</tr>
									<tr>
										<th>전공분야</th>
										<td><input type="text" name="infoOfferMajor" id="infoOfferMajor" value='<c:out value="${result.infoOfferMajor}"/>' style="width:100%;" able /></td>
										<th>기관명</th>
										<td><input type="text" name="infoOfferInstt" id="infoOfferInstt" value='<c:out value="${result.infoOfferInstt}"/>' style="width:100%;" disabled="disabled" /></td>
									</tr>
									<tr>
										<th>전화</th>
										<td><input type="text" name="infoOfferTlphon" id="infoOfferTlphon" value='<c:out value="${result.infoOfferTlphon}"/>' style="width:100%;" able /></td>
										<th>팩스</th>
										<td><input type="text" name="infoOfferFax" id="infoOfferFax" value='<c:out value="${result.infoOfferFax}"/>' style="width:100%;" able /></td>
									</tr>
									<tr>
										<th>주소</th>
										<td><input type="text" name="infoOfferAdres" id="infoOfferAdres" value='<c:out value="${result.infoOfferAdres}"/>' style="width:100%;" able /></td>
										<th>전자우편주소</th>
										<td><input type="text" name="infoOfferEmail" id="infoOfferEmail" value='<c:out value="${result.infoOfferEmail}"/>' style="width:100%;" disabled="disabled" /></td>
									</tr>
								</tbody>
							</table>
							
						</article>
	                </div>
	            </section>

<style>
/*
input[type="button"] {padding:0 15px 0 15px; border-radius: 2.5px; height:28px; outline:0; border:0; color:#fff; background:#6e85e9; transition-duration:1s; font-size: 12px; line-height: 28px; font-family:'NanumGothic'; cursor: pointer;}
input[type="button"]:hover {background:#4c55a4; transition-duration:1s;}
*/


.add_01 { text-indent:-1000px; white-space:nowrap; overflow:hidden; background:url(/images/pantheon/common/btns_01.png) no-repeat 7px 7px #6e85e9 !important; }
.add_01:hover {background-color:#4c55a4 !important; transition-duration:1s;}
.del_01 { text-indent:-1000px; white-space:nowrap; overflow:hidden; background:url(/images/pantheon/common/btns_01.png) no-repeat 7px -39px #6e85e9 !important;}
.del_01:hover {background-color:#4c55a4 !important; transition-duration:1s;}


</style>



			</div>
		</section>

	</form>



</div>
</body>
</html>