<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/dragtable.css'/>">
<script src="<c:url value='/js/pantheon/common/jquery.dragtable.js'/>"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var set_sn = $("#frm_popup #SET_SN").val();
		$("#div_set_table").append($("#div_set" + set_sn).html());
		$("#div_set_table table tr").each(function(index, entry) {
			$(this).find("td").attr("onclick", "");
		});

		//$("#div_set_table table button").remove();

		$("#div_set_table table tr").each(function(index, entry) {
			$(this).find("td:last").remove();
		});

		$("#div_set_table table").dragtable();

		$("#div_set_table table tbody").sortable({
			placeholder : "ui-state-highlight",
			update : function(event, ui) {
				$("#div_set_table table tbody tr").each(function(index, entry) {
					$(this).find("input[name=set_vriabl_sn]").each(function(index2, entry2) {
						var item = {
							SET_VRIABL_SN : $(this).val(),
							SET_ROW_ORDR : (index + 1)
						};
						AUIGrid.updateRowsById(EDCK0209_grid2.id, item);
					});
				});
			}
		});
		$("#div_set_table table tbody").disableSelection();
	});
	function applyTable() {
		$("#div_set_table table tbody tr").each(function(index, entry) {
			var set_vriabl_ordr = 1;
			$(this).find("input[name=set_vriabl_sn]").each(function(index, entry) {
				var item = AUIGrid.getItemByRowId(EDCK0209_grid2.id, $(this).val());
				item.SET_VRIABL_ORDR = set_vriabl_ordr;
				AUIGrid.updateRowsById(EDCK0209_grid2.id, item);
				set_vriabl_ordr++;
			});

		});
		fn_layoutSorting(EDCK0209_grid2, false);

		$("#div_layout").empty();
		makeLayoutObject(EDCK0209_grid2);
		layerClose();
	}
</script>
<section class="popupWrap">
	<div class="popup wd1000">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="popup_conBoxInner">
				<h6>
					<spring:message code="edc.lbl.TABLE_SET" />
				</h6>
				<article class="mgT5">
					<form id="frm_popup" name="frm_popup">
						<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="${ VISIT_GROUP_SN }">
						<input type="hidden" id="SET_SN" name="SET_SN" value="${ SET_SN }">
					</form>
					<div id="div_set_table"></div>
				</article>
				<article class="mgT35">
					<div style="text-align: center">
						<input type="button" id="btnSave" value="<spring:message code="edc.btn.APPLY" />" onclick="applyTable()" />
						<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>




