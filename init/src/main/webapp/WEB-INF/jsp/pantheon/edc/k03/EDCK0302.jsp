<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<script type="text/javascript">
$(document).ready(function() {
	 mkSetDatePickerYYMMDD("#APPLC_BGNDE", "#APPLC_ENDDE");
	
	if ($("#crud").val() == "U") {
		var bgnde = "${result.APPLC_BGNDE}";
		var endde = "${result.APPLC_ENDDE}";
		
		$("#APPLC_BGNDE").val(bgnde.substring(0,10));
		$("#APPLC_ENDDE").val(endde.substring(0,10));
		
		$("input[name=SEXDSTN][value=${result.SEXDSTN}]").prop("checked", "checked");
		
		editMode(1);
	} else {
		editMode(2);
	}
	
 	$("#btnInttNm").click(function(){
	 		var param={  };
			mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
 	});
	
 	$("#btnAnalsNm").click(function(){
 		var param={  };
		mkLayerPopupOpen("/edc/k03/popupEDCK0302.do", param, 2);
	});
 	
	
});


var form = document.regForm;
function fnSave(){
	if(!mkValidation()){
		return;
	}
	
	var type = '';
	var URL = '';
	type = $("#LAB_SN").val();
	
	if(type == ""){
		URL = './insertLab.do';
	}else{
		URL = './updateLab.do';
	}
	if (confirm('<spring:message code="common.regist.msg" />')) {
		var param = $("#regForm").serialize();
		$.ajax({
			url : URL,
			data : param,
			type : 'post',
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					alert(data.message);
						window.location.href='./EDCK0301.do';
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

function fnList(){
	$("#regForm").attr({
		action : './EDCK0301.do',
		method : 'post'
	}).submit();
}

function editMode(c) {
	if (c == 1) {
		mkDisabled(); //컨트롤 비활성화
		$("button").hide();
		$("#btn_edit").show();
		$(".ui-datepicker-trigger").hide();
	} else {
		mkEnabled(); //컨트롤 활성화
		$("button").show();
		$("#btn_edit").hide();
		$(".ui-datepicker-trigger").show();
	}
}

function fn_setInstt(){
	$("#txtInputInttNm").val(returnValue.INSTT_NAME);
	$("#INSTT_CODE").val(returnValue.INSTT_CODE);
	
}

function fn_setParam(){
	$("#txtInputAnalsNm").val(returnValue.CDISC_SUBMIT_VALUE);
	$("#ANALS_PARAMTR").val(returnValue.CL_CODE_SN);
	
}

</script>
</head>

<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0302&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0302&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>

	 <section id="mainCon">
          <div class="mainConInner">

              <!-- 컨텐츠박스 시작-->
              <section class="conBox100 conBox">
                  <div class="conBoxInner">

                      <!-- 컨텐츠 타이틀 시작-->
                      <article class="conTitBox">
                          <h5>Lab 정상범위 상세</h5>
                      </article>
                      <!-- 컨텐츠 타이틀 끝-->

                      <!-- 상단 오른쪽 메뉴 시작-->
                      <!-- 상단 테이블 오른쪽 메뉴 시작-->
					  <div class="conTitBtnR">
					  	  <button type="button" id="btn_edit" onclick="editMode(2);">수정</button>
                          <button type="button" onclick="fnSave()" >저장</button>
                          <button type="button" onclick="fnList()" >목록</button>
                      <!-- 상단 오른쪽 메뉴 끝-->
                      </div>
                      <form name="regForm" id="regForm" method="post">
						<input type="hidden" name="LAB_SN" id="LAB_SN" value='<c:out value="${result.LAB_SN}"/>'/>
						<input type="hidden" id="crud" name="crud" value="${ param.crud }">
						
                      <article class="mgT16">
                          <table class="tb02">
                              <tbody>
                                  <tr>
                                      <th>기관명<span style='color:red'>*</span></th>
                                      <td class="wd360">
                                       <input type="text"  title="기관명" name="insttNm" size="45" id="txtInputInttNm" disabled value='<c:out value="${result.NAME1}"/>' able valireqire="기관명"/>
                                       <button type="button" id="btnInttNm" >조회</button>
                                       <input type="hidden" name="INSTT_CODE" id="INSTT_CODE" value='<c:out value="${result.INSTT_CODE}"/>'>
                                      </td>
                                      <th>Laboratory<span style='color:red'>*</span></th>
                                      <td>
										<input type="text" title="Laboratory" name="LAB_NM" size="55"  value='<c:out value="${result.LAB_NM}"/>' able/>
                                      </td>
                                  </tr>
                                  <tr>
                                      <th>Analysis parameter<span style='color:red'>*</span></th>
                                      <td class="wd360">
                                       <input type="text" title="Analysis parameter" id="txtInputAnalsNm" name="txtInputAnalsNm" size="45" value='<c:out value="${result.CDISC_SUBMIT_VALUE}"/>' able valireqire="Laboratory"/>
                                       <button type="button" id="btnAnalsNm" >조회</button>
                                       <input type="hidden" name="ANALS_PARAMTR" id="ANALS_PARAMTR" value='<c:out value="${result.ANALS_PARAMTR}"/>'>
                                      </td>
                                      <th>Unit<span style='color:red'>*</span></th>
                                      <td>
										<input type="text" title="Unit" name="UNIT" size="55"  value='<c:out value="${result.UNIT}"/>' able valireqire="Unit"/>
                                      </td>
                                  </tr>
                                  <tr>
                                      <th>Reference Range Lower limit<span style='color:red'>*</span></th>
                                      <td class="wd360">
                                       <input type="text" title="Reference Range Lower limit" name="SCOPE_LWLT_VALUE" size="55"  value='<c:out value="${result.SCOPE_LWLT_VALUE}"/>' able valireqire="Reference Range Lower limit"/>
                                      </td>
                                      <th>Reference Range Upper limit<span style='color:red'>*</span></th>
                                      <td>
										<input type="text" title="Reference Range Upper limit" name="SCOPE_UPLMT_VALUE" size="55"  value='<c:out value="${result.SCOPE_UPLMT_VALUE}"/>' able valireqire="Reference Range Upper limit"/>
                                      </td>
                                  </tr>
                                  <tr>
                                      <th>연령<span style='color:red'>*</span></th>
                                      <td class="wd360">
                                       <input type="text" title="연령" name="AGE" size="55"  value='<c:out value="${result.AGE}"/>' able valireqire="연령"/>
                                      </td>
                                      <th>성별<span style='color:red'>*</span></th>
                                      <td>
										<input type="radio" id="ra01" name="SEXDSTN" value="M" able><label for="ra01" class="raLab" ><span>남</span></label>
                                          <input type="radio" id="ra02" name="SEXDSTN" value="F" checked able><label for="ra02" class="raLab"><span>여</span></label>
                                      </td>
                                  </tr>
									<tr>
                                      <th>적용기간<span style='color:red'>*</span></th>
                                      <td>
                                       <div class="dateBox">
											<input type="text" title="적용기간 시작" name="APPLC_BGNDE" id="APPLC_BGNDE" able valireqire="적용기간"/>
										</div>
										~
										<div class="dateBox">
											<input type="text" title="적용기간 종료" name="APPLC_ENDDE" id="APPLC_ENDDE" able valireqire="적용기간"/></td>
										</div>
                                      </td>
                                  </tr>
                              </tbody>
                          </table>

                      </article>
                       </form>
                      <!-- 폼리스트 메뉴 끝 -->
                  </div>
              </section>
              <!-- 컨텐츠박스 끝-->
		</div>
</section>
</div>
</body>
</html>

