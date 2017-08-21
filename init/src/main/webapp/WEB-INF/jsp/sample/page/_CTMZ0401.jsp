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
  "역할 Role":"PD Approved by",
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
				<h3>기관 방문</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>기관 방문</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">





					<div id="tab" class="tab tab01">
						<ul>
							<li id="" class="port_back tab_menu">모니터링 계획</li>
							<li id="" class="tab_menu">모니터링 보고서</li>
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
									<input type="text" id="" style="width:100%;">
								</td>
							</tr>
							<tr>
								<th>연구기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="" style="width:93%;">
									<button type="button" class="oneBtn">
										<img class="oneBtnIco" src="http://52.2.72.226:8080/images/pantheon/common/searchIco.png" alt="검색">
									</button>
								</td>
							</tr>
							<tr>
								<th>책임연구자 Principal Investigator</th>
								<td>
									<input type="text" id="" style="width:100%;">
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 목적 Attendants</h6>
                    </article>
                    

					<div style="height:2px;"></div>



					<div style="padding:0 0 0 18px;">
						본 모니터링 계획은 <input type="text" id="" style="width:200px;" value="[CJ_OOO_P0O]"> 연구 모니터링 업무를 수행하는 데 필요한 지침을 제공하기 위해 마련되었다.
					</div>




					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>2. 정기 모니터링 Routine Monitoring Visit</h6>
                    </article>


					<div style="height:2px;"></div>


					<div style="padding:0 0 0 18px;">
						정기 모니터링 방문 이외에 연구기관에 전화 또는 메일을 통해 연락을 취하여 수시로 연구 진행 현황을 파악한다.정기 모니터링의 시기와 방법은 아래의 표를 참조하여 실시한다.
					</div>





					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6 style="color:#FF0000;">[예시]</h6>
                    </article>


					<div style="height:2px;"></div>


					<h7 style="color:#FF0000;">ㆍ모니터링 시기</h7>
					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>첫 번째 정기 모니터링</th>
								<td style="color:#FF0000;">
									목표 조사대상자수의 O% 등록 완료 시점으로부터 O주 이내
								</td>
							</tr>
							<tr>
								<th>이후 정기 모니터링</th>
								<td style="color:#FF0000;">
									목표 조사대상자수의 O%, O% 등록 완료 시점으로부터 O주 이내
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:10px;"></div>
					

					<h7 style="color:#FF0000;">ㆍ모니터링 방법</h7>
					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>첫 번째 정기 모니터링</th>
								<td style="color:#FF0000;">
									조사대상자의 홀수(또는 짝수) 번호를 전수 조사 한다. 연속된 O명의 조사대상자의 점검 완료 후 특이사항이 없을 경우 OO하고, 특이사항이 있을 경우 전수 조사 한다.
								</td>
							</tr>
							<tr>
								<th>이후 정기 모니터링</th>
								<td style="color:#FF0000;">
									첫 번째 정기 모니터링 이후 등록된 조사대상자를 동일한 방법으로 모니터링 하고, 이전 점검사항에 대해 Follow Up 한다.
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:2px;"></div>


					<div style="padding:0 0 0 0px;">
						단, <span style="color:#FF0000;">모니터링 시기와 횟수</span>는 TM의 사전승인 하에 <span style="color:#FF0000;">기관에 따라 변경 될 수 있다.</span>
					</div>



					<div style="height:20px;"></div>
					

					<h7>ㆍ 정기 모니터링 방문에서 CRA은 다음을 실시한다.</h7>

					<div style="padding:0 0 0 18px;">
						<ul>
							<li>- 연구기관의 적절성 확인</li>
							<li>- 연구자 기본 문서 (Investigator study files)</li>
							<li>- <span style="color:#FF0000;">조사대상자 등록 및 완료 현황</span></li>
							<li>- <span style="color:#FF0000;">연구 계획서 및 관련 규정 위반 시, 재발 방지를 위한 적절한 조치 여부, 기록 및 보고 확인</span></li>
						</ul>
					</div>




					<div style="height:20px;"></div>
					

					<h7>ㆍ 다음 항목에 대해 SDV를 실시한다.</h7>

					<div style="padding:0 0 0 18px;">
						<ul>
							<li>- 동의서</li>
							<li>- <span style="color:#FF0000;">방문일 정보</span></li>
							<li>- <span style="color:#FF0000;">조사대상자 탈락 여부</span></li>
							<li>- <span style="color:#FF0000;">실험실 검사</span></li>
							<li>- 중대한 유해사례 보고서 (해당할 경우)</li>
							<li>- 병용약물, <span style="color:#FF0000;">병력</span></li>
							<li>- <span style="color:#FF0000;">ISF 최신화</span></li>
						</ul>
					</div>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 종료 모니터링 Close-out Visit</h6>
                    </article>


					<div style="height:2px;"></div>


					<div style="padding:0 0 0 0px;">
						마지막 조사대상자의 방문이 종료되면 CRA는 연구자에게 공지 후 종료방문을 실시하도록 한다.
					</div>
					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>종료 방문</th>
								<td style="color:#FF0000;">
									목연구 종료 요청일로부터 0주 이내
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>










                    <article class="conTitBox">
                        <h6>4. 결제</h6>
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