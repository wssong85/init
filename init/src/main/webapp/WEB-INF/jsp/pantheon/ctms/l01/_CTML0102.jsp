<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<style>
/*테이블004 CSS*/
table.tb_004 {width:100%; border-top: 1px solid #7287e4 !important;}
.tb_004 th {color:#333; font-size:13px; font-weight: bold; text-align: center; vertical-align:middle; font-family:'NanumGothicBold'; font-weight: normal;  padding:8px; border-left:1px solid #dedede; border-right:1px solid #dedede; box-sizing: border-box;}
.tb_004 thead th {background:#f6f7ff;}
.tb_004 tbody th {background:#f6f7ff; border:1px solid #dedede;}
.tb_004 tbody td {font-family:'NanumGothic'; color:#555; text-align:left; vertical-align:middle; font-size:12px; border:1px solid #dedede; box-sizing: border-box; }


.tb_004 td.day_01{ position:relative;}
.tb_004 td.day_01 div{position:absolute; top:5px;  height:25px; background:#6e85e9;}
</style>



<script type="text/javascript">
$(function(){
	// 탭메뉴
	$('#tab_01').click(function(){
		window.location.href ="./_CTML0101.do";
	});
	$('#tab_02').click(function(){
		window.location.href ="./_CTML0102.do";
	});
});
</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do" charEncoding="utf-8"/>
<c:import url="/com/lnb.do" charEncoding="utf-8"/>




	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>Project Part</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>MILESTONE</li>
						<li>Project Part</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height: 700px;">

						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_01" class="tab_menu">계획리스트</li>
								<li id="tab_02" class="port_back tab_menu">Milestone</li>
							</ul>
						</div>



						<table class="tb_004">
							<colgroup>
								<col width="10%">
								<col width="">
								<col width="7%">
								<col width="7%">
								
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead>
								<tr>
									<th colspan="2"></th>
									<th>1월</th>
									<th>2월</th>
									<th>3월</th>
									<th>4월</th>
									<th>5월</th>
									<th>6월</th>
									<th>7월</th>
									<th>8월</th>
									<th>9월</th>
									<th>10월</th>
									<th>11월</th>
									<th>12월</th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<th rowspan="4">Protocal 개발</th>
									<th>계획</th>
									<td colspan="12" class="day_01">
										<div style="left:0.273%; width:0.273%;" title="01월 02일 ~ 01월 03일"></div>
									</td>
								</tr>
								<tr>
									<th>실행</th>
									<td colspan="12" class="day_01">
										<div style="left:8.19%; width:8.19%;" title="02월 01일 ~ 02월 28일"></div>
									</td>
								</tr>
								<tr>
									<th>실행</th>
									<td colspan="12" class="day_01">
										<div style="left:19.11%; width:5.46%;" title="03월 10일 ~ 03월 30일"></div>
									</td>
								</tr>
								<tr>
									<th>실행</th>
									<td colspan="12" class="day_01">
										<div style="left:0%; width:100%;" title="01월 01일 ~ 12월 31일"></div>
									</td>
								</tr>
							</tbody>
						</table>



				</div>
            </section>



		</div>
	</section>
</div>
</body>
</html>