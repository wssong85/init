<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<style type="text/css">
/* table.tb01{ */
/* 	width: 70% */
/* } */
</style>
<title>교육관리</title>
<script type="text/javascript">
var paramItem;
var com007List; //모듈코드 리스트
var g_CRUD   = "";
var g_EDC_SN = "";
var s_MODULE = "TASK";
var g_MODULE = "";
var grEducation = {
 	id: '',
 	div: {
 		gridDiv: '#grEducation',
 		paging: {
 			pagingDiv: 'pgEducation',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: '/ctms/j03/selectEduMgrList.do',
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: false
 	},
 	gridPros: {
 		usePaging: true,
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "singleRows",

	    enableFilter : true
 	},
 	columnLayout : [{
 		dataField : "EDC_SN",
 		headerText : "교육순번"
 		, visible : false
 	},{
 		dataField : "TASK_SN",
 		headerText : "과제순번"
 		, visible : false
 	},{
 		dataField : "TASK_NM",
 		headerText : "과제명"
 		, width: 300
		, filter : {
			showIcon : true
		  }
 	},{
 		dataField : "TASK_NO",
 		headerText : "과제번호"
 		, width: 120
 		, filter : {
			showIcon : true
		  }
 	},{
 		dataField : "MODULE",
 		headerText : "모듈"
 		, visible : false
 	},{
 		dataField : "MODULE_NM",
 		headerText : "모듈"
 		, width: 100
 		, filter : {
			showIcon : true
		  }
 	},{
 		dataField : "ROLE_NM",
 		headerText : "역할"
 		, width: 180
 		, filter : {
			showIcon : true
		  }
 	},{
 		dataField : "SJ",
 		headerText : "제목"
	    , filter : {
			showIcon : true
		  }
 	},{
 		dataField : "VER",
 		headerText : "버전"
 		, width: 80
 		, filter : {
			showIcon : true
		  }
 	},{
 		dataField : "UDPATE_DE",
 		headerText : "변경일"
 		, width: 100
 		, formatString : "yyyy-mm-dd"
 		, dataType:"date"
		, filter : {
			showIcon : true
		  }
 	},{
 		dataField : "EDC_AT",
 		headerText : "교육중"
 		, width: 80
 		, visible : false

 	}],
 	createGrid: function() {
 		var me = this;
   		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		AUIGrid.bind(grEducation.id, "cellDoubleClick", function(event){
 			console.log(event.value);
 			g_CRUD = "U";
 			g_EDC_SN = event.item.EDC_SN;
 			g_MODULE = event.item.MODULE;
 	 		var param={};
 	 		mkLayerPopupOpen("/ctms/j03/popupDMCJ0302.do", param);
 		 });
 	},
 	load: function(v1, v2) {
 		var me = this;

 		AUIGrid.showAjaxLoader(me.id);

 		$.ajax({
 		    url: me.proxy.url,
 		    type: me.proxy.type,
 		    dataType: me.proxy.dataType,
 		    data: me.proxy.param,
 		    success:function(data){
 		    	if(data.success) {
 		    		if(s_MODULE == "TASK"){
 		    			AUIGrid.setColumnProp(me.id, 2, {headerText : "과제명", width: 300});
 		    		}
 		    		else if(s_MODULE == "SYSTEM"){
 		    			AUIGrid.setColumnProp(me.id, 2, {headerText : "모듈", width: 100});
 		    		}

 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);

 			    	com007List = data.com007; //모률코드 리스트

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

$(function(){

	grEducation.createGrid();
	AUIGrid.resize(grEducation.id);

	$('#SEARCH_COND').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#SEARCH_COND').val()) {
			$('#btnSearch').trigger('click');
		}
	});
	
	$('#btnSearch').click(function() {
 		var params = {
				  SEARCH_TYPE : $("#SEARCH_TYPE").val()
		        , SEARCH_COND : $("#SEARCH_COND").val()
		        , GUBUN : s_MODULE
		    };
 		grEducation.proxy.param = params;
		grEducation.load();
	});
	
	$('#btnNewEdu').click(function() {
		g_CRUD = "C";
		var param={};
		mkLayerPopupOpen("/ctms/j03/popupDMCJ0302.do", param);
	});
	
	$("input[name=raEduGubun]").change(function() {
		var radioValue = $(this).val();
		if(radioValue == "T"){
			s_MODULE = "TASK";
		}
		else if(radioValue == "S"){
			s_MODULE = "SYSTEM";
		}
	});
	
});

$(window).on('resize', function(){
	if (typeof grEducation.id !== "undefined") {
		AUIGrid.resize(grEducation.id);
	}
});


</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0301&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0301&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>교육관리</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>과제관리</li>
						<li>교육관리</li>
					</ul>
				</nav>
			</article>
		
			<section class="conBox100 conBox">
				<div class="conBoxInner">
	
	                <article class="conTitBtn">
	                    <div class="conTitBtnL">
							<select id="SEARCH_TYPE" class="select">
								<option value="1" >과제명</option>
								<option value="2" >과제번호</option>
								<option value="3" >제목</option>
							</select>
	                        <input type="text" id="SEARCH_COND" name="SEARCH_COND" class="pdR15"><input type="button" id="btnSearch" class="btn mgL3" value="검색">
	                        <input type="radio"	id="raTask"   name="raEduGubun" value="T" checked><label for="raTask" class="raLab"><span>과제</span></label>
	                        <input type="radio" id="raSystem" name="raEduGubun" value="S"><label for="raSystem" class="raLab"><span>시스템</span></label>
	                    </div>
	
	                    <div class="conTitBtnR">
	                        <input type="button" id="btnNewEdu" value="신규">
	                    </div>
	                </article>
	
					
					<article class="mgT55">
						<div id="grEducation" class="gridHeiSz17 grid_wrap tb01_2"></div>
					</article>
				</div>
			</section>
		</div>
	</section>
</div>
</body>
</html>