<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<script>


var testData_01 =[
{
  "이름 Name":"홍길동",
  "역할 Role":"역할",
  "소속 Division":"소속입니다"
}, {
  "이름 Name":"홍길동",
  "역할 Role":"역할",
  "소속 Division":"소속입니다"
}, {
  "이름 Name":"홍길동",
  "역할 Role":"역할",
  "소속 Division":"소속입니다"
}, {
  "이름 Name":"홍길동",
  "역할 Role":"역할",
  "소속 Division":"소속입니다"
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
    dataField : "이름 Name",
    headerText : "이름 Name",
    width : 100
  },{
    dataField : "역할 Role",
    headerText : "역할 Role",
    width : 200
  },{
    dataField : "소속 Division",
    headerText : "소속 Division"

  
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
  "이름 Name":"김길동",
  "역할 Role":"역할임",
  "소속 Division":"김길동소속입니다"
}, {
  "이름 Name":"홍길동",
  "역할 Role":"역할",
  "소속 Division":"소속입니다"
}, {
  "이름 Name":"홍길동",
  "역할 Role":"역할",
  "소속 Division":"소속입니다"

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
    dataField : "이름 Name",
    headerText : "이름 Name",
    width : 100
  },{
    dataField : "역할 Role",
    headerText : "역할 Role",
    width : 200
  },{
    dataField : "소속 Division",
    headerText : "소속 Division"

  
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
  "역할 Role":"CRA Prepared by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"CRM Reviewed by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"TM Approved by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"

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
    AUIGrid.setGridData(me.id, testData_03);
  }
};





$(document).ready(function() {
  myGridOption_01.createGrid();
  myGridOption_02.createGrid();
  myGridOption_03.createGrid();
  mkSetDatePickerYYMMDD("#day_01");
  mkSetDatePickerYYMMDD("#day_02");
  mkSetDatePickerYYMMDD("#day_03");
  mkSetDatePickerYYMMDD("#day_04");
});


window.onresize = function() {
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if (myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
	}
	if (myGridOption_03.id) {
		AUIGrid.resize(myGridOption_03.id);
	}
};


</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>

						
	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>개시 미팅</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>개시 미팅</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">



					<div id="tab" class="tab tab01">
						<ul>
							<li id="" class="port_back tab_menu">개시 미팅 준비기록</li>
							<li id="" class="tab_menu">시험 개시방문 보고서</li>
						</ul>
					</div>



<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->


					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>시험제목 Title</th>
								<td>
									<input type="text" id="" style="width:93%;">
									<button type="button" class="oneBtn">
										<img class="oneBtnIco" src="http://52.2.72.226:8080/images/pantheon/common/searchIco.png" alt="검색">
									</button>
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="" style="width:100%;">
								</td>
							</tr>
							<tr>
								<th>시험책임자 Principal Investigator</th>
								<td>
									<input type="text" id="" style="width:93%;">
									<button type="button" class="oneBtn">
										<img class="oneBtnIco" src="http://52.2.72.226:8080/images/pantheon/common/searchIco.png" alt="검색">
									</button>
								</td>
							</tr>
							<tr>
								<th>일시 Date &amp; Time</th>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>장소 Place</th>
								<td>
									<input type="text" id="" style="width:100%;">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 참석자 Attendants</h6>
                    </article>
                    

                    <article class="conTitBtnR">
                        <input type="button" id="" value="추가">
                        <input type="button" id="" value="삭제">
                    </article>
					<div style="height:10px;"></div>

					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>2. 내부참석자 In-house Attendants</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="" value="추가">
                        <input type="button" id="" value="삭제">
                    </article>
					<div style="height:10px;"></div>
					<div id="grid_wrap_02" class="gridHeiSz03 grid_wrap tb01_2"></div>





					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>3. 진행 스케줄 및 담당자 Time Schedule and Responsible Person</h6>
                    </article>

					<div style="height:10px;"></div>

					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th style="text-align:center; padding-left:4px;">항목<br>Items</th>
								<th style="text-align:center; padding-left:4px;">담당자<br>Responsible Person</th>
								<th style="text-align:center; padding-left:4px;">일정<br>Time schedule (yyyy.mm.dd)</th>
							</tr>
							<tr>
								<th colspan="3">개시미팅 실지 전</th>
							</tr>
							<tr>
								<td>일정확인</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td>
									<div class="dateBox">
										<input type="text" id="day_02" style="width: 120px;" />
									</div>
									~
									<div class="dateBox">
										<input type="text" id="day_03" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<td>예산확인</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td>
									<div class="dateBox">
										<input type="text" id="day_04" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<td>장소섭외</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>기관 및 내부참석자 연락</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>교통편 및 숙박시설 예약</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>시험자 파일 준비</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>임상시험용의 약품 배송확인</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>약품파일준비</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>회의참석자명단준비</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>위임서명록 준비</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>프리젠테이션 자료 준비</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>개시미팅 초대장 발송</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>기타 1(빔, 노트북, 포인터 등)</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>기타 2(도시락, 다과 등)</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<th colspan="3">개시미팅 실지 중</th>
							</tr>
							<tr>
								<td>회의실 세팅</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>접수 및 안내</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>불참자 및 연착자 확인</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>프리젠테이션 및 교육</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>프리젠테이션 어시스트</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>문서서명 및 확인</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>회의록작성</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>질의응답</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<th colspan="3">개시미팅 실시 후</th>
							</tr>
							<tr>
								<td>행사 후 회의실 정리</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
							<tr>
								<td>개시미팅 보고서 작성</td>
								<td><input type="text" id="" style="width:100%;"></td>
								<td></td>
							</tr>
						</tbody>
					</table>






					<table class="tb001" style="border:none;">
						<colgroup>
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>비고 Remark</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="3" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 결제</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="" value="결제정보">
                        <input type="button" id="" value="결제요청">
                    </article>
					<div style="height:10px;"></div>
					<div id="grid_wrap_03" class="gridHeiSz03 grid_wrap tb01_2"></div>



					<div style="height:20px;"></div>



                    <div style="text-align:center;">
                        <input type="button" id="" value="저장">
                        <input type="button" id="" value="출력">
                    </div>




							
				</div>
            </section>

		</div>
	</section>

</div>
</body>
</html>