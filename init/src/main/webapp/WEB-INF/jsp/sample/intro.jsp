<%@page pageEncoding="UTF-8"%> 

<!DOCTYPE HTML>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <meta name="Author" content="RyuJiHyun">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=IE9" charset="utf-8">
  <title>Intro</title>
  <link rel="shortcut icon" href="../../images/pantheon/common/favicon.ico">
  <link rel="stylesheet" href="../../css/pantheon/common/reset.css">
  <link rel="stylesheet" href="../../css/pantheon/common/intro.css"> 
  <link rel="stylesheet" href="../../css/pantheon/common/layout.css"> 
  <link rel="stylesheet" href="../../css/pantheon/common/common.css"> 
  <link rel="stylesheet" href="../../css/pantheon/common/contents.css"> 
  <link rel="stylesheet" href="../../css/pantheon/common/theme.css" > 
  <link rel="stylesheet" href="../../css/pantheon/common/bxslider.css"> 
  <script src="../../js/pantheon/common/jquery-1.11.3.min.js"></script>
  <script src="../../js/pantheon/common/jquery-ui.min.js"></script>
  <script src="../../js/pantheon/common/jquery.mobile-events.js"></script>
  <script src="../../js/pantheon/common/jquery.bxslider.js"></script>
  <script src="../../js/pantheon/common/common.js"></script>
  <script src="../../js/pantheon/common/theme.js"></script>
  <script src="../../js/pantheon/common/layout.js"></script>
  <script src="../../js/pantheon/common/intro.js"></script>
  <!--[if lt IE 9]>
  <script src="../../js/pantheon/common/html5shiv.js"></script>
  <script src="../../js/pantheon/common/PIE.js"></script>
  <script src="../../js/pantheon/common/respond.min.js"></script>
  <script src="https://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
  <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js"></script>
  <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
  <![endif]-->

<script>
  $(function(){
  var Slider=$(".visualSlider").bxSlider({
      mode: 'fade',            // 페이드로 슬라이드 된다.
      speed:1000,              // 이동 속도를 설정합니다.
      pause: 5000,       // 슬라이드를 얼마나 멈추고, 이동할지 설정
      moveSlides:1,         // 슬라이드 이동시 갯수 설정.
      auto:true,             // 자동으로 흐를지 설정합니다.
      autoHover:false,    // 마우스 오버시 정시킬지 설정합니다.
      controls:false,        // 이전 다음 버튼 노출 여부 설정합니다
      pager: false,     //현재 위치를 나타내는 볼릿버튼 유무여부
});  
});
  </script>

 </head>

 <body>

<div id="wrap">

<div id="Slider">
<ul class="visualSlider">
  <li><div class="visualImg visualImg01"></div></li>
  <li><div class="visualImg visualImg02"></div></li>
  <li><div class="visualImg visualImg03"></div></li>
</ul>
</div>

<section id="sstBtnBox">
<div class="sstBtnBoxInner">

<ul class="sstBtn">
  <li class="sstBtnLst sstBtnLst01"><span><a href="#">CTMS</a></span>
  <ul class="sstBtnSub">
    <li class="sstBtnSubLst"><a href="#">전체</a></li>
    <li class="sstBtnSubLst"><a href="#">과제선택</a></li>
    <li class="sstBtnSubLst"><a href="#">종료과제</a></li>
  </ul> 
  </li>
  <a href="#"><li class="sstBtnLst sstBtnLst02"><span>EDC</span></li></a>
  <a href="#"><li class="sstBtnLst sstBtnLst03"><span>IWRS</span></li></a>
  <a href="#"><li class="sstBtnLst sstBtnLst04"><span>Safety DB</span></li></a>
  <a href="#"><li class="sstBtnLst sstBtnLst05"><span>DM Center</span></li></a>
  <a href="#"><li class="sstBtnLst sstBtnLst06"><span>시스템관리</span></li></a>
</ul>

</div>

</section>

</div>

 </body>
</html>
