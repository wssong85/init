<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
	function processConfirm(){
		var params = g_rowData;
		
		if($('#QUERY_CN').val().trim() == ""){
			alert('<spring:message code="edcg0104.msg.QUERY_CN_IS_NULL" />');
			return false;
		}
		
		params.MODULE_CODE 		= "EDC";
		params.END_AT 			= "N";
		params.QUERY_STTUS_CODE = "04";
		params.QUERY_TY_CODE 	= "02";
		params.USE_AT 			= "Y";
		params.USER_ID			= _userId;
		params.CRA_CNFIRM_CODE	= "03";
		params.QUERY_CN			= $('#QUERY_CN').val();
		
		console.log("params : "+params);
		
		var arJson = params;
		$.ajax({
			url : "<c:url value='/edc/g01/insertCmQueryByCra.do'/>",
			type : 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(arJson),
			success : function(data, textStatus, jqXHR){
				if(data.success){
					layerClose();
					grid_csList.load();
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
<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="conBoxInner">
				<!-- 팝업 내부 컨텐츠 시작 -->
				<article class="conTitBox">
					<h5><spring:message code="edcg0104.title.QUERY_PUBLISH" /></h5><!-- 쿼리 발행 -->
				</article>

				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<table class="tb001">
							<colgroup>
								<col width="20%">
								<col width="">
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="edcg0104.title.QUERY_CN" /><span class='must_01'></th><!-- 쿼리 내용 -->
									<td style="padding: 7px 7px 7px 7px; background:#ffffff;">
										<textarea id="QUERY_CN" name="QUERY_CN" rows="4" style="width: 100%;"></textarea>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</article>
				<article class="mgT10">
					<div style="text-align: center">
						<input type="button" onClick="processConfirm();" value='<spring:message code="edcg01.gr.RSRCH_CODING" />'/> <!-- 확인 -->
						<input type="button" value='<spring:message code="button.reset" />' onclick="layerClose();"><!-- 취소 -->
					</div>
				</article>
			</div>
		</section>
	</div>
</section>