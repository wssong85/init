<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<script>
var taskSn = ${loginMap.TASK_SN};
console.log("TASK_SN : "+taskSn);
var grid_qrList = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_qrList',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
	 	},
	 	proxy: {
			url : './selectQueryListByPre.do',
			param : {'TASK_SN':taskSn},
	 		type: 'post',
	 		dataType: 'json',
	 		paging: false,
	 		autoLoad: true
	 	},
	 	gridPros: {
		    showRowNumColumn : true,
		    showRowCheckColumn : true,
		    
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    
	 	    editable : false,
		    enableFilter : true,
		    
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",

		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "singleRows",

		    displayTreeOpen : false
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{ 
							dataField : "QUERY_SN",
							headerText : "QUERY_SN",
							width : 120,
							editable : false,
							visible : false
						},{ 
							dataField : "INSTT_NM",
							headerText : "Site",
							width : 120,
							editable : false
						},{
							dataField : "SUBJECT_NO",
							headerText : "Subject",
							width: 120,
							editable : false
						},{
							dataField : "VISIT_LBL",
							headerText : "Visit",
							width: 120,
							editable : false
						},{
							dataField : "GROUP_LBL",
							headerText : "CRF",
							width: 120,
							editable : false
						},{
							dataField : "VRBL",
							headerText : "Variable",
							width: 120,
							editable : false
						},{
							dataField : "QUERY_STTUS_CODE",
							headerText : "Status",
							width: 120,
							editable : false
						},{
							dataField : "QUERY_TY_CODE",
							headerText : "Type",
							width: 120,
							editable : false
						},{
							dataField : "ROLE_NM",
							headerText : "Role",
							width: 120,
							editable : false
						},{
							dataField : "FRST_CRTR",
							headerText : "Issue",
							width: 120,
							editable : false
						},{
							dataField : "LAST_UPDUSR",
							headerText : "Modifier",
							width: 120,
							editable : false
						},{
							dataField : "QUERY_CN",
							headerText : "Query",
							width: 120,
							editable : false
						},{
							dataField : "RESN",
							headerText : "Reason",
							width: 120,
							editable : false
						},{
							dataField : "LAST_UPDDE",
							headerText : "Mod Date",
							width: 120,
							editable : false
						} ],
	 	
	 	//AUI 그리드 생성
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		gridMainID = me.id;
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	
	 	//AUI 그리드 이벤트 
	 	binding: function() {
	 		var me = this;
	 		
	 		AUIGrid.bind(me.id, "cellClick", function(event) {
	 			if (event.dataField == "TASK_NO") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					console.log("rowItem.TASK_SN : "+rowItem.TASK_SN);
					$("#frm_main #TASK_SN").val(rowItem.TASK_SN);
					$("#frm_main #TASK_NO").val(rowItem.TASK_NO);
					$("#frm_main").attr({
						action : './EDCK0402.do',
						method : 'post'
					}).submit();
				}
			});
	 		
			AUIGrid.bind(me.id, "cellEditBegin", function(event) {

			});

	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		
	 		if(me.proxy.paging && !v1 && !v2) {
	 			me.proxy.param.page = me.div.paging.currentPage;		
	 			me.proxy.param.count= me.div.paging.rowCount;		
	 		}
	 		
	 		if(v1 && v2) {
	 			me.proxy.param.page = v2;	
	 			me.div.paging.currentPage = v2;
	 			me.proxy.param.count = v1;		
	 			me.div.paging.rowCount = v1;		
	 		}
	 		
	 		AUIGrid.showAjaxLoader(me.id);

	 		$.ajax({
			    url : './selectQueryListByPre.do' ,//변경
			    type: 'post',
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		console.log("data.result : "+data.result);
	 			    	AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						$("#frm_main #TASK_SN").val(taskSn);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
						
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader("#grid_qrList");
	 		    		alert(data.message);
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};	
	
$(function(){

	$("#frm_main #TASK_SN").val(taskSn);
	
	grid_qrList.createGrid();
	
	// 양식 다운로드
	$('.popup_01').click(function(){
		$.ajax({
			url : './selectDownTemplate.do',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				if(data.success) {
					window.open("<c:url value='/edc/d01/selectOpenFile.do?FILE_PATH=" + data.filePath + "&FILE_NAME=" + data.fileName + "'/>");
					
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});
	
	// 쿼리 업로드
	$('.popup_02').click(function(){
		mkLayerPopupOpen("./popupEDCD0105.do", null);
		AUIGrid.resize(EDCD0105_grid.id);
	});
	
	//검색버튼 클릭
	$('#btnSearch').click(function(){
		var params = {
		};
		
		params.INSTT_NM = $('#INSTT_NM').val();
		params.SUBJECT_NO = $('#SUBJECT_NO').val();
		params.TASK_SN = $('#TASK_SN').val();
		
		grid_qrList.proxy.param = params;
		grid_qrList.load();
	})
	
	$('#btnQrIss').click(function(){
		var arJson = [];
		
		// 선택된 행 아이템들(배열)		
		var editedItems = AUIGrid.getCheckedRowItems(grid_qrList.id);
		if(editedItems.length == 0){
			alert("데이터를 선택해 주세요.");
			return false;
		}

		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].item.QUERY_STTUS_CODE = '01';
			arJson.push(editedItems[i].item);
		}		
		
		$.ajax({
			  url : './updateCmQueryByQuerySttus.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {					
					  grid_qrList.load();			
				  } else {
					  AUIGrid.removeAjaxLoader(grid_qrList.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	})
	
	$("#btnQrDlt").click(function(){
		var arJson = [];
		
		// 선택된 행 아이템들(배열)		
		var editedItems = AUIGrid.getCheckedRowItems(grid_qrList.id);
		if(editedItems.length == 0){
			alert("데이터를 선택해 주세요.");
			return false;
		}

		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].item.USE_AT = 'N';
			arJson.push(editedItems[i].item);
		}
		
		console.log(arJson);
		
		$.ajax({
			  url : './updateCmQueryByUseAt.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {					
					  grid_qrList.load();			
				  } else {
					  AUIGrid.removeAjaxLoader(grid_qrList.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
		
	});
	
});

</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCD0101&&UPPER_MENU_ID=EDCD" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCD0101&&UPPER_MENU_ID=EDCD" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>${ progrmMap.MENU_NM }</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>${ progrmMap.UPPER_MENU_NM }</li>
						<li>${ progrmMap.MENU_NM }</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner">
					<div id="tab" class="tab tab01 mgT16">
						<ul>
							<li id="tab_01" class="port_back tab_menu">예비</li>
							<li id="tab_02" class="tab_menu" onclick="fn_moveTab('EDCD0102');">오픈</li>
						</ul>
					</div>
					<article style="overflow:hidden;">
						<div class="conTitBtnL">
							
							<span style="font-family:'NanumGothicBold';">Site :</span>
							<input type="text" id="INSTT_NM" name="INSTT_NM" style="width: 200px;">
							<span style="font-family:'NanumGothicBold'; margin-left: 20px;">Subject :</span>
							<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" style="width: 140px;">
							<button class="oneBtn" id="btnSearch" popup_type="ProductSearch" type="sumit">
								<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
							</button>
						</div>
						<div class="conTitBtnR">									
							<input type="button" class="popup_01" value="양식 다운로드">
							<input type="button" class="popup_02" value="쿼리 업로드">
							<input type="button" id="btnQrIss" value="쿼리 발행">
							<input type="button" id="btnQrDlt" value="쿼리 삭제">
						</div>
					</article>
 					<article class="mgT16">
                        <div id="grid_qrList" class="gridHeiSz15 grid_wrap tb01_2"></div>
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    <form id="frm_main" name="frm_main">
						<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
					</form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>


</html>