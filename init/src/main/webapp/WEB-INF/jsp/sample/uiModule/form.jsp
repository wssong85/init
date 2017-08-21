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
  <title>Form UI Module</title>
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
                        <h3>FORM UI 모듈</h3>

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
                                <h5>FORM UI MODULE 01</h5>
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
                                            <th>텍스트</th>
                                            <td class="wd360"><input type="text" name="" id=""></td>
                                            <th>버튼(인풋)</th>
                                            <td><input type="button" value="BUTTON">
                                                <!--input type="submit" value="BUTTON">
                                                <input type="reset" value="BUTTON"-->
                                            </td>
                                            <th>체크박스</th>
                                            <td><!--input type="checkbox" name="" id=""-->
                                                <!--input type="checkbox" name="" id="" style="visibility:visible !important"-->
                                                <!--[if lt IE 9]>
                                                <![endif]-->
                                                <input type="checkbox" id="chkBox01"><label for="chkBox01" class="chcLab"><span>체크하기</span></label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>파일</th>
                                            <td><input type="file" name="" id=""></td>
                                            <th>히든(숨긴입력폼)</th>
                                            <td><input type="hidden" name=""></td>
                                            <th>이미지</th>
                                            <td><input type="image" src="../../../images/pantheon/common/imgBtn.png" alt="image"></td>
                                        </tr>

                                        <tr>
                                            <th>패스워드</th>
                                            <td><input type="password" Placeholder="Password" maxlength="13" name="" id=""></td>
                                            <th>라디오</th>
                                            <td><!--input type="radio" name="" id=""-->
                                                <!--input type="radio" name="" id="" style="visibility:visible !important"-->
                                                <!--[if lt IE 9]>
                                                <![endif]-->
                                                <input type="radio" id="ra01" name="sex"><label for="ra01" class="raLab"><span>남성</span></label>
                                                <input type="radio" id="ra02" name="sex" checked><label for="ra02" class="raLab"><span>여성</span></label>
                                            </td>
                                            <th>리셋</th>
                                            <td><input type="reset" value="RESET"></td>
                                        </tr>
                                        <tr>
                                            <th>제출</th>
                                            <td><input type="submit" value="SUBMIT"></td>
                                            <th></th>
                                            <td></td>
                                            <th></th>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>

                            </article>
                            <!-- 폼리스트 메뉴 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->




                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>FORM UI MODULE 02</h5>
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
                                            <th>색상(사용x)</th>
                                            <td class="wd360"><input type="color" value="#7e92e9" name="" id=""></td>
                                            <th>일선택(사용x)</th>
                                            <td><input type="date" name="" id="" height="50px"></td>
                                            <th>날짜선택(사용x)</th>
                                            <td><input type="datetime-local" name="" id=""></td>
                                        </tr>

                                        <tr>
                                            <th>이메일</th>
                                            <td><input type="email" Placeholder="Email" name="" id=""></td>
                                            <th>월선택(사용x)</th>
                                            <td><input type="month" name="" id=""></td>
                                            <th>숫자생성(사용x)</th>
                                            <td><input type="number" min="1" max="5" value="1"></td>
                                        </tr>

                                        <tr>
                                            <th>범위선택(사용x)</th>
                                            <td><input type="range" min="1" max="5" name="" id=""></td>
                                            <th>검색어입력</th>
                                            <td><input type="search" Placeholder="Search" name="" id=""> <button class="oneBtn" type="sumit"><img class="oneBtnIco" src="../../../images/pantheon/common/searchIco.png" alt="검색"></button>
                                            </td>
                                            <th>전화번호입력</th>
                                            <td><input type="tel" Placeholder="Tel" name="" id=""></td>
                                        </tr>
                                        <tr>
                                            <th>시간선택(사용x)</th>
                                            <td><input type="time" name="" id=""></td>
                                            <th>URL주소입력</th>
                                            <td><input type="url" Placeholder="Url" name="" id=""></td>
                                            <th>주선택(사용x)</th>
                                            <td><input type="week" name="" id=""></td>
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
                                <h5>FORM UI MODULE 03</h5>
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
                                            <th>셀렉트박스</th>
                                            <td class="wd360">
                                                <select>
                                                <option value="" selected="selected">rows 선택</option>
                                                    <option value="10">rows 10</option>
                                                    <option value="20">rows 20</option>
                                                    <option value="30">rows 30</option>
                                                    <option value="40">rows 40</option>
                                                    <option value="50">rows 50</option>
                                                    <option value="60">rows 60</option>
                                                    <option value="70">rows 70</option>
                                                    <option value="80">rows 80</option>
                                                    <option value="90">rows 90</option>
                                                    <option value="100">rows 100</option>
                                                </select>
                                            </td>
                                            <th>버튼</th>
                                            <td class="wd360">
                                                <button type="sumit">버튼</button>
                                            </td>
                                            <th>결과값(사용x)</th>
                                            <td>
                                                <form oninput="x.value=parseInt(a.value)+parseInt(b.value)">
                                                    <input type="number" id="a" value="50"> + <input type="number" id="b" value="50"> = <output name="x" for="a b"></output>
                                                </form>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>텍스트박스</th>
                                            <td>
                                                <textarea name="" id="" cols="30" rows="3"></textarea>
                                            </td>
                                            <th>텍스트 값리스트</th>
                                            <td>
                                                <input type="text" list="mobileOS">
                                                <datalist id="mobileOS">
                                                <option value="iOS"></option>
                                                <option value="Android"></option>
                                                <option value="windows"></option>
                                                <option value="Tizen"></option>
                                            </datalist>
                                            </td>
                                            <th>진행상태(사용x)</th>
                                            <td><progress value="10" max="100"></progress> 10%</td>
                                        </tr>

                                        <tr>
                                            <th>값차지(사용x)</th>
                                            <td><meter value- "10" max="100" low="" high="" optimum=""></meter> 10%</td>
                                            <th>키젠(사용x)</th>
                                            <td><keygen name=""></td>
                                            <th></th>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <th></th>
                                            <td></td>
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

                </div>
</body>

</html>