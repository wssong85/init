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
  "제목 Title":"제목입니다."
}, {
  "이름 Name":"홍길동",
  "제목 Title":"제목입니다."
}, {
  "이름 Name":"홍길동",
  "제목 Title":"제목입니다."
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
    width : 200
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
  "역할 Role":"작성자 Prepared by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"검토자 Adjusted by",
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
				<h3>시험전 방문보고</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>시험전 방문보고</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">



					<article>
						<h5>시험전 방문보고서</h5>
					</article>

					<div style="height:10px;"></div>

<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->






					<table class="tb001 tb001_01">
						<colgroup>
							<col width="250px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>시험제목 Title</th>
								<td>
									<input type="text" id="" style="width:100%;" value="시험제목">
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="" style="width:93%;">
									<button type="button" class="oneBtn">
										<img class="oneBtnIco" src="http://52.2.72.226:8080/images/pantheon/common/searchIco.png" alt="검색">
									</button>
								</td>
							</tr>
							<tr>
								<th>시험책임자 Principal Investigator</th>
								<td>
									<input type="text" id="" style="width:100%;" value="홍길동">
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:10px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h7>방문시 접촉한 연구진 Study Personnel Present During Visit</h7>
                    </article>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="" value="추가">
						<input type="button" id="" value="삭제">
					</div>
					<div id="grid_wrap_01" class="gridHeiSz02 grid_wrap tb01_2"></div>	


					<div style="height:20px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h7>방문자 및 방문일 Visit &amp; Visit Date</h7>
                    </article>


					<div style="text-align:right; margin:5px;">
						<input type="button" id="" value="추가">
						<input type="button" id="" value="삭제">
					</div>
					<div id="grid_wrap_02" class="gridHeiSz02 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>



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
								<th colspan="2">A. 시험계획서 관련 사항 Protocol and Pertaining Issues</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>
									시험책임자에게 임상시험(목적, 계획서, 절차 등)에 대한 설명을 하고 논의하였습니까? Were the trial objectives, protocol, and required procedures (if applicable) explained to and discussed with the principal investigator?
									<br>
									시험계획서 버전 Specify the protocol version:
								</td>
								<td><input type="radio" id="a11" name="a1"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>시험자에게 임상시험용의약품에 대한 정보가 제공되었습니까?<br>Were the descriptions of investigational products explained?</td>
								<td><input type="radio" id="a21" name="a2"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>피험자 동의 과정에 대해 검토하였습니까?<br>Was the informed consent procedure reviewed?</td>
								<td><input type="radio" id="a31" name="a3"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>
									시험책임자는 시험기간 내에 적절한 수의 피험자를 모집할 수 있습니까? 
									Does the principal investigator have access to adequate number of subjects within the timeline?
									<br>
									본 기관의 모집예상 피험자 수 Total number of eligible subjects at the site <input type="text" id="" style="width:100px;"> 명
									
									<div style=" margin:6px 0;">주 단위 또는 월 단위로 기대되는 피험자 수 Recruitment expected per weekly/monthly <input type="text" id="" style="width:100px;"> 명</div>
								</td>
								<td><input type="radio" id="a41" name="a4"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>피험자 등록에 영향을 줄 수 있는 타 임상시험이 있습니까? 있다면 기술하시오.<br>Any studies or trials that may impact accrual. If yes, please describe :</td>
								<td><input type="radio" id="a51" name="a5"><label for="a51" class="raLab"></label></td>
								<td><input type="radio" id="a52" name="a5"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>예산에 대해 시험책임자와 논의하고 동의하였습니까?<br>Was the trial budget discussed and agreed by the PI?</td>
								<td><input type="radio" id="a61" name="a6"><label for="a61" class="raLab"></label></td>
								<td><input type="radio" id="a62" name="a6"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6"><label for="a63" class="raLab"></label></td>
							</tr>
							<tr>
								<td>7</td>
								<td>시험자의 책임(중대한 이상반응 보고, 임상시험심사위원회의 승인, 임상시험관리기준 요구사항, 모니터링 조정/점검/ 실태조사에 대한 협조)에 대해 논의하였습니까?<br>Were responsibilities of investigators reviewed including reporting SAEs, obtaining the approval from the IRB/IEC for the protocol, other GCP requirements and coordinating monitoring, audits, and inspections?</td>
								<td><input type="radio" id="a71" name="a7"><label for="a71" class="raLab"></label></td>
								<td><input type="radio" id="a72" name="a7"><label for="a72" class="raLab"></label></td>
								<td><input type="radio" id="a73" name="a7"><label for="a73" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="2">B. 시험자의 적합성 Investigator Qualification</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>
									시험자와 연구진은 임상시험을 진행하기에 적절한 자격(임상시험 참여 경험, GCP 관련 교육 이수 등)을 갖추고 있습니까?
									<br>
									Are investigators and other staffs are qualified to conduct this trial (GCP training and previous clinical trial experience)?
									<br>
									이력서에 임상시험 경험과 GCP교육이력에 대한 정보가 있어야 함.
									<br>
									Ensure that the information on GCP training and previous clinical trial experiences is indicated in CVs.
								</td>
								<td><input type="radio" id="b11" name="b1"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>
									시험책임자는 임상시험을 시행하기 위한 충분한 시간이 있습니까?
									<br>
									Do the principal investigator has adequate time to conduct this trial?
								</td>
								<td><input type="radio" id="b21" name="b2"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="2">C. 시설과 실험실 Facilities and Laboratory</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>
									임상시험을 실시하고자 하는 기관의 시설, 장비, 실험실이 적절하게 갖추어져 있습니까? Are site facilities, equipment, and laboratory adequate for this trial?
									임상시험 개시 시까지는 실험실에 대한 인증서가 확보되어야 함.
									<br>
									Laboratory certification/accreditation should be obtained by site initiation
								</td>
								<td><input type="radio" id="c11" name="c1"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>
									임상시험기간 또는 요구되는 기간 동안 증례기록서와 다른 중요문서를 보관할 안전한 장소가 있습니까? Does the investigator have the adequate, secured space for CRFs and any other essential documents during the trial and for the period requested by the regulatory requirements?
									<br>
									보관 장소 Specify the retention space:
								</td>
								<td><input type="radio" id="c21" name="c2"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2"><label for="c23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>
									요구되는 기간 동안 임상시험용의약품 또는 생체시료들을 보관할 안전한 장소가 있습니까? Does the site have adequate, secure storage facilities for investigational products or body fluids/tissue samples for the required period?
									<br>
									보관장소나 시설, 온도점검(필요하다면) 과정에 대한 설명 Specify storage areas/facilities and/or the type of temperature monitoring process (if required) : 
								</td>
								<td><input type="radio" id="c31" name="c3"><label for="c31" class="raLab"></label></td>
								<td><input type="radio" id="c32" name="c3"><label for="c32" class="raLab"></label></td>
								<td><input type="radio" id="c33" name="c3"><label for="c33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4</td>
								<td>
									모니터링을 할 장소가 있습니까? Is there any adequate space for the monitoring?
									<br>
									모니터링 장소 Specify monitoring space:
								</td>
								<td><input type="radio" id="c41" name="c4"><label for="c41" class="raLab"></label></td>
								<td><input type="radio" id="c42" name="c4"><label for="c42" class="raLab"></label></td>
								<td><input type="radio" id="c43" name="c4"><label for="c43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5</td>
								<td>
									모니터링 하는 장소에서 모니터링, 점검, 실태조사자들이 근거자료나 문서에 바로 접근이 가능합니까?
									<br>
									Dies the site agree to direct access to source data/document by the monitors, auditors, and inspectors?
								</td>
								<td><input type="radio" id="c51" name="c5"><label for="c51" class="raLab"></label></td>
								<td><input type="radio" id="c52" name="c5"><label for="c52" class="raLab"></label></td>
								<td><input type="radio" id="c53" name="c5"><label for="c53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>
									(임상시험용의약품이나 생체시료들을 냉장 또는 냉동보관 할 경우) 정전 시 비상설비가 있습니까?
									<br>
									Is there any emergency equipment for electricity outage (only in case that investigational products or body fluids/tissue samples were required to be refrigerated or frozen)?
								</td>
								<td><input type="radio" id="c61" name="c6"><label for="c61" class="raLab"></label></td>
								<td><input type="radio" id="c62" name="c6"><label for="c62" class="raLab"></label></td>
								<td><input type="radio" id="c63" name="c6"><label for="c63" class="raLab"></label></td>
							</tr>
							
							<tr>
								<th colspan="2">D. 임상시험심사위원회 절차  IRB/IEC Procedures</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>
									임상시험심사위원회의 승인과 통지 절차를 확인하였습니까? Were notification and approval procedures of the IRB/IEC verified?
									<br>
									심사회의 횟수 Specify the regular and expedited meeting frequencies :                                                        
									<br>
									각 기관의 특별한 요구조건 Specify any site specific requirements :
								</td>
								<td><input type="radio" id="d11" name="d1"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>
									타기관 발생 중대한 이상반응을 포함한 모든 중대한 이상반응은 보고되어야 합니까? Do all SAEs including SAEs occurred in other sites should be reported to the IRB/IEC?
									<br>
									보고범위와 보고기간 Specify the extent of reporting and timeline :
								</td>
								<td><input type="radio" id="d21" name="d2"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2"><label for="d23" class="raLab"></label></td>
							</tr>
							
							<tr>
								<th colspan="2">E. 임상시험용의약품과 그 외 공급물품 Investigator Product and Other Supplies</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1</td>
								<td>
									임상시험용의약품의 입출고, 폐기 과정을 확인하였습니까? Were receipt, return, and destruction procedures of investigational products reviewed?
									<br>
									입출고, 폐기 횟수/간격과 방법 Specify supply/return/destruction frequencies/intervals and method :
								</td>
								<td><input type="radio" id="e11" name="e1"><label for="e11" class="raLab"></label></td>
								<td><input type="radio" id="e12" name="e1"><label for="e12" class="raLab"></label></td>
								<td><input type="radio" id="e13" name="e1"><label for="e13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2</td>
								<td>
									임상시험용의약품의 수불과정을 논의하였습니까? Were the investigational product accountability and dispensing procedures discussed?
									<br>
									과정을 서술하시오. Describe the procedures:
								</td>
								<td><input type="radio" id="e21" name="e2"><label for="e21" class="raLab"></label></td>
								<td><input type="radio" id="e22" name="e2"><label for="e22" class="raLab"></label></td>
								<td><input type="radio" id="e23" name="e2"><label for="e23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>
									이 임상시험을 수행하기 위해 본 기관에 제공해야할 물품이 있습니까? Are there any site specific supplied provided to conduct this trial?
									<br>
									목록 Specify:
								</td>
								<td><input type="radio" id="e31" name="e3"><label for="e31" class="raLab"></label></td>
								<td><input type="radio" id="e32" name="e3"><label for="e32" class="raLab"></label></td>
								<td><input type="radio" id="e33" name="e3"><label for="e33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					

					<div style="height:30px;"></div>


                    <article class="conTitBox">
                        <h7>후속조치가 필요합니까? Were any Issue that require follow-up?</h7>
                    </article>
					
					
					
					<div style="height:5px;"></div>
					
					<input type="radio" id="f11" name="f1"><label for="f11" class="raLab"><span>Yes</span></label>
					<br>
					<input type="radio" id="f12" name="f1"><label for="f12" class="raLab"><span>No 만약 있다면, 의견 란에 작성하시오. If yes, complete the comment.</span></label>


					<div style="height:10px;"></div>


					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>의견 Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>
					
					





                    <article class="conTitBox">
                        <h7>결제</h7>
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