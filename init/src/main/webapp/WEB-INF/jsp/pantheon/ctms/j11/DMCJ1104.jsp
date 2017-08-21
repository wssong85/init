<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>사용자 조회</title>
	<script type="text/javascript">
	
	var currentRowIndex = "";
	var v_task_no;
	var v_user_nm;
	var v_cntrct_sttus;
	var v_user_type;
	var v_autoLoad;
	var v_user_se_code;
	
	if (typeof p_task_no      == 'undefined'){ v_task_no      = ""; } else { v_task_no      = p_task_no     ; }
	if (typeof p_user_nm      == 'undefined'){ v_user_nm      = ""; } else { v_user_nm      = p_user_nm     ; }
	if (typeof p_cntrct_sttus == 'undefined'){ v_cntrct_sttus = ""; } else { v_cntrct_sttus = p_cntrct_sttus; }
	if (typeof p_user_type    == 'undefined'){ v_user_type    = ""; } else { v_user_type    = p_user_type   ; }
	if (typeof p_autoLoad     == 'undefined'){ v_autoLoad  = false; } else { v_autoLoad     = p_autoLoad    ; }	
	
	var gridUserList = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
		 	id: 'gridUserList',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridUserList',
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/ctms/j11/selectTaskUserList.do',
		 		param: {   TASK_NO      : v_task_no
		 			     , USER_NM      : v_user_nm
		 			     , CNTRCT_STTUS : v_cntrct_sttus
		 			     , USER_TYPE    : v_user_type		 			    
		 			   },
		 		type: 'post',
		 		dataType: 'json',
		 		//처음 시작시 데이터 로딩
		 		autoLoad: v_autoLoad
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
				selectionMode: 'singleRow',
				editable: false,
				showStateColumn: false,
				enableFilter : true,
				showRowNumColumn : true,
			    headerHeight: 40,
			    rowHeight: 37,			   
			    width: 810
			    
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
		 		dataField : "TASK_SN",
		 		headerText : "과제순번",
		 		visible : false,
		 		editable : false,
		 		filter : {
					showIcon : true
				},
		 		width: 90
		 	},{
		 		dataField : "TASK_NO",
		 		headerText : "과제번호",
		 		editable : false,
		 		filter : {
					showIcon : true
				},
		 		width: 90
		 	},{
		 		dataField : "INSTT_NAME",
		 		headerText : "기관명",
		 		editable : false,	
		 		width: 180
		 	}
		 	,{
		 		dataField : "USER_ID",
		 		headerText : "ID",
		 		editable : false,	
		 		filter : {
					showIcon : true
				},
		 		width: 90
		 	}
		 	,{
		 		dataField : "USER_NM",
		 		headerText : "이름",
		 		editable : false,
		 		filter : {
					showIcon : true
				},
		 		width: 75
		 	}
		 	,{
		 		dataField : "EMAIL",
		 		headerText : "Email",
		 		filter : {
					showIcon : true
				},
		 		editable : false,	
		 		width: 140
		 	}
		 	,{
		 		dataField : "ROLE_ID",
		 		headerText : "ROLE",
		 		editable : false,	
		 		filter : {
					showIcon : true
				},
		 		width: 70
		 	}
		 	,{
		 		dataField : "TEL_NO",
		 		headerText : "연락처",
		 		filter : {
					showIcon : true
				},
		 		editable : false
// 	      	  , labelFunction : function(  rowIndex, columnIndex, value) { 
// 						value += "";
// 						if(value.length == 11) {
// 							return value.substr(0,3) + "-" + value.substr(3,4) + "-" + value.substr(6,value.length)
// 						}
// 						else if(value.length == 10) {
// 							return value.substr(0,2) + "-" + value.substr(2,4) + "-" + value.substr(5,value.length)
// 						}
// 						return value;	
//  		        }
		 	  , width: 125
		 	}
		 	],
		 	columnLayout2 : [{
		 		dataField : "USER_ID",
		 		headerText : "사용자ID",
		 		visible : true,
		 		filter : {
					showIcon : true
				},
		 		editable : false,
		 		width: 130
		 	},{
		 		dataField : "USER_NM",
		 		headerText : "사용자",
		 		editable : false,
		 		filter : {
					showIcon : true
				},
		 		width: 130
		 	},{
		 		dataField : "TELNO",
		 		headerText : "전화번호",
		 		editable : false,	
		 		filter : {
					showIcon : true
				},
		 		width: 150
		 	}
		 	,{
		 		dataField : "EMAIL",
		 		headerText : "Email",
		 		filter : {
					showIcon : true
				},
		 		editable : false
		 	}		 	
		 	,{
		 		dataField : "DEPT_NM",
		 		headerText : "부서",
		 		filter : {
					showIcon : true
				},
		 		editable : false
		 	}
		 	,{
		 		dataField : "INSTT_CODE",
		 		headerText : "기관코드",
		 		editable : false
		 	}
		 	],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		if(p_user_type == ""){
		 			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		}
		 		else if(p_user_type == "N" || p_user_type == "Y"){
		 			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout2, me.gridPros);
		 		} 

		 		
				window.setTimeout(function(){
					AUIGrid.resize(me.id);
				}, 0.5);
		 		
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
		 			returnValue = {
		 				  TASK_SN    : event.item.TASK_SN
		 			    , TASK_NO    : event.item.TASK_NO
		 				, INSTT_CODE : event.item.INSTT_CODE
		 			    , INSTT_NAME : event.item.INSTT_NAME
		 			    , USER_ID    : event.item.USER_ID
		 			    , USER_NM    : event.item.USER_NM
		 			    , EMAIL      : event.item.EMAIL
		 			    , TEL_NO     : event.item.TEL_NO
		 			    , ROLE_ID    : event.item.ROLE_ID
		 			    , DEPT_NM    : event.item.DEPT_NM
		 			    , KUNNR_CODE : event.item.KUNNR_CODE
		 			};
		 		});
		 		
		 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
		 			currentRowIndex = event.rowIndex;
		 			
		 			if( p_user_type.length == 0){
			 			returnValue = {
				 				  TASK_SN    : event.item.TASK_SN
				 			    , TASK_NO    : event.item.TASK_NO
				 				, INSTT_CODE : event.item.INSTT_CODE
				 			    , INSTT_NAME : event.item.INSTT_NAME
				 			    , USER_ID    : event.item.USER_ID
				 			    , USER_NM    : event.item.USER_NM
				 			    , EMAIL      : event.item.EMAIL
				 			    , TEL_NO     : event.item.TEL_NO
				 			    , ROLE_ID    : event.item.ROLE_ID
			 			};
		 			}
		 			else{
			 			returnValue = {
			 			 	      USER_ID : event.item.USER_ID
				 			    , USER_NM : event.item.USER_NM
				 				, TELNO   : event.item.TELNO
				 			    , EMAIL   : event.item.EMAIL
				 			    , DEPT_NM : event.item.DEPT_NM
				 			    , KUNNR_CODE : event.item.KUNNR_CODE
				 			   
			 			};
		 			}
		 			
	 			   	layerClose(1);
					fn_setUserInfo();
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
		 		    data: me.proxy.param,
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
		gridUserList.createGrid();
		$("#btnApply").click(function(){
			if(currentRowIndex >= 0){
				layerClose(1);
				fn_setUserInfo();
			}
			else{
				alert("기관을 선택하세요.");
			}
		});

		$("#btnClose").click(function(){
			layerClose(1);
		});
		
		//검색 엔터클릭
		 $("#USER_NM").keydown(function(event){			 
			 if(event.keyCode == 13){	
				 fn_searchInstt();
			 }
		 });
		//검색 엔터클릭
		 $("#USER_ID").keydown(function(event){
			 
			 if(event.keyCode == 13){	
				 fn_searchInstt();
			 }
		 });
		
	});
	
	function fn_searchInstt(){
		var params = {
				 'USER_NM' : $("#USER_NM").val(),
				 'USER_ID' : $("#USER_ID").val(),
				 'TASK_NO'      : v_task_no,		 			     
			     'CNTRCT_STTUS' : v_cntrct_sttus,
			     'USER_TYPE'    : v_user_type
		 };
		 gridUserList.proxy.param = params;
		 gridUserList.load();
	}
	
	window.onresize = function() {
		if (typeof gridUserList.id !== "undefined") {
			AUIGrid.resize(gridUserList.id);
		}
	}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup popup1 wd840">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<article class="conTitBox">
					    아이디 : <input type="text" id="USER_ID" name="USER_ID" class="pdR15">
						이름 : <input type="text" id="USER_NM" name="USER_NM" class="pdR15"><input type="button" class="btn mgL3" onclick="fn_searchInstt()" value="검색">
					</article>

					<article class="mgT15">
						<div id="gridUserList" class="gridHeiSz04 grid_wrap tb01_2"></div>
					</article>

					<article class="mgT10">
						<div style="text-align:center">					
							<input type="button" id="btnApply" value="적용" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>
</body>
</html>