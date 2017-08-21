<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<%
	final String pathUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>

<jsp:include page="/com/common.do" flush="false"/>


<title></title>
<script>

var testData_01 =[
{
  "역할 Role":"작성자 Prepared by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"시험책임자 Adjusted by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"시험책임자 Adjusted by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
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
    dataField : "역할 Role",
    headerText : "역할 Role",
    width : 200
  },{
    dataField : "성명 Name/ 서명 Signature",
    headerText : "성명 Name/ 서명 Signature",
    width : 300
  },{
    dataField : "날짜 Date(yyyy.mm.dd)",
    headerText : "날짜 Date(yyyy.mm.dd)"
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





$(document).ready(function() {
  myGridOption_01.createGrid();
});


window.onresize = function() {
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
};






</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
	<section id="mainCon">
		<div class="mainConInner">


            <section class="conBox100 conBox">
                <div class="conBoxInner">
					<article class="conTitBox">
						<h5>그리드</h5>
					</article>
					<br><br>
<pre>

그리드 기본 포멧 퍼블 단에서 기본적으로 부여한 내용


＊＊＊＊ 스크립트 부분 ＊＊＊＊
var <span style="background:aqua;">testData_01</span> =[
{
  "역할 Role":"작성자 Prepared by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"시험책임자 Adjusted by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"시험책임자 Adjusted by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}];



var <span style="background:aqua;">myGridOption_01</span> = {
  id: '',

  div: {
    gridDiv: '<span style="background:aqua;">#grid_wrap_01</span>'
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
    dataField : "역할 Role",
    headerText : "역할 Role",
    width : 200
  },{
    dataField : "성명 Name/ 서명 Signature",
    headerText : "성명 Name/ 서명 Signature",
    width : 300
  },{
    dataField : "날짜 Date(yyyy.mm.dd)",
    headerText : "날짜 Date(yyyy.mm.dd)"
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
    AUIGrid.setGridData(me.id, <span style="background:aqua;">testData_01</span>);
  }
};





$(document).ready(function() {
  <span style="background:aqua;">myGridOption_01</span>.createGrid();
});




$(window).resize(function(){
	if (<span style="background:aqua;">myGridOption_01.id</span>) {
		AUIGrid.resize(<span style="background:aqua;">myGridOption_01.id</span>);
	}
});




＊＊＊＊ html 부분 ＊＊＊＊
&lt;article class="mgT16"&gt;
    &lt;div id="<span style="background:aqua;">grid_wrap_01</span>" class="gridHeiSz02 grid_wrap tb01_2"&gt;&lt;/div&gt;
&lt;/article&gt;


<div style="border-top:1px solid black;"></div>

주의 
1. 리사이즈 할때 아래처럼 쓰면 안됨
    레어어 팝업뜰때 본페이지에 그리드 리사이징이 먹히지 않음
    레이어 팝업에 html테그로 시작 하는 부분은 괜찮음 
    div로 시작 하는 레이어 팝업에서 리사이징 되지않음

<strike>window.onresize = function() {
	if (<span style="background:aqua;">myGridOption_01.id</span>) {
		AUIGrid.resize(<span style="background:aqua;">myGridOption_01.id)</span>;
	}
};</strike>


$(window).resize(function(){
	if (<span style="background:aqua;">myGridOption_01.id</span>) {
		AUIGrid.resize(<span style="background:aqua;">myGridOption_01.id</span>);
	}
});






2. 그리드에서 데이타 내용 없을때 자체 지원하는 페이징과 필터가 이상한 곳에 붙어 있을 경우
    아래처럼 시간차를 둠
createGrid: function() {
	var me = this;
	me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	me.binding();

<span style="background:aqua;">	window.setTimeout(function(){
		AUIGrid.resize(me.id);
		}, 0.5);</span>

	if(me.proxy.autoLoad) {
		me.load();
		}
	},






3. 항목 부분이 2행 일경우
    그리드 스타일 재 선언(항목 센터정렬)하고 옵션을 바꿔주면 됨
<span style=" text-decoration: underline;"><a href="<%=pathUrl%>/sample/page/_IWRG0102.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0102.do</a></span>






4. 쿼리 업로드 버튼 클릭하면 레이어 팝업이 뜨는데 본페이지에  레이어팝업에 id를 찾아 리사이징관련 함수 써줌
<span style=" text-decoration: underline;"><a href="<%=pathUrl%>/sample/page/_EDCD0101.do" target="_blank"><%=pathUrl%>/sample/page/_EDCD0101.do</a></span>
$(function(){
	// 팝업레이어
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./_EDCD0105.do", null);
		<span style="background:aqua;">AUIGrid.resize(myGridOption_01.id)</span>; //팝업레이어 id
	});

	//$('.popup_01').trigger('click');
	});
	
});



5. 그리드에 이미지 아이콘 적용(아이콘 버튼)
<span style=" text-decoration: underline;"><a href="<%=pathUrl%>/sample/page/_IWRG0104.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0104.do</a></span>






6. 그리드 저작권 부분 숨김 방법(공통)
AUIGrid_style.css 맨 상단에

&lt;style&gt;
<span style="background:aqua;">.aui-vscrollbar + div{ display:none; }</span>
&lt;/style&gt;



</pre>


                </div>
            </section>










            <section class="conBox100 conBox">
                <div class="conBoxInner">
					<article class="conTitBox">
						<h5>name</h5>
					</article>
					<br><br>
					
                </div>
            </section>





		</div>
	</section>



</div>
</body>
</html>