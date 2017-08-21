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
	  "IP Type":"RI",
	  "Treatment":"Placebo",
	  "제조번호":"201003",
	  "유효기한":"2016.01.31",
	  "재검사일":"2016.01.31",
	  "저장조건":"상온",
	  "유효일 Start":"2016.01.31",
	  "유효일 End":"2016.01.31"
}, {
	  "IP Type":"",
	  "Treatment":"",
	  "제조번호":"",
	  "유효기한":"",
	  "재검사일":"",
	  "저장조건":"",
	  "유효일 Start":"",
	  "유효일 End":""
}, {
	  "IP Type":"",
	  "Treatment":"",
	  "제조번호":"",
	  "유효기한":"",
	  "재검사일":"",
	  "저장조건":"",
	  "유효일 Start":"",
	  "유효일 End":""
}, {
	  "IP Type":"",
	  "Treatment":"",
	  "제조번호":"",
	  "유효기한":"",
	  "재검사일":"",
	  "저장조건":"",
	  "유효일 Start":"",
	  "유효일 End":""
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
    showRowNumColumn : false,
    showRowCheckColumn : true,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    //wordWrap : true,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "IP Type",
	    headerText : "IP Type"
  },{
	    dataField : "Treatment",
	    headerText : "Treatment"
  },{
	    dataField : "제조번호",
	    headerText : "제조번호"
  },{
	    dataField : "유효기한",
	    headerText : "유효기한"
  },{
	    dataField : "재검사일",
	    headerText : "재검사일"
  },{
	    dataField : "저장조건",
	    headerText : "저장조건"
  },{
	    dataField : "유효일 Start",
	    headerText : "유효일 Start"
  },{
	    dataField : "유효일 End",
	    headerText : "유효일 End"
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
								<li id="" class="tab_menu">IP</li>
								<li id="" class="port_back tab_menu">화면디자인</li>
							</ul>
						</div>


						<article style="position:relative;">
							<h5>CJ 연구과제8</h5>
							<div class="tab_small">
								<ul>
									<li id="" class="tab_menu_s">방문 설정</li>
									<li id="" class="port_back tab_menu_s">IP 상세 정보 설정</li>
								</ul>
							</div>
						</article>
						



						<div class="mgT20 view_block_01">
							<div style="height:38px;">
								<div class="conTitBtnL">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">IP 상세 정보 설정</span>
								</div>
								
								<div class="conTitBtnR">
									<input type="button" value="저장">
								</div>
								
							</div>
				        	<div id="grid_wrap_01" class="gridHeiSz10 grid_wrap tb01_2"></div>
						</div>
						



						
						
					</div>
				</section>
			</div>
		</section>
</div>
</body>
</html>