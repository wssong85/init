<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/com/common.do" flush="false" />

<script type="text/javascript">
var g_selRowData;
var g_user = '${loginMap.USER_ID}';
var g_TaskSn = ${loginMap.TASK_SN};	//popup에서 사용.
console.log(g_user);
//var g_SanclineSn = '68';	//popup에서 사용. List Query에 포함되어야 함.

var grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : 'grid_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		
		//데이터 연계 옵션
		proxy : {
			url : './selectResearchSubjectList.do',
			param : { 'TASK_SN' : g_TaskSn },
			type : 'post',
			dataType : 'json',
			paging : true,
			autoLoad : true,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			editable : false,
			enableFilter : true,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow"
		},
		//AUI 그리드 레이아웃
		columnLayout : [{ 
							dataField : "TASK_SN",
							headerText : "TASK_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "SANCLINE_SN",
							headerText : "SANCLINE_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "INSTT_FORM_SN",
							headerText : "INSTT_FORM_SN",
							editable : false,
							visible : false
						},{ 
							dataField : "BLIND_STTUS_CODE",
							headerText : "BLIND_STTUS_CODE",
							editable : false,
							visible : false
						},{ 
							dataField : "REQUST_NO",
							headerText : "REQUST_NO",
							editable : false,
							visible : false
						},{ 
							dataField : "INSTT_NM",
							headerText : "Site",
							editable : false,
							visible : true
						},{ 
			    			dataField : "SUBJECT_NO",
			    			headerText : "스크리닝 번호",
			    			editable : false
			    		},{ 
			    			dataField : "R_NO",
			    			headerText : "대상자번호",
			    			editable : false
			    		},{ 
			    			dataField : "IP_CODE",
			    			headerText : "IP코드",
			    			editable : false
			    		},{ 
			    			dataField : "MEDICINE_NM",
			    			headerText : "임상시험용의약품",
			    			editable : false
			    		},{
			    			dataField : "BLIND_STTUS_NM",
			    			headerText : "눈가림",
			    			editable : false
			    		},{
			    			dataField : "RELIS_RESN",
			    			headerText : "사유",
			    			editable : false
			    		} ],
		
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;
			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			
			me.binding();
			
			if (me.proxy.autoLoad) {
				me.load();
			}
		},
	 	//AUI 그리드 이벤트 
	 	binding: function() {
	 		var me = this;
	 		
	 		AUIGrid.bind(me.id, 'cellClick', function(event) {
	 			g_selRowData = event.item;	//선택한 row data
	 			console.log(g_selRowData);
	 		});
	 	},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;

			fn_load(me, v1, v2);
		}
	};

	$(document).ready(function() {
		$("#frm_main #TASK_SN").val(g_TaskSn);
		
		grid.createGrid();
		
		$("#btnSearch").click(function(){		//검색
			var params = {};
		
			params.INSTT_NM = $('#INSTT_NM').val();
			params.SUBJECT_NO = $('#SUBJECT_NO').val();
			params.TASK_SN = $('#frm_main #TASK_SN').val();
			
			grid.proxy.param = params;
			grid.load();
		});
		
		$("#btnReqBlndRelis").click(function(){		//눈가림 해제 요청
			if(g_selRowData == null){
				alert("데이터를 먼저 선택해 주세요.");
				return false;
			}
			console.log(g_selRowData);
			var sttBlnd = g_selRowData.BLIND_STTUS_CODE;
			
			if(sttBlnd == "01"){		//유지 상태인 경우 해제요청
				var param = new Object();
				mkLayerPopupOpen("/edc/i01/popupEDCI0103.do", param);
// 				fn_newForm();
// 			}else if(sttBlnd == "02"){	//요청 상태인 경우 요청한 내용을 보여 줌.
// 				var param = {};
// 				mkLayerPopupOpen("/edc/i01/popupEDCI0103.do", param);
// 				fn_viewForm();
			}else{
				alert("눈가림 상태가 '유지'인 건만 눈가림 해제 요청을 할 수 있습니다.");
			}
		});
		
		$("#btnImmeBlndRelis").click(function(){		//즉시 해제
			if(g_selRowData == null){
				alert("데이터를 먼저 선택해 주세요.");
				return false;
			}
			console.log(g_selRowData);
			var sttBlnd = g_selRowData.BLIND_STTUS_CODE;
			
			if(sttBlnd == "01"){		//유지 상태인 경우 즉시해제요청
				var param = new Object();
				mkLayerPopupOpen("/edc/i01/popupEDCI0106.do", param);
				fn_newForm();
// 			}else if(sttBlnd == "02"){	//요청 상태인 경우 요청한 내용을 보여 줌.
// 				var param = {};
// 				mkLayerPopupOpen("/edc/i01/popupEDCI0106.do", param);
// 				fn_viewForm();
			}else{
				alert("눈가림 상태가 '유지'인 건만 즉시해제 요청을 할 수 있습니다.");
			}
			
		});
		
		$("#btnInputCnfrmNo").click(function(){			//승인번호 입력
			if(g_selRowData == null){
				alert("데이터를 먼저 선택해 주세요.");
				return false;
			}
			console.log(g_selRowData);
			var sttBlnd = g_selRowData.BLIND_STTUS_CODE;
			
			if(sttBlnd == "03"){		//승인 상태인 경우 승인번호 ㅇㅣㅂ력
				var param = new Object();
				mkLayerPopupOpen("/edc/i01/popupEDCI0105.do", param);
				fn_newForm();
// 			}else if(sttBlnd == "02"){	//요청 상태인 경우 요청한 내용을 보여 줌.
// 				var param = {};
// 				mkLayerPopupOpen("/edc/i01/popupEDCI0105.do", param);
// 				fn_viewForm();
			}else{
				alert("눈가림 상태가 '승인'인 건만 승인번호입력을 할 수 있습니다.");
			}
			
		})
		
	});
	
	function getGridData(){
		var paramData = new Object();
		paramData.subjectNo = $("#subjectNo").val();
		paramData.name = $("#name").val();
		
		grid.proxy.param = paramData;
		grid.load();
	}
	
	// 윈도우 리사이징 이벤트
	$(window).resize(function(){
		if (grid.id) {
			AUIGrid.resize(grid.id);
		}
	});

</script>
</head>
<body>

<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCI0101&&UPPER_MENU_ID=EDCI" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCI0101&&UPPER_MENU_ID=EDCI" charEncoding="utf-8"/>
	<section id="mainCon">
		<div class="mainConInner">
 			<!-- Navigation -->
			<article class="mainTitBox">
				<h3>${progrmMap.MENU_NM }</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="<c:url value='/images/pantheon/common/patheonNavIco.png' />" alt=""> Home</li>
						<li>${ progrmMap.UPPER_MENU_NM }</li>
						<li>${ progrmMap.MENU_NM }</li>
					</ul>
				</nav>
			</article>
            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">
                	<article style="overflow:hidden;">
                		<div class="conTitBtnL">
							<span style="font-family:'NanumGothicBold';"><spring:message code="edcg01.lbl.INSTT_NM" /> :</span><!-- Site -->
							<input type="text" id="INSTT_NM" name="INSTT_NM" style="width: 200px;">
							<span style="font-family:'NanumGothicBold'; margin-left: 20px;"><spring:message code="edcg01.lbl.SUBJECT_NO" /> :</span><!-- Subject -->
							<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" style="width: 140px;">
							<button class="oneBtn" id="btnSearch" type="sumit">
								<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png' />" alt='<spring:message code="button.search" />'><!-- 검색 -->
							</button>
                		</div>
	                    <div class="conTitBtnR">
							<input id="btnReqBlndRelis" type="button" value="눈가림해제 요청" >
							<input id="btnImmeBlndRelis" type="button" value="즉시 해제" >
							<input id="btnInputCnfrmNo" type="button" value="승인번호입력" >
	                    </div>
                	</article>
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="grid_wrap tb01_2"></div>
                    </article>
                    <form id="frm_main" name="frm_main">
						<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
					</form>
                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
        </form>
    	</div>
	</section>
</div>
</body>
</html>