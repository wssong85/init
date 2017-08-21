

<%@page pageEncoding="UTF-8"%>    




<script>

var testData_001 =[
{
  "MedDRA version for reaction(s)event(s) recurred":"input Q E",
  "If yes, which reaction(s)/event(s) recurred?":"input Q E"
}, {
  "MedDRA version for reaction(s)event(s) recurred":"input Q E",
  "If yes, which reaction(s)/event(s) recurred?":"input Q E"
}, {
  "MedDRA version for reaction(s)event(s) recurred":"input Q E",
  "If yes, which reaction(s)/event(s) recurred?":"input Q E"
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
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "MedDRA version for reaction(s)event(s) recurred",
    headerText : "MedDRA version for reaction(s)event(s) recurred"
  },{
    dataField : "If yes, which reaction(s)/event(s) recurred?",
    headerText : "If yes, which reaction(s)/event(s) recurred?"
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



var testData_002 =[
{
  "Additional information on drug":"input Q E"
}, {
   "Additional information on drug":"input Q E"
}, {
   "Additional information on drug":"input Q E"
}];



var myGridOption_002 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_002'
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
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "Additional information on drug",
    headerText : "Additional information on drug"
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
    AUIGrid.setGridData(me.id, testData_002);
  }
};




var testData_003 =[
{
  "MedDRA version for Reaction assessed":"input Q E",
  "Reaction assessed":"input Q E",
  "Source of assessment":"input Q E",
  "Method of assessment":"input Q E",
  "Result":"input Q E"
}, {
  "MedDRA version for Reaction assessed":"input Q E",
  "Reaction assessed":"input Q E",
  "Source of assessment":"input Q E",
  "Method of assessment":"input Q E",
  "Result":"input Q E"
}, {
  "MedDRA version for Reaction assessed":"input Q E",
  "Reaction assessed":"input Q E",
  "Source of assessment":"input Q E",
  "Method of assessment":"input Q E",
  "Result":"input Q E"
}];



var myGridOption_003 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_003'
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
    rowHeight: 37
  },
  columnLayout : [{
    dataField : "MedDRA version for Reaction assessed",
    headerText : "MedDRA version for Reaction assessed"
  },{
    dataField : "Reaction assessed",
    headerText : "Reaction assessed"
  },{
    dataField : "Source of assessment",
    headerText : "Source of assessment"
  },{
    dataField : "Method of assessment",
    headerText : "Method of assessment"
  },{
    dataField : "Result",
    headerText : "Result"
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
    AUIGrid.setGridData(me.id, testData_003);
  }
};








$(document).ready(function() {
  myGridOption_001.createGrid();
  myGridOption_002.createGrid();
  myGridOption_003.createGrid();
});


$(window).resize(function() {
	if (myGridOption_001.id) {
		AUIGrid.resize(myGridOption_001.id);
	}
	if (myGridOption_002.id) {
		AUIGrid.resize(myGridOption_002.id);
	}
	if (myGridOption_003.id) {
		AUIGrid.resize(myGridOption_003.id);
	}
});





$(function() {
	$("#btnClose").click(function(){ 				
		layerClose();
	});
});

</script>

<section class="popupWrap">
	<div class="popup wd1000">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>Drug 팝업</h5>
			

            <article class="conTitBtnR">
				<input type="button" id="btnSave" class="btn mgL3" value="초기화">
				<input type="button" id="btnSave" class="btn mgL3" value="저장">
            </article>
			<div style="clear:both; height:10px; "></div>
			
			<div style=" height:600px; border-top:1px solid #cccccc;border-bottom:1px solid #cccccc; overflow-y: scroll;">
			
				<article>
					

	
					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="30%" />
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>Characterization of drug role</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Proprietary medicinal product name</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
							</tr>
							<tr>
								<th>Active Drug substance names</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
								<th>Identification of the country where the drug was obtained</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
							</tr>
							<tr>
								<th>Batch/lot number</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Authorization/Application Number</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Country of authorization/application</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
								<th>Name of holder/applicant</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
							</tr>
							<tr>
								<th>Structure Dosage Number</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Structure Dosage Number Unit</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Receiver Street Address</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
								<th>Receiver City</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
							</tr>
							<tr>
								<th>number of separate dosages</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
								<th>number of units in the interval</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>definition of the interval</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th></th>
								<td></td>
							</tr>
							<tr>
								<th>Drug Cumulative Dosage number</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Drug Cumulative Dosage number Unit</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Dosage text</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
								<th>Pharmaceutical form(Dosage form)</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
							</tr>
							<tr>
								<th>Route of administration</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Parent route od administration (in case of a parent child/fetus report)</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Gestation period at time of exposure</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
								<th>Gestation period at time of exposure Unit</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>MedDRA version for indication</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
								<th>Indication for use in the case</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td>
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
												<input type="button" class="oneBtn" popup_type="E" value="E">
											</td>
										</tr>
									</table>
									<input type="hidden" id="" />
									<label popup_type="Label" id=""></label>
								</td>
							</tr>
							<tr>
								<th>Date of start of drug Format</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Date of start of drug</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Drug start period</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Drug start period Unit</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Drug last period</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Drug last period Unit</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Drug End Date Format</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
	
								</td>
								<th>Drug End Date</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Drug Treatment Duration</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="text" id="" style="width:100%;">
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Drug Treatment Duration Unit</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th>Action(s) taken with drug</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<select id="" style="width:100%;">
													<option value=''>===selected===</option>
													<option value=''>data</option>
												</select>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
								<th>Did reaction recur on readministration?</th>
								<td>
									<table class="in_table">
										<tr>
											<th>
												<input type="radio" id="d11" name="d1"><label for="d11" class="raLab"><span>Yes</span></label>
												<input type="radio" id="d12" name="d1"><label for="d12" class="raLab"><span>No</span></label>
												<input type="radio" id="d13" name="d1"><label for="d13" class="raLab"><span>Unknown</span></label>
											</th>
											<td style="width: 32px;">
												<input type="button" class="oneBtn" popup_type="Q"  value="Q">
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
	
	
					<div style="height:10px;"></div>


					<div style=" width:50%; display:inline-block; padding:6px; box-sizing: border-box; ">
	                    <article class="conTitBox">
	                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Drug Recurrence</h6>
	                    </article>
	                    
	
	                    <article class="conTitBtnR">
	                        <input type="button" id="" value="행추가">
	                        <input type="button" id="" value="행삭제">
	                    </article>
	                    
						<div style="height:10px;"></div>
	
						<div id="grid_wrap_001" class="gridHeiSz02 grid_wrap tb01_2"></div>
					</div>
                    
                    
                    <div style=" width:49.54%; display:inline-block; padding:6px; box-sizing: border-box; ">
	                    <article class="conTitBox">
	                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Drug</h6>
	                    </article>
	
	                    <article class="conTitBtnR">
	                        <input type="button" id="" value="행추가">
	                        <input type="button" id="" value="행삭제">
	                    </article>
	                    
						<div style="height:10px;"></div>
						
						<div id="grid_wrap_002" class="gridHeiSz02 grid_wrap tb01_2"></div>
					</div>
			                    

                    
                    <div style="padding:6px; box-sizing: border-box;">
	                    <article class="conTitBox">
	                        <h6 style="font-size:13px; line-height:20px; color:#333333; font-family:'NanumGothicBold';">Drug Reaction Relatedness</h6>
	                    </article>
	
	                    <article class="conTitBtnR">
	                        <input type="button" id="" value="행추가">
	                        <input type="button" id="" value="행삭제">
	                    </article>
	                    
						<div style="height:10px;"></div>
						
						<div id="grid_wrap_003" class="gridHeiSz02 grid_wrap tb01_2"></div>
					</div>

				</article>
				
				<div style="height:20px;"></div>
			
			</div>
			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


