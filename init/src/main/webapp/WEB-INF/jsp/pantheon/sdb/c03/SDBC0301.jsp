<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<!-- 상단 css, js 임포트 호출 -->
	<jsp:include page="/com/common.do" flush="false"/>
	<script type="text/javascript" src="<c:url value='/js/pantheon/common/jquery.form.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js' />"></script>
	<script type="text/javascript">
		$(function(){
			makeFileAttachment();
			pageSetting();
			buttonActive();
		});
		
		function pageSetting(){
			$('#ajaxForm').ajaxForm({
				beforeSubmit: function (data,form,option) {
					//submit전 행동
					return true;
				},
				success: function(response,status){
					var data = '';
					
					try {
						data = JSON.parse(response);	
					} catch(e) {
						data = response;
					}
					
					if(data.success) {
						
					} else {
						alert(data.message);
					}
				},
				error: function(){
					alert("file upload error!!");
				}
			});
		}
		
		function makeFileAttachment(){
			//파일업로드 제한 수
			var maxFileNum = 1;
			var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
			multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
		}
		
		function buttonActive(){
			$('#tabUpload').click(function(){
				window.location.href ="/sdb/c03/SDBC0301.do";
			});
			$('#tabHistory').click(function(){
				window.location.href ="/sdb/c03/SDBC0303.do";
			});
			
			$("#btnUpload").click(function(){
				$('#ajaxForm').submit();
			});
		}
	</script>
</head>
<body>
	<c:import url="/com/topHeader.do?MODULE_CODE=SDBMENU_ID=SDBC0301&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<c:import url="/com/lnb.do?MODULE_CODE=SDB&MENU_ID=SDBC0301&UPPER_MENU_ID=SDBC" charEncoding="utf-8"/>
	<div id="wrap">
		<section id="mainCon">
			<div class="mainConInner"> 
				<article class="mainTitBox">
					<h3>Upload</h3>
					<nav id="pathNav">
						<ul>
							<li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
							<li>유해정보등록</li>
							<li>대량Upload</li>
							<li>Upload</li>
						</ul>
					</nav>
				</article>
				<section class="conBox100 conBox">
					<div class="conBoxInner">
						<div class="button_tab_01">
							<ul>
								<li id="tabUpload" class="port_back tab_menu">Upload</li>
								<li id="tabHistory" class="tab_menu">History</li>
							</ul>
						</div>
	                 	<article class="conTitBox">
		                    <h5>UPLOAD</h5>
		                </article>
						<article class="conTitBtn">
							<table class="tb001">
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th>User ID</th>
										<td>
											<label id="lblUserId"></label>
										</td>
									</tr>
									<tr>

										<th>Time</th>
										<td>
											<label id="lblTime"></label>
										</td>
									</tr>
									<tr>
										<th>Status</th>
										<td>
											<label id="lblStatus"></label>
										</td>
									</tr>
									<tr>
										<th>Message</th>
										<td>
											<label id="lblMessage"></label>
										</td>
									</tr>
								</tbody>
							</table>
							<table class="tb001 mgT10">
								<colgroup>
									<col width="10%" />
									<col width="25%" />
									<col width="10%" />
									<col width="25%" />
									<col width="10%" />
									<col width="20%" />
								</colgroup>
								<tbody>
									<tr>
										<th>Product</th>
										<td>
											<input id="txtProduct" type="text" />
										</td>
										<th>Source Type</th>
										<td>
											<select id="sltSrouceType">
												<option value="">=== Selected ===</option>
											</select>
										</td>
										<th>Source</th>
										<td>
											<select id="sltSrouce">
												<option value="">=== Selected ===</option>
											</select>
										</td>
									</tr>
									<tr>
										<th>File</th>
										<td colspan="5" style="padding-top: 5px; padding-bottom: 5px;">
											<form id="ajaxForm" action="<c:url value='/sdb/c03/insertUpload.do'/>" method="post" enctype="multipart/form-data">
												<input type="file" name="file_1"  id="egovComFileUploader" style="width:50%;" title="첨부파일" />
												<p>
													<div id="egovComFileList"></div>
												</p>
											</form>
										</td>
									</tr>
									<tr>
										<td colspan="6">
											<div class="taC">
											<input type="button" id="btnUpload" value="Upload" />
											<input type="button" id="btnDownload" value="Template Download" />
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</article>
					</div>
				</section>
			</div>
		</section>
	</div>
</body>
</html>