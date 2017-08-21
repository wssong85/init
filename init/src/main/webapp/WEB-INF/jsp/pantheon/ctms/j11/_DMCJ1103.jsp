<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>

<script type="text/javascript">
var currentRowIndex = "";
var v_instt_name;

if (typeof p_instt_name == 'undefined'){ v_instt_name = ""; } else { v_instt_name = p_instt_name ; }

var gridInstt = {
	 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
	 	id: 'gridInstt',
	 	//AUI그리드 생성할 div 및 페이징 옵션
	 	div: {
	 		gridDiv: '#gridInstt',
	 	},
	 	//데이터 연계 옵션
	 	proxy: {
	 		url: '/selectInsttList.do',
	 		param: { INSTT_NM : v_instt_name },
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
	 		dataField : "INSTT_CODE",
	 		headerText : "기관코드",
	 		editable : false,
	 		width: 90
	 	},{
	 		dataField : "INSTT_NAME",
	 		headerText : "기관명",
	 		editable : false,	
	 		width: 200
	 	}
	 	,{
	 		dataField : "ADDRESS",
	 		headerText : "주소",
	 		editable : false
	 	}
	 	,{
	 		dataField : "BIZ_NO",
	 		headerText : "사업자번호",
	 		editable : false,
	 		dataType:"string"
//       		  , labelFunction : function(  rowIndex, columnIndex, value) { 
// 						value += "";
// 						if(value.length == 10) {
// 							return value.substr(0,3) + "-" + value.substr(3,2) + "-" + value.substr(5,value.length)
// 						}
// 						return value;	
//    		        }
	 	  , width: 120
	 	}],
	 	//AUI 그리드 생성
	 	createGrid: function() {
	 		var me = this;
	 		
	 		//이후 객체.id 로 AUIGrid 컨트롤
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		me.binding();
	 		
	 		if(me.proxy.param.INSTT_NM.length > 0){
	 			me.proxy.autoLoad = true;
	 		}

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
	 				  INSTT_CODE : event.item.INSTT_CODE
	 			    , INSTT_NAME : event.item.INSTT_NAME
	 			    , KUNNR : event.item.KUNNR
		 		};
	 		});
	 		
	 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
	 			currentRowIndex = event.rowIndex;
	 			returnValue = {
	 				  INSTT_CODE : event.item.INSTT_CODE
	 			    , INSTT_NAME : event.item.INSTT_NAME
	 			    , KUNNR : event.item.KUNNR
	 			};
	 			
 			   	layerClose(2);
 			    fn_setInstt();
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
	gridInstt.createGrid();

	$("#btnApply").click(function(){
		if(currentRowIndex >= 0){
			layerClose(2);
			fn_setInstt();
		}
		else{
			alert("기관을 선택하세요.");
		}
	});

	$("#btnClose").click(function(){
		layerClose(2);
	});
});

function fn_searchClick(){
	gridInstt.proxy.param = {INSTT_NM : $("#INSTT_NM").val()};
	gridInstt.load();
}

window.onresize = function() {
	if (typeof gridInstt.id !== "undefined") {
		AUIGrid.resize(gridInstt.id);
	}
}
</script>



	<section class="popupWrap">
		<div class="popup popup2 wd740">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			
			
			
				<div class="popup_conBoxInner">
	
	
					<div class="conTitBtnL">
						<label>기관명 : </label>
						<input type="text" id="INSTT_NM" name="INSTT_NM" class="pdR15">
						<input type="button" class="btn mgL3" onclick="fn_searchClick()" value="검색">
					</div>
	
					
					
					<article class="mgT44">
						<div id="gridInstt" class="gridHeiSz08 grid_wrap tb01_2" style="height:308px !important;"></div>
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




