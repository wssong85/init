<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    

<style>
.pop_style .aui-grid-default-header { text-align: center;}

</style>

<script>

var EDCD0105_grid = {
  id: '',
  failCount: 0,
  //AUI그리드 생성할 div 및 페이징 옵션
  div: {
    gridDiv: '#EDCD0105_grid',
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
    showRowCheckColumn : true,
    enableColumnResize : true,
    enableMovingColumn : false,
    editable : false,
    enableFilter : true,

    // 한 화면 페이징 버턴 개수 5개로 지정
    showPageButtonCount : 5,
    headerHeight: 40,
    rowHeight: 37,
    selectionMode : "multipleRows",
    displayTreeOpen : true,
    
  },
		    
  //AUI 그리드 레이아웃
  columnLayout : [{
	headerText : "업로드 파일 자료",
	children:[{
	    dataField : "STATUS",
	    headerText : "Status",
	    filter : {
	    	showIcon : true
	    }
	  },{
	    dataField : "Site", 
	    headerText : "Site",
	    filter : {
	    	showIcon : true
	    },
	    width : 150
	  },{
	    dataField : "Subject", 
	    headerText : "Subject",
	    visible : false
	  },{
	    dataField : "Visit",
	    headerText : "Visit",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "CRF",
	    headerText : "CRF",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "Variable",
	    headerText : "Variable",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "Query", 
	    headerText : "Query",
	    filter : {
	    	showIcon : true
	    },
	    width : 200
	  },{
	    dataField : "Role", 
	    headerText : "Role",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "Issue", 
	    headerText : "Issue",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	  },{
	    dataField : "SetVriablSn", 
	    headerText : "SetVriablSn",
	    filter : {
	    	showIcon : true
	    },
	    visible : false
	  },{
	    dataField : "VisitGroupSn", 
	    headerText : "VisitGroupSn",
	    filter : {
	    	showIcon : true
	    },
	    visible : false
	  },{
	    dataField : "Sn", 
	    headerText : "Sn",
	    filter : {
	    	showIcon : true
	    },
	    visible : false
	  },{
	    dataField : "insttFormSn", 
	    headerText : "insttFormSn",
	    filter : {
	    	showIcon : true
	    },
	    visible : false
	  },{
	    dataField : "visitSn", 
	    headerText : "visitSn",
	    filter : {
	    	showIcon : true
	    },
	    visible : false
	  },{
	    dataField : "setRowSn", 
	    headerText : "setRowSn",
	    filter : {
	    	showIcon : true
	    },
	    visible : false
	  },{
	    dataField : "vriablRowSn", 
	    headerText : "vriablRowSn",
	    filter : {
	    	showIcon : true
	    } ,
	     visible : false
	  }
	  ]
},{
	headerText : "적용자료",
	children : [{
	    dataField : "Query",
	    headerText : "Query",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	},{
	    dataField : "Role",
	    headerText : "Role",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	},{
	    dataField : "Issue",
	    headerText : "Issue",
	    filter : {
	    	showIcon : true
	    },
	    width : 120
	},{
	    dataField : "REASON",
	    headerText : "오류 사유",
	    filter : {
	    	showIcon : true
	    },
	    width : 220
	}]
	
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
 if (typeof EDCD0105_grid.id !== "undefined") {
	 AUIGrid.resize(EDCD0105_grid.id);
   }
};


$(function(){
	
	EDCD0105_grid.createGrid();
	$("#btnClose").click(function(){ 				
		layerClose();
	});
	
	$(".fileIuputHid").change(function(){
	   var fileVal = $(this).val();
	   $(this).parent(".fileInputArea").children("#fileName").val(fileVal)
	});
	
	$("#btnSave").click(function() {
		if(EDCD0105_grid.failCount) {
			alert('<spring:message code="comc02.msg.2"/>');
			return;
		}
		
		var arrData = AUIGrid.getGridData(EDCD0105_grid.id);

		$.ajax({
			url : "<c:url value='/edc/d01/insertCfQuery.do'/>",
			type: 'post',
			contentType: "application/json; charset=UTF-8",
			data : JSON.stringify(arrData),
			success : function(data, textStatus, jqXHR) {
				if(data.success) {
					alert("저장 완료");
					$("#btnClose").trigger('click');
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
		var formTag = $('#ajaxForm').children().children();
		
		for(var i = 0; i < formTag.length; i++) {
			formData.append(formTag[i].name, formTag[i].value);
			
			if(formTag[i].type == 'file') {
				formData.append(formTag[i].name, $('input[name='+formTag[i].name+']')[0].files[0]);
			}
		}
		
		$.ajax({
			url : './selectQueryListByExcel.do',
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
						console.log(data);
						$('#h6Validation').text('VALIDATION : FAIL (' + data.count + ')');
						EDCD0105_grid.failCount = data.count;
					} else {
						console.log(data);
						$('#h6Validation').text('VALIDATION : SUCCESS');
						EDCD0105_grid.failCount = data.count;
					}
					AUIGrid.setGridData(EDCD0105_grid.id, data.result);
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

</script>

<section class="popupWrap">
	<div class="popup wd960">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>쿼리 업로드</h5>
			<article class="mgT5">
				<table class="tb001">
					<colgroup>
						<col width="20%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>업로드파일</th>
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
				<div id="EDCD0105_grid" class="gridHeiSz07 grid_wrap tb01_2"></div>
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