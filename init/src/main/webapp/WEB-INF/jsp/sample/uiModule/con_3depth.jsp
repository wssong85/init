<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/com/common.do" flush="false" />

<title>EDC Designer</title>

<script type="text/javascript">
//내용부분 3뎁스
function category_View(d1, d2, d3){
	var dep1 = d1 - 1 ;
	var dep2 = d2 - 1 ;
	var dep3 = d3 - 1 ;

	$(".depth_01 > dd > a").eq(dep1).addClass("open").next().slideDown("fast"); //첫번째 내용 보이기
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().addClass("open").slideDown("fast"); //두번째 내용 보이기
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".link_01").eq(dep3).addClass("on"); //세번째 text 표시
	$(".depth_01 > dd > a").eq(dep1).next().children("dd").eq(dep2).children().next().children("dd").find(".popup_01").eq(dep3).addClass("on"); //세번째 팝업 아이콘 표시

	$(".depth_01 > dd > a").click(function() {
		$(this).addClass("open").next("dl").slideDown("fast");

		//나머지 닫힘
		$(".depth_01 > dd > a").not(this).removeClass("open").next("dl").slideUp("fast");
		$(".depth_02 > dd > a").not(this).removeClass("open").next("dl").slideUp("fast");
	});

	$(".depth_02 > dd > a").click(function() {
		if($(this).next("dl").hasClass("depth_03")){
			$(this).toggleClass("open").parent().find(".depth_03").slideToggle("fast");
		}else{
			$(this).removeClass("open");
		}
		//나머지 닫힘
		//$(".depth_02 > dd > a").not(this).removeClass("open").parent().find(".depth_03").slideUp("fast");
	
	});
}

//내용부분 크기 조정
function Con_Resize(){
	var con_boxd = $('.contents_01_in').height();
	$('.con_category_01').css({"height": con_boxd + 17 + "px"});
	$('.conBox_01').css({"height": con_boxd + 22 + "px"});
	$('.depth_01').css({"height": con_boxd - 29 + "px"});
	$('.depth_02').css({"height": con_boxd + 20 + "px"});
	$('.dumi_01').css({"height": con_boxd + 20 + "px"});
	$('.contents_01').css({"top": -con_boxd - 19 + "px"});
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
		$(".con_category_01 .depth_02").addClass("depth_02_move");
		$(".dumi_01").addClass("dumi_01_move");
		$(".contents_01_in").addClass("contents_01_move");

	});
	
	$(".con_category_open").click(function(){
        $(".con_category_open").hide();
        $(".con_category_close").show();
		$(".depth_01").removeClass("hidden");
		$(".con_category_01").removeClass("con_category_01_reduce");
		$(".con_category_01 .depth_02").removeClass("depth_02_move");
		$(".dumi_01").removeClass("dumi_01_move");
		$(".contents_01_in").removeClass("contents_01_move");

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
	category_View(1, 2, 2);	//3뎁스 고정메뉴
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
								<a href="#void"><span>S238</span></a>
								<dl class="depth_02">
									<dt><span>S238-N226</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>V1</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>방문일방문일방문일방문일방문일방문일방문일방문일방문일방문일방문일</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>인구학적 정보</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_02" title="비활성화"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>병력조사</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_03" title="임시저장"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>투여약물 조사</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_04" title="쿼리없음"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>활력징후</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_05" title="쿼리있음"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>일반신체검사</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_06" title="퀴리응답"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>피임동의 및 피임방법 확인</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_07" title="SDV 미완료"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>피임동의 및 피임방법 확인</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_08" title="SDV 완료"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>피임동의 및 피임방법 확인</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_09" title="전자서명 미완료"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>피임동의 및 피임방법 확인</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_10" title="전자서명 완료"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>피임동의 및 피임방법 확인</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_11" title="SDV Completion"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>피임동의 및 피임방법 확인</span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_12" title="DB Freezing"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>V2</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>방문일</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_10" title="전자서명 완료"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>인구학적 정보 </span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_10" title="전자서명 완료"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>인구학적 정보 </span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_10" title="전자서명 완료"></span></div>
											</dd>
											<dd>
												<a href="#" class="link_01"><span>인구학적 정보 </span></a>
												<a href="#" class="popup_01"><span>P</span></a>
												<div class="mark_01"><span class="small_icon_10" title="전자서명 완료"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>V3</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>방문일</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_08" title="SDV 완료"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>V4</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>방문일</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_08" title="SDV 완료"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>SFU</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>방문일</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_08" title="SDV 완료"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>ALL</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>임상시험대상자 일지</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_08" title="SDV 완료"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S237</span></a>
								<dl class="depth_02">
									<dt><span>S237-N225</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_08" title="SDV 완료"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>V1</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>방문일</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_08" title="SDV 완료"></span></div>
											</dd>
										</dl>
									</dd>
									<dd>
										<a href="#void"><span>V2</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>방문일</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S236</span></a>
								<dl class="depth_02">
									<dt><span>S236-N224</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S235</span></a>
								<dl class="depth_02">
									<dt><span>S235</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S234</span></a>
								<dl class="depth_02">
									<dt><span>S234</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S233</span></a>
								<dl class="depth_02">
									<dt><span>S233-N222</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S233</span></a>
								<dl class="depth_02">
									<dt><span>S233-N222</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S233</span></a>
								<dl class="depth_02">
									<dt><span>S233-N222</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S233</span></a>
								<dl class="depth_02">
									<dt><span>S233-N222</span></dt>
									<dd>
										<a href="#void"><span>등록</span></a>
										<dl class="depth_03">
											<dd>
												<a href="#1" class="link_01"><span>등록</span></a>
												<a href="#2" class="popup_01"><span>popup</span></a>
												<div class="mark_01"><span class="small_icon_01" title="입력전"></span></div>
											</dd>
										</dl>
									</dd>
								</dl>
							</dd>
							<dd>
								<a href="#void"><span>S33</span></a>
								<dl class="depth_02">
									<dt><span>S233-N222</span></dt>
								</dl>
							</dd>
							
						</dl>
						<div class="dumi_01"></div>
						

					</div>
					
				</nav>



				<section class="contents_01">
					<div class="contents_01_in">
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