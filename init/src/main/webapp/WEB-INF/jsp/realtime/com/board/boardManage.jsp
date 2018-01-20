<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/common/common.do" flush="false"/>
<title>게시판관리</title>

<script type="text/javascript">

var grTbBoardManage = null ;

$(function(){
	
	grTbBoardManage = new ax5.ui.grid();
	grTbBoardManage.getSelectionRowIndex = 0 ;
	grTbBoardManage.selectionItems = 0 ;
	
	grTbBoardManage.load = function(){
		$.ajax({
			url    : _contextPath + "/com/board/selectTbBoardManageList.do",
			type   : 'post',
			success: function(data){
				if(data.success){
					
					grTbBoardManage.setData(data.result);
					
				} else {
					
					alert(data.message);
					
				}
			},
			error : function(jqXHR, testStatus, errorThrown){
				
				alert(textStatus);
				
			}
			
		});
	};
	
	grTbBoardManage.setConfig({
		target: $('[data-ax5grid="grTbBoardManage"]'),
		header: {align:'center'},
		showLineNumber: false,
		body:{
			onClick: function(){
				
				grTbBoardManage.getSelectionRowIndex = this.doindex;
				grTbBoardManage.getSelectionItem = this.item;
				
				grTbBoardManage.focus(this.doindex);
// 				grTbBoardManage.load();
				
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbBoardManage.getSelectionRowIndex = this.doindex;
				grTbBoardManage.getSelectionItem = this.item;
				
				if(!grTbBoardManage.getSelectionItem["CRUD"]){
					grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"CRUD": "U"}), grTbBoardManage.getSeletionRowIndex);
				}
				
				/*
				if(this.value && this.key == "BOARD_MANAGE_SEQ") {
					grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"BOARD_MANAGE_SEQ": this.value}), grTbBoardManage.getSelectionRowIndex);
				}
				
				if(this.key == "BOARD_MANAGE_SEQ") {
					
					//길이체크
					if(_vGrValidation.lengthCheck(this.value, 3)
							//영문자숫자체크
							&& _vGrValidation.engNumcheck(this.value)
							//중복체크
							&& _vGrValidation.pkCheck(grTbBoardManage, "BOARD_MANAGE_SEQ")){
						
						grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"BOARD_MANAGE_SEQ": this.value}), grTbBoardManage.getSelectionRowIndex);
						
					} else {
						
						grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"BOARD_MANAGE_SEQ": ""}), grTbBoardManage.getSelectionRowIndex);
						
					}
					
				} else if(this.key == "CD_DC") {
					
					if(!_vGrValidation.lengthCheck(this.value, 200)) {
						grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"CD_DC": ""}), grTbBoardManage.getSelectionRowIndex);
					} 
					
				}
				*/
			}
		},
		columns: [{
			key: "",
			lable:"",
			align: "center",
			width: 50,
			enableFilter: true,
			styleClass: function(){
				if(this.item.CRUD == 'C'){
					return 'grid-cell-green';
				} else if(this.item.CRUD == 'U'){
					return  'grid-cell-blue';
				} else if(this.item.CRUD == 'D'){
					return 'grid-cell-red';
				}
			}
		},{
			key: 'CRUD',
			lebel: '',
			align:'center',
			width: 0,
			enableFilter: true,
			hidden: true,
		},{
			key:'BOARD_MANAGE_SEQ',
			label: '게시판관리번호',
			align:'center',
			width: 200,
			enableFilter: true
		},{
			key:'PROGRAM_ID',
			label: '프로그램아이디',
			align:'center',
			width: 200,
			enableFilter: true
		},{
			key:'TB_BOARD_NM',
			label: '게시판테이블이름',
			align:'center',
			width: 200,
			enableFilter: true,
			editor: {
				type:'text'
			}
		},{
			key:'TB_COMMENT_NM',
			label: '댓글테이블이름',
			align:'center',
			width: 200,
			enableFilter: true,
			editor: {
				type:'text'
			}
		},{
			key:'BOARD_NM',
			label: '게시판이름',
			align:'center',
			width: 200,
			enableFilter: true,
			editor: {
				type:'text'
			}
		},{
			key:'USE_YN',
			label: '사용여부',
			align:'center',
			width: 200,
			enableFilter: true,
			editor: {
				type: 'checkbox',
				config: {
					height: 17,
					trueValue : 'Y',
					falseValue: 'N'
				}
			}
		},{
			key:'UP_DT',
			label: '수정일',
			align:'center',
			width: 200,
			enableFilter: true
		}]
	});
	
	
	
	$('[data-grid-control]').click(function(){
		switch(this.getAttribute("data-grid-control")) {
			case "btnAddTbBoardManage" :
				
				var vAddItem = {
					"CRUD"             : "C",
					"BOARD_MANAGE_SEQ" : "",
					"PROGRAM_ID"       : "",
					"TB_BOARD_NM"      : "",
					"TB_COMMENT_NM"    : "",
					"BOARD_NM"         : "",
					"USE_YN"           : "Y"
				};
				
				grTbBoardManage.addRow($.extend({}, vAddItem, {__index: undefined}));
				
				break ;
			
			case "btnRemoveTbBoardManage" :
				
				grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"CRUD": "D"}), grTbBoardManage.getSelectionRowIndex);
				grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex]["__modified__"] = true;
				break ;
				
		}
	});
	
	$("#btnSelectTbBoardManage").click(function(){
		grTbBoardManage.load();
	});
	
	$("#btnMultiSaveTbBoardManage").click(function(){
		var vValidateJson = {
			"TB_BOARD_NM" : "프로그램 ID는 필수 입력해해주십시오."//validation 체크는 필수값 넣고
		};
    	
    	fn_GridMultiSaveForValidateArray(
    		grTbBoardManage
			,"/com/board/multiTbBoardManage.do"
			,vValidateJson
			,[]
		);
	});
	
	$("#btnSelectTbBoardManage").trigger("click");
	
});
</script>

<html>
<body>
	
<div id="wrapper">
	<c:import url="/common/leftMenu.do" charEncoding="utf-8"/>
	
	<div id="page-content-wrapper">
        <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas">
       		<span class="hamb-top"></span>
           	<span class="hamb-middle"></span>
           	<span class="hamb-bottom"></span>
         </button>
	
		<div class="container">
		<div class="row">
		<div class="col-lg-8 col-lg-offset-2">
		
		<!-- conetent 시작-->
		<div style="padding:10px;">
			<button class="btn btn-default" id="btnSelectTbBoardManage">조회</button>
			<button class="btn btn-default" data-grid-control="btnAddTbBoardManage">행추가</button>
			<button class="btn btn-default" data-grid-control="btnRemoveTbBoardManage">행삭제</button>
			<button class="btn btn-default" id="btnMultiSaveTbBoardManage">저장</button>
		</div>
		
		<div data-ax5grid="grTbBoardManage" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>
		<!-- conetent 끝-->	
			
		</div>
		</div>
		</div>
	</div>
</div>
	
	

</body>
</html>