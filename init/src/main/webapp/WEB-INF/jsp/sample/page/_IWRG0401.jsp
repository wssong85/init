<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>

<style>
.view_block_01{ display: block; border:1px solid red; margin-bottom:30px;}
.hide_block_01{ display: none;}

</style>

<script type="text/javascript">



var testData_01 =[
{
	  "Protocol No":"CJ-2016-301",
	  "등록일":"",
	  "등록자":""
}, {
	  "Protocol No":"CJ-2016-302",
	  "등록일":"2016.12.12",
	  "등록자":"홍길동"
}, {
	  "Protocol No":"CJ-2016-303",
	  "등록일":"2016.12.12",
	  "등록자":"홍길동"
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
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "Protocol No",
	    headerText : "Protocol No"
  },{
	    dataField : "등록일",
	    headerText : "등록일"
  },{
	    dataField : "등록자",
	    headerText : "등록자"
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





var testData_02 =[
{
	  "IP Type":"select",
	  "Start Code":"input",
	  "End Code":"input",
	  "구분":"select"
}, {
	  "IP Type":"select",
	  "Start Code":"input",
	  "End Code":"input",
	  "구분":"select"
}, {
	  "IP Type":"select",
	  "Start Code":"input",
	  "End Code":"input",
	  "구분":"select"
}];



var myGridOption_02 = {
  id: '',

  div: {
    gridDiv: '#grid_wrap_02'
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
    showRowCheckColumn : true,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : true,
    enableFilter : true,
    headerHeight: 40,
    rowHeight: 37
  },
  columnLayout : [{
	    dataField : "IP Type",
	    headerText : "IP Type"
  },{
	    dataField : "Start Code",
	    headerText : "Start Code"
  },{
	    dataField : "End Code",
	    headerText : "End Code"
  },{
	    dataField : "구분",
	    headerText : "구분"
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
    AUIGrid.setGridData(me.id, testData_02);
  }
};







$(function() {
	myGridOption_01.createGrid();
	myGridOption_02.createGrid();
	
	$(".fileIuputHid").change(function(){
		   var fileVal = $(this).val();
		   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
		});
	
	$('.popup_01').click(function(){
		mkLayerPopupOpen("./_IWRG0402.do", null);
		AUIGrid.resize(myGridOption_001.id);
	});

	
});

$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
	}
	if (myGridOption_02.id) {
		AUIGrid.resize(myGridOption_02.id);
	}
});








</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>

		<section id="mainCon">
			<div class="mainConInner">
				<article class="mainTitBox">
					<h3>공장재고 등록</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>과제관리</li>
	                        <li>공장재고 등록</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner" style="min-height:900px;">
					


						<article>
							<div class="conTitBtnL">
								<h5>Protocol List</h5>
							</div>

							<div style="clear:both; height:10px;"></div>
							
							<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>
							
						</article>
						
						<div style="height:20px;"></div>

						<h5>공장재고 등록</h5>
						
						<div style="height:10px;"></div>
						
						<div style="height:30px;">
							<div class="conTitBtnL" style="width:60%;">
								<span style="font-family:'NanumGothicBold'; position:relative; top:0px;">등록 Type :</span>
								&nbsp;
								<select style="width:60%; vertical-align:top;">
									<option value="">====선택====</option>
									<option value="">자동 설정</option>
									<option value="">매뉴얼 설정</option>
								</select>
								<input type="button" value="설정확인">
							</div>
						</div>
						<div style="clear:both;height:10px;"></div>


						<div class="view_block_01">
							<div style="height:30px;">
								<div class="conTitBtnR">
									<input type="button" value="행추가">
									<input type="button" value="행삭제">
									<input type="button" value="저장">
								</div>
							</div>
							
							<div style="clear:both;height:10px;"></div>

				        	<div id="grid_wrap_02" class="gridHeiSz06 grid_wrap tb01_2"></div>
			        	</div>


						<div class="view_block_01">
							<div style="height:30px;">
								<div class="conTitBtnL" style="width:90%;">
									<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">업로드 :</span>
									&nbsp;
					 				<div class="fileInputArea" style="width:69%;">
						 				<input type="text" id="fileName" readonly="readonly" style="width:83%;">
						 				<input type="button" value="파일 찾기" class="fileInputBtn" />
						 				<input type="file" class="fileIuputHid" style="width:100%;">
					 				</div>
									<input type="button" value="업로드" />
									<input type="button" value="양식 다운로드" />
								</div>
								<div class="conTitBtnR">
									<input type="button" value="초기화">
								</div>
							</div>
							
							<div style="clear:both;height:10px;"></div>

							<table class="tb001">
								<colgroup>
									<col width="15%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>유효성 검사 결과</th>
										<td>
											<span style="font-family:'NanumGothicBold'; ">실패 : </span>
							 				필수값(0),중복값(0)/ 성공
										</td>
									</tr>
								</tbody>
							</table>
						</div>


<input type="button" value="공장재고 설정 팝업" class="popup_01">
						
					</div>
				</section>
			</div>
		</section>
</div>
</body>
</html>