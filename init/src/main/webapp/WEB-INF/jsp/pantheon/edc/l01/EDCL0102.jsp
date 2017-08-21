<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>

</head>
<script type="text/javascript">
	var EDCL0102_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCL0102_grid',
			paging : {
				pagingDiv : 'EDCL0102_grid_paging',
				totalRowCount : 500,
				rowCount : 20,
				pageButtonCount : 5,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectCdiscVariablValueList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : true,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : true,
			enableMovingColumn : false,
			editable : false,
			enableFilter : true,
			headerHeight : 50,
			rowHeight : 37,
			fixedColumnCount : 0,
			selectionMode : "singleRow"
		},
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;
			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, $.parseJSON(gridHeader), me.gridPros);
			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		},
		//사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
		createPagingNavigator : function(goPage) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			fn_createPagingNavigator(me, goPage);
		},
		//페이징 에서 어느 페이지로 갈 것인지 지정
		moveToPage : function(goPage, rowCount) {
			var me = this;
			if (!me.div.paging.pagingDiv) {
				return;
			}
			$("#searchForm PAGE").val(goPage);
			fn_moveToPage(me, goPage, rowCount)
		}
	};
	
	var gridHeader = null;
	
	function makeFileAttachment(){
		//파일업로드 제한 수
		var maxFileNum = 0;
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	}

	$(function() {
		// 하위 xml또는 엑셀
		$("#btn").click(function() {
			$("#cfcdiscDomnSn").val($('#selectModules option:selected').val());
			
			var formData = new FormData();
			var formTag = $('#ajaxForm').children().children();
			
			for(var i = 0; i < formTag.length; i++) {
				formData.append(formTag[i].name, formTag[i].value);
				
				if(formTag[i].type == 'file') {
					formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
				}
			}
			
			$.ajax({
				url : './selectCdiscFileChk.do',
				data : formData,
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					//location.href="./COMZ0201_DOWN.do?MstrSn=" + data.result;
					// location.href="./selectCdiscExcelChk.do?MstrSn=" + data.result; 
//	 				if(data.success) {
//	 					location.replace("./COMZ0201_DOWN.do?MstrSn=" + data.result);
//	 				}

					var chkVal = data.chk + '(사유 : ' + data.failMessage + ')';
					
					$('#chkDiv').append(chkVal);
					if(data.chk == 'success'){
						// 유효성 검사 성공일때 
					}else{
						// 유효성 검사 실패일때
					}

				}
			});
		});
		
		
		$.ajax({
			url : './selectCdiscDomainList.do',
			type: 'post',
			dataType: 'json',
			data:{'cfcdiscSn': $("#cdiscSn").val()},
			success : function(data) {
				if(data.success) {
					loadCombo($("#selectModules"), data.result);
					$("#selectModules").val("");
				}
			}
		});
		
		function loadCombo(target, data) {
			var dataArr = [];
			var inx = 0;
			target.empty();

			$(data).each( function() {
				dataArr[inx++] = "<option value=" + this.CFCDISC_DOMN_SN + ">" + this.DOMN_NM + "</option> ";
			});

			target.append(dataArr);
		}
		
		// 도메인을 바꿀 때 그리드 헤더를 새로 설정해야 한다.
		$("#selectModules").change(function() {
			if($('#selectModules option:selected').val()) {
				AUIGrid.destroy(EDCL0102_grid.id);
				getHeaderText();
				
				$("#cfcdiscDomnSn").val($('#selectModules option:selected').val());
				var gridParam = $("#ajaxForm").serialize();
				
				EDCL0102_grid.proxy.param = gridParam;
				EDCL0102_grid.createGrid();
				
			}
		});
		
	});
	
	function searchClick(page) {
		if (page == undefined) {
			page = 1;
		}

		$("#searchForm #PAGE").val(page);
		$("#searchForm #COUNT").val(EDCL0102_grid.div.paging.rowCount);
		var param = $("#ajaxForm").serialize();
		EDCL0102_grid.proxy.param = param;
		EDCL0102_grid.load();
	}
	
	function getHeaderText(){
			
		var domnSn = $('#selectModules option:selected').val();
		gridHeader = "[";
		
		$.ajax({
			type : "POST",
			data : {'cfcdiscDomnSn': domnSn },
			async : false,
			url : "./selectCdiscVariablList.do",
			success :function(data){
				var total = data.length;
				var i = 1;
				$.each(data, function(index, result){
					
					if(index === total -1){
						gridHeader += "{ \"dataField\" : \"" + i + "\", \"headerText\" : \"" + result.VRIABL_NM + "\", \"editable\": false}";
					}else{
						gridHeader += "{ \"dataField\" : \"" + i + "\", \"headerText\" : \"" + result.VRIABL_NM + "\", \"editable\": false},";	
					}
					i++;
				});
			}
		});
		gridHeader += "]";
		console.log(gridHeader);
	}
	
	$(document).ready(function() {
	//	getHeaderText();
		EDCL0102_grid.createGrid();
		//문서로딩 후, MultiSelector 생성
		makeFileAttachment();
		
		$("#closePop").click(function() {
	        $('.popup_bg, .popup').fadeOut(500);
	        searchClick();
		});
	});
	
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCL0102_grid.id !== "undefined") {
			AUIGrid.resize(EDCL0102_grid.id);
		}
	};
</script>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCL0102&&UPPER_MENU_ID=EDCL" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCL0102&&UPPER_MENU_ID=EDCL" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
		
			<article class="mainTitBox">
            <h3>Data Import View</h3>

            	<nav id="pathNav">
                	<ul>
                        <li>
                            <a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a>
                        </li>
                        <li><a href="#">Module</a></li>
                    </ul>
                </nav>
            </article>

			<!-- 팝업 배경 시작 -->
			<div class="popup_bg"></div> 
			<!-- 팝업 배경 끝 -->
			
			<!-- 팝업 wrap 시작 -->
			<section class="popupWrap">
			    <!-- 팝업 시작 -->
			    <!-- 팝업 세로는 자동지정이지만, 가로는 지정해줘야한다. wd00의 00은 픽셀 사이즈 1~100은 1단위, 1000은 10단위-->
			    <!-- popup01은 popup-button01에 맞추는등, 숫자를 맞춰준다 -->
			    <div class="popup popup01 wd800"> 
			    <img class="popup_close" src="../../../images/pantheon/common/popupX.png" alt=""> <!-- 팝업 X 끄기 -->
                     <!-- 팝업 내부 컨텐츠 시작 -->
                     <article class="conTitBox">
                         <h5></h5>
                     </article>

                     <article class="conTitBtn">
						<form id="ajaxForm" action="<c:url value='/com/z02/insertDmFileMstr.do'/>" method="post" enctype="multipart/form-data">
                         <div class="conTitBtnL">
                            <input type="hidden" id="moduleKnd" name="moduleKnd" value="EDC">
                            <input type="hidden" id="cfcdiscDomnSn" name="cfcdiscDomnSn" value="">
                            
                                 업로드파일 <input name="file_1" id="egovComFileUploader" type="file" class="btn mgL3" size="60" title="첨부파일입력"/>
							<p>
								<div id="egovComFileList"></div>
							</p>
							
                                <div class="conTitBtnR">
                                    <input type="button" id="btn" class="btn mgL3" value="업로드">
                                    <input type="button" class="btn mgL3" id="closePop" value="닫기">
                                </div>
                            유효성 검사 : <div id="chkDiv"/>
                         </div>
                         </form>
                     </article>

                     <!-- 팝업 내부 컨텐츠 끝 -->
			    </div>
			    <!-- 팝업 끝 -->
			</section>
			<!-- 팝업 wrap 끝 -->
			
		<form name="searchForm" id="searchForm">
		<input type="hidden" id="PAGE" name="PAGE">
		<input type="hidden" id="COUNT" name="COUNT">
		<input type="hidden" id="cdiscSecode" name="cdiscSecode" value="${param.cdiscSecode}">
		<input type="hidden" id="imprtNmParam" name="imprtNmParam" value="${param.imprtNmParam}">
		<input type="hidden" id="cdiscSn" name="cdiscSn" value="${param.cdiscSn}">
		
		
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">
                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5></h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드  상단메뉴라인 시작-->        
                    <article class="conTitBtn">
                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                        	Domain <select id="selectModules" style="width:105px">
										<option>===selected===</option>
									</select>
									<input type="button" id="testBtn" class="btn mgL3" value="테스트">
                        	<br>Import 명 <c:out value="${param.imprtNmParam}"/>     종류 <c:out value="${param.cdiscSecode}"/> 
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->
                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <div class="conTitBtnR">
                            <input type="button" class="popup-button popup-button01" value="Import">
                        </div>
                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="EDCL0102_grid" class="gridHeiSz09 grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
						<div id="EDCL0102_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    <!-- 그리드 끝 -->
                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
        </form>
    	</div>
	</section>
</div>
</body>
</html>
