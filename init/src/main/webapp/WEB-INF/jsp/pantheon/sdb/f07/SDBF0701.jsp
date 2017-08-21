<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
		
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
	<script type="text/javascript">
		var gridAssessmentSetting = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grAssessmentSetting'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/f07/selectAssessmentSettingInfo.do',
		 		param: {SE_CODE : $("#sltType option:selected").val()},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : true,
				'selectionMode': 'singleRow',
				'editable': true,
				'showStateColumn': false,
				'showRowNumColumn' : false,
				'showRowCheckColumn' : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "QESTN_SN",
								headerText : "질문<span class='must_01'></span>",
								width : 64,
								dataType : "numeric"
							}, {
								dataField : "QESTN_CN",
								headerText : "질문내용<span class='must_01'></span>"
							}, {
								dataField : "YES_SCORE",
								headerText : "Yes",
								renderer : {
									type : "NumberStepRenderer",
									min : -100,
									max : 100,
									step : 1
								},
								width : 100
							}, {
								dataField : "NO_SCORE",
								headerText : "No",
								renderer : {
									type : "NumberStepRenderer",
									min : -100,
									max : 100,
									step : 1
								},
								width : 100,
								dataType : "numeric"
							}, {
								dataField : "NOT_KNOW_SCORE",
								headerText : "Do not know",
								renderer : {
									type : "NumberStepRenderer",
									min : -100,
									max : 100,
									step : 1
								},
								width : 100,
								dataType : "numeric"
							}, {
								dataField : "SN",
								headerText : "SN",
								visible : false
							}, {
								dataField : "SE_CODE",
								headerText : "SE_CODE",
								visible : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.proxy.param = {SE_CODE : $("#sltType option:selected").val()};
		 		
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		me.binding();
// 		 		AUIGrid.bind(me.id, "cellClick", auiGridCellClickHandler);
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
		 				 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: {SE_CODE : $("#sltType option:selected").val()},
		 		    success:function(data){
		 		    	if(data.result == "true") {
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
	
		$(function(){
			initPageSetting();
			buttonActive();
			selectBoxActive();
		});
		
		function initPageSetting(){
			<c:forEach var="result" items="${assessment}" varStatus="status">
				if("${result.CMMN_CODE}" != "03"){
					$("#sltType").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
				}
			</c:forEach>
			
			gridAssessmentSetting.createGrid();
			
			$("#btnSave").hide();
			$("#btnEdit").show();
			$("#btnAdd").hide();
			$("#btnDelete").hide();
			$("#btnX").hide();
		}
		
		function selectBoxActive(){
			$("#sltType").change(function(){
				gridAssessmentSetting.load();
			});
		}
		
		function buttonActive(){
			$("#btnSave").click(function(){
				saveAssessmentInfo();
			});
			
			$("#btnDelete").click(function(){
				deleteAssessmentInfo();
			});
			
			$("#btnAdd").click(function(){
				addGridAddRow();
			});
			
			$("#btnEdit").click(function(){
				AUIGrid.setProperty(gridTrigger.id, "editable" , true);
				$("#btnSave").show();
				$("#btnEdit").hide();
				$("#btnAdd").show();
				$("#btnDelete").show();
				$("#btnX").show();
			});
			
			$("#btnX").click(function(){
				AUIGrid.setProperty(gridTrigger.id, "editable" , false);
				$("#btnSave").hide();
				$("#btnEdit").show();
				$("#btnAdd").hide();
				$("#btnDelete").hide();
				$("#btnX").hide();
			})
		}
		
		function addGridAddRow(){
			 var row = {
						'QESTN_SN': 1,
						'QESTN_CN': '',
						'YES_SCORE': '',
						'NO_SCORE': '',
						'NOT_KNOW_SCORE': '',
						'SN': '',
						'CRUD' : 'C'
				};
			AUIGrid.addRow(gridAssessmentSetting.id, row, 'first'); // 최하단에 행 추가
		}
		
		function saveAssessmentInfo(){
			var addedRowItems = AUIGrid.getAddedRowItems(gridAssessmentSetting.id);
			var editedRowItems = AUIGrid.getEditedRowItems(gridAssessmentSetting.id);
			
			var param = [{
				SE_CODE : $("#sltType option:selected").val(),
				ADDDATA : addedRowItems,
				EDITDATA : editedRowItems
			}];
			
			$.ajax({
				type : "POST",
				async : false,
				data : {data : JSON.stringify(param) },
				url : "/sdb/f07/insertAssessmentInfo.do",
				success :function(data){
					if(data.result == "true"){
						alert(data.message);
						gridAssessmentSetting.load();
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		function deleteAssessmentInfo(){
			var deletedRowItems = AUIGrid.getCheckedRowItems(gridAssessmentSetting.id);
			
			var param = [{
				SE_CODE : $("#sltType option:selected").val(),
				DELDATA : deletedRowItems
			}];
			console.log(deletedRowItems);
			$.ajax({
				type : "POST",
				async : false,
				data : {data : JSON.stringify(param) },
				url : "/sdb/f07/deleteAssessmentInfo.do",
				success :function(data){
					if(data.result == "true"){
						alert(data.message);
						gridAssessmentSetting.load();
					}else{
						alert(data.message);
					}
				}
			});
		}
		
		$(window).resize(function(){
			if(gridAssessmentSetting.id){
				AUIGrid.resize(gridAssessmentSetting.id);
			}
		});
		
		
	</script>
</head>
<body>
<div id="wrap">	
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBF0701&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBF0701&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>	
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
						<select id="sltType">
						</select>
					</article>
					<article class="conTitBtnR">
						<input type="button" id="btnSave" value="저장" />
						<input type="button" id="btnEdit" value="수정" />
						<input type="button" id="btnAdd" value="행추가" />
						<input type="button" id="btnDelete" value="행삭제" />
	                  	<input type="button" id="btnX" value="X" />
					</article>
					<article class="mgT16">
						<div id="grAssessmentSetting" class="gridHeiSz15 grid_wrap tb01_2"></div>
					</article>
				</div>
			</section>
		</div>
		</section>
</div>
</body>
</html>