

<%@page pageEncoding="UTF-8"%>    

<script>
$(function() {
	 mkSetDatePickerYYMMDD("#day_01");
	
	$("#btnClose").click(function(){ 				
		layerClose();
	});
	

});


</script>

<section class="popupWrap">
	<div class="popup wd500">
		<section class="conBox100 popup_conBox" style="margin:0px;">
		<div class="popup_conBoxInner">
			<h5>변경</h5>
			<article class="mgT5">
				
			
			
				<table class="tb001">
					<colgroup>
						<col width="30%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>적용방법</th>
							<td>
				 				<input type="radio" id="a11" name="a1" checked="checked"><label for="a11" class="raLab"><span>즉시</span></label>
				 				<input type="radio" id="a12" name="a1"><label for="a12" class="raLab"><span>적용일</span></label>
							</td>
						</tr>
						<tr>
							<th>적용일</th>
							<td>
								<div class="dateBox">
									<input type="text" id="day_01" style="width: 120px;" />
								</div>
							</td>
						</tr>
						<tr>
							<th>사유</th>
							<td style="padding-top:7px; padding-bottom: 0px;">
								<textarea id="" rows="3" style="width: 100%;" tabindex="20"></textarea>
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


