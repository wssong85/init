<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<script type="text/javascript">
		var gridTask = {
		 	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(gridDelivery.id);
		 	id: '',
		 	//AUI그리드 생성할 div 및 페이징 옵션
		 	div: {
		 		gridDiv: '#grTask'
		 	},
		 	//데이터 연계 옵션
		 	proxy: {
		 		url: '/iwrs/g01/selectTaskList.do',
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
				'showRowNumColumn' : true,
				reverseRowNum : true,
				enableFilter : true,
			    headerHeight: 40,
			    rowHeight: 37
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
								dataField : "TASK_NO",
								headerText : "과제번호",
						 		filter : {
						 			showIcon : true
						 		},
								renderer : { // HTML 템플릿 렌더러 사용
									type : "TemplateRenderer"
								},
								// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
								labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
									var template = "<a href='#' onclick='javascript:goIwrsDesignList(\"" + item.TASK_SN + "\", \"" + item.TASK_NM + "\");return false;'>" + value + "</a>";
									
									return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
								}
							}, {
								dataField : "TASK_NM",
								headerText : "과제명",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "IWRS_VER",
								headerText : "IWRS Ver.",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "APPLC_DE",
								headerText : "적용일",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "PROGRS_CODE",
								headerText : "상태",
						 		filter : {
						 			showIcon : true
						 		}
							}, {
								dataField : "TASK_SN",
						 		visible : false
							}
						],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		//이후 객체.id 로 AUIGrid 컨트롤
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		window.setTimeout(function(){
		 			AUIGrid.resize(me.id);
		 		}, 0.5);
		 				 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 		}
		 	},
		 	//AUI 그리드 데이터 요청
		 	load: function(v1, v2) {
		 		var me = this;
		 		
		 		me.proxy.param = {
	 				TASK_NO : $("#txtTaskNo").val(), 
	 				TASK_NM : $("#txtTaskNm").val()
		 		};
		 	
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
		 		    	$(".aui-grid-template-renderer-wrapper").removeAttr("style");
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						AUIGrid.removeAjaxLoader(me.id);
						alert(textStatus);
					}
		 		});
		 	}
		};
		
		$(function(){
			gridTask.createGrid();
			
			$("#btnSearch").click(function(){
				gridTask.load();
			});
			
			$("#btnTest").click(function(){
				var ratios = {
					ratio : {
						ratio : $("#txtRatio1").val(),
						armcode : $("#txtArmCode1").val()
					},
					ratio : {
						ratio : $("#txtRatio2").val(),
						armcode : $("#txtArmCode2").val()
					},
					ratio : {
						ratio : $("#txtRatio3").val(),
						armcode : $("#txtArmCode3").val()
					},
					ratio : {
						ratio : $("#txtRatio4").val(),
						armcode : $("#txtArmCode4").val()
					}
				};
				
				var blocks = {
					block : {
						size : $("#txtBlockSize1").val(),
						count : $("#txtBlockCount1").val()
					},
					block : {
						size : $("#txtBlockSize2").val(),
						count : $("#txtBlockCount2").val()
					},
					block : {
						size : $("#txtBlockSize3").val(),
						count : $("#txtBlockCount3").val()
					},
					block : {
						size : $("#txtBlockSize4").val(),
						count : $("#txtBlockCount4").val()
					}
				};
				
				var param = {
					ratios : ratios,
					blocks : blocks
				}
				
				$.ajax({
					type : "POST",
					async : false,
					data : {data : JSON.stringify(param) },
					url : "/iwrs/g01/test.do",
					success :function(data){
						
					}
				});
			});
		});
		
		function goIwrsDesignList(taskSn, taskNm){
			var f = document.createElement("form");
			
			if(taskSn == null || taskSn == undefined) taskSn = "";
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "TASK_SN");
			obj.setAttribute("value", taskSn);
			f.appendChild(obj);
			
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", "TASK_NM");
			obj.setAttribute("value", taskNm);
			f.appendChild(obj);
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/iwrs/g01/IWRG0102.do");
			document.body.appendChild(f);
			f.submit();
		}
		
		$(window).resize(function(){
			if (gridTask.id) {
				AUIGrid.resize(gridTask.id);
			}
		});

	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=IWRG0101&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=IWRG0101&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
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
					<div class="conBoxInner" style="min-height:900px;">
						<article class="conTitBox">
	                        <h5>과제목록</h5>
	                    </article>
								
						<div class="conTitBtnR">									
							<span style="font-family:'NanumGothicBold';">과제번호 </span>
							<input type="text" id="txtTaskNo" name="" style="width: 150px;">
							<span style="font-family:'NanumGothicBold'; margin-left: 20px;">과제명 </span>
							<input type="text" id="txtTaskNm" name="" style="width: 150px;">
							<button id="btnSearch" type="button" class="oneBtn" popup_type="ProductSearch">
								<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
							</button>
						</div>
<!-- 						<article class="conTitBox"> -->
<!--  							<h5>배송현황</h5> -->
<!-- 							<label>과제번호</label> -->
<!-- 							<input type="text" id="txtTaskNo" /> -->
<!-- 							<label class="mgL30">과제명</label> -->
<!-- 							<input type="text" id="txtTaskNm" /> -->
<!-- 						</article> -->
<!-- 						<article class="conTitBtnR"> -->
<!-- 							<input type="button" id="btnSearch" value="검색" /> -->
<!-- 						</article> -->
						<article class="mgT16">
							<div id="grTask" class="gridHeiSz15 grid_wrap tb01_2"></div>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>