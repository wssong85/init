<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<style>
.row_height_01 th{ height:auto; padding:2px 5px 2px 12px;}
</style>

<script type="text/javascript" src="<c:url value='/js/pantheon/common/ctms/ctms.js'/>"></script>
<script>
var g_CRUD         = '${CRUD}';
var g_REPORT_SN    = '${REPORT_SN}';
var g_SETLE_NO     = '${SETLE_NO}';
var g_TASK_SN      = "${loginMap.TASK_SN}";
var g_USER_ID      = "${loginMap.USER_ID}";
var g_MILESTONE_SN = "${result.MILESTONE_SN}";
var g_REPORT_TYPE  = "P";
var g_REPORT_INFO;
var g_ITEM;

var g_EMAIL_URL        = "<c:url value='/ctms/z02/insertApprovalEmail.do'/>";
var g_UPDATE_APPOROVAL = "<c:url value='/ctms/z03/updateReportApprovalSn.do'/>";

var grid_wrap_03 = {
    id: '',
    div: {
		gridDiv: '#grid_wrap_03'
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
	grid_wrap_03.createGrid();
	mkSetDatePickerYYMMDD("#txtOprtnDe");

	if(g_CRUD == "U"){
		fn_selectReportInfo();
	}
	else{ //신규
	}
	
	$("#btnSave").click(function(){
		
		if(confirm("저장하시겠습니까?")){
			
		}
		else{
			return;
		}
		
		var arJson = [];
		
		var oprtnDe = $("#txtOprtnDe").val();
	    var oprtnDay = oprtnDe.split("-");
	    var day01 = oprtnDay[0]+oprtnDay[1]+oprtnDay[2]+"000000";

		var visitInfo = {
		           'TASK_SN'      : "${loginMap.TASK_SN}"
		          ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
		          ,'RSRCHMAN_ID'  : $("#txtResearchId").val()
		          ,'INSTT_CODE'   : "${result.INSTT_CODE}"
		          ,'OPRTN_DE'     : day01 //실시일
		          ,'CHARGER_ID'   : "${loginMap.USER_ID}"
		          ,'REMARK_A'     : $("#txtRemarkA").val()
		          ,'JOB_SE'       : "${loginMap.TASK_TY_CODE}"
		          ,'UPDATE_ID'    : "${loginMap.USER_ID}"
		          ,'REPORT_SE'    : 'E00'
		          ,'DATA_SE'      : 'A'
		          ,'REPORT_SN'    : g_REPORT_SN
		          ,'CRUD'         : '${CRUD}'
		          ,'REPORT_TYPE'  : 'P'
		          ,'COL_A'        : $('input[type=radio][name=raColA]:checked').val()
		          ,'COL_B'        : $('#txtColB').val()
		          ,'COL_C'        : $('input[type=radio][name=raColC]:checked').val()
		          ,'ITEM_A'       : $('#txtItemA').val()
		          ,'ITEM_B'       : $('#txtItemB').val()
		          ,'ITEM_C'       : $('#txtItemC').val()
		          ,'ITEM_D'       : $('#txtItemD').val()
		          ,'ITEM_E'       : $('#txtItemE').val()
		          ,'ITEM_F'       : $('#txtItemF').val()
		          ,'ITEM_G'       : $('#txtItemG').val()
		};
		arJson.push(visitInfo);
		
		var totalRows = $("tbody[id]").length;
        var params = [  $("tbody[id]").find('tr[name=trA]').length
                      , $("tbody[id]").find('tr[name=trB]').length
                      , $("tbody[id]").find('tr[name=trC]').length
                      , $("tbody[id]").find('tr[name=trD]').length
                     ];
        var params2 = [ $("tbody[id]").find('tr[name=trE]').length
                      , $("tbody[id]").find('tr[name=trF]').length
                      , $("tbody[id]").find('tr[name=trG]').length
                      , $("tbody[id]").find('tr[name=trH]').length
                      , $("tbody[id]").find('tr[name=trI]').length
                      , $("tbody[id]").find('tr[name=trJ]').length
                      , $("tbody[id]").find('tr[name=trK]').length
                      ];
        
		var addItems = {};		
		var num = 97; //아스키코드 소문자 a 시작	 
		var a_value;

		var addItems2 = {};
		var num2 = 101; //아스키코드 소문자 e 시작	 
		var a_value2;
		
        for(var j=0; j<params.length; j++){
            a_value = String.fromCharCode(num);   //아스키코드를 문자형으로..
            //console.log("a_value::::"+a_value);
            num++;

            for(var i=1; i<=params[j]; i++){
                addItems[i] = {
	                'REPORT_SN'     : g_REPORT_SN
	                ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
	                ,'TASK_SN'      : "${loginMap.TASK_SN}"
	                ,'REPORT_TYPE'  : 'P'
	                ,'ITEM_SE'      : a_value+i
	                ,'ITEM_VALUE'   : $('input:radio[name="'+a_value+i+'"]:checked').val()
	                ,'CHARGER_ID'   : "${loginMap.USER_ID}"
	                ,'RM'           : ''
	                ,'CRUD'         : '${CRUD}'
	                ,'DATA_SE'      : 'B'
	                ,'LAST_UPDUSR'  : "${loginMap.USER_ID}"
	                ,'USE_AT'       : "Y"
                }
//              if(!$(':input:radio[name="'+a_value+i+'"]:checked').val()){
//                  alert("선택되지 않은 항목이 있습니다.");
//                  return;
//              }
                //console.log("checkedValue::::"+a_value+i+"::::::"+$('input:radio[name="'+a_value+i+'"]:checked').val());
                arJson.push(addItems[i]);
            }
        }//for

        for(var j=0; j<params2.length; j++){
            a_value2 = String.fromCharCode(num2); //아스키코드를 문자형으로..
            //console.log("a_value::::"+a_value);
            num2++;

            for(var i=1; i<=params2[j]; i++){
                addItems2[i] = {
                     'REPORT_SN'    : g_REPORT_SN
                    ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
                    ,'TASK_SN'      : "${loginMap.TASK_SN}"
                    ,'REPORT_TYPE'  : 'P'
                    ,'ITEM_SE'      : a_value2+i
                    ,'ITEM_VALUE'   : $('input:checkbox[name="'+a_value2+i+'"]:checked').val()
                    ,'CHARGER_ID'   : "${loginMap.USER_ID}"
                    ,'RM'           : ''
                    ,'CRUD'         : '${CRUD}'
                    ,'DATA_SE'      : 'B'
                    ,'LAST_UPDUSR'  : "${loginMap.USER_ID}"
                    ,'USE_AT'       : "Y"
                }
//              if(!$(':input:radio[name="'+a_value+i+'"]:checked').val()){
//                  alert("선택되지 않은 항목이 있습니다.");
//                  return;
//              }
                //console.log("checkedValue::::"+a_value+i+"::::::"+$('input:radio[name="'+a_value+i+'"]:checked').val());
                arJson.push(addItems2[i]);
            }
        }//for

		///////////////////////// SAVE //////////////////////////
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
		}); //ajax

	}); //btnSave

	//결재요청 버튼 클릭
	$("#btnApproval").click(function() {
		mkLayerPopupOpen("<c:url value='/com/z09/popupCOMZ0901.do'/>", {
			'REQUST_NM': '시험개시 방문 보고서',
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

	//RD 출력버튼
  	$("#btnPrint").click(function(){
  		var g_RD_NAME = "CTMZ0501_NSS-301-FORM 04-SIVR-Ver.02.mrd";
  		fn_rdPrint(g_RD_NAME);
	}); //btnPrint

});

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
				$("#txtOprtnDe"   ).val(g_REPORT_INFO.OPRTN_DATE );
				
				$('input:radio[name=raColA]:input[value="'+g_REPORT_INFO.COL_A+'"]').attr("checked", true);
				$("#txtColB"      ).val(g_REPORT_INFO.COL_B      );
				$('input:radio[name=raColC]:input[value="'+g_REPORT_INFO.COL_C+'"]').attr("checked", true);
				
				$('#txtItemA'     ).val(g_REPORT_INFO.ITEM_A     );
				$('#txtItemB'     ).val(g_REPORT_INFO.ITEM_B     );
				$('#txtItemC'     ).val(g_REPORT_INFO.ITEM_C     );
				$('#txtItemD'     ).val(g_REPORT_INFO.ITEM_D     );
				$('#txtItemE'     ).val(g_REPORT_INFO.ITEM_E     );
				$('#txtItemF'     ).val(g_REPORT_INFO.ITEM_F     );
				$('#txtItemG'     ).val(g_REPORT_INFO.ITEM_G     );

				$("input[id=txtTaskNo]"    ).attr("readonly",true);
				$("input[id=txtInsttNm]"   ).attr("readonly",true);
				$("input[id=txtResearchNm]").attr("readonly",true);
				
				for(var i=0; g_ITEM.length > i; i++){
	                if(g_ITEM[i].ITEM_SE < String.fromCharCode(101)){
	                    $('input:radio[name="'+g_ITEM[i].ITEM_SE+'"]:input[value="'+g_ITEM[i].ITEM_VALUE+'"]').attr('checked',true);
	                }else if(g_ITEM[i].ITEM_SE >= String.fromCharCode(101)){
	                    $('input:checkbox[name="'+g_ITEM[i].ITEM_SE+'"]:input[value="'+g_ITEM[i].ITEM_VALUE+'"]').attr('checked',true);
	                }
				}
				
	            var params = [ $("tbody[id]").find('tr[name=trE]').length
	                         , $("tbody[id]").find('tr[name=trF]').length
	                         , $("tbody[id]").find('tr[name=trG]').length
	                         , $("tbody[id]").find('tr[name=trH]').length
	                         , $("tbody[id]").find('tr[name=trI]').length
	                         , $("tbody[id]").find('tr[name=trJ]').length
	                         ];

	            var num = 101; //아스키코드 소문자 e 시작
	            var a_value;

	            for(var j=0; j<params.length; j++){
	                a_value = String.fromCharCode(num); //아스키코드를 문자형으로..
	                checkValue(a_value); //체크박스 점수 체크함수
	                num++;
	            }

				if(g_SETLE_NO){
					grid_wrap_03.proxy.param = {'REQUEST_NO' : g_REPORT_INFO.SETLE_NO};
					grid_wrap_03.load();
					
					$("input:text").attr("disabled","true");
					$("textarea").attr("disabled","true");
					$("input:radio").attr("disabled","true");
					$("input:checkbox").attr("disabled","true");
					
					$("#btnSave").hide();
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


//////체크박스 중복체크 방지/////
function checkSelect(id,name){

	var obj = document.getElementsByName(name);
console.log("id : "+id+"      obj : "+obj+"    "+name);	
	for(var i=0; i<obj.length; i++){
		if(obj[i] != id){
			obj[i].checked = false;
		}
	}
	
	var value = name.substring(0,1);
	
	checkValue(value);
}


///////체크박스 점수 체크///////
function checkValue(value){
	var params  = [];
	var num = 0; //체크 Y 하나에 1
	var checkNum = 0;
	for(var i=1; i<=3; i++){
		 params[i] = $('input:checkbox[name="'+value+i+'"]:checked').val();		
		// console.log("params::"+params[i]);
		 if(params[i] == "Y"){
			 num++;
		 }
		 if( $('input:checked[name="'+value+i+'"]').is(':checked') == true){
			 checkNum++;
		 }
	}
	var txtId = "#txt"+value;
	if(checkNum == 0){
		$(txtId).val("N/A"); //체크가 없으면 N/A
	}else{
		$(txtId).val(num);
	}
}

window.onresize = function() {
	if (grid_wrap_03.id) {
		AUIGrid.resize(grid_wrap_03.id);
	}
};


</script>

</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0501&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0501&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>연구자 적합성</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>연구자 적합성</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">



					<article>
						<h5>연구자 적합성 보고서</h5>
					</article>

					<div style="height:10px;"></div>


<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->


					<table class="tb001 tb001_01">
						<colgroup>
							<col width="250px" />
							<col width="" />
							<col width="160px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>연구제목 Title</th>
								<td colspan="3">
									<input type="text" id="txtTaskNo" style="width:100%;" value="${loginMap.TASK_NO}">
								</td>
							</tr>
							<tr>
								<th>연구기관 Site Name</th>
								<td>
									<input type="hidden" id="txtInsttCd" value="${result.INSTT_CODE}">
									<input type="text" id="txtInsttNm" style="width:100%;" value="${result.NAME1}">
								</td>
								<th>실시일 Date of Contact</th>
								<td>
									<div class="dateBox">
										<input type="text" id="txtOprtnDe" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>연구책임자 후보 Potential PI</th>
								<td>
									<input type="hidden" id="txtResearchId" style="width:100%;" value="${result.USER_ID}">
									<input type="text" id="txtResearchNm" style="width:100%;" value="${result.USER_NM}">
								</td>
								<th>실시자 CRA</th>
								<td>
									<input type="hidden" id="txtChargerId" style="width:100%;" value="${loginMap.USER_ID}">
									<input type="text" id="txtChargerNm" style="width:100%;" value="${loginMap.USER_NM}">
								</td>
							</tr>
							<tr>
								<th>평가방법 Method of Evaluation</th>
								<td colspan="3">
									<div><input type="radio" name="raColA" id="o11" value="T"><label for="o11" class="raLab"><span>전화방문 Telephone Contact</span></label></div>
									<div><input type="radio" name="raColA" id="o12" value="S"><label for="o12" class="raLab"><span>기관방문 Site Visit</span></label></div>
									<div><input type="radio" name="raColA" id="o13" value="O"><label for="o13" class="raLab"><span>기타 Others</span></label><input type="text" id="txtColB" style="width:70%;"></div>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>

					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbA">
							<tr>
								<th>A. 기관에 제공된 정보 확인 Confirm information provided to the site</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trA">
								<td>1. 연구자가 연구계획서를 검토함 Protocol has been reviewed by the investigator</td>
								<td><input type="radio" id="a11" name="a1" value="Y"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1" value="N"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1" value="X"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>2. 연구자가 본 연구의 목적을 이해함 Relevant scientific background is understood by investigator</td>
								<td><input type="radio" id="a21" name="a2" value="Y"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2" value="N"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2" value="X"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>3. 연구 시작, 연구대상자 모집 및 완료에 대한 연구 일정을 인지하고 있음 Study timeline, including initiation, subject accrual rate and completion</td>
								<td><input type="radio" id="a31" name="a3" value="Y"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3" value="N"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3" value="X"><label for="a33" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbB">
							<tr>
								<th colspan="4">B. 연구자 Investigator</th>
							</tr>
							<tr name="trB">
								<td>1. 연구자는 연구에 할애할 충분한 시간이 있음 The investigator has sufficient time, training to conduct the study</td>
								<td><input type="radio" id="b11" name="b1" value="Y"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1" value="N"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1" value="X"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>2. 연구자는 최신 이력서 및 GCP 이수증을 보유하고 있음 The investigator has recent curriculum vitae, GCP training certificate to conduct the study</td>
								<td><input type="radio" id="b21" name="b2" value="Y"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2" value="N"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2" value="X"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>3. 연구자는 훈련되어 있는 공동연구자 및 인력을 적절히 확보하고 있음 The investigator has adequate, trained subinvestigator and other human resources</td>
								<td><input type="radio" id="b31" name="b3" value="Y"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3" value="N"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3" value="X"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>4. 연구자의 연락처가 확보되어 있음 Investigator contact has been identified.</td>
								<td><input type="radio" id="b41" name="b4" value="Y"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4" value="N"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4" value="X"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>5. 공동연구자와 연구간호사는 인증된 자격이 있음 Subinvestigator includes (a) certified clinical coordinator(s)</td>
								<td><input type="radio" id="b51" name="b5" value="Y"><label for="b51" class="raLab"></label></td>
								<td><input type="radio" id="b52" name="b5" value="N"><label for="b52" class="raLab"></label></td>
								<td><input type="radio" id="b53" name="b5" value="X"><label for="b53" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbC">
							<tr>
								<th colspan="4">C. 연구대상자 Subjects</th>
							</tr>
							<tr name="trC">
								<td>1. 선정제외기준에 적합한 연구대상자 등록이 가능함 Sufficient eligible subjects (patients, samples) are available</td>
								<td><input type="radio" id="c11" name="c1" value="Y"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1" value="N"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1" value="X"><label for="c13" class="raLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tbD">
							<tr>
								<th colspan="4">D. 연구비 Budget</th>
							</tr>
							<tr name="trD">
								<td>1. 연구 예산에 대해 논의 및 합의함 Study budget discussed and finalized</td>
								<td><input type="radio" id="d11" name="d1" value="Y"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1" value="N"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1" value="X"><label for="d13" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>



					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="15%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>의견 Comment</th>
								<td style="padding:10px 20px;">
									<textarea id="txtRemarkA" rows="3" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>

					<div style="height:20px;"></div>
					
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="220px" />
						</colgroup>
						<tbody id="tbE">
							<tr>
								<th colspan="5">평가 Evaluation</th>
							</tr>
							<tr>
								<td colspan="2">평가요인 Evaluation Factor</td>
								<td colspan="2" style="text-align: center; border-right:none;">범례 : </td>
								<td style="border-left:none;">
									Excellent :  3 점
									<br>
									Normal : 2 점
									<br>
									Poor : 0 ~ 1점
		  						</td>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 역량  Investigator capabilities</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2">비고 Comment</th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txte" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trE">
								<td>1</td>
								<td>연구 참여 경험이 많고, GCP 이수 등 연구자로서의 소양을 갖춤</td>
								<td><input type="checkbox" name="e1" id="ce1" value="Y" onclick="checkSelect(this, this.name)"><label for="ce1" class="chcLab"></label></td>
								<td><input type="checkbox" name="e1" id="ce2" value="N" onclick="checkSelect(this, this.name)"><label for="ce2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtItemA" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trE">
								<td>2</td>
								<td>안전성 정보 수집의 당위성과 필요성을 이해하고 관심갖으며, AE와 SAE의 개념을 이해함</td>
								<td><input type="checkbox" name="e2" id="ce3" value="Y" onclick="checkSelect(this, this.name)"><label for="ce3" class="chcLab"></label></td>
								<td><input type="checkbox" name="e2" id="ce4" value="N" onclick="checkSelect(this, this.name)"><label for="ce4" class="chcLab"></label></td>
							</tr>
							<tr name="trE">
								<td>3</td>
								<td>컴퓨터 사용에 능숙하여 eCRF 작성이 가능함</td>
								<td><input type="checkbox" name="e3" id="ce5" value="Y" onclick="checkSelect(this, this.name)"><label for="ce5" class="chcLab"></label></td>
								<td><input type="checkbox" name="e3" id="ce6" value="N" onclick="checkSelect(this, this.name)"><label for="ce6" class="chcLab"></label></td>
							</tr>
						</tbody>
						<tbody id="tdF">
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">공동연구자 및 인력의 적합성 Suitability of subinvestigator and other human resources</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txtf" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trF">
								<td>1</td>
								<td>공동연구자 및 연구담당자의 연구 참여 경험이 많고, GCP 이수 등 연구자로서의 소양을 갖춤</td>
								<td><input type="checkbox" name="f1" id="cf1" value="Y" onclick="checkSelect(this, this.name)"><label for="cf1" class="chcLab"></label></td>
								<td><input type="checkbox" name="f1" id="cf2" value="N" onclick="checkSelect(this, this.name)"><label for="cf2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtItemB" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trF">
								<td>2</td>
								<td>안전성 정보 수집의 당위성과 필요성을 이해하고 관심갖으며, AE와 SAE의 개념을 이해함</td>
								<td><input type="checkbox" name="f2" id="cf3" value="Y" onclick="checkSelect(this, this.name)"><label for="cf3" class="chcLab"></label></td>
								<td><input type="checkbox" name="f2" id="cf4" value="N" onclick="checkSelect(this, this.name)"><label for="cf4" class="chcLab"></label></td>
							</tr>
							<tr name="trF">
								<td>3</td>
								<td>컴퓨터 사용에 능숙하여 eCRF 작성이 가능함</td>
								<td><input type="checkbox" name="f3" id="cf5" value="Y" onclick="checkSelect(this, this.name)"><label for="cf5" class="chcLab"></label></td>
								<td><input type="checkbox" name="f3" id="cf6" value="N" onclick="checkSelect(this, this.name)"><label for="cf6" class="chcLab"></label></td>
							</tr>
							
						</tbody>
						<tbody id="tdG">
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구대상자 모집 유용성 Subject accrual availability</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txtg" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trG">
								<td>1</td>
								<td>충분한 조사대상자 확보가 가능함</td>
								<td><input type="checkbox" name="g1" id="cg1" value="Y" onclick="checkSelect(this, this.name)"><label for="cg1" class="chcLab"></label></td>
								<td><input type="checkbox" name="g1" id="cg2" value="N" onclick="checkSelect(this, this.name)"><label for="cg2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtItemC" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trG">
								<td>2</td>
								<td>해당 연구에 적합한 진료과에서 연구를 진행함</td>
								<td><input type="checkbox" name="g2" id="cg3" value="Y" onclick="checkSelect(this, this.name)"><label for="cg3" class="chcLab"></label></td>
								<td><input type="checkbox" name="g2" id="cg4" value="N" onclick="checkSelect(this, this.name)"><label for="cg4" class="chcLab"></label></td>
							</tr>
							<tr name="trG">
								<td>3</td>
								<td>유사성분의 연구를 중복해서 진행한 경험이 없음</td>
								<td><input type="checkbox" name="g4" id="cg5" value="Y" onclick="checkSelect(this, this.name)"><label for="cg5" class="chcLab"></label></td>
								<td><input type="checkbox" name="g4" id="cg6" value="N" onclick="checkSelect(this, this.name)"><label for="cg6" class="chcLab"></label></td>
							</tr>
							
						</tbody>
						<tbody id="tdH">
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 할애 가능한 시간 Investigator’s available time</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txth" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trH">
								<td>1</td>
								<td>하루에 30분 이상 연구에 시간 할애가 가능함</td>
								<td><input type="checkbox" name="h1" id="ch1" value="Y" onclick="checkSelect(this, this.name)"><label for="ch1" class="chcLab"></label></td>
								<td><input type="checkbox" name="h1" id="ch2" value="N" onclick="checkSelect(this, this.name)"><label for="ch2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtItemD" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trH">
								<td>2</td>
								<td>다른 연구를 5개 이상 진행하고 있지 않음</td>
								<td><input type="checkbox" name="h2" id="ch3" value="Y" onclick="checkSelect(this, this.name)"><label for="ch3" class="chcLab"></label></td>
								<td><input type="checkbox" name="h2" id="ch4" value="N" onclick="checkSelect(this, this.name)"><label for="ch4" class="chcLab"></label></td>
							</tr>
							<tr name="trH">
								<td>3</td>
								<td>전체 연구기간 동안 중단 없이 참여 가능함</td>
								<td><input type="checkbox" name="h3" id="ch5" value="Y" onclick="checkSelect(this, this.name)"><label for="ch5" class="chcLab"></label></td>
								<td><input type="checkbox" name="h3" id="ch6" value="N" onclick="checkSelect(this, this.name)"><label for="ch6" class="chcLab"></label></td>
							</tr>

						</tbody>
						<tbody id="tdI">

							<tr class="row_height_01">
								<th colspan="2" rowspan="2">연구자의 관심도와 충실성 Investigator’s interest and commitment</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txti" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trI">
								<td>1</td>
								<td>연구 참여에 적극적인 의사를 표함</td>
								<td><input type="checkbox" name="i1" id="ci1" value="Y" onclick="checkSelect(this, this.name)"><label for="ci1" class="chcLab"></label></td>
								<td><input type="checkbox" name="i1" id="ci2" value="N" onclick="checkSelect(this, this.name)"><label for="ci2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtItemE" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trI">
								<td>2</td>
								<td>연구디자인, 선정/제외기준 등 관련사항 및 연구진행 프로세스에 대해 정확히 인지함</td>
								<td><input type="checkbox" name="i2" id="ci3" value="Y" onclick="checkSelect(this, this.name)"><label for="ci3" class="chcLab"></label></td>
								<td><input type="checkbox" name="i2" id="ci4" value="N" onclick="checkSelect(this, this.name)"><label for="ci4" class="chcLab"></label></td>
							</tr>
							<tr name="trI">
								<td>3</td>
								<td>CRF를 작성 및 쿼리해결의 퀄리티가 높으며, 쿼리 발행사항을 신속히 해결함</td>
								<td><input type="checkbox" name="i3" id="ci5" value="Y" onclick="checkSelect(this, this.name)"><label for="ci5" class="chcLab"></label></td>
								<td><input type="checkbox" name="i3" id="ci6" value="N" onclick="checkSelect(this, this.name)"><label for="ci6" class="chcLab"></label></td>
							</tr>
							
						</tbody>
						<tbody id="tdJ">
							
							<tr class="row_height_01">
								<th colspan="2" rowspan="2">문서보존 능력 Recordkeeping capability</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th rowspan="2"></th>
							</tr>
							<tr class="row_height_01">
								<th colspan="2" style="text-align:center; font-weight:bold; padding-left:5px;"><input type="text" id="txtj" style="text-align:center;" disabled></th>
							</tr>
							<tr name="trJ">
								<td>1</td>
								<td>연구 관련 문서를 보관할 수 있는 적합한 공간을 확보함</td>
								<td><input type="checkbox" name="j1" id="cj1" value="Y" onclick="checkSelect(this, this.name)"><label for="cj1" class="chcLab"></label></td>
								<td><input type="checkbox" name="j1" id="cj2" value="N" onclick="checkSelect(this, this.name)"><label for="cj2" class="chcLab"></label></td>
								<td rowspan="3" style="padding:11px 10px 5px 10px;">
									<textarea id="txtItemF" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
							<tr name="trJ">
								<td>2</td>
								<td>연구 종료 후 3년간 근거문서를 보관해야 함을 인지함</td>
								<td><input type="checkbox" name="j2" id="cj3" value="Y" onclick="checkSelect(this, this.name)"><label for="cj3" class="chcLab"></label></td>
								<td><input type="checkbox" name="j2" id="cj4" value="N" onclick="checkSelect(this, this.name)"><label for="cj4" class="chcLab"></label></td>
							</tr>
							<tr name="trJ">
								<td>3</td>
								<td>계약서, ISF 등의 관련문서를 적절히 보관함</td>
								<td><input type="checkbox" name="j3" id="cj5" value="Y" onclick="checkSelect(this, this.name)"><label for="cj5" class="chcLab"></label></td>
								<td><input type="checkbox" name="j3" id="cj6" value="N" onclick="checkSelect(this, this.name)"><label for="cj6" class="chcLab"></label></td>
							</tr>
						</tbody>
					</table>
					<table class="tb001" style="border-top:none;">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
							<col width="180px" />
						</colgroup>
						<tbody id="tdK">
							<tr class="row_height_01">
								<th rowspan="2" colspan="2">기타 Other</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">O</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">X</th>
								<th style="text-align:center; font-weight:bold; padding-left:5px;">NA</th>	
								<th rowspan="2"></th>							
							</tr>
							<tr class="row_height_01">
								<th colspan="3" style="text-align:center; font-weight:bold; padding-left:5px;"> </th>
							</tr>							
							<tr name="trK">
								<td>1</td>
								<td style="padding-right:12px;"><input type="text" id="txtItemG" style="width:100%;"></td>
								<td><input type="checkbox" name="k1" id="ck1" value="3" onclick="checkSelect(this, this.name)"><label for="ck1" class="chcLab"></label></td>
								<td><input type="checkbox" name="k1" id="ck2" value="2" onclick="checkSelect(this, this.name)"><label for="ck2" class="chcLab"></label></td>
								<td><input type="checkbox" name="k1" id="ck3" value="1" onclick="checkSelect(this, this.name)"><label for="ck3" class="chcLab"></label></td>
								<td></td>
							</tr>
						</tbody>

							
							<tr>
								<th colspan="6">추천 Recommendation</th>
							</tr>
							<tr>
								<td colspan="2">
									본 연구자는 시험을 진행하기 위한 CJ의 기준에 부합함 This investigator meets <CJ>'s criteria to conduct the study
								</td>
								<td colspan="4">
									<input type="radio" id="l11" name="raColC" value="Y"><label for="l11" class="raLab"><span>예 Yes</span></label>
									<input type="radio" id="l12" name="raColC" value="N"><label for="l12" class="raLab"><span>아니오 No</span></label>
								</td>
							</tr>

					</table>



					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>결제</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval"     value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					
					
					<div style="height:10px;"></div>
					
					
					<div id="grid_wrap_03" class="gridHeiSz03 grid_wrap tb01_2"></div>



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