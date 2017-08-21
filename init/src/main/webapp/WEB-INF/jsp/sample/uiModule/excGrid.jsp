<%@page pageEncoding="UTF-8"%> 

<!DOCTYPE HTML>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=IE9" charset="utf-8">
  <title>excGrid Module</title>
  <link rel="shortcut icon" href="../../../images/pantheon/common/favicon.ico">
  <link rel="stylesheet" href="../../../css/pantheon/common/reset.css">
  <link rel="stylesheet" href="../../../css/pantheon/common/sub.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/layout.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/common.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/contents.css"> 
  <link rel="stylesheet" href="../../../css/pantheon/common/theme.css" > 
  <link rel="stylesheet" href="../../../css/pantheon/common/jquery-ui.css" > 
  <script src="../../../js/pantheon/common/jquery-2.1.1.js"></script>
  <script src="../../../js/pantheon/common/jquery-ui.min.js"></script>
  <script src="../../../js/pantheon/common/jquery.mobile-events.js"></script>
  <script src="../../../js/pantheon/common/common.js"></script>
  <script src="../../../js/pantheon/common/theme.js"></script>
  <script src="../../../js/pantheon/common/layout.js"></script>
  <script src="../../../js/pantheon/common/sub.js"></script>
  <!--[if lt IE 9]>
  <script src="../../../js/pantheon/common/jquery-1.11.3.min.js"></script>
  <script src="../../../js/pantheon/common/html5shiv.js"></script>
  <script src="../../../js/pantheon/common/PIE.js"></script>
  <script src="../../../js/pantheon/common/respond.min.js"></script>
  <script src="https://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
  <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE8.js"></script>
  <script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
  <![endif]-->

  <!-- 그리드 CSS&JS -->
  <link href="../../../css/pantheon/common/AUIGrid/AUIGrid_style.css" rel="stylesheet">
  <script type="text/javascript" src="../../../js/pantheon/common/AUIGrid/AUIGridLicense.js"></script>
  <script type="text/javascript" src="../../../js/pantheon/common/AUIGrid/AUIGrid.js"></script>

<script type="text/javascript">

var testData =[
{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
}, {
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
},{
  "ID":"1",
  "NAME":"name1",
  "ID_":"1",
  "NAME_":"name1",
  "ID_1":"1",
  "NAME_1":"name1"
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
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
    width : 200
  },{
    dataField : "NAME",
    headerText : "NAME",
    width : 200
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],


  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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



//행추가, 행삭제 시작

function addRow(rowPos) {
  var item = new Object();
  
  // rowIdField 로 지정한 id 는 그리드가 row 추가 시 자동으로 중복되지 않게 생성합니다.
  // DB 에서 Insert 시 실제 PK 값 결정하십시오.
  
  /*
  item.name = $("#t_name").val();
  item.country = $("#t_country").val();
  item.color = $("#t_color").val();
  item.product = $("#t_product").val();
  item.price = $("#t_price").val();
  item.date = $("#t_date").val();
*/ 

  // parameter
  // item : 삽입하고자 하는 아이템 Object
  // rowPos : rowIndex 인 경우 해당 index 에 삽입, first : 최상단, last : 최하단, selectionUp : 선택된 곳 위, selectionDown : 선택된 곳 아래
  AUIGrid.addRow(myGridOption.id, item, rowPos);
  
   $("#t_name").val("AUI-" + (++cnt));
   $("#t_country").val(countries[cnt % countries.length ]);
}

function removeRow(rowPos) {
  AUIGrid.removeRow(myGridOption.id, rowPos);
}


// 추가, 수정, 삭제 된 아이템들 확인하기
function checkItems() {
  
  // 추가된 행 아이템들(배열)
  var addedRowItems = AUIGrid.getAddedRowItems(myGridOption.id);
   
  // 수정된 행 아이템들(배열)
  var editedRowItems = AUIGrid.getEditedRowColumnItems(myGridOption.id); 
  
  // 삭제된 행 아이템들(배열)
  var removedRowItems = AUIGrid.getRemovedItems(myGridOption.id);
  
  var i, len, name, rowItem;
  var str = "";
  
  if(addedRowItems.length > 0) {
    str += "---추가된 행\r\n";
    for(i=0, len=addedRowItems.length; i<len; i++) {
      rowItem = addedRowItems[i]; // 행아이템
      // 전체 조회
      for(var name in rowItem) {
        str += name + " : " + rowItem[name] + ", "; 
      }
      str += "\r\n";
    }
  }
  
  if(editedRowItems.length > 0) {
    str += "---수정된 행\r\n";
    for(i=0, len=editedRowItems.length; i<len; i++) {
      rowItem = editedRowItems[i]; // 행아이템
      
      // 전체 조회
      for(var name in rowItem) {
        str += name + " : " + rowItem[name] + ", "; 
      }
      str += "\r\n";
    }
  }
  
  if(removedRowItems.length > 0) {
    str += "---삭제된 행\r\n";
    for(i=0, len=removedRowItems.length; i<len; i++) {
      rowItem = removedRowItems[i]; // 행아이템
      // 전체 조회
      for(var name in rowItem) {
        str += name + " : " + rowItem[name] + ", "; 
      }
      str += "\r\n";
    }
  }
  
  // 하단에 정보 출력.
  $("#desc_info").html("추가 개수 : " + addedRowItems.length + ", 수정 개수 : " + editedRowItems.length + ", 삭제 개수 : " + removedRowItems.length); 
  
  
  if(str == "")
    str = "변경 사항 없음";
  
  alert(str);
}
//행추가, 행삭제 끝


var myGridOption2 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap2',
    paging: {
      pagingDiv: 'grid_paging2',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
    width : 200
  },{
    dataField : "NAME",
    headerText : "NAME",
    width : 200
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<a href='javascript:myGridOption2.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption2.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption2.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption2.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption2.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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

var myGridOption3 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap3',
    paging: {
      pagingDiv: 'grid_paging3',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<a href='javascript:myGridOption3.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption3.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption3.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption3.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption3.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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



var myGridOption4 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap4',
    paging: {
      pagingDiv: 'grid_paging4',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption4.div.paging.currentPage, this.value)'>"
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
    retStr += "<a href='javascript:myGridOption4.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption4.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption4.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption4.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption4.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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


var myGridOption5 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap5',
    paging: {
      pagingDiv: 'grid_paging5',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption4.div.paging.currentPage, this.value)'>"
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
    retStr += "<a href='javascript:myGridOption5.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption5.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption5.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption5.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption5.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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


var myGridOption6 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap6',
    paging: {
      pagingDiv: 'grid_paging6',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption4.div.paging.currentPage, this.value)'>"
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
    retStr += "<a href='javascript:myGridOption6.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption6.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption6.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption6.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption6.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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


var myGridOption7 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap7',
    paging: {
      pagingDiv: 'grid_paging7',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption4.div.paging.currentPage, this.value)'>"
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
    retStr += "<a href='javascript:myGridOption7.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption7.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption7.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption7.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption7.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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

var myGridOption8 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap8',
    paging: {
      pagingDiv: 'grid_paging8',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption4.div.paging.currentPage, this.value)'>"
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
    retStr += "<a href='javascript:myGridOption8.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption8.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption8.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption8.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption8.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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

var myGridOption9 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap9',
    paging: {
      pagingDiv: 'grid_paging9',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption4.div.paging.currentPage, this.value)'>"
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
    retStr += "<a href='javascript:myGridOption9.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption9.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption9.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption9.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption9.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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


var myGridOption10 = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap10',
    paging: {
      pagingDiv: 'grid_paging10',
      totalRowCount: 500,
      rowCount: 10,
      pageButtonCount: 4,
      currentPage: 1,
      totalPage: 0,
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: 'selectTest2.do',
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
    usePaging : true,
    
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",

    displayTreeOpen : true,
    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "ID",
    headerText : "ID",
  },{
    dataField : "NAME",
    headerText : "NAME",
  },{
    dataField : "ID_",
    headerText : "ID_",
  },{
    dataField : "NAME_",
    headerText : "NAME_",
  },{
    dataField : "ID_1",
    headerText : "ID_1",
  },{
    dataField : "NAME_1",
    headerText : "NAME_1",
   }],

   
  //AUI 그리드 생성
  createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    
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
    
    AUIGrid.setGridData(me.id, testData);
    me.div.paging.totalRowCount =testData.length;


    //me.createPagingNavigator(me.div.paging.currentPage);
  /*

  //rowCOunt = 300
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: me.proxy.param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            //AUIGrid.setGridData(me.id, data.result);
            data.count = testData.length;
            AUIGrid.setGridData(me.id, testData);
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              /*
              //me.createPagingNavigator(me.div.paging.currentPage);
            }
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });*/
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
    retStr += "<select class='rowSel' onchange='javascript:myGridOption.moveToPage(myGridOption4.div.paging.currentPage, this.value)'>"
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
    retStr += "<a href='javascript:myGridOption10.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:myGridOption10.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:myGridOption10.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }



    // 다음
    retStr += "<a href='javascript:myGridOption10.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:myGridOption10.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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
  myGridOption2.createGrid();
  myGridOption3.createGrid();
  myGridOption4.createGrid();
  myGridOption5.createGrid();
  myGridOption6.createGrid();
  myGridOption7.createGrid();
  myGridOption8.createGrid();
  myGridOption9.createGrid();
  myGridOption10.createGrid();
});

 // 윈도우 리사이징 이벤트
  window.onresize = function() {
  // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
  if (typeof myGridOption.id !== "undefined") {
    AUIGrid.resize(myGridOption.id);
    }
      if (typeof myGridOption2.id !== "undefined") {
    AUIGrid.resize(myGridOption2.id);
    }

  if (typeof myGridOption3.id !== "undefined") {
    AUIGrid.resize(myGridOption3.id);
    }

  if (typeof myGridOption4.id !== "undefined") {
    AUIGrid.resize(myGridOption4.id);
    }

  if (typeof myGridOption5.id !== "undefined") {
    AUIGrid.resize(myGridOption5.id);
    }

  if (typeof myGridOption6.id !== "undefined") {
    AUIGrid.resize(myGridOption6.id);
    }

  if (typeof myGridOption7.id !== "undefined") {
    AUIGrid.resize(myGridOption7.id);
    }

    if (typeof myGridOption8.id !== "undefined") {
    AUIGrid.resize(myGridOption8.id);
    }

    if (typeof myGridOption9.id !== "undefined") {
    AUIGrid.resize(myGridOption9.id);
    }

    if (typeof myGridOption10.id !== "undefined") {
    AUIGrid.resize(myGridOption10.id);
    }

  };

</script>

 </head>

<body>

<div id="wrap">

    <%@include file="../topHeader.jsp"%>

    <%@include file="../lnb.jsp"%>

    <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>그리드 설정별 모듈</h3>

                <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Module</a></li>
                    </ul>
                </nav>
            </article>


            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>Grid1</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 전체메뉴라인 시작-->        
                    <article class="conTitBtn">

                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                        <!--검색 설정 숨겨진 부분 시작-->
                        <!--
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
                            -->
                            <!--검색 설정 숨겨진 부분 끝-->

                            <select id="dataFieldSelect">
                                <option value="name" selected="selected">name</option>
                                <option value="contry">Country</option>
                                <option value="product">Product</option>
                                <option value="quantity">Quantity</option>
                                <option value="price">Price</option>
                                <option value="date">Date</option>
                            </select>
                            <input type="text" id="myInput" value="anna" class="pdR15"><input type="button" class="btn mgL3" onclick="searchClick()" value="검색">
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <div class="conTitBtnR">
                            <input type="button" onclick="addRow('first')" value="최상단 행추가">
                            <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                            <input type="button" value="저장">
                        </div>
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        

                    <!-- 그리드 시작 -->
                    <article class="mgT55">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap" class="grid_wrap tb01_2"></div>
                                 <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                        <!-- 그리드 페이징 네비게이터 -->
                        <!--div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div-->
                    </article>
                    <!-- 그리드 끝 -->

                </div>

            </section>
            <!-- 컨텐츠박스 끝-->





            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>Grid2</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                        <input type="button" onclick="addRow('first')" value="최상단 행추가">
                        <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                        <input type="button" value="저장">
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap2" class="grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                        <!-- 그리드 페이징 네비게이터 -->
                        <!--div id="grid_paging2" class="aui-grid-paging-panel my-grid-paging-panel"></div-->
                    </article>
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->





            <!-- 컨텐츠박스 시작-->
            <section class="conBox50 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>Grid3</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                        <input type="button" onclick="addRow('first')" value="최상단 행추가">
                        <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                        <input type="button" value="저장">
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap3" class="grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                        <!-- 그리드 페이징 네비게이터 -->
                        <!--div id="grid_paging3" class="aui-grid-paging-panel my-grid-paging-panel"></div-->
                    </article>
                    <!-- 그리드 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->




            <!-- 컨텐츠박스 시작-->
            <section class="conBox50 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠 타이틀 시작-->
                    <article class="conTitBox">
                        <h5>Grid4</h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 오른쪽 메뉴 시작-->
                    <article class="conTitBtnR">
                        <input type="button" onclick="addRow('first')" value="최상단 행추가">
                        <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                        <input type="button" value="저장">
                    </article>
                    <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    <!-- 그리드 시작 -->
                    <article class="mgT16">
                        <!-- 에이유아이 그리드가 이곳에 생성 -->
                        <div id="grid_wrap4" class="grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                        <!-- 그리드 페이징 네비게이터 -->
                        <!--div id="grid_paging4" class="aui-grid-paging-panel my-grid-paging-panel"></div-->
                    </article>
                    <!-- 그리드 끝 -->

                </div>

            </section>
            <!-- 컨텐츠박스 끝-->




            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠내부 왼쪽 특정 내용 시작-->
                    <section class="conSbtL50 conSbtL">

                        <!-- 컨텐츠 타이틀 시작-->
                        <article class="conTitBox">
                            <h5>Grid5</h5>
                        </article>
                        <!-- 컨텐츠 타이틀 끝-->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <article class="conTitBtnR">
                            <input type="button" onclick="addRow('first')" value="최상단 행추가">
                            <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                            <input type="button" value="저장">
                        </article>
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                        <!-- 그리드 시작 -->
                        <article class="mgT16">
                            <!-- 에이유아이 그리드가 이곳에 생성 -->
                            <div id="grid_wrap5" class="grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                            <!-- 그리드 페이징 네비게이터 -->
                            <!--div id="grid_paging5" class="aui-grid-paging-panel my-grid-paging-panel"></div-->
                        </article>
                        <!-- 그리드 끝 -->

                    </section>
                    <!-- 컨텐츠내부 왼쪽 특정 내용 끝-->

                    <!-- 컨텐츠내부 오른쪽 특정 내용 시작-->
                    <section class="conSbtR50 conSbtR">

                        <!-- 컨텐츠 타이틀 시작-->
                        <article class="conTitBox">
                            <h5>Grid6</h5>
                        </article>
                        <!-- 컨텐츠 타이틀 끝-->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <article class="conTitBtnR">
                            <input type="button" onclick="addRow('first')" value="최상단 행추가">
                            <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                            <input type="button" value="저장">
                        </article>
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                        <!-- 그리드 시작 -->
                        <article class="mgT16">
                            <!-- 에이유아이 그리드가 이곳에 생성 -->
                            <div id="grid_wrap6" class="grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                            <!-- 그리드 페이징 네비게이터 -->
                            <!--div id="grid_paging6" class="aui-grid-paging-panel my-grid-paging-panel"></div==>
                        </article>
                        <!-- 그리드 끝 -->

                    </section>
                    <!-- 컨텐츠내부 오른쪽 특정 내용 끝-->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->




            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 컨텐츠내부 왼쪽 특정 내용 시작-->
                    <section class="conSbtL50 conSbtL">
                        <!-- 컨텐츠 특정 내부 라인 시작-->
                        <div class="conSbtLn">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>Grid7</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 그리드 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" onclick="addRow('first')" value="최상단 행추가">
                                <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 그리드 오른쪽 메뉴 끝-->

                            <!-- 그리드 시작 -->
                            <article class="mgT16">
                                <!-- 에이유아이 그리드가 이곳에 생성 -->
                                <div id="grid_wrap7" class="grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                                <!-- 그리드 페이징 네비게이터 -->
                                <!--div id="grid_paging7" class="aui-grid-paging-panel my-grid-paging-panel"></div-->
                            </article>
                            <!-- 그리드 끝 -->

                        </div>
                        <!-- 컨텐츠 특정 내부 라인 끝-->
                    </section>
                    <!-- 컨텐츠내부 특정 내용 끝-->

                    <!-- 컨텐츠내부 오른쪽 특정 내용 시작-->
                    <section class="conSbtR50 conSbtR">
                        <!-- 컨텐츠 특정 내부 라인 시작-->
                        <div class="conSbtLn">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>Grid8</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 그리드 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" onclick="addRow('first')" value="최상단 행추가">
                                <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 그리드 오른쪽 메뉴 끝-->

                            <!-- 그리드 시작 -->
                            <article class="mgT16">
                                <!-- 에이유아이 그리드가 이곳에 생성 -->
                                <div id="grid_wrap8" class="gridHeiSz05 grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                            </article>
                            <!-- 그리드 끝 -->

                        </div>
                        <!-- 컨텐츠 특정 내부 라인 끝-->
                    </section>
                    <!-- 컨텐츠내부 오른쪽 특정 내용 끝-->

                    <!-- 컨텐츠내부 오른쪽 특정 내용 시작-->
                    <section class="conSbtR50 conSbtR mgT24">
                        <!-- 컨텐츠 특정 내부 라인 끝-->
                        <div class="conSbtLn">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>Grid9</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 그리드 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" onclick="addRow('first')" value="최상단 행추가">
                                <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 그리드 오른쪽 메뉴 끝-->

                            <!-- 그리드 시작 -->
                            <article class="mgT16">
                                <!-- 에이유아이 그리드가 이곳에 생성 -->
                                <div id="grid_wrap9" class="gridHeiSz05 grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                                <!-- 그리드 페이징 네비게이터 -->
                                <!--div id="grid_paging9" class="aui-grid-paging-panel my-grid-paging-panel"></div-->
                            </article>
                            <!-- 그리드 끝 -->

                        </div>
                        <!-- 컨텐츠 특정 내부 라인 끝-->
                    </section>
                    <!-- 컨텐츠내부 오른쪽 특정 내용 끝-->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->




            <!-- 컨텐츠박스 시작-->
            <section class="conBox100 conBox">
                <div class="conBoxInner">

                    <!-- 탭 메뉴 부분 시작 -->
                    <div id="tab" class="tab tab01">
                        <ul>
                            <li id="tab_menu1" class="port_back tab_menu">eCRF list</li>
                            <li id="tab_menu2" class="tab_menu">Template</li>
                            <li id="tab_menu3" class="tab_menu">Group</li>
                            <li id="tab_menu4" class="tab_menu">Visit</li>
                            <li id="tab_menu5" class="tab_menu">Dictionary</li>
                            <li id="tab_menu6" class="tab_menu">Layout</li>
                        </ul>
                    </div>
                    <!-- 탭 메뉴 부분 끝 -->

                    <!-- 탭 컨텐츠 부분 시작 -->
                    <article class="tab_list">
                        <div class="tab_sub1 tab_sub">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>Grid10</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 그리드 오른쪽 메뉴 시작-->
                            <article class="conTitBtnR">
                                <input type="button" onclick="addRow('first')" value="최상단 행추가">
                                <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                                <input type="button" value="저장">
                            </article>
                            <!-- 상단 그리드 오른쪽 메뉴 끝-->

                            <!-- 그리드 시작 -->
                            <article class="mgT16">
                                <!-- 에이유아이 그리드가 이곳에 생성 -->
                                <div id="grid_wrap10" class="grid_wrap tb01_2"></div>
                                <!-- row선택 시작 -->
                                <select class="rowSel2">
                                  <option value="" selected="selected">rows 선택</option>
                                  <option value="10">rows 10</option>
                                  <option value="20">rows 20</option>
                                  <option value="30">rows 30</option>
                                  <option value="40">rows 40</option>
                                  <option value="50">rows 50</option>
                                  <option value="60">rows 60</option>
                                  <option value="70">rows 70</option>
                                  <option value="80">rows 80</option>
                                  <option value="90">rows 90</option>
                                  <option value="100">rows 100</option>
                                </select>
                                <!-- row선택 끝 -->
                            </article>
                            <!-- 그리드 끝 -->

                        </div>
                        <div class="tab_sub2 tab_sub">내용2</div>
                        <div class="tab_sub3 tab_sub">내용3</div>
                        <div class="tab_sub4 tab_sub">내용4</div>
                        <div class="tab_sub5 tab_sub">내용5</div>
                        <div class="tab_sub6 tab_sub">내용6</div>
                    </article>
                    <!-- 탭 컨텐츠 부분 끝 -->

                </div>
            </section>
            <!-- 컨텐츠박스 끝-->


        </div>
    </section>

</div>

</body>

</html>