<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<style>
.tb001_01 td{height:auto; padding:14px 30px 20px 30px; vertical-align:top;}
.tb001_01 td div{ display:inline-block; padding:0 20px 0 0;}
</style>

<script>
var g_CRUD      = '${CRUD}';
var g_REPORT_SN = '${REPORT_SN}';
var g_SETLE_NO  = '${SETLE_NO}';
var g_REPORT_INFO;
var g_ITEM;

var grReportApproval = {
    id: '',
    
    div: {
		gridDiv: '#grReportApproval'
    },
    proxy: {
		url: "<c:url value='/ctms/z02/selectApprovalInfo.do'/>",
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
        editable : false,
        enableFilter : true,
        headerHeight: 40,
        rowHeight: 37,
        selectionMode : "multipleCells"
    },
    columnLayout : [{
          dataField : "SANCTN_CODE_NM",
          headerText : '<spring:message code="comz0903.gr.SANCTN_CODE_NM"/>'
      },{
          dataField : "DEPT_NM",
          headerText : '<spring:message code="comz0903.gr.DEPT_NM"/>'
      },{
          dataField : "SANCTNER_NM",
          headerText : '<spring:message code="comz0903.gr.SANCTNER_NM"/>'
      },{
          dataField : "SANCTNER_ID",
          headerText : '<spring:message code="comz0903.gr.SANCTNER_ID"/>',
          visible : false
      },{
          dataField : "STTUS_CODE_NM",
          headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>'
      },{
          dataField : "SANCTN_CODE",
          headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>',
          visible : false
      },{
          dataField : "STTUS_CODE",
          headerText : '<spring:message code="comz0903.gr.STTUS_CODE_NM"/>',
          visible : false
      },{
          dataField : "SANCTN_DT",
          headerText : '<spring:message code="comz0903.gr.SANCTN_DT"/>',
          formatString : "yyyy-mm-dd HH:MM:ss",
          dataType:"date",
          width: 200
      },{
          dataField : "SANCTN_COMMENT",
          headerText : '<spring:message code="comz0903.gr.SANCTN_COMMENT"/>'
      },{
          dataField : "EMAIL",
          headerText : 'EMAIL',
          visible : false
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
      $.ajax({
          url: me.proxy.url,
          type: me.proxy.type,
          dataType: me.proxy.dataType,
          data: me.proxy.param,
          success:function(data){
              if(data.success) {
                  //console.log(data.result);
                  AUIGrid.setGridData(me.id, data.result);
                  AUIGrid.setSelectionByIndex(me.id, 0);
              }
          },
          error : function(jqXHR, textStatus, errorThrown){
              alert(textStatus);
          }
      });
    }
};



$(document).ready(function() {
	grReportApproval.createGrid();
	
	mkSetDatePickerYYMMDD("#txtVisitDay");

	if(g_CRUD == "U"){
		fn_selectReportInfo();
	}
	else{ //신규
		$("input[id=txtTaskNo]"    ).attr("readonly",true);
		$("input[id=txtInsttNm]"   ).attr("readonly",true);
		$("input[id=txtResearchNm]").attr("readonly",true);
		$("input[id=txtVisitor]"   ).attr("readonly",true);
	}
	
	fn_btnApproval();

    $("input[name=chk]").click(function(idx){
		if(g_SETLE_NO){
			for(var i=0; g_ITEM.length > i; i++){
				if(g_ITEM[i].ITEM_VALUE == "Y"){
					$("input:checkbox[id='"+g_ITEM[i].ITEM_SE+"']").prop("checked", true);
				}
				else{
					$("input:checkbox[id='"+g_ITEM[i].ITEM_SE+"']").prop("checked", false);
				}
			}
		}
    });

	$("#btnSave").click(function(){
		
		if(confirm("저장하시겠습니까?")){
			var arJson = [];
	
			var visitDay   = $("#txtVisitDay").val();
			var arrVisitDay = visitDay.split("-");
			var txtVisitDay = arrVisitDay[0]+arrVisitDay[1]+arrVisitDay[2]+"000000";
			
			var visitInfo = {
			           'TASK_SN'      : "${loginMap.TASK_SN}"
			          ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
			          ,'RSRCHMAN_ID'  : $("#txtResearchId").val()
			          ,'INSTT_CODE'   : "${result.INSTT_CODE}"
			          ,'RSPOFC'       : $("#txtPosition").val()
			          ,'OPRTN_DE'     : txtVisitDay
			          ,'CHARGER_ID'   : "${loginMap.USER_ID}"
			          ,'REMARK_A'     : $("#txtComments").val()
			          ,'JOB_SE'       : "${loginMap.TASK_TY_CODE}"
			          ,'UPDATE_ID'    : "${loginMap.USER_ID}"
			          ,'REPORT_SE'    : 'C01'
			          ,'DATA_SE'      : 'A'
			          ,'REPORT_SN'    : g_REPORT_SN
			          ,'CRUD'         : '${CRUD}'
			          ,'REPORT_TYPE'  : 'P'
			};
			arJson.push(visitInfo);
			
			var addItem = {};
			var isCheck = "";
			$("input[name=chk]").each(function(idx){
				//console.log($(this).attr('id')+"  :  "+$("input:checkbox[id='"+$(this).attr('id')+"']").is(":checked"));
				if($("input:checkbox[id='"+$(this).attr('id')+"']").is(":checked")){
					isCheck = "Y";
				} // if true
				else {
					isCheck = "N";
				}
	
				addItem = {
			               'REPORT_SN'    : g_REPORT_SN
			              ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
			              ,'TASK_SN'      : "${loginMap.TASK_SN}"
			              ,'REPORT_TYPE'  : 'P'
			              ,'ITEM_SE'      : $(this).attr('id')
			              ,'ITEM_VALUE'   : isCheck
			              ,'CHARGER_ID'   : "${loginMap.USER_ID}"
			              ,'RM'           : ''
			              ,'SUBJECT_CO'   : '0'
			              ,'DTE'          : txtVisitDay
			              ,'CRUD'         : '${CRUD}'
			              ,'DATA_SE'      : 'B'
			              ,'UPDATE_ID'    : "${loginMap.USER_ID}"
			              ,'USE_AT'       : "Y"
				} //addItem
				
				arJson.push(addItem);
			});
			
			$.ajax({
				  url : "<c:url value='/ctms/z03/insertVisitReport.do'/>" ,
				  type: 'post',
				  contentType: "application/json; charset=UTF-8",
				  data : JSON.stringify(arJson),
				  success : function(data, textStatus, jqXHR) {				
					  
					  if(data.success) {
						  g_REPORT_SN = data.REPORT_SN;
						  alert("저장되었습니다.");
						  fn_selectReportInfo();
					  } else {					  
						  alert(data.message);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(textStatus);
					  //alert(jqXHR);
				  }
			});
		
		} // 저장여부
		
	});
  
	$("#btnPrint").click(function(){
		var param = {
				MRD_NAME : "CTMZ0202_NSS-301-FORM 04-SIVR-Ver.02.mrd",
				MILESTONE_SN : "${result.MILESTONE_SN}",
				TASK_SN : "${loginMap.TASK_SN}"
		};
		
		var f = document.createElement("form");
		
		$.each(param, function(key, value){
			var obj;
			obj = document.createElement("input");
			obj.setAttribute("type", "hidden");
			obj.setAttribute("name", key);
			obj.setAttribute("value", value);
			f.appendChild(obj);	
		});
		
		window.open("", "popForm", "toolbar=no, width=1100, height=800, directories=no, status=no, scrollorbars=yes, resizable=no");

		f.setAttribute("method", "post");
		f.setAttribute("action", "<c:url value='/com/system/CommonRD.do'/>");
		f.setAttribute("target", "popForm");
		document.body.appendChild(f);
		f.submit();
	});
	
	//결재요청 버튼 클릭
	$("#btnApproval").click(function() {
		mkLayerPopupOpen("<c:url value='/com/z09/popupCOMZ0901.do'/>", {
			'REQUST_NM': '연구기관 방문 보고서',
			'callbackFunction': 'f_requestRequstNo_1'
		}, 1);
	});

	//결재정보버튼 클릭
	$('#btnApprovalInfo').click(function() {
		mkLayerPopupOpen("<c:url value='/com/z09/popupCOMZ0903.do'/>", {
			'REQUST_NO'        : g_REPORT_INFO.SETLE_NO,
			'callbackFunction' : 'f_requestRequstNo_2',
			'CALLBACK_TRUE'    : true
		});
	});

	$('#tab_menu2').click(function(){
		fn_goTapPage();
	});

});

//결재정보 버튼 callback
function f_requestRequstNo_2(v) {
	//console.log("approvalSn:::::"+approvalSn);
	var params = {
  			'REQUEST_NO' : g_SETLE_NO
		};
	grReportApproval.proxy.param = params;
	grReportApproval.load();
}

//결재요청 버튼 callback
function f_requestRequstNo_1(v) {
	g_SETLE_NO = v;
	var arJson = [];
	var approval = {
		 'REPORT_SN'    : g_REPORT_INFO.REPORT_SN
		,'CHARGER_ID'   : g_REPORT_INFO.CHARGER_ID
		,'UPDATE_ID'    : "${loginMap.USER_ID}"
		,'SETLE_NO'     : g_SETLE_NO
		,'MILESTONE_SN' : g_REPORT_INFO.MILESTONE_SN
		,'TASK_SN'      : g_REPORT_INFO.TASK_SN
		,'REPORT_TYPE'  : 'P'
	};
	
	$.ajax({
		  url : "<c:url value='/ctms/z03/updateReportApprovalSn.do'/>" ,
		  type: 'post',
		  contentType: "application/json; charset=UTF-8",
		  data : JSON.stringify(approval),
		  success : function(data, textStatus, jqXHR) {				
			  
			  if(data.success) {
				  //approvalSn = data.result.
				    var params = {
	    	  			'REQUEST_NO' : g_SETLE_NO
	    			};
		    	  grReportApproval.proxy.param = params;
		    	  grReportApproval.load();
				 
				  ///////////////////////////결재요청시 이메일 발송/////////////////////////
				  var items = AUIGrid.getGridData(grReportApproval.id);
				  var exItems = [{"EMAIL" : "kimbokmin@cj.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
				                 {"EMAIL" : "kimbokmin@daum.net" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/},
				                 {"EMAIL" : "kimbokmin@naver.com" /*sendEmail*/, "USER_NM" : "김복민"/*userName*/}];
				 
				  var emailInfo = {};
				  for(var i=0; i<items.length; i++){
					  //emailInfo = {"EMAIL" : items[i].EMAIL /*sendEmail*/, "USER_NM" : items[i].SANCTNER_NM/*userName*/}; 실제 메일발송
// 					  emailInfo = {"EMAIL" : exItems[i].EMAIL /*sendEmail*/, "USER_NM" : exItems[i].SANCTNER_NM/*userName*/};
// 					  fn_Email(emailInfo);
				  }
				  
				  fn_selectReportInfo();
			  } else {					  
				  alert(data.message);
			  }
		  }, 
		  error : function(jqXHR, textStatus, errorThrown){
			  alert(textStatus);
			  //alert(jqXHR);
		  }
	});
	
}

function fn_btnApproval(){
	if(g_SETLE_NO){
		$("#btnApproval").hide();
		$("#btnApprovalInfo").show();
	}
	else{
		$("#btnApproval").show();
		$("#btnApprovalInfo").hide();
	}
}

function fn_Email(param){
	
	var arJson = [];	
	arJson.push(param);

	$.ajax({
		    url: "<c:url value='/ctms/z02/insertApprovalEmail.do'/>",
		    type: 'post', 		
		    contentType: "application/json; charset=UTF-8",
		    dataType: 'json',
		    data: JSON.stringify(arJson), 		  
		    success:function(data){
		    	
		    	if(data.success) {
		    		 			    	
		    	} else { 		    		
		    		alert(data.message);
		    	}
		    },
		    error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			alert(errorThrown);
			alert(jqXHR.responseText);				
		}
	});
}

function fn_selectReportInfo(){
    var params = {'REPORT_SN' : g_REPORT_SN};

	$.ajax({
		type     : "POST",
		url      : "<c:url value='/ctms/z03/selectVisitReportInfo.do'/>",
		data     : params,
		dataType : 'json',
		success:function(data){
			if(data.success) {
				console.log(data.info);
				g_REPORT_INFO = data.info;
				g_REPORT_SN   = g_REPORT_INFO.REPORT_SN;
				g_SETLE_NO    = g_REPORT_INFO.SETLE_NO;
				g_ITEM        = data.item;

				$("#txtInsttNm"   ).val(g_REPORT_INFO.INSTT_NAME );
				$("#txtInsttCd"   ).val(g_REPORT_INFO.INSTT_CODE );
				$("#txtResearchId").val(g_REPORT_INFO.RSRCHMAN_ID);
				$("#txtResearchNm").val(g_REPORT_INFO.RSRCHMAN_NM);
				$("#txtPosition"  ).val(g_REPORT_INFO.RSPOFC     );
				$("#txtVisitDay"  ).val(g_REPORT_INFO.OPRTN_DATE );
				$("#txtVisitorId" ).val(g_REPORT_INFO.CHARGER_ID );
				$("#txtVisitor"   ).val(g_REPORT_INFO.VISITOR_NM );
				$("#txtComments"  ).val(g_REPORT_INFO.REMARK_A   );

				$("input[id=txtTaskNo]"    ).attr("readonly",true);
				$("input[id=txtInsttNm]"   ).attr("readonly",true);
				$("input[id=txtResearchNm]").attr("readonly",true);
				$("input[id=txtPosition]"  ).attr("readonly",true);
				$("input[id=txtVisitDay]"  ).attr("readonly",true);
				$("input[id=txtVisitor]"   ).attr("readonly",true);

				for(var i=0; g_ITEM.length > i; i++){
					if(g_ITEM[i].ITEM_VALUE == "Y"){
						$("input:checkbox[id='"+g_ITEM[i].ITEM_SE+"']").prop("checked", true);
					}
				}

				if(g_SETLE_NO){
					grReportApproval.proxy.param = {'REQUEST_NO' : g_REPORT_INFO.SETLE_NO};
					grReportApproval.load();

					$("textarea[id=txtComments]").attr("readonly",true);
				}
				
				fn_btnApproval();

			} else {
				//alert(data.message);
			}
		},
		error : function(jqXHR, textStatus, errorThrown){
			alert(textStatus);
			//alert(jqXHR);
		}
	});
}

function fn_goTapPage(){
	var params = { 
			   'MILESTONE_SN' : g_REPORT_INFO.MILESTONE_SN
	  		  ,'INSTT_CODE'   : g_REPORT_INFO.INSTT_CODE
	  		  ,'TASK_SN'      : g_REPORT_INFO.TASK_SN
	          ,'OPRTN_DE'     : g_REPORT_INFO.OPRTN_DE_DATE
			  ,'NAME1'        : g_REPORT_INFO.INSTT_NAME
			  ,'USER_NM'      : g_REPORT_INFO.RSRCHMAN_NM //연구자 명
			  ,'USER_ID'      : g_REPORT_INFO.RSRCHMAN_ID //연구자 ID
			  ,'TASK_NO'      : g_REPORT_INFO.TASK_NO
			  ,'REPORT_SE'    : 'C02'
			  ,'REPORT_TYPE'  : 'V'
        };
	
	var f = document.createElement("form");
	
	var objs ;
	var value ;
	
	for(var key in params){
		value = params[key];		
		objs = document.createElement("input");
		objs.setAttribute("type", "hidden");
		objs.setAttribute("id", key);
		objs.setAttribute("name", key);
		objs.setAttribute("value", value);
		f.appendChild(objs);
	}

	f.setAttribute("method", "post");
	f.setAttribute("action", "<c:url value='/ctms/z03/CTMZ0303.do'/>");
	document.body.appendChild(f);
	f.submit();
}

window.onresize = function() {
	if (grReportApproval.id) {
		AUIGrid.resize(grReportApproval.id);
	}
};


</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0303&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0303&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>기관 방문</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>기관 방문</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">




					<div id="tab" class="tab tab01">
						<ul>
							<li id="tab_menu1" class="port_back tab_menu">연구기관 방문 보고서</li>
							<li id="tab_menu2" class="tab_menu">방문 후속조치 보고서</li>
						</ul>
					</div>

<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->


					<table class="tb001">
						<colgroup>
							<col width="180px" />
							<col width="" />
							<col width="180px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>과제번호 Protocol No.</th>
								<td>
									<input type="text" id="txtTaskNo" style="width:100%;" value="${loginMap.TASK_NO}">
								</td>
								<th>연구기관 Institution</th>
								<td>
									<input type="hidden" id="txtInsttCd" value="${result.INSTT_CODE}">
									<input type="text" id="txtInsttNm" style="width:100%;" value="${result.NAME1}">
								</td>
							</tr>
							<tr>
								<th>연구자 Investigator</th>
								<td>
									<input type="hidden" id="txtResearchId" style="width:100%;" value="${result.USER_ID}">
									<input type="text" id="txtResearchNm" style="width:100%;" value="${result.USER_NM}">
								</td>
								<th>직책 Position</th>
								<td>
									<input type="text" id="txtPosition" style="width:100%;" value="조사연구자 or 공동연구자 or CRC"> <!-- 조사연구자 or 공동연구자 or CRC -->
								</td>
							</tr>
							<tr>
								<th>방문일 Date of Visit</th>
								<td>
									<div class="dateBox">
										<input type="text" id="txtVisitDay" style="width: 120px;" />
									</div>
								</td>
								<th>방문자 Visitor</th>
								<td>
									<input type="hidden" id="txtVisitorId" style="width:100%;" value="${loginMap.USER_ID}">
									<input type="text"   id="txtVisitor"   style="width:100%;" value="${loginMap.USER_NM}">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 방문목적 Purpose of Visit</h6>
                    </article>
                    

					<div style="height:10px;"></div>

					<table class="tb001 tb001_01">
						<colgroup>
							<col width="50%" />
							<col width="" />
						</colgroup>
						<tbody id="tBody">
							<tr>
								<th>1. 연구 설명</th>
								<th>2. 계약</th>
							</tr>
							<tr>
								<td>
									<div><input type="checkbox" name="chk" id="a1" ><label for="a1" class="chcLab"><span>1. 디자인 설명</span></label></div>
									<div><input type="checkbox" name="chk" id="a2" ><label for="a2" class="chcLab"><span>2. 규정 관련 설명</span></label></div>
									<div><input type="checkbox" name="chk" id="a3" ><label for="a3" class="chcLab"><span>3. 조사대상자 선정/제외기준 설명</span></label></div>
									<div><input type="checkbox" name="chk" id="a4" ><label for="a4" class="chcLab"><span>4. e-CRF 입력 방법 교육</span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="chk" id="b1" ><label for="b1" class="chcLab"><span>1. 진행 계약</span></label></div>
									<div><input type="checkbox" name="chk" id="b2" ><label for="b2" class="chcLab"><span>2. 중단 계약</span></label></div>
									<div><input type="checkbox" name="chk" id="b3" ><label for="b3" class="chcLab"><span>3. 변경 계약</span></label></div>
								</td>
							</tr>
							<tr>
								<th>3. 연구 진행 및 독려</th>
								<th>4. IRB 심의</th>
							</tr>
							<tr>
								<td>
									<div><input type="checkbox" name="chk" id="c1" ><label for="c1" class="chcLab"><span>1. 진행 독려</span></label></div>
									<div><input type="checkbox" name="chk" id="c2" ><label for="c2" class="chcLab"><span>2. 진행 확인</span></label></div>
									<div><input type="checkbox" name="chk" id="c3" ><label for="c3" class="chcLab"><span>3. 쿼리 해결</span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="chk" id="d1" ><label for="d1" class="chcLab"><span>1. 초기심의</span></label></div>
									<div><input type="checkbox" name="chk" id="d2" ><label for="d2" class="chcLab"><span>2. 변경심의</span></label></div>
									<div><input type="checkbox" name="chk" id="d3" ><label for="d3" class="chcLab"><span>3. 종료심의</span></label></div>
									<div><input type="checkbox" name="chk" id="d4" ><label for="d4" class="chcLab"><span>4. 지속심의</span></label></div>
									<div><input type="checkbox" name="chk" id="d5" ><label for="d5" class="chcLab"><span>5. SAE 보고</span></label></div>
									<div><input type="checkbox" name="chk" id="d6" ><label for="d6" class="chcLab"><span>6. 기타</span></label></div>
								</td>
							</tr>
							<tr>
								<th>5. 유해사례</th>
								<th>6. 기타</th>
							</tr>
							<tr>
								<td>
									<div><input type="checkbox" name="chk" id="e1" ><label for="e1" class="chcLab"><span>1. SAE 확인</span></label></div>
								</td>
								<td>
									<div><input type="checkbox" name="chk" id="f1" ><label for="f1" class="chcLab"><span>1. 기타</span></label></div>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>




					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>세부 내용 Additional Comments</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtComments" rows="3" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>2. 결제</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval"     value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					<div style="height:10px;"></div>
					<div id="grReportApproval" class="gridHeiSz03 grid_wrap tb01_2"></div>



					<div style="height:20px;"></div>



                    <div style="text-align:center;">
                        <input type="button" id="btnSave" value="<spring:message code="ctmz0201.btn.Save" />">
                        <input type="button" id="btnPrint" value="<spring:message code="ctmz0201.btn.Print" />">
                    </div>





							
				</div>
            </section>

		</div>
	</section>

</div>
</body>
</html>