<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false" />
<title></title>



<style>
.detail_wrap_01{ overflow-x:auto; margin:7px 0 30px 0;}

table.tb002 { width:auto; border-top: 1px solid #7287e4;}
table.tb002 th {color:#333; border-right: 1px solid #e6e6e6;border-left: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6; background:#f6f7ff; font-family:'NanumGothicBold';  height:36px; font-size:16px; box-sizing: border-box; }
table.tb002 td { width:100px; border-right: 1px solid #e6e6e6;border-left: 1px solid #e6e6e6; height:42px; border-bottom: 1px solid #e6e6e6; font-family:'NanumGothic'; color:#555; padding:5px 0 0px 0; text-align:center; vertical-align:middle; font-size:12px; line-height:16px; box-sizing: border-box;  }
table.tb002 td:first-child{ text-align:right; padding:3px 8px 3px 3px;}

.con_category_01{ border:1px solid #d5d5d5; border-bottom:none;  top:-2px;  }
.dumi_02{ border-left:1px solid #d5d5d5; /* border-top:1px solid #d5d5d5; */ border-bottom:1px solid #d5d5d5; }
 .contents_02_in{  border-left:none; border:1px solid #d5d5d5; }
 
</style>


<script type="text/javascript">
//내용부분 1뎁스
function category_View(d1){
	var dep1 = d1 - 1 ;

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
	
	
});

//화면 로드, 리사이즈, 스크롤
$(window).load(function() {
	Con_Resize();
});

$(window).resize(function() {
	Con_Resize();
});

$(window).scroll(function(){
	Con_Resize();
});


$(function(){
	category_View(3);	//1뎁스 고정메뉴
	
	// 탭메뉴
	$('#tab_01').click(function(){
		window.location.href ="./_EDCC0102.do";
	});
	$('#tab_02').click(function(){
		window.location.href ="./_EDCC0103.do";
	});
	
	
	
});


</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
		<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>Subject List</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>Subject</li>
							<li>Subject List</li>
						</ul>
					</nav>
				</article>


	            <section class="conBox100 conBox">
					<div class="conBoxInner">
						<article class="mgT10" style="overflow:hidden;">
							<div class="conTitBtnL">
								
								<span style="font-family:'NanumGothicBold';">Site :</span>
								<input type="text" id="" name="" style="width: 140px;">
								<span style="font-family:'NanumGothicBold'; margin-left: 20px;">Subject :</span>
								<input type="text" id="" name="" style="width: 140px;">
								<button class="oneBtn" popup_type="ProductSearch" type="sumit">
										<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
							</div>
							<div class="conTitBtnR">									
								<input type="button" value="Unscheduled Visit 추가" onclick="">
							</div>
						</article>



						<div id="tab" class="tab tab01 mgT16">
							<ul>
								<li id="tab_01" class="port_back tab_menu">View</li>
								<li id="tab_02" class="tab_menu" onClick="">List</li>
							</ul>
						</div>


						<section class="conBox_01" style="margin:0;">
							<nav>
								<div class="con_category_01">
									<a href="#void" class="con_category_close"><span>SUBJECT NO</span></a>
									<a href="#void" class="con_category_open"></a>
									
									
									<dl class="depth_01">
										<dd>
											<a href="#1"><span>S111</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S233</span></a>
										</dd>
										<dd>
											<a href="#2"><span>S237</span></a>
										</dd>
										<dd>
											<a href="#3"><span>S236</span></a>
										</dd>
										<dd>
											<a href="#4"><span>S235</span></a>
										</dd>
										<dd>
											<a href="#5"><span>S234</span></a>
										</dd>
										<dd>
											<a href="#6"><span>S999</span></a>
										</dd>
									</dl>
									<div class="dumi_02"></div>
									
									
			
								</div>
								
							</nav>
			
			
			
							<section class="contents_02">
								<div class="contents_02_in">
									<article class="detail_wrap_01">
									
									
										<!-- 한셀당 가로 100px 13개 이니까 table width:1300입니다. -->
										<table class="tb002" style="width:1400px;">
											<tbody>
												<tr>
													<th></th>
													<th>V1</th>
													<th>V2</th>
													<th>V3</th>
													<th>UV1</th>
													<th>V4</th>
													<th>UV2</th>
													<th>V4</th>
													<th>V5</th>
													<th>V6</th>
													<th>V7</th>
													<th>V8</th>
													<th>V9</th>
													<th>V10</th>
												</tr>
												<tr>
													<td>방문일</td>
													<td><a href="#"><span class="big_icon_01" title="입력전"></span></a></td>
													<td><a href="#"><span class="big_icon_02" title="비활성화"></span></a></td>
													<td><a href="#"><span class="big_icon_03" title="임시저장"></span></a></td>
													<td><a href="#"><span class="big_icon_04" title="쿼리없음"></span></a></td>
													<td><a href="#"><span class="big_icon_05" title="쿼리있음"></span></a></td>
													<td><a href="#"><span class="big_icon_06" title="퀴리응답"></span></a></td>
													<td><a href="#"><span class="big_icon_07" title="SDV 미완료"></span></a></td>
													<td><a href="#"><span class="big_icon_08" title="SDV 완료"></span></a></td>
													<td><a href="#"><span class="big_icon_09" title="전자서명 미완료"></span></a></td>
													<td><a href="#"><span class="big_icon_10" title="전자서명 완료"></span></a></td>
													<td><a href="#"><span class="big_icon_11" title="SDV Completion"></span></a></td>
													<td><a href="#"><span class="big_icon_12" title="DB Freezing"></span></a></td>
													<td><a href="#"><span class="big_icon_13" title="쿼리응답 이나 퀴리 있음"></span></a></td>
												</tr>
												<tr>
													<td>인구학적정보</td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td>활력징후</td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td>신체검사</td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
													<td></td>
												</tr>
											</tbody>
										</table>
									
									
									
									

									</article>










								</div>
							</section>	
						</section>
								
			
			
			
								
								
						</section>
			
					</div>
	            </section>			
				
			</div>
		</section>
	</div>
</body>
</html>