<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>


<title>메인</title>
<script>

var testData =[
{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
}, {
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"


}];


var myGridOption = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap',
    paging: {
      pagingDiv: 'grid_paging',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    //페이징 true, false 로 지정
    paging: true,
    //처음 시작시 데이터 로딩
    autoLoad: true,
  },
  //AUI 그리드 옵션
  gridPros: {
    // 페이징 사용
    //usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    //showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",
    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
	filter : {
		showIcon : true
	},
    width : 200
  },{
    dataField : "NAME",
    headerText : "NAME",
    width : 200
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],


  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
    if(me.proxy.autoLoad) {
      me.load();
    }

    //me.createPagingNavigator(1);
  },
  //AUI 그리드 이벤트 
  binding: function() {
    
  },
  //AUI 그리드 데이터 요청
  load: function(v1, v2) {
    var me = this;
    
    //AUIGrid.showAjaxLoader(me.id);
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    me.createPagingNavigator(me.div.paging.currentPage);

  },
  //사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
  createPagingNavigator: function(goPage) {
    var me = this;
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    this.div.paging.totalPage = Math.ceil(this.div.paging.totalRowCount/this.div.paging.rowCount);
    
    var retStr = "";
    var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * ( me.div.paging.pageButtonCount /*-3*/);
    var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount +1 ;
    prevPage = Math.max(0,prevPage );
    nextPage = Math.min(nextPage, me.div.paging.totalPage);
    if ( goPage == 0 ) { prevPage.stop() }



    //셀렉트박스
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption.div.paging.currentPage, this.value)'>"
    if(myGridOption.div.paging.rowCount == 20) {
      retStr += "<option value=20 selected=true>rows 20</option>"
    } else {
      retStr += "<option value=20>rows 20</option>"
    }
    if(myGridOption.div.paging.rowCount == 50) {
      retStr += "<option value=50 selected=true>rows 50</option>"
    } else {
      retStr += "<option value=50>rows 50</option>"
    }
    if(myGridOption.div.paging.rowCount == 100) {
      retStr += "<option value=100 selected=true>rows 100</option>"
    } else {
      retStr += "<option value=100>rows 100</option>"
    }
    if(myGridOption.div.paging.rowCount == 300) {
      retStr += "<option value=300 selected=true>rows 300</option>"
    } else {
      retStr += "<option value=300>rows 300</option>"
    }
    if(myGridOption.div.paging.rowCount == 500) {
      retStr += "<option value=500 selected=true>rows 500</option>"
    } else {
      retStr += "<option value=500>rows 500</option>"
    }
    retStr += "</select>"

    
	// 처음
	retStr += "<span class='aui-grid-paging-grup'>";
	retStr += "<a href='javascript:myGridOption.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";
	// 이전
	retStr += "<a href='javascript:myGridOption.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";

	for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage); i<=len; i++) {
		if (goPage == i) {
			retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
		} else {
			retStr += "<a href='javascript:myGridOption.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
			retStr += i;
			retStr += "</span></a>";
		}
		if (i >= me.div.paging.totalPage) {
			break;
		}
	}

	// 다음
	retStr += "<a href='javascript:myGridOption.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
	// 마지막
	retStr += "<a href='javascript:myGridOption.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>";
	retStr += "</span>";

    //el식 테스트
    document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
  },
  //페이징 에서 어느 페이지로 갈 것인지 지정
  moveToPage: function(goPage, rowCount) {
    var me = this;
    
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    // 현재 페이지 보관
    me.div.paging.currentPage = goPage ;
    
    // selectBox에서 요청시, 1페이지부터 시작
    if(rowCount) {
      me.div.paging.rowCount = rowCount;
      me.div.paging.currentPage = 1;
      goPage = 1;
    }
    
    me.load(me.div.paging.rowCount, goPage);
  }
};


$(document).ready(function() {
  myGridOption.createGrid();
});


window.onresize = function() {
 if (typeof myGridOption.id !== "undefined") {
   AUIGrid.resize(myGridOption.id);
   }
};
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />
<c:import url="/com/lnb.do?MODULE_CODE=EDC&MENU_ID=EDCC0106&UPPER_MENU_ID=EDCC" charEncoding="utf-8" />



	<section id="mainCon">
		<div class="mainConInner2">




            <section class="conBox100 conBox">
                <div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>Study Status</h5>
                    </article>
                    <article class="conTitBtnR">
                        <input type="button" id="" value="EDIT" />
                    </article>
                    <article class="mgT16">
                        <div id="" class="gridHeiSz10 grid_wrap tb01_2"></div>
                        <div id="" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                </div>
            </section>





            <section class="conBox_left_01">
                <div class="conBoxInner2">
                    <article class="calendar">
						<div class="calendar_head_01">
							December 2015
							<a href="#void" class="cal_prev"></a>
							<a href="#void" class="cal_next"></a>
						</div>
						<table class="calendar_body_01">
							<colgroup>
								<col width="">
								<col width="14.28%">
								<col width="14.28%">
								<col width="14.28%">
								<col width="14.28%">
								<col width="14.28%">
								<col width="14.28%">
							</colgroup>
							<thead>
								<tr>
									<th>Su</th>
									<th>Mo</th>
									<th>Tu</th>
									<th>We</th>
									<th>Th</th>
									<th>Fr</th>
									<th>Sa</th>
								</tr>
							</thead>
							<tbody class="cal_day_01">
								<tr>
									<td>
										<div class="cal_cell">
											<a href="#void" class="plan_01">30
												<div class="cal_detail">일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용일정내용</div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="plan_01">1
												<div class="cal_detail">일정 내용</div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="plan_01">2
												<div class="cal_detail">일정 내용</div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="plan_01">3
												<div class="cal_detail">일정 내용</div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">4
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">5
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">6
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">7
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">8
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">9
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">10
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">11
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">12
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">13
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="cal_cell">
											<a href="#void" class="plan_01">14
												<div class="cal_detail">일정 내용</div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">15
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">16
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">17
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="plan_01">18
												<div class="cal_detail">일정 내용</div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">19
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">20
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">21
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">22
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">23</a>
											<div class="cal_detail"></div>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">24
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">25
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">26
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">27
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">28
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">29
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">30
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">31
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">1
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="">2
												<div class="cal_detail"></div>
											</a>
										</div>
									</td>
									<td>
										<div class="cal_cell">
											<a href="#void" class="plan_01">3
												<div class="cal_detail">일정 내용</div>
											</a>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
                    </article>
                </div>
            </section>




            <section class="conBox_right_01">
                <div class="conBoxInner">
                    <article class="conTitBox">
                         <h5>업무 알림</h5>
                    </article>
                    <article class="mgT16">
                        
						<div id="grid_wrap" class="gridHeiSz09 grid_wrap tb01_2"></div>
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
						
                    </article>
                </div>
            </section>





		</div>
	</section>


<script>
$(function(){
	$('.cal_day_01 td .plan_01').hover(
		function () {
			$(this).children('.cal_detail').stop().show();
		}, 
		function () {
			$(this).children('.cal_detail').stop().hide();
		}
	);
});
</script>






</div>
</body>
</html>