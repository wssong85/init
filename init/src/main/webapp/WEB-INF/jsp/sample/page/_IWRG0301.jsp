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
	  "과제번호":"CJ_xxx_xx8",
	  "과제명":"CJ 연구과제8",
	  "IWRS Ver.":"1.7",
	  "DB Freezing":"2015-12-12"
}, {
	  "과제번호":"CJ_xxx_xx8",
	  "과제명":"CJ 연구과제8",
	  "IWRS Ver.":"1.7",
	  "DB Freezing":"2015-12-12"
}, {
	  "과제번호":"CJ_xxx_xx8",
	  "과제명":"CJ 연구과제8",
	  "IWRS Ver.":"1.7",
	  "DB Freezing":"2015-12-12"
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
	    dataField : "IWRS Ver.",
	    headerText : "IWRS Ver."
  },{
	    dataField : "DB Freezing",
	    headerText : "DB Freezing"
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


$(function() {
	myGridOption_01.createGrid();
});


$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
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
				<h3>피험자 배정 로그 (Covariate)</h3>
                <nav id="pathNav">
                    <ul>
                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
                        <li>과제관리</li>
                        <li>피험자 배정 로그 (Covariate)</li>
                    </ul>
                </nav>
			</article>
			<section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">
					
					<div id="tab" class="tab tab01 mgT16">
						<ul>
							<li id="" class="port_back tab_menu">과제 목록</li>
							<li id="" class="tab_menu">피험자 배정로그</li>
						</ul>
					</div>
					
                    <article class="conTitBox">
						<span style="font-family:'NanumGothicBold';">과제번호 :</span>
						<input type="text" id="" name="" style="width: 150px;">
						<span style="font-family:'NanumGothicBold'; margin-left: 20px;">과제명 :</span>
						<input type="text" id="" name="" style="width: 150px;">
						<button type="button" class="oneBtn" popup_type="ProductSearch">
							<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
						</button>
                    </article>
							



					<article class="mgT16">
						<div id="grid_wrap_01" class="gridHeiSz15 grid_wrap tb01_2"></div>
					</article>


				</div>
			</section>
		</div>
	</section>
</div>
</body>
</html>