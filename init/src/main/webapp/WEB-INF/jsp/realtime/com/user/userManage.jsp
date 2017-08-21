<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>

<title>사용자관리</title>

<script type="text/javascript">
	var grTbUser = null;
	
	$(function(){
		
		grTbUser = new ax5.ui.grid();
		grTbUser.getSelectionRowIndex = 0;
		grTbUser.selectionItems = 0;
		
		grTbUser.load = function() {
			$.ajax({
				url : _contextPath + "/com/user/selectTbUserList.do",
				type: "post",
				success : function(data) {
					if(data.success) {
						grTbUser.setData(data.result);
						
						/*
						if(data.result.length && !grTbDetailCode.getList().length){
							
							grTbUser.getSelectionRowIndex = 0;
							grTbUser.getSelectionItem = data.result[0];
							
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
		grTbUser.setConfig({
			target: $('[data-ax5grid="grTbUser"]'),
			header: {align: 'center'},
			
			showLineNumber: false,
			
			body: {
				onClick: function(){
					grTbUser.getSelectionRowIndex = this.doindex;
					grTbUser.getSelectionItem = this.item;
					
				},
				onDBLClick: function(){
					
				},
				onDataChanged: function(){
					
					grTbUser.getSelectionRowIndex = this.doindex;
					grTbUser.getSelectionItem = this.item;
					
					if(!grTbUser.getSelectionItem["CRUD"]) {
						grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"CRUD": "U"}), grTbUser.getSelectionRowIndex);
					}
					
					if(this.value && this.key == "USER_ID") {
						grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"USER_ID": this.value.toUpperCase()}), grTbUser.getSelectionRowIndex);
					}
					
					//컬럼 유효성 체크
					if(this.key == "USER_ID") {
						
						if(_vGrValidation.lengthCheck(this.value, 5)
								&&_vGrValidation.engNumcheck(this.value)
								&& _vGrValidation.pkCheck(grTbUser, "USER_ID")){
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"USER_ID": this.value.toUpperCase()}), grTbUser.getSelectionRowIndex);
							
						} else {
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"USER_ID": ""}), grTbUser.getSelectionRowIndex);
							
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
				key: "USER_ID",
				label: "사용자ID",
				align: "center",
				width: 100,
				enableFilter: true,
	            editor: {type:"text"}
			},{
				key: "USER_NAME",
				label: "사용자이름",
				align: "center",
				width: 100,
				enableFilter: true,
	            editor: {type:"text"}
			},{
				key: "PASSWORD",
				label: "패스워드",
				align: "center",
				width: 100,
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
				key: "BIRTH_DT",
				label: "생일",
				align: "center",
				width: 100,
				enableFilter: true,
	            editor: {type:"text"}
			},{
				key: "AGE",
				label: "나이",
				align: "center",
				width: 100,
				enableFilter: true,
	            editor: {type:"text"}
			},{
				key: "PHONE",
				label: "전화번호",
				align: "center",
				width: 100,
				enableFilter: true,
	            editor: {type:"text"}
			},{
				key: "ADDR",
				label: "주소",
				align: "center",
				width: 200,
				enableFilter: true,
	            editor: {type:"text"}
			},{
				key: "EMAIL",
				label: "이메일",
				align: "center",
				width: 100,
				enableFilter: true,
	            editor: {type:"text"}
			},{
				key: "EMAIL_YN",
				label: "이메일 사용여부",
				type: "checkbox",
				align: "center",
				width: 100,
				enableFilter: true,
				editor: {
					type: "checkbox", config: {height: 17, trueValue: "Y", falseValue: "N"}
				}
			},{
				key: "FILE_ID",
				label: "파일 아이디",
				align: "center",
				width: 100,
				enableFilter: true,
	            editor: {type:"text"}
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
	        		
	            case "btnAddTbUser":
	            	
	            	var vAddItem = {
	            		"CRUD": "C"
	            		,"USER_ID": ""
	            		,"USER_NAME": ""
	            		,"PASSWORD": ""
            			,"USE_YN": "Y"
	            		,"BIRTH_DT": ""
	            		,"AGE": ""
	            		,"PHONE": ""
            			,"ADDR": ""
	            		,"EMAIL": ""
	            		,"EMAIL_YN": "Y"
	            		,"FILE_ID": ""
	            	};            	
	            	
	            	grTbUser.addRow($.extend({}, vAddItem, {__index: undefined}));
	                
	                break;
	                
	            case "btnRemoveTbUser":
	            	
					grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"CRUD": "D"}), grTbUser.getSelectionRowIndex);
					grTbUser.list[grTbUser.getSelectionRowIndex]["__modified__"] = true;
					
	                break;
	        }
	        
	    });
	    
	    $("#btnSelectTbUser").click(function(){
	    	grTbUser.load();
	    });
	    
	    $("#btnMultiSaveTbUser").click(function(){
	    	
	    	var vValidateJson = {
				"USER_ID": "사용자ID는 필수 입력해 주십시오."
				,"USER_NAME": "사용자이름은 필수 입력해 주십시오."
				,"PASSWORD": "패스워드는 필수 입력해 주십시오."
			};
	    	
	    	fn_GridMultiSaveForValidateArray(
					grTbUser
					,"/com/user/changeTbUser.do"
					,vValidateJson
					,[]
			);
	    });
	    
	    $("#btnSelectTbUser").trigger("click");
	});
</script>
</head>

<body>

	<div style="padding: 10px;">
		<button class="btn btn-default" id="btnSelectTbUser">조회</button>
	    <button class="btn btn-default" data-grid-control="btnAddTbUser">행추가</button>
	    <button class="btn btn-default" data-grid-control="btnRemoveTbUser">행삭제</button>
	    <button class="btn btn-default" id="btnMultiSaveTbUser">저장</button>
	</div>
	
	<div data-ax5grid="grTbUser" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>

</body>
</html>