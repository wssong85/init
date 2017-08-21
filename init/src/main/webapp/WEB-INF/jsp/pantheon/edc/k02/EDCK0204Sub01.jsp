<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<style>
</style>
<script type="text/javascript">
	var EDCK0204Sub01_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : "EDCK0204Sub01_grid",
			paging : {
				pagingDiv : 'EDCK0204Sub01_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectCDISCCodeList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : false,
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "CL_CODE_SN"
		},
		columnLayout : [ {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_RULE_SN",
			headerText : "CDISC_RULE_SN",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_UPPER_CODE",
			headerText : "CDISC_UPPER_CODE",
			editable : false
		}, {
			dataField : "CDISC_CODE",
			headerText : "CDISC_CODE",
			editable : false
		}, {
			dataField : "CODE_NM",
			headerText : "CODE_NM",
			editable : false
		}, {
			dataField : "ESTN_POSBL_AT",
			headerText : "ESTN_POSBL_AT",
			editable : false
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE",
			editable : false
		}, {
			dataField : "CDISC_SYNONM",
			headerText : "CDISC_SYNONM",
			editable : false
		}, {
			dataField : "CDISC_DFN",
			headerText : "CDISC_DFN",
			editable : false
		}, {
			dataField : "NCI_NM",
			headerText : "NCI_NM",
			editable : false
		} ],
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;
			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			me.binding();
			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;
			AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
				choiceCode();
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	$(function() {
		var popgrid_param = new Object();
		popgrid_param.TASK_SN = $("#frm_popup #TASK_SN").val();
		popgrid_param.CDISC_UPPER_CODE = $("#frm_popup #CDISC_UPPER_CODE").val();
		EDCK0204Sub01_grid.proxy.param = popgrid_param;
		EDCK0204Sub01_grid.createGrid();
	});
	function choiceCode() {
		if ($("#frm_popup #PAGE").val() == "EDCK0204") {
			var msg = null;
			var selectedItems = AUIGrid.getSelectedItems(EDCK0204Sub01_grid.id);
			if (selectedItems.length > 0) {
				var selectedItem = selectedItems[0].item;

				var rowItems = AUIGrid.getGridData(EDCK0204_grid3.id);
				for (var i = 0; i < rowItems.length; i++) {
					var rowItem = rowItems[i];
					if (rowItem.DOMN_VRIABL_SN == $("#frm_popup #DOMN_VRIABL_SN").val()) {
						if (rowItem.CL_CODE_SN == selectedItem.CL_CODE_SN) {
							msg = selectedItem.CDISC_SUBMIT_VALUE + "\n";
							msg += "은 이미 선택된 코드리스트";
						}
					}
				}
				if (msg != null) {
					alert(msg);
				} else {
					var item = {
						VRIABL_SN : $("#frm_popup #VRIABL_SN").val(),
						CL_CODE_SN : selectedItem.CL_CODE_SN,
						CDISC_SUBMIT_VALUE : selectedItem.CDISC_SUBMIT_VALUE
					};
					AUIGrid.updateRowsById(EDCK0204_grid3.id, item, true);
					layerClose();
				}
			} else {
				alert('<spring:message code="edc.notSelect.msg" />');
			}
		} else {
			var msg = null;
			var selectedItems = AUIGrid.getSelectedItems(EDCK0204Sub01_grid.id);
			if (selectedItems.length > 0) {
				var selectedItem = selectedItems[0].item;
				var rn = $("#frm_popup #RN").val();
				var domn_vriabl_sn = $("#frm_popup #DOMN_VRIABL_SN").val()
				var rowItem = AUIGrid.getItemByRowId(EDCK0208_grid.id, rn);
				var row_group_sn = rowItem.GROUP_SN
				row_group_sn = row_group_sn.substring(row_group_sn.indexOf("_") + 1, row_group_sn.length);
				var visit_rowItems = AUIGrid.getItemsByValue(EDCK0208_grid.id, "VISIT_SN", rowItem.VISIT_SN);
				for (var i = 0; i < visit_rowItems.length; i++) {
					var visit_group_sn = visit_rowItems[i].GROUP_SN
					visit_group_sn = visit_group_sn.substring(visit_group_sn.indexOf("_") + 1, visit_group_sn.length);
					if (visit_group_sn == row_group_sn) {
						if (visit_rowItems[i].DOMN_VRIABL_SN == domn_vriabl_sn && visit_rowItems[i].CL_CODE_SN == selectedItem.CL_CODE_SN) {
							msg = visit_rowItems[i].VRIABL_NM + " - " + selectedItem.CDISC_SUBMIT_VALUE + "\n";
							msg += "은 이미 선택된 코드리스트";
							break;
						}
					}
				}
				if (msg != null) {
					alert(msg);
				} else {
					var item = {
						RN : rn,
						CL_CODE_SN : selectedItem.CL_CODE_SN,
						CDISC_SUBMIT_VALUE : selectedItem.CDISC_SUBMIT_VALUE
					};
					var cl_code_sn = $("#frm_popup #CL_CODE_SN").val();
					if (cl_code_sn == "") {
						cl_code_sn = null;
					}
					var rowItems = AUIGrid.getGridData(EDCK0208_grid.id);
					for (var i = 0; i < rowItems.length; i++) {
						var group_sn = rowItems[i].GROUP_SN
						group_sn = group_sn.substring(group_sn.indexOf("_") + 1, group_sn.length);
						if (group_sn == row_group_sn && rowItems[i].DOMN_VRIABL_SN == domn_vriabl_sn && rowItems[i].CL_CODE_SN == cl_code_sn) {
							AUIGrid.updateRow(EDCK0208_grid.id, item, i);
							break;
						}
					}
					layerClose();
				}
			} else {
				alert('<spring:message code="edc.notSelect.msg" />');
			}
		}
	}
</script>

<section class="popupWrap">
	<!-- 팝업 시작 -->
	<!-- 팝업 세로는 자동지정이지만, 가로는 지정해줘야한다. wd00의 00은 픽셀 사이즈 1~100은 1단위, 1000은 10단위-->
	<!-- popup01은 popup-button01에 맞추는등, 숫자를 맞춰준다 -->
	<div class="popup popup01 wd800">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="conBoxInner">
				<!-- 팝업 내부 컨텐츠 시작 -->
				<article class="conTitBox">
					<h5>CDISC Code List</h5>
				</article>
				<article>
					<!-- 에이유아이 그리드가 이곳에 생성 -->
					<div id="EDCK0204Sub01_grid" class="gridHeiSz05 grid_wrap tb01_2"></div>
				</article>
				<article class="mgT35">
					<div style="position: absolute; right: 20px; bottom: 20px;">
						<input type="button" value="<spring:message code="btn.select" />" onclick="choiceCode();">
						<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose();">
					</div>
				</article>
				<form id="frm_popup" name="frm_popup">
					<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
					<input type="hidden" id="VRIABL_SN" name="VRIABL_SN" value="${ VRIABL_SN }">
					<input type="hidden" id="DOMN_VRIABL_SN" name="DOMN_VRIABL_SN" value="${ DOMN_VRIABL_SN }">
					<input type="hidden" id="CL_CODE_SN" name="CL_CODE_SN" value="${ CL_CODE_SN }">
					<input type="hidden" id="CDISC_UPPER_CODE" name="CDISC_UPPER_CODE" value="${ CDISC_UPPER_CODE }">
					<input type="hidden" id="PAGE" name="PAGE" value="${ PAGE }">
					<input type="hidden" id="RN" name="RN" value="${ RN }">
				</form>
				<!-- 팝업 내부 컨텐츠 끝 -->
			</div>
		</section>
	</div>
	<!-- 팝업 끝 -->
</section>
<!-- 팝업 wrap 끝 -->