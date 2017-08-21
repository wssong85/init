<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title>CASUALITY</title>
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

<script type="text/javascript">
var HRMFLNS_CASE_CODE = "${HRMFLNS_CASE_CODE}";
var PRDUCT_CODE = "${PRDUCT_CODE}";
var FOLLOW_NO = "${FOLLOW_NO}";
var SOURCE_TYPE = "${SOURCE_TYPE}";
var SOURCE = "${SOURCE}";
var SITESUBJECT = "${SITESUBJECT}";
var MAFU_NO = "${MAFU_NO}";
var ids = new Array();
var vals = new Array();

function tabMove(url){
	ids[0]= "HRMFLNS_CASE_CODE";
	vals[0]= HRMFLNS_CASE_CODE;

	ids[1]= "PRDUCT_CODE";
	vals[1]= PRDUCT_CODE;
	
	ids[2]= "FOLLOW_NO";
	vals[2]= FOLLOW_NO;
	
	ids[3]= "SOURCE_TYPE";
	vals[3]= SOURCE_TYPE;
	
	ids[4]= "SOURCE";
	vals[4]= SOURCE;
	
	ids[5]= "SITESUBJECT";
	vals[5]= SITESUBJECT;
	
	ids[6]= "MAFU_NO";
	vals[6]= MAFU_NO;
	
	POSTSends(url, ids, vals);		
}

$(function() {
	setAccodian();
	
	
	btnInit();	
	init();
	setInit();
	
	grCasulity.createGrid();
});


function setInit(){	
	
	//$('#DrugHinput').hide();
}

function btnInit(){
	
	$('#tabDemographics').click(function() {
		var url = "/sdb/c02/SDBC0201.do";
		tabMove(url);
	});
	$('#tabMedicalhistory').click(function() {
		var url = "/sdb/c02/SDBC0202.do";
		tabMove(url);
	});
	$('#tabDrughistory').click(function() {
		var url = "/sdb/c02/SDBC0203.do";
		tabMove(url);
	});
	$('#tabAe').click(function() {
		var url = "/sdb/c02/SDBC0204.do";
		tabMove(url);
	});
	$('#tabLab').click(function() {
		var url = "/sdb/c02/SDBC0205.do";
		tabMove(url);
	});
	$('#tabDrug').click(function() {
		var url = "/sdb/c02/SDBC0206.do";
		tabMove(url);
	});
	$('#tabCasulity').click(function() {
		var url = "/sdb/c02/SDBC0207.do";
		tabMove(url);
	});
	$('#tabNarrative').click(function() {
		var url = "/sdb/c02/SDBC0208.do";
		tabMove(url);
	});
	$('#tabAssessment').click(function() {
		var url = "/sdb/c02/SDBC0209.do";
		tabMove(url);
	});
		
	$('#btnInit').click(function(){
		Applybtninit();
	});	
	
	
	$('#btnSave').click(function(){	
		if (!confirm('저장하시겠습니까?')) {
			return;
		}	
		
		updelform();			
	});	
	
	
	$('#btnExcel').click(function(){
		var data = AUIGrid.getGridData(grStudy.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grCasulity.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grCasulity.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
}


function init(){
	$("#hdhrmflns_case_code").val(HRMFLNS_CASE_CODE);
	$("#hdprduct_code").val(PRDUCT_CODE);
	$("#hdfollow_no").val(FOLLOW_NO);
	$("#hdmafu_no").val(MAFU_NO);
}

function Applybtninit(){
	$('#iform').each(function() {
		this.reset();
	});
	 	
	$('label[popup_type=Label]').text('');
	
}

function updelform(){
	var param = {
			TRGET_CODE 	: $("#hdmafu_no").val(), 
			TRGETNM 	: "Casuality",
			TRGET_MODE  : $('#mode').val(),
			UPDATE_ID	: '${loginMap.USER_ID}'						
		};
	mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
}

function saveform(){
	var arJson = [];
	
	// 추가된 행 아이템들(배열)
//		var addedRowItems = AUIGrid.getAddedRowItems(grCasulity.id);
	// 수정된 행 아이템들(배열)
	var editedItems = AUIGrid.getEditedRowItems(grCasulity.id);
	// 삭제된 행 아이템들(배열)
//		var removeItems = AUIGrid.getRemovedItems(grCasulity.id);
	
//		for(var i = 0; i < addedRowItems.length; i++) {
//			arJson.push(addedRowItems[i]);
//		}
	
	for(var i = 0; i < editedItems.length; i++) {
		editedItems[i].CURD = 'U';			
		editedItems[i].UPDATE_ID = '${loginMap.USER_ID}';
		arJson.push(editedItems[i]);
	}				

	if(!arJson.length) {
		alert('저장할 값이 없습니다.');
		return;
	}
	
	$.ajax({
		  url : '/sdb/c02/insertCasuality.do',
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(arJson),
		  success : function(data, textStatus, jqXHR) {
			  if(data.success) {
				  grCasulity.load()
			  } else {
				  AUIGrid.removeAjaxLoader(grCasulity.id);
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
		  }
	});
	
}

function saveLayer(p_mode){		
	saveform();				
}


var grCasulity = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grCasulity.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grCasulity',
    paging: {
      pagingDiv: 'grid_paging',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
	url: '/sdb/c02/selectCasualityList.do',
	param: {
		HRMFLNS_CASE_CODE : $('#hdhrmflns_case_code').val(),
		PRDUCT_CODE : $('#hdprduct_code').val()	,
		FOLLOW_NO : $('#hdfollow_no').val()
	},
    type: 'post',
    dataType: 'json',
    //페이징 true, false 로 지정
    paging: true,
    //처음 시작시 데이터 로딩
    autoLoad: true,
  },
  //AUI 그리드 옵션
  gridPros: {
    // 페이징 사용
    //usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    enableCellMerge : true,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    //showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",
    displayTreeOpen : true,
    groupingFields : ["TXT_ADVERSE_EVENT", "DRFSTFROLE_SE","MEDCIN_RECOED_NM"],
    showBranchOnGrouping : false,
    

  },
  //AUI 그리드 레이아웃
  
  columnLayout : [{
    dataField : "TXT_ADVERSE_EVENT",
    headerText : "Adverse Event",    
    //cellMerge : true,
    width : '10%'
  },{
    dataField : "DRFSTFROLE_SE",
    headerText : "Drug Role",
    //cellMerge : true
  },{
    dataField : "MEDCIN_RECOED_NM",
    headerText : "Brand(Generic) Name",
    //cellMerge : true
  },{
	headerText:"Relatedness(Reporter)#1",
	dataField : "REPORTR_RELATION_ONE",
// 	children :[{
// 		dataField : "REPORTR_RELATION",
// 	    headerText : "Relatedness(Reporter)#2"	
// 	}],
	labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
		var me = grCasulity;
		var retStr = "";
		
		for(var i = 0; i < me.columnLayout[3].editRenderer.list.length; i++) {
			if(me.columnLayout[3].editRenderer.list[i]['CMMN_CODE'] == value) {
				retStr = me.columnLayout[3].editRenderer.list[i]['CMMN_CODE_NM'];
				break;
			}
		}
		
		if(retStr) {
			return retStr;	
		} else {
			return value;
		}
	},
	editRenderer : {
		type : "DropDownListRenderer",
		showEditorBtnOver: true,
		list : null,
		keyField : "CMMN_CODE",
		valueField : "CMMN_CODE_NM"
	}  
  },{
		headerText:"Relatedness(Reporter)#2",
		dataField : "REPORTR_RELATION_TWO",
//	 	children :[{
//	 		dataField : "REPORTR_RELATION",
//	 	    headerText : "Relatedness(Reporter)#2"	
//	 	}],
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			var me = grCasulity;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[4].editRenderer.list.length; i++) {
				if(me.columnLayout[4].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[4].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			
			if(retStr) {
				return retStr;	
			} else {
				return value;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : null,
			keyField : "CMMN_CODE",
			valueField : "CMMN_CODE_NM"
		}  
	  },{
		headerText:"Relatedness(Sponsor)#1",
		dataField : "SPON_RELATION_ONE",
		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			var me = grCasulity;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[5].editRenderer.list.length; i++) {
				if(me.columnLayout[5].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[5].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			
			if(retStr) {
				return retStr;	
			} else {
				return value;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : null,
			keyField : "CMMN_CODE",
			valueField : "CMMN_CODE_NM"
		}  
	  },{
		headerText:"Relatedness(Sponsor)#2",
		dataField : "SPON_RELATION_TWO",

		labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
			var me = grCasulity;
			var retStr = "";
			
			for(var i = 0; i < me.columnLayout[6].editRenderer.list.length; i++) {
				if(me.columnLayout[6].editRenderer.list[i]['CMMN_CODE'] == value) {
					retStr = me.columnLayout[6].editRenderer.list[i]['CMMN_CODE_NM'];
					break;
				}
			}
			
			if(retStr) {
				return retStr;	
			} else {
				return value;
			}
		},
		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : null,
			keyField : "CMMN_CODE",
			valueField : "CMMN_CODE_NM"
		} 
	  
  },{
    dataField : "AE_INFO",
    headerText : "AE_INFO",    
    visible : false
  },{
    dataField : "MEDCIN_INFO_NO",
    headerText : "MEDCIN_INFO_NO",    
    visible : false
  }], 


  createGrid: function() {
		var me = this;
		//이후 객체.id 로 AUIGrid 컨트롤
		$.ajax({
			url : '/com/common/selectQueryDataList.do',
			type: 'post',
			dataType: 'json',
			data:{'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'SDB025'},
			success : function(data) {
				if(data.success) {
					me.columnLayout[3].editRenderer.list = data.result;
					me.columnLayout[5].editRenderer.list = data.result;
				} else {
			    	alert(data.message);
			    }
			},
			error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
			}
		});
		
		$.ajax({
			url : '/com/common/selectQueryDataList.do',
			type: 'post',
			dataType: 'json',
			data:{'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'SDB026'},
			success : function(data) {
				if(data.success) {
					me.columnLayout[4].editRenderer.list = data.result;
					me.columnLayout[6].editRenderer.list = data.result;
				} else {
			    	alert(data.message);
			    }
			},
			error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
			}
		});
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);		
		 
		
		me.binding();
		
		if(me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 이벤트 
	binding: function() {
		var me = this;
		
	},
	//AUI 그리드 데이터 요청
	load: function(v1, v2) {
		var me = this;
		var param = {
			HRMFLNS_CASE_CODE : $('#hdhrmflns_case_code').val(),
			PRDUCT_CODE : $('#hdprduct_code').val()	,
			FOLLOW_NO : $('#hdfollow_no').val()
		};
		AUIGrid.showAjaxLoader(me.id);
		$.ajax({
		    url: me.proxy.url,
		    type: me.proxy.type,
		    dataType: me.proxy.dataType,
		    data: param,
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



window.onresize = function() {
if (typeof grCasulity.id !== "undefined") {
 AUIGrid.resize(grCasulity.id);
 }
};

function setAccodian(){
	 for(var ai=0; ai<3; ai++){
	    aiP = ai+1;
	
		(function(aiE){ 
			$(".accordion_0"+aiE+" > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".accordion_con_0"+aiE+"").slideToggle(20);
					$(this).toggleClass('open');
					//그리드 리사이징
					//AUIGrid.resize(grCasulity.id);
				}
			});

			$(".accordion_con_02").css({"display":""});
			$(".accordion_con_03").css({"display":"none"});
		
		})(aiP); //반복문 적용끝
	
	} //반복문끝
}


</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>이상사례</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>이상사례</li>
					</ul>
				</nav>
			</article>

            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">

					<div class="button_tab_01">
						<ul>
							<li id="tabDemographics" class="tab_menu">DEMOGRAPHICS</li>
							<li id="tabMedicalhistory" class="tab_menu">MEDICAL HISTORY</li>
							<li id="tabDrughistory" class="tab_menu">DRUG HISTORY</li>
							<li id="tabAe" class="tab_menu">AE</li>
							<li id="tabLab" class="tab_menu">LAB</li>
							<li id="tabDrug" class="tab_menu">DRUG</li>
							<li id="tabCasulity" class="port_back tab_menu">CASUALITY</li>
							<li id="tabNarrative" class="tab_menu">NARRATIVE</li>
							<li id="tabAssessment" class="tab_menu">ASSESSMENT</li>
						</ul>
					</div>

					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="btnInit" value="초기화">
						<input type="button" id="btnSave" value="저장">						
						<input type="button" id="btnExcel" value="엑셀">
						<input type="button" id="btnAudit" value="내역">
					</article>

 					<article class="mgT16" style="margin-bottom: 16px;">
                        <div id="grCasulity" class="gridHeiSz15 grid_wrap tb01_2"></div>
                        <!-- <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
                    </article>
                    <input type="hidden" id="hdhrmflns_case_code" />
					<input type="hidden" id="hdprduct_code" />
					<input type="hidden" id="hdfollow_no" />
					<input type="hidden" id="hdmafu_no" />					
					<input type="hidden" id="mode" />
					
                    <form id="iform">
					<ul class="mgT20" id="DrugHinput">
					    <li class="accordion_02">					    
					        <div class="accordion_con_02">
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap" class="gridHeiSz04 grid_wrap tb01_2"></div>
					                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
					                    </div>
					                </li>
					            </ul>


					        </div>
					    </li>
	
					    
					</ul>
					</form>		
				</div>
            </section>

		</div>
	</section>
	
</div>
</body>
</html>