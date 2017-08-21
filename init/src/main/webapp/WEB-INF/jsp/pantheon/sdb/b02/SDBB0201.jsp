<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript">


$(function(){
	
	$('#delngln_nm').mkSearchEnter('btnSearch');
	
	btnInit();
	
	grOrgan_List.createGrid();
	  
	 
	  
	
});

function btnInit(){
	$('#btnSearch').click(function(){	  	
		  grOrgan_List.load();	  	 
	});
	  
	$('#btnAdd').click(function(){	  	
		  location.href ="/sdb/b02/SDBB0202.do";	  	 
	});
	  
	$('#btnExcel').click(function() {
		
		var data = AUIGrid.getGridData(grOrgan_List.id);
		
		if(data.length) {
			var exportProps = {
					fileName : "Study_List"
			};
			AUIGrid.setProperty(grOrgan_List.id, "exportURL", '/com/z02/downloadAuiGridFile.do');
			AUIGrid.exportToXlsx(grOrgan_List.id, true, exportProps);
		} else {
			alert('데이터 확인');
		}
	});
}



var me;
var grOrgan_List = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grOrgan_List.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grOrgan_List',
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
    	DELNGLN_NM : $('#delngln_nm').val()
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
    // 페이징 사용
    //usePaging : true,
    
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
	    dataField : "DELNGLN_NM",
	    headerText : "거래선",
	    filter : {
 			showIcon : true
 		}
  },{
    dataField : "DELNGLN_CODE",
    headerText : "거래선 코드",    
    filter : {
			showIcon : true
		}
  },{
    dataField : "DMSTC_SE",
    headerText : "국내/국외",
    filter : {
			showIcon : true
		}
  },{
    dataField : "DELNGLN_SE",
    headerText : "거래선구분",
    filter : {
			showIcon : true
		}
  },{
    dataField : "CNTRCT_FILE_ID",
    headerText : "계약서",
    renderer : { // HTML 템플릿 렌더러 사용
		type : "TemplateRenderer"
	},
	// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
	labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
		if(!value)	return "";		
		var template = '<div style=" margin:0 auto;">';		
		template += '<a href="#" class="my_a_tag" style=" padding:10px 10px 0 0; display:block; text-align:center;" onclick="javascript:fn_downFile('+ value +','+ item.DETAIL_SN+');"><img src="/images/pantheon/common/AUIGrid/download_icon.png"/>';		
		template += '</a></div>';
		return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
	},
	width:65
  },{
    dataField : "DETAIL_SN",
    headerText : "DETAIL_SN",
    visible : false
  }],

  //AUI 그리드 생성
  createGrid: function() {
    me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    AUIGrid.bind(me.id, "cellDoubleClick", auiGridCellDoubleClickHandler);
    if(me.proxy.autoLoad) {
      console.log('1');
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
		var param = {
				DELNGLN_NM : $('#delngln_nm').val()
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




 // 윈도우 리사이징 이벤트
  window.onresize = function() {
  // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
  if (typeof grOrgan_List.id !== "undefined") {
    AUIGrid.resize(grOrgan_List.id);
    }  

  };

  function auiGridCellDoubleClickHandler(){
	  
	  var str = "";
		var i, rowItem, rowInfoObj, dataField;
		
		selectionMode = AUIGrid.getProperty(me.id, "selectionMode");
		
		var selectedItems = AUIGrid.getSelectedItems(me.id);	
		
		rowInfoObj = selectedItems[0];
		rowItem = rowInfoObj.item;		
		
		if(selectedItems.length <= 0) {
			alert("없음");
			return;
		}
		
		$('#iDELNGLN_CODE').val(rowItem.DELNGLN_CODE);
		$('#iform').submit();
		
  }

  function fn_downFile(fileMastrSn, fileSn){
		window.open("<c:url value='/sdb/b01/selectDmFileDetailByPk.do?FILE_MASTR_SN="+fileMastrSn+"&DETAIL_SN="+fileSn+"'/>");
	}

</script>

 </head>

<body>
<form id="iform" method="post" action="/sdb/b02/SDBB0202.do">
	<input type="hidden" name="DELNGLN_CODE" id="iDELNGLN_CODE" />
</form>
<div id="wrap">
	<!-- 헤더 호출 -->
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0201&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0201&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
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
								<span style="font-family:'NanumGothicBold';">거래선명 :</span>
								<input type="text" id="delngln_nm" class="pdR15">								
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
                        <div id="grOrgan_List" class="gridHeiSz15 grOrgan_List grid_wrap tb01_2"></div>
                        <!-- 그리드 페이징 네비게이터 -->
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