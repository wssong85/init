<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>


<style>

.tb001_01 td{height:auto; padding:8px 14px 8px 15px; }
.tb001_01 td .ck_01{ display:block; padding:0 20px 0 0;}
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
	mkSetDatePickerYYMMDD("#txtOprtnDe" );
	mkSetDatePickerYYMMDD("#txtExpectDe");
	
	$("input[id=txtTaskNo]"    ).attr("readonly",true);
	$("input[id=txtInsttNm]"   ).attr("readonly",true);
	$("input[id=txtResearchNm]").attr("readonly",true);

	fn_btnApproval();

	if(g_CRUD == "U"){
		fn_selectReportInfo();
	}
	else{ //신규

	}
	
    $("input[name=chk]").click(function(idx){ //결제요청 후 update 막기
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
		var arJson = [];

		///////////////////////////CTMS_ST_REPORT_MAIN////////////////////////////
		var day1    = $("#txtOprtnDe").val();
		var arrDay1 = day1.split("-");
		var txtDay1 = arrDay1[0]+arrDay1[1]+arrDay1[2]+"000000";
		var day2    = $("#txtExpectDe").val();
		var arrDay2 = day2.split("-");
		var txtDay2 = arrDay2[0]+arrDay2[1]+arrDay2[2]+"000000";
		
		var visitInfo = {
		           'TASK_SN'      : "${loginMap.TASK_SN}"
		          ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
		          ,'RSRCHMAN_ID'  : $("#txtResearchId").val()
		          ,'INSTT_CODE'   : "${result.INSTT_CODE}"
		          ,'CHARGER_ID'   : "${loginMap.USER_ID}"
		          ,'REMARK_A'     : $("#txtRemarkA").val() //요약
		          ,'REMARK_B'     : $("#txtRemarkB").val() //소견
		          ,'PURPS'        : $("#txtPurps"  ).val() //변경여부
		          ,'JOB_SE'       : "${loginMap.TASK_TY_CODE}"
		          ,'UPDATE_ID'    : "${loginMap.USER_ID}"
		          ,'REPORT_SE'    : 'K00'
		          ,'DATA_SE'      : 'A'
		          ,'REPORT_SN'    : g_REPORT_SN
		          ,'CRUD'         : '${CRUD}'
		          ,'REPORT_TYPE'  : 'P'
		          ,'OPRTN_DE'     : txtDay1
		          ,'EXPECT_DE'    : txtDay2
		          ,'COL_A'        : $("#txtColA").val() //피험자 번호
		          ,'COL_B'        : $(':radio[name="txtColB"]:checked').val() //성별
		          ,'COL_C'        : $("#txtColC").val() //이니셜
		          ,'COL_D'        : $(':radio[name="txtColD"]:checked').val() //변경여부
		};
		arJson.push(visitInfo);

		/////////////////////////CTMS_ST_REPORT_ITEM//////////////////////////
		var addItem = {};
		var isCheck = "";
		$("input[name=chk]").each(function(idx){
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
		              ,'CRUD'         : '${CRUD}'
		              ,'DATA_SE'      : 'B'
		              ,'UPDATE_ID'    : "${loginMap.USER_ID}"
		              ,'USE_AT'       : "Y"
			} //addItem
			
			arJson.push(addItem);
		});

		/////////////////////// SAVE //////////////////////////
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

	}); //btnSave

	//결재요청 버튼 클릭
	$("#btnApproval").click(function() {
		mkLayerPopupOpen("<c:url value='/com/z09/popupCOMZ0901.do'/>", {
			'REQUST_NM': '내용 확인서',
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
  		var g_RD_NAME = "CTMZ1201_NSS-301-FORM 04-SIVR-Ver.02.mrd";
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
				g_REPORT_INFO = data.info;
				g_REPORT_SN   = g_REPORT_INFO.REPORT_SN;
				g_SETLE_NO    = g_REPORT_INFO.SETLE_NO;
				g_ITEM        = data.item;
				
				$("#txtInsttNm"   ).val(g_REPORT_INFO.INSTT_NAME );
				$("#txtInsttCd"   ).val(g_REPORT_INFO.INSTT_CODE );
				$("#txtResearchId").val(g_REPORT_INFO.RSRCHMAN_ID);
				$("#txtResearchNm").val(g_REPORT_INFO.RSRCHMAN_NM);
				$("#txtRemarkA"   ).val(g_REPORT_INFO.REMARK_A   );
				$("#txtRemarkB"   ).val(g_REPORT_INFO.REMARK_B   );
				$("#txtPurps"     ).val(g_REPORT_INFO.PURPS      );
				$("#txtOprtnDe"   ).val(g_REPORT_INFO.OPRTN_DATE );
				$("#txtExpectDe"  ).val(g_REPORT_INFO.EXPECT_DATE);
				$("#txtColA"      ).val(g_REPORT_INFO.COL_A      );
				$('input:radio[name=txtColB]:input[value='+g_REPORT_INFO.COL_B+']').attr("checked", true);
				$("#txtColC"      ).val(g_REPORT_INFO.COL_C      );
				$('input:radio[name=txtColD]:input[value='+g_REPORT_INFO.COL_D+']').attr("checked", true);

				$("input[id=txtTaskNo]"    ).attr("readonly",true);
				$("input[id=txtInsttNm]"   ).attr("readonly",true);
				$("input[id=txtResearchNm]").attr("readonly",true);
				
				for(var i=0; g_ITEM.length > i; i++){
					if(g_ITEM[i].ITEM_VALUE == "Y"){
						$("input:checkbox[id='"+g_ITEM[i].ITEM_SE+"']").prop("checked", true);
					}
				}

				if(g_SETLE_NO){
					grid_wrap_03.proxy.param = {'REQUEST_NO' : g_REPORT_INFO.SETLE_NO};
					grid_wrap_03.load();

					$("input[id=txtColA]").attr("readonly",true);
					$("input[name=txtColB]").attr("disabled",true);
					$("input[id=txtColC]").attr("readonly",true);
					$("input[name=txtColD]").attr("disabled",true);
					
					$("textarea[id=txtRemarkA]").attr("readonly",true);
					$("textarea[id=txtRemarkB]").attr("readonly",true);
					$("textarea[id=txtPurps]"  ).attr("readonly",true);

					$("#txtOprtnDe" ).datepicker("disable");
					$("#txtExpectDe").datepicker("disable");
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


</script>


</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1401&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ1401&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>일탈 로그</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>일탈 로그</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">




					<article>
						<h5>계획서 일탈 보고서</h5>
					</article>

					<div style="height:10px;"></div>



<!--
					<article style="text-align: right; margin-bottom: 10px;">
						<input type="button" id="" value="저장">
					</article>
-->




					<table class="tb001">
						<colgroup>
							<col width="220px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>시험제목 Title</th>
								<td>
									<input type="text" id="txtTaskNo" style="width:100%;" value="${loginMap.TASK_NO}">
								</td>
							</tr>
							<tr>
								<th>시험책임자 Principal Investigator</th>
								<td>
									<input type="hidden" id="txtResearchId" style="width:100%;" value="${result.USER_ID}">
									<input type="text" id="txtResearchNm" style="width:100%;" value="${result.USER_NM}">
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="hidden" id="txtInsttCd" value="${result.INSTT_CODE}">
									<input type="text"   id="txtInsttNm" style="width:100%;" value="${result.NAME1}">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>



					<table class="tb001">
						<colgroup>
							<col width="18%" />
							<col width="21%" />
							<col width="15%" />
							<col width="12%" />
							<col width="12%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>피험자 번호 Subject No.</th>
								<td><input type="text" id="txtColA" style="width:100%;" value=""></td>
								<th>성별 Gender</th>
								<td>
									<input type="radio" name="txtColB" id="colF" value="F"><label for="colF" class="raLab"><span>F</span></label>
									<span style=" padding:0 5px;"></span>
									<input type="radio" name="txtColB" id="colM" value="M"><label for="colM" class="raLab"><span>M</span></label>
								</td>
								<th>이니셜 Initial</th>
								<td><input type="text" id="txtColC" style="width:100%;" value=""></td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>



					<table class="tb001 tb001_01">
						<colgroup>
							<col width="" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
							<col width="20%" />
						</colgroup>
						<tbody>
							<tr>
								<th>일탈의 형태 Deviation Type</th>
								<td>
									<div class="ck_01"><input type="checkbox" name="chk" id="a1" ><label for="a1" class="chcLab"><span>불이행<br><em style="margin-left:20px;">deviation</em></span></label></div>
								</td>
								<td>
									<div class="ck_01"><input type="checkbox" name="chk" id="a2" ><label for="a2" class="chcLab"><span>규정위반<br><em style="margin-left:20px;">violation</em></span></label></div>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<th>일탈의 원인<br>Deviation was</th>
								<td>
									<div class="ck_01"><input type="checkbox" name="chk" id="a3" ><label for="a3" class="chcLab"><span>의도하지 않음<br><em style="margin-left:20px;">Inadvertent</em></span></label></div>
								</td>
								<td>
									<div class="ck_01"><input type="checkbox" name="chk" id="a4" ><label for="a4" class="chcLab"><span>의도됨<br><em style="margin-left:20px;">Intentional</em></span></label></div>
								</td>
								<td colspan="2">
									<div class="ck_01"><input type="checkbox" name="chk" id="a5" ><label for="a5" class="chcLab"><span>피험자 보호를 위해 필요함<br><em style="margin-left:20px;">Necessary to protect the subject's welfare</em></span></label></div>
								</td>
							</tr>
							<tr>
								<th>일탈의 종류<br>Deviation involved</th>
								<td>
									<div class="ck_01"><input type="checkbox" name="chk" id="a6" ><label for="a6" class="chcLab"><span>관련 문서<br><em style="margin-left:20px;">Study Article</em></span></label></div>
									<div class="ck_01"><input type="checkbox" name="chk" id="a7" ><label for="a7" class="chcLab"><span>피험자 등록<br><em style="margin-left:20px;">Enrollment</em></span></label></div>
								</td>
								<td>
									<div class="ck_01"><input type="checkbox" name="chk" id="a8" ><label for="a8" class="chcLab"><span>임상시험절차<br><em style="margin-left:20px;">Procedure</em></span></label></div>
									<div class="ck_01"><input type="checkbox" name="chk" id="a9" ><label for="a9" class="chcLab"><span>임상시험용의약품<br><em style="margin-left:20px;">IP</em></span></label></div>
								</td>
								<td colspan="2">
									<div class="ck_01"><input type="checkbox" name="chk" id="a10" ><label for="a10" class="chcLab"><span>피험자 방문<br><em style="margin-left:20px;">Visit</em></span></label></div>
									<div class="ck_01"><input type="checkbox" name="chk" id="a11" ><label for="a11" class="chcLab"><span>기타<br><em style="margin-left:20px;">Others (Detail in Summary)</em></span></label></div>
								</td>
							</tr>
							<tr>
								<th>일자<br>Dates</th>
								<td>발생일 Occurred on</td>
								<td>
									<div class="dateBox">
										<input type="text" id="txtOprtnDe" style="width: 120px;" />
									</div>
								</td>
								<td>발견일 Discovered on</td>
								<td>
									<div class="dateBox">
										<input type="text" id="txtExpectDe" style="width: 120px;" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>
					
					
					

					<table class="tb001">
						<colgroup>
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>요약 Summary</th>
							</tr>
							<tr>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtRemarkA" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					
					


					<table class="tb001">
						<colgroup>
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>소견 Summary</th>
							</tr>
							<tr>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtRemarkB" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>
					
					
					

					<table class="tb001">
						<colgroup>
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>
									<span style="position:relative; top:-4px;">시험계획서 변경이 필요합니까? Should the protocol be amended?</span>
									<span style=" padding:0 5px;"></span>
									<input type="radio" name="txtColD" id="colY" value="Y"><label for="colY" class="raLab"><span>예 Yes</span></label>
									<span style=" padding:0 5px;"></span>
									<input type="radio" name="txtColD" id="colN" value="N"><label for="colN" class="raLab"><span>아니오 No  (If yes, explain)</span></label>
								</th>
							</tr>
							<tr>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtPurps" rows="5" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 결제</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnApprovalInfo" value="<spring:message code="ctmz0201.btn.ApprovalInfo" />">
                        <input type="button" id="btnApproval"     value="<spring:message code="ctmz0201.btn.ApprovalRequest" />">
                    </article>
					<div style="height:10px;"></div>
					<div id="grid_wrap_03" class="gridHeiSz02 grid_wrap tb01_2"></div>



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