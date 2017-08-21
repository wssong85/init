<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script type="text/JavaScript" src="/js/jquery_latest.js"></script> -->
<!-- <script type="text/JavaScript" src="/js/jquery-1.8.3.min.js"></script> -->
<jsp:include page="/com/popup/popupCommon.do" flush="false"/>

<script language="javascript">

function getAddr(){
	$.ajax({
		 url :"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
		,type:"post"
		,data:$("#form").serialize()
		,dataType:"jsonp"
		,crossDomain:true
		,success:function(xmlStr){
			if(navigator.appName.indexOf("Microsoft") > -1){
				var xmlData = new ActiveXObject("Microsoft.XMLDOM");
				xmlData.loadXML(xmlStr.returnXml)
			}else{
				var xmlData = xmlStr.returnXml;
			}
			$("#list").html("");
			var errCode = $(xmlData).find("errorCode").text();
			var errDesc = $(xmlData).find("errorMessage").text();
			if(errCode != "0"){
				alert(errCode+"="+errDesc);
			}else{
				if(xmlStr != null){
					makeList(xmlData);
				}
			}
		}
	    ,error: function(xhr,status, error){
	    	alert("에러발생");
	    }
	});
}

function getAddrLoc(){
	$.ajax({
		 url :"/sample/getAddrApi.do"
		,type:"post"
		,data:$("#form").serialize()
		,dataType:"xml"
		,success:function(xmlStr){
			$("#list").html("");
			var errCode = $(xmlStr).find("errorCode").text();
			var errDesc = $(xmlStr).find("errorMessage").text();
			if(errCode != "0"){
				alert(errCode+"="+errDesc);
			}else{
				if(xmlStr != null){
					makeList(xmlStr);
				}
			}
		}
	    ,error: function(xhr,status, error){
	    	alert("에러발생");
	    }
	});
}
// roadAddrPart1
// roadAddrPart2
// zipNo
function makeList(xmlStr){
	var htmlStr = "";
	htmlStr += "<table>";
	$(xmlStr).find("juso").each(function(){
		htmlStr += "<tr>";
		htmlStr += "<td>"+$(this).find('roadAddr').text()      +"</td>";
		htmlStr += "<td>"+$(this).find('roadAddrPart1').text()      +"</td>";
		htmlStr += "<td>"+$(this).find('roadAddrPart2').text()      +"</td>";
		htmlStr += "<td>"+$(this).find('jibunAddr').text()     +"</td>";
		htmlStr += "<td>"+$(this).find('engAddr').text()     +"</td>";
		htmlStr += "<td>"+$(this).find('zipNo').text()      +"</td>";
		htmlStr += "<td>"+$(this).find('admCd').text()      +"</td>";
		htmlStr += "<td>"+$(this).find('rnMgtSn').text()      +"</td>";
		htmlStr += "<td>"+$(this).find('bdMgtSn').text()      +"</td>";
		htmlStr += "</tr>";
	});
	htmlStr += "</table>";
	$("#list").html(htmlStr);
}

function enterSearch() {
	var evt_code = (window.netscape) ? ev.which : event.keyCode;
	if (evt_code == 13) {    
		event.keyCode = 0;  
		getAddr(); //jsonp사용시 enter검색 
		//getAddrLoc(); // controller사용시 enter검색
	} 
}
</script>
<title>Insert title here</title>
</head>
<body>
<form name="form" id="form" method="post">
 <!-- <div style="display:none;"> -->
	currentPage : <input type="text" name="currentPage" value="1"/>
	countPerPage : <input type="text" name="countPerPage" value="10"/> 
 <!-- </div>  -->
 <!-- 테스트 키 TESTJUSOGOKR -->
	confmKey : <input type="text" name="confmKey" id="confmKey" style="width:250px;display:none" value="TESTJUSOGOKR"/>
	keyword : <input type="text" name="keyword" value="" onkeydown="enterSearch();"/>
<br/>
	<input type="button" onClick="getAddr();" value="주소가져오기_domainChk"/>
	<input type="button" onClick="getAddrLoc();" value="주소가져오기_ipChk"/>
	
	<div id="list"></div>
</form>
</body>
</html>