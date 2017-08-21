/**
 * WRITOR : 김상민, 이원민
 * DATE : 2016-02-15
 * VERSION : V1.0
 */
///////////////////////////////////////////////////////////////////////////
//	Function Name	: 
//	Parameter Info	: 
//	Return Info		: 
//	Description		: datepicker 설정 부분
///////////////////////////////////////////////////////////////////////////
$.datepicker._updateDatepicker_original = $.datepicker._updateDatepicker;
$.datepicker._updateDatepicker = function (inst) {
    $.datepicker._updateDatepicker_original(inst);
    var afterShow = this._get(inst, 'afterShow');
    if (afterShow)
        afterShow.apply((inst.input ? inst.input[0] : null));  // trigger custom callback
}
///////////////////////////////////////////////////////////////////////////
//	Function Name	: showMessage
//	Parameter Info	: b(message), a(options) 
//	Return Info		: 
//	Description		: 하단에 레이어를 생성하여 메시지를 보여줌
///////////////////////////////////////////////////////////////////////////
$.showMessage = function (b, a) {
	alert(b);
//    settings = jQuery.extend({
//        id: "sliding_message_box",
//        position: "bottom",
//        size: "90",
//        backgroundColor: "rgb(143, 177, 240)",
//        color: "black",
//        delay: 2000,
//        speed: 500,
//        fontSize: "30px"
//    }, a);
//
//    a = $("#" + settings.id);
//
//    if (a.length == 0) {
//        a = $("<div></div>").attr("id", settings.id);
//        a.css({
//            "z-index": "999",
//            "background-color": settings.backgroundColor,
//            "color": settings.color,
//            "text-align": "center",
//            position: "absolute",
//            position: "fixed",
//            left: "0",
//            width: "100%",
//            "line-height": settings.size + "px",
//            "font-size": settings.fontSize
//        });
//
//        $("body").append(a);
//    }
//
//    if (mkGetByteLength(b) > 133) {
//        b = b.substring(20);
//        a.css("font-size", "15px");
//        settings.delay = settings.delay * 3;
//    }
//    else if (mkGetByteLength(b) > 85) {
//        a.css("font-size", "18px");
//        settings.delay = settings.delay * 3;
//    }
//
//    a.html(b);
//
//    if (settings.position == "bottom") {
//        a.css("bottom", "-" + settings.size + "px");
//        a.animate({ bottom: "0" }, settings.speed);
//        b = '$("#' + settings.id + '").animate({bottom:"-' + settings.size + 'px"}, ' + settings.speed + ");";
//        setTimeout(b, settings.delay);
//    }
//    else if (settings.position == "top") {
//        a.css("top", "-" + settings.size + "px");
//        a.animate({ top: "0" }, settings.speed);
//        b = '$("#' + settings.id + '").animate({top:"-' + settings.size + 'px"}, ' + settings.speed + ");";
//        setTimeout(b, settings.delay);
//    }
};


///////////////////////////////////////////////////////////////////////////
//	Function Name	: focusEnd
//	Parameter Info	: 
//	Return Info		: 객체
//	Description		: 텍스트박스나 텍스트필드 데이타 끝에 커서키 위치시키기
///////////////////////////////////////////////////////////////////////////
$.fn.mkFocusEnd = function () {
    this.setCursorPosition(this.val().length);
};

$.fn.setCursorPosition = function (position) {
    if (this.lengh == 0) return this;
    return this.setSelection(position, position);
};

$.fn.setSelection = function (selectionStart, selectionEnd) {
    if (this.lengh == 0) return this;
    input = this[0];

    if (input.createTextRange) {
        var range = input.createTextRange();
        range.collapse(true);
        range.moveEnd('character', selectionEnd);
        range.moveStart('character', selectionStart);
        range.select();
    } else if (input.setSelectionRange) {
        input.focus();
        selectionStart = adjustOffset(input, selectionStart);
        selectionEnd = adjustOffset(input, selectionEnd);
        input.setSelectionRange(selectionStart, selectionEnd);
    }

    return this;
};


///////////////////////////////////////////////////////////////////////////
//	Function Name	: reduce
//	Parameter Info	: num: 허용할 글자수
//	Return Info		: 객체
//	Description		: 말줄임 표시 적용
///////////////////////////////////////////////////////////////////////////
$.fn.mkReduce = function (num) {
    var value = "";
    if (this.val().length > num) value = this.val().substring(0, num) + "...";
    else value = this.val();

    this.val(value);

    return this;
};


///////////////////////////////////////////////////////////////////////////
// Function Name	: positionCenter
// Parameter Info	: 
// Return Info		: 객체
// Description		: 화면 중앙에 위치잡기 (absolute)
///////////////////////////////////////////////////////////////////////////
$.fn.positionCenter = function () {
    var posTop = ($(window).height() - this.height()) / 2 + $(window).scrollTop();
    var posLeft = ($(window).width() - this.width()) / 2 + $(window).scrollLeft();
    this.css({position: "absolute", top: posTop, left: posLeft});

    return this;
};


///////////////////////////////////////////////////////////////////////////
//	Function Name	: indicator
//	Parameter Info	: true or false: 설정여부
//	Return Info		: 
//	Description		: 인티케이터 설정
///////////////////////////////////////////////////////////////////////////
function indicator(bFlg) {
	window.setTimeout(function(){
		if (bFlg) {
	        if ($('#ajax_load_indicator').css("display") == "none") {
	            $('#ajax_load_indicator').positionCenter().show().fadeIn('fast');
	        }
	    } else { 
	    	$('#ajax_load_indicator').fadeOut();
	    }
	}, 0.1);
};


///////////////////////////////////////////////////////////////////////////
//	Function Name	: POSTSend
//	Parameter Info	: url: 이동할 경로, id: 전송값 아이디, val: 전송값
//	Return Info		: 
//	Description		: 자바스크립트를 이용해서 포스트 방식으로 다른페이지로 값 전달
///////////////////////////////////////////////////////////////////////////
function POSTSend(url, id, val) {
    $("<form id='form2'><input type='hidden' name='mtype' id='" + id + "'></input></form>")
                .attr("action", url).attr("method", "post")
                .find("input").val(val).end().appendTo('body');

    var form2 = document.getElementById("form2");
    form2.submit();
};


///////////////////////////////////////////////////////////////////////////
//	Function Name	: POSTSends
//	Parameter Info	: url: 이동할 경로, ids: 전송값 아이디(배열), vals: 전송값(배열)
//	Return Info		: 
//	Description		: 닷넷의 문제인 다른페이지 폼 전송(전송할 아이디와 값이 여러개인경우)
///////////////////////////////////////////////////////////////////////////
function POSTSends(url, ids, vals) {
    var $form = $("<form id='form2'></form>");

    for (var i = 0; i < ids.length; i++) {
        var $hd = $("<input type='hidden' name='" + ids[i] + "' id='" + ids[i] + "'></input>");
        $hd.val(vals[i]);
        $form.append($hd);
    }

    $form.attr("action", url).attr("method", "post").appendTo('body');

    var form2 = document.getElementById("form2");
    form2.submit();
};


///////////////////////////////////////////////////////////////////////////
// Function Name	: isNull
// Parameter Info	: 
// Return Info		: true or false
// Description		: Null 체크
///////////////////////////////////////////////////////////////////////////
$.fn.mkIsNull = function () {
    if (this == null || this == undefined || $.trim(this.val()) == "") return true;
    else return false;
};

///////////////////////////////////////////////////////////////////////////
// Function Name	: number, unNumber
// Parameter Info	: event
// Return Info		: 객체
// Description		: 숫자만 허용
///////////////////////////////////////////////////////////////////////////
$.fn.mkNumber = function () {
    this.bind("keydown", function (event) {
        if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 ||
            (event.keyCode == 65 && event.ctrlKey === true) ||
            (event.shiftKey === false && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105))) ||
            (event.keyCode >= 35 && event.keyCode <= 39)) {
            return;
        }
        else {
            if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105) || event.shiftKey === true) {
                event.preventDefault();
            }
        }
    });

    return this;
};

$.fn.mkUnNumber = function () {
    this.unbind("keydown");
    return this;
};


///////////////////////////////////////////////////////////////////////////
// Function Name	: numberDot, unNumberDot
// Parameter Info	: event
// Return Info		: 객체
// Description		: 숫자와 . 허용 and 해제
///////////////////////////////////////////////////////////////////////////
$.fn.mkNumberDot = function () {
    this.bind("keydown", function (e) {
        if ((e.keyCode == 46 || e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 27 ||
            (e.keyCode == 65 && e.ctrlKey === true) ||
            (e.shiftKey === false && ((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105))) ||
            (e.keyCode >= 35 && e.keyCode <= 39) ||
            ((e.keyCode == 190 || e.keyCode == 110) && $(this).val().indexOf('.') == -1))) {
            return;
        }
        else {
            if ((e.keyCode < 48 || e.keyCode > 57) && (e.keyCode < 96 || e.keyCode > 105) || e.shiftKey === true) {
                (e.preventDefault) ? e.preventDefault() : e.returnValue = false;
            }
        }
    });

    return this;
};

$.fn.mkUnNumberDot = function () {
    this.unbind("keydown");

    return this;
};


///////////////////////////////////////////////////////////////////////////
// Function Name	: numberHyphen, unNumberHyphen
// Parameter Info	: event
// Return Info		: 
// Description		: 숫자와 '-' 허용
///////////////////////////////////////////////////////////////////////////
$.fn.mkNumberHyphen = function () {
    this.bind("keydown", function (event) {
        if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 ||
            (event.keyCode == 65 && event.ctrlKey === true) ||
            (event.keyCode >= 35 && event.keyCode <= 39) ||
            (event.shiftKey === false && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105))) ||
            (event.keyCode == 189 || event.keyCode == 109)) {
            return;
        }
        else {
            if ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105) || event.shiftKey === true) {
                event.preventDefault();
            }
        }
    });
};

$.fn.mkUnNumberHyphen = function () {
    this.unbind("keydown");
};


///////////////////////////////////////////////////////////////////////////
// Function Name	: Money
// Parameter Info	: 
// Return Info		: 
// Description		: 돈표시
///////////////////////////////////////////////////////////////////////////
$.fn.mkMoney = function (type) {
    if (type == "1" || type == undefined) {
        this.mkNumberDot();
    } else {
        this.mkNumber();
    }

    this.bind("keyup", function (event) {
        $(this).val(mkRegularNumberFormat($(this).val().replace(/,/g, "") + ""));
    }).bind("focusin", function (event) {
        $(this).val(mkRegularNumberFormat($(this).val().replace(/,/g, "") + ""));
    });

    $(this).val(mkRegularNumberFormat($(this).val()));

    return this;
};

$.fn.mkUnMoney = function () {
    this.mkUnNumberDot().unbind("keyup");
    $(this).val($(this).val().replace(/,/g, ""));

    return this;
};

///////////////////////////////////////////////////////////////////////////
// Function Name	: ajaxSetup
// Parameter Info	: 
// Return Info		: 
// Description		: 기본 Ajax 설정사항
///////////////////////////////////////////////////////////////////////////
//$.ajaxSetup({
//    async: false,
//    cache: false,
//    type: "post",
//    dataType: "json",
//    beforeSend: function (xhr) {
//        xhr.setRequestHeader("X-Ajax-call", "true");
//        
//        var flag = 'false';
//        $.ajax({
//			type		: "POST",
//			dataType	: "json",
//			beforeSend	: function (xhr) {
//		        xhr.setRequestHeader("X-Ajax-call", "true");
//		    }
//		});
//        if(flag == 'true'){
//        	
//        	return false;
//        }
//    },
//    error: function (req, error) {
////        if (error === 'error') { error = req.statusText; }
////
////        var options = {
////            id: "show_message_error",
////            backgroundColor: "red",
////            color: "white"
////        }
////        $.showMessage(error, options);
//    },
//    complete: function () {
//        //indicator(false);
//    }
//});

///////////////////////////////////////////////////////////////////////////
// Function Name	: mkSetDatePickerYYMM
// Parameter Info	: id = fromDate, ids = toDate
// Return Info		: 
// Description		: 달만표시 달력, id, ids 둘다 들어오면 값비교. 하나만 들어오면 값비교 없음.
// Sample           : mkSetDatePickerYYMM("#txtfromdate") or mkSetDatePickerYYMM("#txtfromdate", "#txttodate") 
///////////////////////////////////////////////////////////////////////////
function mkSetDatePickerYYMM(id, ids) {
    var tt;
    $(id + ", " + ids).datepicker({
        showButtonPanel: true,
        currentText: "당월",
        beforeShow: function (inst) {
            tt = $(this).val();
            $("#" + inst.id).val(tt + "-01");
        },
        onChangeMonthYear: function (year, month, inst) {
            tt = $.datepicker.formatDate('yy-mm', new Date(year, month - 1, 1));
            $('#' + inst.id).val(tt + '-01');
        },
        afterShow: function (inst) {
            $('.ui-datepicker-calendar').find("tr").hide();
            $(this).val(tt);
        },
        onClose: function () {
            if (ids != undefined) {
                var idDate = $(id).val().length > 7 ? $(id).val() : $(id).val() + "-01";
                var idsDate = $(ids).val().length > 7 ? $(ids).val() : $(ids).val() + "-01";
                if (idDate > idsDate) {
                    mkMessageFunc("조회일자는 시작날짜가 종료날짜보다 이전이어야 합니다.", 1);
                    $(id + ", " + ids).val($.datepicker.formatDate('yy-mm', new Date()));
                    $(this).val($.datepicker.formatDate('yy-mm', new Date()));
                }
            }
            else if (!isValidDate($(this).val()) && !isValidDate($(this).val() + '-01')) {
                mkMessageFunc("유효한 날짜가 아닙니다.", 1);
                $(this).val(tt);
                $(this).focus();
            }
        }
    }).val($.datepicker.formatDate("yy-mm", new Date()));
}

$.datepicker.regional['ko'] = {
    changeMonth: true,
    changeYear: true,
    closeText: '닫기',
    prevText: '이전',
    nextText: '다음',
    currentText: '오늘',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    weekHeader: 'Wk',
    dateFormat: 'yy-mm-dd',
    firstDay: 0,
    isRTL: false,
    showMonthAfterYear: true,
    yearSuffix: '',
    buttonImageOnly: true,
    yearRange: 'c-5:c+5' // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
};
$.datepicker.setDefaults($.datepicker.regional['ko']);

/////////////////////////////////////////////////////////////////////////////
//// Function Name	: mkSetDatePickerYYMMDD
//// Parameter Info	: id = fromDate, ids = toDate
//// Return Info		: 
//// Description		: 일자까지표시 달력, id, ids 둘다 들어오면 값비교. 하나만 들어오면 값비교 없음.
//// Sample           : mkSetDatePickerYYMMDD("#txtfromdate") or mkSetDatePickerYYMMDD("#txtfromdate", "#txttodate") 
/////////////////////////////////////////////////////////////////////////////
function mkSetDatePickerYYMMDD(id, ids) {
    var tt;
    $(id + ", " + ids).datepicker({
        beforeShow: function (inst) {
            tt = $(this).val();
        },
        onClose: function (dateText, inst) {
            //alert($(id).val() + "," + $(ids).val() + ", " + ids);
            if (ids != undefined && $(id).val() > $(ids).val()) {
                mkMessageFunc("조회일자는 시작날짜가 종료날짜보다 이전이어야 합니다.", 1);
                $(id + ", " + ids).val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
            }
            else if (!isValidDate($(this).val())) {
                mkMessageFunc("유효한 날짜가 아닙니다.", 1);
                $(this).val(tt);
                $(this).focus();
            }
        }
    }).val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
}

/////////////////////////////////////////////////////////////////////////////
//// Function Name	: mkSetDatePickerYY
//// Parameter Info	: id = fromDate, ids = toDate
//// Return Info		: 
//// Description		: 년도만표시 달력, id, ids 둘다 들어오면 값비교. 하나만 들어오면 값비교 없음.
//// Sample           : mkSetDatePickerYY("#txtfromdate") or mkSetDatePickerYY("#txtfromdate", "#txttodate") 
/////////////////////////////////////////////////////////////////////////////
function mkSetDatePickerYY(id, ids) {
    var tt;
    $(id + ", " + ids).datepicker({
        changeMonth: false,
        yearSuffix: ' 년',
        currentText: "당해",
        showButtonPanel: true,
        monthNames: ["", "", "", "", "", "", "", "", "", "", "", ""],
        beforeShow: function (inst) {
            tt = $(this).val();
            $("#" + inst.id).val(tt + "-06-01");
        },
        onChangeMonthYear: function (year, month, inst) {
            tt = $.datepicker.formatDate('yy', new Date(year, 1, 1));
            $('#' + inst.id).val(tt + "-06-01");
            $.datepicker._hideDatepicker();
        },
        afterShow: function (inst) {
            $('.ui-datepicker-calendar').find("tr").hide();
            $(this).val(tt);
        },
        onClose: function () {
            if (ids != undefined && $(id).val() > $(ids).val()) {
                mkMessageFunc("조회일자는 시작날짜가 종료날짜보다 이전이어야 합니다.", 1);
                $(id + ", " + ids).val($.datepicker.formatDate('yy', new Date(year, 1, 1)));
            }
            else if (!isValidDate($(this).val()) && !isValidDate($(this).val() + "-06-01")) {
                mkMessageFunc("유효한 년도가 아닙니다.", 1);
                $(this).val(tt);
                $(this).focus();
            }
        }
    }).val($.datepicker.formatDate("yy", new Date()));
}


///////////////////////////////////////////////////////////////////////////
//	Function Name	: SearchParameterUrl
//	Parameter Info	: return page name
//	Return Info		: Search Parameter Url String
//	Description		: 검색 조건을 Url 형태로 만듬.
///////////////////////////////////////////////////////////////////////////
function SearchParameterMakeUrl(pageName, rowIndex) {
    var returnValue = "returnPage=" + pageName;
    $("[SearchCondition=Y]").each(function (idx, obj) {
        returnValue += "&search_" + $(obj).attr("id") + "=" + $(obj).val();
    });

    return returnValue + "&search_idx=" + rowIndex;
}


///////////////////////////////////////////////////////////////////////////
//	Function Name	: SearachParameterSetObject
//	Parameter Info	: 
//	Return Info		: 
//	Description		: 검색 파라메터 Url 형태의 값을 해당 객체에 넣기.
///////////////////////////////////////////////////////////////////////////
function SearachParameterSetObject() {
    var searchCondition = mkGetParamValueAll();
    var strParams = searchCondition.split('&');
    for (var i = 0; i < strParams.length; i++) {
        if (strParams[i].indexOf('=') > 0) {
            var strQuery = strParams[i].split('=');
            $("#" + strQuery[0].substring(7, strQuery[0].length)).val(strQuery[1]);
        }
    }
}

///////////////////////////////////////////////////////////////////////////
//	Function Name	: mkAutoComplate
//	Parameter Info	: gbn: 구분값('PART', 'USER' 등등..), id: 값 저장할 객체id
//	Return Info		: 
//	Description		: 자동완성 기능
///////////////////////////////////////////////////////////////////////////
$.fn.mkAutoComplate = function (gbn, id) {
    var part_result;

    params = {
        procNm: "USP_COM_AUTOCOMPLATE",
        gbn: gbn
    };

    $.ajax({
        url: setupUrl + "/Ajax/Union.aspx",
        data: params,
        success: function (data) {
            part_result = data.RESULT;
        }
    });

    this.autocomplete({
        minLength: 1,
        source: $.map(part_result, function (item) {
            return {
                label: item.NM + "[" + item.NM_PART + "]",
                id: item.CD,
                value: item.NM,
                tel: item.NO_TEL,
                hp: item.NO_HP
            };
        }),
        select: function (event, ui) {
            $('#' + id).val(ui.item.value).attr("cd", ui.item.id);
            $('#' + id + '_id').val(ui.item.id);
            $('#' + id + '_tel').text(ui.item.tel);
            $('#' + id + '_hp').text(ui.item.hp);
        },
        selectFirst: true
    });

    this.bind("blur", function () {
        if ($(this).mkIsNull() || $(this).val().length < 2 || $(this).attr("cd") == "") {
            $("#" + id).val("").attr("cd", "");
            $('#' + id + '_id').val("");
            $('#' + id + '_tel').text("");
            $('#' + id + '_hp').text("");
            $(this).val("");
        }
    });

    return this;
};

///////////////////////////////////////////////////////////////////////////
// Function Name	: mkTel
// Parameter Info	: 
// Return Info		: 
// Description		: 전화번호 체크
///////////////////////////////////////////////////////////////////////////
var regExpTel = /^0(?:\d{1}|\d{2})(\-|)(?:\d{3}|\d{4})(\-|)\d{4}$/;
var regExpTelS = /^0(?:[2])(\-|)(?:\d{3}|\d{4})(\-|)\d{4}$/;

$.fn.mkTel = function (value) {
    if (value != "" && value != undefined) {
        if (value.length == 9) $(this).inputmask("99-999-9999").val(value);
        else if (value.length == 10) {
            if (regExpTelS.test(value)) $(this).inputmask("99-9999-9999").val(value);
            else $(this).inputmask("999-999-9999").val(value);
        }
        else if (value.length == 11) $(this).inputmask("999-9999-9999").val(value);
        else {
            mkMessageFunc("유효하지 않은 전화번호 형식입니다.", 1);
            $(this).val(value);
        }
    }
    else {
        $(this).inputmask("999-9999-9999");
    }

    this.bind("focusin", function () {
        $(this).inputmask("999-9999-9999");
    });

    this.bind("focusout", function () {
        var num = mkOnlyNumber($(this).val());
        if (num == "") return;

        if (!regExpTel.test(num)) {
            mkMessageFunc("유효하지 않은 전화번호 형식입니다.", 1);
            $(this).val("");
            return;
        }

        if (num.length == 9) $(this).inputmask("99-999-9999");
        else if (num.length == 10) {
            if (regExpTelS.test(num)) $(this).inputmask("99-9999-9999");
            else $(this).inputmask("999-999-9999");
        }
        else if (num.length == 11) $(this).inputmask("999-9999-9999");
        else {
            mkMessageFunc("유효하지 않은 전화번호 형식입니다.", 1);
            $(this).val("");
        }
    });

    return this;
};
///////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////
// Function Name	: mkTime
// Parameter Info	: 
// Return Info		: 
// Description		: 시간 체크 (아이디 두개)
///////////////////////////////////////////////////////////////////////////
function mkTime(id, ids) {
    $(id + ", " + ids).inputmask("99:99");

    $(id + ", " + ids).bind("focusout", function () {
        if ($(this).val() == "") return;

        if ($(this).val().replace(/_/g, '').replace(/:/g, '').length != 4) {
            mkMessageFunc("유효하지 않은 시간입니다.", 1);
            $(this).val("");
            return;
        }

        var hh;
        var mm;

        if ($(this).val().indexOf(":") == -1) {
            hh = $(this).val().replace(/_/g, '').substring(0, 1);
            mm = $(this).val().replace(/_/g, '').substring(2, 3);
        }
        else {
            hh = $(this).val().replace(/_/g, '').split(':')[0];
            mm = $(this).val().replace(/_/g, '').split(':')[1];
        }

        if (Number(hh) > 24) {
            mkMessageFunc("유효하지 않은 시간입니다.", 1);
            $(this).val("");
            return;
        }
        else if (Number(mm) > 59 || (Number(hh) == 24 && Number(mm) > 0)) {
            mkMessageFunc("유효하지 않은 시간입니다.", 1);
            $(this).val("");
            return;
        }
        else if (ids != undefined && $(id).val() > $(ids).val() && $(ids).val() != "") {
            mkMessageFunc("시작시간이 종료시간보다 큽니다.", 1);
            $(id + ", " + ids).val("");
            return;
        }
    });
}

///////////////////////////////////////////////////////////////////////////
// Function Name	: isDateFormat
// Parameter Info	: 
// Return Info		: 
// Description		: 날짜 데이터 포맷 체크
///////////////////////////////////////////////////////////////////////////
function isDateFormat(d) {
    var regExpDate = /^20(\d{2})(\-|)(\d{2})(\-|)\d{2}$/;
    //var regExpTelS = /^0(?:[2])(\-|)(?:\d{3}|\d{4})(\-|)\d{4}$/;
    var df = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
    //return d.match(df);
    return regExpDate.test(d);
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: isLeaf
// Parameter Info	: 
// Return Info		: 
// Description		: 윤년여부 검사
///////////////////////////////////////////////////////////////////////////
function isLeaf(year) {
    var leaf = false;

    if (year % 4 == 0) {
        leaf = true;

        if (year % 100 == 0) {
            leaf = false;
        }

        if (year % 400 == 0) {
            leaf = true;
        }
    }

    return leaf;
}

///////////////////////////////////////////////////////////////////////////
// Function Name	: isValidDate
// Parameter Info	: 
// Return Info		: 
// Description		: 날짜가 유효한지 검사
///////////////////////////////////////////////////////////////////////////
function isValidDate(d) {
    // 포맷에 안맞으면 false리턴
    if (!isDateFormat(d)) {
        return false;
    }

    var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    var dateToken = d.split('-');
    var year = Number(dateToken[0]);
    var month = Number(dateToken[1]);
    var day = Number(dateToken[2]);

    // 날짜가 0이면 false
    if (day == 0) {
        return false;
    }

    var isValid = false;

    // 윤년일때
    if (isLeaf(year)) {
        if (month == 2) {
            if (day <= month_day[month - 1] + 1) {
                isValid = true;
            }
        } else {
            if (day <= month_day[month - 1]) {
                isValid = true;
            }
        }
    } else {
        if (day <= month_day[month - 1]) {
            isValid = true;
        }
    }

    return isValid;
}

///////////////////////////////////////////////////////////////////////////
// Function Name	: mkValidation
// Parameter Info	: 
// Return Info		: true or false
// Description		: 유효성 체크
///////////////////////////////////////////////////////////////////////////
function mkValidation() {
    var isValidate = true;
    $("[valireqire]").each(function (idx, obj) {
        if (($(obj).val() || "") == "") {
            mkMessageFunc($(obj).attr("valireqire") + "을(를) 입력하세요.", 1);
            $(obj).focus();
            isValidate = false;
            return false;
        }
    });
    
    if(!isValidate) return false;
    
    $("[validate]").each(function (idx, obj) {
        if (!isValidDate($(obj).val())) {
            mkMessageFunc($(obj).attr("validate") + "을(를) 정확히 입력하세요.", 1);
            $(obj).focus();
            isValidate = false;
            return false;
        }
    });

    if(!isValidate) return false;
    
    $("[valimobile]").each(function (idx, obj) {
        if (!_VF.isMobile($(obj).val(), "-")) {
            mkMessageFunc($(obj).attr("valimobile") + "을(를) 정확히 입력하세요.", 1);
            $(obj).focus();
            isValidate = false;
            return false;
        }
    });

    if(!isValidate) return false;
    
    $("[valiemail]").each(function (idx, obj) {
        if (!_VF.isEmail($(obj).val())) {
            mkMessageFunc($(obj).attr("valiemail") + "을(를) 정확히 입력하세요.", 1);
            $(obj).focus();
            isValidate = false;
            return false;
        }
    });

    if(!isValidate) return false;
    
    $("[valicorpnum]").each(function (idx, obj) {
        if (!_VF.isCorpNum($(obj).val(), '-')) {
            mkMessageFunc($(obj).attr("valicorpnum") + "을(를) 정확히 입력하세요.", 1);
            $(obj).focus();
            isValidate = false;
            return false;
        }
    });

    if(!isValidate) return false;
    
    $("[valibiznum]").each(function (idx, obj) {
        if (!_VF.isBiznum($(obj).val(), "-")) {
            mkMessageFunc($(obj).attr("valibiznum") + "을(를) 정확히 입력하세요.", 1);
            $(obj).focus();
            isValidate = false;
            return false;
        }
    });

    if(!isValidate) return false;
    
    $("[valinum]").each(function (idx, obj) {
        if (!_VF.isOnlyNumber($(obj).val())) {
            mkMessageFunc($(obj).attr("valinum") + "을(를) 정확히 입력하세요.", 1);
            $(obj).focus();
            isValidate = false;
            return false;
        }
    });

    return isValidate;
}

var _VF = new function ValidateFormat() 
{
	var instance = this;
	

	// instance 리턴

	ValidateFormat.getInstance = function()
	{
		return instance;
	}
	
	
	
    //	핸드폰번호 체크 - arguments[0] : 핸드폰 구분자   	.

	ValidateFormat.isMobile = function(s, arg)
	{	
		return eval("(/01[016789]" + arg + "[1-9]{1}[0-9]{2,3}" + arg + "[0-9]{4}$/).test(s)");
	}



	//	이메일의 유효성을 체크

	ValidateFormat.isEmail = function(s)
	{			
		return (/\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/).test( s );
	}


	
	//	법인 등록번호 체크 - arguments[0] : 등록번호 구분자	
	//	XXXXXX-XXXXXXX

	ValidateFormat.isCorpNum = function(s, arg)
	{	
		var corpnum = eval("s.match(/[0-9]{6}" + arg + "[0-9]{7}$/)");

		if(corpnum == null) 		
			return false;         
		else 
			corpnum = corpnum.toString().num().toString();        


        var sum = 0;

        var num = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2]

        var last = parseInt(corpnum.charAt(12));

        for(var i = 0; i < 12; i++) {

             sum += parseInt(corpnum.charAt(i)) * num[i];
        }

        return ((10 - sum % 10) % 10 == last) ? true : false;

	}


	


	//	사업자번호 등록번호 체크 - arguments[0] : 등록번호 구분자	
	//	XX-XXX-XXXXX

	ValidateFormat.isBiznum = function(s, arg)
	{	

		var biznum = eval("s.match(/[0-9]{3}" + arg + "[0-9]{2}" + arg + "[0-9]{5}$/)");

		if(biznum == null)
			return false;
		else 
			biznum = biznum.toString().num().toString();


		var sum = parseInt(biznum.charAt(0));

		var num = [0, 3, 7, 1, 3, 7, 1, 3];

		for(var i = 1; i < 8; i++) sum += (parseInt(biznum.charAt(i)) * num[i]) % 10;

		sum += Math.floor(parseInt(parseInt(biznum.charAt(8))) * 5 / 10);

		sum += (parseInt(biznum.charAt(8)) * 5) % 10 + parseInt(biznum.charAt(9));

		return (sum % 10 == 0) ? true : false;

	}




	// 외국인 등록번호 체크 - arguments[0] : 등록번호 구분자
	// XXXXXX-XXXXXXX

	ValidateFormat.isForeign = function(s, arg)
	{
		
		var jumin = eval("s.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[5678]{1}[0-9]{1}[02468]{1}[0-9]{2}[6789]{1}[0-9]{1}$/)");

		if(jumin == null)
			return false;
		else
			jumin = jumin.toString().num().toString();

		

		// 생년월일 체크

		var birthYY = (parseInt(jumin.charAt(6)) == (5 || 6)) ? "19" : "20";

		birthYY += jumin.substr(0, 2);

		var birthMM = jumin.substr(2, 2) - 1;

		var birthDD = jumin.substr(4, 2);

		var birthDay = new Date(birthYY, birthMM, birthDD);

		if(birthDay.getYear() % 100 != jumin.substr(0,2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {

			return false;

		}

		if((parseInt(jumin.charAt(7)) * 10 + parseInt(jumin.charAt(8))) % 2 != 0) {

			return false;

		}

		var sum = 0;

		var num = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5]

		var last = parseInt(jumin.charAt(12));

		for(var i = 0; i < 12; i++) {

			sum += parseInt(jumin.charAt(i)) * num[i];

		}

		return (((11 - sum % 11) % 10) + 2 == last) ? true : false;

	}




	// 주민번호 체크 - arguments[0] : 주민번호 구분자
	// XXXXXX-XXXXXXX

	ValidateFormat.isJuminNo = function(s, arg)
	{ 

		var jumin = eval("s.match(/[0-9]{2}[01]{1}[0-9]{1}[0123]{1}[0-9]{1}" + arg + "[1234]{1}[0-9]{6}$/)");
		
		if(jumin == null) 
			return false;
		else
			jumin = jumin.toString().num().toString();

		

		// 생년월일 체크

		var birthYY = (parseInt(jumin.charAt(6)) == (1 ||2)) ? "19" : "20";

		birthYY += jumin.substr(0, 2);

		var birthMM = jumin.substr(2, 2) - 1;

		var birthDD = jumin.substr(4, 2);

		var birthDay = new Date(birthYY, birthMM, birthDD);

		if(birthDay.getYear() % 100 != jumin.substr(0,2) || birthDay.getMonth() != birthMM || birthDay.getDate() != birthDD) {

			return false;

		}       

		var sum = 0;

		var num = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5]

		var last = parseInt(jumin.charAt(12));

		for(var i = 0; i < 12; i++) {

			sum += parseInt(jumin.charAt(i)) * num[i];

		}

		return ((11 - sum % 11) % 10 == last) ? true : false;
	}
	
	


	// 아이디 체크 영어와 숫자만 체크 첫글자는 영어로 시작 - arguments[0] : 추가 허용할 문자들
    // @return : boolean

	ValidateFormat.isUserid = function(s, arg) {
		
		return (/^[a-zA-z]{1}[0-9a-zA-Z]+$/).test( ValidateFormat.remove(s, arg) ) ? true : false;

	}

	// 영어와 숫자만 체크 - arguments[0] : 추가 허용할 문자들
    // @return : boolean

	ValidateFormat.isNumber = function(s, arg) {
		
		return (/^[0-9a-zA-Z]+$/).test( ValidateFormat.remove(s, arg) ) ? true : false;

	}
	ValidateFormat.isOnlyNumber = function(s, arg) {	

		return (/^[0-9.]+$/).test( ValidateFormat.remove(s, arg) ) ? true : false;

	}



	// private member - 정규식 이스케이프
	ValidateFormat.meta = function(str) {
		
		var result = ""

		for(var i = 0; i < str.length; i++)
		{
			if((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/).test(str.charAt(i))) 
				result += str.charAt(i).replace((/([\$\(\)\*\+\.\[\]\?\\\^\{\}\|]{1})/), "\\$1");
			else
				result += str.charAt(i);
		}

		return result;
	}



	// private member - 정규식 특정문자열 제거
	ValidateFormat.remove = function(str, pattern) {
		return (pattern == null) ? str : eval("str.replace(/[" + ValidateFormat.meta(pattern) + "]/g, \"\")");
	}



	return ValidateFormat;
}


///////////////////////////////////////////////////////////////////////////
//Function Name		: indexOf
//Parameter Info	: 
//Return Info		: 
//Description		: ie8에서 indexOf 찾지 못해 생기는 에러 처리
///////////////////////////////////////////////////////////////////////////
// Production steps of ECMA-262, Edition 5, 15.4.4.14
// Reference: http://es5.github.io/#x15.4.4.14
if (!Array.prototype.indexOf) {
  Array.prototype.indexOf = function(searchElement, fromIndex) {

    var k;

    // 1. Let O be the result of calling ToObject passing
    //    the this value as the argument.
    if (this == null) {
      throw new TypeError('"this" is null or not defined');
    }

    var O = Object(this);

    // 2. Let lenValue be the result of calling the Get
    //    internal method of O with the argument "length".
    // 3. Let len be ToUint32(lenValue).
    var len = O.length >>> 0;

    // 4. If len is 0, return -1.
    if (len === 0) {
      return -1;
    }

    // 5. If argument fromIndex was passed let n be
    //    ToInteger(fromIndex); else let n be 0.
    var n = +fromIndex || 0;

    if (Math.abs(n) === Infinity) {
      n = 0;
    }

    // 6. If n >= len, return -1.
    if (n >= len) {
      return -1;
    }

    // 7. If n >= 0, then Let k be n.
    // 8. Else, n<0, Let k be len - abs(n).
    //    If k is less than 0, then let k be 0.
    k = Math.max(n >= 0 ? n : len - Math.abs(n), 0);

    // 9. Repeat, while k < len
    while (k < len) {
      // a. Let Pk be ToString(k).
      //   This is implicit for LHS operands of the in operator
      // b. Let kPresent be the result of calling the
      //    HasProperty internal method of O with argument Pk.
      //   This step can be combined with c
      // c. If kPresent is true, then
      //    i.  Let elementK be the result of calling the Get
      //        internal method of O with the argument ToString(k).
      //   ii.  Let same be the result of applying the
      //        Strict Equality Comparison Algorithm to
      //        searchElement and elementK.
      //  iii.  If same is true, return k.
      if (k in O && O[k] === searchElement) {
        return k;
      }
      k++;
    }
    return -1;
  };
}