<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>
<title>공통코드</title>

<script type="text/javascript">

var grTbMenu = null;
var grTbMenuProgram = null;

$(function(){
	
	grTbMenu = new ax5.ui.grid();
	grTbMenu.getSelectionRowIndex = 0;
	grTbMenu.selectionItems = 0;
	
	grTbMenu.load = function() {
		$.ajax({
			url : _contextPath + "/com/role/selectTbMenuListForRoleCombine.do",
			type: "post",
			success : function(data) {
				if(data.success) {
					grTbMenu.setData(data.result);
					
					if(data.result.length && !grTbMenuProgram.getList().length){
						
						grTbMenu.getSelectionRowIndex = 0;
						grTbMenu.getSelectionItem = data.result[0];
						
						grTbMenuProgram.load({"GROUP_CD" : data.result[0]["GROUP_CD"]});
						
					}
					
				} else {
					alert(data.message);
				}
			},
    		error : function(jqXHR, textStatus, errorThrown){
    				alert(textStatus);
    		}
		});
		
	};

	/* 그리드 설정 지정 */
	grTbMenu.setConfig({
		target: $('[data-ax5grid="grTbMenu"]'),
		header: {align: 'center'},
		
		showLineNumber: false,
		
		body: {
			onClick: function(){
				grTbMenu.getSelectionRowIndex = this.doindex;
				grTbMenu.getSelectionItem = this.item;
				grTbMenuProgram.load({"GROUP_CD" : this.item["GROUP_CD"]});
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbMenu.getSelectionRowIndex = this.doindex;
				grTbMenu.getSelectionItem = this.item;
				
				/*
				if(!grTbMenu.getSelectionItem["CRUD"]) {
					grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"CRUD": "U"}), grTbMenu.getSelectionRowIndex);
				}
				
				if(this.value) {
					grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"GROUP_CD": this.value.toUpperCase()}), grTbMenu.getSelectionRowIndex);
				}
				
				//컬럼 유효성 체크
				if(this.key == "GROUP_CD") {
					
					//길이체크
					if(_vGrValidation.lengthCheck(this.value, 3)
							//영문자숫자체크
							&& _vGrValidation.engNumcheck(this.value)
							//중복체크
							&& _vGrValidation.pkCheck(grTbMenu, "GROUP_CD")){
						
						grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"GROUP_CD": this.value.toUpperCase()}), grTbMenu.getSelectionRowIndex);
						
					} else {
						
						grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"GROUP_CD": ""}), grTbMenu.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "CD_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"CD_DC": ""}), grTbMenu.getSelectionRowIndex);
					} 
					
				}
				*/
				
			}
		},
		columns: [{
			key: "",
			label: "",
			align: "center",
			width: 50,
			enableFilter: true,
            styleClass: function () {
            	
            	if(this.item.CRUD === "C") {
            		return "grid-cell-green";
            	} else if(this.item.CRUD === "U") {
            		return "grid-cell-blue";
            	} else if(this.item.CRUD === "D") {
            		return "grid-cell-red";
            	}
            	
            }
		},{
			key: "CRUD",
			label: "",
			align: "center",
			width: 0,
			enableFilter: true,
			hidden: true
		},{
			key: "UP_MENU_NM",
			label: "상위메뉴이름",
			align: "center",
			width: 200,
			enableFilter: true
		},{
			key: "MENU_NM",
			label: "메뉴이름",
			align: "center",
			width: 200,
			enableFilter: true
		},{
			key: "MENU_ID",
			label: "메뉴아이디",
			align: "center",
			width: 150,
			enableFilter: true,
			hidden: true
		}]
	
	});
	
	grTbMenuProgram = new ax5.ui.grid();
	
	grTbMenuProgram.getSelectionRowIndex = 0;
	grTbMenuProgram.selectionItems = 0;
	grTbMenuProgram.load = function(vParam) {
		
		$.ajax({
			url : _contextPath + "/com/code/selectTbMenuProgramList.do",
			type: 'post',
			dataType: 'json',
			data:vParam,
			success : function(data) {
				if(data.success) {
					grTbMenuProgram.setData(data.result);
				} else {
					alert(data.message);
				}
			},
    		error : function(jqXHR, textStatus, errorThrown){
    				alert(textStatus);
    		}
		});
		
	};
	
	
	/* 그리드 설정 지정 */
	grTbMenuProgram.setConfig({
		target: $('[data-ax5grid="grTbMenuProgram"]'),
		header: {align: 'center'},
		
		showLineNumber: false,
		
		body: {
			onClick: function(){
				
				grTbMenuProgram.getSelectionRowIndex = this.doindex;
				grTbMenuProgram.getSelectionItem = this.item;
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbMenuProgram.getSelectionRowIndex = this.doindex;
				grTbMenuProgram.getSelectionItem = this.item;
				
				if(!grTbMenuProgram.getSelectionItem["CRUD"]) {
					grTbMenuProgram.updateRow($.extend({}, grTbMenuProgram.list[grTbMenuProgram.getSelectionRowIndex], {"CRUD": "U"}), grTbMenuProgram.getSelectionRowIndex);
				}
				
				if(this.value) {
					grTbMenuProgram.updateRow($.extend({}, grTbMenuProgram.list[grTbMenuProgram.getSelectionRowIndex], {"DETAIL_CD": this.value.toUpperCase()}), grTbMenuProgram.getSelectionRowIndex);
				}
				
				//컬럼 유효성 체크
				if(this.key == "DETAIL_CD") {
					
					//길이체크
					if(_vGrValidation.lengthCheck(this.value, 3)
							//영문자숫자체크
							&& _vGrValidation.engNumcheck(this.value)
							//중복체크
							&& _vGrValidation.pkCheck(grTbMenuProgram, "DETAIL_CD")){
						
						grTbMenuProgram.updateRow($.extend({}, grTbMenuProgram.list[grTbMenuProgram.getSelectionRowIndex], {"DETAIL_CD": this.value.toUpperCase()}), grTbMenuProgram.getSelectionRowIndex);
						
					} else {
						
						grTbMenuProgram.updateRow($.extend({}, grTbMenuProgram.list[grTbMenuProgram.getSelectionRowIndex], {"DETAIL_CD": ""}), grTbMenuProgram.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "CD_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbMenuProgram.updateRow($.extend({}, grTbMenuProgram.list[grTbMenuProgram.getSelectionRowIndex], {"CD_DC": ""}), grTbMenuProgram.getSelectionRowIndex);
					} 
					
				}
				
			}
		},
		columns: [{
			key: "",
			label: "",
			align: "center",
			width: 50,
			enableFilter: true,
            styleClass: function () {
            	
            	if(this.item.CRUD === "C") {
            		return "grid-cell-green";
            	} else if(this.item.CRUD === "U") {
            		return "grid-cell-blue";
            	} else if(this.item.CRUD === "D") {
            		return "grid-cell-red";
            	}
            	
            }
		},{
			key: "CRUD",
			label: "",
			align: "center",
			width: 0,
			enableFilter: true,
			hidden: true
		},{
			key: "GROUP_CD",
			label: "*그룹코드",
			align: "center",
			width: 100,
			enableFilter: true
		},{
			key: "DETAIL_CD",
			label: "*코드",
			align: "center",
			width: 100,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "CD_DC",
			label: "코드설명",
			align: "center",
			width: 250,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "CD_SEQ",
			label: "순서",
			align: "center",
			width: 50,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "USE_YN",
			label: "사용여부",
			type: "checkbox",
			align: "center",
			width: 100,
			enableFilter: true,
			editor: {
				type: "checkbox", config: {height: 17, trueValue: "Y", falseValue: "N"}
			}
		},{
			key: "UP_DT", 
			label: "수정일", 
			formatter: "date", 
			align: "center",
			enableFilter: true,
			width: 150,
			enableFilter: true
		}]
	
	});
    
    $("#btnSelectTbGroupCode").click(function(){
    	grTbMenu.load();
    });
    
    $("#btnTbMenuProgramMultiSave").click(function(){
    	
    	var vValidateJson = {
			"DETAIL_CD": "상세코드는 필수입력해주십시오."
		};
    	
    	fn_GridMultiSaveForValidateArray(
				grTbMenuProgram
				,"/com/code/multiTbMenuProgram.do"
				,vValidateJson
				,[]
				,""
				,""
				,{"GROUP_CD":grTbMenu.getSelectionItem["GROUP_CD"]});
    	
    });
    
    $("#btnSelectTbGroupCode").trigger("click");
    
});
</script>
</head>

<body>

<!-- <div style="padding: 10px;"> -->
<!-- 	<button class="btn btn-default" id="btnSelectTbGroupCode">조회</button> -->
<!--     <button class="btn btn-default" data-grid-control="btnAddTbGroupCode">행추가</button> -->
<!--     <button class="btn btn-default" data-grid-control="btnRemoveTbGroupCode">행삭제</button> -->
<!--     <button class="btn btn-default" id="btnMultiSaveTbGroupCode">저장</button> -->
<!-- </div> -->

<div data-ax5grid="grTbMenu" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>

<div style="padding: 10px;">
    <button class="btn btn-default" data-grid-control="btnAddTbMenuProgram">메뉴넣기</button>
    <button class="btn btn-default" data-grid-control="btnRemoveTbMenuProgram">메뉴삭제</button>
    <button class="btn btn-default" id="btnTbMenuProgramMultiSave">저장</button>
</div>

<div style="padding: 10px;">
	권한: <select>ㅎㅎ</select> 
</div>

<div data-ax5grid="grTbMenuProgram" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>

</body>
</html>