<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>

<style>
.view_block_01{ display: block; border:1px solid red; margin-bottom:30px;}
.hide_block_01{ display: none;}

</style>


<script type="text/javascript">





</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>IRWS 디자이너</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>과제관리</li>
	                        <li>IRWS 디자이너</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner" style="min-height:900px;">
					
						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="" class="tab_menu">목록</li>
								<li id="" class="tab_menu">Randomization</li>
								<li id="" class="port_back tab_menu">IP</li>
								<li id="" class="tab_menu">화면디자인</li>
							</ul>
						</div>


						<article style="position:relative;">
							<h5>CJ 연구과제8</h5>
							<div class="tab_small">
								<ul>
									<li id="" class="tab_menu_s">IP 타입</li>
									<li id="" class="port_back tab_menu_s">IP 코드</li>
									<li id="" class="tab_menu_s">추가IP 코드</li>
									<li id="" class="tab_menu_s">테스트 코드</li>
								</ul>
							</div>
						</article>
						

						<div class="mgT20">
							<span style="font-family:'NanumGothicBold'; position:relative; top:-3px;">코드생성방법 :</span>
							&nbsp;
							<input type="radio" id="a11" name="a1"><label for="a11" class="raLab"><span>시스템</span></label>
							&nbsp;
							<input type="radio" id="a12" name="a1" checked="checked"><label for="a12" class="raLab"><span>위탁</span></label>
						</div>





						<!-- 위탁 radio -->
						<div class="view_block_01">
							<div class="mgT5" style="height:30px;">
								<div class="conTitBtnL">
									<span style="font-family:'NanumGothicBold'; position:relative; top:-3px;">배정시점 설정 :</span>
									&nbsp;
									<input type="checkbox" name="" id="b1" ><label for="b1" class="chcLab"><span>V1</span></label>
									&nbsp;
									<input type="checkbox" name="" id="b2" ><label for="b2" class="chcLab"><span>V2</span></label>
									&nbsp;
									<input type="checkbox" name="" id="b3" ><label for="b3" class="chcLab"><span>V3</span></label>
									&nbsp;
									<input type="checkbox" name="" id="b4" ><label for="b4" class="chcLab"><span>V4</span></label>
									&nbsp;
									<input type="checkbox" name="" id="b5" ><label for="b5" class="chcLab"><span>V5</span></label>
									&nbsp;
									<input type="checkbox" name="" id="b6" ><label for="b6" class="chcLab"><span>V6</span></label>
								</div>
								<div class="conTitBtnR">
									<input type="button" value="양식다운로드">
									<input type="button" value="업로드">
									<input type="button" value="적용">
								</div>
							</div>
							<div class="mgT5">
								<table class="tb001">
									<colgroup>
										<col width="15%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th rowspan="2">파일 업로드</th>
											<td>
												<span style="font-family:'NanumGothicBold'; ">Real : </span>
								 				<div class="fileInputArea" style="width:94%;">
									 				<input type="text" id="fileName" readonly="readonly" style="width:86%;">
									 				<input type="button" value="파일 찾기" class="fileInputBtn" />
									 				<input type="file" class="fileIuputHid" style="width:100%;">
								 				</div>
											</td>
										</tr>
										<tr>
											<td>
												<span style="font-family:'NanumGothicBold'; ">Test : </span>
								 				<div class="fileInputArea" style="width:94%;">
									 				<input type="text" id="fileName" readonly="readonly" style="width:86%;">
									 				<input type="button" value="파일 찾기" class="fileInputBtn" />
									 				<input type="file" class="fileIuputHid" style="width:100%;">
								 				</div>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div style="height:10px;"></div>
								
								<table class="tb001">
									<colgroup>
										<col width="15%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th rowspan="2">유효성 검사 결과</th>
											<td>
												<span style="font-family:'NanumGothicBold'; ">Real Code : </span>
								 				<span style="margin-right:20px;">Null값 : 3개</span>
								 				<span style="margin-right:20px;">중복값 : 3개</span>
								 				<span style="margin-right:20px;">필수값 : 3개</span>
											</td>
										</tr>
										<tr>
											<td>
												<span style="font-family:'NanumGothicBold'; ">Test Code : </span>
								 				<span style="margin-right:20px;">Null값 : 3개</span>
								 				<span style="margin-right:20px;">중복값 : 3개</span>
								 				<span style="margin-right:20px;">필수값 : 3개</span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						
						



						<!-- 시스템 radio -->
						<div class="view_block_01">
							디자인 논의중...


			
						</div>
							










					</div>
				</section>
			</div>
		</section>
</div>
</body>
</html>