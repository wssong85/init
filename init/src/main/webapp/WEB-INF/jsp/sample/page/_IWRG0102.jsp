<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>

<style>
.center_style .aui-grid-default-header { text-align: center; text-indent:0;}

</style>

<script type="text/javascript">

var testData_01 =[
{
	  "IWRS Ver.":"1.7",
	  "무작위등록":"Yes",
	  "무작위추가":"Yes",
	  "IP 등록":"Yes",
	  "IP 추가":"Yes",
	  "화면 디자인":"Yes",
	  "변경사유":"변경사유",
	  "적용방법":"즉시",
	  "적용일":"2015-12-12",
	  "수정일":"2015-12-12",
	  "작성자":"홍길동",
	  "상태":"진행중(Randoization)"
}, {
	  "IWRS Ver.":"1.7",
	  "무작위등록":"Yes",
	  "무작위추가":"Yes",
	  "IP 등록":"Yes",
	  "IP 추가":"Yes",
	  "화면 디자인":"Yes",
	  "변경사유":"변경사유",
	  "적용방법":"즉시",
	  "적용일":"2015-12-12",
	  "수정일":"2015-12-12",
	  "작성자":"홍길동",
	  "상태":"진행중(Randoization)"
}, {
	  "IWRS Ver.":"1.7",
	  "무작위등록":"Yes",
	  "무작위추가":"Yes",
	  "IP 등록":"Yes",
	  "IP 추가":"Yes",
	  "화면 디자인":"Yes",
	  "변경사유":"변경사유",
	  "적용방법":"즉시",
	  "적용일":"2015-12-12",
	  "수정일":"2015-12-12",
	  "작성자":"홍길동",
	  "상태":"진행중(Randoization)"
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
	    dataField : "IWRS Ver.",
	    headerText : "IWRS Ver."
  },{
	    dataField : "변경대상",
	    headerText : "변경대상",
		children : [{
			dataField : "무작위등록",
			headerText : "무작위등록"
		},{
	   		dataField : "무작위추가",
	   		headerText : "무작위추가"
		},{
	   		dataField : "IP 등록",
	   		headerText : "IP 등록"
		},{
	   		dataField : "IP 추가",
	   		headerText : "IP 추가"
		},{
	   		dataField : "화면 디자인",
	   		headerText : "화면 디자인"
		}]
  },{
	    dataField : "변경사유",
	    headerText : "변경사유"
  },{
	    dataField : "적용방법",
	    headerText : "적용방법"
  },{
	    dataField : "적용일",
	    headerText : "적용일"
  },{
	  	dataField : "수정일",
	  	headerText : "수정일"
  },{
	    dataField : "작성자",
	    headerText : "작성자"
  },{
	    dataField : "상태",
	    headerText : "상태"
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


	// 팝업레이어
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./_IWRG0103.do", null);

	});

	//$('.popup_01').trigger('click');
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
							<li id="" class="port_back tab_menu">목록</li>
							<li id="" class="tab_menu">Randomization</li>
							<li id="" class="tab_menu">IP</li>
							<li id="" class="tab_menu">화면디자인</li>
						</ul>
					</div>


			

				<article style="overflow:hidden;">
					<div class="conTitBtnL">
						<h5>CJ 연구과제8</h5>

						
					</div>
					<div class="conTitBtnR">									
						<input type="button" value="신규">
						<input type="button" value="변경">
						<input type="button" value="변경승인요청">
						<input type="button" value="승인요청">
						<input type="button" value="승인">
						<input type="button" value="승인이력">
						
						
						
					</div>
				</article>


				<article class="mgT16 center_style">
					<div id="grid_wrap_01" class="gridHeiSz15 grid_wrap tb01_2"></div>
				</article>


<br>
<input type="button" value="변경 팝업" class="popup_01">

				</div>
			</section>
		</div>
	</section>
</div>
</body>
</html>