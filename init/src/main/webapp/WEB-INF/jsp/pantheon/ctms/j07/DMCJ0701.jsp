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

<title></title>
<script type="text/javascript">
var grCmRoleUser = {
 	id: '',
 	div: {
 		gridDiv: '#grCmRoleUser'
 	},
 	proxy: {
 		url: './selectRoleByProgAndBtnList.do',
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
	    selectionMode : "singleRows",
	    softRemoveRowMode: false
// 	    rowIdField : "PROGRM_ID"
 	},
 	//AUI 그리드 레이아웃
 	columnLayout : [{
 		dataField : "ROLE_ID",
 		headerText : "ROLE_ID",
 		width: 80 ,
 		visible: false
 	},{
 		dataField : "MODULE_CODE",
 		headerText : "모듈"
        , width: 80
        , filter : {
				showIcon : true
			  }
 	},{
 		dataField : "MENU_ID",
 		headerText : "메뉴ID",
 		visible: false
 	},{
 		dataField : "PROGRM_ID",
 		headerText : "프로그램ID",
 		visible: false
 	},{
 		dataField : "MENU_NM",
 		headerText : "메뉴명",
 		visible: false
 	},{
 		dataField : "PROGRM_NM",
 		headerText : "프로그램명"
		, filter : {
			showIcon : true
		}
 	},{
 		dataField : "BUTTON_ID",
 		headerText : "버튼ID"
 		, visible: false
 	},{
 		dataField : "BUTTON_NM",
 		headerText : "버튼명"
		, filter : {
			showIcon : true
		}
 	},{
 		dataField : "BUTTON_DC",
 		headerText : "버튼설명"
 		, visible: false
		, filter : {
			showIcon : true
		}
 	},{
 		dataField : "BUTTON_ORDR",
 		headerText : "버튼순서"
 		, visible: false
 	},{
 		dataField : "ESSNTL_AT",
 		headerText : "필수화면"
 		, visible: false
 	},{
 		dataField : "TASK_AT",
 		headerText : "과제여부"
 		, visible: true
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
 		
 		AUIGrid.bind(me.id, "cellEditBegin", function(event) {
 			if(event.item.BUTTON_ID == ""){
 				return false;
 			}
		}); //cellEditBegin

 		AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
 			var copyItem;
			copyItem = AUIGrid.getSelectedItems(me.id)[0].item;
			copyItem.TASK_SN   = $("#TASK_SN").val();
			copyItem.UPDATE_ID = '${loginMap.USER_ID}';
 			AUIGrid.addRow(grTaskByBtn.id, copyItem, 'last');
 			AUIGrid.removeRow(me.id, "selectedIndex");
		});
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		AUIGrid.showAjaxLoader(me.id);
 		
 		grCmRoleUser.proxy.param = {'ROLE_ID': $('#selectRoles option:selected').val(), 'TASK_SN': $('#TASK_SN').val() };

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

var grTaskByBtn = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grTaskByBtn'
	 	},
	 	proxy: {
	 		url: './selectTaskByBtnList.do',
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
//	 	    rowIdField : "PROGRM_ID"
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
	 		dataField : "ROLE_ID",
	 		headerText : "ROLE_ID",
	 		width: 80 ,
	 		visible: false
	 	},{
	 		dataField : "MODULE_CODE",
	 		headerText : "모듈"
	 	    , width: 60
// 	 	    , filter : {
// 				showIcon : true
// 			}
	 	},{
	 		dataField : "MENU_ID",
	 		headerText : "메뉴ID",
	 		visible: false
	 	},{
	 		dataField : "PROGRM_ID",
	 		headerText : "프로그램ID",
	 		visible: false
	 	},{
	 		dataField : "UPPER_MENU_NM",
	 		headerText : "대메뉴",
	 		visible: true
// 	 		, filter : {
// 				showIcon : true
// 			}
	 	},{
	 		dataField : "MENU_NM",
	 		headerText : "소메뉴",
	 		visible: true
// 	 		, filter : {
// 				showIcon : true
// 			}
	 	},{
	 		dataField : "PROGRM_NM",
	 		headerText : "프로그램명"
//  			, filter : {
// 				showIcon : true
// 			}
	 	},{
	 		dataField : "BUTTON_ID",
	 		headerText : "버튼ID"
	 		, visible: false
	 	},{
	 		dataField : "BUTTON_NM",
	 		headerText : "버튼명"
//  			, filter : {
// 				showIcon : true
// 			}
	 	},{
	 		dataField : "BUTTON_DC",
	 		headerText : "버튼설명"
	      , visible: true
// 	      , filter : {
// 				showIcon : true
// 			}
	 	},{
	 		dataField : "TASK_SN",
	 		headerText : "과제순번"
	 	  , visible: false
	 	},{
	 		dataField : "BUTTON_ORDR",
	 		headerText : "버튼순서"
	 		, visible: false
	 	},{
	 		dataField : "TASK_AT",
	 		headerText : "과제여부"
	 		, visible: true
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
	 			AUIGrid.addRow(grCmRoleUser.id, AUIGrid.getSelectedItems(me.id)[0].item, 'last');
	 			AUIGrid.removeRow(me.id, "selectedIndex");
			});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		
	 		AUIGrid.showAjaxLoader(me.id);
	 		
	 		grTaskByBtn.proxy.param = {  
	 									'ROLE_ID': $('#selectRoles option:selected').val()
	 				                  , 'TASK_SN': $('#TASK_SN').val()
	 				                  };

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

	 			    	grCmRoleUser.load();
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

var p_task_no = "";
var returnTaskValue = "";

function loadCombo(target, data) {
	var dataArr = [];
	var inx = 0;
	target.empty();

	dataArr[inx++] = "<option value=''>선택</option> ";
	$(data).each( function() {
		dataArr[inx++] = "<option value=" + this.ROLE_ID + ">" + this.ROLE_NM + "</option> ";
	});

	target.append(dataArr);
}

function fn_setTaskNo(){
	$("#TASK_SN").val(returnTaskValue.TASK_SN);
	$("#TASK_NO").val(returnTaskValue.TASK_NO);
	if($("#TASK_SN").val() && $("#TASK_NO").val()){
		grTaskByBtn.load();
	}
}

$(function() {
	grCmRoleUser.createGrid();
	grTaskByBtn.createGrid();

	$.ajax({
		url : "<c:url value='/com/b01/selectCmRoleForComboBox.do'/>",
		success : function(data) {
			loadCombo($("#selectRoles"), data.result);
            $("#selectRoles").val("");
		}
	});

	$("#selectRoles").change(function() {
		if($('#selectRoles option:selected').val()) {
			if($("#TASK_SN").val() != null && $("#TASK_NO").val() && $("#TASK_SN").val()){
				grTaskByBtn.load();
			}
		}
	});

	$('#btnTaskNoSearch').click(function() {
		p_task_no = $("#TASK_NO").val();
		var param = {};
		mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
	});
	
	$('#btnLeftMove').click(function() {
		if(!$('#selectRoles option:selected').val()) {
			alert('권한을 지정해 주십시오.');
			return;
		}
		
		var checkedItems = AUIGrid.getCheckedRowItems(grTaskByBtn.id);
		for(var i = 0; i < checkedItems.length; i++) {
			AUIGrid.addRow(grCmRoleUser.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grTaskByBtn.id);
	});

	$('#btnRightMove').click(function() {
		var checkedItems = AUIGrid.getCheckedRowItems(grCmRoleUser.id);
		for(var i = 0; i < checkedItems.length; i++) {
			checkedItems[i].item.TASK_SN   = $("#TASK_SN").val();
			checkedItems[i].item.UPDATE_ID = '${loginMap.USER_ID}';
			AUIGrid.addRow(grTaskByBtn.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grCmRoleUser.id);
	});
	
	$('#btnRowDelete').click(function() {
		var checkedItems = AUIGrid.getCheckedRowItems(grCmRoleUser.id);
		
		if(!checkedItems.length) {
			return;
		}
		
		for(var i = 0; i < checkedItems.length; i++) {
			AUIGrid.addRow(grCmMenu.id, checkedItems[i].item, 'last');
		}
		
		AUIGrid.removeCheckedRows(grCmRoleUser.id);
	});

	$('#btnSave').click(function() {
		
		var rowCnt = AUIGrid.getGridData(grTaskByBtn.id);

		if(rowCnt.length > 0){
			
			if(confirm("저장 하시겠습니까?")){
				AUIGrid.showAjaxLoader(grTaskByBtn.id);
				
				fn_pkProgramCopy(); //필수 화면 추가
				
				var data = AUIGrid.getGridData(grTaskByBtn.id);

				if(!data.length) {
					data.push({'ROLE_ID': $('#selectRoles option:selected').val(), 'TASK_SN': $('#TASK_SN').val()});
				}

				$.ajax({
					  url : './insertTaskByBtnInfo.do',
					  type: 'post',
					  contentType: "application/json; charset=UTF-8",
					  data : JSON.stringify(data),
					  success : function(data, textStatus, jqXHR) {
						  if(data.success) {
							  grTaskByBtn.load();
						  } else {
							  AUIGrid.removeAjaxLoader(grTaskByBtn.id);
							  alert(data.message);
						  }
					  }, 
					  error : function(jqXHR, textStatus, errorThrown){
						  alert(textStatus);
					  }
				});

				AUIGrid.removeAjaxLoader(grTaskByBtn.id);
			} //
		} // if
		else{
			alert("추가된 항목이 없습니다.");
		}
	});

});

function fn_pkProgramCopy(){
	var pkData   = AUIGrid.getGridData(grCmRoleUser.id);
	var saveData = AUIGrid.getGridData(grTaskByBtn.id);
	var pkRowsId, saveRowsId
	var dulCnt = 0;
	for(var i = 0; i < pkData.length; i++) {
		if(pkData[i].ESSNTL_AT == "Y"){
			for(var j=0; saveData.length > j; j++){
				if(pkData[i].ROWS_ID == saveData[j].ROWS_ID){
					dulCnt++;
				}
			}
			if(dulCnt == 0){
				pkData[i].TASK_SN   = $("#TASK_SN").val();
				pkData[i].UPDATE_ID = '${loginMap.USER_ID}';
				AUIGrid.addRow(grTaskByBtn.id, pkData[i], 'last');
			}

			dulCnt = 0;
		} // if
	} // for
}

$(window).resize(function() {
	console.log('resize');
	if (grCmRoleUser.id) {
		AUIGrid.resize(grCmRoleUser.id);
	}
	if (grTaskByBtn.id) {
		AUIGrid.resize(grTaskByBtn.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0701&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0701&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
	<section id="mainCon">
		<section class="mainConInner">
            <!-- 컨텐츠박스 시작-->

			<article class="mainTitBox">
				<h3>과제별 역할관리</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>사용자관리</li>
						<li>과제별 역할관리</li>
					</ul>
				</nav>
			</article>
            
            
            
            
           <section class="conBox50 conBox" style="float: left; width:48%; position:relative;">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>전체역할권한</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
<!--                     
<input type="button" id="btnLeftMove" value="윈쪽">
<input type="button" id="btnRightMove" value="오른쪽">
 -->
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grCmRoleUser" class="gridHeiSz18 grid_wrap tb01_2"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>
                
                
                <div class="center_btn_01">
	                <input type="button" id="btnRightMove" class="big_arrow_btn_01" value="▶">
	                <input type="button" id="btnLeftMove" class="big_arrow_btn_02" value="◀">
                </div>
            </section>
            <!-- 컨텐츠박스 끝-->

<style>

.center_btn_01{  position:absolute; left:100%; top:43%; width:8%; box-sizing:border-box; text-align: center; padding:0 6px; }
.big_arrow_btn_01 {  transition-duration:0s !important;  padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; margin:0 0 6px 0; }
.big_arrow_btn_02 {  transition-duration:0s !important; padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; }

</style>



            <!-- 컨텐츠박스 시작-->
            <section class="conBox50 conBox" style="float: right; width:48%;  ">
                <div class="conBoxInner">
                
                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>과제별 역할권한</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                    	<select id="selectRoles" style="vertical-align: top; width: 76px;">
							<option>선택</option>
						</select>
                    	<input type="hidden" id="TASK_SN" name="TASK_SN">
                        <input type="text" id="TASK_NO" name="TASK_NO" style="width: 150px;">
                        <input type="button" class="btn mgL3" id="btnTaskNoSearch" value="검색">
                        <input type="button" id="btnSave" value="저장">
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grTaskByBtn" class="gridHeiSz18 grid_wrap tb01_2"></div>
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