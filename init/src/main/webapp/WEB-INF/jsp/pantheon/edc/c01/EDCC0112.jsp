<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<style>
table.tbl_query tr td {
	cursor: default !important;
}

span {
	cursor: default !important;
}
</style>
<script type="text/javascript">
	var EDCC0112_grid = {
		id : '',
		div : {
			gridDiv : '#EDCC0112_grid',
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
			url : './selectCRFLayoutList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : false,
			enableFilter : false,
			softRemoveRowMode : false,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "RN"
		},
		columnLayout : [ {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM"
		}, {
			dataField : "SET_ORDR",
			headerText : "SET_ORDR"
		}, {
			dataField : "SET_ROW_ORDR",
			headerText : "SET_ROW_ORDR"
		}, {
			dataField : "SET_VRIABL_ORDR",
			headerText : "SET_VRIABL_ORDR"
		}, {
			dataField : "INSTT_FORM_SN",
			headerText : "INSTT_FORM_SN"
		}, {
			dataField : "SUBJECT_NO",
			headerText : "SUBJECT_NO"
		}, {
			dataField : "VISIT_SN",
			headerText : "VISIT_SN"
		}, {
			dataField : "SN",
			headerText : "SN"
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN"
		}, {
			dataField : "SET_SN",
			headerText : "SET_SN"
		}, {
			dataField : "SET_ROW_SN",
			headerText : "SET_ROW_SN"
		}, {
			dataField : "SET_VRIABL_SN",
			headerText : "SET_VRIABL_SN"
		}, {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN"
		}, {
			dataField : "VRIABL_SN",
			headerText : "VRIABL_SN"
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN"
		}, {
			dataField : "SET_TY_CODE",
			headerText : "SET_TY_CODE"
		}, {
			dataField : "VRIABL_SE_CODE",
			headerText : "VRIABL_SE_CODE"
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE"
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO"
		}, {
			dataField : "DC_CN",
			headerText : "DC_CN"
		}, {
			dataField : "DC_FONT_CODE",
			headerText : "DC_FONT_CODE"
		}, {
			dataField : "DC_FONT_CODE_VALUE",
			headerText : "DC_FONT_CODE_VALUE"
		}, {
			dataField : "DC_FONT_MG",
			headerText : "DC_FONT_MG"
		}, {
			dataField : "DC_FONT_MG_VALUE",
			headerText : "DC_FONT_MG_VALUE"
		}, {
			dataField : "DC_LINK_CODE",
			headerText : "DC_LINK_CODE"
		}, {
			dataField : "DC_FONT_COLLR",
			headerText : "DC_FONT_COLLR"
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN"
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE"
		}, {
			dataField : "RN",
			headerText : "RN"
		}, {
			dataField : "VRIABL_ROW_SN",
			headerText : "VRIABL_ROW_SN"
		}, {
			dataField : "VRIABL_ROW_ORDR",
			headerText : "VRIABL_ROW_ORDR"
		}, {
			dataField : "STRE_VALUE",
			headerText : "STRE_VALUE"
		}, {
			dataField : "QUERY_SN",
			headerText : "QUERY_SN"
		}, {
			dataField : "QUERY_TY_CODE",
			headerText : "QUERY_TY_CODE"
		}, {
			dataField : "QUERY_STTUS_CODE",
			headerText : "QUERY_STTUS_CODE"
		}, {
			dataField : "QUERY_CN",
			headerText : "QUERY_CN"
		}, {
			dataField : "RESN",
			headerText : "RESN"
		}, {
			dataField : "QUERY_GROUP",
			headerText : "QUERY_GROUP"
		}, {
			dataField : "CRUD",
			headerText : "CRUD"
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	var EDCC0112_grid2 = {
		id : '',
		div : {
			gridDiv : '#EDCC0112_grid2',
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
			url : './selectCRFCommentList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : false,
			enableFilter : false,
			softRemoveRowMode : false,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "RN"
		},
		columnLayout : [ {
			dataField : "INSTT_FORM_SN",
			headerText : "INSTT_FORM_SN"
		}, {
			dataField : "SUBJECT_NO",
			headerText : "SUBJECT_NO"
		}, {
			dataField : "VISIT_SN",
			headerText : "VISIT_SN"
		}, {
			dataField : "SN",
			headerText : "SN"
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN"
		}, {
			dataField : "SET_SN",
			headerText : "SET_SN"
		}, {
			dataField : "SET_ROW_SN",
			headerText : "SET_ROW_SN"
		}, {
			dataField : "VRIABL_ROW_SN",
			headerText : "VRIABL_ROW_SN"
		}, {
			dataField : "CM_MSSAGE",
			headerText : "CM_MSSAGE"
		}, {
			dataField : "RN",
			headerText : "RN"
		}, {
			dataField : "CRUD",
			headerText : "CRUD"
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	var EDCC0112_grid3 = {
		id : '',
		div : {
			gridDiv : '#EDCC0112_grid3',
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
			url : './selectCRFQueryList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : false,
			enableFilter : false,
			softRemoveRowMode : false,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "QUERY_SN"
		},
		columnLayout : [ {
			dataField : "INSTT_FORM_SN",
			headerText : "INSTT_FORM_SN"
		}, {
			dataField : "SUBJECT_NO",
			headerText : "SUBJECT_NO"
		}, {
			dataField : "VISIT_SN",
			headerText : "VISIT_SN"
		}, {
			dataField : "SN",
			headerText : "SN"
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN"
		}, {
			dataField : "SET_ROW_SN",
			headerText : "SET_ROW_SN"
		}, {
			dataField : "VRIABL_ROW_SN",
			headerText : "VRIABL_ROW_SN"
		}, {
			dataField : "SET_VRIABL_SN",
			headerText : "SET_VRIABL_SN"
		}, {
			dataField : "QUERY_SN",
			headerText : "QUERY_SN"
		}, {
			dataField : "QUERY_TY_CODE",
			headerText : "QUERY_TY_CODE"
		}, {
			dataField : "QUERY_STTUS_CODE",
			headerText : "QUERY_STTUS_CODE"
		}, {
			dataField : "QUERY_CN",
			headerText : "QUERY_CN"
		}, {
			dataField : "RESN",
			headerText : "RESN"
		}, {
			dataField : "QUERY_GROUP",
			headerText : "QUERY_GROUP"
		}, {
			dataField : "CRUD",
			headerText : "CRUD"
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function popupCRFClose() {
		layerClose(1);
	}

	function makeLayoutView(sArr, crf_id) {
		var cnt = 1;
		$(sArr).each(function(index, entry) {
			if (entry.SET_TY_CODE == "01") {
				var item_count = 0;
				var set_row_sn = null;
				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				$(entry.row).each(function(index2, entry2) {
					$(entry2.varRow).each(function(index3, entry3) {
						var item = entry3.vriabl;
						item_count = item.length;
						var label = item[0].CRF_LBL_ONE;
						str += "<table class='tb004' ><tbody  id='tbd_set'>";
						str += "<tr name='" + entry2.SET_ROW_SN + "' id='set_row_sn'>";
						str += "<th style='width: 20%;'>" + label + "</th>";
						str += "<td>";
						str += fn_makeInputType(item[0], 1, item[0].RN, item[0].STRE_VALUE);
						str += "<input type='hidden' id='rn' name='rn' value='" + item[0].RN + "' />";
						if (item_count > 1) {
							str += "</td><td>";
							str += "<label>" + item[1].CDISC_SUBMIT_VALUE + "</label>";
							str += "<input type='hidden' id='rn' name='rn' value='" + item[1].RN + "' />";
						}
						str += "</td>";
						str += "<td style='width: 180px;'>";
						str += " <button type=\"button\" class=\"audit_01\" title=\"Audit\" >Audit</button>";
						str += "</td></tr>";

						str += "<tr name='tr_cmt" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='display : none;' id='tr_cmt'>";
						str += "<td colspan='" + (item_count + 2) + "'>";
						str += "<table style='width:100%;' id='tbl_cmt'><colgroup><col width='65px' /><col width='' /></colgroup><tr style='border:none;'>";
						str += "<td style='border:none;vertical-align:top;font-weight: bold;padding-top:8px;'>Comment</td>";
						str += "<td style='border:none;'><pre id='pre_cmt' style=' white-space:pre-wrap;'></pre></td>";
						str += "</tr></table>";
						str += "</td></tr>";

						str += "<tr name='tr_query" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='display : none;' id='tr_query'>";
						str += "<td colspan='" + (item_count + 2) + "'>";
						str += "<table class='tbl_query' style='width:100%;' id='tbl_query'><colgroup><col width='65px' /><col width='' /></colgroup>";
						str += "</table></td></tr>";
					});
				});
				str += "</tbody></table></div>";
				$("#" + crf_id).append(str);
			} else if (entry.SET_TY_CODE == "02" || entry.SET_TY_CODE == "04") {
				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				var item_count = 0;
				var row_count = 0;
				str += "<table class='tb004' >";
				$(entry.row).each(function(index2, entry2) {
					$(entry2.varRow).each(function(index3, entry3) {
						row_count++;
						if (index2 == 0 && index3 == 0) {
							str += "<thead><tr>";
							$(entry3.vriabl).each(function(index4, entry4) {
								var label = entry4.CRF_LBL_ONE;
								str += "<th>" + label + "</th>";
								item_count++;
							});
							str += "<td style='width: 180px;'>";
							str += "</td></tr></thead><tbody id='tbd_set' >";
						}
						str += "<tr name='" + entry3.SET_ROW_SN + "' id='set_row_sn'>";
						$(entry3.vriabl).each(function(index4, entry4) {
							str += "<td>";
							str += fn_makeInputType(entry4, row_count, entry4.RN, entry4.STRE_VALUE);
							str += "<input type='hidden' id='rn' name='rn' value='" + entry4.RN + "' />";
							str += "</td>";
						});
						str += "<td>";
						str += " <button type=\"button\" class=\"audit_01\" title=\"Audit\" >Audit</button>";
						str += "</td></tr>"

						str += "<tr name='tr_cmt" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='display : none;' id='tr_cmt'>";
						str += "<td colspan='" + (item_count + 1) + "'>";
						str += "<table style='width:100%;' id='tbl_cmt'><colgroup><col width='65px' /><col width='' /></colgroup><tr style='border:none;'>";
						str += "<td style='border:none;vertical-align:top;font-weight: bold;padding-top:8px;'>Comment</td>";
						str += "<td style='border:none;'><pre id='pre_cmt' style=' white-space:pre-wrap;'></pre></td>";
						str += "</tr></table>";
						str += "</td></tr>";

						str += "<tr name='tr_query" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='display : none;' id='tr_query'>";
						str += "<td colspan='" + (item_count + 1) + "'>";
						str += "<table class='tbl_query' style='width:100%;' id='tbl_query'><colgroup><col width='65px' /><col width='' /></colgroup>";
						str += "</table></td></tr>";

					});
				});
				str += "</tbody></table></div>";
				$("#" + crf_id).append(str);
			} else if (entry.SET_TY_CODE == "03") {
				fn_makeDescription(entry, crf_id, false);
			}
			cnt++;
		});
	}

	function showQueryView(grid3, crf_id) {
		var rowItems = AUIGrid.getGridData(grid3.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (rowItems[i].QUERY_STTUS_CODE == "01" && rowItems[i].STATUS == "OPEN") {
				if (rowItems[i].QUERY_CN && rowItems[i].QUERY_CN != "") {
					var tr_query = $("#" + crf_id + " tr[name=tr_query" + rowItems[i].SET_ROW_SN + "_" + rowItems[i].VRIABL_ROW_SN + "]");
					tr_query.show();
					var msg = rowItems[i].QUERY_CN;
					var str = "<tr>";
					str += "<td><pre id='pre_query' style='color : red; white-space:pre-wrap;'>" + msg + "</pre></td>";
					str += "</tr>";
					tr_query.find("[id=tbl_query]").append(str);
				}
			}
		}
	}

	$(document).ready(function() {
		EDCC0112_grid.createGrid();
		EDCC0112_grid2.createGrid();
		EDCC0112_grid3.createGrid();

		var param = fn_serializeObject($("#frm_popup"));
		EDCC0112_grid.proxy.param = param;
		EDCC0112_grid.load();
		var layout = fn_makeCRFObject(EDCC0112_grid);
		makeLayoutView(layout, "popup_crf_layout");

		EDCC0112_grid2.proxy.param = param;
		EDCC0112_grid2.load();
		fn_showComment(EDCC0112_grid2, "popup_crf_layout");

		EDCC0112_grid3.proxy.param = param;
		EDCC0112_grid3.load();
		showQueryView(EDCC0112_grid3, "popup_crf_layout");

		$("#popup_crf_layout [read]").prop("disabled", true);
	});
</script>
<section class="popupWrap">
	<div class="popup popup1 wd1200">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="popup_conBoxInner">
				<form id="frm_popup" name="frm_popup">
					<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
					<input type="hidden" id="INSTT_FORM_SN" name="INSTT_FORM_SN" value="${ INSTT_FORM_SN }">
					<input type="hidden" id="SUBJECT_NO" name="SUBJECT_NO" value="${ SUBJECT_NO }">
					<input type="hidden" id="VISIT_SN" name="VISIT_SN" value="${ VISIT_SN }">
					<input type="hidden" id="SN" name="SN" value="${ SN }">
					<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="${ VISIT_GROUP_SN }">
				</form>

				<div style="height: 600px; border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc; overflow-y: scroll;">
					<article id="popup_crf_layout"></article>
				</div>
				<div id="EDCC0112_grid" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>
				<div id="EDCC0112_grid2" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>
				<div id="EDCC0112_grid3" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>

				<article class="mgT10">
					<div style="text-align: center">
						<input type="button" value="<spring:message code="btn.close" />" onclick="popupCRFClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>




