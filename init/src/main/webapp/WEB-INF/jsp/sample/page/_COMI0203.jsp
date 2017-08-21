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
						<h4>비밀번호 변경</h4>
						


	                        <div style="margin-top: 10px;">
								<table class="tb001">
									<colgroup>
										<col width="20%" />
										<col width="" />
									</colgroup>
									<tbody>
										<tr>
											<th>새 패스워드</th>
											<td>
												<input type="password" style="width:70%;">
											</td>
										</tr>
										<tr>
											<th>새 패스워드 확인</th>
											<td>
												<input type="password" style="width:70%;">
											</td>
										</tr>
									</tbody>
								</table>
								<div class="agree_btn_01">
									<input type="button" class="big_button_01"  value="비밀번호 변경">
								</div>
	                        </div>



						
						
                	</div>
                </div>


      

                
                
                
                
            </section>
		</div>
	</section>
</div>
</html>