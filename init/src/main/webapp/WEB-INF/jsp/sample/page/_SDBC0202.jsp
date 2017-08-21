<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<title>DEMOGRAPHICS</title>
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

<script type="text/javascript">


var testData =[
{
  "Disease / Surgical procedure / etc.":"천식",
  "Start Date":"2016-11-15",
  "Continuing":"Unknown",
  "End Date":"2016-11-15",
  "Comments":"천식입니다.",
  "Deleted":"N"
}, {
  "Disease / Surgical procedure / etc.":"천식",
  "Start Date":"2016-11-15",
  "Continuing":"Unknown",
  "End Date":"2016-11-15",
  "Comments":"천식입니다.",
  "Deleted":"N"


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
    dataField : "Disease / Surgical procedure / etc.",
    headerText : "Disease / Surgical procedure / etc.",
    width : 240
  },{
    dataField : "Start Date",
    headerText : "Start Date",
    width : 100
  },{
    dataField : "Continuing",
    headerText : "Continuing",
    width : 100
  },{
    dataField : "End Date",
    headerText : "End Date",
    width : 100
  },{
    dataField : "Comments",
    headerText : "Comments"
  },{
    dataField : "Deleted",
    headerText : "Deleted",
    width : 80
  
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





$(function() {
	setAccodian();
	mkSetDatePickerYYMMDD("#day_01");
	mkSetDatePickerYYMMDD("#day_02");
});



function setAccodian(){
	 for(var ai=0; ai<3; ai++){
	    aiP = ai+1;
	
		(function(aiE){ 
			$(".accordion_0"+aiE+" > a").on("click",function() {
				if ($(this).hasClass("close")) {
					$(this).siblings(".accordion_con_0"+aiE+"").slideToggle(20);
					$(this).toggleClass('open');
					//그리드 리사이징
					AUIGrid.resize(myGridOption.id);
				}
			});

			$(".accordion_con_02").css({"display":"none"});
			$(".accordion_con_03").css({"display":"none"});
		
		})(aiP); //반복문 적용끝
	
	} //반복문끝
}





</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<form id="iform">
	<input type='hidden' id=''/>							
	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>이상사례</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>이상사례</li>
					</ul>
				</nav>
			</article>




            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">

					<div class="button_tab_01">
						<ul>
							<li id="" class="tab_menu">DEMOGRAPHICS</li>
							<li id="" class="port_back tab_menu">MEDICAL HISTORY</li>
							<li id="" class="tab_menu">DRUG HISTORY</li>
							<li id="" class="tab_menu">AE</li>
							<li id="" class="tab_menu">TEST</li>
							<li id="" class="tab_menu">DRUG</li>
							<li id="" class="tab_menu">RELATION</li>
							<li id="" class="tab_menu">NARRATIVE</li>
							<li id="" class="tab_menu">ASSESSMENT</li>
						</ul>
					</div>

					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="초기화">									
						<input type="button" id="" value="검색">
						<input type="button" id="" value="추가">
						<input type="button" id="" value="저장">
						<input type="button" id="" value="삭제">
						<input type="button" id="" value="엑셀">
						<input type="button" id="" value="내역">
					</article>


					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>General Comment</th>
								<td style="padding-top:5px; padding-bottom: 2px;">
									<table class="in_table">
										<tr>
											<th>
												<textarea id="" rows="3" style="width: 100%;"></textarea>
											</th>
											<td style="vertical-align: top; width: 32px;">
												<input type="button" class="oneBtn" value="Q" style="vertical-align: top;" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</tbody>
					</table>



 					<article class="mgT16">
                        <div id="grid_wrap" class="gridHeiSz03 grid_wrap tb01_2"></div>
                        <!-- <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
                    </article>



	
					<ul class="mgT20">
					    <li class="accordion_02">
					    	<a href="#void" class="close">MEDICAL HISTORY No.1</a>
					        <div class="accordion_con_02">
	
	
								<table class="tb001">
									<colgroup>
										<col width="10%" />
										<col width="8%" />
										<col width="20%" />
										<col width="10%" />
										<col width="20%" />
										<col width="10%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th colspan="2">Disease / Surgical procedure / etc.<span class="must_01"></span></th>
											<td colspan="5">
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>KCD</th>
											<th>Version</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Team</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="width: 32px; vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
											</td>
											<th>Code</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th>MedDRA</th>
											<th>Version</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>LLT</th>
											<td style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="width: 32px; vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
											</td>
											<th>LLT Code</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<input type="text" id="" style="width:100%;">
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Start Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="day_01" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>Continuing</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<select id="" style="width:100%;">
																<option value=''>===selected===</option>
															</select>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
											<th>End Date</th>
											<td>
												<table class="in_table">
													<tr>
														<th>
															<div class="dateBox">
																<input type="text" id="day_02" style="width: 120px;" />
															</div>
														</th>
														<td style="width: 32px;">
															<input type="button" class="oneBtn" popup_type="Q"  value="Q">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<th colspan="2">Comments</th>
											<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
												<table class="in_table">
													<tr>
														<th>
															<textarea id="" rows="2" style="width: 100%;"></textarea>
														</th>
														<td style="vertical-align: top;">
															<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
															<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
														</td>
													</tr>
												</table>
												<input type="hidden" id="" />
												<label popup_type="Label" id=""></label>
											</td>
										</tr>
									</tbody>
								</table>
	
					            <ul class="mgT20">
					                <li class="accordion_03">
					                	<a heft="#void" class="close"><span>[Q내역]</span></a>
					                    <div class="accordion_con_03 close">
					                        <div id="grid_wrap" class="gridHeiSz04 grid_wrap tb01_2"></div>
					                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
					                    </div>
					                </li>
					            </ul>


					        </div>
					    </li>
	
					    
					</ul>
							
				</div>
            </section>

		</div>
	</section>
	</form>
</div>
</body>
</html>