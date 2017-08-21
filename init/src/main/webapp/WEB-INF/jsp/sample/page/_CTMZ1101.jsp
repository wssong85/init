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
  "제목 Title":"모니터링 방문 보고 자료"
}, {
  "이름 Name":"홍길동",
  "제목 Title":"모니터링 방문 보고 자료"
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
    dataField : "제목 Title",
    headerText : "제목 Title"
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
  "모니터 Monitor":"홍길동",
  "방문시작일 Visit The Beginning":"2015.12.12",
  "방문종료일 Visit End":"2015.12.16"
}, {
  "모니터 Monitor":"홍길동",
  "방문시작일 Visit The Beginning":"2015.12.12",
  "방문종료일 Visit End":"2015.12.16"
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
    dataField : "모니터 Monitor",
    headerText : "모니터 Monitor"
  },{
    dataField : "방문시작일 Visit The Beginning",
    headerText : "방문시작일 Visit The Beginning",
    width : 200
  },{
    dataField : "방문종료일 Visit End",
    headerText : "방문종료일 Visit End",
    width : 200
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
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "CRA 성명 Name/ 서명 Signature":"홍길동/sign",
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
    dataField : "CRA 성명 Name/ 서명 Signature",
    headerText : "CRA 성명 Name/ 서명 Signature",
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








var testData_04 =[
{
  "TM 성명 Name/ 서명 Signature":"홍길동 / sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "TM 성명 Name/ 서명 Signature":"홍길동 / sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "TM 성명 Name/ 서명 Signature":"홍길동 / sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "TM 성명 Name/ 서명 Signature":"홍길동 / sign",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
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
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "TM 성명 Name/ 서명 Signature",
    headerText : "TM 성명 Name/ 서명 Signature",
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
    AUIGrid.setGridData(me.id, testData_04);
  }
};





$(document).ready(function() {
  myGridOption_01.createGrid();
  myGridOption_02.createGrid();
  myGridOption_03.createGrid();
  myGridOption_04.createGrid();
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
	if (myGridOption_04.id) {
		AUIGrid.resize(myGridOption_04.id);
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
				<h3>종료방문</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>종료방문</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">




					<article>
						<h5>시험종료방문보고서</h5>
					</article>

					<div style="height:10px;"></div>


<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->


					<table class="tb001">
						<colgroup>
							<col width="250px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>임상시험제목 Title</th>
								<td>
									<input type="text" id="" style="width:100%;" value="">
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="" style="width:93%;">
									<button type="button" class="oneBtn">
										<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
									</button>
								</td>
							</tr>
							<tr>
								<th>시험책임자 Principal Investigator</th>
								<td>
									<input type="text" id="" style="width:100%;" value="">
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h6>방문시 접촉한 연구진 Study Personnel Present During Visit</h6>
                    </article>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="" value="추가">
						<input type="button" id="" value="삭제">
					</div>
					<div id="grid_wrap_01" class="gridHeiSz02 grid_wrap tb01_2"></div>	


					<div style="height:20px;"></div>



                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h6>방문자 및 방문일 Visit &amp; Visit Date</h6>
                    </article>


					<div style="text-align:right; margin:5px;">
						<input type="button" id="" value="추가">
						<input type="button" id="" value="삭제">
					</div>
					<div id="grid_wrap_02" class="gridHeiSz02 grid_wrap tb01_2"></div>
                    




					<div style="height:20px;"></div>



                    <article class="conTitBox">
                        <h6>피험자 정보 Subject Information</h6>
                    </article>
					
					<div style="height:5px;"></div>
					
					<table class="tb001">
						<colgroup>
							<col width="50%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<td><span style="margin-right:44px;"># 목표피험자수 Total Subjects Planned</span> <input type="text" id="" style="width:100px;" value=""> 명</td>
								<td><span style="margin-right:10px;"># 완료 피험자수 Total Subjects Completed</span> <input type="text" id="" style="width:100px;" value=""> 명</td>
							</tr>
							<tr>
								<td><span style="margin-right:10px;"># 스크리닝 피험자수 Total Subjects Screened</span> <input type="text" id="" style="width:100px;" value=""> 명</td>
								<td><span style="margin-right:21px;"># 탈락 피험자수 Total Subjects Dropped</span> <input type="text" id="" style="width:100px;" value=""> 명</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>1. 증례기록서 Case Report Form</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>증례기록서 원본을 모두 수거하였습니까? Have all original CRFs been collected?</td>
								<td><input type="radio" id="a11" name="a1"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>증례기록서의 의문사항이 모두 해결되었습니까? Have all data clarification forms/queries been resolved to CRFs?</td>
								<td><input type="radio" id="a21" name="a2"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>증례기록서 원본 이외에 임상시험용물품은 모두 수거하였습니까? Have all clinical trial materials (except original CRFs) been collected?</td>
								<td><input type="radio" id="a31" name="a3"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3"><label for="a33" class="raLab"></label></td>
							</tr>

						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>2.기본문서 Essential Document</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>시험책임자는 KGCP에 따른 시험자 기본문서를 제대로 구비하고 있습니까? Is the site study file appropriately maintained according to KGCP?</td>
								<td><input type="radio" id="b11" name="b1"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>시험책임자는 문서보관(CRF, 근거문서, 시험자기본문서) 임무와 보관기간을 알고 있습니까? Has the PI been reminded of his/her records (CRF, source document and essential document) retention obligations?</td>
								<td><input type="radio" id="b21" name="b2"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>관리약사는 KGCP에 따른 기본문서를 제대로 구비하고 있습니까? Is the pharmacy file appropriately maintained according to KGCP?</td>
								<td><input type="radio" id="b31" name="b3"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>IRB는 KGCP에 따른 기본문서를 제대로 구비하고 있습니까? Is IRB’s document appropriately maintained according to KGCP?</td>
								<td><input type="radio" id="b41" name="b4"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>기관으로부터 시험의뢰자가 받아야 할 기본문서를 모두 받았습니까? Have all the essential documents of site been forwarded to sponsor?</td>
								<td><input type="radio" id="b51" name="b5"><label for="b51" class="raLab"></label></td>
								<td><input type="radio" id="b52" name="b5"><label for="b52" class="raLab"></label></td>
								<td><input type="radio" id="b53" name="b5"><label for="b53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					


					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>3.임상시험용의약품 Investigational Product Accountability</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>임상시험용의약품을 모두 반납 받았습니까? Have investigational products been returned to sponsor?</td>
								<td><input type="radio" id="c11" name="c1"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>임상시험용의약품의 수불기록 사본을 받았습니까? Have copies of accountability of all investigational product been submitted to sponsor?</td>
								<td><input type="radio" id="c21" name="c2"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2"><label for="c23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>4. 기타 Others</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody>
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>IRB에 시험종료보고 계획에 대하여 PI와 협의하였습니까? Has the PI been reminded to notify the IRB of site close-out?</td>
								<td><input type="radio" id="d11" name="d1"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>연구비 정산 및 지급에 관하여 PI와 협의하였습니까? Has the financial issue (ex. final payment) been discussed with the PI?</td>
								<td><input type="radio" id="d21" name="d2"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2"><label for="d23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>외부에 발표할 계획에 대하여 PI와 협의하였습니까? Has the publication plan been discussed with the PI?</td>
								<td><input type="radio" id="d31" name="d3"><label for="d31" class="raLab"></label></td>
								<td><input type="radio" id="d32" name="d3"><label for="d32" class="raLab"></label></td>
								<td><input type="radio" id="d33" name="d3"><label for="d33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>미해결 문제가 있습니까? Is there any unsolved problems</td>
								<td><input type="radio" id="d41" name="d4"><label for="d41" class="raLab"></label></td>
								<td><input type="radio" id="d42" name="d4"><label for="d42" class="raLab"></label></td>
								<td><input type="radio" id="d43" name="d4"><label for="d43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>이후 진행과정(Audit, 실태조사 등)에 관해 논의하였습니까? Has the PI been reminded of Audit and/or KFDA inspection?</td>
								<td><input type="radio" id="d51" name="d5"><label for="d51" class="raLab"></label></td>
								<td><input type="radio" id="d52" name="d5"><label for="d52" class="raLab"></label></td>
								<td><input type="radio" id="d53" name="d5"><label for="d53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="2" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>






				
					<div style="height:20px;"></div>
					
					
					<div id="grid_wrap_03" class="gridHeiSz03 grid_wrap tb01_2"></div>
					
					

					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>5. 권고사항 Recommendations</h6>
                    </article>
					
					
					
					<div style="height:5px;"></div>
					
					<input type="radio" id="e11" name="e1"><label for="e11" class="raLab"><span>모니터의 의견에 동의합니다. I agree with the recommendations of the monitor.</span></label>
					<br>
					<input type="radio" id="e12" name="e1"><label for="e12" class="raLab"><span>모니터의 의견에 동의하지 않습니다. I do not agree with the recommendations of the monitor.</span></label>


					<div style="height:10px;"></div>


					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Reason</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>6. 결제</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="" value="결제정보">
                        <input type="button" id="" value="결제요청">
                    </article>
					
					
					<div style="height:10px;"></div>
					
					
					<div id="grid_wrap_04" class="gridHeiSz03 grid_wrap tb01_2"></div>



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