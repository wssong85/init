<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript">
	var userId; //로그인한 유저 ID
	var taskNm;
	var DMCJ01code; //모듈구분코드
	var DMCJ02code; //공지구분코드
	var notice_sn;
	var count;
	$(document).ready(function() {

		if (count == "1") {
			NoticeRightGrid.load();
		}
		//console.log("roleCodevalue:::"+roleCodevalue);
		NoticeRightGrid.createGrid();

		$("#btnNew").click(function() {
			dmc0202Popup();
		});

		$("#btnSearch").click(function() {
			var params = {
				'TASK_NO' : $("#textSearch").val()
			};
			NoticeRightGrid.proxy.param = params;
			NoticeRightGrid.load();
		});

	});
	function gridLoad() {
		NoticeRightGrid.load();
	}
	function dmc0202Popup() {
		$.ajax({
			url : './selectCommonCodeList.do',
			type : 'post',
			dataType : 'json',
			data : {
				'CMMN_CLCODE' : 'DMCJ01'
			},//me.proxy.param,
			success : function(data) {
				if (data.success) {
					DMCJ01code = data.result;
					console.log("DMCJ01code::::" + DMCJ01code[0].NAME);
					var param = {};
					mkLayerPopupOpen("./DMCJ0202.do", param);
					AUIGrid.resize(grSend.id);
					AUIGrid.resize(grReception.id);
				} else {
					alert(data.message);

				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
	var NoticeRightGrid = {
		id : '',
		div : {
			gridDiv : '#NoticeRightGrid'
		},
		proxy : {
			url : './selectAllNoticeList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			//페이징 true, false 로 지정
			paging : false,
			//처음 시작시 데이터 로딩
			autoLoad : true
		},
		gridPros : {
			// 페이징 사용
			//  usePaging : true,
			//pageRowCount : 5,			    
			//showPageButtonCount : 5, 
			showStateColumn : true,
			showRowNumColumn : true,
			showRowCheckColumn : false,
			//rowCheckToRadio : true,
			enableColumnResize : false,
			enableMovingColumn : false,
			editable : true,
			enableFilter : true,
			//height: 265,
			// 한 화면 페이징 버턴 개수 5개로 지정
			//showPageButtonCount : 4,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "multipleRows",

			displayTreeOpen : true,

		},
		//AUI 그리드 레이아웃
		columnLayout : [
				{
					dataField : "MODULE_SE",
					headerText : "모듈",
					editable : false,
					labelFunction : function(rowIndex, columnIndex, value,
							headerText, item) {
						var me = NoticeRightGrid;
						var retStr = "";
						for (var i = 0; me.columnLayout[0].editRenderer.list.length > i; i++) {
							if (me.columnLayout[0].editRenderer.list[i]['CODE'] == value) {
								retStr = me.columnLayout[0].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
					},
					editRenderer : {
						type : "DropDownListRenderer",
						showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
						list : null,
						keyField : "CODE",
						valueField : "NAME"
					}
				},
				{
					dataField : "NOTICE_SE",
					headerText : "공지구분",
					editable : false,
					labelFunction : function(rowIndex, columnIndex, value,
							headerText, item) {
						var me = NoticeRightGrid;
						var retStr = "";
						for (var i = 0; me.columnLayout[1].editRenderer.list.length > i; i++) {
							if (me.columnLayout[1].editRenderer.list[i]['CODE'] == value) {
								retStr = me.columnLayout[1].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
					},
					editRenderer : {
						type : "DropDownListRenderer",
						showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
						list : null,
						keyField : "CODE",
						valueField : "NAME"
					}
				}, {
					dataField : "TASK_NM",
					headerText : "과제명",
					editable : false
				}, {
					dataField : "TASK_NO",
					headerText : "과제번호",
					editable : false
				}, {
					dataField : "",
					headerText : "권한",
					editable : false,
					renderer : {
						type : "ButtonRenderer",
						labelText : "설정",
						onclick : function(rowIndex, columnIndex, value, item) {
							notice_sn = item.NOTICE_SN;
							console.log("notice_sn::::" + notice_sn);
							dmc0202Popup();
						}
					}
				}, {
					dataField : "FRSTCRTR",
					headerText : "관리자",
					editable : false
				}, {
					dataField : "FRST_CREAT_DE",
					headerText : "등록일",
					dataType : "date",
					formatString : "yyyy-mm-dd",
					editable : false
				}, {
					dataField : "NOTICE_SN",
					headerText : "순번",
					editable : false
				} ],
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;

			me.id = AUIGrid
					.create(me.div.gridDiv, me.columnLayout, me.gridPros);

			me.binding();

			if (me.proxy.autoLoad) {
				me.load();

			}
		},
		//AUI 그리드 이벤트 
		binding : function() {
		},
		load : function(v1, v2) {
			var me = this;

			AUIGrid.showAjaxLoader(me.id);

			$.ajax({
				url : me.proxy.url,
				type : me.proxy.type,
				dataType : me.proxy.dataType,
				data : me.proxy.param,
				success : function(data) {
					if (data.success) {
						userId = data.USER_ID;
						me.columnLayout[0].editRenderer.list = data.module_se;
						me.columnLayout[1].editRenderer.list = data.notice_se;

						AUIGrid.removeAjaxLoader(me.id);
						AUIGrid.setGridData(me.id, data.result);
						AUIGrid.setSelectionByIndex(me.id, 0);
					} else {
						AUIGrid.removeAjaxLoader(me.id);
						alert(data.message);

					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(textStatus);
				}
			});
		}
	};

	$(window).resize(function() {
		if (NoticeRightGrid.id) {
			AUIGrid.resize(NoticeRightGrid.id);
		}
	});
</script>
<title>공지사항관리</title>
</head>
<body>
	<div id="wrap">
		<c:import
			url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0201&UPPER_MENU_ID=EDCK"
			charEncoding="utf-8" />
		<c:import
			url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0201&UPPER_MENU_ID=EDCK"
			charEncoding="utf-8" />
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



						<article class="conTitBtn">


							<div class="conTitBtnR">
								<input type="button" id="btnNew" value="신규">
							</div>

							<div class="conTitBtnL">
								과제번호 <input type="text" id="textSearch"> <input
									type="button" id="btnSearch" value="검색">
							</div>
						</article>

						<article class="mgT55">

							<div id="NoticeRightGrid" class="grid_wrap tb01_2"></div>
						</article>


					</div>
				</section>



			</div>
		</section>
	</div>
</body>
</html>