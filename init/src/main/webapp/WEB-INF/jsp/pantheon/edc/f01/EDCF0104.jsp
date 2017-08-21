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
console.log("taskSn : "+taskSn);
var grid_crfList = {
	 	id: '',
	 	div: {
			gridDiv : 'grid_crfList',
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
			url : './selectEdcCfGroup.do',
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
							dataField : "INSTT_FORM_SN",
							headerText : "Instt Form Sn",
							editable : false,
							visible : false
						},{ 
							dataField : "VISIT_SN",
							headerText : "Visit Sn",
							editable : false,
							visible : false
						},{ 
							dataField : "SN",
							headerText : "Sn",
							editable : false,
							visible : false
						},{ 
							dataField : "VISIT_GROUP_SN",
							headerText : "Visit Group Sn",
							editable : false,
							visible : false
						},{ 
							dataField : "INSTT_NM",
							headerText : "Site",
							editable : false,
							filter : {
								showIcon : true
							}
						},{ 
							dataField : "SUBJECT_NO",
							headerText : "Subject",
							editable : false,
							filter : {
								showIcon : true
							}
						},{ 
							dataField : "VISIT_LBL",
							headerText : "Visit",
							editable : false,
							filter : {
								showIcon : true
							}
						},{ 
							dataField : "CRF_LBL",
							headerText : "CRF",
							editable : false,
							filter : {
								showIcon : true
							}
						},{ 
							dataField : "OPEN_QUERY",
							headerText : "Open query",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SDV_STTUS_NM",
							headerText : "SDV",
							editable : false,
							filter : {
								showIcon : true
							}
						},{
							dataField : "SDV_COMPT_STTUS_NM",
							headerText : "SDV Completion",
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
	 		
	 		fn_load(me, v1, v2);
	 	}
	};	
	
$(function(){

	$("#frm_main #TASK_SN").val(taskSn);
	
	grid_crfList.createGrid();

	
	//검색버튼 클릭
	$('#btnSearch').click(function(){
		var params = {
		};
		
		params.INSTT_NM = $('#INSTT_NM').val();
		params.SUBJECT_NO = $('#SUBJECT_NO').val();
		params.TASK_SN = $('#TASK_SN').val();
		
		grid_crfList.proxy.param = params;
		grid_crfList.load();
	})
});

//SDV, 해제 버튼 클릭
function fn_sdvPrcss(v){

	console.log("fn_sdvPrcss");
	
	var items = AUIGrid.getCheckedRowItems(grid_crfList.id);
	if(items.length <= 0){
		alert("Site를 선택해 주세요.");
		return;
	}
	
	var arJson = [];		
	
	// 선택된 행 아이템들(배열)		
	var editedItems = AUIGrid.getCheckedRowItems(grid_crfList.id);

	for(var i = 0; i < editedItems.length; i++) {
		
		var sdvSttus = editedItems[i].item.SDV_STTUS_CODE;
		
		console.log("sdv : "+sdvSttus);	
		if(v=="sdv"){
			if(sdvSttus == "03"){
				alert("SDV 완료 된 Site가 포함되어 있습니다.");
				return;
			}
			
			editedItems[i].item.SDV_STTUS_CODE = "03";
		}else if(v=='sdvCncl'){
			if(sdvSttus == "01"){
				alert("SDV 해제된 Site가 포함되어 있습니다.");
				return;
			}
			editedItems[i].item.SDV_STTUS_CODE = "01";
		}
		arJson.push(editedItems[i].item);
	}		
	console.log("before class");
	$.ajax({
		  url : './updateSdvSttusBySite.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {
			  if(data.success) {					
				  grid_crfList.load();			
			  } else {
				  AUIGrid.removeAjaxLoader(grid_crfList.id);
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
}


//SDV Completion, 해제  버튼 클릭
function fn_sdvCmplPrcss(v){

	console.log("fn_sdvPrcss");
	
	var items = AUIGrid.getCheckedRowItems(grid_crfList.id);
	if(items.length <= 0){
		alert("Site를 선택해 주세요.");
		return;
	}
	
	var arJson = [];		
	
	// 선택된 행 아이템들(배열)		
	var editedItems = AUIGrid.getCheckedRowItems(grid_crfList.id);

	for(var i = 0; i < editedItems.length; i++) {
		
		var sdvCmplSttus = editedItems[i].item.SDV_COMPT_STTUS_CODE;
		console.log("sdv : "+sdvCmplSttus);	
		if(v=='sdvCmpl'){
			if(sdvCmplSttus == "03"){
				alert("SDV Completion 된 Site가 포함되어 있습니다.");
				return;
			}
			editedItems[i].item.SDV_COMPT_STTUS_CODE = "03";			
		}else if(v=='sdvCmplCncl'){
			if(sdvCmplSttus == "01"){
				alert("SDV Completion 해제된 Site가 포함되어 있습니다.");
				return;
			}
			editedItems[i].item.SDV_COMPT_STTUS_CODE = "01";			
		}
		arJson.push(editedItems[i].item);
	}		
	console.log("before class");
	$.ajax({
		  url : './updateSdvCmplSttusBySite.do' ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {
			  if(data.success) {					
				  grSiteList.load();			
			  } else {
				  AUIGrid.removeAjaxLoader(grid_crfList.id);
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
}

window.onresize = function(){
	if(grid_crfList.id !== "undefine"){
		AUIGrid.resize(grid_crfList.id);
	}
}

</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCF0104&&UPPER_MENU_ID=EDCF" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCF0104&&UPPER_MENU_ID=EDCF" charEncoding="utf-8"/>
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
							<li id="tab_01" class="tab_menu" onclick="fn_moveTab('EDCF0101');">Site</li>
							<li id="tab_02" class="tab_menu" onclick="fn_moveTab('EDCF0102');">Subject</li>
							<li id="tab_03" class="tab_menu" onclick="fn_moveTab('EDCF0103');">Visit</li>
							<li id="tab_04" class="port_back tab_menu">CRF</li>
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
							<input type="button" value="SDV" onclick="fn_sdvPrcss('sdv')">
							<input type="button" value="SDV 해제" onclick="fn_sdvPrcss('sdvCncl')">
							<input type="button" value="SDV Completion" onclick="fn_sdvCmplPrcss('sdvCmpl')">
							<input type="button" value="SDV Completion 해제" onclick="fn_sdvCmplPrcss('sdvCmplCncl')">
						</div>
					</article>
 					<article class="mgT16">
                        <div id="grid_crfList" class="gridHeiSz15 grid_wrap tb01_2"></div>
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    <form id="frm_main" name="frm_main">
						<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
						<input type="hidden" id="EDC_VER" name="TASK_SN" value="${ EDC_VER }">
					</form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>


</html>