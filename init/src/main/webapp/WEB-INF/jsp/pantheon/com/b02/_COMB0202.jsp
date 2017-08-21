<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

<title>역할별 권한 관리</title>
<script type="text/javascript">
var grCmMenu = {
 	id: '',
 	div: {
 		gridDiv: '#grCmMenu'
 	},
 	proxy: {
 		url: '/com/common/selectQueryDataList.do',
 		param: {'QUERY': 'selectCmMenuForDefaultGrid'},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: true,
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
 		headerText: '모듈',
 		filter : {
 			showIcon : true
 		},
 		width: 80
 	},{
 		dataField : "UPPER_MENU_NM",
 		headerText: '대메뉴',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "MENU_NM",
 		headerText : "소메뉴",
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "PROGRM_NM",
 		headerText : "프로그램명",
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
 			if(!$('#selectRoles option:selected').val()) {
 				alert('권한을 지정해 주십시오.');
 				return;
 			}
			
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
 	div: {
 		gridDiv: '#grCmRoleUser'
 	},
 	proxy: {
 		url: './selectCmRoleAuthorByRoleId.do',
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		//페이징 true, false 로 지정
 		paging: false,
 		//처음 시작시 데이터 로딩
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
	    softRemoveRowMode: false
// 	    rowIdField : "PROGRM_ID"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "MODULE_CODE",
 		headerText : "모듈",
 		width: 80
 	},{
 		dataField : "UPPER_MENU_ID",
 		headerText : "상위메뉴ID",
 		visible: false
 	},{
 		dataField : "UPPER_MENU_NM",
 		headerText : "대메뉴"
 	},{
 		dataField : "MENU_ID",
 		headerText : "메뉴ID",
 		visible: false
 	},{
 		dataField : "MENU_NM",
 		headerText : "소메뉴"
 	},{
 		dataField : "PROGRM_NM",
 		headerText : "프로그램명"
 	},{
 		dataField : "PROGRM_ID",
 		headerText : "프로그램명",
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
		url : "<c:url value='/com/b01/selectCmRoleForComboBox.do'/>",
		success : function(data) {
			loadCombo($("#selectRoles"), data.result);
            $("#selectRoles").val("");
		}
	});

	$("#selectRoles").change(function() {
		if($('#selectRoles option:selected').val()) {
			grCmRoleUser.proxy.param = {'ROLE_ID': $('#selectRoles option:selected').val()};
			grCmRoleUser.load();
		}
	});
	
	$('#btnInit').click(function() {
		AUIGrid.destroy(grCmMenu.id);
		AUIGrid.destroy(grCmRoleUser.id);
		grCmMenu.createGrid();
		grCmRoleUser.createGrid();
	});
	
	$('#btnMove').click(function() {
		if(!$('#selectRoles option:selected').val()) {
			alert('권한을 지정해 주십시오.');
			return;
		}
		
		var checkedItems = AUIGrid.getCheckedRowItems(grCmMenu.id);
		
		for(var i = 0; i < checkedItems.length; i++) {
			AUIGrid.addRow(grCmRoleUser.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grCmMenu.id);
	});
	
	$('#btnCmRoleUserSave').click(function() {
		if(!$('#selectRoles option:selected').val()) {
			alert('권한을 지정해 주십시오.');
			return;
		}
		
		var data = AUIGrid.getGridData(grCmRoleUser.id);

		for(var i = 0; i < data.length; i++) {
			data[i]['USE_YN'] = 'Y';
			data[i]['UPDATE_ID'] = '${loginMap.USER_ID}';
			data[i]['ROLE_ID'] =  $('#selectRoles option:selected').val();
		}
		
		if(!data.length) {
			data.push({'ROLE_ID': $('#selectRoles option:selected').val()});
		}
		
		$.ajax({
			  url : './insertCmRoleAuthorByRoleId.do',
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(data),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {
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
	
	
            <!-- 컨텐츠박스 시작-->
            <section class="conBox50 conBox" style="float: left; width:48%; position:relative;">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>전체메뉴</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                    	<!-- <input type="button" id="btnInit" value="초기화"> -->
                    	<input type="button" id="btnInit" value="초기화" class="reset_01">
                    	<!-- <input type="button" id="btnMove" value="추가"> -->
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grCmMenu" class="gridHeiSz20 grid_wrap tb01_2"></div>
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

.center_btn_01{  position:absolute; left:100%; top:43%; width:8%; box-sizing:border-box; text-align: center; padding:0 3px;}
.big_arrow_btn_01 {  transition-duration:0s !important;  padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; margin:0 0 6px 0; }
.big_arrow_btn_02 {  transition-duration:0s !important; padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; }




</style>






            <!-- 컨텐츠박스 시작-->
            <section class="conBox50 conBox" style="float: right; width:48%;  ">
                <div class="conBoxInner">
                
                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>권한메뉴</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                        <select id="selectRoles">
							<option>===selected===</option>
						</select>
                       <!--  <input type="button" id="btnCmRoleUserDelete" value="행삭제"> -->
                        <input type="button" id="btnCmRoleUserSave" value="저장">
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grCmRoleUser" class="gridHeiSz20 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->
                </div>

            </section>
            <!-- 컨텐츠박스 끝-->
	</section>
	<!-- 메인 끝 -->
</div>
</body>
</html>