

<%@page pageEncoding="UTF-8"%>    


<style>
.pop_style .aui-grid-default-header { text-align: center;}

</style>


<script>

var testData_01 =[
{
  "Status":"정상",
  "Site":"쿼리",
  "Subject":"정상",
  "Visit":"v1",
  "CRF":"활력징후",
  "Variable":"맥박",
  "Query":"쿼리내용",
  "Role":"DM",
  "Issue":"Hwk9",
  "Query":"쿼리내용",
  "Role":"DM",
  "Issue":"Hwk9",
  "오류사유":"오류임"
}, {
  "Status":"정상",
  "Site":"쿼리",
  "Subject":"정상",
  "Visit":"v1",
  "CRF":"활력징후",
  "Variable":"맥박",
  "Query":"쿼리내용",
  "Role":"DM",
  "Issue":"Hwk9",
  "Query":"쿼리내용",
  "Role":"DM",
  "Issue":"Hwk9",
  "오류사유":"오류임"
}];






var myGridOption_01 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_01'
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
    showRowCheckColumn : true,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "업로드 파일 자료",
    headerText : "업로드 파일 자료",
	children : [{
		dataField : "Status",
		headerText : "Status"
	},{
   		dataField : "Site",
   		headerText : "Site"
	},{
   		dataField : "Subject",
   		headerText : "Subject"
	},{
   		dataField : "Visit",
   		headerText : "Visit"
	},{
   		dataField : "CRF",
   		headerText : "CRF"
	},{
   		dataField : "Variable",
   		headerText : "Variable"
	},{
   		dataField : "Query",
   		headerText : "Query"
	},{
   		dataField : "Role",
   		headerText : "Role"
	},{
   		dataField : "Issue",
   		headerText : "Issue"
	}]
  },{
    dataField : "적용 자료",
    headerText : "적용 자료",
	children : [{
		dataField : "Query",
		headerText : "Query"
	},{
   		dataField : "Role",
   		headerText : "Role"
	},{
   		dataField : "Issue",
   		headerText : "Issue"
	},{
   		dataField : "오류사유",
   		headerText : "오류사유"
	}]
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
    AUIGrid.setGridData(me.id, testData_01);
  }
};





$(document).ready(function() {
  myGridOption_01.createGrid();
});



$(window).resize(function() {
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
});



$(function() {

	$("#btnClose").click(function(){ 				
		layerClose();
	});
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});

});
</script>

<section class="popupWrap">
	<div class="popup wd960">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>쿼리 업로드</h5>
			<article class="mgT5">
				<table class="tb001">
					<colgroup>
						<col width="20%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>업로드파일</th>
							<td>
				 				<div class="fileInputArea" style="width:88%;">
					 				<input type="text" id="fileName" readonly="readonly" style="width:87%;">
					 				<input type="button" value="파일 선택" class="fileInputBtn" />
					 				<input type="file" class="fileIuputHid" style="width:100%;">
				 				</div>
								<input type="button" id="" value="업로드" />
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			
			<h6 class="mgT10">유효성 검사 : Fail(3)</h6>
			<article class="mgT5 pop_style">
				<div id="grid_wrap_01" class="gridHeiSz07 grid_wrap tb01_2"></div>
			</article>
			
			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="" value="저장" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


