<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 상단 css, js 임포트 호출 -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<jsp:include page="/com/common.do" flush="false"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
var _user = {
		'USER_ID': '${loginMap.USER_ID}'
	};
	
	var g_grid1 = "Y";
	var g_grid2 = "Y";
	var g_grid3 = "Y";
	var g_grid4 = "Y";
	var g_grid5 = "Y";
	var g_grid6 = "Y";
	var g_grid4Update  = "N";
	var g_deleteChange = "N";
	var returnRowNo    = "N";
	
	var g_insttList   ; //기관리스트
	var g_craList     ; //CRA리스트
	var g_ctms017     ; //연락처 구분코드
	var g_ctms008     ; //심의1 구분코드
	var g_ctms009     ; //심의2 구분코드
	var g_ctms010     ; //계산서 종류
	var g_ctms026     ; //심의 구분1
	var g_ctms016     ; //심의 구분2

	var g_TaskSn   = '${TASK_SN}';
	var g_TaskNo   = '${TASK_NO}';
	var g_TaskeEnd = '${TASK_END}';
	var g_updateYn = 'N';
	var n_rowMSelect;
	var n_rowSelect;
	
	var isSeletionForceFlag = false;
	var oldSelectedItemInfo = null;
	var gridMainID;
	var gridSub1ID;
	var gridSub2ID;
	var gridSub3ID;
	var gridSub4ID;
	var gridSub5ID;
	var gridSub6ID;

	var myGridOption = {
			  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(myGridOption.id);
			  id: '',
			  //AUI그리드 생성할 div 및 페이징 옵션
			  div: {
			    gridDiv: '#grid_wrap'
			  },
			  //데이터 연계 옵션
			  proxy: {
			    url: '/ctms/e01/selectIRBBasicInfoList.do',
			    param: {'TASK_SN': g_TaskSn},
			    type: 'post',
			    dataType: 'json',
			    //페이징 true, false 로 지정
			    paging: false,
			    //처음 시작시 데이터 로딩
			    autoLoad: false,
			  },
			  //AUI 그리드 옵션
			  gridPros: {
			    // 페이징 사용
			    //usePaging : true,
			    
			    showRowNumColumn : true,
			    showRowCheckColumn : false,

			    showStateColumn    : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    
			    enableColumnResize : true,
			    enableMovingColumn : true,
			    editable : true,
			    enableFilter : true,

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 60,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true

			  },
			  //AUI 그리드 레이아웃
			  columnLayout : [
	    		   {
	    		   	  dataField : "IRB_BSIS_SN"
	    		   	, headerText : "순번"
	    		   	, visible : false
	    		   	, editable : false
	    		   	//width: 120
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_SN"
	    		   	, headerText : "과제순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_NO"
	    		   	, headerText : "과제번호"
	    		   	, editable : false
	    			, width: 100
	    			, visible : true
	    			, filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "INSTT_CODE"
	    		   	, headerText : "기관번호<span class='must_01'></span>"
	    		   	, editable : false
	    			, width: 90
	    			, visible : true
	    			, filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "INSTT_NM"
	    		   	, headerText : "기관명<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 220
	    			, visible : true
	      			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridOption;
						var retStr = "";
						for(var i=0; me.columnLayout[4].editRenderer.list.length > i; i++) {
							if(me.columnLayout[4].editRenderer.list[i]['INSTT_NAME'] == value) {
								retStr = me.columnLayout[4].editRenderer.list[i]['INSTT_NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
	    			, editRenderer : {
	    				type : "DropDownListRenderer",
	    				showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
	    				keyField : "INSTT_NAME",
	    				valueField : "INSTT_NAME",
	    				list : null,
	    				// 드랍 리스트의 개별 아이템에 대하여 출력할 양식을 HTML 로 작성하여 반환하면 리스트로 출력됩니다.
	    				listTemplateFunction : function(rowIndex, columnIndex, text, item, dataField, listItem) {
	    					var html = '<div style="display:block;text-align:left;white-space:nowrap">';

	    					for(var n in listItem) {
	    						if(n != "flag") {
	    							//html += '<span style="display:inline-block;width:80px;">' + listItem[n] + '</span>';
	    						}
	    					}
	    					html += '<span style="display:inline-block;width:80px;">' + listItem["INSTT_CODE"] + '</span>';
	    					html += '<span style="display:inline-block;width:180px;">' + listItem["INSTT_NAME"] + '</span>';
	    					html += '<span style="display:inline-block;width:100px;">' + listItem["TELF1"] + '</span>';
	    					html += '</div>';
	    					return html;
	    				}
	    			}
	    			, filter : {
	      				showIcon : true
	      			}
	    		   }
	              ,{
	                    dataField : "CHRG_NM"
	                  , headerText : "담당 CRA"
	                  , editable : true
	                  , visible : true
	                  , width: 90
	        	      , labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
	 						var me = myGridOption;
	 						var retStr = "";
	 						for(var i=0; me.columnLayout[5].editRenderer.list.length > i; i++) {
	 							if(me.columnLayout[5].editRenderer.list[i]['USER_NM'] == value) {
	 								retStr = me.columnLayout[5].editRenderer.list[i]['USER_NM'];
	 								break;
	 							}
	 						}
	 						return retStr == "" ? value : retStr;	
	       		       }
	                  , editRenderer : {
	  	     			type : "DropDownListRenderer",
	  	     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
	  	     			list : null,
	  	     			keyField : "USER_NM",
	  	     			valueField : "USER_NM"
	  	     		  }
	                  , filter : {
	        				showIcon : true
	        			  }
	                }
	              ,{
	    		   	  dataField : "CHRG_CRA"
	    		   	, headerText : "CHRG_CRA"
	    		   	, editable : false
	    			, width: 80
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "AREA"
	    		   	, headerText : "지역(시/도)"
	    		   	, editable : true
	    			, visible : true
	    			, editRenderer : {
		    				type : "InputEditRenderer",
		    				
		    				// 에디팅 유효성 검사
		    				validator : function(oldValue, newValue, rowItem) {
		    					var isValid = false;
		    					
		    					if(newValue.length <= 100) { 
		    						isValid = true;
		    					}
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100자 이하로 입력해 주세요." };
		    				}
	    			  }
	    		     , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "EIRB_AT"
	    		   	, headerText : "e-IRB 유무"
	    		   	, editable : true
	    			, width: 80
	    			, visible : true
	    			, editRenderer : {
	    				type : "DropDownListRenderer",  //ComboBoxRenderer
	    				showEditorBtnOver : true,
	    				list : ['Y', 'N']
	    			  }
	    		   , filter : {
	      				showIcon : true
	      			  } 
		    	   }
	    		   ,{
	    		   	  dataField : "EXPR_APPN_AT"
	    		   	, headerText : "임상시험지정기관"
	    		   	, editable : true
	    			, width: 75
	    			, visible : true
	    			, editRenderer : {
	    				type : "DropDownListRenderer",  //ComboBoxRenderer
	    				showEditorBtnOver : true,
	    				list : ['Y', 'N']
	    			  }
	    		   , filter : {
	      				showIcon : true
	      			  }
		    	   }
	    		   ,{
	    		   	  dataField : "FDRM_JDGMN"
	    		   	, headerText : "정기심사일정"
	    		   	, editable : true
	    			, visible : true
	    			, width: 100
	    			, editRenderer : {
		    				type : "InputEditRenderer",
		    				
		    				// 에디팅 유효성 검사
		    				validator : function(oldValue, newValue, rowItem) {
		    					var isValid = false;
		    					
		    					if(newValue.length <= 200) { 
		    						isValid = true;
		    					}
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100자 이하로 입력해 주세요." };
		    				}
	    			  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "RPD_JDGMN"
	    		   	, headerText : "신속심사일정"
	    		   	, editable : true
	    			, visible : true
	    			, width: 100
	    			, editRenderer : {
		    				type : "InputEditRenderer",
		    				
		    				// 에디팅 유효성 검사
		    				validator : function(oldValue, newValue, rowItem) {
		    					var isValid = false;
		    					
		    					if(newValue.length <= 200) { 
		    						isValid = true;
		    					}
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100자 이하로 입력해 주세요." };
		    				}
	    			  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "EXMNT_REQUST"
	    		   	, headerText : "검토요청시기"
	    		   	, editable : true
	    			, visible : true
	    			, width: 100
	    			, editRenderer : {
		    				type : "InputEditRenderer",
		    				
		    				// 에디팅 유효성 검사
		    				validator : function(oldValue, newValue, rowItem) {
		    					var isValid = false;
		    					
		    					if(newValue.length <= 100) { 
		    						isValid = true;
		    					}
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100자 이하로 입력해 주세요." };
		    				}
	    			  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "ADRES_A"
	    		   	, headerText : "주소(병원)"
	    		   	, editable : true
 	    			, width: 170
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "ADRES_B"
	    		   	, headerText : "주소(산학협력단)"
	    		   	, editable : true
// 	    			, width: 170
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "ADRES_C"
	    		   	, headerText : "주소(IRB)"
	    		   	, editable : true
// 	    			, width: 160
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "ADRES_D"
	    		   	, headerText : "주소(계약담당)"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "HSPTLHED_NM"
	    		   	, headerText : "병원장명"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 50) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "50자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "RPRSNTV_NM"
	    		   	, headerText : "대표자명(계약시)"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 50) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "50자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
			  ],
			  //AUI 그리드 생성
			  createGrid: function() {
			    var me = this;

			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			    
			    window.setTimeout(function(){
					AUIGrid.resize(me.id);
				}, 0.5);

			    gridMainID = me.id;
			    me.binding();

			    if(me.proxy.autoLoad) {
					me.load();
			    }
			  },

			  //AUI 그리드 이벤트 
			  binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				}); //cellEditBegin

				AUIGrid.bind(me.id, "cellEditEnd", function(event) {
					//기관명 선택시 기관코드 맵핑.
					if(AUIGrid.getSelectedIndex(me.id)[1] == 4) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_insttList.length > i; i++){

							pName = g_insttList[i].INSTT_NAME;
							pCode = g_insttList[i].INSTT_CODE;

							if( pValue == pName ){
								var userData = { INSTT_CODE : pCode };

								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if
					if( event.dataField == "CHRG_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_craList.length > i; i++){

							pName = g_craList[i].USER_NM;
							pCode = g_craList[i].USER_ID;

							if( pValue == pName ){
								var userData = { CHRG_CRA : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if

				}); //cellEditEnd

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowMSelect = event.rowIndex;
				});
				
				AUIGrid.bind(me.id, 'selectionChange', function(e) {

					var selectedItems = e.selectedItems;
					if(selectedItems.length > 0) {
						var firstItemInfo = selectedItems[0];
						if(oldSelectedItemInfo && !isSeletionForceFlag) {
							// 이전 셀렉션 정보
							var state = getItemState(oldSelectedItemInfo.item);
							var editRows = getUpdateCheck();

							if(state == "Added" || state == "Edited" || state == "Removed" || editRows > 0) {
								if(g_deleteChange == "N"){
									if(!confirm('기초정보 또는 하위 내용 중 저장하지 않은 내역이 있습니다. \n\n           행 이동시 하위 내용을 저장 할 수 없습니다. \n\n           새로운 행으로 이동하시겠습니까?')){
										returnRowNo = "Y";
										isSeletionForceFlag = true;
										AUIGrid.setSelectionByIndex(me.id, oldSelectedItemInfo.rowIndex, oldSelectedItemInfo.columnIndex);
										isSeletionForceFlag = false;
// 										checkSelection();
										return;
									} // if
									else{
										returnRowNo = "N";
										
										myGridOption.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];

										myGridSub1.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
										myGridSub1.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
										myGridSub1.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];

										if(g_grid1 == "Y"){
											g_grid1 = "N";
											$("#grid1").siblings(".acdMenuCts02").slideToggle(1);
											$("#grid1").toggleClass("open");
											myGridSub1.createGrid();
										}
										
										myGridSub2.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
										myGridSub2.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
										
										myGridSub3.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
										myGridSub3.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
										
										myGridSub4.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
										myGridSub4.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
										
										myGridSub5.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
										myGridSub5.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
										
										myGridSub6.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
										myGridSub6.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];

										fn_mainClick();
									}
								} // if
							} // if
						} // if
						// 최근 선택 정보 보관.
						oldSelectedItemInfo = firstItemInfo;
					}
					
					if(returnRowNo == "N"){

						myGridOption.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];

						myGridSub1.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
						myGridSub1.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
						myGridSub1.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];

						if(g_grid1 == "Y"){
							g_grid1 = "N";
							$("#grid1").siblings(".acdMenuCts02").slideToggle(1);
							$("#grid1").toggleClass("open");
							myGridSub1.createGrid();
						}
						
						myGridSub2.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
						myGridSub2.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
						
						myGridSub3.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
						myGridSub3.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
						
						myGridSub4.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
						myGridSub4.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
						
						myGridSub5.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
						myGridSub5.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];
						
						myGridSub6.proxy.param['IRB_BSIS_SN'] = e.selectedItems[0].item['IRB_BSIS_SN'];
						myGridSub6.proxy.param['TASK_SN']     = e.selectedItems[0].item['TASK_SN'];

						fn_mainClick();
					}
					else{
						returnRowNo == "N";
					}
// 					checkSelection();

				}); //cellEditBegin end

			  },
			  //AUI 그리드 데이터 요청
			  init: function(v1, v2) {
			 		var me = this;
			 		AUIGrid.showAjaxLoader(me.id);

			 		$.ajax({
			 		    url: "/ctms/e01/selectIRBInitInfo.do",
			 		    type: me.proxy.type,
			 		    //dataType: me.proxy.dataType,
			 		    data: me.proxy.param,
			 		    success:function(data){
			 		    	if(data.success) {
			 		    		
			 		    		g_updateYn = "N";
			 		    		
			 		    		me.columnLayout[4].editRenderer.list = data.insttlist;
			 		    		me.columnLayout[5].editRenderer.list = data.cralist;
			 		    		myGridSub6.columnLayout[4].editRenderer.list = data.cralist;
			 		    		
			 		    		g_insttList = data.insttlist;
			 		    		g_craList   = data.cralist;
			 		    		g_ctms017   = data.code1list;
			 		    		g_ctms008   = data.code2list;
			 		    		g_ctms009   = data.code3list;
			 		    		g_ctms010   = data.code4list;
			 		    		g_ctms026   = data.code6list;
			 		    		g_ctms016   = data.code5list;
			 		    		myGridSub1.columnLayout[3].editRenderer.list  = data.code1list; //연락처구분코드     CTMS017
			 		    		myGridSub2.columnLayout[4].editRenderer.list  = data.code2list; //심의비 구분1 코드 CTMS022
			 		    		myGridSub2.columnLayout[5].editRenderer.list  = data.code3list; //심의비 구분2코드  CTMS009
			 		    		myGridSub2.columnLayout[11].editRenderer.list = data.code4list; //계산서 종류 구분   CTMS010
			 		    		myGridSub3.columnLayout[6].editRenderer.list  = data.code4list; //계산서 종류 구분   CTMS010
			 		    		myGridSub4.columnLayout[3].editRenderer.list  = data.code6list; //심의 종류 구분      CTMS026
			 		    		myGridSub4.columnLayout[4].editRenderer.list  = data.code5list; //심의 구분             CTMS016

			 		    		me.createGrid();

			 		    	} else {
			 		    		AUIGrid.removeAjaxLoader(me.id);
			 		    		alert(data.message);
			 		    	}
			 		    },
						error : function(jqXHR, textStatus, errorThrown){
							alert(textStatus);
						}
			 		});

			  },
			  load: function(v1, v2) {
			 		var me = this;
			 		
			 		AUIGrid.showAjaxLoader(me.id);

					$.ajax({
						  url : '/ctms/e01/selectIRBBasicInfoList.do' ,
						  type: 'post',
						  //contentType: "application/json; charset=UTF-8",
						  data : me.proxy.param,
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;

							  if(data.success) {
								  AUIGrid.removeAjaxLoader(me.id);
								  AUIGrid.setGridData(me.id, data.irblist);
								  irbBasicInfo = data.irblist;
								  AUIGrid.setSelectionByIndex(me.id, 0);

								  $("#btnMAddrow").hide();
								  $("#btnMDelete").hide();
								  $("#btnMSave"  ).hide();
								  AUIGrid.setProperty("#grid_wrap", "editable", false);
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
			  }
	};

	var myGridSub1 = {

			  id: '',
			  //AUI그리드 생성할 div 및 페이징 옵션
			  div: {
			    gridDiv: '#grid_wrap1',
			    paging: {
			      pagingDiv: 'grid_paging',
			      totalRowCount: 500,
			      rowCount: 10,
			      pageButtonCount: 4,
			      currentPage: 1,
			      totalPage: 0,
			    },
			  },
			  //데이터 연계 옵션
			  proxy: {
			    url: '/ctms/e01/selectIRBCttpcList.do',
			    param: {},
			    type: 'post',
			    dataType: 'json',
			    //페이징 true, false 로 지정
			    paging: true,
			    //처음 시작시 데이터 로딩
			    autoLoad: true,
			  },
			  //AUI 그리드 옵션
			  gridPros: {
			    // 페이징 사용
			    //usePaging : true,
			    
			    showRowNumColumn : true,
			    showRowCheckColumn : false,

			    showStateColumn    : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    editable : false,
			    enableFilter : true,

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true,

			  },
			  //AUI 그리드 레이아웃
			  columnLayout : [
	    		   {
	    		   	  dataField : "IRB_BSIS_SN"
	    		   	, headerText : "IRB_BSIS_SN"
	    		   	, visible : false
	    		   	, editable : false
	    		   	, width: 120
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_SN"
	    		   	, headerText : "TASK_SN"
	    		   	, editable : true
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "CTTPC_SN"
	    		   	, headerText : "CTTPC_SN"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "SE_NM"
	    		   	, headerText : "구분<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 120
	      			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridSub1;
						var retStr = "";
						for(var i=0; me.columnLayout[3].editRenderer.list.length > i; i++) {
							if(me.columnLayout[3].editRenderer.list[i]['NAME'] == value) {
								retStr = me.columnLayout[3].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
		       		, editRenderer : {
		     			type : "DropDownListRenderer",
		     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		     			list : null,
		     			keyField : "NAME",
		     			valueField : "NAME"
		     		  }
		       		, filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "SE"
	    		   	, headerText : "SE"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "NM"
	    		   	, headerText : "이름"
	    		   	, editable : true
// 	    			, width: 200
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 32) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "32자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "OFFM"
	    		   	, headerText : "사무실"
	    		   	, editable : true
	    			, width: 150
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 20) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "20자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "CELL_PHONE"
	    		   	, headerText : "핸드폰"
	    		   	, editable : true
	    			, width: 150
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				onlyNumeric : true,
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					if(newValue && newValue.length <= 20) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "20자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "EMAIL"
	    		   	, headerText : "e-mail"
	    		   	, editable : true
	    			, width: 250
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					
	    					var isValid = false;
	    					var email_matcher = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/; // 이메일 체크 정규식
	    					
	    					if(email_matcher.test(newValue)) {
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					if(!isValid){
	    						return { "validate" : isValid, "message"  : "정확한 이메일 주소가 아닙니다. 다시 확인해 주세요." };
	    					}
	    					
	    					isValid = false;
	    					
	    					if(newValue.length <= 50) { 
	    						isValid = true;
	    					}
	    					
	    					if(!isValid){
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    						return { "validate" : isValid, "message"  : "50자 이하로 입력해 주세요." };
	    					}
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "FAX"
	    		   	, headerText : "FAX"
	    		   	, editable : true
	    			, width: 150
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				onlyNumeric : true,
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 20) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "20자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
			  ],

			  //AUI 그리드 생성
			  createGrid: function() {
			    var me = this;

			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			    gridSub1ID = me.id;
			    me.binding();

			    if(me.proxy.autoLoad) {
					me.load();
			    }
			  },

			  //AUI 그리드 이벤트 
			  binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				});

				AUIGrid.bind(me.id, "cellEditEnd", function(event) {

					if( event.dataField == "SE_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_ctms017.length > i; i++){

							pName = g_ctms017[i].NAME;
							pCode = g_ctms017[i].CODE;

							if( pValue == pName ){
								var userData = { SE : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if

				});

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowSelect = event.rowIndex;
				});

			  },
			  load: function(v1, v2) {
			 		var me = this;

			 		AUIGrid.showAjaxLoader(me.id);

					$.ajax({
						  url: me.proxy.url,
						  type: me.proxy.type,
						  dataType: me.proxy.dataType,
						  data: me.proxy.param,
						  success : function(data, textStatus, jqXHR) {
//g_comCode1List
							  if(data.success) {
								  AUIGrid.removeAjaxLoader(me.id);
								  AUIGrid.setGridData(me.id, data.cttpcList);
								  AUIGrid.setSelectionByIndex(me.id, 0);

								  $("#btnG1Addrow").hide();
								  $("#btnG1Delete").hide();
								  $("#btnG1Save"  ).hide();
								  AUIGrid.setProperty("#grid_wrap1", "editable", false);
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap1");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
			  }
	};

	var myGridSub2 = {

			  id: '',
			  //AUI그리드 생성할 div 및 페이징 옵션
			  div: {
			    gridDiv: '#grid_wrap2',
			    paging: {
			      pagingDiv: 'grid_paging',
			      totalRowCount: 500,
			      rowCount: 10,
			      pageButtonCount: 4,
			      currentPage: 1,
			      totalPage: 0,
			    },
			  },
			  //데이터 연계 옵션
			  proxy: {
			    url: '/ctms/e01/selectIRBDlbrtctList.do',
			    param: {},
			    type: 'post',
			    dataType: 'json',
			    //페이징 true, false 로 지정
			    paging: true,
			    //처음 시작시 데이터 로딩
			    autoLoad: true,
			  },
			  //AUI 그리드 옵션
			  gridPros: {
			    // 페이징 사용
			    //usePaging : true,
			    
			    showRowNumColumn : true,
			    showRowCheckColumn : false,

			    showStateColumn    : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true,
			    
			  },
			  //AUI 그리드 레이아웃
			  columnLayout : [
	    		   {
	    		   	  dataField : "IRB_BSIS_SN"
	    		   	, headerText : "IRB_BSIS_SN"
	    		   	, visible : false
	    		   	, editable : false
	    		   	//width: 120
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_SN"
	    		   	, headerText : "TASK_SN"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "DLBRTCT_SN"
	    		   	, headerText : "DLBRTCT_SN"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "BSNM_REGIST_NO"
	    		   	, headerText : "사업자 등록번호<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 150
	    			, visible : true
	    			, datatype : "numeric"
//     				, labelFunction : function(  rowIndex, columnIndex, value) { // 000-00-00000 - 처리.
//     					console.log("value : "+value);

// 						value += "";
// 						if(value.length == 10) {
// 							return value.substr(0,3) + "-" + value.substr(3,2) + "-" + value.substr(5,value.length)
// 						}
// 						return value;

// 	   		        }
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				onlyNumeric : true,
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 10) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "10자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    			, filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "SE_NM"
	    		   	, headerText : "구분1<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 70
	    			, visible : true
	      			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridSub2;
						var retStr = "";
						for(var i=0; me.columnLayout[4].editRenderer.list.length > i; i++) {
							if(me.columnLayout[4].editRenderer.list[i]['NAME'] == value) {
								retStr = me.columnLayout[4].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
		       		, editRenderer : {
		     			type : "DropDownListRenderer",
		     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		     			list : null,
		     			keyField : "NAME",
		     			valueField : "NAME"
		     		  }
		       		, filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "DLBRT_NM"
	    		   	, headerText : "구분2<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 90
	    			, visible : true
	    			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridSub2;
						var retStr = "";
						for(var i=0; me.columnLayout[5].editRenderer.list.length > i; i++) {
							if(me.columnLayout[5].editRenderer.list[i]['NAME'] == value) {
								retStr = me.columnLayout[5].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
		       		, editRenderer : {
		     			type : "DropDownListRenderer",
		     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		     			list : null,
		     			keyField : "NAME",
		     			valueField : "NAME"
		     		  }
		       		, filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "AMOUNT"
	    		   	, headerText : "금액"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, dataType : "numeric"
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				onlyNumeric : true,
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					if(newValue && newValue.length <= 20) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "15자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "VAT_AT"
	    		   	, headerText : "VAT 산정여부"
	    		   	, editable : true
	    			, width: 100
	    			, visible : true
	    			, editRenderer : {
	    				type : "DropDownListRenderer",  //ComboBoxRenderer
	    				showEditorBtnOver : true,
	    				list : ['Y', 'N']
	    			  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "BANK_NM"
	    		   	, headerText : "은행명(심의비)"
	    		   	, editable : true
	    			, width: 200
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 50) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "50자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "ACNUT_NO"
	    		   	, headerText : "계좌번호(심의비)"
	    		   	, editable : true
	    			, width: 180
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				onlyNumeric : true,
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 25) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "25자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "BILL_PBLICTE"
	    		   	, headerText : "계산서 발행"
	    		   	, editable : true
	    			, width: 90
	    			, visible : true
	    			, editRenderer : {
	    				type : "DropDownListRenderer",  //ComboBoxRenderer
	    				showEditorBtnOver : true,
	    				list : ['Y', 'N']
	    			  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "BILL_NM"
	    		   	, headerText : "계산서 종류"
	    		   	, editable : true
	    			, width: 100
	    			, visible : true
	    			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridSub2;
						var retStr = "";
						for(var i=0; me.columnLayout[11].editRenderer.list.length > i; i++) {
							if(me.columnLayout[11].editRenderer.list[i]['NAME'] == value) {
								retStr = me.columnLayout[11].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
		       		, editRenderer : {
		     			type : "DropDownListRenderer",
		     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		     			list : null,
		     			keyField : "NAME",
		     			valueField : "NAME"
		     		  }
		       		, filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "RM"
	    		   	, headerText : "코멘트(심의비 입금시기 등)"
	    		   	, editable : true
// 	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
    		      ,{
	    		   	  dataField : "SE"
	    		   	, headerText : "SE"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
    		      ,{
	    		   	  dataField : "DLBRT_SE"
	    		   	, headerText : "DLBRT_SE"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
    		      ,{
	    		   	  dataField : "BILL_SE"
	    		   	, headerText : "BILL_SE"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
			  ],  
			  //AUI 그리드 생성
			  createGrid: function() {
			    var me = this;
			    
			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			    gridSub2ID = me.id;
			    me.binding();

			    if(me.proxy.autoLoad) {
					me.load();
			    }
			  },

			  //AUI 그리드 이벤트 
			  binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				});

				AUIGrid.bind(me.id, "cellEditEnd", function(event) {

					if( event.dataField == "SE_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_ctms008.length > i; i++){

							pName = g_ctms008[i].NAME;
							pCode = g_ctms008[i].CODE;

							if( pValue == pName ){
								var userData = { SE : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if
					
					if( event.dataField == "DLBRT_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_ctms009.length > i; i++){

							pName = g_ctms009[i].NAME;
							pCode = g_ctms009[i].CODE;

							if( pValue == pName ){
								var userData = { DLBRT_SE : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if

					if( event.dataField == "BILL_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_ctms010.length > i; i++){

							pName = g_ctms010[i].NAME;
							pCode = g_ctms010[i].CODE;

							if( pValue == pName ){
								var userData = { BILL_SE : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if

				});

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowSelect = event.rowIndex;
				});

			  },
			  load: function(v1, v2) {
			 		var me = this;

			 		AUIGrid.showAjaxLoader(me.id);
		 		
					$.ajax({
						url: me.proxy.url,
			 		    type: me.proxy.type,
			 		    dataType: me.proxy.dataType,
			 		    data: me.proxy.param,
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;

							  if(data.success) {
								  AUIGrid.removeAjaxLoader(me.id);
								  AUIGrid.setGridData(me.id, data.dlbrtctList);
								  AUIGrid.setSelectionByIndex(me.id, 0);

								  $("#btnG2Addrow").hide();
								  $("#btnG2Delete").hide();
								  $("#btnG2Save"  ).hide();
								  AUIGrid.setProperty("#grid_wrap2", "editable", false);
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap2");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
			  }
	};

	var myGridSub3 = {

			  id: '',
			  //AUI그리드 생성할 div 및 페이징 옵션
			  div: {
			    gridDiv: '#grid_wrap3'
			  },
			  //데이터 연계 옵션
			  proxy: {
			    url: '/ctms/e01/selectIRBRsrcctist.do',
			    param: {},
			    type: 'post',
			    dataType: 'json',
			    //페이징 true, false 로 지정
			    paging: false,
			    //처음 시작시 데이터 로딩
			    autoLoad: true,
			  },
			  //AUI 그리드 옵션
			  gridPros: {
			    // 페이징 사용
			    //usePaging : true,
			    
			    showRowNumColumn : true,
			    showRowCheckColumn : false,
			    showStateColumn    : true,
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true,

			  },
			  //AUI 그리드 레이아웃
			  columnLayout : [
	    		   {
	    		   	  dataField : "IRB_BSIS_SN"
	    		   	, headerText : "순번"
	    		   	, visible : false
	    		   	, editable : false
	    		   	//width: 120
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_SN"
	    		   	, headerText : "과제순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "RSRCCT_SN"
	    		   	, headerText : "연구비 순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
    		       ,{
	    		   	  dataField : "BSNM_REGIST_NO"
	    		   	, headerText : "사업자등록번호<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 200
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				onlyNumeric : true,
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 10) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "10자 이하로 입력해 주세요." };
	    				}
    			  	  }
    		       , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "BANK_NM"
	    		   	, headerText : "은행명(연구비)"
	    		   	, editable : true
	    			, width: 200
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 50) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "50자 이하로 입력해 주세요." };
	    				}
    			  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "ACNUT_NO"
	    		   	, headerText : "계좌번호(연구비)"
	    		   	, editable : true
	    			, width: 180
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				onlyNumeric : true,
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 25) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "25자 이하로 입력해 주세요." };
	    				}
    			  	  }
                   , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "BILL_NM"
	    		   	, headerText : "계산서 종류"
	    		   	, editable : true
	    			, width: 100
	    			, visible : true
	    			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridSub3;
						var retStr = "";
						for(var i=0; me.columnLayout[6].editRenderer.list.length > i; i++) {
							if(me.columnLayout[6].editRenderer.list[i]['NAME'] == value) {
								retStr = me.columnLayout[6].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
		       		, editRenderer : {
		     			type : "DropDownListRenderer",
		     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		     			list : null,
		     			keyField : "NAME",
		     			valueField : "NAME"
		     		  }
		       		, filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "DIRECT_RATE"
	    		   	, headerText : "직접비%"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					var pattern = /^\d+(?:[.]?[\d]?[\d])?$/;
	    					
	    					if(newValue <= 100) { 
	    						isValid = true;
	    					}
	    					else{
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100% 이하로 입력해 주세요." };
	    					}
	    					
	    					if(!pattern.test(newValue)){
	    						isValid = false;
	    						return { "validate" : isValid, "message"  : "숫자와 소숫점2자리까지 입력 가능합니다." };
	    					}
	    				}
    			  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "INDRT_RATE"
	    		   	, headerText : "간접비%"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					var pattern = /^\d+(?:[.]?[\d]?[\d])?$/;
	    					
	    					if(newValue <= 100) { 
	    						isValid = true;
	    					}
	    					else{
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100% 이하로 입력해 주세요." };
	    					}
	    					
	    					if(!pattern.test(newValue)){
	    						isValid = false;
	    						return { "validate" : isValid, "message"  : "숫자와 소숫점2자리까지 입력 가능합니다." };
	    					}
	    				}
   			  	  	 }
                   , filter : {
	      				showIcon : true
	      			  }
	    		  }
                 ,{
	    		   	  dataField : "MEDIC_RATE"
	    		   	, headerText : "약제관리비%"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					var pattern = /^\d+(?:[.]?[\d]?[\d])?$/;
	    					
	    					if(newValue <= 100) { 
	    						isValid = true;
	    					}
	    					else{
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100% 이하로 입력해 주세요." };
	    					}
	    					
	    					if(!pattern.test(newValue)){
	    						isValid = false;
	    						return { "validate" : isValid, "message"  : "숫자와 소숫점2자리까지 입력 가능합니다." };
	    					}
	    				}
  			  	  	 }
                   , filter : {
	      				showIcon : true
	      			  }
	    		  }
                 ,{
	    		   	  dataField : "HSPTL_RATE"
	    		   	, headerText : "병원관리비%"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					var pattern = /^\d+(?:[.]?[\d]?[\d])?$/;
	    					
	    					if(newValue <= 100) { 
	    						isValid = true;
	    					}
	    					else{
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100% 이하로 입력해 주세요." };
	    					}
	    					
	    					if(!pattern.test(newValue)){
	    						isValid = false;
	    						return { "validate" : isValid, "message"  : "숫자와 소숫점2자리까지 입력 가능합니다." };
	    					}
	    				}
 			  	  	 }
                  , filter : {
	      				showIcon : true
	      			  }
	    		  }
                 ,{
	    		   	  dataField : "MXMM_RATE"
	    		   	, headerText : "직접비 대비 인건비 최대비율%"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					var pattern = /^\d+(?:[.]?[\d]?[\d])?$/;
	    					
	    					if(newValue <= 100) { 
	    						isValid = true;
	    					}
	    					else{
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "100% 이하로 입력해 주세요." };
	    					}
	    					
	    					if(!pattern.test(newValue)){
	    						isValid = false;
	    						return { "validate" : isValid, "message"  : "숫자와 소숫점2자리까지 입력 가능합니다." };
	    					}
	    				}
    			  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		  }
                 ,{
	    		   	  dataField : "ETC"
	    		   	, headerText : "기타"
	    		   	, editable : true
//	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					else{
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    					}
	    				}
   			  	  	 }
                    , filter : {
	      				showIcon : true
	      			  }
	    		  }
                 ,{
	    		   	  dataField : "VAT_AT"
	    		   	, headerText : "VAT 산정 여부"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "DropDownListRenderer",  //ComboBoxRenderer
	    				showEditorBtnOver : true,
	    				list : ['Y', 'N']
	    			  }
	    		   }
                 ,{
	    		   	  dataField : "RM"
	    		   	, headerText : "코멘트(특이사항)"
	    		   	, editable : true
// 	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					else{
		    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
		    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    					}
	    				}
    			  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "BILL_KND"
	    		   	, headerText : "BILL_KND"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
			  ],

			  //AUI 그리드 생성
			  createGrid: function() {
			    var me = this;
			    
			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			    gridSub3ID = me.id;
			    me.binding();

			    if(me.proxy.autoLoad) {
					me.load();
			    }
			  },

			  //AUI 그리드 이벤트 
			  binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				});

				AUIGrid.bind(me.id, "cellEditEnd", function(event) {

					if( event.dataField == "BILL_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_ctms010.length > i; i++){

							pName = g_ctms010[i].NAME;
							pCode = g_ctms010[i].CODE;

							if( pValue == pName ){
								var userData = { BILL_KND : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if

				});

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowSelect = event.rowIndex;
				});

			  },
			  load: function(v1, v2) {
			 		var me = this;

			 		AUIGrid.showAjaxLoader(me.id);
			 		
					$.ajax({
						url: me.proxy.url,
			 		    type: me.proxy.type,
			 		    dataType: me.proxy.dataType,
			 		    data: me.proxy.param,
						  success : function(data, textStatus, jqXHR) {
							  if(data.success) {
								  AUIGrid.removeAjaxLoader(me.id);
								  AUIGrid.setGridData(me.id, data.rsrcctist);
								  AUIGrid.setSelectionByIndex(me.id, 0);
								  
								  $("#btnG3Addrow").hide();
								  $("#btnG3Delete").hide();
								  $("#btnG3Save"  ).hide();
								  AUIGrid.setProperty("#grid_wrap3", "editable", false);
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap3");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
			  }
	};

	var myGridSub4 = {

			  id: '',
			  //AUI그리드 생성할 div 및 페이징 옵션
			  div: {
			    gridDiv: '#grid_wrap4',
			    paging: {
			      pagingDiv: 'grid_paging',
			      totalRowCount: 500,
			      rowCount: 10,
			      pageButtonCount: 4,
			      currentPage: 1,
			      totalPage: 0,
			    },
			  },
			  //데이터 연계 옵션
			  proxy: {
			    url: '/ctms/e01/selectIRBDlbrtList.do',
			    param: {},
			    type: 'post',
			    dataType: 'json',
			    //페이징 true, false 로 지정
			    paging: true,
			    //처음 시작시 데이터 로딩
			    autoLoad: true,
			  },
			  //AUI 그리드 옵션
			  gridPros: {
			    // 페이징 사용
			    //usePaging : true,
			    
			    showRowNumColumn : true,
			    showRowCheckColumn : false,

			    showStateColumn    : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true,

			  },
			  //AUI 그리드 레이아웃
              columnLayout : [
	    		   {
	    		   	  dataField : "IRB_BSIS_SN"
	    		   	, headerText : "순번"
	    		   	, visible : false
	    		   	, editable : false
	    		   	//width: 120
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_SN"
	    		   	, headerText : "과제순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "DLBRT_SN"
	    		   	, headerText : "심의순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
                   ,{
	    		   	  dataField : "SE_NM"
	    		   	, headerText : "구분<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridSub4;
						var retStr = "";
						for(var i=0; me.columnLayout[3].editRenderer.list.length > i; i++) {
							if(me.columnLayout[3].editRenderer.list[i]['NAME'] == value) {
								retStr = me.columnLayout[3].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
		       		, editRenderer : {
		     			type : "DropDownListRenderer",
		     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		     			list : null,
		     			keyField : "NAME",
		     			valueField : "NAME"
		     		  }
		       		, filter : {
	      				showIcon : true
	      			  }
	    		   }
                   ,{
	    		   	  dataField : "DLBRT_NM"
	    		   	, headerText : "심의구분<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 130
	    			, visible : true
	    			, labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
	      				var me = myGridSub4;
						var retStr = "";
						for(var i=0; me.columnLayout[4].editRenderer.list.length > i; i++) {
							if(me.columnLayout[4].editRenderer.list[i]['NAME'] == value) {
								retStr = me.columnLayout[4].editRenderer.list[i]['NAME'];
								break;
							}
						}
						return retStr == "" ? value : retStr;
	      		    }
		       		, editRenderer : {
		     			type : "DropDownListRenderer",
		     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
		     			list : null,
		     			keyField : "NAME",
		     			valueField : "NAME"
		     		  }
		       		, filter : {
	      				showIcon : true
	      			  }
	    		   }
                   ,{
 	    		   	  dataField : "PRESENTN_NBFPS"
 	    		   	, headerText : "제출부수"
 	    		   	, editable : true
//  	    			, width: 120
 	    			, visible : true
 	    			, editRenderer : {
 	    				type : "InputEditRenderer",
 	    				
 	    				// 에디팅 유효성 검사
 	    				validator : function(oldValue, newValue, rowItem) {
 	    					var isValid = false;
 	    					
 	    					if(newValue.length <= 10) { 
 	    						isValid = true;
 	    					}
 	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
 	    					return { "validate" : isValid, "message"  : "10자 이하로 입력해 주세요." };
 	    				}
     			  	  }
                    , filter : {
 	      				showIcon : true
 	      			  }
 	    		   }
                   ,{
  	    		   	  dataField : "PRESENTN_CYCLE"
  	    		   	, headerText : "제출주기"
  	    		   	, editable : true
//   	    			, width: 120
  	    			, visible : true
  	    			, editRenderer : {
  	    				type : "InputEditRenderer",
  	    				
  	    				// 에디팅 유효성 검사
  	    				validator : function(oldValue, newValue, rowItem) {
  	    					var isValid = false;
  	    					
  	    					if(newValue.length <= 100) { 
  	    						isValid = true;
  	    					}
  	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
  	    					return { "validate" : isValid, "message"  : "100자 이하로 입력해 주세요." };
  	    				}
      			  	  }
                     , filter : {
  	      				showIcon : true
  	      			  }
  	    		   }
                   ,{
   	    		   	  dataField : "POSES_PAPERS"
   	    		   	, headerText : "구비서류"
   	    		   	, editable : true
//    	    			, width: 120
   	    			, visible : true
   	    			, editRenderer : {
   	    				type : "InputEditRenderer",
   	    				
   	    				// 에디팅 유효성 검사
   	    				validator : function(oldValue, newValue, rowItem) {
   	    					var isValid = false;
   	    					
   	    					if(newValue.length <= 100) { 
   	    						isValid = true;
   	    					}
   	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
   	    					return { "validate" : isValid, "message"  : "100자 이하로 입력해 주세요." };
   	    				}
       			  	  }
                      , filter : {
   	      				showIcon : true
   	      			  }
   	    		   }
                   ,{
	    		   	  dataField : "RM"
	    		   	, headerText : "코멘트"
	    		   	, editable : true
// 	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
                   , filter : {
	      				showIcon : true
	      			  }
	    		   }
                  ,{
  	    		   	  dataField : "FILE_CNT"
  	    		   	, headerText : "첨부파일"
  	    		   	, editable : false
  	    			, width: 120
  	    			, visible : true
  	    			, renderer : {
  	  						type : "ButtonRenderer",				
		  					onclick : function(rowIndex, columnIndex, value, item){
		  						var param = {							 
		  								 parent_value : item.ATCH_FILE_SN
		  						};

		  						if(item.ATCH_FILE_SN != null){
		  							mkLayerPopupOpen("/CTMF0104.do", param);
		  						}
		  					}
		  				}
                     , filter : {
	      				showIcon : true
	      			  }
  	    		   }
                  ,{
 	    		   	  dataField : ""
 	    		   	, headerText : ""
 	    		   	, editable : false
 	    			, width: 120
 	    			, visible : true
 	    			, renderer : {
		 	   				type : "ButtonRenderer",
		 					labelText: "Upload",
		 					onclick : function(rowIndex, columnIndex, value, item){
		 						 var param = {					 
		 								 PROGRAM_ID : "CTMV0101"
		 							   , FILE_SN : item.ATCH_FILE_SN
		 						 };
		 						 
		 						 if(g_grid4Update == "Y"){
		 						 	mkLayerPopupOpen("/DMCJ1105.do", param, 1);
		 						 }
		 					}
		 			   }
 	    		   }
                  ,{
	    		   	  dataField : "ATCH_FILE_SN"
	    		   	, headerText : "파일순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
                  ,{
	    		   	  dataField : "SE"
	    		   	, headerText : "SE"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		  }
                  ,{
	    		   	  dataField : "DLBRT_SE"
	    		   	, headerText : "DLBRT_SE"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		  }
			  ],
			  //AUI 그리드 생성
			  createGrid: function() {
			    var me = this;
			    
			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			    gridSub4ID = me.id;
			    me.binding();

			    if(me.proxy.autoLoad) {
					me.load();
			    }
			  },
			  
			  //AUI 그리드 이벤트 
			  binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				});

				AUIGrid.bind(me.id, "cellEditEnd", function(event) {

					if( event.dataField == "SE_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_ctms026.length > i; i++){

							pName = g_ctms026[i].NAME;
							pCode = g_ctms026[i].CODE;

							if( pValue == pName ){
								var userData = { SE : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if
					
					if( event.dataField == "DLBRT_NM" ) {
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_ctms016.length > i; i++){

							pName = g_ctms016[i].NAME;
							pCode = g_ctms016[i].CODE;

							if( pValue == pName ){
								var userData = { DLBRT_SE : pCode };
								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if

				});

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowSelect = event.rowIndex;
				});

			  },
			  load: function(v1, v2) {
			 		var me = this;
			 		
			 		AUIGrid.showAjaxLoader(me.id);
			 		
					$.ajax({
						url: me.proxy.url,
			 		    type: me.proxy.type,
			 		    dataType: me.proxy.dataType,
			 		    data: me.proxy.param,
						  success : function(data, textStatus, jqXHR) {
							  if(data.success) {
								  AUIGrid.removeAjaxLoader(me.id);
								  AUIGrid.setGridData(me.id, data.dlbrtList);
								  AUIGrid.setSelectionByIndex(me.id, 0);
								  
								  $("#btnG4Addrow").hide();
								  $("#btnG4Delete").hide();
								  $("#btnG4Save"  ).hide();
								  AUIGrid.setProperty("#grid_wrap4", "editable", false);
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap4");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
			  }
	};

	var myGridSub5 = {

			  id: '',
			  //AUI그리드 생성할 div 및 페이징 옵션
			  div: {
			    gridDiv: '#grid_wrap5',
			    paging: {
			      pagingDiv: 'grid_paging',
			      totalRowCount: 500,
			      rowCount: 10,
			      pageButtonCount: 4,
			      currentPage: 1,
			      totalPage: 0,
			    },
			  },
			  //데이터 연계 옵션
			  proxy: {
			    url: '/ctms/e01/selectIRBSaeList.do',
			    param: {},
			    type: 'post',
			    dataType: 'json',
			    //페이징 true, false 로 지정
			    paging: true,
			    //처음 시작시 데이터 로딩
			    autoLoad: true,
			  },
			  //AUI 그리드 옵션
			  gridPros: {
			    // 페이징 사용
			    //usePaging : true,
			    
			    showRowNumColumn : true,
			    showRowCheckColumn : false,

			    showStateColumn    : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true,

			  },
			  //AUI 그리드 레이아웃
              columnLayout : [
	    		   {
	    		   	  dataField : "IRB_BSIS_SN"
	    		   	, headerText : "순번"
	    		   	, visible : false
	    		   	, editable : false
	    		   	//width: 120
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_SN"
	    		   	, headerText : "과제순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "SAE_SN"
	    		   	, headerText : "SAE순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "FORM_AT"
	    		   	, headerText : "양식여부<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 100
	    			, visible : true
	    			, editRenderer : {
	    				type : "DropDownListRenderer",  //ComboBoxRenderer
	    				showEditorBtnOver : true,
	    				list : ['Y', 'N']
	    			  }
	    		   , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "SAE_REPORT_AT"
	    		   	, headerText : "타기관 SAE 보고여부"
	    		   	, editable : true
	    			, width: 150
	    			, visible : true
	    			, editRenderer : {
	    				type : "DropDownListRenderer",  //ComboBoxRenderer
	    				showEditorBtnOver : true,
	    				list : ['Y', 'N']
	    			  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
	    		   ,{
	    		   	  dataField : "SAE_REPORT_MTH"
	    		   	, headerText : "타기관 SAE 보고방법"
	    		   	, editable : true
	    			, width: 200
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
	    		    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                   ,{
	    		   	  dataField : "RM"
	    		   	, headerText : "코멘트(기타사항)"
	    		   	, editable : true
// 	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
    			  	  }
                   , filter : {
	      				showIcon : true
	      			  }
	    		   }
			  ],
			  //AUI 그리드 생성
			  createGrid: function() {
			    var me = this;
			    
			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			    gridSub5ID = me.id;
			    me.binding();

			    if(me.proxy.autoLoad) {
					me.load();
			    }
			  },

			  //AUI 그리드 이벤트 
			  binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				});

				AUIGrid.bind(me.id, "cellEditEnd", function(event) {

					if(AUIGrid.getSelectedIndex(me.id)[1] == 8) {

					} // if

				});

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowSelect = event.rowIndex;
				});

			  },
			  load: function(v1, v2) {
			 		var me = this;
			 		
			 		AUIGrid.showAjaxLoader(me.id);
			 		
					$.ajax({
						url: me.proxy.url,
			 		    type: me.proxy.type,
			 		    dataType: me.proxy.dataType,
			 		    data: me.proxy.param,
						  success : function(data, textStatus, jqXHR) {
							  if(data.success) {
								  AUIGrid.removeAjaxLoader(me.id);
								  AUIGrid.setGridData(me.id, data.saeList);
								  AUIGrid.setSelectionByIndex(me.id, 0);

								  $("#btnG5Addrow").hide();
								  $("#btnG5Delete").hide();
								  $("#btnG5Save"  ).hide();
								  AUIGrid.setProperty("#grid_wrap5", "editable", false);
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap5");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
			  }
	};

	var myGridSub6 = {

			  id: '',
			  //AUI그리드 생성할 div 및 페이징 옵션
			  div: {
			    gridDiv: '#grid_wrap6',
			    paging: {
			      pagingDiv: 'grid_paging',
			      totalRowCount: 500,
			      rowCount: 10,
			      pageButtonCount: 4,
			      currentPage: 1,
			      totalPage: 0,
			    },
			  },
			  //데이터 연계 옵션
			  proxy: {
			    url: '/ctms/e01/selectIRBInfoList.do',
			    param: {},
			    type: 'post',
			    dataType: 'json',
			    //페이징 true, false 로 지정
			    paging: true,
			    //처음 시작시 데이터 로딩
			    autoLoad: true,
			  },
			  //AUI 그리드 옵션
			  gridPros: {
			    // 페이징 사용
			    //usePaging : true,
			    
			    showRowNumColumn : true,
			    showRowCheckColumn : false,

			    showStateColumn    : true,
			    
			    softRemoveRowMode  : true,
			    softRemovePolicy   : "exceptNew",
			    
			    enableColumnResize : true,
			    enableMovingColumn : false,
			    editable : true,
			    enableFilter : true,

			    // 한 화면 페이징 버턴 개수 5개로 지정
			    //showPageButtonCount : 4,
			    headerHeight: 40,
			    rowHeight: 37,
			    selectionMode : "multipleRows",

			    displayTreeOpen : true,

			  },
			  //AUI 그리드 레이아웃
            columnLayout : [
	    		   {
	    		   	  dataField : "IRB_BSIS_SN"
	    		   	, headerText : "순번"
	    		   	, visible : false
	    		   	, editable : false
	    		   	//width: 120
	    		   }
	    		   ,{
	    		   	  dataField : "TASK_SN"
	    		   	, headerText : "과제순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
	    		   ,{
	    		   	  dataField : "E_IRB_SN"
	    		   	, headerText : "e-IRB 순번"
	    		   	, editable : false
	    			, width: 120
	    			, visible : false
	    		   }
                 ,{
	    		   	  dataField : "E_IRB_ADRES"
	    		   	, headerText : "e-IRB 주소"
	    		   	, editable : true
	    			, width: 200
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
  			  	  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "JOIN_NM"
	    		   	, headerText : "가입 CRA<span class='must_01'></span>"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	        	    , labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
	 						var me = myGridOption;
	 						var retStr = "";
	 						for(var i=0; me.columnLayout[4].editRenderer.list.length > i; i++) {
	 							if(me.columnLayout[4].editRenderer.list[i]['USER_NM'] == value) {
	 								retStr = me.columnLayout[4].editRenderer.list[i]['USER_NM'];
	 								break;
	 							}
	 						}
	 						return retStr == "" ? value : retStr;	
	       		      }
	                , editRenderer : {
	  	     			type : "DropDownListRenderer",
	  	     			showEditorBtnOver : true, // 마우스 오버 시 에디터버턴 보이기
	  	     			list : null,
	  	     			keyField : "USER_NM",
	  	     			valueField : "USER_NM"
	  	     		  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "JOIN_CRA"
	    		   	, headerText : "JOIN_ID"
	    		   	, editable : true
	    			, width: 60
	    			, visible : false
	    		   }
                 ,{
	    		   	  dataField : "ID"
	    		   	, headerText : "ID"
	    		   	, editable : true
	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 32) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "32자 이하로 입력해 주세요." };
	    				}
  			  	  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "PW"
	    		   	, headerText : "PW"
	    		   	, editable : true
	    			, width: 150
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 64) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "64자 이하로 입력해 주세요." };
	    				}
  			  	  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "PROGRS_TASK"
	    		   	, headerText : "진행과제(과제 연구자명)"
	    		   	, editable : true
	    			, width: 180
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 32) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "32자 이하로 입력해 주세요." };
	    				}
  			  	  	  }
                 	, filter : {
	      				showIcon : true
	      			  }
	    		   }
                 ,{
	    		   	  dataField : "RM"
	    		   	, headerText : "코멘트(기타사항)"
	    		   	, editable : true
//	    			, width: 120
	    			, visible : true
	    			, editRenderer : {
	    				type : "InputEditRenderer",
	    				
	    				// 에디팅 유효성 검사
	    				validator : function(oldValue, newValue, rowItem) {
	    					var isValid = false;
	    					
	    					if(newValue.length <= 200) { 
	    						isValid = true;
	    					}
	    					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
	    					return { "validate" : isValid, "message"  : "200자 이하로 입력해 주세요." };
	    				}
  			  	  	  }
                    , filter : {
	      				showIcon : true
	      			  }
	    		   }
			  ],
			  //AUI 그리드 생성
			  createGrid: function() {
			    var me = this;
			    
			    //이후 객체.id 로 AUIGrid 컨트롤
			    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
			    gridSub5ID = me.id;
			    me.binding();

			    if(me.proxy.autoLoad) {
					me.load();
			    }
			  },

			  //AUI 그리드 이벤트 
			  binding: function() {
				var me = this;

				AUIGrid.bind(me.id, "cellEditBegin", function(event) {

				});

				AUIGrid.bind(me.id, "cellEditEnd", function(event) {

					if(event.dataField == "JOIN_NM"){
						var pValue = event.value;
						var pName, pCode;

						for(i=0; g_craList.length > i; i++){

							pName = g_craList[i].USER_NM;
							pCode = g_craList[i].USER_ID;

							if( pValue == pName ){
								var userData = { JOIN_CRA : pCode };

								AUIGrid.updateRow(me.id, userData, event.rowIndex);
							}
						} // for
					} // if

				});

				AUIGrid.bind(me.id, "cellClick", function(event) {
					n_rowSelect = event.rowIndex;
				});

			  },
			  load: function(v1, v2) {
			 		var me = this;
			 		
			 		AUIGrid.showAjaxLoader(me.id);
			 		
					$.ajax({
						url: me.proxy.url,
			 		    type: me.proxy.type,
			 		    dataType: me.proxy.dataType,
			 		    data: me.proxy.param,
						  success : function(data, textStatus, jqXHR) {
							  if(data.success) {
								  AUIGrid.removeAjaxLoader(me.id);
								  AUIGrid.setGridData(me.id, data.eInfoList);
								  AUIGrid.setSelectionByIndex(me.id, 0);

								  $("#btnG6Addrow").hide();
								  $("#btnG6Delete").hide();
								  $("#btnG6Save"  ).hide();
								  AUIGrid.setProperty("#grid_wrap6", "editable", false);
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap6");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
			  }
	};

	function checkSelection() {
		var selectedItems = AUIGrid.getSelectedItems(gridMainID);
		if(selectedItems.length <= 0)
			return;
		
		var firstItem = selectedItems[0];
		
		// 행 상태 체크하기
		var state = getItemState(firstItem.item);
		
		return state;
/*
		// 하단에 행인덱스, 헤더 텍스트, 수정 가능여부 출력함.
		document.getElementById("selectionDesc").innerHTML = "현재 행 Index : " + firstItem.rowIndex 
		+ ",  editable : " 	+ firstItem.editable 
		+ ", 행 고유값(PK) : " + firstItem.rowIdValue 
		+ ", 행 상태 : " + state;
*/
	}

	// 아이템 상태 반환
	function getItemState(curItem) {
		
		var rowIdField = AUIGrid.getProperty(gridMainID, "rowIdField");
		var rowIdValue = curItem[rowIdField];

		// 추가된 행인지 여부 검사.
		var isAdded = AUIGrid.isAddedById(gridMainID, rowIdValue );
		if(isAdded) return "Added";
		
		// 수정된 행인지 여부 검사
		var isEdited = AUIGrid.isEditedById(gridMainID, rowIdValue );
		if(isEdited) return "Edited";
		
		// 삭제된 행인지 여부 검사
		var isRemoved = AUIGrid.isRemovedById(gridMainID, rowIdValue );
		if(isRemoved) return "Removed";

		return "Normal";
	}
	
	function fn_mainClick(){
		var classGrid1 = $(".acdMenuLst02 > a").eq(0).hasClass('open');
		var classGrid2 = $(".acdMenuLst02 > a").eq(1).hasClass('open');
		var classGrid3 = $(".acdMenuLst02 > a").eq(2).hasClass('open');
		var classGrid4 = $(".acdMenuLst02 > a").eq(3).hasClass('open');
		var classGrid5 = $(".acdMenuLst02 > a").eq(4).hasClass('open');
		var classGrid6 = $(".acdMenuLst02 > a").eq(5).hasClass('open');

		if(classGrid1){
			myGridSub1.load();
		}
		if(classGrid2){
			myGridSub2.load();
		}
		if(classGrid3){
			myGridSub3.load();
		}
		if(classGrid4){
			myGridSub4.load();
		}
		if(classGrid5){
			myGridSub5.load();
		}
		if(classGrid6){
			myGridSub6.load();
		}
	}

	function accHeader(id){

		var classGrid1 = $(".acdMenuLst02 > a").eq(0).hasClass('open');
		
		if(id == "grid1"){
			if(!classGrid1){
				if(g_grid1 == "Y"){
					$("#grid1").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid1").toggleClass("open");
					myGridSub1.createGrid();
					g_grid1 = "N";
					AUIGrid.setProperty("#grid_wrap1", "editable", false);
				}
			}
			else{
				chkRow = getGridUpdateCheck(id);
				if(chkRow == 0){
					$("#grid1").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid1").toggleClass("close");
				}
				else{
					alert("변경 내역이 존재 합니다. 저장 후 닫으세요.");
				}
			}
		}

		var classGrid2 = $(".acdMenuLst02 > a").eq(1).hasClass('open');
		if(id == "grid2"){
			if(!classGrid2){
				if(g_grid2 == "Y"){
					$("#grid2").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid2").toggleClass("open");
					myGridSub2.createGrid();
					g_grid2 = "N";
					AUIGrid.setProperty("#grid_wrap2", "editable", false);
				}
			}
			else{
				chkRow = getGridUpdateCheck(id);
				if(chkRow == 0){
					$("#grid2").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid2").toggleClass("close");
				}
				else{
					alert("변경 내역이 존재 합니다. 저장 후 닫으세요.");
				}
			}
		}
		
		var classGrid3 = $(".acdMenuLst02 > a").eq(2).hasClass('open');
		if(id == "grid3"){
			if(!classGrid3){
				if(g_grid3 == "Y"){
					$("#grid3").siblings(".acdMenuCts02").slideToggle(500);
					$("#grid3").toggleClass("open");
					myGridSub3.createGrid();
					g_grid3 = "N";
					AUIGrid.setProperty("#grid_wrap3", "editable", false);
				}	
			}
			else{
				chkRow = getGridUpdateCheck(id);
				if(chkRow == 0){
					$("#grid3").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid3").toggleClass("close");
				}
				else{
					alert("변경 내역이 존재 합니다. 저장 후 닫으세요.");
				}
			}
		}
		
		var classGrid4 = $(".acdMenuLst02 > a").eq(3).hasClass('open');
		if(id == "grid4"){
			if(!classGrid4){
				if(g_grid4 == "Y"){
					$("#grid4").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid4").toggleClass("open");
					myGridSub4.createGrid();
					g_grid4 = "N";
					AUIGrid.setProperty("#grid_wrap4", "editable", false);
				}	
			}
			else{
				chkRow = getGridUpdateCheck(id);
				if(chkRow == 0){
					$("#grid4").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid4").toggleClass("close");
				}
				else{
					alert("변경 내역이 존재 합니다. 저장 후 닫으세요.");
				}
			}
		}
		
		var classGrid5 = $(".acdMenuLst02 > a").eq(4).hasClass('open');
		if(id == "grid5"){
			if(!classGrid5){
				if(g_grid5 == "Y"){
					$("#grid5").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid5").toggleClass("open");
					myGridSub5.createGrid();
					g_grid5 = "N";
					AUIGrid.setProperty("#grid_wrap5", "editable", false);
				}		
			}
			else{
				chkRow = getGridUpdateCheck(id);
				if(chkRow == 0){
					$("#grid5").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid5").toggleClass("close");
				}
				else{
					alert("변경 내역이 존재 합니다. 저장 후 닫으세요.");
				}
			}
		}
		
		var classGrid6 = $(".acdMenuLst02 > a").eq(5).hasClass('open');
		if(id == "grid6"){
			if(!classGrid6){
				if(g_grid6 == "Y"){
					$("#grid6").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid6").toggleClass("open");
					myGridSub6.createGrid();
					g_grid6 = "N";
					AUIGrid.setProperty("#grid_wrap6", "editable", false);
				}		
			}
			else{
				chkRow = getGridUpdateCheck(id);
				if(chkRow == 0){
					$("#grid6").siblings(".acdMenuCts02").slideToggle(1);
					$("#grid6").toggleClass("close");
				}
				else{
					alert("변경 내역이 존재 합니다. 저장 후 닫으세요.");
				}
			}
		}
	} // function accHeader
	
	function getUpdateCheck(){
		
		var classGrid1 = $(".acdMenuLst02 > a").eq(0).hasClass('open');
		var classGrid2 = $(".acdMenuLst02 > a").eq(1).hasClass('open');
		var classGrid3 = $(".acdMenuLst02 > a").eq(2).hasClass('open');
		var classGrid4 = $(".acdMenuLst02 > a").eq(3).hasClass('open');
		var classGrid5 = $(".acdMenuLst02 > a").eq(4).hasClass('open');
		var classGrid6 = $(".acdMenuLst02 > a").eq(5).hasClass('open');

		if(classGrid1){
			var rows = AUIGrid.getRowCount("#grid_wrap1");
			if(rows >0 ){
		        var added  = AUIGrid.getAddedRowItems ("#grid_wrap1");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap1");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap1");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}

		if(classGrid2){
			var rows = AUIGrid.getRowCount("#grid_wrap2");

			if(rows > 0 ){
				var added  = AUIGrid.getAddedRowItems ("#grid_wrap2");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap2");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap2");
				return (added.length) + (edited.length) + (remove.length);
			}
			return 0;
		}
		
		if(classGrid3){
			var rows = AUIGrid.getRowCount("#grid_wrap3");
			if(rows > 0){
				var added  = AUIGrid.getAddedRowItems ("#grid_wrap3");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap3");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap3");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		if(classGrid4){
			var rows = AUIGrid.getRowCount("#grid_wrap4");
			if(rows > 0){
				var added  = AUIGrid.getAddedRowItems ("#grid_wrap4");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap4");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap4");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		if(classGrid5){
			var rows = AUIGrid.getRowCount("#grid_wrap5");
			if(rows > 0){
				var added  = AUIGrid.getAddedRowItems ("#grid_wrap5");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap5");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap5");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		if(classGrid6){
			var rows = AUIGrid.getRowCount("#grid_wrap6");
			if(rows > 0){
				var added  = AUIGrid.getAddedRowItems ("#grid_wrap6");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap6");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap6");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		return 0;
	}

	function getGridUpdateCheck(id){
		if(id == "grid1"){
			var rows = AUIGrid.getRowCount("#grid_wrap1");
			if(rows>0){
		        var added  = AUIGrid.getAddedRowItems ("#grid_wrap1");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap1");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap1");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		if(id == "grid2"){
			var rows = AUIGrid.getRowCount("#grid_wrap2");
			if(rows>0){
		        var added  = AUIGrid.getAddedRowItems ("#grid_wrap2");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap2");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap2");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}

		if(id == "grid3"){
			var rows = AUIGrid.getRowCount("#grid_wrap3");
			if(rows>0){
		        var added  = AUIGrid.getAddedRowItems ("#grid_wrap3");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap3");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap3");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		if(id == "grid4"){
			var rows = AUIGrid.getRowCount("#grid_wrap4");
			if(rows>0){
		        var added  = AUIGrid.getAddedRowItems ("#grid_wrap4");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap4");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap4");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		if(id == "grid5"){
			var rows = AUIGrid.getRowCount("#grid_wrap5");
			if(rows>0){
		        var added  = AUIGrid.getAddedRowItems ("#grid_wrap5");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap5");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap5");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		if(id == "grid6"){
			var rows = AUIGrid.getRowCount("#grid_wrap6");
			if(rows>0){
		        var added  = AUIGrid.getAddedRowItems ("#grid_wrap6");
				var edited = AUIGrid.getEditedRowItems("#grid_wrap6");
				var remove = AUIGrid.getRemovedItems  ("#grid_wrap6");
				return (added.length)+(edited.length)+(remove.length);
			}
			return 0;
		}
		
		return 0;
	}

	$(document).ready(function() {

		$("#btnMAddrow").hide();
		$("#btnMDelete").hide();
		$("#btnMSave"  ).hide();
		
		$("#btnG1Addrow").hide();
		$("#btnG1Delete").hide();
		$("#btnG1Save"  ).hide();
		
		$("#btnG2Addrow").hide();
		$("#btnG2Delete").hide();
		$("#btnG2Save"  ).hide();
		
		$("#btnG3Addrow").hide();
		$("#btnG3Delete").hide();
		$("#btnG3Save"  ).hide();
		
		$("#btnG4Addrow").hide();
		$("#btnG4Delete").hide();
		$("#btnG4Save"  ).hide();
		
		$("#btnG5Addrow").hide();
		$("#btnG5Delete").hide();
		$("#btnG5Save"  ).hide();
		
		$("#btnG6Addrow").hide();
		$("#btnG6Delete").hide();
		$("#btnG6Save"  ).hide();

		myGridOption.init();
		
		
		$('#btnSearch').click(function(){	 //수정여부	
			myGridOption.proxy.param = { TASK_SN: g_TaskSn, INSTT_NM: $("#insttNm").val()};				
			myGridOption.load();
		});
		
		$('#btnMUpdate').click(function(){	 //수정여부	
			if(AUIGrid.getProperty("#grid_wrap", "editable")){
				AUIGrid.setProperty("#grid_wrap", "editable", false);
				$("#btnMAddrow").hide();
				$("#btnMDelete").hide();
				$("#btnMSave"  ).hide();
			}
			else{
				AUIGrid.setProperty("#grid_wrap", "editable", true);
				$("#btnMAddrow").show();
				$("#btnMDelete").show();
				$("#btnMSave"  ).show();
			}
		});

		$('#btnMAddrow').click(function(){	 //행추가
			if(getUpdateCheck() > 0){
				alert("변경내역이 존재 합니다. 변경 내역을 저장하세요.");
				return;
			}
		
	        AUIGrid.setProperty("#grid_wrap", "editable" , true ); 
	        var row = {
  		   	            'IRB_BSIS_SN'  : ''
	    		   	  , 'TASK_SN'      : g_TaskSn
	    		   	  , 'TASK_NO'      : g_TaskNo
	    		   	  , 'INSTT_CODE'   : ''
	    		   	  , 'INSTT_NM'     : ''
	                  , 'CHRG_CRA'     : ''
	    		   	  , 'AREA'         : ''
	    		   	  , 'EIRB_AT'      : 'N'
	    		   	  , 'EXPR_APPN_AT' : 'N'
	    		   	  , 'FDRM_JDGMN'   : ''
	    		   	  , 'RPD_JDGMN'    : ''
	    		   	  , 'EXMNT_REQUST' : ''
	    		   	  , 'ADRES_A'      : ''
	    		   	  , 'ADRES_A'      : ''
	    		   	  , 'ADRES_B'      : ''
	    		   	  , 'ADRES_C'      : ''
	    		   	  , 'ADRES_D'      : ''
	    		   	  , 'HSPTLHED_NM'  : ''
	    		   	  , 'RPRSNTV_NM'   : ''
                      , 'UPDATE_ID'    : _user.USER_ID
                      , 'LAST_UPDDE'   : new Date()
                      , 'USE_AT'       : 'Y'
                      , 'CURD'         : 'C'
	        };      
	        AUIGrid.addRow("#grid_wrap", row, 'first');
		});

		$('#btnMDelete').click(function(){	 //행삭제
			var state = checkSelection();
			if(state == "Added"){
				g_deleteChange = "Y";
				AUIGrid.removeRow("#grid_wrap", "selectedIndex");
			}
			else{
				if(confirm("기초 정보 삭제 시 연락처, 심의비, 연구비, 심의, e-IRB정보도 같이 삭제 됩니다.\n\n                                       적용 하시겠습니까?")){
					AUIGrid.removeRow("#grid_wrap", "selectedIndex");
				}
			}
		});
		
		$('#btnMSave').click(function(){	 //저장

			if(getUpdateCheck() > 0){
				alert("변경내역이 존재 합니다. 변경 내역을 저장하세요.");
				return;
			}

			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap");
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems("#grid_wrap");
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems("#grid_wrap");
			
			var cnt = 0;
			for(var i = 0; i < addedRowItems.length; i++) {
				arJson.push(addedRowItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < editedItems.length; i++) {
				editedItems[i].CURD = 'U';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < removeItems.length; i++) {
				editedItems[i].CURD = 'D';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			var nullChkData = AUIGrid.getGridData("#grid_wrap");
			for(i=0; nullChkData.length > i; i++){
				var gData     = nullChkData[i];
				var insttCode = gData.INSTT_CODE;
				if(insttCode == "" || insttCode == null){
					AUIGrid.setSelectionByIndex("#grid_wrap", i, 4);
					alert("기관명은 필수 입력입니다.");
					return;
				}
			}

			if(cnt > 0){
				if(confirm("저장 하시겠습니까?")){
					$.ajax({
						  url : '/ctms/e01/insertIRBBasicInfo.do' ,
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert("저장되었습니다.");
								   myGridOption.load();
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap");
								  alert(data.message);
							  }
						  }, 
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				}
			} // if
			else{
				alert("변경 내역이 없습니다.");
			}

		}); // Main 저장
		
		/***************************************************************************/
		$('#btnG1Update').click(function(){	 //수정여부
			if(AUIGrid.getProperty("#grid_wrap1", "editable")){
				AUIGrid.setProperty("#grid_wrap1", "editable", false);
				$("#btnG1Addrow").hide();
				$("#btnG1Delete").hide();
				$("#btnG1Save"  ).hide();
			}
			else{
				AUIGrid.setProperty("#grid_wrap1", "editable", true);
				$("#btnG1Addrow").show();
				$("#btnG1Delete").show();
				$("#btnG1Save"  ).show();
			}
		});

		$('#btnG1Addrow').click(function(){	 //행추가

			var bsisSn = myGridOption.proxy.param['IRB_BSIS_SN'];
			if(bsisSn != "" && bsisSn != undefined ){
		        AUIGrid.setProperty("#grid_wrap1", "editable" , true ); 
		        var row = {
	                      'IRB_BSIS_SN' : myGridSub1.proxy.param['IRB_BSIS_SN']
			            , 'TASK_SN'     : myGridSub1.proxy.param['TASK_SN']
			            , 'TASK_NO'     : g_TaskNo
			            , 'CTTPC_SN'    : ''
			            , 'SE'          : ''
			            , 'NM'          : ''
			            , 'OFFM'        : ''
			            , 'CELL_PHONE'  : ''
			            , 'EMAIL'       : ''
			            , 'FAX'         : ''
			            , 'USE_AT'      : 'Y'
			            , 'UPDATE_ID'   : _user.USER_ID
			            , 'LAST_UPDDE'  : new Date()
			            , 'USE_AT'      : 'Y'
			            , 'CURD'        : 'C'
		        };      
		        AUIGrid.addRow("#grid_wrap1", row, 'first');
			}
			else{
				alert("IRB 기초 정보를 먼전 등록 하세요.");
			}
		});

		$('#btnG1Delete').click(function(){	 //행삭제
			AUIGrid.removeRow("#grid_wrap1", "selectedIndex");
		});
		
		$('#btnG1Save').click(function(){	 //저장

			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap1");
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems("#grid_wrap1");
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems("#grid_wrap1");
			
			var cnt = 0;
			for(var i = 0; i < addedRowItems.length; i++) {
				arJson.push(addedRowItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < editedItems.length; i++) {
				editedItems[i].CURD = 'U';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < removeItems.length; i++) {
				editedItems[i].CURD = 'D';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			var nullChkData = AUIGrid.getGridData("#grid_wrap1");
			for(i=0; nullChkData.length > i; i++){
				var gData = nullChkData[i];
				var val1 = gData.SE_NM;
				if(val1 == "" || val1 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap1", i, 3);
					alert("연락처 구분은 필수 입력입니다.");
					return;
				}
			}

			if(cnt > 0){
				if(confirm("저장 하시겠습니까?")){
					$.ajax({
						  url : '/ctms/e01/insertIRBCttpcInfo.do' ,
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert("저장되었습니다.");
								  myGridSub1.load();
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap1");
								  alert(data.message);
							  }
						  }, 
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				}
			} // if
			else{
				alert("변경 내역이 없습니다.");
			}

		}); // grid1 저장
		
		/***************************************************************************/
		$('#btnG2Update').click(function(){	 //수정여부
			if(AUIGrid.getProperty("#grid_wrap2", "editable")){
				AUIGrid.setProperty("#grid_wrap2", "editable", false);
				$("#btnG2Addrow").hide();
				$("#btnG2Delete").hide();
				$("#btnG2Save"  ).hide();
			}
			else{
				AUIGrid.setProperty("#grid_wrap2", "editable", true);
				$("#btnG2Addrow").show();
				$("#btnG2Delete").show();
				$("#btnG2Save"  ).show();
			}
		});

		$('#btnG2Addrow').click(function(){	 //행추가

			var bsisSn = myGridOption.proxy.param['IRB_BSIS_SN'];
			if(bsisSn != "" && bsisSn != undefined ){
	        	AUIGrid.setProperty("#grid_wrap2", "editable" , true ); 
		        var row =  {
	                      'IRB_BSIS_SN'    : myGridSub2.proxy.param['IRB_BSIS_SN']
			            , 'TASK_SN'        : myGridSub2.proxy.param['TASK_SN']
			            , 'TASK_NO'        : g_TaskNo
			            , 'DLBRTCT_SN'     : ''
			            , 'BSNM_REGIST_NO' : ''
			            , 'SE'             : ''
			            , 'DLBRT_SE'       : ''
			            , 'AMOUNT'         : ''
			            , 'VAT_AT'         : 'N'
			            , 'BANK_NM'        : ''
			            , 'ACNUT_NO'       : ''
			            , 'BILL_PBLICTE'   : 'N'
			            , 'BILL_SE'        : ''
			            , 'RM'             : ''
			            , 'USE_AT'         : 'Y'
			            , 'UPDATE_ID'      : _user.USER_ID
			            , 'LAST_UPDDE'     : new Date()
			            , 'USE_AT'         : 'Y'
			            , 'CURD'           : 'C'
		        };      
		        AUIGrid.addRow("#grid_wrap2", row, 'first');
			}
			else{
				alert("IRB 기초 정보를 먼전 등록 하세요.");
			}
		});

		$('#btnG2Delete').click(function(){	 //행삭제
			AUIGrid.removeRow("#grid_wrap2", "selectedIndex");
		});
		
		$('#btnG2Save').click(function(){	 //저장

			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap2");
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems("#grid_wrap2");
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems("#grid_wrap2");
			
			var cnt = 0;
			for(var i = 0; i < addedRowItems.length; i++) {
				arJson.push(addedRowItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < editedItems.length; i++) {
				editedItems[i].CURD = 'U';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < removeItems.length; i++) {
				editedItems[i].CURD = 'D';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			var nullChkData = AUIGrid.getGridData("#grid_wrap2");
			for(i=0; nullChkData.length > i; i++){
				var gData = nullChkData[i];
				var val1  = gData.BSNM_REGIST_NO;
				var val2  = gData.SE_NM;
				var val3  = gData.DLBRT_NM;

				if(val1 == "" || val1 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap2", i, 3);
					alert("사업자등록번호는 필수 입력입니다.");
					return;
				}
				if(val2 == "" || val2 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap2", i, 4);
					alert("구분1은 필수 입력입니다.");
					return;
				}
				if(val3 == "" || val3 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap2", i, 5);
					alert("구분2는 필수 입력입니다.");
					return;
				}
			}
			
			if(cnt > 0){
				if(confirm("저장 하시겠습니까?")){
					$.ajax({
						  url : '/ctms/e01/insertIRBDlbrtctInfo.do' ,
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert("저장되었습니다.");
								  myGridSub2.load();
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap2");
								  alert(data.message);
							  }
						  }, 
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				}
			} // if
			else{
				alert("변경 내역이 없습니다.");
			}

		}); // gird2 저장

		/***************************************************************************/
		$('#btnG3Update').click(function(){	 //수정여부	
			if(AUIGrid.getProperty("#grid_wrap3", "editable")){
				AUIGrid.setProperty("#grid_wrap3", "editable", false);
				$("#btnG3Addrow").hide();
				$("#btnG3Delete").hide();
				$("#btnG3Save"  ).hide();
			}
			else{
				AUIGrid.setProperty("#grid_wrap3", "editable", true);
				$("#btnG3Addrow").show();
				$("#btnG3Delete").show();
				$("#btnG3Save"  ).show();
			}
		});

		$('#btnG3Addrow').click(function(){	 //행추가
			var bsisSn = myGridOption.proxy.param['IRB_BSIS_SN'];
			if(bsisSn != "" && bsisSn != undefined ){
	        	AUIGrid.setProperty("#grid_wrap3", "editable" , true ); 
		        var row = {
	                      'IRB_BSIS_SN'  : myGridSub3.proxy.param['IRB_BSIS_SN']
			            , 'TASK_SN'      : myGridSub3.proxy.param['TASK_SN']
			            , 'TASK_NO'      : g_TaskNo
			            , 'RSRCCT_SN'    : ''
			            , 'BANK_NM'      : ''
			            , 'ACNUT_NO'     : ''
			            , 'BILL_KND'     : ''
			            , 'DIRECT_RATE'  : '0.0'
			            , 'INDRT_RATE'   : '0.0'
			            , 'MXMM_RATE'    : '0.0'
			            , 'VAT_AT'       : ''
			            , 'RM'           : ''
			            , 'USE_AT'       : 'Y'
			            , 'UPDATE_ID'    : _user.USER_ID
			            , 'LAST_UPDDE'   : new Date()
			            , 'USE_AT'       : 'Y'
			            , 'CURD'         : 'C'
		        };      
		        AUIGrid.addRow("#grid_wrap3", row, 'first');
			}
			else{
				alert("IRB 기초 정보를 먼전 등록 하세요.");
			}
		});

		$('#btnG3Delete').click(function(){	 //행삭제
			AUIGrid.removeRow("#grid_wrap3", "selectedIndex");
		});
		
		$('#btnG3Save').click(function(){	 //저장

			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap3");
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems("#grid_wrap3");
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems("#grid_wrap3");
			
			var cnt = 0;
			for(var i = 0; i < addedRowItems.length; i++) {
				arJson.push(addedRowItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < editedItems.length; i++) {
				editedItems[i].CURD = 'U';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < removeItems.length; i++) {
				editedItems[i].CURD = 'D';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			var nullChkData = AUIGrid.getGridData("#grid_wrap3");
			for(i=0; nullChkData.length > i; i++){
				var gData = nullChkData[i];
				var val1  = gData.BSNM_REGIST_NO;
				if(val1 == "" || val1 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap3", i, 3);
					alert("사업자등록번호는 필수 입력입니다.");
					return;
				}
			}

			if(cnt > 0){
				if(confirm("저장 하시겠습니까?")){
					$.ajax({
						  url : '/ctms/e01/insertIRBRsrcctInfo.do' ,
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert("저장되었습니다.");
								  myGridSub3.load();
// 								  AUIGrid.setProperty("#grid_wrap3", "editable" , false ); 
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap3");
								  alert(data.message);
							  }
						  },
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				}
			} // if
			else{
				alert("변경 내역이 없습니다.");
			}

		}); // gird3 저장
		
		/***************************************************************************/
		$('#btnG4Update').click(function(){	 //수정여부	
			if(AUIGrid.getProperty("#grid_wrap4", "editable")){
				AUIGrid.setProperty("#grid_wrap4", "editable", false);
				$("#btnG4Addrow").hide();
				$("#btnG4Delete").hide();
				$("#btnG4Save"  ).hide();
				g_grid4Update = "N";
			}
			else{
				AUIGrid.setProperty("#grid_wrap4", "editable", true);
				$("#btnG4Addrow").show();
				$("#btnG4Delete").show();
				$("#btnG4Save"  ).show();
				g_grid4Update = "Y";
			}
		});

		$('#btnG4Addrow').click(function(){	 //행추가

			var bsisSn = myGridOption.proxy.param['IRB_BSIS_SN'];
			if(bsisSn != "" && bsisSn != undefined ){
		        AUIGrid.setProperty("#grid_wrap4", "editable" , true ); 
		        var row = {
	                      'IRB_BSIS_SN'    : myGridSub4.proxy.param['IRB_BSIS_SN']
			            , 'TASK_SN'        : myGridSub4.proxy.param['TASK_SN']
			            , 'TASK_NO'        : g_TaskNo
			            , 'DLBRT_SN'       : ''
			            , 'E_IRB_AT'       : ''
			            , 'DLBRT_SE'       : ''
			            , 'PRESENTN_NBFPS' : ''
			            , 'PRESENTN_CYCLE' : ''
			            , 'POSES_PAPERS'   : ''
			            , 'RM'             : ''
			            , 'FILE_CNT'       : '0'
			            , 'ATCH_FILE_SN'   : ''
			            , 'UPDATE_ID'      : _user.USER_ID
			            , 'LAST_UPDDE'     : new Date()
			            , 'USE_AT'         : 'Y'
			            , 'CURD'           : 'C'
		        };      
		        AUIGrid.addRow("#grid_wrap4", row, 'first');
			}
			else{
				alert("IRB 기초 정보를 먼전 등록 하세요.");
			}
		});

		$('#btnG4Delete').click(function(){	 //행삭제
			AUIGrid.removeRow("#grid_wrap4", "selectedIndex");
		});
		
		$('#btnG4Save').click(function(){	 //저장

			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap4");
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems("#grid_wrap4");
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems("#grid_wrap4");
			
			var cnt = 0;
			for(var i = 0; i < addedRowItems.length; i++) {
				arJson.push(addedRowItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < editedItems.length; i++) {
				editedItems[i].CURD = 'U';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < removeItems.length; i++) {
				editedItems[i].CURD = 'D';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			var nullChkData = AUIGrid.getGridData("#grid_wrap4");
			for(i=0; nullChkData.length > i; i++){
				var gData = nullChkData[i];
				var val1  = gData.SE_NM;
				var val2  = gData.DLBRT_NM;
				if(val1 == "" || val1 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap4", i, 3);
					alert("구분은 필수 입력입니다.");
					return;
				}
				if(val2 == "" || val2 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap4", i, 4);
					alert("심의구분은 필수 입력입니다.");
					return;
				}
			}
			
			if(cnt > 0){
				if(confirm("저장 하시겠습니까?")){
					$.ajax({
						  url : '/ctms/e01/insertIRBDlbrtInfo.do' ,
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert("저장되었습니다.");
								  myGridSub4.load();
// 								  AUIGrid.setProperty("#grid_wrap4", "editable" , false ); 
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap4");
								  alert(data.message);
							  }
						  }, 
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				} // confirm if
			} // if
			else{
				alert("변경 내역이 없습니다.");
			}

		}); // gird4 저장
		
		/***************************************************************************/
		$('#btnG5Update').click(function(){	 //수정여부	
			if(AUIGrid.getProperty("#grid_wrap5", "editable")){
				AUIGrid.setProperty("#grid_wrap5", "editable", false);
				$("#btnG5Addrow").hide();
				$("#btnG5Delete").hide();
				$("#btnG5Save"  ).hide();
			}
			else{
				AUIGrid.setProperty("#grid_wrap5", "editable", true);
				$("#btnG5Addrow").show();
				$("#btnG5Delete").show();
				$("#btnG5Save"  ).show();
			}
		});

		$('#btnG5Addrow').click(function(){	 //행추가

			var bsisSn = myGridOption.proxy.param['IRB_BSIS_SN'];
			if(bsisSn != "" && bsisSn != undefined ){
		        AUIGrid.setProperty("#grid_wrap5", "editable" , true ); 
		        var row = {
	                      'IRB_BSIS_SN'    : myGridSub5.proxy.param['IRB_BSIS_SN']
			            , 'TASK_SN'        : myGridSub5.proxy.param['TASK_SN']
			            , 'TASK_NO'        : g_TaskNo
			            , 'SAE_SN'         : ''
			            , 'FORM_AT'        : 'N'
			            , 'SAE_REPORT_AT'  : 'N'
			            , 'SAE_REPORT_MTH' : ''
			            , 'RM'             : ''
			            , 'UPDATE_ID'      : _user.USER_ID
			            , 'LAST_UPDDE'     : new Date()
			            , 'USE_AT'         : 'Y'
			            , 'CURD'           : 'C'
		        };      
		        AUIGrid.addRow("#grid_wrap5", row, 'first');
			}
			else{
				alert("IRB 기초 정보를 먼전 등록 하세요.");
			}
		});

		$('#btnG5Delete').click(function(){	 //행삭제
			AUIGrid.removeRow("#grid_wrap5", "selectedIndex");
		});
		
		$('#btnG5Save').click(function(){	 //저장

			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap5");
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems("#grid_wrap5");
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems("#grid_wrap5");
			
			var cnt = 0;
			for(var i = 0; i < addedRowItems.length; i++) {
				arJson.push(addedRowItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < editedItems.length; i++) {
				editedItems[i].CURD = 'U';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < removeItems.length; i++) {
				editedItems[i].CURD = 'D';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			var nullChkData = AUIGrid.getGridData("#grid_wrap5");
			for(i=0; nullChkData.length > i; i++){
				var gData = nullChkData[i];
				var val1  = gData.FORM_AT;
				if(val1 == "" || val1 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap5", i, 3);
					alert("양식여부는 필수 입력입니다.");
					return;
				}
			}
			
			if(cnt > 0){
				if(confirm("저장 하시겠습니까?")){
					$.ajax({
						  url : '/ctms/e01/insertIRBSaeInfo.do' ,
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert("저장되었습니다.");
								  myGridSub5.load();
// 								  AUIGrid.setProperty("#grid_wrap5", "editable" , false ); 
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap5");
								  alert(data.message);
							  }
						  }, 
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				} // confirm if
			} // if
			else {
				alert("변경 내역이 없습니다.");
			}

		}); // gird5 저장

		/***************************************************************************/
		$('#btnG6Update').click(function(){	 //수정여부	
			if(AUIGrid.getProperty("#grid_wrap6", "editable")){
				AUIGrid.setProperty("#grid_wrap6", "editable", false);
				$("#btnG6Addrow").hide();
				$("#btnG6Delete").hide();
				$("#btnG6Save"  ).hide();
			}
			else{
				AUIGrid.setProperty("#grid_wrap6", "editable", true);
				$("#btnG6Addrow").show();
				$("#btnG6Delete").show();
				$("#btnG6Save"  ).show();
			}
		});

		$('#btnG6Addrow').click(function(){	 //행추가

			var bsisSn = myGridOption.proxy.param['IRB_BSIS_SN'];
			if(bsisSn != "" && bsisSn != undefined ){
		        AUIGrid.setProperty("#grid_wrap6", "editable" , true ); 
		        var row = {
	                      'IRB_BSIS_SN' : myGridSub5.proxy.param['IRB_BSIS_SN']
			            , 'TASK_SN'     : myGridSub5.proxy.param['TASK_SN']
			            , 'TASK_NO'     : g_TaskNo
			            , 'E_IRB_SN'    : ''
			            , 'E_IRB_ADRES' : ''
			            , 'SBSCRB_CRA'  : ''
			            , 'ID'          : ''
			            , 'PW'          : ''
			            , 'PROGRS_TASK' : ''
			            , 'RM'          : ''
			            , 'UPDATE_ID'   : _user.USER_ID
			            , 'LAST_UPDDE'  : new Date()
			            , 'USE_AT'      : 'Y'
			            , 'CURD'        : 'C'
		        };      
		        AUIGrid.addRow("#grid_wrap6", row, 'first');
			}
			else{
				alert("IRB 기초 정보를 먼전 등록 하세요.");
			}
		});

		$('#btnG6Delete').click(function(){	 //행삭제
			AUIGrid.removeRow("#grid_wrap6", "selectedIndex");
		});
		
		$('#btnG6Save').click(function(){	 //저장

			var arJson = [];
			
			// 추가된 행 아이템들(배열)
			var addedRowItems = AUIGrid.getAddedRowItems("#grid_wrap6");
			// 수정된 행 아이템들(배열)
			var editedItems = AUIGrid.getEditedRowItems("#grid_wrap6");
			// 삭제된 행 아이템들(배열)
			var removeItems = AUIGrid.getRemovedItems("#grid_wrap6");
			
			var cnt = 0;
			for(var i = 0; i < addedRowItems.length; i++) {
				arJson.push(addedRowItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < editedItems.length; i++) {
				editedItems[i].CURD = 'U';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			for(var i = 0; i < removeItems.length; i++) {
				editedItems[i].CURD = 'D';
				editedItems[i].UPDATE_ID = _user.USER_ID;
				arJson.push(editedItems[i]);
				cnt++;
			}
			
			var nullChkData = AUIGrid.getGridData("#grid_wrap6");
			for(i=0; nullChkData.length > i; i++){
				var gData = nullChkData[i];
				var val1  = gData.JOIN_NM;
				if(val1 == "" || val1 == null){
					AUIGrid.setSelectionByIndex("#grid_wrap6", i, 4);
					alert("가입CRA는 필수 입력입니다.");
					return;
				}
			}
			
			if(cnt > 0){
				if(confirm("저장 하시겠습니까?")){
					$.ajax({
						  url : '/ctms/e01/insertIRBInfoInfo.do' ,
						  type: 'post',
						  contentType: "application/json; charset=UTF-8",
						  data : JSON.stringify(arJson),
						  success : function(data, textStatus, jqXHR) {
							  var gridData = data;
							  
							  if(data.success) {
								  alert("저장되었습니다.");
								  myGridSub6.load();
// 								  AUIGrid.setProperty("#grid_wrap6", "editable" , false ); 
							  } else {
								  AUIGrid.removeAjaxLoader("#grid_wrap6");
								  alert(data.message);
							  }
						  }, 
						  error : function(jqXHR, textStatus, errorThrown){
							  alert(textStatus);
						  }
					});
				} // confirm if
			} // if
			else {
				alert("변경 내역이 없습니다.");
			}

		}); // gird6 저장

	});

	
	window.onresize = function() {
		// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
		if (typeof myGridOption.id !== "undefined") {
			AUIGrid.resize(myGridOption.id);
		}
		if (typeof myGridSub1.id !== "undefined") {
			AUIGrid.resize(myGridSub1.id);
		}
		if (typeof myGridSub2.id !== "undefined") {
			AUIGrid.resize(myGridSub2.id);
		}
		if (typeof myGridSub3.id !== "undefined") {
			AUIGrid.resize(myGridSub3.id);
		}
		if (typeof myGridSub4.id !== "undefined") {
			AUIGrid.resize(myGridSub4.id);
		}
		if (typeof myGridSub5.id !== "undefined") {
			AUIGrid.resize(myGridSub5.id);
		}
		if (typeof myGridSub6.id !== "undefined") {
			AUIGrid.resize(myGridSub6.id);
		}
	};
</script>
</head>
<body>
<c:import url="/com/topHeader.do?MODULE_CODE=CTMS&MENU_ID=CTMV0101&UPPER_MENU_ID=CTMV" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=CTMS&MENU_ID=CTMV0101&UPPER_MENU_ID=CTMV" charEncoding="utf-8"/>
<div id="wrap">

	<!-- 메인 시작 -->
    <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>IRB Info 전체</h3>

                <nav id="pathNav">
                    <ul>
                        <li><a href="#"><img src="../../../images/pantheon/common/pathNavIco.png" alt="">Home</a></li>
                        <li><a href="#">Report</a></li>
                    </ul>
                </nav>
            </article>
			
                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">
                        <div class="conBoxInner">

                            <!-- 컨텐츠 타이틀 시작-->
                            <article class="conTitBox">
                                <h5>기초정보</h5>
                            </article>
                            <!-- 컨텐츠 타이틀 끝-->

                            <!-- 상단 타이틀 전체메뉴라인 시작-->
                            <article class="conTitBtn">
                                                                                                     
                                <!-- 상단 테이블 왼쪽 메뉴 시작 -->
                                <div class="conTitBtnL">
                                    기관명 : <input type="text" id="insttNm" class="pdR15"><input type="button" class="btn mgL3" id="btnSearch" value="검색">
                                </div>
                                <!-- 상단 테이블 왼쪽 메뉴 끝 -->

                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
                                <div class="conTitBtnR">
                                    <input type="button" id="btnMAddrow" value="행추가">
                                    <input type="button" id="btnMDelete" value="행삭제">
                                    <input type="button" id="btnMUpdate" value="수정">
                                    <input type="button" id="btnMSave"   value="저장">
                                </div>
                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

                            </article>
                            <!-- 상단 타이틀 전체메뉴라인 끝-->

                            <!-- 테이블 시작 -->
                            <article class="mgT55">
                                <div id="grid_wrap" ></div>
                            </article>
                            <!-- 테이블 끝 -->

                        </div>

                    </section>
                    <!-- 컨텐츠박스 끝-->
                    
                    <!-- 컨텐츠박스 시작-->
                    <section class="conBox100 conBox">

                            <!-- 아코디언 메뉴  시작 -->
                            <article class="mgT55">
                                <ul id="acdMenu02">

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close" id="grid1" onclick='accHeader(this.id)'>연락처</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

			                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
			                                <div class="conTitBtnR">
			                                    <input type="button" id="btnG1Addrow" value="행추가">
			                                    <input type="button" id="btnG1Delete" value="행삭제">
			                                    <input type="button" id="btnG1Update" value="수정">
			                                    <input type="button" id="btnG1Save"   value="저장">
			                                </div>
			                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

											<article class="mgT43">
	                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                                            <div id="grid_wrap1"></div>
	                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                            </article>

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close" id="grid2" onclick='javascript:accHeader(this.id)'>심의비</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

			                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
			                                <div class="conTitBtnR">
			                                    <input type="button" id="btnG2Addrow" value="행추가">
			                                    <input type="button" id="btnG2Delete" value="행삭제">
			                                    <input type="button" id="btnG2Update" value="수정">
			                                    <input type="button" id="btnG2Save"   value="저장">
			                                </div>
			                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

											<article class="mgT43">
	                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                                            <div id="grid_wrap2"></div>
	                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                            </article>

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->


                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close" id="grid3" onclick='javascript:accHeader(this.id)'>연구비</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

			                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
			                                <div class="conTitBtnR">
			                                    <input type="button" id="btnG3Addrow" value="행추가">
			                                    <input type="button" id="btnG3Delete" value="행삭제">
			                                    <input type="button" id="btnG3Update" value="수정">
			                                    <input type="button" id="btnG3Save"   value="저장">
			                                </div>
			                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

											<article class="mgT43">
	                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                                            <div id="grid_wrap3"></div>
	                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                            </article>

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->

                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close" id="grid4" onclick='javascript:accHeader(this.id)'>심의</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

			                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
			                                <div class="conTitBtnR">
			                                    <input type="button" id="btnG4Addrow" value="행추가">
			                                    <input type="button" id="btnG4Delete" value="행삭제">
			                                    <input type="button" id="btnG4Update" value="수정">
			                                    <input type="button" id="btnG4Save"   value="저장">
			                                </div>
			                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

											<article class="mgT43">
	                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                                            <div id="grid_wrap4"></div>
	                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                            </article>

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->
                                    
                                    
                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close" id="grid5" onclick='javascript:accHeader(this.id)'>SAE 정보</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

			                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
			                                <div class="conTitBtnR">
			                                    <input type="button" id="btnG5Addrow" value="행추가">
			                                    <input type="button" id="btnG5Delete" value="행삭제">
			                                    <input type="button" id="btnG5Update" value="수정">
			                                    <input type="button" id="btnG5Save"   value="저장">
			                                </div>
			                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

											<article class="mgT43">
	                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                                            <div id="grid_wrap5"></div>
	                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                            </article>

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->
                                    
                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst02"><a class="acdMenuLik close" id="grid6" onclick='javascript:accHeader(this.id)'>e-IRB 정보</a>
                                        <div class="acdMenuCts acdMenuCts02 close">

			                                <!-- 상단 테이블 오른쪽 메뉴 시작-->
			                                <div class="conTitBtnR">
			                                    <input type="button" id="btnG6Addrow" value="행추가">
			                                    <input type="button" id="btnG6Delete" value="행삭제">
			                                    <input type="button" id="btnG6Update" value="수정">
			                                    <input type="button" id="btnG6Save"   value="저장">
			                                </div>
			                                <!-- 상단 테이블 오른쪽 메뉴 끝-->

											<article class="mgT43">
	                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
	                                            <div id="grid_wrap6"></div>
	                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                            </article>

                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->

                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->

                    </section>
                    <!-- 컨텐츠박스 끝-->
</div>
</section>
</div>

</body>
</html>