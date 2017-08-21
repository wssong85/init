<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<style>

.tb001_01 td{height:auto; padding:14px 30px 20px 30px; vertical-align:top;}
.tb001_01 td div{ display:block; padding:0 20px 0 0;}
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
				<h3>Note to File</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>Note to File</li>
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
							<col width="22%" />
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
								<th>시험연구자 Principal Investigator</th>
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



					<table class="tb001 tb001_01">
						<colgroup>
							<col width="" />
							<col width="26%" />
							<col width="26%" />
							<col width="26%" />
						</colgroup>
						<tbody>
							<tr>
								<th>관련 항목<br>Related Contents</th>
								<td>
									<div><input type="checkbox" name="" id="a1" ><label for="a1" class="chcLab"><span>임상시험용의약품<br><em style="margin-left:20px;">Investigational product</em></span></label></div>
									<div><input type="checkbox" name="" id="a2" ><label for="a2" class="chcLab"><span>피험자 등록<br><em style="margin-left:20px;">Subject enrollment</em></span></label></div>
									<div><input type="checkbox" name="" id="a3" ><label for="a3" class="chcLab"><span>기타<br><em style="margin-left:20px;">Others</em></span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="" id="a1" ><label for="a1" class="chcLab"><span>임상시험 절차<br><em style="margin-left:20px;">Study procedure</em></span></label></div>
									<div><input type="checkbox" name="" id="a2" ><label for="a2" class="chcLab"><span>문서<br><em style="margin-left:20px;">Dcumentation</em></span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="" id="a1" ><label for="a1" class="chcLab"><span>연구진<br><em style="margin-left:20px;">Site personnel</em></span></label></div>
									<div><input type="checkbox" name="" id="a2" ><label for="a2" class="chcLab"><span>안전성<br><em style="margin-left:20px;">관련 정보 Safety information</em></span></label></div>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>




					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="78%" />
						</colgroup>
						<tbody>
							<tr>
								<th>요약 Summary</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="" rows="10" style="width: 100%;"></textarea>
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