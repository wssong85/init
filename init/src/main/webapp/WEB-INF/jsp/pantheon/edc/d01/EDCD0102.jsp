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
			url : './selectQueryListByOpen.do',
			param : {'TASK_SN':taskSn},
	 		type: 'post',
	 		dataType: 'json',
	 		paging: false,
	 		autoLoad: true
	 	},
	 	gridPros: {
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    
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
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SUBJECT_NO",
							headerText : "Subject",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "VISIT_LBL",
							headerText : "Visit",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "GROUP_LBL",
							headerText : "CRF",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "VRBL",
							headerText : "Variable",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "QUERY_STTUS_CODE",
							headerText : "Status",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "QUERY_TY_CODE",
							headerText : "Type",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "ROLE_NM",
							headerText : "Role",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "FRST_CRTR",
							headerText : "Issue",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "LAST_UPDUSR",
							headerText : "Modifier",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "QUERY_CN",
							headerText : "Query",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "RESN",
							headerText : "Reason",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "LAST_UPDDE",
							headerText : "Mod Date",
							width: 120,
							editable : false,
							filter : {
								showIcon : true
							}
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
			    url : './selectQueryListByOpen.do' ,//변경
			    type: 'post',
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 		    		console.log("data.result : "+data.result);
	 			    	AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						irbBasicInfo = data.result;
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
	
$(document).ready(function(){

	grid_qrList.createGrid();
	
	// 양식 다운로드
	$('.popup_01').click(function(){
		alert("1");
		$.ajax({
			url : './selectDownTemplate.do',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				//location.href="./COMZ0201_DOWN.do?MstrSn=" + data.result;
				// location.href="./selectCdiscExcelChk.do?MstrSn=" + data.result; 
// 				if(data.success) {
// 					location.replace("./COMZ0201_DOWN.do?MstrSn=" + data.result);
// 				}
				if(data.success) {
					alert("성공!");
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
		mkLayerPopupOpen("/edc/d01/popupEDCD0105.do", param);
	});
	
	//검색버튼 클릭
	$('#btnSearch').click(function(){
		var params = {
		};
		
		params.INSTT_NM = $('#INSTT_NM').val();
		params.SUBJECT_NO = $('#SUBJECT_NO').val();
		
		grid_qrList.proxy.param = params;
		grid_qrList.load();
	})
	
});

</script>

</head>


<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCD0102&&UPPER_MENU_ID=EDCD" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCD0102&&UPPER_MENU_ID=EDCD" charEncoding="utf-8"/>
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
							<li id="tab_01" class="tab_menu" onclick="fn_moveTab('EDCD0101');">예비</li>
							<li id="tab_02" class="port_back tab_menu">오픈</li>
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
							<input type="button" value="일괄처리">
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