<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<script type="text/javascript">
	var EDCC0110_grid = {
		id : '',
		div : {
			gridDiv : '#EDCC0110_grid',
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
	var EDCC0110_grid2 = {
		id : '',
		div : {
			gridDiv : '#EDCC0110_grid2',
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
	var EDCC0110_grid3 = {
		id : '',
		div : {
			gridDiv : '#EDCC0110_grid3',
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

	$(document).ready(function() {
		EDCC0110_grid.createGrid();
		EDCC0110_grid2.createGrid();
		EDCC0110_grid3.createGrid();

		var param = fn_serializeObject($("#frm_popup"));
		EDCC0110_grid.proxy.param = param;
		EDCC0110_grid.load();
		var layout = fn_makeCRFObject(EDCC0110_grid);
		makeLayoutQuery(layout, "popup_crf_layout", 2, EDCC0110_grid);

		EDCC0110_grid2.proxy.param = param;
		EDCC0110_grid2.load();
		fn_showComment(EDCC0110_grid2, "popup_crf_layout");

		EDCC0110_grid3.proxy.param = param;
		EDCC0110_grid3.load();
		showQuery(EDCC0110_grid3, "popup_crf_layout", 2, EDCC0110_grid);

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
				
				<div style="clear:both; height:10px; "></div>
				
				<div style="height: 600px; border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc; overflow-y: scroll;">
					<article id="popup_crf_layout"></article>
				</div>
				
				<div id="EDCC0110_grid" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>
				<div id="EDCC0110_grid2" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>
				<div id="EDCC0110_grid3" class="gridHeiSz05 grid_wrap tb01_2 " style="display: none;"></div>

				<article class="mgT10">
					<div style="text-align: center">
						<input type="button" value="<spring:message code="btn.close" />" onclick="popupCRFClose();">
					</div>
				</article>
			</div>
		</section>
	</div>
</section>




