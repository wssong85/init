<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false" />
<title>거래선 등록</title>
<script type="text/javascript"
	src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript">
	var file_mastr_sn = "${FILE_MASTR_SN}";
	var req_delngln_code = "${req_delngln_code}";

	$(function() {
		init();
		//검색 
		$('#btnClCodeadd').click(function() {
			var row = {
				'CHARGER_NM' : '',
				'CLSF' : '',
				'CTTPC' : '',
				'EMAIL' : '',
				'FRST_CREDE' : '',
				'CURD' : 'C'
			};
			AUIGrid.addRow(chagerGrid.id, row, 'last'); // 최하단에 행 추가
		});

		//메뉴상단 행삭제
		$('#btnChargerDel').click(function() {
			AUIGrid.removeRow(chagerGrid.id, "selectedIndex");
		});

		$('#btnSearch').click(function() {
			grOran.load();
		});
		$('#btnInit').click(function() {
			$('#inputForm').each(function() {
				this.reset();
				$("#mode").val('C');
			});

		});
		
		$('button[popup_type=Search], #txtProductCode').click(function(){			
			var param = {
					DELNGLN_CODE : $('#hddelngln_code').val()
				};
			mkLayerPopupOpen("/sdb/b02/popupSDBB0203.do", param); 
			//mkLayerPopupOpen("/sdb/b02/popupSDBB0203.do");
			
			if (typeof grProductList.id !== "undefined") {
				AUIGrid.resize(grProductList.id);
			}
			if (typeof grProduc_Reg.id !== "undefined") {
				AUIGrid.resize(grProduc_Reg.id);
			}
			return false;
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
			if($.trim($('#product_input').text())==""){
				alert('PRODUCT를 선택해주세요.');
				return;
			}
			
			if (!mkValidation()) {
				return;
			}

			var mode = $("#mode").val();
			var empty_file = $("#empty_file").val();

			if (mode == 'C') {
				$("#filetForm").submit();
			} else if (mode == "U") {
				//alert('수정');
				
				c_del();
				
				$("#filetForm").submit();
			}
		});

		$('#btnDel').click(function() {
			var mode = $("#mode").val();
			if (!confirm('삭제하시겠습니까?')) {
				return;
			}
			if (mode == 'U') {
				del_mode = 'D';
			}else{
				return;
			}
			var params_D = [{
				CURD : del_mode,
				DELNGLN_CODE : $("#hddelngln_code").val()
			}];
			
			$.ajax({
				url : './insertOrgan.do',
				async : false,
				data : {
					data : JSON.stringify(params_D)
				},
				success : function(data) {
					if (data.result == "ok") {
						//alert("성공");
						window.location.href ='/sdb/b02/SDBB0201.do';
					} else {
						alert('실패');
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(errorThrown);
					alert(textStatus);
				}
			});

		});

		$('#btnConDel').click(function() {
			//getCheckedRowItems();
			AUIGrid.removeRow(grOran.id, "selectedIndex");
		});
		
		
		makeFileAttachment();

	});

	function createPageController() {
		<c:forEach var="result" items="${printType}" varStatus="status">
		$("#sltdelngln_se").append(
				"<option value='<c:out value="${result.CMMN_CODE}"/>'>"
						+ '<c:out value="${result.CMMN_CODE_NM}"/>'
						+ "</option>");
		</c:forEach>
		<c:forEach var="result" items="${printType2}" varStatus="status">
		$("#sltdmstc_se").append(
				"<option value='<c:out value="${result.CMMN_CODE}"/>'>"
						+ '<c:out value="${result.CMMN_CODE_NM}"/>'
						+ "</option>");
		</c:forEach>
	}

	function makeFileAttachment() {
		//파일업로드 제한 수
		var maxFileNum = 1;
		var multi_selector = new MultiSelector(document
				.getElementById('egovComFileList'), maxFileNum);
		multi_selector.addElement(document
				.getElementById('egovComFileUploader'));
	}

	function init() {
		createPageController();		 
		mkSetDatePickerYYMMDD("#txtcntrct_pd","#txtcntrct_pd_end");		
		mkSetDatePickerYYMMDD("#txtefect_occrrncde");
		mkSetDatePickerYYMMDD("#txtprmisnde");
		mkSetDatePickerYYMMDD("#txtcmtde");
		
// 		$('#txtcntrct_pd').val('');
// 		$('#txtcntrct_pd_end').val('');
		$('#txtefect_occrrncde').val('');
		$('#txtprmisnde').val('');
		$('#txtcmtde').val('');

		if (req_delngln_code != "") {
			 
			$("#hddelngln_code").val(req_delngln_code);
			$("#mode").val('U');
		}
		if (req_delngln_code != null && req_delngln_code != "") {
			var params = {
				DELNGLN_CODE : req_delngln_code,
			};
			
			
			$.ajax({
				type : "POST",
				url : "/sdb/b02/selectProductInfo.do",
				data : params,
				dataType : "json",
				//async		: true,
				success : function(data) {
					if (data.success) {
						var tt_input = "";
						
						for (i = 0; i < data.result.length; i++) {
							var txt_word = data.result[i].WORD;
							var txt_prduct_code = data.result[i].PRDUCT_CODE;
							tt_input = tt_input
									+ '<input type="hidden" name="PRDUCTNM_CODE"  value="'+txt_prduct_code+'"/><label>'
									+ txt_word + '</label>';
						}
						if (data.result.length !=0){
							$('#product_input').html(tt_input);	
						}
					} else {
						alert(data.message);
					}
				},
				error : function(xhr, textStatus, errorThrown) {
					//alert(textStatus);
					alert("실패");
				}
			});
			//return;
			$.ajax({
				type : "POST",
				url : "/sdb/b02/selectDelnglnInfo.do",
				data : params,
				dataType : "json",
				//async		: true,
				success : function(data) {
					if (data.success) {
						$('#txtProductCode').val();
						$('#hddelngln_code').val(data.result.DELNGLN_CODE);
						$('#sltdelngln_se').val(data.result.DELNGLN_SE);
						$('#txtdelngln_nm').val(data.result.DELNGLN_NM);
						$('#sltdmstc_se').val(data.result.DMSTC_SE);
						$('#txtcntrct_pd').val(data.result.CNTRCT_PD);
						$('#txtcntrct_pd_end').val(data.result.CNTRCT_PD_END);
						$('#txtefect_occrrncde').val(data.result.EFECT_OCCRRNCDE);
						$('#txtprmisnde').val(data.result.PRMISNDE); 
						$('#txtcmtde').val(data.result.CMTDE);
						$('#txtcntrct_file_id').val(data.result.CNTRCT_FILE_ID);

						grOran.createGrid();
						chagerGrid.createGrid();

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
			//alert("||"+req_delngln_code+"|");
			//$("#mode").val('U');
			grOran.createGrid();
			chagerGrid.createGrid();
		}

	}

	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
		if (typeof grOran.id !== "undefined") {
			AUIGrid.resize(grOran.id);
		}
		if (typeof chagerGrid.id !== "undefined") {
			AUIGrid.resize(chagerGrid.id);
		}
	};

	//체크된 아이템 얻기
	function getCheckedRowItems() {
		var checkedItems = AUIGrid.getCheckedRowItems(grOran.id);
		if (checkedItems.length <= 0) {
			alert("없음");
			return;
		}

		var rowItem;
		for (var i = 0, len = checkedItems.length; i < len; i++) {
			rowItem = checkedItems[i];
			alert(rowItem.item.DETAIL_SN);
		}

	}

	var allChecked = false;
	function setAllCheckedRows() {
		allChecked = !allChecked;
		AUIGrid.setAllCheckedRows(myGridID, allChecked);
	};

	function deleteCheckedRows() {

		// 체크된 행 삭제 처리
		AUIGrid.removeCheckedRows(myGridID);
	}

	function del_file() {
		$('#empty_file').val("NO");
		$('#egovComFileList').empty();
		$('#egovComFileUploader').attr("disabled", false);
	}

	function insertFile() {
		var formData = new FormData();
		var formTag = $('#filetForm').children();

		for (var i = 0; i < formTag.length; i++) {
			formData.append(formTag[i].name, formTag[i].value);

			if (formTag[i].type == 'file') {
				formData.append(formTag[i].name, $('input[name='
						+ formTag[i].name + ']')[0].files[0]);
			}
		}

		$.ajax({
			url : '/sdb/b01/insertDmFileMstr.do',
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				location.href = "/com/z02/COMZ0201_DOWN.do?MstrSn="
						+ data.result;

			}
		});

	}

	function saveForm(mode, file_id) {
		var arJson = [];

		// 추가된 행 아이템들(배열)
		var addedRowItems = AUIGrid.getAddedRowItems(chagerGrid.id);
		// 수정된 행 아이템들(배열)
		var editedItems = AUIGrid.getEditedRowItems(chagerGrid.id);
		// 삭제된 행 아이템들(배열)
		var removeItems = AUIGrid.getRemovedItems(chagerGrid.id);

		for (var i = 0; i < addedRowItems.length; i++) {
			addedRowItems[i].UPDATE_ID = '${loginMap.USER_ID}';
			arJson.push(addedRowItems[i]);
		}

		for (var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			editedItems[i].UPDATE_ID = '${loginMap.USER_ID}';
			arJson.push(editedItems[i]);
		}

		for (var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			removeItems[i].UPDATE_ID = '${loginMap.USER_ID}';
			arJson.push(removeItems[i]);
		}

		for (var i = 0; i < arJson.length; i++) {
			if (!arJson[i]['CHARGER_NM'] || !arJson[i]['CHARGER_NM']) {
				alert('담당자명을 입력해주세요.');
				return;
			}
		}

		var params = [ {
			CURD : mode,
			chagerGrid : arJson,
			DELNGLN_CODE : $("#hddelngln_code").val(),
			DELNGLN_NM : $("#txtdelngln_nm").val(),
			CNTRCT_FILE_ID : file_id,
			DELNGLN_SE : $("#sltdelngln_se").val(),
			DMSTC_SE : $("#sltdmstc_se").val(),
			CNTRCT_PD : $("#txtcntrct_pd").val(),
			CNTRCT_PD_END : $("#txtcntrct_pd_end").val(),
			EFECT_OCCRRNCDE : $("#txtefect_occrrncde").val(),
			PRMISNDE : $("#txtprmisnde").val(),
			CMTDE : $("#txtcmtde").val(),
			UPDATE_ID : '${loginMap.USER_ID}'
		} ];
		$.ajax({
			url : './insertOrgan.do',
			async : false,
			data : {
				data : JSON.stringify(params)
			},
			success : function(data) {
				if (data.success) {
					alert(data.d_code);
					saveProduct(data.d_code);
					//alert("성공1");
				} else {
					alert('실패');
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패");
			}
		});

	}

	function fn_downFile(fileMastrSn, fileSn) {
		window
				.open("<c:url value='/sdb/b01/selectDmFileDetailByPk.do?FILE_MASTR_SN="
						+ fileMastrSn + "&DETAIL_SN=" + fileSn + "'/>");
	}

	var me;
	var grOran = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grOran.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#grid_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 50,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			}
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectCntrctInfo.do',
			param : {
				FILE_MASTR_SN : $('#txtcntrct_file_id').val()
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
			// 페이징 사용
			//usePaging : true,

			showRowNumColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,			
			showStateColumn : true,
			editable : false,
			enableFilter : true,

			// 한 화면 페이징 버턴 개수 5개로 지정
			//showPageButtonCount : 4,
			headerHeight : 40,
			rowHeight : 37,
			height : 180,
			selectionMode : "singleRows"
		//displayTreeOpen : true   

		},
		//AUI 그리드 레이아웃
		columnLayout : [
				{
					dataField : "FILE_NAME",
					headerText : "파일명",			
			 		filter : {
			 			showIcon : true
			 		}
					
				},
				{
					dataField : "FRST_CREDE",
					headerText : "등록일",			
			 		filter : {
			 			showIcon : true
			 		}
				},
				{
					dataField : "FILE_MASTR_SN",
					headerText : "FILE",
					renderer : { // HTML 템플릿 렌더러 사용
						type : "TemplateRenderer"
					},
					// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
					labelFunction : function(rowIndex, columnIndex, value,
							headerText, item) { // HTML 템플릿 작성
						if (!value)
							return "";
						var template = '<div style="display:inline-block; margin-top:4px; line-height:12px;">';
						template += '<a href="#" class="my_a_tag" onclick="javascript:fn_downFile('
								+ value
								+ ','
								+ item.DETAIL_SN
								+ ');">'
								+ item.FILE_NAME;
						template += '</a></div>';
						return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
					}
				}, {
					dataField : "DETAIL_SN",
					headerText : "DETAIL_SN",
					visible : false
				} ],

		//AUI 그리드 생성
		createGrid : function() {
			me = this;

			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid
					.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			me.binding();

			if (me.proxy.autoLoad) {
				console.log('1');
				me.load();
			}
			// 전체 체크박스 클릭 이벤트 바인딩
			AUIGrid.bind(me.id, "rowAllCheckClick", function(checked) {
				alert("전체 선택  checked : " + checked);
			});

			//me.createPagingNavigator(1);
		},
		//AUI 그리드 이벤트 
		binding : function() {

		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;

			//AUIGrid.showAjaxLoader(me.id);
			//rowCOunt = 300
			var param = {
				FILE_MASTR_SN : $('#txtcntrct_file_id').val()
			};
			$.ajax({
				url : me.proxy.url,
				type : me.proxy.type,
				dataType : me.proxy.dataType,
				data : param,
				success : function(data) {
					if (data.success) {
						AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						$(".aui-grid-template-renderer-wrapper").removeAttr(
								"style");
					} else {
						AUIGrid.removeAjaxLoader(me.id);
						alert(data.message);
					}
				}
			});
		}

	};

	var chagerGrid = {
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#grid_wrap2',
			paging : {
				pagingDiv : 'grid_paging2',
				totalRowCount : 50,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			}
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectChagerListInfo.do',
			param : {
				DELNGLN_CODE : $('#hddelngln_code').val()
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
			// 페이징 사용
			//usePaging : true,

			showRowNumColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : true,
			enableFilter : true,

			// 한 화면 페이징 버턴 개수 5개로 지정
			//showPageButtonCount : 4,
			headerHeight : 40,
			rowHeight : 37,
			height : 180,
			selectionMode : "singleRows"
		//displayTreeOpen : true   

		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "CHARGER_NM",
			headerText : "담당자명 <span style='color:red'>*</span>",
	 		filter : {
	 			showIcon : true
	 		} 		
		}, {
			dataField : "CLSF",
			headerText : "직급",			
	 		filter : {
	 			showIcon : true
	 		} 		
		}, {
			dataField : "CTTPC",
			headerText : "연락처",			
	 		filter : {
	 			showIcon : true
	 		}
			
		}, {
			dataField : "EMAIL",
			headerText : "이메일",			
	 		filter : {
	 			showIcon : true
	 		}
			
		}, {
			dataField : "FRST_CREDE",
			headerText : "등록일",			
	 		filter : {
	 			showIcon : true
	 		}
		}, {
			dataField : "CHARGER_SN",
			headerText : "CHARGER_SN",
			visible : false
		}, {
			dataField : "DELNGLN_CODE",
			headerText : "DELNGLN_CODE",
			visible : false
		} ],

		//AUI 그리드 생성
		createGrid : function() {
			var me = this;

			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid
					.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			me.binding();

			// 전체 체크박스 클릭 이벤트 바인딩

		},
		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;

			if (me.proxy.autoLoad) {
				console.log('1');
				me.load();
			}
			;

			AUIGrid.bind(me.id, "rowAllCheckClick", function(checked) {
				alert("전체 선택  checked : " + checked);
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;

			AUIGrid.showAjaxLoader(me.id);
			//rowCOunt = 300
			var param = {
				DELNGLN_CODE : $('#hddelngln_code').val()
			};
			$.ajax({
				url : me.proxy.url,
				type : me.proxy.type,
				dataType : me.proxy.dataType,
				data : param,
				success : function(data) {
					if (data.success) {
						AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						$(".aui-grid-template-renderer-wrapper").removeAttr(
								"style");
					} else {
						AUIGrid.removeAjaxLoader(me.id);
						alert(data.message);
					}
				}
			});
		}
	};

	function saveProduct(delngln_code) {
		var params2 = {
			CURD : 'D',
			DELNGLN_CODE : delngln_code,
			UPDATE_ID : '${loginMap.USER_ID}'
		};
		
		$.ajax({
			url : './insertProductDel.do',
			type: 'post',
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify(params2),
			dataType : "json",
			success : function(data) {
				if (data.success) {
					//alert("성공1");
					saveDeProduct(delngln_code);
					//saveCharger(delngln_code);
				} else {
					alert(data.errmsg);
					return;
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("실패p");
				return;
			}
		});		
	}
	
	function saveDeProduct(delngln_code){
		$('input[name^="PRDUCTNM_CODE"]').each(function() {
			var params3 = {
				CURD : 'C',
				PRDUCT_CODE : $(this).val(),
				DELNGLN_CODE : delngln_code,
				UPDATE_ID : '${loginMap.USER_ID}'
			};
			$.ajax({
				url : './insertProduct.do',
				type: 'post',
				contentType : "application/json; charset=UTF-8",
				data : JSON.stringify(params3),
				dataType : "json",
				success : function(data) {
					if (data.success) {
						//alert("성공2");
						window.location.href ="/sdb/b02/SDBB0201.do";
					} else {
						alert(data.errmsg);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("실패pp");
				}
			});
		});
		
	}
	
	function c_del(){
		var arJson = [];

		// 삭제된 행 아이템들(배열)
		 
		var removeItems = AUIGrid.getRemovedItems(grOran.id);


		for (var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			//removeItems[i].FILE_MASTR_SN = $('#txtcntrct_file_id').val();
			removeItems[i].UPDATE_ID = '${loginMap.USER_ID}';
			arJson.push(removeItems[i]);
		}
		
		if(removeItems.length>0){
			$.ajax({
				  url : './delCtFile.do',
				  type: 'post',
				  contentType: "application/json; charset=UTF-8",
				  data : JSON.stringify(arJson),
				  success : function(data, textStatus, jqXHR) {
					  if(data.success) {
						  grOran.load()
					  } else {
						  AUIGrid.removeAjaxLoader(grOran.id);
						  alert(data.message);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(textStatus);
				  }
			});
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0201&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0201&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							 <li>${progrmMap.UPPER_MENU_NM}</li>
							<li>${progrmMap.MENU_NM}</li>
						</ul>
					</nav>
				</article>
				<!-- 컨텐츠박스 시작-->
				<section class="conBox100 conBox">
					<div class="conBoxInner">



						<div class="conTitBtnR">
							<input type="button" id="btnInit" value="초기화" />
							<input type="button" id="btnSave" value="저장" />
							<input type="button" id="btnDel" value="삭제" />
						</div>

						<input type='hidden' id='prduct_code' />
						<input type='hidden' id='psur_code' />
						<input type='hidden' id='file_id' />
						<input type='hidden' id='mode' value='C' />
						<input type='hidden' id='empty_file' value="YES" />
						<input type='hidden' id='txtcntrct_file_id' />

						<article class="mgT44" style="position:relative;">

								<div style="font-family:'NanumGothicBold'; display:inline-block; position:absolute; top:-25px;">
									<h7>거래선</h7>
								</div>

								<table class="tb001">
									<colgroup>
										<col style="width: 15%" />
										<col style="width: 35%" />
										<col style="width: 15%" />
										<col style="" />
									</colgroup>
									<tbody>
										<form id="inputForm">
										<tr>
											<th>PRODUCT<span class="must_01"></span></th>
											<td colspan="3">
												<input type='text' id='txtProductCode'  readonly />
												<input type="hidden" id="hdProductCode"/>
												<button class="oneBtn" popup_type="Search" type="button">
													<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
												</button>
												<span id="product_input"></span>
											</td>
										</tr>
										<tr>
											<th>거래선명 <span class="must_01"></span></th>
											<td colspan="3"><input type='text' id='txtdelngln_nm' valireqire="거래선명" style="width:100%;"/><input type='hidden' id='hddelngln_code'/>
											</td>												
										</tr>
										<tr>
											<th>거래선구분</th>
											<td>
												<select id="sltdelngln_se" valireqire="거래선구분" style="width:100%;>
													<option value="">====선택====</option>
												</select>
											</td>
											<th>국내/국외</th>
											<td>
												<select id="sltdmstc_se" valireqire="국내외구분" style="width:100%;>
													<option value="">====선택====</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
								
								<div style="height:20px;"></div>
								
								<div style="font-family:'NanumGothicBold'; display:inline-block; ">
									<h7>계약</h7>
								</div>
								
								<div style="height:5px;"></div>
									
								<table class="tb001">
									<colgroup>
										<col style="width: 15%" />
										<col style="width: 35%" />
										<col style="width: 15%" />
										<col style="" />
									</colgroup>
									<tbody>
										<tr>
											<th>계약기간</th>
											<td>
												<div class="dateBox">
													<input type='text' id='txtcntrct_pd' style="width: 120px;" />
												</div>
												 ~ 
												 <div class="dateBox">
												 <input type='text' id='txtcntrct_pd_end' style="width: 120px;" />
												 </div>
											</td>
											<th>효력발생일</th>
											<td>
												<div class="dateBox">
													<input type='text' id='txtefect_occrrncde' style="width: 120px;" />
												</div>
											</td>
										</tr>
										<tr>
											<th>허가일</th>
											<td>
												<div class="dateBox">
													<input type='text' id='txtprmisnde' style="width: 120px;" />
												</div>
											</td>
											<th>출시일</th>
											<td>
												<div class="dateBox">
													<input type='text' id='txtcmtde' style="width: 120px;" />
												</div>
											</td>
										</tr>
										</form>
										<tr>
											<th>계약서첨부</th>
											<td colspan="3">
												<form id="filetForm" action="<c:url value='/sdb/b01/insertDmFileMstr.do'/>" method="post" enctype="multipart/form-data">
													<input type="file" name="file_1" id="egovComFileUploader" size="60" title="첨부파일" />
													<p>
														<div id="egovComFileList"></div>
													</p>
												</form>
											</td>
										</tr>
									</tbody>
								</table>

						</article>

								
						<div style="height:15px;"></div>



						<div style="font-family:'NanumGothicBold'; display:inline-block; position:relative; top:18px;">
							<h7>계약서</h7>
						</div>
						<article class=" conTitBtnR">							
							<input type="button" id="btnConDel" value="삭제" />
						</article>

						<div style="height:15px; clear:both;"></div>

						<article>
							<div id="grid_wrap" class="gridHeiSz03 grid_wrap tb01_2"></div>
						</article>




								
						<div style="height:40px; clear:both;"></div>






						<div style="font-family:'NanumGothicBold'; display:inline-block; position:relative; top:18px;">
							<h7>담당자</h7>
						</div>
						<article class="conTitBtnR">
							<input type="button" id="btnClCodeadd" value="추가" />
							<input type="button" id="btnChargerDel" value="삭제" />
						</article>

						<div style="height:15px; clear:both;"></div>

						<article>
							<div id="grid_wrap2" class="gridHeiSz03 grid_wrap tb01_2"></div>
						</article>


					</div>
					
				</section>
				<!-- 컨텐츠박스 끝-->
				
				
			</div>
		</section>
		
	</div>
	
</body>
</html>