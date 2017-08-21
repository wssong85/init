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

.view_block_02{ display: block; border:1px solid blue; margin-bottom:30px;}
.hide_block_02{ display: none;}


</style>


<script type="text/javascript">
var testData_01 =[
{
	  "Ratio":"input",
	  "ARM Code":"P",
	  "ARM":"Placebo"
}, {
	  "Ratio":"input",
	  "ARM Code":"A",
	  "ARM":"Treatment A"
}, {
	  "Ratio":"input",
	  "ARM Code":"B",
	  "ARM":"Treatment B"
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
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "Ratio",
	    headerText : "Ratio"
  },{
	    dataField : "ARM Code",
	    headerText : "ARM Code"
  },{
	    dataField : "ARM",
	    headerText : "ARM"
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
	  "Factor Name":"성별",
	  "Label":"Sex",
	  "No of Levels":"1",
	  "Level Description":"Sex = M"
}, {
	  "Factor Name":"성별",
	  "Label":"Sex",
	  "No of Levels":"1",
	  "Level Description":"Sex = F"
}, {
	  "Factor Name":"수축기 혈압",
	  "Label":"SBP",
	  "No of Levels":"1",
	  "Level Description":"SBP < 100"
}, {
	  "Factor Name":"수축기 혈압",
	  "Label":"SBP",
	  "No of Levels":"2",
	  "Level Description":"100 <= SBP >= 150"
}, {
	  "Factor Name":"수축기 혈압",
	  "Label":"SBP",
	  "No of Levels":"3",
	  "Level Description":"SBP > 150"
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
    rowHeight: 37,
    enableCellMerge : true
  },
  columnLayout : [{
	    dataField : "Factor Name",
	    headerText : "Factor Name",
	    width : 150,
	    cellMerge : true
  },{
	    dataField : "Label",
	    headerText : "Label",
	    width : 150,
	    cellMerge : true
  },{
	    dataField : "No of Levels",
	    width : 150,
	    headerText : "No of Levels"
  },{
	    dataField : "Level Description",
	    headerText : "Level Description"
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
	  "Type":"텍스트",
	  "설정(길이)":"고정",
	  "값":"RA"
}, {
	  "Type":"층화",
	  "설정(길이)":"2",
	  "값":"ML, MH, FL, FH"
}, {
	  "Type":"층화",
	  "설정(길이)":"1",
	  "값":"-"
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
	    dataField : "Type",
	    headerText : "Type",
		editRenderer : {
			type : "ComboBoxRenderer",
			showEditorBtnOver : true,
			list : ['텍스트', '층화', '구분자']
		}
  },{
	    dataField : "설정(길이)",
	    headerText : "설정(길이)"
  },{
	    dataField : "값",
	    headerText : "값"
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
    AUIGrid.setGridData(me.id, testData_04);
  }
};



var testData_05 =[
{
	  "Element Code":"TA10",
	  "Element":"Treatment A 10mg"
}, {
	  "Element Code":"TA20",
	  "Element":"Treatment B 20mg"
}, {
	  "Element Code":"TA30",
	  "Element":"Treatment C 30mg"
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
	    dataField : "Element Code",
	    headerText : "Element Code"
  },{
	    dataField : "Element",
	    headerText : "Element"
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







var testData_06 =[
{
	  "Sequence":"TA10, TB20, TC30",
	  "Arm Code":"A",
	  "Arm Name":"Miracle A",
	  "Ratio":""
}, {
	  "Sequence":"TA10, TB20, TC30",
	  "Arm Code":"B",
	  "Arm Name":"Miracle A",
	  "Ratio":""
}, {
	  "Sequence":"TA10, TB20, TC30",
	  "Arm Code":"C",
	  "Arm Name":"Miracle A",
	  "Ratio":""
}];

var myGridOption_06 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_06'
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
	    dataField : "Sequence",
	    headerText : "Sequence"
  },{
	    dataField : "Arm Code",
	    headerText : "Arm Code"
  },{
	    dataField : "Arm Name",
	    headerText : "Arm Name"
  },{
	    dataField : "Ratio",
	    headerText : "Ratio"
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
    AUIGrid.setGridData(me.id, testData_06);
  }
};






var testData_07 =[
{
	  "Type":"텍스트",
	  "설정(길이)":"고정",
	  "값":"RA"
}, {
	  "Type":"층화",
	  "설정(길이)":"2",
	  "값":"ML, MH, FL, FH"
}, {
	  "Type":"층화",
	  "설정(길이)":"1",
	  "값":"-"
}];

var myGridOption_07 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_07'
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
	    dataField : "Type",
	    headerText : "Type"
  },{
	    dataField : "설정(길이)",
	    headerText : "설정(길이)"
  },{
	    dataField : "값",
	    headerText : "값"
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
    AUIGrid.setGridData(me.id, testData_07);
  }
};




var testData_08 =[
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

var myGridOption_08 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_08'
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
    AUIGrid.setGridData(me.id, testData_08);
  }
};






var testData_09 =[
{
	  "Ratio":"input",
	  "ARM Code":"P",
	  "ARM":"Placebo"
}, {
	  "Ratio":"input",
	  "ARM Code":"A",
	  "ARM":"Treatment A"
}, {
	  "Ratio":"input",
	  "ARM Code":"B",
	  "ARM":"Treatment B"
}];

var myGridOption_09 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_09'
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
	    dataField : "Ratio",
	    headerText : "Ratio"
  },{
	    dataField : "ARM Code",
	    headerText : "ARM Code"
  },{
	    dataField : "ARM",
	    headerText : "ARM"
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
    AUIGrid.setGridData(me.id, testData_09);
  }
};




var testData_10 =[
{
	  "Factor Name":"성별",
	  "Label":"Sex",
	  "No of Levels":"1",
	  "Level Description":"Sex = M"
}, {
	  "Factor Name":"성별",
	  "Label":"Sex",
	  "No of Levels":"1",
	  "Level Description":"Sex = F"
}, {
	  "Factor Name":"수축기 혈압",
	  "Label":"SBP",
	  "No of Levels":"1",
	  "Level Description":"SBP < 100"
}, {
	  "Factor Name":"수축기 혈압",
	  "Label":"SBP",
	  "No of Levels":"2",
	  "Level Description":"100 <= SBP >= 150"
}, {
	  "Factor Name":"수축기 혈압",
	  "Label":"SBP",
	  "No of Levels":"3",
	  "Level Description":"SBP > 150"
}];


var myGridOption_10 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_10'
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
    rowHeight: 37,
    enableCellMerge : true
  },
  columnLayout : [{
	    dataField : "Factor Name",
	    headerText : "Factor Name",
	    width : 150,
	    cellMerge : true
  },{
	    dataField : "Label",
	    headerText : "Label",
	    width : 150,
	    cellMerge : true
  },{
	    dataField : "No of Levels",
	    width : 150,
	    headerText : "No of Levels"
  },{
	    dataField : "Level Description",
	    headerText : "Level Description"
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
    AUIGrid.setGridData(me.id, testData_10);
  }
};




var testData_11 =[
{
	  "Type":"텍스트",
	  "설정(길이)":"고정",
	  "값":"RA"
}, {
	  "Type":"층화",
	  "설정(길이)":"2",
	  "값":"ML, MH, FL, FH"
}, {
	  "Type":"층화",
	  "설정(길이)":"1",
	  "값":"-"
}];

var myGridOption_11 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_11'
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
	    dataField : "Type",
	    headerText : "Type"
  },{
	    dataField : "설정(길이)",
	    headerText : "설정(길이)"
  },{
	    dataField : "값",
	    headerText : "값"
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
    AUIGrid.setGridData(me.id, testData_11);
  }
};






$(function() {
	myGridOption_01.createGrid();
	myGridOption_02.createGrid();
	myGridOption_03.createGrid();
	myGridOption_04.createGrid();
	myGridOption_05.createGrid();
	myGridOption_06.createGrid();
	myGridOption_07.createGrid();
	myGridOption_08.createGrid();
	myGridOption_09.createGrid();
	myGridOption_10.createGrid();
	myGridOption_11.createGrid();
	
	//아코디언 선택 open(2번째 아코디언 열림)
	//setAccodian_02(4);
	setAccodian_02();
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});

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
	if (myGridOption_06.id) {
		AUIGrid.resize(myGridOption_06.id);
	}
	if (myGridOption_07.id) {
		AUIGrid.resize(myGridOption_07.id);
	}
	if (myGridOption_08.id) {
		AUIGrid.resize(myGridOption_08.id);
	}
	if (myGridOption_09.id) {
		AUIGrid.resize(myGridOption_09.id);
	}
	if (myGridOption_10.id) {
		AUIGrid.resize(myGridOption_10.id);
	}
	if (myGridOption_11.id) {
		AUIGrid.resize(myGridOption_11.id);
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
			AUIGrid.resize(myGridOption_06.id);
			AUIGrid.resize(myGridOption_07.id);
			AUIGrid.resize(myGridOption_08.id);
			AUIGrid.resize(myGridOption_09.id);
			AUIGrid.resize(myGridOption_10.id);
			AUIGrid.resize(myGridOption_11.id);
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
								<li id="" class="port_back tab_menu">Randomization</li>
								<li id="" class="tab_menu">IP</li>
								<li id="" class="tab_menu">화면디자인</li>
							</ul>
						</div>


						<article style="position:relative;">
							<h5>CJ 연구과제8</h5>
							<div class="tab_small">
								<ul>
									<li id="" class="port_back tab_menu_s">무작위배정코드</li>
									<li id="" class="tab_menu_s">추가 무작위배정코드</li>
									<li id="" class="tab_menu_s">테스트 코드</li>
								</ul>
							</div>
						</article>
						


						<div class="view_block_01 mgT20">
							<div class="mgT5" style="height:30px;">
								<div class="conTitBtnL" style="width:80%;">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">설계 디자인 :</span>
									&nbsp;
									<select style="width:80%; vertical-align:top;">
										<option value="">====선택====</option>
										<option value="">Block Randomization</option>
										<option value="">Crossover</option>
										<option value="">Covariate adaptive randomization</option>
									</select>
								</div>
								<div class="conTitBtnR">
									<input type="button" value="수정">
									<input type="button" value="저장">
								</div>
							</div>
							<div class="mgT5" style="height:30px;">
								<div class="conTitBtnL" style="width:48%;">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">배정시점 :</span>
									&nbsp;
									<select style="width:80%; vertical-align:top;">
										<option value="">====선택====</option>
									</select>
								</div>
								<div class="conTitBtnR" style="width:48%;">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">층화 :</span>
									&nbsp;
									<select style="width:87%; vertical-align:top;">
										<option value="">====선택====</option>
									</select>
								</div>
							</div>
						</div>
						
						<!-- Block Randomization -->
						<div class="view_block_02">
							<ul class="mgT10 accordion_wrap">
							    <li class="accordion_02">
							    	<a href="#void" class="close">Arm Ratio</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnR">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
							        	<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">Factor</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnR">
												<input type="button" value="Diagram 보기">
												<input type="button" value="추가">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
							        	<div id="grid_wrap_02" class="gridHeiSz05 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">Code Configuration</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:0px;">Code Sample :</span>
												&nbsp;
												<input type="text" style="width:200px;">
											</div>
											<div class="conTitBtnR">
												<input type="button" value="추가">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
										<div id="grid_wrap_03" class="gridHeiSz04 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">Randomization Code</a>
							        <div class="accordion_con_02">
							        
										<div style="height:38px;">
											<div class="conTitBtnL">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Seed</span>
											</div>
											<div class="conTitBtnR">
												<input type="button" value="Diagram 보기">
												<input type="button" value="수정">
												<input type="button" value="생성">
											</div>
										</div>
										
										<table class="tb001">
											<colgroup>
												<col width="15%" />
												<col width="35%" />
												<col width="15%" />
												<col width="" />
											</colgroup>
											<tbody>
												<tr>
													<th>Seed</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
													<th>Block Seed</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
												</tr>
											</tbody>
										</table>
										
										
										<div style="height:10px;"></div>
							        
										<div style="height:38px;">
											<div class="conTitBtnL">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Blocks</span>
											</div>
											<div class="conTitBtnR">
												<input type="button" value="추가">
											</div>
										</div>
							        	<div id="grid_wrap_04" class="gridHeiSz05 grid_wrap tb01_2"></div>
							        </div>
								</li>
							</ul>
						</div>
							

					
						<!-- Crossover -->
						<div class="view_block_02">
							<ul class="mgT10 accordion_wrap">
							    <li class="accordion_02">
							    	<a href="#void" class="close">Element & Arm</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Element</span>
											</div>
										</div>
							        	<div id="grid_wrap_05" class="gridHeiSz03 grid_wrap tb01_2"></div>
							        	
							        	
							        	<div style="height:10px;"></div>
							        	
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Arm Ratio</span>
											</div>
											<div class="conTitBtnR">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
							        	
							        	<div id="grid_wrap_06" class="gridHeiSz03 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">Code Configuration</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:0px;">Code Sample :</span>
												&nbsp;
												<input type="text" style="width:200px;">
											</div>
											<div class="conTitBtnR">
												<input type="button" value="추가">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
										<div id="grid_wrap_07" class="gridHeiSz04 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">Randomization Code</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnL">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Seed</span>
											</div>
											<div class="conTitBtnR">
												<input type="button" value="Diagram 보기">
												<input type="button" value="수정">
												<input type="button" value="생성">
											</div>
										</div>
										
										<table class="tb001">
											<colgroup>
												<col width="15%" />
												<col width="35%" />
												<col width="15%" />
												<col width="" />
											</colgroup>
											<tbody>
												<tr>
													<th>Seed</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
													<th>Block Seed</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
												</tr>
											</tbody>
										</table>
										
										
										<div style="height:10px;"></div>							        
							        
										<div style="height:38px;">
											<div class="conTitBtnL">
												<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Blocks</span>
											</div>
											<div class="conTitBtnR">
												<input type="button" value="추가">
											</div>
										</div>
							        	<div id="grid_wrap_08" class="gridHeiSz05 grid_wrap tb01_2"></div>
							        </div>
								</li>
							</ul>
						</div>
							

						
							

						<!-- Covariate adaptive randomization -->
						<div class="view_block_02">
							<ul class="mgT10 accordion_wrap">
							    <li class="accordion_02">
							    	<a href="#void" class="close">Arm Ratio</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnR">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
							        	<div id="grid_wrap_09" class="gridHeiSz03 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">Factor</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnR">
												<input type="button" value="Diagram 보기">
												<input type="button" value="추가">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
							        	<div id="grid_wrap_10" class="gridHeiSz05 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">Code Configuration</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnL" style="width:80%;">
												<span style="font-family:'NanumGothicBold'; position:relative; top:0px;">Code Sample :</span>
												&nbsp;
												<input type="text" style="width:200px;">
											</div>
											<div class="conTitBtnR">
												<input type="button" value="추가">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
										<div id="grid_wrap_11" class="gridHeiSz04 grid_wrap tb01_2"></div>
							        </div>
								</li>
							    <li class="accordion_02">
							    	<a href="#void" class="close">배정설정</a>
							        <div class="accordion_con_02">
										<div style="height:38px;">
											<div class="conTitBtnR">
												<input type="button" value="수정">
												<input type="button" value="저장">
											</div>
										</div>
										<table class="tb001">
											<colgroup>
												<col width="20%" />
												<col width="" />
											</colgroup>
											<tbody>
												<tr>
													<th>초기 배정용 Seed</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
												</tr>
												<tr>
													<th>초기 배정인원</th>
													<td>
										 				<input type="text"  style="width:100%;">
													</td>
												</tr>
												<tr>
													<th>층화그룹별최대피험자수</th>
													<td>
										 				<input type="text"  style="width:100%;">
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