<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<style>

.tb001_01 td{height:auto; padding:8px 14px 8px 15px; }
.tb001_01 td .ck_01{ display:block; padding:0 20px 0 0;}
</style>



<script>

var testData_01 =[
{
  "역할 Role":"작성자 Prepared by",
  "성명 Name/ 서명 Signature":"홍길동/ 서명",
  "날짜 Date(yyyy.mm.dd)":"2015.12.12"
}, {
  "역할 Role":"시험책임자 Adjusted by",
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
  mkSetDatePickerYYMMDD("#day_02");
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
				<h3>일탈 로그</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>일탈 로그</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">




					<article>
						<h5>계획서 일탈 보고서</h5>
					</article>

					<div style="height:10px;"></div>



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
									<input type="text" id="" style="width:100%;" value="">
								</td>
							</tr>
							<tr>
								<th>시험책임자 Principal Investigator</th>
								<td>
									<input type="text" id="" style="width:100%;" value="">
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="text" id="" style="width:100%;" value="">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>



					<table class="tb001">
						<colgroup>
							<col width="18%" />
							<col width="21%" />
							<col width="15%" />
							<col width="12%" />
							<col width="12%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>피험자 번호 Subject No.</th>
								<td><input type="text" id="" style="width:100%;" value=""></td>
								<th>성별 Gender</th>
								<td>
									<input type="radio" id="a11" name="a1"><label for="a11" class="raLab"><span>F</span></label>
									<span style=" padding:0 5px;"></span>
									<input type="radio" id="a21" name="a1"><label for="a21" class="raLab"><span>M</span></label>
								</td>
								<th>이니셜 Initial</th>
								<td><input type="text" id="" style="width:100%;" value=""></td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>



					<table class="tb001 tb001_01">
						<colgroup>
							<col width="" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<tbody>
							<tr>
								<th>일탈의 형태 Deviation Type</th>
								<td>
									<div class="ck_01"><input type="checkbox" name="" id="b1" ><label for="b1" class="chcLab"><span>불이행<br><em style="margin-left:20px;">deviation</em></span></label></div>
								</td>
								<td>
									<div class="ck_01"><input type="checkbox" name="" id="b2" ><label for="b2" class="chcLab"><span>규정위반<br><em style="margin-left:20px;">violation</em></span></label></div>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<th>일탈의 원인<br>Deviation was</th>
								<td>
									<div class="ck_01"><input type="checkbox" name="" id="b3" ><label for="b3" class="chcLab"><span>의도하지 않음<br><em style="margin-left:20px;">Inadvertent</em></span></label></div>
								</td>
								<td>
									<div class="ck_01"><input type="checkbox" name="" id="b4" ><label for="b4" class="chcLab"><span>의도됨<br><em style="margin-left:20px;">Intentional</em></span></label></div>
								</td>
								<td colspan="2">
									<div class="ck_01"><input type="checkbox" name="" id="b5" ><label for="b5" class="chcLab"><span>피험자 보호를 위해 필요함<br><em style="margin-left:20px;">Necessary to protect the subject's welfare</em></span></label></div>
								</td>
							</tr>
							<tr>
								<th>일탈의 종류<br>Deviation involved</th>
								<td>
									<div class="ck_01"><input type="checkbox" name="" id="b6" ><label for="b6" class="chcLab"><span>관련 문서<br><em style="margin-left:20px;">Study Article</em></span></label></div>
									<div class="ck_01"><input type="checkbox" name="" id="b7" ><label for="b7" class="chcLab"><span>피험자 등록<br><em style="margin-left:20px;">Enrollment</em></span></label></div>
								</td>
								<td>
									<div class="ck_01"><input type="checkbox" name="" id="b8" ><label for="b8" class="chcLab"><span>임상시험절차<br><em style="margin-left:20px;">Procedure</em></span></label></div>
									<div class="ck_01"><input type="checkbox" name="" id="b9" ><label for="b9" class="chcLab"><span>임상시험용의약품<br><em style="margin-left:20px;">IP</em></span></label></div>
								</td>
								<td colspan="2">
									<div class="ck_01"><input type="checkbox" name="" id="b10" ><label for="b10" class="chcLab"><span>피험자 방문<br><em style="margin-left:20px;">Visit</em></span></label></div>
									<div class="ck_01"><input type="checkbox" name="" id="b11" ><label for="b11" class="chcLab"><span>기타<br><em style="margin-left:20px;">Others (Detail in Summary)</em></span></label></div>
								</td>
							</tr>
							<tr>
								<th>일자<br>Dates</th>
								<td>발생일 Occurred on</td>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />
									</div>
								</td>
								<td>발견일 Discovered on</td>
								<td>
									<div class="dateBox">
										<input type="text" id="day_02" style="width: 120px;" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>
					
					
					

					<table class="tb001">
						<colgroup>
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>요약 Summary</th>
							</tr>
							<tr>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					
					


					<table class="tb001">
						<colgroup>
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>소견 Summary</th>
							</tr>
							<tr>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					
					

					<table class="tb001">
						<colgroup>
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>
									<span style="position:relative; top:-4px;">시험계획서 변경이 필요합니까? Should the protocol be amended?</span>
									<span style=" padding:0 5px;"></span>
									<input type="radio" id="c11" name="c1"><label for="c11" class="raLab"><span>예 Yes</span></label>
									<span style=" padding:0 5px;"></span>
									<input type="radio" id="c21" name="c1"><label for="c21" class="raLab"><span>아니오 No  (If yes, explain)</span></label>
								</th>
							</tr>
							<tr>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="5" style="width: 100%;"></textarea>
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
					<div id="grid_wrap_01" class="gridHeiSz02 grid_wrap tb01_2"></div>



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