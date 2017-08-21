

<%@page pageEncoding="UTF-8"%>    



<script>

var testData_001 =[
{
	  "구분":"포장",
	  "IP Type":"IP",
	  "등록 재고 수량":""
}, {
	  "구분":"포장",
	  "IP Type":"RI",
	  "등록 재고 수량":""
}, {
	  "구분":"샘플링",
	  "IP Type":"IP",
	  "등록 재고 수량":""
}, {
	  "구분":"샘플링",
	  "IP Type":"RI",
	  "등록 재고 수량":""
}, {
	  "구분":"미포장",
	  "IP Type":"IP",
	  "등록 재고 수량":""
}, {
	  "구분":"미포장",
	  "IP Type":"RI",
	  "등록 재고 수량":""
}];




var myGridOption_001 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_001'
  },
  proxy: {
   // url: 'selectTest2.do',
    param: {},
    type: 'post',
    dataType: 'json',
    autoLoad: true,
  },
  gridPros: {
    showRowNumColumn : false,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37,
    enableCellMerge : true
  },
  columnLayout : [{
	    dataField : "구분",
	    headerText : "구분",
	    cellMerge : true
  },{
	    dataField : "IP Type",
	    headerText : "IP Type"
  },{
	    dataField : "등록 재고 수량",
	    headerText : "등록 재고 수량"
  }],

  createGrid: function() {
    var me = this;
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
  binding: function() { },
  load: function(v1, v2) {
    var me = this;
    AUIGrid.setGridData(me.id, testData_001);
  }
};






$(function() {
	myGridOption_001.createGrid();
		
	$("#btnClose").click(function(){ 				
		layerClose();
	});
});


</script>

<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>설정 확인</h5>
			<article class="mgT5">
				<div id="grid_wrap_001" class="gridHeiSz06 grid_wrap tb01_2"></div>
			</article>

			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="" value="적용" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


