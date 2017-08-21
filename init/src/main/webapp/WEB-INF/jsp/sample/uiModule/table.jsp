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
  <title>Table Module</title>
  <link rel="shortcut icon" href="../../../images/pantheon/common/favicon.ico">
  <link rel="stylesheet" href="../../../css/pantheon/common/reset.css">
  <link rel="stylesheet" href="../../../css/pantheon/common/sub.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/layout.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/common.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/contents.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/theme.css" >
  <link rel="stylesheet" href="../../../css/pantheon/common/jquery-ui.css" >  
  <script src="../../../js/pantheon/common/jquery-2.1.1.js"></script>
  <script src="../../../js/pantheon/common/jquery-ui.min.js"></script>
  <script src="../../../js/pantheon/common/jquery.mobile-events.js"></script>
  <script src="../../../js/pantheon/common/common.js"></script>
  <script src="../../../js/pantheon/common/theme.js"></script>
  <script src="../../../js/pantheon/common/layout.js"></script>
  <script src="../../../js/pantheon/common/sub.js"></script>
  <!--[if lt IE 9]>
  <script src="../../../js/pantheon/common/jquery-1.11.3.min.js"></script>
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
                        <h3>테이블 UI 모듈</h3>

                        <nav id="pathNav">
                            <ul>
                                <li>
                                    <a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a>
                                </li>
                                <li><a href="#">Module</a></li>
                            </ul>
                        </nav>
                    </article>


                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>TABLE UI MODULE 01</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 타이틀 전체메뉴라인 시작-->
                            <article class="conTitBtn">

                                <!-- 상단 테이블 왼쪽 메뉴 시작 -->
                                <div class="conTitBtnL">
                                    <select id="dataFieldSelect">
                                <option value="name" selected="selected">name</option>
                                <option value="contry">Country</option>
                                <option value="product">Product</option>
                                <option value="quantity">Quantity</option>
                                <option value="price">Price</option>
                                <option value="date">Date</option>
                            </select>
                                    <input type="text" id="myInput" value="신규임상" class="pdR15"><input type="button" class="btn mgL3" value="검색">
                                </div>
                                <!-- 상단 테이블 왼쪽 메뉴 끝 -->

                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
                                <div class="conTitBtnR">
                                    <input type="button" value="최상단 행추가">
                                    <input type="button" value="선택행 삭제">
                                    <input type="button" value="저장">
                                </div>
                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            </article>
                            <!-- 상단 타이틀 전체메뉴라인 끝-->

                            <!-- 테이블 시작 -->
                            <article class="mgT55">

                                <table class="tb01">
                                    <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>내용</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>

                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>

                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>

                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>
                                    </tbody>

                                </table>

                            </article>
                            <!-- 테이블 끝 -->

                        </div>

                    </section>
                    <!-- 컨텐츠박스 끝-->




                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>TABLE UI MODULE 02</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 테이블 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            <!-- 테이블 시작 -->
                            <article class="mgT16">

                            <!-- 테이블 크기 조절 
                            가로길이px값 (클래스 wd0부터 wd100까지 100이후부터 1000까지는 10단위)
                            가로길이퍼센트값 (wd5Pct부터 wd100Pct까지 5단위)
                            세로길이px & 세로길이 퍼센트값 가로와 내용 같음 (wd를 hei로만 바꿈)
                            -->

                                <table class="tb01">
                                    <thead>
                                        <tr>
                                            <th class="wd40">번호</th>
                                            <th class="wd20Pct">제목</th>
                                            <th>내용</th>
                                            <th class="wd90">작성자</th>
                                            <th class="wd90">작성일</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>

                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>

                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>

                                        <tr>
                                            <td>212</td>
                                            <td>신규임상</td>
                                            <td>신규임상과제 등록 완료</td>
                                            <td>관리자</td>
                                            <td>2015.12.07</td>
                                        </tr>
                                    </tbody>
                                </table>

                            </article>
                            <!-- 테이블 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->




                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>TABLE UI MODULE 03</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 테이블 전체메뉴라인 시작-->
                            <article class="conTitBtn">

                                <!-- 상단 테이블 왼쪽 메뉴 시작 -->
                                <div class="conTitBtnL">
                                    <select id="dataFieldSelect">
                                <option value="name" selected="selected">name</option>
                                <option value="contry">Country</option>
                                <option value="product">Product</option>
                                <option value="quantity">Quantity</option>
                                <option value="price">Price</option>
                                <option value="date">Date</option>
                            </select>
                                    <input type="text" id="myInput" value="신규임상" class="pdR15"><input type="button" class="btn mgL3" value="검색">
                                </div>
                                <!-- 상단 테이블 왼쪽  메뉴 끝 -->

                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
                                <div class="conTitBtnR">
                                    <input type="button" value="최상단 행추가">
                                    <input type="button" value="선택행 삭제">
                                    <input type="button" value="저장">
                                </div>
                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            </article>
                            <!-- 상단 테이블 전체메뉴라인 끝-->

                            <!-- 테이블 시작 -->
                            <article class="mgT55">

                                <table class="tb02">

                                    <tbody>
                                        <tr>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                        </tr>

                                        <tr>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                        </tr>

                                        <tr>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td colspan="3">내용</td>
                                        </tr>
                                    </tbody>

                                </table>


                            </article>
                            <!-- 테이블 끝 -->

                        </div>

                    </section>
                    <!-- 컨텐츠박스 끝-->



                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>TABLE UI MODULE 04</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 테이블 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            <!-- 테이블 시작 -->
                            <article class="mgT16">

                                <table class="tb02">

                                    <tbody>
                                        <tr>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                        </tr>

                                        <tr>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td>내용</td>
                                        </tr>

                                        <tr>
                                            <th>제목</th>
                                            <td>내용</td>
                                            <th>제목</th>
                                            <td colspan="3">내용</td>
                                        </tr>
                                    </tbody>

                                </table>

                            </article>
                            <!-- 테이블 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->



                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>TABLE UI MODULE 05</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 테이블 전체메뉴라인 시작-->
                            <article class="conTitBtn">

                                <!-- 상단 테이블 왼쪽 메뉴 시작 -->
                                <div class="conTitBtnL">
                                    <select id="dataFieldSelect">
                                <option value="name" selected="selected">name</option>
                                <option value="contry">Country</option>
                                <option value="product">Product</option>
                                <option value="quantity">Quantity</option>
                                <option value="price">Price</option>
                                <option value="date">Date</option>
                            </select>
                                    <input type="text" id="myInput" value="신규임상" class="pdR15"><input type="button" class="btn mgL3" value="검색">
                                </div>
                                <!-- 상단 테이블 왼쪽  메뉴 끝 -->

                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
                                <div class="conTitBtnR">
                                    <input type="button" value="최상단 행추가">
                                    <input type="button" value="선택행 삭제">
                                    <input type="button" value="저장">
                                </div>
                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            </article>
                            <!-- 상단 테이블 전체메뉴라인 끝-->

                            <!-- 테이블 시작 -->
                            <article class="mgT55">

                                <table class="tb03">

                                    <thead>
                                        <tr>
                                            <th class="wd5Pct">Visit</th>
                                            <th>제목</th>
                                            <th>제목</th>
                                            <th>제목</th>
                                            <th>제목</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <th>V1</th>
                                            <td rowspan="3">내용</td>
                                            <td>내용</td>
                                            <td>내용</td>
                                            <td>내용</td>
                                        </tr>

                                        <tr>
                                            <th>V2</th>
                                            <td>내용</td>
                                            <td>내용</td>
                                            <td>내용</td>

                                        </tr>
                                    </tbody>

                                </table>


                            </article>
                            <!-- 테이블 끝 -->

                        </div>

                    </section>
                    <!-- 컨텐츠박스 끝-->



                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>TABLE UI MODULE 06</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 테이블 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            <!-- 테이블 시작 -->
                            <article class="mgT16">

                                <table class="tb03_2">

                                    <thead>
                                        <tr>
                                            <th class="wd5Pct">Visit</th>
                                            <th>제목</th>
                                            <th>제목</th>
                                            <th>제목</th>
                                            <th>제목</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <tr>
                                            <th>V1</th>
                                            <td rowspan="3">내용</td>
                                            <td>내용</td>
                                            <td>내용</td>
                                            <td>내용</td>
                                        </tr>

                                        <tr>
                                            <th>V2</th>
                                            <td>내용</td>
                                            <td>내용</td>
                                            <td>내용</td>
                                        </tr>
                                    </tbody>

                                </table>

                            </article>
                            <!-- 테이블 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->


                </div>
            </section>

</div>

</body>

</html>