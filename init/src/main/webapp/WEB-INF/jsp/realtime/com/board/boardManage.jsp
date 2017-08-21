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
			url    : _contextPath + "/com/board/selectTbBoardList.do",
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
				grTbBoardManage.getSelectionRowIndex = this.doindex ;
				grTbBoardManage.getSelectionItem = this.item ;
				grTbBoardManage.focus(this.doindex);
				grTbBoardManage.load({
					"" : this.item[""]
				});
			},
			onDBLClick: function(){
				
			},
			onDataChanged: function(){
				
				grTbBoardManage.getSElectionRowIndex = this.doindex;
				grTbBoardManage.getSelectionItem = this.item ;
				
				if(!grTbBoardManage.getSeletionItem["CRUD"]){
					grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"CRUD": "U"}), grTbBoardManage.getSeletionRowIndex);
				}
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
			key:'BOARD_TB_NM',
			label: '게시판테이블이름',
			align:'center',
			width: 200,
			enableFilter: true,
			editor: {
				type:'text'
			}
		},{
			key:'COMMENT_TB_NM',
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
			key:'USE_AT',
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
		},{
			key:'WRITE_ID',
			label: '등록수정자',
			align:'center',
			width: 200,
			enableFilter: true
		}]
	});
	
	
	
	$('[data-grid-controll]').click(function(){
		switch(this.getAttribute("data-grid-control")) {
			case "btnAddTbBoard" :
				var vAddItem = {
					"CRUD"             : "C",
					"BOARD_MANAGE_SEQ" : "",
					"PROGRAM_ID"       : "",
					"BOARD_TB_NM"      : "",//TB_BOARD_NM 으로 바꿔야 한다. ㅇㅋ
					"COMMENT_TB_NM"    : "",
					"BOARD_NM"         : "",
					"USE_YN"           : "Y"
				};
				
				grTbBoardManage.addRow($.extend({}, vAddItem, {__index: undefiend}));
			break ;
			case "btnRemoveTbBoard" :
				grTbBoardManage.updateRow($.extend({}, grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex], {"CRUD": "D"}), grTbBoardManage.getSelectionRowIndex);
				grTbBoardManage.list[grTbBoardManage.getSelectionRowIndex]["__modified__"] = true;
			
			break ;
		}
	});
	
	$("#btnSelectTbBoard").click(function(){
		grTbBoardManage.load();
	});
	
	$("#btnMultiSaveTbBoard").click(function(){
		var vValidateJson = {
			"PROGRAM_ID" : "프로그램 ID는 필수 입력해해주십시오."//validation 체크는 필수값 넣고
		};
    	
    	fn_GridMultiSaveForValidateArray(
    		grTbBoardManage
			,"/com/board/multiTbBoard.do"
			,vValidateJson
			,[]
		);
	});
	
	
	$("#btnSelectTbBoard").trigger("click");
	
});
</script>

<html>
<body>
	<div style="padding:10px;">
		<button class="btn btn-default" id="btnSelectTbBoard"   >조회</button>
		<button class="btn btn-default" id="btnAddTbBoard"      >행추가</button>
		<button class="btn btn-default" id="btnRemoveTbBoard"   >행삭제</button>
		<button class="btn btn-default" id="btnMultiSaveTbBoard">저장</button>
	</div>
	
	<div data-ax5grid="grTbBoardManage" data-ax5grid-config="{}" style="width:800px; height:300px;"></div>

</body>
</html>