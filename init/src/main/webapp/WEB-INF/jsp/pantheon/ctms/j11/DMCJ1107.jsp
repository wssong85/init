<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>사용자 권한조회</title>
<script type="text/javascript">
var currentRowIndex = "";
var taskSn;
var roleCodeReceive;
var roleCodeId; //select box 선택 데이터 저장


var gridUserRole = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
		 	id: 'gridUserRole',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridUserRole',
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/selectUserRoleInfoList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': true,
			    headerHeight: 40,
			    rowHeight: 37,
			    width: 700
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
		 		dataField : "TASK_SN",
		 		headerText : "과제순번",
		 		editable : false,
		 		visible : false,		 		
		 	},{
		 		dataField : "TASK_NO",
		 		headerText : "과제번호",
		 		editable : false,
		 		visible : false,		 		
		 	},{
		 		dataField : "ROLE_NM",
		 		headerText : "역할",
		 		editable : false,	
		 	},{
		 		dataField : "USER_ID",
		 		headerText : "ID",
		 		editable : false
		 	},{
		 		dataField : "USER_NM",
		 		headerText : "사용자",
		 		editable : false
		 	}],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 이벤트 
		 	binding: function() {
		 		var me = this;
		 		
		 		AUIGrid.bind(me.id, 'cellClick', function(event) {
		 			currentRowIndex = event.rowIndex;
		 			returnRoleValue = {
		 				  ROLE_ID : event.item.ROLE_ID
		 				, ROLE_NM : event.item.ROLE_NM
		 			    , USER_ID : event.item.USER_ID
		 				, RM 	  : event.item.RM

			 		};
		 		});
		 		
		 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
		 			currentRowIndex = event.rowIndex;
		 			returnRoleValue = {
		 				  ROLE_ID : event.item.ROLE_ID
		 				, ROLE_NM : event.item.ROLE_NM
			 			, USER_ID : event.item.USER_ID
			 			, RM 	  : event.item.RM
		 			};
		 			
		 			switch(gridDataCount){
		 			case 1 :
		 				if(!AUIGrid.isUniqueValue(grSend.id, 'USER_ID', event.item['USER_ID'])
			 					&& !AUIGrid.isUniqueValue(grSend.id, 'ROLE_ID', event.item['ROLE_ID'])) {
							alert('중복된 값이 있습니다.');
							return;
			 			}
		 				
		 				break;
		 			case 2: 
		 				if(!AUIGrid.isUniqueValue(grReception.id, 'USER_ID', event.item['USER_ID'])
			 					&& !AUIGrid.isUniqueValue(grReception.id, 'ROLE_ID', event.item['ROLE_ID'])) {
							alert('중복된 값이 있습니다.');
							return;
			 			}		 				
		 				
		 				break;
		 			}
		 			
	 			   	layerClose(3);	 			   
	 			    fn_serRoleInfo(event);
		 		});
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;		 	 	
		 		AUIGrid.showAjaxLoader(me.id);		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: {'TASK_SN' : roleTaskSn, 'ROLE_ID' : roleCodeId},//me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {		 		    		
		 		    		 		    		
		 		    		
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.result);
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
		
	
$(document).ready(function(){
	gridUserRole.createGrid();
 	//$("select option[value=" "]").attr("TaskNoSearchModule",true)
	
 	var selectBoxText;
 	selectBoxText += "<option value=''>전체</option>";
 	for(var i=0; roleCodevalue.length > i; i++){
 		selectBoxText += "<option value='"+roleCodevalue[i].CODE+"'>"+roleCodevalue[i].NAME+"</option>";
 	}
 	$("#TaskNoSearchModule").append(selectBoxText);
 	
	
 	
	$("#TaskNoSearchModule").change(function(){		
		roleCodeId = $("#TaskNoSearchModule").val();	
		console.log("roleCodeId::::"+roleCodeId);
		gridUserRole.load();
	});

	$("#btnRoleClose").click(function(){
		
		layerClose(3);
	});
});	
window.onresize = function() {
	if (typeof gridUserRole.id !== "undefined") {
		AUIGrid.resize(gridUserRole.id);
	}
}
</script>
</head>
<body>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<section class="popupWrap">
					<div class="popup popup1 wd1000" >	
						<section class="conBox100 conBox">
							<div class="conBoxInner">		
								<div class="conTitBtnR">
					                <input type="button" id="btnRoleSave" value="저장">
					                <input type="button" id="btnRoleClose" value="목록">  					                          
					            </div>					             
					            <table class="tb02">
					           		<tbody>
										<tr>
											<th>모듈</th>
											<td>
											<select id="selectModule" name="selectModule">								
																		
											</select>
											</td>
											<th>공지구분</th>
                                            <td>
                                                <input type="radio" id="rdAll" name="noticeDivision" value="01" checked><label for="rdAll" class="raLab"><span>전체</span></label>
                                                <input type="radio" id="rdTask" name="noticeDivision" value="02"><label for="rdTask" class="raLab"><span>과제</span></label>
                                            </td>
                                            <th>과제번호</th>
                                            <td>
                                            	<input type="hidden" id="txtInputTaskSN">
                                                <input type="text" id="txtInputTaskNo" disabled> <input type="button" id="btnSearchTask" value="조회" >
                                            </td>                                            
										</tr>										
									</tbody>
								</table>
								<table class="tb02">
									<tbody>
										<tr>
											<th>글쓰기 권한(송신)</th>  <th>글보기 권한(수신)</th>
										</tr>
									</tbody>
								</table>
								<table class="tb02">
									<tbody>
										<tr>
											<td>
												<div class="conTitBtnR">
						               				<input type="button" id="btnLeftSave" value="행추가">
						               			    <input type="button" id="btnLeftDel" value="삭제"> 					                          
						           				</div>
											</td>
											<td>
												<div class="conTitBtnR">
						               				<input type="button" id="btnRightSave" value="행추가">
						               			    <input type="button" id="btnRightDel" value="삭제"> 					                          
						           				</div>
											</td>
												
										</tr>										
									</tbody>									
								</table>
								<table>
									<tbody>
										<tr>
											<td>
												<!-- 그리드 시작 -->
							                    <article class="mgT10">
							                        <!-- 에이유아이 그리드가 이곳에 생성 -->							                        
							                        <div id="grSend" ></div> 
							                    </article>
							                    <!-- 그리드 끝 -->
											</td>
											<td>
												<!-- 그리드 시작 -->
							                    <article class="mgT10">
							                        <!-- 에이유아이 그리드가 이곳에 생성 -->							                       
							                        <div id="grReception" ></div>  
							                    </article>
							                    <!-- 그리드 끝 -->
											<td>
										</tr>										
									</tbody>									
								</table>
							</div>
						</section>
				    </div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>