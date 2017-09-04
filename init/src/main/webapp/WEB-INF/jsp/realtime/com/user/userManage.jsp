<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>

<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.css">
<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-select/master/dist/ax5select.min.js"></script>

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
						
						if(_vGrValidation.lengthCheck(this.value, 15)
								&&_vGrValidation.engNumcheck(this.value)
								&& _vGrValidation.pkCheck(grTbUser, "USER_ID")){
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"USER_ID": this.value.toUpperCase()}), grTbUser.getSelectionRowIndex);
							
						} else {
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"USER_ID": ""}), grTbUser.getSelectionRowIndex);
							
						}
					}
					
					if(this.key == "USER_NAME") {
						
						if(_vGrValidation.lengthCheck(this.value, 10)){
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"USER_NAME": this.value.toUpperCase()}), grTbUser.getSelectionRowIndex);
							
						} else {
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"USER_NAME": ""}), grTbUser.getSelectionRowIndex);
							
						}
					}
					
					if(this.key == "PASSWORD") {
						
						if(_vGrValidation.lengthCheck(this.value, 15)
								&&_vGrValidation.engNumSpecialCheck(this.value)){
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"PASSWORD": this.value.toUpperCase()}), grTbUser.getSelectionRowIndex);
							
						} else {
							
							grTbUser.updateRow($.extend({}, grTbUser.list[grTbUser.getSelectionRowIndex], {"PASSWORD": ""}), grTbUser.getSelectionRowIndex);
							
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
			}
				<c:forEach var="metaData" items="${metaDataList}" varStatus="status">
					<c:if test="${not empty metaData.Comment}">
						,{
							key: "<c:out value="${metaData.Field}"/>"
							,label: "<c:out value="${metaData.Comment}"/>"
							,align: "center"
							,width: 100
							,enableFilter: true
							<c:choose>
							    <c:when test="${fn:contains(metaData.Type, 'datetime')}">
							    	,formatter: "date"
							    </c:when>
							    <c:otherwise>
								    <c:choose>
									    <c:when test="${fn:contains(metaData.Type, 'varchar(1)')}">
										    ,editor: {
												type: "checkbox", config: {height: 17, trueValue: "Y", falseValue: "N"}
											}
									    </c:when>
									    <c:when test="${metaData.Field eq 'USER_ID' || metaData.Field eq 'PASSWORD'}">
									    	,editor: {
									    		type:"text"
								    			 ,disabled: function () {
								    				if(this.item["CRUD"] && this.item["CRUD"] != "D") {
														return false;
													} else {
														return true;
													}
												}
									    	}
									    </c:when>
									    <c:otherwise>
									   		,editor: {type:"text"}
									    </c:otherwise>
									</c:choose>
							    </c:otherwise>
							</c:choose>
						}
					</c:if>
				</c:forEach> 
				,{
					key: "ROLE", 
					label: "권한", 
					align: "center", 
					editor: { 
						type: "select", 
						config: {
	                        columnKeys: {
	                            optionValue: "ROLE", optionText: "ROLE_NM"
	                        },
	                        options: [
								<c:forEach var="roleData" items="${roleList}" varStatus="status">
									<c:if test="${status.index != 0}">,</c:if>
									{ROLE: "${roleData.ROLE}", ROLE_NM: "${roleData.ROLE}"}
								</c:forEach> 
	                        ]
						}
					}
				}
			]
		});
			
	    $('[data-grid-control]').click(function () {
	        switch (this.getAttribute("data-grid-control")) {
	        		
	            case "btnAddTbUser":
	            	
	            	var vAddItem = {
	            		"CRUD": "C"
            			<c:forEach var="metaData" items="${metaDataList}" varStatus="status">
            				<c:if test="${not empty metaData.Comment}">
								, 
								"<c:out value="${metaData.Field}"/>" 
								:
								<c:choose>
								    <c:when test="${fn:contains(metaData.Type, 'varchar(1)')}">
								    	"Y"
								    </c:when>
								    <c:otherwise>
								   		""
								    </c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach> 
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
				,"ROLE": "권한을 선택해 주십시오."
			};
	    	
	    	fn_GridMultiSaveForValidateArray(
					grTbUser
					,"/com/user/multiTbUser.do"
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