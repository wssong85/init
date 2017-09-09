<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>
<title>역할결합관리</title>

<script type="text/javascript">

function loadCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.ROLE + ">" + this.ROLE_NM + "</option> ";
	});

	target.append(dataArr);
}

var grTbMenu = null;
var grTbMenuProgram = null;

$(function(){
	
	$.ajax({
		url : _contextPath + "/com/role/selectTbRolesList.do",
		success : function(data) {
			loadCombo($("#selectRoles"), data.result);
            $("#selectRoles").val("");
		}
	});
	
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
		
		showLineNumber: true,
		showRowSelector: true,
		lineNumberColumnWidth: 40,
		rowSelectorColumnWidth: 25,
		
		body: {
			onClick: function(){
				grTbMenu.getSelectionRowIndex = this.doindex;
				grTbMenu.getSelectionItem = this.item;
				
			},
			onDBLClick: function(){
				
				if(!$('#selectRoles option:selected').val()) {
	    			alert("권한을 선택해 주십시오.");
	    			return;
	    		}
				
				var vAddItem = {
// 	            		"CRUD": "C"
	            		"ROLE": $('#selectRoles option:selected').val()
	            		,"MENU_ID": grTbMenu.getList()[grTbMenu.getSelectionRowIndex]["MENU_ID"]
	            		,"MENU_NM": grTbMenu.getList()[grTbMenu.getSelectionRowIndex]["MENU_NM"]
	            		,"UP_MENU_NM": grTbMenu.getList()[grTbMenu.getSelectionRowIndex]["UP_MENU_NM"]
				};
				
				grTbMenuProgram.addRow($.extend({}, vAddItem, {__index: undefined}));
				
				if(!_vGrValidation.pkCheck(grTbMenuProgram, "MENU_ID")) {
					alert("중복된 메뉴입니다.");
					grTbMenuProgram.removeRow(0);
					return;
				}
				
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
			url : _contextPath + "/com/role/selectTbMenuProgramListByRole.do",
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
		
		showLineNumber: true,
		showRowSelector: true,
		lineNumberColumnWidth: 40,
		rowSelectorColumnWidth: 25,

		body: {
			onClick: function(){
				
				grTbMenuProgram.getSelectionRowIndex = this.doindex;
				grTbMenuProgram.getSelectionItem = this.item;
				
			},
			onDBLClick: function(){
				
				if(!$('#selectRoles option:selected').val()) {
	    			alert("권한을 선택해 주십시오.");
	    			return;
	    		}
				
				grTbMenuProgram.removeRow(grTbMenuProgram.getSelectionRowIndex);
				
			},
			onDataChanged: function(){
				
				grTbMenuProgram.getSelectionRowIndex = this.doindex;
				grTbMenuProgram.getSelectionItem = this.item;
				
			}
		},
		columns: [{
			key: "ROLE",
			label: "역할",
			align: "center",
			width: 100,
			enableFilter: true
		},{
			key: "MENU_ID",
			label: "메뉴아이디",
			align: "center",
			width: 100,
			enableFilter: true,
			hidden: true
		},{
			key: "UP_MENU_NM",
			label: "상위메뉴이름",
			align: "center",
			width: 100,
			enableFilter: true
		},{
			key: "MENU_NM",
			label: "메뉴이름",
			align: "center",
			width: 100,
			enableFilter: true
		}]
	
	});
    
    $("#btnSelectTbGroupCode").click(function(){
    	grTbMenu.load();
    });
    
    $("#btnTbMenuProgramMultiSave").click(function(){
    	
    	if(!grTbMenuProgram.getList().length) {
    		alert("저장할 역할이 없습니다.");
    		return;
    	}
    	
    	var vValidateJson = {
			"ROLE": "역할이 없습니다."
			,"MENU_ID": "메뉴아이디가 없습니다."
		};
    	
    	fn_GridMultiSaveForValidateArray2(
				grTbMenuProgram
				,"/com/role/insertTbMenuProgramForAll.do"
				,vValidateJson
				,[]
				,""
				,""
				,{"ROLE":$('#selectRoles option:selected').val()});
    	
    });
    
    $("#selectRoles").change(function(){
    	
		if($('#selectRoles option:selected').val()) {
			
			grTbMenuProgram.load({"ROLE": $('#selectRoles option:selected').val()});
			
		}
    	
    });
    
    $('[data-grid-control]').click(function () {
    	switch (this.getAttribute("data-grid-control")) {
    	
    	case "btnAddTbMenuProgram":
    		
    		if(!$('#selectRoles option:selected').val()) {
    			alert("권한을 선택해 주십시오.");
    			return;
    		}
    		
    		for(var i = 0; i < grTbMenu.getList("selected").length; i++) {
    			
    			if(!$('#selectRoles option:selected').val()) {
        			alert("권한을 선택해 주십시오.");
        			return;
        		}
    			
    			var vAddItem = {
// 	            		"CRUD": "C"
	            		"ROLE": $('#selectRoles option:selected').val()
	            		,"MENU_ID": grTbMenu.getList("selected")[i]["MENU_ID"]
	            		,"MENU_NM": grTbMenu.getList("selected")[i]["MENU_NM"]
	            		,"UP_MENU_NM": grTbMenu.getList("selected")[i]["UP_MENU_NM"]
				};
	        	
        		grTbMenuProgram.addRow($.extend({}, vAddItem, {__index: undefined}));
        		
    		}

    		break;
    		
    	case "btnRemoveTbMenuProgram":
    	
    		if(!$('#selectRoles option:selected').val()) {
    			alert("권한을 선택해 주십시오.");
    			return;
    		}

			for(var i = 0; i < grTbMenuProgram.getList("selected").length; i++) {
				grTbMenuProgram.removeRow(grTbMenuProgram.getList("selected")[i].__index);
    		}
    		
    		break;
    	
    	}
    	
    });
    
    grTbMenu.load();
});
</script>
</head>

<body>


<div id="wrapper">
	<c:import url="/common/leftMenu.do" charEncoding="utf-8"/>
	
	<div id="page-content-wrapper">
        <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas">
       		<span class="hamb-top"></span>
           	<span class="hamb-middle"></span>
           	<span class="hamb-bottom"></span>
         </button>
	
		<div class="container">
		<div class="row">
		<div class="col-lg-8 col-lg-offset-2">
		
		<!-- conetent 시작-->
		<div data-ax5grid="grTbMenu" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
		
		<div style="padding: 10px;">
		    <button class="btn btn-default" data-grid-control="btnAddTbMenuProgram">메뉴넣기</button>
		    <button class="btn btn-default" data-grid-control="btnRemoveTbMenuProgram">메뉴삭제</button>
		    <button class="btn btn-default" id="btnTbMenuProgramMultiSave">저장</button>
		</div>
		
		<div style="padding: 10px;">
			권한: <select id="selectRoles" style="width:200px;"></select> 
		</div>
		
		<div data-ax5grid="grTbMenuProgram" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
		<!-- conetent 끝-->	
			
		</div>
		</div>
		</div>
	</div>
</div>

</body>
</html>