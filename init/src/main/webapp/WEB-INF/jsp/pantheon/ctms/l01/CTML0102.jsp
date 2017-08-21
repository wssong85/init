<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript" src="<c:url value='/js/pantheon/edc/EDC.js'/>"></script>
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
$(document).ready(function() {

	// 탭메뉴
	$('#tab_menu1').click(function(){
		$("#frm").attr({
			action : './CTML0101.do',
			method : 'post'
		}).submit();
	});
	$('#tab_menu2').click(function(){
		$("#frm").attr({
			action : './CTML0102.do',
			method : 'post'
		}).submit();
	});
	
	fn_initLoad();

});

function fn_initLoad() {
	
	var paramData = {
			TASK_SN : '${loginMap.TASK_SN}'
		};

	$.ajax({
		url : '/ctms/l01/selectMileStonePlanBarList.do',
		type : 'post',
		dataType : 'json',
		data : paramData,
		success : function(data) {
			if (data.success) {

				var yearSize;
				$("#yearSize").empty();
				yearSize += "<col width='10%'>";
				yearSize += "<col width=''>";
				for(var i=0; data.yearcnt > i; i++){
					yearSize += "<col width='"+data.colwidth.COL_WIDTH+"%'>";
				}
				$("#yearSize").append(yearList);
				
				var yearData;
				var yearList;
				$("#yearList").empty();
				yearList += "<th colspan='2'></th>";
				for(var i=0; data.yearcnt > i; i++){
					yearData = data.yearList[i];
					yearList += "<th>"+yearData.MONTHS+"</th>";
				}
				$("#yearList").append(yearList);
				
				var barData;
				var barTbody = "";
				$("#barTbody").empty();
				
				if(data.barcnt > 0){
					
					for(var i=0; data.barcnt > i; i++){
						
						barData = data.barList[i];
						barTbody += "<tr>";
						
						if( barData.ORD == 1 ){
							barTbody += "	<th rowspan='2'>"+barData.PLAN_NM+"</th>";
							barTbody += "	<th>계획</th>";
						}
						else{
							barTbody += "	<th>실행</th>";
						}
						barTbody += "	<td colspan='"+data.yearcnt+"' class='day_01'>";
						barTbody += "		<div style='left:"+barData.START_PLAN+"%; width:"+barData.END_PLAN+"%;' title='"+barData.FROM_TO+"'></div>";
						barTbody += "	</td>";
						barTbody += "</tr>";
					}
					$("#barTbody").append(barTbody);
				}
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
}

</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>




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
								<li id="tab_menu1" class="tab_menu">계획리스트</li>
								<li id="tab_menu2" class="port_back tab_menu">Milestone</li>
							</ul>
						</div>



						<table class="tb_004">
							<colgroup id="yearSize">
								<col width="10%">
								<col width="">
								<col width="12.8%">
								<col width="12.8%">
								<col width="12.8%">
								<col width="12.8%">
								<col width="12.8%">
								<col width="12.8%">
								<col width="12.8%">
							</colgroup>
							<thead>
								<tr id="yearList">
									<th colspan="2"></th>
									<th>15-11월</th>
									<th>15-12월</th>
									<th>16-01월</th>
									<th>16-02월</th>
									<th>16-03월</th>
									<th>16-04월</th>
									<th>16-05월</th>
								</tr>
							</thead>

							<tbody id="barTbody">
								<tr>
									<th rowspan="2">Protocal 개발 11</th>
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
									<th rowspan="2">Protocal 개발 22</th>
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
							</tbody>
						</table>



				</div>
            </section>

<form id="frm" name="frm">
	<input id="TASK_SN" type="hidden" name="TASK_SN" value='${loginMap.TASK_SN}'>
</form>

		</div>
	</section>
</div>
</body>
</html>