<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/com/common.do" flush="false" />

<title>EDC Designer</title>

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
	$('.con_category_01').css({"height": con_boxd + 17 + "px"});
	$('.conBox_01').css({"height": con_boxd + 22 + "px"});
	$('.depth_01').css({"height": con_boxd - 29 + "px"});
	$('.dumi_02').css({"height": con_boxd + 20 + "px"});
	$('.contents_02').css({"top": -con_boxd - 19 + "px"});
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

	});
	
	$(".con_category_open").click(function(){
        $(".con_category_open").hide();
        $(".con_category_close").show();
		$(".depth_01").removeClass("hidden");
		$(".con_category_01").removeClass("con_category_01_reduce");
		$(".dumi_02").removeClass("dumi_02_move");
		$(".contents_02_in").removeClass("contents_02_move");

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
						<a href="#void" class="con_category_close"><span>SUBJECT NO</span></a>
						<a href="#void" class="con_category_open"></a>
						
						
						<dl class="depth_01">
							<dd>
								<a href="#1"><span>S238</span></a>
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
						</dl>
						<div class="dumi_02"></div>
						
						

					</div>
					
				</nav>



				<section class="contents_02">
					<div class="contents_02_in">
						<h3>CRF WRITE</h3>
						<article>




							<span class="big_icon_01" title="입력전"></span>
							<span class="big_icon_02" title="비활성화"></span>
							<span class="big_icon_03" title="임시저장"></span>
							<span class="big_icon_04" title="쿼리없음"></span>
							<span class="big_icon_05" title="쿼리있음"></span>
							<span class="big_icon_06" title="퀴리응답"></span>
							<span class="big_icon_07" title="SDV 미완료"></span>
							<span class="big_icon_08" title="SDV 완료"></span>
							<span class="big_icon_09" title="전자서명 미완료"></span>
							<span class="big_icon_10" title="전자서명 완료"></span>
							<span class="big_icon_11" title="SDV Completion"></span>
							<span class="big_icon_12" title="DB Freezing"></span>


							2222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
							22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
							2222<br>22222222<br>22222222<br>22222222<br>222222222222<br>22222222<br>22222222<br>22222222<br>222222222222<br>22222222<br>22222222<br>22222222<br>22222222
							
							
							
							
							end


						</article>
					</div>
				</section>	
					



					
					
			</section>
			
			
			
			</div>
		</section>
	</div>
</body>
</html>