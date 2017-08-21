<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- <jsp:include page="/com/popup/popupCommon.do" flush="false"/> --%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript">

//AUIGrid 생성 후 반환 ID

var grTaskProgressStatus = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grTaskProgressStatus'
	 	},
	 	proxy: {
	 		url: '/ctms/j01/selectTaskProgressList.do',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: false
	 	},
	 	gridPros: {
		    enableCellMerge : false,
		    showStateColumn: false,
		    reverseRowNum : true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : false,
		    enableFilter : true,
		    // 한 화면 페이징 버턴 개수 5개로 지정
		    //showPageButtonCount : 4,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows",

		    displayTreeOpen : true,
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
			dataField : "TASK_NM",
			headerText : "과제명",
			editable : false,
			visible : true
		},{
			dataField : "TASK_NO",
			headerText : "과제번호",
			editable : false	
		},{
			dataField : "EDC_CNT",
			headerText : "EDC",
			editable : false,
			visible : true
		},{
			dataField : "IWRS_CNT",
			headerText : "IWRS",			
			editable : false,
			visible : true
		},{
			dataField : "RSRCH_CNT",
			headerText : "연구자",			
			editable : false,
			visible : true
		},{
			dataField : "INSTT_CNT",
			headerText : "기관",			
			editable : false,
			visible : true
		},{
			dataField : "TASK_END_AT",
			headerText : "상태",			
			editable : false,
			visible : true
		}],
	 	//AUI 그리드 생성
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	//AUI 그리드 이벤트 
	 	binding: function() {
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		
	 		AUIGrid.showAjaxLoader(me.id);
	 		
	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: {'TASK_NM' : $("#txtTaskNm").val(), 'TASK_NO' : $("#txtTaskNo").val() },//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.taskList);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);	 			    	
	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader(me.id);
	 		    		alert(data.message);
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};

$(document).ready(function() {
	grTaskProgressStatus.createGrid();
	
	$('#txtTaskNm').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtTaskNm').val()) {
			$('#btnSearchTask').trigger('click');
		}
	});
	$('#txtTaskNo').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtTaskNo').val()) {
			$('#btnSearchTask').trigger('click');
		}
	});

	$("#btnClose").click(function(){
		layerClose();
	});
	
	$("#btnSearchTask").click(function(){
		grTaskProgressStatus.load();
		$("#txtTaskNm").val("");
		$("#txtTaskNo").val("");
	});
	
}); 

$(window).resize(function() {
	if (grTaskProgressStatus.id) {
		AUIGrid.resize(grTaskProgressStatus.id);
	}
});

window.onresize = function() {
	if (grTaskProgressStatus.id) {
		AUIGrid.resize(grTaskProgressStatus.id);
	}
};

</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd800" >	
			<section class="conBox100 popup_conBox" style='margin:0px;'>
				<div class="popup_conBoxInner">		
									             
		            <table class="tb001">
		            	<colgroup>
		            		<col width="15%">
		            		<col width="30%">
		            		<col width="15%">
		            		<col width="">
		            	</colgroup>
		           		<tbody>
							<tr>					
								<th>과제명</th>
                                <td>
                                    <input type="text" id="txtTaskNm" style="width:100%;"> 
                                </td>
                                <th>과제번호</th>
                                <td>                     	
                                    <input type="text" id="txtTaskNo" style="width:70%;">
									<input type="button" id="btnSearchTask" value="검색" > 
                                </td> 
							</tr>
						</tbody>
					</table>		
											
                    <article class="mgT16">					                   
                        <!-- 에이유아이 그리드가 이곳에 생성 -->							                        
                        <div id="grTaskProgressStatus" class="gridHeiSz06 grid_wrap tb01_2"></div> 
                    </article>		
                    <table class="tb02">					           		
	           			<article class="mgT10">
							<div style="text-align:center">					
								<input type="button" id="btnClose" value="닫기" />
							</div>
						</article>
		           	</table>					
				</div>
			</section>
	    </div>
	</section>

</body>
</html>










