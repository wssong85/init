<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var g_fileMastrSn = ${FILE_MASTR_SN};

var grid_edcLabDta = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_edcLabDta',
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
			url : './selectEdcLabDtaList.do',
			param : {
							'TASK_SN':taskSn
						,	'FILE_MASTR_SN':g_fileMastrSn
					},
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
							dataField : "TASK_SN",
							headerText : "TASK_SN",
							width : 120,
							editable : false,
							visible : false
						},{ 
							dataField : "FILE_MASTR_SN",
							headerText : "FILE_MASTR_SN",
							width : 120,
							editable : false,
							visible : false
						},{ 
							dataField : "TASK_NO",
							headerText : "Study No",
							width : 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{ 
							dataField : "LAB_NM",
							headerText : "Laboratory Name",
							width : 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SUBJECT_INITIAL",
							headerText : "Subject initial",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SEXDSTN",
							headerText : "Sex",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SUBJECT_NO",
							headerText : "Subject No",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SMPLERING_DE",
							headerText : "Sampling Date",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "VISIT_LBL",
							headerText : "Visit No",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ANALS_PARAMTR",
							headerText : "항목",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ANALS_RESULT",
							headerText : "값",
							width: 120,
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
			    url : './selectEdcLabDtaList.do' ,//변경
			    type: 'post',
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		console.log("data.result : "+data.result);
	 			    	AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
						
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader("#grid_edcLabDta");
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
	var paramData = new Object();
	paramData.TASK_SN = $("#popup_frm #TASK_SN").val();
	paramData.FILE_MASTR_SN = $("#popup_frm #FILE_MASTR_SN").val();
	
	grid_edcLabDta.proxy.param = paramData;
	grid_edcLabDta.createGrid();
	
	$("#btnCmAddrClose").click(function(){
		layerClose();
	});

});

$(window).on('resize', function(){
	if (grid_edcLabDta && grid_edcLabDta.id) {
		AUIGrid.resize(grid_edcLabDta.id);
	}
});

</script>

<body>
<div id="wrap">
	<section class="popupWrap">
		<div class="popup wd800"> 
		
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
            
				<article class="mgT20">
					<div id="grid_edcLabDta" class="gridHeiSz10 grid_wrap tb01_2"></div>
				</article>
				
            </section>
            
			<article class="mgT10">
				<div style="text-align:center;padding:10px;">
					<input type="button" id="btnCmAddrClose" value="닫기">
				</div>
			</article>
            <form id="popup_frm" name="popup_frm">
				<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
				<input type="hidden" id="FILE_MASTR_SN" name="FILE_MASTR_SN" value="${ FILE_MASTR_SN }">
			</form>
			
		</div>
	</section>
	
</div>
</body>	
