<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<style>
		.grid_wrap a{color: #5570e6 !important; text-decoration:underline; font-weight: bold;}
		.grid_wrap a:hover{color: #5570e6 !important; text-decoration:underline; cursor:pointer;}
	</style>
	<script type="text/javascript">
		var gridHeader = null;
		var gridDispense = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grDispense',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grDispense'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/e01/selectDispenseList.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	//AUI 그리드 옵션
		 	gridPros: {
		 		usePaging : true,
				'selectionMode': 'singleRow',
				'editable': false,
				'showStateColumn': false,
				'showRowNumColumn' : false,
				enableFilter : true,
				fixedColumnCount : 5,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, JSON.parse(gridHeader), me.gridPros);
		 		me.binding();
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 		
		 	},
		 	binding: function() {
				var me = this;
				AUIGrid.bind(me.id, "cellDoubleClick", function(event) {
					g_rowSelect = event.rowIndex;

					if(event.dataField == "SUBJECT_CODE"){
						goDispensePage(event.value);
					}
					console.log(event);
					<c:forEach var="result" items="${list}" varStatus="status">
						if(event.dataField == "IP_CODE_${result.VISIT_LBL}".toUpperCase()){
							goSetPaging(event.item.TASK_CODE, event.item.SUBJECT_CODE, event.item["VISIT_CODE_${result.VISIT_LBL}".toUpperCase()], "${result.VISIT_LBL}", "1");
						}
						if(event.dataField == "RTUN_DT_${result.VISIT_LBL}".toUpperCase()){
							goSetPaging(event.item.TASK_CODE, event.item.SUBJECT_CODE, event.item["VISIT_CODE_${result.VISIT_LBL}".toUpperCase()], "${result.VISIT_LBL}", "1");
						}
						if(event.dataField == "RTURN_DT_${result.VISIT_LBL}".toUpperCase()){
							goSetPaging(event.item.TASK_CODE, event.item.SUBJECT_CODE, event.item["VISIT_CODE_${result.VISIT_LBL}".toUpperCase()], "${result.VISIT_LBL}", "2");
						}
					</c:forEach>
				});
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    	
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
		
		$(function(){
			createGridHeader();
			buttonActive();
			gridDispense.createGrid();
		});
		
		function createGridHeader(){
			gridHeader = "[{\"dataField\" : \"INSTT_CODE\", \"headerText\" : \"Site\", \"filter\" : {\"showIcon\" : true}}, ";
			gridHeader += "{\"dataField\" : \"SN\", \"headerText\" : \"SN\", \"visible\" : false}, ";
			gridHeader += "{\"dataField\" : \"SUBJECT_CODE\", \"headerText\" : \"Subject\", \"filter\" : {\"showIcon\" : true} }, ";
			gridHeader += "{\"dataField\" : \"TASK_CODE\", \"headerText\" : \"TASK_CODE\", \"visible\" : false}, ";
			gridHeader += "{\"dataField\" : \"\", \"headerText\" : \"무작위배정번호\", \"filter\" : {\"showIcon\" : true}}, ";
			gridHeader += "{\"dataField\" : \"DLVYMANAGE_CODE\", \"headerText\" : \"DLVYMANAGE_CODE\", \"visible\" : false}, ";
			<c:forEach var="result" items="${list}" varStatus="status">
				gridHeader += "{\"headerText\" : \"" + "${result.VISIT_LBL}".toUpperCase() + "\", \"children\" : [";
				gridHeader += "{\"dataField\" : \"IP_CODE_" + "${result.VISIT_LBL}".toUpperCase() + "\", \"headerText\" : \"IP Code\", \"filter\" : {\"showIcon\" : true}}, ";
				gridHeader += "{\"dataField\" : \"VISIT_CODE_" + "${result.VISIT_LBL}".toUpperCase() + "\", \"headerText\" : \"VISIT Code\", \"visible\" : false}, ";
				gridHeader += "{\"dataField\" : \"RTUN_DT_" + "${result.VISIT_LBL}".toUpperCase() + "\", \"headerText\" : \"불출일\", \"formatString\" : \"yyyy-mm-dd\", \"dataType\" : \"date\", \"filter\" : {\"showIcon\" : true}}, ";
				gridHeader += "{\"dataField\" : \"RTURN_DT_" + "${result.VISIT_LBL}".toUpperCase() + "\", \"headerText\" : \"반납일\", \"formatString\" : \"yyyy-mm-dd\", \"dataType\" : \"date\", \"filter\" : {\"showIcon\" : true}}, ";
				gridHeader += "{\"dataField\" : \"IP_STTUS_CODE_" + "${result.VISIT_LBL}".toUpperCase() + "\", \"headerText\" : \"상태\"}, ";
				gridHeader += "{\"dataField\" : \"RTUN_RTURN_CNFIRM_AT_" + "${result.VISIT_LBL}".toUpperCase() + "\", \"headerText\" : \"서명상태\", \"filter\" : {\"showIcon\" : true}}, ";
				gridHeader += "{\"headerText\" : \"Audit Trail\"}]}";
				<c:if test="${!status.last}">
					gridHeader += ", ";
				</c:if>
			</c:forEach>
			gridHeader += "]";
			//console.log(gridHeader);
		}
		
		function buttonActive(){
			$("#btnIpDeliDoc").click(function(){
				mkLayerPopupOpen("/iwrs/c01/popupIwrc0110.do");
			});
		}
		
		function goDispensePage(subjectNo){
			var f = document.createElement("form");
			
			if(subjectNo == null || subjectNo == undefined) subjectNo = "";
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "SUBJECT_CODE");
			obj.setAttribute("value", subjectNo);
			f.appendChild(obj);
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/iwrs/e01/IWRE0102.do");
			document.body.appendChild(f);
			f.submit();
		}
		
		function goSetPaging(task_code, subject_code, visit_code, visit_lbl, type){
			var f = document.createElement("form");
			
			if(subject_code == null || subject_code == undefined) subject_code = "";
			if(task_code == null || task_code == undefined) task_code = "";
			if(visit_code == null || visit_code == undefined) visit_code = "";
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "TASK_CODE");
			obj.setAttribute("value", task_code);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "SUBJECT_CODE");
			obj.setAttribute("value", subject_code);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "VISIT_CODE");
			obj.setAttribute("value", visit_code);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "VISIT_LBL");
			obj.setAttribute("value", visit_lbl);
			f.appendChild(obj);
			console.log(subject_code);
			if("${ROLE}" == "CRA" || "${ROLE}" == "CRM"){
				f.setAttribute("method", "post");
				f.setAttribute("action", "/iwrs/e01/IWRE0105.do");
				document.body.appendChild(f);
				f.submit();
			}else{
				if(type == "1"){
					f.setAttribute("method", "post");
					f.setAttribute("action", "/iwrs/e01/IWRE0103.do");
					document.body.appendChild(f);
					f.submit();
				}else{
					f.setAttribute("method", "post");
					f.setAttribute("action", "/iwrs/e01/IWRE0104.do");
					document.body.appendChild(f);
					f.submit();
				}
			}
		}
		
		window.onresize = function() {
			if (typeof gridDispense.id !== "undefined") {
				AUIGrid.resize(gridDispense.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRE0101&UPPER_MENU_ID=IWRE" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRE0101&UPPER_MENU_ID=IWRE" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>${progrmMap.UPPER_MENU_NM}</li>
	                        <li>${progrmMap.MENU_NM}</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="conTitBox">
<!-- 							<h5>배송현황</h5> -->
						</article>
						<article class="conTitBtnR">
							<input type="button" id="btnIpDeliDoc" value="IP수불문서" />
						</article>
						<article class="mgT16">
							<div id="grDispense" class="gridHeiSz14 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>