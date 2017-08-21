<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script src="<c:url value="/js/pantheon/edc/edc.js" />"></script>

<title>EDC</title>



<style>
.uk_date {
	font-size: 10px !important;
}

table.tb004 {
	width: 100%;
	border-top: 1px solid #7287e4;
	margin-bottom: 5px;
}

table.tb004 th {
	color: #333;
	border-right: 1px solid #e6e6e6;
	border-left: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	font-family: 'NanumGothicBold';
	background: #f6f7ff;
	height: 28px;
	font-size: 12px;
	line-height: 15px;
	padding: 3px 4px 3px 4px;
	text-align: center;
	vertical-align: middle;
	Letter-spacing: 0px;
	box-sizing: border-box;
}

table.tb004 td {
	font-family: 'NanumGothic';
	border-right: 1px solid #e6e6e6;
	border-left: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	color: #555;
	background: #FFFFFF;
	height: 36px;
	padding: 4px 4px 4px 4px;
	vertical-align: middle;
	font-size: 12px;
	Letter-spacing: 0px;
	box-sizing: border-box;
}

table.tb004 tr:last-child {
	border-bottom: 1px solid #e6e6e6;
}

table.tb004 tr:last-child td {
	border-bottom: 0px;
}

table.tb004_no_border, table.tb004_no_border tr, table.tb004_no_border th, table.tb004_no_border td {
	border: none !important;
}

table.tbl_query tr td {
	border: none !important;
	cursor: pointer;
}

table.tbl_query td.crf_query_status {
	text-align: center;
	vertical-align: top;
	font-weight: bold;
	padding-top: 8px;
}
</style>



<script type="text/javascript">
	var isChange = false;

	$(document).ready(function() {
		EDCC0106_grid.createGrid();
		EDCC0106_grid2.createGrid();
		EDCC0106_grid3.createGrid();

		fn_conResize();
		//내용부분 카테고리 닫기
		$(".con_category_close").click(function() {
			$(".con_category_close").hide();
			$(".con_category_open").show();
			$(".depth_01").addClass("hidden");
			$(".con_category_01").addClass("con_category_01_reduce");
			$(".con_category_01 .depth_02").addClass("depth_02_move");
			$(".dumi_01").addClass("dumi_01_move");
			$(".contents_01_in").addClass("contents_01_move");

			/* if ($('.grid_wrap') && $('.grid_wrap').length) {
				for (var i = 0; i < $('.grid_wrap').length; i++) {
					try {
						fn_lnbResize($('.grid_wrap')[i].id);
					} catch (e) {
					}
				}
			} */

		});

		$(".con_category_open").click(function() {
			$(".con_category_open").hide();
			$(".con_category_close").show();
			$(".depth_01").removeClass("hidden");
			$(".con_category_01").removeClass("con_category_01_reduce");
			$(".con_category_01 .depth_02").removeClass("depth_02_move");
			$(".dumi_01").removeClass("dumi_01_move");
			$(".contents_01_in").removeClass("contents_01_move");

			/* if ($('.grid_wrap') && $('.grid_wrap').length) {
				for (var i = 0; i < $('.grid_wrap').length; i++) {
					try {
						fn_lnbResize($('.grid_wrap')[i].id);
					} catch (e) {
					}
				}
			} */

		});

		var instt_form_sn = $("#frm_main #INSTT_FORM_SN").val();
		var subject_no = $("#frm_main #SUBJECT_NO").val();

		$(".depth_01 > dd > a").each(function(index, entry) {
			var no = $(this).find("span").text();
			if (subject_no == no) {
				$(this).find("span").eq(0).trigger("click");
			}
		});

		$(window).on("beforeunload", function() {
			if (isChange)
				return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
		});
	});

	//화면 로드, 리사이즈, 스크롤
	$(window).load(function() {
		fn_conResize();
	});

	$(window).resize(function() {
		fn_conResize();
	});

	$(window).scroll(function() {
		fn_conResize();
	});

	var EDCC0106_grid = {
		id : '',
		div : {
			gridDiv : '#EDCC0106_grid',
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
	var EDCC0106_grid2 = {
		id : '',
		div : {
			gridDiv : '#EDCC0106_grid2',
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
			dataField : "ATRAIL_SN",
			headerText : "ATRAIL_SN"
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
	var EDCC0106_grid3 = {
		id : '',
		div : {
			gridDiv : '#EDCC0106_grid3',
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
			dataField : "STATUS",
			headerText : "STATUS"
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

	var left_click = false;
	function choiceSubject(instt_form_sn, subject_no, subject_count, obj) {
		$(obj).addClass("open").next("dl").slideDown("fast");

		//나머지 닫힘
		$(".depth_01 > dd > a").not(obj).removeClass("open").next("dl").slideUp("fast");
		$(".depth_02 > dd > a").not(obj).removeClass("open").next("dl").slideUp("fast");

		left_click = false;
		fn_getCRFVisitList(instt_form_sn, subject_no, subject_count, './selectCRFVisitList.do');
	}

	function getCRFPage(visit_sn, sn, visit_group_sn, subject_count, visit_count, group_count) {
		var con = true;
		if (isChange) {
			con = confirm("이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.");
		}
		if (!isChange || con) {
			$("#crf_layout").empty();

			$("#frm_main #VISIT_SN").val(visit_sn);
			$("#frm_main #SN").val(sn);
			$("#frm_main #VISIT_GROUP_SN").val(visit_group_sn);
			$("#frm_main #subject_count").val(subject_count);
			$("#frm_main #visit_count").val(visit_count);
			$("#frm_main #group_count").val(group_count);

			fn_categoryView(subject_count, visit_count, group_count);

			var param = fn_serializeObject($("#frm_main"));

			EDCC0106_grid.proxy.param = param;
			EDCC0106_grid.load();
			var layout = fn_makeCRFObject(EDCC0106_grid);
			makeLayoutInput(layout, "crf_layout", EDCC0106_grid);
			showCalendar(EDCC0106_grid);

			EDCC0106_grid2.proxy.param = param;
			EDCC0106_grid2.load();
			fn_showComment(EDCC0106_grid2, "crf_layout");

			EDCC0106_grid3.proxy.param = param;
			EDCC0106_grid3.load();
			showQuery(EDCC0106_grid3, "crf_layout", 1);

			fn_inputControl("div_main_btn", "frm_main", "crf_layout");

			fn_conResize();

			$("input, select, radio").change(function() {
				isChange = true;
			});
		}
	}

	function showCalendar(grid) {
		var rowItems = AUIGrid.getGridData(grid.id);
		if (rowItems.length > 0) {
			for (var i = 0; i < rowItems.length; i++) {
				if (rowItems[i].VRIABL_SE_CODE == '05') {
					fn_ukDatepicker("var_value" + rowItems[i].RN);
				}
			}
		}
	}

	function fn_inputControl(btn_id, frm_id, crf_id) {
		var param = $("#" + frm_id).serialize();
		$.ajax({
			url : './selectGroupInfo.do',
			data : param,
			async : false,
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					if (data.result.GROUP_SE_CODE == "05") {//전자서명 그룹
						$("#frm_main #GROUP_SE_CODE").val(data.result.GROUP_SE_CODE);
						$("#" + crf_id + " [read]").prop("disabled", true);
						if (data.result.ELTSGN_STTUS_CODE == "03") {//전자서명완료
							$("#" + btn_id + " #btn_reset").show();
							$("#" + btn_id + " #btn_temp_save").hide();
							$("#" + btn_id + " #btn_save").hide();
						} else {
							$("#" + btn_id + " #btn_reset").hide();
							$("#" + btn_id + " #btn_temp_save").hide();
							$("#" + btn_id + " #btn_save").show();
						}
					} else {
						if (data.result.STRE_CODE == "02") {//저장
							$("#" + crf_id + " [read]").prop("disabled", true);
							$("#" + btn_id + " #btn_reset").show();
							$("#" + btn_id + " #btn_temp_save").hide();
							$("#" + btn_id + " #btn_save").show();
						} else if (data.result.STRE_CODE == "03") {//임시저장
							$("#" + crf_id + " [read]").prop("disabled", true);
							$("#" + btn_id + " #btn_reset").show();
							$("#" + btn_id + " #btn_temp_save").hide();
							$("#" + btn_id + " #btn_save").show();
						} else {
							$("#" + btn_id + " #btn_reset").hide();
							$("#" + btn_id + " #btn_temp_save").show();
							$("#" + btn_id + " #btn_save").show();
						}
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

	function makeLayoutInput(sArr, crf_id, grid) {
		grid = (grid.id).replace("#", "");
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
						str += "<button type=\"button\" class=\"edit_01\" onclick=\"rowEditMode(this);\" title=\"";
						str += '<spring:message code="btn.update" />';
						str += "\" >";
						str += '<spring:message code="btn.update" />';
						str += "</button>";
						str += " <button type=\"button\" class=\"comment_01\" title=\"Comment\" onclick=\"inputComment('" + crf_id + "','" + entry2.SET_ROW_SN + "','" + entry3.VRIABL_ROW_SN + "');\" >Comment</button>";
						str += " <button type=\"button\" class=\"audit_01\" title=\"Audit\" >Audit</button>";
						str += "</td></tr>";

						str += "<tr name='tr_cmt" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='display : none;' id='tr_cmt'>";
						str += "<td colspan='" + (item_count + 2) + "'>";
						str += "<textarea name='cmt_" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='width : 100%;' ></textarea>";
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
							str += "<button type=\"button\"  class=\"edit_01\" onclick=\"tableEditMode('" + crf_id + "', " + entry.SET_SN + "," + grid + ");\" title=\"";
							str += '<spring:message code="btn.update" />';
							str += "\" >";
							str += '<spring:message code="btn.update" />';
							str += "</button>";
							if (entry.SET_TY_CODE == "02") {
								str += " <button type=\"button\" class=\"add_01\" onclick=\"addTr('" + crf_id + "', '" + entry.SET_SN + "', " + grid + ");\" title=\"행추가\" >행추가</button>";
							} else {
							}
							str += "</td></tr></thead><tbody id='tbd_set' >";
						}
						str += "<tr name='" + entry2.SET_ROW_SN + "' id='set_row_sn'>";
						$(entry3.vriabl).each(function(index4, entry4) {
							str += "<td>";
							str += fn_makeInputType(entry4, row_count, entry4.RN, entry4.STRE_VALUE);
							str += "<input type='hidden' id='rn' name='rn' value='" + entry4.RN + "' />";
							str += "</td>";
						});
						str += "<td>";
						str += "<button type=\"button\" class=\"edit_01\" onclick=\"rowEditMode(this, " + grid + ");\" title=\"";
						str += '<spring:message code="btn.update" />';
						str += "\" >";
						str += '<spring:message code="btn.update" />';
						str += "</button>";
						str += " <button type=\"button\" class=\"del_01\" onclick=\"deleteRow('" + entry.SET_SN + "', '" + entry2.SET_ROW_SN + "', '" + entry3.VRIABL_ROW_SN + "');\" title=\"삭제\" >삭제</button>";
						str += " <button type=\"button\" class=\"comment_01\" title=\"Comment\" onclick=\"inputComment('" + crf_id + "','" + entry2.SET_ROW_SN + "', '" + entry3.VRIABL_ROW_SN + "');\" >Comment</button>";
						str += " <button type=\"button\" class=\"audit_01\" title=\"Audit\" >Audit</button>";
						str += "</td></tr>"

						str += "<tr name='tr_cmt" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='display : none;' id='tr_cmt'>";
						str += "<td colspan='" + (item_count + 1) + "'>";
						str += "<textarea name='cmt_" + entry2.SET_ROW_SN + "_" + entry3.VRIABL_ROW_SN + "' style='width : 100%;' ></textarea>";
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
				fn_makeDescription(entry, crf_id, true);
			}
			cnt++;
		});
	}

	function addTr(crf_id, set_sn, grid) {
		grid = (grid.id).replace("#", "");

		var set_row_ordr = 1;
		var set_vriabl_ordr = 1;
		var row_count = 1;
		$("#" + crf_id + " #div_set" + set_sn).find("[id=tbd_set] [seq]").each(function(index, entry) {
			row_count++;
		});
		var set_row_sn = $("#" + crf_id + " #div_set" + set_sn).find("#set_row_sn").attr("name");
		var vriabl_row_sn = fn_createGuid();
		var str = "<tr name='" + set_row_sn + "' id='set_row_sn'>";
		var items = AUIGrid.getItemsByValue(grid.id, "SET_SN", set_sn);
		var item_count = 0;
		$("#" + crf_id + " #div_set" + set_sn).find("[id=tbd_set] tr:first").find("input[name=rn]").each(function(index2, entry2) {
			for (var i = 0; i < items.length; i++) {
				var item = items[i];
				item.VRIABL_ROW_SN = vriabl_row_sn;
				if (item.RN == $(this).val()) {
					item.VRIABL_ROW_ORDR = row_count;
					item.STRE_VALUE = null;
					AUIGrid.addRow(EDCC0106_grid.id, item, "first");
					var row = AUIGrid.getItemByRowIndex(grid.id, 0);
					str += "<td>";
					str += fn_makeInputType(row, row_count, row.RN);
					str += "<input type='hidden' id='rn' name='rn' value='" + row.RN + "' />";
					str += "</td>";
					break;
				}
			}
			item_count++;
		});
		str += "<td>";
		str += "<button type=\"button\" class=\"edit_01\" onclick=\"rowEditMode(this, " + grid + ");\" title=\"";
		str += '<spring:message code="btn.update" />';
		str += "\" >";
		str += '<spring:message code="btn.update" />';
		str += "</button>";
		str += " <button type=\"button\" class=\"del_01\" onclick=\"deleteRow('" + set_sn + "', '" + set_row_sn + "');\" title=\"삭제\" >삭제</button>";
		str += " <button type=\"button\" class=\"comment_01\" title=\"Comment\" onclick=\"inputComment('" + crf_id + "','" + set_row_sn + "', '" + vriabl_row_sn + "');\" >Comment</button>";
		str += " <button type=\"button\" class=\"audit_01\" title=\"Audit\" >Audit</button>";
		str += "</td></tr>";

		str += "<tr name='tr_cmt" + set_row_sn + "_" + vriabl_row_sn + "' style='display : none;' id='tr_cmt'>";
		str += "<td colspan='" + (item_count + 1) + "'>";
		str += "<textarea name='cmt_" + set_row_sn + "_" + vriabl_row_sn + "' style='width : 100%;' ></textarea>";
		str += "<table style='width:100%;' id='tbl_cmt'><colgroup><col width='65px' /><col width='' /></colgroup><tr style='border:none;'>";
		str += "<td style='border:none;text-align: center;vertical-align:top;font-weight: bold;padding-top:8px;'>Comment</td>";
		str += "<td style='border:none;'><pre id='pre_cmt' style=' white-space:pre-wrap;'></pre></td>";
		str += "</tr></table>";
		str += "</td></tr>";

		str += "<tr name='tr_query" + set_row_sn + "_" + vriabl_row_sn + "' style='display : none;' id='tr_query'>";
		str += "<td colspan='" + (item_count + 1) + "'>";
		str += "<table class='tbl_query' style='width:100%;' id='tbl_query'><colgroup><col width='65px' /><col width='' /></colgroup>";
		str += "</table></td></tr>";

		$("#" + crf_id + " #div_set" + set_sn).find("[id=tbd_set]").append(str);
	}
	function tableEditMode(crf_id, set_sn, grid) {
		var b = true;
		$("#" + crf_id + " #div_set" + set_sn).find("[read]").each(function(index, entry) {
			if (!$(this).prop("disabled")) {
				b = false;
			}
		});
		if (b) {
			$("#" + crf_id + " #div_set" + set_sn).find("[read]").prop("disabled", false);
		} else {
			$("#" + crf_id + " #div_set" + set_sn).find("[read]").each(function(index, entry) {
				var rn = $(this).attr("name");
				var item = AUIGrid.getItemByRowId(grid.id, rn);
				$(this).val(item.STRE_VALUE);
			});
			$("#" + crf_id + " #div_set" + set_sn).find("[read]").prop("disabled", true);
		}
	}
	function rowEditMode(obj, grid) {
		if ($(obj).parent().parent().find("[read]").prop("disabled")) {
			$(obj).parent().parent().find("[read]").prop("disabled", false);
		} else {
			$(obj).parent().parent().find("[read]").each(function(index, entry) {
				var rn = $(this).attr("name");
				var item = AUIGrid.getItemByRowId(grid.id, rn);
				$(this).val(item.STRE_VALUE);
			});
			$(obj).parent().parent().find("[read]").prop("disabled", true);
		}
	}
	function showQuery(grid3, crf_id, popup_order) {
		var rowItems = AUIGrid.getGridData(grid3.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (rowItems[i].QUERY_STTUS_CODE == "01" && rowItems[i].STATUS == "OPEN") {
				if (rowItems[i].QUERY_CN && rowItems[i].QUERY_CN != "") {
					var tr_query = $("#" + crf_id + " tr[name=tr_query" + rowItems[i].SET_ROW_SN + "_" + rowItems[i].VRIABL_ROW_SN + "]");
					tr_query.show();
					var msg = rowItems[i].QUERY_CN;
					var str = "<tr onclick=\"popupQueryAnswer('" + rowItems[i].QUERY_SN + "', " + popup_order + ", '" + crf_id + "')\" >";
					//str += "<td>" + rowItems[i].QUERY_TY + " " + rowItems[i].QUERY_STTUS + "</td>";
					str += "<td><pre id='pre_query' style='color : red; white-space:pre-wrap;'>" + msg + "</pre></td>";
					str += "</tr>";
					tr_query.find("[id=tbl_query]").append(str);
				}
			}
		}
	}
	function popupQueryAnswer(query_sn, popup_order, crf_id) {
		var param = {};
		param.QUERY_SN = query_sn;
		param.POPUP_ORDER = popup_order;
		param.CRF_ID = crf_id;
		mkLayerPopupOpen("/edc/c01/popupEDCC0106Sub01.do", param, 1);
	}
	function inputComment(crf_id, set_row_sn, vriabl_row_sn) {
		var tr_cmt = $("#" + crf_id + " tr[name=tr_cmt" + set_row_sn + "_" + vriabl_row_sn + "]");
		if (tr_cmt.find("textarea").attr("id") == "cmt") {
			if (tr_cmt.find("textarea").css("display") != "none") {
				tr_cmt.find("#tbl_cmt").show();
				tr_cmt.find("textarea").hide();
				tr_cmt.find("textarea").val(tr_cmt.find("#pre_cmt").text());
			} else {
				tr_cmt.find("#tbl_cmt").hide();
				tr_cmt.find("textarea").show();
			}
		} else {
			if (tr_cmt.css("display") != "none") {
				tr_cmt.hide();
				tr_cmt.find("#tbl_cmt").show();
				tr_cmt.find("textarea").hide();
				tr_cmt.find("textarea").val("");
			} else {
				tr_cmt.show();
				tr_cmt.find("#tbl_cmt").hide();
				tr_cmt.find("textarea").show();
			}
		}
	}

	function saveCRFPage(btn_id, frm_id, crf_id, stre_code, grid, grid2, grid3) {
		$("#" + frm_id + " #STRE_CODE").val(stre_code);

		var group_se_code = $("#frm_main #GROUP_SE_CODE").val();
		if (group_se_code == "05") {
			var param = fn_serializeObject($("#" + frm_id));
			param.type = "CRF_VISIT";
			mkLayerPopupOpen("/edc/e01/popupEDCE0103.do", param);
		} else {
			//Variable
			if (stre_code == "01") {
				$("#" + crf_id + " [id^=var_value]").each(function(index, entry) {
					var rn = $(this).attr("name");
					var item = AUIGrid.getItemByRowId(grid.id, rn);
					item.STRE_VALUE = null;
					AUIGrid.updateRowsById(grid.id, item);
				});
			} else {
				$("#" + crf_id + " [id^=var_value]").each(function(index, entry) {
					var rn = $(this).attr("name");
					var item = AUIGrid.getItemByRowId(grid.id, rn);
					var value = $(this).val();
					if (value == "") {
						value = null;
					}

					if ($(this).is("input[type=text][analyte]")) {
						if (item.STRE_VALUE != value) {
							item.STRE_VALUE = item.CL_CODE_SN;
							AUIGrid.updateRowsById(grid.id, item);
						}
					} else if ($(this).is("input[type=text][save]")) {
						if (item.STRE_VALUE != value) {
							item.STRE_VALUE = value;
							AUIGrid.updateRowsById(grid.id, item);
						}
					} else if ($(this).is("input[type=radio][save]")) {
						if ($(this).is(":checked")) {
							if (item.STRE_VALUE != value) {
								item.STRE_VALUE = value;
								AUIGrid.updateRowsById(grid.id, item);
							}
						}
					} else if ($(this).is("input[type=checkbox][save]")) {
						if ($(this).is(":checked")) {
							if (item.STRE_VALUE != value) {
								item.STRE_VALUE = value;
								AUIGrid.updateRowsById(grid.id, item);
							}
						}
					} else if ($(this).is("select[save]")) {
						if (item.STRE_VALUE != value) {
							item.STRE_VALUE = value;
							AUIGrid.updateRowsById(grid.id, item);
						}
					}
				});
			}

			var sortInfo = [];
			sortInfo[0] = {
				dataField : "SET_ORDR",
				sortType : 1
			};
			sortInfo[1] = {
				dataField : "SET_ROW_ORDR",
				sortType : 1
			};
			sortInfo[2] = {
				dataField : "VRIABL_ROW_ORDR",
				sortType : 1
			};
			sortInfo[3] = {
				dataField : "SET_VRIABL_ORDR",
				sortType : 1
			};
			AUIGrid.setSorting(grid.id, sortInfo);

			var param = new Object();
			param.BASE = JSON.stringify(fn_serializeObject($("#" + frm_id)));

			var arJson = fn_setCRUD(grid);
			if (arJson.length > 0) {
				param.VALUE_LIST = JSON.stringify(arJson);
			}

			//Comment 
			if (stre_code == "01") {
				var rowItems = AUIGrid.getGridData(grid2.id);
				for (var i = 0; i < rowItems.length; i++) {
					rowItems[i].CM_MSSAGE = null
					AUIGrid.updateRowsById(grid2.id, rowItems[i]);
				}
			} else {
				$("#" + crf_id).find("textarea[name^=cmt]").each(function(index2, entry2) {
					var name = $(this).attr("name");
					var arr = name.split("_");
					var cm_mssage = $(this).val();

					var item = fn_serializeObject($("#" + frm_id));
					item.SET_ROW_SN = arr[1];
					item.VRIABL_ROW_SN = arr[2];
					item.CM_MSSAGE = cm_mssage;

					var b = true;
					var rowItems = AUIGrid.getGridData(grid2.id);
					for (var i = 0; i < rowItems.length; i++) {
						if (rowItems[i].SET_ROW_SN == arr[1] && rowItems[i].VRIABL_ROW_SN == arr[2]) {
							item.RN = rowItems[i].RN;
							AUIGrid.updateRowsById(grid2.id, item);
							b = false;
							break;
						}
					}
					if (cm_mssage != "") {
						if (b) {
							AUIGrid.addRow(grid2.id, item, "first");
						}
					}
				});
			}

			arJson = fn_setCRUD(grid2);
			if (arJson.length > 0) {
				param.COMMENT_LIST = JSON.stringify(arJson);
			}
			if (param.VALUE_LIST || param.COMMENT_LIST) {
				$.ajax({
					url : './insertCRFValue.do',
					data : param,
					type : 'post',
					//contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							$("#" + crf_id).empty();

							grid.load();
							var layout = fn_makeCRFObject(grid);
							makeLayoutInput(layout, crf_id, grid);

							grid2.load();
							fn_showComment(grid2, crf_id);

							grid3.load();
							showQuery(grid3, crf_id, 1);

							fn_inputControl(btn_id, frm_id, crf_id);

							alert("저장되었습니다.");
						} else {
							alert(data.message);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert(textStatus);
					}
				});
			} else {
				alert("변경 없음");
			}
		}
	}

	function popupCRFPage() {
		var param = fn_serializeObject($("#frm_main"));
		mkLayerPopupOpen("./popupEDCC0109.do", param, 1);
	}

	function moveSubject(obj) {
		if (!left_click) {
			var subject_count = $(obj).val();
			$(".depth_01 > dd").eq(subject_count - 1).find("#span_depth_01").trigger("click");
		}
		left_click = false;
	}
	function saveESign(frm_id) {
		var param = fn_serializeObject($("#" + frm_id));
		mkLayerPopupOpen("/edc/e01/popupEDCE0103.do", param);
	}
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<%-- <h3>${progrmMap.MENU_NM}</h3> --%>
					<h3>${progrmMap.PROGRM_NM}</h3>
					<nav id="pathNav">
						<ul>
							<li>
								<img src="/images/pantheon/common/pathNavIco.png" alt="">Home
							</li>
							<li>${progrmMap.UPPER_MENU_NM}</li>
							<li>${progrmMap.MENU_NM}</li>
						</ul>
					</nav>
				</article>


				<section class="conBox_01">
					<nav>
						<div class="con_category_01">
							<a href="#void" class="con_category_close"><span>SUBJECT NO</span></a> <a href="#void" class="con_category_open"></a>

							<dl class="depth_01">
								<c:forEach var="result" items="${SubjectMenuList}" varStatus="status">
									<dd>
										<a href="javascript:choiceSubject('${result.INSTT_FORM_SN}','${result.SUBJECT_NO}','${ status.count }', this )"><span id="span_depth_01">${result.SUBJECT_NO}</span></a>
										<dl class="depth_02" id="depth2_${result.SUBJECT_NO}">
										</dl>
									</dd>
								</c:forEach>
							</dl>
							<div class="dumi_01"></div>

						</div>

					</nav>

					<section class="contents_01">
						<div class="contents_01_in">

							<div class="right_002" style="position: relative; height: 36px;" id="div_main_btn">
								<div style="text-align: center;">
									<select id="move_subject_no" name="move_subject_no" onchange="moveSubject(this);">
										<c:forEach var="result" items="${SubjectMenuList}" varStatus="status">
											<option value="${ status.count }">${result.SUBJECT_NO}</option>
										</c:forEach>
									</select>
									&nbsp;
									<button type="button" onclick="moveCRF('P')">이전</button>
									&nbsp;
									<button type="button" onclick="moveCRF('N')">다음</button>
								</div>
								<div style="position: absolute; right: 0px; top: 0px;">
									<button type="button" id="btn_reset" onclick="saveCRFPage('div_main_btn' , 'frm_main' , 'crf_layout' , '01', EDCC0106_grid, EDCC0106_grid2, EDCC0106_grid3);">초기화</button>
									<button type="button" id="btn_temp_save" onclick="saveCRFPage('div_main_btn' , 'frm_main' , 'crf_layout' , '03', EDCC0106_grid, EDCC0106_grid2, EDCC0106_grid3);">임시저장</button>
									<button type="button" id="btn_save" onclick="saveCRFPage('div_main_btn' , 'frm_main' , 'crf_layout' , '02', EDCC0106_grid, EDCC0106_grid2, EDCC0106_grid3);">저장</button>
								</div>
							</div>
							<form id="frm_main" name="frm_main">
								<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
								<input type="hidden" id="INSTT_FORM_SN" name="INSTT_FORM_SN" value="${ INSTT_FORM_SN }">
								<input type="hidden" id="SUBJECT_NO" name="SUBJECT_NO" value="${ SUBJECT_NO }">
								<input type="hidden" id="VISIT_SN" name="VISIT_SN" value="">
								<input type="hidden" id="SN" name="SN" value="">
								<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="">
								<input type="hidden" id="subject_count" name="subject_count" value="">
								<input type="hidden" id="visit_count" name="visit_count" value="1">
								<input type="hidden" id="group_count" name="group_count" value="1">
								<input type="hidden" id="STRE_CODE" name="STRE_CODE" value="">
								<input type="hidden" id="GROUP_SE_CODE" name="GROUP_SE_CODE" value="">
							</form>
							<!-- <button type="button" id="" class="report_write_01" title="보고서작성">보고서작성</button> -->
							<article id="crf_layout"></article>

							<div id="EDCC0106_grid" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>
							<div id="EDCC0106_grid2" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>
							<div id="EDCC0106_grid3" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>
						</div>
					</section>
				</section>

			</div>
		</section>
	</div>
</body>
</html>