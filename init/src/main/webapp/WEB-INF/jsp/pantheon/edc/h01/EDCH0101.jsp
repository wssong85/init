<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title></title>
<style>
.edc_column_style {
	color: #5570e6;
	text-decoration: underline;
	font-weight: bold;
}

.edc_column_style:hover {
	text-decoration: underline;
	cursor: pointer;
}
</style>

<script>
var taskSn = ${loginMap.TASK_SN};

var grid_dmFileDetail = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_dmFileDetail',
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
			url : './selectDmFileDetailList.do',
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
							dataField : "DETAIL_SN",
							headerText : "DETAIL_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "FILE_MASTR_SN",
							headerText : "FILE_MASTR_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "ORGINL_FILE_NM",
							headerText : "File",
							editable : false,
							style : "edc_column_style",
							filter : {
								showIcon : true
							}
						},{ 
							dataField : "INTRLCK_AT",
							headerText : "CRF 연동",
							editable : false,
							filter : {
								showIcon : true
							}
						},{ 
							dataField : "FRST_CREDE",
							headerText : "업로드 일자",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "REGIST_ID",
							headerText : "업로드 사용자",
							editable : false,
							filter : {
								showIcon : true
							}
						}],
	 	
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
	 			if(event.dataField == "ORGINL_FILE_NM"){
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
	 				
	 				var param = new Object();
	 				param.TASK_SN = $("#frm_main #TASK_SN").val();
	 				param.FILE_MASTR_SN = rowItem.FILE_MASTR_SN;
	 				
	 				mkLayerPopupOpen("/edc/h01/popupEDCH0103.do", param);
	 				AUIGrid.resize(grid_edcLabDta.id);
	 				AUIGrid.resize(grid_edcLabDta.id);
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
			    url : './selectDmFileDetailList.do' ,//변경
			    type: 'post',
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		console.log("data.result : "+data.result);
	 			    	AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
						
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader("#grid_dmFileDetail");
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
	
	grid_dmFileDetail.createGrid();
	
	//양식다운로드 버튼 클릭
	$('#fn_formDown').click(function(){
		$.ajax({
			url : './selectDownTemplate.do',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				if(data.success) {
					window.open("<c:url value='/edc/h01/selectOpenFile.do?FILE_PATH=" + data.filePath + "&FILE_NAME=" + data.fileName + "'/>");
					
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});
	
	//업로드 버튼 클릭
	$('#fn_formUpload').click(function(){
		mkLayerPopupOpen("./popupEDCH0102.do", null);
		AUIGrid.resize(EDCH0102_grid.id);
	});
	
	//연동 버튼 클릭
	$('#fn_insert').click(function(){
		var checkedItems = AUIGrid.getCheckedRowItems(grid_dmFileDetail.id);
		
		if (checkedItems.length <= 0) {
			alert("연동할 파일을 선택하세요.");
		}else if(checkedItems.length > 1){
			alert("하나의 파일만 선택하세요.");
		}else {
			if(!confirm("연동하시겠습니까?")) {
				return;
			}
			
			var param = new Object();
			param.FILE_MASTR_SN = checkedItems[0].item.FILE_MASTR_SN;
		
			$.ajax({
				url : './insertLabCfValue.do',
				data : param,
				type : 'post',
				success : function(data, textStatus, jqXHR) {
					if (data.success) {
						alert('<spring:message code="message.save.2"/>');
						grid_dmFileDetail.load();
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		
		}
	});

});

// 윈도우 리사이징 이벤트
window.onresize = function() {
	if (grid_dmFileDetail.id !== "undefined") {
		AUIGrid.resize(grid_dmFileDetail.id);
	}
};


</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCH0101&&UPPER_MENU_ID=EDCH" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCH0101&&UPPER_MENU_ID=EDCH" charEncoding="utf-8"/>
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
					<article style="overflow:hidden;">
						<div class="conTitBtnR">
							<input type="button" value="연동" id="fn_insert">
							<input type="button" value="양식다운로드" id="fn_formDown">
							<input type="button" value="업로드" id="fn_formUpload">
						</div>
					</article>
 					<article class="mgT16">
                        <div id="grid_dmFileDetail" class="gridHeiSz15 grid_wrap tb01_2"></div>
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