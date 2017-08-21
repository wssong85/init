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

var rsrchSearch = {
	 	id: 'rsrchSearch',
	 	div: {
	 		gridDiv: '#rsrchSearch'
	 	},
	 	proxy: {
	 		url: './selectRsrUserInfo.do',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
		    // 페이징 사용
		   /*  usePaging : true,
		    pageRowCount : 5,
		    showPageButtonCount : 5, */
		    enableCellMerge : true,
		    showStateColumn: true,
		    reverseRowNum : true,
		    softRemoveRowMode  : true,
		    softRemovePolicy   : "exceptNew",
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
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
			dataField : "INSTT_CODE",
			headerText : "기관코드",
			editable : false,
			visible : false
		},{
			dataField : "HSPTL_NM",
			headerText : "연구기관",
			editable : false	
		},{
			dataField : "USER_NM",
			headerText : "연구자명",
			editable : false			
		},{
			dataField : "USER_ID",
			headerText : "ID",			
			editable : false
		},{
			dataField : "EMAIL",
			headerText : "E-mail",			
			editable : false			
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
	 		    data: {'USER_NM' : $("#txtInputRsrchNm").val(), 'HSPTL_NM' : $("#txtInputInstt").val() },//me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.result);
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
	rsrchSearch.createGrid();
	
	$("#btnClose").click(function(){
		layerClose();
	});
	
	$("#btnSearchTask").click(function(){
		rsrchSearch.load();
		$("#txtInputRsrchNm").val("");
		$("#txtInputInstt").val("");
	});
	
}); 





</script>
</head>
<body>
	<section class="popupWrap">
		<div class="popup wd800" >	
			<section class="conBox100 popup_conBox" style='margin:0px;'>
				<div class="popup_conBoxInner">		
									             
		            <table class="tb001">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="" />
						</colgroup>
		           		<tbody>
							<tr>					
								<th>연구기관</th>
                                <td>
                                    <input type="text" id="txtInputInstt" style="width:100%;">
                                </td>
                                <th>연구자명</th>
                                <td>                     	
                                    <input type="text" id="txtInputRsrchNm" style="width:70%;">
									<input type="button" id="btnSearchTask" value="검색" >
                                </td>  
							</tr>
						</tbody>
					</table>		
											
                    <article class="mgT15">					                   
                        <div id="rsrchSearch" class="gridHeiSz05 grid_wrap tb01_2"></div> 
                    </article>
                    		
					           		
           			<article class="mgT10">
						<div style="text-align:center">					
							<input type="button" id="btnClose" value="닫기" />
						</div>
					</article>
				
				</div>
			</section>
	    </div>
	</section>

</body>
</html>










