<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
 <script type="text/javascript">
 var userId ; //로그인한 유저 ID
 var taskSearchNo; //검색
 var standardTime;
 var insttCode; //모듈구분 공통코드		
 var checkRoleCode; 
 var divisionId; //아이디 구분 공통코드
 var userSeCode; //사용자구분 공통코드
 var paramItem;
 var clickCount = false; //true면 수정화면
 var p_instt_type = "";
 var p_taskSn = "";
 $(document).ready(function(){
	 
	 $("#textSearch").val("");
	 //console.log("roleCodevalue:::"+roleCodevalue);
	 taskUserGrid.createGrid();
	 
	 $("#btnNew").click(function(){
	
		 var param={};
		 mkLayerPopupOpen("/ctms/j08/popupDMCJ0802.do", param);
		 AUIGrid.resize(checkRoleGrid.id);
			
	 });
	 
	 $("#btnSave").click(function(){
		
	    var checkItems = AUIGrid.getRemovedItems(taskUserGrid.id);
	    console.log(checkItems);
		if(checkItems == ""){
			alert("삭제할 항목을 선택해 주세요.");
			return;
		}
	
		if(confirm("삭제하시겠습니까?") == true){
			//확인 진행
		}else{
			return;
		}
		 
		var arJson = [];
		
		var removeItems = AUIGrid.getRemovedItems(taskUserGrid.id);
		
		for(var i = 0; i < removeItems.length; i++) {
			removeItems[i].CRUD = 'D';
			removeItems[i].LAST_UPDUSR = userId;				
			arJson.push(removeItems[i]);
		}
		
		$.ajax({
			  url : './insertTaskUserInfo.do' ,
			  type: 'post',
			  contentType: "application/json; charset=UTF-8",
			  data : JSON.stringify(arJson),
			  success : function(data, textStatus, jqXHR) {
				  var gridData = data;
				  
				  if(data.success) {
					   taskUserGrid.load();
					   
				  } else {
					  AUIGrid.removeAjaxLoader(taskUserGrid.id);
					  alert(data.message);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert(textStatus);
			  }
		});
	 });
	 
	 $("#btnDel").click(function(){
		// AUIGrid.removeCheckedRows(taskUserGrid.id);
		
		 AUIGrid.removeCheckedRows(taskUserGrid.id);
	 });
	 
	 //검색버튼 클릭
	 $("#btnTaskNoSearch").click(function(){			
		var params = {
				'TASK_NO': $("#textSearch").val()				   
			};
			
		taskUserGrid.proxy.param = params; 			
		taskUserGrid.load();
		
	 });
	 
	 //검색 엔터클릭
	 $("#textSearch").keydown(function(event){	
		 if(event.keyCode == 13){
			 var params = {
					'TASK_NO': $("#textSearch").val()				   
				};					
			taskUserGrid.proxy.param = params; 			
			taskUserGrid.load();
		 }
			
		
	 });
	 
	 AUIGrid.bind(taskUserGrid.id, "cellDoubleClick", function(event){		 
		 paramItem = event.item;
		 //console.log(paramItem);
		 clickCount = true;
		 
		 var param={};
		 mkLayerPopupOpen("/ctms/j08/popupDMCJ0802.do", param);
		 AUIGrid.resize(checkRoleGrid.id);
	 });
	 
 });  
 
 function gridReset(){
	 taskUserGrid.load();
	 console.log("reset===");
 }
 

 $(window).on('resize', function(){
		if (taskUserGrid.id) {
			AUIGrid.resize(taskUserGrid.id);
		}
	});
 
 var taskUserGrid = {
		 	id: '',
		 	div: {
		 		gridDiv: '#taskUserGrid',	 			
		 	},
		 	proxy: {
		 		url: './selectTaskUserInfo.do',
		 		param: {},
		 		type: 'post',
		 		dataType: 'json',
		 		//페이징 true, false 로 지정
		 		paging: true,
		 		//처음 시작시 데이터 로딩
		 		autoLoad: true
		 	},
		 	gridPros: {
		 		usePaging : true,
	 		    showStateColumn: true,
	 		    rowCheckToRadio : false,
	 		    reverseRowNum : true,
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    showRowNumColumn : true,
			    showRowCheckColumn : true,
			    //enableColumnResize : false,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,	
			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "singleRow",

			    displayTreeOpen : true,
			   
		 	},
		 	//AUI 그리드 레이아웃
		 	columnLayout : [{
			 	dataField : "TASK_SN",
			 	headerText : "과제순번",
			 	visible : false,
			 	editable : false
			 },{
			 	dataField : "TASK_NO",
			 	headerText : "과제번호",
			 	width : 120,
			 	filter : {
					showIcon : true
				},
			 	editable : false
			 },{
			 	dataField : "DEPT_NM",
			 	headerText : "기관",
			 	width : 180,
			 	filter : {
					showIcon : true
				},
			 	editable : false	
			 },{
			 	dataField : "INSTT_TY",
			 	headerText : "기관유형",
			 	width : 120,
			 	editable : false,
			 	labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
					var me = taskUserGrid;
					var retStr = "";
					for(var i=0; me.columnLayout[3].editRenderer.list.length > i; i++) {
						if(me.columnLayout[3].editRenderer.list[i]['CODE'] == value) {
							retStr = me.columnLayout[3].editRenderer.list[i]['NAME'];
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
			 	dataField : "ROLE_NM",
			 	headerText : "역할",
			 	//width : 180,
			 	filter : {
					showIcon : true
				},
			 	editable : false	
			 },{
			 	dataField : "USER_NM",
			 	headerText : "사용자명",
			 	width : 120,
			 	filter : {
					showIcon : true
				},
			 	editable : false 	
			 },{
			 	dataField : "USER_ID",
			 	headerText : "ID",
			 	width : 120,
			 	filter : {
					showIcon : true
				},
			 	editable : false 	
			 },{
			 	dataField : "EMAIL",
			 	headerText : "이메일",
			 	width : 180,
			 	filter : {
					showIcon : true
				},
			 	editable : false	
			 },{
			 	dataField : "TELNO",
			 	headerText : "연락처",
			 	width : 120,
			 	filter : {
					showIcon : true
				},
			 	editable : false	
			 },{
			 	dataField : "FRST_CREDE",
			 	headerText : "등록일", 	
			 	dataType : "date",
			 	width : 120,
				formatString : "yyyy-mm-dd",
				filter : {
					showIcon : true
				},
			 	editable : false	
			 },{
			 	dataField : "DEPT_CD",
			 	headerText : "기관코드",
			 	filter : {
					showIcon : true
				},
			 	visible : false,
			 	editable : false	
			 },{
			 	dataField : "STD_TIME_SN",
			 	headerText : "지역별 시간",
			 	filter : {
					showIcon : true
				},
			 	visible : false,
			 	editable : false	
			 },{
				dataField : "USE_YN",
			 	headerText : "사용 구분",
			 	filter : {
					showIcon : true
				},
			 	visible : true,
			 	width:140,
			 	editable : false	
			 },{
				 dataField : "USER_ENGNM",
			 	headerText : "영문명",
			 	visible : false,
			 	editable : false
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
		 				 				 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    dataType: me.proxy.dataType,
		 		    data: me.proxy.param,//me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {
		 		    		userId = data.USER_ID;
		 		    		insttCode = data.insttCode;		 		    		   		
		 		    		divisionId = data.divisionId;
		 		    		standardTime = data.stdTime;
		 		    		userSeCode = data.userSeCode;
		 		    		
		 		    		me.columnLayout[3].editRenderer.list = data.insttCode;
		 		    		
		 			    	AUIGrid.setGridData(me.id, data.result);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);
		 		    	} else {
		 		    		
		 		    		alert(data.message);
		 		    		
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
		 		});
		 	}
		};
 

 </script>
<title>과제별사용자</title>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=DMCJ0801&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=DMCJ0801&UPPER_MENU_ID=DMCJ" charEncoding="utf-8"/>
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


                    <div class="conTitBtnR">     
                       <input type="button" id="btnDel" value="삭제">     
                       <input type="button" id="btnSave" value="저장">               
                       <input type="button" id="btnNew" value="신규">
                    </div>

                    <div class="conTitBtnL">                     
						<span style="font-family:'NanumGothicBold';">과제번호  :</span>
						<input type="text" id="textSearch">
						<input type="button" id="btnTaskNoSearch" value="검색">
                    </div>


                    <article class="mgT44">
                         <div id="taskUserGrid" class="gridHeiSz15 grid_wrap tb01_2"></div>                        
                    </article>

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->
	 
	
	</div>
</section>
</div>
</body>
</html>