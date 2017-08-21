<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>등록된 Product List 검색</title>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<style>

.bottom_arrow_btn_01 {
	padding: 2px 30px 5px 30px !important;
	height: 30px !important;
	background: #4c55a4 !important;
	font-size: 20px !important;
}

.bottom_arrow_btn_01:hover {
	background:;
	transition-duration: 1s;
}
</style>


	<script type="text/javascript">
	var txtdelngln_code ="${DELNGLN_CODE}"
	var grProductList = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grProductList.id);
			id : 'grProductList',
			//AUI그리드 생성할 div 및 페이징 옵션
			div : {
				gridDiv : '#grProductList',
				paging : {
					pagingDiv : 'grProductList_paging',
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
				paging : true ,
				//처음 시작시 데이터 로딩
				autoLoad : true
			},
			//AUI 그리드 옵션
			gridPros : {
				selectionMode : 'singleRow',
				editable : false,
				//usePaging : false,
				showRowCheckColumn : true,
				enableFilter : true,
				pageRowCount : 10,
				showPageButtonCount : 10,
				headerHeight : 40,	
				rowHeight : 37
			},
			//AUI 그리드 레이아웃
			columnLayout : [
		 	 { 
		 		dataField : "PRDUCT_CODE",
		 		headerText : "제품ID",
		 		visible : false
		 	},{
		 		dataField : "PRDUCTNM_CODE",
		 		headerText : "Brand Name",
		 		width: 120,
		 		filter : {
		 			showIcon : true
		 		}
		 	},{
		 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
		 		headerText : "Pre Approval IP Name",
		 		filter : {
		 			showIcon : true
		 		} 		
		 	},{
		 		dataField : "CONFM_DTE",
		 		headerText : "Approval Date",
		 		formatString : "yyyy/mm/dd",
		 		dataType:"date" 	,
		 		filter : {
		 			showIcon : true
		 		}	
		 	},{
		 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
		 		headerText : "Generic Name",
		 		filter : {
		 			showIcon : true
		 		}
		 		
		 	},{
		 		dataField : "COMAVA_AT",
		 		headerText : "Commercially",
		 		filter : {
		 			showIcon : true
		 		}
		 	}],
		 	
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
	
	var grProduc_Reg = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grProduc_Reg.id);
			id : 'grProduc_Reg',
			//AUI그리드 생성할 div 및 페이징 옵션
			div : {
				gridDiv : '#grProduc_Reg',
				paging : {
					pagingDiv : 'grProduc_Reg_paging',
					totalRowCount : 500,
					rowCount : 20,
					pageButtonCount : 10,
					currentPage : 1,
					totalPage : 0,
				},
			},
			//데이터 연계 옵션
			proxy : {
				url : './selectProductListReg.do',
				param : {
					DELNGLN_CODE : txtdelngln_code
				},
				type : 'post',
				dataType : 'json',
				//페이징 true, false 로 지정
				paging : false,
				//처음 시작시 데이터 로딩
				autoLoad : true
			},
			//AUI 그리드 옵션
			gridPros : {
				selectionMode : 'singleRow',
				editable : false,
				usePaging : false,
				showRowCheckColumn : true,
				enableFilter : true,
				softRemoveMode : true,
				pageRowCount : 10,
				showPageButtonCount : 10,
				headerHeight : 40,	
				rowHeight : 37
			},
			//AUI 그리드 레이아웃
			columnLayout : [
		 	 { 
		 		dataField : "PRDUCT_CODE",
		 		headerText : "제품ID",
		 		visible : false
		 	},{
		 		dataField : "PRDUCTNM_CODE",
		 		headerText : "Brand Name",
		 		width: 120,
		 		filter : {
		 			showIcon : true
		 		} 		
		 	},{
		 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
		 		headerText : "Pre Approval IP Name",
		 		filter : {
		 			showIcon : true
		 		} 				
		 	},{
		 		dataField : "CONFM_DTE",
		 		headerText : "Approval Date",
		 		formatString : "yyyy/mm/dd",
		 		dataType:"date" ,
		 		filter : {
		 			showIcon : true
		 		} 				
		 	},{
		 		dataField : "CONFM_BFE_IP_NM_MULLANG_CODE1",
		 		headerText : "Generic Name",
		 		filter : {
		 			showIcon : true
		 		} 		
		 		
		 	},{
		 		dataField : "COMAVA_AT",
		 		headerText : "Commercially",
		 		filter : {
		 			showIcon : true
		 		} 		
		 	}],
		 	
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
			},
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

		$(function(){
			init();		
			
			//그리드
			grProductList.createGrid();
			grProduc_Reg.createGrid();
			btnInit_pop();
		});

		function init(){			
			$('#txtprduct_nm').val($.trim(txtprduct_nm));
		}
		
		function btnInit_pop(){			
			$("#btnSearch").click(function(){

				var param = {
					PRDUCT_NM : 	$('#txtprduct_nm').val()
				};
				grProductList.proxy.param = param;
				grProductList.load();
				
			});
			
			$('#btnAdd').click(function(){				
				var checkedItems = AUIGrid.getCheckedRowItems(grProductList.id);
				var arr = [];
				for(var i = 0; i < checkedItems.length; i++) {
					if(!AUIGrid.isUniqueValue(grProduc_Reg.id, "PRDUCT_CODE", checkedItems[i].item['PRDUCT_CODE'])){
						alert(checkedItems[i].item['PRDUCTNM_CODE']+"은 이미 등록된  의약품입니다.");
						continue;
					}
					arr.push({
						'PRDUCT_CODE': checkedItems[i].item['PRDUCT_CODE'],
						'PRDUCTNM_CODE': checkedItems[i].item['PRDUCTNM_CODE'],
						'CONFM_BFE_IP_NM_MULLANG_CODE1': checkedItems[i].item['CONFM_BFE_IP_NM_MULLANG_CODE1'],
						'CONFM_DTE': checkedItems[i].item['CONFM_DTE'],
						'CONFM_BFE_IP_NM_MULLANG_CODE1': checkedItems[i].item['CONFM_BFE_IP_NM_MULLANG_CODE1'],
						'COMAVA_AT': checkedItems[i].item['COMAVA_AT']
					});
				}
				
				AUIGrid.addRow(grProduc_Reg.id, arr, "");
			});
			$('#btnApply').click(function(){				
				var data = AUIGrid.getGridData(grProduc_Reg.id);
				
				if(!data.length) {
					return;
				}
				
				var t_html = "";
				for(var i = 0; i < data.length; i++) {					
					t_html += '<input type="hidden" name="PRDUCTNM_CODE"  value="'+ data[i].PRDUCT_CODE +'"/><label>'
						+ data[i].PRDUCTNM_CODE + '</label>&nbsp;';
				}
				
				if (data.length !=0){
					$('#product_input').html(t_html);	
				}
				layerClose();
			});
			
			$("#btnClose").click(function(){
				layerClose();
			});
			
			$('#btnProductDel').click(function(){
				alert('삭제');
				var checkedItems = AUIGrid.getCheckedRowItems(grProduc_Reg.id);
				for(var i = 0; i < checkedItems.length; i++) {
					AUIGrid.removeRow(grProduc_Reg.id, checkedItems[i].rowIndex);
				}
				AUIGrid.removeSoftRows(grProduc_Reg.id);

			});
			
		}

	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd900">
			<section class="conBox100 popup_conBox" style="margin:0px;">
                <div class="popup_conBoxInner">
				 	<!-- <h5>PRODUCT 검색 팝업</h5> -->

			
					<div>
						<label>PRODUCT : </label>
						<input type="text" id="txtprduct_nm" name="PRDUCT_NM" class="pdR15">						
						<input type="button" class="btn mgL3" id="btnSearch" value="검색">
						
					</div>


					<article class="mgT15">
						<div id="grProductList" class="gridHeiSz04 grid_wrap tb01_2"></div>
						<div id="grProductList_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
					</article>		


					
					<div style="text-align:center; margin:20px 0 10px 0; clear:both; position:relative;">
						<input type="button" class="btn mgL3 bottom_arrow_btn_01" id="btnAdd" value="▼">
						<div style=" position:absolute; right:1px; top:0px;">
							<input type="button" id="btnProductDel" value="삭제" />
						</div>
					</div>
								

								

					<div id="grProduc_Reg" class="gridHeiSz03 grid_wrap tb01_2"></div>

					
					<article class="mgT20">
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