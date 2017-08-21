<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript" src="<c:url value='/js/pantheon/common/ctms/ctms.js'/>"></script>

<link rel="stylesheet" href="<c:url value='/js/pantheon/common/fullcalendar/fullcalendar.css' />">
<link rel="stylesheet" media='print' href="<c:url value='/js/pantheon/common/fullcalendar/fullcalendar.print.css' />">
<%-- script src="<c:url value="/js/pantheon/common/fullcalendar-2.7.3/lib/jquery.min.js" />"></script--%>
<script src="<c:url value="/js/pantheon/common/fullcalendar/lib/moment.min.js" />"></script>
<script src="<c:url value="/js/pantheon/common/fullcalendar/fullcalendar.min.js" />"></script>

<title>메인</title>
<script>

var jobGridOption = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#jobGridOption',
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
    autoLoad: false,
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
		dataField : "NOTIFY_SN",
		headerText : "NOTIFY_SN",
		visible : false
	},{
		dataField : "REQUEST_SN",
		headerText : "REQUEST_SN",			
		visible : false
	},{
		dataField : "JOB_TYPE",
		headerText : "JOB_TYPE",			
        visible : false	
	},{
		dataField : "TASK_NO",
		headerText : "과제번호",			
        visible : true,
        editable : false
	},{
		dataField : "JOB_NM",
		headerText : "업무유형",			
        visible : true,
        editable : false
	},{
		dataField : "TASK_SN",
		headerText : "과제번호",			
        visible : false
	},{
		dataField : "NOTIFY_SJ",
		headerText : "업무내용",			
        visible : true,
        editable : false
	},{
		dataField : "CHARGER_ID",
		headerText : "CHARGER_ID",			
        visible : false
	},{
		dataField : "TASK_SN",
		headerText : "과제 순번",			
        visible : false,
		editable : false
	},{
		dataField : "LINK_URL",
		headerText : "LINK_URL",			
        visible : false,
		editable : false
	},{
		dataField : "LINK_KEY",
		headerText : "LINK_KEY",			
        visible : false,
		editable : false
	},{
		dataField : "LINK_VALUE",
		headerText : "LINK_VALUE",			
        visible : false,
		editable : false
	},{
		dataField : "NOTIFY_BEGIN",
		headerText : "NOTIFY_BEGIN",			
        visible : false,
		editable : false
	},{
		dataField : "NOFTIFY_END",
		headerText : "NOFTIFY_END",			
        visible : false,
		editable : false
	},{
		dataField : "UPDT_DE",
		headerText : "알람일",			
        visible : true,
        dataType : "date",
 		formatString : "yyyy-mm-dd",
		editable : false
	}],

  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
  },
  //AUI 그리드 이벤트 
  binding: function() {
	var me = this;
	AUIGrid.bind(me.id, "cellDoubleClick", function(event){
		fn_jobNotification(event.item);
	});
  },
  //AUI 그리드 데이터 요청
  load: function(v1, v2) {
    var me = this;
    
    //AUIGrid.showAjaxLoader(me.id);
    
    AUIGrid.setGridData(me.id, testData);


  }
};


$(document).ready(function() {
	jobGridOption.createGrid();
	fn_milestoneInfo();
});

function fn_milestoneInfo(){
	$.ajax({
	    url: "/ctms/i01/selectCalMilestoneList.do",
	    type: "post",
	    dataType: "json",
	    data: {},//me.proxy.param,
	    success:function(data){
	    	if(data.success) {
	    		fn_milestoneCal(data.calList);
	    		AUIGrid.setGridData(jobGridOption.id, data.jobList);
	    	} else {	    		
	    		alert(data.message);
	    	}
	    },
		error : function(jqXHR, textStatus, errorThrown){
		alert(textStatus);
		}
	});
}

function fn_milestoneCal(calList){
	var today = fn_getToday();
	$('#calendar').fullCalendar({
		header: {
			left: 'prev today',
			center: 'title',
			right: 'next'
			//right: 'month,basicWeek,basicDay'
		},
		defaultDate: today,
		editable: false,
		eventLimit: true, // allow "more" link when too many events
		eventClick: function(event) {
			// opens events in a popup window
			console.log("event.title : "+event.title);
		},
		dayClick: function(event) {
	        //alert('a day has been clicked!');
	    },
		events : calList
/*
		events: [
			{
				title: '방문 보고서',
				start: '2016-05-01',
				end: '2016-05-02T10:30:00'
			}
		]
*/
	});
}

function fn_jobNotification(item){

	var jobType   = item.JOB_TYPE;
	var keySize   = 0;
	var valueSize = 0;
	var params    = {};

	if (typeof item.LINK_KEY !== "undefined") {
		if(item.LINK_KEY){
			keySize   = item.LINK_KEY.length;
			valueSize = item.LINK_VALUE.length;
		}
   	}

	if(keySize > 0 && valueSize > 0){
		var keys   = item.LINK_KEY.split(",");
		var values = item.LINK_VALUE.split(",");
		
		if(keys.length == values.length){
			var keys   = keykey.split(",");
			var values = valuevalue.split(",");
			
			for(var i=0; keys.length > i; i++){
				params[keys[i]] = values[i];
			}
		}
		else{
			console.log("key 갯수와 values 갯수가 틀림!!!");
		}
	}

	$("#frm").attr({
		  action : item.LINK_URL
		, method : 'post'
		, dataType: "json"
		, data : params
	}).submit();
}

window.onresize = function() {
	if (typeof jobGridOption.id !== "undefined") {
		AUIGrid.resize(jobGridOption.id);
	}
};
</script>
<style>
/*
	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}
*/
	#calendar {
		max-width: 500px;
		margin: 0 auto;
	}

</style>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMI0101&UPPER_MENU_ID=CTMI" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMI0101&UPPER_MENU_ID=CTMI" charEncoding="utf-8"/>



	<section id="mainCon">
		<div class="mainConInner2">




            <section class="conBox100 conBox">
                <div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>Study Status</h5>
                    </article>
                    <article class="conTitBtnR">
                        <!-- input type="button" id="" value="EDIT" /-->
                    </article>
                    <article class="mgT16">
                        <div id="" class="gridHeiSz07 grid_wrap tb01_2"></div>
                    </article>
                </div>
            </section>





            <section class="conBox_left_01">
                <div class="conBoxInner2">
                
                	<div id='calendar'></div>

                    <!-- article class="calendar">
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
                    </article-->
                </div>
            </section>




            <section class="conBox_right_01">
                <div class="conBoxInner">
                    <article class="conTitBox">
                         <h5>업무 알림</h5>
                    </article>
                    <article class="mgT16">
                        
						<div id="jobGridOption" class="gridHeiSz10 grid_wrap tb01_2"></div>
						
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



<form id="frm" name="frm">
</form>



</div>
</body>
</html>