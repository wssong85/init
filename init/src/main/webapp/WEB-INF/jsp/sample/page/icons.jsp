<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>


<title>메인</title>
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
						<h5>달력</h5>
					</article>
					
<script>
$(function() {
	  mkSetDatePickerYYMMDD("#aaaa");
	  mkSetDatePickerYYMMDD("#bbbb");
	  $("#bbbb").val("2000-12-12")
	  $('#bbbb').datepicker('disable');	//달력 비활성(분기화 해서 처리)
});
</script>
<br>
<br>
<div class="dateBox">
	<input type="text" id="aaaa" style="width: 120px;" /> 
</div> (활성)
<br>
<br>
<div class="dateBox">
	<input type="text" id="bbbb" style="width: 120px;" /> 
</div> (비활성)
<br>
<br>



<style>
.ui-datepicker .ui-datepicker-buttonpane{ display:none;}
</style>
<script type="text/javascript" src="/js/pantheon/common/unified.cubesafety.js"></script>
<div class="dateBox">
	<input type="text" id="" style="width: 120px;" data-datatype="DATE" data-yyuk="Y" data-mmuk="Y" data-dduk="Y" />
</div> (하단에 추가 버튼 있는 달력)
<br>
	
					
                </div>
            </section>










            <section class="conBox100 conBox">
                <div class="conBoxInner">
					<article class="conTitBox">
						<h5>텍스트 버튼 아이콘화</h5>
					</article>



                    <article class="conTitBtnR">
                    	<input type="button" id="" value="수정">
						<input type="button" id="" value="행추가">
						<input type="button" id="" value="행삭제">
						<input type="button" id="" value="저장">
						<input type="button" id="" value="닫기">
						<input type="button" id="" value="초기화">
						/
						<input type="button" id="" value="Comment">
						<input type="button" id="" value="Audit">
						<input type="button" id="" value="Query">
						<input type="button" id="" value="보고서작성">
                    </article>


					<br><br>




                    <article class="conTitBtnR">
                    	<input type="button" id="" value="수정" class="edit_01" title="수정">
						<input type="button" id="" value="행추가" class="add_01" title="행추가">
						<input type="button" id="" value="행삭제" class="del_01" title="행삭제">
						<input type="button" id="" value="저장" class="save_01" title="저장">
						<input type="button" id="" value="닫기" class="close_01" title="닫기">
						<input type="button" id="" value="초기화" class="reset_01" title="초기화">
						/
						<input type="button" id="" value="Comment" class="comment_01" title="Comment">
						<input type="button" id="" value="Audit" class="audit_01" title="Audit">
						<input type="button" id="" value="Query" class="query_01" title="Query">
						<input type="button" id="" value="보고서작성" class="report_write_01" title="보고서작성">
						/
						<input type="button" id="" value="저장" class="save_02" title="저장">
						
                    </article>

					
					<br><br>



                    <article class="mgT16">
                        <div id="grid_wrap_01" class="gridHeiSz02 grid_wrap tb01_2"></div>
                    </article>

					<br>
					
		
                    <article class="conTitBtnR">
                    	<button type="button" id="" class="edit_01" title="수정">수정</button>
						<button type="button" id="" class="add_01" title="행추가">행추가</button>
						<button type="button" id="" class="del_01" title="행삭제">행삭제</button>
						<button type="button" id="" class="save_01" title="저장">저장</button>
						<button type="button" id="" class="close_01" title="닫기">닫기</button>
						<button type="button" id="" class="reset_01" title="초기화">초기화</button>
						/
						<button type="button" id="" class="comment_01" title="Comment">Comment</button>
						<button type="button" id="" class="audit_01" title="Audit">Audit</button>
						<button type="button" id="" class="query_01" title="Query">Query</button>
						<button type="button" id="" class="report_write_01" title="보고서작성">보고서작성</button>
						/
						<button type="button" class="oneBtn" popup_type="ProductSearch">
							<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
						</button>
                    </article>

					<br>


					<div style="margin-top:20px; background:#ebebeb; height:30px;"></div>


					<br>


<pre>
아래 <span style="background:aqua;">야광색 부분 복사</span>해서 붙여넣기 하시면 됩니다.

수정 : &lt;input type="button" id="" value="수정"<span style="background:aqua;"> class="edit_01" title="수정"</span> &gt
행추가 : &lt;input type="button" id="" value="행추가"<span style="background:aqua;"> class="add_01" title="행추가"</span> &gt
행삭제 : &lt;input type="button" id="" value="행삭제"<span style="background:aqua;"> class="del_01" title="행삭제"</span> &gt
저장 : &lt;input type="button" id="" value="저장"<span style="background:aqua;"> class="save_01" title="저장"</span> &gt
닫기 : &lt;input type="button" id="" value="닫기"<span style="background:aqua;"> class="close_01" title="닫기"</span> &gt
초기화 : &lt;input type="button" id="" value="초기화"<span style="background:aqua;"> class="reset_01" title="초기화"</span> &gt

Comment : &lt;input type="button" id="" value="Comment"<span style="background:aqua;"> class="comment_01" title="Comment"</span> &gt
Audit : &lt;input type="button" id="" value="Audit"<span style="background:aqua;"> class="audit_01" title="Audit"</span> &gt
Query : &lt;input type="button" id="" value="Query"<span style="background:aqua;"> class="query_01" title="Query"</span> &gt
보고서작성 : &lt;input type="button" id="" value="보고서작성"<span style="background:aqua;"> class="report_write_01" title="보고서작성"</span> &gt


---------------------------------------------------------------------------------------------------------

수정 : &lt;button type="button" id=""<span style="background:aqua;"> class="edit_01" title="수정"</span> &gt;수정&lt;/button&gt;
행추가 : &lt;button type="button" id=""<span style="background:aqua;"> class="add_01" title="행추가"</span> &gt;행추가&lt;/button&gt;
행삭제 : &lt;button type="button" id=""<span style="background:aqua;"> class="del_01" title="행삭제"</span> &gt;행삭제&lt;/button&gt;
저장 : &lt;button type="button" id=""<span style="background:aqua;"> class="save_01" title="저장"</span> &gt;저장&lt;/button&gt;
닫기 : &lt;button type="button" id=""<span style="background:aqua;"> class="close_01" title="닫기"</span> &gt;닫기&lt;/button&gt;
초기화 : &lt;button type="button" id=""<span style="background:aqua;"> class="reset_01" title="초기화"</span> &gt;초기화&lt;/button&gt;

Comment : &lt;button type="button" id=""<span style="background:aqua;"> class="comment_01" title="Comment"</span> &gt;Comment&lt;/button&gt;
Audit : &lt;button type="button" id=""<span style="background:aqua;"> class="audit_01" title="Audit"</span> &gt;Audit&lt;/button&gt;
Query : &lt;button type="button" id=""<span style="background:aqua;"> class="query_01" title="Query"</span> &gt;Query&lt;/button&gt;
보고서작성 : &lt;button type="button" id=""<span style="background:aqua;"> class="report_write_01" title="보고서작성"</span> &gt;Query&lt;/button&gt;

</pre>









                </div>
            </section>





		</div>
	</section>



</div>
</body>
</html>