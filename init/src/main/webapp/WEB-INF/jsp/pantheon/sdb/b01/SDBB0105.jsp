<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false"/>
  <title>Non-Clinical</title>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
<script type="text/javascript">
var req_prduct_code = "${req_prduct_code}";

$(function() {
	setinit();
	btninit();
	init();
	 
	  
	
});

function setinit(){
	makeFileAttachment();
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
	
	
	 $('#btnInit').click(function() {
		$('#iform').each(function(){
			this.reset();
		});
		
		$('#egovComFileList').empty();
		$('#egovComFileUploader').attr("disabled",false);
		$("#mode").val('C');
	});
	 
	//검색 
	  $('#btnSearch').click(function(){	  	
		  grNonClinical.load();	  	 
	  });
	
	  $('#btnInit').click(function() {
			$('#inputForm').each(function(){
				$('#egovComFileList').empty();
				$('#egovComFileUploader').attr("disabled",false);
				this.reset();
				$("#mode").val('I');
			});
		});
	  
	  $('#btnSave').click(function() {
			var mode = $("#mode").val();
			var empty_file = $("#empty_file").val();
			
			if(mode == 'C'){
				alert('등록');
				
				if(typeof($('#egovComFileList').find("input")) != "object"){				
					alert('첨부할 파일이 존재하지 않습니다.');	
					return;
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
						
					 alert(mode);
					saveForm(mode, data.result);
					}
				});
			}else if(mode == "U"){
				alert('수정');				
				
				if(typeof($('#egovComFileList').find("input")) != "object"){				
					alert('첨부할 파일이 존재하지 않습니다.');
					return;
				}
				if(empty_file=="YES"){
					saveForm(mode, $('#file_id').val());
				}else{
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
					PRDUCT_CODE : $("#prduct_code").val(),
					NCLINC_FILECODE : ''
					};		
			$.ajax({
				  url : './insertNonCList.do',
				  type: 'post',
				  data : params,
				  dataType	: "json",
				  success : function(data) {
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

function makeFileAttachment(){
	//파일업로드 제한 수
	var maxFileNum = 1;
	var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
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
					  
					  $("#nclinc_filecode").val(result.NCLINC_FILECODE);
					  
					  grNonClinical.createGrid();
					  //makeFileAttachment();
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
var me;
var grNonClinical = {
  //그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grNonClinical.id);
  id: '',
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#grid_wrap',
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
    url: './selectNonCList.do',
    param: {
    	FILE_MASTR_SN : $('#nclinc_filecode').val()
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
    selectionMode : "singleRows",
    displayTreeOpen : true,    

  },
  //AUI 그리드 레이아웃
  columnLayout : [{
    dataField : "FILE_NAME",
    headerText : "File Name",
    width : 400
  },{
    dataField : "FRST_CREDE",
    headerText : "등록일.",
    dataType:"date",
	formatString : "yyyy-mm-dd",
    width : 200
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
    dataField : "DETAIL_SN",
    headerText : "DETAIL_SN",
    visible : false
  }],

  //AUI 그리드 생성
  createGrid: function() {
    me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
    me.binding();
    AUIGrid.bind(me.id, "cellDoubleClick", auiGridCellDoubleClickHandler);
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
		FILE_MASTR_SN : $('#nclinc_filecode').val()
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
    retStr += "<select class='rowSel' onchange='javascript:grNonClinical.moveToPage(grNonClinical.div.paging.currentPage, this.value)'>"
    if(grNonClinical.div.paging.rowCount == 20) {
      retStr += "<option value=20 selected=true>rows 20</option>"
    } else {
      retStr += "<option value=20>rows 20</option>"
    }
    if(grNonClinical.div.paging.rowCount == 50) {
      retStr += "<option value=50 selected=true>rows 50</option>"
    } else {
      retStr += "<option value=50>rows 50</option>"
    }
    if(grNonClinical.div.paging.rowCount == 100) {
      retStr += "<option value=100 selected=true>rows 100</option>"
    } else {
      retStr += "<option value=100>rows 100</option>"
    }
    if(grNonClinical.div.paging.rowCount == 300) {
      retStr += "<option value=300 selected=true>rows 300</option>"
    } else {
      retStr += "<option value=300>rows 300</option>"
    }
    if(grNonClinical.div.paging.rowCount == 500) {
      retStr += "<option value=500 selected=true>rows 500</option>"
    } else {
      retStr += "<option value=500>rows 500</option>"
    }
    retStr += "</select>"
    


    // 처음
    retStr += "<span class='aui-grid-paging-grup'>";
    retStr += "<a href='javascript:grNonClinical.moveToPage(1)'><span class='aui-grid-paging-number aui-grid-paging-first'>first</span></a>";
    // 이전
    retStr += "<a href='javascript:grNonClinical.moveToPage(" + prevPage + ")'><span class='aui-grid-paging-number aui-grid-paging-prev'> < </span></a>";
    for (var i=(prevPage+1), len=(me.div.paging.pageButtonCount+prevPage) ; i<=len; i++) {
      if (goPage == i) {
        retStr += "<span class='aui-grid-paging-number aui-grid-paging-number-selected'>" + i + "</span>";
      } else {
        retStr += "<a href='javascript:grNonClinical.moveToPage(" + i + ")'><span class='aui-grid-paging-number'>";
        retStr += i;
        retStr += "</span></a>";

  console.log(prevPage)
      }
      
      if (i >= me.div.paging.totalPage) {
        break;
      }
    }

    // 다음
    retStr += "<a href='javascript:grNonClinical.moveToPage(" + nextPage + ")'><span class='aui-grid-paging-number aui-grid-paging-next'> > </span></a>";
    // 마지막
    retStr += "<a href='javascript:grNonClinical.moveToPage(" + me.div.paging.totalPage + ")'><span class='aui-grid-paging-number aui-grid-paging-last'>last</span></a>"
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
  if (typeof grNonClinical.id !== "undefined") {
    AUIGrid.resize(grNonClinical.id);
    }  

  };

  function auiGridCellDoubleClickHandler(){
	  
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
		var detail_sn = rowItem.DETAIL_SN;
		var params ={
				DETAIL_SN : detail_sn
		}
		$.ajax({
			type		: "POST",
			url			: "/sdb/b01/selectNonCListInfo.do",
			data		: params,
			dataType	: "json",
			 success : function(result) {					 
				  if(result.success == "true"){				  
					  var file_fullname= result.FILE_NAME;					  
					  //
					  var detail_sn = result.DETAIL_SN;
					  var file_mastr_sn = result.FILE_MASTR_SN;					  
					  var t_html = '<a href="javascript:fn_downFile('+file_mastr_sn+', '+detail_sn+')">'+ file_fullname +'</a> <input type="button" onclick="del_file()" value="Delete"/>';
					  $("#egovComFileList").empty();
					  $("#egovComFileList").append(t_html);
					  $('#egovComFileUploader').attr("disabled",true);
					  $('#detail_sn').val(detail_sn);
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
	  	$('#empty_file').val("NO");
		$('#egovComFileList').empty();
		$('#egovComFileUploader').attr("disabled",false);
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
		
//			for문이 돌면 아래와 같이 데이터 입력이 된다.
//			formData.append("type", $("input[name=type]").val());
//			formData.append("test3", $("input[name=file1]")[0].files[0]);
//			formData.append("test4", $("input[name=file2]")[0].files[0]);
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
				PRDUCT_CODE 			: $("#prduct_code").val(),
				NCLINC_FILECODE			: file_id								
				};
	  alert(params);
		$.ajax({
			  url : './insertNonCList.do',
			  type : 'post',
			  contentType : "application/json; charset=UTF-8",
			  data : JSON.stringify(params),
			  dataType	: "json",
			  success : function(data) {
				  if(data.success){
						alert("성공");
						window.location.reload();
				  }else{
						alert(data.errmsg);
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
	            <section class="conBox100 conBox">
	                <div class="conBoxInner">
	                    <article class="conGridUpper">
							<div class="button_tab_01">
								<ul>
									<li id="tabInfo" class="tab_menu">Info</li>
									<li id="tabLab" class="tab_menu">LABEL</li>
									<li id="tabPsur" class="tab_menu">RSI</li>
									<li id="tabNon" class="port_back tab_menu">Non-Clinical</li>						
								</ul>
							</div>					

	                        <div class="conTitBtnR">
	                            <input type="button" class="btn mgL3"  id="btnSource" value="Source">
	                            <input type="button" id="btnInit" value="초기화">
	                            <input type="button" id="btnSave" value="저장">
	                            <input type="button" id="btnDel" value="삭제">
	                            <input type="button" id="btnAudit" value="내역">                           
	                        </div>

	                        
							<input type='hidden' id='prduct_code'/>
							<input type='hidden' id='nclinc_filecode'/>
							<input type='hidden' id='detail_sn'/>							
							<input type='hidden' id='file_id'/>							
							<input type='hidden' id='mode' value='C'/>
							<input type='hidden' id='empty_file' value="YES">	
													
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
										<td>
											<input type='text' id='txtprductnm_code' readonly style="width:100%;">
										</td>
										<th>Pre-Approval IP Name 1</th>
										<td>
											<input type='text' id='txtconfm_bfe_ip_nm_mullang_code1' readonly style="width:100%;">
										</td>
									</tr>
									<tr>
										<th>Pre-Approval IP Name 2</th>
										<td>
											<input type='text' id='txtconfm_bfe_ip_nm_mullang_code2' readonly style="width:100%;">
										</td>
										<th>Pre-Approval IP Name 3</th>
										<td>
											<input type='text' id='txtconfm_bfe_ip_nm_mullang_code3' readonly style="width:100%;">
										</td>
									</tr>
									</tbody>
								</table>

								<div style="height:20px;"></div>
								
								<div style="font-family:'NanumGothicBold'; display:inline-block; ">
									<h7>Non-Clinical</h7>
								</div>
								
								<div style="height:5px;"></div>


								<table class="tb001" id ="inputTable">
									<colgroup>
										<col width="15%" />
										<col width="" />
									</colgroup>																		
									<tbody>
									<tr>
										<th>Non-Clinical<span class="must_01"></span></th>
										<td>
											<form id="filetForm" action="<c:url value='/sdb/b01/insertDmFileMstr.d'/>" method="post" enctype="multipart/form-data">
											<input type="file" name="file_1"  id="egovComFileUploader" size="60" title="첨부파일" />
											<p>
												<div id="egovComFileList"></div>
											</p>
											</form>
										</td>
									</tr>
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