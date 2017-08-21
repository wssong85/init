<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE HTML>
<style>
.input_upper {
	text-transform: uppercase;
} /*탭*/
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

#tab2 .tab_list2 {
	width: 100%;
} /*탭 선택시 나오는부분*/
#tab2 .port_back2 {
	background-color: #fff;
	color: #333 !important;
	border: 1px solid #cbcbcb;
	border-bottom: 0px;
	transition-duration: 0.5s;
}

#tab2 .port_back2:hover {
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

.tab_sub2 { /*border: 1px solid #51bbff; padding: 15px; box-sizing: border-box;*/
	transition-duration: 0.5s;
}
</style>
<script type="text/javascript">
	var EDCK0205_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : "EDCK0205_grid",
			paging : {
				pagingDiv : 'EDCK0205_grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectUserVariableList.do',
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
			rowIdField : "DOMN_VRIABL_SN"
		},
		columnLayout : [ {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			editable : false,
			visible : false
		}, {
			dataField : "USER_CDISC_SN",
			headerText : "USER_CDISC_SN",
			editable : false,
			visible : false
		}, {
			dataField : "CDISC_SE_CODE",
			headerText : '<spring:message code="edc.lbl.GROUP_LBL" />',
			editable : false
		}, {
			dataField : "CDISC_DOMN_SN",
			headerText : "CDISC_DOMN_SN",
			editable : false,
			visible : false
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN",
			editable : false,
			visible : false
		}, {
			dataField : "DOMN_NM",
			headerText : '<spring:message code="edc.lbl.DOMN_NM" />',
			editable : false
		}, {
			dataField : "VRIABL_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_NM" />',
			editable : false
		}, {
			dataField : "VRIABL_TY_CODE",
			headerText : '<spring:message code="edc.lbl.VRIABL_TY_CODE" />',
			editable : false
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE",
			editable : false
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO",
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
			AUIGrid.bind(me.id, 'cellClick', function(event) {
				var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
				$("#frm_popup #DOMN_VRIABL_SN").val(rowItem.DOMN_VRIABL_SN);
				$("#frm_popup #CRUD").val("U");
				popup_selectDetail();
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};
	var EDCK0205_grid2 = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : "EDCK0205_grid2",
			paging : {
				pagingDiv : 'EDCK0205_grid2_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectUserVariableOptionList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "VRIABL_OPTN_SN"
		},
		columnLayout : [ {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			visible : false,
			editable : false
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN",
			visible : false,
			editable : false
		}, {
			dataField : "VRIABL_OPTN_SN",
			headerText : "VRIABL_OPTN_SN",
			visible : false,
			editable : false
		}, {
			dataField : "VRIABL_OPTN_CODE",
			headerText : '<spring:message code="edc.lbl.VRIABL_OPTN_CODE" />',
			editable : true
		}, {
			dataField : "VRIABL_OPTN_NM",
			headerText : '<spring:message code="edc.lbl.VRIABL_OPTN_NM" />',
			editable : true
		}, {
			dataField : "VRIABL_OPTN_ORDR",
			headerText : "VRIABL_OPTN_ORDR",
			visible : false,
			editable : false
		}, {
			dataField : "CRUD",
			headerText : "CRUD",
			visible : false,
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
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function popup_getDomainSelectbox() {
		var param = new Object();
		param.URL = "<c:url value='/com/common/selectQueryDataList.do'/>";
		param.QUERY = "selectEDCCodeList";
		param.FLAG = "USER_DOMAIN";
		param.TASK_SN = $("#frm_popup #TASK_SN").val();
		param.SUPP_DOMN = $("#frm_popup #SUPP_DOMN").val();
		param.location = "frm_popup #CDISC_DOMN_SN";
		param.defaultLabel = '<spring:message code="edc.lbl.SELFINPUT" />';
		fn_makeSelectbox(param);
	}

	function popup_newDetail() {
		AUIGrid.clearSelection(EDCK0205_grid.id, EDCK0205_grid.gridPros.selectionMode);
		$("#frm_popup input, textarea").val("");
		$("#frm_popup label").text("");
		$("#frm_popup #TASK_SN").val("${ TASK_SN }");
		$("#frm_popup #CRUD").val("C");

		popup_getDomainSelectbox();

		$("#frm_popup select").each(function(index, entry) {
			$(this).find("option:eq(0)").prop("selected", true);
		});

		$("#frm_popup #DOMN_NM").prop("disabled", false);
	}

	function popup_selectDetail() {
		var param = $("#frm_popup").serialize();
		$.ajax({
			url : './selectUserVariableDetail.do',
			data : param,
			type : 'post',
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					var objects = data.result;
					for ( var key in objects) {
						$("#frm_popup").find("#" + key).val(objects[key]);
					}
					$("#frm_popup #lbl_domain").text(objects.DOMN_NM);
					$("#frm_popup #DOMN_NM").val("");
					$("#frm_popup #DOMN_NM").prop("disabled", false);

					var popgrid_param = new Object();
					popgrid_param.TASK_SN = $("#frm_popup #TASK_SN").val();
					popgrid_param.DOMN_VRIABL_SN = $("#frm_popup #DOMN_VRIABL_SN").val();
					EDCK0205_grid2.proxy.param = popgrid_param;
					EDCK0205_grid2.load();
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
	function popup_save() {
		AUIGrid.forceEditingComplete(EDCK0205_grid2.id, null, false);
		var ret = null;
		var msg = "\n" + '<spring:message code="edc.required.msg" />';
		if ($("#frm_popup #CDISC_DOMN_SN").val() == "" && $("#frm_popup #DOMN_NM").val() == "") {
			ret = "DOMN_NM";
		}
		if (ret == null) {
			if ($("#frm_popup #CDISC_DOMN_SN").val() != "") {
				var txt = $("#frm_popup #CDISC_DOMN_SN option:selected").text();
				var vriabl_nm = $("#frm_popup #VRIABL_NM").val();
				if (vriabl_nm.length == txt.length) {
					ret = "VRIABL_NM";
				}
			} else {
				var domn_nm = $("#frm_popup #DOMN_NM").val();
				var vriabl_nm = $("#frm_popup #VRIABL_NM").val();
				if (vriabl_nm.length == domn_nm.length) {
					ret = "VRIABL_NM";
				}
			}
		}

		if (ret != null) {
			alert(ret + msg);
		} else {
			var msg = null;
			if ($("#frm_popup #CRUD").val() == "D") {
				msg = '<spring:message code="edc.delete.msg" />';
			} else {
				msg = '<spring:message code="edc.save.msg" />';
			}
			if (confirm(msg)) {
				var param = new Object();
				param.BASE = JSON.stringify(fn_serializeObject($("#frm_popup")));
				param.BASE.VRIABL_NM = $("#frm_popup #lbl_domain").text() + $("#frm_popup #VRIABL_NM").val();

				var rowItems = AUIGrid.getGridData(EDCK0205_grid2.id);
				for (var i = 0; i < rowItems.length; i++) {
					var item = {
						VRIABL_OPTN_ORDR : (i + 1)
					};
					AUIGrid.updateRow(EDCK0205_grid2.id, item, i, true);
				}

				var arJson = new Array();
				var rowItems = AUIGrid.getAddedRowItems(EDCK0205_grid2.id);
				fn_makeArr(arJson, rowItems, "C");
				rowItems = AUIGrid.getEditedRowItems(EDCK0205_grid2.id);
				fn_makeArr(arJson, rowItems, "U");
				rowItems = AUIGrid.getRemovedItems(EDCK0205_grid2.id);
				fn_makeArr(arJson, rowItems, "D");
				if (arJson.length > 0) {
					param.OPTION_LIST = JSON.stringify(arJson);
				}

				$.ajax({
					url : './insertUserVariable.do',
					data : param,
					type : 'post',
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							EDCK0205_grid.load();
							popup_newDetail();
							AUIGrid.setGridData(EDCK0205_grid2.id, []);
						} else {
							alert(data.message);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert(textStatus);
					}
				});
			}
		}
	}
	function popup_delete() {
		$("#frm_popup #CRUD").val("D");
		popup_save();
	}
	function popup_close() {
		var param = new Object();
		param.TASK_SN = $("#frm_popup #TASK_SN").val();
		param.URL = "<c:url value='/com/common/selectQueryDataList.do'/>";
		param.QUERY = "selectEDCCodeList";
		param.FLAG = "DOMAIN";
		param.defaultLabel = "<spring:message code="edc.lbl.SELECT" />";
		param.location = "frm_main #CDISC_DOMN_SN";

		fn_makeSelectbox(param);

		layerClose();
	}
	function popup_selectDomain() {
		if ($("#frm_popup #CDISC_DOMN_SN").val() != "") {
			$("#frm_popup #lbl_domain").text($("#frm_popup #CDISC_DOMN_SN option:selected").text());
			$("#frm_popup #DOMN_NM").val("");
			$("#frm_popup #DOMN_NM").prop("disabled", true);
		} else {
			$("#frm_popup #lbl_domain").text("");
			$("#frm_popup #DOMN_NM").prop("disabled", false);
		}
	}

	$(function() {
		var popgrid_param = new Object();
		popgrid_param.TASK_SN = $("#frm_popup #TASK_SN").val();
		popgrid_param.SUPP_DOMN = $("#frm_popup #SUPP_DOMN").val();
		EDCK0205_grid.proxy.param = popgrid_param;
		EDCK0205_grid.createGrid();
		popup_getDomainSelectbox();

		EDCK0205_grid2.createGrid();
		AUIGrid.setGridData(EDCK0205_grid2.id, []);

		$('#frm_popup #DOMN_NM').keyup(function(event) {
			var val = $(this).val();
			var input_length = val.length;
			/* 
			if (input_length > 2) {
				val = val.substring(0, 2)
			} else {
				if (fn_CheckEng(val) == null) {
					val = val.substring(0, input_length - 1)
				}
			} */
			if (!fn_CheckEng(val)) {
				val = val.substring(0, input_length - 1)
			}
			$(this).val(val);
			$('#frm_popup #VRIABL_NM').val(val);
		});

		$('#frm_popup #CDISC_DOMN_SN').change(function() {
			if ($("#frm_popup #CDISC_DOMN_SN option:selected").val() != "") {
				var txt = $("#frm_popup #CDISC_DOMN_SN option:selected").text();
				$('#frm_popup #VRIABL_NM').val(txt);
			} else {
				$('#frm_popup #VRIABL_NM').val("");
			}
		});

		$('#frm_popup #VRIABL_NM').keyup(function(event) {
			var val = $(this).val();
			var input_length = val.length;
			if (!fn_CheckEng(val)) {
				val = val.substring(0, input_length - 1)
			}

			if ($("#frm_popup #CDISC_DOMN_SN").val() != "") {
				var txt = $("#frm_popup #CDISC_DOMN_SN option:selected").text();
				if (val.length < txt.length) {
					val = txt;
				}
			} else {
				var txt = $("#frm_popup #DOMN_NM").val();
				if (val.length < txt.length) {
					val = txt;
				}
			}

			$(this).val(val);
		});
	});
	function popup_addRow() {
		var item = {
			TASK_SN : $("#frm_popup #TASK_SN").val(),
			DOMN_VRIABL_SN : $("#frm_popup #DOMN_VRIABL_SN").val()
		};
		AUIGrid.addRow(EDCK0205_grid2.id, item, "first");
	}// 선택 행들 위로 한 단계 올림
	function popup_moveRowsToUp() {
		AUIGrid.moveRowsToUp(EDCK0205_grid2.id);
	};

	// 선택 행들 아래로 한 단계 올림
	function popup_moveRowsToDown() {
		AUIGrid.moveRowsToDown(EDCK0205_grid2.id);
	};
</script>

<section class="popupWrap">
	<!-- 팝업 시작 -->
	<!-- 팝업 세로는 자동지정이지만, 가로는 지정해줘야한다. wd00의 00은 픽셀 사이즈 1~100은 1단위, 1000은 10단위-->
	<!-- popup01은 popup-button01에 맞추는등, 숫자를 맞춰준다 -->
	<div class="popup popup01 wd800">
		<section class="conBox100 popup_conBox" style="margin: 0px;">
			<div class="conBoxInner">
				<div id="tab2" class="tab tab01">
					<ul>
						<li id="tab_menu1" class="tab_menu2" onclick="popupUserVariable('EDCK0206');">User Variable</li>
						<li id="tab_menu2" class="port_back2 tab_menu2">SUPP</li>
					</ul>
				</div>
				<article>
					<!-- 에이유아이 그리드가 이곳에 생성 -->
					<div id="EDCK0205_grid" class="gridHeiSz04 grid_wrap tb01_2"></div>
				</article>

				<article class="mgT10">
					<article class="conTitBox">
						<h5>Detail</h5>
					</article>
					<article class="conTitBtnR">
						<input type="button" value="<spring:message code="btn.new" />" onclick="popup_newDetail();">
						<input type="button" value="<spring:message code="btn.save" />" onclick="popup_save();">
						<input type="button" value="삭제" onclick="popup_delete();">
					</article>
					<article class="mgT10">
						<form id="frm_popup" name="frm_popup">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
							<input type="hidden" id="SUPP_DOMN" name="SUPP_DOMN" value="02">
							<input type="hidden" id="CRUD" name="CRUD" value="C">
							<input type="hidden" id="DOMN_VRIABL_SN" name="DOMN_VRIABL_SN">
							<table class="tb02">
								<tbody>
									<tr>
										<th>CDISC_SE_CODE<span class='must_01'></span></th>
										<td>
											<select id="CDISC_SE_CODE" name="CDISC_SE_CODE">
												<c:forEach items="${ EDC038 }" var="list">
													<option value="${ list.CODE }">${ list.VALUE }</option>
												</c:forEach>
											</select>
										</td>
										<th>DOMN_NM<span class='must_01'></span></th>
										<td>
											<select id="CDISC_DOMN_SN" name="CDISC_DOMN_SN" onchange="popup_selectDomain();">
											</select>
											<input type="text" id="DOMN_NM" name="DOMN_NM" class="input_upper">
										</td>
									</tr>
									<tr>
										<th>VRIABL_NM<span class='must_01'></span></th>
										<td>
											<input type="text" id="VRIABL_NM" name="VRIABL_NM" class="input_upper">
										</td>
										<th>VRIABL_TY_CODE<span class='must_01'></span></th>
										<td>
											<select id="VRIABL_TY_CODE" name="VRIABL_TY_CODE">
												<c:forEach items="${ EDC037 }" var="list">
													<option value="${ list.CODE }">${ list.VALUE }</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th>CRF_LBL_ONE</th>
										<td>
											<input type="text" id="CRF_LBL_ONE" name="CRF_LBL_ONE">
										</td>
										<th>CRF_LBL_TWO</th>
										<td>
											<input type="text" id="CRF_LBL_TWO" name="CRF_LBL_TWO">
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</article>
				</article>

				<article class="mgT10">
					<article class="conTitBox">
						<h5>Option</h5>
					</article>
					<article class="conTitBtnR">
						<button type="button" onclick="popup_moveRowsToUp()" able>▲</button>
						<button type="button" onclick="popup_moveRowsToDown()" able>▼</button>
						<button type="button" able onclick="popup_addRow()" title="<spring:message code="btn.rowAdd"/>">
							<spring:message code="btn.rowAdd" />
						</button>
						<button type="button" able onclick="fn_deleteRow(EDCK0205_grid2)">
							<spring:message code="btn.rowDelete" />
						</button>
					</article>
				</article>

				<article class="mgT10">
					<div id="EDCK0205_grid2" class="gridHeiSz04 grid_wrap tb01_2"></div>
				</article>
				</article>

				<article class="mgT35">
					<div style="position: absolute; right: 20px; bottom: 20px;">
						<input type="button" value="<spring:message code="btn.close" />" onclick="popup_close();">
					</div>
				</article>
				<!-- 팝업 내부 컨텐츠 끝 -->
			</div>
		</section>
	</div>
	<!-- 팝업 끝 -->
</section>
<!-- 팝업 wrap 끝 -->