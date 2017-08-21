<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>기관 리스트</title>
<script type="text/javascript">
$(function(){
	
	$('#txtinstt_nm').mkSearchEnter('btnSearch');
	
	btninit();
	grOrganList2.createGrid();
});

function btninit(){
 //검색 
  $('#btnSearch').click(function(){	  	
	  grOrganList2.load();	  
	  
  });
  
  $('#btnAdd').click(function(){	  	
	  location.replace("/sdb/b03/SDBB0302.do");	  	 
  });
	  
	$('#btnExcel').click(function() {
		
		var data = AUIGrid.getGridData(grOrganList2.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grOrganList2.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grOrganList2.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
//    $('#txtinstt_nm').on('keyup', function(e){
// 	  if(e.which ==13)
// 		  $('#btnSearch').trigger('click');
//    });
// 	$("#txtinstt_nm").keypress(function(e){	
// 		var code = e.which?e.which:event.keyCode
// 		if(code== 13){
// 			$('#btnSearch').trigger('click');
// 		}
// 	 });
	 
}

//윈도우 리사이징 이벤트
window.onresize = function() {
// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
if (typeof grOrganList2.id !== "undefined") {
  AUIGrid.resize(grOrganList2.id);
  }  

};


var me;
var grOrganList2 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grOrganList2.id);
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
    url: './selectOrganList.do',
    param: {
    	INSTT_NM : $('#txtinstt_nm').val()
    },
    type: 'post',
    dataType: 'json',
    //페이징 true, false 로 지정
    paging: false,
    //처음 시작시 데이터 로딩
    autoLoad: true,
  },
  //AUI 그리드 옵션
 gridPros: {
		selectionMode: 'singleRow',
		editable: false,		
	    usePaging : false,
	    enableFilter : true,
	    pageRowCount : 5,
	    showPageButtonCount : 5,
	    headerHeight: 40,
	    fixedColumnCount : 3,
	    rowHeight: 37
 	},
  //AUI 그리드 레이아웃
  columnLayout : [{
	    dataField : "INSTT_NO",
	    headerText : "기관번호",
	    visible : false
  },{
    dataField : "INSTT_SE",
    headerText : "Report Type",
    width : 130,
    filter : {
			showIcon : true
		}
  },{
    dataField : "INSTT_NM",
    headerText : "Site",
    width : 100,
    filter : {
			showIcon : true
		}
  },{
	    dataField : "INSTT_CODE",
	    headerText : "Site No.",	    
	    filter : {
				showIcon : true
			}
  },{
    dataField : "REPORTR",
    headerText : "Reporter",
    filter : {
			showIcon : true
		}
  },{
    dataField : "EMAIL",
    headerText : "EMAIL",
    filter : {
			showIcon : true
		}
  }],

  createGrid: function() {
		var me = this;
		
		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros); 		
		AUIGrid.bind(me.id, "cellDoubleClick", auiGridCellDoubleClickHandler); 		 		
		me.binding();
		
		if(me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 이벤트 
	binding: function() {
		var me = this;
		
	},
	//AUI 그리드 데이터 요청
	load: function(v1, v2) {
		var me = this;
		var param = {
			INSTT_NM : $('#txtinstt_nm').val()
		};
		AUIGrid.showAjaxLoader(me.id);
		$.ajax({
		    url: me.proxy.url,
		    type: me.proxy.type,
		    dataType: me.proxy.dataType,
		    data: param,
		    success:function(data){
		    	if(data.success) {
			    	AUIGrid.removeAjaxLoader(me.id);
			    	AUIGrid.setGridData(me.id, data.result);
			    	AUIGrid.setSelectionByIndex(me.id, 0);
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



  function auiGridCellDoubleClickHandler(){
	  
	  var str = "";
		var i, rowItem, rowInfoObj, dataField;
		
		selectionMode = AUIGrid.getProperty(grOrganList2.id, "selectionMode");
		
		var selectedItems = AUIGrid.getSelectedItems(grOrganList2.id);	
		
		rowInfoObj = selectedItems[0];
		rowItem = rowInfoObj.item;
		//location.replace("/sdb/b03/SDBB0302.do?DELNGLN_CODE="+rowItem.DELNGLN_CODE);
		url = "/sdb/b03/SDBB0302.do";
		id ="INSTT_NO";
		val =rowItem.INSTT_NO;
		POSTSend(url, id, val); 
  }


</script>

 </head>

<body>

<div id="wrap">
	<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0301&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0301&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
    <section id="mainCon">
        <div class="mainConInner">
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
                    <!-- 상단 그리드 전체메뉴라인 시작-->        
                    <article class="conGridUpper">
                       
                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                        <!--검색 설정 숨겨진 부분 시작-->
							
								<span style="font-family:'NanumGothicBold';">기관명 :  </span>
								<input type="text" id="txtinstt_nm" class="pdR15">
								<input type="button" id="btnSearch" value="검색">
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작--> 
                        <div class="conTitBtnR">
							<input type="button" id="btnAdd" value="추가">
							 <input type="button" id="btnExcel" value="엑셀">
                            
                        </div>
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT45">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="gridHeiSz15 grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
<!--                         <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div> -->
                    </article>
                    <!-- 그리드 끝 -->

                </div>

            </section>
            <!-- 컨텐츠박스 끝-->


        </div>
    </section>

</div>

</body>

</html>