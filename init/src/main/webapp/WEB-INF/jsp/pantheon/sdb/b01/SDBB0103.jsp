<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
<title>Label</title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

<script type="text/javascript">
var req_prduct_code = "${req_prduct_code}";

$(function() {
	  setinit();
	  btninit();
	  init();
	  grLabelList.createGrid();
	  makeFileAttachment();
});

function makeFileAttachment(){
	//파일업로드 제한 수
	var maxFileNum = 1;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
}

function btninit(){	
	
	$('#tabInfo').click(function(){
		url = "/sdb/b01/SDBB0102.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val()
		POSTSend(url, id, val);
	});	
	
	$('#tabLab').click(function(){
		url = "/sdb/b01/SDBB0103.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val()
		POSTSend(url, id, val);
	});	
	
	$('#tabPsur').click(function(){
		url = "/sdb/b01/SDBB0104.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val()
		POSTSend(url, id, val);
	});
	
	$('#tabNon').click(function(){
		url = "/sdb/b01/SDBB0105.do";
		id ="PRDUCT_CODE";
		val = $("#prduct_code").val()
		POSTSend(url, id, val);
	});
	
	 //검색 
	  $('#btnSearch').click(function(){	  	
		  grLabelList.load();	  	 
	  });
	 
	  $('#btnInit').click(function() {
			//var check_code = $("#tx	tEtcno").val();
			$('#iform').each(function() {
				this.reset();
			});
			
			$('label[popup_type=Label]').text('');
			
			$('#empty_file').val("NO");
			$('#egovComFileList').empty();
			$('#egovComFileUploader').attr("disabled",false);
			
			$("#mode").val('C');
		});
	  
	  $('#btnSave').click(function() {
		  if (!mkValidation()) {
				return;
			}		
			if (!confirm('저장하시겠습니까?')) {
				return;
			}
			var mode = $("#mode").val();
			var empty_file = $("#empty_file").val();
			
			if(mode == 'C'){
				alert('등록');
				//return;
				if(typeof($('#egovComFileList').find("input")) != "object"){				
					alert('첨부할 파일이 존재하지 않습니다.');	
				}
				var formData = new FormData();
				var formTag = $('#filetForm').children();
				
				for(var i = 0; i < formTag.length; i++) {
					formData.append(formTag[i].name, formTag[i].value);
					
					if(formTag[i].type == 'file') {
						formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
					}
				}			
				$.ajax({
					url : '/sdb/b01/insertDmFileMstr.do',
					data : formData,
					processData : false,
					contentType : false,
					type : 'POST',
					success : function(data) {					
						saveForm(mode, data.result);
					}
				});
			}else if(mode == "U"){
				alert('수정');
				//return;
				if(empty_file=="YES"){
					saveForm(mode, $('#file_id').val());
				}else{
					if(typeof($('#egovComFileList').find("input")) != "object"){				
						alert('첨부할 파일이 존재하지 않습니다.');	
					}
					var formData = new FormData();
					var formTag = $('#filetForm').children();
					
					for(var i = 0; i < formTag.length; i++) {
						formData.append(formTag[i].name, formTag[i].value);
						
						if(formTag[i].type == 'file') {
							formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
						}
					}			
					$.ajax({
						url : '/sdb/b01/insertDmFileMstr.do',
						data : formData,
						processData : false,
						contentType : false,
						type : 'POST',
						success : function(data) {
							saveForm(mode, data.result);
			//						if(data.success) {
			//							location.replace("./COMZ0201_DOWN.do?MstrSn=" + data.result);
			//						}
						}
					});
				}
			}
		});
		
	  $('#btnDel').click(function(){	  	
		  var mode = $("#mode").val();
			if(!confirm('삭제하시겠습니까?')){
				return;
			}
			if (mode =='U'){
				del_mode = 'D';
			}
			var params = {
					CURD : del_mode,					
					LBL_CODE : $("#lbl_code").val()
					};		
			$.ajax({
				  url : './saveLabelList.do',
				  type: 'post',
				  data : params,
				  dataType	: "json",
				  success : function(result) {
					  if(result.result == "ok"){
							alert("성공");
							window.location.reload();
					  }else{
							alert(result.errmsg);
					  }
				  }, 
				  error : function(jqXHR, textStatus, errorThrown){
					  alert(errorThrown);
					  alert(textStatus);
				  }			
			});
			  	 
	  });
	
}

function setinit(){
	<c:forEach var="result" items="${printType}" varStatus="status">
		$("#sllbl_tp_code").append("<option value='<c:out value="${result.CMMN_CODE}"/>'>" + '<c:out value="${result.CMMN_CODE_NM}"/>' + "</option>");
	</c:forEach>
	
	mkSetDatePickerYYMMDD("#txtefect_occrrncde");
	
	
	
}

function init(){
	
	if(req_prduct_code !=""){
		$("#prduct_code").val(req_prduct_code);		
	}else{
				
	}
	
	if(req_prduct_code != null && req_prduct_code !=""){
		var params = {
			PRDUCT_CODE : req_prduct_code,
		};
		$.ajax({
			type		: "POST",
			url			: "/sdb/b01/selectProductListInfo.do",
			data		: params,
			dataType	: "json",
			 success : function(result) {					 
				  if(result.success == "true"){
					  $("#txtprductnm_code").val(result.PRDUCTNM_CODE_KOR);						  
					  $("#txtconfm_bfe_ip_nm_mullang_code1").val(result.CONFM_BFE_IP_NM_CODE1_KOR);
					  $("#txtconfm_bfe_ip_nm_mullang_code2").val(result.CONFM_BFE_IP_NM_CODE2_KOR);
					  $("#txtconfm_bfe_ip_nm_mullang_code3").val(result.CONFM_BFE_IP_NM_CODE3_KOR);
				  }else{
						alert(result.errmsg);
				  }
			  }, 
			error		: function(xhr, textStatus, errorThrown){
				//alert(textStatus);
				alert("실패");
			}
		});
	}
}

function EnglishNotation(idKorean, idEng){
	
	var txtKorean = $.trim($('#'+idKorean).val());
	var txtEng = $.trim($('#'+idEng).text());

	var param = {
			ID_KOREAN : idKorean,
			ID_ENG : idEng,
			KOREAN : txtKorean,
			ENG : txtEng
		};
		
		mkLayerPopupOpen("/sdb/c02/popupSDBC0218.do", param);
		return false;
}

var me;
var grLabelList = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grLabelList.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap',
    paging: {
	    pselectionMode : 'singleRow',
		editable : false,
		usePaging : false,
		enableFilter : true,
		pageRowCount : 10,
		showPageButtonCount : 10,
		headerHeight : 40,	
		rowHeight : 37
    },
  },
  //데이터 연계 옵션
  proxy: {
    url: './selectLabelList.do',
    param: {
    	PRDUCT_CODE : $('#prduct_code').val()
    },
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
    enableColumnResize : false,
    enableMovingColumn : false,
    editable : false,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    //showPageButtonCount : 4,
    headerHeight: 40,
    rowHeight: 37,
    height : 400,
    selectionMode : "singleRows",
    displayTreeOpen : true,    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
	    dataField : "LBL_TP_CODE",
	    headerText : "Label Type",
	    width : 120,
		filter : {
 			showIcon : true
 		}
  },{
    dataField : "FILE_NAME",
    headerText : "Label Name",
    width : "50%",
	filter : {
			showIcon : true
		}
  },{
    dataField : "EFECT_OCCRRNCDE",
    headerText : "Effective Date",
    width : 200,
	filter : {
			showIcon : true
		}
  },{
    dataField : "FILE_MASTR_SN",
    headerText : "FILE",
    renderer : { // HTML 템플릿 렌더러 사용
		type : "TemplateRenderer"
	},
	// dataField 로 정의된 필드 값이 HTML 이라면 labelFunction 으로 처리할 필요 없음.
	labelFunction : function (rowIndex, columnIndex, value, headerText, item ) { // HTML 템플릿 작성
		if(!value)	return "";		
		var template = '<div style="display:inline-block; margin-top:4px; line-height:12px;">';		
		template += '<a href="#" class="my_a_tag" onclick="javascript:fn_downFile('+ value +','+ item.DETAIL_SN+');"><img style="width:auto; height:12px;" src="/images/pantheon/common/AUIGrid/download_icon.png">';		
		template += '</a></div>';
		return template; // HTML 템플릿 반환..그대도 innerHTML 속성값으로 처리됨
	}
  },{
    dataField : "LBL_CODE",
    headerText : "Label Code",
    visible : false
  }],

  //AUI 그리드 생성
  createGrid: function() {
    me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    AUIGrid.bind(me.id, "cellClick", auiGridCellClickHandler);
    if(me.proxy.autoLoad) {
      console.log('1');
      me.load();
    }

    //me.createPagingNavigator(1);
  },
  //AUI 그리드 이벤트 
  binding: function() {
    
  },
  //AUI 그리드 데이터 요청
  load: function(v1, v2) {
    var me = this;
    
    //AUIGrid.showAjaxLoader(me.id);
  //rowCOunt = 300
   var param = {
   		PRDUCT_CODE : $('#prduct_code').val()
   };
    $.ajax({
        url: me.proxy.url,
        type: me.proxy.type,
        dataType: me.proxy.dataType,
        data: param,
        success:function(data){
          if(data.success) {
            AUIGrid.removeAjaxLoader(me.id);
            AUIGrid.setGridData(me.id, data.result);
            data.count= data.result.length;
            
            //paging = true 및 count를 서버에서 리턴받았을 시 페이징 시작
            if(data.count && me.proxy.paging) {
              me.div.paging.totalRowCount = data.count;
              /*높이 변경
              AUIGrid.resize(me.id, 800, 300);
              $("#"+me.div.paging.pagingDiv).offset({top: 495})
              */
              me.createPagingNavigator(me.div.paging.currentPage);
            }
            $(".aui-grid-template-renderer-wrapper").removeAttr("style");
          } else {
            AUIGrid.removeAjaxLoader(me.id);
            alert(data.message);
          }
        }
    });
  },
  //사용자 정의 페이징 Navigator (css 및 태그를 개발자가 임의로 지정할 수 있다. (retStr 수정) load() 함수에서 ajax 요청이 끝나고 마지막에 발동시킨다.)
  createPagingNavigator: function(goPage) {
    var me = this;
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    this.div.paging.totalPage = Math.ceil(this.div.paging.totalRowCount/this.div.paging.rowCount);
    
    var retStr = "";
    var prevPage = parseInt((goPage - 1)/me.div.paging.pageButtonCount) * ( me.div.paging.pageButtonCount /*-3*/);
    var nextPage = ((parseInt((goPage - 1)/me.div.paging.pageButtonCount)) * me.div.paging.pageButtonCount) + me.div.paging.pageButtonCount +1 ;
    prevPage = Math.max(0,prevPage );
    nextPage = Math.min(nextPage, me.div.paging.totalPage);
    if ( goPage == 0 ) { prevPage.stop() }

            //console.log(goPage)
    
    //셀렉트박스
    retStr += "<select class='rowSel' onchange='javascript:grLabelList.moveToPage(grLabelList.div.paging.currentPage, this.value)'>"
    if(grLabelList.div.paging.rowCount == 20) {
      retStr += "<option value=20 selected=true>rows 20</option>"
    } else {
      retStr += "<option value=20>rows 20</option>"
    }
    if(grLabelList.div.paging.rowCount == 50) {
      retStr += "<option value=50 selected=true>rows 50</option>"
    } else {
      retStr += "<option value=50>rows 50</option>"
    }
    if(grLabelList.div.paging.rowCount == 100) {
      retStr += "<option value=100 selected=true>rows 100</option>"
    } else {
      retStr += "<option value=100>rows 100</option>"
    }
    if(grLabelList.div.paging.rowCount == 300) {
      retStr += "<option value=300 selected=true>rows 300</option>"
    } else {
      retStr += "<option value=300>rows 300</option>"
    }
    if(grLabelList.div.paging.rowCount == 500) {
      retStr += "<option value=500 selected=true>rows 500</option>"
    } else {
      retStr += "<option value=500>rows 500</option>"
    }
    retStr += "</select>"
    


    // 처음
    retStr += "<span class='aui-grid-paging-grup'>";
    retStr += "<a href='javascript:grLabelList.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:grLabelList.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:grLabelList.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }

    // 다음
    retStr += "<a href='javascript:grLabelList.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:grLabelList.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
    retStr += "</span>";
    ;

    //el식 테스트
    document.getElementById(me.div.paging.pagingDiv).innerHTML = retStr;
  },
  //페이징 에서 어느 페이지로 갈 것인지 지정
  moveToPage: function(goPage, rowCount) {
    var me = this;
    
    if(!me.div.paging.pagingDiv) { 
      return;
    }
    
    // 현재 페이지 보관
    me.div.paging.currentPage = goPage ;
    
    // selectBox에서 요청시, 1페이지부터 시작
    if(rowCount) {
      me.div.paging.rowCount = rowCount;
      me.div.paging.currentPage = 1;
      goPage = 1;
    }
    
    me.load(me.div.paging.rowCount, goPage);
  }
};




 // 윈도우 리사이징 이벤트
  window.onresize = function() {
  // 크기가 변경되었을 때 AUIGrid.resize() 함수 호출 
  if (typeof grLabelList.id !== "undefined") {
    AUIGrid.resize(grLabelList.id);
    }  

  };

  function auiGridCellClickHandler(){
	  
	  var str = "";
		var i, rowItem, rowInfoObj, dataField;
		
		selectionMode = AUIGrid.getProperty(me.id, "selectionMode");
		
		var selectedItems = AUIGrid.getSelectedItems(me.id);	
		if(selectedItems.length <= 0) {
			alert("없음");
			return;
		}
		
		rowInfoObj = selectedItems[0];
		rowItem = rowInfoObj.item;
		//str += "rowIdx : " + rowInfoObj.rowIndex + ", id : " + rowItem.id + ", name : " + rowItem.name + ", country : " + rowItem.country + "......\n";
		var lbl_code = rowItem.LBL_CODE;
		var params ={
				LBL_CODE : lbl_code
		}
		$.ajax({
			type		: "POST",
			url			: "/sdb/b01/selectLabelListInfo.do",
			data		: params,
			dataType	: "json",
			 success : function(result) {					 
				  if(result.success == "true"){				  
					  var file_name= result.FILE_NAME;
					  var file_ext= result.FILE_EXT;
					  var file_fullname = file_name +"."+file_ext;
					  
					  var detail_sn = result.DETAIL_SN;
					  var file_mastr_sn = result.FILE_MASTR_SN;
					  $("#txtefect_occrrncde").val(result.EFECT_OCCRRNCDE);
					  $("#sllbl_tp_code").val(result.LBL_TP_CODE);
					  $("#txtsend_nation").val(result.SEND_NATION);
					  
					  
					  
					  $("#hdetc_appn").val(result.ETC_APPN);
					  $("#hdmain_change_isestatn").val(result.MAIN_CHANGE_ISESTATN);					  
					  $("#hdsend_person").val(result.SEND_PERSON);
					  $("#hdsend_person_etc_info").val(result.SEND_PERSON_ETC_INFO);
					  
					  $("#txtetc_appn").val(result.ETC_APPN_KOR);
					  $("#txtmain_change_isestatn").val(result.MAIN_CHANGE_ISESTATN_KOR);					  
					  $("#txtsend_person").val(result.SEND_PERSON_KOR);
					  $("#txtsend_person_etc_info").val(result.SEND_PERSON_ETC_INFO_KOR);
					  
					  $("#txtetc_appn_eng").text(result.ETC_APPN_ENG);
					  $("#txtmain_change_isestatn_eng").text(result.MAIN_CHANGE_ISESTATN_ENG);					  
					  $("#txtsend_person_eng").text(result.SEND_PERSON_ENG);
					  $("#txtsend_person_etc_info_eng").text(result.SEND_PERSON_ETC_INFO_ENG);
					  var t_html = '<a href="javascript:fn_downFile('+file_mastr_sn+', '+detail_sn+')">'+ file_fullname +'</a> <input type="button" onclick="del_file()" value="Delete"/>';
					  $("#egovComFileList").empty();
					  $("#egovComFileList").append(t_html);
					  $('#egovComFileUploader').attr("disabled",true);
					  $('#lbl_code').val(lbl_code);
					  $('#file_id').val(file_mastr_sn);
					  
					  $('#mode').val('U'); 
					  
				  }else{
						alert(result.errmsg);
				  }
			  }, 
			error		: function(xhr, textStatus, errorThrown){
				//alert(textStatus);
				alert("실패");
			}
		});
		
  }
  function del_file(){
	  if(!confirm('삭제하시겠습니까?')){
		  return;
	  }
		  
	    $('#empty_file').val("NO");
		$('#egovComFileList').empty();
		$('#egovComFileUploader').attr("disabled",false);
		$("#mode").val('C');
		
	}
  
  function insertFile(){
	  var formData = new FormData();
		var formTag = $('#filetForm').children();
		
		for(var i = 0; i < formTag.length; i++) {
			formData.append(formTag[i].name, formTag[i].value);
			
			if(formTag[i].type == 'file') {
				formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
			}
		}
		
		$.ajax({
			url : '/sdb/b01/insertDmFileMstr.do',
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				location.href="/com/z02/COMZ0201_DOWN.do?MstrSn=" + data.result;
//				if(data.success) {
//					location.replace("./COMZ0201_DOWN.do?MstrSn=" + data.result);
//				}
			}
		});
	  
  }
  
  function saveForm(mode, file_id){
	  var params = {
				CURD 					: mode, 		
				LBL_CODE 				: $("#lbl_code").val(),
				PRDUCT_CODE 			: $("#prduct_code").val(),
				FILE_ID 				: file_id,
				EFECT_OCCRRNCDE 		: $("#txtefect_occrrncde").val(),
				LBL_TP_CODE 			: $("#sllbl_tp_code").val(),
				SEND_NATION 			: $("#txtsend_nation").val(),
				ETC_APPN 				: $("#hdetc_appn").val(),
				ETC_APPN_KOR			: $("#txtetc_appn").val(),
				ETC_APPN_ENG			: $("#txtetc_appn_eng").text(),
				MAIN_CHANGE_ISESTATN 	: $("#hdmain_change_isestatn").val(),
				MAIN_CHANGE_ISESTATN_KOR: $("#txtmain_change_isestatn").val(),
				MAIN_CHANGE_ISESTATN_ENG: $("#txtmain_change_isestatn_eng").text(),
				SEND_PERSON 			: $("#hdsend_person").val(),
				SEND_PERSON_KOR			: $("#txtsend_person").val(), 
				SEND_PERSON_ENG			: $("#txtsend_person_eng").text(), 
				SEND_PERSON_ETC_INFO 	: $("#hdsend_person_etc_info").val(),
				SEND_PERSON_ETC_INFO_KOR: $("#txtsend_person_etc_info").val(),
				SEND_PERSON_ETC_INFO_ENG: $("#txtsend_person_etc_info_eng").text(),
				UPDATE_ID 				: '${loginMap.USER_ID}'
				};
		
		$.ajax({
			  url : './insertLabelList.do',
			  type : 'post',
			  contentType : "application/json; charset=UTF-8",
			  data : JSON.stringify(params),
			  dataType	: "json",
			  success : function(data) {
				  if(data.success){
						alert("성공");
						window.location.reload();
				  }else{
						alert(result.errmsg);
				  }
			  }, 
			  error : function(jqXHR, textStatus, errorThrown){
				  alert("실패");
			  }
		});
	  
  }
  
  function fn_downFile(fileMastrSn, fileSn){
		window.open("<c:url value='/sdb/b01/selectDmFileDetailByPk.do?FILE_MASTR_SN="+fileMastrSn+"&DETAIL_SN="+fileSn+"'/>");
	}
</script>
 </head>
<body>
	<div id="wrap">
	<!-- 헤더 호출 -->
		<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBB0101&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
		<!-- 레프트 호출 -->
		<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBB0101&UPPER_MENU_ID=SDBB" charEncoding="utf-8"/>
		
		<input type='hidden' id='lbl_code'/>	
		<input type='hidden' id='file_id'/>						
		<input type='hidden' id='mode' value='C'/>
		<input type="hidden" id="prduct_code"/>
		<input type='hidden' id='empty_file' value="YES">
	    <section id="mainCon">
	        <div class="mainConInner">
	           <article class="mainTitBox">
					<h3>${progrmMap.MENU_NM}</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							 <li>${progrmMap.UPPER_MENU_NM}</li>
							<li>${progrmMap.MENU_NM}</li>
						</ul>
					</nav>
				</article>
	            <!-- 컨텐츠박스 시작-->
	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
	                   <article class="conGridUpper">
							<div class="button_tab_01">
								<ul>
									<li id="tabInfo" class="tab_menu">Info</li>
									<li id="tabLab" class="port_back tab_menu">LABEL</li>
									<li id="tabPsur" class="tab_menu">PSUR</li>
									<li id="tabNon" class="tab_menu">Non-Clinical</li>						
								</ul>
							</div>


							<div class="conTitBtnR">
								<input type="button" id="btnSource" value="CASE">
								<input type="button" id="btnInit" value="초기화">
								<input type="button" id="btnSave" value="저장">
								<input type="button" id="btnDel" value="삭제">
								<input type="button" id="btnAudit" value="A" title="Audit Trail">
							</div>

							<article class="mgT44" style="position:relative;">
							
								<div style="font-family:'NanumGothicBold'; display:inline-block; position:absolute; top:-25px;">
									<h7>PRODUCT</h7>
								</div>
								
								<table class="tb001">
									<colgroup>
										<col width="15%" />
										<col width="35%" />
										<col width="15%" />																		
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>Brand Name</th>
											<td><input type='text' id='txtprductnm_code' readonly style="width:100%;"></td>
											<th>Pre-Approval IP Name 1</th>
											<td><input type='text' id='txtconfm_bfe_ip_nm_mullang_code1' readonly style="width:100%;"></td>
										</tr>
										<tr>
											<th>Pre-Approval IP Name 2</th>
											<td><input type='text' id='txtconfm_bfe_ip_nm_mullang_code2' readonly style="width:100%;"></td>
											<th>Pre-Approval IP Name 3</th>
											<td><input type='text' id='txtconfm_bfe_ip_nm_mullang_code3'  readonly style="width:100%;"></td>
										</tr>
									</tbody>
								</table>
								
								<div style="height:20px;"></div>
								
								<div style="font-family:'NanumGothicBold'; display:inline-block; ">
									<h7>LABEL</h7>
								</div>
								
								<div style="height:5px;"></div>
								
								<table class="tb001" id ="inputTable">
								<colgroup>
									<col width="15%" />
									<col width="35%" />
									<col width="15%" />																		
									<col width="" />
								</colgroup>
								<tbody>								
								<tr>
									<th>Label Upload<span class='must_01'></span></th>
									<td colspan="3">
										<form id="filetForm" action="<c:url value='/sdb/b01/insertDmFileMstr.d'/>" method="post" enctype="multipart/form-data">
										<input type="file" name="file_1"  id="egovComFileUploader" size="60" title="첨부파일" valireqire="첨부파일" />
										<p>
											<div id="egovComFileList"></div>
										</p>
										</form>
									</td>
								</tr>
								<form id="iform">
								<tr>
									<th>Effective Date</th>
									<td>
										<div class="dateBox">
											<input type='text' id='txtefect_occrrncde' style="width: 120px;" />
										</div>
									</td>
									<th>Label Type</th>
									<td>
										<select id='sllbl_tp_code' style="width:100%;">
											<option value="">====선택====</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>Major Change</th>
									<td colspan="3" style="padding-top:5px; padding-bottom: 2px;">
										<table class="in_table">
											<tr>
												<th>
													<textarea id="txtmain_change_isestatn" rows="2" style="width: 100%;" tabindex="20"></textarea>
												</th>
												<td style="vertical-align: top; width: 32px;">
													<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtmain_change_isestatn','txtmain_change_isestatn_eng');"/>
												</td>
											</tr>
										</table>
										<input type="hidden" id="hdmain_change_isestatn" />
										<label class="label_01" popup_type="Label" id="txtmain_change_isestatn_eng">
									</td>									
								</tr>
								<tr>
									<th>Other Specify</th>
									<td>
										<table class="in_table">
											<tr>
												<th>
													<input type="text" id="txtetc_appn" style="width:100%;">
												</th>
												<td style="width: 32px;">
													<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtetc_appn','txtetc_appn_eng');"/>
												</td>
											</tr>
										</table>
										<input type="hidden" id="hdetc_appn" />
										<label class="label_01" popup_type="Label" id="txtetc_appn_eng">
									</td>
									<th>Country of Sender</th>
									<td><input type='text' id='txtsend_nation' style="width:100%;"></td>
								</tr>
								<tr>
									<th>Sender</th>
									<td>
										<table class="in_table">
											<tr>
												<th>
													<input type="text" id="txtsend_person" style="width:100%;">
												</th>
												<td style="width: 32px;">
													<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtsend_person','txtsend_person_eng');"/>
												</td>
											</tr>
										</table>
										<input type="hidden" id="hdsend_person" />
										<label class="label_01" popup_type="Label" id="txtsend_person_eng">
									</td>
									<th>Other information of Sender</th>
									<td style="padding-top:5px; padding-bottom: 2px;">
										<table class="in_table">
											<tr>
												<th>
													<textarea id="txtsend_person_etc_info" rows="2" style="width: 100%;" tabindex="20"></textarea>
												</th>
												<td style="vertical-align: top; width: 32px;">
													<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;"  onclick="EnglishNotation('txtsend_person_etc_info','txtsend_person_etc_info_eng');"/>
												</td>
											</tr>
										</table>
										<input type="hidden" id="hdsend_person_etc_info" />
										<label class="label_01" popup_type="Label" id="txtsend_person_etc_info_eng">
									</td>
								</tr>
								</form>
								</tbody>
							</table>	
								 
							</article>
							
							
		                    <article class="mgT55">
		                        <div id="grid_wrap" class="gridHeiSz10 grid_wrap tb01_2"></div>
		                        <div id="grid_paging" class="aui-grid-paging-panel my-grid-paging-panel"></div>
		                    </article>
						</article>
	                </div>
	            </section>
	            <!-- 컨텐츠박스 끝-->
	        </div>
	    </section>
	   
	</div>
</body>
</html>