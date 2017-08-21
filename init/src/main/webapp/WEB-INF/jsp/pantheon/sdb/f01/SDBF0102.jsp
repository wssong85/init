<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
		
	<script type="text/javascript">
	var gridCase = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grCase',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grCase',
		 		paging: {
		 			pagingDiv: 'grid_paging',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/f01/selectProductCaseInfo.do',
		 		param: { PRDUCT_CODE : "${PRDUCT_CODE}", QC_REPRT_NO : "${QC_REPRT_NO}"},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': true,
				'showRowNumColumn' : true,
				'showRowCheckColumn' : true,
				softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "ABOVECASE_CODE",
								headerText : "이상사례 코드"
							}, {
								dataField : "PRTCL_NO",
								headerText : "프로토콜 번호"
							}, {
								dataField : "INSTT_NO",
								headerText : "기관 번호"
							}, {
								dataField : "TESTEE_NO",
								headerText : "피험자 번호"
							}, {
								dataField : "DEATH_AT",
								headerText : "사망여부"
							}, {
								dataField : "FRST_CREDE",
								headerText : "등록일",
								formatString : "yyyy-mm-dd",
						 		dataType:"date"
							}, {
								dataField : "SN",
								headerText : "SN",
								visible : false
							} 
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 		
		 		//autoLoad로 처음 화면 데이터 로딩 
		 		if(me.proxy.paging && !v1 && !v2) {
		 			me.proxy.param.page = me.div.paging.currentPage;		
		 			me.proxy.param.count= me.div.paging.rowCount;		
		 		}
		 		
		 		//moveToPage 로 데이터 요청
		 		if(v1 && v2) {
		 			me.proxy.param.page = v2;	
		 			me.div.paging.currentPage = v2;
		 			me.proxy.param.count = v1;		
		 			me.div.paging.rowCount = v1;		
		 		}
		 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result == "true") {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 			    	
		 			    	//샘플때문에 페이징 나타나게 하기위해 임의의 값 넣어줌 
//		  			    	data.count = 13;
//		  			    	console.log(data.count);
		 			    	//paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
		 			    	if(data.count && me.proxy.paging) {
		 			    		
		 			    		me.div.paging.totalRowCount = data.count;
		 			    		me.createPagingNavigator(me.div.paging.currentPage);
		 			    	}
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	},
		 	//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		 	createPagingNavigator: function(goPage) {
		 		var me = this;
		 
		 		if(!me.div.paging.pagingDiv) { 
		 			return;
		 		}
		 		
		 		me.div.paging.totalPage = Math.ceil(me.div.paging.totalRowCount/me.div.paging.rowCount);
		 		
		 		var retStr = "";
		 		var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * me.div.paging.pageButtonCount;
		 		var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount + 1;
		 
		 		prevPage = Math.max(0, prevPage);
		 		nextPage = Math.min(nextPage, me.div.paging.totalPage);
		 		
		 		//셀렉트박스
		 		retStr += "<select style='float:left;' onchange='javascript:gridDelivery.moveToPage(gridDelivery.div.paging.currentPage, this.value)'>"
		 		if(gridDelivery.div.paging.rowCount == 20) {
		 			retStr += "<option value=20 selected=true>20</option>"
		 		} else {
		 			retStr += "<option value=20>20</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 50) {
		 			retStr += "<option value=50 selected=true>50</option>"
		 		} else {
		 			retStr += "<option value=50>50</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 100) {
		 			retStr += "<option value=100 selected=true>100</option>"
		 		} else {
		 			retStr += "<option value=100>100</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 300) {
		 			retStr += "<option value=300 selected=true>300</option>"
		 		} else {
		 			retStr += "<option value=300>300</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 500) {
		 			retStr += "<option value=500 selected=true>500</option>"
		 		} else {
		 			retStr += "<option value=500>500</option>"
		 		}
		 		retStr += "</select>"
		 				 
		 		$(".aui-grid-paging-panel").append(retStr);
		 		//document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
		 	}
		};
	
		$(function(){
			initPageSetting();
			buttonActive();
			selectCapaListInfo();
		});
		
		function initPageSetting(){
			mkSetDatePickerYYMMDD("#txtQcDate");
			mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -60);
			
			$("#txtQcDate, #txtStartDate, #txtEndDate").mkNumberHyphen();
			
			gridCase.createGrid();
						
			var cn = "";
			var selectTag = "<option value=''>==SELECT==</option><option value='Y'>Yes</option><option value='N'>No</option><option value='NA'>NA</option>";
			<c:forEach var="result" items="${soplist}" varStatus="status">
				var naCheck = "<input type='checkbox' id='chkNa_${result.GROUP_SN}' able onChange='processNA(\"chkNa_${result.GROUP_SN}\", \"${result.GROUP_SN}\");' /> <label for='chkNa_${result.GROUP_SN}'  class='chcLab' style='margin-left:20px; position:relative; top:4px; font-family:NanumGothic;'><span>NA</span></label>";
				
				cn = "";
				
				if("${result.GROUP_TYPE}" == "1"){
					cn = "<tr><th style='text-align:center; padding-left:4px;'>${result.QESTN_SN}</th><th><span style='position:relative; top:-4px;'>${result.QESTN_CN}" + naCheck + "</span></th><th>Yes / No / NA</th></tr>";
				}else{
					cn = "<tr><td style='text-align:center; padding-left:4px;'>${result.QESTN_SN}</td><td style='line-height:16px; padding:5px 4px 5px 12px;'>${result.QESTN_CN}</td><td style='padding:5px 4px;'><select style='width:100%;' id='sltCheck_${result.GROUP_SN}_${result.QESTN_SN}' able valireqire='${result.GROUP_SN}_${result.QESTN_SN}'>" + selectTag + "</select></td></tr>";
					cn += "<tr id='tr${result.GROUP_SN}_${result.QESTN_SN}'><th colspan='3'>Comment</th></tr>";
					cn += "<tr id='tr${result.GROUP_SN}_${result.QESTN_SN}'><td colspan='3'><textarea id='txtComment_${result.GROUP_SN}_${result.QESTN_SN}' style='width:100%;' able valireqire1='${result.GROUP_SN}_${result.QESTN_SN}_코멘트'>${result.MEMO}</textarea></td></tr>";
				}
				$("#tbodySopList").append(cn);
				cn = "";
				
				if("${result.GROUP_TYPE}" == "1"){
					if("${result.IEM_CECK_AT}" == "Y"){
						$("#chkNa_${result.GROUP_SN}").attr("checked", true);
					}else{
						$("#chkNa_${result.GROUP_SN}").attr("checked", false);
					}
				}
				if("${result.GROUP_TYPE}" == "2"){
					$("#sltCheck_${result.GROUP_SN}_${result.QESTN_SN}").val("${result.RESULT_CODE}").attr("selected", true);
					if("${result.RESULT_CODE}" != "N"){
						$("[id^=tr${result.GROUP_SN}_${result.QESTN_SN}]").hide();	
					}
				}
				
				$("#sltCheck_${result.GROUP_SN}_${result.QESTN_SN}").change(function(){
					if($("#" + $(this).attr("id") + " option:selected").val() == "N"){
						$("[id^=tr" + $(this).attr("id").replace("sltCheck_", "") + "]").show();
						$("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).attr("valireqire", $("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).attr("valireqire1"));
						$("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).removeAttr("valireqire1");
					}else{
						$("[id^=tr" + $(this).attr("id").replace("sltCheck_", "") + "]").hide();
						$("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).val("");
						$("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).attr("valireqire1", $("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).attr("valireqire"));
						$("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).removeAttr("valireqire");
					}
					
					calcResultRate();
				});
			</c:forEach>
			
			processNA();

			if("${qcreport}" != null && "${qcreport}" != ""){
				$("#hQcReportNo").val("${qcreport.QC_REPRT_NO}");
				$("#txtSafetyDeptUserId").val("${qcreport.SAFE_MANAGE_CHARGER_NM}");
				$("#hSafetyDeptUserId").val("${qcreport.SAFE_MANAGE_CHRGDEPT_CHARGER}");
				$("#txtProductCode").val("${qcreport.PRDUCT_CODE_NM}");
				$("#hdProductCode").val("${qcreport.PRDUCT_CODE}");
				$("#txtStartDate").val("${qcreport.PD_BGNDE}");
				$("#txtEndDate").val("${qcreport.PD_LASTDE}");
				$("#lblQcUserName").text("${qcreport.QLMNGMT_CHARGER_NM}");
				$("#hQcUserId").val("${qcreport.QLMNGMT_CHARGER}");
				$("#txtQcDate").val("${qcreport.QLMNGMT_OPRTNDE}");
				$("#lblQcUser").text("${qcreport.QLMNGMT_CHARGER_NM}");
				$("#lblQcDate").text("${qcreport.QLMNGMT_OPRTNDE}");
				$("#lblSafeUser").text("${qcreport.SFMNGCHRG_DPRLR_NM}");
				$("#lblSafeDate").text("${qcreport.SFMNGCHRG_DPRLR_SANCTNDE}");
				$("#txtResultComment").text("${qcreport.SFMNGCHRG_DPRLR_MEMO}");
				$("#btnProductPopup").hide();
				$("#btnSafetyUserPopup").hide();
				
				if("${TYPE}" == "2"){					
					mkDisabled();
					$("#btnAdd").hide();
					$("#btnDel").hide();
					$("#btnInit").hide();
					$("#btnSave").hide();
					$(".ui-datepicker-trigger").hide();
				}else if("${TYPE}" == "3"){
					mkDisabled();
					$("#btnAdd").hide();
					$("#btnDel").hide();
					$("#btnInit").hide();
					$("#btnSave").val("승인");
					$(".ui-datepicker-trigger").hide();
				}else if("${TYPE}" == "4"){
					mkDisabled();
					$("#btnAdd").hide();
					$("#btnDel").hide();
					$("#btnInit").hide();
					$("#btnSave").hide();
					$(".ui-datepicker-trigger").hide();
				}
			}
			
			calcResultRate();
		}
		
		function calcResultRate(){
			var totalSize = 0;
			var noSize = 0;
			var yesSize = 0;
			$("[id^=sltCheck_]").each(function(){
				if($("#" + $(this).attr("id") + " option:selected").val() == "" || 
					$("#" + $(this).attr("id") + " option:selected").val() == "Y" ||
					$("#" + $(this).attr("id") + " option:selected").val() == "N"){
					totalSize++;
				}
				
				if($("#" + $(this).attr("id") + " option:selected").val() == "" ||
					$("#" + $(this).attr("id") + " option:selected").val() == "N"){
					noSize++;
				}
				
				if($("#" + $(this).attr("id") + " option:selected").val() == "Y"){
					yesSize++;
				}
			});
			
			$("#lblTotal").text(totalSize);
			$("#lblNo").text(noSize);
			$("#lblRate").text((yesSize/totalSize*100).toFixed(2));
		}
		
		function buttonActive(){
			$("#btnInit").click(function(){
				initPage();
			});
			
			$("#btnSave").click(function(){
				var check = true;
				if(!mkValidation()){
					return;
				}
				$("[id^=lblVioltiem_]").each(function(idx, value){
					if(!$("input[name=" + $(this).attr("id").replace("lblVioltiem_", "") + "]:checked").val()){
						alert("해결유무를 선택하십시오.");
						check = false;
						return false;
					}
					if($("input[name=" + $(this).attr("id").replace("lblVioltiem_", "") + "]:checked").val() == "N" 
							&& !$("#txtUnsolvResn_" + $(this).attr("id").replace("lblVioltiem_", "")).val()){
						alert("미해결사유를 입력하십시오.");
						$("#txtUnsolvResn_" + $(this).attr("id").replace("lblVioltiem_", "")).focus();
						check = false;
						return false;
					}
				});
				
				if(!check) return;
				
				if("${TYPE}" == "3"){
					var param = {
							callbackFunction : "approvalDocument"
					}
					mkLayerPopupOpen("/iwrs/b01/popupIwrb0102.do", param);
				}else{
					var param = {
							callbackFunction : "saveResultInfo"
					}
					mkLayerPopupOpen("/iwrs/b01/popupIwrb0102.do", param);
				}
			});
			
			$("#btnSetting").click(function(){
				goPageSetting();
			});
			
			$("#btnPdf").click(function(){
				
			});
			
			$("#btnProductPopup").click(function(){
				mkLayerPopupOpen("/sdb/b02/popupSDBB0204.do", null);
				if (typeof grProductList_Search.id !== "undefined") {
					AUIGrid.resize(grProductList_Search.id);
				}
// 				$("#hdProductCode").val("P2016_1111");
// 				$("#txtProductCode").val("테스트");
			});
			
			$('#txtProductCode').change(function(){
				selectCapaListInfo();
			});
			
			$("#btnSafetyUserPopup").click(function(){
				var param = {
						callbackFunction : "setUserInfo"
				}
				mkLayerPopupOpen("/sdb/f01/popupSdbf0104.do", param);
			});
			
			$("#btnAdd").click(function(){
				if(!$("#hdProductCode").val()){
					alert("품목명을 입력하십시오.");
					return;
				}
				var param = {
						callbackFunction : "setCaseInfo",
						PRDUCT_CODE : $("#hdProductCode").val()
				}
				
				mkLayerPopupOpen("/sdb/f01/popupSdbf0105.do", param);
			});
			
			$("#btnDel").click(function(){
				if(!confirm("정말 삭제하시겠습니까?")){
					return;
				}
				var deletedRowItems = AUIGrid.getCheckedRowItems(gridCase.id);
				if(deletedRowItems.length <= 0){
					alert("삭제할 행을 선택하십시오.");
					return;
				}
				AUIGrid.removeCheckedRows(gridCase.id);
			});
		}
		
		function processNA(id, idx){
			if(id != undefined){
				if($(":checkbox[id=" + id + "]").is(":checked")){
					$("[id^=sltCheck_" + idx + "]").prop("disabled", true);
					$("[id^=sltCheck_" + idx + "]").val("NA").attr("selected", "selected");
					$("[id^=txtComment_" + idx + "]").val("");
					$("[id^=tr" + idx + "]").hide();
				}else{
					$("[id^=sltCheck_" + idx + "]").prop("disabled", false);
					$("[id^=sltCheck_" + idx + "]").val("").attr("selected", "selected");
				}
			}else{
				$("[id^=chkNa_]").each(function(){
					if($(":checkbox[id=" + $(this).attr("id") + "]").is(":checked")){
						$("[id^=sltCheck_" + $(this).attr("id").replace("chkNa_", "") + "]").prop("disabled", true);
						$("[id^=txtComment_" + $(this).attr("id").replace("chkNa_", "") + "]").prop("disabled", true);
					}else{
						$("[id^=sltCheck_" + $(this).attr("id").replace("chkNa_", "") + "]").prop("disabled", false);
						$("[id^=txtComment_" + $(this).attr("id").replace("chkNa_", "") + "]").prop("disabled", false);
					}
				});
			}
			calcResultRate();	
		}
		
		function saveResultInfo(user_id){
			var group = [];
			var check = [];
			var delItem = [];
			var capa = [];
						
			$("[id^=chkNa_]").each(function(idx, value){
				var groupItem = new Object();
				groupItem.IEM_CODE = $(this).attr("id").replace("chkNa_", "");
				if($("#" + $(this).attr("id") + ":checked").val()){
					groupItem.IEM_CECK_AT = "Y";
				}else{
					groupItem.IEM_CECK_AT = "N";
				}
				
				group.push(groupItem);
			});

			$("[id^=sltCheck_]").each(function(idx, value){
				var checkItem = new Object();
				var item = $(this).attr("id").split("_");
				checkItem.IEM_CODE = item[2];
				checkItem.UPPER_IEM_CODE = item[1];
				checkItem.RESULT_CODE = $("#" + $(this).attr("id") + " option:selected").val();
				checkItem.MEMO = $("#txtComment_" + $(this).attr("id").replace("sltCheck_", "")).val();
 
				check.push(checkItem);
			});
			
			$("[id^=lblVioltiem_]").each(function(idx, value){
				if(!$("input[name=" + $(this).attr("id").replace("lblVioltiem_", "") + "]:checked").val()){
					alert("해결유무를 선택하십시오.");
					return;
				}
				var capaItem = new Object();
				capaItem.VIOLTIEM = $(this).text();
				capaItem.VIOLTCN = $("#txtVioltcn_" + $(this).attr("id").replace("lblVioltiem_", "")).val();
				capaItem.SOLUTENNC = $("input[name=" + $(this).attr("id").replace("lblVioltiem_", "") + "]:checked").val();
				capaItem.UNSOLV_RESN = $("#txtUnsolvResn_" + $(this).attr("id").replace("lblVioltiem_", "")).val();
				capaItem.RM = $("#txtRm_" + $(this).attr("id").replace("lblVioltiem_", "")).val();
				capaItem.FLLWMANAGT_SN = $("#hFllwManagtSn_" + $(this).attr("id").replace("lblVioltiem_", "")).val() ;
				
				capa.push(capaItem);
			});
// 						console.log(capa);
			var caseItem = AUIGrid.getAddedRowItems(gridCase.id);
			var delItem = AUIGrid.getRemovedItems(gridCase.id);
			
			var param = [{
				QC_REPRT_NO : $("#hQcReportNo").val(),
				PRDUCT_CODE : $("#hdProductCode").val(),
				SAFE_MANAGE_CHRGDEPT_CHARGER : $("#hSafetyDeptUserId").val(),
				QLMNGMT_OPRTNDE : $("#txtQcDate").val().replace(/-/g, ""),
				QLMNGMT_CHARGER : $("#hQcUserId").val(),
				PD_BGNDE : $("#txtStartDate").val().replace(/-/g, ""),
				PD_LASTDE : $("#txtEndDate").val().replace(/-/g, ""),
				TOT_IEM_CO : $("#lblTotal").text(),
				VIOLT_IEM_CO : $("#lblNo").text(),
				SFMNGCHRG_DPRLR_MEMO : $("#txtResultComment").val(),
				USER_ID : user_id,
				SETLELN_CODE : "1",
				GROUP : group,
				CHECK : check,
				CASE : caseItem,
				DELCASE : delItem,
				CAPA : capa
			}];
			console.log(param);
			$.ajax({
				type : "POST",
				async : false,
				data : {data : JSON.stringify(param) },
				url : "/sdb/f01/insertQcResultReportInfo.do",
				success :function(data){
					if(data.result == "true"){
						alert(data.message);
						
						var f = document.createElement("form"); 
						
						f.setAttribute("method", "post");
						f.setAttribute("action", "/sdb/f01/SDBF0101.do");
						document.body.appendChild(f);
						f.submit();
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		function initPage(){
			$("#txtProductCode").val("");
			$("#hdProductCode").val("");
			$("#hQcReportNo").val("");
			$("#txtSafetyDeptUserId").val("");
			$("#hSafetyDeptUserId").val("");
			mkSetDatePickerYYMMDD("#txtQcDate");
			mkSetDatePickerYYMMDD("#txtStartDate", "#txtEndDate", -60);
			AUIGrid.destroy(gridCase.id);
			gridCase.createGrid();
			$("#tbodyCapaList").each()
			$("#tbodyCapaList > tr").each(function(idx, value){
				if(idx != 0){
					this.remove();
				}
			});
			
			$("[id^=sltCheck_]").val("").attr("selected", "selected").attr("disabled", false);
			$("[id^=txtComment_]").val("").attr("disabled", false);
			$("[id^=chkNa_]").attr("checked", false);
		}
		
		function goPageSetting(){
			var f = document.createElement("form");
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/sdb/f09/SDBF0901.do");
			document.body.appendChild(f);
			f.submit();
		}
		
		function setUserInfo(rowItem){
			$('#txtSafetyDeptUserId').val(rowItem.USER_NM);
			$("#hSafetyDeptUserId").val(rowItem.USER_ID);
			selectCapaListInfo();
		}
		
		function setCaseInfo(checkedItems){
			for(i = 0; i <checkedItems.length; i++){
				var rowObj = checkedItems[i];
				var rowItem = rowObj.item;
				
				if(!AUIGrid.isUniqueValue(gridCase.id, "ABOVECASE_CODE", rowItem.HRMFLNS_CASE_CODE)){
					alert("이미 등록된 이상반응 코드입니다.");
					continue;
				}
				
				var row = {
						'ABOVECASE_CODE': rowItem.HRMFLNS_CASE_CODE,
						'PRTCL_NO': rowItem.PRTCL_NO,
						'INSTT_NO': rowItem.INSTT_NO,
						'TESTEE_NO' : rowItem.TESTEE_NO,
						'DEATH_AT' : rowItem.DEATH_AT,
						'FRST_CREDE' : rowItem.FRST_CREDE
				};
				AUIGrid.addRow(gridCase.id, row, 'last'); // 최하단에 행 추가
			}
		}
		
		function approvalDocument(user_id){
			var param = {
				QC_REPRT_NO : $("#hQcReportNo").val(),
				PRDUCT_CODE : $("#hdProductCode").val(),
				SFMNGCHRG_DPRLR : user_id,
				USER_ID : user_id
			};
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : "/sdb/f01/updateApprovalCaseInfo.do",
				success :function(data){
					if(data.result == "true"){
						alert(data.message);
						
						var f = document.createElement("form"); 
						
						f.setAttribute("method", "post");
						f.setAttribute("action", "/sdb/f01/SDBF0101.do");
						document.body.appendChild(f);
						f.submit();
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		function selectCapaListInfo(){
			var param = {
				QC_REPRT_NO : $("#hQcReportNo").val(),
				PRDUCT_CODE : $("#hdProductCode").val(),
				SAFE_MANAGE_CHRGDEPT_CHARGER : $("#hSafetyDeptUserId").val()
			};
			
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : "/sdb/f01/selectCapaListInfo.do",
				success :function(data){
					if(data.result == "true"){
						createCapaList(data.list);
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		function createCapaList(list){
			for(var i = 0; i < list.length; i++){
				var capa = "<tr>";
				capa += "<td><label id='lblVioltiem_" + list[i].VIOLTIEM + "'>" + list[i].VIOLTIEM.trim() + "</label></td>";
				capa += "<td style='padding:10px; padding-bottom: 2px;'><textarea id='txtVioltcn_" + list[i].VIOLTIEM + "' rows='2' style='width:100%;' disabled='disabled'>" + list[i].VIOLTCN +"</textarea></td>";
				capa += "<td style='text-align:center; padding-left:4px;'><input type='radio' id='rdoYes_" + list[i].VIOLTIEM + "' name='" + list[i].VIOLTIEM + "' value='Y' /><label for='rdoYes_" + list[i].VIOLTIEM + "' class='raLab'><span>Yes</span></label>";
				capa += " <input type='radio' id='rdoNo_" + list[i].VIOLTIEM + "'  name='" + list[i].VIOLTIEM + "' value='N' /><label for='rdoNo_" + list[i].VIOLTIEM + "' class='raLab'><span>No</span></label></td>";
				capa += "<td style='padding:10px; padding-bottom: 2px;'><textarea id='txtUnsolvResn_" + list[i].VIOLTIEM + "' rows='2' style='width:100%;' disabled='disabled'>" + list[i].UNSOLV_RESN.trim() +"</textarea></td>";
				capa += "<td style='padding:10px; padding-bottom: 2px;'><textarea id='txtRm_" + list[i].VIOLTIEM + "' rows='2' style='width:100%;'>" + list[i].RM.trim() +"</textarea>";
				capa += "<input type='hidden' id='hFllwManagtSn_"+ list[i].VIOLTIEM + "' value='" + list[i].FLLWMANAGT_SN + "' />";
				capa += "</td>";
				capa += "</tr>";

				
				
				$("#tbodyCapaList").append(capa);

				$("input[name=" + list[i].VIOLTIEM + "]").change(function(){
					var value = $(this).val();
					if(value == "Y"){
						$("#txtUnsolvResn_" + $(this).attr("name")).attr("disabled", true);
						$("#txtUnsolvResn_" + $(this).attr("name")).val("");
					}else if(value == "N"){
						$("#txtUnsolvResn_" + $(this).attr("name")).attr("disabled", false);
						$("#txtUnsolvResn_" + $(this).attr("name")).val("");
					}
				});
				$(":radio[name=" + list[i].VIOLTIEM + "][value=" + list[i].SOLUTENNC + "]").attr("checked" , true);
				if(list[i].SOLUTENNC == "Y"){
					$("#txtUnsolvResn_" + list[i].VIOLTIEM).attr("disabled", true);
				}else{
					$("#txtUnsolvResn_" + list[i].VIOLTIEM).attr("disabled", false);
				}  
			}
		}
		
		$(window).resize(function(){
			if(gridCase.id){
				AUIGrid.resize(gridCase.id);
			}
		});
		
		
		
	</script>
</head>
<body>
<div id="wrap">
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBF0102&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBF0102&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>	
	<section id="mainCon">
	<div class="mainConInner">
		<article class="mainTitBox">
			<h3>QC결과보고서 LIST</h3>
			<nav id="pathNav">
				<ul>
					<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
					<li>SYSTEM MASTER FILE</li>
					<li>QC결과보고서 LIST</li>
				</ul>
			</nav>
		</article>
	
	
		<section class="conBox100 conBox">
			<div class="conBoxInner">

                <article class="conTitBox">
                    <h5>QC결과보고서</h5>
                </article>

				<article class="conTitBtnR">
					<input type="button" id="btnInit" value="초기화" />
					<input type="button" id="btnSave" value="저장" />
					<input type="button" id="btnSetting" value="설정" />
					<input type="button" id="btnPdf" value="출력" />
				</article>
				
				<article class="mgT16">
					<div>
						<table class="tb001">
							<colgroup>
								<col style="width:20%" />
								<col style="width:30%" />
								<col style="width:18%" />
								<col style="" />
							</colgroup>
							<tbody>
								<tr>
									<th>품목명 Name of Product</th>
									<td colspan="3">
										<input type="text" id="txtProductCode" disabled="disabled" style="width:50%;" />
										<button class="oneBtn" id="btnProductPopup">
											<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
										</button>
										<input type="hidden" id="hdProductCode" value="" />
										<input type="hidden" id="hQcReportNo" value="" />
									</td>
								</tr>
								<tr>
									<th>안전관리담당부서 담당자 Interviewed person</th>
									<td>
										<input type="text" id="txtSafetyDeptUserId" disabled="disabled" valireqire="안전관리담당부서 담당자" style="width:80%;" />
										<button class="oneBtn" id="btnSafetyUserPopup">
											<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
										</button>
										<input type="hidden" id="hSafetyDeptUserId" value="" />
									</td>
									<th>평가기간</th>
									<td>
										<div class="dateBox">
											<input type='text' id='txtStartDate' valireqire="평가기간" validate="평가기간" able style="width: 120px;" />
										</div>
										 ~ 
										<div class="dateBox">
											<input type='text' id='txtEndDate' valireqire="평가기간" validate="평가기간" able style="width: 120px;" />
										</div>
									</td>
								</tr>
								<tr>
									<th>품질곤리(QC) 담당자 Person in charge of QC</th>
									<td>
										<label id="lblQcUserName">${loginMap.USER_NM}</label>
										<input type="hidden" id="hQcUserId" value="${loginMap.USER_ID}" />
									</td>
									<th>품질관리(QC) 실시일 Date of QC</th>
									<td>
										<div class="dateBox">
											<input type='text' id='txtQcDate' valireqire="품질관리 실시일" validate="품질관리 실시일" able style="width: 120px;" />
										</div>
									</td>
								</tr>
								<tr>
									
								</tr>
							</tbody>
						</table>
					</div>
				</article>
				<article class="conTitBox mgT30">
					<h5>이상사례 정보</h5>
				</article>
				
				<article class="conTitBtnR mgT30">
					<input type="button" id="btnAdd" value="추가" />
					<input type="button" id="btnDel" value="삭제" />
				</article>
				
				<article class="mgT10">
						<div id="grCase" class="gridHeiSz04 grid_wrap tb01_2"></div>
				</article>
				
				<article class="mgT30 conTitBox">
					<h5>1. 후속조치 확인 Confirmation of Last CAPA Follow-up</h5>
				</article>
				
				
				
				<article class="mgT8">
					<table class="tb001">
						<colgroup>
							<col width="12%" />
							<col width="20%" />
							<col width="18%" />
							<col width="" />
							<col width="18%" />
					
						</colgroup>
						<tbody id="tbodyCapaList">
							<tr>
								<th>위반항목 Item</th>
								<th>위반내용 QC Findings</th>
								<th>해결유무 Get Resolved</th>
								<th>미해결사유 Reason for not being Resolved</th>
								<th>비고Remark</th>
							</tr>
						</tbody>
					</table>
				</article>
				
				
				
				<article class="mgT30 conTitBox">
					<h5>2. SOP 항목별 체크리스트 SOP Compliance Check-list</h5>
				</article>
				<article class="mgT8">
					<div>
						<table class="tb001">
							<colgroup>
								<col width="40px" />
								<col width="" />
								<col width="120px" />
							</colgroup>
							<tbody id="tbodySopList">
							</tbody>
						</table>
					</div>
				</article>
				
				
				
				
				<article class="mgT30 conTitBox">
					<h5>3. 평가 결과 QC Result and Recommendatons</h5>
				</article>
				<article class="mgT8">
					<table class="tb001">
						<colgroup>
							<col width="10%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<td colspan="2" style="font-family:NanumGothicBold; text-align:center; color:#000000; font-size:14px; background:#f6f7ff;">
									<label id="lblNo"></label>개 항목 위반 / 총 <label id="lblTotal"></label>개 항목 (달성률 <label id="lblRate"></label>%)
								</td>
							</tr>
							<tr>
								<th>Comment</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtResultComment" rows="3" style="width:100%;" able valireqire="평가 결과 코멘트"></textarea>
								</td>
							</td>
							</tr>
						</tbody>
					</table>
				</article>
				
				<article class="mgT30 conTitBox">
					<h5>4. 결제</h5>
				</article>
				<article class="mgT8">
					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="40%" />
							<col width="40%" />
						</colgroup>
						<tbody>
							<tr>
								<th class="taC"></th>
								<th class="taC">성명 Nmae/서명 Signature</th>
								<th class="taC">날짜 Date(yyyy.mm.dd)</th>
							</tr>
							<tr>
								<th class="taC">
									품질관리(QC) 담당자 Prepared by
								</th>
								<td>
									<label id="lblQcUser"></label>
								</td>
								<td>
									<label id="lblQcDate"></label>
								</td>
							</tr>
							<tr>
								<th class="taC">
									안전관리담당 부서장 Prepared by
								</th>
								<td>
									<label id="lblSafeUser"></label>
								</td>
								<td>
									<label id="lblSafeDate"></label>
								</td>
							</tr>
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