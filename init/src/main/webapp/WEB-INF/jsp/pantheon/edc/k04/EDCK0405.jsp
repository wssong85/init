<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />


<title></title>
<script type="text/javascript">
	var rsltData;
	var frzSttCd;
	
	var grFrzngHist = {
		 	id: '',
		 	div: {
		 		gridDiv: '#grFrzngHist'
		 	},
		 	proxy: {
		 		url: '/edc/k04/selectEdcFrzngHist.do',
			 	param:{},
		 		type: 'post',
		 		dataType: 'json',
		 		paging: false,
		 		autoLoad: true
		 	},
		 	gridPros: {
			    showRowNumColumn : true,
			    showRowCheckColumn : false,
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    
		 	    editable : false,
			    enableFilter : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "singleRows",

			    displayTreeOpen : false,
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
		  		  dataField : "TASK_SN"
		 		, headerText : "TASK_SN"
			   	, editable : false
				, visible : false
		 	},{
		  		  dataField : "HIST_SN"
		 		, headerText : "HIST_SN"
			   	, editable : false
				, visible : false
		 	},{
		  		  dataField : "REQUST_NO"
		 		, headerText : "REQUST_NO"
			   	, editable : false
				, visible : false
		 	},{
				  dataField : "REQUST_NM"
		 		, headerText : '<spring:message code="edc.gr.STTUS" />'//'상태'
			   	, editable : false
				, visible : true
		 	},{
		 		  dataField : "RQESTER_ID"
		 		, headerText : '<spring:message code="edc.gr.RQESTER_ID" />'//'요청자'
		 		, width : 200
			   	, editable : false
				, visible : true
				, filter : {
					showIcon : true
				  }
		 	},{
				  dataField : "FRST_CREDE"
		 		, headerText : '<spring:message code="edc.gr.FRST_CREDE" />'//'요청일'
			   	, editable : false
				, visible : true
		 	},{
		 		  dataField : "SANCTN_DT"
		 		, headerText : '<spring:message code="edc.gr.SANCTN_DT" />'//'승인일'
			   	, editable : false
				, visible : true
		 	}],
		 	
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	
		 	//AUI 그리드 이벤트 
		 	binding: function() {
		 		var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				});

		 	},
		 	load: function(v1, v2) {
		 		var me = this;
		 		
		 		if(me.proxy.paging && !v1 && !v2) {
		 			me.proxy.param.page = me.div.paging.currentPage;		
		 			me.proxy.param.count= me.div.paging.rowCount;		
		 		}
		 		
		 		if(v1 && v2) {
		 			me.proxy.param.page = v2;	
		 			me.div.paging.currentPage = v2;
		 			me.proxy.param.count = v1;		
		 			me.div.paging.rowCount = v1;		
		 		}
		 		
		 		AUIGrid.showAjaxLoader(me.id);

		 		$.ajax({
				    url : '/edc/k04/selectEdcFrzngHist.do' ,//변경
				    type: 'post',
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
							AUIGrid.setGridData(me.id, data.result);
							irbBasicInfo = data.result;
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
							
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader("#grFrzngHist");
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
		 		});
		 	}
		};

	
	$(document).ready(function() {
		console.log("frm TASK_SN : "+$("#frm_main #TASK_SN").val());
		var grid_param = new Object();
		grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
		grFrzngHist.proxy.param = grid_param;
		grFrzngHist.createGrid();
		
		$("#btnGotoEDCK0401").click(function(){// 과제목록 화면 이동
			$("#frm_main").attr({
				action : './EDCK0401.do',
				method : 'post'
			}).submit();
		});
	});
	
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (grFrzngHist.id !== "undefined") {
			AUIGrid.resize(grFrzngHist.id);
		}
	};

</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0405&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0405&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${ progrmMap.MENU_NM }</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>${ progrmMap.UPPER_MENU_NM }</li>
							<li>${ progrmMap.MENU_NM }</li>
						</ul>
					</nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">

						<!--tab 설정 -->
						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_menu1" class="tab_menu" onCleck="fn_moveTab('EDCK0402');"><spring:message code="edc.tab.SITE" /></li>
								<li id="tab_menu2" class="tab_menu" onclick="fn_moveTab('EDCK0403');"><spring:message code="edc.tab.SUBJECT" /></li>
								<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0404');" ><spring:message code="edc.tab.DB_FREEZING" /></li>
								<li id="tab_menu4" class="port_back tab_menu""><spring:message code="edc.tab.HIST_LIST" /></li>
							</ul>
						</div>
						<!--상단 버튼 설정 -->
						<div class="conTitBtnR">
							<input type="button" id="btnGotoEDCK0401" value='<spring:message code="edc.btn.GO_TASK_LIST" />'>
						</div>
						<br>				
						<article class="mgT20">
							<div id="grFrzngHist" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>	

						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
						</form>
					</div>
				</section>	
			</div>
		</section>
	</div>
</body>
</html>