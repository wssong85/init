function getInputOption(param) {
	var ret = null;
	$.ajax({
		url : "/com/common/selectQueryDataList.do",
		data : param,
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				ret = data.result;
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
	return ret;
}

function fn_layoutSorting(grid, order) {
	var sortInfo = [];
	sortInfo[0] = {
		dataField : "SET_ORDR",
		sortType : 1
	}
	sortInfo[1] = {
		dataField : "SET_ROW_ORDR",
		sortType : 1
	}
	sortInfo[2] = {
		dataField : "SET_VRIABL_ORDR",
		sortType : 1
	}
	AUIGrid.setSorting(grid.id, sortInfo);

	if (order) {
		var old_set_sn = null;
		var set_ordr = 1;
		var rowItems = AUIGrid.getGridData(grid.id);
		for (var i = 0; i < rowItems.length; i++) {
			var set_sn = rowItems[i].SET_SN;
			if (old_set_sn == null || old_set_sn == set_sn) {
				old_set_sn = set_sn;
				rowItems[i].SET_ORDR = set_ordr;
			} else if (old_set_sn != set_sn) {
				old_set_sn = set_sn;
				set_ordr++;
				rowItems[i].SET_ORDR = set_ordr;
			}
			AUIGrid.updateRowsById(grid.id, rowItems[i]);
		}
	}
}

function fn_makeInputType(item, row_count, rn, stre_value) {
	var ret = "";
	var vriabl_se_code = item.VRIABL_SE_CODE;
	var param = new Object();
	param.QUERY = "selectEDCCodeList";
	param.FLAG = "CODELIST";
	param.TASK_SN = $("#frm_main #TASK_SN").val();
	param.DOMN_VRIABL_SN = item.DOMN_VRIABL_SN;
	var disabled = "disabled='disabled'";
	var cdisc_submit_value = item.CDISC_SUBMIT_VALUE;
	if (!item.CDISC_SUBMIT_VALUE) {
		cdisc_submit_value = "";
		disabled = "";
	}
	if (!stre_value) {
		stre_value = "";
	}
	switch (vriabl_se_code) {
	case "02"://Radio
		$(getInputOption(param)).each(function(index, entry) {
			ret += "<div style='display:inline-block; margin-right : 12px;'>";
			ret += '<input type="radio" id="var_value' + rn + "_" + (index + 1) + '" name="' + rn + '" value="' + entry.CODE + '"';
			if (entry.CODE == stre_value) {
				ret += '  checked="checked" ';
			}
			ret += ' read save><label for="var_value' + rn + "_" + (index + 1) + '" class="raLab"> <span>' + entry.VALUE + '</span></label>';
			ret += "</div>";
		});
		break;
	case "03"://Check
		$(getInputOption(param)).each(function(index, entry) {
			ret += "<div style='display:inline-block; margin-right : 12px;'>";
			ret += '<input type="checkbox" id="var_value' + rn + "_" + (index + 1) + '" name="' + rn + '" value="' + entry.CODE + '"';
			if (entry.CODE == stre_value) {
				ret += '  checked="checked" ';
			}
			ret += ' read save><label for="var_value' + rn + "_" + (index + 1) + '" class="chcLab"> <span>' + entry.VALUE + '</span></label>';
			ret += "</div>";
		});
		break;
	case "04"://Textarea
		ret += "<div>";
		ret += "<textarea id='var_value" + rn + "' name='" + rn + "' style='width: 100%; height : 100%;' read save></textarea>";
		ret += "</div>";
		break;
	case "05"://Date
		ret += "<div class=\"dateBox\">";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + stre_value + "' style='width: 120px;'  data-datatype=\"DATE\" data-yyuk=\"Y\" data-mmuk=\"Y\" data-dduk=\"Y\"  read save/>";
		ret += "</div>";
		break;
	case "06"://H/M
		ret += "<div>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "'  style='width: 100%;' read save/>";
		ret += "</div>";
		break;
	case "07"://Seq
		if (stre_value == "") {
			stre_value = row_count;
		}
		ret += "<div>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + stre_value + "' disabled='disabled'  style='width: 100%;' save seq/>";
		ret += "</div>";
		break;
	case "08"://analyte
		ret += "<div>";
		ret += "<label>" + cdisc_submit_value + "</label>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + cdisc_submit_value + "' disabled='disabled'  style='width: 100%; display : none;' analyte/>";
		ret += "</div>";
		break;
	case "09"://LAB
		ret += "<div>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "'  style='width: 100%;' read save/>";
		ret += "</div>";
		break;
	case "10"://Select
		ret += '<div><select id="var_value' + rn + '" name="' + rn + '" read save >';
		ret += '<option value="">';
		ret += 'Not Selected</option>';
		$(getInputOption(param)).each(function(index, entry) {
			ret += '<option value="' + entry.CODE + '"';
			if (entry.CODE == stre_value) {
				ret += ' selected="selected" ';
			}
			ret += '>' + entry.VALUE;
			ret += '</option>';
		});
		ret += "</select></div>";
		break;
	case "11"://Unit
		ret += "<div>";
		ret += "<label>" + cdisc_submit_value + "</label>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + cdisc_submit_value + "' disabled='disabled'  style='width: 100%; display : none;' save />";
		ret += "</div>";
		break;
	case "12"://SUBJID
		ret += "<div>";
		ret += "<label>" + stre_value + "</label>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + stre_value + "' disabled='disabled'  style='width: 100%; display : none;' />";
		ret += "</div>";
		break;
	case "13"://조사대상자번호
		ret += "<div>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + stre_value + "'   style='width: 100%;' save />";
		ret += "</div>";
		break;
	case "14"://Random No
		ret += "<div>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + stre_value + "' disabled='disabled' style='width: 100%;' />";
		ret += "</div>";
		break;
	default:
		ret += "<div>";
		ret += "<input type='text' id='var_value" + rn + "' name='" + rn + "' value='" + stre_value + "' " + disabled + " style='width: 100%;' read save />";
		ret += "</div>";
		break;
	}
	return ret;
}

function fn_makeCRFObject(grid) {
	var rowItems = AUIGrid.getGridData(grid.id);
	if (rowItems.length > 0) {
		var setSn = null;
		var setRowSn = null;
		var valRowSn = null;
		var set_ty_code = null;
		var vrArr = [];
		var rArr = [];
		var vArr = [];
		var sArr = [];
		for (var i = 0; i <= rowItems.length; i++) {
			if (setSn == null) {
				vArr.push(fn_setVriabl(rowItems[i]));

				setSn = rowItems[i].SET_SN;
				set_ty_code = rowItems[i].SET_TY_CODE;
				setRowSn = rowItems[i].SET_ROW_SN;
				varRowSn = rowItems[i].VRIABL_ROW_SN;
			} else if (i == rowItems.length) {
				var varRow = {};
				varRow.VRIABL_ROW_SN = varRowSn;
				varRow.vriabl = vArr;
				vrArr.push(varRow);

				var row = {};
				row.SET_ROW_SN = setRowSn;
				row.varRow = vrArr;
				rArr.push(row);

				var set = {};
				set.SET_SN = setSn;
				set.SET_TY_CODE = set_ty_code;
				set.row = rArr;
				sArr.push(set);
			} else if (setSn != rowItems[i].SET_SN) {
				var varRow = {};
				varRow.VRIABL_ROW_SN = varRowSn;
				varRow.vriabl = vArr;
				vrArr.push(varRow);

				var row = {};
				row.SET_ROW_SN = setRowSn;
				row.varRow = vrArr;
				rArr.push(row);

				var set = {};
				set.SET_SN = setSn;
				set.SET_TY_CODE = set_ty_code;
				set.row = rArr;
				sArr.push(set);

				rArr = [];
				vrArr = [];
				vArr = [];

				vArr.push(fn_setVriabl(rowItems[i]));

				set_ty_code = rowItems[i].SET_TY_CODE;
				setSn = rowItems[i].SET_SN;
				setRowSn = rowItems[i].SET_ROW_SN;
				varRowSn = rowItems[i].VRIABL_ROW_SN;
			} else if (setSn == rowItems[i].SET_SN && setRowSn == rowItems[i].SET_ROW_SN) {
				if (varRowSn == rowItems[i].VRIABL_ROW_SN) {
					vArr.push(fn_setVriabl(rowItems[i]));
				} else {
					var varRow = {};
					varRow.VRIABL_ROW_SN = varRowSn;
					varRow.vriabl = vArr;
					vrArr.push(varRow);

					vArr = [];
					vArr.push(fn_setVriabl(rowItems[i]));
					varRowSn = rowItems[i].VRIABL_ROW_SN;
				}
			} else if (setSn == rowItems[i].SET_SN && setRowSn != rowItems[i].SET_ROW_SN) {
				var varRow = {};
				varRow.VRIABL_ROW_SN = varRowSn;
				varRow.vriabl = vArr;
				vrArr.push(varRow);

				var row = {};
				row.SET_ROW_SN = setRowSn;
				row.varRow = vrArr;
				rArr.push(row);

				vrArr = [];
				vArr = [];

				vArr.push(fn_setVriabl(rowItems[i]));
				varRowSn = rowItems[i].VRIABL_ROW_SN;
				setRowSn = rowItems[i].SET_ROW_SN;

			}

		}
		return sArr;
	}
	return null;
}

function fn_setVriabl(item) {
	var vriabl = {};
	vriabl.SET_VRIABL_SN = item.SET_VRIABL_SN;
	vriabl.CDISC_SUBMIT_VALUE = item.CDISC_SUBMIT_VALUE;
	vriabl.VRIABL_NM = item.VRIABL_NM;
	vriabl.CRF_LBL_ONE = item.CRF_LBL_ONE;
	vriabl.CRF_LBL_TWO = item.CRF_LBL_TWO;
	vriabl.VRIABL_SE_CODE = item.VRIABL_SE_CODE;
	vriabl.DOMN_VRIABL_SN = item.DOMN_VRIABL_SN;
	vriabl.DC_CN = item.DC_CN;
	vriabl.DC_FONT_CODE = item.DC_FONT_CODE;
	vriabl.DC_FONT_CODE_VALUE = item.DC_FONT_CODE_VALUE;
	vriabl.DC_FONT_MG = item.DC_FONT_MG;
	vriabl.DC_FONT_MG_VALUE = item.DC_FONT_MG_VALUE;
	vriabl.DC_FONT_COLLR = item.DC_FONT_COLLR;
	vriabl.DC_LINK_CODE = item.DC_LINK_CODE;
	vriabl.VRIABL_ROW_SN = item.VRIABL_ROW_SN;
	vriabl.RN = item.RN;
	vriabl.STRE_VALUE = item.STRE_VALUE;

	return vriabl;
}

//내용부분 3뎁스
function fn_categoryView(d1, d2, d3) {
	var dep1 = d1 - 1;
	var dep2 = d2 - 1;
	var dep3 = d3 - 1;

	$(".depth_01 > dd > a").eq(dep1).addClass("open").next().slideDown("fast"); //첫번째 내용 보이기
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().addClass("open").slideDown("fast"); //두번째 내용 보이기

	//$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".link_01").removeClass("on"); //세번째 default text
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").find(".link_01").removeClass("on");
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".link_01").eq(dep3).addClass("on"); //세번째 text 표시
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".popup_01").removeClass("on"); //세번째 default 팝업 아이콘
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".popup_01").eq(dep3).addClass("on"); //세번째 팝업 아이콘 표시

}

//내용부분 크기 조정
function fn_conResize() {
	var con_boxd = $('.contents_01_in').height();
	$('.con_category_01').css({
		"height" : con_boxd + 17 + "px"
	});
	$('.conBox_01').css({
		"height" : con_boxd + 22 + "px"
	});
	$('.depth_01').css({
		"height" : con_boxd - 29 + "px"
	});
	$('.depth_02').css({
		"height" : con_boxd + 20 + "px"
	});
	$('.dumi_01').css({
		"height" : con_boxd + 20 + "px"
	});
	$('.contents_01').css({
		"top" : -con_boxd - 19 + "px"
	});
	$('.lnb').addClass('lnb_relative');

}

function fn_showComment(grid2, div_id) {
	var rowItems = AUIGrid.getGridData(grid2.id);
	for (var i = 0; i < rowItems.length; i++) {
		if (rowItems[i].CM_MSSAGE && rowItems[i].CM_MSSAGE != "") {
			var tr_cmt = $("#" + div_id + " tr[name=tr_cmt" + rowItems[i].SET_ROW_SN + "_" + rowItems[i].VRIABL_ROW_SN + "]");
			tr_cmt.show();
			tr_cmt.find("#tbl_cmt").show();
			tr_cmt.find("#pre_cmt").text(rowItems[i].CM_MSSAGE);
			tr_cmt.find("textarea").val(rowItems[i].CM_MSSAGE);
			tr_cmt.find("textarea").hide();
			tr_cmt.find("textarea").attr("id", "cmt");
		}
	}
}

function fn_makeDescription(entry, div_id, link) {
	var item = entry.row[0].varRow[0].vriabl[0];
	var dc = "";
	var style = null;
	if (item.DC_CN != null && item.DC_CN != "") {
		dc = item.DC_CN;
		style = "style='cursor : pointer; font-family : " + item.DC_FONT_CODE_VALUE + "; color : " + item.DC_FONT_COLLR + "; ";
		style += "font-size : " + item.DC_FONT_MG_VALUE + "px; line-height : " + (Number(item.DC_FONT_MG_VALUE) + 10) + "px;'";
	}

	var str = "<div name='div_set'>";
	str += "<table class='tb004 tb004_no_border' >";
	if (link && item.DC_LINK_CODE) {
		str += "<tr onclick='popupCRFPage();'>";
	} else {
		str += "<tr>";
	}
	str += "<td>";
	if (style != null) {
		str += "<span " + style + ">";
	} else {
		str += "<span>";
	}
	str += dc;
	str += "</span>";
	str += "</td><td style='width: 180px;'>";
	str += "</td></tr></table></div>";
	$("#" + div_id).append(str);
}

function fn_getCRFVisitList(instt_form_sn, subject_no, subject_count, url) {
	$("#frm_main #INSTT_FORM_SN").val(instt_form_sn);
	$("#frm_main #SUBJECT_NO").val(subject_no);
	var param = new Object();
	param.TASK_SN = $("#frm_main #TASK_SN").val();
	param.INSTT_FORM_SN = instt_form_sn;
	param.SUBJECT_NO = subject_no;
	$.ajax({
		url : url,
		data : param,
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				var str = "";
				str += '<dt>';
				str += '<span>' + subject_no + ' - </span>';
				str += '</dt>';
				$(data.result).each(function(index, entry) {
					str += '<dd id=visit_' + (index + 1) + '>';
					str += '<a href="#void"><span>' + entry.VISIT_LBL + '</span></a>';
					$(entry.GROUP_LIST).each(function(index2, entry2) {
						str += '<dl class="depth_03">';
						str += '<dd>';
						str += '<a href="javascript:getCRFPage(' + entry.VISIT_SN + ',' + entry.SN + ',' + entry2.VISIT_GROUP_SN + ',' + subject_count + ',' + (index + 1) + ',' + (index2 + 1) + ');" class="link_01">';
						str += '<span>' + entry2.GROUP_LBL + '</span></a>';
						str += '<a href="javascript:fn_popupCRFView(' + entry.VISIT_SN + ',' + entry.SN + ',' + entry2.VISIT_GROUP_SN + ');" class="popup_01"><span>popup</span></a>';
						str += '<div class="mark_01">';
						str += '<span class="small_icon_08" title="SDV 완료"></span>';
						str += '</div>';
						str += '</dd>';
						str += '</dl>';
					});
					str += '</dd>';
				});
				$("#depth2_" + subject_no).html(str);

				$(".depth_02 > dd > a").click(function() {
					if ($(this).next("dl").hasClass("depth_03")) {
						$(this).toggleClass("open").parent().find(".depth_03").slideToggle("fast");
					} else {
						$(this).removeClass("open");
					}
					//나머지 닫힘
					//$(".depth_02 > dd > a").not(this).removeClass("open").parent().find(".depth_03").slideUp("fast");

				});

				var visit_count = $("#frm_main #visit_count").val();
				var group_count = $("#frm_main #group_count").val();
				$(".depth_01 > dd").eq(subject_count - 1).find(".depth_02 > dd").eq(visit_count - 1).find(".depth_03 > dd").eq(group_count - 1).find("span").eq(0).trigger("click");

				$("#move_subject_no").val(subject_count);
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
}

function moveCRF(type) {
	var subject_count = Number($("#frm_main #subject_count").val());
	var visit_count = Number($("#frm_main #visit_count").val());
	var group_count = Number($("#frm_main #group_count").val());
	if (type == "P") {
		group_count = (group_count - 1);
		if (group_count == 0) {
			visit_count = (visit_count - 1);
			if (visit_count != 0) {
				group_count = $("#visit_" + visit_count).find("dl").length;
				$(".depth_01 > dd").eq(subject_count - 1).find(".depth_02 > dd").eq(visit_count - 1).find(".depth_03 > dd").eq(group_count - 1).find("span").eq(0).trigger("click");
			} else {
				alert("이전 CRF가 존재하지 않습니다.");
			}
		} else {
			$(".depth_01 > dd").eq(subject_count - 1).find(".depth_02 > dd").eq(visit_count - 1).find(".depth_03 > dd").eq(group_count - 1).find("span").eq(0).trigger("click");
		}
	} else {
		var group_total = $("#visit_" + visit_count).find("dl").length;
		group_count = (group_count + 1);
		if (group_count > group_total) {
			visit_count = (visit_count + 1);
			if ($("#visit_" + visit_count).length == 0) {
				alert("다음 CRF가 존재하지 않습니다.");
			} else {
				group_count = 1;
				$(".depth_01 > dd").eq(subject_count - 1).find(".depth_02 > dd").eq(visit_count - 1).find(".depth_03 > dd").eq(group_count - 1).find("span").eq(0).trigger("click");
			}
		} else {
			$(".depth_01 > dd").eq(subject_count - 1).find(".depth_02 > dd").eq(visit_count - 1).find(".depth_03 > dd").eq(group_count - 1).find("span").eq(0).trigger("click");
		}
	}
}

function fn_popupCRFView(visit_sn, sn, visit_group_sn) {
	var param = {};
	param.TASK_SN = $("#frm_main #TASK_SN").val();
	param.INSTT_FORM_SN = $("#frm_main #INSTT_FORM_SN").val();
	param.SUBJECT_NO = $("#frm_main #SUBJECT_NO").val();
	param.VISIT_SN = visit_sn;
	param.SN = sn;
	param.VISIT_GROUP_SN = visit_group_sn;

	mkLayerPopupOpen("./popupEDCC0112.do", param, 1);
}