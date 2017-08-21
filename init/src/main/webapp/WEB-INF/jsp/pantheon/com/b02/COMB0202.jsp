<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>

<style type="text/css">
/* 커스텀 칼럼 스타일 정의 */
.aui-grid-user-custom-left {
	text-align:left;
}
.aui-grid-user-custom-left .aui-checkLabelBox .aui-checkbox {
	margin-left: 10px;
}
</style>
<title>${progrmMap.MENU_NM}</title>
<script type="text/javascript">
var grCmMenu = {
 	id: '',
 	div: {
 		gridDiv: '#grCmMenu'
 	},
 	proxy: {
 		url: "<c:url value='/com/b02/selectCmMenuForDefaultGrid.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: false,
 		store: null
 	},
 	gridPros: {
 		showStateColumn: true,
	    showRowNumColumn : true,
	    showRowCheckColumn : true,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    softRemoveRowMode: false,
	    rowIdField : "UNIQUE_ID"
 	},
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText: '<spring:message code="comb0202.gr.MODULE_CODE" />',
 		filter : {
 			showIcon : true
 		},
 		width: 80
 	},{
 		dataField : "UPPER_MENU_NM",
 		headerText: '<spring:message code="comb0202.gr.UPPER_MENU_NM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText: '<spring:message code="comb0202.gr.MENU_NM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_NM",
 		headerText: '<spring:message code="comb0202.gr.PROGRM_NM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_ID",
 		headerText : "PROGRM_ID",
 		filter : {
 			showIcon : true
 		},
 		visible: false
 	},{
 		dataField : "UNIQUE_ID",
 		headerText : "UNIQUE_ID",
 		filter : {
 			showIcon : true
 		},
		visible: false 		
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
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
//  			if(!$('#selectRoles option:selected').val()) {
//  				alert('<spring:message code="comb0202.msg.1"/>');
//  				return;
//  			}
			
 			AUIGrid.addRow(grCmRoleUser.id, AUIGrid.getSelectedItems(grCmMenu.id)[0].item, 'last');
 			AUIGrid.removeRow(grCmMenu.id, 'selectedIndex');
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
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	me.proxy.store = data.result;
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	if(grCmRoleUser.id) {
	 			    	var arrGrCmRoleUser = AUIGrid.getGridData(grCmRoleUser.id);
	 			    	if(arrGrCmRoleUser.length) {
							var arrProgrmId = [];
		 			    	for(var i = 0; i < arrGrCmRoleUser.length; i++) {
		 			    		arrProgrmId.push(arrGrCmRoleUser[i]['UNIQUE_ID']);
		 			    	}
		 			    	
		 			    	AUIGrid.removeRowByRowId(grCmMenu.id, arrProgrmId);
	 			    	}
 			    	}
 			    	
 		    	} else {
 		    		AUIGrid.removeAjaxLoader(me.id);
 		    		alert(data.message);
 		    	}
 		    },
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
 		});
 	},
 	reload: function() {
 		var me = this;
 		if(me.proxy.store) {
			AUIGrid.setGridData(me.id, me.proxy.store); 		
 		}
 	}
};

var grCmRoleUser = {
 	id: '',
 	loadFlag: 1,
 	div: {
 		gridDiv: '#grCmRoleUser'
 	},
 	proxy: {
 		url: "<c:url value='/com/b02/selectCmRoleAuthorByRoleId.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: false
 	},
 	gridPros: {
 		showStateColumn: true,
	    showRowNumColumn : true,
	    showRowCheckColumn : true,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    softRemoveRowMode: false,
	    editable : true
// 	    rowIdField : "PROGRM_ID"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText : '<spring:message code="comb0202.gr.MODULE_CODE" />',
 		width: 80,
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPPER_MENU_ID",
 		headerText : "상위메뉴ID",
 		visible: false,
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPPER_MENU_NM",
 		headerText : '<spring:message code="comb0202.gr.UPPER_MENU_NM" />',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_ID",
 		headerText : "메뉴ID",
 		visible: false,
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText : '<spring:message code="comb0202.gr.MENU_NM" />',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_NM",
 		headerText : '<spring:message code="comb0202.gr.PROGRM_NM" />',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_ID",
 		headerText : "프로그램명",
 		visible: false,
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "REDNG_AT",
 		headerText : '<spring:message code="comb0202.gr.REDNG_AT" />',
 		width: 96,
 		style:"task_style_01",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		filter : {
 			showIcon : true
 		}

 	},{
 		dataField : "WRITE_AT",
 		headerText : '<spring:message code="comb0202.gr.WRITE_AT" />',
 		width: 96,
 		style:"task_style_01",
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		filter : {
 			showIcon : true
 		}
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
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
 			AUIGrid.addRow(grCmMenu.id, AUIGrid.getSelectedItems(me.id)[0].item, 'last');
 			AUIGrid.removeRow(me.id, "selectedIndex");
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
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	if(me.loadFlag) {
 			    		
 			    		//전체
 			    		grCmMenu.proxy.param['ROLE_ID'] =  $('#selectRoles option:selected').val();
 			    		grCmMenu.proxy.param['LOAD_FLAG'] =  me.loadFlag;
 			    		
 			    	} else {
 			    	
 			    		//제한
 			    		grCmMenu.proxy.param['ROLE_ID'] =  $('#selectRoles2 option:selected').val();
 			    		grCmMenu.proxy.param['LOAD_FLAG'] =  me.loadFlag;
 			    		
 			    	}
 			    	
 			    	grCmMenu.load();
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

function loadCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.ROLE_ID + ">" + this.ROLE_NM + "</option> ";
	});

	target.append(dataArr);
}

$(function() {
	grCmMenu.createGrid();
	grCmRoleUser.createGrid();

	$.ajax({
		url : "<c:url value='/com/b02/selectCmRoleByFixingAtNForComboBox.do'/>",
		success : function(data) {
			loadCombo($("#selectRoles"), data.result);
            $("#selectRoles").val("");
		}
	});
	
	$.ajax({
		url : "<c:url value='/com/b02/selectCmRoleByFixingAtYForComboBox.do'/>",
		success : function(data) {
			loadCombo($("#selectRoles2"), data.result);
            $("#selectRoles2").val("");
		}
	});

	$("#selectRoles").change(function() {
		if($('#selectRoles option:selected').val()) {
			
			grCmRoleUser.loadFlag = 1;
			
			grCmRoleUser.proxy.param['ROLE_ID'] = $('#selectRoles option:selected').val();
			grCmRoleUser.proxy.param['LOAD_FLAG'] = grCmRoleUser.loadFlag;
			grCmRoleUser.load();
			
		}
	});
	
	$("#selectRoles2").change(function() {
		if($('#selectRoles2 option:selected').val()) {
			
			grCmRoleUser.loadFlag = 0;
			
			grCmRoleUser.proxy.param['ROLE_ID'] = $('#selectRoles2 option:selected').val();
			grCmRoleUser.proxy.param['LOAD_FLAG'] = grCmRoleUser.loadFlag;
			grCmRoleUser.load();
			
		}
	});
	
	$('#btnInit').click(function() {
		AUIGrid.destroy(grCmRoleUser.id);
		grCmRoleUser.createGrid();
		AUIGrid.destroy(grCmMenu.id);
		grCmMenu.createGrid();
	});
	
	$('#btnMove').click(function() {
// 		if(!$('#selectRoles option:selected').val()) {
// 			alert('<spring:message code="comb0202.msg.1"/>');
// 			return;
// 		}
		
		var checkedItems = AUIGrid.getCheckedRowItems(grCmMenu.id);
		
		for(var i = 0; i < checkedItems.length; i++) {
			AUIGrid.addRow(grCmRoleUser.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grCmMenu.id);
	});
	
	$('#btnCmRoleUserSave').click(function() {
		
		//loadFlag = 0 이면 save2로 저장
		if(!grCmRoleUser.loadFlag) {
			alert('<spring:message code="comb0202.msg.3"/>');
			return;
		}
		
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}
		
		if(!$('#selectRoles option:selected').val()) {
			alert('<spring:message code="comb0202.msg.1"/>');
			return;
		}
		
		var data = AUIGrid.getGridData(grCmRoleUser.id);

		for(var i = 0; i < data.length; i++) {
			if(data[i]['REDNG_AT'] == 'N' && data[i]['WRITE_AT'] == 'Y') {
				alert('<spring:message code="comb0202.msg.2"/>');
				return;
			}
			
			data[i]['USE_YN'] = 'Y';
			data[i]['UPDATE_ID'] = '${loginMap.USER_ID}';
			data[i]['ROLE_ID'] =  $('#selectRoles option:selected').val();
		}
		
		if(!data.length) {
			data.push({'ROLE_ID': $('#selectRoles option:selected').val()});
		}
		
		data[0]['LOAD_FLAG'] = grCmRoleUser.loadFlag;
		
		$.ajax({
			  url : "<c:url value='/com/b02/insertCmRoleAuthorByRoleId.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(data),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {
					    alert('<spring:message code="message.save.2"/>');
					  	grCmRoleUser.load();
				  } else {
					  AUIGrid.removeAjaxLoader(grCmRoleUser.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	
	$('#btnCmRoleUserSave2').click(function() {
		
		//loadFlag = 1 이면 save로 저장
		if(grCmRoleUser.loadFlag) {
			alert('<spring:message code="comb0202.msg.4"/>');
			return;
		}
		
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}
		
		if(!$('#selectRoles2 option:selected').val()) {
			alert('<spring:message code="comb0202.msg.1"/>');
			return;
		}
		
		var data = AUIGrid.getGridData(grCmRoleUser.id);

		for(var i = 0; i < data.length; i++) {
			
			if(data[i]['REDNG_AT'] == 'N' && data[i]['WRITE_AT'] == 'Y') {
				alert('<spring:message code="comb0202.msg.2"/>');
				return;
			}
			
			data[i]['USE_YN'] = 'Y';
			data[i]['UPDATE_ID'] = '${loginMap.USER_ID}';
			data[i]['ROLE_ID'] =  $('#selectRoles2 option:selected').val();
		}
		
		if(!data.length) {
			data.push({'ROLE_ID': $('#selectRoles2 option:selected').val()});
		}
		
		
		
		data[0]['LOAD_FLAG'] = grCmRoleUser.loadFlag;
		
		$.ajax({
			  url : "<c:url value='/com/b02/insertCmRoleAuthorByRoleId.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(data),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {
					    alert('<spring:message code="message.save.2"/>');
						grCmRoleUser.load();
				  } else {
					  AUIGrid.removeAjaxLoader(grCmRoleUser.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	
	$('#btnCmRoleUserDelete').click(function() {
		var checkedItems = AUIGrid.getCheckedRowItems(grCmRoleUser.id);
		
		if(!checkedItems.length) {
			return;
		}
		
		for(var i = 0; i < checkedItems.length; i++) {
			AUIGrid.addRow(grCmMenu.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grCmRoleUser.id);
	});
});

window.onresize = function() {
	if (grCmMenu.id) {
		AUIGrid.resize(grCmMenu.id);
	}
	if (grCmRoleUser.id) {
		AUIGrid.resize(grCmRoleUser.id);
	}
}

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMB0202&UPPER_MENU_ID=COMB" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMB0202&UPPER_MENU_ID=COMB" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
	<section id="mainCon">
		<section class="mainConInner">

			<article class="mainTitBox">
				<h3>${progrmMap.MENU_NM}</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="<c:url value='/images/pantheon/common/pathNavIco.png'/>" alt="">Home</li>
						<li>${progrmMap.UPPER_MENU_NM}</li>
						<li>${progrmMap.MENU_NM}</li>
					</ul>
				</nav>
			</article>

	
            <!-- 컨텐츠박스 시작-->
            <section class="conBox50 conBox" style="float: left; width:48%; position:relative; padding:0px; margin: 12px 12px 12px 12px;">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5><spring:message code="comb0202.title.3"/></h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                    	<!-- <input type="button" id="btnInit" value="초기화"> -->
                    	<input type="button" id="btnInit" value=<spring:message code="btn.init"/> class="reset_01">
                    	<!-- <input type="button" id="btnMove" value="추가"> -->
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grCmMenu" class="gridHeiSz18 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>
                
                <div class="center_btn_01">
	                <input type="button" id="btnMove" class="big_arrow_btn_01" value="▶">
	                <input type="button" id="btnCmRoleUserDelete" class="big_arrow_btn_02" value="◀">
                </div>
            </section>
            <!-- 컨텐츠박스 끝-->



<style>

.center_btn_01{  position:absolute; left:100%; top:43%; width:8%; box-sizing:border-box; text-align: center; padding:0 6px; }
.big_arrow_btn_01 {  transition-duration:0s !important;  padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; margin:0 0 6px 0; }
.big_arrow_btn_02 {  transition-duration:0s !important; padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; }

</style>






            <!-- 컨텐츠박스 시작-->
            <section class="conBox50 conBox" style="float: right; width:48%; ">
                <div class="conBoxInner">
                
                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5><spring:message code="comb0202.title.4" /></h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                        <select id="selectRoles" style="vertical-align: top;">
							<option>===selected===</option>
						</select>
                        <input type="button" id="btnCmRoleUserSave" value=<spring:message code="btn.save"/> class="save_01" title="<spring:message code="btn.save"/>">
						
						<c:if test="${AUTH_BTN_GUBUN eq 'Y'}">                        
                        <select id="selectRoles2" style="vertical-align: top;">
							<option>===selected===</option>
						</select>
                        <input type="button" id="btnCmRoleUserSave2" value=<spring:message code="btn.save"/> class="save_02" title="<spring:message code="btn.save"/>">
                        </c:if>
                    </article>

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grCmRoleUser" class="gridHeiSz18 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->
                </div>

            </section>
            <!-- 컨텐츠박스 끝-->
		</section>
	</section>
	<!-- 메인 끝 -->
</div>
</body>
</html>