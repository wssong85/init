<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>
<title>역할관리</title>

<script type="text/javascript">

var grTbRoles = null;

$(function(){
	
	grTbRoles = new ax5.ui.grid();
	grTbRoles.getSelectionRowIndex = 0;
	grTbRoles.selectionItems = 0;
	
	grTbRoles.load = function() {
		$.ajax({
			url : _contextPath + "/com/role/selectTbRolesList.do",
			type: "post",
			success : function(data) {
				if(data.success) {
					grTbRoles.setData(data.result);
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
	grTbRoles.setConfig({
		target: $('[data-ax5grid="grTbRoles"]'),
		header: {align: 'center'},
		
		showLineNumber: false,
		
		body: {
			onClick: function(){
				grTbRoles.getSelectionRowIndex = this.doindex;
				grTbRoles.getSelectionItem = this.item;
				grTbRoles.focus(this.doindex);
			},
			onDataChanged: function(){
				
				grTbRoles.getSelectionRowIndex = this.doindex;
				grTbRoles.getSelectionItem = this.item;
				
				if(!grTbRoles.getSelectionItem["CRUD"]) {
					grTbRoles.updateRow($.extend({}, grTbRoles.list[grTbRoles.getSelectionRowIndex], {"CRUD": "U"}), grTbRoles.getSelectionRowIndex);
				}
				
				if(this.value && this.key == "ROLE") {
					grTbRoles.updateRow($.extend({}, grTbRoles.list[grTbRoles.getSelectionRowIndex], {"ROLE": this.value.toUpperCase()}), grTbRoles.getSelectionRowIndex);
				}
				
				//컬럼 유효성 체크
				if(this.key == "ROLE") {
					
					if(_vGrValidation.lengthCheck(this.value, 10)
							&& _vGrValidation.engNumSpecialCheck(this.value)
							&& _vGrValidation.pkCheck(grTbRoles, "ROLE")){
						
						grTbRoles.updateRow($.extend({}, grTbRoles.list[grTbRoles.getSelectionRowIndex], {"ROLE": this.value.toUpperCase()}), grTbRoles.getSelectionRowIndex);
						
					} else {
						
						grTbRoles.updateRow($.extend({}, grTbRoles.list[grTbRoles.getSelectionRowIndex], {"ROLE": ""}), grTbRoles.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "ROLE_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbRoles.updateRow($.extend({}, grTbRoles.list[grTbRoles.getSelectionRowIndex], {"ROLE_DC": ""}), grTbRoles.getSelectionRowIndex);
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
			key: "ROLE",
			label: "*역할",
			align: "center",
			width: 200,
			enableFilter: true,
            editor: {
            	type:"text",
				disabled: function () {
					if(this.item["CRUD"] && this.item["CRUD"] != "D") {
						return false;
					} else {
						return true;
					}
				} 
            }
		},{
			key: "ROLE_NM",
			label: "역할명",
			align: "center",
			width: 200,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "ROLE_DC",
			label: "역할설명",
			align: "center",
			width: 200,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "UP_DT",
			label: "수정일",
			type: "checkbox",
			align: "center",
			width: 150,
			enableFilter: true
		}]
	
	});
	
	
	
		
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
        		
            case "btnAddTbRoles":
            	
            	var vAddItem = {
            		"CRUD": "C"
            		,"ROLE": ""
            		,"ROLE_NM": ""
            		,"ROLE_DC": ""
            		,"WRITE_ID" : ""
            	};            	
            	
            	grTbRoles.addRow($.extend({}, vAddItem, {__index: undefined}));
                
                break;
                
            case "btnRemoveTbRoles":
            	
				grTbRoles.updateRow($.extend({}, grTbRoles.list[grTbRoles.getSelectionRowIndex], {"CRUD": "D"}), grTbRoles.getSelectionRowIndex);
				grTbRoles.list[grTbRoles.getSelectionRowIndex]["__modified__"] = true;
				
                break;
                
        }
        
    });
    
    $("#btnSelectTbRoles").click(function(){
    	grTbRoles.load();
    });
    
    $("#btnMultiSaveTbRoles").click(function(){

    	var vValidateJson = {
			 "ROLE"   : "역할은 필수로 입력해 주십시오."
		};
    	
    	fn_GridMultiSaveForValidateArray(
				grTbRoles
				,"/com/role/multiTbRoles.do"
				,vValidateJson
				,[]
		);
    	
    });
    
    $("#btnSelectTbRoles").trigger("click");
    
});
</script>
</head>

<body>

<div style="padding: 10px;">
	<button class="btn btn-default" id="btnSelectTbRoles">조회</button>
    <button class="btn btn-default" data-grid-control="btnAddTbRoles">행추가</button>
    <button class="btn btn-default" data-grid-control="btnRemoveTbRoles">행삭제</button>
    <button class="btn btn-default" id="btnMultiSaveTbRoles">저장</button>
</div>

<div data-ax5grid="grTbRoles" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>

</body>
</html>