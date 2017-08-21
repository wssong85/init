<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />


<title></title>
<script type="text/javascript">
	var rsltData;
	var frzSttCd;
	_user = {
			'USER_ID': '${loginMap.USER_ID}'
		};

	var param = new Object();
	param.TASK_SN = ${TASK_SN};

	$(document).ready(function() {
		$.ajax({
			url : '/edc/k04/selectTaskInfo.do',
			data : param,
			type : 'post',
			//contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus, jqXHR) {
				console.log("data.result : "+data.result);
				if (data.success) {
					rsltData = data.result;
					if(rsltData.length > 0){
						console.log("TASK_SN : "+rsltData[0].TASK_SN);
						$("#frm_main #TASK_SN").val(rsltData[0].TASK_SN);
				 		$("#frm_main #FREEZING_STTUS_CODE").val(rsltData[0].FREEZING_STTUS_CODE);
				 		$("#frm_main #REQUST_NO").val(rsltData[0].REQUST_NO);
				 		$("#frm_main #SDV_FNSH_CHK").val(rsltData[0].SDV_FNSH_CHK);
						$("#frm_main #TASK_NO").text(rsltData[0].TASK_NO);
				 		$("#frm_main #TASK_NM").text(rsltData[0].TASK_NM);
				 		$("#frm_main #FREEZING_STTUS_NM").text(rsltData[0].FREEZING_STTUS_NM);
				 		$("#frm_main #SUBJECT_CNT").text(rsltData[0].SUBJECT_CNT);
				 		$("#frm_main #ELTSGN_SUBJECT_CNT").text(rsltData[0].ELTSGN_SUBJECT_CNT);
				 		$("#frm_main #TOTAL_CRF_PAGE").text(rsltData[0].TOTAL_CRF_PAGE);
				 		$("#frm_main #SAVE_CRF_PAGE").text(rsltData[0].SAVE_CRF_PAGE);
				 		$("#frm_main #TOTAL_OPEN_QUERY").text(rsltData[0].TOTAL_OPEN_QUERY);
				 		$("#frm_main #TOTAL_RESPONSE_QUERY").text(rsltData[0].TOTAL_RESPONSE_QUERY);
				 		
				 		frzSttCd = $("#frm_main #FREEZING_STTUS_CODE").val();
					}else{
						alert("데이터가 없습니다.");
					}
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
		
		$("#btnTmpFrz").click(function(){	//Temp Freezing
			if(frzSttCd == "03"){
				mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
					'REQUST_NM': 'Temp Freezing',
					'callbackFunction': 'fn_updateRequstNo'
				}, 1);
			}else{
				alert("Temp Freezing 가능한 상태가 아닙니다.");
				return false;
			}
		});
		
		$("#btnTmpFrzCnl").click(function(){	//Temp Freezing 해제
			if(frzSttCd == "02"){
				mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
					'REQUST_NM': 'Temp Freezing 해제',
					'callbackFunction': 'fn_updateRequstNo'
				}, 1);
			}else{
				alert("Temp Freezing 해제 가능한 상태가 아닙니다.");
				return false;
			}
		});

		$("#btnDbFrz").click(function(){		//DB Freezing 요청
			console.log("sdv_fnsh_chk : "+ $("#frm_main #SDV_FNSH_CHK").val());
			if(frzSttCd == "03" && $("#frm_main #SDV_FNSH_CHK").val() == 0 ){
				mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
					'REQUST_NM': 'DB Freezing 요청',
					'callbackFunction': 'fn_updateRequstNo'
				}, 1);
			}else{
				alert("Temp Freezing 해제 가능한 상태가 아닙니다.");
				return false;
			}
		});

		$("#btnDbFrzCnl").click(function(){		//DB Freezing 해제 요청
			if(frzSttCd == "01"){
				mkLayerPopupOpen('/com/z09/popupCOMZ0901.do', {
					'REQUST_NM': 'DB Freezing 해제 요청',
					'callbackFunction': 'fn_updateRequstNo'
				}, 1);
			}else{
				alert("Temp Freezing 해제 가능한 상태가 아닙니다.");
				return false;
			}
		});

		$("#btnSncCnfrm").click(function(){		//승인
			var tmpRequstNo = $("#frm_main #REQUST_NO").val();
		
			if(tmpRequstNo == null){
				alert("진행중인 결제가 없습니다.");
			}else{
				console.log("REQUST_NO : "+tmpRequstNo);
				mkLayerPopupOpen('/com/z09/popupCOMZ0903.do', {
					'REQUST_NO':tmpRequstNo,
					'callbackFunction': 'fn_cnfrm'
				});
			}
		});

		$("#btnGotoEDCK0401").click(function(){// 과제목록 화면 이동
			$("#frm_main").attr({
				action : './EDCK0401.do',
				method : 'post'
			}).submit();
		});
	});

	function fn_updateRequstNo(v) {		//결재 상신 후 requst_no를 edc_cr_Task table에 저장
		console.log('RequstNo : ' + v);
		var paramData = {"TASK_SN":$("#frm_main #TASK_SN").val(), "REQUST_NO":v};
		
		$.ajax({
			url : '/edc/k04/updateEdcCrTaskReqNo.do',
			type: 'post',
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(paramData),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
				} else {
					alert(data.message);
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	}
	
	function fn_cnfrm(v){		//결재 후 결과가 승인된 건에 대해 edc_cr_task의 freezing_sttus_code update
		console.log("requst_no : "+v);
		param = {	"TASK_SN": $("#frm_main #TASK_SN").val(),
					"UPDATE_ID": _user.USER_ID,
					"REQUST_NO": v
				};
		$.ajax({
			url : '/edc/k04/updateEdcCrTaskFrzStt.do',
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(paramData),
			success : function(data, textStatus, jqXHR){
				if(data.success){
					
				}else{
					alert(data.message);
				}				
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0404&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0404&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${ progrmMap.MENU_NM }</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>${ progrmMap.UPPER_MENU_NM }</li>
							<li>${ progrmMap.MENU_NM }</li>
						</ul>
					</nav>
				</article>


				<section class="conBox100 conBox">
					<div class="conBoxInner">

						<!--tab 설정 -->
						<div id="tab" class="tab tab01">
							<ul>
								<li id="tab_menu1" class="tab_menu" onclick="fn_moveTab('EDCK0402');"><spring:message code="edc.tab.SITE" /></li>
								<li id="tab_menu2" class="tab_menu" onclick="fn_moveTab('EDCK0403');"><spring:message code="edc.tab.SUBJECT" /></li>
								<li id="tab_menu3" class="port_back tab_menu""><spring:message code="edc.tab.DB_FREEZING" /></li>
								<li id="tab_menu4" class="tab_menu" onclick="fn_moveTab('EDCK0405');" ><spring:message code="edc.tab.HIST_LIST" /></li>
							</ul>
						</div>
						
						<!--상단 버튼 설정 -->
						<div class="conTitBtnR">
							<input type="button" id="btnTmpFrz" value='<spring:message code="edc.btn.TEMP_FREEZING" />'>
							<input type="button" id="btnTmpFrzCnl" value='<spring:message code="edc.btn.TEMP_UNFREEZING" />'>
							<input type="button" id="btnDbFrz" value='<spring:message code="edc.btn.DB_FREEZING" />'>
							<input type="button" id="btnDbFrzCnl" value='<spring:message code="edc.btn.DB_UNFREEZING" />'>
							<input type="button" id="btnSncCnfrm" value='<spring:message code="edc.btn.CONFIRM" />'>
							<input type="button" id="btnGotoEDCK0401" value='<spring:message code="edc.btn.GOTO_LIST" />'>
						</div>
						<br>						
						<form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${TASK_SN}">
							<input type="hidden" id="FREEZING_STTUS_CODE" name="FREEZING_STTUS_CODE" value="">
							<input type="hidden" id="REQUST_NO" name="REQUST_NO" value="">
							<input type="hidden" id="SDV_FNSH_CHK" name="SDV_FNSH_CHK" value="">
							
	                      <article class="mgT16">
	                          <table class="tb02">
	                              <tbody>
	                                  <tr>
	                                  	<th><spring:message code="edc.lbl.TASK_NO" /></th>
	                                      <td class="wd360" colspan="3">
											<label id="TASK_NO"></label>
	                                      </td>
	                                  </tr>
	                                  <tr>
	                                      <th><spring:message code="edc.lbl.STTUS" /></th>
	                                      <td class="wd360" colspan="3">
	                                       	<label id="FREEZING_STTUS_NM"></label>
	                                      </td>
	                                  </tr>
	                                  <tr>
	                                      <th><spring:message code="edc.lbl.TASK_NM" /></th>
	                                      <td class="wd360" colspan="3">
	                                        	<label id="TASK_NM"></label>
	                                      </td>
	                                  </tr>
	                                  <tr>
	                                      <th><spring:message code="edc.lbl.SUBJECT_CNT" /></th>
	                                      <td class="wd360">
	                                        <label id="SUBJECT_CNT"></label>
	                                      </td>
	                                      <th><spring:message code="edc.lbl.ELTSGN_SUBJECT_CNT" /></th>
	                                      <td>
											<label id="ELTSGN_SUBJECT_CNT"></label>
	                                      </td>
	                                  </tr>
									  <tr>
	                                      <th><spring:message code="edc.lbl.TOTAL_CRF_PAGE" /></th>
	                                      <td>
	                                       	<label id="TOTAL_CRF_PAGE"></label>
	                                      </td>
	                                      <th><spring:message code="edc.lbl.SAVE_CRF_PAGE" /></th>
	                                      <td>
	                                       	<label id="SAVE_CRF_PAGE"></label>
	                                      </td>
	                                  </tr>
									  <tr>
	                                      <th><spring:message code="edc.lbl.TOTAL_OPEN_QUERY" /></th>
	                                      <td>
	                                       	<label id="TOTAL_OPEN_QUERY"></label>
	                                      </td>
	                                      <th><spring:message code="edc.lbl.TOTAL_RESPONSE_QUERY" /></th>
	                                      <td>
	                                       	<label id="TOTAL_RESPONSE_QUERY"></label>
	                                      </td>
	                                  </tr>
									  <tr>
	                                      <th><spring:message code="edc.lbl.SANCTNER_NM" /></th>
	                                      <td>
	                                       	<label id="SANCTNER_NM"></label>
	                                      </td>
	                                      <th><spring:message code="edc.lbl.SANCTN_DT" /></th>
	                                      <td>
	                                       	<label id="SANCTN_DT"></label>
	                                      </td>
	                                  </tr>
	                              </tbody>
	                          </table>
	
	                      </article>
						</form>
					</div>
			</div>
		</section>
	</div>
</body>
</html>