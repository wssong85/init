<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />


<title></title>
<style>
.edc_column_style {
	color: #5570e6;
	text-decoration: underline;
	font-weight: bold;
}

.edc_column_style:hover {
	text-decoration: underline;
	cursor: pointer;
}
</style>
<script type="text/javascript">


var grTaskList = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grTaskList'
	 	},
	 	proxy: {
	 		url: '/edc/k04/selectEdcTaskList.do',
		 	param:{
	 		},
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

		    displayTreeOpen : false
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
	  		  dataField : "TASK_SN"
	 		, headerText : "TASK_SN"
		   	, editable : false
			, visible : false
	 	},{
	  		  dataField : "TASK_NO"
	 		, headerText : '<spring:message code="edc.gr.TASK_NO" />'	//과제번호
		   	, editable : false
			, visible : true
			, style : "edc_column_style"
				, filter : {
					showIcon : true
				  }
	 	},{
			  dataField : "TASK_NM"
	 		, headerText : '<spring:message code="edc.gr.TASK_NM" />'	//'과제명'	
		   	, editable : false
			, visible : true
			, filter : {
				showIcon : true
			  }
	 	},{
	 		  dataField : "TASK_TY_NM"
	 		, headerText : '<spring:message code="edc.gr.TYPE" />'	//'종류'	
		   	, editable : false
			, visible : true
			, filter : {
				showIcon : true
			  }
	 	},{
	 		  dataField : "OPEN_QUERY"
	 		, headerText : '<spring:message code="edc.gr.OPEN_QUERY" />'	//'Open Query'
		   	, editable : false
			, visible : true
			, filter : {
				showIcon : true
			  }
	 	},{
			  dataField : "SDV_STTUS_NM"
	 		, headerText : '<spring:message code="edc.gr.SDV" />'	//'SDV'
		   	, editable : false
			, visible : true
			, filter : {
				showIcon : true
			  }
	 	},{
	 		  dataField : "SDV_COMPT_STTUS_NM"
	 		, headerText : '<spring:message code="edc.gr.SDV_COMPT_STTUS_NM" />'	// 'SDV Completion'
		   	, editable : false
			, visible : true
			, filter : {
				showIcon : true
			  }
	 	},{
	  		  dataField : "FREEZING_STTUS_NM"
	 		, headerText : '<spring:message code="edc.gr.FREEZING_STTUS_NM" />'	// 'Freezing'
		   	, editable : false
			, visible : true
			, filter : {
				showIcon : true
			  }
	 	}],
	 	
	 	//AUI 그리드 생성
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		gridMainID = me.id;
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	
	 	//AUI 그리드 이벤트 
	 	binding: function() {
	 		var me = this;
	 		
	 		AUIGrid.bind(me.id, "cellClick", function(event) {
	 			if (event.dataField == "TASK_NO") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					console.log("rowItem.TASK_SN : "+rowItem.TASK_SN);
					$("#frm_main #TASK_SN").val(rowItem.TASK_SN);
					$("#frm_main #TASK_NO").val(rowItem.TASK_NO);
					$("#frm_main").attr({
						action : './EDCK0402.do',
						method : 'post'
					}).submit();
				}
			});
	 		
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
			    url : '/edc/k04/selectEdcTaskList.do' ,//변경
			    type: 'post',
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						irbBasicInfo = data.result;
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
						
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader("#grTaskList");
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
		grTaskList.createGrid();
		
		$('#btnEdcTaskListSearch').click(function() {
			
			var params = {
			};
			
			params.TASK_NO = $('#txtEdcTaskNo').val();
			params.TASK_NM = $('#txtEdcTaskNm').val();
			
			grTaskList.proxy.param = params;
			grTaskList.load();
		});
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (grTaskList.id !== "undefined") {
			AUIGrid.resize(grTaskList.id);
		}
	};

</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0401&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0401&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
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
						<!-- 검색 -->
						<article class="mgB40">
							<span style="font-family: 'NanumGothicBold';"><spring:message code="edc.gr.TASK_NM" /> : </span> 
							<input type="text" id="txtEdcTaskNm" style="width:200px"/>
							<span style="font-family: 'NanumGothicBold';"><spring:message code="edc.gr.TASK_NO" /> : </span>
							<input type="text" id="txtEdcTaskNo" style="width:200px"/>
							<input type="button" id="btnEdcTaskListSearch" class="btnmgL3" value='<spring:message code="button.search" />'>
						</article>		
						<article class="mgT20">
							<div id="grTaskList" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>	
						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="">
							<input type="hidden" id="TASK_NO" name="TASK_NO" value="">
						</form>
					</div>
				</section>	
			</div>
		</section>
	</div>
</body>
</html>