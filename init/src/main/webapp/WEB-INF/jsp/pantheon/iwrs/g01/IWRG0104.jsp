<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<script type="text/javascript">
		var gridRandomization = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grRandomization'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectRandomizationList.do',
		 		param: {TASK_SN : "${TASK_SN}", IWRS_VER : "${IWRS_VER}"},
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
								dataField : "SE_CODE",
								headerText : "구분",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "STTUS_CODE",
								headerText : "Status",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "CODE_TY",
								headerText : "배정방법",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "VISIT_LBL",
								headerText : "배정시점",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "TRGTER_CO",
								headerText : "대상자 수",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "CODE_CO",
								headerText : "Code 수",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "OPER_TY",
								headerText : "Type",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "FRST_CRTR",
								headerText : "생성자",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								headerText : "파일"
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
			init();
			event();
		});
		
		function init(){
			gridRandomization.createGrid();
		}
		
		function event(){
			$('#tabVersionList').click(function(){
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
				f.setAttribute("action", "/iwrs/g01/IWRG0102.do");
				document.body.appendChild(f);
				f.submit();
			});
						
			$('#tabIpList').click(function(){
				
			});
			
			$('#tabScreenDesign').click(function(){
				
			});
			
			$("#btnCodeGeneration").click(function(){
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
				obj.setAttribute("name", "IWRS_VER");
				obj.setAttribute("value", "${IWRS_VER}");
				f.appendChild(obj);
				
				var obj;
				obj = document.createElement("input");
				obj.setAttribute("type", "hidden");
				obj.setAttribute("name", "TASK_NM");
				obj.setAttribute("value", "${TASK_NM}");
				f.appendChild(obj);
				
				f.setAttribute("method", "post");
				f.setAttribute("action", "/iwrs/g01/IWRG0105.do");
				document.body.appendChild(f);
				f.submit();
			});
		}
		
		$(window).resize(function(){
			if (gridRandomization.id) {
				AUIGrid.resize(gridRandomization.id);
			}
		});
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=IWRG0104&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=IWRG0104&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
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
								<li id="tabVersionList" class="tab_menu">목록</li>
								<li id="tabRandomList" class="port_back tab_menu">Randomization</li>
								<li id="tabIpList" class="tab_menu">IP</li>
								<li id="tabScreenDesign" class="tab_menu">화면디자인</li>
							</ul>
						</div>
						<article style="overflow:hidden;">
							<div class="conTitBtnL">
								<h5>${ TASK_NM }</h5>
							</div>
							<div class="conTitBtnR">									
								<input type="button" id="btnCodeGeneration" value="코드생성">
							</div>
						</article>
						<article class="mgT16">
							<div id="grRandomization" class="gridHeiSz15 grid_wrap tb01_2"></div>
							<input type="hidden" id="hTaskSn" value="" />
							<input type="hidden" id="hIwrsVersion" value="" />
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>