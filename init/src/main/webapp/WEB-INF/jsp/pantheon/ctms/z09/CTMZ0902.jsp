<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false" />

<title></title>

<script type="text/javascript" src="<c:url value='/js/pantheon/common/ctms/ctms.js'/>"></script>
<script>
var g_CRUD         = '${CRUD}';
var g_REPORT_SN    = '${REPORT_SN}';
var g_SETLE_NO     = '${SETLE_NO}';
var g_TASK_SN      = "${loginMap.TASK_SN}";
var g_USER_ID      = "${loginMap.USER_ID}";
var g_MILESTONE_SN = "${result.MILESTONE_SN}";
var g_REPORT_TYPE  = "V";
var g_REPORT_INFO;
var g_ITEM;

var g_EMAIL_URL        = "<c:url value='/ctms/z02/insertApprovalEmail.do'/>";
var g_UPDATE_APPOROVAL = "<c:url value='/ctms/z03/updateReportApprovalSn.do'/>";

var grid_wrap_01 = {
    id: '',
    div: {
      gridDiv: '#grid_wrap_01'
    },
    proxy: {
        url: "<c:url value='/ctms/z03/selectVisitInfoGrid.do'/>",
        param: {},
        type: 'post',
        dataType: 'json',
        autoLoad: false,

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
        selectionMode : "multipleCells",
        softRemoveRowMode  : true,
        softRemovePolicy   : "exceptNew",
        reverseRowNum : true,
    },
    columnLayout : [{
        dataField : "NM",
        headerText : '<spring:message code="ctmz0201.gr.NAME" />',
        width : 100,
        editRenderer : {
            type: "InputEditRenderer",
            validator : function(oldValue, newValue, rowItem){
                var isValid = false;

                validator(newValue);

                if(validatorCnt <= 100){
                    isValid = true;
                }
                // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
            }
        }
    },{
        dataField : "ROLE_NM",
        headerText : "<spring:message code='ctmz0201.gr.ROLE_NM' />",
        width : 200,
        editRenderer : {
            type: "InputEditRenderer",
            validator : function(oldValue, newValue, rowItem){
                var isValid = false;

                validator(newValue);

                if(validatorCnt <= 100){
                    isValid = true;
                }
                // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
            }
        }
    },{
        dataField : "PSITN",
        headerText : "<spring:message code='ctmz0201.gr.PSITN' />",
        editRenderer : {
            type: "InputEditRenderer",
            validator : function(oldValue, newValue, rowItem){
                var isValid = false;

                validator(newValue);

                if(validatorCnt <= 500){
                    isValid = true;
                }
                // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
            }
        }
    },{
        dataField : "ITEM_SE",
        headerText : "ITEM_SE",
        visible : false
    },{
        dataField : "VISIT_SN",
        headerText : "VISIT_SN",
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
    binding: function() {

    },
    load: function(v1, v2) {

        var me = this;

        $.ajax({
            url: me.proxy.url,
            type: me.proxy.type,
            dataType: me.proxy.dataType,
            data: me.proxy.param,
            success:function(data){
                if(data.success) {
                    AUIGrid.setGridData(me.id, data.result);
                    AUIGrid.setSelectionByIndex(me.id, 0);
                } else {
                    AUIGrid.removeAjaxLoader(me.id);
                    alert(data.message);
                }
            },
            error : function(jqXHR, textStatus, errorThrown){
                alert(textStatus);
            }
        });
    }
};


var grid_wrap_02 = {
	id: '',
    div: {
        gridDiv: '#grid_wrap_02'
    },
    proxy: {
        url: "<c:url value='/ctms/z03/selectVisitInfoGrid.do'/>",
        param: {},
        type: 'post',
        dataType: 'json',
        autoLoad: false,
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
        selectionMode : "multipleCells",
        softRemoveRowMode  : true,
        softRemovePolicy   : "exceptNew",
        reverseRowNum : true,
    },
    columnLayout : [{
        dataField : "NM",
        headerText : "<spring:message code="ctmz0201.gr.NAME" />",
        width : 100,
        editRenderer : {
            type: "InputEditRenderer",
            validator : function(oldValue, newValue, rowItem){
                var isValid = false;
    
                validator(newValue);
    
                if(validatorCnt <= 100){
                    isValid = true;
                }
                // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
            }
        }
    },{
        dataField : "ROLE_NM",
        headerText : "<spring:message code='ctmz0201.gr.ROLE_NM' />",
        width : 200,
        editRenderer : {
            type: "InputEditRenderer",
            validator : function(oldValue, newValue, rowItem){
                var isValid = false;
            
                validator(newValue);
            
                if(validatorCnt <= 100){
                    isValid = true;
                }
                // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
            }
        }
    },{
        dataField : "PSITN",
        headerText : "<spring:message code='ctmz0201.gr.PSITN' />",
        editRenderer : {
            type: "InputEditRenderer",
            validator : function(oldValue, newValue, rowItem){
                var isValid = false;
                validator(newValue);
                if(validatorCnt <= 500){
                    isValid = true;
                }
                // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                return{"validate" : isValid, "message" : "범위를 초과하였습니다."};
            }
        }
    },{
        dataField : "ITEM_SE",
        headerText : "ITEM_SE",
        visible : false
    },{
        dataField : "VISIT_SN",
        headerText : "VISIT_SN",
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
                        AUIGrid.setGridData(me.id, data.result);
                        AUIGrid.setSelectionByIndex(me.id, 0);
                    } else {
                        AUIGrid.removeAjaxLoader(me.id);
                        alert(data.message);
                    }
                },
            error : function(jqXHR, textStatus, errorThrown){
                alert(textStatus);
            }
        });
    }
};

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
	grid_wrap_01.createGrid();
	grid_wrap_02.createGrid();
	grid_wrap_03.createGrid();
	mkSetDatePickerYYMMDD("#day_01");
	mkSetDatePickerYYMMDD("#day_02");
	mkSetDatePickerYYMMDD("#day_03");
	
	$("input[id=txtTaskNo]"    ).attr("readonly",true);
	$("input[id=txtInsttNm]"   ).attr("readonly",true);
	$("input[id=txtResearchNm]").attr("readonly",true);

	fn_btnApproval();
	
	if(g_CRUD == "U"){
		fn_selectReportInfo();
	}
	else{ //신규
		$("#txtInputSubjectCo").val("0");
	}
	
	$("#btnSave").click(function(){
		
		//사이즈 체크
		
		if(confirm("저장하시겠습니까?")){
			
		}
		else{
			return;
		}
		
		var arJson = [];

///////////////////////////CTMS_ST_REPORT_VISIT////////////////////////////

		// 추가된 행 아이템들(배열)
		var addedRowItems1 = AUIGrid.getAddedRowItems(grid_wrap_01.id);	
		var addedRowItems2 = AUIGrid.getAddedRowItems(grid_wrap_02.id);
		// 수정된 행 아이템들(배열)
		var editedItems1 = AUIGrid.getEditedRowItems(grid_wrap_01.id);
		var editedItems2 = AUIGrid.getEditedRowItems(grid_wrap_02.id);
		// 삭제된 행 아이템들(배열)
		var removeItems1 = AUIGrid.getRemovedItems(grid_wrap_01.id);
		var removeItems2 = AUIGrid.getRemovedItems(grid_wrap_02.id);
		
		// 외부참석자 그리드 
		for(var i = 0; i < addedRowItems1.length; i++) {
			addedRowItems1[i].CRUD         = 'C';
			addedRowItems1[i].REPORT_SN    = g_REPORT_SN;
			addedRowItems1[i].TASK_SN      = g_TASK_SN;			
			addedRowItems1[i].MILESTONE_SN = g_MILESTONE_SN;
			addedRowItems1[i].REPORT_TYPE  = 'V';	
			addedRowItems1[i].DATA_SE      = 'C';
			arJson.push(addedRowItems1[i]);			
		}
		
		for(var i = 0; i < editedItems1.length; i++) {
			editedItems1[i].CRUD        = 'U';			
			editedItems1[i].DATA_SE     = 'C';
			editedItems1[i].REPORT_TYPE = 'V';
			editedItems1[i].UPDATE_ID   = g_USER_ID;
			arJson.push(editedItems1[i]);
		}
		
		for(var i = 0; i < removeItems1.length; i++) {
			removeItems1[i].CRUD        = 'D';
			removeItems1[i].DATA_SE     = 'C';	
			removeItems1[i].REPORT_TYPE = 'V';
			removeItems1[i].UPDATE_ID   = g_USER_ID;			
			arJson.push(removeItems1[i]);
		}
		
		// 내부참석자 그리드
		for(var i = 0; i < addedRowItems2.length; i++) {
			addedRowItems2[i].CRUD         = 'C';
			addedRowItems2[i].REPORT_SN    = g_REPORT_SN;
			addedRowItems2[i].TASK_SN      = g_TASK_SN;		
			addedRowItems2[i].MILESTONE_SN = g_MILESTONE_SN;
			addedRowItems2[i].REPORT_TYPE  = 'V';	
			addedRowItems2[i].DATA_SE      = 'C';
			arJson.push(addedRowItems2[i]);			
		}
		
		for(var i = 0; i < editedItems2.length; i++) {
			editedItems2[i].CRUD        = 'U';
			editedItems2[i].DATA_SE     = 'C';
			editedItems2[i].REPORT_TYPE = 'V';
			editedItems2[i].UPDATE_ID   = g_USER_ID
			arJson.push(editedItems2[i]);
		}
		
		for(var i = 0; i < removeItems2.length; i++) {
			removeItems2[i].CRUD        = 'D';
			removeItems2[i].ITEM_SE     = 'C';
			removeItems2[i].REPORT_TYPE = 'V';
			removeItems2[i].UPDATE_ID   = g_USER_ID;
			arJson.push(removeItems2[i]);
		}

///////////////////////////CTMS_ST_REPORT_MAIN////////////////////////////

		var day01Data = $("#day_01").val();
		var day01Split = day01Data.split("-");
		var day01Value = day01Split[0]+day01Split[1]+day01Split[2]+"000000";
		
		var day02Data = $('#day_02').val();
	    var day02Split = day02Data.split('-');
	    var day02Value = day02Split[0]+day02Split[1]+day02Split[2]+"000000";
	    
	    var day03Data = $('#day_03').val();
	    var day03Split = day03Data.split('-');
	    var day03Value = day03Split[0]+day03Split[1]+day03Split[2]+"000000";
		
		var visitInfo = {
		           'TASK_SN'      : "${loginMap.TASK_SN}"
		          ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
		          ,'RSRCHMAN_ID'  : $("#txtResearchId").val()
		          ,'INSTT_CODE'   : "${result.INSTT_CODE}"
		          ,'OPRTN_DE'     : day01Value //실시일
		          ,'CHARGER_ID'   : "${loginMap.USER_ID}"
		          ,'REMARK_A'     : $("#txtRemarkA").val()
		          ,'JOB_SE'       : "${loginMap.TASK_TY_CODE}"
		          ,'UPDATE_ID'    : "${loginMap.USER_ID}"
		          ,'REPORT_SE'    : 'G02'
		          ,'DATA_SE'      : 'A'
		          ,'REPORT_SN'    : g_REPORT_SN
		          ,'CRUD'         : '${CRUD}'
		          ,'REPORT_TYPE'  : 'V'
		          ,'COL_A'        : $("#txtInputSubjectCo").val() //피험자 수
		          ,'COL_B'        : day02Value //스크리닝 개시 예정일
		          ,'COL_C'        : day03Value //모집기한
		};
		arJson.push(visitInfo);
		
/////////////////////////CTMS_ST_REPORT_ITEM//////////////////////////
        var totalRows = $("tbody[id]").length;
        var params = [  $("tbody[id]").find('tr[name=trA]').length,
                        $("tbody[id]").find('tr[name=trB]').length,
                        $("tbody[id]").find('tr[name=trC]').length,
                        $("tbody[id]").find('tr[name=trD]').length,
                        $("tbody[id]").find('tr[name=trE]').length,
                        $("tbody[id]").find('tr[name=trF]').length,
                        $("tbody[id]").find('tr[name=trG]').length,
                        $("tbody[id]").find('tr[name=trH]').length,
                        $("tbody[id]").find('tr[name=trI]').length,
                        $("tbody[id]").find('tr[name=trJ]').length,
                        $("tbody[id]").find('tr[name=trK]').length,
                        $("tbody[id]").find('tr[name=trL]').length,
                        $("tbody[id]").find('tr[name=trM]').length
                        ];
        var addItems = {};
        var num = 97; //아스키코드 소문자 a
		var item;
		var a_value;

		for(var j=0; j<totalRows; j++){
			a_value = String.fromCharCode(num);	//아스키코드를 문자형으로..
			num++;
			
			for(var i=1; i<=params[j]; i++){
				addItems[i] = {
			               'REPORT_SN'    : g_REPORT_SN
			              ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
			              ,'TASK_SN'      : "${loginMap.TASK_SN}"
			              ,'REPORT_TYPE'  : 'V'
			              ,'ITEM_SE'      : a_value+i
			              ,'ITEM_VALUE'   : $('input:radio[name="'+a_value+i+'"]:checked').val()
			              ,'CHARGER_ID'   : "${loginMap.USER_ID}"
			              ,'RM'           : ''
			              ,'SUBJECT_CO'   : '0'
			              ,'DTE'          : ''
			              ,'CRUD'         : '${CRUD}'
			              ,'DATA_SE'      : 'B'
			              ,'UPDATE_ID'    : "${loginMap.USER_ID}"
			              ,'USE_AT'       : "Y"
				} //addItem
				
				if(!$(':input:radio[name="'+a_value+i+'"]:checked').val()){
					alert("선택되지 않은 항목이 있습니다.");
					return;
				}

				arJson.push(addItems[i]);	
			}
		} // for

		console.log(arJson);
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
		});

	});

    //Grid1 row Add
    $("#btnAddrow1").click(function(){
        var row = {
                   'NM'        : ''
                  ,'ROLE_NM'   : ''
                  ,'PSITN'     : ''
                  ,'ITEM_SE'   : '01' //외부참석자
                  ,'UPDATE_ID' : g_USER_ID
                  ,'DATA_SE'   : 'C'
                  ,'VISIT_SN'  : ''
          };
          AUIGrid.addRow(grid_wrap_01.id, row, 'first'); // 최상단에 행 추가
    });

    //Grid1 row Delete
    $("#btnRowDel1").click(function(){
        AUIGrid.removeRow(grid_wrap_01.id, "selectedIndex");
    });

    //Grid2 row Add
    $("#btnAddrow2").click(function(){
        var row = {
                       'NM'        : ''
                      ,'ROLE_NM'   : ''
                      ,'PSITN'     : ''
                      ,'ITEM_SE'   : '02' //내부참석자
                      ,'UPDATE_ID' : g_USER_ID
                      ,'DATA_SE'   : 'C'
                      ,'VISIT_SN'  : ''
          };
          AUIGrid.addRow(grid_wrap_02.id, row, 'first'); // 최상단에 행 추가
    });

    //Grid2 row Delete
    $("#btnRowDel2").click(function(){
        AUIGrid.removeRow(grid_wrap_02.id, "selectedIndex");
    });

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

	$('#tab_menu1').click(function(){
		var p_REPORT_SE    = 'G01';
		var p_REPORT_TYPE  = 'P';
		var p_APPROVAL_URL = "<c:url value='/ctms/z09/CTMZ0901.do'/>";
		fn_goTapPage(p_REPORT_SE, p_REPORT_TYPE, p_APPROVAL_URL);
	});

	//RD 출력버튼
  	$("#btnPrint").click(function(){
  		var g_RD_NAME = "CTMZ0902_NSS-301-FORM 04-SIVR-Ver.02.mrd";
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

				$("#txtInsttNm"       ).val(g_REPORT_INFO.INSTT_NAME );
				$("#txtInsttCd"       ).val(g_REPORT_INFO.INSTT_CODE );
				$("#txtResearchId"    ).val(g_REPORT_INFO.RSRCHMAN_ID);
				$("#txtResearchNm"    ).val(g_REPORT_INFO.RSRCHMAN_NM);
				$("#day_01"           ).val(g_REPORT_INFO.OPRTN_DATE );
				$("#day_02"           ).val(g_REPORT_INFO.COL_B      );
				$("#day_03"           ).val(g_REPORT_INFO.COL_C      );
				$("#txtInputSubjectCo").val(g_REPORT_INFO.COL_A      );
				$("#txtRemarkA"       ).val(g_REPORT_INFO.REMARK_A   );
				
				$("input[id=txtTaskNo]"    ).attr("readonly",true);
				$("input[id=txtInsttNm]"   ).attr("readonly",true);
				$("input[id=txtResearchNm]").attr("readonly",true);
				
				for(var i=0; g_ITEM.length > i; i++){
					$('input:radio[name="'+g_ITEM[i].ITEM_SE+'"]:input[value="'+g_ITEM[i].ITEM_VALUE+'"]').attr('checked',true);
				}

	    	  	var params1 = { 'MILESTONE_SN' : g_MILESTONE_SN, 'TASK_SN' : g_TASK_SN, 'ITEM_SE' : '01', 'REPORT_SN' : g_REPORT_SN };
	    	  	var params2 = { 'MILESTONE_SN' : g_MILESTONE_SN, 'TASK_SN' : g_TASK_SN, 'ITEM_SE' : '02', 'REPORT_SN' : g_REPORT_SN };
	    		grid_wrap_01.proxy.param = params1;	    	  	    	  	
	    	  	grid_wrap_02.proxy.param = params2;	    		
	    	  	grid_wrap_01.load();
	    	  	grid_wrap_02.load();

				if(g_SETLE_NO){
					grid_wrap_03.proxy.param = {'REQUEST_NO' : g_REPORT_INFO.SETLE_NO};
					grid_wrap_03.load();

					$("textarea[id=txtRemarkA]").attr("readonly",true);
					
					$("#day_01").datepicker("disable");
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
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0902&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0902&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
	<section id="mainCon">
		<div class="mainConInner">


			<article class="mainTitBox">
				<h3>개시 미팅</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>Report</li>
						<li>개시 미팅</li>
					</ul>
				</nav>
			</article>



            <section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">



					<div id="tab" class="tab tab01">
						<ul>
							<li id="tab_menu1" class="tab_menu">개시 미팅 준비기록</li>
							<li id="tab_menu2" class="port_back tab_menu">시험 개시방문 보고서</li>
						</ul>
					</div>



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
								<th>시험 제목 Title</th>
								<td>
									<input type="text" id="txtTaskNo" style="width:100%;" value="${loginMap.TASK_NO}">
									<!-- button type="button" class="oneBtn">
										<img class="oneBtnIco" src="http://52.2.72.226:8080/images/pantheon/common/searchIco.png" alt="검색">
									</button-->
								</td>
							</tr>
							<tr>
								<th>시험기관 Clinical Trial Site</th>
								<td>
									<input type="hidden" id="txtInsttCd" value="${result.INSTT_CODE}">
									<input type="text" id="txtInsttNm" style="width:100%;" value="${result.NAME1}">
								</td>
							</tr>
							<tr>
								<th>시험책임자 Principal Investigator</th>
								<td>
									<input type="hidden" id="txtResearchId" style="width:100%;" value="${result.USER_ID}">
									<input type="text" id="txtResearchNm" style="width:100%;" value="${result.USER_NM}">
									<!-- button type="button" class="oneBtn">
										<img class="oneBtnIco" src="http://52.2.72.226:8080/images/pantheon/common/searchIco.png" alt="검색">
									</button-->
								</td>
							</tr>
						</tbody>
					</table>
					
					
					<div style="height:20px;"></div>

                    <article class="conTitBox">
                        <h6>
							실시일 Date : 
							<div class="dateBox">
								<input type="text" id="day_01" style="width: 120px;" />
							</div>
						</h6>
                    </article>

					<div style="height:10px;"></div>


                    <article class="conTitBox" style="float:left; position:relative; top:7px;">
                        <h6>참가자 Attendees</h6>
                    </article>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAddrow1" value="행추가" class="add_01" title="<spring:message code="ctmz0201.btn.Add" />" >
	                    <input type="button" id="btnRowDel1" value="행삭제" class="del_01" title="<spring:message code="ctmz0201.btn.Del" />" >
					</div>
					<div id="grid_wrap_01" class="gridHeiSz02 grid_wrap tb01_2"></div>	


					<div style="height:20px;"></div>

					<div style="text-align:right; margin:5px;">
						<input type="button" id="btnAddrow2" value="행추가" class="add_01" title="<spring:message code="ctmz0201.btn.Add" />" >
	                    <input type="button" id="btnRowDel2" value="행삭제" class="del_01" title="<spring:message code="ctmz0201.btn.Del" />" >
					</div>
					<div id="grid_wrap_02" class="gridHeiSz02 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 시험계획서 Protocol</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbA">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trA">
								<td>1</td>
								<td>임상시험의 목적/디자인 Trial purpose/design</td>
								<td><input type="radio" id="a11" name="a1" value="Y"><label for="a11" class="raLab"></label></td>
								<td><input type="radio" id="a12" name="a1" value="N"><label for="a12" class="raLab"></label></td>
								<td><input type="radio" id="a13" name="a1" value="X"><label for="a13" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>2</td>
								<td>선정/제외기준 Inclusion and exclusion criteria</td>
								<td><input type="radio" id="a21" name="a2" value="Y"><label for="a21" class="raLab"></label></td>
								<td><input type="radio" id="a22" name="a2" value="N"><label for="a22" class="raLab"></label></td>
								<td><input type="radio" id="a23" name="a2" value="X"><label for="a23" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>3</td>
								<td>탈락/시험종료기준 Drop-out and study completion criteria</td>
								<td><input type="radio" id="a31" name="a3" value="Y"><label for="a31" class="raLab"></label></td>
								<td><input type="radio" id="a32" name="a3" value="N"><label for="a32" class="raLab"></label></td>
								<td><input type="radio" id="a33" name="a3" value="X"><label for="a33" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>4</td>
								<td>임상시험의 절차, 요구사항 및 계획엄수 Study procedure, requirements and adherence</td>
								<td><input type="radio" id="a41" name="a4" value="Y"><label for="a41" class="raLab"></label></td>
								<td><input type="radio" id="a42" name="a4" value="N"><label for="a42" class="raLab"></label></td>
								<td><input type="radio" id="a43" name="a4" value="X"><label for="a43" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>5</td>
								<td>시험계획서의 개정절차 Procedures for protocol amendments</td>
								<td><input type="radio" id="a51" name="a5" value="Y"><label for="a51" class="raLab"></label></td>
								<td><input type="radio" id="a52" name="a5" value="N"><label for="a52" class="raLab"></label></td>
								<td><input type="radio" id="a53" name="a5" value="X"><label for="a53" class="raLab"></label></td>
							</tr>
							<tr name="trA">
								<td>6</td>
								<td>시험계획서 일탈/위반사항의 문서화 Documentation of protocol deviations or violation</td>
								<td><input type="radio" id="a61" name="a6" value="Y"><label for="a61" class="raLab"></label></td>
								<td><input type="radio" id="a62" name="a6" value="N"><label for="a62" class="raLab"></label></td>
								<td><input type="radio" id="a63" name="a6" value="X"><label for="a63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>
					
					

                    <article class="conTitBox">
                        <h6>2. 피험자 모집 Recruitment of Trial Subjects</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbB">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trB">
								<td>1</td>
								<td>본 기관의 모집목표 피험자 수 Planned Subjects No. : <input type="text" id="txtInputSubjectCo" style="width:100px;"> 명</td>
								<td><input type="radio" id="b11" name="b1" value="Y"><label for="b11" class="raLab"></label></td>
								<td><input type="radio" id="b12" name="b1" value="N"><label for="b12" class="raLab"></label></td>
								<td><input type="radio" id="b13" name="b1" value="X"><label for="b13" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>2</td>
								<td>스크리닝 개시 예정일 Anticipated Screening Date <div class="dateBox"><input type="text" id="day_02" style="width: 120px;" /></div>
								<td><input type="radio" id="b21" name="b2" value="Y"><label for="b21" class="raLab"></label></td>
								<td><input type="radio" id="b22" name="b2" value="N"><label for="b22" class="raLab"></label></td>
								<td><input type="radio" id="b23" name="b2" value="X"><label for="b23" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>3</td>
								<td>모집 기한 Recruitment timelines <div class="dateBox"><input type="text" id="day_03" style="width: 120px;" /></div>
								<td><input type="radio" id="b31" name="b3" value="Y"><label for="b31" class="raLab"></label></td>
								<td><input type="radio" id="b32" name="b3" value="N"><label for="b32" class="raLab"></label></td>
								<td><input type="radio" id="b33" name="b3" value="X"><label for="b33" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>4</td>
								<td>광고매체 승인 및 개정 Advertising materials approval and revision requirements</td>
								<td><input type="radio" id="b41" name="b4" value="Y"><label for="b41" class="raLab"></label></td>
								<td><input type="radio" id="b42" name="b4" value="N"><label for="b42" class="raLab"></label></td>
								<td><input type="radio" id="b43" name="b4" value="X"><label for="b43" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>5</td>
								<td>스크리닝 방법 Screening process</td>
								<td><input type="radio" id="b51" name="b5" value="Y"><label for="b51" class="raLab"></label></td>
								<td><input type="radio" id="b52" name="b5" value="N"><label for="b52" class="raLab"></label></td>
								<td><input type="radio" id="b53" name="b5" value="X"><label for="b53" class="raLab"></label></td>
							</tr>
							<tr name="trB">
								<td>6</td>
								<td>보험 및 피험자에 대한 보상 Indemnity insurance and subject compensations</td>
								<td><input type="radio" id="b61" name="b6" value="Y"><label for="b61" class="raLab"></label></td>
								<td><input type="radio" id="b62" name="b6" value="N"><label for="b62" class="raLab"></label></td>
								<td><input type="radio" id="b63" name="b6" value="X"><label for="b63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>3. 임상시험용의약품 Investigational Product</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbC">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trC">
								<td>1</td>
								<td>임상시험용의약품 포장/배포를 위한 물품(e.g., 라벨 등) Investigational product packaging and dispensing product (e.g., label etc.)</td>
								<td><input type="radio" id="c11" name="c1" value="Y"><label for="c11" class="raLab"></label></td>
								<td><input type="radio" id="c12" name="c1" value="N"><label for="c12" class="raLab"></label></td>
								<td><input type="radio" id="c13" name="c1" value="X"><label for="c13" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>2</td>
								<td>임상시험용의약품의 인수, 취급, 저장, 회수 및/또는 폐기 Receipt, handling, storage, return, and/or destruction of investigational product</td>
								<td><input type="radio" id="c21" name="c2" value="Y"><label for="c21" class="raLab"></label></td>
								<td><input type="radio" id="c22" name="c2" value="N"><label for="c22" class="raLab"></label></td>
								<td><input type="radio" id="c23" name="c2" value="X"><label for="c23" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>3</td>
								<td>피험자의 순응도 확인 Compliance check</td>
								<td><input type="radio" id="c31" name="c3" value="Y"><label for="c31" class="raLab"></label></td>
								<td><input type="radio" id="c32" name="c3" value="N"><label for="c32" class="raLab"></label></td>
								<td><input type="radio" id="c33" name="c3" value="X"><label for="c33" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>4</td>
								<td>임상시험용의약품의 수불기록 Investigational product accountability and documentation</td>
								<td><input type="radio" id="c41" name="c4" value="Y"><label for="c41" class="raLab"></label></td>
								<td><input type="radio" id="c42" name="c4" value="N"><label for="c42" class="raLab"></label></td>
								<td><input type="radio" id="c43" name="c4" value="X"><label for="c43" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>5</td>
								<td>무작위배정 절차 Randomization procedures</td>
								<td><input type="radio" id="c51" name="c5" value="Y"><label for="c51" class="raLab"></label></td>
								<td><input type="radio" id="c52" name="c5" value="N"><label for="c52" class="raLab"></label></td>
								<td><input type="radio" id="c53" name="c5" value="X"><label for="c53" class="raLab"></label></td>
							</tr>
							<tr name="trC">
								<td>6</td>
								<td>눈가림 방법 및 눈가림 해제에 관한 절차 Blinding and code breaking procedures</td>
								<td><input type="radio" id="c61" name="c6" value="Y"><label for="c61" class="raLab"></label></td>
								<td><input type="radio" id="c62" name="c6" value="N"><label for="c62" class="raLab"></label></td>
								<td><input type="radio" id="c63" name="c6" value="X"><label for="c63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>4. 시험자 및 연구진 Investigator and Staff</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbD">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trD">
								<td>1</td>
								<td>시험자 및 연구진의 변경사항 Change of investigator &amp; staff</td>
								<td><input type="radio" id="d11" name="d1" value="Y"><label for="d11" class="raLab"></label></td>
								<td><input type="radio" id="d12" name="d1" value="N"><label for="d12" class="raLab"></label></td>
								<td><input type="radio" id="d13" name="d1" value="X"><label for="d13" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>2</td>
								<td>KGCP 및 관련 규정의 준수 Compliance with KGCP &amp; applicable regulatory requirements</td>
								<td><input type="radio" id="d21" name="d2" value="Y"><label for="d21" class="raLab"></label></td>
								<td><input type="radio" id="d22" name="d2" value="N"><label for="d22" class="raLab"></label></td>
								<td><input type="radio" id="d23" name="d2" value="X"><label for="d23" class="raLab"></label></td>
							</tr>
							<tr name="trD">
								<td>3</td>
								<td>역할 할당 및 문서화 Delegation and documentation of duties</td>
								<td><input type="radio" id="d31" name="d3" value="Y"><label for="d31" class="raLab"></label></td>
								<td><input type="radio" id="d32" name="d3" value="N"><label for="d32" class="raLab"></label></td>
								<td><input type="radio" id="d33" name="d3" value="X"><label for="d33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>5. 피험자 동의 절차 Informed Consent Process</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbE">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trE">
								<td>1</td>
								<td>피험자 동의서 취득 절차 Procedures of obtaining and documenting informed consent</td>
								<td><input type="radio" id="e11" name="e1" value="Y"><label for="e11" class="raLab"></label></td>
								<td><input type="radio" id="e12" name="e1" value="N"><label for="e12" class="raLab"></label></td>
								<td><input type="radio" id="e13" name="e1" value="X"><label for="e13" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>2</td>
								<td>피험자 동의서 변경 절차 Procedures for informed consent form amendment</td>
								<td><input type="radio" id="e21" name="e2" value="Y"><label for="e21" class="raLab"></label></td>
								<td><input type="radio" id="e22" name="e2" value="N"><label for="e22" class="raLab"></label></td>
								<td><input type="radio" id="e23" name="e2" value="X"><label for="e23" class="raLab"></label></td>
							</tr>
							<tr name="trE">
								<td>3</td>
								<td>서명된 피험자 동의서 보관 Documentation and retention of all signed informed consent</td>
								<td><input type="radio" id="e31" name="e3" value="Y"><label for="e31" class="raLab"></label></td>
								<td><input type="radio" id="e32" name="e3" value="N"><label for="e32" class="raLab"></label></td>
								<td><input type="radio" id="e33" name="e3" value="X"><label for="e33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>6. 근거문서 Source Documents</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbF">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trF">
								<td>1</td>
								<td>시험기관에서 사용하는 근거문서의 범위 Source document definition and source documents used by the site</td>
								<td><input type="radio" id="f11" name="f1" value="Y"><label for="f11" class="raLab"></label></td>
								<td><input type="radio" id="f12" name="f1" value="N"><label for="f12" class="raLab"></label></td>
								<td><input type="radio" id="f13" name="f1" value="X"><label for="f13" class="raLab"></label></td>
							</tr>
							<tr name="trF">
								<td>2</td>
								<td>임상시험 관련 기록의 보존 Maintenance of trial documents</td>
								<td><input type="radio" id="f21" name="f2" value="Y"><label for="f21" class="raLab"></label></td>
								<td><input type="radio" id="f22" name="f2" value="N"><label for="f22" class="raLab"></label></td>
								<td><input type="radio" id="f23" name="f2" value="X"><label for="f23" class="raLab"></label></td>
							</tr>
							<tr name="trF">
								<td>3</td>
								<td>SDV 절차 Source document verification process</td>
								<td><input type="radio" id="f31" name="f3" value="Y"><label for="f31" class="raLab"></label></td>
								<td><input type="radio" id="f32" name="f3" value="N"><label for="f32" class="raLab"></label></td>
								<td><input type="radio" id="f33" name="f3" value="X"><label for="f33" class="raLab"></label></td>
							</tr>
							<tr name="trF">
								<td>4</td>
								<td>근거문서 간에 불일치한 내용의 확인수정 Process for clarifying source document discrepancies</td>
								<td><input type="radio" id="f41" name="f4" value="Y"><label for="f41" class="raLab"></label></td>
								<td><input type="radio" id="f42" name="f4" value="N"><label for="f42" class="raLab"></label></td>
								<td><input type="radio" id="f43" name="f4" value="X"><label for="f43" class="raLab"></label></td>
							</tr>
							<tr name="trF">
								<td>5</td>
								<td>근거문서에 대한 접근 (전자문서 포함) Access to source documents(including electronic data)</td>
								<td><input type="radio" id="f51" name="f5" value="Y"><label for="f51" class="raLab"></label></td>
								<td><input type="radio" id="f52" name="f5" value="N"><label for="f52" class="raLab"></label></td>
								<td><input type="radio" id="f53" name="f5" value="X"><label for="f53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>7. 증례기록서 및 데이터의 수집 Case Report Form and Data Collection</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbG">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trG">
								<td>1</td>
								<td>증례기록서 작성을 위한 세부지침CRF completion guidelines</td>
								<td><input type="radio" id="g11" name="g1" value="Y"><label for="g11" class="raLab"></label></td>
								<td><input type="radio" id="g12" name="g1" value="N"><label for="g12" class="raLab"></label></td>
								<td><input type="radio" id="g13" name="g1" value="X"><label for="g13" class="raLab"></label></td>
							</tr>
							<tr name="trG">
								<td>2</td>
								<td>수정에 관한 절차 Procedures for corrections</td>
								<td><input type="radio" id="g21" name="g2" value="Y"><label for="g21" class="raLab"></label></td>
								<td><input type="radio" id="g22" name="g2" value="N"><label for="g22" class="raLab"></label></td>
								<td><input type="radio" id="g23" name="g2" value="X"><label for="g23" class="raLab"></label></td>
							</tr>
							<tr name="trG">
								<td>3</td>
								<td>증례기록서/데이터의 서명에 관한 사항 CRF/Data signature requirements</td>
								<td><input type="radio" id="g31" name="g3" value="Y"><label for="g31" class="raLab"></label></td>
								<td><input type="radio" id="g32" name="g3" value="N"><label for="g32" class="raLab"></label></td>
								<td><input type="radio" id="g33" name="g3" value="X"><label for="g33" class="raLab"></label></td>
							</tr>
							<tr name="trG">
								<td>4</td>
								<td>증례기록서/데이터의 작성기한 CRF/Data completion timelines</td>
								<td><input type="radio" id="g41" name="g4" value="Y"><label for="g41" class="raLab"></label></td>
								<td><input type="radio" id="g42" name="g4" value="N"><label for="g42" class="raLab"></label></td>
								<td><input type="radio" id="g43" name="g4" value="X"><label for="g43" class="raLab"></label></td>
							</tr>
							<tr name="trG">
								<td>5</td>
								<td>데이터 쿼리 해결 절차 Process of query resolution</td>
								<td><input type="radio" id="g51" name="g5" value="Y"><label for="g51" class="raLab"></label></td>
								<td><input type="radio" id="g52" name="g5" value="N"><label for="g52" class="raLab"></label></td>
								<td><input type="radio" id="g53" name="g5" value="X"><label for="g53" class="raLab"></label></td>
							</tr>
							<tr name="trG">
								<td>6</td>
								<td>전자자료 및 기록에 대한 규정의 준수 Regulatory requirements for electronic data and records</td>
								<td><input type="radio" id="g61" name="g6" value="Y"><label for="g61" class="raLab"></label></td>
								<td><input type="radio" id="g62" name="g6" value="N"><label for="g62" class="raLab"></label></td>
								<td><input type="radio" id="g63" name="g6" value="X"><label for="g63" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>8. 안전성 정보 Safety Information</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbH">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trH">
								<td>1</td>
								<td>이상반응 및 중대한 이상반응의 정의 Definition of AE and SAE	</td>
								<td><input type="radio" id="h11" name="h1" value="Y"><label for="h11" class="raLab"></label></td>
								<td><input type="radio" id="h12" name="h1" value="N"><label for="h12" class="raLab"></label></td>
								<td><input type="radio" id="h13" name="h1" value="X"><label for="h13" class="raLab"></label></td>
							</tr>
							<tr name="trH">
								<td>2</td>
								<td>이상반응 및 중대한 이상반응의 보고에 관한 사항 AE and SAE reporting requirements</td>
								<td><input type="radio" id="h21" name="h2" value="Y"><label for="h21" class="raLab"></label></td>
								<td><input type="radio" id="h22" name="h2" value="N"><label for="h22" class="raLab"></label></td>
								<td><input type="radio" id="h23" name="h2" value="X"><label for="h23" class="raLab"></label></td>
							</tr>
							<tr name="trH">
								<td>3</td>
								<td>중대한 이상반응 발생 시 연락처 Contact information of sponsor</td>
								<td><input type="radio" id="h31" name="h3" value="Y"><label for="h31" class="raLab"></label></td>
								<td><input type="radio" id="h32" name="h3" value="N"><label for="h32" class="raLab"></label></td>
								<td><input type="radio" id="h33" name="h3" value="X"><label for="h33" class="raLab"></label></td>
							</tr>
							<tr name="trH">
								<td>4</td>
								<td>이상반응 및 중대한 이상반응의 추적관찰에 관한 사항 AE and SAE  follow-up</td>
								<td><input type="radio" id="h41" name="h4" value="Y"><label for="h41" class="raLab"></label></td>
								<td><input type="radio" id="h42" name="h4" value="N"><label for="h42" class="raLab"></label></td>
								<td><input type="radio" id="h43" name="h4" value="X"><label for="h43" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>9. 임상시험 관련 설비 및 기기 Facility and Equipment of Site</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbI">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trI">
								<td>1</td>
								<td>설비 및 기기가 임상시험을 실시하기 적절한지 여부 Adequate facilities and equipment for the trial</td>
								<td><input type="radio" id="i11" name="i1" value="Y"><label for="i11" class="raLab"></label></td>
								<td><input type="radio" id="i12" name="i1" value="N"><label for="i12" class="raLab"></label></td>
								<td><input type="radio" id="i13" name="i1" value="X"><label for="i13" class="raLab"></label></td>
							</tr>
							<tr name="trI">
								<td>2</td>
								<td>약국 그리고/또는 임상시험용의약품 저장소의 적합성 Adequate (or secure) storage space for investigational product</td>
								<td><input type="radio" id="i21" name="i2" value="Y"><label for="i21" class="raLab"></label></td>
								<td><input type="radio" id="i22" name="i2" value="N"><label for="i22" class="raLab"></label></td>
								<td><input type="radio" id="i23" name="i2" value="X"><label for="i23" class="raLab"></label></td>
							</tr>
							<tr name="trI">
								<td>3</td>
								<td>임상검사실 설비 및 기기의 적합성 Adequate laboratory facilities and equipment</td>
								<td><input type="radio" id="i31" name="i3" value="Y"><label for="i31" class="raLab"></label></td>
								<td><input type="radio" id="i32" name="i3" value="N"><label for="i32" class="raLab"></label></td>
								<td><input type="radio" id="i33" name="i3" value="X"><label for="i33" class="raLab"></label></td>
							</tr>
							<tr name="trI">
								<td>4</td>
								<td>문서보관장소의 적합성 Adequate (or secure) storage space for record keeping</td>
								<td><input type="radio" id="i41" name="i4" value="Y"><label for="i41" class="raLab"></label></td>
								<td><input type="radio" id="i42" name="i4" value="N"><label for="i42" class="raLab"></label></td>
								<td><input type="radio" id="i43" name="i4" value="X"><label for="i43" class="raLab"></label></td>
							</tr>
							<tr name="trI">
								<td>5</td>
								<td>임상시험 관련 기기에 관한 품질 관리 기록 Record requirement for quality control of trial equipment</td>
								<td><input type="radio" id="i51" name="i5" value="Y"><label for="i51" class="raLab"></label></td>
								<td><input type="radio" id="i52" name="i5" value="N"><label for="i52" class="raLab"></label></td>
								<td><input type="radio" id="i53" name="i5" value="X"><label for="i53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>10.의학적 처치 및 검사/실험실적 검사 등 Medical/Laboratory/Technical Procedures/Tests</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbJ">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trJ">
								<td>1</td>
								<td>실험실적 검사 또는 기타 의학적 검사 수행절차 Procedures for performing laboratory and other medical tests</td>
								<td><input type="radio" id="j11" name="j1" value="Y"><label for="j11" class="raLab"></label></td>
								<td><input type="radio" id="j12" name="j1" value="N"><label for="j12" class="raLab"></label></td>
								<td><input type="radio" id="j13" name="j1" value="X"><label for="j13" class="raLab"></label></td>
							</tr>
							<tr name="trJ">
								<td>2</td>
								<td>생체 시료의 수집, 처리, 저장 및 운송 Collection, handling, storage and transportation of biological specimens</td>
								<td><input type="radio" id="j21" name="j2" value="Y"><label for="j21" class="raLab"></label></td>
								<td><input type="radio" id="j22" name="j2" value="N"><label for="j22" class="raLab"></label></td>
								<td><input type="radio" id="j23" name="j2" value="X"><label for="j23" class="raLab"></label></td>
							</tr>
							<tr name="trJ">
								<td>3</td>
								<td>추가로 실시한 실험실적 검사 및 기타 의학적 검사의 검토에 대한 시험자의 책임 Investigator’s responsibilities for review and follow-up of laboratory reports and other medical data</td>
								<td><input type="radio" id="j31" name="j3" value="Y"><label for="j31" class="raLab"></label></td>
								<td><input type="radio" id="j32" name="j3" value="N"><label for="j32" class="raLab"></label></td>
								<td><input type="radio" id="j33" name="j3" value="X"><label for="j33" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>11.추가적인 시험자의 의무 Additional Investigator Obligations</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbK">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trK">
								<td>1</td>
								<td>IRB와의 의사소통 Communication with IRB</td>
								<td><input type="radio" id="k11" name="k1" value="Y"><label for="k11" class="raLab"></label></td>
								<td><input type="radio" id="k12" name="k1" value="N"><label for="k12" class="raLab"></label></td>
								<td><input type="radio" id="k13" name="k1" value="X"><label for="k13" class="raLab"></label></td>
							</tr>
							<tr name="trK">
								<td>2</td>
								<td>모니터링 방문 계획 및 요청 사항 Monitoring visits schedule and requirements</td>
								<td><input type="radio" id="k21" name="k2" value="Y"><label for="k21" class="raLab"></label></td>
								<td><input type="radio" id="k22" name="k2" value="N"><label for="k22" class="raLab"></label></td>
								<td><input type="radio" id="k23" name="k2" value="X"><label for="k23" class="raLab"></label></td>
							</tr>
							<tr name="trK">
								<td>3</td>
								<td>점검 및 규제기관의 실태조사 Sponsor audits and regulatory authority inspections</td>
								<td><input type="radio" id="k31" name="k3" value="Y"><label for="k31" class="raLab"></label></td>
								<td><input type="radio" id="k32" name="k3" value="N"><label for="k32" class="raLab"></label></td>
								<td><input type="radio" id="k33" name="k3" value="X"><label for="k33" class="raLab"></label></td>
							</tr>
							<tr name="trK">
								<td>4</td>
								<td>시험결과 출판에 관한 정책 Publication policy</td>
								<td><input type="radio" id="k41" name="k4" value="Y"><label for="k41" class="raLab"></label></td>
								<td><input type="radio" id="k42" name="k4" value="N"><label for="k42" class="raLab"></label></td>
								<td><input type="radio" id="k43" name="k4" value="X"><label for="k43" class="raLab"></label></td>
							</tr>
							<tr name="trK">
								<td>5</td>
								<td>연구비 결산에 관한 절차 Financial disclosure procedures</td>
								<td><input type="radio" id="k51" name="k5" value="Y"><label for="k51" class="raLab"></label></td>
								<td><input type="radio" id="k52" name="k5" value="N"><label for="k52" class="raLab"></label></td>
								<td><input type="radio" id="k53" name="k5" value="X"><label for="k53" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>12.필수문서 Required Documents</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbL">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trL">
								<td>1</td>
								<td>시험자 기본문서파일 및 임상시험기본문서 Site study file and essential documents</td>
								<td><input type="radio" id="l11" name="l1" value="Y"><label for="l11" class="raLab"></label></td>
								<td><input type="radio" id="l12" name="l1" value="N"><label for="l12" class="raLab"></label></td>
								<td><input type="radio" id="l13" name="l1" value="X"><label for="l13" class="raLab"></label></td>
							</tr>
							<tr name="trL">
								<td>2</td>
								<td>임상시험 관련 문서(근거문서 포함)의 보관 및 유지 Retention and archiving of trial documents(including source data and source documents)</td>
								<td><input type="radio" id="l21" name="l2" value="Y"><label for="l21" class="raLab"></label></td>
								<td><input type="radio" id="l22" name="l2" value="N"><label for="l22" class="raLab"></label></td>
								<td><input type="radio" id="l23" name="l2" value="X"><label for="l23" class="raLab"></label></td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>13. 임상시험 관련 물품의 인수 인계 현황 Receipt of Study Materials</h6>
                    </article>
					<div style="height:5px;"></div>
					<table class="tb001">
						<colgroup>
							<col width="30px" />
							<col width="" />
							<col width="40px" />
							<col width="40px" />
							<col width="40px" />
						</colgroup>
						<tbody id="tbM">
							<tr>
								<th></th>
								<th>Were issues identified during the discussion of the following?</th>
								<th>Yes</th>
								<th>No</th>
								<th>NA</th>
							</tr>
							<tr name="trM">
								<td>1</td>
								<td>임상시험계획서 Protocol</td>
								<td><input type="radio" id="m11" name="m1" value="Y"><label for="m11" class="raLab"></label></td>
								<td><input type="radio" id="m12" name="m1" value="N"><label for="m12" class="raLab"></label></td>
								<td><input type="radio" id="m13" name="m1" value="X"><label for="m13" class="raLab"></label></td>
							</tr>
							<tr name="trM">
								<td>2</td>
								<td>시험자 기본문서파일 Site study file</td>
								<td><input type="radio" id="m21" name="m2" value="Y"><label for="m21" class="raLab"></label></td>
								<td><input type="radio" id="m22" name="m2" value="N"><label for="m22" class="raLab"></label></td>
								<td><input type="radio" id="m23" name="m2" value="X"><label for="m23" class="raLab"></label></td>
							</tr>
							<tr name="trM">
								<td>3</td>
								<td>임상시험자자료집 Investigator’s Brochure</td>
								<td><input type="radio" id="m31" name="m3" value="Y"><label for="m31" class="raLab"></label></td>
								<td><input type="radio" id="m32" name="m3" value="N"><label for="m32" class="raLab"></label></td>
								<td><input type="radio" id="m33" name="m3" value="X"><label for="m33" class="raLab"></label></td>
							</tr>
							<tr name="trM">
								<td>4</td>
								<td>증례기록서 Case report forms</td>
								<td><input type="radio" id="m41" name="m4" value="Y"><label for="m41" class="raLab"></label></td>
								<td><input type="radio" id="m42" name="m4" value="N"><label for="m42" class="raLab"></label></td>
								<td><input type="radio" id="m43" name="m4" value="X"><label for="m43" class="raLab"></label></td>
							</tr>
							<tr name="trM">
								<td>5</td>
								<td>피험자 동의서 Informed consent forms</td>
								<td><input type="radio" id="m51" name="m5" value="Y"><label for="m51" class="raLab"></label></td>
								<td><input type="radio" id="m52" name="m5" value="N"><label for="m52" class="raLab"></label></td>
								<td><input type="radio" id="m53" name="m5" value="X"><label for="m53" class="raLab"></label></td>
							</tr>
							<tr>
								<td>6</td>
								<td>눈가림 봉투 Blinding envelopes</td>
								<td><input type="radio" id="m61" name="m6" value="Y"><label for="m61" class="raLab"></label></td>
								<td><input type="radio" id="m62" name="m6" value="N"><label for="m62" class="raLab"></label></td>
								<td><input type="radio" id="m63" name="m6" value="X"><label for="m63" class="raLab"></label></td>
							</tr>
							<tr name="trM">
								<td>7</td>
								<td>기타 물품 Other supplements:</td>
								<td><input type="radio" id="m71" name="m7" value="Y"><label for="m71" class="raLab"></label></td>
								<td><input type="radio" id="m72" name="m7" value="N"><label for="m72" class="raLab"></label></td>
								<td><input type="radio" id="m73" name="m7" value="X"><label for="m73" class="raLab"></label></td>
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
								<th>비고 Remark</th>
								<td style="padding:10px; padding-bottom: 2px;">
									<textarea id="txtRemarkA" rows="3" style="width: 100%;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>



					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>14. 결제</h6>
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