<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<style>
/*탭*/
#tab2 {
	position: relative;
	width: 100%;
}

#tab2 ul {
	width: 100%;
	height: 39px;
	display: inline-block;
	list-style: none;
	border-bottom: 1px solid #cbcbcb;
	margin-bottom: 10px;
}

#tab2 li {
	display: block;
	float: left; /*min-width:80px;*/
	padding: 0 24px 0 24px;
	height: 39px;
	line-height: 39px;
}

#tab2 .tab_list {
	width: 100%;
} /*탭 선택시 나오는부분*/
#tab2 .port_back {
	background-color: #fff;
	color: #333 !important;
	border: 1px solid #cbcbcb;
	border-bottom: 0px;
	transition-duration: 0.5s;
}

#tab2 .port_back:hover {
	transition-duration: 0.5s;
}

.tab_menu2 {
	background-color: #fff;
	color: #999;
	text-align: center;
	transition-duration: 0.5s;
	cursor: pointer;
}

.tab_menu2:hover {
	background-color: #f3f3f3;
	color: #333;
	transition-duration: 0.5s;
}

.tab_sub2 {
	/*border: 1px solid #51bbff; padding: 15px; box-sizing: border-box;*/
	transition-duration: 0.5s;
}
</style>
<script type="text/javascript">
	var EDCK0214Sub01_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0214Sub01_grid',
			paging : {
				pagingDiv : 'EDCK0214Sub01_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectArmCodeList.do',
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
			showStateColumn : true,
			softRemovePolicy : "exceptNew",
			editable : true,
			enableFilter : false,
			headerHeight : 40,
			rowHeight : 37,
			editableOnFixedCell : true,
			fixedColumnCount : 4,
			selectionMode : "singleRow",
			rowIdField : "TA_SN"
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			visible : false
		}, {
			dataField : "EDC_VER",
			headerText : "EDC_VER",
			visible : false
		}, {
			dataField : "TA_SN",
			headerText : "TA_SN",
			visible : false
		}, {
			dataField : "TA_CODE",
			headerText : '<spring:message code="edc.lbl.TA_CODE" />' + "<span class='must_01'></span>",
		}, {
			dataField : "TA_LBL",
			headerText : '<spring:message code="edc.lbl.TA_LBL" />' + "<span class='must_01'></span>",
		}, {
			dataField : "CRUD",
			headerText : "Delete",
			editable : false,
			visible : false
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
			AUIGrid.bind(me.id, 'cellEditEndBefore', function(event) {
				return fn_checkGridNull(event);
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function addRow_EDCK0214Sub01_grid() {
		var item = {
			TASK_SN : $("#frm_popup #TASK_SN").val(),
			EDC_VER : $("#frm_popup #EDC_VER").val()
		};
		AUIGrid.addRow(EDCK0214Sub01_grid.id, item, "first");
	}
	function save_EDCK0214Sub01_grid() {
		var msg1 = '<spring:message code="edc.required.msg" />';
		var msg2 = '<spring:message code="edc.byte.msg" />';
		var rowItems = AUIGrid.getGridData(EDCK0214Sub01_grid.id);
		for (var i = 0; i < rowItems.length; i++) {
			if (!rowItems[i].TA_CODE || rowItems[i].TA_CODE.length <= 0) {
				alert("TA_CODE" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214Sub01_grid.id, i);
				return false;
			}

			if (!rowItems[i].TA_LBL || rowItems[i].TA_LBL.length <= 0) {
				alert("TA_LBL" + "\n" + msg1);
				AUIGrid.setSelectionByIndex(EDCK0214Sub01_grid.id, i);
				return false;
			}

			var text_byte = 200;
			text = rowItems[i].TA_CODE;
			if (fn_getByte(text) > text_byte) {
				alert("TA_CODE" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214Sub01_grid.id, i);
				return false;
			}

			text = rowItems[i].TA_LBL;
			if (fn_getByte(text) > text_byte) {
				alert("TA_LBL" + "\n" + text_byte + msg2);
				AUIGrid.setSelectionByIndex(EDCK0214Sub01_grid.id, i);
				return false;
			}
		}

		var arJson = [];
		rowItems = AUIGrid.getAddedRowItems(EDCK0214Sub01_grid.id);
		fn_makeArr(arJson, rowItems, "C");
		rowItems = AUIGrid.getEditedRowItems(EDCK0214Sub01_grid.id);
		fn_makeArr(arJson, rowItems, "U");
		rowItems = AUIGrid.getRemovedItems(EDCK0214Sub01_grid.id);
		fn_makeArr(arJson, rowItems, "D");

		if (arJson.length > 0) {
			AUIGrid.showAjaxLoader(EDCK0214Sub01_grid.id);
			$.ajax({
				url : './insertArmCodeList.do',
				data : JSON.stringify(arJson),
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						EDCK0214Sub01_grid.load();
						alert('<spring:message code="edc.save.confirm.msg" />');
					} else {
						alert(data.message);
					}
					AUIGrid.removeAjaxLoader(EDCK0214Sub01_grid.id);
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		} else {
			alert('<spring:message code="edc.save.noChange" />');
		}
	}
	function closePopup() {
		var param = {};
		param.TASK_SN = $("#frm_popup #TASK_SN").val();
		param.EDC_VER = $("#frm_popup #EDC_VER").val();
		param.URL = "/com/common/selectQueryDataList.do";
		param.QUERY = "selectEDCCodeList";
		param.FLAG = "ARM_CODE";
		EDCK0214_grid2.columnLayout[5].editRenderer.list = fn_makeSelectList(param);
		param.FLAG = "ARM_LABEL";
		EDCK0214_grid2.columnLayout[6].editRenderer.list = fn_makeSelectList(param);
		layerClose();
	}

	$(function() {
		var popgrid_param = $("#frm_popup").serialize();
		EDCK0214Sub01_grid.proxy.param = popgrid_param;
		EDCK0214Sub01_grid.createGrid();
	});
</script>

<section class="popupWrap">
	<!-- 팝업 시작 -->
	<!-- 팝업 세로는 자동지정이지만, 가로는 지정해줘야한다. wd00의 00은 픽셀 사이즈 1~100은 1단위, 1000은 10단위-->
	<!-- popup01은 popup-button01에 맞추는등, 숫자를 맞춰준다 -->
	<div class="popup popup01 wd500">
		<!-- 컨텐츠박스 시작-->
		<section class="conBox100 conBox pd0">
			<div class="conBoxInner">
				<articla class="conTitBox">
				<h5>Arm Code</h5>
				</articla>
				<div class="conTitBtnR">
					<button type="button" class="add_01" onclick="addRow_EDCK0214Sub01_grid()" title="<spring:message code="btn.rowAdd"/>" able>
						<spring:message code="btn.rowAdd" />
					</button>
					<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0214Sub01_grid)" title="<spring:message code="btn.rowDelete" />" able>
						<spring:message code="btn.rowDelete" />
					</button>
					<button type="button" class="save_01" onclick="save_EDCK0214Sub01_grid()" title="<spring:message code="btn.save" />" able>
						<spring:message code="btn.save" />
					</button>
				</div>
				<form id="frm_popup" name="frm_popup">
					<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
					<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }">
				</form>
				<article class="mgT14">
					<div id="EDCK0214Sub01_grid" class="gridHeiSz05 grid_wrap tb01_2"></div>
				</article>
				<article class="mgT35">
					<div style="position: absolute; right: 20px; bottom: 20px;">
						<button type="button" class="close_01" onclick="closePopup();" title="<spring:message code="btn.close" />" able>
							<spring:message code="btn.close" />
						</button>
					</div>
				</article>
				<!-- 팝업 내부 컨텐츠 끝 -->
			</div>
		</section>
	</div>
	<!-- 팝업 끝 -->
</section>
<!-- 팝업 wrap 끝 -->

