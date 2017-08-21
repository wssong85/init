<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
.gnb_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.gnb_column_style:hover{text-decoration:underline; cursor:pointer;}
.gnb_grid_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.gnb_grid_column_style:hover{text-decoration:underline; cursor:pointer;}
.gnb_grid_column_style2 { color: #5570e6; font-weight: bold;}
</style>

<script>
var globalInterval = setInterval(convertTime, 1000);

function convertTime() {
	var test = $('#headerTimeData').text();
	var test2 = test.split(':');
	var test3 = (test2[0] * 60) + test2[1] * 1;
	
	if(!test3) {
		location.href = "<c:url value='/com/i01/pantheonLogout.do'/>";
	}
	
	var test4 = '';
	var test5 = '';
	
	test3 = test3 - 1;
	
	if(test3%60 < 10) {
		test4 = '0' + test3%60; 
	} else {
		test4 = test3%60;
	}
	
	if(parseInt(test3/60) < 10) {
		test5 = '0' + parseInt(test3/60); 
	} else {
		test5 = parseInt(test3/60);
	}
	
	$('#headerTimeData').text(test5 + ':' + test4);   	
}

function resetTime() {
	var test = $('#headerTimeData').text();
	var test2 = test.split(':');
	var test3 = (test2[0] * 60) + test2[1] * 1;
	
	if(test3 < 1740) {
		$('#headerTimeData').text('30:00');	
	}
}

var grHeaderCmUserTask = {
	id : '',
	div : {
		gridDiv : '#grHeaderCmUserTask',
		paging : {
			pagingDiv : 'grHeaderCmUserTask_paging',
			totalRowCount : 500,
			rowCount : 20,
			pageButtonCount : 5,
			currentPage : 1,
			totalPage : 0,
		},
	},
	proxy : {
		url : "<c:url value='/edc/a01/selectTaskList.do'/>",
		param : {},
		type : 'post',
		dataType : 'json',
		paging : true,
		autoLoad : false
	},
	gridPros : {
		showRowNumColumn : false,
		showRowCheckColumn : false,
		enableColumnResize : true,
		enableMovingColumn : false,
		editable : false,
		enableFilter : true,
		headerHeight : 40,
		rowHeight : 37,
		selectionMode : "singleRow"
	},
	columnLayout : [{ 
		dataField : "TASK_NO",
		headerText : '<spring:message code="header.gr.TASK_NO"/>',
		width : 120,
		style : "gnb_grid_column_style"
	},{
		dataField : "TASK_SN",
		headerText : '<spring:message code="header.gr.TASK_SN"/>',
		visible: false
	},{
		dataField : "TASK_NM",
		headerText : '<spring:message code="header.gr.TASK_NM"/>',
		width: 150
	},{
		dataField : "TASK_TY_CODE_NM",
		headerText : '<spring:message code="header.gr.TASK_TY_CODE_NM"/>'
	},{
		dataField : "PROGRS_CODE_NM",
		headerText : '<spring:message code="header.gr.PROGRS_CODE_NM"/>'
	},{
		dataField : "TASK_DC",
		headerText : '<spring:message code="header.gr.TASK_DC"/>'
	},{
		dataField : "ROLE_NM",
		headerText : '<spring:message code="header.gr.ROLE_NM"/>'
	},{
		dataField : "ROLE_ID",
		headerText : '<spring:message code="header.gr.ROLE_NM"/>',
		visible: false
	},{
		dataField : "TASK_TY_CODE",
		headerText : '<spring:message code="header.gr.TASK_TY_CODE"/>',
		visible: false
	},{
		dataField : "EDU_TY",
		headerText : '<spring:message code="header.gr.EDU_TY"/>',
		style : "gnb_grid_column_style2"
	}],
	createGrid : function() {
		var me = this;
		
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
		me.binding();
		
		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	binding : function() {
		var me = this;
		AUIGrid.bind(me.id, 'cellClick', function(event) {
			if (event.dataField == "TASK_NO") {
				if(!$('#selectHeaderTaskModule').val()) {
					alert('<spring:message code="header.message.1"/>');
					return;
				}
				
				$('#txtHeaderTaskSn').val(event.item['TASK_SN']);
				$('#txtHeaderTaskNo').val(event.item['TASK_NO']);
				$('#txtHeaderRoleId').val(event.item['ROLE_ID']);
				$('#txtHeaderTaskTyCode').val(event.item['TASK_TY_CODE']);
				$('#txtHeaderModuleCode').val($('#selectHeaderTaskModule').val());
				
    	 		$.ajax({
    	 		    url: "<c:url value='/edc/a01/selectCtmsDmcTaskRoleForDupCheck.do'/>",
    	 		    type: 'post',
    	 		    dataType: 'json',
    	 		    data: {
    	 		    	'ROLE_ID' : event.item['ROLE_ID'],
    	 		    	'MODULE_CODE' : $('#selectHeaderTaskModule').val(),
    	 		    	'TASK_SN' : event.item['TASK_SN']
    	 		    },
    	 		    success:function(data){
    	 		    	if(data.success) {
    	 		    		if(!data.count) {
    	 		    			alert('<spring:message code="header.message.2"/>');
    	 		    			return;
    	 		    		} else {
    	 						$("#frHeaderSubmit").attr({
    	 							action: "<c:url value='/edc/system/EDCA0101.do'/>",
    	 							method:'post',
    	 						}).submit();
    	 		    		}
    	 		    	} else {
    	 		    		alert(data.message);
    	 		    	}
    	 		    },
    				error : function(jqXHR, textStatus, errorThrown){
    					alert(textStatus);
    				}
    	 		});
				
			}
		});
	},
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};

//전체 모듈 select box loading
function loadHeaderAllModuleCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.PROGRM_URL + ">" + this.MODULE_CODE + "</option> ";
	});

	target.append(dataArr);
}

//과제 모듈 select box loading
function loadHeaderTaskModuleCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.MODULE_CODE + ">" + this.MODULE_CODE + "</option> ";
	});

	target.append(dataArr);
}

$(function(){	
	grHeaderCmUserTask.createGrid();
	
	$('body').keydown(function(event){
		resetTime();		
	});
	
	$('body').mousemove(function(event){
		resetTime();
	});
	
	$('#btnHeaderMove').click(function(){
		if(!$('#selectHeaderAllModule').val()) {
			alert('<spring:message code="header.message.3"/>');
			return;
		}
		
		var vHomeUrl = $('#selectHeaderAllModule').val();
		
		$("#frHeaderSubmit").attr({
			action: "<c:url value='"+ vHomeUrl +"'/>",
			method:'post',
		}).submit();

	});

	//모듈/과제
	$('.gnb_01, .gnb_icon_01').click(function(){
		$('.gnb_01').toggleClass("gnb_on_01");
		$('.gnb_icon_01').toggleClass("gnb_icon_on_01");
		$('.gnb_detail_01').fadeToggle(400);
		$(".detail_in_01").scrollTop(0);
 		AUIGrid.resize(grHeaderCmUserTask.id);
	});
	
	$('.gnb_close_01').click(function(){
		$(this).parent().fadeOut(400);
		$('.gnb_01').removeClass("gnb_on_01");
		$('.gnb_icon_01').removeClass("gnb_icon_on_01");
	});
	
	//바로가기
// 	$('.gnb_02').hover(function(){
// 		$('.gnb_02').toggleClass("gnb_on_02");
// 		$('.gnb_icon_02').toggleClass("gnb_icon_on_02");
// 		$('.gnb_detail_02').stop().fadeToggle(400);
// 	});
	
	//설정
// 	$('.gnb_03').click(function(){
// 		mkLayerPopupOpen('/sample/page/_COMZ0101.do', {
// 			'REQUST_NM': '테스트결재',
// 			'callbackFunction': 'f_requestRequstNo_1'
// 		}, 1);
// 	});
	
	$("#selectHeaderTaskModule").change(function() {
		if ($('#selectHeaderTaskModule').val()) {
			grHeaderCmUserTask.proxy.param.MODULE_CODE = $('#selectHeaderTaskModule').val();
			grHeaderCmUserTask.load();
		}
	});
	
	$("#aChgPassword").click(function(){
		if(!confirm('<spring:message code="header.message.4"/>')) {
			return;
		}
		
 		$.ajax({
 		    url: "<c:url value='/com/i02/updateCmUserForMainClick.do'/>",
 		    type: 'post',
 		    dataType: 'json',
 		    data: {},
 		    success:function(data){
 		    	if(data.success) {
 		    		var passwordUrl = "<c:url value='/com/anonymous/COMI0204.do?PASSWORD_CODE='/>";
					location.href = passwordUrl + data.result;
 		    	} else {
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
	});

	
	$.ajax({
		url : "<c:url value='/com/i01/selectCmProgrmForHeaderAllModule.do'/>",
		success : function(data) {
			loadHeaderAllModuleCombo($("#selectHeaderAllModule"), data.result);
	        $("#selectHeaderAllModule").val("");
		}
	});
	
	$.ajax({
		url : "<c:url value='/com/i01/selectCmProgrmForHeaderTaskModule.do'/>",
		success : function(data) {
			loadHeaderTaskModuleCombo($("#selectHeaderTaskModule"), data.result);
	        $("#selectHeaderTaskModule").val("");
		}
	});

});

$(window).resize(function() {
	if(grHeaderCmUserTask && grHeaderCmUserTask.id) {
		AUIGrid.resize(grHeaderCmUserTask.id);
	}
});
</script>



<header id="topHeader">
	<form id="frHeaderSubmit" name="frHeaderSubmit">
		<input type="hidden" id="txtHeaderTaskSn" name="TASK_SN"/>
		<input type="hidden" id="txtHeaderTaskNo" name="TASK_NO"/>
		<input type="hidden" id="txtHeaderRoleId" name="ROLE_ID"/>
		<input type="hidden" id="txtHeaderModuleCode" name="MODULE_CODE"/>
		<input type="hidden" id="txtHeaderTaskTyCode" name="TASK_TY_CODE"/>
	</form>

	<a href="<c:url value='/com/i01/intro.do'/>" ><img id="logo" src="<c:url value='/images/pantheon/common/logo.png'/>" alt=""></a>
	
	<nav id="topMenu">
	
<style>
.test_gnb{  position: absolute; top:5px; left:350px; z-index:1000;}
.test_gnb li{  font-size:11px; line-height:14px; color:#6d86f3; float:left; padding:3px; margin:0 0 0 10px;}
</style>
<!-- 		<ul class="test_gnb"> -->
<%-- 			<li>test1 : <spring:message code="global.lang" /></li> --%>
<%-- 			<li>test1 : ${pageContext.response.locale}2</li> --%>
<!-- 		</ul> -->
		
		
		<ul class="gnb">
			<a href="<c:url value='/com/i01/intro.do'/>" ><li style="cursor: pointer;"><div class="gnbIco gnbIco01"></div><span>Home</span></li></a>
			
			<li class="gnbmenu_001" style="cursor: pointer;">
				<div class="gnbIco gnbIco02 gnb_icon_01"></div>
				<span class="gnb_01"><spring:message code="header.th.1"/></span>
				<div class="gnb_detail_01">
					<div class="arrow00"></div>
					<a href="#" class="gnb_close_01">×</a>
					<div class="detail_in_01">
						<table class="in_001">
							<colgroup>
								<col width="18%">
								<col width="">
							</colgroup>
							<tr>
								<th><spring:message code="header.th.2"/></th>
								<td>
									<select id="selectHeaderAllModule" style="width:81%;">
										<option value="">====select====</option>
									</select>
									
									<input type="button" id="btnHeaderMove" value=<spring:message code="header.btn.1"/>>
								</td>
							</tr>
						</table>
						
						<div style="height:15px;"></div>
						
						<table class="in_001">
							<colgroup>
								<col width="18%">
								<col width="">
							</colgroup>
							<tr>
								<th>과제</th>
								<td>
									<select id="selectHeaderTaskModule" style="width:100%;">
										<option value="">====select====</option>
									</select>
								</td>
							</tr>
						</table>
						
						<div style="height:2px;"></div>
						
						<div class="detail_in_001">
							<div id="grHeaderCmUserTask" class="gridHeiSz05 grid_wrap tb01_2"></div>
						</div>
					</div>
				</div>
			</li>
			<c:if test="${loginMap.TASK_NO ne null}">
			<li class="gnbmenu_002"><div class="gnbIco gnbIco02_01"></div><span id="spanHeaderTaskNo">${loginMap.TASK_NO}</span></li>
			</c:if>
			<li class="gnbmenu_004">
				<ul class="gnbSel">
					<li class="gnbSelLst">
						<c:if test="${pageContext.response.locale eq 'kr'  || pageContext.response.locale eq 'ko_KR'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>Korean</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<c:if test="${pageContext.response.locale eq 'jp'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>日本語</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<c:if test="${pageContext.response.locale eq 'en'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>ENGLISH</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<c:if test="${pageContext.response.locale eq 'ch_1'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>簡体中文</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<c:if test="${pageContext.response.locale eq 'ch_2'}">
							<a href="#"><div class="gnbIco gnbIco03"></div><span>繁体中文</span><div class="gnbIco gnbIcoArrow"></div></a>
						</c:if>
						
						<ul class="gnbSelSub">
							<div class="arrow01"></div>
							<li class="gnbSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=kr&URL='/>${LOCALE_RETURN}">Korean</a></li>
							<li class="gnbSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=en&URL='/>${LOCALE_RETURN}">ENGLISH</a></li>
							<li class="gnbSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=jp&URL='/>${LOCALE_RETURN}">日本語</a></li>
							<li class="gnbSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=ch_1&URL='/>${LOCALE_RETURN}">簡体中文</a></li>
							<li class="gnbSelSubLst"><a href="<c:url value='/com/anonymous/changeLocale.do?locale=ch_2&URL='/>${LOCALE_RETURN}">繁体中文</a></li>
						</ul>
					</li>
				</ul>
			</li>
			
			<li class="gnbmenu_005"><div class="gnbIco gnbIco04"></div><span>${loginMap.USER_NM}</span></li>
			<li class="gnbmenu_006"><div class="gnbIco gnbIco05"></div><span id="headerTimeData">30:00</span></li>
			<a href="<c:url value='/com/i01/pantheonLogout.do'/>" >
				<li class="gnbmenu_006_01" style="padding-left:0px; padding-right:24px; margin-right:10px; cursor: pointer;">
					<div class="gnbIco gnbIco06"></div>
					<span><spring:message code="header.span.1"/></span>
				</li>
			</a>
			
			<a id="aChgPassword" href="#" >
			<li class="gnbmenu_008" style="padding-left:0px; padding-right:24px; margin-right:10px;cursor: pointer;">
				<div class="gnbIco gnbIco07"></div>
				<span><spring:message code="header.span.2"/></span>
			</li>
			</a>
		</ul>
	</nav>
</header>