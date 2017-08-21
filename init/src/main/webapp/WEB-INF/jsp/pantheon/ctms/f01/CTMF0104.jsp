<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8"/>
<meta http-equiv="Content-Script-Type" content="text/javascript"/>
<meta http-equiv="Content-Style-Type" content="text/css"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>

<script type="text/javascript">
var openFileInfo;
var uploadFileNm;
var myGridID2 = {
	 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grClCode.id);
	 	id: '',
	 	//AUI그리드 생성할 div 및 페이징 옵션
	 	div: {
	 		gridDiv: '#myGridID2',
	 	},
	 	//데이터 연계 옵션
	 	proxy: {
	 		url: '/ctms/f01/selectContractPopUpList.do',
	 		//url: '/selectContractPopUpList.do',
	 		
	 		param: { FILE_MASTR_SN	: "${map.parent_value}"	},
	 		type: 'post',
	 		dataType: 'json',
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	//AUI 그리드 옵션
	 	gridPros: {
			'selectionMode': 'singleRow',
			'editable': true,
			//'showStateColumn': true,
		    headerHeight: 40,
		    rowHeight: 37,
		    width : 360,
		    height : 160
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
	 		dataField : "ORGINL_FILE_NM",
	 		headerText : "파일명",
	 		width : 200,
	 		editable : false
	 	},{
	 		dataField : "LAST_UPDDE",
	 		headerText : "등록일",
	 		//formatString : "yyyy/mm/dd",
	 		editable : false
	 		//width: 120
	 	}
	 	,{
	 		dataField : "ORGINL_EXTSN_NM",
	 		headerText : "확장자",
	 		editable : false,
	 		visible : false
	 	}
	 	,{
	 		dataField : "UPLOAD_FILE_NM",
	 		headerText : "upload된파일이름",
	 		editable : false,
	 		visible : false
	 	}
	 	,{
	 		dataField : "DWLD_PHYSIC_COURS",
	 		headerText : "다운로드경로",
	 		editable : false,
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
	 	//AUI 그리드 이벤트 
	 	binding: function() {
	 		var me = this;
	 		
	 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
	 			var flag = false;
	 			
	 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
	 			
	 			//uu_id 로 add 인지 아닌지 유효성 검사
	 			for(var i = 0; i < addedRowItems.length; i++) {
	 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
	 					flag = true;
	 				}
	 			}
	 			
	 			//현재 index가 0인지 아닌지 판단.(행추가 row는 상관이 없다.)
	 			if(AUIGrid.getSelectedIndex(me.id)[1] != 1) {
	 				flag = true;
	 			}
	 			return flag;
	 		});
	 		
	 		AUIGrid.bind(me.id, 'cellClick', function(event) {
	 			openFileInfo = event.item.DWLD_PHYSIC_COURS + "/" + event.item.ORGINL_FILE_NM + "." + event.item.ORGINL_EXTSN_NM;
	 			uploadFileNm = event.item.UPLOAD_FILE_NM; //upload시 파일이름
	 			openFileInfo = "system_layout.pdf";
	 			console.log("cellClick openFileInfo : "+openFileInfo);
	 			
// 				var param = {
// 						 pdf_info : openFileInfo
// 					};
// 				mkLayerPopupOpen("/ctms/f01/CTMF0105.do",param);

				fn_pdfViwer(openFileInfo);
	 		});
	 		
	 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
	 			openFileInfo = event.item.DWLD_PHYSIC_COURS + "/" + event.item.ORGINL_FILE_NM + "." + event.item.ORGINL_EXTSN_NM;
	 			uploadFileNm = event.item.UPLOAD_FILE_NM; //upload시 파일이름
	 			console.log("down openFileInfo : "+openFileInfo);
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
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.result);
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
	
$(document).ready(function(){
	myGridID2.createGrid();
	
	$("#btnClose").click(function(){
		layerClose();
	});
});

window.onresize = function() {
	if (typeof myGridID2.id !== "undefined") {
		AUIGrid.resize(myGridID2.id);
	}
}

//modal 팝업 생성
function fn_pdfViwer(val){	
	var url = './CTMF0105.do';
	var option = "dialogWidth:1000;dialogHeight:800px;status:no;help:no";    
	var arrVal =  new Array();
	arrVal[0] = val;
    window.showModalDialog(url,arrVal, option); 
}

</script>

</head>
<body> 		
	<section class="popupWrap">
		<div class="popup wd400">
			<section class="conBox100 popup_conBox" style="margin:0px;">
				<div class="popup_conBoxInner">
					<h6>계약서</h6>
				<article class="mgT5">
					<div id="myGridID2" class="gridHeiSz03 grid_wrap tb01_2"></div>
				</article>
				<article class="mgT20">
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