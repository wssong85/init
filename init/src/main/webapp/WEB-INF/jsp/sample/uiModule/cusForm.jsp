<%@page pageEncoding="UTF-8"%> 

<!DOCTYPE HTML>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=IE9" charset="utf-8">
  <title>cusForm UI Module</title>
  <link rel="shortcut icon" href="../../../images/pantheon/common/favicon.ico">
  <link rel="stylesheet" href="../../../css/pantheon/common/reset.css">
  <link rel="stylesheet" href="../../../css/pantheon/common/sub.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/layout.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/common.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/contents.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/theme.css" > 
  <link rel="stylesheet" href="../../../css/pantheon/common/jquery-ui.css" > 
  <script src="../../../js/pantheon/common/jquery-1.11.3.min.js"></script>
  <script src="../../../js/pantheon/common/jquery-ui.min.js"></script>
  <script src="../../../js/pantheon/common/jquery.mobile-events.js"></script>
  <script src="../../../js/pantheon/common/common.js"></script>
  <script src="../../../js/pantheon/common/theme.js"></script>
  <script src="../../../js/pantheon/common/layout.js"></script>
  <script src="../../../js/pantheon/common/sub.js"></script>
  <!--[if lt IE 9]>
  <script src="../../../js/pantheon/common/html5shiv.js"></script>
  <script src="../../../js/pantheon/common/PIE.js"></script>
  <script src="../../../js/pantheon/common/respond.min.js"></script>
  <script src="https://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
  <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js"></script>
  <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
  <![endif]-->

 </head>

<body>

<div id="wrap">

    <%@include file="../topHeader.jsp"%>

        <%@include file="../lnb.jsp"%>

            <section id="mainCon">
                <div class="mainConInner">

                    <article class="mainTitBox">
                        <h3>CusFORM UI 모듈</h3>

                        <nav id="pathNav">
                            <ul>
                                <li>
                                    <a><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a>
                                </li>
                                <li><a>Module</a></li>
                            </ul>
                        </nav>
                    </article>


                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">
                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>FORM UI</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 테이블 오른쪽 메뉴 시작-->
                            <form class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </form>
                            <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            <!-- 폼리스트 시작 -->
                            <article class="mgT16">

                                <table class="tb02">
                                    <tbody>
                                        <tr>
                                            <th>Q,E버튼</th>
                                            <td class="wd360"><input class="oneBtn" type="button" value="Q">
                                                <input class="oneBtn" type="button" value="E"></td>
                                            <th>검색</th>
                                            <td class="wd360">
                                                <button class="oneBtn" type="sumit"><img class="oneBtnIco" src="../../../images/pantheon/common/searchIco.png" alt="검색"></button>
                                            </td>
                                            <th>다운로드</th>
                                            <td>
                                                <button class="oneBtn cirBtn" type="sumit"><img class="oneBtnIco" src="../../../images/pantheon/common/downIco.png" alt="다운로드"></button>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>날짜입력</th>
                                            <td>
                                                <div class="dateBox"><input type="text" class="datePicker datePicker01" /></div>
                                                <span> ~ </span>
                                                <div class="dateBox"><input type="text" class="datePicker datePicker02" /></div>
                                            </td>
                                            <th>숫자생성</th>
                                            <td><input class="spinner"></td>
                                            <th>팝업</th>
                                            <td><button class="oneBtn" type="sumit"><img class="oneBtnIco" src="../../../images/pantheon/common/winIco.png" alt="팝업"></button>
                                            <div class="menuPop"></div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>파일</th>
                                            <td>
                                                <div class="fileInputArea">
                                                    <input type="text" id="fileName" readonly="readonly">
                                                    <input type="button" value="파일 선택" class="fileInputBtn" />
                                                    <input type="file" class="fileIuputHid" />
                                                </div>
                                                <!--input type="file" class="fileIuputHid" onchange="javascript: document.getElementById('fileName01').value = this.value /*this.parentNode('.fileInputArea').children('#fileName01') = this.value*/ " /-->
                                            </td>


                                            <th>진행상태(小)</th>
                                            <td>
                                                <div class="progBarBg progBarBg01">
                                                    <div class="progBar progBar01 wd50p"></div>
                                                </div>
                                                <!-- wd1p(위드값1%) ~ wd100p(위드값 100%) -->
                                                <!--ul id="prog">
                                                <li class="progLst">
                                                <div class="progBarBg">
                                                <div class="progBar wd65p"></div>
                                                </div>
                                                </li>
                                                </ul-->
                                            </td>
                                            <th>폴더</th>
                                            <td>
                                                <img src="../../../images/pantheon/common/folderIco02.png" alt="폴더">
                                                <!--button class="oneBtn cirBtn" type="sumit"><img class="oneBtnIco" src="../../../images/pantheon/common/folderIco.png" alt="폴더"></button-->
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>큰화살표</th>
                                            <td>
                                                <div class="cirArrow cirArrowR"></div>
                                                <div class="cirArrow cirArrowL"></div>
                                                <div class="cirArrow cirArrowT"></div>
                                                <div class="cirArrow cirArrowB"></div>
                                            </td>
                                            <th>진행상태(大)</th>
                                            <td>
                                                <div class="progBarBg progBarBg02">
                                                    <div class="progBar progBar02 wd29p"></div>
                                                </div>
                                            </td>
                                            <th>결재라인
                                                <div class="tbSubTit">prepared by</div>
                                            </th>
                                            <td>
                                                <input class="txtLine" type="text" name="" id="" value="000">
                                                <div class="txtSubDesc">성명 <i>Name</i> / 서명 <i>Signnature</i></div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>라벨인풋</th>
                                            <td>
                                                <label>제목: <input type="text"></label>
                                                <!--label for="form01">제목: </label><input type="text" id="form01"-->
                                            </td>
                                            <th>작은화살표</th>
                                            <td><input class="oneBtn" type="button" value="▲">
                                                <input class="oneBtn" type="button" value="▼">
                                                <input class="oneBtn" type="button" value="◀">
                                                <input class="oneBtn" type="button" value="▶">
                                            </td>
                                            <th>SAFETY 아이콘</th>
                                            <td>
                                                <div class="signIco signIco02 white"></div>
                                                <div class="signIco signIco02 red"></div>
                                                <div class="signIco signIco02 yellow"></div>
                                                <div class="signIco signIco02 green"></div>
                                                <div class="signIco signIco02 black"></div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>CDMS 아이콘</th>
                                            <td>
                                                <div class="signIco signIco01 grayLine"></div>
                                                <div class="signIco signIco01 white"></div>
                                                <div class="signIco signIco01 green"></div>
                                                <div class="signIco signIco01 red"></div>
                                                <div class="signIco signIco01 yellow"></div>
                                                <div class="signIco signIco01 gray"></div>
                                                <div class="signIco signIco01 green"><img src="../../../images/pantheon/common/signIco01Ck.png" alt=""></div>
                                                <div class="signIco signIco01 green"><img src="../../../images/pantheon/common/signIco01Sta.png" alt=""></div>
                                                <div class="signIco signIco01 green"><img src="../../../images/pantheon/common/signIco01Sc.png" alt=""></div>
                                                <div class="signIco signIco01 green"><img src="../../../images/pantheon/common/signIco01Lock.png" alt=""></div>
                                                <div class="signIco signIco01 green"><img src="../../../images/pantheon/common/signIco01Bl.png" alt=""></div>
                                                <div class="signIco signIco01 green"><img src="../../../images/pantheon/common/signIco01S.png" alt=""></div>
                                            </td>
                                            <th>CDMS메뉴아이콘</th>
                                            <td>
                                                <div class="signIco signIco01 grayLine sm"></div>
                                                <div class="signIco signIco01 white sm"></div>
                                                <div class="signIco signIco01 green sm"></div>
                                                <div class="signIco signIco01 red sm"></div>
                                                <div class="signIco signIco01 yellow sm"></div>
                                                <div class="signIco signIco01 gray sm"></div>
                                                <div class="signIco signIco01"><img src="../../../images/pantheon/common/signIco01Ck_sm.png" alt=""></div>
                                                <div class="signIco signIco01"><img src="../../../images/pantheon/common/signIco01Sta_sm.png" alt=""></div>
                                                <div class="signIco signIco01"><img src="../../../images/pantheon/common/signIco01Sc_sm.png" alt=""></div>
                                                <div class="signIco signIco01"><img src="../../../images/pantheon/common/signIco01Lock_sm.png" alt=""></div>
                                                <div class="signIco signIco01"><img src="../../../images/pantheon/common/signIco01Bl_sm.png" alt=""></div>
                                                <div class="signIco signIco01"><img src="../../../images/pantheon/common/signIco01S_sm.png" alt=""></div>
                                            </td>
                                            <th>아코디언버튼</th>
                                            <td>
                                                <input class="acdBtn" type="button" value="ABOTTON">
                                            </td>
                                        </tr>

                                                                                <tr>
                                            <tr>
                                            <th>클릭변경버튼</th>
                                            <td><input class="btnCl btnCl_on" type="button" value="BUTTON"></td>
                                            <th></th>
                                            <td></td>
                                            <th></th>
                                            <td></td>
                                        </tr>

                                    </tbody>
                                </table>

                            </article>
                            <!-- 폼리스트 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->


                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>FORM UI GROUP</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->



                            <!-- 상단 오른쪽 메뉴 시작-->
                            <form class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </form>
                            <!-- 상단 오른쪽 메뉴 끝-->


                            <!-- 폼리스트 시작 -->
                            <article class="mgT16">
                                <!-- mgT은 위로 55px을 띄운다는것 1부터 100까지는 1단위, 100부터 1000까지는 10단위
                                 주로 타이틀이나 메뉴 밑에 부분은 mgT16 mgT55 mgT43을 사용한다-->

                                <form action="">
                                    <fieldset>
                                        <!--legend>로그인 정보</legend-->

                                        <table class="tb02">
                                            <tbody>
                                                <tr>
                                                    <th><label for="nameT">이름</label></th>
                                                    <td class="wd360"><label><input type="text" id="nameT"> 4자 이하</label></td>
                                                    <th><label for="oHomeT">고향</label></th>
                                                    <td><input type="text" id="oHomeT"></td>
                                                    <th><label for="nNameT">닉네임</label></th>
                                                    <td><input type="text" id="nNameT"></td>
                                                </tr>

                                                <tr>
                                                    <th><label for="idT">아이디</label></th>
                                                    <td class="wd360"><label><input type="text" id="idT"> 5자 이상 6자 이하</label></td>
                                                    <th><label for="passT">비밀번호</label></th>
                                                    <td><input type="password" id="passT"></td>
                                                    <th><label for="passCkT">비밀번호확인</label></th>
                                                    <td><input type="password" id="passCkT"></td>
                                                </tr>

                                            </tbody>
                                        </table>

                                    </fieldset>
                                </form>

                            </article>
                            <!-- 폼리스트 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->


                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>FORM UI PROPERTIES</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->



                            <!-- 상단 오른쪽 메뉴 시작-->
                            <form class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </form>
                            <!-- 상단 오른쪽 메뉴 끝-->



                            <!-- 폼리스트 시작 -->
                            <article class="mgT16">
                                <!-- mgT은 위로 55px을 띄운다는것 1부터 100까지는 1단위, 100부터 1000까지는 10단위
                                 주로 타이틀이나 메뉴 밑에 부분은 mgT16 mgT55 mgT43을 사용한다-->


                                <table class="tb02">
                                    <tbody>

                                        <tr>
                                            <th>읽기전용</th>
                                            <td><input type="text" name="" id="" readonly></td>
                                            <th>힌트표기</th>
                                            <td><input type="text" name="" id="" placeholder="숫자만입력"></td>
                                            <th>자동완성</th>
                                            <td><input type="text" name="" id="" autocomplete="on"></td>
                                        </tr>

                                        <tr>
                                            <th>필수필드</th>
                                            <td><input type="text" name="" id="" required></td>
                                            <th>입력커서표기</th>
                                            <td><input type="text" name="" id="" autofocus></td>
                                            <th>사이즈,문자개수</th>
                                            <td><input type="text" name="" id="" size="" min="" max="" maxlengh=""></td>
                                        </tr>

                                    </tbody>
                                </table>

                            </article>
                            <!-- 폼리스트 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->

                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>FORM UI PROG</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->



                            <!-- 상단 오른쪽 메뉴 시작-->
                            <form class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </form>
                            <!-- 상단 오른쪽 메뉴 끝-->


                            <!-- 폼리스트 시작 -->
                            <article class="mgT16">
                                <!-- mgT은 위로 55px을 띄운다는것 1부터 100까지는 1단위, 100부터 1000까지는 10단위
                                 주로 타이틀이나 메뉴 밑에 부분은 mgT16 mgT55 mgT43을 사용한다-->

                               
                                <table class="tb04">

                                    <thead>
                                        <tr>
                                            <th class="wd5Pct">Visit</th>
                                            <th>1</th>
                                            <th>2</th>
                                            <th>3</th>
                                            <th>4</th>
                                            <th>5</th>
                                            <th>6</th>
                                            <th>7</th>
                                            <th>8</th>
                                            <th>9</th>
                                            <th>10</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <th>V1</th>
                                            <td></td>
                                            <td>
                                                <div class="tdProgBg02"></div>
                                            </td>
                                            <td>
                                                <div class="tdProgBg02"></div>
                                            </td>
                                            <td>
                                                <div class="tdProgBg02"></div>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>

                                        <tr>
                                            <th>V2</th>
                                            <td></td>
                                            <td></td>
                                            <td>
                                                <div class="tdProgBg02"></div>
                                            </td>
                                            <td>
                                                <div class="tdProgBg02"></div>
                                            </td>
                                            <td>
                                                <div class="tdProgBg02"></div>
                                            </td>
                                            <td>
                                                <div class="tdProgBg02"></div>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>

                                         <tr>
                                            <th>V2</th>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td class="tdProgBg01"></td>
                                            <td class="tdProgBg01"></td>
                                            <td class="tdProgBg01"></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>

                                </table>


                            </article>
                            <!-- 테이블 끝 -->

                            </article>
                            <!-- 폼리스트 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->


                </div>
</body>

</html>