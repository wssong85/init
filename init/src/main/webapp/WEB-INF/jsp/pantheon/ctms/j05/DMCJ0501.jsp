<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
 <script type="text/javascript">
 var userId ; //로그인한 유저 ID
 var taskNm;
 $(document).ready(function(){
	 dmcj0501Grid.createGrid();
	 $("#TASK_NM").val("");
	 $("#SERCHBUTTON").click(function(){
		 taskNm = $("#TASK_NM").val();
		 dmcj0501Grid.load();
	 });
	
 });  
 var dmcj0501Grid = {
		 	id: '',
		 	div: {
		 		gridDiv: '#dmcj0501Grid'
		 	},
		 	proxy: {
		 		url: './selectInstitutionInfo.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: false,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	gridPros: {
			    // 페이징 사용
			   //  usePaging : true,
			    //pageRowCount : 5,			    
			    //showPageButtonCount : 5, 
			    showStateColumn: true,
			    showRowNumColumn : true,
			    showRowCheckColumn : false,
			    //rowCheckToRadio : true,
			   // enableColumnResize : false,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,
				//height: 265,
			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true,
			   
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
			 	dataField : "KUNNR",
			 	headerText : "거래처 코드",
			 	editable : true	,
			 	visible : false
			 },{
			 	dataField : "INSTT_CODE",
			 	headerText : "기관코드",
			 	editable : true	,
			 	visible : false
			 },{
			 	dataField : "NAME1",
			 	headerText : "기관명",
			 	width : 220,
			 	editable : true	
			 },{
			 	dataField : "VKBUR",
			 	headerText : "기관코드", 	
			 	editable : true	
			 },{
			 	dataField : "INSTT_TY",
			 	headerText : "기관유형",
			 	editable : true,
			 	labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
					var me = dmcj0501Grid;
					var retStr = "";
					for(var i=0; me.columnLayout[4].editRenderer.list.length > i; i++) {
						if(me.columnLayout[4].editRenderer.list[i]['CODE'] == value) {
							retStr = me.columnLayout[4].editRenderer.list[i]['NAME'];
							break;
						}
					}
					return retStr == "" ? value : retStr;
			    },
			    editRenderer : {
	     			type : "DropDownListRenderer",
	     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
	     			list : null,
	     			keyField : "CODE",
	     			valueField : "NAME"
	     		 }
			 },{
			 	dataField : "STCD2",
			 	headerText : "사업자등록번호",
			 	width : 180,
			 	editable : true 	
			 },{
			 	dataField : "ORT01",
			 	headerText : "소재지",
			 	width : 200,
			 	editable : true 	
			 },{
			 	dataField : "REGIO",
			 	headerText : "지역",	
			 	editable : true
			 	
			 },{
			 	dataField : "STRAS",
			 	headerText : "주소",
				width : 200,
			 	editable : true
				 	
			 },{
			 	dataField : "FRST_CREDE",
			 	headerText : "등록일",	
			 	dataType : "date",
			 	width : 120,
				formatString : "yyyy-mm-dd",
			 	editable : true
					 	
			 }],
		 	//AUI 그리드 생성
		 	createGrid: function() {
		 		var me = this;
		 		
		 		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		 		
		 		me.binding();
		 		
		 		if(me.proxy.autoLoad) {
		 			me.load();
		 			
		 		}
		 	},
		 	//AUI 그리드 이벤트 
		 	binding: function() {
		 	},
		 	load: function(v1, v2) {
		 		var me = this;
		 		console.log("loadFunction");
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: {'NAME1' : taskNm},//me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {	 
		 		    		
		 		    	    //userId = data.USER_ID;			 	
		 		    	    me.columnLayout[4].editRenderer.list = data.instt_ty;
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.result);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 			    	AUIGrid.setProperty(dmcj0501Grid.id, "editable" , false ); 
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
 

$(window).resize(function(){
	if (typeof dmcj0501Grid.id !== "undefined") {
		AUIGrid.resize(dmcj0501Grid.id);
	}	
});

 </script>
<title>기관정보 목록</title>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0501&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0501&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
<section id="mainCon">
	<div class="mainConInner">
	  <!-- 컨텐츠박스 시작-->

            <article class="mainTitBox">
                <h3>${progrmMap.MENU_NM}</h3>
                <nav id="pathNav">
                    <ul>
                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
                        <li>${progrmMap.UPPER_MENU_NM}</li>
                        <li>${progrmMap.MENU_NM}</li>
                    </ul>
                </nav>
           	</article>
           	
           	
	  		<!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

				    <div class="conTitBtnL">
						<span style="font-family:'NanumGothicBold';">과제명 :</span>
						<input type="text" id="TASK_NM" name="TASK_NO" class="pdR15">	    	
						<input type="button" id="SERCHBUTTON" name = "SERCHBUTTON" value="검색">
				    </div> 


                    <article class="mgT44">
                         <div id="dmcj0501Grid" class="gridHeiSz15 grid_wrap tb01_2"></div>
                    </article>

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
		</div>
	</section>
</div>
</body>
</html>