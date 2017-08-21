<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>Etc 등록/수정/삭제</title>
<script type="text/javascript">
var ETC_INFO_NO = "${ETC_INFO_NO}";
var NEW_ETC_INFO_NO = "${NEW_ETC_INFO_NO}";

	$(function() {
		setAccodian();
		btnInit();
		setInit();
		init();
		
		grTrial_Q.createGrid();
	});

	function btnInit() {
		//$('#txtSource_eng, #txtOtherInfo1_eng, #txtOtherInfo2_eng, #txtOtherInfo3_eng, #btnE')
		//$('.sdbLal, #btnE')
		$('label[popup_type=Label], input[popup_type=E]').click(
			function() {
				var multi = new Array;
				multi = $(this).siblings();
				var idKorean;
				var idEng;
				var txtCode;
				var txtKorean;
				var txtEng;
				// Label 클릭시 Selector
				if (multi.context) {
					txtEng = multi.context.textContent;
						idEng = multi.context.id;	
				}
				//textarea, input, label
				for (i = 0; i < multi.length; i++) {
					if (multi[i].tagName == "TEXTAREA"
							|| (multi[i].tagName == "INPUT" && multi[i].type == "text")) {
						txtKorean = $.trim(multi[i].value);
						idKorean = $.trim($.trim(multi[i].id));
					}else if (multi[i].tagName == "LABEL"){
							txtEng = $.trim(multi[i].textContent);
							idEng = $.trim($.trim(multi[i].id));									
					}
				}
				
				var param = {
					ID_KOREAN : idKorean,
					ID_ENG : idEng,
					KOREAN : txtKorean,
					ENG : txtEng
				};

				mkLayerPopupOpen("/sdb/c02/popup_SDBC0218.do", param);
				//return false;
			});

		$('input[popup_type=Q]').click(function(){
			alert('쿼리팝업');
			return false;
		});	
		
		$('button[popup_type=ProductSearch], input[popup_type=ProductSearch]').click(function(){
			mkLayerPopupOpen("/sdb/b02/popup_SDBB0204.do", null);
			if (typeof grProductList_Search.id !== "undefined") {
				AUIGrid.resize(grProductList_Search.id);
			}
			return false;
		});	
		
		
		$('#tabTrial').click(function() {
			window.location.href = "/sdb/c01/_SDBC0101.do";
		});
		$('#tabSpontaneous').click(function() {
			window.location.href = "/sdb/c01/_SDBC0104.do";
		});
		$('#tabLiterature').click(function() {
			window.location.href = "/sdb/c01/_SDBC0106.do";
		});
		$('#tabEtc').click(function() {
			window.location.href = "/sdb/c01/_SDBC0108.do";
		});
		$('#tabICSR').click(function() {
			window.location.href = "/sdb/c01/_SDBC0110.do";
		});

		$('#btnCase').click(function() {
			window.location.href = "/sdb/c02/_SDBC0201.do";
		});

		$('#btnInit').click(function() {
			var check_code = $("#txtEtcno").val();
			$('#iform').each(function() {
				this.reset();
			});
			
			$('label[popup_type=Label]').text('');
			$("#txtEtcno").val(check_code);
		});

		// 퍼블 테스트용 팝업
		$('#btnSaveDel2').click(function(){
			mkLayerPopupOpen("/sdb/c02/popup_SDBC0217.do", null);
			if (typeof grProductList_Search.id !== "undefined") {
				AUIGrid.resize(grProductList_Search.id); 
			}
			return false;
		});
		
		
		$('#btnSave').click(function() {

			if (!mkValidation()) {
				return;
			}	
			if (!confirm('저장하시겠습니까?')) {
				return;
			}
			if ( $.trim($("#mode").val()) == 'U') {
				var param = {
						TRGET_CODE 	: $("#txtEtcno").val(),
						TRGETNM 	: "ETC",
						TRGET_MODE  : "U",
						UPDATE_ID	: '${loginMap.USER_ID}'						
					};
				//alert(param);
	//			return;
				mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
			}else{
				var params = {
					CURD 				: $.trim($("#mode").val()),
					ETC_INFO_NO 		: $.trim($("#txtEtcno").val()),
					PRDUCT_CODE 		: $.trim($("#hdProductCode").val()),
					SOURC 				: $.trim($("#hdSource").val()),
					SOURC_KOR 			: $.trim($("#txtSource").val()),
					SOURC_ENG 			: $.trim($("#txtSource_eng").text()),
					ETC_INFO_ONE 		: $.trim($("#hdOtherInfo1").val()),
					ETC_INFO_ONE_KOR 	: $.trim($("#txtOtherInfo1").val()),
					ETC_INFO_ONE_ENG 	: $.trim($("#txtOtherInfo1_eng").text()),
					ETC_INFO_TWO 		: $.trim($("#hdOtherInfo2").val()),
					ETC_INFO_TWO_KOR 	: $.trim($("#txtOtherInfo2").val()),
					ETC_INFO_TWO_ENG 	: $.trim($("#txtOtherInfo2_eng").text()),
					ETC_INFO_THREE 		: $.trim($("#hdOtherInfo3").val()),
					ETC_INFO_THREE_KOR 	: $.trim($("#txtOtherInfo3").val()),
					ETC_INFO_THREE_ENG 	: $.trim($("#txtOtherInfo3_eng").text()),
					UPDATE_ID 			: '${loginMap.USER_ID}'
				};

				$.ajax({
					url : '/sdb/c01/insertEtcInfo.do',
					type : 'post',
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							window.location.href= "/sdb/c01/_SDBC0108.do";
						} else {
							alert(data.errmsg);
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
			}
		});

		$('#btnDel').click(function() {
			if ($('#mode').val() == 'U') {
				if (!confirm('삭제하시겠습니까?')) {
					return;
				}
				var param = {
						TRGET_CODE 	: $("#txtEtcno").val(),
						TRGETNM 	: "ETC",
						TRGET_MODE  : "D",
						UPDATE_ID	: '${loginMap.USER_ID}'						
					};
				
				mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
			}
		});

		$('#btnAudit').click(function() {
			alert('Audit팡법');
			
			return false;
		});
	}
	
	function saveLayer(p_mode){		
		if(p_mode=='U'){
			var params = {
				CURD 				: $.trim($("#mode").val()),
				ETC_INFO_NO 		: $.trim($("#txtEtcno").val()),
				PRDUCT_CODE 		: $.trim($("#hdProductCode").val()),
				SOURC 				: $.trim($("#hdSource").val()),
				SOURC_KOR 			: $.trim($("#txtSource").val()),
				SOURC_ENG 			: $.trim($("#txtSource_eng").text()),
				ETC_INFO_ONE 		: $.trim($("#hdOtherInfo1").val()),
				ETC_INFO_ONE_KOR 	: $.trim($("#txtOtherInfo1").val()),
				ETC_INFO_ONE_ENG 	: $.trim($("#txtOtherInfo1_eng").text()),
				ETC_INFO_TWO 		: $.trim($("#hdOtherInfo2").val()),
				ETC_INFO_TWO_KOR 	: $.trim($("#txtOtherInfo2").val()),
				ETC_INFO_TWO_ENG 	: $.trim($("#txtOtherInfo2_eng").text()),
				ETC_INFO_THREE 		: $.trim($("#hdOtherInfo3").val()),
				ETC_INFO_THREE_KOR 	: $.trim($("#txtOtherInfo3").val()),
				ETC_INFO_THREE_ENG 	: $.trim($("#txtOtherInfo3_eng").text()),
				UPDATE_ID 			: '${loginMap.USER_ID}'
			};

			$.ajax({
				url : '/sdb/c01/insertEtcInfo.do',
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						//alert("성공");
						window.location.href= "/sdb/c01/_SDBC0108.do";
					} else {
						alert(data.errmsg);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		}
		else if(p_mode=='D'){
			
			var params = {
				CURD : "D",
				ETC_INFO_NO : ETC_INFO_NO
			};
			$.ajax({
				type : "POST",
				url : "/sdb/c01/insertEtcInfo.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						//alert("성공");
						window.location.href= "/sdb/c01/_SDBC0108.do";
			
					} else {
						alert(result.errmsg);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert("실패");
				}
			});
		} else {

		}
		
	}
	
	function setInit(){
		$("#txtEtcno").attr("disabled", true);

		$("#txtSource").attr("maxlength", 150);
		$("#txtOtherInfo1").attr("maxlength", 150);
		$("#txtOtherInfo2").attr("maxlength", 150);
		$("#txtOtherInfo3").attr("maxlength", 150);		
		
	}
	function init() {
		if (ETC_INFO_NO != "") {
			$('#mode').val('U');
		} else {
			$('#mode').val('C');
		}
		$("#txtEtcno").val(NEW_ETC_INFO_NO);
		
		//수정모드인 경우
		if (ETC_INFO_NO != null && ETC_INFO_NO != "") {
			
			var params = {
				ETC_INFO_NO : ETC_INFO_NO
			};
			$.ajax({
				type : "post",
				url : "/sdb/c01/selectEtcInfo.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var txtEtcno = (isNull(data.result.ETC_INFO_NO)) ? ''
								: data.result.ETC_INFO_NO;
						var Source_Code = (isNull(data.result.SOURC_CODE)) ? ''
								: data.result.SOURC_CODE;
						var OtherInfo1_Code = (isNull(data.result.ETC_INFO_ONE)) ? ''
								: data.result.ETC_INFO_ONE_CODE;
						var OtherInfo2_Code = (isNull(data.result.ETC_INFO_TWO)) ? ''
								: data.result.ETC_INFO_TWO_CODE;
						var OtherInfo3_Code = (isNull(data.result.ETC_INFO_THREE)) ? ''
								: data.result.ETC_INFO_THREE_CODE;
						var prductnm_code = (isNull(data.result.PRDUCTNM_CODE)) ? '' : data.result.PRDUCTNM_CODE;
						var prduct_code = (isNull(data.result.PRDUCT_CODE)) ? '' : data.result.PRDUCT_CODE;
						
						$("#txtEtcno").val(txtEtcno);
						$('#hdSource').val(Source_Code);
						$('#hdOtherInfo1').val(OtherInfo1_Code);
						$('#hdOtherInfo2').val(OtherInfo2_Code);
						$('#hdOtherInfo3').val(OtherInfo3_Code);
						$("#txtProductCode").val(prductnm_code);
						$("#hdProductCode").val(prduct_code);

						var txtSource = (isNull(data.result.SOURC)) ? ''
								: data.result.SOURC;
						var txtSource_eng = (isNull(data.result.SOURC_ENG)) ? ''
								: data.result.SOURC_ENG;
						var txtOtherInfo1 = (isNull(data.result.ETC_INFO_ONE)) ? ''
								: data.result.ETC_INFO_ONE;
						var txtOtherInfo1_eng = (isNull(data.result.ETC_INFO_ONE_ENG)) ? ''
								: data.result.ETC_INFO_ONE_ENG;
						var txtOtherInfo2 = (isNull(data.result.ETC_INFO_TWO)) ? ''
								: data.result.ETC_INFO_TWO;
						var txtOtherInfo2_eng = (isNull(data.result.ETC_INFO_TWO_ENG)) ? ''
								: data.result.ETC_INFO_TWO_ENG;
						var txtOtherInfo3 = (isNull(data.result.ETC_INFO_THREE)) ? ''
								: data.result.ETC_INFO_THREE;
						var txtOtherInfo3_eng = (isNull(data.result.ETC_INFO_THREE_ENG)) ? ''
								: data.result.ETC_INFO_THREE_ENG;

						$("#txtSource").val(txtSource);								
						$("#txtOtherInfo1").val(txtOtherInfo1);
						$("#txtOtherInfo2").val(txtOtherInfo2);
						$("#txtOtherInfo3").val(txtOtherInfo3);

						$("#txtSource_eng").text(txtSource_eng);
						$("#txtOtherInfo1_eng").text(txtOtherInfo1_eng);
						$("#txtOtherInfo2_eng").text(txtOtherInfo2_eng);
						$("#txtOtherInfo3_eng").text(txtOtherInfo3_eng);

						$("#mode").val("U"); // 여기부터 해야함~~

					} else {
						alert(data.errmsg);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert("실패");
				}
			});
		}

	}
	
	function setAccodian(){
		
		 for(var ai=0; ai<3; ai++){
		    aiP = ai+1;
		
			(function(aiE){ 
				$(".acdMenuLst0"+aiE+" > a").on("click",function() {
					if ($(this).hasClass("close")) {
						$(this).siblings(".acdMenuCts0"+aiE+"").slideToggle(500);
						$(this).toggleClass('open');
						//그리드 리사이징
						AUIGrid.resize(grTrial_Q.id);
					}
				});
				
				if ( aiE !=2 ) {
					$(".acdMenuLst0"+aiE+"").not(this).on("click",function() {
						if ($(".acdMenuLst0"+aiE+"").not(this).children().hasClass("close")) {
							$(".acdMenuLst0"+aiE+"").not(this).children(".acdMenuCts0"+aiE+"").slideUp(500);
						}
					});
					
					$(".acdMenuLst0"+aiE+" > a").not(this).on("click",function() {
						if ($(".acdMenuLst0"+aiE+" > a").hasClass('open')) {
							$(".acdMenuLst0"+aiE+" > a").not(this).removeClass('open');
						}
					});
				} //조건문끝
			
			})(aiP); //반복문 적용끝
		
		} //반복문끝
	}
	
	window.onresize = function() {
		if (typeof grTrial_Q.id !== "undefined") {
			AUIGrid.resize(grTrial_Q.id);
		}

	}

	var grTrial_Q = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grTrial_Q.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#grTrial_Q',
			
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectEtcList.do',
			param : {
				PRDUCT_CODE : $('#hdProductCode').val()
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
				PRDUCT_CODE : $('#hdProductCode').val()
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

		selectionMode = AUIGrid.getProperty(grTrial_Q.id, "selectionMode");

		var selectedItems = AUIGrid.getSelectedItems(grTrial_Q.id);
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
			
		$('#iETC_INFO_NO').val(rowItem.ETC_INFO_NO);
		$('#iform').submit();
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
				<h3>Source별 등록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>Source별 등록</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner">
					<form id="iform">
					<input type="hidden" id="mode" value="C" />							
					

						<div class="button_tab_01">
							<ul>
								<li id="tabTrial" class="tab_menu">Study</li>
								<li id="tabSpontaneous" class="tab_menu">Spontaneous</li>
								<li id="tabLiterature" class="tab_menu">Literature</li>
								<li id="tabEtc" class="port_back tab_menu">Etc</li>
								<li id="tabICSR" class="tab_menu">ICSR</li>
							</ul>
						</div>
							

						<!-- 상단 검색과 버튼 시작 -->
						<article>
							<div class="conTitBtnL">
								PRODUCT <span class="must_01"></span> : 
								<input type="text" id="txtProductCode" class="pdR15" popup_type="ProductSearch" style="width:300px;" readonly>
								<input type="hidden" id="hdProductCode" />
								<button class="oneBtn" popup_type="ProductSearch" type="sumit">
										<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
							</div>

							<div class="conTitBtnR">
								<input type="button" id="btnCase" value="CASE">
								<input type="button" id="btnInit" value="초기화">
								<input type="button" id="btnSave" value="저장">
								<input type="button" id="btnDel" value="삭제">
								<input type="button" id="btnAudit" value="A" title="Audit Trail">
								
								<input type="button" id="btnSaveDel2" value="저장삭제 디자인 수정">
							</div>
						</article>
						<!-- 상단 검색과 버튼 끝 -->

						<!-- 테이블 시작 -->
						<article class="mgT44">
							<table class="tb001">
								<colgroup>
									<col width="14%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>ETC No. <span class="must_01"></span></th>
										<td style="padding-top:3px; padding-bottom:4px; height:42px;">
											<input type="text" id="txtEtcno" style="width: 60%;"  valireqire="ETC No." readonly />
										</td>
									</tr>
									<tr>
										<th>Source <span class="must_01"></span></th>
										<td class="inputMulti" style="padding-top:5px; ">
											<textarea id="txtSource" style="width: 60%;" valireqire="Source"></textarea>
											<input class="oneBtn" popup_type="E" type="button" value="E" style="vertical-align: top;" /> 
											<input	class="oneBtn" popup_type="Q" type="button" value="Q" style="vertical-align: top;" />
											<input type="hidden" id="hdSource">
											<label class="label_01" popup_type="Label" id="txtSource_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Other Information 1</th>
										<td style="padding-top:5px; ">
											<textarea id="txtOtherInfo1" style="width: 60%;"></textarea> 
											<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" /> 
											<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" /> 
											<input type="hidden" id="hdOtherInfo1" />
											<label class="label_01" popup_type="Label" id="txtOtherInfo1_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Other Information 2</th>
										<td style="padding-top:5px; ">
											<textarea id="txtOtherInfo2" style="width: 60%;"></textarea> 
											<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" /> 
											<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" /> 
											<input type="hidden" id="hdOtherInfo2" /> 
											<label class="label_01" popup_type="Label" id="txtOtherInfo2_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Other Information 3</th>
										<td style="padding-top:5px; ">
											<textarea id="txtOtherInfo3" style="width: 60%;"></textarea> 
											<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" /> 
											<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" /> 
											<input type="hidden" id="hdOtherInfo3" />
											<label class="label_01" popup_type="Label" id="txtOtherInfo3_eng"></label>
										</td>
									</tr>
					
								</tbody>
							</table>
						</article>
						
<style>
.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
#egovComFileList input{ margin-left:5px;}
</style>
						
						 <!-- 아코디언 메뉴 시작 -->
							<article class="mgT10">
								<ul id="acdMenu01">
									<!-- 아코디언 메뉴 리스트 시작 -->
									<!-- 아코디언 함수 공통에서 옮기기  -->
									<li class="acdMenuLst acdMenuLst01"><a
										class="acdMenuLik close">[Q 내역]</a>
										<div class="acdMenuCts acdMenuCts01 close">
											<!-- 아코디언 메뉴 컨텐츠 시작 -->
											<article class="mgT10">
												<!-- 에이유아이 그리드가 이곳에 생성 -->
												<div id="grTrial_Q" class="gridHeiSz10 grid_wrap tb01_2" style></div>
											</article>
											<!-- 아코디언 메뉴 컨텐츠 끝 -->
										</div></li>
									<!-- 아코디언 메뉴 리스트 끝 -->
								</ul>
							</article>
                            <!-- 아코디언 메뉴 끝 -->
						<!-- 테이블 끝 -->

						
					</form>
				</div>
            </section>


		
		






		</div>
	</section>
</div>
</body>
</html>