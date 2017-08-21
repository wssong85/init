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
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<script type="text/javascript">
		var gridVerificationConfirm = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridVerificationConfirm'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/e03/selectVerificationForExcel.do',
		 		param: {
		 			FILENM : "${FILENM}",
		 			MAFU_NO : "${MAFU_NO}",
		 			PRDUCT_NM : "${PRDUCT_NM}",
		 			FIRST_DATE_START : "${FIRST_DATE_START}",
		 			FIRST_DATE_END : "${FIRST_DATE_END}",
		 			REPORT_DATE_START : "${REPORT_DATE_START}",
		 			REPORT_DATE_END : "${REPORT_DATE_END}",
		 			DMSTC_OUTNATN_SE : "${DMSTC_OUTNATN_SE}",
		 			NORMAL : "${NORMAL}"
		 		},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "EXCEL_ROW",
								headerText : "Excel Row",
								width : 80
							}, {
								dataField : "MAFU_NO",
								headerText : "Manufacturing NO.",
								width : 150
							}, {
								dataField : "PRDUCT_NM",
								headerText : "Brand Name",
								width : 250
							}, {
								dataField : "SERIUSFMNM_AT",
								headerText : "Serious",
								width : 100
							}, {
								dataField : "NORMAL",
								headerText : "Status",
								width : 80
							}, {
								dataField : "KIDS_NO",
								headerText : "KIDS No.",
								width : 150
							}, {
								dataField : "NORMAL_CODE",
								visible : false
							}, {
								dataField : "HRMFLNS_CASE_CODE",
								visible : false
							}, {
								dataField : "FOLLOW_NO",
								visible : false
							}, {
								dataField : "KIDS_REPORT_DTE",
								formatString : "yyyymmdd",
						 		dataType:"date",
						 		visible : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
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
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
		
		$(function(){
			initPageSetting();
			buttonActive();
		});
		
		function initPageSetting(){
			gridVerificationConfirm.createGrid();
		}
		
		function buttonActive(){
			$("#btnApply").click(function(){
				var item = AUIGrid.getGridData(gridVerificationConfirm.id);
				
				var param = [{
					DATA : item,
					FILENM : "${FILENM}"
				}];
				
				$.ajax({
		 		    url: "/sdb/e03/updateVerificationInfo.do",
		 		    type: "POST",
		 		    data: {data : JSON.stringify(param)},
		 		    async : false,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	alert(data.message);
		 					${callbackFunction}();
		 			    	layerClose();
		 		    	} else {
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
		 		});
			});
			
			$("#btnClose").click(function(){
				$.ajax({
		 		    url: "/sdb/e03/deleteTempVerificationInfo.do",
		 		    type: "POST",
		 		    data: {FILENM : "${FILENM}"},
		 		    async : false,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	layerClose();
		 		    	} else {
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
		 		});
			});
		}
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd1000">
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article class="conTitBox">
						<h5>Verification 확인</h5>
					</article>
					<article class="mgT15">
						<div id="gridVerificationConfirm" class="gridHeiSz10 grid_wrap tb01_2"></div>
					</article>
					<article class="mgT15">
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