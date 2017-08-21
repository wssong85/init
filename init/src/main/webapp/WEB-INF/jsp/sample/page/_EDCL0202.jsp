<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<jsp:include page="/com/common.do" flush="false"/>



<script type="text/javascript">





</script>
</head>
<body>
<div id="wrap">
<c:import url="/com/topHeader.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>
<c:import url="/com/lnb.do?MODULE_CODE=IWRS&MENU_ID=IWRG0102&UPPER_MENU_ID=IWRG" charEncoding="utf-8"/>

	<section id="mainCon">
		<div class="mainConInner">
			<article class="mainTitBox">
				<h3>Data Export</h3>
                <nav id="pathNav">
                    <ul>
                        <li><img src="/images/pantheon/common/pathNavIco.png" alt="">Home</li>
                        <li>Data</li>
                        <li>Data Export</li>
                    </ul>
                </nav>
			</article>
			<section class="conBox100 conBox">
				<div class="conBoxInner" style="min-height:900px;">
					

<style>
.export_01{ }
.export_01 li{ display: inline-block; width: 20%;}
.export_01 li + span{ padding: 0 0 3px 5px;display: block;}
.export_01 li .export_box_01{border:1px solid #E6E6E6; width: 100%; box-sizing: border-box; height: 500px; padding:5px 10px; overflow-y:auto; }
.export_01 li .export_box_01 label{display: block;}
</style>


					<ul class="export_01">
						<li>
							<span style="font-family:'NanumGothicBold';">종류</span>
							<div class="export_box_01">
								<input type="radio" id="a11" name="a1"><label for="a11" class="raLab"><span>CRF</span></label>
								<input type="radio" id="a12" name="a1" checked="checked"><label for="a12" class="raLab"><span>SDTM data</span></label>
								<input type="radio" id="a13" name="a1"><label for="a13" class="raLab"><span>SDTM define</span></label>
								<input type="radio" id="a14" name="a1"><label for="a14" class="raLab"><span>ODM data</span></label>
								<input type="radio" id="a15" name="a1"><label for="a15" class="raLab"><span>ODM define</span></label>
								<input type="radio" id="a16" name="a1"><label for="a16" class="raLab"><span>Audit trail</span></label>
								<input type="radio" id="a17" name="a1"><label for="a17" class="raLab"><span>Query list</span></label>
							</div>
						</li>
						<li>
							<span style="font-family:'NanumGothicBold';">Domain</span>
							<div class="export_box_01">
								<input type="checkbox" id="b11" name="b1" checked="checked"><label for="b11" class="chcLab"><span>DM</span></label>
								<input type="checkbox" id="b12" name="b1"><label for="b12" class="chcLab"><span>...</span></label>
								<input type="checkbox" id="b13" name="b1"><label for="b13" class="chcLab"><span>...</span></label>
							</div>
						</li>
						<li>
							<span style="font-family:'NanumGothicBold';">File</span>
							<div class="export_box_01">
								<input type="radio" id="c11" name="c1"><label for="c11" class="raLab"><span>Excel</span></label>
								<input type="radio" id="c12" name="c1"><label for="c12" class="raLab"><span>Access</span></label>
								<input type="radio" id="c13" name="c1" checked="checked"><label for="c13" class="raLab"><span>Xml</span></label>
								<input type="radio" id="c14" name="c1"><label for="c14" class="raLab"><span>Sas</span></label>
							</div>
						</li>
						<li>
							<span style="font-family:'NanumGothicBold';">Transport</span>
							<div class="export_box_01">
								<input type="radio" id="d11" name="d1"><label for="d11" class="raLab"><span>가로</span></label>
								<input type="radio" id="d12" name="d1" checked="checked"><label for="d12" class="raLab"><span>세로</span></label>
							</div>
						</li>
					</ul>






				</div>
			</section>
		</div>
	</section>
</div>
</body>
</html>