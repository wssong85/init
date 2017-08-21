<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/com/common.do" flush="false"/>



<title>DM Center Home</title>
<script type="text/javascript">

var grTaskRegStatus = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grTaskRegStatus'
	 	},
	 	proxy: {
	 		url: './selectDmcHomeInfo.do',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
	 		showHeader: true,
	 		showStateColumn: false,
		    showRowNumColumn : false,
	 	    showRowCheckColumn : false,
		    enableColumnResize : false,
		    enableMovingColumn : false,
		    enableFilter : false,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "singleRows",
		    softRemoveRowMode: false
//	 	    rowIdField : "PROGRM_ID"
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
	 		dataField : "EDC_CNT",
	 		headerText : "EDC",
	 		visible: true,
	 		editable: false
	 	},{
	 		dataField : "IWRS_CNT",
	 		headerText : "IWRS",
	 		visible: true,
	 		editable: false
	 	},{
	 		dataField : "RSRCH_CNT",
	 		headerText : "연구자",
	 		visible: true,
	 		editable: false
	 	},{
	 		dataField : "INSTT_CNT",
	 		headerText : "기관",
	 		visible: true,
	 		editable: false
	 	}],
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	binding: function() {

	 	},
	 	load: function(v1, v2) {

	 	}
	};

	var grNotify = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grNotify'
	 	},
	 	proxy: {
	 		url: '/ctms/j01/selectDmcHomeInfo.do',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: true
	 	},
	 	gridPros: {
	 		showHeader: false,
	 		showStateColumn: false,
		    showRowNumColumn : false,
	 	    showRowCheckColumn : false,
		    enableColumnResize : false,
		    enableMovingColumn : false,
		    enableFilter : false,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "singleRows",
		    softRemoveRowMode: false
//	 	    rowIdField : "PROGRM_ID"
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [{
	 		dataField : "NOTIFY_SJ",
	 		headerText : "NOTIFY_SJ",
	 		visible: true
	 	},{
	 		dataField : "NOTIFY_SN",
	 		headerText : "NOTIFY_SN",
	 		visible: false
	 	},{
	 		dataField : "REQUEST_SN",
	 		headerText : "REQUEST_SN",
	 		visible: false
	 	},{
	 		dataField : "JOB_SE",
	 		headerText : "JOB_SE",
	 		visible: false
	 	},{
	 		dataField : "CHARGER_ID",
	 		headerText : "CHARGER_ID",
	 		visible: false
	 	},{
	 		dataField : "NOTIFY_AT",
	 		headerText : "NOTIFY_AT",
	 		visible: false
	 	},{
	 		dataField : "LINK_URL",
	 		headerText : "LINK_URL",
	 		visible: false
	 	},{
	 		dataField : "LINK_KEY",
	 		headerText : "LINK_KEY",
	 		visible: false
	 	},{
	 		dataField : "LINK_VALUE",
	 		headerText : "LINK_VALUE",
	 		visible: false
	 	}],
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	binding: function() {
	 		var me = this;

	 		AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
	 			fn_jobNotification(e.item);
			});
	 	},
	 	load: function(v1, v2) {
	 		var me = this;
	 		
	 		AUIGrid.showAjaxLoader(me.id);

	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.notification);
	 			    	AUIGrid.setSelectionByIndex(me.id, 0);
	 			    	
	 			    	AUIGrid.setGridData(grTaskRegStatus.id, data.taskStatus);
	 			    	AUIGrid.setSelectionByIndex(grTaskRegStatus.id, 0);

	 			    	AUIGrid.setGridData(grTaskNotice.id, data.noticeList);
	 			    	AUIGrid.setSelectionByIndex(grTaskNotice.id, 0);

	 		    	} else {
	 		    		AUIGrid.removeAjaxLoader(me.id);
	 		    		alert(data.message);
	 		    	}
	 		    },
				error : function(jqXHR, textStatus, errorThrown){
					alert(textStatus);
				}
	 		});
	 	}
	};

	var grTaskNotice = {
	 	id: '',
	 	div: {
	 		gridDiv: '#grTaskNotice'
	 	},
	 	proxy: {
	 		url: '',
	 		param: {},
	 		type: 'post',
	 		dataType: 'json',
	 		//페이징 true, false 로 지정
	 		paging: false,
	 		//처음 시작시 데이터 로딩
	 		autoLoad: false
	 	},
	 	gridPros: {
	 		showHeader: true,
	 		showStateColumn: false,
		    showRowNumColumn : false,
	 	    showRowCheckColumn : false,
		    enableColumnResize : false,
		    enableMovingColumn : false,
		    enableFilter : false,
		    headerHeight: 40,
		    rowHeight: 37,
		    selectionMode : "singleRows",
		    softRemoveRowMode: false
//	 	    rowIdField : "PROGRM_ID"
	 	},
	 	//AUI 그리드 레이아웃
	 	columnLayout : [
			{
				dataField : "SN",
				headerText : "순번",
				visible: false
			},{
		 		dataField : "TASK_SN",
		 		headerText : "과제순번",
		 		visible: false
		 	},{
		 		dataField : "TASK_NO",
		 		headerText : "과제번호",
		 		visible: true,
		 		width:150
		 	},{
		 		dataField : "MODULE_NM",
		 		headerText : "모듈",
		 		visible: true,
		 		width:130
		 	},{
		 		dataField : "SJ",
		 		headerText : "제목",
		 		visible: true
		 	},{
		 		dataField : "",
		 		headerText : "권한",
		 		visible: true,
		 		width:120
		 	},{
		 		dataField : "USER_NM",
		 		headerText : "작성자",
		 		visible: true,
		 		width:150
		 	},{
		 		dataField : "CREATE_DE",
		 		headerText : "작성일",
		 		visible: true,
		 		width:120
		 	}
	 	],
	 	createGrid: function() {
	 		var me = this;
	 		
	 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
	 		
	 		me.binding();
	 		
	 		if(me.proxy.autoLoad) {
	 			me.load();
	 		}
	 	},
	 	binding: function() {
	 		var me = this;

	 		AUIGrid.bind(me.id, 'cellDoubleClick', function(e) {
	 			fn_goModuleNotice(e.item);
			});
	 	},
	 	load: function(v1, v2) {

	 	}
	};

	$(function() {
		grTaskNotice.createGrid();
		grTaskRegStatus.createGrid();
		grNotify.createGrid();

		$('#btnMore').click(function() {
			var param = {};
			mkLayerPopupOpen("/ctms/j01/popupDMCJ0102.do", param);
			AUIGrid.resize(grTaskProgressStatus.id);
		});

	});
	
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
	
	function fn_goModuleNotice(item){
		console.log(item);
		var v_module = item.MODULE_NM;
		var params   = {};
		var v_linkUrl;

		switch(v_module){
		case "EDC" :
			v_linkUrl = "";
			break;
		case "CTMS" :
			v_linkUrl = "/ctms/a01/CTMA0101.do";
			break;
		case "SDB" :
			break;
		case "IWRS" :
			break;
		
		default :
		} //switch
		
		$("#frm").attr({
			  action : v_linkUrl
			, method : 'post'
			, dataType: "json"
			, data : params
		}).submit();	
	}


	$(window).resize(function() {
		if (grTaskRegStatus.id) {
			AUIGrid.resize(grTaskRegStatus.id);
		}
		if (grNotify.id) {
			AUIGrid.resize(grNotify.id);
		}
		if (grTaskNotice.id) {
			AUIGrid.resize(grTaskNotice.id);
		}
	});
	
</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0101&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0101&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>



	<section id="mainCon">
		<div class="mainConInner2">


            <section class="conBox_left_01" style="width:65%">
                <div class="conBoxInner3">
                    <article class="conTitBox">
                         <h5>과제 등록현황</h5>
                    </article>
                    <article class="conTitBtnR">
                        <input type="button" id="btnMore" value="More" />
                    </article>
                    <article class="mgT16">

						<div id="grTaskRegStatus" class="gridHeiSz06 grid_wrap tb01_2"></div>

                    </article>
                </div>
            </section>




            <section class="conBox_right_01" style="width:35%">
                <div class="conBoxInner">
                    <article class="conTitBox">
                         <h5>업무 알림</h5>
                    </article>
                    <article class="mgT16">
                    	<div id="grNotify" class="gridHeiSz06 grid_wrap tb01_2"></div>
						<!-- ul class="sub_main_board_01">
							<li>신규 임상과제등록 완료에 대한 공지 </li>
							<li>eTraining 사용법에 대해서 정확한 설명을 위한위한위한위한위한위한위한위한위한위한위한위한.. </li>
							<li>시스템 사용자 신청시 작성 서류 방법에 대한.. </li>
							<li>시스템 자동 로그아웃 설정 방법에 대한 정보 소식</li>
							<li>eTraining 사용법에 대해 자세한 설명은.. </li>
							<li>시스템 사용자 신청시 작성 서류에 대한 공지 </li>
							<li>시스템 자동 로그아웃 설정 방법.. </li>
							<li>시스템 자동 로그아웃 설정 방법.. </li>
							<li>시스템 자동 로그아웃 설정 방법.. </li>
							<li>시스템 자동 로그아웃 설정 방법.. </li>
							<li>시스템 자동 로그아웃 설정 방법.. </li>
							<li>시스템 자동 로그아웃 설정 방법.. </li>
							<li>시스템 자동 로그아웃 설정 방법.. </li>
						</ul-->
                    </article>
                </div>
            </section>





            <section class="conBox100 conBox">
                <div class="conBoxInner">
                    <article class="conTitBox">
                        <h5>과제 공지사항</h5>
                    </article>
                    <article class="conTitBtnR">
                        <!-- input type="button" id="" value="설정" /-->
                    </article>
                    <article class="mgT16">
						<div id="grTaskNotice" class="gridHeiSz11 grid_wrap tb01_2"></div>
                    </article>
                </div>
            </section>
			<div style="clear:both;"></div>

<form id="frm" name="frm">
</form>



		</div>
	</section>






</div>
</body>
</html>