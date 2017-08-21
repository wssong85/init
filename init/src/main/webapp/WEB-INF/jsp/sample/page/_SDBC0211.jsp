

<%@page pageEncoding="UTF-8"%>    



<script>





$(function() {
		
	$("#btnClose").click(function(){ 				
		layerClose();
	});
});


</script>

<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>보고서팝업</h5>
			<article class="mgT5">
				
			
			
				<table class="tb001">
					<colgroup>
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>Chose report type</th>
						</tr>
						<tr>
							<td>
				 				<div><input type="radio" id="a11" name="a1"><label for="a11" class="raLab"><span>CIOMS 영문</span></label></div>
				 				<div><input type="radio" id="a12" name="a1"><label for="a12" class="raLab"><span>CIOMS 국문</span></label></div>
				 				<div><input type="radio" id="a13" name="a1"><label for="a13" class="raLab"><span>ICH ICSR Message XML</span></label></div>
				 				<div><input type="radio" id="a14" name="a1"><label for="a14" class="raLab"><span>KIDS</span></label></div>
				 				<div><input type="radio" id="a15" name="a1"><label for="a15" class="raLab"><span>KIDS Appendix No.1</span></label></div>
				 				<div><input type="radio" id="a16" name="a1"><label for="a16" class="raLab"><span>CIOMS II</span></label></div>
							</td>
						</tr>
					</tbody>
				</table>
			</article>

			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="" value="저장" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


