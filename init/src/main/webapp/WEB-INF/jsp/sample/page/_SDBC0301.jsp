<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title></title>


<script type="text/javascript">

$(function() {
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});
	
	
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./_IWRG0402.do", null);
	});
	
});





</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<form id="iform">
	<input type='hidden' id=''/>							
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>대량 Upload</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>대량 Upload</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">

					<div class="button_tab_01">
						<ul>
							<li id="" class="port_back tab_menu">Upload</li>
							<li id="" class="tab_menu">History</li>
						</ul>
					</div>



					<div style="height:28px;">
						<span style="font-family:'NanumGothicBold';">Upload</span>
					</div>



					<table class="tb001">
						<colgroup>
							<col width="15%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>User Id</th>
								<td>crscube@cj.net</td>
							</tr>
							<tr>
								<th>Time</th>
								<td>2015-07-10 15:46</td>
							</tr>
							<tr>
								<th>Status</th>
								<td>SUCCESS</td>
							</tr>
							<tr>
								<th>Message</th>
								<td>File upload Success</td>
							</tr>
						</tbody>
					</table>


					<div style="height:30px;"></div>
					

					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Product</th>
								<td>
									<input type="text" id="" style="width:80%;">
									<button type="button" class="oneBtn">
										<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
									</button>
								</td>
								<th>Source type</th>
								<td>
									<select style="width:100%; vertical-align:top;">
										<option value="">====선택====</option>
									</select>
								</td>
								<th>Source</th>
								<td>
									<select style="width:100%; vertical-align:top;">
										<option value="">====선택====</option>
									</select>
								</td>
							</tr>
							<tr>
								<td colspan="6">
					 				<div class="fileInputArea" style="width:100%;">
						 				<input type="text" id="fileName" readonly="readonly" style="width:80%;">
						 				<input type="button" value="Select file" class="fileInputBtn" />
						 				<input type="file" class="fileIuputHid" style="width:100%;">
					 				</div>
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:30px;"></div>

					<div style=" text-align: center;">
						<input type="button" value="Upload">
		 				<input type="button" value="Template Download">
					</div>
	

<input type="button" value="팝업" class="popup_01">




				</div>
            </section>

		</div>
	</section>
	</form>
</div>
</body>
</html>