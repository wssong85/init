<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />


<title></title>
<script type="text/javascript">

var grSubList = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grSubList'
	 	},
	 	proxy: {
	 		url: '/edc/k04/selectEdcSubInsttList.do',
		 	param:{},
	 		type: 'post',
	 		dataType: 'json',
	 		paging: false,
	 		autoLoad: true
	 	},
	 	gridPros: {
		    showRowNumColumn : true,
		    showRowCheckColumn : true,
		    
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
	  		  dataField : "INSTT_FORM_SN"
	 		, headerText : '<spring:message code="edc.gr.INSTT_FORM_SN" />'	//"기관양식순번"
		   	, editable : false
			, visible : false
	 	},{
			  dataField : "INSTT_NM"
	 		, headerText : '<spring:message code="edc.gr.INSTT_NM" />'	//'Site'
		   	, editable : false
			, visible : true
			, filter : {
				showIcon : true
			  }
	 	},{
		  	  dataField : "SUBJECT_NO"
  	 		, headerText : '<spring:message code="edc.gr.SUBJECT" />'	//"Subject"
  		   	, editable : false
  			, visible : true
  	 	},{
		  	  dataField : "FREEZING_STTUS_CODE"
  	 		, headerText : '<spring:message code="edc.gr.FREEZING_STTUS_CODE" />'	//'Freezing Status Code'
  		   	, editable : false
  			, visible : false
  	 	},{
  		  	  dataField : "FREEZING_STTUS_NM"
  	 		, headerText : '<spring:message code="edc.gr.FREEZING_STTUS_NM" />'	//'Freezing'
  		   	, editable : false
  			, visible : true
  			, filter : {
  				showIcon : true
  			  }
  	 	},{
	 		  dataField : "OPEN_QUERY"
	 		, headerText : '<spring:message code="edc.gr.OPEN_QUERY" />'	//'Open Query'
	 		, width : 200
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
	 		, headerText : '<spring:message code="edc.gr.SDV_COMPT_STTUS_NM" />'	//'SDV Completion'
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
			    url : '/edc/k04/selectEdcSubInsttList.do' ,//변경
			    type: 'post',
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						irbBasicInfo = data.result;
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
						
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader("#grSubList");
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
		var grid_param = new Object();
		grid_param.TASK_SN = $("#frm_main #TASK_SN").val();
		grSubList.proxy.param = grid_param;
		grSubList.createGrid();
		
		$("#btnGotoEDCK0401").click(function(){// 과제목록 화면 이동
			$("#frm_main").attr({
				action : './EDCK0401.do',
				method : 'post'
			}).submit();
		});	
		
	});
	
	function fnSubFrzngHndl(v){
		
		var items = AUIGrid.getCheckedRowItems(grSubList.id);
		if(items.length <= 0){
			alert("Subject를 선택해 주세요.");
			return;
		}
		var msg;
		if(v=="subFrzng"){
			msg = "Freezing 하시겠습니까?";
		}else{
			msg = "Freezing 해제 하시겠습니까?";
		}
		
		if(confirm(msg) == true){			
			//확인 진행
		}else{
			return;
		}
		
		var arJson = [];		
		
		// 선택된 행 아이템들(배열)		
		var editedItems = AUIGrid.getCheckedRowItems(grSubList.id);

		for(var i = 0; i < editedItems.length; i++) {
			var frzSttus = editedItems[i].item.FREEZING_STTUS_CODE;
			console.log("FREEZING_STTUS_CODE : "+frzSttus);	
			console.log(" v : "+v);
			if(v=="subFrzng"){
				if(frzSttus == "03"){
					alert("이미 Freezing 된 Subject가 포함되어 있습니다.");
					return;
				}
				
				editedItems[i].item.FREEZING_STTUS_CODE = "03";
			}else{
				if(frzSttus == "01"){
					alert("이미 Freezing 해제된 Subject가 포함되어 있습니다.");
					return;
				}
				editedItems[i].item.FREEZING_STTUS_CODE = "01";
			}
			arJson.push(editedItems[i].item);
		}		
		console.log("before class");
		console.log(JSON.stringify(arJson));
		$.ajax({
			  url : '/edc/k04/updateSubFrzEdcCrInsttFrm.do' ,
			  type: 'post',
// 			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {					
					  grSubList.load();			
				  } else {
					  AUIGrid.removeAjaxLoader(grSubList.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	}		
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (grSubList.id !== "undefined") {
			AUIGrid.resize(grSubList.id);
		}
	};

</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0403&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0403&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
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
								<li id="tab_menu1" class="tab_menu" onclick="fn_moveTab('EDCK0402');" ><spring:message code="edc.tab.SITE" /></li>
								<li id="tab_menu2" class="port_back tab_menu""><spring:message code="edc.tab.SUBJECT" /></li>
								<li id="tab_menu3" class="tab_menu" onclick="fn_moveTab('EDCK0404');" ><spring:message code="edc.tab.DB_FREEZING" /></li>
								<li id="tab_menu4" class="tab_menu" onCleck="fn_moveTab('EDCK0405');" ><spring:message code="edc.tab.HIST_LIST" /></li>
							</ul>
						</div>
						<!--상단 버튼 설정 -->
						<div class="conTitBtnR">
							<input type="button" id="btnSubFrzng" onClick="fnSubFrzngHndl('subFrzng')" value='<spring:message code="edc.btn.FREEZING" />'>
							<input type="button" id="btnSubUnFrzng" onClick="fnSubFrzngHndl('unSubFrzng')" value='<spring:message code="edc.btn.UNFREEZING" />'>
							<input type="button" id="btnGotoEDCK0401" value='<spring:message code="edc.btn.GO_TASK_LIST" />'>
						</div>
						<br>				
						<article class="mgT20">
							<div id="grSubList" class="gridHeiSz15 grid_wrap tb01_2"></div>
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