<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>





<script>

$(document).ready(function() {
  mkSetDatePickerYYMMDD("#day_01");
});

</script>


</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTML0101&UPPER_MENU_ID=CTML" charEncoding="utf-8"/>

						
	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>연구자 순응도</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>연구자 순응도</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">




					<article>
						<h5>연구자 순응도 평가서</h5>
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
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>과제명 Title</th>
								<td>
									<input type="text" id="" style="width:100%;" value="CJ_TST_P01">
								</td>
								<th>실시일 Date of contact</th>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>연구기관 Site Name</th>
								<td>
									<input type="text" id="" style="width:100%;" value="한사랑의원">
								</td>
								<th>연구자명 PI</th>
								<td>
									<input type="text" id="" style="width:100%;" value="신홍식">
								</td>
							</tr>
							<tr>
								<th>필수항목 점수 Critical Item Score</th>
								<td>
									<input type="text" id="" style="width:100%;" value="50">
								</td>
								<th>선택항목 점수 Optional Item Score</th>
								<td>
									<input type="text" id="" style="width:100%;" value="17.5">
								</td>
							</tr>
							<tr>
								<th>총점 Total Score</th>
								<td>
									<input type="text" id="" style="width:100%;" value="67.5">
								</td>
								<th>평가자 CRA or CRM</th>
								<td>
									<input type="text" id="" style="width:100%;" value="정한나">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>

					<table class="tb001">
						<colgroup>
							<col width="130px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody>
							<tr>
								<th colspan="2">A. 필수항목</th>
								<th>Yes</th>
								<th>No</th>
							</tr>
							<tr>
								<th>연구시작전</th>
								<td>1.해당 적응증을 가진 조사시작 전 최근 3개월간의 내원환자의 수가 목표조사대상자수 이상임</td>
								<td><input type="radio" id="a12" name="a1"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr>
								<th rowspan="4">연구중</th>
								<td>1.병용약물, 병력 정보가 충실하게 기재되어 있어 추가적인 정보입력을 요청하는 전체 쿼리가 발생되지 않음</td>
								<td><input type="radio" id="a22" name="a2"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2.등록된 조사대상자가 선정기준에 부합함</td>
								<td><input type="radio" id="a32" name="a3"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3.발생된 AE 또는 SAE 가 1건 이상 기재됨</td>
								<td><input type="radio" id="a42" name="a4"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr>
								<td>4.CRF 작성시 연구자가 직접 작성함</td>
								<td><input type="radio" id="a52" name="a5"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr>
								<th rowspan="3">연구종료후</th>
								<td>1.쿼리 발행 후 1개월 이내에 쿼리를 해결함</td>
								<td><input type="radio" id="a62" name="a6"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6"><label for="a63" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2.기존에 기재된 정보의 임의 삭제 없이 발행된 쿼리 내용에 따라 추가 정보를 입력함</td>
								<td><input type="radio" id="a72" name="a7"><label for="a72" class="raLab"></label></td>
								<td><input type="radio" id="a73" name="a7"><label for="a73" class="raLab"></label></td>
							</tr>
							<tr>
								<td>3.해외연수, 조기종료, 중단 등 사유 없이 끝까지 연구를 수행하여 완료함</td>
								<td><input type="radio" id="a82" name="a8"><label for="a82" class="raLab"></label></td>
								<td><input type="radio" id="a83" name="a8"><label for="a83" class="raLab"></label></td>
							</tr>
							<tr>
								<th rowspan="2">클레임</th>
								<td>1.쿼리 발행 및 해결에 대한 클레임 발생 없음</td>
								<td><input type="radio" id="a92" name="a9"><label for="a92" class="raLab"></label></td>
								<td><input type="radio" id="a93" name="a9"><label for="a93" class="raLab"></label></td>
							</tr>
							<tr>
								<td>2.연구비와 관련하여 클레임 발생 없음</td>
								<td><input type="radio" id="a102" name="a10"><label for="a102" class="raLab"></label></td>
								<td><input type="radio" id="a103" name="a10"><label for="a103" class="raLab"></label></td>
							</tr>
							<tr>
								<th colspan="4">
									<div style="margin-bottom:5px;">* 문항당 5점씩 50점 만점</div>
									* 30점 미만 or 모든 카테고리에 NO 포함 시 선택항목 체크 불가
								</th>
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
								<th>기타 특이사항</th>
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
							<col width="40px" />
						</colgroup>
						<tbody>
							<tr>
								<th>B. 필수항목</th>
								<th>Yes</th>
							</tr>
							<tr>
								<td>1. 해당 적응증을 가진 조사시작 전 최근 3개월간의 내원환자의 수가 목표조사대상자수 이상임</td>
								<td><input type="checkbox" name="" id="b1" ><label for="b1" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>2. 요청 서류를 1주일 이내로 제공함</td>
								<td><input type="checkbox" name="" id="b2" ><label for="b2" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>3. 계약서 원본 또는 사본을 보관함</td>
								<td><input type="checkbox" name="" id="b3" ><label for="b3" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>4. 보조인력이 있음</td>
								<td><input type="checkbox" name="" id="b4" ><label for="b4" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>5. CRF 작성 과정에서 문의사항에 대해 문의함</td>
								<td><input type="checkbox" name="" id="b5" ><label for="b5" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>6. 계약 체결 이후 1개월 이내에 조사대상자 등록을 1건 이상 진행함</td>
								<td><input type="checkbox" name="" id="b6" ><label for="b6" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>7. 연구자가 먼저 방문을 요청함</td>
								<td><input type="checkbox" name="" id="b7" ><label for="b7" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>8. 연구자 방문 시 커뮤니케이션이 가능한 긍정적인 환경을 조성함</td>
								<td><input type="checkbox" name="" id="b8" ><label for="b8" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>9. 연구 설명 시(연구디자인 및 조사대상자 선정기준, 또는 e-CRF 작성법) 시 1회 이상 질문함</td>
								<td><input type="checkbox" name="" id="b9" ><label for="b9" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>10. 연구계획서 등 연구 관련 문서를 보관함</td>
								<td><input type="checkbox" name="" id="b10" ><label for="b10" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>11. 연구 설명 시 MR과 연관지어 연구를 받아들이지 않고 독립적인 연구로 인지함</td>
								<td><input type="checkbox" name="" id="b11" ><label for="b11" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>12. SAE 발생 시 보고서를 정해진 기한내에 유해사례 상세내용을 포함하여 작성함</td>
								<td><input type="checkbox" name="" id="b12" ><label for="b12" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>13. SAE 보고서 작성 시 추가적인 수정요청에 대해 클레임 발생 없음</td>
								<td><input type="checkbox" name="" id="b13" ><label for="b13" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>14. 연구 진행 시 내부적으로 작성해야 하는 연구비 정산서 등과 같은 IRB 서류 작성을 요청하지 않음</td>
								<td><input type="checkbox" name="" id="b14" ><label for="b14" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>15. 연구 참여 경험이 2회 이상 있음</td>
								<td><input type="checkbox" name="" id="b15" ><label for="b15" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>16. 연구자의 직통연락처(내선번호 or 휴대폰번호 or 이메일주소)를 확보함</td>
								<td><input type="checkbox" name="" id="b16" ><label for="b16" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>17. 연구기간 중 컴퓨터 사용에 대한 어려움을 호소하지 않음</td>
								<td><input type="checkbox" name="" id="b17" ><label for="b17" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>18. F/U loss가 목표조사대상자수의 10% 이하임</td>
								<td><input type="checkbox" name="" id="b18" ><label for="b18" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>19. 종료 요청시점까지 계약일 이후에 환자 등록이 가능함을 인지하여 이에 대한 클레임 발생 없음</td>
								<td><input type="checkbox" name="" id="b19" ><label for="b19" class="chcLab"></label></td>
							</tr>
							<tr>
								<td>20. AE가 목표조사대상자수의 5% 이상 기재됨</td>
								<td><input type="checkbox" name="" id="b20" ><label for="b20" class="chcLab"></label></td>
							</tr>
							<tr>
								<th colspan="2">
									<div style="margin-bottom:5px;">* 선택항목은 선택 사항이므로 해당하지 않는 문항은 작성 하지 않으셔도 됩니다.</div>
									* 각 2.5점씩 추가점수를 부여
								</th>
							</tr>
						</tbody>
					</table>



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