<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<script type="text/javascript">
		var gridIwrsDesignList = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grIwrsDesignList'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectIwrsDesignList.do',
		 		param: {TASK_SN : "${TASK_SN}"},
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
				reverseRowNum : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "IWRS_VER",
								headerText : "IWRS Ver.",
						 		filter : {
						 			showIcon : true
						 		},
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									var template = "<a href='#' onclick='javascript:goRandomization(\"" + item.TASK_SN + "\", \"" + item.IWRS_VER + "\");return false;'>" + value + "</a>";
									
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								dataField : "CHANGE_RESN",
								headerText : "변경사유",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "APPLC_DE",
								headerText : "적용일",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "LAST_UPDDE",
								headerText : "수정일",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "FRST_CRTR",
								headerText : "작성자",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "PROGRS_CODE",
								headerText : "상태",
						 		filter : {
						 			showIcon : true
						 		}
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
			gridIwrsDesignList.createGrid();
			$("#hTaskSn").val("${TASK_SN}");
			
			$("#btnNew").click(function(){
				var param = {
						TASK_SN : "${TASK_SN}",
						callbackFunction : "goRandomizationCallback"
				};
				mkLayerPopupOpen('/iwrs/g01/popupIWRG0103.do', param);
			});
			
			$("#btnApprovalRequest").click(function(){
				var param = {
						REQUST_NM : "IWRS 디자이너 승인요청",
						callbackFunction : "approvalRequest"
				};
				mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', param, 1);
			});
			
			$("#btnApproval").click(function(){
				
			});
			
			$("#btnApprovalHistory").click(function(){
				
			});
			
			$('#tabVersionList').click(function(){
				
			});
			
			$('#tabRandomList').click(function(){
				var f = document.createElement("form");
				
				var obj;
				obj = document.createElement("input");
				obj.setAttribute("type", "hidden");
				obj.setAttribute("name", "TASK_SN");
				obj.setAttribute("value", "${TASK_SN}");
				f.appendChild(obj);
				
				var obj;
				obj = document.createElement("input");
				obj.setAttribute("type", "hidden");
				obj.setAttribute("name", "TASK_NM");
				obj.setAttribute("value", "${TASK_NM}");
				f.appendChild(obj);
				
				f.setAttribute("method", "post");
				f.setAttribute("action", "/iwrs/g01/IWRG0104.do");
				document.body.appendChild(f);
				f.submit();
			});
			
			$('#tabIpList').click(function(){
				
			});
			
			$('#tabScreenDesign').click(function(){
				
			});
		});
		
		function goRandomization(taskSn, iwrsVer){
			var f = document.createElement("form");
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "TASK_SN");
			obj.setAttribute("value", taskSn);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "IWRS_VER");
			obj.setAttribute("value", iwrsVer);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "TASK_NM");
			obj.setAttribute("value", "${TASK_NM}");
			f.appendChild(obj);
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/iwrs/g01/IWRG0104.do");
			document.body.appendChild(f);
			f.submit();
		}
		
		function goRandomizationCallback(value){
			var f = document.createElement("form");
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "TASK_SN");
			obj.setAttribute("value", value.TASK_SN);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "IWRS_VER");
			obj.setAttribute("value", value.IWRS_VER);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "TASK_NM");
			obj.setAttribute("value", "${TASK_NM}");
			f.appendChild(obj);
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/iwrs/g01/IWRG0104.do");
			document.body.appendChild(f);
			f.submit();
		}
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
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
					<div class="conBoxInner" style="min-height:900px;">
						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="tabVersionList" class="port_back tab_menu">목록</li>
								<li id="tabRandomList" class="tab_menu">Randomization</li>
								<li id="tabIpList" class="tab_menu">IP</li>
								<li id="tabScreenDesign" class="tab_menu">화면디자인</li>
							</ul>
						</div>
						<article class="conTitBox">
							<h5>${TASK_NM }</h5>
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnNew" value="신규" />
							<input type="button" id="btnApprovalRequest" value="승인요청" />
							<input type="button" id="btnApproval" value="승인" />
							<input type="button" id="btnApprovalHistory" value="승인이력" />
						</article>
						<article class="mgT16">
							<div id="grIwrsDesignList" class="gridHeiSz15 grid_wrap tb01_2"></div>
							<input type="hidden" id="hTaskSn" value="" />
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>