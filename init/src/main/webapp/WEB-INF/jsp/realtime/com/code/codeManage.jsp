<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>

<script type="text/javascript">

var grTbGroupCode = null;
var grTbDetailCode = null;

$(function(){
	
	grTbGroupCode = new ax5.ui.grid();
	grTbGroupCode.getSelectionRowIndex = 0;
	grTbGroupCode.selectionItems = 0;
	
	grTbGroupCode.load = function() {
		$.ajax({
			url : _contextPath + "/com/code/selectTbGroupCodeList.do",
			type: "post",
			success : function(data) {
				if(data.success) {
					grTbGroupCode.setData(data.result);
					
					if(data.result.length && !grTbDetailCode.getList().length){
						
						grTbGroupCode.getSelectionRowIndex = 0;
						grTbGroupCode.getSelectionItem = data.result[0];
						
						grTbDetailCode.load({"GROUP_CD" : data.result[0]["GROUP_CD"]});
						
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
	grTbGroupCode.setConfig({
		target: $('[data-ax5grid="grTbGroupCode"]'),
		header: {align: 'center'},
		
		showLineNumber: false,
		
		body: {
			onClick: function(){
				grTbGroupCode.getSelectionRowIndex = this.doindex;
				grTbGroupCode.getSelectionItem = this.item;
				grTbGroupCode.focus(this.doindex);
				grTbDetailCode.load({"GROUP_CD" : this.item["GROUP_CD"]});
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbGroupCode.getSelectionRowIndex = this.doindex;
				grTbGroupCode.getSelectionItem = this.item;
				
				if(!grTbGroupCode.getSelectionItem["CRUD"]) {
					grTbGroupCode.updateRow($.extend({}, grTbGroupCode.list[grTbGroupCode.getSelectionRowIndex], {"CRUD": "U"}), grTbGroupCode.getSelectionRowIndex);
				}
				
				if(this.value && this.key == "GROUP_CD") {
					grTbGroupCode.updateRow($.extend({}, grTbGroupCode.list[grTbGroupCode.getSelectionRowIndex], {"GROUP_CD": this.value.toUpperCase()}), grTbGroupCode.getSelectionRowIndex);
				}
				
				//컬럼 유효성 체크
				if(this.key == "GROUP_CD") {
					
					//길이체크
					if(_vGrValidation.lengthCheck(this.value, 3)
							//영문자숫자체크
							&& _vGrValidation.engNumcheck(this.value)
							//중복체크
							&& _vGrValidation.pkCheck(grTbGroupCode, "GROUP_CD")){
						
						grTbGroupCode.updateRow($.extend({}, grTbGroupCode.list[grTbGroupCode.getSelectionRowIndex], {"GROUP_CD": this.value.toUpperCase()}), grTbGroupCode.getSelectionRowIndex);
						
					} else {
						
						grTbGroupCode.updateRow($.extend({}, grTbGroupCode.list[grTbGroupCode.getSelectionRowIndex], {"GROUP_CD": ""}), grTbGroupCode.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "CD_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbGroupCode.updateRow($.extend({}, grTbGroupCode.list[grTbGroupCode.getSelectionRowIndex], {"CD_DC": ""}), grTbGroupCode.getSelectionRowIndex);
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
			key: "CD_DC",
			label: "코드설명",
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
	
	grTbDetailCode = new ax5.ui.grid();
	
	grTbDetailCode.getSelectionRowIndex = 0;
	grTbDetailCode.selectionItems = 0;
	grTbDetailCode.load = function(vParam) {
		
		$.ajax({
			url : _contextPath + "/com/code/selectTbDetailCodeList.do",
			type: 'post',
			dataType: 'json',
			data:vParam,
			success : function(data) {
				if(data.success) {
					grTbDetailCode.setData(data.result);
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
	grTbDetailCode.setConfig({
		target: $('[data-ax5grid="grTbDetailCode"]'),
		header: {align: 'center'},
		
		showLineNumber: false,
		
		body: {
			onClick: function(){
				
				grTbDetailCode.getSelectionRowIndex = this.doindex;
				grTbDetailCode.getSelectionItem = this.item;
				grTbDetailCode.focus(this.doindex);
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbDetailCode.getSelectionRowIndex = this.doindex;
				grTbDetailCode.getSelectionItem = this.item;
				
				if(!grTbDetailCode.getSelectionItem["CRUD"]) {
					grTbDetailCode.updateRow($.extend({}, grTbDetailCode.list[grTbDetailCode.getSelectionRowIndex], {"CRUD": "U"}), grTbDetailCode.getSelectionRowIndex);
				}
				
				if(this.value && this.key == "DETAIL_CD") {
					grTbDetailCode.updateRow($.extend({}, grTbDetailCode.list[grTbDetailCode.getSelectionRowIndex], {"DETAIL_CD": this.value.toUpperCase()}), grTbDetailCode.getSelectionRowIndex);
				}
				
				//컬럼 유효성 체크
				if(this.key == "DETAIL_CD") {
					
					//길이체크
					if(_vGrValidation.lengthCheck(this.value, 3)
							//영문자숫자체크
							&& _vGrValidation.engNumcheck(this.value)
							//중복체크
							&& _vGrValidation.pkCheck(grTbDetailCode, "DETAIL_CD")){
						
						grTbDetailCode.updateRow($.extend({}, grTbDetailCode.list[grTbDetailCode.getSelectionRowIndex], {"DETAIL_CD": this.value.toUpperCase()}), grTbDetailCode.getSelectionRowIndex);
						
					} else {
						
						grTbDetailCode.updateRow($.extend({}, grTbDetailCode.list[grTbDetailCode.getSelectionRowIndex], {"DETAIL_CD": ""}), grTbDetailCode.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "CD_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbDetailCode.updateRow($.extend({}, grTbDetailCode.list[grTbDetailCode.getSelectionRowIndex], {"CD_DC": ""}), grTbDetailCode.getSelectionRowIndex);
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
	
    $('[data-grid-control]').click(function () {
        switch (this.getAttribute("data-grid-control")) {
        		
            case "btnAddTbGroupCode":
            	
            	var vAddItem = {
            		"CRUD": "C"
            		,"GROUP_CD": ""
            		,"CD_DC": ""
            		,"USE_YN": "Y"
            	};            	
            	
            	grTbGroupCode.addRow($.extend({}, vAddItem, {__index: undefined}));
                
                break;
                
            case "btnRemoveTbGroupCode":
            	
				grTbGroupCode.updateRow($.extend({}, grTbGroupCode.list[grTbGroupCode.getSelectionRowIndex], {"CRUD": "D"}), grTbGroupCode.getSelectionRowIndex);
				grTbGroupCode.list[grTbGroupCode.getSelectionRowIndex]["__modified__"] = true;
				
                break;
            case "btnAddTbDetailCode":
            	
            	var vAddItem = {
                		"CRUD": "C"
                		,"GROUP_CD": grTbGroupCode.getSelectionItem["GROUP_CD"]
                	    ,"DETAIL_CD": ""
                	    ,"CD_SEQ": "0"
                		,"CD_DC": ""
                		,"USE_YN": "Y"
				};
            	
            	grTbDetailCode.addRow($.extend({}, vAddItem, {__index: undefined}));
                
            	break;
            case "btnRemoveTbDetailCode":
            	
            	grTbDetailCode.updateRow($.extend({}, grTbDetailCode.list[grTbDetailCode.getSelectionRowIndex], {"CRUD": "D"}), grTbDetailCode.getSelectionRowIndex);
            	grTbDetailCode.list[grTbDetailCode.getSelectionRowIndex]["__modified__"] = true;
            	
            	break;
            
        }
        
    });
    
    $("#btnSelectTbGroupCode").click(function(){
    	grTbGroupCode.load();
    });
    
    $("#btnMultiSaveTbGroupCode").click(function(){
    	
    	var vValidateJson = {
			"GROUP_CD": "그룹코드는 필수입력해주십시오."
		};
    	
    	fn_GridMultiSaveForValidateArray(
				grTbGroupCode
				,"/com/code/multiTbGroupCode.do"
				,vValidateJson
				,[]
		);
    	
    });
    
    $("#btnTbDetailCodeMultiSave").click(function(){
    	
    	var vValidateJson = {
			"DETAIL_CD": "상세코드는 필수입력해주십시오."
		};
    	
    	fn_GridMultiSaveForValidateArray(
				grTbDetailCode
				,"/com/code/multiTbDetailCode.do"
				,vValidateJson
				,[]
				,""
				,""
				,{"GROUP_CD":grTbGroupCode.getSelectionItem["GROUP_CD"]});
    	
    });
    
    $("#btnSelectTbGroupCode").trigger("click");
    
});
</script>
<title>공통코드 관리</title>
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
				<button class="btn btn-default" id="btnSelectTbGroupCode">조회</button>
			    <button class="btn btn-default" data-grid-control="btnAddTbGroupCode">행추가</button>
			    <button class="btn btn-default" data-grid-control="btnRemoveTbGroupCode">행삭제</button>
			    <button class="btn btn-default" id="btnMultiSaveTbGroupCode">저장</button>
			</div>
			
			<div data-ax5grid="grTbGroupCode" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
			
			<div style="padding: 10px;">
			    <button class="btn btn-default" data-grid-control="btnAddTbDetailCode">행추가</button>
			    <button class="btn btn-default" data-grid-control="btnRemoveTbDetailCode">행삭제</button>
			    <button class="btn btn-default" id="btnTbDetailCodeMultiSave">저장</button>
			</div>
			
			<div data-ax5grid="grTbDetailCode" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
		<!-- conetent 끝-->	
			
		</div>
		</div>
		</div>
	</div>
</div>


</body>
</html>

