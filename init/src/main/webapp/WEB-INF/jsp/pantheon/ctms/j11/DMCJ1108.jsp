<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<title>연구자 조회</title>
<script type="text/javascript">
console.log("gridItem.TASK_SN}::::"+gridItem.TASK_SN);
var rsrchGrid = {
	 	id: 'rsrchGrid',
	 	div: {
	 		gridDiv: '#rsrchGrid'
	 	},
	 	proxy: {
	 		url: '/ctms/j11/selectRsrchUserInfo.do',
	 		param: {'TASK_SN' : gridItem.TASK_SN},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
		    // 페이징 사용
		   /*  usePaging : true,
		    pageRowCount : 5,
		    showPageButtonCount : 5, */
		    enableCellMerge : true,
		    showStateColumn: true,
		    reverseRowNum : true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
		    enableFilter : true,
		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "singleRow",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "INSTT_CODE",
			headerText : "기관코드",
			editable : true	
		},{
			dataField : "HSPTL_NM",
			headerText : "기관명",		
			editable : false,	
			filter : {
				showIcon : true
			}
		},{
			dataField : "USER_ID",
			headerText : "ID",		
			editable : false,
			filter : {
				showIcon : true
			}
		},{
			dataField : "USER_NM",
			headerText : "연구자",		
			editable : false,
			filter : {
				showIcon : true
			}
		},{
			dataField : "EMAIL",
			headerText : "e-mail",		
			editable : false,
			filter : {
				showIcon : true
			}
		},{
			dataField : "TELNO",
			headerText : "전화번호",		
			editable : false,	
			filter : {
				showIcon : true
			}
		}],
	 	//AUI 그리드 생성
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	//AUI 그리드 이벤트 
	 	binding: function() {
	 		var me = this;
	 		
	 		//셀 클릭
	 		AUIGrid.bind(me.id, "cellClick", function(event){
	 			returnValue = {
		 				  INSTT_CODE : event.item.INSTT_CODE
		 			    , HSPTL_NM : event.item.HSPTL_NM
		 			    , USER_ID : event.item.USER_ID
		 			    , USER_NM : event.item.USER_NM
		 			    , EMAIL : event.item.EMAIL
		 			    , TELNO : event.item.TELNO		 			  
			 		};	 	
	 		});
	 		
	 		//셀 더블클릭
	 		AUIGrid.bind(me.id, "cellDoubleClick", function(event){
	 			returnValue = {
		 				  INSTT_CODE : event.item.INSTT_CODE
		 			    , HSPTL_NM : event.item.HSPTL_NM
		 			    , USER_ID : event.item.USER_ID
		 			    , USER_NM : event.item.USER_NM
		 			    , EMAIL : event.item.EMAIL
		 			    , TELNO : event.item.TELNO		 			  
			 		};	 			
	 			layerClose(1);
	 			fn_setRsrchUserInfo();
	 		});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;	 		
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	 			    	
	 		    	} else {
	 		    		
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
	rsrchGrid.createGrid();
	
	//닫기버튼 클릭
	$("#btnClose").click(function(){
		layerClose(1);
		fn_rsrchCallback();
	});
	
	//검색버튼 클릭
	$("#btnSearch").click(function(){
		var params = {
				'USER_NM': $("#USER_NM").val()				   
			};
			
		rsrchGrid.proxy.param = params; 			
		rsrchGrid.load();
	});
	
	//검색 엔터
	$("#USER_NM").keyup(function(event){
		if(event.keyCode == 13){
			var params = {
					'USER_NM': $("#USER_NM").val()				   
				};
				
			rsrchGrid.proxy.param = params; 			
			rsrchGrid.load();
		}
	});
	
	//적용 버튼 클릭
	$("#btnApply").click(function(){
		
		layerClose(1);
		fn_setRsrchUserInfo();
	});
	
	
});



</script>



	<section class="popupWrap">
		<div class="popup popup1 wd850">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">	
	
					<div class="conTitBtnL">
						<label>연구자명 </label>
						<input type="text" id="USER_NM" name="USER_NM" class="pdR15">
						<input type="button" id="btnSearch" class="btn mgL3" value="검색">
					</div>
					
					<article class="mgT44">
						<div id="rsrchGrid" class="gridHeiSz08 grid_wrap tb01_2" style="height:308px !important;"></div>
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




