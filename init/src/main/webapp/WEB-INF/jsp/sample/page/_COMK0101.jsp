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
	  "구분":"IP",
	  "Status":"등록",
	  "Code 수":"200",
	  "Type":"Real",
	  "생성일":"2016-06-11",
	  "생성자":"운영자"
}, {
	  "과제번호":"CJ_xxx_xx8",
	  "구분":"IP",
	  "Status":"등록",
	  "Code 수":"200",
	  "Type":"Real",
	  "생성일":"2016-06-11",
	  "생성자":"운영자"
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
	    dataField : "구분",
	    headerText : "구분"
  },{
	    dataField : "Status",
	    headerText : "Status"
  },{
	    dataField : "Code 수",
	    headerText : "Code 수"
  },{
	    dataField : "Type",
	    headerText : "Type"
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
					<h3>위탁코드목록</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>위탁코드목록</li>
	                        <li>위탁코드목록</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner" style="min-height:900px;">
					

						<div style="height:38px;">
							<div class="conTitBtnR">
								<input type="button" value="코드생성">
							</div>
						</div>
				        	



		
						<article class="mgT06">
							<div id="grid_wrap_01" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>


					</div>
				</section>
			</div>
		</section>
</div>
</body>
</html>