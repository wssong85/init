<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<style>
.tb001_01 td{height:auto; padding:14px 30px 20px 30px; vertical-align:top;}
.tb001_01 td div{ display:inline-block; padding:0 20px 0 0;}
</style>

<script>

var testData_01 =[
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
							<li id="" class="port_back tab_menu">연구기관 방문 보고서</li>
							<li id="" class="tab_menu">방문 후속조치 보고서</li>
						</ul>
					</div>

<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->


					<table class="tb001">
						<colgroup>
							<col width="180px" />
							<col width="" />
							<col width="180px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>과제번호 Protocol No.</th>
								<td>
									<input type="text" id="" style="width:100%;" value="[CJ_OOO_P0O]">
								</td>
								<th>연구기관 Institution</th>
								<td>
									<input type="text" id="" style="width:100%;" value="한양대 병원">
								</td>
							</tr>
							<tr>
								<th>연구자 Investigator</th>
								<td>
									<input type="text" id="" style="width:100%;" value="홍길동">
								</td>
								<th>직책 Position</th>
								<td>
									<input type="text" id="" style="width:100%;" value="조사연구자 or 공동연구자 or CRC">
								</td>
							</tr>
							<tr>
								<th>방문일 Date of Visit</th>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />
									</div>
								</td>
								<th>방문자 Visitor</th>
								<td>
									<input type="text" id="" style="width:100%;">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 방문목적 Purpose of Visit</h6>
                    </article>
                    

					<div style="height:10px;"></div>

					<table class="tb001 tb001_01">
						<colgroup>
							<col width="50%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>1. 연구 설명</th>
								<th>2. 계약</th>
							</tr>
							<tr>
								<td>
									<div><input type="checkbox" name="" id="a1" ><label for="a1" class="chcLab"><span>1. 디자인 설명</span></label></div>
									<div><input type="checkbox" name="" id="a2" ><label for="a2" class="chcLab"><span>2. 규정 관련 설명</span></label></div>
									<div><input type="checkbox" name="" id="a3" ><label for="a3" class="chcLab"><span>3. 조사대상자 선정/제외기준 설명</span></label></div>
									<div><input type="checkbox" name="" id="a4" ><label for="a4" class="chcLab"><span>4. e-CRF 입력 방법 교육</span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="" id="b1" ><label for="b1" class="chcLab"><span>1. 진행 계약</span></label></div>
									<div><input type="checkbox" name="" id="b2" ><label for="b2" class="chcLab"><span>2. 중단 계약</span></label></div>
									<div><input type="checkbox" name="" id="b3" ><label for="b3" class="chcLab"><span>3. 변경 계약</span></label></div>
								</td>
							</tr>
							<tr>
								<th>3. 연구 진행 및 독려</th>
								<th>4. IRB 심의</th>
							</tr>
							<tr>
								<td>
									<div><input type="checkbox" name="" id="c1" ><label for="c1" class="chcLab"><span>1. 진행 독려</span></label></div>
									<div><input type="checkbox" name="" id="c2" ><label for="c2" class="chcLab"><span>2. 진행 확인</span></label></div>
									<div><input type="checkbox" name="" id="c3" ><label for="c3" class="chcLab"><span>3. 쿼리 해결</span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="" id="d1" ><label for="d1" class="chcLab"><span>1. 초기심의</span></label></div>
									<div><input type="checkbox" name="" id="d2" ><label for="d2" class="chcLab"><span>2. 변경심의</span></label></div>
									<div><input type="checkbox" name="" id="d3" ><label for="d3" class="chcLab"><span>3. 종료심의</span></label></div>
									<div><input type="checkbox" name="" id="d4" ><label for="d4" class="chcLab"><span>4. 지속심의</span></label></div>
									<div><input type="checkbox" name="" id="d5" ><label for="d5" class="chcLab"><span>5. SAE 보고</span></label></div>
									<div><input type="checkbox" name="" id="d6" ><label for="d6" class="chcLab"><span>6. 기타</span></label></div>
								</td>
							</tr>
							<tr>
								<th>5. 유해사례</th>
								<th>6. 기타</th>
							</tr>
							<tr>
								<td>
									<div><input type="checkbox" name="" id="e1" ><label for="e1" class="chcLab"><span>1. SAE 확인</span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="" id="f1" ><label for="f1" class="chcLab"><span>1. 기타</span></label></div>
								</td>
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
								<th>세부 내용 Additional Comments</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="3" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>2. 결제</h6>
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