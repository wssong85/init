<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    

<style>
.pop_style .aui-grid-default-header { text-align: center;}

</style>

<script>

var EDCK0303_grid = {
  id: '',
  failCount: 0,
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#EDCK0303_grid',
  },
  //데이터 연계 옵션
  proxy: {
 		param: {},
 		type: 'post',
 		dataType: 'json',
 		paging: false,
 		autoLoad: false
 	},
  //AUI 그리드 옵션
  	gridPros: {
    // 페이징 사용
    usePaging : false,
    showRowNumColumn : true,
    showRowCheckColumn : false,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : false,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 5,
    headerHeight: 60,
    rowHeight: 37,
    selectionMode : "multipleRows",
    displayTreeOpen : true,
    
  },
		    
  //AUI 그리드 레이아웃
  columnLayout : [{
	    dataField : "STATUS",
	    headerText : "Status",
	    filter : {
	    	showIcon : true
	    }
	  },{
	    dataField : "LaboratoryName", 
	    headerText : "Laboratory Name",
	    filter : {
	    	showIcon : true
	    },
	    width : 150
	  },{
	    dataField : "AnalysisParameter", 
	    headerText : "Analysis <br> Parameter",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "Unit",
	    headerText : "Unit",
	    filter : {
	    	showIcon : true
	    },
	    width : 80
	  },{
	    dataField : "ReferenceRangeLowerLimit", 
	    headerText : "ReferenceRange <br>LowerLimit",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "ReferenceRangeUpperLimit", 
	    headerText : "ReferenceRange <br>UpperLimit",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "AGE",
	    headerText : "연령",
	    filter : {
	    	showIcon : true
	    },
	    width : 80
	  },{
	    dataField : "SEXDSTN",
	    headerText : "성별",
	    filter : {
	    	showIcon : true
	    },
	    width : 80
	  },{
	    dataField : "APPLC_BGNDE", 
	    headerText : "적용시작일",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "APPLC_ENDDE", 
	    headerText : "적용종료일",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "INSTT_CODE", 
	    headerText : "INSTT_CODE",
	    visible : false
	  },{
	    dataField : "REASON",
	    headerText : "오류 사유",
	    filter : {
	    	showIcon : true
	    },
	    width : 220
	}],


//AUI 그리드 생성
  	createGrid: function() {
    var me = this;
    
    //이후 객체.id 로 AUIGrid 컨트롤
    me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
   // me.binding();
    
    if(me.proxy.autoLoad) {
      me.load();
    }
  },
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		fn_load(me, v1, v2);
	}
};


window.onresize = function() {
 if (typeof EDCK0303_grid.id !== "undefined") {
	 AUIGrid.resize(EDCK0303_grid.id);
   }
};


$(function(){
	
	EDCK0303_grid.createGrid();
	$("#btnClose").click(function(){ 				
		layerClose();
	});
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});
	
	//기관조회버튼 클릭
 	$("#btnInttNm").click(function(){
	 		var param={  };
			mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
 	});
	
	$("#btnSave").click(function() {
		if(EDCK0303_grid.failCount) {
			alert('<spring:message code="comc02.msg.2"/>');
			return;
		}
		
		var arrData = AUIGrid.getGridData(EDCK0303_grid.id);

		if(!arrData.length) {
			alert('<spring:message code="message.null.1"/>');
			return;
		}
		
		if(!confirm('<spring:message code="message.save.1"/>')) {
			return;
		}
		
		$.ajax({
			url : "<c:url value='/edc/k03/insertLabData.do'/>",
			type: 'post',
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(arrData),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					alert('<spring:message code="message.save.2"/>');
					$("#btnClose").trigger('click');
					EDCK0301_grid.load();
				} else {
					alert(data.message);
				}
			}, 
			error : function(jqXHR, textStatus, errorThrown){
				alert(textStatus);
			}
		});
	});
	
	$("#submitUpload").click(function() {
		
		var formData = new FormData();
		formData.append('INSTT_CODE', $("#INSTT_CODE").val());
		
		if($("#txtInputInttNm").val() == null || $("#txtInputInttNm").val() == ""){
			alert("기관을 선택하세요.");
			return;
		}
		
		if($("#fileName").val() == null || $("#fileName").val() == ""){
			alert("파일을 선택하세요.");
			return;
		} 
		
		var formTag = $('#ajaxForm').children().children();
		
		for(var i = 0; i < formTag.length; i++) {
			formData.append(formTag[i].name, formTag[i].value);
			
			if(formTag[i].type == 'file') {
				formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
			}
		}
		
		$.ajax({
			url : './selectLabListByExcel.do',
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(response) {
				var data = '';
				
				try {
					data = JSON.parse(response);	
				} catch(e) {
					data = response;
				}
				
				if(data.success) {
					if(data.count) {
						$('#h6Validation').text('VALIDATION : FAIL (' + data.count + ')');
						EDCK0303_grid.failCount = data.count;
					} else {
						$('#h6Validation').text('VALIDATION : SUCCESS');
						EDCK0303_grid.failCount = data.count;
					}
					AUIGrid.setGridData(EDCK0303_grid.id, data.result);
				} else {
					alert(data.message);
				}
			},
			error: function(){
				alert("file upload error!!");
			}
		});
	});
	

});

function fn_setInstt(){
	//returnValue.INSTT_CODE;	
	$("#txtInputInttNm").val(returnValue.INSTT_NAME);
	$("#INSTT_CODE").val(returnValue.INSTT_CODE);
	
}

</script>

<section class="popupWrap">
	<div class="popup wd960">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>Lab 정상범위 업로드</h5>
			<article class="mgT5">
			
				<table class="tb001">
					<colgroup>
						<col width="20%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>기관명<span class="must_01"></span></th>
                            <td>
                            	<input type="hidden" id="INSTT_CODE" disabled>
                                <input type="text" id="txtInputInttNm" disabled> <input type="button" id="btnInttNm" value="조회" >
                            </td>
                        </tr>
                        <tr>
							<th>업로드파일<span class="must_01"></span></th>
							<td>
								<form id="ajaxForm" action="<c:url value='/edc/d01/selectQueryListByExcel.do'/>" method="post" enctype="multipart/form-data">		
				 				<div class="fileInputArea" style="width:86%;">
					 				<input type="text" id="fileName" readonly="readonly" style="width:81%;">
					 				<input type="button" value="파일" class="fileInputBtn" />
					 				<input type="file" name="file_1" class="fileIuputHid" style="width:100%;">
				 				</div>
								<input type="button" id="submitUpload" value=<spring:message code="btn.upload" />>
								</form>
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			
			<h6 id="h6Validation" class="mgT10"></h6>
			<article class="mgT5 pop_style">
				<div id="EDCK0303_grid" class="gridHeiSz07 grid_wrap tb01_2"></div>
			</article>
			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="btnSave" class="btn mgL3" value="저장">
                    <input type="button" class="btn mgL3" id="btnClose" value="닫기">
				</div>
			</article>
		</div>
		</section>
	</div>
</section>

</html>