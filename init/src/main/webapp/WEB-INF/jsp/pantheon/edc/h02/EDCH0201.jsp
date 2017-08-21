<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>
<script>
	var taskSn = ${ loginMap.TASK_SN };

	var grid_labSubjectList = {
		id : '',
		div : {
			gridDiv : '#grid_wrap',
			paging : {
				pagingDiv : 'grid_paging',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		proxy : {
			url : './selectLabSubjectList.do',
			param : {
				'TASK_SN' : taskSn
			},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : true
		},
		gridPros : {
			showRowNumColumn : true,
			showRowCheckColumn : false,

			enableColumnResize : true,
			enableMovingColumn : false,

			editable : false,
			enableFilter : true,

			softRemoveRowMode : true,
			softRemovePolicy : "exceptNew",

			// 한 화면 페이징 버턴 개수 5개로 지정
			showPageButtonCount : 5,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRows",

			displayTreeOpen : false
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "INSTT_NM",
			headerText : '<spring:message code="edch0201.gr.INSTT_NM" />', //"Site",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "SUBJECT_NO",
			headerText : '<spring:message code="edch0201.gr.SUBJECT_NO" />', //"Subject",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VISIT_LBL",
			headerText : '<spring:message code="edch0201.gr.VISIT_LBL" />', //"방문",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "VISIT_STTUS",
			headerText : '<spring:message code="edch0201.gr.VISIT_STTUS" />', //"방문상태",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : '<spring:message code="edch0201.gr.CDISC_SUBMIT_VALUE" />', //"항목",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "STRE_VALUE",
			headerText : '<spring:message code="edch0201.gr.STRE_VALUE" />', //"값",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "INTRLCK_AT",
			headerText : '<spring:message code="edch0201.gr.INTRLCK_AT" />', //"업로드 상태",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "LAST_UPDDE",
			headerText : '<spring:message code="edch0201.gr.LAST_UPDDE" />', //"업로드 날짜",
			editable : false,
			filter : {
				showIcon : true
			}
		}, {
			dataField : "LAST_UPDUSR",
			headerText : '<spring:message code="edch0201.gr.LAST_UPDUSR" />', //"업로드 사용자",
			editable : false,
			filter : {
				showIcon : true
			}
		} ],

		//AUI 그리드 생성
		createGrid : function() {
			var me = this;

			me.id = AUIGrid
					.create(me.div.gridDiv, me.columnLayout, me.gridPros);

			gridMainID = me.id;

			me.binding();

			if (me.proxy.autoLoad) {
				me.load();
			}
		},

		//AUI 그리드 이벤트 
		binding : function() {
			var me = this;

			AUIGrid.bind(me.id, "cellClick", function(event) {

			});

			AUIGrid.bind(me.id, "cellEditBegin", function(event) {

			});

		},
		load : function(v1, v2) {
			var me = this;

			fn_load(me, v1, v2);
		}
	};

	$(document).ready(function() {
		$("#frm_main #TASK_SN").val(taskSn);
		grid_labSubjectList.createGrid();

		$("#btnSearch").click(function() {
			var params = {
			};
			
			params.INSTT_NM = $('#INSTT_NM').val();
			params.SUBJECT_NO = $('#SUBJECT_NO').val();
			params.TASK_SN = $('#TASK_SN').val();
			
			grid_labSubjectList.proxy.param = params;
			grid_labSubjectList.load();
		});
	});
	
	// 윈도우 리사이징 이벤트
	$(window).resize(function(){
		if (grid_labSubjectList.id) {
			AUIGrid.resize(grid_labSubjectList.id);
		}
	});
		
</script>

</head>
<body>
	<div id="wrap">
		<c:import
			url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCH0201&&UPPER_MENU_ID=EDCH"
			charEncoding="utf-8" />
		<c:import
			url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCH0201&&UPPER_MENU_ID=EDCH"
			charEncoding="utf-8" />
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${ progrmMap.MENU_NM }</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>${ progrmMap.UPPER_MENU_NM }</li>
							<li>${ progrmMap.MENU_NM }</li>
						</ul>
					</nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<article style="overflow:hidden;">
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold';"><spring:message code="edch0201.gr.INSTT_NM" /> :</span><!-- Site -->
								<input type="text" id="INSTT_NM" name="INSTT_NM" style="width: 200px;">
								<span style="font-family:'NanumGothicBold'; margin-left: 20px;"><spring:message code="edch0201.gr.SUBJECT_NO" /> :</span><!-- Subject -->
								<input type="text" id="SUBJECT_NO" name="SUBJECT_NO" style="width: 140px;">
								<button class="oneBtn" id="btnSearch" type="sumit">
									<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png' />" alt='<spring:message code="button.search" />'><!-- 검색 -->
								</button>
							</div>
						</article>
						<article class="mgT16">
							<div id="grid_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
						</article>
	                    <form id="frm_main" name="frm_main">
							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }">
						</form>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>


</html>