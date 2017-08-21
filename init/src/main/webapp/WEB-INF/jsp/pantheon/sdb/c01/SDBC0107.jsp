<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false" />
<title>Literature 등록/수정/삭제</title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript">
var LTRTRE_NO = "${LTRTRE_NO}";
var NEW_LTRTRE_NO = "${NEW_LTRTRE_NO}";

	$(function() {
		
		setAccodian();
		btnInit();
		setInit();
		init();
		
		//그리드
		grLiterature_Q.createGrid();
		
	});

	function btnInit() {
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

				mkLayerPopupOpen("/sdb/c02/popupSDBC0218.do", param);
				
				//return false;
			});

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
		
		$('#tabTrial').click(function() {
			window.location.href = "/sdb/c01/SDBC0101.do";
		});
		$('#tabSpontaneous').click(function() {
			window.location.href = "/sdb/c01/SDBC0104.do";
		});
		$('#tabLiterature').click(function() {
			window.location.href = "/sdb/c01/SDBC0106.do";
		});
		$('#tabEtc').click(function() {
			window.location.href = "/sdb/c01/SDBC0108.do";
		});
		$('#tabICSR').click(function() {
			window.location.href = "/sdb/c01/SDBC0110.do";
		});

		$('#btnCase').click(function() {
			window.location.href = "/sdb/c02/SDBC0201.do";
		});

		$('#btnInit').click(function() {
			var check_code = $("#txtLtrtre_no").val();
			$('#iform').each(function() {
				this.reset();
			});
			
			$('label[popup_type=Label]').text('');
			$("#txtLtrtre_no").val(check_code);
			
			$('#empty_file').val("NO");
			$('#egovComFileList').empty();
			$('#egovComFileUploader').attr('disabled', false);
			$("input[name=file_1]").attr("disabled", false);
			
		});
		
		
		$('#filetForm').ajaxForm({
			beforeSubmit: function (data,form,option) {
							
				if(data[0].value=="")
				{
					saveForm($("#mode").val(), $('#file_id').val());
					return false;
				}
				//submit전 행동
				return true;
				
			},
			success: function(response,status){
				var data = '';
				
				try {
					data = JSON.parse(response);	
				} catch(e) {
					data = response;
				}
				
				if(data.success) {
					console.log(data.result);
					saveForm($('#mode').val(), data.result);
				} else {
					alert(data.message);
				}
			},
			error: function(){
				alert("file upload error!!");
			}
		});
		
		
		$('#btnSave').click(function() {
			if (!mkValidation()) {
				return;
			}	
			if (!confirm('저장하시겠습니까?')) {
				return;
			}			
			
			var mode = $("#mode").val();
			var empty_file = $("#empty_file").val();
			
			if($("#mode").val() == 'C'){
								
				$("#filetForm").submit();


			}else if($("#mode").val() == "U"){
				var param = {
						TRGET_CODE 	: $("#txtLtrtre_no").val(),
						TRGETNM 	: "LIT",
						TRGET_MODE  : "U",
						UPDATE_ID	: '${loginMap.USER_ID}'						
					};
				mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
				
			}
		});


		$('#btnDel').click(function() {
			if($("#mode").val() == "C"){
				return;
			}
			if (!confirm('삭제하시겠습니까?')) {
				return;
			}
			var param = {
					TRGET_CODE 	: $("#txtLtrtre_no").val(),
					TRGETNM 	: "LIT",
					TRGET_MODE  : "D",
					UPDATE_ID	: '${loginMap.USER_ID}'						
				};
			
			mkLayerPopupOpen("/sdb/c02/popupSDBC0217.do", param);
			
		});

		$('#btnAudit').click(function() {
			alert('Audit팡법');
			return false;
		});
		
		
	}
	function setInit(){
		mkSetDatePickerYYMMDD("#txtPblcate_dte");
		//$("#txtEtcno").attr("disabled", true);
		
		//$("#txtSource").attr("maxlength", 150);
		$("#txtJrnl_info").attr("maxlength", 30);
		$("#txtOtherInfo1").attr("maxlength", 150);
		$("#txtOtherInfo2").attr("maxlength", 150);
		$("#txtOtherInfo3").attr("maxlength", 150);		
		
		$("input[popup_type=Q]").attr("title", "Query");
		$("input[popup_type=E]").attr("title", "English Notation");
		
	}
	
	function saveLayer(p_mode){		
		if(p_mode=='U'){

			$("#filetForm").submit();

		}
		else if(p_mode=='D'){
			if ($('#mode').val() == 'U') {
				//$('#mode').val('D');
				var params = {
					CURD : 'D',
					PRDUCT_CODE 		: $.trim($("#hdProductCode").val()),
					LTRTRE_NO : $.trim($("#txtLtrtre_no").val())
				};
				$.ajax({
					type : "POST",
					url : "/sdb/c01/insertLiteratureInfo.do",
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(params),
					dataType : "json",
					success : function(data) {
						if (data.success) {
							window.location.href= "/sdb/c01/SDBC0106.do";
						} else {
							alert(data.message);
						}
					},
					error : function(xhr, textStatus, errorThrown) {
						//alert(textStatus);
						alert("실패");
					}
				});
			} else {
	
			}
		}
	}
	
	function saveForm(mode, file_id){
		var params = {
				CURD 				: $.trim($("#mode").val()),
				LTRTRE_NO 			: $.trim($("#txtLtrtre_no").val()),
				PRDUCT_CODE 		: $.trim($("#hdProductCode").val()),
				PBLCATE_DTE 		: $.trim($("#txtPblcate_dte").val()),
				LTRTRE_FILE 		: $.trim(file_id),
				LTRTRE_SJ 			: $.trim($("#hdLtrtre_sj").val()),
				LTRTRE_SJ_KOR 		: $.trim($("#txtLtrtre_sj").val()),
				LTRTRE_SJ_ENG 		: $.trim($("#txtLtrtre_sj_eng").text()),
				JRNL_INFO 			: $.trim($("#hdJrnl_info").val()),
				JRNL_INFO_KOR 		: $.trim($("#txtJrnl_info").val()),
				JRNL_INFO_ENG 		: $.trim($("#txtJrnl_info_eng").text()),
				AUTHR 				: $.trim($("#hdAuthr").val()),
				AUTHR_KOR 			: $.trim($("#txtAuthr").val()),
				AUTHR_ENG 			: $.trim($("#txtAuthr_eng").text()),
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
				url : '/sdb/c01/insertLiteratureInfo.do',
				type : 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						//alert("성공");
						window.location.href= "/sdb/c01/SDBC0106.do";
						
					} else {
						alert(data.message);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패");
				}
			});
		
	}
	function init() {
		if (LTRTRE_NO != "") {
			$('#mode').val('U');
		} else {
			$('#mode').val('C');
		}
		$("#txtLtrtre_no").val(NEW_LTRTRE_NO);
		$('#txtPblcate_dte').val('');
		
		//수정모드인 경우
		if (LTRTRE_NO != null && LTRTRE_NO != "") {
			
			var params = {
				LTRTRE_NO : LTRTRE_NO
			};
			$.ajax({
				type : "post",
				url : "/sdb/c01/selectLiteratureInfo.do",
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						var Ltrtre_no = (isNull(data.result.LTRTRE_NO)) ? ''
								: data.result.LTRTRE_NO;
						var prduct_code = (isNull(data.result.PRDUCT_CODE)) ? ''
								: data.result.PRDUCT_CODE;
						var prductnm_code = (isNull(data.result.PRDUCTNM_CODE)) ? ''
								: data.result.PRDUCTNM_CODE;
						var Ltrtre_sj_code = (isNull(data.result.LTRTRE_SJ_CODE)) ? ''
								: data.result.LTRTRE_SJ_CODE;
						var Pblcate_dte = (isNull(data.result.PBLCATE_DTE)) ? ''
								: data.result.PBLCATE_DTE;
						var Jrnl_info_code = (isNull(data.result.JRNL_INFO_CODE)) ? ''
								: data.result.JRNL_INFO_CODE;
						var Jrnl_info_code = (isNull(data.result.JRNL_INFO_CODE)) ? ''
								: data.result.JRNL_INFO_CODE;
						var Authr_code = (isNull(data.result.AUTHR_CODE)) ? ''
								: data.result.AUTHR_CODE;						
						var OtherInfo1_Code = (isNull(data.result.ETC_INFO_ONE)) ? ''
								: data.result.ETC_INFO_ONE_CODE;
						var OtherInfo2_Code = (isNull(data.result.ETC_INFO_TWO)) ? ''
								: data.result.ETC_INFO_TWO_CODE;
						var OtherInfo3_Code = (isNull(data.result.ETC_INFO_THREE)) ? ''
								: data.result.ETC_INFO_THREE_CODE;
						
						$("#txtLtrtre_no").val(Ltrtre_no);
						$("#hdProductCode").val(prduct_code);
						$("#txtPblcate_dte").val(Pblcate_dte);
						
						$("#txtProductCode").val(prductnm_code);
						$('#hdLtrtre_sj').val(Ltrtre_sj_code);
						$('#hdJrnl_info').val(Jrnl_info_code);
						$('#hdAuthr').val(Authr_code);
						$('#hdOtherInfo1').val(OtherInfo1_Code);
						$('#hdOtherInfo2').val(OtherInfo2_Code);
						$('#hdOtherInfo3').val(OtherInfo3_Code);
						
						var txtLtrtre_sj = (isNull(data.result.LTRTRE_SJ)) ? ''
								: data.result.LTRTRE_SJ;
						var txtLtrtre_sj_eng = (isNull(data.result.LTRTRE_SJ_ENG)) ? ''
								: data.result.LTRTRE_SJ_ENG;
						var txtJrnl_info = (isNull(data.result.JRNL_INFO)) ? ''
								: data.result.JRNL_INFO;
						var txtJrnl_info_eng = (isNull(data.result.JRNL_INFO_ENG)) ? ''
								: data.result.JRNL_INFO_ENG;
						var txtAuthr = (isNull(data.result.AUTHR)) ? ''
								: data.result.AUTHR;
						var txtAuthr_eng = (isNull(data.result.AUTHR_ENG)) ? ''
								: data.result.AUTHR_ENG;
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

						$("#txtLtrtre_sj").val(txtLtrtre_sj);
						$("#txtJrnl_info").val(txtJrnl_info);
						$("#txtAuthr").val(txtAuthr);
						$("#txtOtherInfo1").val(txtOtherInfo1);
						$("#txtOtherInfo2").val(txtOtherInfo2);
						$("#txtOtherInfo3").val(txtOtherInfo3);

						$("#txtLtrtre_sj_eng").text(txtLtrtre_sj_eng);
						$("#txtJrnl_info_eng").text(txtJrnl_info_eng);
						$("#txtAuthr_eng").text(txtAuthr_eng);
						$("#txtOtherInfo1_eng").text(txtOtherInfo1_eng);
						$("#txtOtherInfo2_eng").text(txtOtherInfo2_eng);
						$("#txtOtherInfo3_eng").text(txtOtherInfo3_eng);
						// 파일다운로드 관련
						var file_name= data.result.FILE_NAME;
						var file_ext= data.result.FILE_EXT;
						var file_fullname = file_name +"."+file_ext;
						  
						var detail_sn = data.result.DETAIL_SN;
						var file_mastr_sn = data.result.FILE_MASTR_SN;
						$("#egovComFileList").empty();
						if(!isNull(file_mastr_sn) && !isNull(detail_sn)){
							var t_html = '<a href="javascript:fn_downFile('+file_mastr_sn+', '+detail_sn+')">'+ file_fullname +'</a><input type="button" onclick="javascript:del_file();" value="Delete"/>';
							$("#egovComFileList").append(t_html);
							$('#egovComFileUploader').attr("disabled",true);
						}
						//$('#lbl_code').val(lbl_code);
						$('#file_id').val(file_mastr_sn);

						$("#mode").val("U"); // 여기부터 해야함~~

					} else {
						alert(data.message);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					alert("실패");
				}
			});
		}
		
		makeFileAttachment();
	}
	
	function makeFileAttachment(){
		//파일업로드 제한 수
		var maxFileNum = 1;
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
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
						AUIGrid.resize(grLiterature_Q.id);
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
		if (typeof grLiterature_Q.id !== "undefined") {
			AUIGrid.resize(grLiterature_Q.id);
		}

	}

	var grLiterature_Q = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grLiterature_Q.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#grLiterature_Q',
			
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
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "SOURC",
			headerText : "Category",
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "AE_COUNT",
			headerText : "Variable",
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "ADR_COUNT",
			headerText : "쿼리내용",
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "UAE_COUNT",
			headerText : "ID",
			filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "SAE_COUNT",
			headerText : "등록자",
			filter : {
	 			showIcon : true
	 		}
		} ],
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

		selectionMode = AUIGrid.getProperty(grLiterature_Q.id, "selectionMode");

		var selectedItems = AUIGrid.getSelectedItems(grLiterature_Q.id);
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
	
	function del_file(){
		if(!confirm('파일을 삭제하시겠습니까?')){
			return;
		}
	    $('#empty_file').val("NO");
		$('#egovComFileList').empty();
		$('#egovComFileUploader').attr('disabled', false);
		$("input[name=file_1]").attr("disabled", false);
	}
  
  function insertFile(){
	  var formData = new FormData();
		var formTag = $('#filetForm').children();
		
		for(var i = 0; i < formTag.length; i++) {
			formData.append(formTag[i].name, formTag[i].value);
			
			if(formTag[i].type == 'file') {
				formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
			}
		}
		
		$.ajax({
			url : '/com/z02/insertDmFileMstr.do',
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				location.href="/com/z02/COMZ0201_DOWN.do?MstrSn=" + data.result;
//				if(data.success) {
//					location.replace("./COMZ0201_DOWN.do?MstrSn=" + data.result);
//				}
			}
		});
	  
  }
  
  function fn_downFile(fileMastrSn, fileSn){
		window.open("<c:url value='/sdb/b01/selectDmFileDetailByPk.do?FILE_MASTR_SN="+fileMastrSn+"&DETAIL_SN="+fileSn+"'/>");
	}
</script>
</head>

<body>

		<div id="wrap">
			<!-- 헤더 호출 -->
			<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
			<!-- 레프트 호출 -->
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
						<input type='hidden' id='detail_sn'/>							
						<input type='hidden' id='file_id'/>							
						<input type='hidden' id='empty_file' value="YES">
						<input type="hidden" id="mode" value="C" />
						
	
							<div class="button_tab_01">
								<ul>
									<li id="tabTrial" class="tab_menu">Study</li>
									<li id="tabSpontaneous" class="tab_menu">Spontaneous</li>
									<li id="tabLiterature" class="port_back tab_menu">Literature</li>
									<li id="tabEtc" class="tab_menu">Etc</li>
									<li id="tabICSR" class="tab_menu">ICSR</li>
								</ul>
							</div>
								
	
							<!-- 상단 검색과 버튼 시작 -->
							<article>
								<div class="conTitBtnL">
									PRODUCT <span class="must_01"></span> : 
									<input type="text" id="txtProductCode" class="pdR15" popup_type="ProductSearch" style="width:300px;" valireqire="PRODUCT" readonly>
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
								</div>
							</article>
							<!-- 상단 검색과 버튼 끝 -->
	
							<!-- 테이블 시작 -->
							<article class="mgT44">
								<table class="tb001">
									<colgroup>
										<col width="14%" />
										<col width="40%" />
										<col width="14%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Literature No.<span class="must_01"></span></th>
											<td colspan="3" style="padding-top:3px; padding-bottom:4px; height:42px;">
												<input type="text" id="txtLtrtre_no" style="width:60%;" valireqire="Literature No." readonly/>
											</td>
										</tr>
										<tr>
											<th>Literature Title <span class="must_01"></span></th>
											<td colspan="3" class="inputMulti" style="padding-top:5px; ">
												<textarea id="txtLtrtre_sj" style="width: 60%;" valireqire="Literature Title"></textarea>
												<input class="oneBtn" popup_type="E" type="button" value="E" style="vertical-align: top;" /> 
												<input	class="oneBtn" popup_type="Q" type="button" value="Q" style="vertical-align: top;" />
												<input	type="hidden" id="hdLtrtre_sj" /> 
												<label class="label_01" popup_type="Label" id="txtLtrtre_sj_eng"></label>
											</td>
										</tr>
										<tr>
											<th>Journal Information</th>
											<td style="padding-top:3px; padding-bottom:4px; height:42px;">
												<input type="text" id="txtJrnl_info" style="width:60%;" /> 
												<input class="oneBtn" type="button" popup_type="E" value="E"/> 
												<input class="oneBtn" type="button" popup_type="Q" value="Q"> 
												<input type="hidden"id="hdJrnl_info" /> 
												<label class="label_02" popup_type="Label" id="txtJrnl_info_eng"></label></td>
											<th>Date of Publication</th>
											<td>
												<div class="dateBox">
													<input type="text" id="txtPblcate_dte" style="width:114px;" />
												</div> 
												<input class="oneBtn" type="button" popup_type="Q" value="Q" style="position:relative; top:1px;">
											</td>
										</tr>
										<tr>
											<th>Author</th>
											<td colspan="3" style="padding-top:5px; ">
												<textarea id="txtAuthr"	style="width: 60%;"></textarea> 
												<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" /> 
												<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" /> 
												<input type="hidden"id="hdAuthr" />
												<label class="label_01" popup_type="Label" id="txtAuthr_eng"></label>
											</td>										
										</tr>
										<tr>
											<th>Other Information 1</th>
											<td colspan="3" style="padding-top:5px; ">
												<textarea id="txtOtherInfo1" style="width: 60%;"></textarea> 
												<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" /> 
												<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" /> 
												<input type="hidden" id="hdOtherInfo1" />
												<label class="label_01" popup_type="Label" id="txtOtherInfo1_eng"></label>
											</td>
										</tr>
										<tr>
											<th>Other Information 2</th>
											<td colspan="3" style="padding-top:5px; ">
												<textarea id="txtOtherInfo2" style="width: 60%;"></textarea> 
												<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" /> 
												<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" /> 
												<input type="hidden" id="hdOtherInfo2" /> 
												<label class="label_01" popup_type="Label" id="txtOtherInfo2_eng"></label>
											</td>
										</tr>
										<tr>
											<th>Other Information 3</th>
											<td colspan="3" style="padding-top:5px; ">
												<textarea id="txtOtherInfo3" style="width: 60%;"></textarea> 
												<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" /> 
												<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" /> 
												<input type="hidden" id="hdOtherInfo3" />
												<label class="label_01" popup_type="Label" id="txtOtherInfo3_eng"></label>
											</td>
										</tr>
										</form>
										<tr>
											<th>Literature File</th>
											<td colspan="3" style="padding-top:5px; padding-bottom:5px; ">
												<form id="filetForm" action="<c:url value='/sdb/b01/insertDmFileMstr.do'/>" method="post" enctype="multipart/form-data">
	
													 <input type="file" name="file_1"  id="egovComFileUploader" size="60" title="첨부파일" />
													 <div id="egovComFileList"></div>
	
													<!-- 
		                                            <div class="fileInputArea" style=" width:500px;">
		                                                <input type="text" id="fileName" readonly="readonly" style="width:82%;">
		                                                <input type="file" class="fileIuputHid" />
		                                                <input type="button" value="파일 선택" class="fileInputBtn" />
		                                            </div>
													 -->
	
												</form>
												
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
													<div id="grLiterature_Q" class="gridHeiSz10 grid_wrap tb01_2" style></div>
												</article>
												<!-- 아코디언 메뉴 컨텐츠 끝 -->
											</div></li>
										<!-- 아코디언 메뉴 리스트 끝 -->
									</ul>
								</article>
	                            <!-- 아코디언 메뉴 끝 -->
							<!-- 테이블 끝 -->
						
					</div>
	            </section>
			</div>
		</section>
	</div>

</body>

</html>