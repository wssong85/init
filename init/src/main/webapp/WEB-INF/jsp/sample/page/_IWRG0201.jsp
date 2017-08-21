<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>

<style>
.pop_style .aui-grid-default-header { text-align: center;}

</style>

<script type="text/javascript">



var testData_01 =[
{
	  "Protocol No":"CJ-2016-301",
	  "Mapping 상태":"No",
	  "등록일":"",
	  "등록자":""
}, {
	  "Protocol No":"CJ-2016-302",
	  "Mapping 상태":"Yes",
	  "등록일":"2016.12.12",
	  "등록자":"홍길동"
}, {
	  "Protocol No":"CJ-2016-303",
	  "Mapping 상태":"Yes",
	  "등록일":"2016.12.12",
	  "등록자":"홍길동"
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
    //wordWrap : true,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "Protocol No",
	    headerText : "Protocol No"
  },{
	    dataField : "Mapping 상태",
	    headerText : "Mapping 상태"
  },{
	    dataField : "등록일",
	    headerText : "등록일"
  },{
	    dataField : "등록자",
	    headerText : "등록자"
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
	  "Factor Name":"Sex",
	  "Level":"M",
	  "Visit":"1",
	  "Group":"2",
	  "Variable":"Sex",
	  "Line":"2",
	  "수식명":"D1",
	  "조건식":"D1 = M"
}, {
	  "Factor Name":"",
	  "Level":"F",
	  "Visit":"1",
	  "Group":"2",
	  "Variable":"Sex",
	  "Line":"2",
	  "수식명":"D1",
	  "조건식":"D1 = F"
}, {
	  "Factor Name":"SBP",
	  "Level":"< 100",
	  "Visit":"1",
	  "Group":"2",
	  "Variable":"ORRES",
	  "Line":"3",
	  "수식명":"D1",
	  "조건식":"D2 < 100"
}, {
	  "Factor Name":"",
	  "Level":">= 100",
	  "Visit":"1",
	  "Group":"2",
	  "Variable":"ORRES",
	  "Line":"3",
	  "수식명":"D1",
	  "조건식":"D2 >= 100"
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
    //wordWrap : true,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "IWRS",
	    headerText : "IWRS",
		children : [{
			dataField : "Factor Name",
			headerText : "Factor Name"
		},{
			dataField : "Level",
			headerText : "Level"
		}]
  },{
	    dataField : "EDC",
	    headerText : "EDC",
		children : [{
			dataField : "Visit",
			headerText : "Vist"
		},{
			dataField : "Group",
			headerText : "Group"
		},{
			dataField : "Variable",
			headerText : "Variable"
		},{
			dataField : "Line",
			headerText : "Line"
		},{
			dataField : "수식명",
			headerText : "수식명"
		},{
			dataField : "조건식",
			headerText : "조건식"
		}]
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
});

$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if (myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
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
					<h3>Factor Mapping</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>과제관리</li>
	                        <li>Factor Mapping</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner" style="min-height:900px;">
					


						<article>
							<div class="conTitBtnL">
								<h5>Protocol List</h5>
							</div>
							<!-- 
							<div class="conTitBtnR">
								<input type="button" value="버튼">
							</div>
							 -->
							<div style="clear:both; height:10px;"></div>
							
							<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>
							
						</article>
						



						<div class="mgT20 view_block_01">
							<h5>Factor Mapping</h5>
							<div style="height:38px;">
								<div class="conTitBtnL">
									
									
									
									
							<div class="mgT5">
								<span style="font-family:'NanumGothicBold';">배정시점 :</span>
								&nbsp;V1&nbsp;V2&nbsp;V3&nbsp;V4&nbsp;V5
							</div>
									
									
								</div>
								
								<div class="conTitBtnR">
									<input type="button" value="수정">
									<input type="button" value="저장">
								</div>
								
							</div>
							<article class="pop_style">
				        		<div id="grid_wrap_02" class="gridHeiSz06 grid_wrap tb01_2"></div>
				        	</article>
						</div>
						



						
						
					</div>
				</section>
			</div>
		</section>
</div>
</body>
</html>