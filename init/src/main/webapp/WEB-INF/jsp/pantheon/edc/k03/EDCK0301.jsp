<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<title>Lab 정상범위 관리 목록</title>
<style>
.edc_column_style {	color: #5570e6; text-decoration:underline; font-weight: bold;}
.edc_column_style:hover{text-decoration:underline; cursor:pointer;}
</style>
<script type="text/javascript">
	var EDCK0301_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCK0301_grid',
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectLabList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
		usePaging : true,
		    
		showRowNumColumn : true,
		showRowCheckColumn : false,

		enableColumnResize : true,
		enableMovingColumn : false,

		editable : false,
		enableFilter : true,
	    showPageButtonCount : 5,
	    headerHeight: 60,
	    rowHeight: 37,
	    selectionMode : "singleRows",
	    displayTreeOpen : true,
		},
		//AUI 그리드 레이아웃 RNUM
		columnLayout : [ {
			dataField : "NAME1",
			headerText : "기관명<span style='color:red'>*</span>",
			width : 160,
			editable : false,
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "LAB_NM",
			headerText : "Laboratory<span style='color:red'>*</span>",
			width : 180,
			editable : false,
			style : "edc_column_style",
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "LAB_SN",
			headerText : "LAB SN",
			editable : false,
			visible : false
		},{
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "Analysis parameter<span style='color:red'>*</span>",
			width: 150,
			editable : false,
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "ANALS_PARAMTR",
			headerText : "ANALS_PARAMTR",
			visible : false,
		},{
			dataField : "UNIT",
			headerText : "Unit<span style='color:red'>*</span>",
			editable : false,
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "SCOPE_LWLT_VALUE",
			headerText : "Reference Range<br> Lower Limit<span style='color:red'>*</span>",
			width: 140,
			editable : false,
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "SCOPE_UPLMT_VALUE",
			headerText : "Reference Range<br> Upper Limit<span style='color:red'>*</span>",
			width: 140,
			editable : false,
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "APPLC_DATE",
			headerText : "적용기간<span style='color:red'>*</span>",
			width: 180,
			editable : false,
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "AGE",
			headerText : "연령<span style='color:red'>*</span>",
			width: 60,
			editable : false,
			filter : {
		    	showIcon : true
		    }
		},{
			dataField : "SEXDSTN",
			headerText : "성별<span style='color:red'>*</span>",
			width: 60,
			editable : false,
			filter : {
		    	showIcon : true
		    }
		} ],
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
			AUIGrid.bind(me.id, 'cellClick', function(event) {
				if (event.dataField == "LAB_NM") {
					var rowItem = AUIGrid.getItemByRowIndex(me.id, event.rowIndex);
					$("#searchForm #INSTT_NM").val(rowItem.INSTT_NM);
					$("#LAB_SN").val(rowItem.LAB_SN);
					$("#crud").val("U");
					$("#searchForm").attr({
						action : './selectLab.do',
						method : 'post'
					}).submit();
				}
			});
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function fnInsert() {
		$("#LAB_SN").val("");
		$("#crud").val("C");
		$("#searchForm").attr({
			action : './EDCK0302.do',
			method : 'post'
		}).submit();
	}
	function searchClick(page) {
		if (page == undefined) {
			page = 1;
		}

		var param = $("#searchForm").serialize();
		EDCK0301_grid.proxy.param = param;
		EDCK0301_grid.load();
	}
	$(document).ready(function() {
		EDCK0301_grid.createGrid();
	});
	// 윈도우 리사이징 이벤트
	window.onresize = function() {
		if (typeof EDCK0301_grid.id !== "undefined") {
			AUIGrid.resize(EDCK0301_grid.id);
		}
	};
	
	function fn_formDown(){
		$.ajax({
			url : './selectDownTemplate.do',
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				if(data.success) {
					window.open("<c:url value='/edc/k03/selectOpenFile.do?FILE_PATH=" + data.filePath + "&FILE_NAME=" + data.fileName + "'/>");
					
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	}
	
	function fn_formUpload(){
		mkLayerPopupOpen("./popupEDCK0303.do", null);
		AUIGrid.resize(EDCK0303_grid.id);
	}
	
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0301&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0301&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Lab 정상범위 관리</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>과제관리</li>
						<li>Lab 정상범위 관리</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">

				<div class="conBoxInner">
					<form name="searchForm" id="searchForm">
					<input type="hidden" name="LAB_SN" id="LAB_SN"/>
					<input type="hidden" id="crud" name="crud" value="">

		            	<articla class="conTitBox">
		            		<h5>Lab 정상범위 목록</h5>
		            	</articla>

						<article class="mgT10" style="overflow:hidden;">
							<div class="conTitBtnL">
								<input type="hidden" id="PAGE" name="PAGE">
								<input type="hidden" id="COUNT" name="COUNT">
								<span style="font-family:'NanumGothicBold';">기관명 :</span>
								<input type="text" id="INSTT_NM" name="INSTT_NM" class="pdR100">
								<input type="button" class="btn mgL3" onclick="searchClick()" value="검색">
							</div>
							<div class="conTitBtnR">									
								<input type="button" value="신규" onclick="fnInsert()">
								<input type="button" value="양식다운로드" onclick="fn_formDown()">
								<input type="button" value="업로드" onclick="fn_formUpload()">
							</div>
						</article>

						<article class="mgT16">
	                        <div id="EDCK0301_grid" class="gridHeiSz10 grid_wrap tb01_2"></div>
						</article>
						
						<article class="mgT16">
							<div id="grid_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
						</article>

					</form>
				</div>
            </section>
		</div>
	</section>
</div>
</body>
</html>