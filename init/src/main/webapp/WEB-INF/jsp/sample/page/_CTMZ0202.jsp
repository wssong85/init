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
  "연구기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
}, {
  "연구기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
}, {
  "연구기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
}, {
  "연구기관(성명/역할) From Site (Name/Role)":"한양대 연구기관(홍길동/세포연구)"
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
    dataField : "연구기관(성명/역할) From Site (Name/Role)",
    headerText : "연구기관(성명/역할) From Site (Name/Role)",
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
  "회사(성명/역할)From Sponsor (Name/Role)":"대성기업(김길동/파트지원 업무)"
}, {
  "회사(성명/역할)From Sponsor (Name/Role)":"대성기업(김길동/파트지원 업무)"
}, {
  "회사(성명/역할)From Sponsor (Name/Role)":"대성기업(김길동/파트지원 업무)"
}, {
  "회사(성명/역할)From Sponsor (Name/Role)":"대성기업(김길동/파트지원 업무)"
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
    dataField : "회사(성명/역할)From Sponsor (Name/Role)",
    headerText : "회사(성명/역할)From Sponsor (Name/Role)",
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
  "역할 Role":"PMO Adjusted by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"PD Approved by",
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
							<li id="" class="tab_menu">개시방문 준비기록</li>
							<li id="" class="port_back tab_menu">개시방문 보고서</li>
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
								<th>연구제목 Title</th>
								<td>
									<input type="text" id="" style="width:93%;">
									<button type="button" class="oneBtn">
										<img class="oneBtnIco" src="http://52.2.72.226:8080/images/pantheon/common/searchIco.png" alt="검색">
									</button>
								</td>
							</tr>
							<tr>
								<th>연구기관 Site Name</th>
								<td>
									<input type="text" id="" style="width:100%;">
								</td>
							</tr>
							<tr>
								<th>책임연구자 Principal Investigator</th>
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
                        <h6>1. 연구계획서 Protocol</h6>
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
								<td>연구의 목적/디자인 Trial purpose/design</td>
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
								<td>탈락/연구종료기준 Drop-out and study completion criteria</td>
								<td><input type="radio" id="a31" name="a3"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>연구의 절차, 요구사항 및 계획엄수 Study procedure, requirements and adherence</td>
								<td><input type="radio" id="a41" name="a4"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4"><label for="a43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>2. 연구대상자 모집 Recruitment of Trial Subjects</h6>
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
								<td>본 기관의 모집 목표 연구 대상자 수 Planned Subjects No. : <input type="text" id="" style="width:100px;"> 명</td>
								<td><input type="radio" id="b11" name="b1"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>연구시작일 Start Date of Study : <input type="text" id="" style="width:60px;"> 년 &nbsp;&nbsp;<input type="text" id="" style="width:40px;"> 월&nbsp;&nbsp;<input type="text" id="" style="width:40px;"> 일</td>
								<td><input type="radio" id="b21" name="b2"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2"><label for="b23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 연구자 Investigator</h6>
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
								<td>연구자의 변경사항 Change of investigator</td>
								<td><input type="radio" id="c11" name="c1"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>역할 할당 및 문서화  Delegation and documentation of duties</td>
								<td><input type="radio" id="c21" name="c2"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2"><label for="c23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>4. 연구대상자 동의 절차 Informed Consent Process</h6>
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
								<td>연구자의 변경사항 Change of investigator</td>
								<td><input type="radio" id="d11" name="d1"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>서명된 동의서 혹은 개인정보활용동의서 보관  Documentation and retention of all signed informed consent</td>
								<td><input type="radio" id="d21" name="d2"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2"><label for="d23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>5. 증례기록서 및 데이터의 수집 Case Report Form and Data Collection</h6>
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
								<td>증례기록서 작성을 위한 세부지침 CRF completion guidelines</td>
								<td><input type="radio" id="e11" name="e1"><label for="e11" class="raLab"></label></td>
								<td><input type="radio" id="e12" name="e1"><label for="e12" class="raLab"></label></td>
								<td><input type="radio" id="e13" name="e1"><label for="e13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>수정에 관한 절차 Procedures for corrections</td>
								<td><input type="radio" id="e21" name="e2"><label for="e21" class="raLab"></label></td>
								<td><input type="radio" id="e22" name="e2"><label for="e22" class="raLab"></label></td>
								<td><input type="radio" id="e23" name="e2"><label for="e23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>증례기록서/데이터의 서명에 관한 사항 CRF/Data signature requirements</td>
								<td><input type="radio" id="e31" name="e3"><label for="e31" class="raLab"></label></td>
								<td><input type="radio" id="e32" name="e3"><label for="e32" class="raLab"></label></td>
								<td><input type="radio" id="e33" name="e3"><label for="e33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>증례기록서/데이터의 작성기한 CRF/Data completion timelines</td>
								<td><input type="radio" id="e41" name="e4"><label for="e41" class="raLab"></label></td>
								<td><input type="radio" id="e42" name="e4"><label for="e42" class="raLab"></label></td>
								<td><input type="radio" id="e43" name="e4"><label for="e43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>데이터 쿼리 해결 절차 Process of query resolution</td>
								<td><input type="radio" id="e51" name="e5"><label for="e51" class="raLab"></label></td>
								<td><input type="radio" id="e52" name="e5"><label for="e52" class="raLab"></label></td>
								<td><input type="radio" id="e53" name="e5"><label for="e53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>전자자료 및 기록에 대한 규정의 준수 Regulatory requirements for electronic data and records</td>
								<td><input type="radio" id="e61" name="e6"><label for="e61" class="raLab"></label></td>
								<td><input type="radio" id="e62" name="e6"><label for="e62" class="raLab"></label></td>
								<td><input type="radio" id="e63" name="e6"><label for="e63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>6. 안전성 정보 Safety Information</h6>
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
								<td>유해사례 및 중대한 유해사례의 정의 Definition of AE and SAE</td>
								<td><input type="radio" id="f11" name="f1"><label for="f11" class="raLab"></label></td>
								<td><input type="radio" id="f12" name="f1"><label for="f12" class="raLab"></label></td>
								<td><input type="radio" id="f13" name="f1"><label for="f13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>유해사례 및 중대한 유해사례의 보고에 관한 사항 AE and SAE reporting requirements</td>
								<td><input type="radio" id="f21" name="f2"><label for="f21" class="raLab"></label></td>
								<td><input type="radio" id="f22" name="f2"><label for="f22" class="raLab"></label></td>
								<td><input type="radio" id="f23" name="f2"><label for="f23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>중대한 유해사례 발생 시 연락처 Contact information of sponsor</td>
								<td><input type="radio" id="f31" name="f3"><label for="f31" class="raLab"></label></td>
								<td><input type="radio" id="f32" name="f3"><label for="f32" class="raLab"></label></td>
								<td><input type="radio" id="f33" name="f3"><label for="f33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>유해사례 및 중대한 유해사례의 추적관찰에 관한 사항 AE and SAE follow-up</td>
								<td><input type="radio" id="f41" name="f4"><label for="f41" class="raLab"></label></td>
								<td><input type="radio" id="f42" name="f4"><label for="f42" class="raLab"></label></td>
								<td><input type="radio" id="f43" name="f4"><label for="f43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>7. 의학적 처치 및 검사/실험적 검사 등 Medical/Laboratory/Technical Procedures/Tests</h6>
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
								<td>추가로 실시한 실험실적 검사 및 기타 의학적 검사의 검토에 대한 연구자의 책임 Investigator’s responsibilities for review and follow-up of laboratory reports and other medical data</td>
								<td><input type="radio" id="g11" name="g1"><label for="g11" class="raLab"></label></td>
								<td><input type="radio" id="g12" name="g1"><label for="g12" class="raLab"></label></td>
								<td><input type="radio" id="g13" name="g1"><label for="g13" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>8. 추가적인 연구자의 의무 Additional Investigator Obligations</h6>
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
								<td>임상시험심사의원회와의 의사소통 Communication with IRB</td>
								<td><input type="radio" id="h11" name="h1"><label for="h11" class="raLab"></label></td>
								<td><input type="radio" id="h12" name="h1"><label for="h12" class="raLab"></label></td>
								<td><input type="radio" id="h13" name="h1"><label for="h13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>점검 및 규제기관의 실태조사 Sponsor audits and regulatory authority inspections</td>
								<td><input type="radio" id="h21" name="h2"><label for="h21" class="raLab"></label></td>
								<td><input type="radio" id="h22" name="h2"><label for="h22" class="raLab"></label></td>
								<td><input type="radio" id="h23" name="h2"><label for="h23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>연구결과 출판에 관한 정책 Publication policy</td>
								<td><input type="radio" id="h31" name="h3"><label for="h31" class="raLab"></label></td>
								<td><input type="radio" id="h32" name="h3"><label for="h32" class="raLab"></label></td>
								<td><input type="radio" id="h33" name="h3"><label for="h33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>연구비 결산에 관한 절차 Finalcial disclosure procedures</td>
								<td><input type="radio" id="h41" name="h4"><label for="h41" class="raLab"></label></td>
								<td><input type="radio" id="h42" name="h4"><label for="h42" class="raLab"></label></td>
								<td><input type="radio" id="h43" name="h4"><label for="h43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>9. 필수문서 Required Documents</h6>
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
								<td>연구 관련 문서(근거문서 포함)의 보관 및 유지 Retention and archiving of trial documents (including source data and source documents</td>
								<td><input type="radio" id="i11" name="i1"><label for="i11" class="raLab"></label></td>
								<td><input type="radio" id="i12" name="i1"><label for="i12" class="raLab"></label></td>
								<td><input type="radio" id="i13" name="i1"><label for="i13" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>10. 연구관련 물품의 인수 인계 현황 Receipt of Study Materials</h6>
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
								<td>연구 계획서 Protocol</td>
								<td><input type="radio" id="j11" name="j1"><label for="j11" class="raLab"></label></td>
								<td><input type="radio" id="j12" name="j1"><label for="j12" class="raLab"></label></td>
								<td><input type="radio" id="j13" name="j1"><label for="j13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>증례기록서 Case report forms</td>
								<td><input type="radio" id="j21" name="j2"><label for="j21" class="raLab"></label></td>
								<td><input type="radio" id="j22" name="j2"><label for="j22" class="raLab"></label></td>
								<td><input type="radio" id="j23" name="j2"><label for="j23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>동의서 혹은 개인정보활용동의서 Informed consent forms</td>
								<td><input type="radio" id="j31" name="j3"><label for="j31" class="raLab"></label></td>
								<td><input type="radio" id="j32" name="j3"><label for="j32" class="raLab"></label></td>
								<td><input type="radio" id="j33" name="j3"><label for="j33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>기타 물품 Other supplements</td>
								<td><input type="radio" id="j41" name="j4"><label for="j41" class="raLab"></label></td>
								<td><input type="radio" id="j42" name="j4"><label for="j42" class="raLab"></label></td>
								<td><input type="radio" id="j43" name="j4"><label for="j43" class="raLab"></label></td>
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
                        <h6>11. 결제</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="" value="결제정보">
                        <input type="button" id="" value="결제요청">
                    </article>
					<div style="height:10px;"></div>

					<div id="grid_wrap_03" class="gridHeiSz04 grid_wrap tb01_2"></div>
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