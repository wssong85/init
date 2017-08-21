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
	  "피험자 이니셜":"PJK",
	  "피험자 ID":"P-001"
}, {
	  "피험자 이니셜":"PWK",
	  "피험자 ID":"P-002"
}, {
	  "피험자 이니셜":"",
	  "피험자 ID":""
}, {
	  "피험자 이니셜":"",
	  "피험자 ID":""
}, {
	  "피험자 이니셜":"",
	  "피험자 ID":""
}, {
	  "피험자 이니셜":"",
	  "피험자 ID":""
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
	usePaging : false,
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
	    dataField : "피험자 이니셜",
	    headerText : "피험자 이니셜"
  },{
	    dataField : "피험자 ID",
	    headerText : "피험자 ID"
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
	  "Factor Name":"성별",
	  "Value":"남자"
}, {
	  "Factor Name":"연령",
	  "Value":"30세 이상"
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
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "Factor Name",
	    headerText : "Factor Name"
  },{
	    dataField : "Value",
	    headerText : "Value"
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



var testData_03 =[
{
	  "분류":"성별",
	  "분류2":"남",
	  "Group A":"8",
	  "Group B":"3"
}, {
	  "분류":"성별",
	  "분류2":"여",
	  "Group A":"8",
	  "Group B":"3"
}, {
	  "분류":"나이",
	  "분류2":"30세 미만",
	  "Group A":"8",
	  "Group B":"3"
}, {
	  "분류":"나이",
	  "분류2":"30세 이상",
	  "Group A":"8",
	  "Group B":"3"
}, {
	  "분류":"",
	  "분류2":"총 환자수",
	  "Group A":"12",
	  "Group B":"3" 
}];

var myGridOption_03 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_03'
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
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37,
    enableCellMerge : true
  },
  columnLayout : [{
	    dataField : "분류",
	    headerText : "분류",
	    colSpan : 2,
	    cellMerge : true,
	    width : 80
  },{
	    dataField : "분류2",
	    colSpan : -1,
	    width : 80
  },{
	    dataField : "Group A",
	    headerText : "Group A"
  },{
	    dataField : "Group B",
	    headerText : "Group B"
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
    AUIGrid.setGridData(me.id, testData_03);
  }
};



var testData_04 =[
{
	  "분류":"성별",
	  "분류2":"남",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"성별",
	  "분류2":"여",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"나이",
	  "분류2":"30세 미만",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"나이",
	  "분류2":"30세 이상",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"",
	  "분류2":"총 환자수",
	  "Group A":"12",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}];

var myGridOption_04 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_04'
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
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37,
    enableCellMerge : true
  },
  columnLayout : [{
	    dataField : "분류",
	    headerText : "분류",
	    colSpan : 2,
	    cellMerge : true,
	    width : 80
},{
	    dataField : "분류2",
	    colSpan : -1,
	    width : 80
},{
	    dataField : "Group A",
	    headerText : "Group A"
},{
	    dataField : "Group B",
	    headerText : "Group B"
},{
	    dataField : "X2 통계량",
	    headerText : "X2 통계량"
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
    AUIGrid.setGridData(me.id, testData_04);
  }
};



var testData_05 =[
{
	  "분류":"성별",
	  "분류2":"남",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"성별",
	  "분류2":"여",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"나이",
	  "분류2":"30세 미만",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"나이",
	  "분류2":"30세 이상",
	  "Group A":"8",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}, {
	  "분류":"",
	  "분류2":"총 환자수",
	  "Group A":"12",
	  "Group B":"3",
	  "X2 통계량":"3.0"
}];
var myGridOption_05 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_05'
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
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37,
    enableCellMerge : true
  },
  columnLayout : [{
	    dataField : "분류",
	    headerText : "분류",
	    colSpan : 2,
	    cellMerge : true,
	    width : 80
},{
	    dataField : "분류2",
	    colSpan : -1,
	    width : 80
},{
	    dataField : "Group A",
	    headerText : "Group A"
},{
	    dataField : "Group B",
	    headerText : "Group B"
},{
	    dataField : "X2 통계량",
	    headerText : "X2 통계량"
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
    AUIGrid.setGridData(me.id, testData_05);
  }
};



$(function() {
	myGridOption_01.createGrid();
	myGridOption_02.createGrid();
	myGridOption_03.createGrid();
	myGridOption_04.createGrid();
	myGridOption_05.createGrid();

	//아코디언 선택 open(2번째 아코디언 열림)
	//setAccodian_02(2);
	setAccodian_02(1);
});


$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if (myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
	}
	if (myGridOption_03.id) {
		AUIGrid.resize(myGridOption_03.id);
	}
	if (myGridOption_04.id) {
		AUIGrid.resize(myGridOption_04.id);
	}
	if (myGridOption_05.id) {
		AUIGrid.resize(myGridOption_05.id);
	}
});


function setAccodian_02(acc_select){


	$(".accordion_02 > a").on("click",function() {
		if ($(this).hasClass("close")) {
			$(this).siblings(".accordion_con_02").slideToggle(0);				
			$(this).toggleClass('open');
			AUIGrid.resize(myGridOption_01.id);
			AUIGrid.resize(myGridOption_02.id);
			AUIGrid.resize(myGridOption_03.id);
			AUIGrid.resize(myGridOption_04.id);
			AUIGrid.resize(myGridOption_05.id);
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
							<li id="" class="tab_menu">과제 목록</li>
							<li id="" class="port_back tab_menu">피험자 배정로그</li>
						</ul>
					</div>
					
 
 
<style>


.left_wrap{float: left; width:30%; }
.right_wrap{float: right; width:69%; }

.left_title_01{line-height:36px; text-indent:13px; box-sizing: border-box; background:#f5f5f5; border: 1px solid #ddd; border-bottom:none; color:#666; font-family: 'Noto Sans KR'; font-weight: 300;}
</style>
 
 
 
					<div class="left_wrap">
						<div class="left_title_01">피험자 리스트</div>
						<article style="border: 1px solid #ddd; padding:10px;">
							<div id="grid_wrap_01" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>
					
					<div class="right_wrap">

						
						<ul class="accordion_wrap">
						    <li class="accordion_02">
						    	<a href="#void" class="close">피험자 배정 전 현황</a>
						        <div class="accordion_con_02">
									<div style="height:38px;">
										<span style="font-family:'NanumGothicBold'; position:relative; top:0px;">피험자 ID :</span>
										&nbsp;
										<input type="text" style="width:150px;">
									</div>


									<div style="height:24px;">
										<span style="font-family:'NanumGothicBold';">대상 피험자 배정 정보</span>
									</div>
						        	<div id="grid_wrap_02" class="gridHeiSz02 grid_wrap tb01_2"></div>

									
									<div style="height:20px;"></div>


									<div style="height:24px;">
										<span style="font-family:'NanumGothicBold';">피험자 배정 전 현황</span>
									</div>
						        	<div id="grid_wrap_03" class="gridHeiSz05 grid_wrap tb01_2"></div>

						        </div>
							</li>
						    <li class="accordion_02">
						    	<a href="#void" class="close">배정 Simulation</a>
						        <div class="accordion_con_02">
									<div style="height:24px;">
										<span style="font-family:'NanumGothicBold';">Group A 배정 Simulation</span>
									</div>
						        	<div id="grid_wrap_04" class="gridHeiSz05 grid_wrap tb01_2"></div>
						        	
						        	<div style="height:20px;"></div>
						        	
									<div style="height:24px;">
										<span style="font-family:'NanumGothicBold';">Group B 배정 Simulation</span>
									</div>
						        	<div id="grid_wrap_05" class="gridHeiSz05 grid_wrap tb01_2"></div>
						        	
						        </div>
							</li>
						    <li class="accordion_02">
						    	<a href="#void" class="close">배정 결과</a>
						        <div class="accordion_con_02">
						        
									
									<table class="tb001">
										<colgroup>
											<col width="25%" />
											<col width="" />
										</colgroup>
										<tbody>
											<tr>
												<th>배정 Simulation 결과</th>
												<td>
									 				<input type="text" style="width:100%;" value="Group A">
												</td>
											</tr>
											<tr>
												<th>피험자 배정</th>
												<td>
									 				<input type="text" style="width:100%;" value="Group A">
												</td>
											</tr>
										</tbody>
									</table>

						        	
						        </div>
							</li>
						</ul>


					</div>






				</div>
			</section>
		</div>
	</section>
</div>
</body>
</html>