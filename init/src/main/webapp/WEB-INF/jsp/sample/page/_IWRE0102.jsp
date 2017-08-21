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

table.tb002 { width:auto;}
table.tb002 th {color:#333; border:1px solid #f2f2f2; font-family:'NanumGothicBold';  height:36px; font-size:16px; box-sizing: border-box; }
table.tb002 td { width:100px; border:1px solid #f2f2f2; font-family:'NanumGothic'; color:#555; padding:10px 0; text-align:center; vertical-align:middle; font-size:16px; box-sizing: border-box;  }
table.tb002 td:first-child{ text-align:right; padding-right:20px;}

.round_red_01{ position:relative; border:3px solid #ff5e00; border-radius:8px; width:50px; height:50px; display:block; margin:0 auto; padding:5px 0 0 0;box-sizing: border-box; font-size:26px; line-height:30px; font-family:'NanumGothicBold';}
.round_black_01{position:relative; border:3px solid #818181; border-radius:8px; width:50px; height:50px; display:block; margin:0 auto; padding:5px 0 0 0;box-sizing: border-box; font-size:26px; line-height:30px; font-family:'NanumGothicBold';}
.round_gray_01{position:relative; border:3px solid #e1e1e1; border-radius:8px; width:50px; height:50px; display:block; margin:0 auto; padding:5px 0 0 0;box-sizing: border-box; font-size:26px; line-height:30px; font-family:'NanumGothicBold';}


/* 
.dumi_02{ border-bottom:1px solid #d5d5d5;}
.contents_02{  top:116px;  padding-left:183px; min-width:auto; transition-duration: 0s; }
.contents_02_move{  padding-left:68px;  }
.contents_02_in{ padding-left:1px;}

 */
 
 
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
});


</script>
</head>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRC0101&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>
		<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRC0101&UPPER_MENU_ID=IWRC" charEncoding="utf-8"/>

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>Dispense 현황</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>Dispense</li>
							<li>Dispense 현황</li>
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
								<li id="tab_menu1" class="port_back tab_menu">View 모드</li>
								<li id="tab_menu2" class="tab_menu" onClick="">List 모드</li>
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
									




									<h6>의약품</h6>
									<article class="detail_wrap_01">
										<table class="tb002" style="width:500px;">
											<tbody>
												<tr>
													<th></th>
													<th>V2</th>
													<th>V3</th>
													<th>V4</th>
													<th>V5</th>
												</tr>
												<tr>
													<td>불출</td>
													<td><a href="#1" class="round_red_01">6<span class="must_02"></span></a></td>
													<td><a href="#1" class="round_black_01">1</a></td>
													<td><a href="#1" class="round_gray_01">99</a></td>
													<td><a href="#1" class="round_red_01">54</a></td>
												</tr>
												<tr>
													<td>반납</td>
													<td><a href="#1" class="round_red_01">1</a></td>
													<td><a href="#1" class="round_black_01">1</a></td>
													<td><a href="#1" class="round_gray_01">44<span class="must_02"></span></a></td>
													<td><a href="#1" class="round_gray_01">99</a></td>
												</tr>
											</tbody>
										</table>
									</article>





	
									<h6>구제약</h6>
									<article class="detail_wrap_01">
										<table class="tb002" style="width:1000px;">
											<tbody>
												<tr>
													<th></th>
													<th>V2</th>
													<th>V3</th>
													<th>V4</th>
													<th>V5</th>
													<th>V6</th>
													<th>V7</th>
													<th>V8</th>
													<th>V9</th>
													<th>V10</th>
												</tr>
												<tr>
													<td>불출</td>
													<td><a href="#1" class="round_red_01">6<span class="must_02"></span></a></td>
													<td><a href="#1" class="round_black_01">1</a></td>
													<td><a href="#1" class="round_gray_01">99</a></td>
													<td><a href="#1" class="round_red_01">54</a></td>
													<td><a href="#1" class="round_red_01">54</a></td>
													<td><a href="#1" class="round_red_01">54</a></td>
													<td><a href="#1" class="round_red_01">54</a></td>
													<td><a href="#1" class="round_red_01">54</a></td>
													<td><a href="#1" class="round_red_01">54</a></td>
												</tr>
											</tbody>
										</table>
									</article>



									123123<br>
									




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