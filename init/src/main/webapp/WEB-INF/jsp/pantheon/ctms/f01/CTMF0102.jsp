<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript">
var myGrid;
var pageXP;
var pageYP;
var myGridOption = {
		  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
		  id: '',
		  dialogId: 'editWindow',
		  _dialog: '',
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
		    url: './selectElectContractList.do',
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
		    enableColumnResize : false,
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
		  columnLayout : [
    		   {
    		   	  dataField : "TASK_SN"
    		   	, headerText : "과제순번"
    		   	, visible : false
    		   	, editable : false
    		   	//width: 120
    		   }
    		   ,{
    		   	  dataField : "TASK_NO"
    		   	, headerText : "과제번호"
    		   	, editable : false
    		   	, width: 100
    		   }
    		   ,{
    		   	  dataField : "INSTT_NM"
    		   	, headerText : "기관명"
				, editable : false
    		   	, width: 180
    		   }
    		   ,{
    		   	  dataField : "USER_NM"
    		   	, headerText : "연구자"
    		   	, editable : false
    		   	, width: 90
    		   }
    		   ,{
    		   	  dataField : "USER_ID"
    		   	, headerText : "ID"
    		   	, editable : false
    		   	, width: 100
    		   }
    		   ,{
    		   	  dataField : "EMAIL"
    		   	, headerText : "e-mail"
    		    , editable : false
    		   	, width: 160
    		   }
    		   ,{
    		   	  dataField : "TELNO"
    		   	, headerText : "전화번호"
    		    , editable : false
        		, labelFunction : function(  rowIndex, columnIndex, value) { 
					value += "";
					if(value.length == 11) {
						return value.substr(0,3) + "-" + value.substr(3,4) + "-" + value.substr(6,value.length)
					}
					else if(value.length == 10) {
						return value.substr(0,2) + "-" + value.substr(2,4) + "-" + value.substr(5,value.length)
					}
					return value;	
 		           }
    		   	 , width: 130
    		   }
    		   ,{
    		   	  dataField : "GOAL_CO"
    		   	, headerText : "목표례수"
    		   	, editable : false
    		   	, width: 120
    		   }
    		   ,{
    		   	  dataField : "IRB_AT"
    		   	, headerText : "IRB여부"
    		   	, editable : false
    		   	//width: 120
    		   }
    		   ,{
    		   	  dataField : "STATUS_NM"
    		   	, headerText : "상태/날짜"
    		   	, editable : true
    		   	//width: 120
    		   }
    		   ,{
    		   	  dataField : "STTUS"
    		   	, headerText : "상태"
    		   	, visible : false
    		   	, editable : false
    		   	//width: 120
    		   }
    		   ,{
    		   	  dataField : "STTUS_DTE"
    		   	, headerText : "상태날짜"
    		   	, visible : false
    		   	, editable : false
    		   }
    		   ,{
    		   	  dataField : "ATCH_FILE"
    		   	, headerText : "첨부파일"
    		   	, visible : false
    		   	, editable : false
    		   	//width: 120
    		   }
    		   ,{
    		   	  dataField : "FILE_CNT"
    		   	, headerText : "계약서"
    		   	, editable : false
    			, renderer : {
    				type : "ButtonRenderer",
    				onclick : function(rowIndex, columnIndex, value, item) {
    					var param = {
    							 parent_value : item.ATCH_FILE
    					};
    					//AUIGrid.removeAjaxLoader(myGridID);
    					mkLayerPopupOpen("/ctms/f01/CTMF0105.do",param);
    				}
    			  }
    		   }
    		   ,{
    		   	  dataField : "CONFM_ENNC"
    		   	, headerText : "승인유무"
    		   	, editable : false
    		   }
    		   ,{
     		   	  dataField : "INSTT_CODE"
     		   	, headerText : "기관코드"
     		    , visible : false
     		   }
    		   ,{
      		   	  dataField : "RSRCHMAN_NO"
      		   	, headerText : "연구자번호"
      		    , visible : false
      		   }
    		   ,{
       		   	  dataField : "CNTRCT_SN"
       		   	, headerText : "계약순번"
       		    , visible : false
       		   }
		  ],

		  //AUI 그리드 생성
		  createGrid: function() {
		    var me = this;
		    
		    //이후 객체.id 로 AUIGrid 컨트롤
		    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		    myGrid = me.id;
		    me.binding();

		    me.dialog();//popup
		    
		    if(me.proxy.autoLoad) {
				me.load();
		    }

		    //me.createPagingNavigator(1);
		  },
		  
		  updateGrid: function() {
			    var me = this;

			    var item = {};
				item.STTUS = $("#name").val();
				item.GOAL_CO = $("#in_goalCo").val();
				AUIGrid.updateRow(myGrid, item, currentRowIndex);
			  },

		  dialog: function() {
		 		var me = this;

		 		me._dialog = $( "#"+me.dialogId ).dialog({
		 		      autoOpen: false,
		 		      height: 280,
		 		      width: 280,
		 		      modal: true,
		 			  headerHeight:40,
		 			  position : { my: "center", at: "center", of: $("#grid_wrap") },
		 		      buttons: {
		 		        "저장": updateGridRow
// 		 		        ,
// 		 		        "취소": function(event) {
// 		 		        	me._dialog.dialog( "close" );
// 		 		        }
		 		      }
		 		    });
		  },

		  //AUI 그리드 이벤트 
		  binding: function() {
			var me = this;

			AUIGrid.bind(me.id, "cellEditBegin", function(event) {
				currentRowIndex = event.rowIndex; // // 에디팅 시작 시 해당 행 인덱스 보관
				setFieldToEditWindow(event.item);
				me._dialog.dialog( "open" );
				
				return false; // false 반환하면 그리드 내장 에디터 표시 안함.(더 이상 진행 안함)
			});
						  
			AUIGrid.bind(me.id, "updateRow", function(event) {
				me._dialog.dialog( "close" ); // 다이얼로그 닫기

				var arJson = [];
				var editedItems = AUIGrid.getEditedRowItems("#grid_wrap");

				for(var i = 0; i < editedItems.length; i++) {
					editedItems[i].CURD = 'U';
					editedItems[i].UPDATE_ID = 'admin';
					arJson.push(editedItems[i]);
				}

				$.ajax({
					  url : './updateElectContractStatus.do' ,
					  type: 'post',
					  contentType: "application/json; charset=UTF-8",
					  data : JSON.stringify(arJson),
					  success : function(data, textStatus, jqXHR) {
						  var gridData = data;

						  if(data.success) {					 
							   $("#grid_wrap").load();
							   AUIGrid.setProperty("#grid_wrap", "editable" , true ); 
							   me.load();
						  } else {
							  AUIGrid.removeAjaxLoader("#grid_wrap");
							  alert(data.message);
						  }
					  }, 
					  error : function(jqXHR, textStatus, errorThrown){
						  alert(textStatus);
					  }
				});
				
				console.log("Grid Update.....");
			});
		  },
		  //AUI 그리드 데이터 요청
		  load: function(v1, v2) {
		 		var me = this;
		 		
		 		//autoLoad로 처음 화면 데이터 로딩 
		 		if(me.proxy.paging && !v1 && !v2) {
		 			me.proxy.param.page = me.div.paging.currentPage;		
		 			me.proxy.param.count= me.div.paging.rowCount;		
		 		}
		 		
		 		//moveToPage 로 데이터 요청
		 		if(v1 && v2) {
		 			me.proxy.param.page = v2;	
		 			me.div.paging.currentPage = v2;
		 			me.proxy.param.count = v1;		
		 			me.div.paging.rowCount = v1;		
		 		}
		 		
		 		AUIGrid.showAjaxLoader(me.id);
		 		
		 		var searchArr = {'TASK_NO' :$("#taskNo").val()};
		 		
		 		$.ajax({
		 		    url: me.proxy.url,
		 		    type: me.proxy.type,
		 		    //dataType: me.proxy.dataType,
		 		    data: searchArr, //me.proxy.param,
		 		    success:function(data){
		 		    	if(data.success) {
		 			    	AUIGrid.removeAjaxLoader(me.id);
		 			    	AUIGrid.setGridData(me.id, data.result);
		 			    	AUIGrid.setSelectionByIndex(me.id, 0);

		 			    	//샘플때문에 페이징 나타나게 하기위해 임의의 값 넣어줌 
//		  			    	data.count = 13;
//		  			    	console.log(data.count);
		 			    	//paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
		 			    	if(data.count && me.proxy.paging) {
		 			    		
		 			    		me.div.paging.totalRowCount = data.count;
		 			    		me.createPagingNavigator(me.div.paging.currentPage);
		 			    	}
		 		    	} else {
		 		    		AUIGrid.removeAjaxLoader(me.id);
		 		    		alert(data.message);
		 		    	}
		 		    },
					error : function(jqXHR, textStatus, errorThrown){
						alert(textStatus);
					}
		 		});
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

		            //console.log(goPage)
		    
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
		    retStr += "<a href='javascript:myGridOption.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
		    // 이전
		    retStr += "<a href='javascript:myGridOption.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
		    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
		      if (goPage == i) {
		        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
		      } else {
		        retStr += "<a href='javascript:myGridOption.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
		        retStr += i;
		        retStr += "</span></a>";

		  console.log(prevPage)
		      }
		      
		      if (i >= me.div.paging.totalPage) {
		        break;
		      }
		    }

		    // 다음
		    retStr += "<a href='javascript:myGridOption.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
		    // 마지막
		    retStr += "<a href='javascript:myGridOption.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
		    retStr += "</span>";
		    ;

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

function updateGridRow() {
	var item = {};
	item.STTUS = $("#rdo_status").val();
	item.GOAL_CO = $("#in_goalCo").val();
    myGridOption.updateGrid();
}

function fn_searchClick(){	
	myGridOption.load();
}

function setFieldToEditWindow(gridItem) {
	$("#rdo_status").html(gridItem.STTUS);
	$("#in_goalCo").val(gridItem.GOAL_CO);
}

window.onresize = function() {
	// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
	if (typeof myGridOption.id !== "undefined") {
		AUIGrid.resize(myGridOption.id);
	}
};

</script>
</head>
<body>

<div id="wrap">
<!-- 헤더 호출 -->
<c:import url="/com/topHeader.do" charEncoding="utf-8"/>
<!-- 레프트 호출 -->
<c:import url="/com/lnb.do" charEncoding="utf-8"/>
	<!-- 메인 시작 -->
    <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>계약관리</h3>

                <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Report</a></li>
                    </ul>
                </nav>
            </article>


            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>전자계약</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 전체메뉴라인 시작-->        
                    <article class="conTitBtn">

                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                        <!--검색 설정 숨겨진 부분 시작-->
                            <!-- ul class="disNn">
                                <li><input type="checkbox" id="direction" value="direction" checked="checked">
                                    <label for="direction">진행 방향 : forward(or backword)</label>
                                </li>
                                <li><input type="checkbox" id="caseSensitive" value="caseSensitive">
                                    <label for="caseSensitive">대소문자 구분(caseSensitive)</label>
                                </li>
                                <li><input type="checkbox" id="wholeWord" value="wholeWord">
                                    <label for="wholeWord">온전한 단어(wholeWord)</label>
                                </li>
                                <li><input type="checkbox" id="wrapSearch" value="wrapSearch" checked="checked">
                                    <label for="wrapSearch">끝에서 되돌리기(wrapSearch)</label>
                                </li>
                            </ul-->
                            <!--검색 설정 숨겨진 부분 끝-->

                             과제번호 : <input type="text" id="taskNo" name="taskNo" class="pdR15"><input type="button" class="btn mgL3" onclick="fn_searchClick()" value="검색">
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <!-- div class="conTitBtnR">
                            <input type="button" onclick="addRow('first')" value="행추가">
                            <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                            <input type="button" value="저장">
                        </div-->
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
                    </article>
                    <!-- 그리드 끝 -->

                </div>

            </section>
            <!-- 컨텐츠박스 끝-->





        </div>
    </section>

</div>

<!-- 수정창 다이얼로그 -->
<div id="editWindow" style="display:none" title="상태변경">
    <fieldset>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="01">계약(후지금)<br>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="02">계약(선지금)<br>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="03">수락<br>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="04">거절<br>
             목표례수 : <input type="text" name="in_goalCo" id="in_goalCo" class="text"></input>

      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px"></input>
    </fieldset>
</div>
<!-- 수정창 다이얼로그 -->

</body>
</html>