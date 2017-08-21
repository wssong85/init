<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>

<script type="text/javascript">

// popup 결과
var returnValue;

//기관 조회 popup
var p_instt_name; //기관명  like 검색
function fn_searchInstt(){
	p_instt_name = $("#insttNm").val();
	var param = {};
	mkLayerPopupOpen("/ctms/j11/popupDMCJ1103.do", param, 2);
}

function fn_setInstt(){
	$("#insttNo").val(returnValue.INSTT_CODE);
	$("#insttNm").val(returnValue.INSTT_NAME);
}

/************************************************************************************/
var p_task_no = "";       //과제번호로  사용자 like 검색
var p_user_nm;            //사용자명  like 검색
var p_cntrct_sttus = "Y"; //기관&연구자 승인건만 조회 "Y", N:모두검색
var p_user_type    = "";  //CM_USER 테이블만 사용 사용자 조회 : 외부사용자 N, 내부사용자 Y  <=== 무조건 ""이 아닐 경우 순수 유저 조회. 
function fn_searchTaskUser(){
	p_task_no = $("#taskNo").val();
	p_user_nm = $("#userNm").val();
	var param = {};
	mkLayerPopupOpen("/ctms/j11/DMCJ1104.do", param);
}

function fn_setUserInfo(){
	
}

var r_user_id;
var r_user_nm;
function fn_setUserInfo(){
	//if p_user_type.length == 0
	$("#taskNo" ).val(returnValue.TASK_NO   );
	$("#insttNo").val(returnValue.INSTT_CODE);
	$("#insttNm").val(returnValue.INSTT_NAME);
	$("#userId" ).val(returnValue.USER_ID   );
	$("#userNm" ).val(returnValue.USER_NM   );
	
	//if p_user_type.length > 0
// 	$("#userId").val(returnValue.USER_ID);
// 	$("#userNm").val(returnValue.USER_NM);
// 	$("#telno" ).val(returnValue.TELNO  );
// 	$("#email" ).val(returnValue.EMAIL  );
	
}

/************************************************************************************/
var p_seq_no; //순번 : 해당항목의 순번(연구자승인요청시 연구자승인 순번)
function fn_setReturn(){
	// 각 업무별 식별 가능한 업무구분코드 + 해당 업무의 유니크한 구분 번호. 예) 과제순번
	p_seq_no = "CT01"+"0000000001"; //업무별 구분자 + 해당업무 seq
	
	var param = {};
	mkLayerPopupOpen("/ctms/j11/popupDMCJ1102.do", param);
}

function fn_callback(){
	console.log("반려사유 저장 후 fn_callback.................");
}
/************************************************************************************/

var returnTaskValue;
function fn_taskSearch(){
	var param = {};
	mkLayerPopupOpen("/ctms/j11/popupDMCJ1106.do", param, 2);
}

function fn_setTaskNo(){
	console.log("returnTaskValue.TASK_SN : "+returnTaskValue.TASK_SN);
// 	returnTaskValue.TASK_SN
// 	returnTaskValue.TASK_NO
}

/***************************************************************************************/
// function fn_RolrSearch(){
// 	var param = {};
// 	mkLayerPopupOpen("/ctms/j11/popupDMCJ1107.do", param, 1);
// }
</script>
</head>
<body>

<div id="wrap">
<form>
</form>
    <section id="mainCon">
        <div class="mainConInner">

            <article class="mainTitBox">
                <h3>Popup</h3>

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
                        <h5></h5>
                    </article>
                    <!-- 컨텐츠 타이틀 끝-->

                    <!-- 상단 그리드 전체메뉴라인 시작-->        
                    <article class="conGridUpper">

                        <!-- 상단 그리드 왼쪽 메뉴 시작 -->
                        <div class="conTitBtnL">
                        <!--검색 설정 숨겨진 부분 시작-->
                            <!-- ul class="disNn">
                                <li><input type="checkbox" id="direction" value="direction" checked="checked">
                                    <label for="direction">진행 방향 : forward(or backword)</label>
                                </li>
                                <li><input type="checkbox" id="caseSensitive" value="caseSensitive">
                                    <label for="caseSensitive">대소문자 구분(caseSensitive)</label>
                                </li>
                                <li><input type="checkbox" id="wholeWord" value="wholeWord">
                                    <label for="wholeWord">온전한 단어(wholeWord)</label>
                                </li>
                                <li><input type="checkbox" id="wrapSearch" value="wrapSearch" checked="checked">
                                    <label for="wrapSearch">끝에서 되돌리기(wrapSearch)</label>
                                </li>
                            </ul-->
                            <!--검색 설정 숨겨진 부분 끝-->
                             기관코드 : <input type="text" id="insttNo" name="insttNo" class="pdR15">&nbsp; 기관명 : <input type="text" id="insttNm" name="insttNm" class="pdR15"><input type="button" class="btn mgL3" onclick="fn_searchInstt()" value="검색">
            <p>
            <p>
             과제번호 : <input type="text" id="taskNo" name=""taskNo"" class="pdR15">&nbsp;&nbsp; 
             사용자ID : <input type="text" id="userId" name="userId" class="pdR15">
            사용자명 : <input type="text" id="userNm" name="userNm" class="pdR15"><input type="button" class="btn mgL3" onclick="fn_searchTaskUser()" value="검색">
            <input type="button" class="btn mgL3" onclick="fn_setReturn()" value="반려">
            <input type="button" class="btn mgL3" onclick="fn_taskSearch()" value="과제조회">
           
                        </div>
                        <!-- 상단 그리드 왼쪽  메뉴 끝 -->

                        <!-- 상단 그리드 오른쪽 메뉴 시작-->
                        <!-- div class="conTitBtnR">
                            <input type="button" onclick="addRow('first')" value="행추가">
                            <input type="button" onclick="removeRow('selectedIndex')" value="선택행 삭제">
                            <input type="button" value="저장">
                        </div-->
                        <!-- 상단 그리드 오른쪽 메뉴 끝-->

                    </article>
                    <!-- 상단 그리드 전체메뉴라인 끝-->        



                </div>

            </section>
            <!-- 컨텐츠박스 끝-->





        </div>
    </section>

</div>

<!-- 수정창 다이얼로그 -->
<div id="editWindow" style="display:none" title="상태변경">
    <fieldset>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="01">계약(후지금)<br>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="02">계약(선지금)<br>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="03">수락<br>
      <INPUT type="radio" name="rdo_status" id="rdo_status" value="04">거절<br>
             목표례수 : <input type="text" name="in_goalCo" id="in_goalCo" class="text"></input>

      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px"></input>
    </fieldset>
</div>
<!-- 수정창 다이얼로그 -->

</body>
</html>