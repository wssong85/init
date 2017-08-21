<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<script type="text/javascript">
		var gridTrigger = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grTrigger',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grTrigger'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/b01/selectTriggerInfo.do',
		 		param: {},
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
				enableFilter : true,
				fixedColumnCount : 2,
				fixedRowCount : 0,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, $.parseJSON(gridHeader), me.gridPros);
		 				 	
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	binding : function() {
		 		var me = this;
		 		
		 		AUIGrid.bind(me.id, "cellEditEndBefore", function(event){
		 			if(event.dataField == "MEMO"){
		 				if(fn_getByte(event.value) > 4000){
		 					alert("메모는 4000바이트까지 입력 가능합니다.");
		 					return event.value.substring(0, fn_getLengthForByte(event.value, 4000));
		 				}
		 			}
		 			return event.value;
		 		});
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
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
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
		 	}
		};
	
		var gridHeader = null;
		// AUIGrid 생성 후 반환 ID
		var myGridID;
		$(function(){	
			pageInit();
			buttonActive();
			getHeaderText();
			gridTrigger.createGrid();
		});
		
		function pageInit(){
			$("#btnSave").hide();
			$("#btnEdit").show();
			$("#btnX").hide();
		}
		
		function buttonActive(){
			$("#btnEdit").click(function(){
				AUIGrid.setProperty(gridTrigger.id, "editable" , true);
				$("#btnSave").show();
				$("#btnEdit").hide();
				$("#btnX").show();
			});
			
			$("#btnX").click(function(){
				AUIGrid.setProperty(gridTrigger.id, "editable" , false);
				pageInit();
			});
			
			$("#btnSave").click(function(){
				var editedRowItems = AUIGrid.getEditedRowItems(gridTrigger.id);
				var gridRowItems = AUIGrid.getGridData(gridTrigger.id);
				var ipTypeArr = ipType.split(",");
				for(var i = 0; i < gridRowItems.length; i++){
					for(var j = 0; j < ipTypeArr.length; j++){
						if(gridRowItems[i][ipTypeArr[j] + "_INV"] == null || gridRowItems[i][ipTypeArr[j] + "_INV"] == "" || gridRowItems[i][ipTypeArr[j] + "_INV"] == "0"){
		 			    	AUIGrid.setSelectionByIndex(gridTrigger.id, i, AUIGrid.getColumnIndexByDataField(gridTrigger.id, ipTypeArr[j] + "_INV"));
		 			    	alert(ipTypeArr[j] + "의 Trigger LV를 입력하십시오.");
		 			    	return;
						}
						if(gridRowItems[i][ipTypeArr[j] + "_MAX"] == null || gridRowItems[i][ipTypeArr[j] + "_MAX"] == "" || gridRowItems[i][ipTypeArr[j] + "_MAX"] == "0"){
							AUIGrid.setSelectionByIndex(gridTrigger.id, i, AUIGrid.getColumnIndexByDataField(gridTrigger.id, ipTypeArr[j] + "_MAX"));
							alert(ipTypeArr[j] + "의 재고유지수량을 입력하십시오.");
		 			    	return;
						}
					}
					if(gridRowItems[i]["APPLCDE"] == null || gridRowItems[i]["APPLCDE"] == ""){
						AUIGrid.setSelectionByIndex(gridTrigger.id, i, AUIGrid.getColumnIndexByDataField(gridTrigger.id, "APPLCDE"));
						alert("적용일을 입력하십시오.");
	 			    	return;
					}
				}
				
				var param = {
						callbackFunction : "saveTrigger"
				};
				
				mkLayerPopupOpen("/iwrs/b01/popupIwrb0102.do", param);
			});
		}
		
		var ipType = "";
		
		function getHeaderText(){
			gridHeader = "[{\"dataField\" : \"INSTT_CODE\", \"headerText\": \"Site\", \"visible\": false}, ";
			gridHeader += "{\"dataField\" : \"TASK_SN\", \"headerText\": \"과제\", \"visible\": false}, ";
			gridHeader += "{\"dataField\" : \"NAME1\", \"headerText\": \"Site\", \"editable\" : false, \"filter\" : {	\"showIcon\" : true	}}, ";
			$.ajax({
				type : "POST",
				async : false,
				url : "/iwrs/b01/selectIpType.do",
				success :function(data){
					$.each(data, function(index, value){
						gridHeader += "{ \"headerText\" : \"" + value.IP_TYPE + "\", \"children\" : [";
						gridHeader += "{ \"dataField\" : \"IP_TYPE_" + value.IP_TYPE + "\", \"headerText\" : \"IP TYPE\", \"visible\": false},";
						gridHeader += "{ \"dataField\" : \"" + value.IP_TYPE + "_TR_NO\", \"headerText\" : \"TR_NO\", \"visible\": false},";
						gridHeader += "{ \"dataField\" : \"" + value.INV + "\", \"headerText\" : \"Trigger LV<span class='must_01'></span>\", \"editRenderer\": { \"type\": \"InputEditRenderer\", \"onlyNumeric\": true }},";
						gridHeader += "{ \"dataField\" : \"" + value.MAX + "\", \"headerText\" : \"재고유지수량<span class='must_01'></span>\", \"editRenderer\": { \"type\": \"InputEditRenderer\", \"onlyNumeric\": true }}]},";
						if(ipType == ""){
							ipType += value.IP_TYPE;
						}else{
							ipType += "," + value.IP_TYPE;
						}
					});
				}
			});
			
			gridHeader += "{\"dataField\" : \"APPLCDE\", \"headerText\" : \"적용일<span class='must_01'></span>\", \"filter\" : {	\"showIcon\" : true	}, \"dataType\":\"date\", \"formatString\": \"yyyy-mm-dd\", \"editRenderer\": { \"type\": \"CalendarRenderer\", \"showEditorBtnOver\": true }},";
			gridHeader += "{\"dataField\" : \"MEMO\", \"headerText\" : \"메모\"},";
			gridHeader += "{\"headerText\" : \"Audit Trail\", \"editable\":false}";
			gridHeader += "]";
			console.log(gridHeader);
		}
		
		function saveTrigger(userId){
			var editedRowItems = AUIGrid.getEditedRowItems(gridTrigger.id);
			var ipTypeArr = ipType.split(",");
			
			var param = [{
					TRIGGER_DATA : editedRowItems,
					IPTYPE : ipTypeArr,
					USER_ID : userId
			}];

			$.ajax({
				type : "POST",
				async : false,
				
				data : {data : JSON.stringify(param) },
				url : "/iwrs/b01/insertTriggerInfo.do",
				success :function(data){
					if(data.result == true){
						alert(data.message);
						gridTrigger.load();
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		window.onresize = function() {
			if (typeof gridTrigger.id !== "undefined") {
				AUIGrid.resize(gridTrigger.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRB0101&UPPER_MENU_ID=IWRB" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRB0101&UPPER_MENU_ID=IWRB" charEncoding="utf-8"/>
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
<!-- 							<h5>Trigger 설정</h5> -->
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnSave" value="저장" class="save_01" title="저장" />
							<input type="button" id="btnEdit" value="수정" class="edit_01" title="수정" />
                        	<input type="button" id="btnX" value="X" class="close_01" title="닫기">
						</article>
						<article class="mgT15">
							<div id="grTrigger" class="gridHeiSz16 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>