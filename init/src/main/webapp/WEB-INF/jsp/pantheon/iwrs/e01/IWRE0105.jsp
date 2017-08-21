<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<style>
		table.tbl_query tr td {
			border: none !important;
			cursor: pointer;
		}
		
		table.tbl_query td.crf_query_status {
			text-align: center;
			vertical-align: top;
			font-weight: bold;
			padding-top: 8px;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			initPage();
			buttonActive();
		});
		
		function initPage(){
			$("#spanSubject").text("${SUBJECT_CODE}");
			$("#spanVisit").text("${VISIT_LBL}");
			$("#hVisitCode").val("${VISIT_CODE}");
			
			var param = {
					TASK_CODE : "${TASK_CODE}",
					SUBJECT_CODE : "${SUBJECT_CODE}",
					VISIT_CODE : "${VISIT_CODE}"
			}
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : '/iwrs/e01/selectDispenseReturnInfo.do',
				success :function(data){
					if(data.result){
						for(var i = 0; i < data.list.length; i++){
							var tr = "<tr>";
							tr += "<td>";
							tr += "<label id='lblIpType" + i + "'>" + data.list[i].IP_TYPE + "</label>";
							tr += "<input type='hidden' id='hDlvyManageCode" + i + "' value='" + data.list[i].DLVYMANAGE_CODE + "' />";
							tr += "<input type='hidden' id='hSn" + i + "' value='" + data.list[i].SN + "' />";
							tr += "<input type='hidden' id='hInvntryManageCode" + i + "' value='" + data.list[i].INVNTRYMANAGE_CODE + "' />";
							tr += "<input type='hidden' id='hRtunNo" + i + "' value='" + data.list[i].RTUN_NO + "' />";
							tr += "<input type='hidden' id='hRtunManId" + i + "' value='" + data.list[i].RTUNMAN_ID + "' />";
							tr += "</td>";
							tr += "<td><label id='lblIpCode" + i + "'>" + data.list[i].IP_CODE + "</label></td>";
							tr += "<td><label id='lblIpAsignDate" + i + "'>" + data.list[i].IPASIGN_DE + "</label></td>";
							tr += "<td><input type='text' id='txtCnt" + i + "' class='wd100Pct' value='" + data.list[i].RTUN_QTT.trim() + "' able /></td>";
							tr += "<td><div class='dateBox'><input type='text' id='txtDispenseDate" + i + "' value='' able /></div></td>";
							tr += "<td><textarea id='txtDispenseMemo" + i + "' row='3' class='wd100Pct' able>" + data.list[i].RTUN_COMMENT + "</textarea></td>";
							tr += "<td>";
							tr += "<input type='button' id='btnDispenseQuery" + i + "' value='Q' />";
							tr += "</td>";
							tr += "</tr>"
							tr += "<tr id='trDispenseQuery_" + data.list[i].IP_CODE + "' style='display:none;'>";
							tr += "<td colspan='7'>";
							tr += "<table class='tbl_query' style='width:100%;' id='tbl_query'><colgroup><col width='65px' /><col width='' /></colgroup>";
							tr += "</table>";
							tr += "</td>";
							tr += "</tr>";
							$("#tbodyDispense").append(tr);
							mkSetDatePickerYYMMDD("#txtDispenseDate" + i);
							$("#txtDispenseDate" + i).val(data.list[i].RTUN_DT);
							
							tr = "<tr>";
							tr += "<td>";
							tr += "<label id='lblIpType" + i + "'>" + data.list[i].IP_TYPE + "</label>";
							tr += "<input type='hidden' id='hDlvyManageCode" + i + "' value='" + data.list[i].DLVYMANAGE_CODE + "' />";
							tr += "<input type='hidden' id='hSn" + i + "' value='" + data.list[i].SN + "' />";
							tr += "<input type='hidden' id='hInvntryManageCode" + i + "' value='" + data.list[i].INVNTRYMANAGE_CODE + "' />";
							tr += "<input type='hidden' id='hRtunNo" + i + "' value='" + data.list[i].RTUN_NO + "' />";
							tr += "<input type='hidden' id='hRtnpsnId" + i + "' value='" + data.list[i].RTNPSN_ID + "' />";
							tr += "</td>";
							tr += "<td><label id='lblIpCode" + i + "'>" + data.list[i].IP_CODE + "</label></td>";
							tr += "<td><label id='lblIpAsignDate" + i + "'>" + data.list[i].IPASIGN_DE + "</label></td>";
							tr += "<td><input type='text' id='txtTaking" + i + "' class='wd100Pct' value='" + data.list[i].TAKNG_QTT.trim() + "' able /></td>";
							tr += "<td><input type='text' id='txtNonTaking" + i + "' class='wd100Pct' value='" + data.list[i].RTURN_QTT.trim() + "' able /></td>";
							tr += "<td><div class='dateBox'><input type='text' id='txtReturnDate" + i + "'value='' able /></div></td>";
							tr += "<td><textarea id='txtReturnMemo" + i + "' row='3' class='wd100Pct' able>" + data.list[i].RTURN_COMMENT + "</textarea></td>";
							tr += "<td>";
							tr += "<input type='button' id='btnReturnQuery" + i + "' value='Q' />";
							tr += "</td>";
							tr += "</tr>"
							tr += "<tr id='trReturnQuery_" + data.list[i].IP_CODE + "' style='display:none;'>";
							tr += "<td colspan='8'>";
							tr += "<table class='tbl_query' style='width:100%;' id='tbl_query'><colgroup><col width='65px' /><col width='' /></colgroup>";
							tr += "</table>";
							tr += "</td>";
							tr += "</tr>";
							$("#tbodyReturn").append(tr);
							mkSetDatePickerYYMMDD("#txtReturnDate" + i);
							$("#txtReturnDate" + i).val(data.list[i].RTURN_DT);
						}

						var query = data.queryList;
						var query_group = null;
						for(var i = 0; i < data.queryList.length; i++){
							if(query[i].QUERY_STTUS_CODE == "01" || query[i].QUERY_STTUS_CODE == "02"){
								if (query[i].QUERY_CN && query[i].QUERY_CN != "") {
									var tr_query = null;
									if(query[i].DLVY_SE_CODE == "01"){
										tr_query = $("#tbodyDispense tr[id=trDispenseQuery_" + query[i].IP_CODE + "]");
									}else{
										tr_query = $("#tbodyReturn tr[id=trReturnQuery_" + query[i].IP_CODE + "]");
									}
									tr_query.show();
									var msg = msg = query[i].RESN;
									var border = "";
									if (query[i].QUERY_STTUS_CODE == "01") {
										msg = query[i].QUERY_CN;
									}
									var color = "color:red;";
									var rowspan = 1;
									if (query[i].STATUS == "ANSWER") {
										color = "color:#facc2e;";
										rowspan = 2;
									}
									var str = "";
									str = "<tr onclick='popupQueryOpen(\"" + query[i].QUERY_GROUP + "\", \"" + query[i].QUERY_CN +  "\", \"" + query[i].RTUN_NO + "\", \"" + query[i].DLVY_SE_CODE + "\", \"" + query[i].QUERY_SE_CODE + "\")'>";
									
									if (query_group == null || query_group != query[i].QUERY_GROUP) {
										if (i != 0) {
											border = "border-top:1px solid #cccccc !important;";
										}
										//str = "<tr style='" + border + "' onclick='popupQueryOpen(\"" + rowItems[i].SET_ROW_SN + "\" , \"" + rowItems[i].VRIABL_ROW_SN + "\", \"END\" ," + rowItems[i].QUERY_SN + ")'>";
										str += "<td class='crf_query_status' style='" + border + color + "' >" + query[i].QUERY_STTUS_NM + "</td>";
										str += "<td style='" + border + "'><pre id='pre_query' style='" + color + " white-space:pre-wrap;'>" + msg + "</pre></td>";
										str += "<td style='" + border + color + "white-space: nowrap;width : 50px;' rowspan='" + rowspan + "'>" + query[i].QUERY_TY_NM + "</td>";
									} else {
										str += "<td class='crf_query_status' style='" + border + color + "' >" + query[i].QUERY_STTUS_NM + "</td>";
										str += "<td style='" + border + "'><pre id='pre_query' style='" + color + "white-space:pre-wrap;'>" + msg + "</pre></td>";
										if (query[i].STATUS != "ANSWER") {
											str += "<td style='" + border + color + "white-space: nowrap;width : 50px;' rowspan='" + rowspan + "'>" + query[i].QUERY_TY_NM + "</td>";
										}
									}
									str += "</tr>";
									tr_query.find("[id=tbl_query]").append(str);
									query_group = query[i].QUERY_GROUP;
								}
							}
						}
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
			
			
			$("#tbodyDispense > tr").each(function(){
				$(this).find("input[id^=btnDispenseQuery]").click(function(){
					rtun_no_query = $(this).parent().parent().find("input[id^=hRtunNo]").val();
					dlvy_se_code = "01";
					rcverId = $(this).parent().parent().find("input[id^=hRtunManId]").val();
					var param = {
							callbackFunction : "insertQuery",
							queryItemType : "IWRS012"
					};
					
					mkLayerPopupOpen("/iwrs/e01/popupIwre0107.do", param);
				});
			});
			
			$("#tbodyReturn > tr").each(function(){				
				$(this).find("input[id^=btnReturnQuery]").click(function(){
					rtun_no_query = $(this).parent().parent().find("input[id^=hRtunNo]").val();
					dlvy_se_code = "02";
					rcverId = $(this).parent().parent().find("input[id^=hRtnpsnId]").val();
					var param = {
							callbackFunction : "insertQuery",
							queryItemType : "IWRS013"
					};
					
					mkLayerPopupOpen("/iwrs/e01/popupIwre0107.do", param);
				});
			});
			mkDisabled();
			$(".ui-datepicker-trigger").hide();
		}
		
		function buttonActive(){
			$("#btnSave").click(function(){
				checkRegister();
			});
		}
		
		function checkRegister(){
			var param = {
					callbackFunction : "saveConfirmInfo"
			};
			
			mkLayerPopupOpen("/iwrs/b01/popupIwrb0102.do", param);
		}
		
		function saveConfirmInfo(userId){
			var params = [];
			$("#tbodyDispense > tr").each(function(){
				var param = {
						RTUN_NO : $("input[id^=hRtunNo]").val(),
						SUBJECT_CODE : $('#spanSubject').text(),
						VISIT_CODE : $("#hVisitCode").val(),
						IP_CODE : $(this).find("label[id^=lblIpCode]").text(),
						DLVYMANAGE_CODE : $(this).find("input[id^=hDlvyManageCode]").val(),
						SN : $(this).find("input[id^=hSn]").val(),
						INVNTRYMANAGE_CODE : $(this).find("input[id^=hInvntryManageCode]").val(),
						USER_ID : userId,
						RTUN_RTURN_CNFRMR_ID : userId
				}
				params.push(param);
			});
			
			$.ajax({
				type : "POST",
				async : false,
				data : {data : JSON.stringify(params) },
				url : '/iwrs/e01/updateConfirmInfo.do',
				success :function(data){
					if(data.result){
						alert(data.message);
						init();
						initPage();
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
		
		var rtun_no_query = "";
		var dlvy_se_code = "";
		var rcverId = "";
		
		function showQueryPopup(rtun_no){
			var param = {
					callbackFunction : "insertQuery"
			};
			
			mkLayerPopupOpen("/iwrs/e01/popupIwre0107.do", param);
		}
		
		function insertQuery(value){
			var param = {
					RTUN_NO : rtun_no_query,
					DLVY_SE_CODE : dlvy_se_code,
					QUERY_SE_CODE : value.QUERY_SE_CODE,
					MODULE_CODE : 'IWR',
					QUERY_TY_CODE : '02',
					QUERY_STTUS_CODE : '01',
					QUERY_CN : value.QUERY_CN,
					RESN : "Manual Query Issue",
					END_AT : 'N',
					USE_AT : 'Y'
			}
// 			console.log(param);
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : '/iwrs/e01/insertQuery.do',
				success :function(data){
					if(data.result){
						alert(data.message);
						init();
						initPage();
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
		
		function popupQueryOpen(query_group, query_cn, rtun_no, dlvy_se_code, query_se_code){
			var param = {
				QUERY_GROUP : query_group, 
				QUERY_CN : query_cn,
				RTUN_NO : rtun_no,
				DLVY_SE_CODE : dlvy_se_code,
				QUERY_SE_CODE : query_se_code,
				callbackFunction : "endQuery"	
			};
			mkLayerPopupOpen("/iwrs/e01/popupIwre0109.do", param);
		}
		
		function endQuery(value){
			var param = {
					RTUN_NO : value.RTUN_NO,
					DLVY_SE_CODE : value.DLVY_SE_CODE,
					QUERY_SE_CODE : value.QUERY_SE_CODE,
					MODULE_CODE : 'IWR',
					QUERY_TY_CODE : '02',
					QUERY_STTUS_CODE : '03',
					QUERY_CN : value.QUERY_CN,
					RESN : value.RESN,
					QUERY_GROUP : value.QUERY_GROUP,
					QUERY_END_TYPE : value.QUERY_END_TYPE,
					END_AT : 'Y',
					USE_AT : 'Y'
			}
			console.log(param);
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : '/iwrs/e01/insertEndQueryInfo.do',
				success :function(data){
					if(data.result){
						alert(data.message);
						init();
						initPage();
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
		
		function init(){
			$('#spanSubject').text("");
			$('#spanVisit').text("");
			$("#hVisitCode").val("");
			$("#tbodyDispense > tr").remove();
			$("#tbodyReturn > tr").remove();
		}
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRE0103&UPPER_MENU_ID=IWRE" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRE0103&UPPER_MENU_ID=IWRE" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>${progrmMap.UPPER_MENU_NM}</li>
	                        <li>${progrmMap.MENU_NM}</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="conTitBox">
							<h5>불출/반납 확인</h5>
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnSave" value="확인" />
						</article>
						<article class="mgT10">
							<span style="font-family:'NanumGothicBold';">피험자 : </span>
							<span id="spanSubject" style="font-family:'NanumGothicBold';"></span>
						</article>
						<article>
							<span style="font-family:'NanumGothicBold';">방문 : </span>
							<span id="spanVisit" style="font-family:'NanumGothicBold';"></span>
							<input type="hidden" id="hVisitCode" value="" />
						</article>
						<article class="mgT16">
							<table class="tb001">
								<colgroup>
									<col width="10%" />
									<col width="10%" />
									<col width="15%" />
									<col width="10%" />
									<col width="15%" />
									<col width="30%" />
									<col width="10%" />									
								</colgroup>
								<thead>
									<tr>
										<th>IP Type</th>
										<th>IP코드</th>
										<th>IP배정일</th>
										<th>수량</th>
										<th>불출일</th>
										<th>메모</th>
										<th>쿼리</th>
									</tr>
								</thead>
								<tbody id="tbodyDispense">
								</tbody>
							</table>
						</article>
						<article class="mgT16">
							<table class="tb001">
								<colgroup>
									<col width="8%" />
									<col width="8%" />
									<col width="15%" />
									<col width="8%" />
									<col width="8%" />
									<col width="15%" />
									<col width="30%" />
									<col width="*" />									
								</colgroup>
								<thead>
									<tr>
										<th>IP Type</th>
										<th>IP코드</th>
										<th>IP배정일</th>
										<th>복용</th>
										<th>미복용</th>
										<th>반납일</th>
										<th>메모</th>
										<th>쿼리</th>
									</tr>
								</thead>
								<tbody id="tbodyReturn">
								</tbody>
							</table>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>