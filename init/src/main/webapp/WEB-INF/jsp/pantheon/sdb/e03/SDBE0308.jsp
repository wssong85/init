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
<title>거래선담당자</title>
<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript">
// var DELNGLN_CODE ='${DELNGLN_CODE}';
// var HRMFLNS_CASE_CODE ='${HRMFLNS_CASE_CODE}'
// var FOLLOW_NO ='${FOLLOW_NO}'
		
//var DELNGLN_CODE ='OD20160202';
var PRDUCT_CODE ='P2016_0022';
var HRMFLNS_CASE_CODE ='S2016_0001'
var FOLLOW_NO ='10'

var me;
var grCharge_D = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grCharge_D.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grCharge_D',
    paging: {
      pagingDiv: 'grCharge_D_paging',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: "<c:url value='/sdb/e03/selectChargeListPop.do'/>",    
    param: {
    	PRDUCT_CODE : PRDUCT_CODE
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
	    dataField : "CHARGER_SN",
	    headerText : "",
	    visible : false
  },{
	    dataField : "DELNGLN_CODE",
	    headerText : "",
	    visible : false
  },{
    dataField : "DELNGLN_NM",
    headerText : "거래선",
    width : 200,
    filter : {
			showIcon : true
		}
  },{
	    dataField : "CHARGER_NM",
	    headerText : "담당자",	    
	    filter : {
				showIcon : true
			}
  },{
    dataField : "EMAIL",
    headerText : "EMAIL",
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
    dataField : "EMAIL",
    headerText : "보내기",
    renderer : { // HTML 템플릿 렌더러 사용
		type : "TemplateRenderer"
	},
	// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
	labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
		if(!value)	return "";		
		var template = '<div style=" margin:0 auto;">';		
		template += '<a href="#" class="my_a_tag" style="padding:10px 10px 0 0; display:block; text-align:center;" onclick=javascript:fn_sendMail("'+ value +'","'+ item.CHARGER_NM +'","'+ item.CHARGER_SN +'","'+ HRMFLNS_CASE_CODE +'","'+ FOLLOW_NO +'");><img src="/images/pantheon/common/AUIGrid/download_icon.png"/>';		
		template += '</a></div>';
		return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
	}
  },{
 		dataField : "EMAIL",
 		headerText : '<spring:message code="comf0101.gr.TMP_PASSWORD"/>',
 		width: 126,
 		maxWidth: 126,
 		style:"tmp_style_01",
		renderer : {
             type : "ButtonRenderer",
             labelText : '<spring:message code="comf0101.gr.MAIL_SEND"/>',
             onclick : function(rowIndex, columnIndex, value, item) {
					
				var item = AUIGrid.getItemByRowIndex(grCharge_D.id, rowIndex);
				
				if(confirm('<spring:message code="comf0101.msg.1"/>')) {
	         	    $.ajax({
	         		    url: "<c:url value='/com/anonymous/updateCmUserForSendTmpMail.do'/>",
	         		    type: 'post',
	         		    dataType: 'json',
	         		    data: {
	         		    	'USER_ID': item['USER_ID'],
	         		    	'USER_NM' : item['USER_NM'],
	         		    	'EMAIL' : item['EMAIL']
	         		    },
	         		    success:function(data){
	         		    	if(data.success) {
	         		    		alert('<spring:message code="comf0101.msg.2"/>');
	         		    	} else {
	         		    		alert(data.message);
	         		    	}
	         		    },
	        			error : function(jqXHR, textStatus, errorThrown){
	        				alert(textStatus);
	        			}
	         		});
				}
             }
      	}
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
				PRDUCT_CODE : PRDUCT_CODE
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
	grCharge_D.createGrid();
});

function btninit_pop(){
 //검색 
  $('#btnSearch2').click(function(){	  
	  grCharge_D.load();	  	 
  });  
		
}


$(window).resize(function(){
	if (grCharge_D.id) {
		AUIGrid.resize(grCharge_D.id);
	}	
});

$('#btnApply2').click(function(){
	var str = "";
	var i, rowItem, rowInfoObj, dataField;

	selectionMode = AUIGrid.getProperty(grCharge_D.id,"selectionMode");

	var selectedItems = AUIGrid.getSelectedItems(grCharge_D.id);
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
				<h5>거래선담당자</h5>
				<article class="mgT20">
					<div id="grCharge_D" class="gridHeiSz10 grid_wrap tb01_2"></div>
					<div id="grCharge_D_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				</article>
				<div style=" position:absolute; right:20px; bottom:20px;">
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</div>
			</section>
		</div>
	</section>
</body>


</html>