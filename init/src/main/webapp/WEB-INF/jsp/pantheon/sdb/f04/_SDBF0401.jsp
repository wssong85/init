<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>SOP 등록</title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript">
		var gridSop = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grSop',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grSop',
		 		paging: {
		 			pagingDiv: 'grid_paging',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/sdb/f04/selectSopInfo.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: true,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : false,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "SJ",
								headerText : "제목",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "EFECT_OCCRRNC_AT_VALUE",
								headerText : "효력발생여부",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "EFECT_OCCRRNCDE",
								headerText : "효력발생일",
						 		filter : {
						 			showIcon : true
						 		},
						 		formatString : "yyyy-mm-dd",
						 		dataType:"date"
							}, {
								dataField : "FRST_CREDE",
								headerText : "등록일",
						 		filter : {
						 			showIcon : true
						 		},
						 		formatString : "yyyy-mm-dd",
						 		dataType:"date"
							}, {
								dataField : "FILE_MASTR_SN",
								headerText : "File",
							    renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									if(!value)	return "";		
									var template = '<div style="display:inline-block; margin-top:4px; line-height:12px;">';		
									template += '<a href="#" class="my_a_tag" onclick="javascript:showFilePopup('+ value +');"><img style="width:auto; height:12px;" src="../../../images/pantheon/common/AUIGrid/document.png">';		
									template += '</a></div>';
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								dataField : "SN",
								headerText : "SN",
								visible : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		AUIGrid.bind(me.id, "cellClick", auiGridCellClickHandler);
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 		
		 		//autoLoad로 처음 화면 데이터 로딩 
		 		if(me.proxy.paging && !v1 && !v2) {
		 			me.proxy.param.page = me.div.paging.currentPage;		
		 			me.proxy.param.count= me.div.paging.rowCount;		
		 		}
		 		
		 		//moveToPage 로 데이터 요청
		 		if(v1 && v2) {
		 			me.proxy.param.page = v2;	
		 			me.div.paging.currentPage = v2;
		 			me.proxy.param.count = v1;		
		 			me.div.paging.rowCount = v1;		
		 		}
		 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result == "true") {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 			    	
		 			    	//샘플때문에 페이징 나타나게 하기위해 임의의 값 넣어줌 
//		  			    	data.count = 13;
//		  			    	console.log(data.count);
		 			    	//paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
		 			    	if(data.count && me.proxy.paging) {
		 			    		
		 			    		me.div.paging.totalRowCount = data.count;
		 			    		me.createPagingNavigator(me.div.paging.currentPage);
		 			    	}
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
		 	},
		 	//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		 	createPagingNavigator: function(goPage) {
		 		var me = this;
		 
		 		if(!me.div.paging.pagingDiv) { 
		 			return;
		 		}
		 		
		 		me.div.paging.totalPage = Math.ceil(me.div.paging.totalRowCount/me.div.paging.rowCount);
		 		
		 		var retStr = "";
		 		var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * me.div.paging.pageButtonCount;
		 		var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount + 1;
		 
		 		prevPage = Math.max(0, prevPage);
		 		nextPage = Math.min(nextPage, me.div.paging.totalPage);
		 		
		 		//셀렉트박스
		 		retStr += "<select style='float:left;' onchange='javascript:gridDelivery.moveToPage(gridDelivery.div.paging.currentPage, this.value)'>"
		 		if(gridDelivery.div.paging.rowCount == 20) {
		 			retStr += "<option value=20 selected=true>20</option>"
		 		} else {
		 			retStr += "<option value=20>20</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 50) {
		 			retStr += "<option value=50 selected=true>50</option>"
		 		} else {
		 			retStr += "<option value=50>50</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 100) {
		 			retStr += "<option value=100 selected=true>100</option>"
		 		} else {
		 			retStr += "<option value=100>100</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 300) {
		 			retStr += "<option value=300 selected=true>300</option>"
		 		} else {
		 			retStr += "<option value=300>300</option>"
		 		}
		 		if(gridDelivery.div.paging.rowCount == 500) {
		 			retStr += "<option value=500 selected=true>500</option>"
		 		} else {
		 			retStr += "<option value=500>500</option>"
		 		}
		 		retStr += "</select>"
		 				 
		 		$(".aui-grid-paging-panel").append(retStr);
		 		//document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
		 	}
		};
	
		$(function(){
			initPageSetting();
			buttonActive();
		});
		
		function initPageSetting(){
			mkSetDatePickerYYMMDD("#txtEffectDate");
			gridSop.createGrid();
			
			var maxFileNum = 5;
			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
			
			$("input[type=radio][name=flag]").change(function(){
				if($(":radio[name=flag]:checked").val() == "Y"){
					$("#txtEffectDate").attr("disabled", false);
					$("#txtEffectDate").attr("valireqire", "효력발생일");
					$(".ui-datepicker-trigger").show();
				}else{
					$("#txtEffectDate").attr("disabled", true);
					$(".ui-datepicker-trigger").hide();
					$("#txtEffectDate").val("");
					$("#txtEffectDate").removeAttr("valireqire");
				}
			});
		}
		
		function buttonActive(){
			$("#btnInit").click(function(){
				init();
			});
			
			$("#btnSave").click(function(){
				saveSopInfo();
			});
			
			$("#btnDelete").click(function(){
				deleteSopInfo();
			});
						
			$("#btnDown").click(function(){
				var data = AUIGrid.getGridData(gridSop.id);
				
				if(data.length) {
					var exportProps = {
							fileName : "Delivery_List"
					};
					AUIGrid.setProperty(gridSop.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
					AUIGrid.exportToXlsx(gridSop.id, true, exportProps);
				} else {
					alert('데이터 확인');
				}
			});
		}
		
		function saveSopInfo(){
			if(!window.confirm("저장하시겠습니까?")){
				return;
			}
			if(!mkValidation()){
				return;
			}
			
			var formData = new FormData();
			var formTag = $("#form").children();
			
			for(var i = 0; i< formTag.length; i++){
				if(formTag[i].type == "file"){
					formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
				}
			}
			
			formData.append("SJ", $("#txtTitle").val());
			formData.append("CN", $("#txtContent").val());
			formData.append("EFECT_OCCRRNC_AT", $(":radio[name=flag]:checked").val());
			formData.append("EFECT_OCCRRNCDE", $("#txtEffectDate").val().replace(/-/gi, ""));
			formData.append("SE_CODE", "01");
			formData.append("FILE_MASTR_SN", $("#hFileFn").val());
			formData.append("SN", $("#hSN").val());
			formData.append("DELFILE", $("#hDeleteFile").val());
			
			$.ajax({
				url : '/sdb/f04/insertSopInfo.do',
				data : formData,
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {					
					if(data.result == "true"){
						alert("저장하였습니다");
						gridSop.load();
						init();
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
		
		function deleteSopInfo(){
			if(!window.confirm("삭제하시겠습니까?")){
				return;
			}
			
			var param = {
					SN : $("#hSN").val()
			};
			
			$.ajax({
				url : '/sdb/f04/deleteSopInfo.do',
				data : param,
				type : 'POST',
				dataType	: "json",
				success : function(data) {					
					if(data.result == "true"){
						alert("삭제하였습니다");
						gridSop.load();
						init();
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
		
		function auiGridCellClickHandler(){
			var str = "";
			var i, rowItem, rowInfoObj, dataField;
			$('#egovComFileList').children().remove();
			var selectionMode = AUIGrid.getProperty(gridSop.id, "selectionMode");
			
			var selectedItems = AUIGrid.getSelectedItems(gridSop.id);	
			if(selectedItems.length <= 0) {
				alert("없음");
				return;
			}
			
			rowInfoObj = selectedItems[0];
			rowItem = rowInfoObj.item;
			//str += "rowIdx : " + rowInfoObj.rowIndex + ", id : " + rowItem.id + ", name : " + rowItem.name + ", country : " + rowItem.country + "......\n";
			var sn = rowItem.SN;
			var file_mastr_sn = rowItem.FILE_MASTR_SN;
			var params ={
					SN : sn,
					FILE_MASTR_SN : file_mastr_sn
			};
			init();
			$("#hFileFn").val(file_mastr_sn);
			$("#hSN").val(sn);
			$.ajax({
				type		: "POST",
				url			: "/sdb/f04/selectSopInfo.do",
				data		: params,
				dataType	: "json",
				success : function(result) {
					if(result.result == "true"){
						$("#txtTitle").val(result.list[0].SJ);
						$("#txtContent").val(result.list[0].CN);
						$(":radio[name=flag][value=" + result.list[0].EFECT_OCCRRNC_AT +"]").prop("checked", true);
						if($(":radio[name=flag]:checked").val() == "Y"){
							$("#txtEffectDate").attr("disabled", false);
							$(".ui-datepicker-trigger").show();
						}else{
							$("#txtEffectDate").attr("disabled", true);
							$("#txtEffectDate").val("");
							$(".ui-datepicker-trigger").hide();
						}
						$("#txtEffectDate").val(result.list[0].EFECT_OCCRRNCDE);
						for(var i = 0; i < result.fileList.length; i++){
							var tag = ""
							tag = '<div id="' + result.fileList[i].DETAIL_SN + '"><a href="javascript:fn_downFile('+result.fileList[i].FILE_MASTR_SN+', '+result.fileList[i].DETAIL_SN+')">'+result.fileList[i].FILE_NAME+'</a><input type="button" onclick="del_file('+result.fileList[i].FILE_MASTR_SN+', '+result.fileList[i].DETAIL_SN+')" value="Delete"/></div>';
							
							$('#egovComFileList').append(tag);
						}
					} else {
						alert(result.message);
					}
				}, 
				error : function(xhr, textStatus, errorThrown){
					//alert(textStatus);
					alert("실패");
			  	}
			});
		}
		
		function fn_downFile(fileMastrSn, fileSn){
			window.open("<c:url value='/com/z02/selectDmFileDetailByPk.do?FILE_MASTR_SN="+fileMastrSn+"&DETAIL_SN="+fileSn+"'/>");
		}
		
		function showFilePopup(fileMastrSn){
			alert("추후개발");
		}
		
		function del_file(fileMastrSn, fileSn){
			if(!window.confirm("첨부 파일을 삭제하시겠습니까?")){
				return;
			}
			
			$("#" + fileSn).remove();
			if(!$("#hDeleteFile").val()){
				$("#hDeleteFile").val(fileSn);
			}else{
				$("#hDeleteFile").val($("#hDeleteFile").val() + "," + fileSn);
			}
			
// 			$.ajax({
// 				type		: "POST",
// 				url			: "/sdb/f04/deleteFileInfo.do",
// 				data		: param,
// 				dataType	: "json",
// 				success : function(result) {
// 					if(result.result == "true"){
// 						alert(result.message);
// 						auiGridCellClickHandler();
// 					} else {
// 						alert(result.message);
// 					}
// 				}, 
// 				error : function(xhr, textStatus, errorThrown){
// 					//alert(textStatus);
// 					alert("실패");
// 			  	}
// 			});
		}
		
		function init(){
			$("#txtTitle").val("");
			$("#txtContent").val("");
			$("input[name=flag][value=Y]").attr("checked", true);
			$("input[name=flag][value=N]").attr("checked", false);
			mkSetDatePickerYYMMDD("#txtEffectDate");
			$("input[type=file]").each(function(){
				if($(this).attr("name") != "file_0"){
					$(this).remove();
				}else {
					$(this).removeAttr("style");
				}
			});
			$("#egovComFileUploader").val("");
			$('#egovComFileList').empty();
			$("#hFileFn").val("");
			$("#hSN").val("");
			$("#hDeleteFile").val("");
		}
	</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBF0401&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBF0401&UPPER_MENU_ID=SDBF" charEncoding="utf-8"/>




	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>SOP 등록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>SYSTEM MASTER FILE</li>
						<li>SOP 등록</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner">
					<article>
						<div class="conTitBtnR">
							<input type="button" id="btnInit" value="초기화" />
							<input type="button" id="btnSave" value="저장" />
							<input type="button" id="btnDelete" value="삭제" />
						</div>
					</article>


					<article class="mgT44">
						<table class="tb001">
							<colgroup>
								<col width="11%" />
								<col width="" />
							</colgroup>
							<tbody>
								<tr>
									<th>제목</th>
									<td><input type="text" id="txtTitle" valireqire="제목" style="width:70%;" /></td>
								</tr>
								<tr>
									<th>내용</th>
									<td style="padding-top:4px;">
										<textarea id="txtContent" rows="4" style="width:70%;"></textarea>
									</td>
								</tr>
								<tr>
									<th>효력발생여부</th>
									<td>
										<input type="radio" id="rdoYes" name="flag" value="Y" checked="checked" /><label for="rdoYes" class="raLab"><span>YES</span></label>
										<input type="radio" id="rdoNo" name="flag" value="N" /><label for="rdoNo" class="raLab"><span>NO</span></label>
									</td>
								</tr>
								<tr>
									<th>효력발생일</th>
									<td><div class="dateBox"><input type="text" id="txtEffectDate" /></div></td>
								</tr>
								<tr>
									<th>파일업로드</th>
									<td style="padding-top:4px;">
										<form id="form" method="post" enctype="multipart/form-data">
											<input type="file" name="file_1"  id="egovComFileUploader" size="60" title="첨부파일" />
											<p>
												<div id="egovComFileList"></div>
											</p>
											<input type="hidden" id="hFileFn" value="" />
										</form>
										<input type="hidden" id="hSN" value="" />
										<input type="hidden" id="hDeleteFile" value="" />
									</td>
								</tr>
							</tbody>
						</table>
					</article>
					
				</div>
            </section>

<style>
#egovComFileList input{ margin:0 0 5px 5px;}
</style>



		
			<section class="conBox100 conBox">
				<div class="conBoxInner">
					<article>
						<div class="conTitBtnR">
							<input type="button" id="btnDown" value="엑셀" />
						</div>
					</article>
					<article class="mgT44">
						<div id="grSop" class="gridHeiSz07 grid_wrap tb01_2"></div>
					</article>
				</div>
			</section>





		</div>
	</section>
</div>
</body>
</html>