<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/com/common.do" flush="false" />
<script src="<c:url value="/js/pantheon/edc/edc.js" />"></script>

<title>EDC Designer</title>



<style>
table.tb004 { width: 100%; border-top: 1px solid #7287e4; margin-bottom: 5px; }
table.tb004 th { color: #333; border-right: 1px solid #e6e6e6; border-left: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6; font-family: 'NanumGothicBold'; background: #f6f7ff; height: 28px; font-size: 12px; line-height: 15px; padding: 3px 4px 3px 4px; text-align: center; vertical-align: middle; Letter-spacing: 0px; box-sizing: border-box;}
table.tb004 td { font-family: 'NanumGothic'; border-right: 1px solid #e6e6e6; border-left: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6; color: #555; background: #FFFFFF; height: 36px; padding: 4px 4px 4px 4px; vertical-align: middle; font-size: 12px; Letter-spacing: 0px; box-sizing: border-box; }
table.tb004 tr:last-child { border-bottom: 1px solid #e6e6e6; }
table.tb004 tr:last-child td { border-bottom: 0px; }

table.tb004_no_border,
table.tb004_no_border tr,
table.tb004_no_border th,
table.tb004_no_border td { border: none !important; }
</style>



<script type="text/javascript">
	$(document).ready(function() {
		if ($("#frm_main #TASK_SN").val() == "") {
			alert("과제선택필요");
			location.replace("./EDCK0201.do");
		} else {
			if ($("#frm_main #EDC_VER").val() == "") {
				alert("버전선택필요");
				fn_moveTab('EDCK0202');
			} else {
				EDCC0106_grid.createGrid();

				Con_Resize();
				//내용부분 카테고리 닫기
				$(".con_category_close").click(function() {
					$(".con_category_close").hide();
					$(".con_category_open").show();
					$(".depth_01").addClass("hidden");
					$(".con_category_01").addClass("con_category_01_reduce");
					$(".con_category_01 .depth_02").addClass("depth_02_move");
					$(".dumi_01").addClass("dumi_01_move");
					$(".contents_01_in").addClass("contents_01_move");
					
			        if($('.grid_wrap') && $('.grid_wrap').length) {
				    	for(var i = 0; i < $('.grid_wrap').length; i++) {
			            	try {
								fn_lnbResize($('.grid_wrap')[i].id);
			            	} catch(e) {
			            	}
				    	}
			        }

				});

				$(".con_category_open").click(function() {
					$(".con_category_open").hide();
					$(".con_category_close").show();
					$(".depth_01").removeClass("hidden");
					$(".con_category_01").removeClass("con_category_01_reduce");
					$(".con_category_01 .depth_02").removeClass("depth_02_move");
					$(".dumi_01").removeClass("dumi_01_move");
					$(".contents_01_in").removeClass("contents_01_move");
					
			        if($('.grid_wrap') && $('.grid_wrap').length) {
				    	for(var i = 0; i < $('.grid_wrap').length; i++) {
			            	try {
								fn_lnbResize($('.grid_wrap')[i].id);
			            	} catch(e) {
			            	}
				    	}
			        }

				});

				var instt_form_sn = $("#frm_main #INSTT_FORM_SN").val();
				var subject_no = $("#frm_main #SUBJECT_NO").val();

				$(".depth_01 > dd > a").click(function() {
					$(this).addClass("open").next("dl").slideDown("fast");

					//나머지 닫힘
					$(".depth_01 > dd > a").not(this).removeClass("open").next("dl").slideUp("fast");
					$(".depth_02 > dd > a").not(this).removeClass("open").next("dl").slideUp("fast");
				});

				$(".depth_01 > dd > a").each(function(index, entry) {
					var no = $(this).find("span").text();
					if (subject_no == no) {
						$(this).find("span").eq(0).trigger("click");
					}
				});
			}
		}
	});

	//화면 로드, 리사이즈, 스크롤
	$(window).load(function() {
		Con_Resize();
	});

	$(window).resize(function() {
		Con_Resize();
	});

	$(window).scroll(function() {
		Con_Resize();
	});

	$(function() {
		category_View(1, 2, 2); //3뎁스 고정메뉴
	});

	//내용부분 3뎁스
	function category_View(d1, d2, d3) {
		var dep1 = d1 - 1;
		var dep2 = d2 - 1;
		var dep3 = d3 - 1;

		$(".depth_01 > dd > a").eq(dep1).addClass("open").next().slideDown("fast"); //첫번째 내용 보이기
		$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().addClass("open").slideDown("fast"); //두번째 내용 보이기
		$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".link_01").removeClass("on"); //세번째 default text
		$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".link_01").eq(dep3).addClass("on"); //세번째 text 표시
		$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".popup_01").removeClass("on"); //세번째 default 팝업 아이콘
		$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".popup_01").eq(dep3).addClass("on"); //세번째 팝업 아이콘 표시

	}

	//내용부분 크기 조정
	function Con_Resize() {
		var con_boxd = $('.contents_01_in').height();
		$('.con_category_01').css({
			"height" : con_boxd + 17 + "px"
		});
		$('.conBox_01').css({
			"height" : con_boxd + 22 + "px"
		});
		$('.depth_01').css({
			"height" : con_boxd - 29 + "px"
		});
		$('.depth_02').css({
			"height" : con_boxd + 20 + "px"
		});
		$('.dumi_01').css({
			"height" : con_boxd + 20 + "px"
		});
		$('.contents_01').css({
			"top" : -con_boxd - 19 + "px"
		});
		$('.lnb').addClass('lnb_relative');

	}

	var EDCC0106_grid = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grid.id);
		id : '',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#EDCC0106_grid',
			paging : {
				pagingDiv : '',
				totalRowCount : 500,
				rowCount : 10,
				pageButtonCount : 4,
				currentPage : 1,
				totalPage : 0,
			},
		},
		//데이터 연계 옵션
		proxy : {
			url : './selectCRFLayoutList.do',
			param : {},
			type : 'post',
			dataType : 'json',
			paging : false,
			autoLoad : false,
		},
		//AUI 그리드 옵션
		gridPros : {
			showRowNumColumn : false,
			showRowCheckColumn : false,
			enableColumnResize : false,
			enableMovingColumn : false,
			showStateColumn : true,
			editable : false,
			enableFilter : false,
			softRemoveRowMode : false,
			headerHeight : 40,
			rowHeight : 37,
			selectionMode : "singleRow",
			rowIdField : "SET_VRIABL_SN"
		},
		columnLayout : [ {
			dataField : "VRIABL_NM",
			headerText : "VRIABL_NM"
		}, {
			dataField : "SET_ORDR",
			headerText : "SET_ORDR"
		}, {
			dataField : "SET_ROW_ORDR",
			headerText : "SET_ROW_ORDR"
		}, {
			dataField : "SET_VRIABL_ORDR",
			headerText : "SET_VRIABL_ORDR"
		}, {
			dataField : "VISIT_GROUP_SN",
			headerText : "VISIT_GROUP_SN"
		}, {
			dataField : "SET_SN",
			headerText : "SET_SN"
		}, {
			dataField : "SET_ROW_SN",
			headerText : "SET_ROW_SN"
		}, {
			dataField : "SET_VRIABL_SN",
			headerText : "SET_VRIABL_SN"
		}, {
			dataField : "GROUP_SN",
			headerText : "GROUP_SN"
		}, {
			dataField : "VRIABL_SN",
			headerText : "VRIABL_SN"
		}, {
			dataField : "DOMN_VRIABL_SN",
			headerText : "DOMN_VRIABL_SN"
		}, {
			dataField : "SET_TY_CODE",
			headerText : "SET_TY_CODE"
		}, {
			dataField : "VRIABL_SE_CODE",
			headerText : "VRIABL_SE_CODE"
		}, {
			dataField : "CRF_LBL_ONE",
			headerText : "CRF_LBL_ONE"
		}, {
			dataField : "CRF_LBL_TWO",
			headerText : "CRF_LBL_TWO"
		}, {
			dataField : "DC_CN",
			headerText : "DC_CN"
		}, {
			dataField : "DC_FONT_CODE",
			headerText : "DC_FONT_CODE"
		}, {
			dataField : "DC_FONT_MG",
			headerText : "DC_FONT_MG"
		}, {
			dataField : "DC_LINK_CODE",
			headerText : "DC_LINK_CODE"
		}, {
			dataField : "DC_FONT_COLLR",
			headerText : "DC_FONT_COLLR"
		}, {
			dataField : "CL_CODE_SN",
			headerText : "CL_CODE_SN"
		}, {
			dataField : "CDISC_SUBMIT_VALUE",
			headerText : "CDISC_SUBMIT_VALUE"
		}, {
			dataField : "CRUD",
			headerText : "CRUD"
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
		binding : function() {
			var me = this;
		},
		//AUI 그리드 데이터 요청
		load : function(v1, v2) {
			var me = this;
			fn_load(me, v1, v2);
		}
	};

	function getCRFVisitList(instt_form_sn, subject_no, subject_count) {
		var param = new Object();
		param.INSTT_FORM_SN = instt_form_sn;
		param.SUBJECT_NO = subject_no;
		$.ajax({
			url : './selectCRFVisitList.do',
			data : param,
			async : false,
			success : function(data, textStatus, jqXHR) {
				if (data.success) {
					AUIGrid.setGridData(EDCC0106_grid.id, []);
					var str = "";
					str += '<dt>';
					str += '<span>' + subject_no + ' - </span>';
					str += '</dt>';
					$(data.result).each(function(index, entry) {
						str += '<dd>';
						str += '<a href="#void"><span>' + entry.VISIT_LBL + '</span></a>';
						$(entry.GROUP_LIST).each(function(index2, entry2) {
							str += '<dl class="depth_03">';
							str += '<dd>';
							str += '<a href="javascript:getCRFPage(' + entry2.VISIT_GROUP_SN + ',' + subject_count + ',' + (index + 1) + ',' + (index2 + 1) + ');" class="link_01">';
							str += '<span>' + entry2.GROUP_LBL + '</span></a>';
							str += '<a href="javascript:popupCRFView("' + entry2.VISIT_GROUP_SN + '");" class="popup_01"><span>popup</span></a>';
							str += '<div class="mark_01">';
							str += '<span class="small_icon_08" title="SDV 완료"></span>';
							str += '</div>';
							str += '</dd>';
							str += '</dl>';
						});
						str += '</dd>';
					});
					$("#depth2_" + subject_no).html(str);

					$(".depth_02 > dd > a").click(function() {
						if ($(this).next("dl").hasClass("depth_03")) {
							$(this).toggleClass("open").parent().find(".depth_03").slideToggle("fast");
						} else {
							$(this).removeClass("open");
						}
						//나머지 닫힘
						//$(".depth_02 > dd > a").not(this).removeClass("open").parent().find(".depth_03").slideUp("fast");

					});

					category_View(subject_count, 1, 1);
					$(".depth_01 > dd > a").eq(subject_count - 1).next().children("dd").eq(0).children().next().children("dd").find("a").eq(0).find("span").eq(0).trigger("click");
				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
	function getCRFPage(visit_group_sn, subject_count, visit_count, group_count) {
		$("#crf_layout").empty();
		console.log(visit_group_sn + "/" + subject_count + "/" + visit_count + "/" + group_count);
		category_View(subject_count, visit_count, group_count);
		var param = new Object();
		param.VISIT_GROUP_SN = visit_group_sn;
		EDCC0106_grid.proxy.param = param;
		EDCC0106_grid.load();
		fn_makeLayoutObject(EDCC0106_grid);
		/* $.ajax({
			url : './getCRFPage.do',
			data : param,
			async : false,
			success : function(data, textStatus, jqXHR) {
				if (data.success) {

					category_View(subject_count, visit_count, group_count);

				} else {
					alert(data.message);
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert(textStatus);
			}
		}); */
	}
	function popupCRFView(visit_group_sn) {

	}
	function makeLayout(sArr) {
		var cnt = 1;
		$(sArr).each(function(index, entry) {
			if (entry.SET_TY_CODE == "01") {
				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				$(entry.row).each(function(index2, entry2) {
					var item = entry2.vriabl;
					var item_count = item.length;
					var td_width = 500;
					if (item_count > 1) {
						td_width = 300;
					}
					var label = item[0].CRF_LBL_ONE;
					str += "<table class='tb002' style='width: 800px;'>";
					str += "<tr name='" + entry2.SET_ROW_SN + "' id='set_row_sn'>";
					str += "<th style='width: 100px;'>" + label + "</th>";
					str += "<td style='width: " + td_width + "px;'>";
					str += fn_makeInputType(item[0], index2);
					str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + item[0].SET_VRIABL_SN + "' />";
					if (item_count > 1) {
						str += "</td><td style='width: 200px;'>";
						str += "<label>" + item[1].CDISC_SUBMIT_VALUE + "</label>";
						str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + item[1].SET_VRIABL_SN + "' />";
					}
				});
				str += "</td>";
				str += "<td style='width: 200px;'>";
				str += "<button type=\"button\" onclick=\"deleteSet('" + entry.SET_SN + "');\" able>삭제</button>";
				str += "</td></tr></tbody></table></div>";
				$("#crf_layout").append(str);
			} else if (entry.SET_TY_CODE == "02") {
				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				var item_count = entry.row[0].vriabl.length;
				var width = 200;
				str += "<table class='tb002' style='width: " + (width * item_count + width) + "px;'>";
				$(entry.row).each(function(index2, entry2) {
					if (index2 == 0) {
						str += "<thead><tr>";
						$(entry2.vriabl).each(function(index3, entry3) {
							var label = entry3.CRF_LBL_ONE;
							str += "<th style='width: " + width + "px;'>" + label + "</th>";
						});
						str += "<td style='width: 200px;'><button type=\"button\" onclick=\"addTr('" + entry.SET_SN + "');\" able>행추가</button>"
						str += " <button type=\"button\" onclick=\"popupTable('" + entry.SET_SN + "');\" able>설정</button></td></tr></thead><tbody>";
					}
					str += "<tr name='" + entry2.SET_ROW_SN + "' id='set_row_sn'>";
					$(entry2.vriabl).each(function(index3, entry3) {
						str += "<td onclick=\"popupChangeVariable(this);\">";
						str += fn_makeInputType(entry3, index2);
						str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + entry3.SET_VRIABL_SN + "' />";
						str += "</td>";
					});
					str += "<td><button type=\"button\" onclick=\"deleteRow('" + entry.SET_SN + "', '" + entry2.SET_ROW_SN + "');\" able>삭제</button>";
					str += "</td></tr>";
				});
				str += "</tbody></table></div>";
				$("#crf_layout").append(str);
			} else if (entry.SET_TY_CODE == "03") {
				var item = entry.row[0].vriabl[0];
				var dc = "";
				var style = null;
				if (item.DC_CN != null && item.DC_CN != "") {
					dc = item.DC_CN;
					style = "style='font-family : " + item.DC_FONT_CODE + "; color : " + item.DC_FONT_COLLR + "; ";
					style += "font-size : " + item.DC_FONT_MG + "px; line-height : " + (Number(item.DC_FONT_MG) + 10) + "px;'";
				}

				var str = "<div id='div_set" + entry.SET_SN + "' name='div_set'>";
				str += "<input type='hidden' id='set_sn' name='set_sn' value='" + entry.SET_SN + "' />";
				str += "<table class='tb002 tb003' style='width: 800px;'>";
				str += "<tr name='" + entry.row[0].SET_ROW_SN + "' id='set_row_sn'>";
				str += "<td style='width: 600px;'>";
				if (style != null) {
					str += "<span " + style + ">";
				} else {
					str += "<span>";
				}
				str += dc;
				str += "</span>";
				str += "<input type='hidden' id='set_vriabl_sn' name='set_vriabl_sn' value='" + item.SET_VRIABL_SN + "' />";
				str += "</td><td style='width: 200px;'>";
				str += "</td></tr></table></div>";
				$("#crf_layout").append(str);
			} else if (entry.SET_TY_CODE == "04") {

			}
			cnt++;
		});
		//editMode(page_edit);
	}
	
	
window.onresize = function() {
	if (EDCC0106_grid.id) {
		AUIGrid.resize(EDCC0106_grid.id);
	}
}

</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>EDC Designer</h3>
					<nav id="pathNav">
						<ul>
							<li>
								<img src="/images/pantheon/common/pathNavIco.png" alt="">Home
							</li>
							<li>과제관리</li>
							<li>EDC Designer</li>
						</ul>
					</nav>
				</article>


				<section class="conBox_01">
					<nav>
						<div class="con_category_01">
							<a href="#void" class="con_category_close"><span>SUBJECT NO</span></a> <a href="#void" class="con_category_open"></a>

							<dl class="depth_01">
								<c:forEach var="result" items="${SubjectMenuList}" varStatus="status">
									<dd>
										<a href="javascript:getCRFVisitList('${result.INSTT_FORM_SN}','${result.SUBJECT_NO}','${ status.count }')"><span>${result.SUBJECT_NO}</span></a>
										<dl class="depth_02" id="depth2_${result.SUBJECT_NO}">
										</dl>
									</dd>
								</c:forEach>
							</dl>
							<div class="dumi_01"></div>

						</div>

					</nav>

					<section class="contents_01">
						<div class="contents_01_in">
							<!-- <article id="crf_layout"></article> -->
							<div id="EDCC0106_grid" class="gridHeiSz05 grid_wrap tb01_2 " style=""></div>
							
							
							
							
<article>

	<div id="" name="">
		<input type="hidden" id="set_sn" name="set_sn" value="5">
		<table class="tb004 tb004_no_border">
			<tr name="5" id="set_row_sn">
				<td>
					<span style="font-family : 돋움; color : rgb(78, 141, 221); font-size : 60px; line-height : 70px;">12412124121241212412124121241212412124121241212412124121241212412124121241212412</span>
					<input type="hidden" id="set_vriabl_sn" name="set_vriabl_sn" value="8">
				</td>
			</tr>
		</table>
	</div>
	



	
	<div id="" name="">
		<input type="hidden" id="set_sn" name="set_sn" value="4">
		<table class="tb004 tb004_no_border">
			<tr>
				<td>
					<span style="font-family : 돋움; color : #666; font-size : 20px; line-height : 30px;">11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111</span>
					<input type="hidden" id="set_vriabl_sn" name="set_vriabl_sn" value="7">
				</td>
			</tr>
		</table>
	</div>




	<div id="" name="">
		<input type="hidden" id="set_sn" name="set_sn" value="2">
		<table class="tb004">
			<tr>
				<th style="width:10%;">한AEACNOTH</th>
				<td>
					<input type="text" id="4" name="4" value="" style="width: 100%;">
					<input type="hidden" id="set_vriabl_sn" name="set_vriabl_sn" value="4">
				</td>
				<td>
					<label>DRUG INTERRUPTED</label>
					<input type="hidden" id="set_vriabl_sn" name="set_vriabl_sn" value="5">
				</td>
				<td style="width:274px;">
					<button type="button">삭제</button>
				</td>
			</tr>
		</table>
	</div>




	<div id="" name="">
		<table class="tb004">
			<tr>
				<th style="width:10%;">한AEACN</th>
				<td>
					<div style="display:inline-block; margin-right : 12px;">
						<input type="checkbox" id="6_1" name="6" value="125345">
						<label for="6_1" class="chcLab"> <span>DOSE INCREASED</span></label>
					</div>
					<div style="display:inline-block; margin-right : 12px;">
						<input type="checkbox" id="6_2" name="6" value="125346">
						<label for="6_2" class="chcLab"> <span>DOSE NOT CHANGED</span></label>
					</div>
					<div style="display:inline-block; margin-right : 12px;">
						<input type="checkbox" id="6_3" name="6" value="125347">
						<label for="6_3" class="chcLab"> <span>DOSE REDUCED</span></label>
					</div>
					<div style="display:inline-block; margin-right : 12px;">
						<input type="checkbox" id="6_4" name="6" value="125348">
						<label for="6_4" class="chcLab"> <span>DRUG INTERRUPTED</span></label>
					</div>
					<div style="display:inline-block; margin-right : 12px;">
						<input type="checkbox" id="6_5" name="6" value="125349">
						<label for="6_5" class="chcLab"> <span>DRUG WITHDRAWN</span></label>
					</div>
					<div style="display:inline-block; margin-right : 12px;">
						<input type="checkbox" id="6_6" name="6" value="125350">
						<label for="6_6" class="chcLab"> <span>NOT APPLICABLE</span></label>
					</div>
					<div style="display:inline-block; margin-right : 12px;">
						<input type="checkbox" id="6_7" name="6" value="125351">
						<label for="6_7" class="chcLab"> <span>UNKNOWN</span></label>
					</div>
					<input type="hidden" id="set_vriabl_sn" name="set_vriabl_sn" value="6">
				</td>
				<td style="width:274px;">
					<button type="button">삭제</button>
				</td>
			</tr>
		</table>
	</div>


	<div id="" name="">
		<table class="tb004">
			<tr>
				<th>한AEACN</th>
				<td style="width:274px;">
					<button type="button">행추가</button>
					<button type="button">설정</button>
					<button type="button">행변환</button>
					<button type="button">행지움</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<button type="button">삭제</button>
				</td>
			</tr>
		</table>
	</div>





	<div id="" name="">
		<table class="tb004">
			<tr>
				<th>한AEACN</th>
				<th>한AEACNOTH</th>
				<td style="width:274px;">
					<button type="button">행추가</button>
					<button type="button">설정</button>
					<button type="button">행변환</button>
					<button type="button">행지움</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="" name="" value="" readonly="readonly" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<button type="button">삭제</button>
				</td>
			</tr>
		</table>
	</div>



	<div id="" name="">
		<table class="tb004">
			<tr>
				<th>한AEACN</th>
				<th>한AEACNOTH</th>
				<th>한AEBDSYCD</th>
				<th>한AEBODSYS</th>
				<td style="width:274px;">
					<button type="button">행추가</button>
					<button type="button">설정</button>
					<button type="button">행변환</button>
					<button type="button">행지움</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="" name="" value="" readonly="readonly" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<button type="button">삭제</button>
				</td>
			</tr>
		</table>
	</div>



	<div id="" name="">
		<table class="tb004">
			<tr>
				<th>한AEACN</th>
				<th>한AEACNOTH</th>
				<th>한AEBDSYCD</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<th>한AEBODSYS</th>
				<td style="width:274px;">
					<button type="button">행추가</button>
					<button type="button">설정</button>
					<button type="button">행변환</button>
					<button type="button">행지움</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" id="" name="" value="" readonly="readonly" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<input type="text" id="" name="" value="" style="width: 100%;">
				</td>
				<td>
					<button type="button">삭제</button>
				</td>
			</tr>
		</table>
	</div>




</article>
							
							
							
							
							
						</div>
					</section>
					
					
					
					
					
					
					
					
					<form id="frm_main" name="frm_main">
						<input type="hidden" id="TASK_SN" name="TASK_SN" value="1">
						<%-- 							<input type="hidden" id="TASK_SN" name="TASK_SN" value="${ TASK_SN }"> --%>
						<input type="hidden" id="TASK_NO" name="TASK_NO" value="${ TASK_NO }">
						<input type="text" id="CRF_VER" name="CRF_VER" value="${ CRF_VER }">
						<input type="hidden" id="EDC_VER" name="EDC_VER" value="2.1.0">
						<%-- 							<input type="hidden" id="EDC_VER" name="EDC_VER" value="${ EDC_VER }"> --%>
						<input type="hidden" id="INSTT_FORM_SN" name="INSTT_FORM_SN" value="${ INSTT_FORM_SN }23">
						<input type="hidden" id="SUBJECT_NO" name="SUBJECT_NO" value="${ SUBJECT_NO }S062">
						<input type="hidden" id="VISIT_GROUP_SN" name="VISIT_GROUP_SN" value="${ VISIT_GROUP_SN }">
					</form>
				</section>

			</div>
		</section>
	</div>
</body>
</html>