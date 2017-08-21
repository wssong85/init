<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<title>${progrmMap.MENU_NM}</title>
<script type="text/javascript">
var grCmRole = {
 	id: '',
 	div: {
 		gridDiv: '#grCmRole',
 		paging: {
 			pagingDiv: '',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: "<c:url value='/com/b01/selectCmRole.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: true
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
	    showStateColumn: true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows"
 	},
 	columnLayout : [{
 		dataField : "ROLE_ID",
 		headerText : '<spring:message code="comb0101.gr.ROLE_ID" /><span class="must_01"></span>',
		editRenderer : {
			type : "InputEditRenderer",
			validator : function(oldValue, newValue, rowItem) {
				var isValid = false;
				
				if(!AUIGrid.isUniqueValue(grCmRole.id, 'ROLE_ID', newValue)) {
					return { "validate" : isValid, "message"  : '<spring:message code="comb0101.msg.2" />' };	
				} 
				
				if(newValue) {
					if(newValue.substring(0, 5) == 'ROLE_'  && newValue.length > 6) {
						isValid = true;
					} else {
						isValid = false;
					}
				} else {
					isValid = false;				
				}
				
				return { "validate" : isValid, "message"  : '<spring:message code="comb0101.msg.1" />' };
			}
		},
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "ROLE_NM",
 		headerText : '<spring:message code="comb0101.gr.ROLE_NM" /><span class="must_01"></span>',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "RM",
 		headerText : '<spring:message code="comb0101.gr.RM" />',
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "FIXING_AT",
 		headerText : '<spring:message code="comb0101.gr.FIXING_AT" />',
		editRenderer : {
			type : "ComboBoxRenderer",
			showEditorBtnOver : true,
			list : ['Y', 'N']
		},
		width: 100,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "TASK_AT",
 		headerText : '<spring:message code="comb0101.gr.TASK_AT" />',
		editRenderer : {
			type : "ComboBoxRenderer",
			showEditorBtnOver : true,
			list : ['Y', 'N']
		},
		width: 100,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "USE_YN",
 		headerText : '<spring:message code="comb0101.gr.USE_YN" />',
		editRenderer : {
			type : "ComboBoxRenderer",
			showEditorBtnOver : true,
			list : ['Y', 'N']
		},
		width: 100,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "UPDATE_NM",
 		headerText : '<spring:message code="comb0101.gr.UPDATE_NM" />',
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	},{
 		dataField : "LAST_UPDDE",
 		headerText : '<spring:message code="comb0101.gr.LAST_UPDDE" />',
 		formatString : "yyyy-mm-dd",
 		dataType:"date",
 		editable : false,
 		filter : {
 			showIcon : true
 		}
 	}],
 	//AUI 그리드 생성
 	createGrid: function() {
 		var me = this;
 		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	//AUI 그리드 이벤트 
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellEditBegin', function(event) {
 			
 			var flag = false;
 			var addedRowItems = AUIGrid.getAddedRowItems(me.id);
 			
 			for(var i = 0; i < addedRowItems.length; i++) {
 				if(addedRowItems[i]._$uid == AUIGrid.getSelectedItems(me.id)[0].rowIdValue) {
 					flag = true;
 				}
 			}
 			
 			if(AUIGrid.getSelectedIndex(me.id)[1]) {
 				flag = true;
 			}
 			
 			return flag;
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
 	}
};

$(function(){
	grCmRole.createGrid();
	
	$('#btnCmRoleInit').click(function() {
		AUIGrid.destroy(grCmRole.id);
		grCmRole.createGrid();	
	});
	
	$('#btnCmRoleadd').click(function() {
		var row = {
				'ROLE_ID': '',
				'ROLE_NM': '',
				'RM': '',
				'UPDATE_NM': '${loginMap.USER_NM}',
				'LAST_UPDDE': new Date(),
				'USE_YN': 'Y'
		};
		AUIGrid.addRow(grCmRole.id, row, 'first');
	});
	
	$('#btnCmRoleDelete').click(function() {
		AUIGrid.removeRow(grCmRole.id, "selectedIndex");
	});
	
	$('#btnCmRoleSave').click(function() {
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}

		var arJson = [];
		var addedRowItems = AUIGrid.getAddedRowItems(grCmRole.id);
		var editedItems = AUIGrid.getEditedRowItems(grCmRole.id);
		var removeItems = AUIGrid.getRemovedItems(grCmRole.id);
		
		for(var i = 0; i < addedRowItems.length; i++) {
			addedRowItems[i].CURD = 'C';
			arJson.push(addedRowItems[i]);
		}

		for(var i = 0; i < editedItems.length; i++) {
			editedItems[i].CURD = 'U';
			arJson.push(editedItems[i]);
		}
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CURD = 'D';
			arJson.push(removeItems[i]);
		}
		
		if(!arJson.length) {
			alert('<spring:message code="message.null.1"/>');
			return;
		}
		
		for(var i = 0; i < arJson.length; i++ ) {
			if(!arJson[i]['ROLE_ID'] || !arJson[i]['ROLE_NM']) {
				alert('<spring:message code="message.validation.2"/>');
				return;
			}    
		}
	
		$.ajax({
			  url : "<c:url value='/com/b01/insertCmRole.do'/>",
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  if(data.success) {
					  alert('<spring:message code="message.save.2"/>');
					  grCmRole.load()
				  } else {
					  AUIGrid.removeAjaxLoader(grCmRole.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	});
});

$(window).resize(function() {
	if (grCmRole && grCmRole.id) {
		AUIGrid.resize(grCmRole.id);
	}
});

</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=COM&MENU_ID=COMB0101&UPPER_MENU_ID=COMB" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=COM&MENU_ID=COMB0101&UPPER_MENU_ID=COMB" charEncoding="utf-8"/>
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
						<h5><spring:message code="comb0101.title_1"/></h5>
					</article>
					
					<article class="conTitBtnR">
						<c:if test="${AUTH_BTN_GUBUN eq 'Y'}">
						<input type="button" id="btnCmRoleInit" value=<spring:message code="btn.init"/> class="reset_01" title="<spring:message code="btn.init"/>">
						<input type="button" id="btnCmRoleadd" value=<spring:message code="btn.rowAdd"/> class="add_01" title="<spring:message code="btn.rowAdd"/>">
						<input type="button" id="btnCmRoleDelete" value=<spring:message code="btn.rowDelete"/> class="del_01" title="<spring:message code="btn.rowDelete"/>">
						<input type="button" id="btnCmRoleSave" value=<spring:message code="btn.save"/> class="save_02" title="<spring:message code="btn.save"/>">
						</c:if>
					</article>
					
					<article class="mgT16">
						<div id="grCmRole" class="gridHeiSz15 grid_wrap tb01_2"></div>
					</article>
				</div>
			</section>
		</div>
	</section>
	<!-- 메인 끝 -->
</div>
</body>
</html>