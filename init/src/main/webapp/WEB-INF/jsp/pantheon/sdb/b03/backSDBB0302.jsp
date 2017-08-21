<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>기관등록</title>
<script type="text/javascript">
var req_delngln_code = "${req_delngln_code}";
$(function(){	

	$('#btnInit').click(function() {
		$('#inputForm').each(function(){
			this.reset();
			$("#mode").val('C');
		});		
		 
		
	});
	$('#btnSave').click(function() {
		 
		if (!mkValidation()) {
			return;
		}
		
		var mode = $("#mode").val();	
		
		var params = {
				CURD : mode,
				DELNGLN_CODE: $("#delngln_code").val(),
				DELNGLN_NM 	: $("#delngln_nm").val(),
				DELNGLN_SE 	: $("#delngln_se").val(),
				DNAME 		: $("#dname").val(),
				EMAIL 		: $("#email").val(),
				ADRES 		: $("#adres").val(),
				CTY 		: $("#cty").val(),
				NATION 		: $("#nation").val(),
				TELNO 		: $("#telno").val().replace(/-/g, ''),
				TLPHON_LXTN : $("#tlphon_lxtn").val().replace(/-/g, ''),
				FXNUM 		: $("#fxnum").val().replace(/-/g, ''),
				FAX_LXTN 	: $("#fax_lxtn").val(),
				ZIP		 	: $("#zip").val(),
				UPDATE_ID 	: '${loginMap.USER_ID}'			
				};	
		//alert(params);
		//return;
		$.ajax({
			  url : "<c:url value='/sdb/b03/insertOrganList.do'/>",
			  type: 'post',
			  contentType : "application/json; charset=UTF-8",
			  data : JSON.stringify(params),
			  dataType : "json",
			  success : function(data) {
				  if(data.success){
						//alert("성공");
						window.location.href = "/sdb/b03/SDBB0301.do"
				  }else{
						alert(data.errmsg);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert("실패");
			  }
		});
		
	});
	
	$('#btnDel').click(function(){			
		var mode = $("#mode").val();
		if(!confirm('삭제하시겠습니까?')){
			return;
		}
		if (mode =='U'){
			del_mode = 'D';
		}
		var params = {
				CURD : del_mode,					
				DELNGLN_CODE : $("#delngln_code").val()
				};		
		$.ajax({
			url : "<c:url value='/sdb/b03/insertOrganList.do'/>",
			  type: 'post',
			  contentType : "application/json; charset=UTF-8",
			  data : JSON.stringify(params),
			  dataType : "json",
			  success : function(data) {
				  if(data.success){
						alert("성공");
						window.location.href = "/sdb/b03/SDBB0301.do"
				  }else{
						alert(data.errmsg);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(errorThrown);
				  alert(textStatus);
			  }			
		});
	
	 });
	
	setinit();
	init();
	
		
	
	
});

function setinit(){
	<c:forEach var="result" items="${printType}" varStatus="status">
	$("#delngln_se").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	$('#telno').mkTel();
	$('#tlphon_lxtn').mkTel();
 	$('#fxnum').mkTel();
	$('#fax_lxtn').mkTel();
	
}
function init(){
	if(req_delngln_code !=""){
		$("#delngln_code").val(req_delngln_code);
		$("#mode").val("U`");
	}else{
		$("#mode").val("C");		
	}
	
	if(req_delngln_code != null && req_delngln_code !=""){
		var params = {
				DELNGLN_CODE : req_delngln_code,
			};
			$.ajax({
				type		: "POST",
				url			: "/sdb/b03/selectOrganInfo.do",
				data		: params,
				dataType	: "json",
				 success : function(result) {					 
					  if(result.success == "true"){							
							$("#delngln_se").val(result.DELNGLN_SE);
							$("#delngln_nm").val(result.DELNGLN_NM);
							$("#dname").val(result.DNAME);							
							$("#email").val(result.EMAIL);
							$("#zip").val(result.ZIP);
							$("#adres").val(result.ADRES);
							$("#cty").val(result.CTY);
							$("#nation").val(result.NATION);
							$("#telno").mkTel(result.TELNO.replace(/-/g, ''));
							$("#tlphon_lxtn").mkTel(result.TLPHON_LXTN.replace(/-/g, ''));
							$("#fxnum").mkTel(result.FXNUM.replace(/-/g, ''));
							$("#fax_lxtn").mkTel(result.FAX_LXTN.replace(/-/g, ''));		
							$("#mode").val("U");						  
					  }else{
							alert(result.errmsg);
					  }
				  }, 
				error		: function(xhr, textStatus, errorThrown){
					//alert(textStatus);
					alert("실패");
				}
			});
	}
}	


</script>
</head>
<body>
<div id="wrap">

<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0301&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0301&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
    <section id="mainCon">
        <div class="mainConInner">
            <article class="mainTitBox">
					<h3>기관  등록</h3>
	                <nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>기본정보관리</li>
							<li>기관 관리</li>
						</ul>
					</nav>
				</article>
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
			<form id="inputForm">
				<input type="hidden" id="mode" value="C"/>
				<input type="hidden" id="delngln_code" value=""/>
			<div class="conBoxInner">						
				<!-- 상단 그리드  상단메뉴라인 시작-->
				<article class="conTitBtn">
					<!-- 상단 그리드 왼쪽 메뉴 시작 -->
					<div class="conTitBtnL"></div>
					<!-- 상단 그리드 왼쪽  메뉴 끝 -->
					<!-- 상단 그리드 오른쪽 메뉴 시작-->
					<div class="conTitBtnR">
						<input type="button" id="btnInit" value="초기화"/>
						<input type="button" id="btnSave" value="저장"/>
						<input type="button" id="btnDel" value="삭제"/>
					</div>
					<!-- 상단 그리드 오른쪽 메뉴 끝-->
				</article>
				<!-- 상단 그리드  상단메뉴라인 끝-->
				<!-- 그리드 시작 -->
				<article class="mgT44">
					<table class="tb001">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 40%;" />
						<col style="width: 10%;" />
						<col style="width: 40%;" />
					</colgroup>
					<tbody>
					<tr>
						<th>구분 <span class="must_01"></span></th>
						<td colspan="3">
							<select id="delngln_se" valireqire="기관명">
								<option value=''>===선택하세요===</option>								
							</select>
						</td>
					</tr>		
					<tr>
						<th>기관명 <span class="must_01"></span></th>
						<td colspan="3"><input type="text" id="delngln_nm" valireqire="기관명"></td>
					</tr>
					<tr>
						<th>성명</th>
						<td><input type="text" id="dname"></td>
						<th>Email</th>
						<td><input type="text" id="email"></td>
					</tr>			
					<tr>
						<th>주소</th>
						<td><input type="text" id="adres" style="width:400px;"></td>
						<th>도시</th>
						<td><input type="text" id="cty"></td>
					</tr>
					<tr>
						<th>지역</th>
						<td><input type="text" id="nation"></td>
						<th>우편번호</th>
						<td><input type="text" id="zip"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><input type="text" id="telno"></td>
						<th>내선번호</th>
						<td><input type="text" id="tlphon_lxtn"></td>
					</tr>
					<tr>
						<th>Fax 번호</th>
						<td><input type="text" id="fxnum"></td>
						<th>Fax 내선</th>
						<td><input type="text" id="fax_lxtn"></td>
					</tr>
					</tbody>
					</table>
				</article>
			</form>
			</section>
		  <!-- 컨텐츠박스 끝-->
       </div>
   </section>	
</body>
</html>