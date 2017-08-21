<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false" />
<title>케이스 그래프</title>
<link rel="stylesheet" href="<c:url value='/css/pantheon/common/jquerychart/barChart.css'/>">
<script src="<c:url value='/js/pantheon/common/jquerychart/barChart.jquery.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/elychart/raphael.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/elychart/elycharts.js'/>"></script>
<script src="<c:url value='/js/pantheon/common/jquerychart/graph.js'/>"></script>
<style>
			* {
			    padding: 0;
			    margin: 0;
			    -moz-box-sizing: border-box;
			    box-sizing: border-box;
			    border: none;
			    outline: none;
			    font: normal 100% sans-serif;
			}

			html, body {
			    width: 100%;
			    height: 100%;
          		background-color:#fafafa;
			}
            h1 { margin:150px auto 30px auto; text-align:center;}
		</style>
<script type="text/javascript">
	$(function() {
		$.elycharts.templates['line_basic_6'] = {
			type : "line",
			margins : [ 10, 40, 40, 30 ],
			defaultSeries : {
				highlight : {
					newProps : {
						r : 8,
						opacity : 1
					},
					overlayProps : {
						fill : "white",
						opacity : 0.2
					}
				}
			},
			series : {
				serie1 : {
					color : "90-#003000-#009000",
					tooltip : {
						frameProps : {
							stroke : "green"
						}
					}
				},
				serie2 : {
					color : "90-#000060-#0000B0",
					tooltip : {
						frameProps : {
							stroke : "blue"
						}
					}
				},				
				serie4 : {
					color : "90-#F80C0C-#F8F40C",
					tooltip : {
						frameProps : {
							stroke : "red"
						}
					}
				},
				serie3 : {
					color : "red",
					rounded : false,
					dot : true,
					dotProps : {
						r : 0,
						stroke : "white",
						"stroke-width" : 0,
						opacity : 0
					},
					plotProps : {
						"stroke-width" : 4,
						"stroke-linecap" : "round",
						"stroke-linejoin" : "round"
					}
				}
			},
			defaultAxis : {
				labels : true
			},
			axis : {
				x : {
					labelsRotate : 45,
					labelsProps : {
						font : "12px Verdana"
					}
				}
			},
			features : {
				grid : {
					draw : true,
					forceBorder : true,
					ny : 5
				}
			},
			barMargins : 10
		}
		
		$("#chart").chart({
			 template : "line_basic_6",
			 tooltips : {
			  serie1 : ["a", "b", "c", "d"],
			  serie2 : ["a", "b", "c", "d"],
			  serie3 : ["a", "b", "c", "d"]
			 },
			 values : {
			  serie1 : [39, 67, 1, 4,39, 67, 1, 4,39, 67, 1, 4],
			  serie2 : [27, 32, 56, 19,27, 32, 56, 19,27, 32, 56, 19],
			  serie4 : [22, 11, 55, 33,22, 11, 2, 5,77, 11, 22, 55],
			  serie3 : [62, 34, 61, 56,62, 34, 61, 56,62, 34, 61, 56]
			 },
			 labels : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월","12월"],
			 defaultSeries : {
			  type : "bar",
			  stacked : true
			 },
			 series : {
			  serie3 : {
			   type : "line",
			   stacked : false,
			   axis : "r"
			  }
			 },
			 axis : {
			  r : {
			   max : 100,
			   suffix : "%"
			  }
			 }
			});
		
		
		 $('#graph').graphify({
	          //options: true,
	          start: 'combo',
	          obj: {
	              id: 'ggg',
	              width: "100%",
	              height: 375,
	              xGrid: false,
	              legend: true,
	              title: 'Linux vs Mac',
	              points: [
							[7, 26, 33, 74, 12, 49, 33, 33, 74, 12, 49, 3],
							[32, 46, 75, 38, 62, 20, 52, 75, 38, 62, 20, 5]
						  ],
	              pointRadius: 3,
	              colors: ['blue', 'red'],
	              xDist: 90,
	              dataNames: ['Linux', 'Mac'],
	              xName: 'Day',
	              animations: true,
	              pointAnimation: true,
	              averagePointRadius: 10,
	              design: {
	                  tooltipColor: '#fff',
	                  gridColor: 'grey',
	                  tooltipBoxColor: 'green',
	                  averageLineColor: 'green',
	                  pointColor: 'green',
	                  lineStrokeColor: 'grey',
	              }
	          }
	      });
		 
		 $('#stack').barChart({
				height : 500,
				bars : [
					{ 
						name : 'Dataset 1',
						values : [["1월",40],["2월",30],["3월",15],["4월",75],["5월",129],["6월",3.3],["7월",57],["8월",50],["9월",30],["10월",31],["11월",24],["12월",24]] 
					},{ 
						name : 'Dataset 2',
						values : [["1월",45],["2월",33],["3월",49],["4월",25],["5월",29],["6월",33],["7월",5.7],["8월",50],["9월",30],["10월",10],["11월",24],["12월",24]] 
					}
					,{ 
						name : 'Dataset 3',
						values : [["1월",20],["2월",33],["3월",49],["4월",25],["5월",59],["6월",33],["7월",10.5],["8월",26],["9월",11],["10월",2],["11월",21],["12월",30]] 
					}
				]
			});

	});
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 호출 -->
		<c:import
			url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBE0305&UPPER_MENU_ID=SDBE"
			charEncoding="utf-8" />
		<!-- 레프트 호출 -->
		<c:import
			url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBE0305&UPPER_MENU_ID=SDBE"
			charEncoding="utf-8" />
		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>케이스 리포트</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>System Master File</li>
							<li>케이스 그래프</li>
						</ul>
					</nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<!-- 상단 그리드 전체메뉴라인 시작-->
						<article class="conGridUpper">
							<div class="conTitBtnL">
								<select id="slyear">
									<option value=''>=년도=</option>
									<option value='2013'>2013</option>
									<option value='2014'>2014</option>
									<option value='2015'>2015</option>
									<option value='2016'>2016</option>
								</select> <select id="slmonth">
									<option value=''>=전체/월=</option>
									<option value='1'>1</option>
									<option value='2'>2</option>
									<option value='3'>3</option>
									<option value='4'>4</option>
									<option value='5'>5</option>
									<option value='6'>6</option>
									<option value='7'>7</option>
									<option value='8'>8</option>
									<option value='9'>9</option>
									<option value='10'>10</option>
									<option value='11'>11</option>
									<option value='12'>12</option>
								</select> <select id="slreport_date">
									<option value=''>=전체=</option>
									<option value='01'>인지일</option>
									<option value='02'>보고일</option>
								</select>
								<input type="button" class="btn mgL10" id="btnSearch" value="검색">
							</div>
							<div class="conTitBtnR">
								<input type="button" id="btnEmail" value="Email전송내역">
								<input type="button" id="btnExcel" value="엑셀">
							</div>

						</article>
						<!-- 상단 그리드 전체메뉴라인 끝-->

						<!-- 그리드 시작 -->
						<article class="mgT55">
							<div id="chart"></div>
							<br/>
							<div id="graph"></div>
							<br/>
							<div id="stack"></div>
							<br/><br/><br/><br/>




						</article>
					
					</div>

				</section>
			</div>
		</section>
	</div>
</body>
</html>