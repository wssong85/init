<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>Product Info</title>

<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>


<script type="text/javascript">
var report_seq=0;
var req_prduct_code = "${req_prduct_code}";

var check_report = 0;

$(function() {	
	btninit();
	setinit();
	init();
});

function btninit(){
	
	$('#tabInfo').click(function(){
		url = "/sdb/b01/SDBB0102.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val();
		POSTSend(url, id, val);
	});	
	
	$('#tabLab').click(function(){
		url = "/sdb/b01/SDBB0103.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val();
		POSTSend(url, id, val);
	});	
	
	$('#tabPsur').click(function(){
		url = "/sdb/b01/SDBB0104.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val();
		POSTSend(url, id, val);
	});
	
	$('#tabNon').click(function(){
		url = "/sdb/b01/SDBB0105.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val();
		POSTSend(url, id, val);
	});
	
	$('#btnInit').click(function() {
		$('#product_form').each(function(){
			this.reset();
		});		
	});
	
	$('#btnSave').click(function() {
		if (!mkValidation()) {
			return;
		}		
		if (!confirm('저장하시겠습니까?')) {
			return;
		}
		
		if ($('#mode').val() =='U'){
			updelform();	
		}else{				
			saveform();
		}
		
		//}
	});
	
	$('#btnDel').click(function(){
		var mode = $("#mode").val();
		if (mode =='U'){			
			if(!confirm('삭제하시겠습니까?')){
				return;
			}
			if (mode =='U'){
				del_mode = 'D';
			}
			var params = {
					CURD : del_mode,					
					PRDUCT_CODE : $("#prduct_code").val()
					};		
			$.ajax({
				  url : "<c:url value='/sdb/b01/insertProductList.do'/>",
				  type: 'post',
				  contentType : "application/json; charset=UTF-8",
				  data : JSON.stringify(params),
				  dataType : "json",
				  success : function(data) {
					  if(data.success){					  
							//alert("성공");
						  	var url ="<c:url value='/sdb/b01/SDBB0101.do'/>";		
							POSTSend(url);
					  }else{
							alert(data.message);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(errorThrown);
					  alert(textStatus);
				  }			
			});
		}
	
	 });
	
		
	$('#report_set_plus').click(function() {        	
       	report_seq = report_seq+1;		
		
		var t_table = "";
		t_table = t_table + '<tr id="row_'+ report_seq +'"><th>보고기관명</th><td><input type="text" id="report_instt_nm_'+ report_seq +'" style="width:100%;"/><input type="hidden" id="i_report_seq_'+ report_seq +'"/></td>';
		t_table = t_table + '	<th>유형</th>';
		//t_table = t_table + '	<td><input type="hidden" id="report_mode_'+ report_seq +'" value="I"/><input type="text" id="ty_'+ report_seq +'" style="width:100%;"/></td>';
		t_table = t_table + '	<td>';
		t_table = t_table + '		<input type="hidden" id="report_mode_'+ report_seq +'" value="I"/><select  id="ty_'+ report_seq +'" style="width:100%;">';
		t_table = t_table + '			<option value="01">거래선</option>';
		t_table = t_table + '			<option value="02">규제기관</option>';
		t_table = t_table + '		</select>';
		t_table = t_table + '	</td>';
		t_table = t_table + '	<th>Initial여부</th>';
		t_table = t_table + '	<td>';
		t_table = t_table + '		<select  id="initial_at_'+ report_seq +'" style="width:100%;">';
		t_table = t_table + '			<option value="Y">YES</option>';
		t_table = t_table + '			<option value="N">NO</option>';
		t_table = t_table + '		</select>';
		t_table = t_table + '	</td>';
		t_table = t_table + '	<th>기준일</th>';
		t_table = t_table + '	<td style="border-right:none;">';
		t_table = t_table + '		<select id="stdde_ty_'+ report_seq +'" style="width:40%;">';
		t_table = t_table + '			<option value="01">달력일</option>';
		t_table = t_table + '			<option value="02">근무일</option>';
		t_table = t_table + '		</select>';
		t_table = t_table + '		<input type="text"  id="reportde_co_'+ report_seq +'" style="width:40%;"/> 일 이내';
		t_table = t_table + '	</td>';
		t_table = t_table + '	<td style="padding:0; border-left:none;border-right:none;"><input type="button" id="del_'+ report_seq +'" value="삭제" title="삭제" onclick="rowDel(this, '+ report_seq +');"/></td>';
		t_table = t_table + '</tr>';

		
        $('#report_set_table > tbody:last').append(t_table);
		
		
       });
//          $('#del_'+ report_seq).click(function() { 
//              $('#row_'+ report_seq).remove(); 
//          }); 
	$('#btnAuditList').click(function(){
		// audit
		 $("report_set_table").find("tr:gt(0)").remove();
	});	
	
	$('#btnCase').click(function(){
		var url ="<c:url value='/sdb/c02/SDBC0201.do'/>";		
		POSTSend(url);
	});
	
	
	$('#not_applicable').change(function(){
		if($('#not_applicable').is(":checked")){
			$('#frst_mfbiz_code').val('');
			$('#frst_mfbiz_code').attr("disabled", true);
		}else{
			$('#frst_mfbiz_code').attr("disabled", false);
		}
	});
	
}

function setinit(){
	<c:forEach var="result" items="${printType}" varStatus="status">
		$("#comava_at").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	<c:forEach var="result" items="${printType_ori}" varStatus="status">
		$("#frst_mfbiz_code").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	mkSetDatePickerYYMMDD("#txtconfm_dte");
	$("#txtconfm_bfe_ip_nm_mullang_code1").attr("maxlength", 100);
	$("#txtconfm_bfe_ip_nm_mullang_code2").attr("maxlength", 100);
	$("#txtconfm_bfe_ip_nm_mullang_code3").attr("maxlength", 100);	
	$("#txtprductnm_code").attr("maxlength", 40);
	$("#txtgnrl_nm_code1").attr("maxlength", 100);
	$("#txtgnrl_nm_code2").attr("maxlength", 100);
	$("#txtgnrl_nm_code3").attr("maxlength", 100);
	
}
function init(){
	if(req_prduct_code !=""){
		$("#prduct_code").val(req_prduct_code);
		$("#mode").val("U");
		$("#tabLab").on("click");
		$("#tabPsur").on("click");
		$("#tabNon").on("click");
		
	}else{
		$("#mode").val("C");
		//$("#tabLab").attr("disabled", true);
		$("#tabLab").off("click");
		$("#tabPsur").off("click");
		$("#tabNon").off("click");
			
	}
	
	if(req_prduct_code != null && req_prduct_code !=""){
		var params = {
				PRDUCT_CODE : req_prduct_code,
			};
			$.ajax({
				type		: "POST",
				url			: "/sdb/b01/selectProductListInfo.do",
				data		: params,
				dataType	: "json",
				 success : function(result) {					 
					  if(result.success == "true"){
						  $("#frst_mfbiz_code").val(result.FRST_MFBIZ_CODE);
						  $("#txtconfm_dte").val(result.CONFM_DTE);
						  $("#comava_at").val(result.COMAVA_AT);
						  
						  $.trim($("#hdprductnm_code").val(result.PRDUCTNM_CODE));						  
						  $.trim($("#hdgnrl_nm_code1").val(result.GNRL_NM_CODE1));
						  $.trim($("#hdgnrl_nm_code2").val(result.GNRL_NM_CODE2));
						  $.trim($("#hdgnrl_nm_code3").val(result.GNRL_NM_CODE3));						  
						  $.trim($("#hdconfm_bfe_ip_nm_mullang_code1").val(result.CONFM_BFE_IP_NM_MULLANG_CODE1));
						  $.trim($("#hdconfm_bfe_ip_nm_mullang_code2").val(result.CONFM_BFE_IP_NM_MULLANG_CODE2));
						  $.trim($("#hdconfm_bfe_ip_nm_mullang_code3").val(result.CONFM_BFE_IP_NM_MULLANG_CODE3));
						        
						  $.trim($("#txtprductnm_code").val(result.PRDUCTNM_CODE_KOR));						  
						  $.trim($("#txtgnrl_nm_code1").val(result.GNRL_NM_CODE1_KOR));
						  $.trim($("#txtgnrl_nm_code2").val(result.GNRL_NM_CODE2_KOR));
						  $.trim($("#txtgnrl_nm_code3").val(result.GNRL_NM_CODE3_KOR));						  
						  $.trim($("#txtconfm_bfe_ip_nm_mullang_code1").val(result.CONFM_BFE_IP_NM_CODE1_KOR));
						  $.trim($("#txtconfm_bfe_ip_nm_mullang_code2").val(result.CONFM_BFE_IP_NM_CODE2_KOR));
						  $.trim($("#txtconfm_bfe_ip_nm_mullang_code3").val(result.CONFM_BFE_IP_NM_CODE3_KOR));		  
						        
						  $.trim($("#txtprductnm_code_eng").text(result.PRDUCTNM_CODE_ENG));						  
						  $.trim($("#txtgnrl_nm_code1_eng").text(result.GNRL_NM_CODE1_ENG));
						  $.trim($("#txtgnrl_nm_code2_eng").text(result.GNRL_NM_CODE2_ENG));
						  $.trim($("#txtgnrl_nm_code3_eng").text(result.GNRL_NM_CODE3_ENG));						  
						  $.trim($("#txtconfm_bfe_ip_nm_mullang_code1_eng").text(result.CONFM_BFE_IP_NM_CODE1_ENG));
						  $.trim($("#txtconfm_bfe_ip_nm_mullang_code2_eng").text(result.CONFM_BFE_IP_NM_CODE2_ENG));
						  $.trim($("#txtconfm_bfe_ip_nm_mullang_code3_eng").text(result.CONFM_BFE_IP_NM_CODE3_ENG));
						  
						  detailSelect(req_prduct_code, '1');
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

function updelform(){
	var param = {
			TRGET_CODE 	: $("#prduct_code").val(), 
			TRGETNM 	: "ProD",
			TRGET_MODE  : $('#mode').val(),
			UPDATE_ID	: '${loginMap.USER_ID}'						
		};
	mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
}


function saveform(){
	alert('삽입');
	var params = {
			CURD 							  : $.trim($("#mode").val()), 
			PRDUCT_CODE 					  : $.trim($("#prduct_code").val()),
			CONFM_BFE_IP_NM_MULLANG_CODE1	  : $.trim($("#hdconfm_bfe_ip_nm_mullang_code1").val()),
			CONFM_BFE_IP_NM_MULLANG_CODE1_KOR : $.trim($("#txtconfm_bfe_ip_nm_mullang_code1").val()),
			CONFM_BFE_IP_NM_MULLANG_CODE1_ENG : $.trim($("#txtconfm_bfe_ip_nm_mullang_code1_eng").text()),
			CONFM_BFE_IP_NM_MULLANG_CODE2	  : $.trim($("#hdconfm_bfe_ip_nm_mullang_code2").val()),
			CONFM_BFE_IP_NM_MULLANG_CODE2_KOR : $.trim($("#txtconfm_bfe_ip_nm_mullang_code2").val()),
			CONFM_BFE_IP_NM_MULLANG_CODE2_ENG : $.trim($("#txtconfm_bfe_ip_nm_mullang_code2_eng").text()),
			CONFM_BFE_IP_NM_MULLANG_CODE3 	  : $.trim($("#hdconfm_bfe_ip_nm_mullang_code3").val()),
			CONFM_BFE_IP_NM_MULLANG_CODE3_KOR : $.trim($("#txtconfm_bfe_ip_nm_mullang_code3").val()),
			CONFM_BFE_IP_NM_MULLANG_CODE3_ENG : $.trim($("#txtconfm_bfe_ip_nm_mullang_code3_eng").text()),
			CONFM_DTE 		  				  : $.trim($("#txtconfm_dte").val()),
			PRDUCTNM_CODE 	  				  : $.trim($("#hdprductnm_code").val()),
			PRDUCTNM_CODE_KOR 				  : $.trim($("#txtprductnm_code").val()),
			PRDUCTNM_CODE_ENG 				  : $.trim($("#txtprductnm_code_eng").text()),
			GNRL_NM_CODE1 	  				  : $.trim($("#hdgnrl_nm_code1").val()),
			GNRL_NM_CODE1_KOR 				  : $.trim($("#txtgnrl_nm_code1").val()),	
			GNRL_NM_CODE1_ENG 				  : $.trim($("#txtgnrl_nm_code1_eng").text()),
			GNRL_NM_CODE2 					  : $.trim($("#hdgnrl_nm_code2").val()),
			GNRL_NM_CODE2_KOR 				  : $.trim($("#txtgnrl_nm_code2").val()),
			GNRL_NM_CODE2_ENG 				  : $.trim($("#txtgnrl_nm_code2_eng").text()),
			GNRL_NM_CODE3 	  				  : $.trim($("#hdgnrl_nm_code3").val()),
			GNRL_NM_CODE3_KOR 				  : $.trim($("#txtgnrl_nm_code3").val()),
			GNRL_NM_CODE3_ENG 				  : $.trim($("#txtgnrl_nm_code3_eng").text()),
			FRST_MFBIZ_CODE					  : $("#frst_mfbiz_code option:selected").val(),
			COMAVA_AT						  : $("#comava_at option:selected").val(),
			UPDATE_ID 						  : '${loginMap.USER_ID}'	
			};
	
			
	
		$.ajax({
			  url : "<c:url value='/sdb/b01/insertProductList.do'/>",
			  type: 'post',
			  contentType : "application/json; charset=UTF-8",
			  data : JSON.stringify(params),
			  dataType : "json",
			  success : function(data) {
				  if(data.success){
						//alert("성공");
						var ireport_seq = report_seq;
						var iprduct_code = data.PRDUCT_CODE;
						
						addReportSet(ireport_seq, iprduct_code);
						//window.location.href  = '/sdb/b01/SDBB0101.do';
				  }else{
						alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(errorThrown);
				  alert(textStatus);
			  }
		});
	
}

function saveLayer(p_mode){		
	saveform();				
}

function EnglishNotation(idKorean, idEng){
	
	var txtKorean = $.trim($('#'+idKorean).val());
	var txtEng = $.trim($('#'+idEng).text());

	var param = {
			ID_KOREAN : idKorean,
			ID_ENG : idEng,
			KOREAN : txtKorean,
			ENG : txtEng
		};
		
		mkLayerPopupOpen("/sdb/c02/popupSDBC0218.do", param);
		return false;
}


function detailSelect(req_prduct_code, report_sn){
	var params2 = {
			PRDUCT_CODE : req_prduct_code			
	};
	$.ajax({
		type		: "POST",
		url			: "/sdb/b01/selectProductReportInfo.do",
		data		: params2,
		dataType	: "json",
		 success : function(data) {					 
			  if(data.success == true){					 
				 for(i=0; i<data.result.length ; i++){
					   var d_report_seq 	= data.result[i].REPORT_SN;
					   var ty 				= data.result[i].TY;
					   var stdde_ty 		= data.result[i].STDDE_TY;
					   var report_instt_nm  = data.result[i].REPORT_INSTT_NM;
					   var reportde_co 		= data.result[i].REPORTDE_CO;
					   var initial_at 		= data.result[i].INITIAL_AT;
					   
						var t_table = "";
						t_table = t_table + '<tr id="row_'+ d_report_seq +'" class="activeTr"><th>보고기관명</th><td><input type="text" id="report_instt_nm_'+ d_report_seq +'" value="'+ report_instt_nm +'" style="width:100%;"/><input type="hidden" id="i_report_seq_'+ report_seq +'"/></td>';
						t_table = t_table + '	<th>유형</th>';
						t_table = t_table + '	<td><input type="hidden" id="report_mode_'+ d_report_seq +'" value="U"/><select id="ty_'+ d_report_seq +'"  style="width:100%;"><option value="">==선택하세요==</option><option value="01">거래선</option><option value="02">규제기관</option></select></td>';
						t_table = t_table + '	<th>Initial여부</th>';
						t_table = t_table + '	<td>';
						t_table = t_table + '		<select id="initial_at_'+ d_report_seq +'" style="width:100%;">';
						t_table = t_table + '			<option value="Y">YES</option>';
						t_table = t_table + '			<option value="N">NO</option>';
						t_table = t_table + '		</select>';
						t_table = t_table + '	</td>';
						t_table = t_table + '	<th>기준일</th>';
						t_table = t_table + '	<td style="border-right:none;">';
						t_table = t_table + '		<select  id="stdde_ty_'+ d_report_seq +'" style="width:40%;">';
						t_table = t_table + '			<option value="01">달력일</option>';
						t_table = t_table + '			<option value="02">근무일</option>';						
						t_table = t_table + '		</select>';
						t_table = t_table + '		<input type="text"  id="reportde_co_'+ d_report_seq +'"  value="'+ reportde_co +'" style="width:40%;"/> 일 이내';
						t_table = t_table + '	</td>';
						t_table = t_table + '	<td style="padding:0; border-left:none;border-right:none;"><input type="button" id="del_'+ d_report_seq +'" value="삭제" title="삭제" onclick="rowDel(this, '+ d_report_seq +');"/></td>';
						t_table = t_table + '</tr>';


						
						
						
				        $('#report_set_table > tbody:last').append(t_table);
				        $('#ty_'+ d_report_seq).val(ty);
				        $('#initial_at_'+ d_report_seq).val(initial_at);
				        $('#stdde_ty_'+ d_report_seq).val(stdde_ty);
				        report_seq = d_report_seq;
					 
				 }
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

function rowDel(obj, seq, prduct_code){
	var ch_status = $('#report_mode_'+seq).val();
	if (ch_status =='I'){
		$(obj).parent().parent().remove();	
	}else if(ch_status =='U'){
		if(!confirm('행삭제를 하시겠습니까?')){
			return;
		}else{
			var del_mode = 'D_D';			
			
			var params = {
					CURD 		: del_mode,					
					PRDUCT_CODE : $('#prduct_code').val(),
					REPORT_SN 	: seq
					};	
			//alert(params);
			//return;
			$.ajax({
				  url : './insertProductReport.do',
				  type: 'post',
				  contentType : "application/json; charset=UTF-8",
				  data : JSON.stringify(params),
				  dataType : "json",
				  success : function(data) {
					  if(data.success){
							//alert("성공");
							window.location.reload();
					  }else{
							alert(data.message);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(errorThrown);
					  alert(textStatus);
				  }			
			});
		}
		
	}else{
		//alert('aaaa');
	}
		
}

function addReportSet(ireport_seq, iprduct_code){
	if($('#mode').val() =='U'){
			
		var params = {
				CURD 			: "D", 
				PRDUCT_CODE 	: iprduct_code				
			};
		$.ajax({
			  url : './insertProductReport.do',
			  type: 'post',
			  contentType : "application/json; charset=UTF-8",
			  data : JSON.stringify(params),
			  dataType : "json",
			  success : function(data) {
				  if(data.success){
					  //alert(report_seq);
					  //return;
						for(i=1 ; i<= report_seq; i++)
						{
							if(typeof($('#report_instt_nm_'+i).val()) != 'undefined' && typeof($('#report_instt_nm_'+i).val()) != null){
								
								check_report = check_report + 1;
								var params3 = {
										CURD : "C", 
										REPORT_SN 		: check_report,
										PRDUCT_CODE 	: iprduct_code,
										TY              : $('#ty_'+i).val(),
										STDDE_TY        : $('#stdde_ty_'+i).val(),
										REPORT_INSTT_NM : $('#report_instt_nm_'+i).val(),
										REPORTDE_CO	    : $('#reportde_co_'+i).val(),	
										INITIAL_AT	    : $('#initial_at_'+i).val(),						
										UPDATE_ID 		: '${loginMap.USER_ID}'
									};
								$.ajax({
									  url : "<c:url value='/sdb/b01/insertProductReport.do'/>",
									  type: 'post',
									  contentType : "application/json; charset=UTF-8",
									  data : JSON.stringify(params3),
									  dataType : "json",
									  success : function(data) {
										  if(data.success){
	
										  }else{
												alert(data.message);
										  }
									  }, 
									  error : function(jqXHR, textStatus, errorThrown){
										  alert("실패");
									  }
								});
							}
					  }					  
					  window.location.href = '/sdb/b01/SDBB0101.do';
				  }else{
						alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert("실패");
			  }
		});
	}
	else{
		for(i=1 ; i<= report_seq; i++)
		{
			if(typeof($('#report_instt_nm_'+i).val()) != 'undefined' && typeof($('#report_instt_nm_'+i).val()) != null){
				
				check_report = check_report + 1;
				var params3 = {
						CURD : "C", 
						REPORT_SN 		: check_report,
						PRDUCT_CODE 	: iprduct_code,
						TY              : $('#ty_'+i).val(),
						STDDE_TY        : $('#stdde_ty_'+i).val(),
						REPORT_INSTT_NM : $('#report_instt_nm_'+i).val(),
						REPORTDE_CO	    : $('#reportde_co_'+i).val(),	
						INITIAL_AT	    : $('#initial_at_'+i).val(),						
						UPDATE_ID 		: '${loginMap.USER_ID}'
					};
				$.ajax({
					  url : "<c:url value='/sdb/b01/insertProductReport.do'/>",
					  type: 'post',
					  contentType : "application/json; charset=UTF-8",
					  data : JSON.stringify(params3),
					  dataType : "json",
					  success : function(data) {
						  if(data.success){

						  }else{
								alert(data.message);
						  }
					  }, 
					  error : function(jqXHR, textStatus, errorThrown){
						  alert("실패");
					  }
				});
			}
	  }					  
	  window.location.href = '/sdb/b01/SDBB0101.do';
		
	}
	//return; 
	
			
}
	



</script>
<title>의약품등록</title>
<style type="text/css">

 </style>
</head>
<body>
<div id="wrap">
	<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0101&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0101&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<form id="product_form">
	<section id="mainCon">
	<div class="mainConInner">
		<article class="mainTitBox">
			<h3>${progrmMap.MENU_NM}</h3>
			<nav id="pathNav">
				<ul>
					<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
					 <li>${progrmMap.UPPER_MENU_NM}</li>
					<li>${progrmMap.MENU_NM}</li>
				</ul>
			</nav>
		</article>
		<section class="conBox100 conBox">
		<div class="conBoxInner">         
             <article class="conGridUpper">  
				<input type="hidden" id="mode" value='C'/>
				<input type="hidden" id="prduct_code"/>
				<div class="button_tab_01">
					<ul>
						<li id="tabInfo" class="port_back tab_menu">Info</li>
						<li id="tabLab" class="tab_menu">LABEL</li>
						<li id="tabPsur" class="tab_menu">RSI</li>
						<li id="tabNon" class="tab_menu">Non-Clinical</li>						
					</ul>
				</div>
			<article>			
				<div class="conTitBtnR">
					<input type="button" id="btnCase" value="CASE">
					<input type="button" id="btnInit" value="초기화">
					<input type="button" id="btnSave" value="저장">
					<input type="button" id="btnDel" value="삭제">
					<input type="button" id="btnAudit" value="A" title="Audit Trail">
				</div>
			</article>
			<article class="mgT44">
				<table class="tb001">
					<colgroup>
						<col width="12%" />
						<col width="25%" />
						<col width="12%" />
						<col width="19%" />
						<col width="12%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>Pre-Approval IP Name1<span class='must_01'></span></th>
							<td>
								<table class="in_table">
									<tr>
										<th>
											<input type="text" id="txtconfm_bfe_ip_nm_mullang_code1" valireqire="Pre-Approval IP Name1" style="width:100%;"/>
										</th>
										<td style="width: 32px;">
											<input class="oneBtn" popup_type="E" type="button" value="E" onclick="EnglishNotation('txtconfm_bfe_ip_nm_mullang_code1','txtconfm_bfe_ip_nm_mullang_code1_eng');"/>
										</td>
									</tr>
								</table>
								<input type="hidden" id="hdconfm_bfe_ip_nm_mullang_code1" />
								<label class="label_01" popup_type="Label" id="txtconfm_bfe_ip_nm_mullang_code1_eng" style="margin-top:1px;"></label>
							</td>
							<th>Pre-Approval IP Name2</th>
							<td>
								<table class="in_table">
									<tr>
										<th>
											<input type="text" id="txtconfm_bfe_ip_nm_mullang_code2" style="width:100%;"/>
										</th>
										<td style="width: 32px;">
											<input class="oneBtn" popup_type="E" type="button" value="E" onclick="EnglishNotation('txtconfm_bfe_ip_nm_mullang_code2','txtconfm_bfe_ip_nm_mullang_code2_eng');"/>
										</td>
									</tr>
								</table>
								<input type="hidden" id="hdconfm_bfe_ip_nm_mullang_code2" />
								<label class="label_01" popup_type="Label" id="txtconfm_bfe_ip_nm_mullang_code2_eng" style="margin-top:1px;"></label>
							</td>

							<th>Pre-Approval IP Name3</th>
							<td>
								<table class="in_table">
									<tr>
										<th>
											<input type="text" id="txtconfm_bfe_ip_nm_mullang_code3" style="width:100%;"/>
										</th>
										<td style="width: 32px;">
											<input class="oneBtn" popup_type="E" type="button" value="E" onclick="EnglishNotation('txtconfm_bfe_ip_nm_mullang_code3','txtconfm_bfe_ip_nm_mullang_code3_eng');"/>
										</td>
									</tr>
								</table>
								<input type="hidden" id="hdconfm_bfe_ip_nm_mullang_code3" />
								<label class="label_01" popup_type="Label" id="txtconfm_bfe_ip_nm_mullang_code3_eng" style="margin-top:1px;"></label>
							</td>				
						</tr>
						<tr>
							<th>Approval Date</th>
							<td>
								<div class="dateBox">
									<input type="text"  id="txtconfm_dte" style="width:114px;"/>
								</div>
							</td>
							<th>Brand Name<span class='must_01'></span></th>				
							<td colspan="3">
								<table class="in_table">
									<tr>
										<th>
											<input type="text" id="txtprductnm_code" valireqire="Brand Name" style="width:100%;"/>
										</th>
										<td style="width: 32px;">
											<input class="oneBtn" popup_type="E" type="button" value="E"  onclick="EnglishNotation('txtprductnm_code','txtprductnm_code_eng');"/>
										</td>
									</tr>
								</table>
								<input type="hidden" id="hdprductnm_code" />
								<label class="label_01" popup_type="Label" id="txtprductnm_code_eng" style="margin-top:1px;"></label>
							</td>				
						</tr>	
						<tr>
							<th>Generic Name1</th>
							<td>
								<table class="in_table">
									<tr>
										<th>
											<input type="text" id="txtgnrl_nm_code1" style="width:100%;"/>
										</th>
										<td style="width: 32px;">
											<input class="oneBtn" popup_type="E" type="button" value="E" onclick="EnglishNotation('txtgnrl_nm_code1','txtgnrl_nm_code1_eng');"/>
										</td>
									</tr>
								</table>
								<input type="hidden" id="hdgnrl_nm_code1" />
								<label class="label_01" popup_type="Label" id="txtgnrl_nm_code1_eng" style="margin-top:1px;"></label>
							</td>
							<th>Generic Name2</th>
							<td>
								<table class="in_table">
									<tr>
										<th>
											<input type="text" id="txtgnrl_nm_code2" style="width:100%;"/>
										</th>
										<td style="width: 32px;">
											<input class="oneBtn" popup_type="E" type="button" value="E"  onclick="EnglishNotation('txtgnrl_nm_code2','txtgnrl_nm_code2_eng');">
										</td>
									</tr>
								</table>
								<input type="hidden" id="hdgnrl_nm_code2" />
								<label class="label_01" popup_type="Label" id="txtgnrl_nm_code2_eng" style="margin-top:1px;"></label>
							</td>
							<th>Generic Name3</th>
							<td>
								<table class="in_table">
									<tr>
										<th>
											<input type="text" id="txtgnrl_nm_code3" style="width:100%;"/>
										</th>
										<td style="width: 32px;">
											<input class="oneBtn" popup_type="E" type="button" value="E"  onclick="EnglishNotation('txtgnrl_nm_code3','txtgnrl_nm_code3_eng');">
										</td>
									</tr>
								</table>
								<input type="hidden" id="hdgnrl_nm_code3" />
								<label class="label_01" popup_type="Label" id="txtgnrl_nm_code3_eng" style="margin-top:1px;"></label>
							</td>
						</tr>
						<tr>
							<th>Commercially able</th>
							<td>								
								<select id="comava_at" style="width:100%;">
									<option value="">====선택====</option>
								</select>
							</td>
							<th>Original Manufacturer<span class='must_01'></span></th>
							<td colspan="3">					
								<select id="frst_mfbiz_code" style="width:70%;">
								    <option value="">====선택====</option>
								</select>
								
								<input type="checkbox" name="" id="not_applicable" ><label for="not_applicable" class="chcLab"><span>Not applicable</span></label>
							</td>				
						</tr>
						</tbody>				
					</table>



					<div style="height:20px;"></div>
					
					 


					<article style="position:relative;">
						<div class="conTitBtnL" style="font-family:'NanumGothicBold';display:inline-block; position:absolute; top:5px;">
							<h7>REPORT Setting</h7>
						</div>

						<div class="conTitBtnR">
							<input type="button" id="report_set_plus" value="추가" />
						</div>
					</article>


					<div style="height:5px; clear:both;"></div>

					<table id="report_set_table" class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="10%" />
							<col width="6%" />
							<col width="10%" />
							<col width="9%" />
							<col width="10%" />
							<col width="7%" />
							<col width="" />
							<col width="30px" />
						</colgroup>
						<tbody></tbody>			 
					</table>
				</article>
			</article>
			</div>
		</section>
		</div>
	</section>
</div>	
</form>
</body>
