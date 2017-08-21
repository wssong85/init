<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
</style>

<script type="text/javascript">
	var EDCK0209Sub01_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0209Sub01_grid',
			paging : {
				pagingDiv : '',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectSameVariable.do',
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
			softRemoveRowMode : false,
			headerHeight : 40,
			rowHeight : 37,
			editableOnFixedCell : true,
			//fixedColumnCount : 8,
			selectionMode : "singleRow",
			rowIdField : "VRIABL_SN"
		},
		columnLayout : [ {
			dataField : "SET_VRIABL_SN",
			headerText : "SET_VRIABL_SN",
			visible : false
		}, {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN",
			visible : false
		}, {
			dataField : "VRIABL_SN",
			headerText : "VRIABL_SN",
			visible : false
		}, {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM"
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN",
			visible : false
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE"
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
				changeVariable();
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	$(document).ready(function() {
		var grid_param = new Object();
		grid_param.TASK_SN = $("#frm_popup #TASK_SN").val();
		grid_param.EDC_VER = $("#frm_popup #EDC_VER").val();
		grid_param.VISIT_GROUP_SN = $("#frm_popup #VISIT_GROUP_SN").val();
		grid_param.DOMN_VRIABL_SN = $("#frm_popup #DOMN_VRIABL_SN").val();
		grid_param.SET_VRIABL_SN = $("#frm_popup #SET_VRIABL_SN").val();

		EDCK0209Sub01_grid.proxy.param = grid_param;
		EDCK0209Sub01_grid.createGrid();
	});
	function changeVariable() {
		var selectedItems = AUIGrid.getSelectedItems(EDCK0209Sub01_grid.id);
		var rowItem = selectedItems[0].item;
		AUIGrid.updateRowsById(EDCK0209_grid2.id, rowItem);
		var set_sn = $("#frm_popup #SET_SN").val();
		$("#div_set" + set_sn).find("input[name=set_vriabl_sn]").each(function(index, entry) {
			if ($(this).val() == rowItem.SET_VRIABL_SN) {
				$(this).parent().find("#var_value" + rowItem.SET_VRIABL_SN).val(rowItem.CDISC_SUBMIT_VALUE);
				$(this).parent().find("#var_value" + rowItem.SET_VRIABL_SN).parent().find("label").text(rowItem.CDISC_SUBMIT_VALUE);
			}
		});
		layerClose();
	}
</script>
<section class="popupWrap">
	<div class="popup wd400">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="popup_conBoxInner">
				<div id="tab2" class="tab tab01">
					<ul>
						<li id="tab_menu1" class="port_back2 tab_menu2">Variable</li>
						<li id="tab_menu2" class="tab_menu2" onclick="tapChangeVariable('EDCK0209Sub01');">입력방식</li>
					</ul>
				</div>
				<form id="frm_popup" name="frm_popup">
					<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
					<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
					<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="${ VISIT_GROUP_SN }">
					<input type="hidden" id="SET_SN" name="SET_SN" value="${ SET_SN }">
					<input type="hidden" id="SET_VRIABL_SN" name="SET_VRIABL_SN" value="${ SET_VRIABL_SN }">
					<input type="hidden" id="DOMN_VRIABL_SN" name="DOMN_VRIABL_SN" value="${ DOMN_VRIABL_SN }">
				</form>
				<article class="mgT16">
					<div id="EDCK0209Sub01_grid" class="gridHeiSz04 grid_wrap tb01_2"></div>
				</article>

				<table class="tb004">
					<c:forEach items="${ EDC019 }" var="list">
						<tr>
							<td>${ list.CODE }</td>
							<td>${ list.VALUE }</td>
						</tr>
					</c:forEach>
				</table>

				<article class="mgT35">
					<div style="position: absolute; right: 20px; bottom: 20px;">
						<input type="button" value="<spring:message code="btn.select" />" onclick="changeVariable();">
						<input type="button" value="<spring:message code="btn.close" />" onclick="layerClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>