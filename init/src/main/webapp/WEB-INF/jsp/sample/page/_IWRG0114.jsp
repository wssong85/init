

<%@page pageEncoding="UTF-8"%>    



<script>

var testData_001 =[
{
	  "Factor Name":"성별",
	  "Label 1":"Sex",
	  "No of Levels":"1",
	  "Level Description":"Sex = M",
	  "Label 2":"ML"
}, {
	  "Factor Name":"성별",
	  "Label 1":"Sex",
	  "No of Levels":"1",
	  "Level Description":"Sex = F",
	  "Label 2":"MF"
}, {
	  "Factor Name":"수축기 혈압",
	  "Label 1":"SBP",
	  "No of Levels":"1",
	  "Level Description":"SBP < 100",
	  "Label 2":""
}, {
	  "Factor Name":"수축기 혈압",
	  "Label 1":"SBP",
	  "No of Levels":"2",
	  "Level Description":"100 <= SBP >= 150",
	  "Label 2":""
}, {
	  "Factor Name":"수축기 혈압",
	  "Label 1":"SBP",
	  "No of Levels":"3",
	  "Level Description":"SBP > 150",
	  "Label 2":""
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
    showRowNumColumn : true,
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
	    dataField : "Factor Name",
	    headerText : "Factor Name",
	    width : 120,
	    cellMerge : true
  },{
	    dataField : "Label 1",
	    headerText : "Label 1",
	    width : 100,
	    cellMerge : true
  },{
	    dataField : "No of Levels",
	    width : 100,
	    headerText : "No of Levels"
  },{
	    dataField : "Level Description",
	    headerText : "Level Description"
  },{
	    dataField : "Label 2",
	    headerText : "Label 2"
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
	<div class="popup wd800">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>IP 코드 생성 결과</h5>
			<article class="mgT5">
				<div id="grid_wrap_001" class="gridHeiSz05 grid_wrap tb01_2"></div>
			</article>

			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="" value="수정" />
					<input type="button" id="" value="저장" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


