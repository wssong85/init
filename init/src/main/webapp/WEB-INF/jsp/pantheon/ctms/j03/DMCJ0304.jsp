<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edc Protocol 검색</title>
<meta charset="utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<script type="text/javascript">
	var grEducation = {
		//그리드 id로 AUI그리드 전용 메소드 사용 시 이용 ex) AUIGrid.selectedItem(grEducation.id);
		id : 'grEducation',
		//AUI그리드 생성할 div 및 페이징 옵션
		div : {
			gridDiv : '#grEducation'
		},
		//데이터 연계 옵션
		proxy : {
			url: '/ctms/j03/selectEducationList.do',
			param : {GUBUN : eduType},
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
			width: 300,
			headerHeight : 40,				
			rowHeight : 37			
		},
		//AUI 그리드 레이아웃
		columnLayout : [ {
			dataField : "COL_NM",
			headerText : "모듈",
			width: 100,
		}, {
			dataField : "VER",
			headerText : "Ver",
			width: 40,
		}, {
			dataField : "INSTT_NM",
			headerText : "소속"
		}, {
			dataField : "USER_NM",
			headerText : "사용자"
		}, {
			dataField : "COMPLETE_NM",
			headerText : "수료여부"
		}, {
			dataField : "USER_SE_CODE",
			headerText : "사용자구분"
		}, {
			dataField : "LAST_UPDT_DE",
			headerText : "수료일"
		}],
		//AUI 그리드 생성
		createGrid : function() {
			var me = this;

			//이후 객체.id 로 AUIGrid 컨트롤
			me.id = AUIGrid.create(me.div.gridDiv, me.columnLayout, me.gridPros);
		    
		    
		    window.setTimeout(function(){
		    	AUIGrid.resize(grEducation.id);
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

	 		AUIGrid.showAjaxLoader(me.id);

	 		$.ajax({
	 		    url: me.proxy.url,
	 		    type: me.proxy.type,
	 		    dataType: me.proxy.dataType,
	 		    data: me.proxy.param,
	 		    success:function(data){
	 		    	if(data.success) {
	 			    	AUIGrid.removeAjaxLoader(me.id);
	 			    	AUIGrid.setGridData(me.id, data.eduList);
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
		} // load
	};

	$(function(){

		grEducation.createGrid();
		if(eduType == "TASK"){
			AUIGrid.setColumnProp( grEducation.id, 0, { headerText : "과제명", width : 100 } );
		}
		else{
			AUIGrid.setColumnProp( grEducation.id, 0, { headerText : "모듈명", width : 100 } );
		}

		$("#btnEduClose").click(function() {

			if(eduType == "SYSTEM"){
				//switch 차후 변경.
				switch(callModule){
				case "EDC" : //과제정보
					g_edc  = "Y";
					break;
				case "CTMS" : //기관정보
					g_ctms = "Y";
					break;
				case "SDB" : //기관정보
					g_sdb  = "Y";
					break;
				case "COM" : //기관정보
					g_com  = "Y";
					break;
				case "IWRS" : //기관정보
					g_iwrs = "Y";
					break;
				case "DMC" : //기관정보
					g_dmc  = "Y";
					break;
				
				default :
				} //switch
			}
			else{
				fn_eduResult();
			}

			layerClose();
		});
	});
	
	$(window).resize(function() {
		if(grEducation.id) {
			AUIGrid.resize(grEducation.id);
		}
	});
	
</script>
</head>
<body>



	<section class="popupWrap">
		<div class="popup wd700">
			<section class="conBox100 popup_conBox" style="margin:0px;">
			<div class="popup_conBoxInner">
				<h6></h6>
				<article class="mgT5">
					<div id="grEducation" class="gridHeiSz10 grid_wrap tb01_2"></div>
				</article>
				<article class="mgT20">
					<div style="text-align:center">
						<input type="button" id="btnEduClose" value="닫기">
					</div>
				</article>
			</div>
			</section>
		</div>
	</section>



</body>
</html>