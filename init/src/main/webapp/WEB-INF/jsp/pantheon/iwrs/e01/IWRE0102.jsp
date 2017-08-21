<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<jsp:include page="/com/common.do" flush="false" />
	<style>
		.detail_wrap_01{ overflow-x:auto; margin:7px 0 30px 0;}

		table.tb002 { width:auto;}
		table.tb002 th {color:#333; border:1px solid #f2f2f2; font-family:'NanumGothicBold';  height:36px; font-size:16px; box-sizing: border-box; }
		table.tb002 td { width:100px; border:1px solid #f2f2f2; font-family:'NanumGothic'; color:#555; padding:10px 0; text-align:center; vertical-align:middle; font-size:16px; box-sizing: border-box;  }
		table.tb002 td:first-child{ text-align:right; padding-right:20px;}
		
		.round_red_01{ position:relative; border:3px solid #ff5e00; border-radius:8px; width:50px; height:50px; display:block; margin:0 auto; padding:5px 0 0 0;box-sizing: border-box; font-size:26px; line-height:30px; font-family:'NanumGothicBold';}
		.round_black_01{position:relative; border:3px solid #818181; border-radius:8px; width:50px; height:50px; display:block; margin:0 auto; padding:5px 0 0 0;box-sizing: border-box; font-size:26px; line-height:30px; font-family:'NanumGothicBold';}
		.round_gray_01{position:relative; border:3px solid #e1e1e1; border-radius:8px; width:50px; height:50px; display:block; margin:0 auto; padding:5px 0 0 0;box-sizing: border-box; font-size:26px; line-height:30px; font-family:'NanumGothicBold';}
		
		.con_category_01{ border:1px solid #d5d5d5; border-bottom:none;  top:-2px;  }
		.dumi_02{ border-left:1px solid #d5d5d5; /* border-top:1px solid #d5d5d5; */ border-bottom:1px solid #d5d5d5; }
		 .contents_02_in{  border-left:none; border:1px solid #d5d5d5; }

	</style>

	<script type="text/javascript">
		var tableHeader = "";
		//내용부분 1뎁스
		function category_View(d1){
			var dep1 = d1;
		
			$(".depth_01 > dd > a").eq(dep1).addClass("open").next().slideDown("fast"); //첫번째 내용 보이기
		
			$(".depth_01 > dd > a").each(function () {
				 $(this).css("background-image","none");
			});
		
			$(".depth_01 > dd > a").click(function() {
				$(this).addClass("open").next("dl").slideDown("fast");
		
				//나머지 닫힘
				$(".depth_01 > dd > a").not(this).removeClass("open").next("dl").slideUp("fast");
			});
		}

		//내용부분 크기 조정
		function Con_Resize(){
			var con_boxd = $('.contents_02_in').height();
			$('.con_category_01').css({"height": con_boxd + 18 + "px"});
			$('.conBox_01').css({"height": con_boxd + 22 + "px"});
			$('.depth_01').css({"height": con_boxd - 32 + "px"});
			$('.dumi_02').css({"height": con_boxd + 20 + "px"});
			$('.contents_02').css({"top": -con_boxd - 21 + "px"});
			$('.lnb').addClass('lnb_relative');
		}
		
		$(function(){
			subjectListSetting();
			visitListSetting();
			pageSetting();
			setTableHeader();
			Con_Resize();
			//내용부분 카테고리 닫기
			$(".con_category_close").click(function(){
		        $(".con_category_close").hide();
		        $(".con_category_open").show();
				$(".depth_01").addClass("hidden");
				$(".con_category_01").addClass("con_category_01_reduce");
				$(".dumi_02").addClass("dumi_02_move");
				$(".contents_02_in").addClass("contents_02_move");
				
		        if($('.grid_wrap') && $('.grid_wrap').length) {
			    	for(var i = 0; i < $('.grid_wrap').length; i++) {
		            	try {
							fn_lnbResize($('.grid_wrap')[i].id);
		            	} catch(e) {
		            	}
			    	}
		        }
			});
		
			$(".con_category_open").click(function(){
		        $(".con_category_open").hide();
		        $(".con_category_close").show();
				$(".depth_01").removeClass("hidden");
				$(".con_category_01").removeClass("con_category_01_reduce");
				$(".dumi_02").removeClass("dumi_02_move");
				$(".contents_02_in").removeClass("contents_02_move");
				
		        if($('.grid_wrap') && $('.grid_wrap').length) {
			    	for(var i = 0; i < $('.grid_wrap').length; i++) {
		            	try {
							fn_lnbResize($('.grid_wrap')[i].id);
		            	} catch(e) {
		            	}
			    	}
		        }

			});
			
			//1뎁스 고정메뉴
			category_View($("#dlSubjectList").find("dd > a").index($("#${SUBJECT_CODE}")));
			getSubjectDispenseInfo("${SUBJECT_CODE}");
			
			// 팝업레이어
			$('.popup_01').click(function(){
				mkLayerPopupOpen("./_IWRE0102_popup_01.jsp", null);
			});
		
		});
		
		//화면 로드, 리사이즈, 스크롤
		$(window).load(function() {
// 			Con_Resize();
		});
		
		$(window).resize(function() {
// 			Con_Resize();
		});
		
		$(window).scroll(function(){
// 			Con_Resize();
		});
		
		function visitListSetting(){
			var th = "<th>&nbsp;</th>";
			var size = 1;
			<c:forEach var="result" items="${visit}" varStatus="status">
				th += "<th>${result.VISIT_LBL}</th>";
				size++;
			</c:forEach>
			$("#trVisitHeader").append(th);
			$("#trVisitHeader").parent().parent().css("width", 100 * size);
		}
		
		function subjectListSetting(){
			<c:forEach var="result" items="${list}" varStatus="status">
				var dl = "<dd><a id=\"${result.SUBJECT_NO}\" href='javascript:getSubjectDispenseInfo(\"${result.SUBJECT_NO}\");'><span>${result.SUBJECT_NO}</span></a></dd>";
				$("#dlSubjectList").append(dl);
			</c:forEach>
		}
		
		function pageSetting(){
			$("#sctView").show();
			$("#sctList").hide();
		}
		
		function changeMode(value){
			if(value == "1"){
				$("#sctView").show();
				$("#sctList").hide();
			}else{
				$("#sctView").hide();
				$("#sctList").show();
			}
		}
		
		function getSubjectDispenseInfo(subjectNo){
			$("#artTable").find("table").remove();
			$("#trDispense > td").remove();
			$("#trReturn > td").remove();
			var param = {
				SUBJECT_CODE : subjectNo
			};
			$.ajax({
				type : "POST",
				async : false,
				data : param,
				url : "/iwrs/e01/selectDispenseListForSubject.do",
				success :function(data){
					if(data.result){
						var table = tableHeader;
						var dispenseTd = "<td>불출</td>";
						var returnTd = "<td>반납</td>";
						for(var i = 0; i < data.list.length; i++){
							table += "<tr>";
							table += "<td>" + data.list[i].VISIT_LBL + "</td>";
							table += "<td>" + data.list[i].IP_TYPE + "</td>";
							if("${ROLE}" == "CRA" || "${ROLE}" == "CRM"){
								table += "<td><a href='javascript:goConfirmPage(\"" + data.list[i].TASK_CODE + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")'>" + data.list[i].RTUN_DT + "</a></td>";
							}else{
								table += "<td><a href='javascript:goDispensePage(\"" + data.list[i].TASK_CODE + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")'>" + data.list[i].RTUN_DT + "</a></td>";
							}
// 							table += "<td>" + data.list[i].RTUN_DT + "</td>";
							table += "<td>" + data.list[i].RTUN_QTT + "</td>";
// 							table += "<td>" + data.list[i].RTURN_DT + "</td>";
							if("${ROLE}" == "CRA" || "${ROLE}" == "CRM"){
								table += "<td><a href='javascript:goConfirmPage(\"" + data.list[i].TASK_CODE + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")'>" + data.list[i].RTURN_DT + "</a></td>";
							}else{
								table += "<td><a href='javascript:goReturnPage(\"" + data.list[i].TASK_CODE + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")'>" + data.list[i].RTURN_DT + "</a></td>";
							}
							table += "<td>" + data.list[i].RTURN_QTT + "</td>";
							table += "<td>" + data.list[i].QUERY_STTUS_CODE + "</td>";
							
							if(("${ROLE}" == "CRA" || "${ROLE}" == "CRM") && data.list[i].IP_TYPE.trim() != ""){
								table += "<td><a href='javascript:goConfirmPage(\"" + data.list[i].TASK_CODE + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")'>Query Open</a></td>";
							}else{
								table += "<td></td>";
							}
							table += "</tr>";
						}
						table += "</tbody>";
						table += "</table>";
						$("#artTable").append(table);
						for(var i = 0; i < data.view.length; i++){
							var className = "";
							if(data.view[i].RTUN_RTURN_CNFIRM_AT == "Y"){
								className = "round_red_01";	
							}else if(data.view[i].RTUN_QTT != null && data.view[i].RTUN_QTT.trim() != "" && data.view[i].RTUN_RTURN_CNFIRM_AT == "N"){
								className = "round_black_01";
							}else{
								className = "round_gray_01";
							}
							if("${ROLE}" == "CRA" || "${ROLE}" == "CRM"){
								if(data.view[i].TYPE == "1"){
									dispenseTd += "<td><a href='javascript:goConfirmPage(\"" + data.view[i].TASK_SN + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")' class='" + className + "'>" + data.view[i].RTUN_QTT;
									if(data.view[i].QUERY_STTUS_CODE == "01" || data.view[i].QUERY_STTUS_CODE == "02"){
										dispenseTd += "<span class='must_02'></span>"
									}
									dispenseTd += "</a></td>";
								}else{
									returnTd += "<td><a href='javascript:goConfirmPage(\"" + data.view[i].TASK_SN + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")' class='" + className + "'>" + data.view[i].RTUN_QTT;
									if(data.view[i].QUERY_STTUS_CODE == "01" || data.view[i].QUERY_STTUS_CODE == "02"){
										returnTd += "<span class='must_02'></span>"
									}
									returnTd += "</a></td>";
								}
							}else{
								if(data.view[i].TYPE == "1"){
									dispenseTd += "<td><a href='javascript:goDispensePage(\"" + data.view[i].TASK_SN + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")' class='" + className + "'>" + data.view[i].RTUN_QTT;
									if(data.view[i].QUERY_STTUS_CODE == "01" || data.view[i].QUERY_STTUS_CODE == "02"){
										dispenseTd += "<span class='must_02'></span>"
									}
									dispenseTd += "</a></td>";
								}else{
									returnTd += "<td><a href='javascript:goReturnPage(\"" + data.view[i].TASK_SN + "\", \"" + subjectNo +"\", \"" + data.view[i].VISIT_SN + "\", \"" + data.view[i].VISIT_LBL + "\")' class='" + className + "'>" + data.view[i].RTUN_QTT;
									if(data.view[i].QUERY_STTUS_CODE == "01" || data.view[i].QUERY_STTUS_CODE == "02"){
										returnTd += "<span class='must_02'></span>"
									}
									returnTd += "</a></td>";
								}
							}
						}
						$("#trDispense").append(dispenseTd);
						$("#trReturn").append(returnTd);
					}else{
						alert(data.message);
					}
				}, 
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
			});
		}
		
		function setTableHeader(){
			tableHeader += "<table class='tb001'>";
			tableHeader += "<tbody>";
			tableHeader += "<tr>";
			tableHeader += "<th rowspan='2'>방문</th>";
			tableHeader += "<th rowspan='2'>IP TYPE</th>";
			tableHeader += "<th colspan='2'>불출</th>";
			tableHeader += "<th colspan='2'>반납</th>";
			tableHeader += "<th rowspan='2'>쿼리상태</th>";
			if("${ROLE}" == "CRA" || "${ROLE}" == "CRM"){
				tableHeader += "<th rowspan='2'>쿼리발행</th>";
			}
			tableHeader += "</tr>";
			tableHeader += "<tr>";
			tableHeader += "<th>불출일</th>";
			tableHeader += "<th>수량</th>";
			tableHeader += "<th>반납일</th>";
			tableHeader += "<th>수량</th>";
			tableHeader += "</tr>";
			var table = tableHeader;
			table += "</tbody>";
			table += "</table>";
			$("#artTable").append(table);
		}
		
		function goDispensePage(task_code, subject_code, visit_code, visit_lbl){
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
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/iwrs/e01/IWRE0103.do");
			document.body.appendChild(f);
			f.submit();
		}
		
		function goReturnPage(task_code, subject_code, visit_code, visit_lbl){
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
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/iwrs/e01/IWRE0104.do");
			document.body.appendChild(f);
			f.submit();
		}
		
		function goConfirmPage(task_code, subject_code, visit_code, visit_lbl){
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
			
			f.setAttribute("method", "post");
			f.setAttribute("action", "/iwrs/e01/IWRE0105.do");
			document.body.appendChild(f);
			f.submit();
		}
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRE0102&UPPER_MENU_ID=IWRE" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRE0102&UPPER_MENU_ID=IWRE" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
	                <nav id="pathNav"
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>${progrmMap.UPPER_MENU_NM}</li>
	                        <li>${progrmMap.MENU_NM}</li>
	                    </ul>
	                </nav>
				</article>

            	<section class="conBox100 conBox">
					<div class="conBoxInner">
		            	<articla class="conTitBox">
		            		<h5>불출/반납 현황</h5>
		            	</articla>

						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="tab_menu1" class="port_back tab_menu" onClick="changeMode(1);">View 모드</li>
								<li id="tab_menu2" class="tab_menu" onClick="changeMode(2);">List 모드</li>
							</ul>
						</div>

						<section class="conBox_01" style="margin:0;">
							<nav>
								<div class="con_category_01">
									<a href="#void" class="con_category_close"><span>SUBJECT NO</span></a>
									<a href="#void" class="con_category_open"></a>
									<dl id="dlSubjectList" class="depth_01">
									</dl>
									<div class="dumi_02"></div>
								</div>
							</nav>
							<section id="sctView" class="contents_02">
								<div class="contents_02_in">
									<h6>의약품</h6>
									<article class="detail_wrap_01">
										<table class="tb002" style="width:500px;">
											<tbody>
												<tr id="trVisitHeader">
												</tr>
												<tr id="trDispense">
												</tr>
												<tr id="trReturn">
												</tr>
											</tbody>
										</table>
									</article>
								</div>
							</section>
							<section id="sctList" class="contents_02">
								<div class="contents_02_in">
									<h6>의약품</h6>
									<article id="artTable">
										
									</article>
								</div>
							</section>
						</section>
					</div>
	            </section>
			</div>
		</section>
	</div>
</body>
</html>