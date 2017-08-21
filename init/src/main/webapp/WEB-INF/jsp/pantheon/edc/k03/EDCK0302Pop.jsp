<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>

<script type="text/javascript">

var EDCK0302Pop_grid = {
	 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
	 	id: 'EDCK0302Pop_grid',
	 	//AUI그리드 생성할 div 및 페이징 옵션
	 	div: {
	 		gridDiv: '#EDCK0302Pop_grid',
	 	},
	 	//데이터 연계 옵션
	 	proxy: {
	 		url: "/edc/k03/selectAnalysisList.do",
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//처음 시작시 데이터 로딩
	 		autoLoad: false
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
	 		dataField : "CDISC_SUBMIT_VALUE",
	 		headerText : "Analysis Parameter",
	 		editable : false,
	 		width: 100
	 	},{
	 		dataField : "CDISC_SYNONM",
	 		headerText : "Description",
	 		editable : false,	 		
	 		width: 200
	 	},{
	 		dataField : "CL_CODE_SN",
	 		headerText : "Analysis parameter Code",
	 		editable : false,	
	 		width: 150
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
	 			returnValue = {
	 				  CDISC_SUBMIT_VALUE : event.item.CDISC_SUBMIT_VALUE
	 			    , CL_CODE_SN : event.item.CL_CODE_SN
		 		};
	 		});
	 		
	 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
	 			currentRowIndex = event.rowIndex;
	 			returnValue = {
 					CDISC_SUBMIT_VALUE : event.item.CDISC_SUBMIT_VALUE
	 			    , CL_CODE_SN : event.item.CL_CODE_SN
	 			};
	 			
 			   	layerClose(2);
 			    fn_setParam();
	 		});
	 	},
	 	//AUI 그리드 데이터 요청
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
	EDCK0302Pop_grid.createGrid();
	// EDCK0302Pop_grid.load();
	$("#btnApply").click(function(){
		if(currentRowIndex >= 0){
			layerClose(2);
			fn_setParam();
		}
		else{
			alert("Analysis parameter를 선택하세요.");
		}
	});

	$("#btnClose").click(function(){
		layerClose(2);
	});
	
	$("#CDISC_SUBMIT_VALUE").keydown(function(key){
		if(key.keyCode == 13){
			fn_searchClick();
		}
	});
		
	
});

function fn_searchClick(){
	EDCK0302Pop_grid.proxy.param = {'CDISC_SUBMIT_VALUE' : $("#CDISC_SUBMIT_VALUE").val(), 'MODULE' : 'Y', 'SEARCH' : 'Y'};
	EDCK0302Pop_grid.load();
}

window.onresize = function() {
	if (typeof EDCK0302Pop_grid.id !== "undefined") {
		AUIGrid.resize(EDCK0302Pop_grid.id);
	}
}
</script>
	<section class="popupWrap">
		<div class="popup popup2 wd740">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<div class="conTitBtnL">
						<label>Analysis parameter </label>
						<input type="text" id="CDISC_SUBMIT_VALUE" name="CDISC_SUBMIT_VALUE" class="pdR15">
						<input type="button" class="btn mgL3" onclick="fn_searchClick()" value="검색">
					</div>
					<article class="mgT44">
						<div id="EDCK0302Pop_grid" class="gridHeiSz08 grid_wrap tb01_2" style="height:308px !important;"></div>
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
