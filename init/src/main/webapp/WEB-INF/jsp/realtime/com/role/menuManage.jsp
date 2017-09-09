<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>
<title>메뉴관리</title>
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.min.js"></script>

<script type="text/javascript">

var grTbUpMenu = null;
var grTbMenu = null;
var grTbProgram = null;

$(function(){
	
	grTbUpMenu = new ax5.ui.grid();
	grTbUpMenu.getSelectionRowIndex = 0;
	grTbUpMenu.selectionItems = 0;
	
	grTbUpMenu.load = function() {
		$.ajax({
			url : _contextPath + "/com/role/selectTbUpMenuList.do",
			type: "post",
			success : function(data) {
				if(data.success) {
					grTbUpMenu.setData(data.result);
					if(data.result.length && !grTbMenu.getList().length){
						
						grTbUpMenu.getSelectionRowIndex = 0;
						grTbUpMenu.getSelectionItem = data.result[0];
						grTbUpMenu.focus(0);
						
						grTbMenu.load({"UP_MENU_ID" : data.result[0]["UP_MENU_ID"]});
						
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
	grTbUpMenu.setConfig({
		target: $('[data-ax5grid="grTbUpMenu"]'),
		header: {align: 'center'},
		
		showLineNumber: false,
		
		body: {
			onClick: function(){
				grTbUpMenu.getSelectionRowIndex = this.doindex;
				grTbUpMenu.getSelectionItem = this.item;
				grTbUpMenu.focus(this.doindex);
				
				grTbMenu.load({"UP_MENU_ID" : this.item["UP_MENU_ID"]});
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
// 				alert("전유완 시발");
				grTbUpMenu.getSelectionRowIndex = this.doindex;
				grTbUpMenu.getSelectionItem = this.item;
				
				if(!grTbUpMenu.getSelectionItem["CRUD"]) {
					grTbUpMenu.updateRow($.extend({}, grTbUpMenu.list[grTbUpMenu.getSelectionRowIndex], {"CRUD": "U"}), grTbUpMenu.getSelectionRowIndex);
				}
				
				if(this.value && this.key == "UP_MENU_ID") {
					grTbUpMenu.updateRow($.extend({}, grTbUpMenu.list[grTbUpMenu.getSelectionRowIndex], {"UP_MENU_ID": this.value.toUpperCase()}), grTbUpMenu.getSelectionRowIndex);
				}
				
				//컬럼 유효성 체크
				if(this.key == "UP_MENU_ID") {
					
					//길이체크
					if(_vGrValidation.lengthCheck(this.value, 10)
							//영문자숫자체크
							&& _vGrValidation.engNumcheck(this.value)
							//중복체크
							&& _vGrValidation.pkCheck(grTbUpMenu, "UP_MENU_ID")){
						
						grTbUpMenu.updateRow($.extend({}, grTbUpMenu.list[grTbUpMenu.getSelectionRowIndex], {"UP_MENU_ID": this.value.toUpperCase()}), grTbUpMenu.getSelectionRowIndex);
						
					} else {
						
						grTbUpMenu.updateRow($.extend({}, grTbUpMenu.list[grTbUpMenu.getSelectionRowIndex], {"UP_MENU_ID": ""}), grTbUpMenu.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "UP_MENU_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbUpMenu.updateRow($.extend({}, grTbUpMenu.list[grTbUpMenu.getSelectionRowIndex], {"UP_MENU_DC": ""}), grTbUpMenu.getSelectionRowIndex);
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
			key: "UP_MENU_ID",
			label: "*상위메뉴아이디",
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
			key: "UP_MENU_NM",
			label: "상위메뉴이름",
			align: "center",
			width: 200,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "UP_MENU_DC",
			label: "상위메뉴설명",
			align: "center",
			width: 200,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "UP_MENU_SEQ",
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
	
	grTbMenu = new ax5.ui.grid();
	
	grTbMenu.getSelectionRowIndex = 0;
	grTbMenu.selectionItems = 0;
	grTbMenu.load = function(vParam) {
		
		$.ajax({
			url : _contextPath + "/com/role/selectTbMenuList.do",
			type: 'post',
			dataType: 'json',
			data:vParam,
			success : function(data) {
				if(data.success) {
					grTbMenu.setData(data.result);
					
					if(data.result.length>0) {
						grTbMenu.focus(0);
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
				grTbMenu.focus(this.doindex);
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbMenu.getSelectionRowIndex = this.doindex;
				grTbMenu.getSelectionItem = this.item;
				
				if(!grTbMenu.getSelectionItem["CRUD"]) {
					grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"CRUD": "U"}), grTbMenu.getSelectionRowIndex);
				}
				
				if(this.value && this.key == "MENU_ID") {
					grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"MENU_ID": this.value.toUpperCase()}), grTbMenu.getSelectionRowIndex);
				}
				
				//컬럼 유효성 체크
				if(this.key == "MENU_ID") {
					
					//길이체크
					if(_vGrValidation.lengthCheck(this.value, 20)
							//영문자숫자체크
							&& _vGrValidation.engNumcheck(this.value)
							//중복체크
							&& _vGrValidation.pkCheck(grTbMenu, "MENU_ID")){
						
						grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"MENU_ID": this.value.toUpperCase()}), grTbMenu.getSelectionRowIndex);
						
					} else {
						
						grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"MENU_ID": ""}), grTbMenu.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "MENU_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"MENU_DC": ""}), grTbMenu.getSelectionRowIndex);
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
			key: "UP_MENU_ID",
			label: "*상위아이디",
			align: "center",
			width: 100,
			enableFilter: true
		},{
			key: "PROGRAM_ID",
			label: "*프로그램아이디",
			align: "center",
			width: 200,
			enableFilter: true
		},{
			key: "MENU_ID",
			label: "*메뉴아이디",
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
			key: "MENU_NM",
			label: "메뉴이름",
			align: "center",
			width: 250,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "MENU_DC",
			label: "코드설명",
			align: "center",
			width: 250,
			enableFilter: true,
            editor: {type:"text"}
		},{
			key: "MENU_SEQ",
			label: "순서",
			align: "center",
			width: 50,
			enableFilter: true,
            editor: {type:"text"}
		}
		/*
		,{
			key: "type", 
			label: "구분", 
			align: "center", 
			editor: { 
				type: "select", 
				config: { 
					columnKeys: { 
						optionValue: "CD", 
						optionText: "NM" 
					}, options: [{
									CD: "O", 
									NM: "O: 주유"
								}, {
									CD: "R", 
									NM: "R: 정비"
								}] 
				}, 
				disabled: function () { 
					// 활성화 여부를 item.complete 의 값으로 런타임 판단. 
					return this.item.complete == "true"; 
				} 
			} 
		}
		*/
		,{

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
        		
            case "btnAddTbUpMenu":
            	
            	var vAddItem = {
            		"CRUD": "C"
            		,"UP_MENU_ID": ""
					,"UP_MENU_NM": ""
            		,"UP_MENU_DC": ""
            		,"UP_MENU_SEQ": "0"
            		,"USE_YN": "Y"
            	};            	
            	
            	grTbUpMenu.addRow($.extend({}, vAddItem, {__index: undefined}));
                
                break;
                
            case "btnRemoveTbUpMenu":
            	
				grTbUpMenu.updateRow($.extend({}, grTbUpMenu.list[grTbUpMenu.getSelectionRowIndex], {"CRUD": "D"}), grTbUpMenu.getSelectionRowIndex);
				grTbUpMenu.list[grTbUpMenu.getSelectionRowIndex]["__modified__"] = true;
				
                break;
            case "btnAddTbMenu":
            	
            	var vAddItem = {
                		"CRUD": "C"
                		,"UP_MENU_ID": grTbUpMenu.getSelectionItem["UP_MENU_ID"]
                	    ,"MENU_ID": ""
                	    ,"MENU_NM": ""
                        ,"MENU_DC": ""
                		,"MENU_DC": ""
                	    ,"MENU_SEQ": "0"
                		,"USE_YN": "Y"
				};
            	
            	grTbMenu.addRow($.extend({}, vAddItem, {__index: undefined}));
                
            	break;
            case "btnRemoveTbMenu":
            	
            	grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"CRUD": "D"}), grTbMenu.getSelectionRowIndex);
            	grTbMenu.list[grTbMenu.getSelectionRowIndex]["__modified__"] = true;
            	
            	break;
            
        }
        
    });
    
    grTbProgram = new ax5.ui.grid();
	grTbProgram.getSelectionRowIndex = 0;
	grTbProgram.selectionItems = 0;
	
	grTbProgram.load = function() {
		$.ajax({
			url : _contextPath + "/com/role/selectTbProgramList.do",
			type: "post",
			data: {
				"USE_YN" : "Y"
			},
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
				grTbProgram.focus(this.doindex);
				
				if(grTbMenu.getSelectionRowIndex > -1) {
					grTbMenu.updateRow($.extend({}, grTbMenu.list[grTbMenu.getSelectionRowIndex], {"PROGRAM_ID": this.item["PROGRAM_ID"]}), grTbMenu.getSelectionRowIndex);
				}
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbProgram.getSelectionRowIndex = this.doindex;
				grTbProgram.getSelectionItem = this.item;
				
			}
		},
		columns: [{
			key: "PROGRAM_ID",
			label: "*프로그램ID",
			align: "center",
			width: 200,
			enableFilter: true
		},{
			key: "PROGRAM_NM",
			label: "프로그램명",
			align: "center",
			width: 200,
			enableFilter: true
		},{
			key: "PROGRAM_URL",
			label: "URL",
			align: "center",
			width: 200,
			enableFilter: true
		},{
			key: "PROGRAM_DC",
			label: "설명",
			align: "center",
			width: 200,
			enableFilter: true
		},{
			key: "USE_YN",
			label: "사용여부",
			type: "checkbox",
			align: "center",
			width: 150,
			enableFilter: true
		},{
			key: "UP_DT", 
			label: "수정일", 
			formatter: "date", 
			align: "center",
			enableFilter: true,
			width: 200
		}]
	
	});
    
    $("#btnSelectTbUpMenu").click(function(){
    	grTbUpMenu.load();
    });
    
    $("#btnMultiSaveTbUpMenu").click(function(){
    	
    	var vValidateJson = {
			"UP_MENU_ID": "상위메뉴아이디는 필수 입력해 주십시오."
		};
    	
    	fn_GridMultiSaveForValidateArray(
				grTbUpMenu
				,"/com/role/multiTbUpMenu.do"
				,vValidateJson
				,[]
		);
    	
    });
    
    $("#btnTbMenuMultiSave").click(function(){
    	
    	var vValidateJson = {
			"MENU_ID": "메뉴아이디는 필수 입력해 주십시오."
			,"PROGRAM_ID":"프로그램아이디는 필수 입력해 주십시오."
		};
    	
    	fn_GridMultiSaveForValidateArray(
				grTbMenu
				,"/com/role/multiTbMenu.do"
				,vValidateJson
				,[]
				,""
				,""
				,{"UP_MENU_ID":grTbUpMenu.getSelectionItem["UP_MENU_ID"]});
    	
    });
    
    $("#btnSelectTbUpMenu").trigger("click");
    grTbProgram.load();
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
			<button class="btn btn-default" id="btnSelectTbUpMenu">조회</button>
		    <button class="btn btn-default" data-grid-control="btnAddTbUpMenu">행추가</button>
		    <button class="btn btn-default" data-grid-control="btnRemoveTbUpMenu">행삭제</button>
		    <button class="btn btn-default" id="btnMultiSaveTbUpMenu">저장</button>
		</div>
		
		<div data-ax5grid="grTbUpMenu" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
		
		<div data-ax5grid="grTbProgram" data-ax5grid-config="{}" style="width:800px; height:200px;"></div>
		
		<div style="padding: 10px;">
		</div>
		
		<div style="padding: 10px;">
		    <button class="btn btn-default" data-grid-control="btnAddTbMenu">행추가</button>
		    <button class="btn btn-default" data-grid-control="btnRemoveTbMenu">행삭제</button>
		    <button class="btn btn-default" id="btnTbMenuMultiSave">저장</button>
		</div>
		
		<div data-ax5grid="grTbMenu" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
		<!-- conetent 끝-->	
			
		</div>
		</div>
		</div>
	</div>
</div>

</body>
</html>