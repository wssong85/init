/**
 * 
 */
///////////////////////////////////////////////////////////////////////////
//Function Name	: mkLayerPopupOpen
//Parameter Info	: 팝업으로 띄울 url
//Return Info		: 
//Description		: 해당 url 경로의 페이지를 레이어 팝업으로 호출함.
///////////////////////////////////////////////////////////////////////////
var bg_z_index = 100;
var popup_z_index = 101;
$(window).resize(function() {
	$(".popup").positionCenter();
}); // 브라우저 창 사이즈 조절할 때도 항상 중앙 정렬

function mkLayerPopupOpen(url, param, index) { //실제 페이지에서 호출하는 함수
	if (index == undefined) {
		index = "";
	}
	writeLayerPopup(url, param, index);

	layerOpen(index);
}

function writeLayerPopup(url, param, index) { //레이어 팝업으로 보여질 부분을 그려줌
	if (index == "") {
		$("body").append("<div class='popup_bg'></div>");
	} else {
		$("body").append("<div class='popup_bg popup_bg" + index + "'></div>");
	}
	$("body").append("<div id='layer_pop" + index + "'></div>");
	$("#layer_pop" + index).load(url, param);
}

function layerOpen(index) { //해당 레이어 팝업을 오픈함.
	$(".popup_bg, .popup" + index).fadeIn(500);
	$(".popup" + index).positionCenter();
	if (index == "") {
		$(".popup_bg").css("z-index", bg_z_index);
		$(".popup").css("z-index", popup_z_index);
	} else {
		$(".popup_bg" + index).css("z-index", bg_z_index);
		$(".popup" + index).css("z-index", popup_z_index);
	}

	bg_z_index += 100;
	popup_z_index += 100;
}
function layerClose(index) { //해당 레이어 팝업을 닫음
	if (index == undefined) {
		index = "";
	}
	$(".popup_bg" + index + ", .popup" + index).fadeOut(500);
	$(".popup_bg" + index + ", #layer_pop" + index).remove();

	bg_z_index -= 100;
	popup_z_index -= 100;
}
///////////////////////////////////////////////////////////////////////////
//Function Name	: mkDisabled, mkEnabled
//Parameter Info	: 
//Return Info		: 
//Description		: 컨트롤의 활성화 비활성화
///////////////////////////////////////////////////////////////////////////
function mkDisabled() {
	$("[able]").attr("disabled", true);
}
function mkEnabled() {
	$("[able]").attr("disabled", false);
}
///////////////////////////////////////////////////////////////////////////
//Function Name	: mkMessageFunc
//Parameter Info	: msg - 처리할 메시지, errOpt - 에러옵션(없거나 0일 때는 에러 아님)
//Return Info		: 
//Description		: 메시지를 출력할 때 쓰는 함수
///////////////////////////////////////////////////////////////////////////
var errorOptions = {
	id : "show_message_error",
	backgroundColor : "red",
	color : "white"
};
function mkMessageFunc(msg, errOpt) {
	if (errOpt == null || errOpt == undefined || errOpt == 0) {
		$.showMessage(msg);
	} else {
		$.showMessage(msg, errorOptions);
	}
}

/**
 * 일정 값에 맞춰서 각 값에 tag를 넣는다.
 * 
 * @param v 값
 * @param n 나눌 숫자
 * @param tag 나눈 후 넣을 tag
 * @returns {String}
 */
function mkAppendBrTag(v, n, tag) {
	var vFor = Math.ceil(v.length / n);
	var vRet = '';
	if (v.length > n) {
		for (var i = 0; i < vFor; i++) {
			if (i < vFor - 1) {
				vRet += v.substring(n * i, (i + 1)) + tag;
			} else {
				vRet += v.substring(n * i, (i + 1));
			}
		}
	}
	return vRet;
}

/**
 * 
 * @param me
 * @param goPage
 */
function fn_createPagingNavigator(me, goPage) {
	var grid = (me.id).substring(1, (me.id).length);
	me.div.paging.totalPage = Math.ceil(me.div.paging.totalRowCount / me.div.paging.rowCount);
	var prevPage = parseInt((goPage - 1) / me.div.paging.pageButtonCount) * me.div.paging.pageButtonCount;
	var nextPage = ((parseInt((goPage - 1) / me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount + 1;
	prevPage = Math.max(0, prevPage);
	nextPage = Math.min(nextPage, me.div.paging.totalPage);
	if (goPage == 0) {
		goPage = 1;
	}
	//셀렉트박스
	var retStr = "<select class='rowSel' onchange='javascript:" + grid + ".moveToPage(" + grid + ".div.paging.currentPage, this.value)'>"
	if (me.div.paging.rowCount == 20) {
		retStr += "<option value=20 selected=true>rows 20</option>"
	} else {
		retStr += "<option value=20>rows 20</option>"
	}
	if (me.div.paging.rowCount == 50) {
		retStr += "<option value=50 selected=true>rows 50</option>"
	} else {
		retStr += "<option value=50>rows 50</option>"
	}
	if (me.div.paging.rowCount == 100) {
		retStr += "<option value=100 selected=true>rows 100</option>"
	} else {
		retStr += "<option value=100>rows 100</option>"
	}
	if (me.div.paging.rowCount == 300) {
		retStr += "<option value=300 selected=true>rows 300</option>"
	} else {
		retStr += "<option value=300>rows 300</option>"
	}
	if (me.div.paging.rowCount == 500) {
		retStr += "<option value=500 selected=true>rows 500</option>"
	} else {
		retStr += "<option value=500>rows 500</option>"
	}
	if (me.div.paging.rowCount == 1000) {
		retStr += "<option value=1000 selected=true>rows 1000</option>"
	} else {
		retStr += "<option value=1000>rows 1000</option>"
	}
	if (me.div.paging.rowCount == 5000) {
		retStr += "<option value=5000 selected=true>rows 5000</option>"
	} else {
		retStr += "<option value=5000>rows 5000</option>"
	}
	if (me.div.paging.rowCount == 10000) {
		retStr += "<option value=10000 selected=true>rows 10000</option>"
	} else {
		retStr += "<option value=10000>rows 10000</option>"
	}
	if (me.div.paging.rowCount == 20000) {
		retStr += "<option value=20000 selected=true>rows 20000</option>"
	} else {
		retStr += "<option value=20000>rows 20000</option>"
	}
	if (me.div.paging.rowCount == 50000) {
		retStr += "<option value=50000 selected=true>rows 50000</option>"
	} else {
		retStr += "<option value=50000>rows 50000</option>"
	}
	if (me.div.paging.rowCount == 100000) {
		retStr += "<option value=100000 selected=true>rows 100000</option>"
	} else {
		retStr += "<option value=100000>rows 100000</option>"
	}
	retStr += "</select>"
	// 처음
	retStr += "<span class='aui-grid-paging-grup'>";
	retStr += "<a href='javascript:" + grid + ".moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";
	// 이전
	retStr += "<a href='javascript:" + grid + ".moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
	for (var i = (prevPage + 1), len = (me.div.paging.pageButtonCount + prevPage); i <= len; i++) {
		if (goPage == i) {
			retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
		} else {
			retStr += "<a href='javascript:" + grid + ".moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
			retStr += i;
			retStr += "</span></a>";
		}
		if (i >= me.div.paging.totalPage) {
			break;
		}
	}
	// 다음
	retStr += "<a href='javascript:" + grid + ".moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
	// 마지막
	retStr += "<a href='javascript:" + grid + ".moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>"
	retStr += "</span>";

	document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
}

/**
 * 
 */
function fn_moveToPage(me, goPage, rowCount) {
	// 현재 페이지 보관
	me.div.paging.currentPage = goPage;
	// selectBox에서 요청시, 1페이지부터 시작
	if (rowCount) {
		me.div.paging.rowCount = rowCount;
		me.div.paging.currentPage = 1;
		goPage = 1;
	}
	me.load(me.div.paging.rowCount, goPage);
}

/**
 * 
 */
function fn_load(me, v1, v2) {
	//autoLoad로 처음 화면 데이터 로딩 
	if (me.proxy.paging && !v1 && !v2) {
		me.proxy.param.PAGE = me.div.paging.currentPage;
		me.proxy.param.COUNT = me.div.paging.rowCount;
	}
	//moveToPage 로 데이터 요청
	if (v1 && v2) {
		me.proxy.param.PAGE = v2;
		me.div.paging.currentPage = v2;
		me.proxy.param.COUNT = v1;
		me.div.paging.rowCount = v1;
	}
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
				//AUIGrid.setSelectionByIndex(me.id, 0);
				if (data.count && me.proxy.paging) {
					me.div.paging.totalRowCount = data.count;
					me.createPagingNavigator(me.div.paging.currentPage);
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

/**
 * 
 * @param f
 * @returns {___anonymous7311_7312}
 */
function fn_serializeObject(f) {
	var o = {};
	var a = f.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

/**
 * 
 * @param arJson
 * @param rowItems
 * @param crud
 */
function fn_makeArr(arJson, rowItems, crud) {
	for (var i = 0; i < rowItems.length; i++) {
		rowItems[i].CRUD = crud;
		arJson.push(rowItems[i]);
	}
}

/**
 * 
 * @param grid
 * @param event
 */
function fn_deleteGridRow(grid, event) {
	if (event.dataField == "CRUD") {
		var isRemoved = AUIGrid.isRemovedById(grid.id, event.item[grid.gridPros.rowIdField]);
		if (isRemoved) {
			var item = {
				CRUD : ""
			};
			AUIGrid.restoreSoftRows(grid.id, event.rowIndex);
			AUIGrid.updateRow(grid.id, item, event.rowIndex, false);
		} else {
			var item = {
				CRUD : true
			};
			AUIGrid.updateRow(grid.id, item, event.rowIndex, false);
			AUIGrid.removeRow(grid.id, event.rowIndex);
		}
	}
}

/**
 * 
 * @param param
 * @returns {Array}
 */
function fn_makeSelectList(param) {
	var arr = new Array();
	$.ajax({
		url : param.URL,
		data : param,
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				$(data.result).each(function(index, entry) {
					var obj = new Object();
					obj.code = entry.CODE;
					obj.value = entry.VALUE;
					arr.push(obj);
				});
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
	return arr;
}

/**
 * 
 * @param param
 */
function fn_makeSelectbox(param) {
	var str = "";
	$.ajax({
		url : param.URL,
		data : param,
		async : false,
		success : function(data, textStatus, jqXHR) {
			if (data.success) {
				str += '<option value="">' + param.defaultLabel + '</option>';
				$(data.result).each(function(index, entry) {
					str += '<option value="' + entry.CODE + '">' + entry.VALUE + '</option>';
				});
				$("#" + param.location).html(str);
			} else {
				alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert(textStatus);
		}
	});
}

/**
 * 
 * @param c
 */
function fn_moveTab(c) {
	var url = url = './' + c + '.do';
	$("#frm_main").attr({
		action : url,
		method : 'post'
	}).submit();
}

/**
 * 
 * @param value
 * @returns {String}
 */
function fn_deleteCRUD(value) {
	if (value) {
		return "Cancel";
	}
	return "Delete";
}

/**
 * 
 * @param event
 * @returns
 */
function fn_checkGridNull(event) {
	if (event.oldValue == null) {
		if (event.value == "") {
			return null;
		}
	}
	return event.value;
}
/**
 * 
 * @param grid
 * @param dataField
 * @param codeList
 */
function fn_setCodeList(grid, dataField, codeList) {
	var object = grid.columnLayout;
	for ( var c in object) {
		if (object[c].dataField == dataField) {
			object[c].editRenderer.list = codeList;
			break;
		}
	}
}
/**
 * 
 * @param grid
 * @param dataField
 * @param value
 * @returns
 */
function fn_checkCodeList(grid, value) {
	var retStr = "";
	var list = grid.editRenderer.list;
	for (var i = 0; i < list.length; i++) {
		if (list[i]["code"] == value) {
			retStr = list[i]["value"];
			break;
		}
	}
	return retStr == "" ? value : retStr;
}

/**
 * 
 * @param url
 */
function fn_goList(url) {
	location.replace("./" + url + ".do");
}

/**
 * 중복값 체크 (true : 중복됨, false: 중복안됨)
 * 
 * @param arr
 * @returns {Boolean}
 */
function fn_checkOverlapByArr(arr) {
	var vTmp = arr;
	var flag = false;

	for (var i = 0; i < vTmp.length; i++) {
		for (var j = 0; j < vTmp.length; j++) {
			if (vTmp[i] == vTmp[j] && i != j) {
				flag = true;
				break;
			}
		}
	}

	return flag;
}

/**
 * 배열에 값이 있는지 체크 (0이상 : 있음, 0: 없음)
 * 
 * @param arr
 * @param vCompare
 * @returns {Number}
 */
function fn_hasValueByArr(arr, vCompare) {
	var cnt = 0;

	for (var i = 0; i < arr.length; i++) {
		if (vCompare == arr[i]) {
			cnt++;
		}
	}

	return cnt;
}

/**
 * 배열의 값이 그룹핑 되어 있는지 체크(true: 그룹핑되어있음, false: 그룹핑 안되어 있음)
 * 
 * @param arr
 * @returns {Boolean}
 */
function fn_checkGroupingByArr(arr) {
	var flag = true;
	var arrCompare = [];

	for (var i = 0; i < arr.length; i++) {
		for (var j = 0; j < arrCompare.length; j++) {
			if (arrCompare[j] == arr[i]) {
				flag = false;
				break;
			}
		}

		if (arr[i] != arr[i + 1]) {
			arrCompare.push(arr[i]);
		}
	}

	return flag;
}

function fn_deleteRow(grid) {
	var rowItem = AUIGrid.getSelectedItems(grid.id)[0].item;
	if (AUIGrid.isRemovedById(grid.id, rowItem[grid.gridPros.rowIdField])) {
		AUIGrid.restoreSoftRows(grid.id, "selectedIndex");
	} else {
		AUIGrid.removeRow(grid.id, "selectedIndex");
	}
}

function fn_createGuid() {
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
		return v.toString(16);
	});
}

function fn_CheckEng(value) {
	var check = /^[A-za-z]/g;
	return check.test(value);
}
function fn_CheckNum(value) {
	var check = /^[0-9]*$/;
	return check.test(value);
}

function fn_TextValidation(frm_id, tag_id) {
	if ($.trim($("#" + frm_id + " #" + tag_id).val()).length == 0) {
		return false;
	}
	return true;
}
function fn_TextByteValidation(frm_id, tag_id, text_byte) {
	var text = $("#" + frm_id + " #" + tag_id).val();
	if (fn_getByte(text) > text_byte) {
		$("#" + frm_id + " #" + tag_id).val();
		$("#" + frm_id + " #" + tag_id).val(text.substring(0, fn_getLengthForByte(text, text_byte)));
		return false;
	}
	return true;
}
function fn_RadioValidation(frm_id, tag_name) {
	if ($("#" + frm_id + " input[name=" + tag_name + "]:checked").length == 0) {
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////////////////////
//Function Name	: mkOnlyNumber
//Parameter Info	: check data, 예외 문자
//Return Info		: 숫자값
//Description		: value 값중 숫자 및 예외 처리할 문자만 리턴
///////////////////////////////////////////////////////////////////////////
function mkOnlyNumber(value, chars) {
	var varLength = value.length;

	var ReturnNumber = "";
	if (chars == null || chars == undefined)
		chars = "";
	var reg = "[^0-9" + chars + "]";

	ReturnNumber = value.replace(new RegExp(reg, "g"), "");

	return ReturnNumber;
}
// value의 바이트 값 리턴
function fn_getByte(value) {
	var string = "";

	string += value;

	var stringLength = string.length;
	var stringByteLength = 0;

	stringByteLength = (function(s, b, i, c) {
		for (b = i = 0; c = s.charCodeAt(i++); b += c >> 11 ? 3 : c >> 7 ? 2 : 1)
			;
		return b;
	})(string);

	return stringByteLength;
}

//value의 바이트 값 리턴
function fn_getLengthForByte(value, byte) {
	var string = "";

	string += value;

	var stringLength = string.length;
	var stringByteLength = 0;

	stringByteLength = (function(s, b, i, c) {
		for (b = i = 0; c = s.charCodeAt(i), b <= byte; i++, b += c >> 11 ? 3 : c >> 7 ? 2 : 1)
			;
		return i - 1;
	})(string);

	return stringByteLength;
}

function fn_setCRUD(grid) {
	var rowItems = AUIGrid.getAddedRowItems(grid.id);
	for (var i = 0; i < rowItems.length; i++) {
		rowItems[i].CRUD = "C";
		AUIGrid.updateRowsById(grid.id, rowItems[i]);
	}
	rowItems = AUIGrid.getEditedRowItems(grid.id);
	for (var i = 0; i < rowItems.length; i++) {
		rowItems[i].CRUD = "U";
		AUIGrid.updateRowsById(grid.id, rowItems[i]);
	}
	rowItems = AUIGrid.getRemovedItems(grid.id);
	for (var i = 0; i < rowItems.length; i++) {
		rowItems[i].CRUD = "D";
		AUIGrid.updateRowsById(grid.id, rowItems[i]);
	}

	var arJson = [];
	var rowItems = AUIGrid.getGridData(grid.id);
	for (var i = 0; i < rowItems.length; i++) {
		if (rowItems[i].CRUD) {
			arJson.push(rowItems[i]);
		}
	}
	return arJson;
}

function fn_replaceAll(str, target, replacement) {
	return str.split(target).join(replacement);
}

/**
 * 영문 소문자 + 숫자만 들어가도록 id 체크
 * 
 * @param value
 * @returns
 */
function fn_CheckUserId(value) {
	var check = /^[a-z0-9]{5,15}$/g;
	return check.test(value);
}

function fn_ukDatepicker(id) {
	$("#" + id).datepicker({
		showButtonPanel : true,
		beforeShow : function(input, inst) {
			setTimeout(function() {
				$(".ui-datepicker").css("z-index", 99999);

				var buttonPane = $(input).datepicker("widget").find(".ui-datepicker-buttonpane");
				buttonPane.empty();

				var today = new Date();
				var year = today.getFullYear();
				var month = today.getMonth() + 1;
				if (String(month).length == 1) {
					month = "0" + month;
				}
				$("<button>", {
					text : year + "-" + month + "-UK",
					click : function() {
						$("#" + inst.id).val(year + "-" + month + "-UK");
					}
				}).appendTo(buttonPane).addClass("ui-state-default uk_date");

				$("<button>", {
					text : year + "-UK-UK",
					click : function() {
						$("#" + inst.id).val(year + "-UK-UK");
					}
				}).appendTo(buttonPane).addClass("ui-state-default uk_date");

				$("<button>", {
					text : "UKUK-UK-UK",
					click : function() {
						$("#" + inst.id).val("UKUK-UK-UK");
					}
				}).appendTo(buttonPane).addClass("ui-state-default uk_date");
			}, 0);
		},
		onChangeMonthYear : function(year, month, inst) {
			setTimeout(function() {
				var buttonPane = $(inst.input).datepicker("widget").find(".ui-datepicker-buttonpane");
				buttonPane.empty();
				if (String(month).length == 1) {
					month = "0" + month;
				}
				$("<button>", {
					text : year + "-" + month + "-UK",
					click : function() {
						$("#" + inst.id).val(year + "-" + month + "-UK");
					}
				}).appendTo(buttonPane).addClass("ui-state-default uk_date");

				$("<button>", {
					text : year + "-UK-UK",
					click : function() {
						$("#" + inst.id).val(year + "-" + "-UK-UK");
					}
				}).appendTo(buttonPane).addClass("ui-state-default uk_date");

				$("<button>", {
					text : "UKUK-UK-UK",
					click : function() {
						$("#" + inst.id).val("UKUK-UK-UK");
					}
				}).appendTo(buttonPane).addClass("ui-state-default uk_date");
			}, 0);
		},
		onClose : function(dateText, inst) {
		}
	});
}