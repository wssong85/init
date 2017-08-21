<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<style>
.row_height_01 th{ height:auto; padding:2px 5px 2px 12px;}
</style>

<script>

var testData_01 =[
{
  "역할 Role":"작성자 Prepared by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"검토자 Reviewed by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"결재자 Approved by",
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
  mkSetDatePickerYYMMDD("#day_01");
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
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>

						
	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>연구자 적합성</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>연구자 적합성</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">



					<article>
						<h5>연구자 적합성 보고서</h5>
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
							<col width="160px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>연구제목 Title</th>
								<td colspan="3">
									<input type="text" id="" style="width:100%;" value="[CJ_EXO_P01]">
								</td>
							</tr>
							<tr>
								<th>연구기관 Site Name</th>
								<td>
									<input type="text" id="" style="width:100%;" value="강남고려병원">
								</td>
								<th>실시일 Date of Contact</th>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>연구책임자 후보 Potential PI</th>
								<td>
									<input type="text" id="" style="width:100%;" value="박 현 주">
								</td>
								<th>실시자 CRA</th>
								<td>
									<input type="text" id="" style="width:100%;" value="장 민 영">
								</td>
							</tr>
							<tr>
								<th>평가방법 Method of Evaluation</th>
								<td colspan="3">
									<div><input type="radio" id="a11" name="a1"><label for="a11" class="raLab"><span>전화방문 Telephone Contact</span></label></div>
									<div><input type="radio" id="a12" name="a1"><label for="a12" class="raLab"><span>기관방문 Site Visit</span></label></div>
									<div><input type="radio" id="a13" name="a1"><label for="a13" class="raLab"><span>기타 Others</span></label> <span style="text-decoration:underline; position:relative; top:-3px; margin-left:20px;">내부 데이터 점검을 통한 평가</span></div>
									
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>




					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody>
							<tr>
								<th>A. 기관에 제공된 정보 확인 Confirm information provided to the site</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr>
								<td>1. 연구자가 연구계획서를 검토함 Protocol has been reviewed by the investigator</td>
								<td><input type="radio" id="b11" name="b1"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2. 연구자가 본 연구의 목적을 이해함 Relevant scientific background is understood by investigator</td>
								<td><input type="radio" id="b21" name="b2"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3. 연구 시작, 연구대상자 모집 및 완료에 대한 연구 일정을 인지하고 있음 Study timeline, including initiation, subject accrual rate and completion</td>
								<td><input type="radio" id="b31" name="b3"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="4">B. 연구자 Investigator</th>
							</tr>
							<tr>
								<td>1. 연구자는 연구에 할애할 충분한 시간이 있음 The investigator has sufficient time, training to conduct the study</td>
								<td><input type="radio" id="b41" name="b4"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2. 연구자는 최신 이력서 및 GCP 이수증을 보유하고 있음 The investigator has recent curriculum vitae, GCP training certificate to conduct the study</td>
								<td><input type="radio" id="b51" name="b5"><label for="b51" class="raLab"></label></td>
								<td><input type="radio" id="b52" name="b5"><label for="b52" class="raLab"></label></td>
								<td><input type="radio" id="b53" name="b5"><label for="b53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3. 연구자는 훈련되어 있는 공동연구자 및 인력을 적절히 확보하고 있음 The investigator has adequate, trained subinvestigator and other human resources</td>
								<td><input type="radio" id="b61" name="b6"><label for="b61" class="raLab"></label></td>
								<td><input type="radio" id="b62" name="b6"><label for="b62" class="raLab"></label></td>
								<td><input type="radio" id="b63" name="b6"><label for="b63" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4. 연구자의 연락처가 확보되어 있음 Investigator contact has been identified.</td>
								<td><input type="radio" id="b71" name="b7"><label for="b71" class="raLab"></label></td>
								<td><input type="radio" id="b72" name="b7"><label for="b72" class="raLab"></label></td>
								<td><input type="radio" id="b73" name="b7"><label for="b73" class="raLab"></label></td>
							</tr>
							<tr>
								<td>5. 공동연구자와 연구간호사는 인증된 자격이 있음 Subinvestigator includes (a) certified clinical coordinator(s)</td>
								<td><input type="radio" id="b81" name="b8"><label for="b81" class="raLab"></label></td>
								<td><input type="radio" id="b82" name="b8"><label for="b82" class="raLab"></label></td>
								<td><input type="radio" id="b83" name="b8"><label for="b83" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="4">C. 연구대상자 Subjects</th>
							</tr>
							<tr>
								<td>1. 선정제외기준에 적합한 연구대상자 등록이 가능함 Sufficient eligible subjects (patients, samples) are available</td>
								<td><input type="radio" id="b91" name="b9"><label for="b91" class="raLab"></label></td>
								<td><input type="radio" id="b92" name="b9"><label for="b92" class="raLab"></label></td>
								<td><input type="radio" id="b93" name="b9"><label for="b93" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="4">D. 연구비 Budget</th>
							</tr>
							<tr>
								<td>1. 연구 예산에 대해 논의 및 합의함 Study budget discussed and finalized</td>
								<td><input type="radio" id="b101" name="b10"><label for="b101" class="raLab"></label></td>
								<td><input type="radio" id="b102" name="b10"><label for="b102" class="raLab"></label></td>
								<td><input type="radio" id="b103" name="b10"><label for="b103" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="15%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>의견 Comment</th>
								<td style="padding:10px 20px;">
									<div>B-2. 연구자의 이력서와 GCP는 보유하고 있지 않음</div>
									<div>B-3. 연구자 혼자 연구를 진행할 예정으로 해당사항 없음</div>
									<div>B-5. 공동연구자와 연구간호사가 없으므로 해당사항 없음</div>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>





					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="220px" />
						</colgroup>
						<tbody>
							<tr>
								<th colspan="5">평가 Evaluation</th>
							</tr>
							<tr>
								<td colspan="2">평가요인 Evaluation Factor</td>
								<td colspan="2" style="text-align: center; border-right:none;">범례 : </td>
								<td style="border-left:none;">
									Excellent :  3 점
									<br>
									Normal : 2 점
									<br>
									Poor : 0 ~ 1점
		  						</td>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 역량  Investigator capabilities</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">○</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">×</th>
								<th rowspan="2">비고 Comment</th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;">3</th>
							</tr>
							<tr>
								<td>1</td>
								<td>연구 참여 경험이 많고, GCP 이수 등 연구자로서의 소양을 갖춤</td>
								<td><input type="checkbox" name="" id="ca1" checked><label for="ca1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="ca2"><label for="ca2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>안전성 정보 수집의 당위성과 필요성을 이해하고 관심갖으며, AE와 SAE의 개념을 이해함</td>
								<td><input type="checkbox" name="" id="cb1" checked><label for="cb1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cb2"><label for="cb2" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>컴퓨터 사용에 능숙하여 eCRF 작성이 가능함</td>
								<td><input type="checkbox" name="" id="cc1" checked><label for="cc1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cc2"><label for="cc2" class="chcLab"></label></td>
							</tr>

							
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">공동연구자 및 인력의 적합성 Suitability of subinvestigator and other human resources</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">○</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">×</th>
								<th rowspan="2">해당사항 없음</th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;">2</th>
							</tr>
							<tr>
								<td>1</td>
								<td>공동연구자 및 연구담당자의 연구 참여 경험이 많고, GCP 이수 등 연구자로서의 소양을 갖춤</td>
								<td><input type="checkbox" name="" id="cd1" checked><label for="cd1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cd2"><label for="cd2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>안전성 정보 수집의 당위성과 필요성을 이해하고 관심갖으며, AE와 SAE의 개념을 이해함</td>
								<td><input type="checkbox" name="" id="ce1"><label for="ce1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="ce2"><label for="ce2" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>컴퓨터 사용에 능숙하여 eCRF 작성이 가능함</td>
								<td><input type="checkbox" name="" id="cf1" checked><label for="cf1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cf2"><label for="cf2" class="chcLab"></label></td>
							</tr>
							

							
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구대상자 모집 유용성 Subject accrual availability</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">○</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">×</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;">1</th>
							</tr>
							<tr>
								<td>1</td>
								<td>충분한 조사대상자 확보가 가능함</td>
								<td><input type="checkbox" name="" id="cg1" checked><label for="cg1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cg2"><label for="cg2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>해당 연구에 적합한 진료과에서 연구를 진행함</td>
								<td><input type="checkbox" name="" id="ch1"><label for="ch1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="ch2"><label for="ch2" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>유사성분의 연구를 중복해서 진행한 경험이 없음</td>
								<td><input type="checkbox" name="" id="ci1"><label for="ci1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="ci2"><label for="ci2" class="chcLab"></label></td>
							</tr>
							
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 할애 가능한 시간 Investigator’s available time</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">○</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">×</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;">0</th>
							</tr>
							<tr>
								<td>1</td>
								<td>하루에 30분 이상 연구에 시간 할애가 가능함</td>
								<td><input type="checkbox" name="" id="cj1"><label for="cj1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cj2"><label for="cj2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>다른 연구를 5개 이상 진행하고 있지 않음</td>
								<td><input type="checkbox" name="" id="ck1"><label for="ck1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="ck2"><label for="ck2" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>전체 연구기간 동안 중단 없이 참여 가능함</td>
								<td><input type="checkbox" name="" id="cl1"><label for="cl1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cl2"><label for="cl2" class="chcLab"></label></td>
							</tr>



							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 관심도와 충실성 Investigator’s interest and commitment</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">○</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">×</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;">0</th>
							</tr>
							<tr>
								<td>1</td>
								<td>연구 참여에 적극적인 의사를 표함</td>
								<td><input type="checkbox" name="" id="cm1"><label for="cm1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cm2"><label for="cm2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>연구디자인, 선정/제외기준 등 관련사항 및 연구진행 프로세스에 대해 정확히 인지함</td>
								<td><input type="checkbox" name="" id="cn1"><label for="cn1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cn2"><label for="cn2" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>CRF를 작성 및 쿼리해결의 퀄리티가 높으며, 쿼리 발행사항을 신속히 해결함</td>
								<td><input type="checkbox" name="" id="co1"><label for="co1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="co2"><label for="co2" class="chcLab"></label></td>
							</tr>
							
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">문서보존 능력 Recordkeeping capability</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">○</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">×</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;">0</th>
							</tr>
							<tr>
								<td>1</td>
								<td>연구 관련 문서를 보관할 수 있는 적합한 공간을 확보함</td>
								<td><input type="checkbox" name="" id="cp1"><label for="cp1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cp2"><label for="cp2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td>연구 종료 후 3년간 근거문서를 보관해야 함을 인지함</td>
								<td><input type="checkbox" name="" id="cq1"><label for="cq1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cq2"><label for="cq2" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>3</td>
								<td>계약서, ISF 등의 관련문서를 적절히 보관함</td>
								<td><input type="checkbox" name="" id="cr1"><label for="cr1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cr2"><label for="cr2" class="chcLab"></label></td>
							</tr>
						</tbody>
					</table>





					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
							<col width="180px" />
						</colgroup>
						<tbody>
							<tr class="row_height_01">
								<th rowspan="2" colspan="2">기타 Other</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">○</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">×</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">NA</th>
								<th rowspan="2">해당사항 없음</th>
							</tr>
							<tr class="row_height_01">
								<th colspan="3" style="text-align:center; font-weight:bold; padding-left:5px;">0</th>
							</tr>
							<tr>
								<td>1</td>
								<td style="padding-right:12px;"><input type="text" id="" style="width:100%;"></td>
								<td><input type="checkbox" name="" id="cs1"><label for="cs1" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cs2"><label for="cs2" class="chcLab"></label></td>
								<td><input type="checkbox" name="" id="cs3"><label for="cs3" class="chcLab"></label></td>
								<td></td>
							</tr>
							<tr>
								<th colspan="6">추천 Recommendation</th>
							</tr>
							<tr>
								<td colspan="2">
									본 연구자는 시험을 진행하기 위한 CJ의 기준에 부합함 This investigator meets <CJ>'s criteria to conduct the study
								</td>
								<td colspan="4">
									<input type="radio" id="c11" name="c1"><label for="c11" class="raLab"><span>예 Yes</span></label>
									<input type="radio" id="c12" name="c1"><label for="c12" class="raLab"><span>아니오 No</span></label>
								</td>
							</tr>
						</tbody>
					</table>




					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>결제</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="" value="결제정보">
                        <input type="button" id="" value="결제요청">
                    </article>
					
					
					<div style="height:10px;"></div>
					
					
					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>



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