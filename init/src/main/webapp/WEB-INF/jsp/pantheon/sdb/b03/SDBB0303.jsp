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
<title>기관 검색 팝업</title>
<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript">


var me;
var grOrganList_Search = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grOrganList_Search.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grOrganList_Search',
    paging: {
      pagingDiv: 'grProductList_Search_paging',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: '/sdb/b03/selectOrganListPop.do',
    param: {
    	INSTT_NM : $('#txtinstt_nm2').val()
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
	    dataField : "INSTT_NO",
	    headerText : "기관번호",
	    visible : false
  },{
    dataField : "INSTT_NM_TXT",
    headerText : "Site",
    width : 200,
    filter : {
			showIcon : true
		}
  },{
	    dataField : "INSTT_CODE",
	    headerText : "Site No.",	    
	    filter : {
				showIcon : true
			}
  },{
    dataField : "REPORTR_KOR",
    headerText : "Reporter",
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
	    dataField : "NATION_CODE",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ENG_ADRES",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_DSTNC",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_DSTNC_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_DSTNC_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_CTY",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_CTY_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_CTY_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_LCLTY",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_LCLTY_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_LCLTY_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "ADRES_ZIP",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_APPN_NM",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_APPN_NM_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_APPN_NM_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_MIDDLE_NM",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_MIDDLE_NM_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_MIDDLE_NM_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_FAMILY_NM",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_FAMILY_NM_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_FAMILY_NM_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_DEPT",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_DEPT_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPORTR_DEPT_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "QUALF",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPRT_TY",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPRT_TY_DETAIL",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPRT_TY_DETAIL_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPRT_TY_DETAIL_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "CLASS",
	    headerText : "",
	    visible : false
  },{
	    dataField : "CLASS_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "CLASS_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "MAJOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "MAJOR_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "MAJOR_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPRT_SJ",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPRT_SJ_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "REPRT_SJ_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "SPCLTYREALM",
	    headerText : "",
	    visible : false
  },{
	    dataField : "SPCLTYREALM_KOR",
	    headerText : "",
	    visible : false
  },{
	    dataField : "SPCLTYREALM_ENG",
	    headerText : "",
	    visible : false
  },{
	    dataField : "TELNO",
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
			INSTT_NM : $('#txtinstt_nm2').val()
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
	$('#txtinstt_nm2').mkSearchEnter('btnSearch2');
	btninit_pop();
	grOrganList_Search.createGrid();
});

function btninit_pop(){
 //검색 
  $('#btnSearch2').click(function(){	  
	  grOrganList_Search.load();	  	 
  });  
		
}

//윈도우 리사이징 이벤트
window.onresize = function() {
// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
if (typeof grOrganList_Search.id !== "undefined") {
  AUIGrid.resize(grOrganList_Search.id);
  }  

};

$('#btnApply').click(function(){
	var str = "";
	var i, rowItem, rowInfoObj, dataField;

	selectionMode = AUIGrid.getProperty(grOrganList_Search.id,"selectionMode");

	var selectedItems = AUIGrid.getSelectedItems(grOrganList_Search.id);
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
	
	 $("#hdinstt_no").val(rowItem.INSTT_NO);
	  $("#hdinstt_nm").val(rowItem.INSTT_NM);
	  $("#txtinstt_nm").val(rowItem.INSTT_NM_KOR);
	  $("#txtinstt_nm_eng").text(rowItem.INSTT_NM_ENG);
	  $("#txtinstt_code").val(rowItem.INSTT_CODE);
	  $("#txtnation_code").val(rowItem.NATION_CODE);
	  $("#txtadres").val(rowItem.ADRES);	  
	  $("#txtadres_eng").text(rowItem.ENG_ADRES);
	  $("#hdadres_dstnc").val(rowItem.ADRES_DSTNC);
	  $("#txtadres_dstnc").val(rowItem.ADRES_DSTNC_KOR);
	  $("#txtadres_dstnc_eng").text(rowItem.ADRES_DSTNC_ENG);
	  $("#hdadres_cty").val(rowItem.ADRES_CTY);
	  $("#txtadres_cty").val(rowItem.ADRES_CTY_KOR);
	  $("#txtadres_cty_eng").text(rowItem.ADRES_CTY_ENG);
	  $("#hdadres_lclty").val(rowItem.ADRES_LCLTY);
	  $("#txtadres_lclty").val(rowItem.ADRES_LCLTY_KOR);
	  $("#txtadres_lclty_eng").text(rowItem.ADRES_LCLTY_ENG);
	  $("#txtadres_zip").val(rowItem.ADRES_ZIP);
	  $("#hdreportr").val(rowItem.REPORTR);
	  $("#txtreportr").val(rowItem.REPORTR_KOR);
	  $("#txtreportr_eng").text(rowItem.REPORTR_ENG);
	  $("#hdreportr_appn_nm").val(rowItem.REPORTR_APPN_NM);
	  $("#txtreportr_appn_nm").val(rowItem.REPORTR_APPN_NM_KOR);
	  $("#txtreportr_appn_nm_eng").text(rowItem.REPORTR_APPN_NM_ENG);
	  $("#hdreportr_middle_nm").val(rowItem.REPORTR_MIDDLE_NM);
	  $("#txtreportr_middle_nm").val(rowItem.REPORTR_MIDDLE_NM_KOR);
	  $("#txtreportr_middle_nm_eng").text(rowItem.REPORTR_MIDDLE_NM_ENG);
	  $("#hdreportr_family_nm").val(rowItem.REPORTR_FAMILY_NM);
	  $("#txtreportr_family_nm").val(rowItem.REPORTR_FAMILY_NM_KOR);
	  $("#txtreportr_family_nm_eng").text(rowItem.REPORTR_FAMILY_NM_ENG);
	  $("#hdreportr_dept").val(rowItem.REPORTR_DEPT);
	  $("#txtreportr_dept").val(rowItem.REPORTR_DEPT_KOR);
	  $("#txtreportr_dept_eng").text(rowItem.REPORTR_DEPT_ENG);
	  alert(rowItem.QUALF);
	  $("#slqualf").val(rowItem.QUALF);
	  $("#slreprt_ty").val(rowItem.REPRT_TY);
	  $("#txtreprt_ty_detail").val(rowItem.REPRT_TY_DETAIL);
	  $("#txtreprt_ty_detail").val(rowItem.REPRT_TY_DETAIL_KOR);
	  $("#txtreprt_ty_detail_eng").text(rowItem.REPRT_TY_DETAIL_ENG);
	  $("#hdclass").val(rowItem.CLASS);
	  $("#txtclass").val(rowItem.CLASS_KOR);
	  $("#txtclass_eng").text(rowItem.CLASS_ENG);
	  $("#hdmajor").val(rowItem.MAJOR);
	  $("#txtmajor").val(rowItem.MAJOR_KOR);
	  $("#txtmajor_eng").text(rowItem.MAJOR_ENG);
	  $("#hdreprt_sj").val(rowItem.REPRT_SJ);
	  $("#txtreprt_sj").val(rowItem.REPRT_SJ_KOR);
	  $("#txtreprt_sj_eng").text(rowItem.REPRT_SJ_ENG);
	  $("#hdspcltyrealm").val(rowItem.SPCLTYREALM);
	  $("#txtspcltyrealm").val(rowItem.SPCLTYREALM_KOR);
	  $("#txtspcltyrealm_eng").text(rowItem.SPCLTYREALM_ENG);
	  $("#txtemail").val(rowItem.EMAIL);
	
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
				<h5>기관 검색 팝업</h5> 
				<div class="mgT8">
					<label>기관명 </label>
					<input type="text" id="txtinstt_nm2" name="INSTT_NM" class="pdR15">
					<input type="button" class="btn mgL3" id="btnSearch2" value="검색">
				</div>
				<article class="mgT14">
					<div id="grOrganList_Search" class="gridHeiSz11 grid_wrap tb01_2"></div>
					<div id="grProductList_Search_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				</article>
				<div style=" position:absolute; right:20px; bottom:20px;">
					<input type="button" id="btnApply" value="적용" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</div>
			</section>
		</div>
	</section>
	
</body>


</html>