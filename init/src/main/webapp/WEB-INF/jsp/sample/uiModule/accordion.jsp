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
  <title>Accordion UI Module</title>
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
                        <h3>아코디언 메뉴 UI 모듈</h3>

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
                                <h5>ACCORDION UI MODULE 01</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 타이틀 전체메뉴라인 시작-->
                            <article class="conTitBtn">

                                <!-- 상단 왼쪽 메뉴 시작 -->
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
                                <!-- 상단 왼쪽 메뉴 끝 -->

                                <!-- 상단 오른쪽 메뉴 시작-->
                                <div class="conTitBtnR">
                                    <input type="button" value="최상단 행추가">
                                    <input type="button" value="선택행 삭제">
                                    <input type="button" value="저장">
                                </div>
                                <!-- 상단 오른쪽 메뉴 끝-->

                            </article>
                            <!-- 상단 타이틀 전체메뉴라인 끝-->

                            <!-- 아코디언 메뉴 시작 -->
                            <article class="mgT55">
                            <!-- mgT은 위로 55px을 띄운다는것 1부터 100까지는 1단위, 100부터 1000까지는 10단위
                                 주로 타이틀이나 메뉴 밑에 부분은 mgT16 mgT55 mgT43을 사용한다-->

                                <ul id="acdMenu01">

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion01</a>
                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion02</a>
                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>


                                            <!-- 2뎁스 아코디언 메뉴 시작 -->
                                            <article class="mgT16">
                                                <ul id="acdMenu02">

                                                    <!-- 2뎁스 아코디언 리스트 시작 -->
                                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close">accordion01</a>
                                                        <div class="acdMenuCts acdMenuCts02 close">

                                                            <!-- 2뎁스 아코디언 컨텐츠 시작 -->
                                                            <p>
                                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                                            </p>
                                                            <p>
                                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                                            </p>
                                                            <!-- 2뎁스 아코디언 컨텐츠 끝 -->

                                                        </div>
                                                    </li>
                                                    <!-- 2뎁스 아코디언 리스트 끝 -->

                                                </ul>
                                            </article>
                                            <!-- 2뎁스 아코디언 메뉴 끝 -->


                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion03</a>
                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>


                                            <!-- 2뎁스 아코디언03 메뉴 시작 -->
                                            <article class="mgT16">
                                                <ul id="acdMenu03">

                                                    <!-- 2뎁스 아코디언03 리스트 시작 -->
                                                    <li class="acdMenuLst acdMenuLst03"><a class="close acdMenuLst acdMenuLst03Ico"><span>accordion01</span></a>
                                                        <div class="acdMenuCts acdMenuCts03 close">

                                                            <!-- 2뎁스 아코디언03 컨텐츠 시작 -->
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
                                                            <!-- 2뎁스 아코디언03 컨텐츠 끝 -->

                                                        </div>
                                                    </li>
                                                    <!-- 2뎁스 아코디언03 리스트 끝 -->

                                                </ul>
                                            </article>
                                            <!-- 2뎁스 아코디언03 메뉴 끝 -->

                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->

                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->




                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>ACCORDION UI MODULE 02</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 테이블 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 테이블 오른쪽 메뉴 끝-->


                            <!-- 아코디언 메뉴  시작 -->
                            <article class="mgT16">
                                <ul id="acdMenu01">

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion01</a>
                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->

                                            <!-- 컨텐츠 타이틀 시작-->
                                            <article class="conTitBox">
                                                <h5>TABLE</h5>
                                            </article>
                                            <!-- 컨텐츠 타이틀 끝-->

                                            <!-- 상단 테이블 오른쪽 메뉴 시작-->
                                            <article class="conTitBtnR">
                                                <input type="button" value="CTMS">
                                                <input type="button" value="EDC">
                                                <input type="button" value="IWRS">
                                            </article>
                                            <!-- 상단 테이블 오른쪽 메뉴 끝-->

                                            <!-- 테이블 시작 -->
                                            <article class="mgT16">

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

                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->


                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion02</a>
                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->


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



                                            <!-- 테이블 시작 -->
                                            <article class="mgT43">

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


                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion03</a>
                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->

                                            <!-- 테이블 시작 -->
                                            <article>

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


                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->



                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->



                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>ACCORDION UI MODULE 03</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->


                            <!-- 상단 오른쪽 메뉴 시작-->
                            <div class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </div>
                            <!-- 상단 오른쪽 메뉴 끝-->


                            <!-- 아코디언 메뉴 시작 -->
                            <article class="mgT16">
                                <ul id="acdMenu01">

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion01</a>
                                        <!-- 아코디언 리스트바의 버튼 시작 -->
                                        <div class="acdBtnGr">
                                            <input class="acdBtn" type="button" value="DMC">
                                            <input class="acdBtn" type="button" value="CTMS">
                                            <input class="acdBtn" type="button" value="EDC">
                                            <input class="acdBtn" type="button" value="IWRS">
                                        </div>
                                        <!-- 아코디언 리스트바의 버튼 끝 -->

                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion02</a>
                                        <!-- 아코디언 리스트바의 버튼 시작 -->
                                        <form class="acdBtnGr">
                                            <input class="acdBtn" type="button" value="DMC">
                                            <input class="acdBtn" type="button" value="CTMS">
                                            <input class="acdBtn" type="button" value="EDC">
                                            <input class="acdBtn" type="button" value="IWRS">
                                        </form>
                                        <!-- 아코디언 리스트바의 버튼 끝 -->

                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>

                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst acdMenuLst01"><a class="acdMenuLik close">accordion03</a>

                                        <!-- 아코디언 리스트바의 버튼 시작 -->
                                        <div class="acdBtnGr">
                                            <input class="acdBtn" type="button" value="DMC">
                                            <input class="acdBtn" type="button" value="CTMS">
                                            <input class="acdBtn" type="button" value="EDC">
                                            <input class="acdBtn" type="button" value="IWRS">
                                        </div>
                                        <!-- 아코디언 리스트바의 버튼 끝 -->

                                        <div class="acdMenuCts acdMenuCts01 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->

                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->





                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>ACCORDION UI MODULE 04</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 타이틀 전체메뉴라인 시작-->
                            <article class="conTitBtn">

                                <!-- 상단 왼쪽 메뉴 시작 -->
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
                                <!-- 상단 왼쪽 메뉴 끝 -->

                                <!-- 상단 오른쪽 메뉴 시작-->
                                <div class="conTitBtnR">
                                    <input type="button" value="최상단 행추가">
                                    <input type="button" value="선택행 삭제">
                                    <input type="button" value="저장">
                                </div>
                                <!-- 상단 오른쪽 메뉴 끝-->

                            </article>
                            <!-- 상단 타이틀 전체메뉴라인 끝-->

                            <!-- 아코디언 메뉴  시작 -->
                            <article class="mgT55">
                                <ul id="acdMenu02">

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close">accordion01</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close">accordion02</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close">accordion03</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            <p>
                                                Praesent eget lorem vitae mauris interdum luctus convallis a nunc. Phasellus dictum placerat volutpat. Cras facilisis quam lacus, molestie bibendum nisi egestas nec. Quisque vitae velit posuere, faucibus libero a, posuere felis. Nullam sit amet ornare lectus. Etiam adipiscing elit viverra, tincidunt orci consequat, lacinia erat. Phasellus non pretium ante. Etiam faucibus arcu ut felis aliquam faucibus. Sed mattis felis vitae libero viverra, in interdum dui dictum. Integer faucibus sem massa, mollis feugiat dolor commodo eget.
                                            </p>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->

                        </div>

                    </section>
                    <!-- 컨텐츠박스 끝-->





                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>ACCORDION UI MODULE 05</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->


                            <!-- 상단 오른쪽 메뉴 시작-->
                            <div class="conTitBtnR">
                                <input type="button" value="최상단 행추가">
                                <input type="button" value="선택행 삭제">
                                <input type="button" value="저장">
                            </div>
                            <!-- 상단 오른쪽 메뉴 끝-->


                            <!-- 아코디언 메뉴 시작 -->
                            <article class="mgT16">
                                <ul id="acdMenu03">

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst03"><a class="close acdMenuLst acdMenuLst02Ico"><span>accordion01</span></a>
                                        <div class="acdMenuCts acdMenuCts03 close">

                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
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
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->

                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->

                        </div>
                    </section>
                    <!-- 컨텐츠박스 끝-->


                </div>
            </section>
            <!-- 컨텐츠박스 끝-->


</div>

</body>

</html>