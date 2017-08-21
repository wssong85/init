
<%@page pageEncoding="UTF-8"%>
 
<%
	final String pathUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>


<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="/js/pantheon/common/jquery-2.1.1.js"></script>
<title>cj헬스케어 통합임상정보관리시스템</title>
<style>
body { background-color:#fafafa; font-size:12px; color:#444444; font-family:dotum, '돋움', sans-serif; }
ul, li { margin:0; padding:0; list-style:none; }
table, th, td { border:0; border-spacing:0px; border-collapse:collapse; }
.coding_list { margin:0 0 60px 0; }
.guide { margin:0 0 100px 0; }
.guide .title_01 { font-weight:bold; font-size:16px; }
.guide .table_map { clear:both; width:100%; border-bottom:1px solid #ccc; border-right:1px solid #ccc; font-size:12px; background:#fff }
.guide .table_map thead th, .guide .table_map thead td { text-align:center }
.guide .table_map tbody tr td:first-child { text-align:center }
.guide .table_map tbody tr.b1 { border-top:2px solid #8588a1; }
.guide .table_map th, .guide .table_map td { padding:6px 10px; border-top:1px solid #ccc; text-align:left; }
.guide .table_map th.center, .guide .table_map td.center { text-align:center; }
.guide .table_map th { border-top:1px solid #ccc; border-left:1px solid #ccc; background-color:#f1f1f1; }
.guide .table_map td { border-left:1px solid #ccc; }
.guide .table_map td a { text-decoration:underline; color:#34495e }
.guide .table_map td em.color1 { display:inline-block; margin-left:10px; color:red; font-weight:bold }
.guide .table_map td em.color2 { display:inline-block; margin-left:10px; color:#72c7c5; font-weight:bold }
.guide .table_map td.left { padding-left:10px; text-align:left; }
.guide .table_map .title { padding-left:10px; text-align:left; }
.guide .table_map .filename a { text-decoration:none; }
.guideRefer { display:inline-block; width:100%; position:relative; margin-bottom:5px; }
.guideRefer p { font-weight:bold; font-size:18px; }
.guideRefer span { position:absolute; right:20px; top:10px; line-height: 159%; }
.guideRefer span strong { color:purple; }
.guideInfo ul { margin-bottom:12px; }
.guideInfo ul li { padding-bottom:5px; }
</style>
</head>

<body>
<!-- <div class="guideRefer"> <span>최종업데이트 : <strong>2016.04.27</strong></span> </div> -->
<div class="guide">
	<p class="title_01">퍼블리싱 수정페이지</p>
	<div class="coding_list">
		<table class="table_map">
			<colgroup>
			<col width="3%" />
			<col width="5%" />
			<col width="25%" />
			<col width="*"/>
			<col width="6%"/>
			<col width="30%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>폴더</th>
					<th>로케이션</th>
					<th>파일명</th>
					<th>완료</th>
					<th>기타</th>
				</tr>
			</thead>
			

			
			<tbody>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>공통코드관리 - 메뉴관리</td>
					<td class="filename"><a href="<%=pathUrl%>/com/d01/_COMD0101.do" target="_blank"><%=pathUrl%>/com/d01/_COMD0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>메뉴관리 - 메뉴관리</td>
					<td class="filename"><a href="<%=pathUrl%>/com/a01/_COMA0101.do" target="_blank"><%=pathUrl%>/com/a01/_COMA0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>필수값 must_01 넣어야함</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>이력관리(AUDIT TRAIL) - 이력관리(Audit Trail)</td>
					<td class="filename"><a href="<%=pathUrl%>/com/j01/_COMJ0101.do" target="_blank"><%=pathUrl%>/com/j01/_COMJ0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>결제선테스트(팝업레이어)</td>
					<td class="filename"><a href="<%=pathUrl%>/com/z09/_COMZ0901.do" target="_blank"><%=pathUrl%>/com/z09/_COMZ0901.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_COMA0101.do에서 결제선 테스트 버튼..덮어써야 해야 보임.</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>결제선관리(팝업레이어에서 또 팝업레이어)</td>
					<td class="filename"><a href="<%=pathUrl%>/com/z09/_COMZ0902.do" target="_blank"><%=pathUrl%>/com/z09/_COMZ0902.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_COMA0101.do에서 결제선 테스트 버튼 누르면 팝업창에서 결제선 버튼 누르면 나옴..덮어써야 해야 보임.</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자결제테스트(팝업레이어)</td>
					<td class="filename"><a href="<%=pathUrl%>/com/z09/_COMZ0903.do" target="_blank"><%=pathUrl%>/com/z09/_COMZ0903.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_COMA0101.do에서 전자결제 테스트 버튼..덮어써야 해야 보임.</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>역할별 권한 괸리</td>
					<td class="filename"><a href="<%=pathUrl%>/com/b02/_COMB0202.do" target="_blank"><%=pathUrl%>/com/b02/_COMB0202.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>덮어쓰기하면 됨</td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0101.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록(등록폼)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0102.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록(Spontaneous 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0104.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0104.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록(Literature 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0106.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0106.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록(등록폼)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0107.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0107.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록(Etc 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0108.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0108.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록(등록폼)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0109.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0109.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - Source별 등록(ICSR 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/_SDBC0110.do" target="_blank"><%=pathUrl%>/sdb/c01/_SDBC0110.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>

				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>팝업레이어(검색)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c01/popup_SDBC0103.do" target="_blank"><%=pathUrl%>/sdb/c01/popup_SDBC0103.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>페이지 내부에서 정상적으로 보임</td>
				</tr>

				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>팝업레이어(수정, 삭제)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c02/popup_SDBC0217.do" target="_blank"><%=pathUrl%>/sdb/c02/popup_SDBC0217.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>페이지 내부에서 정상적으로 보임</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>팝업레이어(원명, 영어명)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c02/popup_SDBC0218.do" target="_blank"><%=pathUrl%>/sdb/c02/popup_SDBC0218.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>페이지 내부에서 정상적으로 보임</td>
				</tr>
<!--				
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>팝업레이어(?)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/b02/popup_SDBB0203.do" target="_blank"><%=pathUrl%>/sdb/b02/popup_SDBB0203.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>페이지 내부에서 정상적으로 보임</td>
				</tr>
-->
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>팝업레이어(검색)</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/b02/popup_SDBB0204.do" target="_blank"><%=pathUrl%>/sdb/b02/popup_SDBB0204.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>페이지 내부에서 정상적으로 보임</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - 유해사례</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/c02/_SDBC0201.do" target="_blank"><%=pathUrl%>/sdb/c02/_SDBC0201.do</a></td>
					<td style="text-align:center;">OK(신규)</td>
					<td>폼디지인 간격 수정(20160510)</td>
				</tr>

				
				
				
				
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>SYSTEM MASTER FILE - SOP 등록</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/f04/_SDBF0401.do" target="_blank"><%=pathUrl%>/sdb/f04/_SDBF0401.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>거래선관리</td>
					<td class="filename"><a href="<%=pathUrl%>/sdb/b02/_SDBB0201.do" target="_blank"><%=pathUrl%>/sdb/b02/_SDBB0201.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				
				
				
				
				








				<tr class="b1">
					<td></td>
					<td class="center">CTMS</td>
					<td>MILESTONE - Project Part(계획리스트 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/l01/_CTML0101.do" target="_blank"><%=pathUrl%>/ctms/l01/_CTML0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>MILESTONE - Project Part(Milestone 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/l01/_CTML0102.do" target="_blank"><%=pathUrl%>/ctms/l01/_CTML0102.do</a></td>
					<td style="text-align:center;">OK(신규)</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>(?) - IRB Info 과제</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/v01/_CTMV0101.do" target="_blank"><%=pathUrl%>/ctms/v01/_CTMV0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>aui그리드 th부분 늘어나게<br> 필터 샘플로 추가<br> select 박스 내용 안겹치게</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>STUDY MANAGEMENT - 임상과제 및 과제정보</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/b01/_CTMB0101.do" target="_blank"><%=pathUrl%>/ctms/b01/_CTMB0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>STUDY MANAGEMENT - PMS 과제 및 과제정보</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/b02/_CTMB0201.do" target="_blank"><%=pathUrl%>/ctms/b02/_CTMB0201.do</a></td>
					<td style="text-align:center;"></td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>STUDY MANAGEMENT - NIS 과제 및 과제정보</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/b03/_CTMB0301.do" target="_blank"><%=pathUrl%>/ctms/b03/_CTMB0301.do</a></td>
					<td style="text-align:center;"></td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>▼pupuptest</td>
					<td class="filename"><a href="<%=pathUrl%>/popuptest.do" target="_blank"><%=pathUrl%>/popuptest.do</a></td>
					<td style="text-align:center;"></td>
					<td>/ctms/f01/CTMSTest.jsp</td>
				</tr>
				
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>반려 팝업레이어</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/j11/popup_DMCJ1102.do" target="_blank"><%=pathUrl%>/ctms/j11/popup_DMCJ1102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>DMCJ1102.jsp</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>기관명 검색 팝업레이어</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/j11/popup_DMCJ1103.do" target="_blank"><%=pathUrl%>/ctms/j11/popup_DMCJ1103.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>DMCJ1103.jsp</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>사용자명 검색 팝업레이어</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/j11/popup_DMCJ1104.do" target="_blank"><%=pathUrl%>/ctms/j11/popup_DMCJ1104.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>DMCJ1104.jsp</td>
				</tr>
				
<!-- 				
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>파일 업로드 팝업레이어</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/j11/DMCJ1105.do" target="_blank"><%=pathUrl%>/ctms/j11/DMCJ1105.do</a></td>
					<td style="text-align:center;"></td>
					<td>DMCJ1105.jsp</td>
				</tr>
				

 -->	
				
				
				
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>과제조회 팝업레이어</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/j11/popup_DMCJ1106.do" target="_blank"><%=pathUrl%>/ctms/j11/popup_DMCJ1106.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>DMCJ1106.jsp</td>
				</tr>



<!-- 				
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>사용자 권한조회 팝업레이어</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/j11/DMCJ1107.do" target="_blank"><%=pathUrl%>/ctms/j11/DMCJ1107.do</a></td>
					<td style="text-align:center;"></td>
					<td>DMCJ1107.jsp</td>
				</tr>
				
 -->				
				

				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>과제별 역할권한</td>
					<td class="filename"><a href="<%=pathUrl%>/ctms/j07/_DMCJ0701.do" target="_blank"><%=pathUrl%>/ctms/j07/_DMCJ0701.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>그대로 덮어쓰기하면 됨(좌우화살표)</td>
				</tr>


				<tr class="b1">
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - Lab 정상범위 관리</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k03/popup_EDCK0301.do" target="_blank"><%=pathUrl%>/edc/k03/popup_EDCK0301.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - Lab 정상범위 상세</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k03/_selectLab.do" target="_blank"><%=pathUrl%>/edc/k03/_selectLab.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_inserLab.do와 같이 쓰임(_EDCK0302.jsp)</td>
				</tr>
				
				<!-- 
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>이상반응 신속보고 목록</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/j01/_EDCJ0101.do" target="_blank"><%=pathUrl%>/edc/j01/_EDCJ0101.do</a></td>
					<td style="text-align:center;"></td>
					<td></td>
				</tr>
				 -->
				 
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>이상반응 신속보고 내용</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/j01/_EDCJ0102.do" target="_blank"><%=pathUrl%>/edc/j01/_EDCJ0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>

				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제선택</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/a01/_EDCA0101.do" target="_blank"><%=pathUrl%>/edc/a01/_EDCA0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>


				<tr class="b1">
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - 과제등록 - Study List</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k01/_EDCK0101.do" target="_blank"><%=pathUrl%>/edc/k01/_EDCK0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - 과제등록 - Study Info</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k01/_EDCK0102.do" target="_blank"><%=pathUrl%>/edc/k01/_EDCK0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0102.jsp에 붙여 넣어야 제대로 보임</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - EDC - EDC Designer</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/_EDCK0201.do" target="_blank"><%=pathUrl%>/edc/k02/_EDCK0201.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - EDC - EDC Designer</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/_EDCK0202.do" target="_blank"><%=pathUrl%>/edc/k02/_EDCK0202.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0202.jsp에서만 됨(붙여넣기 해야함)</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>팝업레이어(신규버튼 클릭시)</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/popup_EDCK0202Sub01.do" target="_blank"><%=pathUrl%>/edc/k02/popup_EDCK0202Sub01.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>페이지 내부에서 정상적으로 보임<br>버튼 하단 가운데<br>EDCK0202Sub01.jsp에 붙여 넣기하면 됨</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>팝업레이어(변경설정)</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/popup_EDCK0202Sub02.do" target="_blank"><%=pathUrl%>/edc/k02/popup_EDCK0202Sub02.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>페이지 내부에서 정상적으로 보임<br>버튼 하단 가운데<br>EDCK0202Sub02.jsp에 붙여 넣기하면 됨</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - EDC - EDC Designer(Group 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/_EDCK0204.do" target="_blank"><%=pathUrl%>/edc/k02/_EDCK0204.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0204.jsp에 붙여 넣기하면 됨<br>오른쪽 아래.. 내리는 큰 버튼</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - EDC - EDC Designer(Visit 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/_EDCK0207.do" target="_blank"><%=pathUrl%>/edc/k02/_EDCK0207.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0207.jsp에 붙여 넣기하면 됨<br>오른쪽 아래.. 내리는 큰 버튼</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - EDC - EDC Designer(Dictionary 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/_EDCK0208.do" target="_blank"><%=pathUrl%>/edc/k02/_EDCK0208.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0208.jsp에 붙여 넣기하면 됨<br>aui그리드 간격width값 넣음</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - EDC - EDC Designer(Layout 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/EDCK0209.do" target="_blank"><%=pathUrl%>/edc/k02/EDCK0209.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0209.jsp에 붙여 넣기하면 됨</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>팝업레이어(Description)</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/popup_EDCK0210.do" target="_blank"><%=pathUrl%>/edc/k02/popup_EDCK0210.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0210.jsp에 붙여 넣기하면 됨</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - EDC - EDC Designer</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k02/_EDCK0214.do" target="_blank"><%=pathUrl%>/edc/k02/_EDCK0214.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>EDCK0214.jsp에 붙여 넣기하면 됨</td>
				</tr>

				<tr class="b1">
					<td></td>
					<td class="center">EDC</td>
					<td>과제관리 - 종료과제 괸리</td>
					<td class="filename"><a href="<%=pathUrl%>/edc/k05/_EDCK0501.do" target="_blank"><%=pathUrl%>/edc/k05/_EDCK0501.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>그대로 덮어쓰기하면 됨(좌우화살표)</td>
				</tr>
				
				<tr class="b1">
					<td></td>
					<td class="center">IWRS</td>
					<td>배송관리 - 배송현황</td>
					<td class="filename"><a href="<%=pathUrl%>/iwrs/c01/_IWRC0101.do" target="_blank"><%=pathUrl%>/iwrs/c01/_IWRC0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>Iwrc0101.jsp에 붙여 넣기하면 됨</td>
				</tr>

				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>팝업레이어(배송요청 눌렀을때)</td>
					<td class="filename"><a href="<%=pathUrl%>/iwrs/c01/popup_Iwrc0102.do" target="_blank"><%=pathUrl%>/iwrs/c01/popup_Iwrc0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>Iwrc0102.jsp에 붙여 넣기하면 됨</td>
				</tr>

				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>팝업레이어(배송완료잉 눌렀을때)</td>
					<td class="filename"><a href="<%=pathUrl%>/iwrs/c01/popup_Iwrc0107.do" target="_blank"><%=pathUrl%>/iwrs/c01/popup_Iwrc0107.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>Iwrc0107.jsp에 붙여 넣기하면 됨</td>
				</tr>


				<tr>
					<td></td>
					<td class="center"></td>
					<td> - </td>
					<td class="filename"><a href="" target="_blank"></a></td>
					<td style="text-align:center;"></td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="coding_list">
		<p class="title_01">인수인계</p>
		<table class="table_map">
			<colgroup>
			<col width="3%" />
			<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>인수인계</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/from_01.do" target="_blank"><%=pathUrl%>/sample/page/from_01.do</a></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	
	<div class="coding_list">
		<p class="title_01">퍼블리싱 생성페이지</p>
		<table class="table_map">
			<colgroup>
			<col width="3%" />
			<col width="5%" />
			<col width="25%" />
			<col width="*"/>
			<col width="6%"/>
			<col width="30%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>폴더</th>
					<th>로케이션</th>
					<th>파일명</th>
					<th>완료</th>
					<th>기타</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td></td>
					<td class="center">page</td>
					<td>버튼아이콘화, 달력 비활성 활성</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/icons.do" target="_blank"><%=pathUrl%>/sample/page/icons.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>① 수정 ② 행추가 ③ 행삭제 ④ 저장 ⑤ 닫기 ⑥ 초기화</td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">uiModule</td>
					<td>1뎁스</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/uiModule/con_1depth.do" target="_blank"><%=pathUrl%>/sample/uiModule/con_1depth.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">uiModule</td>
					<td>2뎁스</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/uiModule/con_2depth.do" target="_blank"><%=pathUrl%>/sample/uiModule/con_2depth.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">uiModule</td>
					<td>3뎁스</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/uiModule/con_3depth.do" target="_blank"><%=pathUrl%>/sample/uiModule/con_3depth.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">page</td>
					<td>서브메인</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMA01.do" target="_blank"><%=pathUrl%>/sample/page/_CTMA01.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">page</td>
					<td>서브메인</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMI01.do" target="_blank"><%=pathUrl%>/sample/page/_CTMI01.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">page</td>
					<td>서브메인</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCB01.do" target="_blank"><%=pathUrl%>/sample/page/_EDCB01.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">page</td>
					<td>서브메인</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRA01.do" target="_blank"><%=pathUrl%>/sample/page/_IWRA01.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">page</td>
					<td>서브메인</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBA01.do" target="_blank"><%=pathUrl%>/sample/page/_SDBA01.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">page</td>
					<td>서브메인</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_DMCJ01.do" target="_blank"><%=pathUrl%>/sample/page/_DMCJ01.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				
				<tr class="b1">
					<td></td>
					<td class="center">IWRS</td>
					<td>불출납현황</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRE0102.do" target="_blank"><%=pathUrl%>/sample/page/_IWRE0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				
				<tr class="b1">
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 로그인 폼</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0109.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0109.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 가입약관(약관동의)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0101.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 가입약관(본인인증)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0102.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 가입약관(정보입력)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0103.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0103.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 가입약관(계약안내)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0104.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0104.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 가입약관(계약요청)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0105.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0105.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 가입약관(계약요청완료)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0106.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0106.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>전자계약 가입약관(계약서미리보기)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMH0107.do" target="_blank"><%=pathUrl%>/sample/page/_COMH0107.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_COMH0105.do 계약서 미리보기 버튼 눌러야 제대로 볼 수 있음</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>아이디/비밀번호 찾기</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMI0202.do" target="_blank"><%=pathUrl%>/sample/page/_COMI0202.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>비밀번호 변경</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMI0203.do" target="_blank"><%=pathUrl%>/sample/page/_COMI0203.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>CDISC</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0101.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>CDISC(팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0102.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_COMC0101.do 내부팝업에서 정상적으로 보임</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>MedDRA 탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0201.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0201.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>ATC 탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0202.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0202.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>WHOART 탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0203.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0203.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>KIMS 탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0204.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0204.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>탭들(팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0205.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0205.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_COMC0201.do ~ _COMC0204.do 내부팝업에서 정상적으로 보임</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>KCD관리</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0301.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0301.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>KCD관리(팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMC0302.do" target="_blank"><%=pathUrl%>/sample/page/_COMC0302.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>_COMC0301.do 내부팝업에서 정상적으로 보임</td>
				</tr>
				
				
				
				
				<tr class="b1">
					<td></td>
					<td class="center">공통</td>
					<td>데이타 로딩화면</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/page_loading.do" target="_blank"><%=pathUrl%>/sample/page/page_loading.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>팝업레이어에서도 데이타 로딩시 감안</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">공통</td>
					<td>에러 페이지</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/error_page.do" target="_blank"><%=pathUrl%>/sample/page/error_page.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">EDC</td>
					<td>Subject 목록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCC0101.do" target="_blank"><%=pathUrl%>/sample/page/_EDCC0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>Subject Visit(View 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCC0102.do" target="_blank"><%=pathUrl%>/sample/page/_EDCC0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>Subject Visit(List 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCC0103.do" target="_blank"><%=pathUrl%>/sample/page/_EDCC0103.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>Patient 등록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCC0104.do" target="_blank"><%=pathUrl%>/sample/page/_EDCC0104.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>eSign(Visit 목록탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCE0101.do" target="_blank"><%=pathUrl%>/sample/page/_EDCE0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>eSign(subject 목록탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCE0102.do" target="_blank"><%=pathUrl%>/sample/page/_EDCE0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>팝업(일괄 전자서명)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCE0103.do" target="_blank"><%=pathUrl%>/sample/page/_EDCE0103.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>

				<tr class="b1">
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - 유해사례(MEDICAL HISTORY 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBC0202.do" target="_blank"><%=pathUrl%>/sample/page/_SDBC0202.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - 유해사례(DRUG HISTORY 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBC0203.do" target="_blank"><%=pathUrl%>/sample/page/_SDBC0203.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - 유해사례(AE 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBC0204.do" target="_blank"><%=pathUrl%>/sample/page/_SDBC0204.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - 유해사례(TEST 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBC0205.do" target="_blank"><%=pathUrl%>/sample/page/_SDBC0205.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>유해정보등록 - 유해사례(DRUG 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBC0206.do" target="_blank"><%=pathUrl%>/sample/page/_SDBC0206.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>

				
				
				<tr class="b1">
					<td></td>
					<td class="center">CTMS</td>
					<td>개시방문 준비기록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0201.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0201.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>개시방문 보고서</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0202.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0202.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>방문 보고서(연구기관 방문 보고서)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0302.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0302.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>방문 후속조치 보고서</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0303.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0303.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>모니터링 계획 관리(모니터링 계획)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0401.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0401.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>모니터링 보고서</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0402.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0402.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>연구자 적합성 보고서</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0501.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0501.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>시험 전 방문보고서</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0701.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0701.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>시험 책임자 적합성 점검표</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0801.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0801.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>개시방문 준비기록(개시미팅준비기록)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0901.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0901.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>개시방문 보고서(시험 개시방문 보고서)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ0902.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ0902.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>모니터링 계획 관리(모니터링 방문 계획)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ1001.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ1001.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>모니터링 보고서(모니터링 방문 보고서)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ1002.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ1002.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>시험종료방문보고서</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ1101.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ1101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>Note to File(내용확인서)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ1201.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ1201.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>일탈로그(계획서 일탈 보고서)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ1401.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ1401.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">CTMS</td>
					<td>연구자 순응도 평가서</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_CTMZ1501.do" target="_blank"><%=pathUrl%>/sample/page/_CTMZ1501.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">EDC</td>
					<td>Query List(예비탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCD0101.do" target="_blank"><%=pathUrl%>/sample/page/_EDCD0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>Query List(오픈탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCD0102.do" target="_blank"><%=pathUrl%>/sample/page/_EDCD0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">EDC</td>
					<td>Query 업로드(팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCD0105.do" target="_blank"><%=pathUrl%>/sample/page/_EDCD0105.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">메일용</td>
					<td>보고서 정보</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/mail_02.do" target="_blank"><%=pathUrl%>/sample/page/mail_02.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				
				<tr class="b1">
					<td></td>
					<td class="center">SDB</td>
					<td>국외사례 - 국외사례리스트(레포트 정보 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBG0102.do" target="_blank"><%=pathUrl%>/sample/page/_SDBG0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>국외사례 - 국외사례리스트(환자정보 탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBG0103.do" target="_blank"><%=pathUrl%>/sample/page/_SDBG0103.do</a></td>
					<td style="text-align:center;">OK</td>
					<td>이상한 달력 추가</td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>국외사례 - 국외사례리스트(국외유해사례/Drug 팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBG0104.do" target="_blank"><%=pathUrl%>/sample/page/_SDBG0104.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				
				
				<tr class="b1">
					<td></td>
					<td class="center">IWRS</td>
					<td>과제목록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0101.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(목록탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0102.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(변경사유팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0103.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0103.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(Randomization탭)- 목록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0104.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0104.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(Randomization탭)- 무작위배정코드탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0105.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0105.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(Randomization탭)- 추가무작위배정코드탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0106.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0106.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(Randomization탭)- 테스트코드탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0107.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0107.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>무작위배정코드 배정표 팝업(Diagram 보기)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0108.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0108.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>Stratified 설정(팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0109.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0109.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(IP탭)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0110.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0110.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(IP탭)- IP타입탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0111.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0111.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
<%--  				
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(IP탭)- IP코드탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0111a.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0111a.do</a></td>
					<td style="text-align:center;">논의중..</td>
					<td></td>
				</tr>
 --%>

				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(IP탭)- 추가IP코드탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0112.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0112.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(IP탭)- 테스트코드탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0113.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0113.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td><strike>IP코드탭 생성 결과(팝업)</strike></td>
					<td class="filename"><strike><a href="<%=pathUrl%>/sample/page/_IWRG0114.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0114.do</a></strike></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(화면디자인탭)- 방문설정탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0115.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0115.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td><strike>IWRS 디자이너(화면디자인탭)- 불출/반납 설정탭</strike></td>
					<td class="filename"><strike><a href="<%=pathUrl%>/sample/page/_IWRG0116.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0116.do</a></strike></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>IWRS 디자이너(화면디자인탭)- IP 상세 정보 설정탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0117.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0117.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>Factor Mapping</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0201.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0201.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>피험자 배정 로그 (Covariate)- 과제 목록 탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0301.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0301.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>피험자 배정 로그 (Covariate)- 피험자 배정 로그 탭</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0302.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0302.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>공장재고 등록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0401.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0401.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">IWRS</td>
					<td>공장재고 설정(팝업)</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_IWRG0402.do" target="_blank"><%=pathUrl%>/sample/page/_IWRG0402.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">DMC</td>
					<td>Data Export</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCL0201.do" target="_blank"><%=pathUrl%>/sample/page/_EDCL0201.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">DMC</td>
					<td>Data Export</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_EDCL0202.do" target="_blank"><%=pathUrl%>/sample/page/_EDCL0202.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">COM</td>
					<td>위탁코드목록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMK0101.do" target="_blank"><%=pathUrl%>/sample/page/_COMK0101.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">COM</td>
					<td>위탁코드등록</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_COMK0102.do" target="_blank"><%=pathUrl%>/sample/page/_COMK0102.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr class="b1">
					<td></td>
					<td class="center">SDB</td>
					<td>대량 Upload</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBC0301.do" target="_blank"><%=pathUrl%>/sample/page/_SDBC0301.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class="center">SDB</td>
					<td>보고서팝업</td>
					<td class="filename"><a href="<%=pathUrl%>/sample/page/_SDBC0211.do" target="_blank"><%=pathUrl%>/sample/page/_SDBC0211.do</a></td>
					<td style="text-align:center;">OK</td>
					<td></td>
				</tr>

			</tbody>
		</table>
	</div>
</div>




<script>
$(function(){
	$('.table_map tbody tr td:first-child').each(function(){
		$(this).text($(this).closest('tr').index() + 1);
	});


	$('.table_map tbody td a').click(function(){
		$(this).parents('tr').css({"background":"#76ff66"});
		$('.table_map tbody td a').not(this).parents('tr').css({"background":"none"});
	});

});

	
</script>
</body>
</html>
