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
							<li id="" class="port_back tab_menu">모니터링 방문 계획</li>
							<li id="" class="tab_menu">모니터링 방문 보고서</li>
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
								<th>임상시험 제목 Title</th>
								<td>
									<input type="text" id="" style="width:100%;">
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
								<th>시험연구자 Principal Investigator</th>
								<td>
									<input type="text" id="" style="width:100%;">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 목적 purpose</h6>
                    </article>
                    

                    

					<div style="height:2px;"></div>



					<div style="padding:0 0 0 18px;">
						본 모니터링 계획은 <input type="text" id="" style="width:200px;" value="[CJ_OOO_P0O]"> 임상시험 모니터링 업무를 수행하는 데 필요한 지침을 제공하기 위해 마련되었다.
					</div>



					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>2. 예상시험기간 Expected Trial Period</h6>
                    </article>

					<div style="height:2px;"></div>



					<div style="padding:0 0 0 18px;">
						임상시험의 예상기간은 
						<input type="text" id="" style="width:60px;" value="2015"> 년 
						<input type="text" id="" style="width:40px;" value="12"> 월 
						~ 
						<input type="text" id="" style="width:60px;" value="2015"> 년  
						<input type="text" id="" style="width:40px;" value="12"> 월 
						
						(마지막 피험자 마지막 방문)까지 이며, 임상시험의 milestone은 다음과 같다.
					</div>





					<div style="height:10px;"></div>



					<table class="tb001 tb001_01">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>첫 피험자 등록</th>
								<td>
									<input type="text" id="" style="width:60px;" value="2015"> 년  
									<input type="text" id="" style="width:40px;" value="12"> 월 
								</td>
							</tr>
							<tr>
								<th>첫 피험자 스크리닝</th>
								<td>
									<input type="text" id="" style="width:60px;" value="2015"> 년  
									<input type="text" id="" style="width:40px;" value="12"> 월 
								</td>
							</tr>
							<tr>
								<th>마지막 피험자 등록</th>
								<td>
									<input type="text" id="" style="width:60px;" value="2015"> 년  
									<input type="text" id="" style="width:40px;" value="12"> 월 
								</td>
							</tr>
							<tr>
								<th>마지막 피험자 마지막 방문<br>(안전성 추적검사 제외)</th>
								<td>
									<input type="text" id="" style="width:60px;" value="2015"> 년  
									<input type="text" id="" style="width:40px;" value="12"> 월 
								</td>
							</tr>
							<tr>
								<th>CRF 수거 완료</th>
								<td>
									<input type="text" id="" style="width:60px;" value="2015"> 년  
									<input type="text" id="" style="width:40px;" value="12"> 월 
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>3. 개시방문 Initiation Visit</h6>
                    </article>

					<div style="height:2px;"></div>


					<div style="padding:0 0 0 18px;">
						임상시험 참여가 확정된 기관이 임상시험을 시작할 수 있도록, 임상시험 CRA는 시험자를 대상으로 임상시험계획 및 관련 절차에 대해 교육하고, 임상시험 시작에 필요한 문서 및 물품을 공급하기 위해 개시모임을 실시한다.
						<br><br>
						개시모임은 시험기관 방문 또는 Investigator Meeting의 형태로 실시 가능하다. 임상시험계획서에 대한 KFDA와 시험기관 IRB의 최초 승인 이후 해당 시험기관의 개시모임을 실시한다. 임상시험용의약품 공급은 원칙적으로 개시모임 후 시험기관이 임상시험 시작에 적합함이 확인된 후 입고하는 것을 원칙으로 하나, 개시모임 이전이라도 시험기관이 임상시험 시작에 문제가 없는 것으로 판단되는 경우에는 개시모임일 또는 그 이전에 해당 시험기관에 임상시험용의약품을 입고할 수 있다.
						<br><br>
						개시모임에서 사용해야 하는 교육자료는 다음과 같다.
						<ul>
							<li>- Presentation file for Protocol</li>
							<li>- SAE Report Procedure</li>
							<li>- CRF Completion Guideline</li>
							<li>- Presentation file for GCP (GCP 교육을 받은 적인 없는 연구자에 한함)</li>
						</ul>
					</div>



					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>4. 정기 모니터링 방문 Routine Monitoring Visit</h6>
                    </article>

					<div style="height:2px;"></div>


					<div style="padding:0 0 0 18px;">
						CRA는 정기 모니터링 방문 시  [시험기관방문기록 (Site Visit Log, SIVL)]을 업데이트 한다. 
						정기 모니터링 방문 이외에 최소 매달 O회 이상 시험기관에 전화 또는 메일을 통해 연락을 취하여 임상시험 진행 현황을 파악한다. 
						CRM 및 CRA는 주기적으로 임상시험 진행 현황을 취합하여 News Letter로 시험책임자, 시험담당자 및 본 시험에 참여하는 모든 자에게 보고한다.
					</div>


					<div style="height:10px;"></div>



					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>첫번째 정기 모니터링 방문</th>
								<td>
									첫번째 피험자 스크리닝일로부터 <input type="text" id="" style="width:40px;" value="35"> 주 이내 
								</td>
							</tr>
							<tr>
								<th>이후 정기 모니터링 방문</th>
								<td>
									최소 <input type="text" id="" style="width:40px;" value="12"> 달에 <input type="text" id="" style="width:60px;" value="315"> 회 이상
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>



					<div style="padding:0 0 0 18px;">
						단, 시험기관의 피험자 등록 속도가 <input type="text" id="" style="width:60px;" value="12337"> 명/1달 미만인 경우에는 임상담당부서장의 사전승인 하에 해당 기관의 정기 모니터링 방문의 간격을 조정할 수 있다.
						<br><br>
						정기 모니터링 방문에서 CRA은 다음을 실시한다.
						<ul>
							<li>- 시험자의 변경 유무 및 시험기관 시설 및 장비의 적절성 확인</li>
							<li>- 시험자 기본 문서 (Investigator study files)</li>
							<li>- 피험자 스크리닝, 등록 및 탈락 현황</li>
							<li>- 임상시험 계획서 및 관련 규정 위반 시, 적절한 조치 여부(재발방지, 이전 모니터링 결과에 대한 조치 여부) 및 기록 및 보고 확인
								<br><span style="padding-left:12px;">(재발방지, 이전 모니터링 결과에 대한 조치 여부)</span></li>
							<li>- 근거자료/문서 확인 (Source Data/Document Verification, 이하 SDV)</li>
						</ul>
						<br>
						다음 항목에 대해 SDV를 실시한다.
						<ul>
							<li>- 서면 동의서</li>
							<li>- 선정/제외기준</li>
							<li>-  Randomization 결과 (해당할 경우)</li>
							<li>- 유효성 및 안전성 평가 지표</li>
							<li>- 중대한 이상반응 보고서 (해당할 경우)</li>
							<li>- 병용약물</li>
							<li>- 기본문서 확인</li>
							<li>- 피험자 일지 이상반응 보고서 확인</li>
						</ul>
					</div>


					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>5. 약국 모니터링 방문 Pharmacy Monitoring Visit</h6>
                    </article>

					<div style="height:2px;"></div>


					<div style="padding:0 0 0 18px;">
						임상시험용의약품 및 기타 임상시험에 필요한 물품 사용 현황 및 추가 공급 필요 여부를 확인하기 위해서 임상시험약국 또는 임상시험용의약품 관리자를 방문한다.
					</div>


					<div style="height:10px;"></div>



					<table class="tb001 tb001_01">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>약국 정기 모니터링 방문</th>
								<td>
									최소 <input type="text" id="" style="width:40px;" value="35"> 달에 <input type="text" id="" style="width:40px;" value="35"> 회 이상
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:2px;"></div>


					<div style="padding:0 0 0 18px;">
						약국 모니터링 방문은 정기모니터링 방문 시 진행할 수도 있고, 모니터링 외 방문을 통해서 이루어질 수도 있다.
						유효기간이 경과하였거나 파손/변질된 임상시험용의약품을 발견한 경우에는 발견 즉시 씨제이헬스케어㈜로 반납하거나 시험기관에서 파기될 수 있도록 조치한다.
						<br><br>
						약국 모니터링방문에서 CRA는 다음을 실시한다.
						<ul>
							<li>- 임상시험용의약품의 재고 및 보관상태 확인</li>
							<li>- 시험자 기본 문서 (Investigator study files) 확인</li>
							<li>- 임상시험용의약품 인수증 확인</li>
							<li>- 온도기록지 확인</li>
						</ul>
						<br>
						다음 항목에 대해 SDV를 실시한다.
						<ul>
							<li>- 임상시험용의약품 수불대장</li>
							<li>- 피험자별 수불관리</li>
							<li>- 처방전 확인</li>
						</ul>
					</div>


					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>6. 종료방문 Close-out Visit</h6>
                    </article>

					<div style="height:2px;"></div>


					<div style="padding:0 0 0 18px;">
						마지막 피험자의 마지막 방문이 종료되면 임상담당부서장 또는 임상담당부서장이 지정한 사람은 임상시험 종료를 시험자에게 알리고 종료방문을 실시하도록 한다.
					</div>


					<div style="height:10px;"></div>



					<table class="tb001 tb001_01">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>종료 방문</th>
								<td>
									시험종료 공지일로부터 <input type="text" id="" style="width:40px;" value="35"> 달 이내
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