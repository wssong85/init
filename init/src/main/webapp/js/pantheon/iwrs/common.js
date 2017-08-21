/**
 * WRITOR : 김상민, 이원민
 * DATE : 2016-02-15
 * VERSION : V1.0
 */
///////////////////////////////////////////////////////////////////////////
// Function Name	: mkCheckNumber
// Parameter Info	: check data
// Return Info		: true or false
// Description		: value 값이 숫자인지 체크, 소수점(.)은 숫자로 취급안함
///////////////////////////////////////////////////////////////////////////
function mkCheckNumber(value) {
    var chkstr = value + "";
    var isNum = true;

    if (value == null || value == undefined || value == "") return false;

    for (j = 0; isNum && (j < value.length); j++) {
        if ((value.substring(j, j + 1) < "0") || (value.substring(j, j + 1) > "9")) {
            if (value.substring(j, j + 1) == "-" || value.substring(j, j + 1) == "+") {
                if (j != 0) {
                    isNum = false;
                }
            }
            else
                isNum = false;
        }
    }

    if (chkstr == "+" || chkstr == "-") isNum = false;

    return isNum;
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: mkOnlyNumber
// Parameter Info	: check data, 예외 문자
// Return Info		: 숫자값
// Description		: value 값중 숫자 및 예외 처리할 문자만 리턴
///////////////////////////////////////////////////////////////////////////
function mkOnlyNumber(value, chars) {
    var varLength = value.length;

    var ReturnNumber = "";
    if (chars == null || chars == undefined) chars = "";
    var reg = "[^0-9" + chars + "]";

    ReturnNumber = value.replace(new RegExp(reg, "g"), "");

    return ReturnNumber;
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: mkRegularNumberFormat
// Parameter Info	: 요청값 
// Return Info		: 결과값
// Description		: 요청값을 돈표시 형태로 치환
///////////////////////////////////////////////////////////////////////////

function mkRegularNumberFormat(value) {
    if (value == 'null' || value == '' || value == undefined || value == null) {
        value = '';
    }

    var regExpMoney = /(^[+-]?\d+)(\d{3})/;
    value += '';                          // 숫자를 문자열로 변환

    while (regExpMoney.test(value))
        value = value.replace(regExpMoney, '$1' + ',' + '$2');
    
    if(value =='')
    	value = 0;

    return value;
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: mkContainsChars
// Parameter Info	: 요청값, 체크할 문자열 
// Return Info		: true or false
// Description		: 입력값에 특정 문자가 있는지 체크
///////////////////////////////////////////////////////////////////////////
function mkContainsChars(value, chars) {
    for (var inx = 0; inx < value.length; inx++) {
        if (chars.indexOf(value.charAt(inx)) != -1)
            return true;
    }
    return false;
}

///////////////////////////////////////////////////////////////////////////
// Function Name	: mkGetByteLength
// Parameter Info	: 입력값
// Return Info		: byte
// Description		: 입력값의 바이트 길이를 리턴
///////////////////////////////////////////////////////////////////////////
function mkGetByteLength(value) {
    var byteLength = 0;
    for (var inx = 0; inx < value.length; inx++) {
        var oneChar = escape(value.charAt(inx));
        if (oneChar.length == 1) {
            byteLength++;
        } else if (oneChar.indexOf("%u") != -1) {
            byteLength += 2;
        } else if (oneChar.indexOf("%") != -1) {
            byteLength += oneChar.length / 3;
        }
    }
    return byteLength;
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: mkGetDayOfWeek
// Parameter Info	: 
// Return Info		: 요일
// Description		: 오늘이 무슨 요일인지 리턴
///////////////////////////////////////////////////////////////////////////
function mkGetDayOfWeek() {
    var now = new Date();

    var day = now.getDay();
    var week = new Array('일', '월', '화', '수', '목', '금', '토');

    return week[day];
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: mkGetDateStamp
// Parameter Info	: Date 객체, 구분자
// Return Info		: 날짜형태 문자열 리턴
// Description		: 오늘의 날짜를 구분자 포함 문자열로 리턴, ex) 2013-04-22
///////////////////////////////////////////////////////////////////////////
function mkGetDateStamp(d, char) {
    var year = d.getFullYear();
    var month = d.getMonth() + 1;
    var day = d.getDate();

    ("" + month).length == 1 ? month = "0" + month : month;
    ("" + day).length == 1 ? day = "0" + day : day;

    return ("" + year + char +  month + char + day);
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: mkGetTimeStamp
// Parameter Info	: Date 객체, 날짜구분자, 날짜와 시간사이 구분자, 시간과 분사이 구분자
// Return Info		: 날짜형태 문자열 리턴
// Description		: 오늘의 날짜를 시, 분을 포함한 구분자 포함 문자열로 리턴, ex) 2013-04-22 11:01
///////////////////////////////////////////////////////////////////////////
function mkGetTimeStamp(d, dchar, schar, tchar) {
    var year = d.getFullYear();
    var month = d.getMonth() + 1;
    var day = d.getDate();
    var hour = d.getHours();
    var min = d.getMinutes();

    ("" + month).length == 1 ? month = "0" + month : month;
    ("" + day).length == 1 ? day = "0" + day : day;
    ("" + hour).length == 1 ? hour = "0" + hour : hour;
    ("" + min).length == 1 ? min = "0" + min : min;

    return ("" + year + dchar + month + dchar + day + schar + hour + tchar + min);
}


///////////////////////////////////////////////////////////////////////////
// Function Name	: mkToTimeObject
// Parameter Info	: 
// Return Info		: Date 객체
// Description		: Time 스트링 -> Date 객체, 숫자형식만 허용('20130422' or '201304221055')
///////////////////////////////////////////////////////////////////////////
function mkToTimeObject(time) {
    var t = mkOnlyNumber(time);

    var year = t.substr(0, 4);
    var month = t.substr(4, 2) - 1;
    var day = t.substr(6, 2);
    var hour = t.substr(8, 2);
    var min = t.substr(10, 2);

    return new Date(year, month, day, hour, min);
}

///////////////////////////////////////////////////////////////////////////
// Function Name	: mkUrlEncoding
// Parameter Info	: url 경로
// Return Info		: url encoding된 string 객체
// Description		: url를 encoding해준다.
///////////////////////////////////////////////////////////////////////////
function mkUrlEncoding(params) { 
    var val = "";
    var oLocation = params;

    if (oLocation.indexOf('?') > 0) {
        var strUri = oLocation.split('?');
        var strParam = strUri[1].split('&');

        for (var i = 0; i < strParam.length; i++) {
            if (strParam[i].indexOf('=') > 0) {
                var strQuery = strParam[i].split('=');

                if (val == "") val = strQuery[0] + "=" + escape(strQuery[1]);
                else val = val + "&" + strQuery[0] + "=" + escape(strQuery[1]);
            }
        }

        return strUri[0] + "?" + val;
    }
    return "";
}

///////////////////////////////////////////////////////////////////////////
//	Function Name	: GetParamValue
//	Parameter Info	: strName: 파라메타 이름
//	Return Info		: 
//	Description		: 전달받은 파라메타에서 값찾기
///////////////////////////////////////////////////////////////////////////
function mkGetParamValue(strName) {
    var oLocation = location.href;

    if (oLocation.indexOf('?') > 0) {
        var strUri = oLocation.split('?');
        var strParam = strUri[1].split('&');

        for (var i = 0; i < strParam.length; i++) {
            if (strParam[i].indexOf('=') > 0) {
                var strQuery = strParam[i].split('=');

                // 0에는 parameter 이름, 1에는 값이 저장된다.
                if (strQuery[0] == strName)
                    return strQuery[1];
            }
        }
    }

    // 찾고자하는 변수가 없는 경우 빈문자열 반환한다.
    return "";
}

///////////////////////////////////////////////////////////////////////////
//	Function Name	: mkGetParamValueAll
//	Parameter Info	: 
//	Return Info		: 
//	Description		: search attribute를 찾아 url 파라미터 생성
///////////////////////////////////////////////////////////////////////////
function mkGetParamValueAll() {
    var oLocation = location.href;
    var returnValue = "";

    if (oLocation.indexOf('?') > 0) {
        var strUri = oLocation.split('?');
        var strParam = strUri[1].split('&');

        for (var i = 0; i < strParam.length; i++) {
            if (strParam[i].indexOf('=') > 0) {
                var strQuery = strParam[i].split('=');

                if (strQuery[0].indexOf("search_") != -1)
                    returnValue += "&" + strQuery[0] + "=" + strQuery[1];
            }
        }
    }

    // 찾고자하는 변수가 없는 경우 빈문자열 반환한다.
    return returnValue;
}

///////////////////////////////////////////////////////////////////////////
//	Function Name	: mkDelay
//	Parameter Info	: gap: millisec
//	Return Info		: 
//	Description		: 지연함수
///////////////////////////////////////////////////////////////////////////
function mkDelay(gap) { /* gap is in millisecs */
    var then, now;
    then = new Date().getTime();
    now = then;
    while ((now - then) < gap) {
        now = new Date().getTime();
    }
}

///////////////////////////////////////////////////////////////////////////
//	Function Name	: mkLengthNumber
//	Parameter Info	: num: 숫자, pri: 자리수
//	Return Info		: 
//	Description		: 앞자리 '0' 체우기
///////////////////////////////////////////////////////////////////////////
function mkLengthNumber(num, pri) {
    var nlen = num.toString().length;
    var ret = "";
    if (nlen >= pri)
        return num.toString();

    for (i = 0; i < pri - nlen; i++) {
        ret += "0";
    }
    return ret + num.toString();
}

///////////////////////////////////////////////////////////////////////////
//	Function Name	: mkAge
//	Parameter Info	: year: 태어난 년
//	Return Info		: 
//	Description		: 나이 계산
///////////////////////////////////////////////////////////////////////////
function mkAge(birthYear) {
    var year = parseInt(new Date().getFullYear());
    var age = parseInt(birthYear);
    return (year - age) + 1; // 우리나라 나이 표시 +1 더함
}

///////////////////////////////////////////////////////////////////////////
// Function Name	: mkIsLevel
// Parameter Info	: 
// Return Info		: true or false
// Description		: 권한 레벨 조회 비교 처리
///////////////////////////////////////////////////////////////////////////
function mkIsLevel(strLevels, strContLevel) {
    var isContain = false;
    var levels = strLevels.split("|");

    for (var i = 0; i < levels.length; i++) {
        if (levels[i] == strContLevel) {
            isContain = true;
            break;
        }
    }

    return isContain;
}
var errorOptions = {
    id: "show_message_error",
    backgroundColor: "red",
    color: "white"
};
///////////////////////////////////////////////////////////////////////////
//		Function Name	: mkMessageFunc
//		Parameter Info	: msg - 처리할 메시지, errOpt - 에러옵션(없거나 0일 때는 에러 아님)
//		Return Info		: 
//		Description		: 메시지를 출력할 때 쓰는 함수
///////////////////////////////////////////////////////////////////////////
function mkMessageFunc(msg, errOpt) {
    if (errOpt == null || errOpt == undefined || errOpt == 0) {
        $.showMessage(msg);
    } else {
        $.showMessage(msg, errorOptions);
    }
}

///////////////////////////////////////////////////////////////////////////
//Function Name	: mkCommonCodeFind
//Parameter Info	: ftype - product customer, param - 입력하는 input text id값
//					, callBackFunc - 팝업의 값 선택후 부모창에 값 받는 함수 callBackFunc은  해당페이지에 함수생성해야됨
//Return Info		: 네임값 또는 해당 ftype의 팝업
//Description		: 제품/거래처 코드로 네임 찾는 함수
///////////////////////////////////////////////////////////////////////////
function mkCommonCodeFind(ftype, param, callBackFunc){
	var t_url ="";
	var j_url ="";
	var pop_params="";
	var receive_input_nm = "";
	receive_input_nm = param.NAME;
	
	if(ftype =='product'){ // 자재, 제품
		t_url = _BASE_URL_ + "/popup/CJHC_MDS_WEB701.do";
		j_url = _BASE_URL_ + "/popup/productSearch.do";
	}else{			
		t_url = _BASE_URL_ + "/popup/CJHC-MDS-WEB704.do";
		j_url = _BASE_URL_ + "/popup/customerSearch.do";
	}
	
	if(param.CODE.length==0){    // CODE 값이 빈값, NULL 일 경우
		if(ftype =='product'){
			pop_params = {			
					plant_cd			:	"",
	        		callBackFunction	: 	callBackFunc
		    };
			sndPopup.openPopup(t_url, pop_params, 650, 600, "자재팝업");				
		}else{
			pop_params = {			
					plant_cd			:	"",
	        		callBackFunction	: 	callBackFunc
		    };
			sndPopup.openPopup(t_url, pop_params, 650, 600, "거래처팝업");					
		}
	}
	else{ //
		var inputParam = {					
				PLANT_CD :  $("#"+ param.PLANT_CD +" option:selected").val(),
				CODE :  $("#"+ param.CODE).val()					
			}
		if(ftype == 'product'){	// 자재				
 			$.ajax({
 				type		: "POST",
 				url			: j_url,
 				data		: inputParam,
 				dataType	: "json",
 				success		: function(data, statusText){	   	   
 		        	   if(statusText == "success"){
 		        		   if(data == null){
	 		        			pop_params = {			
	 		     						plant_cd			:	"",
	 		     		        		callBackFunction	: 	callBackFunc
	 		     			    };
	 		     				sndPopup.openPopup(t_url, pop_params, 650, 600, "자재팝업");
 		        		   }else{
 		        			  t_receive_input_nm = "#"+receive_input_nm;
	 		        		  $(t_receive_input_nm).val(data.CODE_NM);
	 		        		  //$(t_receive_input_nm).attr("readonly", true);
 		        		   }
 		        		   
 		        	   }else{
 		        		    pop_params = {			
 		     						plant_cd			:	"",
 		     		        		callBackFunction	: 	callBackFunc
 		     			    };
 		     				sndPopup.openPopup(t_url, pop_params, 650, 600, "자재팝업");
 		        	   }
 				},
 				error		: function(xhr, textStatus, errorThrown){
 					pop_params = {			
     						plant_cd			:	"",
     		        		callBackFunction	: 	callBackFunc
     			    };
     				sndPopup.openPopup(t_url, pop_params, 650, 600, "자재팝업");
 				}
 			});				
		}else{	// 거래처				
			$.ajax({
 				type		: "POST",
 				url			: j_url,
 				data		: inputParam,
 				dataType	: "json",
 				success		: function(data, statusText){	   	   
 		        	   if(statusText == "success"){
 		        		   if(data == null){
	 		        			pop_params = {			
	 		     						plant_cd			:	"",
	 		     		        		callBackFunction	: 	callBackFunc
	 		     			    };
	 		     				sndPopup.openPopup(t_url, pop_params, 650, 600, "거래처팝업");
 		        		   }else{
 		        			  t_receive_input_nm = "#"+receive_input_nm;
	 		        		  $(t_receive_input_nm).val(data.CODE_NM);
	 		        		  //$(t_receive_input_nm).attr("readonly", true);
 		        		   }
 		        		   
 		        	   }else{
 		        		    pop_params = {			
 		     						plant_cd			:	"",
 		     		        		callBackFunction	: 	callBackFunc
 		     			    };
 		     				sndPopup.openPopup(t_url, pop_params, 650, 600, "거래처팝업");
 		        	   }
 				},
 				error		: function(xhr, textStatus, errorThrown){
 					pop_params = {			
     						plant_cd			:	"",
     		        		callBackFunction	: 	callBackFunc
     			    };
     				sndPopup.openPopup(t_url, pop_params, 650, 600, "거래처팝업");
 				}
 			});			
			
		}	
	}		
}


///////////////////////////////////////////////////////////////////////////
//Function Name	: mkfnChkByte
//Parameter Info	: ftype - product customer, param - 입력하는 input text id값
//					, callBackFunc - 팝업의 값 선택후 부모창에 값 받는 함수 callBackFunc은  해당페이지에 함수생성해야됨
//Return Info		: 네임값 또는 해당 ftype의 팝업
//Description		: maxlength 함수
///////////////////////////////////////////////////////////////////////////

function mkfnChkByte(obj, maxByte){

	var str = obj.value;
	var str_len = str.length;

	var rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var str2 = "";

	for(var i=0; i<str_len; i++){
		one_char = str.charAt(i);
		
		if(escape(one_char).length > 4){
		    rbyte += 2;                                         
		}else{
		    rbyte++;                                            
		}

		if(rbyte <= maxByte){
		    rlen = i+1;                                          
		}
	}

	if(rbyte > maxByte){
	    alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    str2 = str.substr(0,rlen);                                  
	    obj.value = str2;
	    mkfnChkByte(obj, maxByte);
	}/*else{
	    document.getElementById('byteInfo').innerText = rbyte;
	}*/
}

//현재 창 닫기
function windowClose(){
	// 부모 윈도우가 있는 경우 강제 종료
    if(opener!=null)
       opener.top.window.open('about:blank','_self').close();

    // 자신이 부모인 경우 스스로 강제 종료
    top.window.open('about:blank','_self').close();
}

///////////////////////////////////////////////////////////////////////////
//Function Name	: mkLayerPopupOpen
//Parameter Info	: 팝업으로 띄울 url
//Return Info		: 
//Description		: 해당 url 경로의 페이지를 레이어 팝업으로 호출함.
///////////////////////////////////////////////////////////////////////////
function mkLayerPopupOpen(url){       //실제 페이지에서 호출하는 함수
	writeLayerPopup(url);
}
function writeLayerPopup(url){			//레이어 팝업으로 보여질 부분을 그려줌
	$("body").append("<div id='layer_pop'><div class='pop_cont'></div></div>");
	$(".pop_cont").load(url);
}
function layerOpen(){					//해당 레이어 팝업을 오픈함.
	$("#layer_pop").css("display","block").find(".pop_cont").positionCenter();
	$("body").css("overflow","hidden");
}
function layerClose(){					//해당 레이어 팝업을 닫음
	$("#layer_pop").css("display","none");
	$("body").css("overflow","auto");
}

///////////////////////////////////////////////////////////////////////////
//Function Name	: mkDisabled, mkEnabled
//Parameter Info	: 
//Return Info		: 
//Description		: 컨트롤의 활성화 비활성화
///////////////////////////////////////////////////////////////////////////
function mkDisabled(){
	$("[able]").attr("disabled", true);
}
function mkEnabled(){
	$("[able]").attr("disabled", false);
}
///////////////////////////////////////////////////////////////////////////
//Function Name	: mkPRRPeriod, mkPRR, mkSE, mkPRRMinus, mkPRRPlus
//Parameter Info	: A, AB, AC, ABCD, PRR텍스트박스, PRR(-)텍스트박스, PRR(+)텍스트박스
//Return Info		: PRR값
//Description		: PRR 값을 계산
///////////////////////////////////////////////////////////////////////////
function mkPRRPeriod(a, ab, ac, abcd, txtPrr, txtPrrMinus, txtPrrPlus){
	if(a != "" && ab != "" && ac != "" && abcd != ""){			
		var b = ab - a;
		var c = ac - a;
		var d = abcd - a - b - c;
		
		if(c == "0"){
			alert("C 값은 0일수 없습니다.");
			return;
		}
		
		txtPrr.val(mkPRR(a, b, c, d));
		txtPrrMinus.val(mkPRRMinus(a, b, c, d));
		txtPrrPlus.val(mkPRRPlus(a, b, c, d));
	
	}else{
		alert("정상적인 데이터를 입력하여 주십시오");
	}
}
function mkPRR(a, b, c, d){
	var prr = (a / (a + b)) * ((c + d) / c);
	
	return prr.toFixed(2);
}
function mkSE(a, b, c, d){
	var se = Math.sqrt((1 / a) + (1 / c) - (1 / (a + b)) - (1 / (c + d)));
	return se.toFixed(2);
}
function mkPRRMinus(a, b, c, d){
	var minus = mkPRR(a, b, c, d) / Math.exp(1.96 * mkSE(a, b, c, d));
	return minus.toFixed(2);
}
function mkPRRPlus(a, b, c, d){
	var plus = mkPRR(a, b, c, d) * Math.exp(1.96 * mkSE(a, b, c, d));
	return plus.toFixed(2);
}