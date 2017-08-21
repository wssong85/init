<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var grCmJobUser2 = {
		id : '',
		div : {
			gridDiv : '#grCmJobUser2'
		},
		proxy : {
			url : "<c:url value='/com/z09/selectCmJobUserListForAll.do'/>",
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true
		},
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : true,
			enableColumnResize : true,
			enableMovingColumn : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "multipleRows",
			softRemoveRowMode : false,
			showStateColumn : true,
			rowIdField : 'UNIQUE_ID'
		},
		columnLayout : [ {
			dataField : "DEPT_NM",
			headerText : '<spring:message code="comz0902.gr.DEPT_NM"/>',
			filter : {
				showIcon : true
			}
		}, {
			dataField : "USER_NM",
			headerText : '<spring:message code="comz0902.gr.USER_NM"/>',
			filter : {
				showIcon : true
			}
		}, {
			dataField : "UNIQUE_ID",
			headerText : "UNIQUE_ID",
			filter : {
				showIcon : true
			},
			visible : false
		} ],
		createGrid : function() {
			var me = this;

			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);

			window.setTimeout(function() {
				AUIGrid.resize(me.id);
			}, 0.5);

			me.binding();

			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		binding : function() {
			var me = this;

			AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
				e.item['SANCTN_CODE'] = '02';
				e.item['SANCTN_ORDR'] = 0;
				e.item['CONFMER_ID'] = e.item['USER_ID'];
				e.item['CONFMER_NM'] = e.item['USER_NM'];
				e.item['USE_YN'] = 'Y';

				AUIGrid.addRow(grCmSancline2.id, e.item, 'last');
				AUIGrid.removeRow(me.id, 'selectedIndex');
			});
		},
		load : function() {
			var me = this;

			AUIGrid.showAjaxLoader(me.id);

			$.ajax({
				url : me.proxy.url,
				type : me.proxy.type,
				dataType : me.proxy.dataType,
				data : me.proxy.param,
				success : function(data) {
					if (data.success) {
						AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						AUIGrid.setSelectionByIndex(me.id, 0);

						if (grCmSancline2.id) {
							var arrGrCmSancline = AUIGrid.getGridData(grCmSancline2.id);

							if (arrGrCmSancline) {

								if (!arrGrCmSancline.length) {
									return;
								}

								var arrUniqueId = [];

								for (var i = 0; i < arrGrCmSancline.length; i++) {
									arrUniqueId.push(arrGrCmSancline[i]['UNIQUE_ID']);
								}

								AUIGrid.removeRowByRowId(me.id, arrUniqueId);
							}
						}

					} else {
						AUIGrid.removeAjaxLoader(me.id);
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		}
	};

	var grCmSancline2 = {
		id : '',
		div : {
			gridDiv : '#grCmSancline2'
		},
		proxy : {
			url : "<c:url value='/com/z09/selectCmSanClineDetailListByPk.do'/>",
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false
		},
		gridPros : {
			// 페이징 사용
			showRowNumColumn : true,
			enableColumnResize : true,
			enableMovingColumn : false,
			showRowCheckColumn : true,
			editable : true,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "multipleRows",
			softRemoveRowMode : false,
			rowIdField : 'UNIQUE_ID',
			showStateColumn : true
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "SANCTN_CODE",
			headerText : '<spring:message code="comz0902.gr.SANCTN_CODE"/>',
			labelFunction : function(rowIndex, columnIndex, value, headerText, item) {
				var me = grCmSancline2;
				var retStr = "";

				for (var i = 0; i < me.columnLayout[0].editRenderer.list.length; i++) {
					if (me.columnLayout[0].editRenderer.list[i]['CMMN_CODE'] == value) {
						retStr = me.columnLayout[0].editRenderer.list[i]['CMMN_CODE_NM'];
						break;
					}
				}

				if (!retStr) {
					return AUIGrid.getItemByRowIndex(me.id, rowIndex)['CMMN_CODE_NM'];
				} else {
					return retStr;
				}
			},
			editRenderer : {
				type : "DropDownListRenderer",
				showEditorBtnOver : true,
				list : '',
				keyField : "CMMN_CODE",
				valueField : "CMMN_CODE_NM"
			}
		}, {
			dataField : "DEPT_NM",
			headerText : '<spring:message code="comz0902.gr.DEPT_NM"/>',
			editable : false
		}, {
			dataField : "CONFMER_NM",
			headerText : '<spring:message code="comz0902.gr.CONFMER_NM"/>',
			editable : false
		}, {
			dataField : "CONFMER_ID",
			headerText : "CONFMER_ID",
			visible : false
		}, {
			dataField : "UNIQUE_ID",
			headerText : "UNIQUE_ID",
			visible : false
		}, {
			dataField : "STTUS_ORDR",
			headerText : "STTUS_ORDR",
			visible : false
		}, {
			dataField : "SANCTN_ORDR",
			headerText : "SANCTN_ORDR",
			visible : false
		} ],
		//AUI 그리드 생성
		createGrid : function() {

			var me = this;

			$.ajax({
				url : "<c:url value='/com/common/selectQueryDataList.do'/>",
				type : 'post',
				dataType : 'json',
				data : {
					'QUERY' : 'selectCmCmmCodeByCmmnClcode',
					'CMMN_CLCODE' : 'COM003',
					'TYPE' : '${ TYPE }'
				},
				success : function(data) {
					if (data.success) {

						me.columnLayout[0].editRenderer.list = data.result;

						me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);

						window.setTimeout(function() {
							AUIGrid.resize(me.id);
						}, 0.5);

						me.binding();

						if (me.proxy.autoLoad) {
							me.load();
						}
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		},
		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;

			AUIGrid.bind(me.id, 'headerClick', function(event) {
				return false;
			});

			AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
				AUIGrid.addRow(grCmJobUser2.id, AUIGrid.getSelectedItems(me.id)[0].item, 'last');
				AUIGrid.removeRow(me.id, 'selectedIndex');
			});
		},
		load : function() {
			var me = this;

			AUIGrid.showAjaxLoader(me.id);

			$.ajax({
				url : me.proxy.url,
				type : me.proxy.type,
				dataType : me.proxy.dataType,
				data : me.proxy.param,
				success : function(data) {
					if (data.success) {
						AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						AUIGrid.setSelectionByIndex(me.id, 0);

						grCmJobUser2.load();
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		}
	};

	$(function() {
		grCmJobUser2.createGrid();
		grCmSancline2.createGrid();
		$('#selectCmSancline2').hide();
		$('#txtSanClineNm').show();

		$("#btnInit2").click(function() {
			$.ajax({
				url : "<c:url value='/com/z09/selectCmSanClineListForComboBox.do'/>",
				success : function(data) {
					loadCombo($("#selectCmSancline2"), data.result);
					$("#selectCmSancline2").val("");
				}
			});
			AUIGrid.destroy(grCmJobUser2.id);
			AUIGrid.destroy(grCmSancline2.id);
			grCmJobUser2.createGrid();
			grCmSancline2.createGrid();
		});

		$("#btnAdd2").click(function() {

			var checkedItems = AUIGrid.getCheckedRowItems(grCmJobUser2.id);

			if (!checkedItems.length) {
				return;
			}

			if (checkedItems.length > 11) {
				alert('<spring:message code="comz09.message.1"/>');
				return;
			}

			for (var i = 0; i < checkedItems.length; i++) {

				checkedItems[i].item['SANCTN_CODE'] = '02';
				checkedItems[i].item['SANCTN_ORDR'] = 0;
				checkedItems[i].item['CONFMER_ID'] = checkedItems[i].item['USER_ID'];
				checkedItems[i].item['CONFMER_NM'] = checkedItems[i].item['USER_NM'];
				checkedItems[i].item['USE_YN'] = 'Y';

				AUIGrid.addRow(grCmSancline2.id, checkedItems[i].item, 'last');
			}

			AUIGrid.removeCheckedRows(grCmJobUser2.id);

		});

		$("#btnCmSancline2Delete").click(function() {

			var checkedItems = AUIGrid.getCheckedRowItems(grCmSancline2.id);

			if (!checkedItems.length) {
				return;
			}

			if (checkedItems.length > 11) {
				alert('<spring:message code="comz09.message.1"/>');
				return;
			}

			for (var i = 0; i < checkedItems.length; i++) {
				AUIGrid.addRow(grCmJobUser2.id, checkedItems[i].item, 'last');
			}

			AUIGrid.removeCheckedRows(grCmSancline2.id);

		});

		$("#btnCmSancline2Up").click(function() {
			AUIGrid.moveRowsToUp(grCmSancline2.id);
		});

		$("#btnCmSancline2Down").click(function() {
			AUIGrid.moveRowsToDown(grCmSancline2.id);
		});

		$("#btnCmSancline2Close").click(function() {
			layerClose(2);
		});

		$("#btnCmSancline2Save").click(function() {
			var arrSanctnCode = AUIGrid.getColumnValues(grCmSancline2.id, 'SANCTN_CODE');

			if ("${ TYPE }" != "BLIND") {//공통 사용
				alert(1);
				if (!fn_hasValueByArr(arrSanctnCode, '01') || !fn_hasValueByArr(arrSanctnCode, '07')) {
					alert('<spring:message code="comz09.message.3"/>');
					return;
				}

				if (fn_hasValueByArr(arrSanctnCode, '01') > 1 || fn_hasValueByArr(arrSanctnCode, '02') > 1 || fn_hasValueByArr(arrSanctnCode, '07') > 1) {
					alert('<spring:message code="comz09.message.4"/>');
					return;
				}

				if (arrSanctnCode[0] != '01') {
					alert('<spring:message code="comz09.message.5"/>');
					return;
				}

				var bCheck = false;
				for (var i = 0; i < arrSanctnCode.length; i++) {
					if (arrSanctnCode[i] == '07') {
						bCheck = true;
					}

					if (arrSanctnCode[i] == '02') {
						bCheck = false;
					}
				}

				if (!bCheck) {
					alert('<spring:message code="comz09.message.7"/>');
					return;
				}

			} else {//EDC Designer - Blind 결재선 설정시 사용
				if (!fn_hasValueByArr(arrSanctnCode, '07')) {
					alert('<spring:message code="comz09.message.30"/>');
					return;
				}

				if (fn_hasValueByArr(arrSanctnCode, '02') > 1 || fn_hasValueByArr(arrSanctnCode, '07') > 1) {
					alert('<spring:message code="comz09.message.31"/>');
					return;
				}

				var bCheck = false;
				for (var i = 0; i < arrSanctnCode.length; i++) {
					if (arrSanctnCode[i] == '07') {
						bCheck = true;
					}

					if (arrSanctnCode[i] == '02') {
						bCheck = false;
					}
				}

				if (!bCheck) {
					alert('<spring:message code="comz09.message.32"/>');
					return;
				}

			}
			if (!fn_checkGroupingByArr(arrSanctnCode)) {
				alert('<spring:message code="comz09.message.6"/>');
				return;
			}

			var auiItems = AUIGrid.getGridData(grCmSancline2.id);
			var vCount = 1;

			for (var i = 0; i < auiItems.length; i++) {
				if (auiItems[i]['SANCTN_CODE'] != '05') {
					AUIGrid.updateRowsById(grCmSancline2.id, {
						'UNIQUE_ID' : auiItems[i]['UNIQUE_ID'],
						'STTUS_ORDR' : (i + 1),
						'SANCTN_ORDR' : 0
					});
				} else {
					AUIGrid.updateRowsById(grCmSancline2.id, {
						'UNIQUE_ID' : auiItems[i]['UNIQUE_ID'],
						'STTUS_ORDR' : (i + 1),
						'SANCTN_ORDR' : vCount
					});
					vCount++;
				}
			}

			var reqUrl = '';
			if ("${ TYPE }" != "BLIND") {
				if ($(":radio[name='raCmSancline']:checked").val() == 'U') {
					reqUrl = '/com/z09/insertSanClineForUpdate.do';

					if (!$('#selectCmSancline2 option:selected').val()) {
						alert('<spring:message code="comz09.message.18"/>');
						// 						alert('수정 기준값이 없습니다.');
						return;
					}

				} else {
					reqUrl = "<c:url value='/com/z09/insertSanClineForCreate.do'/>";

					if (!$('#txtSanClineNm').val()) {
						alert('<spring:message code="comz09.message.2"/>');
						// 						alert('결재선명을 기입해 주십시오.');
						return;
					}

				}
				var arJson = AUIGrid.getGridData(grCmSancline2.id);

				for (var i = 0; i < arJson.length; i++) {
					arJson[i]['CURD'] = 'X';
					arJson[i]['SANCLINE_SN'] = $('#selectCmSancline2 option:selected').val();
				}

				arJson.push({
					'CURD' : 'M',
					'USE_YN' : 'Y',
					'SANCLINE_NM' : $('#txtSanClineNm').val(),
					'SANCLINE_SN' : $('#selectCmSancline2 option:selected').val()
				});

			} else if ("${ TYPE }" == "BLIND") {
				if ("${ SANCLINE_SN }" == "") {
					reqUrl = "<c:url value='/com/z09/insertSanClineForCreate.do'/>";
				} else {
					reqUrl = "<c:url value='/com/z09/insertSanClineForUpdate.do'/>";
				}

				var arJson = AUIGrid.getGridData(grCmSancline2.id);

				for (var i = 0; i < arJson.length; i++) {
					arJson[i]['CURD'] = 'X';
					arJson[i]['SANCLINE_SN'] = $('#SANCLINE_SN').val();
				}

				arJson.push({
					'CURD' : 'M',
					'USE_YN' : 'Y',
					//'SANCLINE_NM' : $('#txtSanClineNm').val(),
					'SANCLINE_SN' : $('#SANCLINE_SN').val()
				});
			}

			$.ajax({
				url : reqUrl,
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(arJson),
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						AUIGrid.removeRowByRowId(grCmSancline2.id, AUIGrid.getColumnValues(grCmSancline2.id, 'UNIQUE_ID'));
						AUIGrid.resetUpdatedItems(grCmSancline2.id, 'all');
						if ("${ TYPE }" != "BLIND") {
							$.ajax({
								url : "<c:url value='/com/z09/selectCmSanClineListForComboBox.do'/>",
								success : function(data) {

									if (data.SANCLINE_SN) {
										$
										{
											callbackFunction
										}
										(data.SANCLINE_SN);
									}

									if ('${callbackFunction}') {
										$
										{
											callbackFunction
										}
										($('#selectCmSancline2 option:selected').val());
									}

									loadCombo($("#selectCmSancline2"), data.result);
									$("#selectCmSancline2").val("");
									$("#txtSanClineNm").val("");
								}
							});
						} else if ("${ TYPE }" == "BLIND") {
							if (data.SANCLINE_SN) {
								updateTaskBlindPk(data.SANCLINE_SN);
								$('#SANCLINE_SN').val(data.SANCLINE_SN);
							}
							grCmSancline2.proxy.param = {
								'SANCLINE_SN' : $('#SANCLINE_SN').val()
							};
							grCmSancline2.load();
						}
					} else {
						AUIGrid.removeAjaxLoader(grCmSancline2.id);
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});

		});

		if ("${ TYPE }" != "BLIND") {

			$("#raCmSanclineCreate").click(function() {
				$('#txtSanClineNm').css('width', 200);

				$('#selectCmSancline2').hide();
				$('#txtSanClineNm').val('');

				AUIGrid.removeRowByRowId(grCmSancline2.id, AUIGrid.getColumnValues(grCmSancline2.id, 'UNIQUE_ID'));
				AUIGrid.resetUpdatedItems(grCmSancline2.id, 'all');

			});

			$("#raCmSanclineUpdate").click(function() {
				$('#txtSanClineNm').css('width', 90);

				$('#selectCmSancline2').show();
				$('#txtSanClineNm').val($('#selectCmSancline2 option:selected').text());
				grCmSancline2.load();

			});

			$("#selectCmSancline2").change(function() {
				if ($('#selectCmSancline2 option:selected').val()) {
					grCmSancline2.proxy.param = {
						'SANCLINE_SN' : $('#selectCmSancline2 option:selected').val()
					};
					grCmSancline2.load();

					$('#txtSanClineNm').val($('#selectCmSancline2 option:selected').text());
				}
			});

			$.ajax({
				url : "<c:url value='/com/z09/selectCmSanClineListForComboBox.do'/>",
				success : function(data) {
					loadCombo($("#selectCmSancline2"), data.result);
					$("#selectCmSancline2").val("");
				}
			});
		} else if ("${ TYPE }" == "BLIND") {
			var sancline_sn = $('#SANCLINE_SN').val();
			if (sancline_sn != "") {
				grCmSancline2.proxy.param = {
					'SANCLINE_SN' : sancline_sn
				};
				grCmSancline2.load();
			}
		}

	});
</script>
</head>
<body>
	<!-- 메인 시작 -->

	<section class="popupWrap">
		<div class="popup popup2 wd1000">
			<section class="conBox50 conBox" style="float: left; width: 48%; padding: 0;">
				<div class="conBoxInner" style="padding-bottom: 0px;">


					<article class="conTitBox">
						<h5>
							<spring:message code="comz0902.title.1" />
						</h5>
					</article>



					<article class="conTitBtnR">
						<!--                     	<input type="button" id="btnMove2" value="설정"> -->
						<input type="button" id="btnInit2" value="초기화" class="reset_01">
						<!-- <input type="button" id="btnAdd2" value="추가"> -->
					</article>


					<article class="mgT16">
						<div id="grCmJobUser2" class="gridHeiSz12 grid_wrap tb01_2"></div>
					</article>
				</div>
			</section>


			<div>
				<input type="button" id="btnAdd2" class="big_arrow_btn_01" value="▶">
			</div>

			<div>
				<input type="button" id="btnCmSancline2Delete" class="big_arrow_btn_02" value="◀">
			</div>

			<style>
.big_arrow_btn_01 {
	position: absolute;
	transition-duration: 0s !important;
	left: 48.6%;
	top: 38%;
	padding: 14px 5px 15px 5px !important;
	height: 60px !important;
	background: #4c55a4 !important;
	font-size: 20px !important;
}

.big_arrow_btn_02 {
	position: absolute;
	transition-duration: 0s !important;
	left: 48.6%;
	top: 49%;
	padding: 14px 5px 15px 5px !important;
	height: 60px !important;
	background: #4c55a4 !important;
	font-size: 20px !important;
}
</style>
			<section class="conBox50 conBox" style="float: right; width: 48%; padding: 0;">
				<div class="conBoxInner" style="padding-bottom: 0px;">


					<article class="conTitBox">
						<h5>
							<spring:message code="comz0902.title.2" />
						</h5>
					</article>

					<c:if test="${ TYPE != 'BLIND' }">
						<article class="conTitBtnR">
							<input type="button" id="btnCmSancline2Up" value="▲">
							<input type="button" id="btnCmSancline2Down" value="▼">
							<!-- <input type="button" id="btnCmSancline2Delete" value="행삭제"> -->
						</article>

						<article class="conTitBtn">
							<article class="conTitBtnL mgT6">
								<div style="display: inline-block; position: relative; top: 3px;">
									<input type="radio" id="raCmSanclineCreate" name="raCmSancline" checked value="C">
									<label for="raCmSanclineCreate" class="raLab"><span><spring:message code="comz0902.radio.1" /></span></label>
									<input type="radio" id="raCmSanclineUpdate" name="raCmSancline" value="U">
									<label for="raCmSanclineUpdate" class="raLab"><span><spring:message code="comz0902.radio.2" /></span></label>
								</div>
								<div style="display: inline-block; position: relative; right: -26px;">
									<spring:message code="comz0902.select" />
									:
									<div style="display: inline-block; width: 200px;">
										<input type="text" id="txtSanClineNm" name="SANCLINE_NM" class="pdR20" style="width: 200px" />
										<!-- 		                       	//신규일시 width 300? -->
										<!-- 		                       	//수정일시 width 80? -->
										<select id="selectCmSancline2" style="width: 100px">
											<option>===selected===</option>
										</select>
									</div>
									<input type="button" id="btnCmSancline2Save" value=<spring:message code="btn.save"/> class="save_01" title="<spring:message code="btn.save"/>">
									<!--  <input type="button" id="btnCmSancline2Close" value="닫기"> -->
								</div>
							</article>
						</article>

						<article class="mgT53">
							<div id="grCmSancline2" class="gridHeiSz11 grid_wrap tb01_2"></div>
						</article>
					</c:if>

					<c:if test="${ TYPE == 'BLIND' }">
						<article class="conTitBtnR mgT6">
							<input type="button" id="btnCmSancline2Up" value="▲">
							<input type="button" id="btnCmSancline2Down" value="▼">
							<input type="button" id="btnCmSancline2Save" value=<spring:message code="btn.save"/>>
						</article>
						<input type="hidden" id="SANCLINE_SN" name="SANCLINE_SN" value="${ SANCLINE_SN }">
						<article class="mgT16">
							<div id="grCmSancline2" class="gridHeiSz11 grid_wrap tb01_2"></div>
						</article>
					</c:if>

				</div>
			</section>

			<div style="clear: both; text-align: center; padding: 10px 10px 10px 0;">
				<input type="button" id="btnCmSancline2Close" value=<spring:message code="btn.close"/>>
			</div>

		</div>
	</section>
	<!-- 메인 끝 -->
</body>
</html>
