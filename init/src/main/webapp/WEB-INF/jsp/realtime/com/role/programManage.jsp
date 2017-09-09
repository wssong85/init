<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>
<title>프로그램관리</title>

<script type="text/javascript">

var grTbProgram = null;

$(function(){
	
	grTbProgram = new ax5.ui.grid();
	grTbProgram.getSelectionRowIndex = 0;
	grTbProgram.selectionItems = 0;
	
	grTbProgram.load = function() {
		$.ajax({
			url : _contextPath + "/com/role/selectTbProgramList.do",
			type: "post",
			success : function(data) {
				if(data.success) {
					grTbProgram.setData(data.result);
					
					/*
					if(data.result.length && !grTbDetailCode.getList().length){
						
						grTbProgram.getSelectionRowIndex = 0;
						grTbProgram.getSelectionItem = data.result[0];
						
						grTbDetailCode.load({"GROUP_CD" : data.result[0]["GROUP_CD"]});
						
					}
					*/
					
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
	grTbProgram.setConfig({
		target: $('[data-ax5grid="grTbProgram"]'),
		header: {align: 'center'},
		
		showLineNumber: false,
		
		body: {
			onClick: function(){
				grTbProgram.getSelectionRowIndex = this.doindex;
				grTbProgram.getSelectionItem = this.item;
// 				grTbProgram.focus(this.doindex);
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbProgram.getSelectionRowIndex = this.doindex;
				grTbProgram.getSelectionItem = this.item;
				
				if(!grTbProgram.getSelectionItem["CRUD"]) {
					grTbProgram.updateRow($.extend({}, grTbProgram.list[grTbProgram.getSelectionRowIndex], {"CRUD": "U"}), grTbProgram.getSelectionRowIndex);
				}
				
				if(this.value && this.key == "PROGRAM_ID") {
					grTbProgram.updateRow($.extend({}, grTbProgram.list[grTbProgram.getSelectionRowIndex], {"PROGRAM_ID": this.value.toUpperCase()}), grTbProgram.getSelectionRowIndex);
				}
				
				console.log('1');
				//컬럼 유효성 체크
				if(this.key == "PROGRAM_ID") {
					
					console.log('2');
					
					console.log(_vGrValidation.lengthCheck(this.value, 5));
					console.log(_vGrValidation.engNumcheck(this.value));
					console.log(_vGrValidation.pkCheck(grTbProgram, "PROGRAM_ID"));
					
					if(_vGrValidation.lengthCheck(this.value, 5)
							&&_vGrValidation.engNumcheck(this.value)
							&& _vGrValidation.pkCheck(grTbProgram, "PROGRAM_ID")){
						
						console.log('3');	
						grTbProgram.updateRow($.extend({}, grTbProgram.list[grTbProgram.getSelectionRowIndex], {"PROGRAM_ID": this.value.toUpperCase()}), grTbProgram.getSelectionRowIndex);
						
					} else {
						console.log('4');
						grTbProgram.updateRow($.extend({}, grTbProgram.list[grTbProgram.getSelectionRowIndex], {"PROGRAM_ID": ""}), grTbProgram.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "PROGRAM_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbProgram.updateRow($.extend({}, grTbProgram.list[grTbProgram.getSelectionRowIndex], {"PROGRAM_DC": ""}), grTbProgram.getSelectionRowIndex);
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
			key: "PROGRAM_ID",
			label: "*프로그램ID",
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
			key: "PROGRAM_NM",
			label: "프로그램명",
			align: "center",
			width: 200,
			enableFilter: true,
			editor: {type:"text"}
		},{
			key: "PROGRAM_URL",
			label: "URL",
			align: "center",
			width: 200,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "PROGRAM_DC",
			label: "설명",
			align: "center",
			width: 200,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "USE_YN",
			label: "사용여부",
			type: "checkbox",
			align: "center",
			width: 150,
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
			width: 200
		}]
	
	});
	
	
	
		
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
        		
            case "btnAddTbProgram":
            	
            	var vAddItem = {
            		"CRUD": "C"
            		,"PROGRAM_ID": ""
            		,"PROGRAM_URL": ""
            		,"PROGRAM_DC": ""
            		,"PROGRAM_NM": ""
            		,"USE_YN": "Y"
            	};            	
            	
            	grTbProgram.addRow($.extend({}, vAddItem, {__index: undefined}));
                
                break;
                
            case "btnRemoveTbProgram":
            	
				grTbProgram.updateRow($.extend({}, grTbProgram.list[grTbProgram.getSelectionRowIndex], {"CRUD": "D"}), grTbProgram.getSelectionRowIndex);
				grTbProgram.list[grTbProgram.getSelectionRowIndex]["__modified__"] = true;
				
                break;
                
        }
        
    });
    
    $("#btnSelectTbProgram").click(function(){
    	grTbProgram.load();
    });
    
    $("#btnMultiSaveTbProgram").click(function(){
    	
    	var vValidateJson = {
			"PROGRAM_ID": "프로그램ID는 필수 입력해 주십시오."
			,"PROGRAM_URL": "프로그램URL은 필수 입력해 주십시오."
		};
    	
    	fn_GridMultiSaveForValidateArray(
				grTbProgram
				,"/com/role/multiTbProgram.do"
				,vValidateJson
				,[]
		);
    	
    });
    
    $("#btnSelectTbProgram").trigger("click");
    
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
		<div style="padding: 10px;">
			<button class="btn btn-default" id="btnSelectTbProgram">조회</button>
		    <button class="btn btn-default" data-grid-control="btnAddTbProgram">행추가</button>
		    <button class="btn btn-default" data-grid-control="btnRemoveTbProgram">행삭제</button>
		    <button class="btn btn-default" id="btnMultiSaveTbProgram">저장</button>
		</div>
		
		<div data-ax5grid="grTbProgram" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
		<!-- conetent 끝-->	
			
		</div>
		</div>
		</div>
	</div>
</div>

</body>
</html>