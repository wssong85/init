<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<script type="text/javascript">
	$(document).ready(function() {
		var task_sn = $("#frm_main #TASK_SN").val();
		var crud = $("#frm_main #CRUD").val();
		if ((task_sn == "" && crud == "C") || (task_sn != "" && crud == "U")) {
			var grid_param = new Object();
			grid_param.TASK_SN = task_sn;
			EDCK0102_grid.proxy.param = grid_param;
			EDCK0102_grid.createGrid();

			mkSetDatePickerYYMMDD("#RSRCH_BEGIN", "#RSRCH_END");
			var date = "${ detail.RSRCH_BEGIN }";
			if (date) {
				$("#RSRCH_BEGIN").val(date.substring(0, 10));
			}
			date = "${ detail.RSRCH_END }";
			if (date) {
				$("#RSRCH_END").val("${ detail.RSRCH_END }".substring(0, 10));
			}

			mkSetDatePickerYYMMDD("#REJDGE_BEGIN, #REJDGE_END");
			date = "${ detail.REJDGE_BEGIN }";
			if (date) {
				$("#REJDGE_BEGIN").val("${ detail.REJDGE_BEGIN }".substring(0, 10));
				date = "${ detail.REJDGE_END }";
			}
			if (date) {
				$("#REJDGE_END").val("${ detail.REJDGE_END }".substring(0, 10));
			}

			mkSetDatePickerYYMMDD("#PRMISN_DE");
			date = "${ detail.PRMISN_DE }";
			if (date) {
				$("#PRMISN_DE").val("${ detail.PRMISN_DE }".substring(0, 10));
			}

			$('input[name=BLIND_CODE]').click(function() {
				if (!$('#IWRS_USE_AT').is(":checked")) {
					$("#frm_main input[name=BLIND_CODE][value=03]").prop("checked", true);
				}
			});

			$('input[name=PHASE_CODE]').click(function() {
				if ($(this).val() == "05") {
					$("#frm_main #PHASE_ETC_NM").prop("disabled", false);
				} else {
					$("#frm_main #PHASE_ETC_NM").val("");
					$("#frm_main #PHASE_ETC_NM").prop("disabled", true);
				}
			});

			$('input[name=IWRS_USE_AT]').click(function() {
				if ($('#IWRS_USE_AT').is(":checked")) {
					$("#frm_main input[name=BLIND_CODE][value=01]").prop("checked", true);
					//$("#frm_main input[name=BLIND_CODE]").prop("disabled", false);
				} else {
					$("#frm_main input[name=BLIND_CODE][value=03]").prop("checked", true);
					//$("#frm_main input[name=BLIND_CODE]").prop("disabled", true);
				}
			});

			changeTaskType($("#frm_main input[name=TASK_TY_CODE]:checked").val());

			$('input[name=TASK_TY_CODE]').click(function() {
				changeTaskType($(this).val());
				if ($(this).val() == "01") {
					$("#frm_main input[name=PHASE_CODE]").prop("disabled", false);
					if ($("#frm_main input[name=PHASE_CODE]:checked").val() == "05") {
						$("#frm_main #PHASE_ETC_NM").prop("disabled", false);
					} else {
						$("#frm_main #PHASE_ETC_NM").prop("disabled", true);
					}
				} else {
					$("#frm_main input[name=PHASE_CODE]").prop("checked", false);
					$("#frm_main input[name=PHASE_CODE]").prop("disabled", true);
					$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
					$("#frm_main #PHASE_ETC_NM").val("");
				}
			});

			$('#frm_main #TRGTER_CO').keyup(function(event) {
				var val = $(this).val();
				var input_length = val.length;
				if (!fn_CheckNum(val)) {
					val = val.substring(0, input_length - 1)
				}
				$(this).val(val);
				$('#frm_main #TRGTER_CO').val(val);
			});

			$('#frm_main #RRCS_CO').keyup(function(event) {
				var val = $(this).val();
				var input_length = val.length;
				if (!fn_CheckNum(val)) {
					val = val.substring(0, input_length - 1)
				}
				$(this).val(val);
				$('#frm_main #RRCS_CO').val(val);
			});

			if ($("#CRUD").val() == "U") {
				editMode(false);
			} else {
				//editMode(true);
				$("#btn_edit").hide();
				$("#frm_main input[name=IWRS_USE_AT]").prop("checked", true);
				$("#frm_main input[name=BLIND_CODE][value=01]").prop("checked", true);
				//$("#frm_main input[name=BLIND_CODE]").prop("disabled", true);
				$("#frm_main input[name=PHASE_CODE][value=01]").prop("checked", true);
				$("#frm_main input[name=PHASE_CODE]").prop("disabled", false);
				$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
			}
		} else {
			alert('<spring:message code="edc.taskSelect.msg" />');
			location.replace("./EDCK0101.do");
		}
	});

	function changeTaskType(value) {
		if (value == "03") {
			$("#tr_nis input").val("");
			$("#tr_nis").hide();
			$("#tr_pms").show();
		} else if (value == "02") {
			$("#tr_pms input").val("");
			$("#tr_pms").hide();
			$("#tr_nis").show();
		} else {
			$("#tr_product input").val("");
			$("#tr_pms").hide();
			$("#tr_nis").hide();
		}
	}

	function saveGrid() {
		var msg1 = "필수 입력";
		var msg2 = "바이트까지 입력 가능합니다.";

		var frm_id = "frm_main";
		var text_byte = 50;
		var tag_id = "TASK_NO";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("TASK_NO" + "\n" + text_byte + msg2);
			return false;
		}

		text_byte = 200;
		tag_id = "TASK_NM";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("TASK_NM" + "\n" + text_byte + msg2);
			return false;
		}
		var tag_id = "DOMN_URL";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("DOMN_URL" + "\n" + text_byte + msg2);
			return false;
		}
		tag_id = "TRGET_DISS";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("TRGET_DISS" + "\n" + text_byte + msg2);
			return false;
		}
		tag_id = "PRODUCT_NM";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("PRODUCT_NM" + "\n" + text_byte + msg2);
			return false;
		}
		tag_id = "STUDY_NM";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("STUDY_NM" + "\n" + text_byte + msg2);
			return false;
		}

		text_byte = 1000;
		tag_id = "RSRCH_PURPS";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("RSRCH_PURPS" + "\n" + text_byte + msg2);
			return false;
		}

		text_byte = 4000;
		tag_id = "TASK_DC";
		if (!fn_TextByteValidation(frm_id, tag_id, text_byte)) {
			alert("TASK_DC" + "\n" + text_byte + msg2);
			return false;
		}

		if (!fn_TextValidation("frm_main", "TASK_NO")) {
			alert("TASK_NO" + "\n" + msg);
			return false;
		}
		if (!fn_TextValidation("frm_main", "TASK_NM")) {
			alert("TASK_NM" + "\n" + msg);
			return false;
		}
		if (!fn_RadioValidation("frm_main", "TASK_TY_CODE")) {
			alert("TASK_TY_CODE" + "\n" + msg);
			return false;
		}

		if ($("#frm_main input[name=TASK_TY_CODE]:checked").val() == "01") {
			if (!fn_RadioValidation("frm_main", "PHASE_CODE")) {
				alert("PHASE_CODE" + "\n" + msg);
				return false;
			}
		}
		if ($("#frm_main input[name=PHASE_CODE]:checked").val() == "05") {
			if (!fn_TextValidation("frm_main", "PHASE_ETC_NM")) {
				alert("PHASE_ETC_NM" + "\n" + msg);
				return false;
			}
		}

		if (confirm('<spring:message code="edc.save.msg" />')) {
			var upload_file = $("#upload_file").val();
			var ext = upload_file.substring(upload_file.lastIndexOf(".") + 1, upload_file.length);

			if (upload_file != "" && ext.toUpperCase() != "DOC") {
				alert("Word 파일이 아님");
				return false;
			}

			if ($("#frm_main #hd_task_no").val() != $("#frm_main #TASK_NO").val()) {
				alert("중복확인필요");
			} else {
				var rowItems = AUIGrid.getGridData(EDCK0102_grid.id);
				var arJson = [];
				for (var i = 0; i < rowItems.length; i++) {
					rowItems[i].PRDUCT_ORDR = (i + 1);

					if (AUIGrid.isAddedById(EDCK0102_grid.id, rowItems[i].PRDUCT_SN)) {
						rowItems[i].CRUD = "C";
					} else if (AUIGrid.isEditedById(EDCK0102_grid.id, rowItems[i].PRDUCT_SN)) {
						rowItems[i].CRUD = "U";
					} else if (AUIGrid.isRemovedById(EDCK0102_grid.id, rowItems[i].PRDUCT_SN)) {
						rowItems[i].CRUD = "D";
					} else {
						rowItems[i].CRUD = "U";
					}
					arJson.push(rowItems[i]);
				}

				$("#frm_main #PRODUCT_LIST").val(JSON.stringify(arJson));

				$("#frm_main").ajaxSubmit({
					url : './insertBaseInfo.do',
					type : "post",
					dataType : 'json',
					// data : $('#' + form).serialize(),
					success : function(response) {
						console.log(3);
						var data = '';
						try {
							data = JSON.parse(response);
						} catch (e) {
							data = response;
						}
						if (data.success) {
							if (data.result.TASK_SN != null) {
								$("#frm_main #TASK_SN").val(data.result.TASK_SN);
								$("#frm_main #CRUD").val("U");
							}
							$("#frm_main").prop({
								action : './EDCK0102.do',
								method : 'post'
							}).submit();
						} else {
							alert(data.message);
						}
					},
					error : function() {
						alert("file upload error!!");
					}
				});
			}
		}
	}

	function selectCheckTaskNo() {
		if ($.trim($("#frm_main #TASK_NO").val()) == "") {
			alert("TASK_NO 필수 입력");
		} else {
			if ($("#frm_main #hd_task_no").val() == $("#frm_main #TASK_NO").val()) {
				alert("사용가능");
			} else {
				var param = $("#frm_main").serialize();
				$.ajax({
					url : './selectCheckTaskNo.do',
					data : param,
					type : 'post',
					//contentType : "application/json; charset=UTF-8",
					success : function(data, textStatus, jqXHR) {
						if (data.success) {
							if (data.result.COUNT == 0) {
								$("#frm_main #hd_task_no").val($("#frm_main #TASK_NO").val());
								alert("사용가능");
							} else {
								alert("이미존재");
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
		}
	}
	function editMode(e) {
		if (!e) {
			mkDisabled(); //컨트롤 비활성화
			$("button").hide();
			$("#btn_edit").show();
			$(".ui-datepicker-trigger").hide();

			AUIGrid.setProperty(EDCK0102_grid.id, {
				"editable" : false
			});

		} else {
			mkEnabled(); //컨트롤 활성화
			$("button").show();
			$("#btn_edit").hide();
			$(".ui-datepicker-trigger").show();
			if ($("#frm_main input[name=TASK_TY_CODE]:checked").val() == "01") {
				$("#frm_main input[name=PHASE_CODE]").prop("disabled", false);
				$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
			} else {
				$("#frm_main input[name=PHASE_CODE]").prop("checked", false);
				$("#frm_main input[name=PHASE_CODE]").prop("disabled", true);
				$("#frm_main input[name=PHASE_ETC_NM]").prop("disabled", true);
			}
			if ($("#frm_main input[name=PHASE_CODE]:checked").val() == "05") {
				$("#frm_main #PHASE_ETC_NM").prop("disabled", false);
			} else {
				$("#frm_main #PHASE_ETC_NM").prop("disabled", true);
			}
			if ($('#IWRS_USE_AT').is(":checked")) {
				//$("#frm_main input[name=BLIND_CODE]").prop("disabled", false);
			} else {
				$("#frm_main input[name=BLIND_CODE][value=03]").prop("checked", true);
				//$("#frm_main input[name=BLIND_CODE]").prop("disabled", true);
			}

			var selIdx = AUIGrid.getSelectedIndex(EDCK0102_grid.id);
			if (selIdx[0] != "-1") {
				AUIGrid.clearSelection(EDCK0102_grid.id, EDCK0102_grid.gridPros.selectionMode);
				AUIGrid.setProperty(EDCK0102_grid.id, {
					"editable" : true
				});
				AUIGrid.setSelectionByIndex(EDCK0102_grid.id, selIdx[0], selIdx[1])
			} else {
				AUIGrid.setProperty(EDCK0102_grid.id, {
					"editable" : true
				});
			}
		}
		$("#btn_list").show();
		$("#btn_down_file").show();
		$("#btn_down_pdf").show();
	}

	function fn_downFile(fileMastrSn, fileSn) {
		window.open("<c:url value='/com/z02/selectDmFileDetailByPk.do?FILE_MASTR_SN=" + fileMastrSn + "&DETAIL_SN=" + fileSn + "'/>");
	}

	var EDCK0102_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0102_grid',
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
			url : './selectProductList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showFooter : true,
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			showStateColumn : true,
			softRemovePolicy : "exceptNew",
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			editableOnFixedCell : true,
			fixedColumnCount : 4,
			selectionMode : "singleRow",
			rowIdField : "PRDUCT_SN"
		},
		columnLayout : [ {
			dataField : "PRDUCT_SN",
			headerText : "PRDUCT_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TASK_SN",
			headerText : "TASK_SN",
			editable : false,
			visible : false
		}, {
			dataField : "TRGTER_CO",
			headerText : '<spring:message code="edc.lbl.TRGTER_CO" />',
			sortable : false,
			filter : {
				showIcon : true
			},
			editRenderer : {
				type : "InputEditRenderer",
				onlyNumeric : true
			}
		}, {
			dataField : "PRDUCT_NM",
			headerText : '<spring:message code="edc.lbl.PRDUCT_NM" />',
			sortable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "PRDUCT_ORDR",
			headerText : "PRDUCT_ORDR",
			editable : false,
			visible : false
		}, {
			dataField : "CRUD",
			headerText : "Delete",
			editable : false,
			visible : false
		} ],
		footerLayout : [ {
			labelText : "합계",
			positionField : "#base"
		}, {
			dataField : "TRGTER_CO",
			positionField : "TRGTER_CO",
			operation : "SUM",
			formatString : "#,##0"
		}, {
			dataField : "PRDUCT_NM",
			positionField : "PRDUCT_NM",
			labelFunction : function(value, columnValues) {
				var str = "";
				for (var i = 0; i < columnValues.length; i++) {
					str += columnValues[i] + "/";
				}
				str = str.substring(0, str.length - 1);
				return str;
			}
		} ],
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;
			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			AUIGrid.setFooter(me.id, me.footerLayout);
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
	function addRow() {
		var item = {
			TASK_SN : $("#frm_main #TASK_SN").val()
		};
		AUIGrid.addRow(EDCK0102_grid.id, item, "last");
	}

	function moveRowsToUp() {
		AUIGrid.moveRowsToUp(EDCK0102_grid.id);
	};

	function moveRowsToDown() {
		AUIGrid.moveRowsToDown(EDCK0102_grid.id);
	};
</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0102&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0102&UPPER_MENU_ID=EDCK" charEncoding="utf-8" />


		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
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


				<section class="conBox100 conBox">

					<div class="conBoxInner" style="min-height: 700px;">

						<articla class="conTitBox">
						<h5>
							<spring:message code="edc.lbl.TASK_INFO" />
						</h5>
						</articla>

						<div class="conTitBtnR">
							<button type="button" class="edit_01" id="btn_edit" onclick="editMode(true);" title="<spring:message code="btn.update" />">
								<spring:message code="btn.update" />
							</button>
							<button type="button" class="save_01" onclick="saveGrid();" title="<spring:message code="btn.save" />" able>
								<spring:message code="btn.save" />
							</button>
							<button type="button" id="btn_list" onclick="fn_goList('EDCK0101');">목록</button>
						</div>


						<form id="frm_main" name="frm_main" enctype="multipart/form-data" method="post" action="">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ detail.TASK_SN }">
							<input type="hidden" id="CRUD" name="CRUD" value="${ detail.CRUD }">
							<input type="hidden" id="PRODUCT_LIST" name="PRODUCT_LIST">

							<article class="mgT16">


								<table class="tb001">
									<colgroup>
										<col width="120px" />
										<col width="" />
										<col width="120px" />
										<col width="40%" />
									</colgroup>
									<tbody>
										<tr>
											<th><spring:message code="edc.lbl.TASK_NO" /><span class='must_01'></span></th>
											<td colspan="3">
												<input type="text" id="TASK_NO" name="TASK_NO" value="${ detail.TASK_NO }" able>
												<input type="hidden" id="hd_task_no" name="hd_task_no" value="${ detail.TASK_NO }">
												<button type="button" onclick="selectCheckTaskNo();" able>
													<spring:message code="edc.btn.DUPLICATION" />
													<span class='must_01'>
												</button>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.TASK_NM" /><span class='must_01'></span></th>
											<td colspan="3">
												<input type="text" style="width: 100%;" id="TASK_NM" name="TASK_NM" value="${ detail.TASK_NM }" able>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.TASK_TY_CODE" /><span class='must_01'></span></th>
											<td>
												<c:set var="TASK_TY_CODE" value="${ detail.TASK_TY_CODE }" />
												<c:if test="${empty TASK_TY_CODE }">
													<c:set var="TASK_TY_CODE" value="01" />
												</c:if>
												<c:forEach items="${ EDC017 }" var="list" varStatus="status">
													<input type="radio" id="TASK_TY_CODE_${ status.count }" name="TASK_TY_CODE" value="${ list.CODE }" <c:if test="${ list.CODE == TASK_TY_CODE}">checked="checked"</c:if> able>
													<label for="TASK_TY_CODE_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
												</c:forEach>
											</td>
											<th><spring:message code="edc.lbl.PHASE_CODE" /></th>
											<td>
												<c:set var="PHASE_CODE" value="${ detail.PHASE_CODE }" />
												<c:forEach items="${ EDC015 }" var="list" varStatus="status">
													<input type="radio" id="PHASE_CODE_${ status.count }" name="PHASE_CODE" value="${ list.CODE }" <c:if test="${ list.CODE == PHASE_CODE}">checked="checked"</c:if> able>
													<label for="PHASE_CODE_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
													</label>
												</c:forEach>
												<input type="text" id="PHASE_ETC_NM" name="PHASE_ETC_NM" value="${ detail.PHASE_ETC_NM }" able>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.IWRS_USE_AT" /></th>
											<td>
												<input type="checkbox" name="IWRS_USE_AT" id="IWRS_USE_AT" value="Y" <c:if test="${ detail.IWRS_USE_AT == 'Y' }">checked="checked"</c:if> able>
												<label for="IWRS_USE_AT" class="chcLab"><span><spring:message code="edc.lbl.IWRS_USE_Y" /></span></label>
											</td>
											<th><spring:message code="edc.lbl.BLIND_CODE" /></th>
											<td>
												<c:set var="BLIND_CODE" value="${ detail.BLIND_CODE }" />
												<c:if test="${empty BLIND_CODE }">
													<c:set var="BLIND_CODE" value="01" />
												</c:if>
												<c:forEach items="${ EDC030 }" var="list" varStatus="status">
													<input type="radio" id="BLIND_CODE_${ status.count }" name="BLIND_CODE" value="${ list.CODE }" <c:if test="${ list.CODE == BLIND_CODE}">checked="checked"</c:if> able>
													<label for="BLIND_CODE_${ status.count }" class="raLab"> <span>${ list.VALUE }</span>
													</label>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.TASK_DC" /></th>
											<td colspan="3" style="padding-top: 5px;">
												<textarea style="width: 100%;" id="TASK_DC" name="TASK_DC" able>${ detail.TASK_DC }</textarea>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.CTRTC_FILE" /></th>
											<td>
												<input type="file" id="upload_file" name="upload_file" able>

												<c:if test="${!empty detail.CTRTC_FILE_SN }">
													<button type="button" id="btn_down_file" onclick="fn_downFile('${ detail.FILE_MASTR_SN }', '${ detail.CTRTC_FILE_SN }');">Word</button>
												</c:if>
												<c:if test="${!empty detail.CTRTC_PDF_FILE_SN }">
													<button type="button" id="btn_down_pdf" onclick="fn_downFile('${ detail.FILE_MASTR_SN }', '${ detail.CTRTC_PDF_FILE_SN }');">PDF</button>
												</c:if>
											<th><spring:message code="edc.lbl.DOMN_URL" /></th>
											<td>
												<input type="text" style="width: 100%;" id="DOMN_URL" name="DOMN_URL" value="${ DOMN_URL }" able>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.TRGET_DISS" /></th>
											<td colspan="3">
												<input type="text" style="width: 100%;" id="TRGET_DISS" name="TRGET_DISS" value="${ detail.TRGET_DISS }" able>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.RRCS_CO" /></th>
											<td>
												<input type="text" style="width: 30%;" id="RRCS_CO" name="RRCS_CO" value="${ detail.RRCS_CO }" able>
											</td>
											<th><spring:message code="edc.lbl.RSRCH_BEGIN" /></th>
											<td>
												<div class="dateBox">
													<input type="text" id="RSRCH_BEGIN" name="RSRCH_BEGIN" value="${ detail.RSRCH_BEGIN }" able>
												</div>
												~
												<div class="dateBox">
													<input type="text" id="RSRCH_END" name="RSRCH_END" value="${ detail.RSRCH_END }" able>
												</div>
											</td>
										</tr>
										<tr>
											<th><spring:message code="edc.lbl.RSRCH_PURPS" /></th>
											<td colspan="3">
												<input type="text" style="width: 100%;" id="RSRCH_PURPS" name="RSRCH_PURPS" value="${ detail.RSRCH_PURPS }" able>
											</td>
										</tr>
										<tr id="tr_pms">
											<th><spring:message code="edc.lbl.PRMISN_DE" /></th>
											<td>
												<div class="dateBox">
													<input type="text" id="PRMISN_DE" name="PRMISN_DE" value="${ detail.PRMISN_DE }" able>
												</div>
											</td>
											<th><spring:message code="edc.lbl.REJDGE_BEGIN" /></th>
											<td>
												<div class="dateBox">
													<input type="text" id="REJDGE_BEGIN" name="REJDGE_BEGIN" value="${ detail.REJDGE_BEGIN }" able>
												</div>
												~
												<div class="dateBox">
													<input type="text" id="REJDGE_END" name="REJDGE_END" value="${ detail.REJDGE_END }" able>
												</div>
											</td>
										</tr>
										<tr id="tr_nis">
											<th><spring:message code="edc.lbl.STUDY_NM" /></th>
											<td colspan="3">
												<input type="text" style="width: 100%;" id="STUDY_NM" name="STUDY_NM" value="${ detail.STUDY_NM }" able>
											</td>
										</tr>

									</tbody>
								</table>

							</article>
						</form>
						<article class="mgT16">
							<article class="conTitBox">
								<h6></h6>
							</article>
							<article class="conTitBtnR">
								<button type="button" onclick="moveRowsToUp(EDCK0102_grid)" able>▲</button>
								<button type="button" onclick="moveRowsToDown(EDCK0102_grid)" able>▼</button>
								<button type="button" class="add_01" onclick="addRow()" title="<spring:message code="btn.rowAdd"/>" able>
									<spring:message code="btn.rowAdd" />
								</button>
								<button type="button" class="del_01" onclick="fn_deleteRow(EDCK0102_grid)" title="<spring:message code="btn.rowDelete" />" able>
									<spring:message code="btn.rowDelete" />
								</button>
							</article>
						</article>

						<article class="mgT16">
							<div id="EDCK0102_grid" class="gridHeiSz05 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>