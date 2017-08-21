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
var g_REPORT_TYPE  = "P";
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
	fn_btnApproval();
  
	if(g_CRUD == "U"){
		fn_selectReportInfo();
	}
	else{ //신규
		
	}
	
	$("#btnSave").click(function(){
		
		//사이즈 체크
		
		if(confirm("저장하시겠습니까?")){
			
		}
		else{
			return;
		}
		
		var arJson = [];

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
			addedRowItems1[i].REPORT_TYPE  = 'P';	
			addedRowItems1[i].DATA_SE      = 'C';
			arJson.push(addedRowItems1[i]);			
		}
		
		for(var i = 0; i < editedItems1.length; i++) {
			editedItems1[i].CRUD        = 'U';			
			editedItems1[i].DATA_SE     = 'C';
			editedItems1[i].REPORT_TYPE = 'P';
			editedItems1[i].UPDATE_ID   = g_USER_ID;
			arJson.push(editedItems1[i]);
		}
		
		for(var i = 0; i < removeItems1.length; i++) {
			removeItems1[i].CRUD        = 'D';
			removeItems1[i].DATA_SE     = 'C';	
			removeItems1[i].REPORT_TYPE = 'P';
			removeItems1[i].UPDATE_ID   = g_USER_ID;			
			arJson.push(removeItems1[i]);
		}
		
		// 내부참석자 그리드
		for(var i = 0; i < addedRowItems2.length; i++) {
			addedRowItems2[i].CRUD         = 'C';
			addedRowItems2[i].REPORT_SN    = g_REPORT_SN;
			addedRowItems2[i].TASK_SN      = g_TASK_SN;		
			addedRowItems2[i].MILESTONE_SN = g_MILESTONE_SN;
			addedRowItems2[i].REPORT_TYPE  = 'P';	
			addedRowItems2[i].DATA_SE      = 'C';
			arJson.push(addedRowItems2[i]);			
		}
		
		for(var i = 0; i < editedItems2.length; i++) {
			editedItems2[i].CRUD        = 'U';
			editedItems2[i].DATA_SE     = 'C';
			editedItems2[i].REPORT_TYPE = 'P';
			editedItems2[i].UPDATE_ID   = g_USER_ID
			arJson.push(editedItems2[i]);
		}
		
		for(var i = 0; i < removeItems2.length; i++) {
			removeItems2[i].CRUD        = 'D';
			removeItems2[i].ITEM_SE     = 'C';
			removeItems2[i].REPORT_TYPE = 'P';
			removeItems2[i].UPDATE_ID   = g_USER_ID;
			arJson.push(removeItems2[i]);
		}


		var visitDay    = $("#day_01").val();
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
		          ,'REMARK_A'     : $("#txtRemarkA").val()
		          ,'JOB_SE'       : "${loginMap.TASK_TY_CODE}"
		          ,'UPDATE_ID'    : "${loginMap.USER_ID}"
		          ,'REPORT_SE'    : 'G01'
		          ,'DATA_SE'      : 'A'
		          ,'REPORT_SN'    : g_REPORT_SN
		          ,'CRUD'         : '${CRUD}'
		          ,'REPORT_TYPE'  : 'P'
		};
		arJson.push(visitInfo);
		
		var addItem = {};
		$("input[name=items]").each(function (idx){
			var inputName  = $(this).attr('id');
	    	var inputSname = "b"+inputName.substring(1, inputName.length);

			addItem = {
		               'REPORT_SN'    : g_REPORT_SN
		              ,'MILESTONE_SN' : "${result.MILESTONE_SN}"
		              ,'TASK_SN'      : "${loginMap.TASK_SN}"
		              ,'REPORT_TYPE'  : 'P'
		              ,'ITEM_SE'      : $(this).attr('id') //$("input:text[id='"+$(this).attr('id')+"']").val()
		              ,'ITEM_VALUE'   : $("input:text[id='"+$(this).attr('id')+"']").val()
		              ,'ITEM_VALUE_A' : $("input:text[id='"+inputSname+"']").val()
		              ,'CHARGER_ID'   : "${loginMap.USER_ID}"
		              ,'RM'           : ''
		              ,'SUBJECT_CO'   : '0'
		              ,'DTE'          : ''
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
			'REQUST_NM': '개시미팅 준비기록',
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
		var p_REPORT_SE    = 'G02';
		var p_REPORT_TYPE  = 'V';
		var p_APPROVAL_URL = "<c:url value='/ctms/z09/CTMZ0902.do'/>";
		fn_goTapPage(p_REPORT_SE, p_REPORT_TYPE, p_APPROVAL_URL);
	});

	//RD 출력버튼
  	$("#btnPrint").click(function(){
  		var g_RD_NAME = "CTMZ0901_NSS-301-FORM 04-SIVR-Ver.02.mrd";
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
				$("#txtPosition"  ).val(g_REPORT_INFO.RSPOFC     );
				$("#day_01"       ).val(g_REPORT_INFO.OPRTN_DATE );
				$("#txtRemarkA"   ).val(g_REPORT_INFO.REMARK_A   );
				
				$("input[id=txtTaskNo]"    ).attr("readonly",true);
				$("input[id=txtInsttNm]"   ).attr("readonly",true);
				$("input[id=txtResearchNm]").attr("readonly",true);
				
				for(var i=0; g_ITEM.length > i; i++){
					var itemSe = g_ITEM[i].ITEM_SE;
					var itemSeValue = "b"+itemSe.substring(1, itemSe.length);
					$("input:text[id='"+g_ITEM[i].ITEM_SE+"']").val(g_ITEM[i].ITEM_VALUE);
					$("input:text[id='"+itemSeValue+"']").val(g_ITEM[i].ITEM_VALUE_A);
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

					$("input[id=txtPosition]"  ).attr("readonly",true);
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
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0901&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMZ0901&UPPER_MENU_ID=CTMZ" charEncoding="utf-8"/>

						
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
							<li id="tab_menu1" class="port_back tab_menu">개시 미팅 준비기록</li>
							<li id="tab_menu2" class="tab_menu">시험 개시방문 보고서</li>
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
								<th>시험제목 Title</th>
								<td>
									<input type="text" id="txtTaskNo" style="width:100%;" value="${loginMap.TASK_NO}">
									<!-- button type="button" class="oneBtn">
										<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
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
										<img class="oneBtnIco" src="/images/pantheon/common/searchIco.png" alt="검색">
									</button-->
								</td>
							</tr>
							<tr>
								<th>일시 Date &amp; Time</th>
								<td>
									<div class="dateBox">
										<input type="text" id="day_01" style="width: 120px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>장소 Place</th>
								<td>
									<input type="text" id="txtPosition" style="width:100%;">
								</td>
							</tr>
						</tbody>
					</table>


					<div style="height:20px;"></div>


                    <article class="conTitBox">
                        <h6>1. 참석자 Attendants</h6>
                    </article>
                    

                    <article class="conTitBtnR">
                    	<input type="button" id="btnAddrow1" value="행추가" class="add_01" title="<spring:message code="ctmz0201.btn.Add" />" >
	                    <input type="button" id="btnRowDel1" value="행삭제" class="del_01" title="<spring:message code="ctmz0201.btn.Del" />" >
                    </article>
					<div style="height:10px;"></div>

					<div id="grid_wrap_01" class="gridHeiSz03 grid_wrap tb01_2"></div>




					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>2. 내부참석자 In-house Attendants</h6>
                    </article>

                    <article class="conTitBtnR">
                        <input type="button" id="btnAddrow2" value="행추가" class="add_01" title="<spring:message code="ctmz0201.btn.Add" />" >
	                    <input type="button" id="btnRowDel2" value="행삭제" class="del_01" title="<spring:message code="ctmz0201.btn.Del" />" >
                    </article>
					<div style="height:10px;"></div>
					<div id="grid_wrap_02" class="gridHeiSz03 grid_wrap tb01_2"></div>





					<div style="height:20px;"></div>




                    <article class="conTitBox">
                        <h6>3. 진행 스케줄 및 담당자 Time Schedule and Responsible Person</h6>
                    </article>

					<div style="height:10px;"></div>

					<table class="tb001">
						<colgroup>
							<col width="20%" />
							<col width="20%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th style="text-align:center; padding-left:4px;">항목<br>Items</th>
								<th style="text-align:center; padding-left:4px;">담당자<br>Responsible Person</th>
								<th style="text-align:center; padding-left:4px;">일정<br>Time schedule (yyyy.mm.dd)</th>
							</tr>
							<tr>
								<th colspan="3">개시미팅 실지 전</th>
							</tr>
							<tr>
								<td>일정확인</td>
								<td><input type="text" name="items" id="a1" style="width:100%;"></td>
								<td><input type="text" name="" id="b1" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>예산확인</td>
								<td><input type="text" name="items" id="a2" style="width:100%;"></td>
								<td><input type="text" name="" id="b2" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>장소섭외</td>
								<td><input type="text" name="items" id="a3" style="width:100%;"></td>
								<td><input type="text" name="" id="b3" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>기관 및 내부참석자 연락</td>
								<td><input type="text" name="items" id="a4" style="width:100%;"></td>
								<td><input type="text" name="" id="b4" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>교통편 및 숙박시설 예약</td>
								<td><input type="text" name="items" id="a5" style="width:100%;"></td>
								<td><input type="text" name="" id="b5" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>시험자 파일 준비</td>
								<td><input type="text" name="items" id="a6" style="width:100%;"></td>
								<td><input type="text" name="" id="b6" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>임상시험용의 약품 배송확인</td>
								<td><input type="text" name="items" id="a7" style="width:100%;"></td>
								<td><input type="text" name="" id="b7" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>약품파일준비</td>
								<td><input type="text" name="items" id="a8" style="width:100%;"></td>
								<td><input type="text" name="" id="b8" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>회의참석자명단준비</td>
								<td><input type="text" name="items" id="a9" style="width:100%;"></td>
								<td><input type="text" name="" id="b9" style="width:100%;"></td>
							</tr>
							<tr>
								<td>위임서명록 준비</td>
								<td><input type="text" name="items" id="a10" style="width:100%;"></td>
								<td><input type="text" name="" id="b10" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>프리젠테이션 자료 준비</td>
								<td><input type="text" name="items" id="a11" style="width:100%;"></td>
								<td><input type="text" name="" id="b11" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>개시미팅 초대장 발송</td>
								<td><input type="text" name="items" id="a12" style="width:100%;"></td>
								<td><input type="text" name="" id="b12" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>기타 1(빔, 노트북, 포인터 등)</td>
								<td><input type="text" name="items" id="a13" style="width:100%;"></td>
								<td><input type="text" name="" id="b13" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>기타 2(도시락, 다과 등)</td>
								<td><input type="text" name="items" id="a14" style="width:100%;"></td>
								<td><input type="text" name="" id="b14" style="width:100%;"/></td>
							</tr>
							<tr>
								<th colspan="3">개시미팅 실지 중</th>
							</tr>
							<tr>
								<td>회의실 세팅</td>
								<td><input type="text" name="items" id="a15" style="width:100%;"></td>
								<td><input type="text" name="" id="b15" style="width:100%;"></td>
							</tr>
							<tr>
								<td>접수 및 안내</td>
								<td><input type="text" name="items" id="a16" style="width:100%;"></td>
								<td><input type="text" name="" id="b16" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>불참자 및 연착자 확인</td>
								<td><input type="text" name="items" id="a17" style="width:100%;"></td>
								<td><input type="text" name="" id="b17" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>프리젠테이션 및 교육</td>
								<td><input type="text" name="items" id="a18" style="width:100%;"></td>
								<td><input type="text" name="" id="b18" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>프리젠테이션 어시스트</td>
								<td><input type="text" name="items" id="a19" style="width:100%;"></td>
								<td><input type="text" name="" id="b19" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>문서서명 및 확인</td>
								<td><input type="text" name="items" id="a20" style="width:100%;"></td>
								<td><input type="text" name="" id="b20" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>회의록작성</td>
								<td><input type="text" name="items" id="a21" style="width:100%;"></td>
								<td><input type="text" name="" id="b21" style="width:100%;"></td>
							</tr>
							<tr>
								<td>질의응답</td>
								<td><input type="text" name="items" id="a22" style="width:100%;"></td>
								<td><input type="text" name="" id="b22" style="width:100%;"/></td>
							</tr>
							<tr>
								<th colspan="3">개시미팅 실시 후</th>
							</tr>
							<tr>
								<td>행사 후 회의실 정리</td>
								<td><input type="text" name="items" id="a23" style="width:100%;"></td>
								<td><input type="text" name="" id="b23" style="width:100%;"/></td>
							</tr>
							<tr>
								<td>개시미팅 보고서 작성</td>
								<td><input type="text" name="items" id="a24" style="width:100%;"></td>
								<td><input type="text" name="" id="b24" style="width:100%;"/></td>
							</tr>
						</tbody>
					</table>

					<table class="tb001" style="border:none;">
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
                        <h6>3. 결제</h6>
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