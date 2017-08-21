<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>

<style>
.view_block_01{ display: block; border:1px solid red; margin-bottom:30px;}
.hide_block_01{ display: none;}

</style>


<script type="text/javascript">



var testData_01 =[
{
	  "Element":"Treatment Placebo",
	  "생성 수":"input"
}, {
	  "Element":"Treatment 10mg Miracle Drug",
	  "생성 수":"input"
}, {
	"Element":"Treatment 10mg Miracle Drug",
	  "생성 수":"input"
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
    showRowNumColumn : true,
    showRowCheckColumn : true,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "Element",
	    headerText : "Element"
  },{
	    dataField : "생성 수",
	    headerText : "생성 수"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
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
	  "크기":"2",
	  "블록 수":"input",
	  "생성 수":"input"
}, {
	  "크기":"4",
	  "블록 수":"input",
	  "생성 수":"input"
}, {
	  "크기":"8",
	  "블록 수":"input",
	  "생성 수":"input"
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
    showRowNumColumn : true,
    showRowCheckColumn : true,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "크기",
	    headerText : "크기"
  },{
	    dataField : "블록 수",
	    headerText : "블록 수"
  },{
	    dataField : "생성 수",
	    headerText : "생성 수"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
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





$(function() {
	myGridOption_01.createGrid();
	myGridOption_02.createGrid();
	
	//아코디언 선택 open(2번째 아코디언 열림)
	//setAccodian_02(2);
	setAccodian_02(1);
	
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./_IWRG0114.do", null);
		AUIGrid.resize(myGridOption_001.id);
	});

	
});

$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if (myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
	}
});



function setAccodian_02(acc_select){


	$(".accordion_02 > a").on("click",function() {
		if ($(this).hasClass("close")) {
			$(this).siblings(".accordion_con_02").slideToggle(0);				
			$(this).toggleClass('open');
			AUIGrid.resize(myGridOption_01.id);
			AUIGrid.resize(myGridOption_02.id);
		}
	});
	
	$(".accordion_02").not(this).on("click",function() {		
		if ($(".accordion_02").not(this).children().hasClass("close")) {
			$(".accordion_02").not(this).children(".accordion_con_02").slideUp(0);
		}
	});

	$(".accordion_02 > a").not(this).on("click",function() {
		if ($(".accordion_02 > a").hasClass('open')) {
			$(".accordion_02 > a").not(this).removeClass('open');
			
		}
	});

	$(".accordion_con_02").css({"display":"none"});
	

	var acc_click = acc_select - 1;
	$(".accordion_wrap > li > a").eq(acc_click).trigger("click");

}





</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>IRWS 디자이너</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>과제관리</li>
	                        <li>IRWS 디자이너</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner" style="min-height:900px;">
					
						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="" class="tab_menu">목록</li>
								<li id="" class="tab_menu">Randomization</li>
								<li id="" class="port_back tab_menu">IP</li>
								<li id="" class="tab_menu">화면디자인</li>
							</ul>
						</div>


						<article style="position:relative;">
							<h5>CJ 연구과제8</h5>
							<div class="tab_small">
								<ul>
									<li id="" class="tab_menu_s">IP 코드</li>
									<li id="" class="tab_menu_s">추가IP 코드</li>
									<li id="" class="port_back tab_menu_s">테스트 코드</li>
								</ul>
							</div>
						</article>
						
						
						<div class="mgT20">
							<ul class="accordion_wrap">
							    <li class="accordion_02">
							    	<a href="#void" class="close">Code Generation</a>
							        <div class="accordion_con_02">
							        	
							        	<!-- 일련번호일 경우 -->
							        	<div class="view_block_01">
											<div style="height:38px;">
												<div class="conTitBtnR">
													<input type="button" value="Diagram 보기">
												</div>
											</div>
								        
											<div style="height:38px;">
												
												<div class="conTitBtnR">
													<input type="button" value="생성">
												</div>
											</div>
											
								        	<div id="grid_wrap_01" class="gridHeiSz05 grid_wrap tb01_2"></div>
										</div>


							        	<!-- 무작위일 경우-->
							        	<div class="view_block_01">
											<div style="height:38px;">
												<div class="conTitBtnR">
													<input type="button" value="Diagram 보기">
												</div>
											</div>
	
											<div style="height:38px;">
												<div class="conTitBtnL">
													<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Blocks</span>
												</div>
												<div class="conTitBtnR">
													<input type="button" value="추가">
													<input type="button" value="생성">
												</div>
											</div>
	
								        	<div id="grid_wrap_02" class="gridHeiSz05 grid_wrap tb01_2"></div>
										</div>


							        </div>
								</li>
							</ul>
						</div>




<input type="button" value="IP 코드 생성 결과 팝업" class="popup_01">



					</div>
				</section>
			</div>
		</section>
</div>
</body>
</html>