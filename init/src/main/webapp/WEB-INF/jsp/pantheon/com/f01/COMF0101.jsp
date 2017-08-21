<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<style>


.login_style_01{ text-align:center; }
.login_style_01 .aui-grid-renderer-base{padding:0 !important;}

.lock_style_01{text-align:center;}
.lock_style_01 .aui-grid-renderer-base{padding:0 !important;}

.use_style_01{text-align:center;}
.use_style_01 .aui-grid-renderer-base{padding:0 !important;}

.tmp_style_01{ }
.tmp_style_01 .aui-grid-renderer-base .aui-grid-button-renderer{ padding:4px 2.2em 7px 1.2em;}
</style>
<script type="text/javascript">
var grCmUser = {
 	id: '',
 	div: {
 		gridDiv: '#grCmUser',
 		paging: {
 			pagingDiv: 'pgCmUser',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		}
 	},
 	proxy: {
 		url: "<c:url value='/com/f01/selectCmUserListByUser.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: true,
 		autoLoad: true
 	},
 	gridPros: {
	    showRowNumColumn : true,
		softRemoveRowMode  : true,
		softRemovePolicy   : "exceptNew",
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : true,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    displayTreeOpen : true
 	},
 	columnLayout : [{
 		dataField : "USER_SE_CODE_NM",
 		headerText : '<spring:message code="comf0101.gr.USER_SE_CODE_NM"/>',
 		editable : false
 	},{
 		dataField : "USER_ID",
 		headerText : '<spring:message code="comf0101.gr.USER_ID"/>',
 		editable : false
 	},{
 		dataField : "USER_NM",
 		headerText : '<spring:message code="comf0101.gr.USER_NM"/>'
 	},{
 		dataField : "TELNO",
 		headerText : '<spring:message code="comf0101.gr.TELNO"/>'
 	},{
 		dataField : "EMAIL",
 		headerText : '<spring:message code="comf0101.gr.EMAIL"/>'
 	},{
 		dataField : "LOGIN_FAILR_CO",
 		headerText : '<spring:message code="comf0101.gr.LOGIN_FAILR_CO"/>',
 		style:"login_style_01",
 		editable : false
 	},{
 		dataField : "PASSWORD_CHANGE_DE",
 		headerText : '<spring:message code="comf0101.gr.PASSWORD_CHANGE_DE"/>',
 		editable : false
 	},{
 		dataField : "ACNT_LOCK_AT",
 		headerText : '<spring:message code="comf0101.gr.ACNT_LOCK_AT"/>',
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		width: 100,
 		style:"lock_style_01",
 		editable : false
 	},{
 		dataField : "USE_YN",
 		headerText : '<spring:message code="comf0101.gr.USE_YN"/>',
 		editRenderer : {
			type : "DropDownListRenderer",
			showEditorBtnOver: true,
			list : ['Y', 'N']
		},
 		width: 100,
 		style:"use_style_01",
 		editable : false
 	},{
 		dataField : "TMP_PASSWORD",
 		headerText : '<spring:message code="comf0101.gr.TMP_PASSWORD"/>',
 		width: 126,
 		maxWidth: 126,
 		style:"tmp_style_01",
		renderer : {
             type : "ButtonRenderer",
             labelText : '<spring:message code="comf0101.gr.MAIL_SEND"/>',
             onclick : function(rowIndex, columnIndex, value, item) {
					
				var item = AUIGrid.getItemByRowIndex(grCmUser.id, rowIndex);
				
				if(confirm('<spring:message code="comf0101.msg.1"/>')) {
	         	    $.ajax({
	         		    url: "<c:url value='/com/anonymous/updateCmUserForSendTmpMail.do'/>",
	         		    type: 'post',
	         		    dataType: 'json',
	         		    data: {
	         		    	'USER_ID': item['USER_ID'],
	         		    	'USER_NM' : item['USER_NM'],
	         		    	'EMAIL' : item['EMAIL']
	         		    },
	         		    success:function(data){
	         		    	if(data.success) {
	         		    		alert('<spring:message code="comf0101.msg.2"/>');
	         		    	} else {
	         		    		alert(data.message);
	         		    	}
	         		    },
	        			error : function(jqXHR, textStatus, errorThrown){
	        				alert(textStatus);
	        			}
	         		});
				}
             }
      	}
 	}],
 	createGrid: function() {
 		var me = this;
   		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		grCmUserRole.createGrid();
 		
 		me.binding();
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
		AUIGrid.bind(me.id, 'selectionChange', function(e) {
			grCmUserRole.proxy.param['USER_ID'] = e.selectedItems[0].item['USER_ID'];
			grCmUserRole.load();
		});
		
 		AUIGrid.bind(me.id, 'cellEditBegin', function(e) {
 			if(e.item['USER_SE_CODE'] == '01') {
 				alert('<spring:message code="comf0101.msg.4"/>');
 				return false;
 			}
 		});
 	},
 	load: function(v1, v2) {
 		var me = this;
 		
 		if(me.proxy.paging && !v1 && !v2) {
 			me.proxy.param.page = me.div.paging.currentPage;		
 			me.proxy.param.count= me.div.paging.rowCount;		
 		}
 		
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
 		    	if(data.success) {
 			    	AUIGrid.removeAjaxLoader(me.id);
 			    	AUIGrid.setGridData(me.id, data.result);
 			    	AUIGrid.setSelectionByIndex(me.id, 0);
 			    	
 			    	if(data.count && me.proxy.paging) {
 			    		me.div.paging.totalRowCount = data.count;
 			    		me.createPagingNavigator(me.div.paging.currentPage);
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
	createPagingNavigator : function(goPage) {
		var me = this;
		if (!me.div.paging.pagingDiv) {
			return;
		}
		fn_createPagingNavigator(me, goPage);
	},
 	moveToPage: function(goPage, rowCount) {
 		var me = this;
 		
 		if(!me.div.paging.pagingDiv) { 
 			return;
 		}
 		
 		// 현재 페이지 보관
 		me.div.paging.currentPage = goPage;
 		
 		// selectBox에서 요청시, 1페이지부터 시작
 		if(rowCount) {
 			me.div.paging.rowCount = rowCount;
 			me.div.paging.currentPage = 1;
 			goPage = 1;
 		}
 		
 		me.load(me.div.paging.rowCount, goPage);
 	}
};

var grCmUserRole = {
	 	id: '',
	 	oriData: '',
	 	div: {
	 		gridDiv: '#grCmUserRole'
	 	},
	 	proxy: {
	 		url: "<c:url value='/com/f01/selectCmUserRoleByUserId.do'/>",
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		paging: false,
	 		autoLoad: false
	 	},
	 	gridPros: {
	 		showStateColumn: true,
			softRemoveRowMode  : true,
			softRemovePolicy   : "exceptNew",
		    enableFilter : true,
		    showRowNumColumn : true,
		    showRowCheckColumn : false,
		    enableColumnResize : true,
		    enableMovingColumn : false,
		    editable : true,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "multipleRows"
	 	},
	 	columnLayout : [{
	 		dataField : "USER_ID",
	 		headerText : '<spring:message code="comf0101.gr.USER_ID"/>',
	 		editable : false
	 	},{
	 		dataField : "USER_NM",
	 		headerText : '<spring:message code="comf0101.gr.USER_NM"/>',
	 		editable : false
	 	},{
	 		dataField : "ROLE_ID",
	 		headerText : '<spring:message code="comf0101.gr.ROLE_ID"/>',
			labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
				var me = grCmUserRole;
				var retStr = "";
				
				for(var i = 0; i < me.columnLayout[2].editRenderer.list.length; i++) {
					if(me.columnLayout[2].editRenderer.list[i]['ROLE_ID'] == value) {
						retStr = me.columnLayout[2].editRenderer.list[i]['ROLE_NM'];
						break;
					}
				}
				
				if(!retStr) {
					return AUIGrid.getItemByRowIndex(me.id, rowIndex)['ROLE_NM'];
				} else {
					return retStr;
				}
			},
			editRenderer : {
				type : "DropDownListRenderer",
				list : '',
				keyField : "ROLE_ID",
				valueField : "ROLE_NM"
			}
	 	},{
	 		dataField : "UPDATE_NM",
	 		headerText : '<spring:message code="comf0101.gr.UPDATE_NM"/>',
	 		editable : false
	 	},{
	 		dataField : "LAST_UPDDE",
	 		headerText : '<spring:message code="comf0101.gr.LAST_UPDDE"/>',
	 		formatString : "yyyy/mm/dd",
	 		dataType:"date",
	 		editable : false
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
	 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
	 			
	 			var flag = false;
	 			
	 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
	 			
	 			//uu_id 로 add 인지 아닌지 유효성 검사
	 			for(var i = 0; i < addedRowItems.length; i++) {
	 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
	 					flag = true;
	 				}
	 			}
	 			
	 			if(AUIGrid.getSelectedIndex(me.id)[1] == 3) {
	 				flag = true;
	 			}
	 			
	 			if(AUIGrid.getSelectedIndex(me.id)[1] == 2) {
		 			$.ajax({
		 			    url : "<c:url value='/com/common/selectQueryDataList.do'/>",
		 			    type: 'post',
		 			    dataType: 'json',
		 			   	data:{'QUERY': 'selectCmRoleByTaskAt'},
		 			    success:function(data){
		 			    	if(data.success) {
		 				    	me.columnLayout[2].editRenderer.list = data.result;
		 			    	} else {
		 			    		alert(data.message);
		 			    	}
		 			    },
		 				error : function(jqXHR, textStatus, errorThrown){
		 					alert(textStatus);
		 				}
		 			});
	 			}
	 			return flag;
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
	 			    	grCmUserRole.oriData = data.result;
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
		dataArr[inx++] = "<option value=" + this.CMMN_CODE + ">" + this.CMMN_CODE_NM + "</option> ";
	});

	target.append(dataArr);
}

$(function(){
	
	grCmUser.createGrid();
	
	$('#txtUserId').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtUserId').val().trim()) {
			$('#btnCmUserSearch').trigger('click');
		}
	});
	
	$('#txtUserNm').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $('#txtUserNm').val().trim()) {
			$('#btnCmUserSearch').trigger('click');
		}
	});
	
	$('#btnCmUserSearch').click(function() {
		grCmUser.proxy.param = {
			'USER_ID': $('#txtUserId').val(),
			'USER_NM': $('#txtUserNm').val(),
			'USER_SE_CODE': $('#selectUserSeCode').val()
		};
		grCmUser.load();
	});
	
	$('#btnCmUserRoleAdd').click(function() {
		var row = {
				'USER_ID': AUIGrid.getSelectedItems(grCmUser.id)[0].item['USER_ID'],
				'USER_NM': AUIGrid.getSelectedItems(grCmUser.id)[0].item['USER_NM'],
				'ROLE_ID': '',
				'USE_YN': 'Y',
				'UPDATE_ID': '${loginMap.USER_ID}',
				'UPDATE_NM': '${loginMap.USER_NM}',
				'LAST_UPDDE': new Date(),
				'CURD': 'C'
		};
		AUIGrid.addRow(grCmUserRole.id, row, 'first');
	});
	
	$('#btnCmUserRoleDelete').click(function() {
		AUIGrid.removeRow(grCmUserRole.id, "selectedIndex");
	});
	
	$('#btnCmUserRoleSave').click(function() {
		var arJson = [];
		
		var addedRowItems = AUIGrid.getAddedRowItems(grCmUserRole.id);
		var editedItems = AUIGrid.getEditedRowItems(grCmUserRole.id);
		var removeItems = AUIGrid.getRemovedItems(grCmUserRole.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			arJson.push(addedRowItems[i]);
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i]['UPDATE_ID'] = '${loginMap.USER_ID}';
			editedItems[i]['CURD'] = 'U';
			arJson.push(editedItems[i]);
		}
				
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			arJson.push(removeItems[i]);
		}
		
		for(var i = 0; i < arJson.length; i++ ) {
			if(arJson[i]['CURD'] != 'D') {
				if(!arJson[i]['USER_ID'] || !arJson[i]['ROLE_ID']) {
					alert('<spring:message code="message.validation.2"/>');
					return;
				}    
			}
		}
		
		$.ajax({
			  url : "<c:url value='/com/f01/insertCmUserRoleByUserId.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  
					  grCmUserRole.load()
					  
				  } else {
					  
					  AUIGrid.removeAjaxLoader(grCmUserRole.id);
					  alert(data.message);
					  
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
	
	$('#btnCmUserSave').click(function() {
		var arJson = [];
		
		var editedItems = AUIGrid.getEditedRowItems(grCmUser.id);

		if(!editedItems.length) {
			alert('<spring:message code="comf0101.msg.5"/>');
			return;
		}
		
		for(var i = 0; i < editedItems.length; i++) {
			
			if(!$.trim(editedItems[i]['USER_NM'])  || !$.trim(editedItems[i]['EMAIL']) 
					|| !$.trim(editedItems[i]['TELNO'])) {
				alert('<spring:message code="comf0101.msg.6"/>');
				return;
			}
			
			editedItems[i]['UPDATE_ID'] = '${loginMap.USER_ID}';
			editedItems[i]['CURD'] = 'U';
			arJson.push(editedItems[i]);
		}
		
		
		$.ajax({
			  url : "<c:url value='/com/f01/updateCmUserByUserSeCode02.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  grCmUser.load();
// 					  grCmUserRole.load()
					  
				  } else {
					  
					  AUIGrid.removeAjaxLoader(grCmUserRole.id);
					  alert(data.message);
					  
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});

	});
	
	$('.popup_01').click(function(){
		mkLayerPopupOpen("<c:url value='/com/f01/popupCOMF0102.do'/>", null);
	});
	
	$.ajax({
		url : "<c:url value='/com/common/selectQueryDataList.do'/>",
		type: 'post',
		dataType: 'json',
		data:{'QUERY': 'selectCmCmmCodeByCmmnClcode', 'CMMN_CLCODE': 'COM001'},
		success : function(data) {
			if(data.success) {
				loadCombo($("#selectUserSeCode"), data.result);
				$("#selectUserSeCode").val("");
			}
		}
	});

});

$(window).resize(function() {
	if (grCmUser && grCmUser.id) {
		AUIGrid.resize(grCmUser.id);
	}
	if (grCmUserRole && grCmUserRole.id) {
		AUIGrid.resize(grCmUserRole.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMF0101&&UPPER_MENU_ID=COMF" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMF0101&&UPPER_MENU_ID=COMF" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
	<section id="mainCon">
		<div class="mainConInner">
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
	
		<section class="conBox100 conBox">
			<div class="conBoxInner">
				
				<article class="conTitBox">
					<h5>${progrmMap.MENU_NM}</h5>
				</article>
				
				<div class="conTitBtnR">
					<spring:message code="comf0101.ip.USER_SE_CODE"/> : 
						<select id="selectUserSeCode" style="width:120px;vertical-align: top;">
							<option>===selected===</option>
						</select>
<!-- 					<input type="text" id="txtUserSeCode" name="USER_SE_CODE" style="width:90px;"/> -->
					<spring:message code="comf0101.ip.USER_NM"/> : <input type="text" id="txtUserNm" name="USER_NM" style="width:90px;"/>
					<spring:message code="comf0101.ip.USER_ID"/> : <input type="text" id="txtUserId" name="USER_ID" style="width:120px;"/>
					<input type="button" id="btnCmUserSearch" value=<spring:message code="btn.search.1"/>>
					<input type="button" class="popup_01" value=<spring:message code="btn.new"/>>
					<input type="button" id="btnCmUserSave" value=<spring:message code="btn.save"/>>
				</div>
				
				<article class="mgT16">
					<div id="grCmUser" class="gridHeiSz10 grid_wrap tb01_2"></div>
					<div id="pgCmUser" class="aui-grid-paging-panel my-grid-paging-panel"></div>
				</article>
				
			</div>
		</section>
		
		<section class="conBox100 conBox">
            
            
			<div class="conBoxInner">
				<article class="conTitBox">
					<h5><spring:message code="comf0101.title.1"/></h5>
	            </article>
	            
				<article class=" conTitBtnR">
					<input type="button" id="btnCmUserRoleAdd" value=<spring:message code="btn.rowAdd"/> class="add_01" title="<spring:message code="btn.rowAdd"/>">
					<input type="button" id="btnCmUserRoleDelete" value=<spring:message code="btn.rowDelete"/> class="del_01" title="<spring:message code="btn.rowDelete"/>">
					<input type="button" id="btnCmUserRoleSave" value=<spring:message code="btn.save"/> class="save_01" title="<spring:message code="btn.save"/>">
				</article>
				
				<article class="mgT16">
					<div id="grCmUserRole" class="gridHeiSz05 grid_wrap tb01_2"></div>
                </article>
			</div>
		</section>
		</div>
	</section>
</div>
</body>
</html>