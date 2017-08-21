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
	var gridIpList = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'gridIpList',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridIpList'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/c01/selectDeliveryIpCode.do',
		 		param: {DLVYMANAGE_CODE:'${DLVYMANAGE_CODE}', IP_TYPE : '${IP_TYPE}'},
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
				'showRowNumColumn' : false,
			    enableMovingColumn : false,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "IP_TYPE",
								headerText : "IP TYPE"
							}, {
								dataField : "IP_CODE",
								headerText : "IP CODE"
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
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
	
		$(function(){
			pageInit();
			buttonActive();
		});
		
		function pageInit(){
			gridIpList.createGrid();
		}
		
		function buttonActive(){
			$("#btnClose1").click(function(){
				layerClose(1);
			});
			
			$("#btnDown1").click(function(){
				var data = AUIGrid.getGridData(gridIpList.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "Delivery_List"
					};
					AUIGrid.setProperty(gridIpList.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(gridIpList.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
		}
		
		window.onresize = function() {
			if (typeof gridIpList.id !== "undefined") {
				AUIGrid.resize(gridIpList.id);
			}
		};
	</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup popup1 wd500">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<article class="conTitBox">
						<h5>배송IP확인</h5>
					</article>
					<article class="conTitBtnR">
						<input type="button" id="btnDown1" value="엑셀" />
					</article>
					<article class="mgT5">
						<div id="gridIpList" class="gridHeiSz10 grid_wrap tb01_2"></div>
					</article>
					<article class="mgT10">
						<div style="text-align:center;">
							<input type="button" id="btnClose1" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>
</body>
</html>