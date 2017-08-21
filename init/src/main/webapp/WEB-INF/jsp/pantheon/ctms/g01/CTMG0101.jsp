<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<style type="text/css">
/* table.tb01{ */
/* 	width: 70% */
/* } */
</style>
<title>연구자등록</title>
<script type="text/javascript">
var roleCode;
var standardTime;
var userId= '${loginMap.USER_ID}';
var paramItems;
var insertCnt = "0"; //0:저장 1: 수정 2:삭제
var confmSe; //과제별 연구자 승인여부 01:신규 02:요청 03:승인 04:반려
var grRsrchuser = {
 	id: '',
 	div: {
 		gridDiv: '#grRsrchuser'
 		
 	},
 	
 	proxy: {
 		url: '/ctms/g01/selectRsrchuserList.do',
 		param: {SEARCH_TYPE : $("#SEARCH_TYPE").val(), SEARCH_COND : $("#SEARCH_COND").val()},
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: true
 	},
 	gridPros: {
 		usePaging : true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "singleRows",

	    displayTreeOpen : true
 	},
 	columnLayout : [{
 		dataField : "TASK_SN",
 		headerText : "과제순번"
 		, visible : false
 	},{
 		dataField : "INSTT_CD",
 		headerText : "기관코드"
 		, width: 90
 	},{
 		dataField : "INSTT_NM",
 		headerText : "기관명"
 	},{
 		dataField : "REGIO",
 		headerText : "지역"
 		, width: 90
 	},{
 		dataField : "ORT01",
 		headerText : "시/도"
 	},{
 		dataField : "TASK_NO",
 		headerText : "과제번호"
 		, width: 90
 	},{
 		dataField : "USER_NM",
 		headerText : "연구자명"
 		, width: 80
 	},{
 		dataField : "ROLE_NM",
 		headerText : "Role"
 		, width: 80
 	},{
 		dataField : "USER_ID",
 		headerText : "ID"
 		, width: 100
 	},{
 		dataField : "EMAIL",
 		headerText : "e-mail"
 	},{
 		dataField : "TELNO",
 		headerText : "전화번호"
 		, width: 120
 	},{
 		dataField : "CONFM_SE",
 		headerText : "상태",
 		width: 100,
 		labelFunction : function( rowIndex, columnIndex, value, headerText, item ) {
			var me = grRsrchuser;
			var retStr = "";
			
			for(var i=0; me.columnLayout[11].editRenderer.list.length > i; i++) {
				if(me.columnLayout[11].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[11].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			return retStr == "" ? value : retStr;
	    },
	    editRenderer : {
 			type : "DropDownListRenderer",
 			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
 			list : null,
 			keyField : "CMMN_CODE",
 			valueField : "CMMN_CODE_NM"
 		 }
 	},{
 		dataField : "STRAS",
 		headerText : "주소 상세",
 		width: 100,
 		visible : false
 	},{
 		dataField : "PSTLZ",
 		headerText : "우편번호",
 		width: 100,
 		visible : false
 	},{
 		dataField : "ROLE_ID",
 		headerText : "ROLE_ID",
 		width: 100,
 		visible : false
 	},{
 		dataField : "USER_ENGNM",
 		headerText : "영문명",
 		width: 100,
 		visible : false
 	},{
 		dataField : "STD_TIME_SN",
 		headerText : "표준시간대",
 		width: 100,
 		visible : false
 	}],
 	createGrid: function() {
 		var me = this;
   		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 		AUIGrid.bind(me.id, "cellDoubleClick", function(event){
 			var param = {};
 			paramItems = event.item; 			
 			mkLayerPopupOpen("/ctms/g01/popupCTMG0102.do", param);
 			fn_popupDetail();
 			insertCnt = "1";
 			
 		});
 	},
 	load: function(v1, v2) {
 		var me = this; 		
 		
 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 		    		roleCode = data.roleCode;
 		    		standardTime = data.stdTime;
 		    		me.columnLayout[11].editRenderer.list = data.ctms030;
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

$(function(){

	grRsrchuser.createGrid();

	$('#SEARCH_COND').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#SEARCH_COND').val()) {
			$('#btnSearch').trigger('click');
		}
	});
	
	$('#btnSearch').click(function() {
		var params = {
				'SDATE': $('#txtStartDate').val(),
				'EDATE': $('#txtEnd').val(),
				'USER_NM': $('#txtUserNm').val(),
				'USER_SE_CODE': $('#selectModules').val(),
				'SEARCH_TYPE' : $("#SEARCH_TYPE").val(),
				'SEARCH_COND' : $("#SEARCH_COND").val()
			};
			
		grRsrchuser.proxy.param = params;
		grRsrchuser.load();
	});
	
	$('#btnCmDtaAtrailSearch').click(function() {
		
	});
	
	$("#btnNew").click(function(){		
		var param = {};
		mkLayerPopupOpen("/ctms/g01/popupCTMG0102.do", param);
		fn_popupNew();
	});
	
});

//입력 팝업이 저장되면 그리드 로드
function fn_GridLoad(){
	grRsrchuser.load();
}

$(window).on('resize', function(){
	if (grRsrchuser.id) {
		AUIGrid.resize(grRsrchuser.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=COMG0101&&UPPER_MENU_ID=CTMG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=COMG0101&&UPPER_MENU_ID=CTMG" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
	<section id="mainCon">
		 <div class="mainConInner">
		
			
            <article class="mainTitBox">
                <h3>연구자등록</h3>

                <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">연구자 관리</a></li>
                        <li><a href="#">연구자 등록</a></li>
                    </ul>
                </nav>
            </article>
            <section class="conBox100 conBox">
			<div class="conBoxInner">
				
                <!-- 컨텐츠 타이틀 시작-->
                <article class="conTitBox">
                    <h5>${TASK_NO}</h5>
                </article>
                <!-- 컨텐츠 타이틀 끝-->

                <!-- 상단 그리드 전체메뉴라인 시작-->        
                <article class="conTitBtn">

                    <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                    <div class="conTitBtnL">
						<select id="SEARCH_TYPE" class="select">
							<option value="1" >기관명</option>
							<option value="2" >연구자명</option>
						</select>
                        <input type="text" id="SEARCH_COND" name="SEARCH_COND" class="pdR15"><input type="button" id="btnSearch" class="btn mgL3" value="검색">
                    </div>
                    <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <div class="conTitBtnR">
                        <input type="button" id="btnNew" value="신규">                        
                    </div>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                </article>
                <!-- 상단 그리드 전체메뉴라인 끝--> 
				
				<article class="mgT55">
					<div id="grRsrchuser" class="gridHeiSz17 grid_wrap tb01_2"></div>
					
				</article>
			</div>
		</section>
		</div>
	</section>
</div>
</body>
</html>