<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>



<script type="text/javascript">



var testData_01 =[
{
	  "과제번호":"CJ_ASD_001",
	  "과제명":"과제명",
	  "종류":"임상",
	  "상태":"진행중",
	  "Open query":"11",
	  "SDV":"완료",
	  "SDV Completion":"완료",
	  "Freezing":"부분완료"
	  
}, {
	  "과제번호":"CJ_FFF_001",
	  "과제명":"과제명",
	  "종류":"임상",
	  "상태":"진행중",
	  "Open query":"11",
	  "SDV":"완료",
	  "SDV Completion":"완료",
	  "Freezing":"부분완료"
}, {
	  "과제번호":"CJ_VBN_001",
	  "과제명":"과제명",
	  "종류":"임상",
	  "상태":"진행중",
	  "Open query":"11",
	  "SDV":"완료",
	  "SDV Completion":"완료",
	  "Freezing":"부분완료"
}];


var myGridOption_01 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_01'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
	usePaging : true,
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "과제번호",
	    headerText : "과제번호"
  },{
	    dataField : "과제명",
	    headerText : "과제명"
  },{
	    dataField : "종류",
	    headerText : "종류"
  },{
	    dataField : "상태",
	    headerText : "상태"
  },{
	    dataField : "Open query",
	    headerText : "Open query"
  },{
	    dataField : "SDV",
	    headerText : "SDV"
  },{
	    dataField : "SDV Completion",
	    headerText : "SDV Completion"
  },{
	    dataField : "Freezing",
	    headerText : "Freezing"
  }],


  
  
  
  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();

 	window.setTimeout(function(){
		AUIGrid.resize(me.id);
	}, 0.5);

    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_01);
  }
};


var testData_02 =[
{
	  "Pooling 명":"Pooling_003",
	  "Pooling 과제":"CJ_AAA_123 Import_001",
	  "생성일":"2016-12-12",
	  "생성자":"부분완료"
}, {
	  "Pooling 명":"Pooling_002",
	  "Pooling 과제":"CJ_AAA_123 CJ_AVB_116",
	  "생성일":"2016-12-12",
	  "생성자":"부분완료"
}, {
	  "Pooling 명":"Pooling_001",
	  "Pooling 과제":"CJ_AAA_123",
	  "생성일":"2016-12-12",
	  "생성자":"부분완료"
}];


var myGridOption_02 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_02'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
	usePaging : true,
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "Pooling 명",
	    headerText : "Pooling 명"
  },{
	    dataField : "Pooling 과제",
	    headerText : "Pooling 과제"
  },{
	    dataField : "생성일",
	    headerText : "생성일"
  },{
	    dataField : "생성자",
	    headerText : "생성자"
  }],

 
  
  
  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();

 	window.setTimeout(function(){
		AUIGrid.resize(me.id);
	}, 0.5);

    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_02);
  }
};




$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if (myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
	}
});

$(function() {
	myGridOption_01.createGrid();
	myGridOption_02.createGrid();

 
 	$("#tab ul li").click(function(){
 		if (myGridOption_01.id) {
 			AUIGrid.resize(myGridOption_01.id);
 		}
 		if (myGridOption_02.id) {
 			AUIGrid.resize(myGridOption_02.id);
 		}
	});
});




</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Data Export</h3>
                <nav id="pathNav">
                    <ul>
                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
                        <li>Data</li>
                        <li>Data Export</li>
                    </ul>
                </nav>
			</article>
			<section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">
					
					<div id="tab" class="tab tab01 mgT16">
						<ul>
							<li id="tab_menu1" class="port_back tab_menu">진행과제</li>
							<li id="tab_menu2" class="tab_menu">Pooling</li>
							<li id="tab_menu3" class="tab_menu">종료과제</li>
						</ul>
					</div>


					 <article class="tab_list">
					 
					 
					 
						<div class="tab_sub1">
							<div style="height:30px;">									
								<span style="font-family:'NanumGothicBold';">Pooling 명 :</span>
								<input type="text" id="" name="" style="width: 150px;">
								<button type="button" class="oneBtn" popup_type="ProductSearch">
									<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
								</button>
							</div>

							<article class="mgT16">
								<div id="grid_wrap_01" class="gridHeiSz10 grid_wrap tb01_2"></div>
							</article>

							
							
						</div>
						
						
						
						<div class="tab_sub2">
							<div style="height:30px;">									
								<span style="font-family:'NanumGothicBold';">Pooling 명 :</span>
								<input type="text" id="" name="" style="width: 150px;">
								<button type="button" class="oneBtn" popup_type="ProductSearch">
									<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
								</button>
							</div>

							
							<article class="mgT16">
								<div id="grid_wrap_02" class="gridHeiSz10 grid_wrap tb01_2"></div>
							</article>
							
						</div>
						
						
						
						<div class="tab_sub3">
							종료과제 내용
						</div>
					</article>





				</div>
			</section>
		</div>
	</section>
</div>
</body>
</html>