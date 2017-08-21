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
	  "구분":"시스템",
	  "Status":"추가",
	  "배정방법":"무작위(블록, 비층화)",
	  "배정시점":"V5",
	  "대상자 수":"150",
	  "Code 수":"200",
	  "Type":"Real",
	  "생성자":"홍길동",
	  "파일":"다운로드"
}, {
	  "구분":"위탁",
	  "Status":"등록",
	  "배정방법":"",
	  "배정시점":"",
	  "대상자 수":"300",
	  "Code 수":"400",
	  "Type":"Test",
	  "생성자":"",
	  "파일":"다운로드"
}, {
	  "구분":"시스템",
	  "Status":"추가",
	  "배정방법":"무작위(블록, 비층화)",
	  "배정시점":"V5",
	  "대상자 수":"150",
	  "Code 수":"200",
	  "Type":"Real",
	  "생성자":"홍길동",
	  "파일":"다운로드"
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
	    dataField : "구분",
	    headerText : "구분"
  },{
	    dataField : "Status",
	    headerText : "Status"
  },{
	    dataField : "배정방법",
	    headerText : "배정방법",
	    width : 150
  },{
	    dataField : "배정시점",
	    headerText : "배정시점"
  },{
	    dataField : "대상자 수",
	    headerText : "대상자 수"
  },{
	    dataField : "Code 수",
	    headerText : "Code 수"
  },{
	    dataField : "Type",
	    headerText : "Type"
  },{
	    dataField : "생성자",
	    headerText : "생성자"
  },{
	    dataField : "파일",
	    headerText : "파일",
	    renderer : { // HTML 템플릿 렌더러 사용
			type : "TemplateRenderer"
		},
		// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
		labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
			if(!value)	return "";		
			var template = '<div style=" margin:0 auto;">';		
			template += '<a href="#" class="my_a_tag" style=" padding:10px 10px 0 0; display:block; text-align:center;" onclick="javascript:fn_downFile();"><img src="/images/pantheon/common/AUIGrid/download_icon.png"/>';		
			template += '</a></div>';
			return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
		},
		width:65
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


function fn_downFile(){
	window.alert('다운로드');
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


						<h5>CJ 연구과제8</h5>
						<div style="height:38px;">
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold'; position:relative; top:9px;">무작위배정코드 목록</span>
							</div>
							<div class="conTitBtnR">
								<input type="button" value="폐기">
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