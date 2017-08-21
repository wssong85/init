<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var grEdcRole = {
	//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grEdcRole.id);
	id : 'grEdcRole',
	//AUI그리드 생성할 div 및 페이징 옵션
	div : {
		gridDiv : '#grEdcRole'
	},
	//데이터 연계 옵션
	proxy : {
		url: '/ctms/j03/selectEduRoleList.do',
		param : {},
		type : 'post',
		dataType : 'json',
		//페이징 true, false 로 지정
		paging : false,
		//처음 시작시 데이터 로딩
		autoLoad : true
	},
	//AUI 그리드 옵션
	gridPros : {
		'selectionMode' : 'singleRow',
		'editable' : false,
		//usePaging : true,
		enableFilter : true,
		pageRowCount : 10,
		showPageButtonCount : 10,
		headerHeight : 40,				
		rowHeight : 37			},
	//AUI 그리드 레이아웃
	columnLayout : [ {
		dataField : "ROLE_YN",
		headerText : " ",
		width: 40,
		renderer : {
			type : "CheckBoxEditRenderer",
			showLabel : false, // 참, 거짓 텍스트 출력여부( 기본값 false )
			editable : true, // 체크박스 편집 활성화 여부(기본값 : false)
				checkValue : "Y", // true, false 인 경우가 기본
				unCheckValue : "N"
		}
	}, {
		dataField : "ROLE_ID",
		headerText : "ROLE ID",
		editable : false,
		minWidth : 100
		, visible : false
	}, {
		dataField : "ROLE_NM",
		headerText : "ROLE 명",
		editable : false
	}],
	//AUI 그리드 생성
	createGrid : function() {
		var me = this;

		//이후 객체.id 로 AUIGrid 컨트롤
		me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		
	    window.setTimeout(function(){
	    	AUIGrid.resize(grEdcRole.id);
	    }, 0.5);
		
		me.binding();

		if (me.proxy.autoLoad) {
			me.load();
		}
	},
	//AUI 그리드 이벤트 
	binding : function() {
		var me = this;

	},
	//AUI 그리드 데이터 요청
	load : function(v1, v2) {
		var me = this;
		AUIGrid.setGridData(me.id, g_roleList);
    	AUIGrid.setSelectionByIndex(me.id, 0);
	}
};

$(function(){
	grEdcRole.createGrid();
	
	if (typeof s_roleList !== "undefined") {
		if(s_roleList.length > 0){
			console.log("s_roleList.length : "+s_roleList.length);
			var data = AUIGrid.getGridData(grEdcRole.id);
			for(s=0; s_roleList.length > s; s++){
				for(i=0; data.length>i; i++){
					if(s_roleList[s].ROLE_ID == data[i].ROLE_ID){
						var userData = { ROLE_YN : 'Y' };
						AUIGrid.updateRow(grEdcRole.id, userData, i);
					}
				} // for
			} // for
		} // if
	} // if

	$("#btnApply").click(function(){
		var data = AUIGrid.getGridData(grEdcRole.id);
		var roleNm = "";
		s_roleList = [];
		for(i=0; data.length > i; i++){
			if( data[i].ROLE_YN == "Y" ){
				s_roleList.push(data[i]);
				roleNm += data[i].ROLE_NM + ",";
			}
		}

		if(roleNm.length > 0){
			roleNm = roleNm.substring(0, roleNm.length-1);
		}
		$("#txtRoleNm").val(roleNm);
		layerClose(2);
	});

	$("#btnClose").click(function(){
		layerClose(2);
	});
});

$(window).resize(function() {
	if(grEdcRole.id) {
		AUIGrid.resize(grEdcRole.id);
	}
});



</script>



<section class="popupWrap">
	<div class="popup popup2 wd400">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h6>역할 선택</h6>
			<article class="mgT5">
				<div id="grEdcRole" class="gridHeiSz10 grid_wrap tb01_2"></div>
			</article>
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="btnApply" value="적용" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>



