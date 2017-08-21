<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<style>
		.grid_wrap a{color: #5570e6 !important; text-decoration:underline; font-weight: bold;}
		.grid_wrap a:hover{color: #5570e6 !important; text-decoration:underline; cursor:pointer;}
	</style>
	<script type="text/javascript">
	var gridDelivery = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grDelivery',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grDelivery'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/c01/selectDeliveryInfo.do',
		 		param: {},
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
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "INSTT_CODE",
								headerText : "Site",
						 		visible : false
							}, {
								dataField : "INSTT_NAME",
								headerText : "Site",
						 		filter : {
						 			showIcon : true
						 		},
								width:130
							}, {
								dataField : "DLVY_RQESTDE",
								headerText : "요청일시",
								formatString : "yyyy-mm-dd HH:MM:ss",
						 		dataType:"date",
						 		filter : {
						 			showIcon : true
						 		},
								width:140
							}, {
								dataField : "DLVY_HOPEDE",
								headerText : "배송희망일",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								width:100,
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "　";
									var template = "";
									if(("${ROLE}" == "CRA" || "${ROLE}" == "CRM") && (item.DLVY_STTUS_CODE == "02")){
										template = '<a href="#" onclick="javascript:showCraPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
									}else{
										template = value;
									}
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								},
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "DLVY_BGNDE",
								headerText : "배송일",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								width:100,
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "　";
									if("${ROLE}" == "IPM" && item.DLVY_STTUS_CODE == "04"){
										var template = '<a href="#" onclick="javascript:showConfirmPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
									}else{
										var template = value;
									}
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								},
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "DLVY_COMPTDE",
								headerText : "배송완료일",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								width:100,
								
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "　";
									if("${ROLE}" == "PHARM" && item.DLVY_STTUS_CODE == "06"){
										var template = '<a href="#" onclick="javascript:showInsulPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
									}else{
										var template = value;
									}
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								},
						 		filter : {
						 			showIcon : true
						 		},
						 		width:100
							}, {
								dataField : "DLVY_CNCDE",
								headerText : "배송취소일",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								width:100,
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "　";
									var template = '<a href="#" onclick="javascript:showDeliCancelPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								},
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IP_CNT",
								headerText : "IP수량",
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "";
									var template = "";
									if(("${ROLE}" == "IPM" && item.DLVY_STTUS_CODE == "02") || ("${ROLE}" == "PHARM" && item.DLVY_STTUS_CODE == "04")){
										template = '<a href="#" onclick="javascript:showDeliConfirmPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';	
									}else{
										template = value;
									}
									
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								dataField : "DLVY_REQUST_COMMENT",
								headerText : "배송메모",
								width:150
							}, {
								dataField : "DLVY_REQUST_OCCRRNC_NM",
								headerText : "배송종류",
						 		filter : {
						 			showIcon : true
						 		},
						 		width:100,
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "";
									var template = "";
									if((("${ROLE}" == "CRA" || "${ROLE}" == "CRM") && item.DLVY_STTUS_CODE == "01")){
										template = '<a href="#" onclick="javascript:showCraPopup(\'' + item.DLVYMANAGE_CODE + '\');return false;">' + value + '</a>';	
									}else{
										template = value;
									}
									
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								dataField : "DLVY_STTUS_NM",
								headerText : "배송상태",
						 		filter : {
						 			showIcon : true
						 		},
						 		width:100,
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "";
									var template = "";
									if((("${ROLE}" == "CRA" || "${ROLE}" == "CRM") && item.DLVY_STTUS_CODE == "02")){
										template = '<a href="#" onclick="javascript:showCancelPopup(\'' + item.DLVYMANAGE_CODE + '\', \'02\');return false;">' + value + '</a>';	
									}else if((("${ROLE}" == "IPM") && item.DLVY_STTUS_CODE == "04")){
										template = '<a href="#" onclick="javascript:showCancelPopup(\'' + item.DLVYMANAGE_CODE + '\', \'04\');return false;">' + value + '</a>';
									}else{
										template = value;
									}
									
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								headerText : "출하요청서",
								width:100,
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									var template = "";
									if(item.DLVY_STTUS_CODE == "02" || item.DLVY_STTUS_CODE == "03" || item.DLVY_STTUS_CODE == "04" || item.DLVY_STTUS_CODE == "06"){
										template = '<a href="#" onclick="javascript:deliveryRequest(\'' + item.DLVYMANAGE_CODE + '\', \'' + item.INSTT_CODE + '\');return false;">출력</a>';
									}
									
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								headerText : "IP인수인계서",
								width:100,
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									var template = "";
									if(item.DLVY_STTUS_CODE == "03" || item.DLVY_STTUS_CODE == "04" || item.DLVY_STTUS_CODE == "06"){
										template = '<a href="#" onclick="javascript:ipReceipt(\'' + item.DLVYMANAGE_CODE + '\', \'' + item.INSTT_CODE + '\');return false;">출력</a>';
									}
									
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								headerText : "Audit Trail",
								width:100
							}, {
								dataField : "DLVYMANAGE_CODE",
								headerText : "배송코드",
								visible : false
							}, {
								dataField : "DLVY_REQUST_OCCRRNC_CODE",
								visible : false
							}, {
								dataField : "DLVY_STTUS_CODE",
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
		 		    	if(data.result == "ok") {
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
			gridDelivery.createGrid();
			pageSetting();
			buttonActive();
		});
		
		function pageSetting(){
			if("${ROLE}" != "CRA" && "${ROLE}" != "CRM" && "${ROLE}" != "PHARM"){
				$("#btnDeliReq").hide();
			}
		}
				
		function buttonActive(){
			$("#btnDeliReq").click(function(){
				
				if("${ROLE}" == "PHARM"){
					showPharmPopup();
				}else{ //CRA, CRM
					showCraPopup();
				}
			});
			
			$("#btnIpDeliDoc").click(function(){
			
			});
			
			$("#btnDown").click(function(){
				var data = AUIGrid.getGridData(gridDelivery.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "Delivery_List"
					};
					AUIGrid.setProperty(gridDelivery.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(gridDelivery.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
			
			$("#btnTest").click(function(){
				var param = {
						MRD_NAME : "DELVIERY_REQUEST.mrd",
						DLVYMANAGE : "ACWkeQHdsEzhzpnLIksRYVEoirOOWszh",
						INSTT_CODE : "1"
				};

				var f = document.createElement("form");
				
				$.each(param, function(key, value){
					var obj;
					obj = document.createElement("input");
					obj.setAttribute("type", "hidden");
					obj.setAttribute("name", key);
					obj.setAttribute("value", value);
					f.appendChild(obj);	
				});
				
				window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
				
				f.setAttribute("method", "post");
				f.setAttribute("action", "/com/system/CommonRD.do");
				f.setAttribute("target", "popForm");
				document.body.appendChild(f);
				f.submit();
			});
			
			$("#btnTest2").click(function(){
				$.ajax({
					type : "POST",
					async : false,
					data : {},
					url : "/iwrs/g01/selectTest.do",
					success :function(data){
						
					}
				});
			});
		}
		
		function deliveryRequest(dlvymanage, insttCode){
			var param = {
					MRD_NAME : "DELVIERY_REQUEST.mrd",
					DLVYMANAGE : dlvymanage,
					INSTT_CODE : insttCode
			};

			var f = document.createElement("form");
			
			$.each(param, function(key, value){
				var obj;
				obj = document.createElement("input");
				obj.setAttribute("type", "hidden");
				obj.setAttribute("name", key);
				obj.setAttribute("value", value);
				f.appendChild(obj);	
			});
			
			window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/com/system/CommonRD.do");
			f.setAttribute("target", "popForm");
			document.body.appendChild(f);
			f.submit();
		}
		
		function ipReceipt(dlvymanage, insttCode){
			var param = {
					MRD_NAME : "IP_RECEIPT.mrd",
					DLVYMANAGE : dlvymanage,
					INSTT_CODE : insttCode
			};

			var f = document.createElement("form");
			
			$.each(param, function(key, value){
				var obj;
				obj = document.createElement("input");
				obj.setAttribute("type", "hidden");
				obj.setAttribute("name", key);
				obj.setAttribute("value", value);
				f.appendChild(obj);	
			});
			
			window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/com/system/CommonRD.do");
			f.setAttribute("target", "popForm");
			document.body.appendChild(f);
			f.submit();
		}
		
		$("#btnTest2").click(function(){
			$.ajax({
				type : "POST",
				async : false,
				data : {},
				url : "/iwrs/g01/selectTest.do",
				success :function(data){
					
				}
			});
		});
		
		function showPharmPopup(){
			mkLayerPopupOpen("/iwrs/c01/popupIwrc0102.do");
		}
		
		function showCraPopup(dlvy_code){
			if(dlvy_code != ""){
				var param = {
					dlvymanage_code : dlvy_code,
					PAGE_ID : "IWRC0101"
				};
				mkLayerPopupOpen("/iwrs/c01/popupIwrc0103.do", param);
			}else{
				mkLayerPopupOpen("/iwrs/c01/popupIwrc0103.do");
			}
		}
		
		function showDeliConfirmPopup(dlvy_code){
			if("${ROLE}" == "PHARM"){
				showInsulPopup(dlvy_code);
			}else{
				showConfirmPopup(dlvy_code);
			}
		}
		
		function showConfirmPopup(dlvy_code){
			var param = {
					dlvymanage_code : dlvy_code
				};
			mkLayerPopupOpen("/iwrs/c01/popupIwrc0104.do", param);
		}
		
		function showCancelPopup(dlvy_code, type){
			var param = {
					dlvymanage_code : dlvy_code,
					type : type,
					layer : "0"
			};
			mkLayerPopupOpen("/iwrs/c01/popupIwrc0105.do", param);
		}
		
		function showDeliCancelPopup(dlvy_code){
			var param = {
					dlvymanage_code : dlvy_code
				};
			mkLayerPopupOpen("/iwrs/c01/popupIwrc0106.do", param);
		}
		
		function showInsulPopup(dlvy_code){
			var param = {
					dlvymanage_code : dlvy_code
				};
			mkLayerPopupOpen("/iwrs/c01/popupIwrc0107.do", param);
			AUIGrid.resize(gridInsu.id);
		}
		
		window.onresize = function() {
			if (typeof gridDelivery.id !== "undefined") {
				AUIGrid.resize(gridDelivery.id);
			}
		};
	</script>
</head>
<body>
	<form id="frSubmit" action="" methos="">
	</form>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRC0101&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRC0101&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>${progrmMap.UPPER_MENU_NM}</li>
	                        <li>${progrmMap.MENU_NM}</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="conTitBox">
<!-- 							<h5>배송현황</h5> -->
						</article>
						<article class="conTitBtnR">
<!-- 							<input type="button" id="btnIpDeliDoc" value="IP수불문서" /> -->
							<input type="button" id="btnDeliReq" value="배송요청" />
							<input type="button" id="btnDown" value="엑셀" />
							<input type="button" id="btnTest" value="테스트" />
<!-- 							<input type="button" id="btnTest2" value="테스트2" /> -->
						</article>
						<article class="mgT16">
							<div id="grDelivery" class="gridHeiSz14 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>