/* ********************************************************
 * 현재날짜 가져오기
 ******************************************************** */
function fn_getToday(){

    var today = new Date();
    var currentYear  = today.getFullYear();
    var currentMonth = (today.getMonth()+1).toString();
    var currentDay = today.getDate().toString();

    var currentToday = currentYear + "-" + fn_getLpad(2,currentMonth) + "-" + fn_getLpad(2,currentDay);

    return  currentToday;
}

/* ********************************************************
 * LPAD 처리
 ******************************************************** */
function fn_getLpad(rtnSize, sourceStr)
{
    rtnStr = sourceStr;

    for( i= sourceStr.length; i<parseInt(rtnSize); i++)
        rtnStr =  "0" + rtnStr;

    return rtnStr;
}


/* ********************************************************
 * 결재정보 버튼 callback
 ******************************************************** */
function f_requestRequstNo_2(v) {
	//console.log("approvalSn:::::"+approvalSn);
	var params = {
  			'REQUEST_NO' : g_SETLE_NO
		};
	grid_wrap_03.proxy.param = params;
	grid_wrap_03.load();
}

/* ********************************************************
 * 결재요청 버튼 callback
 ******************************************************** */


/* ********************************************************
 * 결재버튼 제어
 ******************************************************** */
function fn_btnApproval(){
	if(g_SETLE_NO){
		$("#btnApproval").hide();
		$("#btnApprovalInfo").show();
	}
	else{
		$("#btnApproval").show();
		$("#btnApprovalInfo").hide();
	}
}



var validatorCnt;
function validator(value){
	var string = "";
	
	string += value;
	
	var stringLength = string.length;
	var stringByteLength = 0;
	
	stringByteLength = (function(s,b,i,c){
		for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
		return b;
	})(string);
	//console.log(stringByteLength + " Bytes"); 
	
	validatorCnt = stringByteLength;
}

/* ********************************************************
 * 메일발송
 ******************************************************** */
function fn_Email(param){
	
	var arJson = [];	
	arJson.push(param);

	$.ajax({
		url: G_EMAIL_URL,
		type: 'post', 		
	    contentType: "application/json; charset=UTF-8",
	    dataType: 'json',
	    data: JSON.stringify(arJson), 		  
	    success:function(data){
	    	
	    	if(data.success) {
	    		 			    	
	    	} else { 		    		
	    		alert(data.message);
	    	}
	    },
	    error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			alert(errorThrown);
			alert(jqXHR.responseText);				
		}
	});
}

function f_requestRequstNo_1(v) {
	console.log("f_requestRequstNo_1..................................["+v+"]");
	g_SETLE_NO = v;
	var approval = {
		 'REPORT_SN'    : g_REPORT_INFO.REPORT_SN
		,'CHARGER_ID'   : g_REPORT_INFO.CHARGER_ID
		,'UPDATE_ID'    : "${loginMap.USER_ID}"
		,'SETLE_NO'     : g_SETLE_NO
		,'MILESTONE_SN' : g_REPORT_INFO.MILESTONE_SN
		,'TASK_SN'      : g_REPORT_INFO.TASK_SN
		,'REPORT_TYPE'  : g_REPORT_TYPE
	};
console.log(approval);
	$.ajax({
		url : g_UPDATE_APPOROVAL,
		type: 'post',
		contentType: "application/json; charset=UTF-8",
		data : JSON.stringify(approval),
		success : function(data, textStatus, jqXHR) {
			if(data.success) {
console.log(data.success);
				//approvalSn = data.result.
				var params = {
						'REQUEST_NO' : g_SETLE_NO
	    		};
				grid_wrap_03.proxy.param = params;
				grid_wrap_03.load();
				 
				///////////////////////////결재요청시 이메일 발송/////////////////////////
				var items = AUIGrid.getGridData(grid_wrap_03.id);
				var exItems = [{"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
				               {"EMAIL" : "kimbokmin@daum.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
				               {"EMAIL" : "kimbokmin@naver.com" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/}];

				var emailInfo = {};
				for(var i=0; i<items.length; i++){
				  //emailInfo = {"EMAIL" : items[i].EMAIL /*sendEmail*/, "USER_NM" : items[i].SANCTNER_NM/*userName*/}; 실제 메일발송
//  					emailInfo = {"EMAIL" : exItems[i].EMAIL /*sendEmail*/, "USER_NM" : exItems[i].SANCTNER_NM/*userName*/};
//  					fn_Email(emailInfo);
				}
				  
				fn_selectReportInfo();
			} else {					  
				alert(data.message);
			}
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			//alert(jqXHR);
		}
	});
}

function fn_goTapPage(p_REPORT_SE, p_REPORT_TYPE, p_APPROVAL_URL){
	var params = { 
			   'MILESTONE_SN' : g_REPORT_INFO.MILESTONE_SN
	  		  ,'INSTT_CODE'   : g_REPORT_INFO.INSTT_CODE
	  		  ,'TASK_SN'      : g_REPORT_INFO.TASK_SN
	          ,'OPRTN_DE'     : g_REPORT_INFO.OPRTN_DE_DATE
			  ,'NAME1'        : g_REPORT_INFO.INSTT_NAME
			  ,'USER_NM'      : g_REPORT_INFO.RSRCHMAN_NM //연구자 명
			  ,'USER_ID'      : g_REPORT_INFO.RSRCHMAN_ID //연구자 ID
			  ,'TASK_NO'      : g_REPORT_INFO.TASK_NO
			  ,'REPORT_SE'    : p_REPORT_SE
			  ,'REPORT_TYPE'  : p_REPORT_TYPE
	};
	
	var f = document.createElement("form");
	
	var objs ;
	var value ;
	
	for(var key in params){
		value = params[key];		
		objs = document.createElement("input");
		objs.setAttribute("type", "hidden");
		objs.setAttribute("id", key);
		objs.setAttribute("name", key);
		objs.setAttribute("value", value);
		f.appendChild(objs);
	}

	f.setAttribute("method", "post");
	f.setAttribute("action", p_APPROVAL_URL);
	document.body.appendChild(f);
	f.submit();
}

function fn_rdPrint(g_RD_NAME){
  	var param = {
			MRD_NAME     : g_RD_NAME,
			MILESTONE_SN : g_REPORT_INFO.MILESTONE_SN,
			TASK_SN      : g_REPORT_INFO.TASK_SN,
	};

	var f = document.createElement("form");
	
	$.each(param, function(key, value){
		var obj;
		obj = document.createElement("input");
		obj.setAttribute("type", "hidden");
		obj.setAttribute("name", key);
		obj.setAttribute("value", value);
		f.appendChild(obj);	
	});
	
	window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");
	
	f.setAttribute("method", "post");
	f.setAttribute("action", "/com/system/CommonRD.do");
	f.setAttribute("target", "popForm");
	document.body.appendChild(f);
	f.submit();
}

window.onresize = function() {
	if (grid_wrap_01.id) {
		AUIGrid.resize(grid_wrap_01.id);
	}
	if (grid_wrap_02.id) {
		AUIGrid.resize(grid_wrap_02.id);
	}
	if (grid_wrap_03) {
		AUIGrid.resize(grid_wrap_03.id);
	}
};
