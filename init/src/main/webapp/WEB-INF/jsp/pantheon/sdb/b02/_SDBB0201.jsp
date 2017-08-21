<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript">
var me;
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
    url: './selectOrganList.do',
    param: {
    	DELNGLN_NM : $('#delngln_nm').val()
    },
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
    editable : false,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    //showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "singleRows",
    displayTreeOpen : true,    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
	    dataField : "DELNGLN_NM",
	    headerText : "거래선",
  },{
    dataField : "BRAND_NAME",
    headerText : "Brand Name",
    width : 200
  },{
    dataField : "DELNGLN_CODE",
    headerText : "거래선 코드",
    width : 200
  },{
    dataField : "DMSTC_SE",
    headerText : "국내/국외",
  },{
    dataField : "DELNGLN_SE",
    headerText : "거래선구분",
  },{
    dataField : "CNTRCT_FILE_ID",
    headerText : "계약서",
    renderer : { // HTML 템플릿 렌더러 사용
		type : "TemplateRenderer"
	},
	// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
	labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
		if(!value)	return "";		
		var template = '<div style="display:inline-block; margin-top:4px; line-height:12px;">';		
		template += '<a href="#" class="my_a_tag" onclick="javascript:fn_downFile('+ value +','+ item.DETAIL_SN+');"><img src="/images/pantheon/common/AUIGrid/download_icon.png">';		
		template += '</a></div>';
		return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
	}
  },{
    dataField : "DETAIL_SN",
    headerText : "DETAIL_SN",
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
    
    //AUIGrid.showAjaxLoader(me.id);
    
//     AUIGrid.setGridData(me.id, testData);
//     me.div.paging.totalRowCount =testData.length;


//     me.createPagingNavigator(me.div.paging.currentPage);
  

  //rowCOunt = 300
   var param = {
		   DELNGLN_NM : $('#delngln_nm').val()
   };
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            AUIGrid.setGridData(me.id, data.result);
            data.count= data.result.length;
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
          $(".aui-grid-template-renderer-wrapper").removeAttr("style");          
        },
		error : function(jqXHR, textStatus, errorThrown){
			AUIGrid.removeAjaxLoader(me.id);
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
    retStr += "<a href='javascript:myGridOption.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'> << </span></a>";
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
    retStr += "<a href='javascript:myGridOption.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'> >> </span></a>"
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
  
  //검색 
  $('#btnSearch').click(function(){	  	
	  myGridOption.load();	  	 
  });
  
  $('#btnAdd').click(function(){	  	
	  location.replace("/sdb/b03/SDBB0202.do");	  	 
  });


});

 // 윈도우 리사이징 이벤트
  window.onresize = function() {
  // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
  if (typeof myGridOption.id !== "undefined") {
    AUIGrid.resize(myGridOption.id);
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
	<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<!-- 레프트 호출 -->
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
    
    
    
    
    
    <section id="mainCon">
        <div class="mainConInner">
            <article class="mainTitBox">
            	<h3>거래선관리</h3>
                <nav id="pathNav">
                    <ul>
                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
                        <li>기본정보관리</li>
						<li>거래선관리</li>
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
                            <ul class="disNn">
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
                            </ul>
                            <!--검색 설정 숨겨진 부분 끝-->

<!--                             <select id="dataFieldSelect"> -->
<!--                                 <option value="name" selected="selected">name</option> -->
<!--                                 <option value="contry">Country</option> -->
<!--                                 <option value="product">Product</option> -->
<!--                                 <option value="quantity">Quantity</option> -->
<!--                                 <option value="price">Price</option> -->
<!--                                 <option value="date">Date</option> -->
<!--                             </select> -->

<!-- 
                            <input type="text" id="delngln_nm" class="pdR15"><input type="button" class="btn mgL3"  id="btnSearch" value="검색">
                            <input type="button" id="btnAdd" value="추가">
                            <input type="button" id="btnExcel" value="엑셀">
                            
 -->

                            
							<div class="conTitBtnL">
								<span style="font-family:'NanumGothicBold';">거래선명 :</span>
								<input type="text" id="delngln_nm" class="pdR15">
								<button class="oneBtn" type="sumit" style="left:-2px;">
									<img class="oneBtnIco" id="btnSearch" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
								 <input type="button" id="btnAdd" value="추가">
								  <input type="button" id="btnExcel" value="엑셀">
							</div>
                            
                            
                            
                            
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <div class="conTitBtnR">
<!--                             <input type="button" value="검색"> -->
                            
                        </div>
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
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

</body>

</html>