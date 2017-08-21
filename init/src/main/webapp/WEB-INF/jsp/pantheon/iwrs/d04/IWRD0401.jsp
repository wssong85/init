<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	
	<script type="text/javascript">
		var grFactoryInven = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: 'grFactoryInven',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grFactoryInven',
		 		paging: {
		 			pagingDiv: 'pgFactoryInven',
		 			totalRowCount: 500,
		 			rowCount: 20,
		 			pageButtonCount: 5,
		 			currentPage: 1,
		 			totalPage: 0
		 		},
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/d04/selectFactoryInventoryInfo.do',
		 		param: {IP_TYPE : $("#sltIpType option:selected").val(), IP_STTUS_CODE : $("#sltIpStatus option:selected").val() },
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
				'showRowCheckColumn' : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "IP_TYPE",
								headerText : "IP Type"
							}, {
								dataField : "IP_CODE",
								headerText : "IP Code"
							}, {
								dataField : "IP_STTUS_NM",
								headerText : "상태"
							}, {
								dataField : "IP_STTUS_CODE",
								headerText : "상태",
								visible : false
							}, {
								dataField : "INSTT_NM",
								headerText : "Site"
							}, {
								dataField : "DLVY_RQESTDE",
								headerText : "배송일"
							}, {
								dataField : "IP_ERROR_CODE",
								headerText : "유형"
							}, {
								dataField : "IP_STTUS_ETC",
								headerText : "기타"
							}, {
								dataField : "CREAT_CODE",
								headerText : "CREAT_CODE",
								visible : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 		
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 				 		
		 		me.proxy.param.IP_TYPE = $("#sltIpType option:selected").val();
		 		me.proxy.param.IP_STTUS_CODE = $("#sltIpStatus option:selected").val();
		 				 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,
		 		    success:function(data){
		 		    	if(data.result == "ok") {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.list);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 			    	$("#spanSearchCount").text(data.count);
		 			    	$("#spanTotalCount").text(data.totalcount);
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
			buttonActive();
			pageSetting();
			selectActive();
			grFactoryInven.createGrid();
		});
		
		function buttonActive(){
			$("#btnEditStatus").click(function(){
				// 그리드 데이터에서 isActive 필드의 값이 Active 인 행 아이템 모두 반환
				var activeItems = AUIGrid.getCheckedRowItems(grFactoryInven.id);
				
				if(activeItems.length == 0){
					alert("체크한 항목이 없습니다.");
					return;
				}
				var ip_code = [];
				var ip_type = [];
				var create_code = "";
				for(var i = 0; i < activeItems.length; i++) {
					ip_code.push( activeItems[i].item.IP_CODE ); // 아이디만 따로 보관해서 alert 출력
					ip_type.push( activeItems[i].item.IP_TYPE ); // 아이디만 따로 보관해서 alert 출력
					if(activeItems[i].item.IP_STTUS_CODE != "01"){
						alert("재고만 상태가 변경 가능합니다.");
						return;
					}
				}
				var strIpCode = ip_code.join(",");
				var strIpType = ip_type.join(",");
				create_code =  activeItems[0].item.CREAT_CODE;
				
				var param = {
						ip_code : strIpCode,
						ip_type : strIpType,
						create_code : create_code
					};
				mkLayerPopupOpen("/iwrs/d04/popupIwrd0402.do", param);
			});
		}
		
		function pageSetting(){
			<c:forEach var="result" items="${iptype}" varStatus="status">
				$("#sltIpType").append("<option value='<c:out value="${result.IP_TYPE}"/>'>" + '<c:out value="${result.IP_TYPE}"/>' + "</option>");
			</c:forEach>
			<c:forEach var="result" items="${ipstatus}" varStatus="status">
				$("#sltIpStatus").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
			</c:forEach>
		}
		
		function selectActive(){
			$("#sltIpType").change(function(){
				grFactoryInven.load();
			});
			
			$("#sltIpStatus").change(function(){
				grFactoryInven.load();
			});
		}
		
		window.onresize = function() {
			if (typeof grFactoryInven.id !== "undefined") {
				AUIGrid.resize(grFactoryInven.id);
			}
		};
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRD0401&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRD0401&UPPER_MENU_ID=IWRD" charEncoding="utf-8"/>
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
							<span style="font-family:'NanumGothicBold';">IP Type :</span>
							<select id="sltIpType" class="pdR100 mgR50">
								<option value="">전체</option>
							</select>
							<span style="font-family:'NanumGothicBold';">IP 상태 :</span>
							<select id="sltIpStatus" class="pdR100">
								<option value="">전체</option>
							</select>
						</article>
						<article class="conTitBtnR">
							<span style="font-family:'NanumGothicBold';">검색수량 :</span>
							<span id="spanSearchCount" style="font-family:'NanumGothicBold';"></span>
							<span style="font-family:'NanumGothicBold';">, 총수량 :</span>
							<span id="spanTotalCount" style="font-family:'NanumGothicBold';"></span>
							<input type="button" id="btnEditStatus" value="IP상태등록" class="mgL100" />
						</article>
						<article class="mgT15">
							<div id="grFactoryInven" class="gridHeiSz15 grid_wrap tb01_2"></div>
							<div id="pgFactoryInven" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>