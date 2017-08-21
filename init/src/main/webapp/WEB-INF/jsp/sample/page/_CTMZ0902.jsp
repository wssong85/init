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
  "시험실시기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
}, {
  "시험실시기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
}, {
  "시험실시기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
}, {
  "시험실시기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
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
    dataField : "시험실시기관(성명/역할) From Site (Name/Role)",
    headerText : "시험실시기관(성명/역할) From Site (Name/Role)",
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
  "의뢰자(성명/역할)From Sponsor (Name/Role)":"홍길동(김길동/파트지원 업무)"
}, {
  "의뢰자(성명/역할)From Sponsor (Name/Role)":"홍길동(김길동/파트지원 업무)"
}, {
  "의뢰자(성명/역할)From Sponsor (Name/Role)":"홍길동(김길동/파트지원 업무)"
}, {
  "의뢰자(성명/역할)From Sponsor (Name/Role)":"홍길동(김길동/파트지원 업무)"
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
    dataField : "의뢰자(성명/역할)From Sponsor (Name/Role)",
    headerText : "의뢰자(성명/역할)From Sponsor (Name/Role)",
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
							<li id="" class="tab_menu">개시 미팅 준비기록</li>
							<li id="" class="port_back tab_menu">시험 개시방문 보고서</li>
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
								<th>시험 제목 Title</th>
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
						</tbody>
					</table>
					
					
					<div style="height:20px;"></div>

                    <article class="conTitBox">
                        <h6>
							실시일 Date : 
							<div class="dateBox">
								<input type="text" id="day_01" style="width: 120px;" />
							</div>
						</h6>
                    </article>

					<div style="height:10px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h6>참가자 Attendees</h6>
                    </article>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="" value="추가">
						<input type="button" id="" value="삭제">
					</div>
					<div id="grid_wrap_01" class="gridHeiSz02 grid_wrap tb01_2"></div>	


					<div style="height:20px;"></div>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="" value="추가">
						<input type="button" id="" value="삭제">
					</div>
					<div id="grid_wrap_02" class="gridHeiSz02 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 시험계획서 Protocol</h6>
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
								<td>임상시험의 목적/디자인 Trial purpose/design</td>
								<td><input type="radio" id="a11" name="a1"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>선정/제외기준 Inclusion and exclusion criteria</td>
								<td><input type="radio" id="a21" name="a2"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>탈락/시험종료기준 Drop-out and study completion criteria</td>
								<td><input type="radio" id="a31" name="a3"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>임상시험의 절차, 요구사항 및 계획엄수 Study procedure, requirements and adherence</td>
								<td><input type="radio" id="a41" name="a4"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>시험계획서의 개정절차 Procedures for protocol amendments</td>
								<td><input type="radio" id="a51" name="a5"><label for="a51" class="raLab"></label></td>
								<td><input type="radio" id="a52" name="a5"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>시험계획서 일탈/위반사항의 문서화 Documentation of protocol deviations or violation</td>
								<td><input type="radio" id="a61" name="a6"><label for="a61" class="raLab"></label></td>
								<td><input type="radio" id="a62" name="a6"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6"><label for="a63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>2. 피험자 모집 Recruitment of Trial Subjects</h6>
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
								<td>본 기관의 모집목표 피험자 수 Planned Subjects No. : <input type="text" id="" style="width:100px;"> 명</td>
								<td><input type="radio" id="b11" name="b1"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>스크리닝 개시 예정일 Anticipated Screening Date <input type="text" id="" style="width:60px;"> 년 &nbsp;&nbsp;<input type="text" id="" style="width:40px;"> 월&nbsp;&nbsp;<input type="text" id="" style="width:40px;"> 일</td>
								<td><input type="radio" id="b21" name="b2"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>모집 기한 Recruitment timelines <input type="text" id="" style="width:60px;"> 년 &nbsp;&nbsp;<input type="text" id="" style="width:40px;"> 월&nbsp;&nbsp;<input type="text" id="" style="width:40px;"> 일</td>
								<td><input type="radio" id="b31" name="b3"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>광고매체 승인 및 개정 Advertising materials approval and revision requirements</td>
								<td><input type="radio" id="b41" name="b4"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>스크리닝 방법 Screening process</td>
								<td><input type="radio" id="b51" name="b5"><label for="b51" class="raLab"></label></td>
								<td><input type="radio" id="b52" name="b5"><label for="b52" class="raLab"></label></td>
								<td><input type="radio" id="b53" name="b5"><label for="b53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>보험 및 피험자에 대한 보상 Indemnity insurance and subject compensations</td>
								<td><input type="radio" id="b61" name="b6"><label for="b61" class="raLab"></label></td>
								<td><input type="radio" id="b62" name="b6"><label for="b62" class="raLab"></label></td>
								<td><input type="radio" id="b63" name="b6"><label for="b63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 임상시험용의약품 Investigational Product</h6>
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
								<td>임상시험용의약품 포장/배포를 위한 물품(e.g., 라벨 등) Investigational product packaging and dispensing product (e.g., label etc.)</td>
								<td><input type="radio" id="c11" name="c1"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>임상시험용의약품의 인수, 취급, 저장, 회수 및/또는 폐기 Receipt, handling, storage, return, and/or destruction of investigational product</td>
								<td><input type="radio" id="c21" name="c2"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2"><label for="c23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>피험자의 순응도 확인 Compliance check</td>
								<td><input type="radio" id="c31" name="c3"><label for="c31" class="raLab"></label></td>
								<td><input type="radio" id="c32" name="c3"><label for="c32" class="raLab"></label></td>
								<td><input type="radio" id="c33" name="c3"><label for="c33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>임상시험용의약품의 수불기록 Investigational product accountability and documentation</td>
								<td><input type="radio" id="c41" name="c4"><label for="c41" class="raLab"></label></td>
								<td><input type="radio" id="c42" name="c4"><label for="c42" class="raLab"></label></td>
								<td><input type="radio" id="c43" name="c4"><label for="c43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>무작위배정 절차 Randomization procedures</td>
								<td><input type="radio" id="c51" name="c5"><label for="c51" class="raLab"></label></td>
								<td><input type="radio" id="c52" name="c5"><label for="c52" class="raLab"></label></td>
								<td><input type="radio" id="c53" name="c5"><label for="c53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>눈가림 방법 및 눈가림 해제에 관한 절차 Blinding and code breaking procedures</td>
								<td><input type="radio" id="c61" name="c6"><label for="c61" class="raLab"></label></td>
								<td><input type="radio" id="c62" name="c6"><label for="c62" class="raLab"></label></td>
								<td><input type="radio" id="c63" name="c6"><label for="c63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>4. 시험자 및 연구진 Investigator and Staff</h6>
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
								<td>시험자 및 연구진의 변경사항 Change of investigator &amp; staff</td>
								<td><input type="radio" id="d11" name="d1"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>KGCP 및 관련 규정의 준수 Compliance with KGCP &amp; applicable regulatory requirements</td>
								<td><input type="radio" id="d21" name="d2"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2"><label for="d23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>역할 할당 및 문서화 Delegation and documentation of duties</td>
								<td><input type="radio" id="d31" name="d3"><label for="d31" class="raLab"></label></td>
								<td><input type="radio" id="d32" name="d3"><label for="d32" class="raLab"></label></td>
								<td><input type="radio" id="d33" name="d3"><label for="d33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>5. 피험자 동의 절차 Informed Consent Process</h6>
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
								<td>피험자 동의서 취득 절차 Procedures of obtaining and documenting informed consent</td>
								<td><input type="radio" id="e11" name="e1"><label for="e11" class="raLab"></label></td>
								<td><input type="radio" id="e12" name="e1"><label for="e12" class="raLab"></label></td>
								<td><input type="radio" id="e13" name="e1"><label for="e13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>피험자 동의서 변경 절차 Procedures for informed consent form amendment</td>
								<td><input type="radio" id="e21" name="e2"><label for="e21" class="raLab"></label></td>
								<td><input type="radio" id="e22" name="e2"><label for="e22" class="raLab"></label></td>
								<td><input type="radio" id="e23" name="e2"><label for="e23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>서명된 피험자 동의서 보관 Documentation and retention of all signed informed consent</td>
								<td><input type="radio" id="e31" name="e3"><label for="e31" class="raLab"></label></td>
								<td><input type="radio" id="e32" name="e3"><label for="e32" class="raLab"></label></td>
								<td><input type="radio" id="e33" name="e3"><label for="e33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>6. 근거문서 Source Documents</h6>
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
								<td>시험기관에서 사용하는 근거문서의 범위 Source document definition and source documents used by the site</td>
								<td><input type="radio" id="f11" name="f1"><label for="f11" class="raLab"></label></td>
								<td><input type="radio" id="f12" name="f1"><label for="f12" class="raLab"></label></td>
								<td><input type="radio" id="f13" name="f1"><label for="f13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>임상시험 관련 기록의 보존 Maintenance of trial documents</td>
								<td><input type="radio" id="f21" name="f2"><label for="f21" class="raLab"></label></td>
								<td><input type="radio" id="f22" name="f2"><label for="f22" class="raLab"></label></td>
								<td><input type="radio" id="f23" name="f2"><label for="f23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>SDV 절차 Source document verification process</td>
								<td><input type="radio" id="f31" name="f3"><label for="f31" class="raLab"></label></td>
								<td><input type="radio" id="f32" name="f3"><label for="f32" class="raLab"></label></td>
								<td><input type="radio" id="f33" name="f3"><label for="f33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>근거문서 간에 불일치한 내용의 확인수정 Process for clarifying source document discrepancies</td>
								<td><input type="radio" id="f41" name="f4"><label for="f41" class="raLab"></label></td>
								<td><input type="radio" id="f42" name="f4"><label for="f42" class="raLab"></label></td>
								<td><input type="radio" id="f43" name="f4"><label for="f43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>근거문서에 대한 접근 (전자문서 포함) Access to source documents(including electronic data)</td>
								<td><input type="radio" id="f51" name="f5"><label for="f51" class="raLab"></label></td>
								<td><input type="radio" id="f52" name="f5"><label for="f52" class="raLab"></label></td>
								<td><input type="radio" id="f53" name="f5"><label for="f53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>7. 증례기록서 및 데이터의 수집 Case Report Form and Data Collection</h6>
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
								<td>증례기록서 작성을 위한 세부지침CRF completion guidelines</td>
								<td><input type="radio" id="g11" name="g1"><label for="g11" class="raLab"></label></td>
								<td><input type="radio" id="g12" name="g1"><label for="g12" class="raLab"></label></td>
								<td><input type="radio" id="g13" name="g1"><label for="g13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>수정에 관한 절차 Procedures for corrections</td>
								<td><input type="radio" id="g21" name="g2"><label for="g21" class="raLab"></label></td>
								<td><input type="radio" id="g22" name="g2"><label for="g22" class="raLab"></label></td>
								<td><input type="radio" id="g23" name="g2"><label for="g23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>증례기록서/데이터의 서명에 관한 사항 CRF/Data signature requirements</td>
								<td><input type="radio" id="g31" name="g3"><label for="g31" class="raLab"></label></td>
								<td><input type="radio" id="g32" name="g3"><label for="g32" class="raLab"></label></td>
								<td><input type="radio" id="g33" name="g3"><label for="g33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>증례기록서/데이터의 작성기한 CRF/Data completion timelines</td>
								<td><input type="radio" id="g41" name="g4"><label for="g41" class="raLab"></label></td>
								<td><input type="radio" id="g42" name="g4"><label for="g42" class="raLab"></label></td>
								<td><input type="radio" id="g43" name="g4"><label for="g43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>데이터 쿼리 해결 절차 Process of query resolution</td>
								<td><input type="radio" id="g51" name="g5"><label for="g51" class="raLab"></label></td>
								<td><input type="radio" id="g52" name="g5"><label for="g52" class="raLab"></label></td>
								<td><input type="radio" id="g53" name="g5"><label for="g53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>전자자료 및 기록에 대한 규정의 준수 Regulatory requirements for electronic data and records</td>
								<td><input type="radio" id="g61" name="g6"><label for="g61" class="raLab"></label></td>
								<td><input type="radio" id="g62" name="g6"><label for="g62" class="raLab"></label></td>
								<td><input type="radio" id="g63" name="g6"><label for="g63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>8. 안전성 정보 Safety Information</h6>
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
								<td>이상반응 및 중대한 이상반응의 정의 Definition of AE and SAE	</td>
								<td><input type="radio" id="h11" name="h1"><label for="h11" class="raLab"></label></td>
								<td><input type="radio" id="h12" name="h1"><label for="h12" class="raLab"></label></td>
								<td><input type="radio" id="h13" name="h1"><label for="h13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>이상반응 및 중대한 이상반응의 보고에 관한 사항 AE and SAE reporting requirements</td>
								<td><input type="radio" id="h21" name="h2"><label for="h21" class="raLab"></label></td>
								<td><input type="radio" id="h22" name="h2"><label for="h22" class="raLab"></label></td>
								<td><input type="radio" id="h23" name="h2"><label for="h23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>중대한 이상반응 발생 시 연락처 Contact information of sponsor</td>
								<td><input type="radio" id="h31" name="h3"><label for="h31" class="raLab"></label></td>
								<td><input type="radio" id="h32" name="h3"><label for="h32" class="raLab"></label></td>
								<td><input type="radio" id="h33" name="h3"><label for="h33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>이상반응 및 중대한 이상반응의 추적관찰에 관한 사항 AE and SAE  follow-up</td>
								<td><input type="radio" id="h41" name="h4"><label for="h41" class="raLab"></label></td>
								<td><input type="radio" id="h42" name="h4"><label for="h42" class="raLab"></label></td>
								<td><input type="radio" id="h43" name="h4"><label for="h43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>9. 임상시험 관련 설비 및 기기 Facility and Equipment of Site</h6>
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
								<td>설비 및 기기가 임상시험을 실시하기 적절한지 여부 Adequate facilities and equipment for the trial</td>
								<td><input type="radio" id="i11" name="i1"><label for="i11" class="raLab"></label></td>
								<td><input type="radio" id="i12" name="i1"><label for="i12" class="raLab"></label></td>
								<td><input type="radio" id="i13" name="i1"><label for="i13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>약국 그리고/또는 임상시험용의약품 저장소의 적합성 Adequate (or secure) storage space for investigational product</td>
								<td><input type="radio" id="i21" name="i2"><label for="i21" class="raLab"></label></td>
								<td><input type="radio" id="i22" name="i2"><label for="i22" class="raLab"></label></td>
								<td><input type="radio" id="i23" name="i2"><label for="i23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>임상검사실 설비 및 기기의 적합성 Adequate laboratory facilities and equipment</td>
								<td><input type="radio" id="i31" name="i3"><label for="i31" class="raLab"></label></td>
								<td><input type="radio" id="i32" name="i3"><label for="i32" class="raLab"></label></td>
								<td><input type="radio" id="i33" name="i3"><label for="i33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>문서보관장소의 적합성 Adequate (or secure) storage space for record keeping</td>
								<td><input type="radio" id="i41" name="i4"><label for="i41" class="raLab"></label></td>
								<td><input type="radio" id="i42" name="i4"><label for="i42" class="raLab"></label></td>
								<td><input type="radio" id="i43" name="i4"><label for="i43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>임상시험 관련 기기에 관한 품질 관리 기록 Record requirement for quality control of trial equipment</td>
								<td><input type="radio" id="i51" name="i5"><label for="i51" class="raLab"></label></td>
								<td><input type="radio" id="i52" name="i5"><label for="i52" class="raLab"></label></td>
								<td><input type="radio" id="i53" name="i5"><label for="i53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>10.의학적 처치 및 검사/실험실적 검사 등 Medical/Laboratory/Technical Procedures/Tests</h6>
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
								<td>실험실적 검사 또는 기타 의학적 검사 수행절차 Procedures for performing laboratory and other medical tests</td>
								<td><input type="radio" id="j11" name="j1"><label for="j11" class="raLab"></label></td>
								<td><input type="radio" id="j12" name="j1"><label for="j12" class="raLab"></label></td>
								<td><input type="radio" id="j13" name="j1"><label for="j13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>생체 시료의 수집, 처리, 저장 및 운송 Collection, handling, storage and transportation of biological specimens</td>
								<td><input type="radio" id="j21" name="j2"><label for="j21" class="raLab"></label></td>
								<td><input type="radio" id="j22" name="j2"><label for="j22" class="raLab"></label></td>
								<td><input type="radio" id="j23" name="j2"><label for="j23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>추가로 실시한 실험실적 검사 및 기타 의학적 검사의 검토에 대한 시험자의 책임 Investigator’s responsibilities for review and follow-up of laboratory reports and other medical data</td>
								<td><input type="radio" id="j31" name="j3"><label for="j31" class="raLab"></label></td>
								<td><input type="radio" id="j32" name="j3"><label for="j32" class="raLab"></label></td>
								<td><input type="radio" id="j33" name="j3"><label for="j33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>11.추가적인 시험자의 의무 Additional Investigator Obligations</h6>
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
								<td>IRB와의 의사소통 Communication with IRB</td>
								<td><input type="radio" id="k11" name="k1"><label for="k11" class="raLab"></label></td>
								<td><input type="radio" id="k12" name="k1"><label for="k12" class="raLab"></label></td>
								<td><input type="radio" id="k13" name="k1"><label for="k13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>모니터링 방문 계획 및 요청 사항 Monitoring visits schedule and requirements</td>
								<td><input type="radio" id="k21" name="k2"><label for="k21" class="raLab"></label></td>
								<td><input type="radio" id="k22" name="k2"><label for="k22" class="raLab"></label></td>
								<td><input type="radio" id="k23" name="k2"><label for="k23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>점검 및 규제기관의 실태조사 Sponsor audits and regulatory authority inspections</td>
								<td><input type="radio" id="k31" name="k3"><label for="k31" class="raLab"></label></td>
								<td><input type="radio" id="k32" name="k3"><label for="k32" class="raLab"></label></td>
								<td><input type="radio" id="k33" name="k3"><label for="k33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>시험결과 출판에 관한 정책 Publication policy</td>
								<td><input type="radio" id="k41" name="k4"><label for="k41" class="raLab"></label></td>
								<td><input type="radio" id="k42" name="k4"><label for="k42" class="raLab"></label></td>
								<td><input type="radio" id="k43" name="k4"><label for="k43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>연구비 결산에 관한 절차 Financial disclosure procedures</td>
								<td><input type="radio" id="k51" name="k5"><label for="k51" class="raLab"></label></td>
								<td><input type="radio" id="k52" name="k5"><label for="k52" class="raLab"></label></td>
								<td><input type="radio" id="k53" name="k5"><label for="k53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>12.필수문서 Required Documents</h6>
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
								<td>시험자 기본문서파일 및 임상시험기본문서 Site study file and essential documents</td>
								<td><input type="radio" id="l11" name="l1"><label for="l11" class="raLab"></label></td>
								<td><input type="radio" id="l12" name="l1"><label for="l12" class="raLab"></label></td>
								<td><input type="radio" id="l13" name="l1"><label for="l13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>임상시험 관련 문서(근거문서 포함)의 보관 및 유지 Retention and archiving of trial documents(including source data and source documents)</td>
								<td><input type="radio" id="l21" name="l2"><label for="l21" class="raLab"></label></td>
								<td><input type="radio" id="l22" name="l2"><label for="l22" class="raLab"></label></td>
								<td><input type="radio" id="l23" name="l2"><label for="l23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>13. 임상시험 관련 물품의 인수 인계 현황 Receipt of Study Materials</h6>
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
								<td>임상시험계획서 Protocol</td>
								<td><input type="radio" id="m11" name="m1"><label for="m11" class="raLab"></label></td>
								<td><input type="radio" id="m12" name="m1"><label for="m12" class="raLab"></label></td>
								<td><input type="radio" id="m13" name="m1"><label for="m13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>시험자 기본문서파일 Site study file</td>
								<td><input type="radio" id="m21" name="m2"><label for="m21" class="raLab"></label></td>
								<td><input type="radio" id="m22" name="m2"><label for="m22" class="raLab"></label></td>
								<td><input type="radio" id="m23" name="m2"><label for="m23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>임상시험자자료집 Investigator’s Brochure</td>
								<td><input type="radio" id="m31" name="m3"><label for="m31" class="raLab"></label></td>
								<td><input type="radio" id="m32" name="m3"><label for="m32" class="raLab"></label></td>
								<td><input type="radio" id="m33" name="m3"><label for="m33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>증례기록서 Case report forms</td>
								<td><input type="radio" id="m41" name="m4"><label for="m41" class="raLab"></label></td>
								<td><input type="radio" id="m42" name="m4"><label for="m42" class="raLab"></label></td>
								<td><input type="radio" id="m43" name="m4"><label for="m43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>피험자 동의서 Informed consent forms</td>
								<td><input type="radio" id="m51" name="m5"><label for="m51" class="raLab"></label></td>
								<td><input type="radio" id="m52" name="m5"><label for="m52" class="raLab"></label></td>
								<td><input type="radio" id="m53" name="m5"><label for="m53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>눈가림 봉투 Blinding envelopes</td>
								<td><input type="radio" id="m61" name="m6"><label for="m61" class="raLab"></label></td>
								<td><input type="radio" id="m62" name="m6"><label for="m62" class="raLab"></label></td>
								<td><input type="radio" id="m63" name="m6"><label for="m63" class="raLab"></label></td>
							</tr>
							<tr>
								<td>7</td>
								<td>기타 물품 Other supplements:</td>
								<td><input type="radio" id="m71" name="m7"><label for="m71" class="raLab"></label></td>
								<td><input type="radio" id="m72" name="m7"><label for="m72" class="raLab"></label></td>
								<td><input type="radio" id="m73" name="m7"><label for="m73" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>






					<table class="tb001">
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
                        <h6>14. 결제</h6>
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