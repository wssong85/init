<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<script>

function fn_lnbResize(v) {
	setTimeout(function() {
		var test = AUIGrid.resize('#' + v);
		
		if(!test) {
			AUIGrid.resize(v);
		}
	}, 90);
}

function fn_lnbResize2(v) {
	setTimeout(function() {
		AUIGrid.resize(v);
	}, 90);
}

$(function(){
    $(".lnb_open").click(function () {
        
    	$(".leftNav").animate({"left": "-=230px"}, 90);
		$("#mainCon").animate({"padding-left": "-=230px"}, 90);
        $(".lnb_open").hide();
        $(".lnb_close").show();
        
        if($('.grid_wrap') && $('.grid_wrap').length) {
	    	for(var i = 0; i < $('.grid_wrap').length; i++) {
            	try {
					fn_lnbResize($('.grid_wrap')[i].id);
            	} catch(e) {
//             		fn_lnbResize2($('.grid_wrap')[i]))   		
            	}
	    	}
        }
        
    });
    
    $(".lnb_close").click(function () {
        
    	$(".leftNav").animate({"left": "+=230px"}, 90);
		$("#mainCon").animate({"padding-left": "+=230px"}, 90);
        $(".lnb_open").show();
        $(".lnb_close").hide();
        
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


//높이 조정
function lnb_Resize(){
	var left_height = $('#mainCon').height();
	$('.leftNav').css({"min-height": left_height + 61 + "px"});
}

//화면 로드, 리사이즈, 스크롤
$(window).load(function() {
	lnb_Resize();
});

$(window).resize(function() {
	lnb_Resize();
});

$(window).scroll(function(){
	lnb_Resize();
});
</script>


<nav id="leftNav" class="leftNav">

<div class="lnb_btn_01">
	<a href="#void" class="lnb_open"></a>
	<a href="#void" class="lnb_close"></a>
</div>


<div class="sstName">${result.leftTitle}</div>

<!-- class="lnbSubLstMusOn" -->
<ul class="lnb" id="lnb">
	<c:forEach items="${ result.distinctLeftMenu }" var="list_1">
		<c:choose>
		<c:when test="${list_1.MENU_ID eq result.UPPER_MENU_ID}">
			<c:choose>
			<c:when test="${list_1.MENU_COUNT > 1}">
				<li class="lnbLst has_sub"><a class="lnbLstA close lnbMusOn" href="#">${ list_1.UPPER_MENU_NM}<div class="lnbArrow_on"></div></a>
				<c:forEach items="${ result.leftMenu }" var="list_2">
					<c:if test="${list_1.MENU_ID eq list_2.UPPER_MENU_ID}">
						<ul class="lnbSub open">
							<c:choose>
							<c:when test="${result.compareId eq list_2.PROGRM_ID}">
								<li class="lnbSubLst"><a href="${ list_2.PROGRM_URL}" class="lnbSubLstMusOn">${ list_2.MENU_NM}</a></li>
							</c:when>
							<c:otherwise>
								<li class="lnbSubLst"><a href="${ list_2.PROGRM_URL}">${ list_2.MENU_NM}</a></li>
							</c:otherwise>
							</c:choose>	
						</ul>
					</c:if>
				</c:forEach>
				</li>
			</c:when>
			<c:otherwise>
				<c:forEach items="${ result.leftMenu }" var="list_2">
					<c:if test="${list_1.MENU_ID eq list_2.UPPER_MENU_ID}">
						<li class="lnbLst has_sub"><a class="lnbLstA close lnbMusOn" href="${ list_2.PROGRM_URL}">${ list_1.UPPER_MENU_NM}</a></li>
					</c:if>
				</c:forEach>
			</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:choose>
			<c:when test="${list_1.MENU_COUNT > 1}">
			<li class="lnbLst has_sub"><a class="lnbLstA close" href="#">${ list_1.UPPER_MENU_NM}<div class="lnbArrow"></div></a>
			<c:forEach items="${ result.leftMenu }" var="list_2">
				<c:if test="${list_1.MENU_ID eq list_2.UPPER_MENU_ID}">
					<ul class="lnbSub close">
						<li class="lnbSubLst"><a href="${ list_2.PROGRM_URL}">${ list_2.MENU_NM}</a></li>
					</ul>
				</c:if>
			</c:forEach>
			</li>
			</c:when>
			<c:otherwise>
				<c:forEach items="${ result.leftMenu }" var="list_2">
					<c:if test="${list_1.MENU_ID eq list_2.UPPER_MENU_ID}">
					<li class="lnbLst has_sub"><a class="lnbLstA close" href="${ list_2.PROGRM_URL}">${ list_2.UPPER_MENU_NM}</a>
					</c:if>
				</c:forEach>
			</c:otherwise>
			</c:choose>
		</c:otherwise>
		</c:choose>
	</c:forEach>
</ul>
</nav>




<script>
function quick_01(){
	var qwidth = parseInt($(this).width());

	if (qwidth < 1200) {
		$('.top_down_area').css({ 'display': 'none'});
	} else  {
		$('.top_down_area').css({ 'display': 'block'});
	}
}

$(window).load(function() {
	//quick_01();
});

$(window).resize(function() {
	quick_01();
});

$(window).scroll(function() {
	quick_01();
});


$(function(){
	var speed = 400; 
	$(".btn_layer_up").click(function(e){
		e.preventDefault();
		$('body, html').animate({scrollTop: 0}, 100);
	})
	$(".btn_layer_down").click(function(e){
		e.preventDefault();
		$('body, html').animate({scrollTop: $(document).height() - $(window).height()}, 100);

	})
});
</script>



<div class="top_down_area">
	<div class="top_down_fixed">
		<a class="btn_layer_up" href="#"><span>상단</span></a>
		<a class="btn_layer_down" href="#"><span>하단</span></a>
	</div>
</div>














