

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
			<h5>전자서명</h5>
			<article class="mgT5">
				
				<div class="agreebox_01">
					<div class="agreebox_01div" style="height:100px; padding:4px 8px;">
<pre>
<strong style="font-size:12px; font-family:'NanumGothicBold'; display:inline-block; ">아래의 내용을 확인해 주시고 화면 하단에 사용자 아이디와 비밀번호를 입력해 
주십시오.
본인은 본 내용이 빠짐없이 정확하게 기재되었음을 확인합니다.
본 전자 서명은 본인의 수기서명과 동등한 법적구속력을 가지고 있음을 
수락합니다.
</strong>

</pre>

					</div>
				</div>
				
				<div>
					
					<table class="tb001" style="border: none;">
						<colgroup>
							<col width="50%" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<td style="border: none; font-family:'NanumGothicBold'; padding-left:0px;">
									위 내용에 동의 하십니까?
								</td>
								<td style="border: none; text-align: right;">
									<input type="checkbox" name="" id="c01"><label for="c01" class="chcLab"><span>동의합니다.</span></label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			
			
				<table class="tb001">
					<colgroup>
						<col width="30%" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th>사용자 아이디</th>
							<td>
								<input type="text" style="width:100%;">
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
				 				<input type="password" style="width:100%;">
							</td>
						</tr>
					</tbody>
				</table>
			</article>
			

			
			
			<article class="mgT10">
				<div style="text-align:center">
					<input type="button" id="" value="서명완료" />
					<input type="button" id="btnClose" value="닫기" />
				</div>
			</article>
		</div>
		</section>
	</div>
</section>


