<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<script type="text/javascript">

$(function(){
	mkSetDatePickerYYMMDD("#day_01");
});

</script>


</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Subject List</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Subject</li>
						<li>Subject List</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:800px;">





                    <article class="conTitBox">
                        <h5>Patient 등록</h5>
                    </article>


                    <article class="conTitBtnR">
						<input type="button" id="" value="저장">
						<input type="button" id="" value="저장 후 이동">
                    </article>
                    




					<article class="mgT14">
						<table class="tb001">
							<colgroup>
								<col width="12%" />
								<col width="30%" />
								<col width="12%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>동의 여부</th>
									<td>
										<input type="radio" id="ra01" name="r1"><label for="ra01" class="raLab"><span>예</span></label>
										<input type="radio" id="ra02" name="r1"><label for="ra02" class="raLab"><span>아니오</span></label>
									</td>
									<th>동의일</th>
									<td>
										<div class="dateBox">
											<input type="text" id="day_01" />
										</div>
									</td>
								</tr>
								<tr>
									<th>이니셜</th>
									<td colspan="3">
										<input type="text" id="" style="width:20%;" />
									</td>
								</tr>
								<tr>
									<th>Subject No.</th>
									<td colspan="3">
										<input type="text" id="" style="width:20%;" value="S004" readonly />
										
									</td>
								</tr>
							</tbody>
						</table>
					</article>
                    








					
				</div>
            </section>


		
		






		</div>
	</section>
</div>
</body>
</html>