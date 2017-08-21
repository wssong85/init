<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/com/common.do" flush="false"/>

<title>전자계약</title>

<style>
#mainCon{ padding:0;}
.conBoxInner{min-height:840px; }
.join_01{ width:1000px; margin:0 auto;}

</style>

<script>
$(document).ready(function(){

	$("#id_search").click(function (){
	 	$(".id_result_01").show();
	});

	$("#pwd_search").click(function (){
	 	$(".pwd_result_01").show();
	});

});
</script>

</head>
<body>



<div id="wrap">
	<header id="topHeader">
		<a href="/com/i01/intro.do"><img id="logo" src="/images/pantheon/common/logo.png" alt=""></a>
	</header>


	<section id="mainCon">
		<div class="mainConInner">
            <section class="conBox100 conBox">
            
 
             
                <div class="conBoxInner">
                	<div class="join_01">
						<h4>아이디/비밀번호 찾기</h4>
						
	                    <div id="tab" class="tab tab01" style="margin-top: 20px;">
	                        <ul>
	                            <li id="tab_menu1" class="port_back tab_menu">아이디 찾기</li>
	                            <li id="tab_menu2" class="tab_menu">비밀번호 찾기</li>
	                        </ul>
	                    </div>




						<article class="tab_list">
	                        <div class="tab_sub1 tab_sub">
	                        
	                        
	                        
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>이름</th>
											<td>
												<input type="text" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>
												<input type="text" style="width:20%;">
												@
												<select id="" style="width:20%;">
													<option>===직접입력===</option>
													<option value="">naver.com</option>
												</select>
												<input type="text" style="width:30%;">
											</td>
										</tr>
									</tbody>
								</table>
								<div class="agree_btn_01">
									<input type="button" class="big_button_01" id="id_search" value="아이디 찾기">
								</div>
								
								
								<div class="id_result_01">
									<span>전자계약연구자</span>님의 아이디는 <br><strong>sbkim88</strong>입니다.
								</div>
								
								
	                        </div>
	                        <div class="tab_sub2 tab_sub">
	                        
	                        
	                        
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>아이디</th>
											<td>
												<input type="text" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>이름</th>
											<td>
												<input type="text" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>이메일</th>
											<td>
												<input type="text" style="width:20%;">
												@
												<select id="" style="width:20%;">
													<option>===직접입력===</option>
													<option value="">naver.com</option>
												</select>
												<input type="text" style="width:30%;">
											</td>
										</tr>
									</tbody>
								</table>
								<div style="margin-top: 6px; font-size: 11px;">※ 전자계약연구자가입시 등록한 이메일로 임시비밀번호가 발송됩니다</div>
								<div class="agree_btn_01">
									<input type="button" class="big_button_01" id="pwd_search" value="비밀번호 찾기">
								</div>
								
								
								<div class="pwd_result_01">
									<strong>임시비밀번호</strong>가 발송되었습니다.
								</div>
	                        </div>
	                    </article>

						
						
                	</div>
                </div>


      

                
                
                
                
            </section>
		</div>
	</section>
</div>
</html>