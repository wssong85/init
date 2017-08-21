<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false" />
<title>[NARRATIVE] 등록/수정/삭제</title>
<script type="text/javascript">
var CASE_DC_SN = "${CASE_DC_SN}";

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
		setInit();
		init();
		
		grNarrative_Q.createGrid();
		
	});

	function btnInit() {
		$('input[popup_type=Q]').click(function(){
			alert('쿼리팝업');
			return false;
		});	
		
		$('button[popup_type=ProductSearch], input[popup_type=ProductSearch]').click(function(){
			mkLayerPopupOpen("/sdb/b02/popupSDBB0204.do", null);
			if (typeof grProductList_Search.id !== "undefined") {
				AUIGrid.resize(grProductList_Search.id);
			}
			return false;
		});	
		
		
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

		$('#btnInit').click(function() {
			var check_code = $("#txtEtcno").val();
			$('#iform').each(function() {
				this.reset();
			});
			
			$('label[popup_type=Label]').text('');
			$("#txtEtcno").val(check_code);
		});

		$('#btnSave').click(function() {

			if (!mkValidation()) {
				return;
			}	
			if (!confirm('저장하시겠습니까?')) {
				return;
			}
			if ( $.trim($("#mode").val()) == 'U') {
				updelform();
			}else{
				saveform();
			}
		});

		$('#btnDel').click(function() {
			if ($('#mode').val() == 'U') {
				if (!confirm('삭제하시겠습니까?')) {
					return;
				}
				$('#mode').val('D');
				updelform();
			}t
		});

		$('#btnAudit').click(function() {
			alert('Audit팡법');
			
			return false;
		});
		
		
	}
	
	function updelform(){
		var param = {
				TRGET_CODE 	: $("#hdmafu_no").val(), 
				TRGETNM 	: "NAR",
				TRGET_MODE  : $('#mode').val(),
				UPDATE_ID	: '${loginMap.USER_ID}'						
			};
		mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);	
	}
	
	function saveform(){
		var params = {
				CURD 					: $.trim($("#mode").val()),
				HRMFLNS_CASE_CODE		: $.trim($("#hdhrmflns_case_code").val()),
				PRDUCT_CODE				: $.trim($("#hdprduct_code").val()),
				FOLLOW_NO				: $.trim($("#hdfollow_no").val()),
				CASE_DC_SN				: $.trim($("#hdcase_dc_sn").val()),
				HRMFLNS_CASE_DC 		: $.trim($("#hdhrmflns_case_dc").val()),
				HRMFLNS_CASE_DC_KOR 	: $.trim($("#txthrmflns_case_dc").val()),
				HRMFLNS_CASE_DC_ENG 	: $.trim($("#txthrmflns_case_dc_eng").text()),
				REPORTR_OPINION 		: $.trim($("#hdreportr_opinion").val()),
				REPORTR_OPINION_KOR 	: $.trim($("#txtreportr_opinion").val()),
				REPORTR_OPINION_ENG 	: $.trim($("#txtreportr_opinion_eng").text()),
				APLCNT_OPINION 			: $.trim($("#hdaplcnt_opinion").val()),
				APLCNT_OPINION_KOR 		: $.trim($("#txtaplcnt_opinion").val()),
				APLCNT_OPINION_ENG 		: $.trim($("#txtaplcnt_opinion_eng").text()),
				DIFR_INFO 				: $.trim($("#hddifr_info").val()),
				DIFR_INFO_KOR 			: $.trim($("#txtdifr_info").val()),
				DIFR_INFO_ENG 			: $.trim($("#txtdifr_info_eng").text()),
				RSRCH_NM 				: $.trim($("#hdrsrch_nm").val()),
				RSRCH_NM_KOR 			: $.trim($("#txtrsrch_nm").val()),
				RSRCH_NM_ENG 			: $.trim($("#txtrsrch_nm_eng").text()),
				SPON_RSRCH_NO 			: $.trim($("#txtspon_rsrch_no").val()),
				RESPNS_OBSERV_RSRCH_TY 	: $.trim($("#slrespns_observ_rsrch_ty").val()),
				UPDATE_ID 				: '${loginMap.USER_ID}'
			};

			$.ajax({
				url : '/sdb/c02/insertNarrativeInfo.do',
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						window.location.reload();
					} else {
						alert(data.errmsg);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		
	}
	
	function saveLayer(p_mode){		
		saveform();				
	}
	
	
	
	function setInit(){
		<c:forEach var="result" items="${printType}" varStatus="status">
			$("#slrespns_observ_rsrch_ty").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
		</c:forEach>

		$("#txthrmflns_case_dc").attr("maxlength", 5000);
		$("#txtreportr_opinion").attr("maxlength", 5000);
		$("#txtaplcnt_opinion").attr("maxlength", 5000);
		$("#txtdifr_info").attr("maxlength", 5000);
		$("#txtrsrch_nm").attr("maxlength", 100);
		$("#txtspon_rsrch_no").attr("maxlength", 30);		
		
		$("input[popup_type=Q]").attr("title", "Query");
		$("input[popup_type=E]").attr("title", "English Notation");
		
	}
	function init() {
		$("#hdhrmflns_case_code").val(HRMFLNS_CASE_CODE);
		$("#hdprduct_code").val(PRDUCT_CODE);
		$("#hdfollow_no").val(FOLLOW_NO);
		$("#hdmafu_no").val(MAFU_NO);
		$("#mode").val('C');

			var params = {
					HRMFLNS_CASE_CODE : HRMFLNS_CASE_CODE,
					PRDUCT_CODE : PRDUCT_CODE,
					FOLLOW_NO : FOLLOW_NO
			};
			$.ajax({
				type : "post",
				url : "/sdb/c02/selectNarrativeInfo.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						if(data.result != null){
							var txtcase_dc_sn 				= (isNull(data.result.CASE_DC_SN)) ? '': data.result.CASE_DC_SN;
							var txthrmflns_case_dc 			= (isNull(data.result.HRMFLNS_CASE_DC)) ? '': data.result.HRMFLNS_CASE_DC;
							var txthrmflns_case_dc_kor		= (isNull(data.result.HRMFLNS_CASE_DC_KOR)) ? '': data.result.HRMFLNS_CASE_DC_KOR;
							var txthrmflns_case_dc_eng 		= (isNull(data.result.HRMFLNS_CASE_DC_ENG)) ? '': data.result.HRMFLNS_CASE_DC_ENG;
							var txtreportr_opinion 			= (isNull(data.result.REPORTR_OPINION)) ? '': data.result.REPORTR_OPINION;
							var txtreportr_opinion_kor 		= (isNull(data.result.REPORTR_OPINION_KOR)) ? '': data.result.REPORTR_OPINION_KOR;
							var txtreportr_opinion_eng 		= (isNull(data.result.REPORTR_OPINION_ENG)) ? '': data.result.REPORTR_OPINION_ENG;
							var txtaplcnt_opinion 			= (isNull(data.result.APLCNT_OPINION)) ? '': data.result.APLCNT_OPINION;
							var txtaplcnt_opinion_kor 		= (isNull(data.result.APLCNT_OPINION_KOR)) ? '': data.result.APLCNT_OPINION_KOR;
							var txtaplcnt_opinion_eng 		= (isNull(data.result.APLCNT_OPINION_ENG)) ? '': data.result.APLCNT_OPINION_ENG;
							var txtdifr_info 				= (isNull(data.result.DIFR_INFO)) ? '': data.result.DIFR_INFO;
							var txtdifr_info_kor 			= (isNull(data.result.DIFR_INFO_KOR)) ? '': data.result.DIFR_INFO_KOR;
							var txtdifr_info_eng 			= (isNull(data.result.DIFR_INFO_ENG)) ? '': data.result.DIFR_INFO_ENG;
							var txtrsrch_nm 				= (isNull(data.result.RSRCH_NM)) ? '': data.result.RSRCH_NM;
							var txtrsrch_nm_kor 			= (isNull(data.result.RSRCH_NM_KOR)) ? '': data.result.RSRCH_NM_KOR;
							var txtrsrch_nm_eng 			= (isNull(data.result.RSRCH_NM_ENG)) ? '': data.result.RSRCH_NM_ENG;
							var txtspon_rsrch_no 			= (isNull(data.result.SPON_RSRCH_NO)) ? '': data.result.SPON_RSRCH_NO;
							var txtrespns_observ_rsrch_ty 	= (isNull(data.result.RESPNS_OBSERV_RSRCH_TY)) ? '': data.result.RESPNS_OBSERV_RSRCH_TY;
							
							$("#hdhrmflns_case_code").val(HRMFLNS_CASE_CODE);
							$("#hdprduct_code").val(PRDUCT_CODE);
							$("#hdcase_dc_sn").val(txtcase_dc_sn);
							$("#hdhrmflns_case_dc").val(txthrmflns_case_dc);
							$("#txthrmflns_case_dc").val(txthrmflns_case_dc_kor);
							$("#txthrmflns_case_dc_eng").text(txthrmflns_case_dc_eng);
							$("#hdreportr_opinion").val(txtreportr_opinion);
							$("#txtreportr_opinion").val(txtreportr_opinion_kor);
							$("#txtreportr_opinion_eng").text(txtreportr_opinion_eng);
							$("#hdaplcnt_opinion").val(txtaplcnt_opinion);
							$("#txtaplcnt_opinion").val(txtaplcnt_opinion_kor);
							$("#txtaplcnt_opinion_eng").text(txtaplcnt_opinion_eng);
							$("#hddifr_info").val(txtdifr_info);
							$("#txtdifr_info").val(txtdifr_info_kor);
							$("#txtdifr_info_eng").text(txtdifr_info_eng);
							$("#hdrsrch_nm").val(txtrsrch_nm);
							$("#txtrsrch_nm").val(txtrsrch_nm_kor);
							$("#txtrsrch_nm_eng").text(txtrsrch_nm_eng);
							$("#txtspon_rsrch_no").val(txtspon_rsrch_no);
							$("#slrespns_observ_rsrch_ty").val(txtrespns_observ_rsrch_ty);
							$("#mode").val("U"); // 여기부터 해야함~~
						
						}
						
						
							
					} else {
						alert(data.errmsg);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert("실패");
				}
			});
		//}

	}
	
	function setAccodian(){
		 for(var ai=0; ai<3; ai++){
		    aiP = ai+1;
		
			(function(aiE){ 
				$(".accordion_0"+aiE+" > a").on("click",function() {
					if ($(this).hasClass("close")) {
						$(this).siblings(".accordion_con_0"+aiE+"").slideToggle(20);
						$(this).toggleClass('open');
						//그리드 리사이징
						AUIGrid.resize(grNarrative_Q.id);
					}
				});
// 				if ( aiE !=2 ) {
// 					$(".acdMenuLst0"+aiE+"").not(this).on("click",function() {
// 						if ($(".acdMenuLst0"+aiE+"").not(this).children().hasClass("close")) {
// 							$(".acdMenuLst0"+aiE+"").not(this).children(".acdMenuCts0"+aiE+"").slideUp(500);
// 						}
// 					});
					
// 					$(".acdMenuLst0"+aiE+" > a").not(this).on("click",function() {
// 						if ($(".acdMenuLst0"+aiE+" > a").hasClass('open')) {
// 							$(".acdMenuLst0"+aiE+" > a").not(this).removeClass('open');
// 						}
// 					});
// 				} //조건문끝
				$(".accordion_con_02").css({"display":"none"});
				$(".accordion_con_03").css({"display":"none"});
			
			})(aiP); //반복문 적용끝
		
		} //반복문끝
	}


	window.onresize = function() {
		if (typeof grNarrative_Q.id !== "undefined") {
			AUIGrid.resize(grNarrative_Q.id);
		}

	}

	var grNarrative_Q = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grNarrative_Q.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#grNarrative_Q',
			
		},
		//데이터 연계 옵션
		proxy : {
			url : '/sdb/c01/selectEtcList.do',
			param : {
				PRDUCT_CODE : $('#hdprduct_code').val()
			},
			type : 'post',
			dataType : 'json',
			//페이징 true, false 로 지정
			paging : false,
			//처음 시작시 데이터 로딩
			autoLoad : true
		},
		//AUI 그리드 옵션
		gridPros : {
			'selectionMode' : 'singleRow',
			'editable' : false,
			usePaging : false,
			enableFilter : true,
			pageRowCount : 10,
			showPageButtonCount : 10,
			headerHeight : 40,	
			rowHeight : 37
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "ETC_INFO_NO",
			headerText : "쿼리번호",
			width : 200,
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "SOURC",
			headerText : "Category",
			width : 300,
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "AE_COUNT",
			headerText : "Variable",
			width : 120,
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "ADR_COUNT",
			headerText : "쿼리내용",
			width : 120,
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "UAE_COUNT",
			headerText : "ID",
			width : 120,
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "SAE_COUNT",
			headerText : "등록자",
			width : 120,
			filter : {
	 			showIcon : true
	 		}
		} , {
			dataField : "PRDUCT_CODE",
			headerText : "등록자",
			visiable : false
		}, {
			dataField : "PRDUCTNM_CODE",
			headerText : "등록자",
			visiable : false
		}],
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;

			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid
					.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			AUIGrid.bind(me.id, "cellDoubleClick",
					auiGridCellDoubleClickHandler);
			me.binding();

			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;

		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			var param = {
				PRDUCT_CODE : $('#hdprduct_code').val()
			};
			AUIGrid.showAjaxLoader(me.id);
			$.ajax({
				url : me.proxy.url,
				type : me.proxy.type,
				dataType : me.proxy.dataType,
				data : param,
				success : function(data) {
					if (data.success) {
						AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						AUIGrid.setSelectionByIndex(me.id, 0);
						
						
					} else {
						AUIGrid.removeAjaxLoader(me.id);
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		}
	};

	function auiGridCellDoubleClickHandler() {

		var str = "";
		var i, rowItem, rowInfoObj, dataField;

		selectionMode = AUIGrid.getProperty(grNarrative_Q.id, "selectionMode");

		var selectedItems = AUIGrid.getSelectedItems(grNarrative_Q.id);
		if (selectedItems.length <= 0) {
			alert("없음");
			return;
		}

		rowInfoObj = selectedItems[0];
		rowItem = rowInfoObj.item;
		if(rowItem.USE_AT =="Deleted"){
			alert('삭제된 행입니다.');
			return;
		}
			
// 		$('#iETC_INFO_NO').val(rowItem.ETC_INFO_NO);
// 		$('#iform').submit();
	}
	
	function EnglishNotation(idKorean, idEng){
		var txtKorean = $.trim($('#'+idKorean).val());
		var txtEng = $.trim($('#'+idEng).text());
		var param = {
				ID_KOREAN : idKorean,
				ID_ENG : idEng,
				KOREAN : txtKorean,
				ENG : txtEng
			};
			
			mkLayerPopupOpen("/sdb/c02/popupSDBC0218.do", param);
			return false;
	}

</script>
</head>

<body>
		<div id="wrap">
			<!-- 헤더 호출 -->
			<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
			<!-- 레프트 호출 -->
			<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
			<form id="iform">
			<input type="hidden" id="mode" value="C" />
			<input type="hidden" id="hdhrmflns_case_code"/>
			<input type="hidden" id="hdprduct_code"/>
			<input type="hidden" id="hdcase_dc_sn" />
			<input type="hidden" id="hdfollow_no" />
			<input type="hidden" id="hdmafu_no" />
			
			<section id="mainCon">
				<div class="mainConInner">
					<article class="mainTitBox">
						<h3>NARRATIVE</h3>
						<nav id="pathNav">
							<ul>
								<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
								<li>국내외 이상사례 등록</li>
								<li>CASE별 등록</li>
							</ul>
						</nav>
					</article>
					<!-- 컨텐츠박스 시작-->
					<section class="conBox100 conBox">
						<div class="conBoxInner">
							<div class="button_tab_01">
								<ul>
									<li id="tabDemographics" class="tab_menu">DEMOGRAPHICS</li>
									<li id="tabMedicalhistory" class="tab_menu">MEDICAL HISTORY</li>
									<li id="tabDrughistory" class="tab_menu">DRUG HISTORY</li>
									<li id="tabAe" class="tab_menu">AE</li>
									<li id="tabLab" class="tab_menu">LAB</li>
									<li id="tabDrug" class="tab_menu">DRUG</li>
									<li id="tabCasulity" class="tab_menu">CASUALITY</li>
									<li id="tabNarrative" class="port_back tab_menu">NARRATIVE</li>
									<li id="tabAssessment" class="tab_menu">ASSESSMENT</li>
								</ul>
							</div>
							<!-- 상단 테이블 전체메뉴라인 시작-->
							<article class="conTitBtn">
								<!-- 상단 테이블 오른쪽 메뉴 시작-->
								<div class="conTitBtnR">
									<input type="button" id="btnInit" value="초기화">									
									<input type="button" id="btnSave" value="저장">
									<input type="button" id="btnAudit" value="A" title="Audit Trail">
								</div>
								<!-- 상단 테이블 오른쪽 메뉴 끝-->
							</article>
							<!-- 상단 테이블 전체메뉴라인 끝-->
							<!-- 테이블 시작 -->
							<article class="mgT55">
								<table class="tb001">
									<colgroup>
										<col style="width: 30%;" />
										<col style="width: *;" />
										<col style="width: 90px;" />										
									</colgroup>
									<tbody>										
										<tr>
											<th>Case narrative</th>
											<td><textarea id="txthrmflns_case_dc" rows="3" style="width: 100%;"></textarea> <input type="hidden"
													id="hdhrmflns_case_dc"><label popup_type="Label" id="txthrmflns_case_dc_eng"></label></td>
											<td>
												<input class="oneBtn" type="button" popup_type="Q" value="Q"> <input class="oneBtn" type="button" popup_type="E" value="E" onclick="EnglishNotation('txthrmflns_case_dc','txthrmflns_case_dc_eng');"/>
											</td>
										</tr>
										<tr>
											<th>Reporter's comments</th>
											<td><textarea id="txtreportr_opinion" rows="3" style="width: 100%;"></textarea> <input type="hidden"
													id="hdreportr_opinion"><label popup_type="Label" id="txtreportr_opinion_eng"></label></td>
											<td><input class="oneBtn" type="button" popup_type="Q" value="Q"> <input class="oneBtn" type="button" popup_type="E" value="E" onclick="EnglishNotation('txtreportr_opinion','txtreportr_opinion_eng');"/>
											</td>
										</tr>
										<tr>
											<th>Sender's comments</th>
											<td><textarea id="txtaplcnt_opinion" rows="3" style="width: 100%;"></textarea> <input type="hidden"
													id="hdaplcnt_opinion"><label popup_type="Label" id="txtaplcnt_opinion_eng"></label></td>
											<td><input class="oneBtn" type="button" popup_type="Q" value="Q"> <input class="oneBtn" type="button" popup_type="E" value="E" onclick="EnglishNotation('txtadverse_event','txtadverse_event_eng');"/> 
											</td>
										</tr>
										<tr>
											<th>Other Information</th>
											<td><textarea id="txtdifr_info" rows="3" style="width: 100%;"></textarea> <input type="hidden"
													id="hddifr_info"><label popup_type="Label" id="txtdifr_info_eng"></label></td>
											<td><input class="oneBtn" type="button" popup_type="Q" value="Q"> <input class="oneBtn" type="button" popup_type="E" value="E" onclick="EnglishNotation('txtdifr_info','txtdifr_info_eng');"/> 
											</td>
										</tr>
										<tr>
											<th>Study name</th>
											<td><input type="text" id="txtrsrch_nm" style="width:100%;"/> <input type="hidden"
													id="hdrsrch_nm"><label popup_type="Label" id="txtrsrch_nm_eng"></label></td>
											<td>
												<input class="oneBtn" type="button" popup_type="Q" value="Q"> <input class="oneBtn" type="button" popup_type="E" value="E" onclick="EnglishNotation('txtrsrch_nm','txtrsrch_nm_eng');"/>
											</td>
										</tr>
										<tr>
											<th>Sponsor study number</th>
											<td><input type="text" id="txtspon_rsrch_no"  /> <input type="hidden"
													id="hdspon_rsrch_no"></td>
											<td><input class="oneBtn" type="button" popup_type="Q" value="Q"> </td>
										</tr>
										<tr>
											<th>Study type in which the reaction(s) event(s) were observed</th>
											<td>
												<select id="slrespns_observ_rsrch_ty">
													<option value="">=== 선택 ===</option>
												</select></td>
											<td><input class="oneBtn" type="button" popup_type="Q" value="Q"> </td>
										</tr>
									</tbody>
								</table>
								<ul class="mgT20">
				                <li class="accordion_03">
				                	<a heft="#void" class="close"><span>[Q내역]</span></a>
				                    <div class="accordion_con_03 close">

				                        <div id="grNarrative_Q" class="grid_wrap tb01_2"></div>
				                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>

				                    </div>
				                </li>
				            </ul>
							</article>
							<!-- 아코디언 메뉴 시작 -->
							<article class="mgT10">
								<!-- mgT은 위로 55px을 띄운다는것 1부터 100까지는 1단위, 100부터 1000까지는 10단위
                                 주로 타이틀이나 메뉴 밑에 부분은 mgT16 mgT55 mgT43을 사용한다-->
<!-- 								<ul id="acdMenu01"> -->
<!-- 									아코디언 메뉴 리스트 시작 -->
<!-- 									아코디언 함수 공통에서 옮기기  -->
<!-- 									<li class="acdMenuLst acdMenuLst01"><a -->
<!-- 										class="acdMenuLik close">[Q 내역]</a> -->
<!-- 										<div id="listQ" class="acdMenuCts acdMenuCts01 close"> -->
<!-- 											아코디언 메뉴 컨텐츠 시작 -->
<!-- 											<article class="mgT5"> -->
<!-- 												에이유아이 그리드가 이곳에 생성 -->
<!-- 												<div id="grNarrative_Q" class="grid_wrap tb01_2"></div> -->
												
<!-- 											</article> -->
<!-- 											아코디언 메뉴 컨텐츠 끝 -->
<!-- 										</div></li> -->
<!-- 									아코디언 메뉴 리스트 끝 -->
<!-- 								</ul> -->
								
							</article>
							<!-- 아코디언 메뉴 끝 -->
							<!-- 테이블 끝 -->
						</div>
					</section>
					<!-- 컨텐츠박스 끝-->
				</div>
			</section>
		</div>
</body>
</form>
</html>