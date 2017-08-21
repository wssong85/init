<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/com/common.do" flush="false" />

<title>과제등록</title>

<script type="text/javascript">
	$(document).ready(function() {
		var TASK_SN = $("#frm_main #TASK_SN").val();
		var CRUD = $("#frm_main #CRUD").val();
		if ((TASK_SN == "" && CRUD == "C") || (TASK_SN != "" && CRUD == "U")) {
			mkSetDatePickerYYMMDD("#RSRCH_BEGIN, #RSRCH_END");
			var date = "${ detail.RSRCH_BEGIN }";
			$("#RSRCH_BEGIN").val(date.substring(0, 10));
			date = "${ detail.RSRCH_END }";
			$("#RSRCH_END").val("${ detail.RSRCH_END }".substring(0, 10));
			mkSetDatePickerYYMMDD("#REJDGE_BEGIN, #REJDGE_END");
			date = "${ detail.REJDGE_BEGIN }";
			$("#REJDGE_BEGIN").val("${ detail.REJDGE_BEGIN }".substring(0, 10));
			date = "${ detail.REJDGE_END }";
			$("#REJDGE_END").val("${ detail.REJDGE_END }".substring(0, 10));
			mkSetDatePickerYYMMDD("#PRMISN_DE");
			date = "${ detail.PRMISN_DE }";
			$("#PRMISN_DE").val("${ detail.PRMISN_DE }".substring(0, 10));

			$('input[name=PHASE_CODE]').click(function() {
				if ($(this).val() == "05") {
					$("#frm_main #PHASE_ETC_NM").prop("disabled", false);
				} else {
					$("#frm_main #PHASE_ETC_NM").val("");
					$("#frm_main #PHASE_ETC_NM").prop("disabled", true);
				}
			});

			$('input[name=IWRS_USE_AT]').click(function() {
				if ($('#IWRS_USE_AT').is(":checked")) {
					$("#frm_main input[name=BLIND_CODE]").prop("disabled", false);
				} else {
					$("#frm_main input[name=BLIND_CODE][value=03]").prop("checked", true);
					$("#frm_main input[name=BLIND_CODE]").prop("disabled", true);
				}
			});

			changeTaskType($("#frm_main input[name=TASK_TY_CODE]:checked").val());

			$('input[name=TASK_TY_CODE]').click(function() {
				changeTaskType($(this).val());
				if ($(this).val() == "01") {
					$("#frm_main input[name=PHASE_CODE]").prop("disabled", false);
					if ($("#frm_main input[name=PHASE_CODE]:checked").val() == "05") {
						$("#frm_main #PHASE_ETC_NM").prop("disabled", false);
					} else {
						$("#frm_main #PHASE_ETC_NM").prop("disabled", true);
					}
				} else {
					$("#frm_main input[name=PHASE_CODE]").prop("checked", false);
					$("#frm_main input[name=PHASE_CODE]").prop("disabled", true);
					$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
					$("#frm_main #PHASE_ETC_NM").val("");
				}
			});

			if ($("#CRUD").val() == "U") {
				editMode(1);
			} else {
				//editMode(2);
				$("#btn_edit").hide();
				$("#frm_main input[name=BLIND_CODE][value=03]").prop("checked", true);
				$("#frm_main input[name=BLIND_CODE]").prop("disabled", true);
				$("#frm_main input[name=PHASE_CODE][value=1]").prop("checked", true);
				$("#frm_main input[name=PHASE_CODE]").prop("disabled", false);
				$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
			}
		} else {
			alert("과제선택필요");
			location.replace("./_EDCK0101.do");
		}
	});

	function changeTaskType(value) {
		if (value == "03") {
			$("#tr_nis input").val("");
			$("#tr_product").show();
			$("#tr_nis").hide();
			$("#tr_pms").show();
		} else if (value == "02") {
			$("#tr_pms input").val("");
			$("#tr_product").show();
			$("#tr_pms").hide();
			$("#tr_nis").show();
		} else {
			$("#tr_product input").val("");
			$("#tr_product").hide();
			$("#tr_pms").hide();
			$("#tr_nis").hide();
		}
	}

	function saveGrid() {
		if($("#frm_main #hd_task_no").val()){
			
		}
		
		if ($("#frm_main #hd_task_no").val() != $("#frm_main #TASK_NO").val()) {
			alert("중복확인필요");
		} else {
			var param = $("#frm_main").serialize();
			$.ajax({
				url : './insertBaseInfo.do',
				data : param,
				type : 'post',
				//async : false,
				//contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						if (data.TASK_SN != null) {
							$("#frm_main #TASK_SN").val(data.TASK_SN);
							$("#frm_main #CRUD").val("U");
						}
						$("#frm_main").prop({
							action : './EDCK0102.do',
							method : 'post'
						}).submit();
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		}
	}

	function selectCheckTaskNo() {
		if ($("#frm_main #hd_task_no").val() == $("#frm_main #TASK_NO").val()) {
			alert("사용가능");
		} else {
			var param = $("#frm_main").serialize();
			$.ajax({
				url : './selectCheckTaskNo.do',
				data : param,
				type : 'post',
				//contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						if (data.result.COUNT == 0) {
							$("#frm_main #hd_task_no").val($("#frm_main #TASK_NO").val());
							alert("사용가능");
						} else {
							alert("이미존재");
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
	}
	function editMode(c) {
		if (c == 1) {
			mkDisabled(); //컨트롤 비활성화
			$("button").hide();
			$("#btn_edit").show();
		} else {
			mkEnabled(); //컨트롤 활성화
			$("button").show();
			$("#btn_edit").hide();
			if ($("#frm_main input[name=PHASE_CODE]:checked").val() == "05") {
				$("#frm_main #PHASE_ETC_NM").prop("disabled", false);
			} else {
				$("#frm_main #PHASE_ETC_NM").prop("disabled", true);
			}

			if (!$("#frm_main input[name=TASK_TY_CODE]:checked").val() == "01") {
				$("#frm_main input[name=PHASE_CODE]").prop("disabled", true);
				$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
			} else {
				$("#frm_main input[name=PHASE_CODE]").prop("checked", false);
				$("#frm_main input[name=PHASE_CODE]").prop("disabled", true);
				$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
			}
			if ($('#IWRS_USE_AT').is(":checked")) {
				$("#frm_main input[name=BLIND_CODE]").prop("disabled", false);
			} else {
				$("#frm_main input[name=BLIND_CODE][value=03]").prop("checked", true);
				$("#frm_main input[name=BLIND_CODE]").prop("disabled", true);
			}
		}
	}
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0102&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0102&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>과제등록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>과제관리</li>
						<li>과제등록</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">

				<div class="conBoxInner" style="min-height:700px;">

	            	<articla class="conTitBox">
	            		<h5>Study Info</h5>
	            	</articla>
	
	            	<div class="conTitBtnR">
						<button type="button" id="btn_edit" onclick="editMode(2);">수정</button>
						<button type="button" onclick="saveGrid();" able>저장</button>
						<button type="button" onclick="fn_goList('EDCK0101');" able>목록</button>
	            	</div>


					<form id="frm_main" name="frm_main">
					<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ detail.TASK_SN }">
					<input type="hidden" id="CRUD" name="CRUD" value="${ detail.CRUD }">
						
						<article class="mgT16">
						
						
							<table class="tb001">
								<colgroup>
									<col width="120px" />
									<col width="" />
									<col width="120px" />
									<col width="50%" />
								</colgroup>
								<tbody>
									<tr>
										<th>과제번호</th>
										<td colspan="3">
											<input type="text" id="TASK_NO" name="TASK_NO" value="${ detail.TASK_NO }" able valireqire>
											<input type="hidden" id="hd_task_no" name="hd_task_no" value="${ detail.TASK_NO }">
											<button type="button" onclick="selectCheckTaskNo();" able>중복확인</button>
										</td>
									</tr>
									<tr>
										<th>과제명</th>
										<td colspan="3">
											<input type="text" style="width:60%;" id="TASK_NM" name="TASK_NM" value="${ detail.TASK_NM }" able valireqire>
										</td>
									</tr>
									<tr>
										<th>과제종류</th>
										<td>
											<c:set var="TASK_TY_CODE" value="${ detail.TASK_TY_CODE }" />
											<c:if test="${empty TASK_TY_CODE }">
												<c:set var="TASK_TY_CODE" value="01" />
											</c:if>
											<c:forEach items="${ EDC017 }" var="list" varStatus="status">
												<input type="radio" id="TASK_TY_CODE_${ status.count }" name="TASK_TY_CODE" value="${ list.CODE }" <c:if test="${ list.CODE == TASK_TY_CODE}">checked="checked"</c:if> able>
												<label for="TASK_TY_CODE_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
											</c:forEach>
										</td>
										<th>Phase</th>
										<td>
											<c:set var="PHASE_CODE" value="${ detail.PHASE_CODE }" />
											<c:forEach items="${ EDC015 }" var="list" varStatus="status">
												<input type="radio" id="PHASE_CODE_${ status.count }" name="PHASE_CODE" value="${ list.CODE }" <c:if test="${ list.CODE == PHASE_CODE}">checked="checked"</c:if> able>
												<label for="PHASE_CODE_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
												</label>
											</c:forEach>
											<input type="text" id="PHASE_ETC_NM" name="PHASE_ETC_NM" value="${ detail.PHASE_ETC_NM }" able>
										</td>
									</tr>
									<tr>
										<th>IWRS</th>
										<td>
											<input type="checkbox" name="IWRS_USE_AT" id="IWRS_USE_AT" value="Y" <c:if test="${ detail.IWRS_USE_AT == 'Y' }">checked="checked"</c:if> able>
											<label for="IWRS_USE_AT" class="chcLab"><span>사용</span></label>
										</td>
										<th>Blinding</th>
										<td>
											<c:set var="BLIND_CODE" value="${ detail.BLIND_CODE }" />
											<c:if test="${empty BLIND_CODE }">
												<c:set var="BLIND_CODE" value="01" />
											</c:if>
											<c:forEach items="${ EDC030 }" var="list" varStatus="status">
												<input type="radio" id="BLIND_CODE_${ status.count }" name="BLIND_CODE" value="${ list.CODE }" <c:if test="${ list.CODE == BLIND_CODE}">checked="checked"</c:if> able>
												<label for="BLIND_CODE_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
												</label>
											</c:forEach>
										</td>
									</tr>
									<tr>
										<th>설명</th>
										<td colspan="3" style="padding-top:5px; ">
											<textarea style="width: 60%;" id="TASK_DC" name="TASK_DC" able>${ detail.TASK_DC }</textarea>
										</td>
									</tr>
									<tr>
										<th>계약서 양식</th>
										<td>
											<input type="file" id="CTRTC_FILE_SN" name="CTRTC_FILE_SN" able>
										</td>
										<th>Domain URL</th>
										<td>
											<input type="text" style="width:90%;" id="DOMN_URL" name="DOMN_URL" value="${ DOMN_URL }" able>
										</td>
									</tr>
									<tr>
										<th>대상자수</th>
										<td>
											<input type="text" style="width:30%;" id="TRGTER_CO" name="TRGTER_CO" value="${ detail.TRGTER_CO }" able>
										</td>
										<th>대상질환</th>
										<td>
											<input type="text" id="TRGET_DISS" name="TRGET_DISS" value="${ detail.TRGET_DISS }" able>
										</td>
									</tr>
									<tr>
										<th>연구기관수</th>
										<td>
											<input type="text" style="width:30%;" id="RRCS_CO" name="RRCS_CO" value="${ detail.RRCS_CO }" able>
										</td>
										<th>연구기간</th>
										<td>
											<div class="dateBox">
												<input type="text" id="RSRCH_BEGIN" name="RSRCH_BEGIN" value="${ detail.RSRCH_BEGIN }" able>
											</div>
											~
											<div class="dateBox">
												<input type="text" id="RSRCH_END" name="RSRCH_END" value="${ detail.RSRCH_END }" able>
											</div>
										</td>
									</tr>
									<tr>
										<th>연구목적</th>
										<td colspan="3">
											<input type="text" style="width:60%;" id="RSRCH_PURPS" name="RSRCH_PURPS" value="${ detail.RSRCH_PURPS }" able>
										</td>
									</tr>
									<tr>
										<th>시험책임자</th>
										<td>
											<input type="text" id="EXPRRSPNBER" name="EXPRRSPNBER" value="${ detail.EXPRRSPNBER }" able>
											<button type="button" class="oneBtn">
												<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png' />" alt="검색" able>
											</button>
										</td>
										<th>병원명</th>
										<td>
											<input type="text" style="width:80%;" id="HSPTL_INSTT_CODE" name="HSPTL_INSTT_CODE" value="${ detail.HSPTL_INSTT_CODE }" disabled="disabled">
										</td>
									</tr>
									</tr>
									<tr id="tr_product">
										<th>제품명</th>
										<td colspan="3">
											<input type="text" style="width:60%;" id="PRODUCT_NM" name="PRODUCT_NM" value="${ PRODUCT_NM }" able>
										</td>
									</tr>
									<tr id="tr_pms">
										<th>허가일</th>
										<td>
											<div class="dateBox">
												<input type="text" id="PRMISN_DE" name="PRMISN_DE" value="${ detail.PRMISN_DE }" able>
											</div>
										</td>
										<th>재심사기간</th>
										<td>
											<div class="dateBox">
												<input type="text" id="REJDGE_BEGIN" name="REJDGE_BEGIN" value="${ detail.REJDGE_BEGIN }" able>
											</div>
											~
											<div class="dateBox">
												<input type="text" id="REJDGE_END" name="REJDGE_END" value="${ detail.REJDGE_END }" able>
											</div>
										</td>
									</tr>
									<tr id="tr_nis">
										<th>스터디명</th>
										<td colspan="3">
											<input type="text" style="width:30%;" id="STUDY_NM" name="STUDY_NM" value="${ detail.STUDY_NM }" able>
										</td>
									</tr>

								</tbody>
							</table>


						</article>
                      </form>
	
	
	



				</div>
            </section>


		
		






		</div>
	</section>
</div>
</body>
</html>