<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>

<script type="text/javascript">
var currentRowIndex = "";
var taskNo;
var tyCode;


var gridTask = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
		 	id: 'gridTask',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridTask',
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/ctms/j11/popupSelectTaskList.do',
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
		 		editable : false
		 		
		 	},{
		 		dataField : "TASK_TY_CODE",
		 		headerText : "구분",
		 		editable : false,
		 		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
					var me = gridTask;
					var retStr = "";
					for(var i=0; me.columnLayout[2].editRenderer.list.length > i; i++) {
						if(me.columnLayout[2].editRenderer.list[i]['CODE'] == value) {
							retStr = me.columnLayout[2].editRenderer.list[i]['NAME'];
							break;
						}
					}
					return retStr == "" ? value : retStr;
			    },
			    editRenderer : {
	     			type : "DropDownListRenderer",
	     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
	     			list : null,
	     			keyField : "CODE",
	     			valueField : "NAME"
	     		 }
		 		
		 	},{
		 		dataField : "FRST_CREDE",
		 		headerText : "등록일",
		 		dataType : "date",
				formatString : "yyyy-mm-dd",
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
		 			returnTaskValue = {
		 				  TASK_SN : event.item.TASK_SN
		 			    , TASK_NO : event.item.TASK_NO

			 		};
		 		});
		 		
		 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
		 			currentRowIndex = event.rowIndex;
		 			returnTaskValue = {
		 				 TASK_SN : event.item.TASK_SN
			 			,TASK_NO : event.item.TASK_NO
		 			};
		 			
	 			   	layerClose(2);
	 			    fn_setTaskNo();
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
		 		    data: {'CMMN_CLCODE' : 'EDC017', 'TASK_NO' : taskNo, 'TASK_TY_CODE' : tyCode},//me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {
		 		    		me.columnLayout[2].editRenderer.list = data.taskCode;
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
	
	if (typeof p_task_no !== "undefined") {
		$("#textTaskNoSearch").val(p_task_no);
		taskNo = $("#textTaskNoSearch").val();				
		gridTask.load();
	}

	gridTask.createGrid();
	
	$("#btnTaskSearch").click(function(){		
		taskNo = $("#textTaskNoSearch").val();
		tyCode = $("#btnTaskNoSearchModule").val();				
		gridTask.load();
		$("#textTaskNoSearch").val("");
	});
	
	$("#btnTaskNoSearchModule").change(function(){		
		taskNo = $("#textTaskNoSearch").val();
		tyCode = $("#btnTaskNoSearchModule").val();				
		gridTask.load();
	});
	
	$("#btnInstt").click(function(){
		if(currentRowIndex >= 0){
			layerClose(2);
			fn_setTaskNo();
		}
		else{
			alert("과제정보를 선택하세요.");
		}
	});
	

	$("#btnClose").click(function(){
		tyCode = "";
		taskNo = "";
		layerClose(2);
	});
});	
window.onresize = function() {
	if (typeof gridTask.id !== "undefined") {
		AUIGrid.resize(gridTask.id);
	}
}
</script>



	<section class="popupWrap">
		<div class="popup popup2 wd740">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			
			
			
				<div class="popup_conBoxInner">
	
	
					<div class="conTitBtnL">
						<label>과제번호 : </label>
						<input type="text" id="textTaskNoSearch" class="pdR15">
						<input type="button" id="btnTaskSearch" class="btn mgL3" value="검색">
					</div>
	
	
					<div class="conTitBtnR">
						<label>구분 : </label>
						<select id="btnTaskNoSearchModule" style="width:200px;">		
						    <option value="">전체</option>		
							<option value="01">임상</option>
							<option value="02">관찰</option>
							<option value="03">PMS</option>				
						</select>
					</div>
	
					
					
					<article class="mgT44">
						<div id="gridTask" class="gridHeiSz08 grid_wrap tb01_2" style="height:308px !important;"></div>
					</article>
					
					
					
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnInstt" value="적용" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			
			
			
			</section>
		</div>
	</section>




