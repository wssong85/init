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
				<h3>모니터링</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>모니터링</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">





					<div id="tab" class="tab tab01">
						<ul>
							<li id="" class="tab_menu">모니터링 계획</li>
							<li id="" class="port_back tab_menu">모니터링 보고서</li>
						</ul>
					</div>



<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->


					<table class="tb001">
						<colgroup>
							<col width="250px" />
							<col width="" />
							<col width="160px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>연구제목 Title</th>
								<td colspan="3">
									<input type="text" id="" style="width:100%;" value="">
								</td>
							</tr>
							<tr>
								<th>연구기관 Clinical Trial Site</th>
								<td colspan="3">
									<input type="text" id="" style="width:100%;" value="">
								</td>
							</tr>
							<tr>
								<th>책임연구자 Principal Investigator</th>
								<td>
									<input type="text" id="" style="width:100%;" value="">
								</td>
								<th>방문차수 No. of Visit</th>
								<td>
									<input type="text" id="" style="width:100px;"> 차 방문
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
                        <h6>조사대상자 정보 Subject Information</h6>
                    </article>
					
					<div style="height:5px;"></div>
					
					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="16%" />
							<col width="16%" />
							<col width="16%" />
							<col width="16%" />
							<col width="16%" />
						</colgroup>
						<tbody>
							<tr>
								<td colspan="6">#목표 조사대상자수 Total Subjects Planned <input type="text" id="" style="width:100px;"> 명</td>
							</tr>
							<tr>
								<th></th>
								<th style="text-align:center; padding-left:5px;">등록 Enrollment</th>
								<th style="text-align:center; padding-left:5px;">완료 Completion</th>
								<th style="text-align:center; padding-left:5px;">탈락 Drop-out</th>
								<th style="text-align:center; padding-left:5px;">진행 중 On-going</th>
								<th style="text-align:center; padding-left:5px;">비고 Remark</th>
							</tr>
							<tr>
								<td style=" background:#f6f7ff;">지난 방문</td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td style="padding:0; height:auto; font:0/0 arial;"><img src="/images/pantheon/common/x_img.png" alt="" style="width:100%; height:100%;"></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
							</tr>
							<tr>
								<td style=" background:#f6f7ff;">이번 방문</td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
							</tr>
							<tr>
								<td style=" background:#f6f7ff;">Total</td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<td><input type="text" id="" style="width:100%;" value=""></td>
							</tr>
							<tr>
								<td colspan="2">#예상치 못한 유해사례 건수*: Unexpected AEs</td>
								<td colspan="4"><input type="text" id="" style="width:100px;"> 건</td>
							</tr>
						</tbody>
					</table>


					<div style="height:2px;"></div>



					<div style="padding:0 0 0 0px;">
						ㆍ이번 방문 시 발견된 건수를 기록합니다.
					</div>

					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>1. 근거문서 대조 및 증례기록서 검토 Source Document Verification and Case Report Form Review</h6>
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
								<td>동의서가 적절하게 작성되었습니까? Were all subjects consented correctly?</td>
								<td><input type="radio" id="a11" name="a1"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td colspan="4">이번에 검토한 CRF Reviewed CRF on this visit : <input type="text" id="" style="width:62%;"></td>
							</tr>
							<tr>
								<td>3</td>
								<td colspan="4">
									<div style="display:inline-block; position:relative; top:-3px;"> 
										이번에 기록 완료된 CRF completed CRF on this visit :
									</div>
									<input type="radio" id="a21" name="a2"><label for="a21" class="raLab"><span>없음</span></label>
									<input type="radio" id="a22" name="a2"><label for="a22" class="raLab"><span>있음</span></label>
								</td>
							</tr>
							<tr>
								<td>4</td>
								<td>CRF는 근거문서에 따라 정확히, 빠짐없이, 제때에 작성되고 있습니까? Are CRFs completed accurate, exhaustive, timely in accordance with the source date/documentation?</td>
								<td><input type="radio" id="a31" name="a3"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>Paper CRF의 경우, CRF 수정시 적절한 수정방법을 사용하였습니까? Were CRF corrected rightly?</td>
								<td><input type="radio" id="a41" name="a4"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>이전 모니터링 시 지적한 문제가 해결되었습니까? Were outstanding data clarification forms/queries resolved?</td>
								<td><input type="radio" id="a51" name="a5"><label for="a51" class="raLab"></label></td>
								<td><input type="radio" id="a52" name="a5"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>7</td>
								<td>지난 방문 이후 연구계획서 위반사항(병력, 병용약물 등)이 있습니까? Have there been any protocol deviations since last visit?</td>
								<td><input type="radio" id="a61" name="a6"><label for="a61" class="raLab"></label></td>
								<td><input type="radio" id="a62" name="a6"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6"><label for="a63" class="raLab"></label></td>
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
                        <h6>2. 연구계획서 및 관련 규정의 준수 Compliance with Protocol & GCP and Applicable Regulatory Requirements</h6>
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
								<td>연구자가 연구계획서 및 관련 규정을 잘 준수하고 있습니까? Are site personnel aware of, and comply with, protocol, GCP and the applicable regulatory requirements?</td>
								<td><input type="radio" id="b11" name="b1"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>연구계획서 변경이 필요합니까? Is amendment of the protocol necessary? </td>
								<td><input type="radio" id="b21" name="b2"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>변경된 연구계획서의 내용은 IRB승인 후에 적용되고 있습니까? Were the changes implemented after approval of the regulatory authorities and/or the IRB/IBC?</td>
								<td><input type="radio" id="b31" name="b3"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>중간보고 및 지속심의 절차가 필요한지 확인하였습니까? Did you check whether the interim report and/or re-approval procedure is necessary or not?</td>
								<td><input type="radio" id="b41" name="b4"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>연구 계획서 위반사항이 있다면 위반 사항이 보고되었습니까? If any violation of protocol are reported violation?</td>
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
                        <h6>3. 유해사례 Adverse Events</h6>
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
								<td>지난 방문 이후 발생한 유해사례 및/또는 중대한 유해사례가 있습니까? Have new AEs and/or SAEs since the last visit been reported?</td>
								<td><input type="radio" id="c11" name="c1"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>지난 방문 시 검토한 유해사례 및/또는 중대한 유해사례에 대한 새로운 정보가 있습니까? Has new information on previous AEs and/or SAEs been properly reviewed, reported, and documented?</td>
								<td><input type="radio" id="c21" name="c2"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2"><label for="c23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>지난 방문 이후 시험자가 알게 된 모든 중대한 유해사례는 관련규정, 계획서, SOP에 따라 모니터 및 IRB(경우에 따라 한국의약품안전관리원 까지)에 적절하게 보고되었습니까? Have all SAEs been reported to monitor &amp; IRB and/or regulatory authorities in compliance with the protocol and SOP?</td>
								<td><input type="radio" id="c31" name="c3"><label for="c31" class="raLab"></label></td>
								<td><input type="radio" id="c32" name="c3"><label for="c32" class="raLab"></label></td>
								<td><input type="radio" id="c33" name="c3"><label for="c33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>유해사례로 인한 중단의 경우 유해사례 내용이 빠진 내용 없이 잘 기재 되어 있습니까? Discontinued due to adverse events for the better without the adverse information is disclosed are you missing information?</td>
								<td><input type="radio" id="c41" name="c4"><label for="c41" class="raLab"></label></td>
								<td><input type="radio" id="c42" name="c4"><label for="c42" class="raLab"></label></td>
								<td><input type="radio" id="c43" name="c4"><label for="c43" class="raLab"></label></td>
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
                        <h6>4. 연구자 기본문서 파일 Investigator Study File</h6>
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
								<td>
									기본문서를 적절히 보관하고 있습니까? Are investigator site files appropriately maintained?
									<ul>
										<li>- 연구계획서, 증례기록서, 동의서, IRB 심의통보서 , AE 관련 문서 , 계약서</li>
										<li>- protocol, CRFs, ICFs, Contract, IRB Notification, AE -related documents, contracts</li>
									</ul>
								</td>
								<td><input type="radio" id="d11" name="d1"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>기본문서파일은 최신의 내용을 반영하고 있습니까? Is the investigator site file updated?</td>
								<td><input type="radio" id="d21" name="d2"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2"><label for="d23" class="raLab"></label></td>
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
                        <h6>5. 모니터링 결과, 문제점, 조치/해결 내용 기술 Explain Monitoring Result, Issue, Management/Solution</h6>
                    </article>
					<div style="height:5px;"></div>



					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					
					<div style="height:20px;"></div>
					
					
					<div id="grid_wrap_03" class="gridHeiSz03 grid_wrap tb01_2"></div>
					
					

					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>6. 권고사항 Recommendations</h6>
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
                        <h6>7. 결제</h6>
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