<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>
<script type="text/javascript">

var testData_01 =[
{
	  "과제번호":"CJ_xxx_xx8",
	  "구분":"IP",
	  "Status":"등록",
	  "Code 수":"200",
	  "Type":"Real",
	  "생성일":"2016-06-11",
	  "생성자":"운영자"
}, {
	  "과제번호":"CJ_xxx_xx8",
	  "구분":"IP",
	  "Status":"등록",
	  "Code 수":"200",
	  "Type":"Real",
	  "생성일":"2016-06-11",
	  "생성자":"운영자"
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

	usePaging : true,
	
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
	    dataField : "과제번호",
	    headerText : "과제번호"
  },{
	    dataField : "구분",
	    headerText : "구분"
  },{
	    dataField : "Status",
	    headerText : "Status"
  },{
	    dataField : "Code 수",
	    headerText : "Code 수"
  },{
	    dataField : "Type",
	    headerText : "Type"
  },{
	    dataField : "생성일",
	    headerText : "생성일"
  },{
	    dataField : "생성자",
	    headerText : "생성자"
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


$(function() {
	myGridOption_01.createGrid();
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});
});


$(window).resize(function(){
	if (myGridOption_01.id) {
		AUIGrid.resize(myGridOption_01.id);
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
					<h3>위탁코드관리</h3>
	                <nav id="pathNav">
	                    <ul>
	                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
	                        <li>위탁코드목록</li>
	                        <li>위탁코드관리</li>
	                    </ul>
	                </nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner" style="min-height:900px;">

						<div style="height:28px;">
							<div class="conTitBtnL" style="width:80%;">
								<span style="font-family:'NanumGothicBold';">과제목록</span>
							</div>
						</div>
						<div id="grid_wrap_01" class="gridHeiSz04 grid_wrap tb01_2"></div>


						<div style="height:30px;"></div>

						<div style="height:30px;">
							<div class="conTitBtnL" style="width:80%;">
								<span style="font-family:'NanumGothicBold';">무작위배정코드 등록</span>
							</div>
						</div>
						
						
						<div style="height:30px;">
							<div class="conTitBtnL" style="width:70%;">
								<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">배정시점 :</span>
								&nbsp;
								<select style="width:80%; vertical-align:top;">
									<option value="">====선택====</option>
								</select>
							</div>
							<div class="conTitBtnR">
								<input type="button" value="무작위배정코드양식다운로드">
								<input type="button" value="업로드">
							</div>
						</div>
						<div class="mgT5" style="height:30px;">
							<div class="conTitBtnL" style="width:48%;">
								<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Type:</span>
								&nbsp;
								<select style="width:80%; vertical-align:top;">
									<option value="">====선택====</option>
								</select>
							</div>
							<div class="conTitBtnR" style="width:48%;">
				 				<div class="fileInputArea" style="width:100%;">
					 				<input type="text" id="fileName" readonly="readonly" style="width:80%;">
					 				<input type="button" value="파일 찾기" class="fileInputBtn" />
					 				<input type="file" class="fileIuputHid" style="width:100%;">
				 				</div>
							</div>
						</div>


							
						<div style="clear:both;height:20px;"></div>

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





						<div style="height:30px;"></div>

						<div style="height:30px;">
							<div class="conTitBtnL" style="width:80%;">
								<span style="font-family:'NanumGothicBold';">IP코드 등록</span>
							</div>
						</div>
						
						
						<div style="height:30px;">
							<div class="conTitBtnL" style="width:70%;">
								<span style="font-family:'NanumGothicBold'; position:relative; top:0px;">IP Type :</span>
								&nbsp;
								<input type="text" style="width:35%;">
								<span style="font-family:'NanumGothicBold'; position:relative; top:0px; padding-left:20px;">Code Type :</span>
								
								<select style="width:35%; vertical-align:top;">
									<option value="">====선택====</option>
								</select>
							</div>
							<div class="conTitBtnR">
								<input type="button" value="IP코드양식다운로드">
								<input type="button" value="업로드">
							</div>
						</div>
						<div class="mgT5" style="height:30px;">
							<div class="conTitBtnL" style="width:48%;">
								<span style="font-family:'NanumGothicBold'; position:relative; top:3px;">Type:</span>
								&nbsp;
								<select style="width:80%; vertical-align:top;">
									<option value="">====선택====</option>
								</select>
							</div>
							<div class="conTitBtnR" style="width:48%;">
				 				<div class="fileInputArea" style="width:100%;">
					 				<input type="text" id="fileName" readonly="readonly" style="width:80%;">
					 				<input type="button" value="파일 찾기" class="fileInputBtn" />
					 				<input type="file" class="fileIuputHid" style="width:100%;">
				 				</div>
							</div>
						</div>


							
						<div style="clear:both;height:20px;"></div>

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
				</section>
			</div>
		</section>
</div>
</body>
</html>