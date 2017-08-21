<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title>연구자 Progress Note</title>
<script type="text/javascript">
	var _user = {
		'USER_ID': '${loginMap.USER_ID}'
	};
	var g_TaskSn   = '${TASK_SN}';

	var grid_option01 = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
		    id: '',
		    //AUI그리드 생성할 div 및 페이징 옵션
		    div: {
		      gridDiv: '#grid_wrap01'
		    },
		    //데이터 연계 옵션
		    proxy: {
		      url: '/edc/k05/selectIRBBasicInfoList.do',//변경 /ctms/e01/
		      param: {'TASK_SN': g_TaskSn},
		      type: 'post',
		      dataType: 'json',
		      //페이징 true, false 로 지정
		      paging: false,
		      //처음 시작시 데이터 로딩
		      autoLoad: true,  //변경 false
		    },
			//AUI 그리드 옵션
			gridPros: {
			  showRowNumColumn : true,
			  showRowCheckColumn : true,
			  showStateColumn    : true,
			  softRemoveRowMode: false,
			    
			  enableColumnResize : true,
			  enableMovingColumn : true,
			  editable : false,
			  enableFilter : true,
			  headerHeight: 40,
			  rowHeight: 37,
			  selectionMode : "multipleRows"
			},
		    columnLayout: [{
		  	    dataField : "TASK_NO"
		  	  , headerText : '<spring:message code="edc.gr.TASK_NO" />'	//과제번호
		   	  , editable : false
		  	  , visible : true
				, filter : {
					showIcon : true
				  }
		    },
		    {
		  	    dataField : "TASK_NM"
		  	  , headerText : '<spring:message code="edc.gr.TASK_NM" />'	//과제명
		   	  , editable : false
		  	  , visible : true
				, filter : {
					showIcon : true
				  }
		    },
		    {
		  	    dataField : "TASK_TY_CODE"
		  	  , headerText : '<spring:message code="edc.gr.TYPE" />'	//종류
		   	  , editable : false
		  	  , visible : true
				, filter : {
					showIcon : true
				  }
		    },
		    {
		  	    dataField : "PROGRS_CODE"
		  	  , headerText : '<spring:message code="edc.gr.STATUS" />'	//상태
		   	  , editable : false
		  	  , visible : true
				, filter : {
					showIcon : true
				  }
		    },
		    {
		  	    dataField : "TASK_END_AT"
		  	  , headerText : '<spring:message code="edc.gr.END_AT" />'	//종료여부
		   	  , editable : false
		  	  , visible : false
		    },
		    {
		  	    dataField : "TASK_END_AT_TMP"
		  	  , headerText : '<spring:message code="edc.gr.END_BF_AT" />'	//이전종료상태
		   	  , editable : false
		  	  , visible : false
		    }],	//end columnLayout
			//AUI 그리드 생성
			createGrid: function() {
			  var me = this;

			  //이후 객체.id 로 AUIGrid 컨트롤
			  me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			  gridMainID = me.id;
			  me.binding();

			  if(me.proxy.autoLoad) {
					me.load();
			  }
			},
			//AUI 그리드 이벤트 
			binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				}); //cellEditBegin

				AUIGrid.bind(me.id, "cellEditEnd", function(event) { // if

				}); //cellEditEnd

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowMSelect = event.rowIndex;
				});
				
				AUIGrid.bind(me.id, 'selectionChange', function(e) {

				}); //cellEditBegin end

			},	//end binding function
			load: function(v1, v2) {
		 		var me = this;
		 		
		 		AUIGrid.showAjaxLoader(me.id);

				$.ajax({
					  url : '/edc/k05/selectIRBBasicInfoList.do' ,
					  type: 'post',
					  //contentType: "application/json; charset=UTF-8",
					  data : me.proxy.param,
					  success : function(data, textStatus, jqXHR) {
						  var gridData = data;

						  if(data.success) {
							  AUIGrid.removeAjaxLoader(me.id);
							  AUIGrid.setGridData(me.id, data.result);
							  irbBasicInfo = data.result;
							  AUIGrid.setSelectionByIndex(me.id, 0);

							  //AUIGrid.setProperty("#grid_wrap01", "editable", false);
						  } else {
							  AUIGrid.removeAjaxLoader("#grid_wrap01");
							  alert(data.message);
						  }
					  },
					  error : function(jqXHR, textStatus, errorThrown){
						  alert(textStatus);
					  }
				});
		  } //end load function
	};	// end grid_option01


	var grid_option02 = {
			//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
		    id: '',
		    //AUI그리드 생성할 div 및 페이징 옵션
		    div: {
		      gridDiv: '#grid_wrap02'
		    },
		    //데이터 연계 옵션
		    proxy: {
		      url: '/edc/k05/selectIRBBasicEndInfoList.do',//변경 /ctms/e01/
		      param: {'TASK_SN': g_TaskSn},
		      type: 'post',
		      dataType: 'json',
		      //페이징 true, false 로 지정
		      paging: false,
		      //처음 시작시 데이터 로딩
		      autoLoad: true,  //변경 false
		    },
			//AUI 그리드 옵션
			gridPros: {
				  showRowNumColumn : true,
				  showRowCheckColumn : true,
				  showStateColumn    : true,
				  softRemoveRowMode: false,
				    
				  enableColumnResize : true,
				  enableMovingColumn : true,
				  editable : false,
				  enableFilter : true,
				  headerHeight: 40,
				  rowHeight: 37,
				  selectionMode : "multipleRows"
			},
		    columnLayout: [{
		  	    dataField : "TASK_NO"
		  	  , headerText : '<spring:message code="edc.gr.TASK_NO" />'	//과제번호
		   	  , editable : false
		  	  , visible : true
			  , filter : {
			  		showIcon : true
			    }
		    },
		    {
		  	    dataField : "TASK_NM"
		  	  , headerText : '<spring:message code="edc.gr.TASK_NM" />'	//과제명
		   	  , editable : false
		  	  , visible : true
			  , filter : {
			  		showIcon : true
			    }
		    },
		    {
		  	    dataField : "TASK_TY_CODE"
		  	  , headerText : '<spring:message code="edc.gr.TYPE" />'	//종류
		   	  , editable : false
		  	  , visible : true
			  , filter : {
			  		showIcon : true
			    }
		    },
		    {
		  	    dataField : "PROGRS_CODE"
		  	  , headerText : '<spring:message code="edc.gr.STATUS" />'	//상태
		   	  , editable : false
		  	  , visible : true
			  , filter : {
			  		showIcon : true
			    }
		    },
		    {
		  	    dataField : "TASK_END_AT"
		  	  , headerText : '<spring:message code="edc.gr.END_AT" />'	//종료여부
		   	  , editable : false
		  	  , visible : false
		    },
		    {
		  	    dataField : "TASK_END_AT_TMP"
		  	  , headerText : '<spring:message code="edc.gr.END_BF_AT" />'	//이전종료상태
		   	  , editable : false
		  	  , visible : false
		    }],	//end columnLayout
			//AUI 그리드 생성
			createGrid: function() {
			  var me = this;

			  //이후 객체.id 로 AUIGrid 컨트롤
			  me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			  gridMainID = me.id;
			  me.binding();

			  if(me.proxy.autoLoad) {
					me.load();
			  }
			},
			//AUI 그리드 이벤트 
			binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				}); //cellEditBegin

				AUIGrid.bind(me.id, "cellEditEnd", function(event) { // if

				}); //cellEditEnd

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowMSelect = event.rowIndex;
				});
				
				AUIGrid.bind(me.id, 'selectionChange', function(e) {

				}); //cellEditBegin end

			},	//end binding function
			load: function(v1, v2) {
		 		var me = this;
		 		
		 		AUIGrid.showAjaxLoader(me.id);

				$.ajax({
					  url : '/edc/k05/selectIRBBasicEndInfoList.do' ,
					  type: 'post',
					  //contentType: "application/json; charset=UTF-8",
					  data : me.proxy.param,
					  success : function(data, textStatus, jqXHR) {
						  var gridData = data;

						  if(data.success) {
							  AUIGrid.removeAjaxLoader(me.id);
							  AUIGrid.setGridData(me.id, data.result);
							  irbBasicInfo = data.result;
							  AUIGrid.setSelectionByIndex(me.id, 0);

							  //AUIGrid.setProperty("#grid_wrap01", "editable", false);
						  } else {
							  AUIGrid.removeAjaxLoader("#grid_wrap02");
							  alert(data.message);
						  }
					  },
					  error : function(jqXHR, textStatus, errorThrown){
						  alert(textStatus);
					  }
				});
		  } //end load function
	};	// end grid_option02

	$(function(){
		$('#btnLeftMove').click(function() {
			
			var checkedItems = AUIGrid.getCheckedRowItems(grid_option02.id);
			
			for(var i = 0; i < checkedItems.length; i++) {
				checkedItems[i].item.TASK_END_AT = 'N';
				AUIGrid.addRow(grid_option01.id, checkedItems[i].item, 'first');
			}
			
			AUIGrid.removeCheckedRows(grid_option02.id);
		});

		$('#btnRightMove').click(function() {
			
			var checkedItems = AUIGrid.getCheckedRowItems(grid_option01.id);
			
			for(var i = 0; i < checkedItems.length; i++) {
				checkedItems[i].item.TASK_END_AT = 'Y';
				AUIGrid.addRow(grid_option02.id, checkedItems[i].item, 'first');
			}
			
			AUIGrid.removeCheckedRows(grid_option01.id);
		});
		
		$('#btnSave').click(function(){
			var arJson = [];
			var cnt = 0;
			//종료되지 않은 과제 Grid에서 수정사항 저장
			var data = AUIGrid.getGridData(grid_option01.id);
			
			for(var i=0; i<data.length; i++){
				var gData = data[i];
				
				var TskEndAt = gData.TASK_END_AT;
				var TskEndAtTmp = gData.TASK_END_AT_TMP;
				
				if(TskEndAt != TskEndAtTmp){
					
					gData.CURD = 'U';
					gData.UPDATE_ID = _user.USER_ID;
					arJson.push(gData);	
					cnt++;
				}
			}
			
			//종료된 과제 Grid에서 수정사항 저장
			var data = AUIGrid.getGridData(grid_option02.id);
			for(var i=0; i<data.length; i++){
				var gData = data[i];
				
				var TskEndAt = gData.TASK_END_AT;
				var TskEndAtTmp = gData.TASK_END_AT_TMP;
				
				if(TskEndAt != TskEndAtTmp){
					
					gData.CURD = 'U';
					gData.UPDATE_ID = _user.USER_ID;
					arJson.push(gData);	
					cnt++;
				}
			}
			
			if(cnt > 0){
				if(confirm('<spring:message code="common.save.msg" />')){	//저장하시겠습니까?
					$.ajax({
						  url : '/edc/k05/insertIRBBasicInfo.do' ,//변경 
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert( '<spring:message code="edc.save.confirm.msg" />');	//저장되었습니다.
								  grid_option01.load();
								  grid_option02.load();
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_option01");
								  alert(data.message);
							  }
						  }, 
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				}
			} // if
			else{
				alert( '<spring:message code="edc.save.noChange" />');	//변경된 내용이 없습니다.
			}
		});
	});
	
	
	$(document).ready(function(){
		grid_option01.load();
		grid_option02.load();

		grid_option01.createGrid();
		grid_option02.createGrid();
	});
	
	$(window).on('resize', function(){
		if (typeof grid_option01.id !== "undefined") {
			AUIGrid.resize(grid_option01.id);
		}
		if (typeof grid_option02.id !== "undefined") {
			AUIGrid.resize(grid_option02.id);
		}
	});
</script>
<body>
	<div id="wrap">
		<c:import url="/com/topHeader.do?MODULE_CODE=DMC&MENU_ID=EDCK0501&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
		<c:import url="/com/lnb.do?MODULE_CODE=DMC&MENU_ID=EDCK0501&&UPPER_MENU_ID=EDCK" charEncoding="utf-8"/>
		
		<!-- 메인 시작 -->
		<section id="mainCon">
	            <!-- 컨텐츠박스 시작-->
	            <section class="conBox50 conBox" style="float: left; width:48%; position:relative;">
	                <div class="conBoxInner">
	
	                    <!-- 컨텐츠 타이틀 시작-->
	                    <article class="conTitBox">
	                        <h5><spring:message code="edc.title.TASK_LIST" /></h5>	<!-- 과제목록-->
	                    </article>
	                    <!-- 컨텐츠 타이틀 끝-->
<!-- 	                    
						<article class="conTitBtnR">
							<input type="button" id="btnRightMove" value="▶">
							<input type="button" id="btnLeftMove" value="◀">
						</article>

 -->
	                    <!-- 그리드 시작 -->
	                    <article class="mgT16">
	                        <!-- left grid 그리드가 이곳에 생성 -->
	                        <div id="grid_wrap01" class="gridHeiSz20 grid_wrap tb01_2"></div>
	                    </article>
	                    <!-- 그리드 끝 -->
	
	                </div>
                
	                <div class="center_btn_01">
		                <input type="button" id="btnRightMove" class="big_arrow_btn_01" value="▶">
		                <input type="button" id="btnLeftMove" class="big_arrow_btn_02" value="◀">
	                </div>
	            </section>
	            <!-- 컨텐츠박스 끝-->
	            



<style>

.center_btn_01{  position:absolute; left:100%; top:43%; width:8%; box-sizing:border-box; text-align: center; padding:0 3px;}
.big_arrow_btn_01 {  transition-duration:0s !important;  padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; margin:0 0 6px 0; }
.big_arrow_btn_02 {  transition-duration:0s !important; padding:14px 5px 15px 5px !important; height:60px !important; background:#4c55a4 !important;  font-size: 20px !important; }




</style>

	            
	            
	            <!-- 컨텐츠박스 시작-->
	            <section class="conBox50 conBox" style="float: right; width:48%;  ">
	                <div class="conBoxInner">
	                
	                    <!-- 컨텐츠 타이틀 시작-->
	                    <article class="conTitBox">
	                        <h5><spring:message code="edc.title.TASK_END_LIST" /></h5>	<!-- 종료과제목록-->
	                    </article>
	                    <!-- 컨텐츠 타이틀 끝-->
	                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
	                    <article class="conTitBtnR">
	                        <input type="button" id="btnSave" value= '<spring:message code="button.save" />'>
	                    </article>
	                    <!-- 상단 그리드 오른쪽 메뉴 끝-->
	
	                    <!-- 그리드 시작 -->
	                    <article class="mgT16">
	                        <!-- right grid 이곳에 생성 -->
	                        <div id="grid_wrap02" class="gridHeiSz20 grid_wrap tb01_2"></div>
	                    </article>
	                    <!-- 그리드 끝 -->
	                </div>
	
	            </section>
	            <!-- 컨텐츠박스 끝-->
		</section>
		<!-- 메인 끝 -->
		
	</div>
</body>