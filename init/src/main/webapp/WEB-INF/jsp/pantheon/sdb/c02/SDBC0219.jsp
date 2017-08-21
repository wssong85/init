<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유사사례 팝업</title>
<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript">


var me;
var grCase_Search = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grCase_Search.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grCase_Search',
    paging: {
      pagingDiv: 'grCase_Search_paging',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: '/sdb/c02/selectCaseListPop.do',
    param: {
    	PRDUCT_NM : $('#txtprduct_nm').val()
    },
    type: 'post',
    dataType: 'json',
    //페이징 true, false 로 지정
    paging: false,
    //처음 시작시 데이터 로딩
    autoLoad: true,
  },
  //AUI 그리드 옵션
 gridPros: {
		selectionMode: 'singleRow',
		editable: false,		
	    usePaging : false,
	    enableFilter : true,
	    pageRowCount : 5,
	    showPageButtonCount : 5,
	    headerHeight: 40,
	    fixedColumnCount : 3,
	    rowHeight: 37
 	},
  //AUI 그리드 레이아웃
  columnLayout : [{
	    dataField : "PRDUCT_CODE",
	    headerText : "기관번호",
	    visible : false
  },{
    dataField : "PRDUCT_NM",
    headerText : "PRODUCT",
    width : 200,
    filter : {
			showIcon : true
		}
  },{
	    dataField : "MAFU_NO",
	    headerText : "MFR NO.",	    
	    filter : {
				showIcon : true
			}
  },{
    dataField : "FOLLOW_NO",
    headerText : "INITIAL",
    filter : {
			showIcon : true
		}
  },{
    dataField : "FRT_RCEPT_DTE",
    headerText : "인지일",
    filter : {
			showIcon : true
		}
  },{
    dataField : "REPORT_FLAG",
    headerText : "보고여부",
    filter : {
			showIcon : true
		}
  },{
	    dataField : "HRMFLNS_CASE_CODE",
	    headerText : "",
	    visible : false
  },{
	    dataField : "INSTT_NO",
	    headerText : "",
	    visible : false
  },{
	    dataField : "TESTEE_NO",
	    headerText : "",
	    visible : false
  }], 
  

  createGrid: function() {
		var me = this;
		
		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros); 		
		//AUIGrid.bind(me.id, "cellDoubleClick", auiGridCellDoubleClickHandler); 		 		
		me.binding();
		
		if(me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 이벤트 
	binding: function() {
		var me = this;
		
	},
	//AUI 그리드 데이터 요청
	load: function(v1, v2) {
		var me = this;
		var param = {
				PRDUCT_NM : $('#txtprduct_nm').val()
		};
		AUIGrid.showAjaxLoader(me.id);
		$.ajax({
		    url: me.proxy.url,
		    type: me.proxy.type,
		    dataType: me.proxy.dataType,
		    data: param,
		    success:function(data){
		    	if(data.success) {
			    	AUIGrid.removeAjaxLoader(me.id);
			    	AUIGrid.setGridData(me.id, data.result);
			    	AUIGrid.setSelectionByIndex(me.id, 0);
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

$(function(){
	$('#txtprduct_nm').mkSearchEnter('btnSearch2');
	btninit_pop();
	grCase_Search.createGrid();
});

function btninit_pop(){
 //검색 
  $('#btnSearch2').click(function(){	  
	  grCase_Search.load();	  	 
  });  
		
}


$(window).resize(function(){
	if (grCase_Search.id) {
		AUIGrid.resize(grCase_Search.id);
	}	
});

$('#btnApply2').click(function(){
	var str = "";
	var i, rowItem, rowInfoObj, dataField;

	selectionMode = AUIGrid.getProperty(grCase_Search.id,"selectionMode");

	var selectedItems = AUIGrid.getSelectedItems(grCase_Search.id);
	if (selectedItems.length <= 0) {
		alert("없음");
		return;
	}

	rowInfoObj = selectedItems[0];
	rowItem = rowInfoObj.item;
	if (rowItem.USE_AT == "Deleted") {
		alert('삭제된 행입니다.');
		return;
	}
	
	Reload_Case(rowItem.MAFU_NO, rowItem.INSTT_NO, rowItem.TESTEE_NO);
	
	layerClose();
});

$("#btnClose").click(function() {
	layerClose();
});


</script>

 </head>


<body>
	<section class="popupWrap">
		<div class="popup wd700">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<h5>유사사례</h5> 
				<div class="mgT8">
					<label>PRODUCT </label>
					<input type="text" id="txtprduct_nm" name="PRDUCT_NM" class="pdR15">
					<input type="button" class="btn mgL3" id="btnSearch2" value="검색">
				</div>
				<article class="mgT20">
					<div id="grCase_Search" class="gridHeiSz10 grid_wrap tb01_2"></div>
					<div id="grCase_Search_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				</article>
				<div style=" position:absolute; right:20px; bottom:20px;">
					<input type="button" id="btnApply2" value="적용" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</div>
			</section>
		</div>
	</section>
	
</body>


</html>