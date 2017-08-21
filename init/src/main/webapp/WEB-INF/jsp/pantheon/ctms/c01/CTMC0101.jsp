<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript" src="<c:url value='/js/pantheon/edc/EDC.js'/>"></script>
<title>과제별 수탁기관</title>

<script type="text/javascript">
var _user = {
	'USER_ID': '${loginMap.USER_ID}'
};

var gridInvest = {
		  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
		  id: '',
		  //AUI그리드 생성할 div 및 페이징 옵션
		  div: {
		    gridDiv: '#grid_invest',
		    paging: {
		      pagingDiv: 'grid_paging',
		      totalRowCount: 500,
		      rowCount: 10,
		      pageButtonCount: 4,
		      currentPage: 1,
		      totalPage: 0,
		    },
		  },
		  //데이터 연계 옵션
		  proxy: {
		    url: '/ctms/c01/selectInvestInfoList.do',
		    param: {},
		    type: 'post',
		    dataType: 'json',
		    //페이징 true, false 로 지정
		    paging: true,
		    //처음 시작시 데이터 로딩
		    autoLoad: false,
		  },
		  //AUI 그리드 옵션
		  gridPros: {
		    // 페이징 사용
		    //usePaging : true,
		    
		    showRowNumColumn : true,
		    showRowCheckColumn : false,

		    showStateColumn    : true,
		    
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    
		    enableColumnResize : true,
		    enableMovingColumn : true,
		    editable : true,
		    enableFilter : true,
		    
// 		    showFooter : true,

		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    //selectionMode : "multipleRows",

		    displayTreeOpen : true,

		  },
		  //AUI 그리드 레이아웃
		  columnLayout : [
    		   {
    		   	  dataField : "TASK_SN"
    		   	, headerText : "TASK_SN"
    		   	, visible : false
    		   	, editable : false
    		   	//width: 120
    		   }
    		   ,{
    		   	  dataField : "TASK_NO"
    		   	, headerText : "TASK_NO"
    		   	, editable : false
    			, width: 120
    			, visible : false
    		   }
    		   ,{
     		   	  dataField : "USER_ID"
     		   	, headerText : "USER_ID"
     		   	, editable : false
     			, width: 120
     			, visible : false
     		   }
    		   ,{
     		   	  dataField : "INSTT_NAME"
     		   	, headerText : '<spring:message code="ctms.gr.INSTT_NAME" />'
     		   	, editable : false
     			, width: 220
     			, visible : true
     			, filter : {
      				showIcon : true
      			  }
     		   }
    		   ,{
       		   	  dataField : "USER_NM"
       		   	, headerText : '<spring:message code="ctms.gr.RSRCHUSER" />'
       		   	, editable : false
       		    , visible : true
       		   	, width: 100
	       		, filter : {
	   				showIcon : true
	   			  }
       		   }
    		   ,{
      		   	  dataField : "INSTT_CODE"
      		   	, headerText : '<spring:message code="ctms.gr.INSTT_CODE" />'
      		   	, editable : false
      		   	, width: 100
      		   	, filter : {
      				showIcon : true
      			  }
      		   }
    		   ,{
     		   	  dataField : "TASK_NM"
     		   	, headerText : '<spring:message code="ctms.gr.TASK_NAME" />'
     		   	, editable : false
     			, width: 250
     			, visible : true
     			, filter : {
      				showIcon : true
      			  }
     		   }
    		   ,{
     		   	  dataField : "CNTRCT_SN"
     		   	, headerText : '<spring:message code="ctms.gr.CNTRCT_CODE" />'
     		   	, editable : false
     			, width: 100
     			, visible : true
     			, filter : {
      				showIcon : true
      			  }
     		   }
    		   ,{
      		   	  dataField : "DOMN_URL"
      		   	, headerText : '<spring:message code="ctms.gr.SITE" />'
      		   	, editable : false
//       			, width: 100
      			, visible : true
          		, filter : {
      				showIcon : true
      			  }
      		   }
		  ]
		  //AUI 그리드 생성
		  , createGrid: function() {
			    var me = this;
			    
			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			 	// 푸터 객체 세팅
				AUIGrid.setFooter(me.div.gridDiv, me.footerObject);

			    me.binding();
	
			    if(me.proxy.autoLoad) {
			    	console.log("me.load()....");
					me.load();
			    }
		  },

		  //AUI 그리드 이벤트 
		  binding: function() {
			var me = this;

			AUIGrid.bind(me.id, "cellEditBegin", function(event) {

			});

			AUIGrid.bind(me.id, "cellEditEnd", function(event) {

				switch(event.type) {
					case "cellEditEnd" :
					if(event.dataField == "INSTT_NAME") {
					}
					break;

				}

			});

			AUIGrid.bind(me.id, "cellDoubleClick", function(event) {

			});

		  },
		  //AUI 그리드 데이터 요청
		  init: function(v1, v2) {
			  console.log("me.init()....");
		 		var me = this;
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    //dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {
		 		    		me.createGrid();
		 		    		AUIGrid.setGridData(me.id, []);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
		 		});
		  },
		  load: function(v1, v2) {
		 		var me = this;
		 		
		 		AUIGrid.showAjaxLoader(me.id);

		 		var searchArr = {
		 				  SEARCH_TYPE : $("#SEARCH_TYPE").val()
		 		        , SEARCH_COND : $("#SEARCH_COND").val()
		 		    };

				$.ajax({
					  url : me.proxy.url,
					  type: me.proxy.type,
					  //contentType: "application/json; charset=UTF-8",
					  data : searchArr,
					  success : function(data, textStatus, jqXHR) {

						  if(data.success) {
							  AUIGrid.removeAjaxLoader(me.id);
							  AUIGrid.setGridData(me.id, data.result);
							  AUIGrid.setSelectionByIndex(me.id, 0);
						  } else {
							  AUIGrid.removeAjaxLoader("#grid_invest");
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

	gridInvest.createGrid();

	$('#btnSearch').click(function(){	 //수정여부
		gridInvest.load();
	});

});

window.onresize = function() {
	// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
	if (typeof gridInvest.id !== "undefined") {
		AUIGrid.resize(gridInvest.id);
	}
};

</script>
</head>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMC0101&UPPER_MENU_ID=CTMC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMC0401&UPPER_MENU_ID=CTMC" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
    <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>Investigational Infomation</h3>

                <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Report</a></li>
                    </ul>
                </nav>
            </article>

            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>${TASK_NO}</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 전체메뉴라인 시작-->        
                    <article class="conTitBtn">

                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
							<select id="SEARCH_TYPE" class="select">
								<option value="1" ><spring:message code="ctms.gr.INSTT_NAME" /></option>
								<option value="2" ><spring:message code="ctms.gr.RSRCHUSER" /></option>
								<option value="3" ><spring:message code="ctms.gr.CNTRCT_CODE" /></option>
							</select>
                            <input type="text" id="SEARCH_COND" name="SEARCH_COND" class="pdR15"><input type="button" class="btn mgL3" id="btnSearch" value='<spring:message code="button.search" />'>
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <!-- div class="conTitBtnR">
                            <input type="button" id="btnAddrow"   value="행추가">
                            <input type="button" id="btnRowDel"   value="행삭제">
                            <input type="button" id="btnUpdateYN" value="수정">
                            <input type="button" id="btnSave"     value="저장">
                        </div-->
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_invest" class="grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>

            </section>
            <!-- 컨텐츠박스 끝-->

        </div>
    </section>

</div>

</body>
</html>