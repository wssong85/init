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
	mkSetDatePickerYYMMDD("#DOCMNT_AGRE_DE");
	
	$('input[name="DOCMNT_AGRE_AT"]').change(function(){
		if($(":radio[name='DOCMNT_AGRE_AT']:checked").val() == 'N'){
			editMode(1);
		}else{
			editMode(2);
		}
	});
});

function fnInsert(type) {
	if(!mkValidation()){
		return;
	}
	
	var arrDileDate = $("#DOCMNT_AGRE_DE").val().split("-");
	
	var toDate = new Date();				
	var dileDate = new Date(arrDileDate[0], arrDileDate[1] - 1, arrDileDate[2], 0, 0, 0);
	
	if(dileDate.getTime() - toDate.getTime() > 0){
		alert("동의일은 미래일을 등록할 수 없습니다.");
		return;
	}
	
	if (confirm('<spring:message code="common.regist.msg" />')) {
		var param = $("#regForm").serialize();
		$.ajax({
			url : './insertSubject.do',
			data : param,
			type : 'post',
			//contentType : "application/json; charset=UTF-8",
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					alert(data.message);
					if(type == '1'){
						window.location.href='./EDCC0101.do';
					}else{
						alert("CRF작성화면");
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
		$(".ui-datepicker-trigger").hide();
	} else {
		mkEnabled(); //컨트롤 활성화
		$("button").show();
		$(".ui-datepicker-trigger").show();
	}
}

</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0104&&UPPER_MENU_ID=EDCC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0104&&UPPER_MENU_ID=EDCC" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Subject</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Subject</li>
						<li>Patient 등록</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:800px;">
                    <article class="conTitBox">
                        <h5>Patient 등록</h5>
                    </article>
                    <article class="conTitBtnR">
	                    <button type="button" onclick="fnInsert(1)" >저장</button>
	                    <button type="button" onclick="fnInsert(2)" >저장 후 이동</button>
                    </article>
                    <form name="regForm" id="regForm" method="post">
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
									<th>동의 여부<span style='color:red'>*</span></th>
									<td>
										<input type="radio" id="DOCMNT_AGRE_AT1" name="DOCMNT_AGRE_AT" value="Y"><label for="DOCMNT_AGRE_AT1" class="raLab"><span>예</span></label>
										<input type="radio" id="DOCMNT_AGRE_AT2" name="DOCMNT_AGRE_AT" value="N"><label for="DOCMNT_AGRE_AT2" class="raLab"><span>아니오</span></label>
									</td>
									<th>동의일<span style='color:red'>*</span></th>
									<td>
										<div class="dateBox">
											<input type="text" id="DOCMNT_AGRE_DE" name="DOCMNT_AGRE_DE" valireqire="동의일" able/>
										</div>
									</td>
								</tr>
								<tr>
									<th>이니셜<span style='color:red'>*</span></th>
									<td colspan="3">
										<input type="text" id="SUBJECT_INITIAL" name="SUBJECT_INITIAL" style="width:20%;" valireqire="이니셜" able/>
									</td>
								</tr>
								<tr>
									<th>Subject No.</th>
									<td colspan="3">
										<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" style="width:20%;" value="S" readonly />
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