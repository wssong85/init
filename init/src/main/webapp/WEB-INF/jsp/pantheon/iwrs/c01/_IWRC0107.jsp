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
	 		    	if(data.result == "ok") {
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
	 		});
	 	}
	};
	
	$(function(){
		gridInsu.createGrid();
		createIpType();
		setController();
		buttonActive();
	});
	
	function createIpType(){
		var tableIpCode = "<table width='200px'>";
		<c:forEach var="ip" items="${list}" varStatus="status">
			tableIpCode += "<tr><th>${ip.IP_TYPE}</th>";
			tableIpCode += "<td><label>${ip.IP_CODE}</label></td></tr>";
		</c:forEach>
		tableIpCode += "</table>";
		$("#divIpInfo").append(tableIpCode);
	}
	
	function setController(){
		mkSetDatePickerYYMMDD("#txtDeliCompDate");
		if("${ deli.DLVY_COMPTDE }" != ""){
			$("#txtDeliCompDate").val("${ deli.DLVY_COMPTDE }");
		}
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
			
			var toDate = new Date();				
			var dileDate = new Date(arrDileDate[0], arrDileDate[1], arrDileDate[2]);
			
			if(dileDate.getDate() - toDate.getDate() > 0){
				alert("배송완료일은 미래일을 등록할 수 없습니다.");
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
	
</script>
</head>
<body>

<style>
#divIpInfo table{  width:100%;}
#divIpInfo table th{border-left:none;}
#divIpInfo table td{border-right:none; }
#divIpInfo table tr:last-child { border-bottom:none;}
#divIpInfo table tr:last-child th{ border-bottom:none; }
#divIpInfo table tr:last-child td:last-child{ border-bottom:none;}
</style>

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
							<td><label>${ deli.INSTT_CODE }</label></td>
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