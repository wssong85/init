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
	var EDCL0101_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCL0101_grid',
			paging : {
				pagingDiv : 'EDCL0101_grid_paging',
				totalRowCount : 500,
				rowCount : 20,
				pageButtonCount : 5,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectCdiscList.do',
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
			fixedColumnCount : 3,
			selectionMode : "singleRow"
		},
		//AUI 그리드 레이아웃 RNUM
		columnLayout : [ {
			dataField : "RNUM",
			headerText : "No",
			editable : false,
			minWidth : 40,
			width : 40
		}, {
			dataField : "IMPRT_NM",
			headerText : "Import명",
			width : 160,
			editable : false
		}, {
			dataField : "CDISC_SE_CODE",
			headerText : "종류",
			width: 80,
			editable : false
		}, {
			dataField : "FRST_CREDE",
			headerText : "생성일",
			width: 120,
			editable : false
		}, {
			dataField : "FRST_CRTR",
			headerText : "생성자",
			width: 160,
			editable : false
		}, {
			dataField : "CFCDISC_SN",
			headerText : "키값",
			editable : false,
			visible : false
		}],
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;
			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			me.binding();
			if (me.proxy.autoLoad) {
				me.load();
			}
		},
		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;
			AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
				if (event.dataField == "IMPRT_NM") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					 $("#cdiscSn").val(rowItem.CFCDISC_SN);
					 $("#imprtNmParam").val(rowItem.IMPRT_NM);
					 $("#cdiscSecode").val(rowItem.CDISC_SE_CODE);
					 $("#searchForm").attr({
						action : './EDCL0102.do',
						method : 'post'
					}).submit(); 
				}
			});
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
	
	function makeFileAttachment(){
		//파일업로드 제한 수
		var maxFileNum = 3;
		var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
		multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
	}

	$(function() {
		// 마스터(define.xml)
		$("#btn").click(function() {
			var formData = new FormData();
			var formTag = $('#ajaxForm').children().children();
			
			for(var i = 0; i < formTag.length; i++) {
				formData.append(formTag[i].name, formTag[i].value);
				
				if(formTag[i].type == 'file') {
					formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
				}
			}
			
			$.ajax({
				url : './selectCdiscFileMstChk.do',
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
	});
	
	function searchClick(page) {
		if (page == undefined) {
			page = 1;
		}

		$("#searchForm #PAGE").val(page);
		$("#searchForm #COUNT").val(EDCL0101_grid.div.paging.rowCount);
		var param = $("#searchForm").serialize();
		EDCL0101_grid.proxy.param = param;
		EDCL0101_grid.load();
	}
	
	$(document).ready(function() {
		EDCL0101_grid.createGrid();
		//문서로딩 후, MultiSelector 생성
		makeFileAttachment();
		
		$("#closePop").click(function() {
	        $('.popup_bg, .popup').fadeOut(500);
	        searchClick();
		});
	});
	
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCL0101_grid.id !== "undefined") {
			AUIGrid.resize(EDCL0101_grid.id);
		}
	};
</script>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCL0101&&UPPER_MENU_ID=EDCL" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCL0101&&UPPER_MENU_ID=EDCL" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
		
			<article class="mainTitBox">
            <h3>Data Import </h3>

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
                             Import 명 <input type="text" id="imprtNm" name="imprtNm" value="aaabb" class="pdR15"> <br/><br/>
                             data type <input type="radio" id="ra01" name="cdiscSeCode" value="SDTM"><label for="ra01" class="raLab"><span>SDTM</span></label>
                                         <input type="radio" id="ra02" name="cdiscSeCode" value="ODM" checked><label for="ra02" class="raLab"><span>ODM</span></label> <br/><br/>
                            <input type="hidden" id="moduleKnd" name="moduleKnd" value="EDC">
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
		<input type="hidden" id="cdiscSn" name="cdiscSn">
		<input type="hidden" id="imprtNmParam" name="imprtNmParam">
		<input type="hidden" id="cdiscSecode" name="cdiscSecode">
		
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
                        	Import 명 <input type="text" name="imprtNm" id="imprtNm" value="" class="pdR15"> <input type="button" class="btn mgL3" onclick="searchClick()" value="검색"> 
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
                        <div id="EDCL0101_grid" class="gridHeiSz09 grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
						<div id="EDCL0101_grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
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
