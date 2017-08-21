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
  <title>Login</title>
  <link rel="shortcut icon" href="../../images/pantheon/common/favicon.ico">
  <link rel="stylesheet" href="../../css/pantheon/common/reset.css">
  <link rel="stylesheet" href="../../css/pantheon/common/login.css"> 
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
  <script src="../../js/pantheon/common/login.js"></script>
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

<section id="loginWrap">
  
  <img class="loginLogo" src="../../images/pantheon/common/logoB.png" alt="">

  <div class="loginLagSel">한국어(Korean) <img class="mgL3" src="../../images/pantheon/common/LoginLagSelArrow.png" alt="">
<ul class="loginLagSelSub">
  <div class="arrow01"></div>
    <li class="loginLagSelSubLst">한국어(Korean)</li>
    <li class="loginLagSelSubLst">ENGLISH</li>
    <li class="loginLagSelSubLst">日本語</li>
    <li class="loginLagSelSubLst">簡体中文</li>
    <li class="loginLagSelSubLst">繁体中文</li>
    <li class="loginLagSelSubLst">français</li>
    <li class="loginLagSelSubLst">español</li>
  </ul>

  </div>

  <article class="loginBox">
    
    <div class="loginCon">
    
      <dl class="loginConDesc">
        <dt>Member Login</dt>
        <dd>아이디와 비밀번호를 입력 후, 로그인 버튼을 클릭 해주세요.</dd>
      </dl>

<form id="loginFrm" action="">
  <fieldset class="loginFs">
   <input type="text" id="loginId" class="longinInput loginId" name="loginId" placeholder="아이디">
   <input type="text" id="loginPassword" class="longinInput loginPassword" name="loginPassword" placeholder="비밀번호">
   <input type="submit" id="loginBtn" title="로그인버튼" alt="로그인버튼" value="login">
   <div class="loginAddBtn">
   <input type="checkbox" id="chkBox01" class="loginChkBoxLab"><label for="chkBox01" class="loginChkBoxLab"><span>ID 저장하기</span></label>
   <span class="loginfind"><a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a></span>
   </div>
  </fieldset>
</form>

    </div>

    <div class="loginNtcCon">
      <dl class="loginNtcDesc">
        <dt>Notice</dt>
        <dd>공지사항입니다.</dd>
      </dl>

<button class="moreBtn02"><span>more<div class="moreArrow"></div></span></button>
<hr class="loginNtcHr">

<ul class="loginNtcUl">
  <li class="loginNtcLst">신규 임상과제등록 완료에 대한 공지 <span class="loginNtcLstDate">2015. 12. 07</span></li>
  <li class="loginNtcLst">eTraining 사용법에 대해서 정확한 설명을 위한.. <span class="loginNtcLstDate">2015. 12. 07</span></li>
  <li class="loginNtcLst">시스템 사용자 신청시 작성 서류 방법에 대한.. <span class="loginNtcLstDate">2015. 12. 07</span></li>
  <li class="loginNtcLst">시스템 자동 로그아웃 설정 방법에 대한 정보 소식<span class="loginNtcLstDate">2015. 12. 07</span></li>
  <li class="loginNtcLst">eTraining 사용법에 대해 자세한 설명은.. <span class="loginNtcLstDate">2015. 12. 07</span></li>
  <li class="loginNtcLst">시스템 사용자 신청시 작성 서류에 대한 공지 <span class="loginNtcLstDate">2015. 12. 07</span></li>
  <li class="loginNtcLst">시스템 자동 로그아웃 설정 방법.. <span class="loginNtcLstDate">2015. 12. 07</span></li>
</ul>

    </div>

  </article>

  <footer id="loginFooter">

<div class="copyright">
  Copyright 2016 CJ HealthCare. All rights reserved.
</div>

<div class="loginFnb">
<a href="#">법적고시</a> | <a href="#">이메일무단수집거부</a>
</div>

  </footer>

</section>

</div>

 </body>
</html>
