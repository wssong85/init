<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html style="margin:0;height:100%">
	<head>
		<meta charset="utf-8">
		<title>Crownix HTML5 Viewer</title>
		<script src="<c:url value='/js/pantheon/com/rd/jquery-1.11.0.min.js'/>"></script>
		<script src="<c:url value='/js/pantheon/com/rd/crownix-viewer.min.js'/>"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/js/pantheon/com/rd/crownix-viewer.min.css'/>">
	</head>
	<body style="margin:0;height:100%">
		<div id="crownix-viewer" style="position:absolute;width:100%;height:100%"></div>
		<script>
		var schme = '${pageContext.request.scheme}';			
		var serverName = '${pageContext.request.serverName}';			
		var serverPort = '${pageContext.request.serverPort}';
		var contextPath = '${pageContext.request.contextPath}';
		
		//개발서버1
		var realPort = '8088';
		
		//개발서버2
		var testPort = "18088";
		
		$(function(){
			
			//로컬 포트
			if(serverPort == '8080') {
				
				schme = 'http';
				serverName = '52.2.42.142';
				serverPort = '8088';
				contextPath = "/";
				
			}
			//개발 서버 1
			else if(serverPort == '80') {
				
				serverPort = realPort;
				
			}
			//개발 서버 2
			else if(serverPort == '90') {
				
				serverPort = testPort;
				
			}
			
			//url 조합
			var requestUrl = schme + "://" + serverName + ":" + serverPort +"/" + contextPath;
			console.log(requestUrl);
			
			var viewer = new m2soft.crownix.Viewer(requestUrl + '/ReportingServer/service', 'crownix-viewer');
			console.log(viewer);
			viewer.openFile('${RD.MRD}', '/rfn [' + requestUrl + '/DataServer/rdagent.jsp] /rv ${RD.PARAM}');
			
// 			viewer.openFile('sample.mrd', '/rfn [sample.txt]');
		});
				
		</script>
	</body>
</html>