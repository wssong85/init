<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product 검색 팝업</title>
<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<script type="text/javascript">
	var grProductList_Search = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grProductList_Search.id);
		id : 'grProductList_Search',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#grProductList_Search',
			paging : {
				pagingDiv : 'grProductList_Search_paging',
				totalRowCount : 500,
				rowCount : 20,
				pageButtonCount : 10,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : '/sdb/b02/selectProductList.do',
			param : {
				PRDUCTNM_NM : $('#txtprductnm_code').val()
			},
			type : 'post',
			dataType : 'json',
			//페이징 true, false 로 지정
			paging : true,
			//처음 시작시 데이터 로딩
			autoLoad : true
		},
		//AUI 그리드 옵션
		gridPros : {
			selectionMode : 'singleRow',
			editable : false,
			//usePaging : true,			
			enableFilter : true,
			pageRowCount : 10,
			showPageButtonCount : 10,
			headerHeight : 40,
			rowHeight : 37
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "PRDUCT_CODE",
			headerText : "제품ID",
			visible : false
		}, {
			dataField : "PRDUCTNM_CODE",
			headerText : "Brand Name",
			width : 120
		}, {
			dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
			headerText : "Pre Approval IP Name",
		}, {
			dataField : "CONFM_DTE",
			headerText : "Approval Date",
			formatString : "yyyy-mm-dd",
			dataType : "date"
		}, {
			dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
			headerText : "Generic Name"

		}, {
			dataField : "COMAVA_AT",
			headerText : "Commercially"
		} ],

		//AUI 그리드 생성
		createGrid : function() {
			var me = this;

			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid
					.create(me.div.gridDiv, me.columnLayout, me.gridPros);			
			me.binding();

			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;

		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
			
		    //AUIGrid.setGridData(me.id, testData);
		    //me.div.paging.totalRowCount =testData.length;
		    me.div.paging.totalRowCount = 50;


		    me.createPagingNavigator(me.div.paging.currentPage);
			
			
		},
		//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		createPagingNavigator : function(goPage) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			fn_createPagingNavigator(me, goPage);
		},
		//페이징 에서 어느 페이지로 갈 것인지 지정
		moveToPage : function(goPage, rowCount) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			fn_moveToPage(me, goPage, rowCount)
		}
	};

	var txtprduct_nm = "${PRDUCT_NM}";

	$(function() {
		init();

		//그리드
		grProductList_Search.createGrid();
		btnInit_pop();
	});

	function init() {
		$('#txtprduct_nm').val($.trim(txtprduct_nm));
	}

	function btnInit_pop() {
		$("#btnSearch").click(function() {

			var param = {
				PRDUCT_NM : $('#txtprduct_nm').val()
			};
			grProductList_Search.proxy.param = param;
			grProductList_Search.load();

		});
		
		$('#btnApply').click(function(){
			var str = "";
			var i, rowItem, rowInfoObj, dataField;

			selectionMode = AUIGrid.getProperty(grProductList_Search.id,"selectionMode");

			var selectedItems = AUIGrid.getSelectedItems(grProductList_Search.id);
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

			$('#txtProductCode').val(rowItem.PRDUCTNM_CODE).trigger('change');
			$('#hdProductCode').val(rowItem.PRDUCT_CODE);
			layerClose();
		});

		$("#btnClose").click(function() {
			layerClose();
		});

	}
	
</script>
</head>
<body>

	<section class="popupWrap">
		<div class="popup wd700">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<div class="conTitBtnL">
					<label>PRODUCT : </label>
					<input type="text" id="txtprduct_nm" name="PRDUCT_NM" class="pdR15">
					<input type="button" class="btn mgL3" id="btnSearch" value="검색">
				</div>
				<article class="mgT44">
					<div id="grProductList_Search" class="gridHeiSz05 grid_wrap tb01_2"></div>
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