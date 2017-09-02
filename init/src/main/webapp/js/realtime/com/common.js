var _vGrValidation = {
	lengthCheck: function(v, v2) {
		if(v.length > v2) {
			return false;
		} else {
			return true;
		}
	},
	numberCheck: function(v) {
		if(v.match(/[^0-9]/)) {
			return false;
		} else {
			return true;
		}
	},
	engCheck: function(v) {
		if(v.match(/[^a-zA-Z]/)) {
			return false;
		} else {
			return true;
		}
	},
	engNumcheck: function(v) {
		if(v.match(/[^a-zA-Z0-9]/)) {
			return false;
		} else {
			return true;
		}
	},
	engNumSpecialCheck: function (v) {
		if(v.match(/[^a-zA-Z0-9.;\-_]/)) {
			return false;
		} else {
			return true;
		}
	},
	pkCheck: function(obj, pkKey) {
		var vTmp = obj.list;
		var flag = true;

		for (var i = 0; i < vTmp.length; i++) {
			for (var j = 0; j < vTmp.length; j++) {
				
				if (!vTmp[i][pkKey] && !vTmp[j][pkKey]) {
					continue;
				}
				
				if (vTmp[i][pkKey] == vTmp[j][pkKey] && i != j) {
					flag = false;
					break;
				}
			}
		}
		
		return flag;
	}

}

function fn_GridMultiSaveCallBack2(obj, url, validateJson, arParam, message1, message2, loadParam, callback) {
	
	var vFlag = false;
	var returnArJson = [];
	
	arParam = obj.getList("modified");
	
	if(!arParam.length) {
		if(message1) {
			alert(message1);
		} else {
			alert("저장할 값이 없습니다.");
		}
		
		vFlag = true;
	}
	
	$.each(validateJson, function(validateKey, validateMessage){ 
		
		for(var i = 0; i < arParam.length; i++) {
			
			if(!arParam[i][validateKey]) {
				
				if(validateMessage) {
					
					if(!vFlag) {
						
						alert(validateMessage);
						
						
						//포커스 영역
						
					}
					
					vFlag = true;
					
				} else {
					
					if(!vFlag) {
						alert("유효성 검사에 통과하지 못했습니다.");
					}
					
					vFlag = true;
				}
				
			}
			
		}
		
	});
	
	if(vFlag) {
		return;
	}
	
	callback(obj, url, validateJson, returnArJson, message1, message2, loadParam);
	
}

function fn_GridMultiSaveForValidateArray(obj, url, validateJson, arParam, message1, message2, loadParam) {
	
	fn_GridMultiSaveCallBack2(obj, url, validateJson, arParam, message1, message2, loadParam, function(){
		
		$.ajax({
			url : _contextPath + url,
			type: "post",
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(obj.getList("modified")),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					if(message2) {
						alert(message2);
						
						if(loadParam) {
							obj.load(loadParam);	
						} else {
							obj.load();
						}
						
					} else {
						alert("저장되었습니다.");
						
						if(loadParam) {
							obj.load(loadParam);	
						} else {
							obj.load();
						}
					}
				} else {
					alert(data.message);
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});
	
}

function fn_GridMultiSaveForValidateArray2(obj, url, validateJson, arParam, message1, message2, loadParam) {
	
	fn_GridMultiSaveCallBack2(obj, url, validateJson, arParam, message1, message2, loadParam, function(){
		
		$.ajax({
			url : _contextPath + url,
			type: "post",
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(obj.getList()),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					if(message2) {
						alert(message2);
						
						if(loadParam) {
							obj.load(loadParam);	
						} else {
							obj.load();
						}
						
					} else {
						alert("저장되었습니다.");
						
						if(loadParam) {
							obj.load(loadParam);	
						} else {
							obj.load();
						}
					}
				} else {
					alert(data.message);
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});
	
}

ax5.ui.grid.formatter["date"] = function() {
	
	var date = this.value;
	
	if(date && date.length == 8) {
		
		return date.substr(0, 4) + "-" + date.substr(4, 2) + "-" + date.substr(6);
	} else {
		
		return date;
		
	}
	
}