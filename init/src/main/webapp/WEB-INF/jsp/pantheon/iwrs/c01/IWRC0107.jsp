<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
		var gridInsu = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'gridIpDeliError',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridIpDeliError',
		 		paging: {
		 			pagingDiv: '',
		 			totalRowCount: 500,
		 			rowCount: 5,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/c01/selectIpErroInfo.do',
		 		param: {dlvymanage_code:'${deli.DLVYMANAGE_CODE}'},
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
				'showStateColumn': false,
				'showRowNumColumn' : false,
			    enableMovingColumn : false,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "IP_CODE",
								headerText : "IP번호"
							}, {
								dataField : "OMISSION",
								headerText : "누락",
								renderer : {
									type : "CheckBoxEditRenderer",
									editable : true, // 체크박스 편집 활성화 여부(기본값 : false)
									checkValue : "Y", // true, false 인 경우가 기본
									unCheckValue : "N"
								}
							}, {
								dataField : "DAMAGE",
								headerText : "파손",
								renderer : {
									type : "CheckBoxEditRenderer",
									editable : true, // 체크박스 편집 활성화 여부(기본값 : false)
									checkValue : "Y", // true, false 인 경우가 기본
									unCheckValue : "N"
								}
							}, {
								dataField : "LOSS",
								headerText : "분실",
								renderer : {
									type : "CheckBoxEditRenderer",
									editable : true, // 체크박스 편집 활성화 여부(기본값 : false)
									checkValue : "Y", // true, false 인 경우가 기본
									unCheckValue : "N"
								}
							}, {
								dataField : "CREAT_CODE",
								visible : false
							}, {
								dataField : "IP_TYPE",
								visible : false
							}, {
								dataField : "IP_TRGET_NO",
								visible : false
							}, {
								dataField : "SN",
								visible : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 		
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result == "ok") {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	},
			//AUI 그리드 이벤트 
		 	binding: function() {
		 		var me = this;
		 		
		 		AUIGrid.bind(me.id, 'cellEditEnd', function(event) {
		 			var flag = false;
		 			
		 			var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
		 			var colItem = event.columnIndex;
		 			
		 			if(event.value == "Y"){
		 				if(event.columnIndex == "1"){
		 					rowItem.LOSS = "N";
		 					rowItem.DAMAGE = "N";
		 				}else if(event.columnIndex == "2"){
		 					rowItem.OMISSION = "N";
		 					rowItem.LOSS = "N";
		 				}else if(event.columnIndex == "3"){
		 					rowItem.OMISSION = "N";
		 					rowItem.DAMAGE = "N";
		 				}
		 				
		 				AUIGrid.updateRow(me.id, rowItem, event.rowIndex);
		 			}
		 			
		 			checkError();
		 		});
		 	}
		};
		
		$(function(){
			gridInsu.createGrid();
			createIpType();
			setController();
			buttonActive();
			checkError();
		});
		
		function checkError(){
			var lossItems = AUIGrid.getItemsByValue(gridInsu.id, "LOSS", "Y");
 			var damageItems = AUIGrid.getItemsByValue(gridInsu.id, "DAMAGE", "Y");
 			var omissionItems = AUIGrid.getItemsByValue(gridInsu.id, "OMISSION", "Y");
 			var cnt = lossItems.length + damageItems.length + omissionItems.length;
 			if(cnt > 0){
 				$('#trErrorMessage').show();
 			}else{
 				$("#trErrorMessage").hide();
 				$("#txtErrorMemo").val("");
 			}
		}
		
		function createIpType(){
			var tableIpCode = "<table width='200px'>";
			<c:forEach var="ip" items="${list}" varStatus="status">
				tableIpCode += "<tr><th>${ip.IP_TYPE}</th>";
				tableIpCode += "<td><label>${ip.IP_CODE}</label></td></tr>";
				if("${ip.IP_ERROR_COMMENT}" != ""){
					$("#txtErrorMemo").val("${ip.IP_ERROR_COMMENT}");
				}
			</c:forEach>
			tableIpCode += "</table>";
			$("#divIpInfo").append(tableIpCode);
		}
		
		function setController(){
			mkSetDatePickerYYMMDD("#txtDeliCompDate");
			if("${ deli.DLVY_COMPTDE }" != ""){
				$("#txtDeliCompDate").val("${ deli.DLVY_COMPTDE }");
			}
			$('#trErrorMessage').hide();
		}
		
		function buttonActive(){
			$("#btnSave").click(function(){
				if(!window.confirm("저장하시겠습니까?")){
					return;
				}
				
				if(!mkValidation()){
					return;
				}
				
				var arrDileDate = $("#txtDeliCompDate").val().split("-");
				var requestDateArray = "${deli.DLVY_RQESTDE}".split("-");
				
				var toDate = new Date();				
				var dileDate = new Date(arrDileDate[0], arrDileDate[1] - 1, arrDileDate[2], 0, 0, 0);
				var requestDate = new Date(requestDateArray[0], requestDateArray[1] - 1, requestDateArray[2], 0, 0, 0);
				
				if(dileDate.getTime() - toDate.getTime() > 0){
					alert("배송완료일은 미래일을 등록할 수 없습니다.");
					return;
				}
				
				if(dileDate.getTime() - requestDate.getTime() < 0){
					alert("배송완료일은 배송 요청일 보다 과거일을 등록할 수 없습니다.");
					return;
				}
				
				saveInsuInfo();
			});
			
			$("#btnClose").click(function(){
				layerClose();
			});
		}
		
		function saveInsuInfo(){
			var item = AUIGrid.getGridData(gridInsu.id);
			
			var param = [{
					dlvy_comptde : $("#txtDeliCompDate").val().replace(/-/g, ""),
					user_id : $("#txtUserId").val(),
					pass : $("#txtPass").val(),
					memo : $("#txtUndtakeMemo").val(),
					dlvymanage_code : "${deli.DLVYMANAGE_CODE}",
					IP_ERROR_COMMENT : $("#txtErrorMemo").val(),
					error_data : item
			}];
			
			$.ajax({
				type : "POST",
				async : false,
				data : {data : JSON.stringify(param) },
				url : "/iwrs/c01/updateIpInsuInfo.do",
				success :function(data){
					if(data.result == "true"){
						alert("등록하였습니다.");
						layerClose();
						gridDelivery.load();
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		window.onresize = function() {
			if (typeof gridInsu.id !== "undefined") {
				AUIGrid.resize(gridInsu.id);
			}
		};
	</script>
	<style>
		#divIpInfo table{  width:100%;}
		#divIpInfo table th{border-left:none;}
		#divIpInfo table td{border-right:none; }
		#divIpInfo table tr:last-child { border-bottom:none;}
		#divIpInfo table tr:last-child th{ border-bottom:none; }
		#divIpInfo table tr:last-child td:last-child{ border-bottom:none;}
	</style>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd700">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<h6>인수확인</h6>
					<article class="mgT5">
						<table class="tb001">
							<colgroup>
								<col width="20%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>Site</th>
								<td><label>${ deli.INSTT_NAME }</label></td>
								</tr>
								<tr>
									<th>배송완료일</th>
									<td><div class="dateBox"><input type="text" id="txtDeliCompDate" valireqire="배송완료일" validate="배송완료일" /></div></td>
								</tr>
								<tr>
									<th>배송메모</th>
									<td><label>${ deli.DLVY_CNFIRM_COMMENT }</label></td>
								</tr>
								<tr>
									<th>IP코드</th>
									<td style="padding:0;"><div id="divIpInfo"></div></td>
								</tr>
								<tr>
									<th>인수확인메모</th>
									<td style="padding:7px 6px 0px 7px;">
										<textarea id="txtUndtakeMemo" row="4" style="width:100%;">${ deli.UNDTAKECNFIRM_COMMENT }</textarea>
									</td>
								</tr>
								<tr>
									<th>IP배송오류</th>
									<td style="padding:7px 6px 7px 7px;">
										<div id="gridIpDeliError" class="gridHeiSz04 grid_wrap tb01_2"></div>
									</td>
								</tr>
								<tr id="trErrorMessage">
									<th>오류 메모</th>
									<td style="padding:7px 6px 0px 7px;">
										<textarea id="txtErrorMemo" row="4" style="width:100%;">${ deli.ERROR_COMMENT }</textarea>
									</td>
								</tr>
								<tr>
									<th>사용자아이디</th>
									<td><input type="text" id="txtUserId" valireqire="사용자아이디" /></td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input type="password" id="txtPass" valireqire="비밀번호" /></td>
								</tr>
							</tbody>
						</table>
					</article>
					<article class="mgT10">
						<div style="text-align:center">
							<input type="button" id="btnSave" value="저장" />
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				</div>
			</section>
		</div>
	</section>
</body>
</html>