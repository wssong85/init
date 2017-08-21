<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<script type="text/javascript" src="<c:url value='/js/pantheon/common/jquery.form.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
	<script type="text/javascript">
	var gridVerification = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#gridVerification'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/e03/selectVerification.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: false
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : true,
				selectionMode: 'singleRow',
				editable: false,
				showStateColumn: false,
				showRowNumColumn : true,
				showRowCheckColumn : true,
				reverseRowNum : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "MAFU_NO",
								headerText : "Manufacturing No.",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "PRDUCT_NM",
								headerText : "Brand Name",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "SERIUSFMNM_AT",
								headerText : "Serious",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "KIDS_REPORT_DTE",
								headerText : "인지일",
								formatString : "yyyy-mm-dd",
						 		dataType:"date",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "FRT_RCEPT_DTE",
								headerText : "KIDS 보고일자",
								formatString : "yyyy-mm-dd",
						 		dataType:"date",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "KIDS_NO",
								headerText : "KIDS No",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "NORMAL",
								headerText : "정상/비정상",
						 		filter : {
						 			showIcon : true
						 		}
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
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
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
			
		$(function(){
			pageInit();
			makeFileAttachment();
			buttonActive();
		});
		
		function pageInit(){
			mkSetDatePickerYYMMDD("#txtFirstDateStart", "#txtFirstDateEnd", -30);
			mkSetDatePickerYYMMDD("#txtReportDateStart", "#txtReportDateEnd", -30);
			gridVerification.createGrid();
			
			$('#ajaxForm').ajaxForm({
				beforeSubmit: function (data,form,option) {
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
						gridVerification.proxy.param.callbackFunction = "refreshGrid";
						gridVerification.proxy.param.FILENM = data.result;
					
						mkLayerPopupOpen("/sdb/e03/popupSdbe0311.do", gridVerification.proxy.param);
						AUIGrid.resize(gridVerificationConfirm.id);
					} else {
						alert(data.message);
					}
				},
				error: function(){
					alert("file upload error!!");
				}
			});
			AUIGrid.setGridData(gridVerification.id, []);
		}
		
		function buttonActive(){
			$("#btnVerification").click(function(){
// 				if(!mkValidation()){
// 					return;
// 				}
// 				if($("#egovComFileList").find("div").length <= 0){
// 					alert("안전관리원 파일을 먼저 등록하십시오.");
// 					return;
// 				}
				
// 				var item = AUIGrid.getGridData(gridVerification.id);
// 				if(item.length <= 0){
// 					alert("검색을 먼저 진행하십시오.");
// 					return;
// 				}
				$('#ajaxForm').submit();
// 				var param = {
// 						callbackFunction : "refreshGrid"
// 					};
				
// 				mkLayerPopupOpen("/sdb/e03/popupSdbe0311.do", param);
// 				AUIGrid.resize(gridVerification.id);
			});
			
			$("#btnExcel").click(function(){
				var data = AUIGrid.getGridData(gridVerification.id);
				if(data.length <= 0){
					alert("검색을 먼저 진행하십시오.");
					return;
				}
				if(data.length) {
					var exportProps = {
							fileName : "Verification_List"
					};
					AUIGrid.setProperty(gridVerification.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(gridVerification.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
			
			$("#btnSearch").click(function(){
				if(!mkValidation()){
					return;
				}
				gridVerification.proxy.param = {
						MAFU_NO : $("#txtManufacturingNo").val(),
						PRDUCT_NM : $("#txtBrandName").val(),
						FIRST_DATE_START : $("#txtFirstDateStart").val().replace(/-/gi, ''),
						FIRST_DATE_END : $("#txtFirstDateEnd").val().replace(/-/gi, ''),
						REPORT_DATE_START : $("#txtReportDateStart").val().replace(/-/gi, ''),
						REPORT_DATE_END : $("#txtReportDateEnd").val().replace(/-/gi, ''),
						DMSTC_OUTNATN_SE : $("#sltDomestic option:selected").val(),
						NORMAL : $("#sltNormal option:selected").val()
				};
				gridVerification.load();
			});
		}
		
		function refreshGrid(){
			gridVerification.load();
		}
		
		function makeFileAttachment(){
			//파일업로드 제한 수
			var maxFileNum = 1;
			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
		}
		
		
		$(window).resize(function(){
			if(gridVerification.id){
				AUIGrid.resize(gridVerification.id);
			}
		});
		
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=SDBMENU_ID=SDBE0310&UPPER_MENU_ID=SDBE" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBE0310&UPPER_MENU_ID=SDBE" charEncoding="utf-8"/>
	<div id="wrap">
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
				<section class="conBox100 conBox">
					<div class="conBoxInner">
		                 <article class="conTitBox">
		                     <h5>검색</h5>
		                 </article>
						<article class="conTitBtn">
							<table class="tb001">
								<colgroup>
									<col width="15%" />
									<col width="35%" />
									<col width="15%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>Manufacturing No.</th>
										<td>
											<input type="text" id="txtManufacturingNo" style="width:100%;">
										</td>
										<th>Brand Name</th>
										<td><input type="text" id="txtBrandName" style="width:100%;"></td>
									</tr>
									<tr>

										<th>인지일<span class="must_01"></span></th>
										<td>
											<div class="dateBox" ><input id="txtFirstDateStart" type="text" style="width:120px;" valireqire="인지일" validate="인지일" /></div>
											<span> ~ </span>
											<div class="dateBox" ><input id="txtFirstDateEnd" type="text" style="width:120px;" valireqire="인지일" validate="인지일" /></div>
										</td>
										<th>KIDS 보고일자<span class="must_01"></span></th>
										<td>
											<div class="dateBox" ><input id="txtReportDateStart" type="text" style="width:120px;" valireqire="보고일자" validate="보고일자" /></div>
											<span> ~ </span>
											<div class="dateBox" ><input id="txtReportDateEnd" type="text" style="width:120px;" valireqire="보고일자" validate="보고일자" /></div>
										</td>
									</tr>
									<tr>
										<th>정상/비정상</th>
										<td>
											<select id="sltNormal" style="width:100%;">
												<option value="" selected="selected">전체</option>
												<option value="01">정상</option>
												<option value="02">비정상</option>
											</select>
										</td>
										<th>국내/외<span class="must_01"></span></th>
										<td>
											<select id="sltDomestic" style="width:100%;" valireqire="국내외">
												<option value="" selected="selected">===selected===</option>
												<option value="01">국내</option>
												<option value="02">국외</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
							<div style="text-align:center; margin:8px 0 0 0;">
								<input type="button" id="btnSearch" class="btn mgL3" value="검색">
							</div>
						</article>
		                 <article class="conTitBox">
		                     <h5>안전관리원파일</h5>
		                 </article>
						<div style=" margin-top: 10px;">
							<table class="tb001">
								<colgroup>
									<col width="" />
									<col width="10%" />
								</colgroup>
								<tbody>
									<tr>
										<td style="padding-top: 5px; padding-bottom: 5px; border-right:none;">
											<form id="ajaxForm" action="<c:url value='/sdb/e03/insertSafetyManagerFile.do'/>" method="post" enctype="multipart/form-data">
												<input type="file" name="file_1"  id="egovComFileUploader" style="width:50%;" title="첨부파일" />
												<input type="button" id="btnVerification" value="검증" />
												<input type="button" id="btnExcel" value="엑셀" />
												<p>
													<div id="egovComFileList"></div>
												</p>
											</form>
										</td>
										<td style="text-align: right; border-left:none; "></td>
									</tr>
								</tbody>
							</table>
						</div>
						<article class="mgT16">
							<div id="gridVerification" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>