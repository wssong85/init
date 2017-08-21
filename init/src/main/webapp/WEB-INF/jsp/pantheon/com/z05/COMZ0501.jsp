<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<title><spring:message code="comz0501.title.1" /></title>

<script type="text/javascript">
var grCmAddr = {
 	id: '',
 	div: {
 		gridDiv: '#grCmAddr',
 		paging: {
 			pagingDiv: 'pgCmAddr',
 			totalRowCount: 500,
 			rowCount: 20,
 			pageButtonCount: 5,
 			currentPage: 1,
 			totalPage: 0
 		},
 	},
 	proxy: {
 		url: "<c:url value='/com/anonymous/selectAddrApi.do'/>",
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: false	
 	},
 	gridPros: {
	    showRowNumColumn : true,
	    showRowCheckColumn : false,
	    enableColumnResize : true,
	    enableMovingColumn : false,
	    editable : false,
	    enableFilter : true,
	    headerHeight: 40,
	    rowHeight: 37,
	    selectionMode : "multipleRows",
	    displayTreeOpen : true
 	},
 	columnLayout : [{
 		dataField : "roadAddr",
 		headerText : '<spring:message code="comz0501.gr.roadAddr"/>'
 	},{
 		dataField : "zipNo",
 		headerText : '<spring:message code="comz0501.gr.zipNo"/>',
 		width: 120
 	}],
 	createGrid: function() {
 		var me = this;
   		
 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
 		
 		
		window.setTimeout(function(){
			AUIGrid.resize(me.id);
		}, 0.5);
 		
 		me.binding();
 		
 		if(me.proxy.autoLoad) {
 			me.load();
 		}
 	},
 	binding: function() {
 		var me = this;
 		
 		AUIGrid.bind(me.id, 'cellDoubleClick', function(event) {
			${callbackFunction}(AUIGrid.getSelectedItems(grCmAddr.id, 'selectedIndex')[0].item);
			$("#btnCmAddrClose").trigger('click');
		});
 	},
 	load: function() {
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
	grCmAddr.createGrid();
	
	$('#btnCmAddrSearch').click(function() {
		if(!$.trim($('#txtCmAddrKeword').val())) {
			return;
		}
		
		var params = {
			'keyword': $('#txtCmAddrKeword').val()
		};
		
		grCmAddr.proxy.param = params; 
		grCmAddr.load();
	});
	
	$('#btnCmAddrSelect').click(function() {
		${callbackFunction}(AUIGrid.getSelectedItems(grCmAddr.id, 'selectedIndex')[0].item);
		$("#btnCmAddrClose").trigger('click');
	});
	
	$('#btnCmAddrClose').click(function() {
		layerClose();
	});
	
	$('#txtCmAddrKeword').keypress(function(e,a,b,c) {
		if(e.keyCode == 13 && $.trim($('#txtCmAddrKeword').val())) {
			$('#btnCmAddrSearch').trigger('click');
		}
	});

});

$(window).on('resize', function(){
	if (grCmAddr && grCmAddr.id) {
		AUIGrid.resize(grCmAddr.id);
	}
});
</script>
</head>
<body>
<div id="wrap">
	<section class="popupWrap">
		<div class="popup wd800"> 
		
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
            
				<article class="conTitBtn">
					<article class="conTitBox">
						<h5><spring:message code="comz0501.h5.1" /></h5>
					</article>
					<article class="conTitBox">
						<input type="text" id="txtCmAddrKeword" class="btn mgL3">
						<input type="button" id="btnCmAddrSearch" class="btn mgL3" value=<spring:message code="btn.search.1" />>
					</article>							
				</article>
					
				<article class="mgT20">
					<div id="grCmAddr" class="gridHeiSz10 grid_wrap tb01_2"></div>
				</article>
				
            </section>
            
			<article class="mgT10">
				<div style="text-align:center;padding:10px;">
					<input type="button" id="btnCmAddrSelect" value=<spring:message code="btn.select" />>
					<input type="button" id="btnCmAddrClose" value=<spring:message code="btn.close" />>
				</div>
			</article>
			
		</div>
	</section>
	
</div>
</body>
</html>