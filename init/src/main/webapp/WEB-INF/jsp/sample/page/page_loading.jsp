<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- 상단 css, js 호출 -->
<jsp:include page="/com/common.do" flush="false" />
  <title>Study 등록/수정/삭제</title>
<script type="text/javascript">


</script>
</head>

<body>
	
	<div id="wrap">
		<!-- 헤더 호출 -->
		<c:import url="/com/topHeader.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
		<!-- 레프트 호출 -->
		<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0101&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
		<form id="iform">
		<input type="hidden" id="mode" value="C" />
		<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Source별 등록</h3>
				<nav id="pathNav">
					<ul>
						<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
						<li>유해정보등록</li>
						<li>Source별 등록</li>
					</ul>
				</nav>
			</article>
            <section class="conBox100 conBox">
				<div class="conBoxInner">
					<form id="iform">
					<input type="hidden" id="mode" value="C" />
					

						<div class="button_tab_01">
							<ul>
								<li id="tabTrial" class="port_back tab_menu">Study</li>
								<li id="tabSpontaneous" class="tab_menu">Spontaneous</li>
								<li id="tabLiterature" class="tab_menu">Literature</li>
								<li id="tabEtc" class="tab_menu">Etc</li>
								<li id="tabICSR" class="tab_menu">ICSR</li>
							</ul>
						</div>
						<!-- 상단 검색과 버튼 시작 -->
						<article>
							<div class="conTitBtnL">
								PRODUCT <span class="must_01"></span> : 
								<input type="text" id="txtProductCode" class="pdR15" popup_type="ProductSearch" valireqire="PRODUCT" style="width:300px;" readonly>
								<input type="hidden" id="hdProductCode" />
								<button class="oneBtn" popup_type="ProductSearch" type="sumit">
										<img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색">
								</button>
							</div>

							<div class="conTitBtnR">
								<input type="button" id="btnCase" value="CASE">
								<input type="button" id="btnInit" value="초기화">
								<input type="button" id="btnSave" value="저장">
								<input type="button" id="btnDel" value="삭제">
								<input type="button" id="btnAudit" value="A" title="Audit Trail">
								<input type="button" id="btnSaveDel2" value="로딩시 Test">
							</div>
						</article>
						<!-- 상단 검색과 버튼 끝 -->

						<!-- 테이블 시작 -->
						<article class="mgT44">
							<table class="tb001">
								<colgroup>
									<col width="12%" />
									<col width="25%" />
									<col width="12%" />
									<col width="19%" />
									<col width="12%" />
									<col width="" />
								</colgroup>
								<tbody>
									<tr>
										<th>Protocol Number <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtprtcl_no" popup_type="protocol" valireqire="Protocol Number" style="width:80%;" />
														<button class="oneBtn" popup_type="protocol" type="sumit"><img class="oneBtnIco" src="<c:url value='/images/pantheon/common/searchIco.png'/>" alt="검색"></button>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										<th>Protocol Title</th>
										<td colspan="3" style="padding-top:3px; padding-bottom:4px; height:42px;">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtprtcl_nm" tabindex="1" style="width:100%;"/>
													</th>
													<td>
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
														<input class="oneBtn" popup_type="E" type="button" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdprtcl_nm" />
											<label class="label_02" popup_type="Label" id="txtprtcl_nm_eng" style="margin-top:1px;"></label>
										</td>
									</tr>
									<tr>
										<th>Study Type <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slrsrch_knd_code" tabindex="2" valireqire="Study Type" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Clinical Trial Type</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slclinc_ty_code" tabindex="3" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Other Surveillance Specify</th>
										<td style="padding-top:4px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtrsrch_knd_etc_matter_memo" rows="1" style="width:100%;"  tabindex="4"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" popup_type="E" type="button" value="E" style="vertical-align: top;" />
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdrsrch_knd_etc_matter_memo" />
											<label class="label_02" popup_type="Label" id="txtrsrch_knd_etc_matter_memo_eng"></label>
										</td>
									</tr>
									<tr>
										<th>MFDS Protocol Approval <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slmfds_confm_at" tabindex="5" style="width:100%;" valireqire="MFDS Protocol Approva">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>MFDS Protocol Approval Date</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtmfds_confm_dte" tabindex="6" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>
										<th>Date of First Patient In</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtfrt_patnt_occrrncde" tabindex="7" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>										
									</tr>
									<tr>
										<th>Date of Last Patient Out</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtlast_patnt_occrrncde" tabindex="8" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>
										<th>Active Control <span class="must_01"></span></th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slrymslmdong_ctrl_at" tabindex="9" valireqire="Active Control" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Name of Company(of Active Control)</th>
										<td style="padding-top:4px;">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtrymslmdong_ctrl_cmpnynm" style="width:100%;"  tabindex="10"/> 
													</th>
													<td>
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
														<input class="oneBtn" popup_type="E" type="button" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdrymslmdong_ctrl_cmpnynm" />
											<label class="label_02" popup_type="Label" id="txtrymslmdong_ctrl_cmpnynm_eng"></label>
										</td>										
									</tr>
									<tr>
										<th>Brand Name (of Active Control)</th>
										<td style="padding-top:4px;">
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtrymslmdong_ctrl_prductnm" style="width:100%;" tabindex="11"/> 
													</th>
													<td>
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
														<input class="oneBtn" popup_type="E" type="button" value="E">
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdrymslmdong_ctrl_prductnm" />
											<label class="label_02" popup_type="Label" id="txtrymslmdong_ctrl_prductnmeng"></label>
										</td>
										<th>Active Control Data Transfer</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slrymslmdong_ctrl_data_trnsmis_a" tabindex="12" style="width:100%;">
															<option value="">====선택====</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>Date of Data Transfer</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtrymslmdong_ctrl_data_trnsmisde" tabindex="13" style="width:114px;" />
														</div> 
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>										
									</tr>
									<tr>
										<th>Date of Safety Data Lock</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<div class="dateBox">
															<input type="text" id="txtsafehelth_dta_lock_dte" tabindex="14" style="width:114px;" />
														</div>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q" style="position:relative; top:1px;">
													</td>
												</tr>
											</table>
										</td>
										<th>Safety Population</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<input type="text" id="txtsafe_popltn" tabindex="15" style="width:100%;" />
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>MedDRA</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slmeddra_ver" tabindex="16" style="width:100%;">
															<option value="">====선택====</option>
															<option value="12.0">12.0</option>
															<option value="15.0">15.0</option>
															<option value="15.1">15.1</option>
															<option value="16.0">16.0</option>
															<option value="16.1">16.1</option>
															<option value="17.0">17.0</option>
															<option value="17.1">17.1</option>
															<option value="18.0">18.0</option>
															<option value="18.1">18.1</option>
															<option value="19.0">19.0</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>										
									</tr>
									<tr>
										<th>KCD</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slkcm_ver" tabindex="17" style="width:100%;">
															<option value="">====선택====</option>
															<option value="6">6</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>WHOART</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slwhoart_ver" tabindex="18" style="width:100%;">
															<option value="">====선택====</option>
															<option value="092">092</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>
										<th>ATC</th>
										<td>
											<table class="in_table">
												<tr>
													<th>
														<select id="slatc_ver" tabindex="19" style="width:100%;">
															<option value="">====선택====</option>
															<option value="2012">2012</option>
															<option value="2013">2013</option>
															<option value="2014">2014</option>
															<option value="2015">2015</option>
															<option value="2016">2016</option>
														</select>
													</th>
													<td style="width: 32px;">
														<input class="oneBtn" popup_type="Q" type="button" value="Q">
													</td>
												</tr>
											</table>
										</td>										
									</tr>	
									<tr>
										<th>Other Information 1</th>
										<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtOtherInfo1" rows="2" style="width: 100%;" tabindex="20"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdOtherInfo1" />
											<label class="label_01" popup_type="Label" id="txtOtherInfo1_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Other Information 2</th>
										<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtOtherInfo2" rows="2" style="width: 100%;" tabindex="21"></textarea> 
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdOtherInfo2" /> 
											<label class="label_01" popup_type="Label" id="txtOtherInfo2_eng"></label>
										</td>
									</tr>
									<tr>
										<th>Other Information 3</th>
										<td colspan="5" style="padding-top:5px; padding-bottom: 2px;">
											<table class="in_table">
												<tr>
													<th>
														<textarea id="txtOtherInfo3" rows="2" style="width:100%;" tabindex="22"></textarea>
													</th>
													<td style="vertical-align: top;">
														<input class="oneBtn" type="button" popup_type="Q" value="Q" style="vertical-align: top;" />
														<input class="oneBtn" type="button" popup_type="E" value="E" style="vertical-align: top;" />
													</td>
												</tr>
											</table>
											<input type="hidden" id="hdOtherInfo3" />
											<label class="label_01" popup_type="Label" id="txtOtherInfo3_eng"></label>
											
											
										</td>
									</tr>						
								</tbody>
							</table>
						</article>
						
<style>

table.in_table{  width:100%; border: none;}
table.in_table th{  background: none; padding: 0px; border: none;}
table.in_table td{ padding: 0px; width:63px; text-align:right; border: none;}
table.in_table tr:last-child{ border: none;;}


.tb001 td .label_01{ font-size: 12px; line-height:18px; color:#333; display:block; padding:0px 2px 3px 8px; margin-top:-4px; box-sizing: border-box; word-break:break-all; word-wrap:break-word; }
.tb001 td .label_02{ font-size: 11px; line-height:23px; color:#333; display:block; padding:0px 2px 0px 8px; margin-top:-2px; box-sizing: border-box;  word-break:break-all; word-wrap:break-word;}
</style>

						
						 <!-- 아코디언 메뉴 시작 -->
                            <article class="mgT10">
                                <ul id="acdMenu01">
                                    <!-- 아코디언 메뉴 리스트 시작 -->
                                    <li class="acdMenuLst acdMenuLst01"><a class="acdMenuLik close">[Q 내역]</a>
                                        <div class="acdMenuCts acdMenuCts01 close">
                                            <!-- 아코디언 메뉴 컨텐츠 시작 -->
                                            	<article class="mgT5">
												<!-- 에이유아이 그리드가 이곳에 생성 -->
												<div id="grStudy_Q" class="gridHeiSz10 grid_wrap tb01_2" style></div>
											</article>
                                            <!-- 아코디언 메뉴 컨텐츠 끝 -->
                                        </div>
                                    </li>
                                    <!-- 아코디언 메뉴 리스트 끝 -->
                                </ul>
                            </article>
                            <!-- 아코디언 메뉴 끝 -->
						<!-- 테이블 끝 -->

						
					</form>
					
						
11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>
11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>
11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>
11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>
11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>11111<br>
					
				</div>
            </section>
		</div>
	</section>
	</div>
	</form>
	

	
	
	
<script type="text/javascript">
$(function(){
	// 퍼블 테스트 팝업
	$('#btnSaveDel2').click(function(){
		mkLayerPopupOpen("/sdb/c02/popup_SDBC0217.do", null);

	});
	
	// 팝업레이어 강제로 띄움
	$('#btnSaveDel2').trigger('click');

	
	
	// load_wrap 나오게
	$('.load_wrap').addClass('loading_yes');
	
	
	// load_wrap 안나오게
	//$('.load_wrap').addClass('loading_no');


});
</script>
	
	





<div class="load_wrap" style="display: block;">
	<div class="loading_box">
		<ul>
			<li><img src="/images/pantheon/common/cj_loading.gif" style="width:62px;"></li>
			<li>불러오는 중입니다...</li>
		</ul>
	</div>
	<div class="loading_box_dim"></div>
</div>















	
	
</body>
</html>